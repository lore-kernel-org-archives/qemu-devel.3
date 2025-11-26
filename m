Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131D7D1118C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJrW-0005XM-6g; Wed, 26 Nov 2025 13:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJrU-0005WL-OG
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:03:28 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJrR-0003WE-Gi
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:03:26 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so3311219b3a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764180197; x=1764784997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+XgVknQUvbbvHRLnYljUJmIelFtJwYn7sI8h5p5qPWk=;
 b=d0yCxOGUULW5FLngbFaK2ZvkmYvwTw20jNqXzWDIoK8aCF9MO8npU9Ci6nPOxJr9Pn
 wft58kYgpkhBpTM3tzK7OWsYMd6eIAv0z/htTfXQWT2vYCrBpSvq2L3UvPM4bh9Ls6E/
 r+lWBIx9XYUD0V4966zapHT1Bd9EGBBKkf63imKLCT1fWut54ayNx2IaFvscNDj64eCj
 SZuPQwGb8NU861u40KFBBCeJDs3C88JOMijCE9Hsk/6xc1koFNWUlAqwaH0/4h2NDe6u
 oNy8dKLf2MPPrFavUslE0ze7pK2OyKFGKYUFQPcEts/zLr5V82SAEiXEP2UwhBxpKzt3
 t5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764180197; x=1764784997;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+XgVknQUvbbvHRLnYljUJmIelFtJwYn7sI8h5p5qPWk=;
 b=jB6or/s3P0H7DPZW5NptP3iaWnVzZEsSt4bno4gS9GnxIuC3/lEgdo2GPlr62WGNE6
 HZh9oygOMnpvOh8lOwgZlnL+z8zGHzZ31dMyaQgCdFcVyUXi8N8tzV0vLBZ3pJXpN4y5
 ezqvbtqKtwRrOUxa49UenhAPehqYo7DDVgYqvHCfARRatsImcDOkZs4zPGdtTzrufS3y
 8tLcUTTnVm3+aZwESDKYmQE0SjOyLpu0JEvP++mdunin5C/xfaUZmdzuWmz88h3NbT8R
 Ru+UC2wihFrRAhVo5V+MkCWJXWEfx4Z/ab8XwbELbc+DlPOlRzlQ0w/GR3zr5VVvosZz
 dreA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4T3J9/aErFx7/VmLV6uSTSyXyy3GyL7hybjVOhr89BTBG9+Kli0c7I7QRcTTwDupeEHAsOIu/YWhH@nongnu.org
X-Gm-Message-State: AOJu0YyRGddoiA4Zru3VF8gJvuAMSo9ou0ox38m8WGPibqp5/FfLfPa8
 KCeyJc8OE2KXGzLvleaWVmh6j5NjDWLrl1c7qzLa9/5EP0Cph5XEMTVWR4IE7/b7zuU=
X-Gm-Gg: ASbGncveBCRaSGxEpxikUcj+/SH455b94KFrqF/4aBW5/Z0B/ytrZZsqw25wNJoM/Fv
 c4DMCufUnLsDACOu79Jb18PPHz5AnbwSWPbmG1mrP6zzwZXXsOz1l0iL/Cam3FNSJhBJVB+j5Ck
 J3SGNNxdAbTdkrCKuB8f5Mv0SZdbVebW2KwZPR6vTh4h36sMK8nXrI1McdkzDFbfwCOjTy4actM
 K48tBzVk8/TGgsMCCRwWld0VTFO2tn9jBMLkHUArZ24XTi444fqKpRpK8jrwoP6RzYJjWAV5vbk
 jW+OqvJNg2u9DZoSXa13Ex8NvU/C/IIVqHEwCan6H7yZA0dE7078Pj4fO6Hfb+M2VcaS4oDK9h1
 5QmtuvOxiEyEFIHEV2Y5CXA/MkqZmVo20wsai3nzJ5WAhkvBHUGtmpNjXDQVw7xFufPgZcIiV6q
 xmIebbYcKGrp1iJ4kTTgaP4JeQfpsSEC/CEze7T1FCNXQyns8bCw==
X-Google-Smtp-Source: AGHT+IHXoLcm7PVCKZluS1cgxLKeSg6YDuAkOBFVTh4wnWZ9amiZtnaeoohz0oCFJl8w2mKu6+0SJQ==
X-Received: by 2002:a05:6a00:987:b0:7b8:7c1a:7f60 with SMTP id
 d2e1a72fcca58-7ca8977c27emr8941283b3a.12.1764180197036; 
 Wed, 26 Nov 2025 10:03:17 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3ea4322a7sm21811741b3a.0.2025.11.26.10.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 10:03:16 -0800 (PST)
Message-ID: <c469d0da-9012-459f-b4cc-e5c607597530@linaro.org>
Date: Wed, 26 Nov 2025 10:03:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 02/12] target/hppa: Use little-endian variant
 of cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, Helge Deller <deller@gmx.de>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126075003.4826-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 11/25/25 23:49, Philippe Mathieu-Daudé wrote:
> We only build the HPPA target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.

big-endian, and in $subject.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

