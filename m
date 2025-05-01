Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A8CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWO1-0003Q6-E0; Thu, 01 May 2025 12:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWMG-0002HQ-1I
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:01:59 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWMC-0004QO-Ac
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:01:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224341bbc1dso14813285ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115310; x=1746720110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lk3AP9HXH+ZScFGI4y047RGazE9Zj4ino/4nvnUWdSc=;
 b=bDYUjO8cByPy9VjbMeT1du+9ymCcb4hQ2Dsr/bIkIAlvONLfuLC9wUpk+fZiDnEmtv
 vmq+wvymODTT34vi5OJCuiZstWoUkaFZhMygjGXXzOFOHaVI5XKi6YdFvo3tBr8NhuG8
 c1tQ24k/3qB4QLg6gLIXWDlvgf1CuQ66qZhhNLNSWKnf9FxOPVGjs0MAaABFmTKLrW6b
 kjUyaneSN4LJZNgKFyxtAxarjgsHlL0J6bYS/TQzCdzLD8LBQNgRB369UYZu5Pa02CYW
 tY2Kzj3pbUiC0ErtGWFNF024n3pNzUMfXRKoWLA/W/Uo5tfg9WvYqIOgHls/DIP5OsEv
 M5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115310; x=1746720110;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lk3AP9HXH+ZScFGI4y047RGazE9Zj4ino/4nvnUWdSc=;
 b=h5VB+KzMXA1qxJC1I7BepFOo2N5jORFACgyDS7aSHhbM8LzweDbE+QE6AnqmHl27x9
 0EuBpgUvz6tXI1/HTM29zzVQeY29QBZc+nlvyvqe/GZVRhoOW9V7FyQcIIi4mGyNb6DS
 SbTETFGua0Lur8yoorkFCx8q1F5H6zjS56r74lrD7dEN+foAisrDRYsh5NZTl8yuvC0O
 xnlvpZyk6Ux/oeE9A5Yvxqt181TAf5Owazv9TCyU6zFMegI0nQrdz95B8jj6BExSmsEp
 yIu3aU5I0JzY0qLjAiGiyrFlZhrgnTKNWleL0iRiLX1VbqLKfKPnfvTMGWS5JONlIC/U
 mkkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjabr0J97LmR4tfKUBaFHUBJGGyzmU5OilQHzcXWfqjgKvcThINxLyA9FfazEOR7A4fantrRYw1GWp@nongnu.org
X-Gm-Message-State: AOJu0YyAoGsrpBxJzaE51lH1twB6KozWQZMb85ZKJ7A0HYzSylhruFzk
 WJ7hMYQYm0rM/IVM4ZQmTmsvIWk9mGaLIV/bY1sOY8jXnQqGzbk9RNsk0yY7tac=
X-Gm-Gg: ASbGncv1qEfrwxr29D9qRhSpGEtOyaxWy6T/ov1mRZQuy7NLwC8zYzoByzWTWfddE/G
 0Mlsgu/oyjob5RTkMXrguMMIzpqxfhR2m00slz9qTmAIEW0cXnDAcdDNZRBu+Itk9q0VBDTCfn+
 ndK6Cxl0OMXoOBm4tfppHU1u4zfuXXg4Mez61Lo5+5z1kBQV2hP4bfGRDf4mMVZfqf+JMaC/6fT
 CI7ibbZ2CTUpOVH/+3NcwITqMHYtTZQong27n4TuYfxGXSLFeF2INH/QY1PM1AShtwiZuzy+dlG
 SviGlxQRPRLQaO8js/2mD9vVnfToAf6t1ypic9oC74MmjUCs1FU4Zg==
X-Google-Smtp-Source: AGHT+IESeCw/ot8K4/fyy1YMFrQh014wqpXqwGhuOka7JcPJtT8VhLcZr8waT1JTbrTY+rw3xUpZ6g==
X-Received: by 2002:a17:902:ce91:b0:22c:33e4:fa5a with SMTP id
 d9443c01a7336-22df34aa1fbmr108623755ad.9.1746115309736; 
 Thu, 01 May 2025 09:01:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0d5eesm8492085ad.60.2025.05.01.09.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:01:49 -0700 (PDT)
Message-ID: <21c3303e-18ea-4031-9ad4-611549dd6821@linaro.org>
Date: Thu, 1 May 2025 09:01:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] accel/tcg: Build cputlb.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c    | 3 ++-
>   accel/tcg/meson.build | 5 +----
>   2 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


