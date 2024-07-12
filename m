Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C2FC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJEI-0000mF-3T; Fri, 12 Jul 2024 12:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJEG-0000g6-AR
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:34:40 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJEE-0003NO-OJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:34:40 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52ea7d2a039so2301587e87.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720802077; x=1721406877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hZ/K2G0j0s13PtwGTc2OrpCTAN5G72qdS8mykIefVco=;
 b=N/bX4AdwhRYJFnUPkm2YHVLL3q/588gEO7GXgfIBjF7tnIqEwCy0hSdhrQJnC1YkmF
 KRrFaXEIvsiUooFKEfyq6g/mxQCqxv3u6YL/JxOweFwIC9rBWwXV2lqXi2/RJTdUMQQF
 spGOFDOxrXa3wm3BWF6joK0Gu9OiMAz8zrIqDOyrHW1vRKfGgO6MVkJacZl09IhwRA0G
 UlVB9ijdEyK+04hbPocZNOYvSUHmRsbSG3Lg84fIjVyK4e3vbdWLKE8W26IjmZB1N5VA
 Tn4nAXMg4TNq8rwI7jAiNn5NEcDpKrfLDAXz58fDAusgiIjgApTr+X1mgsIRkL/aAO06
 dtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720802077; x=1721406877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZ/K2G0j0s13PtwGTc2OrpCTAN5G72qdS8mykIefVco=;
 b=xO/8UyA30WWiTZ/oa1sEkTnjo3ldKNL+zMHEdHQbTmXvPTg4XB6uG0cTKwpdLb7VKX
 fnzCFlursbxFUF2cwb8UTRa5NoCK8baWZjT16whTV1uM+djMiUMLx99EY9J+BsHZBmoP
 vSsn47axhpLMjS2VcMEPsoYIfSO8HeGUYiayJQQ84GZFjqfekpN74Q1hBIPXYraBK9du
 y9ZV/UcL0dhewI4TiH9avjYYr9B0IpVJQS6C1GD7UOKQ5huopT6mwLHz9LJ74arxvwlh
 Tt+uG7EgG8WWzgv/UvxR+h8Q+hw1GvUJILJnneqhMgyxmqBjYCvck8w5OdwbbPghT962
 kvqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVdmZi10R1Z4pft1UarTcffmRKr0g3x+XjhcfY5jPeuzkS6mKMkEa2PZVvPoDmwMA236uPzvWHad4hnhYf8DX83onhrAs=
X-Gm-Message-State: AOJu0YwU8dtXtVgWIfcYvgHV0z1FW4gZgAl7JErDL0QWSdLZjStENrFB
 AZcQsykeRFb8oRGuTP07R9D77pWXAOwhqOrviU5frTCffHrB73BpFxdHlwKP/1c=
X-Google-Smtp-Source: AGHT+IG3nOjJeZ4uQKoPlUMe08ABSlYZYUsdHEC6G0u/eWLeXOYdMAOVkNR3c/lkj9cCs9dy+5ZR1Q==
X-Received: by 2002:ac2:483b:0:b0:52c:d5b3:1a6a with SMTP id
 2adb3069b0e04-52eb9999d82mr6613243e87.28.1720802076697; 
 Fri, 12 Jul 2024 09:34:36 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr.
 [176.184.54.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d74c6sm27904215e9.45.2024.07.12.09.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 09:34:36 -0700 (PDT)
Message-ID: <1ac07dde-effd-4e7e-a209-7293a48a6902@linaro.org>
Date: Fri, 12 Jul 2024 18:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/core/loader: allow loading larger ROMs
To: Gregor Haas <gregorhaas1997@gmail.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, yaoxt.fnst@fujitsu.com
References: <20240628182706.99525-1-gregorhaas1997@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240628182706.99525-1-gregorhaas1997@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 28/6/24 20:27, Gregor Haas wrote:
> The read() syscall is not guaranteed to return all data from a file. The
> default ROM loader implementation currently does not take this into account,
> instead failing if all bytes are not read at once. This change loads the ROM
> using g_file_get_contents() instead, which correctly reads all data using
> multiple calls to read() while also returning the loaded ROM size.
> 
> Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
> ---
>   hw/core/loader.c | 30 +++++-------------------------
>   1 file changed, 5 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

