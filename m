Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F911CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRzWa-0005aS-De; Tue, 26 May 2026 17:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRzWY-0005Zt-4I
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:41:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRzWW-0001Vu-8S
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:41:17 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bc7b311e77so50734805ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779831674; x=1780436474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gK/gPTVvVrHpf8sngQaR43WX+ed0zg5u4KRi/HrHF6U=;
 b=VacQDjwzRhtlnc/AOwLef4P1CytWF/CAkMzVSlq5Sr4FoDKSDjeMRWd72GoqprJPFy
 q5Fu3MDqtCCJwksjYJ07CgYqzWWcO+o5oiaN+YGmxUA/m1weWvodLekuWwb+jDY7AurT
 PEoYuIqT0L44Qrg4r28EGQRXIpsh6GJGPEKKxUu5l4UEvzrZZ5cqSNp6blALnxj049U8
 GoPqYgX1NoFPIAPaUCP5AljVoWsAEBbfyQTYoTzSYJAalK37OT7oPdG3L9t6J//K4OIS
 +K8bmpHxkjmHRy9BYqG4/otYLEX/0UiEXVbmV8rIuWrEmWTWItFFUFYOcoswNO0PgER/
 f9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779831674; x=1780436474;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gK/gPTVvVrHpf8sngQaR43WX+ed0zg5u4KRi/HrHF6U=;
 b=Z7YYa7C42+8uC+dXhqt33boqUGfHw/tYsKvwZZn33aIfSFJ1YOg5PzrwSfLPv/4SqB
 XNKdQBnsB2JXA2q8VxIU6AvmTMm0fowhVY5lcG1ApNa4ogPlyXEiIwnXS1OGSUUo/WRW
 lnMXErou+r6sHF0wPf76ATPu7ql17o3dKnmU0fq+rx7eDH2eFrW8PIMt+oXbWkdlWKLd
 pPDGvbJ9wljxVH5SDNNs18VGwOZt3B7znYKNXdGH5gS5OhqouOoLFpapLaNaNackmY0o
 cKdlMiSCnMVjKUm1cUNigWnYEGjj5ZKpbK1lDrCzFpG5jVWo3KNUW4CilbO+kAoebUMt
 1/nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VlJKO+krEwORxtdqd2G+G+MW6X0Q6wtfO3iPlMfdSnBP0dZehG58Gs0d7mn/Gfqs6xKhgyqr2efGF@nongnu.org
X-Gm-Message-State: AOJu0YxFUIvdo05syGZksF/dZLzVEStDKjZXr9DlRmV9+b/7MY8/GqBS
 2NmYojbjqmT1IAYFfu0B42jis6nRNgLjsa+SlkPN9AxMSHGl7pFB5W4+J+/T3J99zhc=
X-Gm-Gg: Acq92OFH4mnEcRXc7baZZCbzEfhs5qM8QcKjKSozNdnAKftpeyt6FqcRobUAAXUNAzL
 X5dt9stT3a+flPH3YV5BSPALwkk/tB0KMYsNRlVue6fozx9mmN1BOHva2a+tWWG0ru4rd0LvZUT
 +9pN9I9Jk4JtsoDyWTRpHyINHNrdMXz0a4SOu2mxnZ8xxPcL1wPAuJAEdKFFCb2jKwwV2rAG9oE
 XtQC6WAcV9adxjjenZPnri6oOQ3uo6IxD2OaUvkc4cHpW8XMZJexbVyvyAsy8eLSOudeNiYL7BR
 Fhy8ESctoImqYDl1vj2eSo+5ZB0e1hTJE02fQcOrXUHlNclVyptZTFFlEoHfWphhKN+Nci6KmBk
 st5CrXKmlP0fh3aThvbGawN1syZRxU2/s18YEXpCS6khud078Ql87N9AD0cUrWYC5v3OiB7P94A
 6VY5qi9OLCRR79WuaXb2iCPq9iwk98WE/RNyed
X-Received: by 2002:a17:903:11c4:b0:2b4:6597:44d9 with SMTP id
 d9443c01a7336-2beb082545dmr175970435ad.8.1779831674310; 
 Tue, 26 May 2026 14:41:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f9100sm127715785ad.37.2026.05.26.14.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 14:41:13 -0700 (PDT)
Message-ID: <dbcb19ca-9b35-4da1-9bff-caeaf9221137@linaro.org>
Date: Tue, 26 May 2026 14:41:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't assert if 64-bit EL2 AT insn sees a
 Domain fault
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260526174155.2491217-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526174155.2491217-1-peter.maydell@linaro.org>
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

On 5/26/26 10:41, Peter Maydell wrote:
> The Domain fault type can only happen for 32-bit short-format
> descriptors.  This means that it almost never needs to be encoded in
> a long-format fault status code.  However, there is one corner case
> where we do need to report it as a long-format FSC: if a 64-bit EL2
> does an AT insn on an AArch32 EL1&0 translation regime that is using
> short-descriptors and that translation operation hits a Domain fault,
> then this is reported in the PAR_EL1 in long-format.
> 
> The PAR_EL1 register description defines that this should be reported
> as 0b111101 for a level 1 Domain fault or 0b111110 for a level 2
> Domain fault.
> 
> The Arm ARM pseudocode special cases this in the function
> AArch64_PARFaultStatus() (because no other "fault to LFSC" code path
> can be a Domain fault).  For QEMU, implement it in arm_fi_to_lfsc().
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1fa498fe0de97 ("target/arm: Provide fault type enum and FSR conversion functions")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3512
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 00830b1724..bb15b149f9 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -880,6 +880,16 @@ static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
>           assert(fi->level >= 0 && fi->level <= 3);
>           fsc = 0b001100 | fi->level;
>           break;
> +    case ARMFault_Domain:
> +        /*
> +         * This can only happen when doing an AT insn at EL2 for an AArch32
> +         * stage 1 EL1&0 translation regime using short-descriptors, and
> +         * the translation hits a Domain fault. This needs to be reported in
> +         * in the long-format PAR. Compare pseudocode AArch64_PARFault_Status().

PARFaultStatus.

> +         */
> +        assert(fi->level == 1 || fi->level == 2);
> +        fsc = 0b111100 | fi->level;
> +        break;
>       case ARMFault_Translation:
>           assert(fi->level >= -1 && fi->level <= 3);
>           if (fi->level < 0) {


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

