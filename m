Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7058CCCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 16:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAWYQ-0000S3-Qt; Sun, 19 Oct 2025 12:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAWYP-0000Rg-Co
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 12:46:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAWYN-00052f-N6
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 12:46:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-427084a641aso1480172f8f.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760892402; x=1761497202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N6PM1jSJ2a7/luZYqWNQW8W98rhy0g7OFbIYpnBSE0c=;
 b=cdKfmeJh8krGGRmsz68ch8egSW4HwSIr9+SDurGEFOUxtaEINw7Dpjzsl2lQKsLeBO
 rC+bCp7/G2azDWJIyGfOZ1xfqDLA0+QaNqJIzyBqtMaTt6sXCK5aSaa5/mKi0unaxd+K
 mtrNWDzUAGS3IOtRLQthdFV9ID0hkpNywM32+YSlPProiGRWEd6/d+M/xlLgerdnd1Ld
 L23ORr3jODNKfxMm4gCI8eTpDtIea3888c5X9VpRZuX+M9T92KMjAGkwEmhSvslQRO7P
 vlLPKdlAKXk/Crw9Q1p4xIk3ehrDUxuHi3wFrCBwAoTEOADiJ7GMy+RyjK3ihELiQ8WR
 +dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760892402; x=1761497202;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N6PM1jSJ2a7/luZYqWNQW8W98rhy0g7OFbIYpnBSE0c=;
 b=HfEdqmzWe+BNyu7zH6y+k/XnMHFxJvGSTgcnhBg7VahX9gUKuqOybNqcvBBVlkwDSF
 ytMaJTx6UegdAeCq/ejMpWmCgEYu0/8eUbrKkTwVjQCwO6JPGWBb6ecYUqmxNgGa1+he
 7etep13UpE13tCM8StLFXIipbe0TMVv+tdg9LDAYptbd8y4riKqvR++nX1Uqexefb61I
 PmbzBHBNmv9SpWw+VU+6UkLK6SlRm7dd//BKuJ6bZ26LCpN9OYKUFTmaRcAr3tESdft+
 gtq2Xv0DQ+2L//eIARMonZmLR5w0TcSA9n1bP3YXtr5XTXXoWFQukfNuGgJrNdSf1+Dy
 oKow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfjiubeTO0EXrt/mblruGnFIXEaiyGxI27aqOfkSnFtv17sJj5c+j/z3VPXUcKAQ0pLEWH/E4GMzjc@nongnu.org
X-Gm-Message-State: AOJu0Yw/KF7cq/KOPE/PWAeAdwxBpxuDQ2EMgyGr/vxtLSiuWk5Uw+oU
 mSF6vtYGDJY4+X7lGn45iuO1rmfab6DEh4PsQ9v7vJRAF9NW3lbXLv+5E3wUFA+s5NY=
X-Gm-Gg: ASbGncveB8rnAY4W5ZlAYwDKiYaM39b587xshTH9uXOXvOhGOPBMWYGRIxQsdRyopEI
 U74W79v0KhXWTtkH1ik7aZcY4yo2nbcCTfGaicjDOibcFqEGIXa/JSigh8ONSLF1AYvAGIFS3Zj
 M3DXpJj5y9I3qcaoS32d3jLG0J+pD1xZ/Lp07YPrGae4mjoywIte4XxG3dsI3sUa86HSWAt4VJr
 /y1K43oRuB9j0j9g/Dr1eqgLibw8XlOZUWCQpHvbQzEryAlgyZyNohZqrjrx5UnWpp734QLKZ6f
 qEsxuWciUXIv6RHWDv6yH+BWBGA/3CKcEjil+M9plS19S6Y/r8f9UK39/LKm4EX59RJRVVhvNJG
 C3NF97E7Hxcz7l6eV6916oFtMPK+pj0s4AW3iuhEq3p3wSoj4pqDKRMvON2D4GdYzDjp9XQ+nTg
 rzdQneAB0KONdo9OKDdIkm1DAVgYL3BU8L7gtU+TN5k2mZfCshZ77Umw==
X-Google-Smtp-Source: AGHT+IFfkb06W6pI5KGDwH+pqHLuOT5DxXZIfp400rmUqb5fsMl/FZ5ve85U7nLQMGDW41ejthbnrg==
X-Received: by 2002:a05:6000:22c6:b0:3ec:1b42:1f8d with SMTP id
 ffacd0b85a97d-42704d4421bmr6849435f8f.10.1760892402196; 
 Sun, 19 Oct 2025 09:46:42 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a797sm11064639f8f.27.2025.10.19.09.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 09:46:41 -0700 (PDT)
Message-ID: <d696326e-b181-47ac-bd6e-0592604162fa@linaro.org>
Date: Sun, 19 Oct 2025 18:46:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] tcg/ppc: Remove dead cases from tcg_target_op_def
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251017163206.344542-1-richard.henderson@linaro.org>
 <20251017163206.344542-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017163206.344542-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 17/10/25 18:32, Richard Henderson wrote:
> Missed some lines when converting to TCGOutOpQemuLdSt*.
> 
> Fixes: 86fe5c2597c ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


