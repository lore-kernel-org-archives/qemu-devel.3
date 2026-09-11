Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C0C88E45
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 00:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5B9N-0001VG-HN; Fri, 11 Sep 2026 19:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5B9L-0001V6-GN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 19:59:19 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5B9J-0004WL-S1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 19:59:19 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso11933685ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789171156; x=1789775956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=81/bihRBXC+CHDb8gkczbvkkaeGokBAQOXkEGMt2vm4=;
 b=w3C9Y6+Wbu2DZwmN0Oik14Tw96D3QenN5zKIcKEtdehRDuiRr3ALTsBN3M+dYv/ukA
 +eivqMKg/DWUxHF4AwraVlfe5BEg9CSYhbk5BkpAI0eTF5wccRRNe3AlKcoR0DH8GERY
 nYILpEyRqjIm4qZdxjINxZ3wHsvhXhOK/LtOMwObyLrmvTN0+BJ1JZEaQd5PoKc3SuWL
 6JyLc//dfwjT+Q4456/h5kJH0OX9ISavgpn91KDO3PsLzh0FeTlTESuWNW0rxiKS6n4Y
 OTDvKqPha6Fqs7og9cKeZE4cUIj/uj/XsOGX7YCi+6RTv8dxfSS0K88dVV16HHM2PF2s
 dWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789171156; x=1789775956;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=81/bihRBXC+CHDb8gkczbvkkaeGokBAQOXkEGMt2vm4=;
 b=qCsMQsl4CJElXrIN1aYJVyMUvNJVAy7DUxrgROtO++AB7T6gw3705CqKuOky5RjWR/
 ycgfGDYnM7m72Q0NhOXw7CUvr6m39ZFSUhh0QstdN/kqm8IzpHbZG07MA1b4DFY/kMZC
 fxdbr0vaAOwSy7LL0FWxytTCDOeI8PF5v0jKQ9ArD/nFu2HLYITF0uKGJlGe1Zl1HAD+
 VaKjZaHDL6BL7aI8xukh5Yt2g2Zu/A5rqYP5/vohr/wwvmklmvGZ+SfxYaI/hVV0qBMI
 5/1sDQUKnsWRldYQyiZoRB60GsmVW/KhhUZIgnJxIFqUOpsNcSYiQQfYGH0A+SB/4Gl0
 1owg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJ1tcf+KzUUq5lg/tQf4S7Cnw5xbxri6nwRd4xXQ1s24y4J/en8g1N3C57CBV10Ou4k6xHEsR4LZqG@nongnu.org
X-Gm-Message-State: AFuF++l9gLtaGqi4AGiTQyR/8dU/lkZgsPEyEjumkhBzBxC9fKfalbpv
 W6s6+p6WOksJliNBWILeOaMSJYaiSy9h5Y5cnqSswEx6FdQxZIQ/gnkVpX6G+efTfHM=
X-Gm-Gg: AYBFou0RHWWw1nNIGvqiSj3L4JDLFm597DGajjKD2o4vU9+DZPKAgyEZvDKemoWU9do
 LvJxrCHPSL6NE8jHO1RTO9KGfb97pobNFw2wfgXMZNKSl69sEVJuPWCRC6ssywQ+F5AdqwhjSok
 7LWodYyMS5LE7b1lPquy5GjGEhizIA1aYZYTLpSPnUBPZLqcApxwc5jIZK6kOjxXZX+Vfsoq2bl
 g0PtWvEqZD8hYkj6pp29zM/mC1ZuqVwYxkDDPHcX3z+Iz3J1ScLBHp9iWlRMQyTNNqE4kZTsUEa
 2Cf5TsjO7lJIftd56FnG6mApEyBABqf4cXfB015t/Ito9f3bxzZrCw2M9O+RttK2ltZtQpCtGEw
 cfiQKrP8L42fu23Ay8H07+unfQX1bW5a70luhKKGybFGgOt2aTQAOqO1ZWcFPEhF5LE1lLpzDF2
 iUxzLSnBuCUwR+twHch3CYVa48ykR/nOEFpwMD/uylcAW+pG+yK0cG7OfNXNl4XcbGC+g+suTwk
 1SnrZdQ+P9p/Rnpgd6IUEETA6Jkysphes/aH5laLS9epY+AQ9CK23dDeIM=
X-Received: by 2002:a17:90b:2b43:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-39d9c21f8c9mr11383480a91.19.1789171155816; 
 Fri, 11 Sep 2026 16:59:15 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b97994sm16882948c88.12.2026.09.11.16.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 16:59:15 -0700 (PDT)
Message-ID: <f6bbf9d4-f9a9-4192-b365-eed83fa9b30b@linaro.org>
Date: Fri, 11 Sep 2026 13:59:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] target/hexagon: share HVX contexts among CPUs
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
References: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
 <20260911204334.1264922-6-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911204334.1264922-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 9/11/26 10:43, Brian Cain wrote:
> +typedef struct HexagonHVXContext {
> +    MMVector VRegs[NUM_VREGS] QEMU_ALIGNED(16);
> +    MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
> +} HexagonHVXContext;

Alignment is a property of the structure, here.

> +#ifdef CONFIG_USER_ONLY
> +    HexagonHVXContext hvx_ctx QEMU_ALIGNED(16);
> +#else

No need to duplicate that here.

> +static const TypeInfo hexagon_hvx_context_info = {
> +    .name = TYPE_HEXAGON_HVX_CONTEXT,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(HexagonHVXContextState),
> +    .class_init = hexagon_hvx_context_class_init,
> +};

Missing .instance_align.

> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
> index e4ef97a1184..c8fa6080a4e 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -33,6 +33,8 @@ void cpu_loop(CPUHexagonState *env)
>       target_ulong syscallnum;
>       target_ulong ret;
>   
> +    env->hvx = &HEXAGON_CPU(cs)->hvx_ctx;

How complex would it be to not have this pointer for user-only?

I think all that would be needed is to define the base as tcg_env and 
adjust the offsetof used.

> +    ctx->hvx_base = NULL;
> +    if (ctx->pkt.pkt_has_hvx) {
> +        ctx->hvx_base = tcg_temp_new_ptr();
> +        tcg_gen_ld_ptr(ctx->hvx_base, tcg_env,
> +                       offsetof(CPUHexagonState, hvx));
> +    }
I think you should use a TCG global for the env->hvx_ctx slot.
That will let the register allocator load the slot on demand.

Also, this could become

#ifdef CONFIG_USER_ONLY
#define hex_hvx_ptr  tcg_env
#else
TCGv_ptr hex_hvx_ptr;
#endif

with a slight change in the offsetof computation.

r~

