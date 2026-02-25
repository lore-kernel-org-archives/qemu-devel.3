Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D815FFD375D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 13:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEuj-0001u4-HH; Wed, 25 Feb 2026 08:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvEui-0001tp-5I
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvEug-00013O-OH
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772026009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v31ygCb6/5ZGgQ2PBur8PqIyK0Mz3HOuhIrw0iXaCxI=;
 b=RBz7IblsVz2DWj5Hq+1axCjhqgk5q6frTIMl86MnAYxEQGjR3DgYxgSq1pxURO3YgKRjdU
 NtXKQ7ovy9CqxLSLPVrgYpLCwnscXgaUnA1xEmVR+cK4U9NFRZT5y56ihxNIs99tqoDDDZ
 2vxa6+sH/AHNb7fRCEVutpR/5AoTsP4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-WMYM642aNE-isa1QOrc3rg-1; Wed,
 25 Feb 2026 08:26:45 -0500
X-MC-Unique: WMYM642aNE-isa1QOrc3rg-1
X-Mimecast-MFC-AGG-ID: WMYM642aNE-isa1QOrc3rg_1772026004
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D44A51956096; Wed, 25 Feb 2026 13:26:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 724E23003D88; Wed, 25 Feb 2026 13:26:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CF6021E692D; Wed, 25 Feb 2026 14:26:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hamilton <dahamilt0@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] hw/misc/ivshmem-pci: Check error after
 setup_interrupt() in process_msg_connect()
In-Reply-To: <20260225121323.5395-3-dahamilt0@gmail.com> (David Hamilton's
 message of "Wed, 25 Feb 2026 07:13:23 -0500")
References: <20260225121323.5395-1-dahamilt0@gmail.com>
 <20260225121323.5395-3-dahamilt0@gmail.com>
Date: Wed, 25 Feb 2026 14:26:42 +0100
Message-ID: <87a4wxkl7x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

David Hamilton <dahamilt0@gmail.com> writes:

> setup_interrupt() can fail and report via errp, but
> process_msg_connect() was ignoring the error and continuing
> to ivshmem_add_eventfd(). Check the bool return to avoid
> operating on a vector whose interrupt setup failed.
>
> Resolves the TODO comment at the call site.
>
> Signed-off-by: David Hamilton <dahamilt0@gmail.com>
> ---
>  hw/misc/ivshmem-pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
> index c987eebb98..f1262fa5f7 100644
> --- a/hw/misc/ivshmem-pci.c
> +++ b/hw/misc/ivshmem-pci.c
> @@ -553,8 +553,9 @@ static void process_msg_connect(IVShmemState *s, uint16_t posn, int fd,
>      }
>  
>      if (posn == s->vm_id) {
> -        setup_interrupt(s, vector, errp);
> -        /* TODO do we need to handle the error? */
> +        if (!setup_interrupt(s, vector, errp)) {

Any cleanup needed here?  Error returns above close(fd).

> +            return;
> +        }
>      }
>  
>      if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD)) {


