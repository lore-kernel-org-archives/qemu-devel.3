Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68366C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmUo-0003pd-Ez; Wed, 19 Aug 2026 16:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmUm-0003pI-J4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:02:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmUj-0003nC-HO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:02:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so2561935ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787169760; x=1787774560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m2V1HvqKjAXGPxijHU9/vWp85mD84KHEKvbER6wzT6Y=;
 b=ETyqt+VLfw0Km0V3fhTyWWp/OFIp467+SU8yWpb6/qi0NZeH7JG67+KtZSoenMby+f
 gN/Pp2jXznjJzPCt0HyN54hStkVLjK+GhbdyUvvrsgJJP5AOCJBBgN5ormJ/yQc1s+Vc
 XsZB2HcV5xclUec55a8sKGaoNJvmXcKvgmo1GUmmO2CCE149JDqlLiotZByFG9FwzOYH
 QaXkC7QxhRkYF4aFUm5MKbYggxvPYpw3GAQ9zAKzLHIIYEsOW004wl2WvQl/0tV7lBnc
 rxmjQH/zsIV48mRJllj/IwD8vNrPQg6PwB1W+KxOBkLle+90KCLn/k/NZ0uYYxz/wTom
 Vx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787169760; x=1787774560;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m2V1HvqKjAXGPxijHU9/vWp85mD84KHEKvbER6wzT6Y=;
 b=iKwn+urYr4ILzC8Q3fMpDbpJkV6QP1OwASXRjudP94ypI3R3NBxrn4eXMJTCvN+mGD
 cHUXyXAA7ykpeffIT9s8rPJHxeg5wMIH+FAlCbaOung01ZxS4Ga1mbi1BCwRJyTtxPr8
 mLHvjR8UZgX89HEUPnVAkK2kt1cBMI6jz5o+ai4hm5GDRlT7hXDxqSl/B7X3AJc94BYj
 GQ6194qGlyBkZjI3aMaKdaWtrStHEHJ5Yhe+xguGVhjwmazKyLFYl1zDbfRwKONgyzIg
 6bo8Y4wLF/fv5raJfjgo55u8DZB3OkrlzDBbMGpmsk3+nvjxoxH1HMld16Kso2y/s1zH
 v1bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoivWAPFX2h8QjsKM3HaKUJ5JYo73KlGkHSvkTbRM8EJ84NmjWp0PDd9/kUtirqUhLyp78ViqOlgwYw@nongnu.org
X-Gm-Message-State: AFuF++l68OjBSZjrOkjrnF03/EnHYIEo1WE6l5SSHRXBlACR5YImMbss
 m/mQ80Qf7TEa35bYtBxPjKfSqt+NqvmUC/YdywtMubzQ52+2pAOxRl/SawODw1gBgSk=
X-Gm-Gg: AR+sD11YOjk06NUk5TPS6QzV2TKZHgDh+5vFGrXXg0cZ0w/EjSShvRDhBaZ0633o35w
 LSN9G7bae8YeXTQWMMyujBNkOuivrEvnZOJVORabuOmRSOrP5ACW/q0NjtGiuifd2PTwpQmWNUc
 IWQ4iy+5EMoHdHLzBG1tzLW5quRolEIHITrIKqTf+FW8paJVJtuQlqdUEXgGf+LCXZu/f8YCNwu
 WVvDKX1llkQkJW86sHOUNhT1Qq5/FhPJ6dMgUkRv/sbsGXzgxIa5pthUUj3ZOb06JdBzNYWiu/r
 bfdK8HMUaT/ZikSFpVCQgkfsw4pkhJp9NMgEPsBn3UHsDOlYNuLvndiCvfYwCtZQwHVKlNatcGs
 x4pRGOMGapD5aice6vMSX6hbNxlRfpZsE57SE3Bg8kzbVmOA467m3JAMq/cLyXID7EQ9axj7JYr
 u+LIgcwRnCwT0ex1bqPM3j0USlVmqOSM7nOKUiPL68o9/LIPvGzL4pEm2toNfjeMmdstuooHa5J
 LPu8p6f
X-Received: by 2002:a17:903:1248:b0:2cf:70d2:da7c with SMTP id
 d9443c01a7336-2d61a1a4bc4mr15693645ad.12.1787169760049; 
 Wed, 19 Aug 2026 13:02:40 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb51951bsm30826305ad.29.2026.08.19.13.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:02:39 -0700 (PDT)
Message-ID: <f39f1b0c-93ea-4981-81f8-95e03746ea79@linaro.org>
Date: Wed, 19 Aug 2026 13:02:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] accel/tcg: Check %halted field in cpu_handle_halt()
 caller
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> In cpu_exec(), checkCPUState::halted field early before
> calling cpu_handle_halt(). The logic is the same but allow
> to simplify the async event processing hooks that will be
> added in the next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/tcg/cpu-exec.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

