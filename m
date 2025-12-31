Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CE8EE6428
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 15:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vayGQ-00037K-4I; Wed, 31 Dec 2025 10:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayGO-000355-Vh
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:37:28 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayGN-0006L5-Ku
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:37:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so110117575e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 07:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767195446; x=1767800246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJXa89Wnw+dSv1jKyLEcH1zDQUgR04nA+jdxS6Vdc9Q=;
 b=BClqef944XiWjcIul3wjxo81YEyZqkp/Qy1FFOX/7/rbK7Tr0/LQllDloxnAucpsEL
 jTKD2xaWmJzLB5cm4Y4vrGTshJJRyfBdLx+7NO85AxidHWcJ4J/BrliXOsqDWKjzFjbs
 2+M8TWNeiuvJzn2iN2QZMkeBAnBiusQHIvvruAObmYmcaTLWmJ4p9tEbdmLn7d88dYCv
 9ZuNJl5+jySPvNuBTpVZa8WsIFO4A8j+WvZBuQHVtTcU2Vmxxw/vJuQstaqn1jHmQEHz
 DHv1ddbzvY8E6XZXygT0gRfNRNIa1Px1c/h4K3RPZ1q0EK3s6NEI6g+FHDDJBvPtSJPt
 Kizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767195446; x=1767800246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJXa89Wnw+dSv1jKyLEcH1zDQUgR04nA+jdxS6Vdc9Q=;
 b=CMhgFHvSkizEWbp1gsvQFpUFON1W6uprzTQx7CbqEWk8psnDGPEWw6/8XLf86skvTq
 LuvqLGRBJyfL5VgFFaa7x9XKP6ORcW1FjAWO6rnlk5AOEKGJcu1hvYWbwb+ng0AXyjYO
 5pXCs1Mdqz4giCY/ytG6tlziQrSXt3JIuKWHWtRDvr7RVi4I2e90NsYz2PKrrtynoiGq
 kiB6oO3ixtYeKOmCPZXPAyiXxr08gHCKPG6pf3u2jJZNYLn6xlkpLL9l5/1ZehM/X0JD
 a+SvdR5AoY/Wv8WzxvAaN8lH6zMcx/9RojiHPT99SvERHA9O6Jn2UsLWGIJtmt4lC6y+
 pJoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9caHMV8J7+nlLRDiK8GOfs3y1/xkoISMWoXjfMVh9yrxdupgOOyhb7cx8TLmFCFN2p030qAHp4GIx@nongnu.org
X-Gm-Message-State: AOJu0YzsDfeiQiFAyPb/by/M5XaE++/9P795AftkYw0Se52G50xAgT69
 1o5DxzsbjWoCXGSMet/84m5UI+fd4iU15068ukOr+dLgNn43nrprReL+nHkH/aaV/3s=
X-Gm-Gg: AY/fxX6u5xTyNKJG9sUPLL/eA45RB9oPTc/TRWqN8EYCJ3qc7AzxZTrAbXMtQ50H2iJ
 m3vAU3gfC+eXE3SHLPkL+fINxuIXq0rSqRC/zB8jzCihw8CyDtlTh4mUhUxF3Sr+KiHTM76KzmQ
 QeggWwAxaFRer3mXR6C7lUSTDXC5Gi0uvGIjwLKyG8RjQ/NisW0sf7ZLjC1YYLEEJ3oSf7smng5
 ZvMtQ4Syu3qC2dr7VxA4HO+yzprRxdQRTnNb+XjaLaZHLYMUm8PS83QlDwMiU+2QcIYM/MzaUKD
 zcjDB9/PUm1HvHDNOEL89bTarglL83Go79jjTOcixBUVSVmVeDmHoM1b+zTmfgsDfGtC1kjza/e
 z6lTfzMwaEfj+H4h6xHo94NrfVQwKF5Av+Ukjg2UzppdvwhcGZfAhjOKIHoH4NFpSdAgROjg0Pf
 p+gKBhJzitpxSn7D+DMl5LwTJ8zudoBTIaPvvU/PCR/s/in1DUpRTJmzMt1g==
X-Google-Smtp-Source: AGHT+IH5Ktqk7Ign4VdI2m4WFekvg1JKDxfpTJah8A0IdV28zBCw8oRcNgNM0hmrXdqx4WUkFhPeVw==
X-Received: by 2002:a05:600c:c041:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-47d1c0360b0mr301296645e9.26.1767195446215; 
 Wed, 31 Dec 2025 07:37:26 -0800 (PST)
Received: from [10.33.60.66] (91.red-95-127-39.staticip.rima-tde.net.
 [95.127.39.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm719667155e9.7.2025.12.31.07.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 07:37:25 -0800 (PST)
Message-ID: <b2bd75cd-5976-40bc-b26c-9ba80d24a074@linaro.org>
Date: Wed, 31 Dec 2025 16:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] meson: enable cpp (optionally) for plugins
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-9-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251231073401.2097765-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
>   meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


