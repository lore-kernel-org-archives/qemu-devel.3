Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F135C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCw6-000767-Hu; Wed, 29 May 2024 02:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCvw-00075d-JV
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:37:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCvv-0006yM-12
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:37:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35507dfe221so1012414f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716964629; x=1717569429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eDF9S5v5WOxJpYFKnJDhl8JF6gxSaeX1TI6BBLzJs1k=;
 b=kahoyUR766/tS0SpfJKkJHbfbOSLDhD4b729R7jpB/fSgAK5WukASaX2/haBf0hWq4
 T03zO/1w4ihINY8TG7OLX53z65k/Bryvmm3Ebkgfx158f0Q8i5EdfrbrZVjLB0roGdUx
 gixgrfhNDpUyk4CMJaxpC39J25d4BgiUAr0zsrebHt44zJMspDW5qvgxfzeyLexvHWKh
 o5+pBP9DIavY60DjtwoD+sPSE2cl3EF1IDuU6GR7NsC0Od8wWHVRkGxWoa0Hwnswz8Y7
 +2HDMTieTpWIECTU3z/MvUPmRKwEMPY2VOTX7b2Q4C3tJN89lQ/wKMaH3D6ksPf0YerW
 R7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716964629; x=1717569429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eDF9S5v5WOxJpYFKnJDhl8JF6gxSaeX1TI6BBLzJs1k=;
 b=N55yEMRxAwJQcxXa/OuTIm7E/zlTXh4rOr2xpJmM4BMk0759EBRRSncezwtUJXkPk0
 bCkyRxnxFsoweqhd89jQtjCUWDz+5+Gg2GHnPvtsqQNuspXPec2sRoTU98CpexlxdpT2
 yqtyFnzhWl56NlyFNZdWmt7UMBwU4w6X1McQjZ2WXz4fXhNhi7p7BUBdi4hrfmv9MERj
 Fplm1HR5/KpBh+izD7qmgAG7NtzggtbKaCWKD5FakWXNg4DpUodZIsXb/AKKkcGAp0+c
 sXGZ9RIR/VU+ASpXNhpAI+vr/Qrsb0T1nZ7w2u+vtforSTkrdrfV8xYx34fYH9O1y48f
 7fGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWRt7nDDijCpaBQLg5coFhn+ormjxKFbRfEi2OJlGBqY3Io0x0qrsi2EPfpKHv9nAN7hFfD3oofcrvfLD2/7Pd0cOy1+U=
X-Gm-Message-State: AOJu0Yw7h36vScaIgvrJgMyO5KiB3EufBLI8LVSZNUDTGK1ETa4wY4nU
 UkLyE5VWGOgUBac3Yh5isRqcZrzXpqS6larI9f/H3REYs1YgtEFSR9F6Pk0NgZ8=
X-Google-Smtp-Source: AGHT+IG6BeSMpWInFS9sz7sjcAZBuQlRCW65z6rFp1k48oZ2mjyvXmnm6lPLSC0WGti2a9w2kpYZhg==
X-Received: by 2002:a5d:5983:0:b0:359:b737:51e4 with SMTP id
 ffacd0b85a97d-359b73753dcmr8868908f8f.2.1716964628795; 
 Tue, 28 May 2024 23:37:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-358a33e6f03sm8761320f8f.36.2024.05.28.23.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:37:08 -0700 (PDT)
Message-ID: <c22119e5-4f8e-4210-be28-bdd991da7de6@linaro.org>
Date: Wed, 29 May 2024 08:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] tcg/loongarch64: Remove temp_vec from tcg_out_vec_op
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527211912.14060-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 27/5/24 23:19, Richard Henderson wrote:
> Use TCG_VEC_TMP0 directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


