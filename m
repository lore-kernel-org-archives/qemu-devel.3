Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F97CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IIV-0005ln-9E; Fri, 10 Oct 2025 14:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IIT-0005jz-Bo
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:57 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IIP-0004bI-TC
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso2054945a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122611; x=1760727411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BoMfU3oUa0ZnimyyMbMukXFVp6pchwHXOcWZshjr5mg=;
 b=EkBnpJXjphFSaBVCdaH/73JN7Pr+lC+OQQh++aA9qPZ8c2QYaU3acxqz2oim4Tb7ye
 RHjmhWRSqgNK/crhNiI7eB3fQtqJSctfr9UZqsR4T9t8kMa+Vm8fyDyNVHWLipe37kJZ
 5UxG1Nzg0nuFuQFocw6VA7fk+ScDXbZmoPXwcUPtEvDSUBTrWQMjR1j7vWXn9c7wNxex
 xxgpyIaJidvQ+siWy60I0eRlnw4eP04Q3LrFLwSWUF0F79Mr2mIgxLofmOndIRRRFYmV
 wAwF5Y65vrYsulKSs9qxAVyzgjq11SSpyhY6+FtpACfQHKbyWQ5RLEsivkzO6fAR5DKI
 Yl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122611; x=1760727411;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BoMfU3oUa0ZnimyyMbMukXFVp6pchwHXOcWZshjr5mg=;
 b=PalVYAcNj4JjGPyrLSQ6HpArQn09e5jxfTvDqUJWfIAKGhptwr25cXyDYvPSQgZNs7
 fAfyT805Ep0Z3J790K/FU/gjOjX5pnkwG9PY9e3aeMeKGoAPqnqgC1QUUYngrFtmulM1
 LJMrwXJr8/hGUJZHixvT1f9LPTk7+Csn14HhhhpsqEy1EaH/KFqE4XA3ZiLlvDjkJzbr
 QYJ8u3H1TfFEWcht5wxUf4+DOVsZnGSW9bWSnI8XHYXb+FnoxHkI/c3i3vSPgX9BB290
 Fe1j+HlukrPvxv94TrxUESTY4eidBdczBxzqmGWwAoJ2+WQ20cvhHJjj3KLVwHxSuzDQ
 +NJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLQLXY/jdGae7kFx/ZUUpb/sGMjQgr+GoBomrK169uDjjHu2ndl9xRETnpplfEyyjU+JyEZsWx3798@nongnu.org
X-Gm-Message-State: AOJu0YxFwxCp7JzYJVr+F+gswYrR/vGzOU7rS8u9RRgMUrioKwFWr2bG
 McfMaHQwk6vkwJU6YVtExNtU/pjMXi52GgEscaXQ1HCvlNk6ki6p2D+PrJebA+B9okVQjAqkYZ5
 sGgz8qVM=
X-Gm-Gg: ASbGnctW0iYI7TAWJY8KV5FJVPgRGYqqzcE7/sE6yt5SP3rmmKFGZ7yMA+eVXduBE2a
 HwHOctY06LGsYezYf9vkiX5y4FGT6QAxsF75+b1GvwtStJb6D3bEMeHaAP2eWI4dKYzNgTAQRxP
 7bAmZ7fBmJ3BYkkZVUwXFryMHuSNesuFgUpXZ8au3G8mmglAoLDGLcLGpiJNBT5q7t72v0Y4dOT
 EDt7bRt6N09PCmFvnH0jdFiN4D3KQO8DJl3uYHPlWWh+/GYtbBL/7QKA7z+Xy0ghE3kCwMF9aN0
 WcXXvCqvJwKtOArcykv8fvgnKvRRhEfjGeFd/gExalrk9tL9en9N9NqkRzF4RlBB/CvT1CHIvQV
 uFJHNOA2TfE/KHoWMcLXbDGXG5Tct8LAmKZ7TPn7TtRLkVM272oZaJgOGEyU=
X-Google-Smtp-Source: AGHT+IGecCtZ+ncp0IysXZ8+3/nf1RhZASrYBEPSm4us+dvpXnzzL7LSs2HOygINCy+DGk5lqTVu+Q==
X-Received: by 2002:a17:902:f60c:b0:24e:593b:d107 with SMTP id
 d9443c01a7336-290273ed7aamr160500415ad.32.1760122611507; 
 Fri, 10 Oct 2025 11:56:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f09069sm63691715ad.75.2025.10.10.11.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:56:51 -0700 (PDT)
Message-ID: <317d1af2-821e-417f-898f-b29869039758@linaro.org>
Date: Fri, 10 Oct 2025 11:56:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] target/openrisc: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251010070702.51484-1-philmd@linaro.org>
 <20251010070702.51484-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010070702.51484-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 10/10/25 00:06, Philippe Mathieu-Daudé wrote:
> mo_endian() returns the target endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

