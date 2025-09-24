Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F9ACAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JYo-0006wX-St; Wed, 24 Sep 2025 03:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1JYe-0006rl-Ex
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1JYS-0001W0-Fn
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758697479;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TZxXpjFnBVv/qZ4ZWaL0qfJpE1CiWY1F3JsrSj4vR14=;
 b=FvFRM18QvcH5JGYKPdW6c2jl3/xlC9uOribSuPazXyljpHt4/R4Oodrjck/30W5F67zrUX
 Ym58KQknQirKmeDcSKi1DIfTOh5E/BshiIqi63OEI4uqADqb7W92+wA5qaFpLPbbI9iH32
 o5ys29trEBaBNrulTnmhe7mqf/+Iogo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-yUis-jDGO3W2z63I4FoVPA-1; Wed,
 24 Sep 2025 03:04:37 -0400
X-MC-Unique: yUis-jDGO3W2z63I4FoVPA-1
X-Mimecast-MFC-AGG-ID: yUis-jDGO3W2z63I4FoVPA_1758697476
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8908619560B0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 07:04:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7716F300018D; Wed, 24 Sep 2025 07:04:34 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:04:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Michael Tsirkin <mst@redhat.com>
Subject: Re: [PATCH] net/net.c: add tap device fd validity check to prevent
 abort on deleted device
Message-ID: <aNOX_q7xoJeUY14e@redhat.com>
References: <20250924062831.1788305-1-hzuo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924062831.1788305-1-hzuo@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 24, 2025 at 02:28:31PM +0800, Houqi (Nick) Zuo wrote:
> This patch addresses a scenario where QEMU would abort with a core dump
> when a tap device created by QEMU is manually deleted from the host while
> the guest is running.
> 
> The specific negative test case is:
> 1. Start QEMU with a tap device (created by QEMU)
> 2. Manually delete the tap device on the host
> 3. Execute shutdown in the guest
> 4. QEMU attempts to clean up the tap device but finds the file descriptor
>    in a bad state, leading to abort and core dump
> 
> The patch introduces a tap device file descriptor validity check using
> the TUNGETIFF ioctl to detect when the underlying tap device has been
> removed. When detected, the operations are skipped gracefully instead
> of proceeding with invalid file descriptors that cause ioctl failures.
> 
> The validity check is integrated into:
> - qemu_set_vnet_hdr_len() in net/net.c
> - qemu_set_offload() in net/net.c
> 
> This ensures that when the tap device is no longer valid, these functions
> return early without attempting operations that would fail and trigger
> aborts, thus achieving the expected behavior of error reporting without

> diff --git a/net/net.c b/net/net.c
> index da275db86e..c0750fd0b9 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -57,6 +57,7 @@
>  #include "qapi/string-output-visitor.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "standard-headers/linux/virtio_net.h"
> +#include "qemu/log.h"
>  
>  /* Net bridge is currently not supported for W32. */
>  #if !defined(_WIN32)
> @@ -543,7 +544,8 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len)
>  void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
>                            int ecn, int ufo, int uso4, int uso6)
>  {
> -    if (!nc || !nc->info->set_offload) {
> +    if (!nc || !nc->info->set_offload ||
> +        (nc->info->query_validity && nc->info->query_validity(nc) != 1)) {
>          return;
>      }
>  
> @@ -561,7 +563,8 @@ int qemu_get_vnet_hdr_len(NetClientState *nc)
>  
>  void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
>  {
> -    if (!nc || !nc->info->set_vnet_hdr_len) {
> +    if (!nc || !nc->info->set_vnet_hdr_len ||
> +        (nc->info->query_validity && nc->info->query_validity(nc) != 1)) {
>          return;
>      }
>

These checks leave open a race condition where the tap can be
deleted in between checking the tap and trying the operation.
Drop the check and just make the later operation not abort
on failure.

There are other methods in this file which will abort on
failure too tap that need addressing, because if setting
len failure is ignored it'll go on to call qemu_set_vnet_be
/ qemu_set_vnet_le eventually which will abort for the same
reason.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


