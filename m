Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA0CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rjg-0006i6-9s; Thu, 09 Oct 2025 10:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rjN-0006a5-3L
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:34:59 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rjG-0003Kh-Bi
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:34:56 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-57bd04f2e84so1153254e87.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020487; x=1760625287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/3004OsejbQepgqHH10D2B9muuMVta85bk3ebxZXnTk=;
 b=eMvIsxPAOAJj2KQK7/bZ74H+A3a8QMoWGkQdFnr8376m1+2EE4h2uAidDiTRDP9A2Z
 QVQFr6XgD72ePZYRxD3RmBcwLbQWAabeqY+Wpno4bZmAbV/P/y/bqwpDpjaWd13u0ndN
 DnYxgyy/xpUFMBxf4/RWPhiUFbjo39Q4ifmLd3G1uWBgSqmROVRbT23uiYRPG6ozgaRB
 kK2XYfp4h4yrE4L7lMV+RLMa94eOw5XSIiAmZ8VseIeRf/X+qsXCaRlZgSeCqShy1Z5q
 rgI0iIjFCrclCCmNvb51uOcNGwTPInLnJbGCSTYAjvqbG4FLv1QOxst4ZG1pEZNzIwM1
 gdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020487; x=1760625287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3004OsejbQepgqHH10D2B9muuMVta85bk3ebxZXnTk=;
 b=QUwGxyorHSouR7UXLq/qzhedLvTPUmKWrfTaOjOmnlY2/avEJlX6cUicYin9beosGc
 Hg7dboK/hGJo5fb3Cl/5AayHPk/Tvdvc5b9lQYIdDF9TKF2Lm9vdKSQ9yGJpCbeEYMjh
 9Lsh91h0/2IaRpwUtIW+BMGSBQhpq9B037yUugsmEmcJjH+gi2VLAdq1nuEMcF+UuZLr
 m2GWVyOHOUHPO7COrvYlivIgpvRAltjzJgytDiNNkKwYjQN6vacocW2i/ampKHk/SwSA
 4eYW1oHGPkb8AKjIjoI9+sJYNCWrHiTF3nCi0M1vQbllw1ztUUsC9PB3mVAs9ERSuYJf
 1MUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE0UvndvdCLXIVA/JHuBqK/G7mAyXvS97f/FSIx5yzo3t8KatT+iQd/f0KQS4Kmfk0ePnv1H+H1XQO@nongnu.org
X-Gm-Message-State: AOJu0YzjWBbFqfg0cs61y51s29TaRsk2sgKVcWqhb8MbQD/tMPv0BUmn
 XS7C00iuJhMZew4yWFPZ4ylK+TUNPv6VrYlDlS4N+3fTFx5UdFWNN0rWAnxRWUF7Mqc=
X-Gm-Gg: ASbGncuABbW/4IKYq2icMapmLDau3NV0nnUpaAeQboBFpmGEnnz0P7T74GQTiB/D6y9
 dtl40LfWd3oqdq6I5mYa1F8u2wnX7+G1sJ3/LI4hFQbC8G9Vz3rt1OM68juvd/8Ak72o44QMgor
 FyDs5V3KbMZtTFPsvZlVQjrHzK2O9u9R28htbc5PysIgSOimNfBEfHT285/2TepUo+3yF1xcwfA
 mO6Zmn85KJv2aZ1lVvvJQQMRrDgBdjZDNFy9Ffi5S2LutvL0wJGwDbZ1ifJ/CH1BfksgaHCkmtY
 L5EAddreCdKjIYip22yNoldqHZFrc7TNQmH5yomNbLlMRgXq2g5s2iftf28b7sKCU912KW7P7mL
 a0Nxj9XZcTlFyGXnktsBntIPwVLZUuTn8tIlK/xgRZwUNV8ABuNnvOhFBPX6h56Xhmgn4c46Zn+
 M0IbMdXYRFmpL0WSXbEQ==
X-Google-Smtp-Source: AGHT+IGu76ExjfJv7UhWEz0lLd1hbTNmCfoSynhXx8D8DdjX+cLX7Mu6kVjObBa5tsqbc+DSr1zjww==
X-Received: by 2002:a05:6512:b12:b0:577:285f:32bf with SMTP id
 2adb3069b0e04-5906dd54208mr2064761e87.35.1760020487499; 
 Thu, 09 Oct 2025 07:34:47 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5907ac234absm1113221e87.55.2025.10.09.07.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:34:46 -0700 (PDT)
Message-ID: <94f9389f-608c-410d-b1b2-4e03c3370ce6@linaro.org>
Date: Thu, 9 Oct 2025 16:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 39/73] target/arm: Use arm_hcr_el2_nvx_eff in access_nv1
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-40-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 8/10/25 23:55, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


