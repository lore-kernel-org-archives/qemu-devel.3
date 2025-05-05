Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F46C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0MH-0003mS-4a; Mon, 05 May 2025 14:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0Lq-0003bq-6K
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:15:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0Lo-0003Zl-EE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:15:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227d6b530d8so44344155ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746468935; x=1747073735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kd6gV1USLNd4p4PNo72gWbrU36bQLzdDoB4a27U1rFM=;
 b=u7Msr/YUD7xvIewrqK/fVohOuBeucZNL8tiOr4TdSXLlBiIgsgyJKNqj6UOnvsSoK8
 9dctatkd4CNR9r1PubbIULTCV9DmWIaIl9mUtoqIDyeEJVde+WFJTcJx1qF9JI0H1tc9
 O+QMM+a07R7mLu1nVmxi04YtHX7EVbvHp83A4Te15T4k7FtrhvrQX4+vT4SuUr+l14cD
 9nnggRFKpTebCIeLYasQkECUnO/2Dr0o+JuT5P9kZrqih1WpPaPTODnI44xV0ed8X6Uz
 p5RpSn5tzS12KTJt2b89/4PtdYnIeeiaJ4jqU8KbUaxNV8s/rSnebiT4p1bruwr6KOTN
 sfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746468935; x=1747073735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kd6gV1USLNd4p4PNo72gWbrU36bQLzdDoB4a27U1rFM=;
 b=GmcGLf1VjvbYdX/i9+NNfL+HaufsoaX8/Tfp9QLv5R0VWIc5C4u9UeXxKaPFJd0e9s
 +VXBsIVHrzuNfjFz/uzZTUWpkwAwmbUlFkMNl5DUUOdRwHTWvUVWZhg2tey1/95WxFAf
 6/IzuKQQTvj21hdra0O45+4fBRqH93tFKG2gJOyinXzvdiq/BnB9h7CbDA9aeZmBy3gN
 K3TWRCPRVOW2hyCeOEwu77hSOnBrFQ/wQPqXHVPN0r+r3Wt6crFBp7qy5zzi2EPfuAFx
 efkczQWdx/8O5mbbU202kVJ1t1F7BbzPHUWcM6mF7e4SmF+iWsOWpZt5mio8Ryk7TMqD
 72WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo04SHLN1BbwiAz64KLq0BYyK7hnAHa4SebOtYlF80BmOM99ikThXJoSgf8JNBXbgXukPEDiNgT83J@nongnu.org
X-Gm-Message-State: AOJu0Yw823g/2wMLCgNyBzZNjDfjbuxDZc9UZ7y1brlo6d1OJ+gKpWpW
 mDpmClsKAfUFCbh5o/oGo2R0Td0JGVQ5sFzm75EVA02QeCCigAXkEhIyYM5rkW0eT9SaRp6f5N4
 I
X-Gm-Gg: ASbGncuk3jEFd9k42Z8lLGe5xKJUGgel8lE8QpmPYPF87ji9WIqL6Ohr7t1UfTWFdAa
 SFOoY3dnQrWTQCWGhl1l3UqI13qr30HBEEzL/DJxAsPhEAEd3syD4rm2q6oPFr5+C5qAgXGvM65
 z2Jy53NOfl/9DXPjnLN6AZAUlfsL/YOTjhcQeu6BkeEHiX311yLLputGtycVI9cIbhlDO2SdQH2
 Nl7EsQqVHAA+n+w5lq6Ahr/FmELEzjvUEK8T0+vVycGMI0+AqLYahCmQ2HiradFVFEv2x9QZF7w
 tXaseUW7mIVL136soGW3f0JJI0yWkxSZxCs7+lArRqrtSiAbaS8Q8JkMbDlFreoDPOSHFm9axQR
 hGbYlI/E=
X-Google-Smtp-Source: AGHT+IF+qPu0gNAX9hw7En2FMcjF10KlwzTyrbe0+ojnqQ3d4oNSY3U0Ki9IYrYge5zoB6d1Kdp4xg==
X-Received: by 2002:a17:902:e84b:b0:224:18b0:86a0 with SMTP id
 d9443c01a7336-22e10355d3amr212805815ad.37.1746468934882; 
 Mon, 05 May 2025 11:15:34 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eae07sm58227335ad.8.2025.05.05.11.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:15:34 -0700 (PDT)
Message-ID: <87cb4a90-25d4-40c5-b8ae-ca8cf9080d5e@linaro.org>
Date: Mon, 5 May 2025 11:15:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/48] tcg: add vaddr type for helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-15-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/4/25 18:51, Pierrick Bouvier wrote:
> Defined as an alias of i32/i64 depending on host pointer size.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-common.h    |  1 +
>   include/tcg/tcg.h              | 14 ++++++++++++++
>   include/exec/helper-head.h.inc | 11 +++++++++++
>   tcg/tcg.c                      |  5 +++++
>   4 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

