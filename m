Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14F5CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbk-0000qo-Mq; Wed, 07 Oct 2026 05:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xELWe-0004Ni-Eo
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xELWa-0005V4-Ts
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791355989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0PeN3w0wV3/IopStkytZts+fLSDazbtigrO7wVAjtE=;
 b=QD+wLk3IH50vt/AgDsiWhu0SzObkvKRX77kRMU76t3kP1BOtu59q6k6bdfT8mTR++roXAL
 A0TNXRlZ3cwHvjvKllWusxY7gclhSWGjMIOxS4UO/TFESRN2xQDMnXAs/IPPf7ZYPDDWtp
 2gXqTkTtTOb9vXku8DA2Jim/ONR4qP0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-2Dsy7dpdPFSR2LiSNtyM1Q-1; Tue,
 06 Oct 2026 10:07:11 -0400
X-MC-Unique: 2Dsy7dpdPFSR2LiSNtyM1Q-1
X-Mimecast-MFC-AGG-ID: 2Dsy7dpdPFSR2LiSNtyM1Q_1791295630
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7CC0196DFC7; Tue,  6 Oct 2026 14:07:09 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E131800591; Tue,  6 Oct 2026 14:07:05 +0000 (UTC)
Date: Tue, 6 Oct 2026 09:07:00 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH qemu 1/4] iotests: add test cases for failing flush after
 qemu-img convert
Message-ID: <asT70WoLHYqAd__l@redhat.com>
References: <20260930132140.2342574-1-f.ebner@proxmox.com>
 <20260930132140.2342574-2-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930132140.2342574-2-f.ebner@proxmox.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 30, 2026 at 03:19:22PM +0200, Fiona Ebner wrote:
> In preparation to add more checks in the following commits and show
> how the behavior changes.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  tests/qemu-iotests/122     | 33 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/122.out | 14 ++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> index be0f6b79e5..488649f1bd 100755
> --- a/tests/qemu-iotests/122
> +++ b/tests/qemu-iotests/122

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


