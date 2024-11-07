Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAFCD5AE79
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zFp-0007ma-0M; Thu, 07 Nov 2024 04:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zFn-0007mQ-OT
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:56:39 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zFm-0005Cr-9c
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:56:39 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so95732466b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973396; x=1731578196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CfCAd+iwtgBRaN6ohgq5pV7COYTKQIYHr9TLd+oPSh8=;
 b=EXfV8OEfdbaSHzKDnnl4zQRXnnSyOCgLf58Awel4lKepOT+AWsVo5EDdx2+uu8epId
 2Toy4Mti3HAnibR88uH6Ni8gV1BZcByWc416D7qT9jrrzqHMuqZdciRI2PO+DVha0Vty
 fh8uXhA3sXx4c5v99FsS75HG+hOIac2VIHTfaeSvW8AZzwjluIHkdcT6jfOvahhJqly7
 MPb2wG9Cl0mHxbq34oVMnR8slNilNCT7guNBbK0ef6lDnqBtHh6iMq9lrFjrgBw4DGeJ
 U6C/Zs/V8okiuUYcywfp8+UCIqLNqZuZwvye51Vbx012gh15Jpt4XomzJ7UJD12XsH5o
 0TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973396; x=1731578196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CfCAd+iwtgBRaN6ohgq5pV7COYTKQIYHr9TLd+oPSh8=;
 b=K0Bn1JZ1h1jUPk9qrn0+8OPLJFh04yxBmOseOP10j2K+1cGaRty1G0XSvz+Dfp9srN
 /yXZ+8VF5imSBEfsG3SHVzCQcTmc1d427jo5eAdWKtvhY1fVZCHS2mP5uFiwae1P1S3i
 8cHe1fb4DXzQth93k4z+Sbd6liwWTsyaq/FElV5lwKNl2FlvCsK9SsPYdjYLWB7AUP2b
 z2asZWmSrTWIykEBNRfy95JT7dPfQeUsd1g3aWqqaAkBKPI9uDDS8Zgix8EX6fRX/FPY
 8ppB6u1EvD6PqyaC3WQQyU6JTmOIEa96sHPqCaPhhBHe71IEaMKItNVGSQ7iOdbsVyl9
 pvtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvdD8pavFVezrHWCzs8/94xdUj1+JZ0AT92wC9Sbf4oxiXlXZouMyg32udUbCQJ483EHL6DqFmLMby@nongnu.org
X-Gm-Message-State: AOJu0YwWY2+ECurRm4/cDnDsUUoGtQYGA4iQ6EkPq9guMr6jU2pGT9bt
 t1UvZFHHaMCfw2SJ+Nm2zmVJwVrFRKRE6n0fZw0dNLJPxZdt6x9bge4Y2CJvHGQ=
X-Google-Smtp-Source: AGHT+IERjhtD/eL/9DtIMBg50dS0IzDgDxKY+fXZrWBncj2/CdT8Dfx8gOkmdt1Db5WeYz6HYa/70w==
X-Received: by 2002:a17:907:3f28:b0:a9a:5cf8:9e40 with SMTP id
 a640c23a62f3a-a9ee74a81ebmr42604866b.24.1730973396406; 
 Thu, 07 Nov 2024 01:56:36 -0800 (PST)
Received: from [172.16.23.118] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0abf47esm70175466b.88.2024.11.07.01.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 01:56:35 -0800 (PST)
Message-ID: <3d8c4242-a325-43f8-a09a-71b5b0683f0e@linaro.org>
Date: Thu, 7 Nov 2024 09:56:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Bump timeouts of functional tests
To: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241106170946.990731-1-thuth@redhat.com>
 <c233a6b5-bfea-4d5e-9b1f-5bc3a467e17d@linaro.org>
 <CAFEAcA-MVg2EU2cKJz+drZp3=GBCPJXqbP7iNimg8fs0NYfhOQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-MVg2EU2cKJz+drZp3=GBCPJXqbP7iNimg8fs0NYfhOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 11/6/24 17:26, Peter Maydell wrote:
> On Wed, 6 Nov 2024 at 17:21, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> I noticed by --enable-debug in configure is a combination of enabling
>> checks (enable-debug-tcg + graph + mutex), and deactivating optimizations.
>>
>> Would it be worth keeping the optimizations and runtime checks instead?
>> This way, there would be no more "timeout" issue.
>>
>> I'm not sure which added value we get from O0, except for debugging
>> locally QEMU.
> 
> "Debugging locally QEMU" is exactly what --enable-debug is intended for...

I think Pierrick is asking why we don't use --enable-debug-tcg for CI?
That is, enable optimization and checks since we won't be doing local debugging within CI.

r~

