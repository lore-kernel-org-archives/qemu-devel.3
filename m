Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8DBCCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 08:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEkFq-0007VX-0x; Fri, 31 Oct 2025 04:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEkFo-0007VH-GE
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:13:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEkFl-00085U-0r
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:12:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso24181885e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761898372; x=1762503172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6cCq5Y50VJUcKYnF5yuaZdosmEJOsQTvMY0v1GHWHA=;
 b=i4VpLLIgNnRyxL8fEDhA+caLd1XPBjehrV7Fy3M2de6hWsSul1oh5yQFjCH6lJRhXi
 N2cW0LmNPm8Tc3J4KKIl6gC+aLzat+aiznL/upYItQA4FT9DBtCtltz6WpJVX3G5IW28
 0nxYbc69dByGqisIEelljmnBaWa1aPlOhGZpBsdO49MMViYZnz0c1T4yI01jMAqORueG
 j//DcGp06dk8kSIorKGo9Z7+Uy0aYFsIsooaoicO7noTimgxfTBUodD4YOZsYc08sW3H
 9AUfELslQ+Jk7gYT29LqCfcl6gURp5i7a0KI0QmebQDotAC+CKQ79scBiwa1sk0OMDE8
 pHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761898372; x=1762503172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6cCq5Y50VJUcKYnF5yuaZdosmEJOsQTvMY0v1GHWHA=;
 b=TpmnjWqOXIw/iGQXWIBfBlOCis9CDlU/+M6FVz+dGx+wjQpQEugH36hnxLBwSLW8n7
 Y+A/6OfH82aqPvysTTbipK+2xrox7NKFfY1vW0n7CZzl9lEbBv2NI6vbL4/QTH4gtzMZ
 B8doKvKxGu/rmcKRfYlb9syPKYYhFtFLA9qN4+rUTHwcMIPT3VasepIbaEp5x6faB3cD
 Gk8UCliCvI0NEg06/d3rVVgVNc5wP9oDDZic9AXlLUud0AzzQhH8fYRMJaAw5k5cxoN5
 hV7MEEUcEcXhrcsMkjvyZTBw/4I4xosd6EFgPmXpbiez49S62AlrDa5l+hT9oHRA/HmS
 D7Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/TvStK1kwbNnbjaUEdBfYd0r3GVsvcmZdhY5v5vV5d/+wUcmtL6SQ2mT5Z5HWdEoihu/dqTBG8iUK@nongnu.org
X-Gm-Message-State: AOJu0YwiYzqOXtXLrDq64XISPIMryGlBda5hhNG5m7X2XMmFs6COpMzs
 mSi9qDpFRm/vX4eiWKBpbvZolEiSIYrgwBPGiHPX6plPQYAqf+rgPsdwYfE1TkXG0JdV1eDsv2u
 7HsgIf7Wh/eI5
X-Gm-Gg: ASbGncuGg6a+238DGcufGTXNbwdQtv3geqiQgIsxI33c+yj+tB9RauqlRjUdRIw4BM/
 lEytx43UJJBU2j7gywYlqgz38hCwaObtpBK+Th1A4Hc73jHDOlLtIK86RukgO96Uk0sBPaVsEjd
 h/phNbHZkZEewPS40iTAfNp8cF8HXkjvsOzIQCQDfb9IP5O6Ds4yWtus7hiBIaLvJSQPIfa6gzM
 JZYkmRIh1HsjpqnClvylSaefrVQNv9TYxOGBVsjvZbNgXpviFtvt//l2wKeF09yy7ITbWQn3Wx5
 WRN5sV1dTO0r1KUoCQmtToBWxvp/U6OdjberjPJGu6xTBpMpuyU2IIo4pxIIvGm9b7K31KTNVD2
 4INkSDqd/bS8Iugu8ldWrKdiKcA2LlZ7C20G8o5WFFELdeQ2z+r1XtXSWw0Pn1vDjVOKY26ecK2
 n0YaI+c+F/AWl5PRFsyf+4wOc0WugqoX1yan6CCgirMmyCupgIzcXrW6Y9dO6jH7fTTg4EKKg=
X-Google-Smtp-Source: AGHT+IHIMjXPFLEfoM3CbyOK45fWGWEfeDnjkt1scktKPmkO6fuCad16eqRPTWI8A4cPuR2yW+0hCQ==
X-Received: by 2002:a05:600c:871a:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-477308af9a5mr22309705e9.37.1761898371835; 
 Fri, 31 Oct 2025 01:12:51 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728a97a1dsm74961295e9.12.2025.10.31.01.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 01:12:51 -0700 (PDT)
Message-ID: <2b30db75-ca33-431f-9af8-65f2717c7147@linaro.org>
Date: Fri, 31 Oct 2025 09:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rx: cpu: fix interrupts check in rx_cpu_do_interrupt()
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: yoshinori.sato@nifty.com, Thomas Huth <thuth@redhat.com>
References: <20251030165932.138512-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030165932.138512-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 30/10/25 17:59, Igor Mammedov wrote:
> Commit [1] broke interrupt handling, replacing interrupts fetch with a bool
> and then the remaining code attempting to check individual bits
> on that bool value, which effectively masked those interrupts.
> 
> Fix it by checking individual interrupt bits directly instead of
> old 'fetch then check' approach.
> 
> 1)
> Fixes: 87511341c30d ("add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   target/rx/helper.c | 41 ++++++++++++++++++-----------------------
>   1 file changed, 18 insertions(+), 23 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


