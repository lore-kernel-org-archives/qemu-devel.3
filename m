Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B5606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fPPYHOkW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2at-0001zZ-NG; Wed, 28 Oct 2026 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM2ak-0001yu-OM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM2ag-0008RW-UJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793189832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0hW7uEgj7X7KUhTeRW5bHnVrHnSh4OfvYzEKf+7M+Fo=;
 b=fPPYHOkWNO/sfVcejOJyI2mdFYwMUEmTIkEeohU0ai+EV+zIvCa2zoTfqWB0sUYaRdfsZA
 IYn5I7IuFwdbhfXpUOVFfmlvGSMrbiqJPbShBUslEToh/s6Dhv/Z+aNxnHxEhP7dqIF/ei
 lmDWlwf2LaPQJlFziTTxCBLz6yOYPIg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-XEPG8tfkP6GGpyxQ1obV1A-1; Wed,
 28 Oct 2026 08:17:09 -0400
X-MC-Unique: XEPG8tfkP6GGpyxQ1obV1A-1
X-Mimecast-MFC-AGG-ID: XEPG8tfkP6GGpyxQ1obV1A_1793189828
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E58C195D009; Wed, 28 Oct 2026 12:17:08 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DCE218002B1; Wed, 28 Oct 2026 12:17:05 +0000 (UTC)
Date: Wed, 28 Oct 2026 07:17:02 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, kwolf@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v2] qemu-pr-helper: do not free reply when
 multipath_process_cmd() fails
Message-ID: <auHnoPfxwL4HwZPV@redhat.com>
References: <20261027200757.961830-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027200757.961830-1-stefanha@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 04:07:57PM -0400, Stefan Hajnoczi wrote:
> Kevin Wolf pointed out that the multipath_process_cmd() documentation
> only defines the value of reply on success. Don't touch it when the
> function returns -1.
> 
> The libmpathcmd implementation as of c78cf64a9e8e does not set *reply to
> NULL when its internal mpath_send_cmd() call fails, so I think Kevin's
> interpretation is correct.
> 
> As it stands, there is no observable bug in the QEMU code though because
> reply is initialized to NULL before calling multipath_process_cmd().
> This patch is just a cleanup.
> 
> Cc: Benjamin Marzinski <bmarzins@redhat.com>
> Cc: kwolf@redhat.com
> Cc: eblake@redhat.com
> Cc: berrange@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
> - Use g_autofree instead of manual free(3) calls [Eric]

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


