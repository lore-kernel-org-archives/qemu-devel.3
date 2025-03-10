Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEFAC28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgyv-0006Zf-JM; Mon, 10 Mar 2025 13:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgy0-00066A-E1
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:31:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgxy-0003tK-Er
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:31:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225477548e1so37309525ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627860; x=1742232660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XIs7KFA6TjWSKY8CV2d/rKzn1ivX8oP+pzfrwN4N8VE=;
 b=ETnpEFPSi3kWbnbAKu5nsBT84e6ObqTd4jf15p5gTQCDw6AvZoHN3G9uejDSsKJILS
 tz1wFbjRrvmNZB06PpAqbIQdwx63LffhfjS2FyI0oMp163GuXnDOJc6Uix3zW3lN2cux
 /Vf08+FN0B3KY0PHW9n/125GybIZjB/7xldr5t/o0UAzV94UsZlas5AQA5OhcZPvs6uv
 p8Tw5EXNjHrjShW0zVHo8nhepiFBNnudYAdyL+LvUy35jqt1+ZVMO0oAtXcxFBG/MSHX
 z4NJEgAqDZ4FHMiTMWglCGNsX4C8/dhFYe0dtq7zizkb80BJuXbVBkDulCBf5UsrbP4U
 vFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627860; x=1742232660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XIs7KFA6TjWSKY8CV2d/rKzn1ivX8oP+pzfrwN4N8VE=;
 b=ZIm3ntHOeVQH7V0Fj1J52NZQn2hPva7No8pm01w0xLAYsNfGjf5S2MY8SSOZTOLXTr
 4gpk+rh+vMlljFhpvRECSsJxLAaSHELnKa6lROM6zUfxpZUaqM7xF6XBVYbkfnDAZQe/
 KJJeDFWB04KO5FX6QEm5wkvCeNQn/e4Lw0kX1EmJHmu7baFtOTyCuolg38+yrl1qIZl4
 tSq4EQbNEuG3YH2jm7tiP6du0aAYLIIS25xWKzxPprjc2H7oBhV84HM9fHbLVQulwSEe
 Nk5ZCmaByIJ4gSiz4PX/OfpcUqcKmvovZiJ4dZEM0gK36zKT5wLTzGnelbiAC5ESwv4q
 BW3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJUtrqk427wHnfvuLiIxA+lARCrReoneIyVqdHG8dhGELb2o/tc/MS+F+7xHTHmuXB1Uh/whK8k2lb@nongnu.org
X-Gm-Message-State: AOJu0YyzwRfsybjSHPS+yB9hWye2N3SsFzafARDccYeJUhfiio+rifYT
 birU4PacY4F6z8UxicASYDUVJVvrczl67dm0iatyEkjqvJaUvHFk8WZaCjuYK2Q=
X-Gm-Gg: ASbGncsWNi1C94T5ak2ET4pwQ0b6ZYj2xl8nbBUvHOZkMRRIOjmOjTvzPzm+YEBE3MN
 ayXC4IQUbJML/aKGJhs1d8+CTwWiG5k0oIJ4HNTBiA1MDPcA0jmnLXE2zSQYZmvEeeBMLQ2CoMz
 2koGbA3rLpyL44cQGnGIZ2EJ/29htAe0bx3tzt8CgkvzLaBmECAIMyKwjxLmV9REYzEQppfk1js
 lHTudmSwyC3V6wpzN5INVqPEsdFg4n5hHXhErfUrVBcJZbYEtAjobz9kuKs5DydUesZSNugxdSi
 7dUBZvJpLeNcUGvJfGwhFUvyWI+FW/GseGb9nm5j2KOB2tOxHML+Fc5geP/PPAPTmrc0RfMTI+p
 AaAqiGiHsBTFjRDM6mD4=
X-Google-Smtp-Source: AGHT+IGnupYoYhyP2CXIf+5VJiA0SToa+3wVWCYLzOwe/U0mtKHX19lGtzBNuAK/MhuDe6icdML52A==
X-Received: by 2002:a17:902:d509:b0:224:191d:8a87 with SMTP id
 d9443c01a7336-22428aa2f48mr233359155ad.26.1741627860641; 
 Mon, 10 Mar 2025 10:31:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa8ae4sm81115935ad.243.2025.03.10.10.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:31:00 -0700 (PDT)
Message-ID: <05eaacd8-194d-44be-a003-ab38e78d4e73@linaro.org>
Date: Mon, 10 Mar 2025 10:30:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] exec/ram_addr: call xen_hvm_modified_memory only if
 xen is enabled
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-13-pierrick.bouvier@linaro.org>
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/ram_addr.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

