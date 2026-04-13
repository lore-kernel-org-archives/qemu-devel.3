Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D96F531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQx5-0001QY-Ud; Mon, 13 Apr 2026 19:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQx5-0001Oh-08
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:44:23 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQx3-00012y-Jt
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:44:22 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so4547684b3a.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776123860; x=1776728660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9sjwD/glpvht4+I5+AIsMW/+qYwfYV+ASiN1Cj61TJ0=;
 b=p09SM2AFOplWg0wpLVgje4RqNtlCtD3YsKzpjTJNHWfYoO/3WCRr+jh8JCOTkqHZxZ
 Qq16wvJDqG1hHPE76GqT8iKwP4I2hn9TglvzimmDPoHgCkDDk7oJKX9sdxj7u9B5iBfE
 5sgXZ6JgiO9gb0Pdp9+TSLzxhTJXF95GjvmkQ5Ztb+WKD30PcQzu/ce40LzaDLjrsEBO
 cbqiYJA1frjvuNp0CtfNBbZ7lJbPP+Y9vZD9b6jQITYMkXYCwPaeYc5iitj6XcnEERC9
 2hq72GWngsprSkR9Nh4Hf2CHve9KbEWKq18qRNTf2sCkRWQKzbi0lgs1R6A3V4FC2wdU
 Ir0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123860; x=1776728660;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9sjwD/glpvht4+I5+AIsMW/+qYwfYV+ASiN1Cj61TJ0=;
 b=gfkCF+O8XgFcnjwLjlFhK7Smvg8QX0CKl5bJbGn7ybTBchUF233ZpIjLl88FgwSdAU
 uzpBGim7JgQZR1oIxc9XY7XFrDFfXi/e2acLvOaMx7QKwtey4r8B3WiJhh5y1jhln5lS
 G9yM/2DTfa4XXITsazlkYvQzTPwMGI2sWR7uvFAxGswsT6uLvSBbsowbwGi8Ck3JVXBd
 nh9rDe9EagWOeFpvfT5TrQMq9ERYQ08vI/fRAVFzsW+tRmq3z0P4ufmdFpxe5v4INrm1
 qqHlV4Oyl6hmLve0Prpe2NdmG6HMLq5KGmhXc6kVMXCH3Cpkvq82d5wk3gkkWpmOKARV
 oqOQ==
X-Gm-Message-State: AOJu0YyEpJ8ZJUtvVzVWAw+iWDl7+cidtJdUlDKoKGaWwBV4Pmyevai7
 powSW16J53UJLGfCGBOIDkPSRAvryuYNkFUUQUq+s4FtD9RHHeZC23wKY3z5Gdg0pNRz7sDsiT2
 r6hWX
X-Gm-Gg: AeBDievDZ2whTX+WTHx5gKhs3FH83i0OC8KFhOEo88Dgv8pEViskWAvCccBRdxxuSc3
 wp6ZCgH8FSAIOomlfu/Dd92LRUPSjiknFLbYLHyCS1bjszjc70GS9jYbUTuYPbjyovyxk6bOfzo
 1O4LudsK5j4Zbiji6ShJVL+Rb0i7woQdtDysCKiBXnoHUYPEGqY99JgFd8NOxVxGXSHjz+p6zuu
 rLwX7XhcUk6p4PuMfXvpel9ogxBR1Ni3FvBb39R/Mmt5PrMeMeafZUKgXnD9I1NsqleveTI39Vo
 +hajOnkLG5Fh7VFaRzQfIcdFvGTnyWt3jZoUp3lE9mniyl4kU2nb7snUexujfXcmomQC84oY/bj
 tAoKc8iU4KZLE1wgTpMMcUFRNJ4W9zcXx6avHu1SacKsvFuhXZLyeHzmPCuYXIdZq0zgoIUhxiV
 GgWHq4G7QFCA4sj6uEN9oVrHTAhgkJvJlwf/ZA3yZv9Na6mQfUxLQ8ePMcGiGhhLMLHcrwuw18j
 WIYweVqAd2vk+xxyKf0s8Bv
X-Received: by 2002:a05:6a00:92aa:b0:82f:4a4d:377e with SMTP id
 d2e1a72fcca58-82f4a4d8eb6mr3375059b3a.28.1776123859961; 
 Mon, 13 Apr 2026 16:44:19 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c506150sm12252376b3a.52.2026.04.13.16.44.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:44:19 -0700 (PDT)
Message-ID: <ac6e59e3-7415-4966-b7a5-ca81a1e2f721@linaro.org>
Date: Tue, 14 Apr 2026 09:44:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/arm: Conceal MO_TE within MVE DO_VSTR() macro
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/mve_helper.c | 43 +++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

