Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171C1D10BE9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4YXn-0005TW-8d; Sat, 26 Oct 2024 00:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YXl-0005Sf-Vv
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:36:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YXj-0000VD-KF
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:36:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cbcd71012so27081145ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917410; x=1730522210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ICl9dgED/m16kjHsCSPmAdWqNiBPiZRJM/ggx0AVya4=;
 b=kGmwWoPi1M2+KMfVXZozTWtSQVEgxUmOgHETQqumbeKJ9biCZKy1Nz+HDKl2cvKPfo
 XYlVeKvqapQq8tj/x5U4GiYt0b1OvbXltZAYD999tKWAQGBn8EwlTBWZaToe+VQ1aFeF
 vfMrKEODXk4CpyQ0R+2f8lI2ri/u9KkdTQQim6sI7sGCMDyfAYD8WKQenknpqfqitw5t
 eWSXGDX46wTKOBgvzCDnCuUILj4P3JcxRqPLxOkX9Qm0XjyeHKRjTWBWQxUNjVgefX6Z
 MNAY95OIQPe2x1O2RHFeShMQPEgP0I7iRjlbhjzkSFUXg+kH7+nIieOOZ+ooTn4NyuO9
 CL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917410; x=1730522210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ICl9dgED/m16kjHsCSPmAdWqNiBPiZRJM/ggx0AVya4=;
 b=XzgtGebdEZqbuql3GLb8pacGn4NYqiqlG1gjFiE2v0U5+uJo+F5wSRDliDa1EWx9Q2
 GP3jBvDE8i5qrDs7e1hB61vCwlbGfXwKmiU45/oYgmVcFiyK0k1NJA4+ip9yqnqX4sV0
 m0bWIakPCyhUpUvO1dfqpI6V5doSE2VEIAfM9AbBN5+AGw52FrLI2zXyeHCuALQShY10
 0g2BHRghfU54BLq/LoctgfnPirfLF/y5eFuTmsvZy2asvS7tDc3/aLD4cBcmysSa8GOQ
 Zo556fXqW8ed89kjol0+JFD+LOEv9ivWocjb1POs63lUUgqCqS+1DcYIFdQuW8pfBy5f
 OU2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY/S/Xj+GX+FfaiZd2k6JFthEBJS1CFX5adua8IaQbNTI3PAOLB8E2eEYO0Gv+QcW9x3G6dVsu7RNA@nongnu.org
X-Gm-Message-State: AOJu0YyRFAtgll6j9FXHgpR57Mg5Bkj+yC+gcRqF/vljJYsHp5CzGpGG
 YflxDj9uejdngYgm+MoqOJDk/+g0t9qMWnG+zy7iHez730Yr5FEVKxMOIiE6iUQ=
X-Google-Smtp-Source: AGHT+IEcy+oxRwkEEptkJNLNAOJpYSaTSplfcqHUoCdQPufiuDiNH7cqgQVdYSWihL9xgm8ISsGiLQ==
X-Received: by 2002:a17:902:e892:b0:20b:5aff:dd50 with SMTP id
 d9443c01a7336-210c6c19c8cmr20680645ad.31.1729917409779; 
 Fri, 25 Oct 2024 21:36:49 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf46ceesm17491325ad.44.2024.10.25.21.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:36:49 -0700 (PDT)
Message-ID: <5e0d668a-13b6-4361-bf38-660b9bb7bddc@linaro.org>
Date: Sat, 26 Oct 2024 01:36:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] target/m68k: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-10-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Explicitly set the 2-NaN propagation rule on env->fp_status
> and on the temporary fp_status that we use in frem (since
> we pass that to a division operation function).
> ---
>   target/m68k/cpu.c              | 16 ++++++++++++++++
>   target/m68k/fpu_helper.c       |  1 +
>   fpu/softfloat-specialize.c.inc | 19 +------------------
>   3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


