Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB68CC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2NF-0001C2-UO; Sun, 26 Jan 2025 08:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2NE-0001Bu-6e
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:08:24 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2NB-0001u7-Po
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:08:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216401de828so62496535ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896899; x=1738501699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jigXf35JFaA7z34wsGf5HL07YBXSguvYsj38StkF3q0=;
 b=naqkQLuQhKZqnKj1R98TmWZzEAgWqBGgrsU7WejePaRag9QVpS2TmEJWIDPgNbZAib
 JmxS1bSA4lig/Fys7pesum7k2/xIT13TKnyOGiolQiG97q1eAPYB6gyC9rb1nu7kpVMD
 9y68x1e725QIsi9d80iHofWTsct0jbmnkFiu6CUAwb2oYxI4hcFN+Q5zGnJqSlHeQdFR
 S26/2FqVGg/SkHEEE3LOa2tqU3tgg5mkAaobopKZrYgMUI4BdrtBVuB6xJt9rObHN8Ia
 0p4lim2AsOFWjNY7OgZi2XAusnN+QSRyp+hdyrZ+EHibXHqKFbbr6Lm7qFFzL/Rkj9sR
 BkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896899; x=1738501699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jigXf35JFaA7z34wsGf5HL07YBXSguvYsj38StkF3q0=;
 b=QqyFj/K5OGoBSbJCfTE+ri03oiuQa/LlD2miTvi7VeQ2aNE11DXqPW0M5gv2uFcsba
 kijKbnE/5mw1tEiOC04OT5vmFPtAOmXMgjvYS5V0GwIvqJDYjY0HaF8aqsY4W/p1HFnH
 ndj5tBn+y7YW++dtoZ6SdzHDkD4zWfk9lzaJt7c3qDlUZQccSymtCYaShqV1S42h0Uvt
 7q1enyAh/MYZj3W7qksV0Byl/1nDt1vQ1H5hueZ0OjkxL9edOsgKusqGN0dgJFN3u10N
 WrcTYTYUkiGMFXyZkHiwHSx4rEbCguACXaf+y3jTyneEBEeVb25p4cuAcPcGuzj2tEH9
 rKTw==
X-Gm-Message-State: AOJu0YwXsNe6fzSakkuZytDp/Y7bZPaROL6zR4R/2F+ChIM5iHUX//zO
 znd/UMDsTSDpzvxYLNrLQKV826yY6sJyAKSgn4HPtBuG3PdcjILbrXVMC7FNKW4y4kXiU4qt4Yc
 F
X-Gm-Gg: ASbGncuXYJAylBjyl1LitMxvZRpNsge/T7wqTL0YpI00TOD/gRYVUIskJhWo26IpSdl
 OI+6FJMBS+wwCmbpxN3hxuIlx0mJV+uEMxD0FPImkb7fmLv4W4Q6HAmrflHpuYPrl9LeTr4DTIM
 2bSY9mR83MQ0ftC1OrE+6J8ZqzRGhPKR/G/fr64mDG6gwEfLnTMZ6GgfzegS0PzdKwU3ypaKKDm
 qMjJQw0ojeYKUN4nYYNdx8y3t/OXNmzAfcU2NA7iA/nQUKFmzwzo9jKmX3ihWUnBdhgHycMY9G2
 1U/4C09J+SpoApJPrEwLuq8=
X-Google-Smtp-Source: AGHT+IGASYfGDA7wh9ALEpQUPKpgCzjljnot3mXiToeo4onB+IYdlGt7zWk0a62qpfV0L30fG6AXwA==
X-Received: by 2002:a17:902:d2d2:b0:216:2e6d:baac with SMTP id
 d9443c01a7336-21c3554b4d7mr612724015ad.29.1737896898958; 
 Sun, 26 Jan 2025 05:08:18 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4176sm45328145ad.75.2025.01.26.05.08.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:08:18 -0800 (PST)
Message-ID: <fafa6758-8ee3-4e35-b450-ddd2951743c8@linaro.org>
Date: Sun, 26 Jan 2025 05:08:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 58/76] target/arm: Handle FPCR.AH in negation steps in
 FCADD
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-59-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-59-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> The negation steps in FCADD must honour FPCR.AH's "don't change the
> sign of a NaN" semantics.  Implement this by encoding FPCR.AH into
> the SIMD data field passed to the helper and using that to decide
> whether to negate the values.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 10 +++++++--
>   target/arm/tcg/vec_helper.c    | 39 ++++++++++++++++++++++++++++------
>   2 files changed, 41 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

