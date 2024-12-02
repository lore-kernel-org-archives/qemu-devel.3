Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650CCD78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAC9-0001z8-JW; Mon, 02 Dec 2024 12:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAC7-0001yu-Iu
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:26:47 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAC6-0000ds-3I
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:26:47 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-29e2e768952so2213385fac.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160404; x=1733765204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NhtAmMZPb6fsvWyz44ePBY0DSfu1+GfytEbCgHJN874=;
 b=XpU3/iSfAh/0dhlBK849w+2+YnBbLW2mnKZD0Z/WSbNG1lHRRMF02+ol9ZH1sc/bCC
 4jUT21uJsbURi3zhW+gz4Y3Bz3ejc/D9ahu5V7ukkOCEc26qv6kWiWgcShJa20L1c/Xd
 jfwrlAtb4j6Pjn6Q9d84CUlZOjYlAYhYGBsEIuQt6UzbMmA7WkFgNDv5N/HF73rQPPxK
 tQi8oAEhw+SluUr6bjTgUb0qv2qRMp36Gb41/5X2dhbpML3YftN1+8pPp25qUb2JLyw9
 Ety1NqeFy83xHy2IIW9UH/L1yhf+SkHSSP+MEwq4mGOZvRLTecmqhZ/+ijQQTdBac9l8
 FO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160404; x=1733765204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NhtAmMZPb6fsvWyz44ePBY0DSfu1+GfytEbCgHJN874=;
 b=UzArnm/KXak9os9vETkXvMVCwD3k30HyUmVEeF2xAl7fsbqdzx9Av+5wLTpclWNcgY
 PIlG4WFmsof+T/NwNQOLFdy8e0/IzHb1+fNopMREdgSeeD2b8dRCl50Hd4oNjAhPjgQ2
 83rsEcOTqDZLgHkaB4hGyRRwlb4rl1UfHppzu/bheXjWmtumFwOwnZYkR9GEPz3Ex1mw
 xh5OchaLtPSz0HAGXemWcJ0mNVQKvGv1B24k9CVYCymDNDJLtv7Itk9XEB1LkWgJ/7hK
 WVF2fWtbZZ1JmOHag/o1HuY96pgfS1B6md4ksF9OZVnr7Nj+zFANACA0pSj97muFQRGF
 w9Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs3cHabquYLESdjIzRM45+X6Ctrr2iY2rS4XgPFWHwGtohW4I3pFI00sXpOvqBIncJpGDlYL+vt9/V@nongnu.org
X-Gm-Message-State: AOJu0YwYMeKIw9RS5rzNkzDdETZefgpjCt+uhZfVPrdmV5KMZFA3Ry9r
 z6u+dmZ0RnqyK6y+yDMtucXlWSf1J3rWkBWLutRblCXKwApzSOpN8eJ3YN/eG2Y=
X-Gm-Gg: ASbGncvCPcs2N2q7V0m8r8ZBv53dcluOScmugLwQk5XxmY4YFBqpV2s0XLRayWxrkBF
 OvLsWav6wQZ5X9SDG9zZODtuKC5b8iOTy2U4WdE39c1OOtWp8mf5mFSj/eDBhQmfC5VN7DADGwp
 X9v2CAhPCSsQFlp5h3+E2emUa5CV2gil55lXeJCkhvnhefkpo0x0HmJhP09FyPvfpp/DwbTjpvT
 Tzz8ERmjnx11hkLpR4gP6AytFgihKCp51eSOt0veaMpRotzA5P65RmZUrLIwfTEYlS6S1I=
X-Google-Smtp-Source: AGHT+IGnjoYnF2S74FPPwIkh+wZX8YP1bJ02vdHuVIvqp9z/Gb0iu5ioJJinthCSmXGsnL4ihocpxA==
X-Received: by 2002:a05:6870:e30f:b0:29e:4623:e0a with SMTP id
 586e51a60fabf-29e46239c27mr6631246fac.24.1733160404624; 
 Mon, 02 Dec 2024 09:26:44 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e58833001sm1059787fac.46.2024.12.02.09.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:26:44 -0800 (PST)
Message-ID: <ab23dcaa-9499-403d-9439-625281f2189e@linaro.org>
Date: Mon, 2 Dec 2024 11:26:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 35/54] tests/fp: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-36-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-36-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for the tests/fp code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/fp/fp-bench.c     | 1 +
>   tests/fp/fp-test-log2.c | 1 +
>   tests/fp/fp-test.c      | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

