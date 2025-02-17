Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59254C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw63-0003S9-KK; Mon, 17 Feb 2025 03:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw61-0003Qg-8G
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:03:17 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw5z-0007yc-Kx
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:03:16 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso60941275ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779394; x=1740384194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GCIAfPZ3Unt4TEfqCTWcPb6UFnksN8EfhCNpsQ2NzEM=;
 b=GHhBi0oevOOlaUVAugXrUAZrUIokAcDUnVyURDTcqK0Q3PywhYJI2c6QS5Q1NQwoIm
 mFOorUBcbN0jPcTK0Dp+gMGr2DzgqixKYthNUllQ7u3Y1cCF5w6Q3Vg7KeF648B+unD3
 X1kEypINCkCPZxV9EDUh/h8vMigT1+mQmZ5LVZIUYTAnyh8EC2bKyKLFOAUCaD6jMkQL
 rHbFCXydgg/I/9ZPJUqCVB2L35/lkpqTyDD2G2Bho+3Mcv1t2cKPZXUebR7bglbMMZVc
 w0ig5IMuyOUv2B7xeFH7ZrlnJjWlxvdJC/FOy3xIjDFI2fmWOxaxPON6kAZdkHDH7H5R
 7o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779394; x=1740384194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GCIAfPZ3Unt4TEfqCTWcPb6UFnksN8EfhCNpsQ2NzEM=;
 b=fTcCmQolvRSOd0/IjKvYWrVFaj8YsFpAJtK7TQmLaa5z7yCUff0VAqEeIj5ytPPkVY
 AGG56Hc3jGBZLnz3yAQotObZBTDQ9WLGXIieAM1hjU7xoRuvQnflRbF6GQWP+q25J1QU
 DYoKOhZa45vtKnKhhOayEybZ74lkL1CxPOtqdruDwJTxSScwzorngdD/sYh4E10zJxhb
 WbypFK0cLqx8lxJaC72E0kDHoggvvvifEMLOFYG57tD88168g2Owkv6757AKISoeSwSB
 rBET7z6tLbxJ6YIIziBSAEbTn+T6CwW0vplg+R66WdaZXQnRcNoOJmC6D5yvSmrQB46k
 3eMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtnHfxK2XKXHwFHifk/jh5AM3C/SjXpNw3xWgOCBtCXw1SRjesscxKHS14kOGv1/DaNx0C2LznjmTj@nongnu.org
X-Gm-Message-State: AOJu0Yzzo3Sl2TsqKmrA9Zb9r4dCKe0W3/AB+LdD8DH6g+3SGphdS+xg
 1aWIUSkCWBABNrGmlm+tpdph4MtjWo2z8cbf1Vi564/Y5Cj/TDF8G/+qf2c6jwQ=
X-Gm-Gg: ASbGncvIFjRV2KiDJ3L/M7TMRFxOlKx0bOaMon/c8ZRNBB29yz5HSeP2tRyv8DArsaQ
 E/on1sRY6YHD8+HFXrcj3Tvv+/lDFlFfdP5OLLbUi65NkIW1PqiYnFMzetYUFNO2cxyEXdl8uxG
 uGmQHv+hl5LPEgt64FB/tOg9IQ6Acgs4/jgykAetFTtKlZW8Cpdp/3YIzoyosL/t3cvw7H64LFm
 qIq5ErqXoj/URtMR5Pv/F5AYt5XY5q6VYj1vL4s6owLCl61/nAmustRy6wHipmT5ZckKBULkZQG
 hXL0UnwU84+3J9SEomFBpqdddzJA8Q==
X-Google-Smtp-Source: AGHT+IGFA0H6QUqzmxUIY/EPF51TPCkq8PCqJszN4tTae/vu+qCj4/MRTaPL95OsvRrBuntigSNceg==
X-Received: by 2002:a17:902:cf08:b0:220:fe36:650c with SMTP id
 d9443c01a7336-221047179dfmr145983535ad.23.1739779394036; 
 Mon, 17 Feb 2025 00:03:14 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220f8682181sm43189165ad.209.2025.02.17.00.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:03:13 -0800 (PST)
Message-ID: <fa7aa007-dac7-4199-b3a3-ae5e8aa8608d@linaro.org>
Date: Mon, 17 Feb 2025 09:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 068/162] tcg: Merge INDEX_op_muls2_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-69-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-69-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 17 +++++++++--------
>   tcg/tcg-op.c             |  8 ++++----
>   tcg/tcg.c                |  9 +++------
>   tcg/tci.c                |  6 ++----
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  3 +--
>   7 files changed, 21 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


