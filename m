Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9765C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 10:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYkVj-0008Ng-EM; Tue, 30 Jul 2024 06:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7GHu=O6=kaod.org=clg@ozlabs.org>)
 id 1sYkVh-0008Md-Du; Tue, 30 Jul 2024 06:55:17 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7GHu=O6=kaod.org=clg@ozlabs.org>)
 id 1sYkVe-0005NY-6K; Tue, 30 Jul 2024 06:55:17 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WYBvW75nqz4x3d;
 Tue, 30 Jul 2024 20:55:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WYBvT6bTZz4wcK;
 Tue, 30 Jul 2024 20:55:01 +1000 (AEST)
Message-ID: <71d5b310-c2ba-49a3-8d95-5949f912dd76@kaod.org>
Date: Tue, 30 Jul 2024 12:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: Alejandro Zeise <alejandro.zeise@seagate.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
 <20240729190035.3419649-3-alejandro.zeise@seagate.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240729190035.3419649-3-alejandro.zeise@seagate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7GHu=O6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Alejandro,

On 7/29/24 21:00, Alejandro Zeise wrote:
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


Thanks for these changes.

However, this introduces a regression when compiling QEMU with
--disable-gcrypt. It can be reproduced with :

   make check-avocado AVOCADO_TAGS=machine:ast1030-evb

or download :

   https://github.com/AspeedTech-BMC/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip

unzip and run :

   path/to/qemu-system-arm -M ast1030-evb -kernel ./zephyr.bin -nographic

then, on the console :

   uart:~$ hash test
   sha256_test
   tv[0]:PASS
   tv[1]:PASS
   tv[2]:PASS
   tv[3]:PASS
   tv[4]:PASS
   sha384_test
   tv[0]:hash_final error
   sha512_test
   tv[0]:Segmentation fault (core dumped)

I believe this is due to the change which now assigns s->total_req_len
when accumulation mode is desired. If the crypto context fails to
allocate (no gcrypt), states are not cleared in the model and previous
values are used by the model when the OS runs the next test and QEMU
segvs in has_padding().

To fix, I think we could move :

         if (s->qcrypto_hash_context == NULL &&
             qcrypto_hash_accumulate_new_ctx(algo, &s->qcrypto_hash_context, NULL)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: qcrypto failed to create hash context\n",
                           __func__);
             return;
         }

at the beginning of do_hash_operation() ?

C.


> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>   hw/misc/aspeed_hace.c         | 91 ++++++++++++++++++-----------------
>   include/hw/misc/aspeed_hace.h |  4 ++
>   2 files changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index c06c04ddc6..8306d8986a 100644
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
> @@ -151,47 +152,15 @@ static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
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
> @@ -226,8 +195,15 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
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
> @@ -252,20 +228,42 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
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
> +        if (s->qcrypto_hash_context == NULL &&
> +            qcrypto_hash_accumulate_new_ctx(algo, &s->qcrypto_hash_context, NULL)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: qcrypto failed to create hash context\n",
> +                          __func__);
> +            return;
> +        }
> +
> +        if (qcrypto_hash_accumulate_bytesv(algo,
> +                                           s->qcrypto_hash_context, iov, i,
> +                                           &digest_buf,
> +                                           &digest_len, NULL) < 0) {
> +
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
> +            return;
> +        }
>   
> -    if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
> +        if (sg_acc_mode_final_request) {
> +            if (qcrypto_hash_accumulate_free_ctx(s->qcrypto_hash_context, NULL) < 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: qcrypto failed to free context\n", __func__);
> +            }
> +
> +            s->qcrypto_hash_context = NULL;
> +            s->iov_count = 0;
> +            s->total_req_len = 0;
> +        }
> +    } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
>           return;
>       }
> @@ -397,6 +395,11 @@ static void aspeed_hace_reset(DeviceState *dev)
>   {
>       struct AspeedHACEState *s = ASPEED_HACE(dev);
>   
> +    if (s->qcrypto_hash_context != NULL) {
> +        qcrypto_hash_accumulate_free_ctx(s->qcrypto_hash_context, NULL);
> +        s->qcrypto_hash_context = NULL;
> +    }
> +
>       memset(s->regs, 0, sizeof(s->regs));
>       s->iov_count = 0;
>       s->total_req_len = 0;
> diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
> index ecb1b67de8..b3c2eb17b7 100644
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
> +    qcrypto_hash_accumulate_ctx_t *qcrypto_hash_context;
>   };
>   
>   


