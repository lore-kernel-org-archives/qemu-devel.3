Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E985CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY3TE-00006o-FW; Fri, 12 Jun 2026 11:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY3TC-00006H-B2
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:06:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY3TA-0005C8-U6
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:06:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0c32f6ce1so7570145ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781276811; x=1781881611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mtjp9a4dd2uPHcL5s9hPKbvSRLnt55OQmf9LhoW88Ug=;
 b=ao/vIqtrRa0DviUUd147/5pW/WCMd91jlJ4XUxGxfwmrD/G8Fu8X6AXzsteCmgwdiG
 /Wy8ihMwXx78Jdd4Otyf5ONTm66ZHeO22rD1KWKVTqS/QpBmx03SmKLE95APHnGNFsoR
 pQnPzmZjHtjIlObo2wB6MvMcGKksXwm39N2lcM/SrmXc3m0aP0SnJ9zWsv5+3KS2Xovc
 uRDN/dxY2b80BvmzjUI0WuQ3OgFdclR4uHuY57EyEC7PrmmfoM4WbgNgWuMVp2cXseMr
 16H0rThd35HZhIddevyxlwIxcEi9J0H15Cf74q0+9gDN7nkOtGbmyxNYFSp76UAmGlXk
 C3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781276811; x=1781881611;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mtjp9a4dd2uPHcL5s9hPKbvSRLnt55OQmf9LhoW88Ug=;
 b=Kpmu8BRqqQhrtMxqTfG9aNMydnSFimU0BGm4b+m/T1q6412LKzm16cq7pSxsAB2zEV
 MWqkekL5owYYABI8sERLcYSvnoiJihqvERXbnOLeYB1SeZsvmLfnFXDBgSUbndfyg7OZ
 KoWF9NmoUb4lrxiJ70CBIC6uXYBykkjDRhjrI92sw7/xWxjnx0IVl/JNW21vIjhpmolZ
 lv96Uw4d1mk2hedfV62cluORU96G4hAv5wB2IB+M/0q6zTgZchv7yHh/oEb7FrexLHFQ
 Z8gl2p5Fc47KvCdaxdXBs8jCqm8+BQ7b+ilXqChtiAETPXogJb4H3tQfOTKOLPv1RMAW
 iM1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Z6/InT8/21nW5sriXfsygkbqsl73rLZIg9LVS+iB+Qeibg3re23AHQGANIjK23KseWrg/qsN/UFf2@nongnu.org
X-Gm-Message-State: AOJu0YxSE64FDAUdc2eM8TRFgoaQGISDnX3iyEnfBD6vyoUxfdKiVcnE
 mfbY9ZFkpZ7NSiRpDes7S2TGTP+IOqy04+PRsvxSaYDR8WSdR8yglSa9qAp0r0iP72c=
X-Gm-Gg: Acq92OHn4J+CTPciyUoQmdxdOP3WgdLZJXcMVNDOEXNUr/mTCP2whDeEAA9FkY96Ma/
 6uv3yVO8TYLiN4x/+f0E03dprZ8BgKzK9mKHVclLEvaU4hMC745h4EHzkuMeigNYTj9VEksAmYw
 zGfKt4eGB7Kr0iORtkB3aMf8aqzOqoWb8KojlX7tq6PxZPV+2/0Lr0KTspzP/IV9lB8zj8IbJqY
 4uBKJ4k90dwsJ72hZ709MabOMlg/gUBuQkZRoO+RmXFTtzWjdBOYPPfqJpF2Q3Q7ucjITATU6s/
 8e5niROBiImGGY4bkH8Asvbrku8atY9vpdtOPw4AXdXsZXTPP8BsLE/VPCr1PX8F7cANipnX8J5
 je0+iPMw2dvOH+qQx1d+hS95aWwB7orWTyyTMqvAGijuUbmX8TYKcNaReTNoYj6nAQ+nrCaCLtA
 u7tE5QKwG/ZcF5UkjPpk/P2RRdvg3vNVJnoTn7
X-Received: by 2002:a17:902:c402:b0:2b2:ebed:7af5 with SMTP id
 d9443c01a7336-2c66416349bmr831415ad.13.1781276810575; 
 Fri, 12 Jun 2026 08:06:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e52c0sm24158345ad.13.2026.06.12.08.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 08:06:50 -0700 (PDT)
Message-ID: <be44cef0-3a18-4c88-8c84-7910a90dd0a9@linaro.org>
Date: Fri, 12 Jun 2026 08:06:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/xtensa: save/restore FP registers across
 signal delivery
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260610152648.677463-2-mattst88@gmail.com>
 <20260612141406.1211912-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260612141406.1211912-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/12/26 07:14, Matt Turner wrote:
> Add support for saving and restoring f0-f15 across signal delivery.
> The target_xtensa_xtregs_fp struct carries 32-bit f-regs for cores
> with XTENSA_OPTION_FP_COPROCESSOR; target_xtensa_xtregs_dfp carries
> 64-bit f-regs for cores with XTENSA_OPTION_DFP_COPROCESSOR.
> 
> Lock the xtregs region via lock_user before reading on sigreturn,
> since sc_xtregs is a user-space pointer that may lie outside the
> locked sigframe.
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   linux-user/xtensa/signal.c | 96 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 88 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

