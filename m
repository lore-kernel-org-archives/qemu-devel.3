Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A62C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 13:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siwdl-0003m5-Ti; Tue, 27 Aug 2024 09:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GG8b=P2=kaod.org=clg@ozlabs.org>)
 id 1siwdj-0003ho-Re; Tue, 27 Aug 2024 09:53:43 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GG8b=P2=kaod.org=clg@ozlabs.org>)
 id 1siwdh-0000YC-9D; Tue, 27 Aug 2024 09:53:43 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WtTXY3PJpz4x8S;
 Tue, 27 Aug 2024 23:53:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtTXV3hB8z4x2g;
 Tue, 27 Aug 2024 23:53:30 +1000 (AEST)
Message-ID: <a825a8f1-e077-43c9-8614-3e027ca00a8b@kaod.org>
Date: Tue, 27 Aug 2024 15:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: Alejandro Zeise <alejandro.zeise@seagate.com>, qemu-arm@nongnu.org
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-16-alejandro.zeise@seagate.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240807195122.2827364-16-alejandro.zeise@seagate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GG8b=P2=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/7/24 21:51, Alejandro Zeise wrote:
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
> ---
>   hw/misc/aspeed_hace.c         | 94 +++++++++++++++++++----------------
>   include/hw/misc/aspeed_hace.h |  4 ++
>   2 files changed, 54 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index c06c04ddc6..4247403d45 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -1,6 +1,7 @@
>   /*
>    * ASPEED Hash and Crypto Engine
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (C) 2021 IBM Corp.
>    *
>    * Joel Stanley <joel@jms.id.au>
> @@ -151,50 +152,28 @@ static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
>       return iov_count;
>   }
>   
> -/**
> - * Generate iov for accumulative mode.
> - *
> - * @param s             aspeed hace state object
> - * @param iov           iov of the current request
> - * @param id            index of the current iov
> - * @param req_len       length of the current request
> - *
> - * @return count of iov
> - */
> -static int gen_acc_mode_iov(AspeedHACEState *s, struct iovec *iov, int id,
> -                            hwaddr *req_len)
> -{
> -    uint32_t pad_offset;
> -    uint32_t total_msg_len;
> -    s->total_req_len += *req_len;
> -
> -    if (has_padding(s, &iov[id], *req_len, &total_msg_len, &pad_offset)) {
> -        if (s->iov_count) {
> -            return reconstruct_iov(s, iov, id, &pad_offset);
> -        }
> -
> -        *req_len -= s->total_req_len - total_msg_len;
> -        s->total_req_len = 0;
> -        iov[id].iov_len = *req_len;
> -    } else {
> -        s->iov_cache[s->iov_count].iov_base = iov->iov_base;
> -        s->iov_cache[s->iov_count].iov_len = *req_len;
> -        ++s->iov_count;
> -    }
> -
> -    return id + 1;
> -}
> -
>   static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>                                 bool acc_mode)
>   {
>       struct iovec iov[ASPEED_HACE_MAX_SG];
> +    uint32_t total_msg_len;
> +    uint32_t pad_offset;
>       g_autofree uint8_t *digest_buf = NULL;
>       size_t digest_len = 0;
> -    int niov = 0;
> +    bool sg_acc_mode_final_request = false;
>       int i;
>       void *haddr;
>   
> +    if (acc_mode && s->hash_ctx == NULL) {
> +        s->hash_ctx = qcrypto_hash_new(algo, NULL);

I wonder if we shouldn't use an 'Error *' argument instead and output
the literal error with error_get_pretty() in qemu_log_mask() ?

> +        if (s->hash_ctx == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: qcrypto failed to create hash context\n",
> +                          __func__);
> +            return;
> +        }
> +    }
> +
>       if (sg_mode) {
>           uint32_t len = 0;
>   
> @@ -226,8 +205,15 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>               }
>               iov[i].iov_base = haddr;
>               if (acc_mode) {
> -                niov = gen_acc_mode_iov(s, iov, i, &plen);
> -
> +                s->total_req_len += plen;
> +
> +                if (has_padding(s, &iov[i], plen, &total_msg_len, &pad_offset)) {
> +                    /* Padding being present indicates the final request */
> +                    sg_acc_mode_final_request = true;
> +                    iov[i].iov_len = pad_offset;
> +                } else {
> +                    iov[i].iov_len = plen;
> +                }
>               } else {
>                   iov[i].iov_len = plen;
>               }
> @@ -252,20 +238,35 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>                * required to check whether cache is empty. If no, we should
>                * combine cached iov and the current iov.
>                */
> -            uint32_t total_msg_len;
> -            uint32_t pad_offset;
>               s->total_req_len += len;
>               if (has_padding(s, iov, len, &total_msg_len, &pad_offset)) {
> -                niov = reconstruct_iov(s, iov, 0, &pad_offset);
> +                i = reconstruct_iov(s, iov, 0, &pad_offset);
>               }
>           }
>       }
>   
> -    if (niov) {
> -        i = niov;
> -    }
> +    if (acc_mode) {
> +        if (qcrypto_hash_updatev(s->hash_ctx, iov, i, NULL) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: qcrypto hash update failed\n", __func__);
> +            return;

This will drop the ending sequence: address_space_unmap() and
setting of the IRQ status register. I guess adding an 'exit'
goto label is preferable.

> +        }
> +
> +        if (sg_acc_mode_final_request) {
> +            if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
> +                                            &digest_len, NULL)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: qcrypto failed to finalize hash\n", __func__);
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
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);

Same issue here with the ending sequence. This should be fixed in
a separate patch.


Thanks,

C.



>           return;
>       }
> @@ -397,6 +398,11 @@ static void aspeed_hace_reset(DeviceState *dev)
>   {
>       struct AspeedHACEState *s = ASPEED_HACE(dev);
>   
> +    if (s->hash_ctx != NULL) {
> +        qcrypto_hash_free(s->hash_ctx);
> +        s->hash_ctx = NULL;
> +    }
> +
>       memset(s->regs, 0, sizeof(s->regs));
>       s->iov_count = 0;
>       s->total_req_len = 0;
> diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
> index ecb1b67de8..4af9919195 100644
> --- a/include/hw/misc/aspeed_hace.h
> +++ b/include/hw/misc/aspeed_hace.h
> @@ -1,6 +1,7 @@
>   /*
>    * ASPEED Hash and Crypto Engine
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (C) 2021 IBM Corp.
>    *
>    * SPDX-License-Identifier: GPL-2.0-or-later
> @@ -10,6 +11,7 @@
>   #define ASPEED_HACE_H
>   
>   #include "hw/sysbus.h"
> +#include "crypto/hash.h"
>   
>   #define TYPE_ASPEED_HACE "aspeed.hace"
>   #define TYPE_ASPEED_AST2400_HACE TYPE_ASPEED_HACE "-ast2400"
> @@ -35,6 +37,8 @@ struct AspeedHACEState {
>   
>       MemoryRegion *dram_mr;
>       AddressSpace dram_as;
> +
> +    QCryptoHash *hash_ctx;
>   };
>   
>   


