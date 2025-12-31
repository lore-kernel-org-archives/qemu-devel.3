Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399B7EE6428
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 15:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vayEA-0001Wi-BS; Wed, 31 Dec 2025 10:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayE8-0001WL-N4
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:35:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayE5-0005fL-NN
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:35:08 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so5171759f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767195303; x=1767800103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7fiCBOsq4n81rBGzdwofKWfkgSnFHieuo+HIl4qcbtg=;
 b=WIFuHZq30i1oYwoH3j+zL14oYebPqRp13ZCK6F2rnHcBISDxms6UnyldBLWrg1/YJo
 AHrumYD30PbmmFDMG2UkPws1osBjou6LiLKjh4QiJUsA7qhXLaljoeFCbuBvq01JnlD5
 PVhiSqi2Hj+HGIdC8fcTxblmV9TXdMhyArzHlGxm+hZKgBOZa57Jny7kJPiAQr+Oeq50
 MHk9WxDDfHMuI6GnGfc4tQA+FG75TCUrOL6cL/D0GFyU+9h+GGTcQnNRAC9LNSzw5TmS
 2yru2w6pOMu/jDC9XRbdPMctqvKzvKm8MmZR3WncstmNW3M1SyYso9LcZUd9bV86CuON
 KdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767195303; x=1767800103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7fiCBOsq4n81rBGzdwofKWfkgSnFHieuo+HIl4qcbtg=;
 b=TTADoxe1OBFVFPYhFq1UD/LO2cUfY6sPBupNjROch7gAT1eoyuwhihDBW0GV4mXD2f
 jNSPPs1bqRlbM4/dEgPKzrQmBGkO0d6cBvbY7dmynYMI3SW7pmV+7FXZPaJrUuVTZT96
 /hVUq+eYFySIBGBQtlUjdv3Q0txB+W7XCxRB/ofbH08K7Q2mlmckv5DQFP1iBBYuL4dR
 c8ozAbmbMRwBRyw0ZfhN819EU36VvBM1zV25RJ1JQV0/bMqJmvdqPDvUiW/mpQk/CJzv
 dV3EM6A01CrCuxklqLbIRcmBr6s27L4kcFEWzXYoijAjUjjSOQZxC/dNCI2hL+T78AZd
 QNHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdkodtQcE37warztOPF620GYpYSLtBIs7TJWFOz+czvJWmH/s5EX52ikSDBPCK7Cp9+3Kcc3KI9h91@nongnu.org
X-Gm-Message-State: AOJu0Yz5jhwOqSvKcoIypApEe6nsTqjGouB7FIrvgElFPpy/TXShzTie
 FkjcOaE9HOsAlj1nwWYIL7a3lq0zHKuMUB44RjJ6phlLQpbpxq++YpjCF82RCDONFng=
X-Gm-Gg: AY/fxX4O+IObhwf2Sq5/qShJo214TdZJF2I2UaNUlqdo/anbzOfhUtJJRjnZvCYMrMF
 Z8I2fWHeezYA538VIy+KcKcEixxMo97xCghspa53zSZYPRUCxBLNZjbcfcZ5Xry4tUd4o3J0zUd
 h+4OG5KUCDHCgPReltqUsenQEnwtRqThIhsJn7AWyAQPNiZv4fNlOQpsx8i+76eRhsLgAjByfuy
 V1146qomL1nUEyQMMaMiH/pAv+SYwlXm/1IaGwLHhYRxzskvAiaJ2n5S4dUHiPavg0O7DcpbPb2
 np22+diLWf0wSJFcn9GmRD6rqlAlACgP8QC3Y/xCL0Lc3nbERI6EjH/ruS9hd2/GXtZ3D4xbGyy
 DPQ/EzVyhPgJqVhsAmPfIMbbZiPAFRaLXx0V+FpR4jS6i+bWghf/qDsp3F/WUUm4NhzA9S9C0e9
 HRuE4KWpn9FhEzIDTrCbWaxCIx/TjGTbFpUPKdIkQp+N3uayDULm18dkCpOWWBZxok+72o
X-Google-Smtp-Source: AGHT+IFnBFSBzDIW+gWBTFSJscb8IsxTA6xnDmLWMb+ReePPXZn3xSRVJQlY56avgpn3mWf+IxJx6w==
X-Received: by 2002:a05:6000:2404:b0:430:f3ab:56a1 with SMTP id
 ffacd0b85a97d-4324e50a211mr46939161f8f.42.1767195303343; 
 Wed, 31 Dec 2025 07:35:03 -0800 (PST)
Received: from [10.33.60.66] (91.red-95-127-39.staticip.rima-tde.net.
 [95.127.39.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227e0sm76781824f8f.17.2025.12.31.07.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 07:35:02 -0800 (PST)
Message-ID: <e6e06a54-1630-4776-941b-e5a8d6661f14@linaro.org>
Date: Wed, 31 Dec 2025 16:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] plugins: use complete filename for defining plugins
 sources
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251231073401.2097765-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 31/12/25 08:33, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/meson.build   | 12 ++++++------
>   tests/tcg/plugins/meson.build |  9 ++++++---
>   2 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


