Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D709C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlun-0003QE-HS; Wed, 19 Aug 2026 15:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwlul-0003O6-M1
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:25:31 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwluj-0004su-Ur
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:25:31 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2267104a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787167528; x=1787772328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6y2BF2KjsqIeeaZzuGQ3k6Zl8/RsVL4sVPR7ZY8U3SY=;
 b=GmFRLBWTBWDH/V9dOCDYozDZHC9KZD6T3P55Uuh/LBBmsAc//rs9LtZQW1+5IqkKT2
 420ivZTYKSzqcAG/Tns3K3NlbqnEK0O9jLJStu834tfjXEiPVLGDHNR4B+SPslE+I80a
 p4S0qixSLjxrD/yri36+Ll1JOeHy2GWh+mVCSx8MX9pVv8CT93XrzHxd4/ACo04cOnBi
 2F/LDNSKDIbwsPGzdGmP0J6m+zljWaLkQx9tb1U29fxACApaXHCuYHR2iEeGNr6cx+2D
 Lr59VSOiSgrYVCR8WXe9BJgI3ktjDMyX7HPNAKJwDgYVEG2GUf4qClx9GezdK8yLTdWI
 fJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167528; x=1787772328;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6y2BF2KjsqIeeaZzuGQ3k6Zl8/RsVL4sVPR7ZY8U3SY=;
 b=heZlp77IrZBdZrx51Rts8vMPxqxbAyA6RLTezal7TOFBKxH0f0fGQtx53Hubmq7uBd
 lWNv9cJTdLOW6OFbXQCFPxOj1HIQ2W1CdmXY6IMFaoK8SeN6A/vTssE1m1To0fQP+TM6
 2uiBS2x73TIBu4Z4W0A7gWfOF2QD7YrMklfoVrcIEbxv48BqDpi/SXehiYLLiQFtGBoQ
 pBrIYTCth/3hs7LwXrwNFjeK+pbAsscpMQzBRVldY62EwT8pgLRb3LGT1pxQFrxzB18Q
 KWpJPyoVj6tFKKqkGO4t6p1IY4uXU4b+44cikkotJnTOiz+X4GZDjT42eCeiv5NwpuJN
 3XJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLTgeQVzFXntLXDgUt6v5WGTC+sOUtwFAzv0itm46F9KLSBsJm23zI+wlGPy2t5W9522HZOfs3FaA+@nongnu.org
X-Gm-Message-State: AFuF++nqRkjl/rUJ0/CVt8aBSDGepcP6XRlOEkVHbd7OgitKM3VUhBcY
 NHsZ5Lo/5/vdYeu3il2yRfvNChC4B8uHHfovz5diDZna5QZhPEtEyVGiMkk1N+cExXs=
X-Gm-Gg: AR+sD12hlqhiQIG0AYCreSna5zsSplDmTlN01ZCwQDCjp7sTaAsUZiXP45LPouS5aVK
 IC/SrZuEcKI0XCSoVL8ANxdxKN5/xo3XTDdcWPh42wRIisLgzxpi67/EvgBhf/5m3PB6khqyqSO
 CsCbzPRtFhMWdvnXcGkizGuxPMcI1MzD0KtetusdA7x0hhKfGQi9Rs13ZrDqB0Ug2S3jQpPKOZM
 w9S0zixOCLXbxo5iG6/xu0zSXXPDqSVj/ufyewC/IuOeEwB4ojkLFWxffyXXJdqv569Dkeg+9xj
 ocNND3JBletC9JP/U6UPAx9HZ9t7KImKSDufCVn8Yec69KIW9yn2Tz0VjRY/HDWBvmaWDBiaXtQ
 lrNtfhWwQt1ATKi7t1M+jtHiTXVPGyBa/ZLmc6ayAr9khn95bcqMDsT0aM9mKesOkszLhM3Hl5z
 n82Xk7z5Lbg+b7sa8qxMFUUAFh+VJ3ZoKxmOJ9aD1KDjihwzwlco2LXUlgbiHBLmEM5KE5A4G7t
 5QrlQEQ
X-Received: by 2002:a17:90b:2e42:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3958109a525mr13699024a91.13.1787167528082; 
 Wed, 19 Aug 2026 12:25:28 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb51271sm3985198a91.7.2026.08.19.12.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:25:27 -0700 (PDT)
Message-ID: <4dd5ec08-76b3-4478-b5ab-baed1364f360@linaro.org>
Date: Wed, 19 Aug 2026 12:25:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: check FPE before reading fcc in
 bceqz/bcnez
To: Jan Mercl <0xjnml@gmail.com>, qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-stable@nongnu.org
References: <20260819132422.5164-1-0xjnml@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819132422.5164-1-0xjnml@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/19/26 06:24, Jan Mercl wrote:
> gen_cz_bc() loads env->cf[cj] without CHECK_FPE, unlike every other
> translator that touches an fcc register (trans_fcmp.c.inc and
> trans_fmov.c.inc, for movcf2gr/movgr2cf/movcf2fr/movfr2cf/fsel).
> 
> A guest that manages the FPU lazily -- Linux clears CSR.EUEN.FPE in
> lose_fpu() on every context switch -- relies on the next fcc access
> raising a Floating-Point-Disabled exception so the kernel can restore
> that task's fcc.  Because bceqz and bcnez never raise it, they branch on
> the condition flag left behind by whichever task last owned the FPU.
> 
> Real Loongson hardware does raise the exception, so this is TCG-only.
> It surfaces as Go binaries dying at startup in runtime.check() with
> "fatal error: float64nan1" -- roughly one process start in a thousand
> once the guest has more runnable tasks than vCPUs -- and in general as a
> conditional branch silently taking the wrong path.
> 
> With four tasks each executing 5M bcnez on a 2-vCPU guest, master
> mispredicts 89 of 20000000.  With this patch, 0 of 100000000 over five
> runs; a Loongson-3C5000 is likewise 0 of 600000000.
> 
> CHECK_FPE is defined in trans_farith.c.inc, which translate.c includes
> before trans_branch.c.inc, so it is already in scope.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/4209
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Jan Mercl<0xjnml@gmail.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_branch.c.inc | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

