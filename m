Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE19C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVfM-00065h-MU; Thu, 01 May 2025 11:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVfF-00064g-Dp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:17:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVfD-0002WX-QR
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:17:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2279915e06eso12055525ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112646; x=1746717446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dy64AXLSg33oFDxGg0PbrM1b8FWcFNT8FYGR5t0yQQ4=;
 b=ZzN4x1oHB/Lmg7IH/MDGgfU4PgEKGdxLq+q8ChpM6XFsxK9L21n4n6X8mGKdu/PoiH
 ossPCI2HH1BEWSrgCSF52dsexRUdgA/bBXZFrFkL63zIvrSQ7XyxcQNj93OUnhUA/67c
 Yf3tM3LQv7ZuCFnaPifvhXl562VpQeUU/DDq6nm9GH/i8gaVL4vOPSgC0swpZqx4zp65
 BeoFQmsFl8kPCoBDksTQwmo+MiQ4Ul38x9jGu7EhrznAMm1HNiVt4fqQOPtpkigqE3Oo
 ucqP3XUsOGgxgYi3Hc/USGnrIhDyRgvRDiTnZgFvLPjgLtsRbsXVp2vt2igAkbax2Ihh
 42kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112646; x=1746717446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dy64AXLSg33oFDxGg0PbrM1b8FWcFNT8FYGR5t0yQQ4=;
 b=ZViBHXNIDxBCNCkRPcV+cRAZOVPpJ886+WBWj+skDGp/YXmf7FxPDBxbm0m/VSfC4/
 QehK2vvFzTLmWqTallQzgCkRpZpNQuj3keJn2BtTnCDlWII5c4eni2z9R/5KDMFLguJK
 5u3UHDzDHBssOw1bCu48bIhzJTpOiPuYsBo63BrONONrx2awETI5TAR6QTvpLhZfe8HG
 Zlbx0fY9sQdOadkpeyeob8Hn9KpDnlVKnpgpcl+18KdC6CgoksyWBttorjP6CBhFJSF0
 B7b+Nxx5QafwsG+nbk47XVPRF6zqgTf/sD63O2WAa4nNfCiiBchvvERkYA8/m2UwxFLY
 8jYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPVrrTTo8oEfxg0qfXpBynu6CXkjk3WND6bFxIdWJNIiTjWvmzhWgKwATvrayCDTiveB4uFawHmDXt@nongnu.org
X-Gm-Message-State: AOJu0Yx22sxvzh1XT3a4iQ4wilsRciMM2K94ez8LPBKPC4HHz2Fx0BAt
 MsxNHPmPHnaLYa3FulX64ABV4t0FI+DPaeQPuh/kEL2N5Ezpz0qGYGUlT+j9apU=
X-Gm-Gg: ASbGncun/KbmlSSRB4otcLLfLTG5zByMQvOam7VX4yj211mVjrxeYo/TACJ5XuIj4bu
 o14K9BVnvn5MXryS4gSa3qmV1UJRyzTl32j0mXWMrF1tk085YSg/eHuGotTwT23mtX9KSRL7exd
 vZsRcmDXyBLJLc5VoKRqmVAlr4pdbAjiwvw3QWHvtbIlR4l140mInPrCayVLrEDO1Ilsk+/iNPz
 zVvKU+wJFoET3oiJZVWfZq8yxVGmXfFT+o7CV5zKQCw8t1NSHmjlqkwuRYc7+bExSw5i2mCFqTv
 kUHW37UXnRWjlp5S3FmmJxe/JiAkpCx4abX20TtOvsxVIX/xIkgjztXhxVmAVHYKe6vbolOgDj0
 nAWh+zdU=
X-Google-Smtp-Source: AGHT+IHhEHrWTzObUpfD2ICW5GU6jqOmtHEYur8ShlNi/oGjCpkvd87Fz0ZVUMYC8k/Hng5SFchK6Q==
X-Received: by 2002:a17:903:1c1:b0:21f:5cd8:c67 with SMTP id
 d9443c01a7336-22e040e45eemr53848915ad.31.1746112645853; 
 Thu, 01 May 2025 08:17:25 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb04bbfsm7979095ad.13.2025.05.01.08.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:17:25 -0700 (PDT)
Message-ID: <2b9b7a9e-c720-4c11-b650-e5e34e3a91f7@linaro.org>
Date: Thu, 1 May 2025 08:17:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/33] target/arm/helper: expose aarch64 cpu
 registration
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-22-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-22-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> associated define_arm_cp_regs are guarded by
> "cpu_isar_feature(aa64_*)", so it's safe to expose that code for arm
> target (32 bit).
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 7 -------
>   1 file changed, 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

