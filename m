Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EFFCF11CD
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 11:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrIv-0006yL-68; Thu, 10 Oct 2024 07:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrIs-0006xm-M7
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrIq-0005ps-Td
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728559555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiECtwZBd/jyA5EjodU8eL1lUP1IsVAFpIZODJXKHDY=;
 b=M+3mshtvtblbHCskVk8EXZ2DEQSWfdiand8PKQOVyeERIJ+VAh4PNoX9p8ZtiGFtN5sEPu
 WLuEhN1zILxcXNy1DBumZcEbPpeVXwmiHe0ZLps42MmiD/ur2CgbDNJWPpBSTGT5cE72oj
 QMA96foUzGH15d0rglrAqzKYdJbTFF0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-vGg9mSB1NSy4dYNAOJV3qA-1; Thu,
 10 Oct 2024 07:25:51 -0400
X-MC-Unique: vGg9mSB1NSy4dYNAOJV3qA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 795861956080; Thu, 10 Oct 2024 11:25:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 541FF300018D; Thu, 10 Oct 2024 11:25:45 +0000 (UTC)
Date: Thu, 10 Oct 2024 12:25:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com,
 peter.maydell@linaro.org, Alejandro Zeise <alejandro.zeise@seagate.com>
Subject: Re: [PATCH v5 16/16] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Message-ID: <Zwe5tMzf1oiA1TyN@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
 <20241008075724.2772149-17-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008075724.2772149-17-clg@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 08, 2024 at 09:57:23AM +0200, Cédric Le Goater wrote:
> From: Alejandro Zeise <alejandro.zeise@seagate.com>
> 
> Make the Aspeed HACE module use the new qcrypto accumulative hashing functions
> when in scatter-gather accumulative mode. A hash context will maintain a
> "running-hash" as each scatter-gather chunk is received.
> 
> Previously each scatter-gather "chunk" was cached
> so the hash could be computed once the final chunk was received.
> However, the cache was a shallow copy, so once the guest overwrote the
> memory provided to HACE the final hash would not be correct.
> 
> Possibly related to: https://gitlab.com/qemu-project/qemu/-/issues/1121
> Buglink: https://github.com/openbmc/qemu/issues/36
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> [ clg: - Checkpatch fixes ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  include/hw/misc/aspeed_hace.h |  4 ++
>  hw/misc/aspeed_hace.c         | 96 +++++++++++++++++++----------------
>  2 files changed, 56 insertions(+), 44 deletions(-)
> 

>  static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>                                bool acc_mode)
>  {
>      struct iovec iov[ASPEED_HACE_MAX_SG];
> +    uint32_t total_msg_len;
> +    uint32_t pad_offset;
>      g_autofree uint8_t *digest_buf = NULL;
>      size_t digest_len = 0;
> -    int niov = 0;
> +    bool sg_acc_mode_final_request = false;
>      int i;
>      void *haddr;
>  
> +    if (acc_mode && s->hash_ctx == NULL) {

  Error local_err = NULL;

> +        s->hash_ctx = qcrypto_hash_new(algo, NULL);

  &local_err;

> +        if (s->hash_ctx == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: qcrypto failed to create hash context\n",
> +                          __func__);

Add error_get_pretty() output to the message so we get useful
information reported, and then error_free,.

> +            return;
> +        }
> +    }
> +
>      if (sg_mode) {
>          uint32_t len = 0;
>  


> -    if (niov) {
> -        i = niov;
> -    }
> +    if (acc_mode) {
> +        if (qcrypto_hash_updatev(s->hash_ctx, iov, i, NULL) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: qcrypto hash update failed\n", __func__);
> +            return;
> +        }
> +
> +        if (sg_acc_mode_final_request) {
> +            if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
> +                                            &digest_len, NULL)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: qcrypto failed to finalize hash\n",
> +                              __func__);
> +            }
>  
> -    if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
> +            qcrypto_hash_free(s->hash_ctx);
> +
> +            s->hash_ctx = NULL;
> +            s->iov_count = 0;
> +            s->total_req_len = 0;
> +        }
> +    } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf,
> +                                   &digest_len, NULL) < 0) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
>          return;
>      }

Same comment about passing an Error object to all these methods
and logging the useful error message.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


