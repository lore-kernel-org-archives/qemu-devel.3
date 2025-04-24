Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ADAC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qbj-0000MS-4v; Thu, 24 Apr 2025 03:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qbg-0000Lr-TE
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:02:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qbe-0001hM-OV
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:02:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39efc1365e4so270917f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745478165; x=1746082965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SG+Bdufp5AiR2jfPxSq39t2skDQV2qFa8gS/cj3aGGE=;
 b=ThgIJr8qoof1NeiE9CwV2DzsDYJUGeTB4ZiXeiqwci/UaAOo5OAyRxikN/W5MlYmAA
 RLvO8kpUvakntGB2SN0DcOQotPgBnvRlZjFF7v4WQ/HO39C/6qiT41zpMk6k0LHjXxTb
 CpD0RlJOiu7WilWdW1Ct8GHgWYfU4gs6UAt1tOp+22MugBMgZoqwFlDbRUyJ+3DIvFBO
 DFmv1vSHmg8rJ6GyuVOlC3IdtD2748OqnoTagnMVros15qq0wvC1PR3ul62A52dx2mFd
 Xe1IrCnquZdBk3JuD3/fe9Y7N8S0aoli0/mN2V2CJQZLHujARJu7AJ2sMvxAUuLqH4lj
 CFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745478165; x=1746082965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SG+Bdufp5AiR2jfPxSq39t2skDQV2qFa8gS/cj3aGGE=;
 b=kinNrhnRMvpMZKWt7HTzpUrmkN5I8Ji0yikQlVnOhHL3MTGTn2adfC3MVk9Zn5nJD6
 eOcKoRrqS7zsMTcdBqaCBVhZkRzCCJJADW/56zz3+dFKkLOBHomvUv62NpBUhV0faxSu
 S8fs7lpeHVrvScORu2lSiZHh9mp5MgyYO1taBkMqFdESenaBepNu+QTPWMMyxTwW9Na6
 86xoZr+h8ghLD6pLuJK1q0wdI4aqMAHK7vP6vNUEE86y++GlLPR+ryvP6DNj8MTe06md
 g88pag9CEXo6+bCmevG16xxCK73a2M5R2wKRiAspVIJ5nHohms5nKVs71R6Hr/C6XdNJ
 enSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb/LQPXPAEGljYcyvadCeuu0j8zxQoDHgA+VOm+5O2pZQ+y0kkjOtPekArbzW41I6RcmdgZJj69RBb@nongnu.org
X-Gm-Message-State: AOJu0Yy1Z0NOHOw1bt4o7wLwSlL/WdcaFdfJXs6r621xiSOJUnejxdCe
 K2ZEPPLdS23spaEQi/cg9J2QuEaSMyioy4sTyn0ciiW+XSMZ2RWWxW4l0H+Qeurm9YUtMVCnm5U
 8
X-Gm-Gg: ASbGncslO3EbyBF6NPINqwNJ6vkMYrl5P9jss8SUOW27H6WvnwgiLuWxSTeDEVPZW2/
 H5wdTgBAWslPt23KI6tVXKBx01qPw3uC7ntgwVniRP79LZBmRtDA8tAKMgUlHc3nAwm0Pb6g0q6
 5DkVUZeSJ0ZmY0C2xEe+jn8Brtnfh79cRiMvkAyf2wMvlxe5rVbmxExVukU2IKdNo7Ohdy7/QIA
 V1MA0T3Xvibv7c5GhejxQ/9Efh3rpRsGexeME7TE8MP8N/y49VCmnpSCTs5MunyEh+kOD95SBAw
 I4TvnKDjrwE2NSmqiqxpmD8jkqr9LzlpeHsVZluFBaUEmN3fPjJxOifFyKf+rByjRwwyaHld9xp
 VUXEmaZ2pwVdW7aNE6zFdN4BD
X-Google-Smtp-Source: AGHT+IEq0U0AT247DcIvQX7EtJSkG6kK5//KBbKJxoHx92SqvJ6DfZJusC5xLW+HMhmE+28mj2rVNg==
X-Received: by 2002:a05:6000:43c5:20b0:391:3157:7717 with SMTP id
 ffacd0b85a97d-3a06cf68953mr623107f8f.34.1745478165218; 
 Thu, 24 Apr 2025 00:02:45 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a8144sm1084083f8f.19.2025.04.24.00.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:02:44 -0700 (PDT)
Message-ID: <40d00542-f5ac-4bf4-b18c-a3173698f64f@linaro.org>
Date: Thu, 24 Apr 2025 09:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] accel/tcg: Merge internal-target.h into
 internal-common.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> There's nothing left in internal-target.h that is
> target specific.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 29 +++++++++++++++++++++++
>   accel/tcg/internal-target.h | 46 -------------------------------------
>   accel/tcg/cpu-exec.c        |  1 -
>   accel/tcg/cputlb.c          |  1 -
>   accel/tcg/tb-maint.c        |  1 -
>   accel/tcg/translate-all.c   |  1 -
>   accel/tcg/user-exec.c       |  1 -
>   7 files changed, 29 insertions(+), 51 deletions(-)
>   delete mode 100644 accel/tcg/internal-target.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


