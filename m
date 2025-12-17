Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC8BD66BA2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVy98-0005wK-Qe; Wed, 17 Dec 2025 15:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy95-0005vr-Hq
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:29:15 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy93-0006Hp-UC
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:29:15 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso6729272b3a.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766003352; x=1766608152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PeuSfPSNWLtwpJyqq29Ik6xFhfYqiWSj7JRj6ySmND4=;
 b=WSXmXjw8oqnV7BAI8BX6SGZwDfXLuKDRP7XeYop6H/F6S11go/0JXta4KccM+WrCAh
 CclH6k67+PqT8OiLNXdGdHIBvY5CKdqb8Eo6PKvfpmSgfs9Ld9VG4n/NOh3NGzMH0LXq
 kkZQR3iDw4oasAl2AlB6q+cHgCCXVJ7pTqihWBy7hOrCMwRwFTTPn4gM1rbdRa/a/cQU
 r96yY/6S6J5eQnk57sL8z2q4uYUyLiWmZMGaZHxTQ2nF9rNTh9Qzp+vTzfWV6+eoEyJs
 yZUJ9Bs8F+B2y2WP+x9w2QLfKEjx9BJA5G8Txv0kxRy/gpNVJwxQ7iDUpY8F3koqLam3
 MGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766003352; x=1766608152;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PeuSfPSNWLtwpJyqq29Ik6xFhfYqiWSj7JRj6ySmND4=;
 b=XtVLGw614H7nvDvsPY3UDxCVxbadq+rBEHDXzAMYjYKOwBCINeIQDwpTM8HFKcCbvv
 q188MUxn+Fmpsrg3E2yvCjCG3QjxXKu9s4SThfo8WWBmA0gSCkcztw4ZagVhZ1hUu5wl
 crMPmjqGZUQLW5mcptvOTBNdiMj/H1+LL6CUaJGIp77G9YlGOQJvu3oHp0596FEroBY2
 WCI14MDdIRaxqe/iUV47RkdU1+CyjaHaa/u+DaLrjOnNFwcQy1vhegJzIuV1zabFKysI
 myjOO4OfCb97bo/83kiG3NEXI2bGrvLm53MZZPqPwNF1riCOVPblAbIPyP0TDIUXvkeo
 zmVQ==
X-Gm-Message-State: AOJu0YxTHShKWn2Ec/DxXsQjv7H/gGiiUrWuxGvUJTDbv1A7PSk94gHy
 mJb+Cw83NPUxmtJ/tiaeMWN20f4nkVmD4MxKIVCkBqYifMGnnQPn3Hgsge1WP2hRYcTtFi6aF+Z
 2bQnEJcg=
X-Gm-Gg: AY/fxX6cOOJYhGL6N8+PHzqj60U6vmE6tOsfCHarxtgTNEk2tPsOSDN+V627vXnhSUX
 Ugs4HWz88ZJiJqMajjtIMjXyX1qGOn7I9Rj/qBpmIa4L0HCq7JnvHMq9zZwCAsfpHfSbsGGWDXj
 OL4sLDVv/i5Cxq8rHrh5jBGOxtTR3FOv9ZZgznzc9rkIC6z1MPXW3W9zN6bQY2kJjqhwDqWM20y
 5eEmxxJ5QewgKZXjhMnWyj9i+exCubgHItjX8xTyMzNPyOL6VzIwsQqKhX+8IPkxPW3oSPUYt2a
 XBfsmQTGCs3upwWILEFp+82lVVSevQBpmRFZy0irBfibyHGCiDQoIhm2sdljEYuPiw+5Uf2y+xl
 cKUDN26RikZkKBINTJdfrrDdLdvfc4mD9oceet2rtjRsaUdBfXSqg0i8R4V4hp3g2UT4S/7Aqwe
 fIWOE6WpHXincgro/YcZPh0lKU821I0g==
X-Google-Smtp-Source: AGHT+IGI1rMhZ35ybc7yPZYHx6rzQvuZWSNXrMBNhPZ7lfrJzR/4aR6s4R9MIZUIAK9uj9atKNAjGA==
X-Received: by 2002:a05:6a00:3403:b0:7e8:4398:b35a with SMTP id
 d2e1a72fcca58-7f6691b1669mr17589867b3a.45.1766003352184; 
 Wed, 17 Dec 2025 12:29:12 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe14179645sm307835b3a.47.2025.12.17.12.29.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 12:29:11 -0800 (PST)
Message-ID: <90a7de63-c7cb-4378-9afd-fd6740ed27fe@linaro.org>
Date: Thu, 18 Dec 2025 07:29:08 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] system/memory: Factor
 address_space_ldst[M]_internal() helper out
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> All the LD/ST[W,L,Q] variants use the same template, only
> modifying the access size used. Unify as a single pair of
> LD/ST methods taking a MemOp argument. Thus use the 'm'
> suffix for MemOp.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory_ldst.c.inc | 289 ++++++++-------------------------------
>   1 file changed, 58 insertions(+), 231 deletions(-)
> 
> diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
> index 823fc3a7561..e0c0c3f5dca 100644
> --- a/system/memory_ldst.c.inc
> +++ b/system/memory_ldst.c.inc
> @@ -20,39 +20,43 @@
>    */
>   
>   /* warning: addr must be aligned */
> -static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
> -    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
> -    enum device_endian endian)
> +static inline
> +uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
> +                                                  hwaddr addr,
> +                                                  MemTxAttrs attrs,
> +                                                  MemTxResult *result,
> +                                                  enum device_endian endian)
>   {
> +    const unsigned size = memop_size(mop);
>       uint8_t *ptr;
>       uint64_t val;
>       MemoryRegion *mr;
> -    hwaddr l = 4;
> +    hwaddr l = size;
>       hwaddr addr1;
>       MemTxResult r;
>       bool release_lock = false;
>   
>       RCU_READ_LOCK();
>       mr = TRANSLATE(addr, &addr1, &l, false, attrs);
> -    if (l < 4 || !memory_access_is_direct(mr, false, attrs)) {
> +    if (l < size || !memory_access_is_direct(mr, false, attrs)) {
>           release_lock |= prepare_mmio_access(mr);
>   
>           /* I/O case */
>           r = memory_region_dispatch_read(mr, addr1, &val,
> -                                        MO_32 | devend_memop(endian), attrs);
> +                                        mop | devend_memop(endian), attrs);
>       } else {
>           /* RAM case */
> -        fuzz_dma_read_cb(addr, 4, mr);
> +        fuzz_dma_read_cb(addr, size, mr);
>           ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>           switch (endian) {
>           case DEVICE_LITTLE_ENDIAN:
> -            val = ldl_le_p(ptr);
> +            val = ldn_le_p(ptr, size);
>               break;
>           case DEVICE_BIG_ENDIAN:
> -            val = ldl_be_p(ptr);
> +            val = ldn_be_p(ptr, size);
>               break;
>           default:
> -            val = ldl_p(ptr);
> +            val = ldn_p(ptr, size);
>               break;
>           }
>           r = MEMTX_OK;
> @@ -67,87 +71,30 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
>       return val;
>   }
>   
> +/* warning: addr must be aligned */
> +static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
> +    enum device_endian endian)
> +{
> +    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_32, addr,
> +                                                    attrs, result, endian);
> +}
> +
>   /* warning: addr must be aligned */

Do we know why this warning is here?
Do we know why we aren't asserting alignment?

It makes me wonder if the ldn_*_p above shouldn't be qatomic_ld.
And more so for the stores.

But that's an existing problem, not new with the refactor, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

