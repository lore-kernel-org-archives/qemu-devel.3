Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115C3C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 17:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3IUd-00034o-94; Fri, 11 Apr 2025 13:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3IUQ-0002rI-C8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 13:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3IUL-00019h-4X
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 13:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744393703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbtyZrbtLrj3GjW4EhRAhnj3W2Ayqe/ytmpu8ahu7tU=;
 b=RlzXPK1tDhHP1yq6AgBJhLAsCUzTCnciYhPTUNwS7r5j8r/f4wzBwAGPrSOTAdE3CVsPsn
 yl+QYTLbmGTeCnElm1nGC7UMAUSfwFkNhyWrLLSut81c+NtDkH5OLJQTxYip/sc7m0OOGb
 /mfljSlDw3cjreuaygHVZjdaSUtvPco=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-RYRahBzFOHeFYJ5M0YBx_w-1; Fri,
 11 Apr 2025 13:48:21 -0400
X-MC-Unique: RYRahBzFOHeFYJ5M0YBx_w-1
X-Mimecast-MFC-AGG-ID: RYRahBzFOHeFYJ5M0YBx_w_1744393700
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 084CF180AB16; Fri, 11 Apr 2025 17:48:18 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20DC71955BC1; Fri, 11 Apr 2025 17:48:13 +0000 (UTC)
Date: Fri, 11 Apr 2025 12:48:11 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, stefanha@redhat.com, berto@igalia.com, den@virtuozzo.com
Subject: Re: [PATCH v3 05/12] iotests/common.rc: add disk_usage function
Message-ID: <v4yhrtllsena44jkk2qffsqf6gd4zlyxrhfjzsgva6jwazvkgv@t3xb7futfgpo>
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
 <20240913163942.423050-6-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913163942.423050-6-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 13, 2024 at 07:39:35PM +0300, Andrey Drobyshev wrote:
> Move the definition from iotests/250 to common.rc.  This is used to
> detect real disk usage of sparse files.  In particular, we want to use
> it for checking subclusters-based discards.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/250       | 5 -----
>  tests/qemu-iotests/common.rc | 6 ++++++
>  2 files changed, 6 insertions(+), 5 deletions(-)

Hmm - I should probably refactor my recent blockdev-mirror sparse test
to take advantage of this as well.
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg01799.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


