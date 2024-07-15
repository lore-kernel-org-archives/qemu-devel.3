Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610ACC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 15:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTNfe-0005pS-TY; Mon, 15 Jul 2024 11:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTNfc-0005ot-Bc
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:31:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTNfa-00035b-Jt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:31:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36799fb93baso2615086f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721057477; x=1721662277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7WOGTLi87FkK+bqJJWJ4YCmRpYnkN97NuzOowc825cA=;
 b=dTboRHeDkZK8ciUuaG+EKpiRbxZNHqlX2lptWOEqkdttIAKz/XtDepovx2pKyCimtp
 uFV6tyE7JEWYpAJgtM+drAP2JTuOzbv9zrQ2fakitKjstKmA/5ka6nj7q1g6IZ6fF0ep
 oypr5OIzlAgWdhDVdeYgNZAmpBAx7ZbYwpdDGLTz7y5lpseFv/N6xu7Bp0+ChPRufIZu
 pzMkqlRCT6SYo3g9D68Kc/s19dgb9a1MUtoCUs2rtG42z3fGSaMSnIehlUxbPmHJQ8sZ
 6hCRoUuqJZHaawCr8RweMrWxc/1FzAxr15eOZa1u2nt+pRWXmKQBlqIfbvA80XAuQ9Q9
 wKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721057477; x=1721662277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7WOGTLi87FkK+bqJJWJ4YCmRpYnkN97NuzOowc825cA=;
 b=MlsAdIA7AYK2wlSQ9sEiDbtJU7ORM9T21Nc7gDpHzNGFzTXVnaonmk7Tw/MqDxqbu4
 q5Sza6D9jOY0ZVzgZqEnNTnZGOOpwrMpoXN2OScTmmsYFenl15ZywDwxdv56nFK1pboV
 gb/T6tIpumgiA0gohqC5np6HoFZ8MXx1N7NNIw+vgUaJhxCcawiFf4TVzCL0gp3qUKkc
 aDfPyS3yvKw0Km25OkBWrOap7bgWgJT4seW/2ReXT7fX86z9ytUXacXkrAfyTljTpU8z
 tax48XtzWIvz54xqn2eY2bb4SQGeYqoi2ps+JltmtfNchRnmlRKRvRLmMMdU3/KH8ia0
 PMdA==
X-Gm-Message-State: AOJu0YwxPZ2KmK9UB/J4/b2JAbWdZR0gHAVUXi6vNVpUdlZmSi9mViDd
 G2WjkVak4AAxssqZHakbNuIBJPsS9eMglk6Q/jYD7MxIvvgIf+m1bkBnB7341vY=
X-Google-Smtp-Source: AGHT+IG/DYP72QDSoF+oVJTyBeELVgU7tZbL7nbYPiqY/Jj7L7W+eOl7hYdaDwTLwJbvkpS3XE3EEA==
X-Received: by 2002:a5d:5231:0:b0:360:744e:4f23 with SMTP id
 ffacd0b85a97d-368240cd563mr46480f8f.63.1721057476914; 
 Mon, 15 Jul 2024 08:31:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3f13sm6756349f8f.4.2024.07.15.08.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 08:31:16 -0700 (PDT)
Message-ID: <3cf8df41-f5b2-49b2-be0f-28c96c0e638f@linaro.org>
Date: Mon, 15 Jul 2024 17:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/intc/loongson_ipi_common: Add loongson ipi
 common class
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <20240704033802.3838618-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240704033802.3838618-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 4/7/24 05:37, Bibo Mao wrote:
> Loongson ipi common class and instance is created here, it comes
> from file loongson_ipi mostly. For the new added loongson ipi
> common class, there is four interfaces defined here:
>   1. Interfaces pre_save/post_load are used for future kvm child class
>   2. Interface get_iocsr_as can be used for different architectures,
> now MIPS 3A4000 and LoongArch 3A5000 machine use this ip, can inherit
> this common class.
>   3. Interace cpu_by_arch_id is added, by default generic function
> cpu_by_arch_id() is used to search vcpu from physical cpuid, it is
> generic searching method. Different machine may define other search
> methods such binary searching method.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongson_ipi_common.c         | 394 ++++++++++++++++++++++++++
>   include/hw/intc/loongson_ipi_common.h |  77 +++++
>   2 files changed, 471 insertions(+)
>   create mode 100644 hw/intc/loongson_ipi_common.c
>   create mode 100644 include/hw/intc/loongson_ipi_common.h


> +static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
> +                                 uint64_t val,
> +                                 hwaddr addr, MemTxAttrs attrs)
> +{
> +    int i, mask = 0, data = 0;
> +    AddressSpace *iocsr_as;
> +    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
> +
> +    iocsr_as = NULL;
> +    if (licc->get_iocsr_as) {
> +        iocsr_as = licc->get_iocsr_as(cpu);
> +    }
> +
> +    if (!iocsr_as) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    /*
> +     * bit 27-30 is mask for byte writing,
> +     * if the mask is 0, we need not to do anything.
> +     */
> +    if ((val >> 27) & 0xf) {
> +        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);

Adding/removing files make noticing the uncommented changes very hard
(see my v3).

Here you use little-endian instead of host one. This device is L-E only
so this makes sense, but I'd have appreciate at least a comment about
it.

> +        for (i = 0; i < 4; i++) {
> +            /* get mask for byte writing */
> +            if (val & (0x1 << (27 + i))) {
> +                mask |= 0xff << (i * 8);
> +            }
> +        }
> +    }
> +
> +    data &= mask;
> +    data |= (val >> 32) & ~mask;
> +    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);

Ditto.

> +    return MEMTX_OK;
> +}


