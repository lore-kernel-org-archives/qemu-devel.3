Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20C7CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISzj-0003AO-Ah; Mon, 10 Nov 2025 09:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vISxx-0000v2-8M
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:33:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vISxv-0004h6-QS
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:33:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4710a1f9e4cso23822265e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762785234; x=1763390034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5/GbErjhRjborKLVc9S6meDdm/ABVRbruOMeCPQTZrY=;
 b=Jwvjf0kSG6D8YuMIjtzqD47p+P5wTx2G+Ddxm6VIBBOrx7z+58ClzQ3aoVuGlg60LR
 kQ4A7d2ylhuHJoT2hD656kIPscHPzGfycZT4dLvH0da+7N/9QUFIQBwmCaOeS4dPVB+3
 okYBSricZYFUGZfafikVaVAk8fx4Hx+dCJXTloGPieNaU4phTND9r5xGJWnfdIwmBrPP
 ITWMQrK9plCLfVB971Lfzv3x4y4BpbK7kO5+yH0oRYeSXzYGu4IszBsNFM5eUJMaiiRJ
 JGbCuyXEvCVkviZEBhFRx+1NDlA4f9yqr8X3p1xA2Bw2kHrzlCsHm9GBteN59KS2YpMK
 MGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762785234; x=1763390034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5/GbErjhRjborKLVc9S6meDdm/ABVRbruOMeCPQTZrY=;
 b=ZG7tvrUzp2i8OmHeEd7Q3c1guA84Z1mL9Yzi1m3WB+KiU6HF0AsfDEWoh+9On9bOyA
 fYhvCVvqo6X+T2RFSB1b3AH6HWaI3GcMTqhQy1C9SaO4CMW6FGV3bR3uuC4ThcToAVmM
 x9egfBSewXYTwfrTLNfha2828eKZFarE085v4NrMMyuXCJqagQ0TC/BBVdohQKdSbAf2
 d4j0EQR/yjXJqFIXFpszKRa6DYJbuerYP/ID2mwrpQCNhG6A8WWYtKRQvEazjA+67YHI
 THW7Yp4/agqcxo0qyb18a46gTCaqz0wLZIbuDoIbgQGwnGEUQh7jkqZMI1M/NwFrAJpd
 bY1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX01gnea9Pt2QfuDz5Z9kifUeIHOn2adiyhRKckVWxswgBE9N+JLn+1rgvDeROSb7uIDMgBeBJhggJ6@nongnu.org
X-Gm-Message-State: AOJu0YzL2zOhW+y8K75C9wbvbhOFs3PXhG5/jSUoBsvqDhRDczsSFXC5
 RINIx59fw6OHwVN4akltpTi9BXS9oPycV+XZngN9q8l0fEQ7V0HnzriG/FIMQgPkCLM=
X-Gm-Gg: ASbGncvHVyBFNtlwNYQOlgmvJBemZzsMFxNx4EwCKTK58GjnQQx0ejQSg4FtCXKnbDA
 pnSWmKPnsJsir0gwlU70AcbLkoSd4P3+vVtqMA7a3P5N22XEwkSBLT4QeJx8N9NuJcO7pffSEC2
 KyQ28ThrgTzo27l6Eul9zuU6GwVYgYwiWgZ1662j9qj43Mhaz/QK3+LBl095M5dnKpcXFqdMme8
 avJ6fVEzfWgNAC5f0XSCNSIbIumWAE0ftbA562Gjic+tQOmoM71fSnVVQrDyPpHObqCE+vqIzFZ
 IhxnQsWkzpcb8bvG/ccJ0czzW9Kx/CtgDFvq6SjQXlFMcK93xAe9dLV8051twZTIK9xcsQ9TrN5
 mVxvadiBAaPKLmjRoQjsybB8rWXDLEP5ByNRPwNXbXsnLr6JZZQP6j8NLmmzdJO1LOcogmLtCfi
 bxw7sF95VRMTv1iFAtEBVPc0omU0KDuCopddQAGsJauJZnAFsUkoFke03hhANTpn4T4Q==
X-Google-Smtp-Source: AGHT+IHV6KWDPoxnCmzbMwV2+lYm4MwzFS911P3qixj61C487rnkOvvp7pkMajMXPUAqtTDm9nn/cg==
X-Received: by 2002:a05:600c:46ce:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-47773288fc2mr75395415e9.36.1762785234095; 
 Mon, 10 Nov 2025 06:33:54 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4777bbb8c59sm28307615e9.17.2025.11.10.06.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:33:53 -0800 (PST)
Message-ID: <5ee843de-2267-4465-93f2-4da27115dfc0@linaro.org>
Date: Mon, 10 Nov 2025 15:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/m68k/test_nextcube: Fix issues reported
 by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251110104837.52077-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110104837.52077-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 10/11/25 11:48, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Fix the indentation in one line, and while we're at it, use an f-string
> instead of old-school formatting in another spot.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/m68k/test_nextcube.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


