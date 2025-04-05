Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D58C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16S1-0001Xk-Vq; Sat, 05 Apr 2025 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16Ry-0001XT-E7
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:32:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16Rw-00009Z-4G
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:32:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso3574980b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743870770; x=1744475570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gm7Bn69nATykFuK/l5JlYYv6YYeCwaCe6gPo5Akukc0=;
 b=bCC401h1HZeazPI6KKf8xf8TVU4pSfuAcNBuJqd18aAUG9+vHbOfcUNq2VTEt0XwCw
 5zLbyczlkOjVnK574/s/Ol941KeycHn9T+dxiTzgeE/OpmDgrAHvRr6eZn5z/eN2/1fF
 572wFbXs5R20xaqGfULqaZj58H4o8lyzuezbRpECgDvWC4Vv45Qw8VG+Pb7aCGc2Tut1
 aBFxmRCbQfBuyVC5wstmTL71l35gl/2oQN0eEYNY2/74awmawEPud5rIobXKHxoBcNcO
 ucr2r64B+Vdx9aXof3YvfJ/NV2ghOVO76lA6p8dI8V0ZMMSk2KylEsInoJ4NvjBoxXOO
 nIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743870770; x=1744475570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gm7Bn69nATykFuK/l5JlYYv6YYeCwaCe6gPo5Akukc0=;
 b=Kji7+r4cl1CdA/Xnn5cRx54bmd84Z52L0Zmskt+fjZ9NpH4s6jblVk1fo5L5gc0b2W
 BLa6nudVnCHAGqobWsG6TpDHgWDW7vMLR9i0AP5nWldpe7EDE2WZvotC5Qnrr7/uj4sH
 /bcRHrAk59w+o1eMWgKGS8aNpqnwB/jqOI9TokpSbz2wkUU594T066SdUKi2nrzG/615
 13wOtf/UyQDJTMKb2PIsr/iuEwCylNmjCl35TIEUslKLqXydQE/U9dbORR2bdX7vkwl/
 0jgS6orMfC1gcXlzR6QTLpWoGp70eCVp8wBk9ejwxLvdhDQ2KLSIKLC76/kzUXB05nob
 9Ruw==
X-Gm-Message-State: AOJu0YxVTTwtABJUxtDzO3+7Vg3iE1x8zpc9BgkmL5UBULPGWeqnkxeo
 n0XNfZPB4nY9T4/nwOetaXHToPdZQgPAsIDapnDpCUNU8H/TP9YRBCGKoALxIhkKh1ol3aPOCOr
 m
X-Gm-Gg: ASbGncujMNMs/cCw+MC5WwdYNmi634n5u7Xdk1ihT16F6Amg8orjtdmzr/LQ4cuzWZQ
 wqmu1DEjRoYY2G52vYMW1ay/mSsr/z7uOgZbOpcMn/JLFkqQ+fcpMrdzIZKTq/YsblnSZvXi30z
 5W3lWbXLAPUyoEStUuQnn6OsacC0trQDIxZ7IFARdEJyxbFw9bnVo+fUIId7rukksaAqIzjcfH3
 oCNV1GeZBsztb/WuHM9Nfo22lIZeVpRKhbvtwuwDMKv3S32TsZs4G+LK/cUVk8s6U4Hb5Ktf8wX
 Ym7ze1BJYOj0CXzhGSekQxxDi7BZNUqeQKtUzlMwGfx7aYDHbNvMDfqWsNyeiTaI
X-Google-Smtp-Source: AGHT+IF6zvgMoL5MKiRArMBcBe+gINFNDJkHmX7Wfc9MR3pQ3FDsHT7Ofm+3FX22BUrx0Cx9+Gip1A==
X-Received: by 2002:a05:6a00:3c83:b0:736:6d4d:ffa6 with SMTP id
 d2e1a72fcca58-73b6b8c11ccmr3668563b3a.15.1743870770103; 
 Sat, 05 Apr 2025 09:32:50 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9ea080esm5587045b3a.108.2025.04.05.09.32.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:32:49 -0700 (PDT)
Message-ID: <63f17e19-d71d-4d61-a0bd-3d8a38674fd6@linaro.org>
Date: Sat, 5 Apr 2025 09:32:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 9/9] target/arm: Build Aarch64 gdbstub helpers
 indistinctly
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 3065081d241..503d106b588 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -3,6 +3,7 @@ arm_ss.add(files(
>     'cpu.c',
>     'debug_helper.c',
>     'gdbstub.c',
> +  'gdbstub64.c',
>     'helper.c',
>     'vfp_fpscr.c',
>   ))
> @@ -13,7 +14,6 @@ arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>   
>   arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>     'cpu64.c',
> -  'gdbstub64.c',
>   ))

This doesn't do what you say is does.  The object file is still in arm_ss, though 
unconditionally instead of conditionally.  Which causes all of the other follow-on 
problems you saw.

I'm not fond of either this or the previous patch.  I'm surprised that you're touching 
anything wrt CONFIG_USER_ONLY.


r~

