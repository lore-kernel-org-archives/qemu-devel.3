Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F4ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10RB-0001Rj-Bg; Tue, 23 Sep 2025 06:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10R2-0001K8-RO
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:39:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Qv-0005Nz-0d
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:39:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so2086392f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758623974; x=1759228774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jjX/GzuCm6wxPV6i5nZAbkBCVwKmsvIhAZarqahABBg=;
 b=nyhfANpnTHDEZ0hzspxIQvrJcNhhMZwhdnNsq3kqBE7QZlH3MP1hqLRHjz/h/oLk3U
 4VlrC5vfVRqNsodr6f6rtlKI8BSE++DWF/iiVTKAQGGeexip7jnxdgeV8M7suqsC7F2N
 RXW0ZM0FG16veGFI0BLMrOI5cEqkurjp6b8h57eDWHRjCkfkvls/2SEvrM+om3+6xN+R
 MdSyIyAzSBTwXHDrPU1Fseos27dV3pRbHuHHYlXvJzbzXttdaLu2x75TTT/tUr4PG21k
 tHlPyvy/qxRwln04PrnsuKEXSvbiUJrtU36syA6b+MFFxe0KIj+Dva2HPRwOJivnsvob
 erPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758623974; x=1759228774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jjX/GzuCm6wxPV6i5nZAbkBCVwKmsvIhAZarqahABBg=;
 b=oc7ikERiHK7+9AWTJUM1W2TcUIkmGmWWbyPcZEuKZsTyYqdQgwqQ3Y5oYt8g3ObRDu
 pjfetYz/mL7SnJHlyF6BQjh7PxmA8NptDNrOn7hC3TY5xpoSzR+a79UuG8WM5HidH+Ww
 3BtA6maaoateFivx1yQsbUHBUSxxyIs2okLI7TgP0h8ykzcJem+noy1OeYSWUQ1Jvsx8
 VG/2NFJMwKlBnG8OcDTvKf8rep098+tAoXt0iex9u64sr36ESpyGKB7YQPiEIMgPz09D
 dqsLtRGLd3W7Ah3+ZYz5hJik3z8hfDunHeDiwUXVochu4QHmF9Ys/Ihg0oFxdyAWPh64
 9DSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbDajdbUPVUr2HeQ/eCGD1ScaOIMBi3bnNHC8/qn5drc9AE7biSScvSp9lWswcipTNL/Btmi6uAPji@nongnu.org
X-Gm-Message-State: AOJu0Yx53/D+u1PI1nMBz0JbI8We91uz/nfE1yQa544WshfhaqdLEeh0
 JaI383SEMjC2RSSHqmzQl/IkmNWG917YuNpgYOivR+4e6DdhjZdveijfa2TapWRsbHC4dF2Xex1
 mYRHEo2q1LQ==
X-Gm-Gg: ASbGncvEPSaWaAWTJ0ub58ppT2PCoGPGND7Ru+hgjfhL9eqNsIP5AakVKd554BSKu3b
 LEzjpxz5IXRyomXq/tb5THiwpAOsghsa9VLasGnuCD9K0SIu6LWYPevNHb4vORPgDVVzJbFSN56
 GnpGZgh3lazbWDoT5z1INioiMUOGSSOd+FTL4tYQxnRsR9PGghvK5I8dOUQJZ8B+cgM/c6Jg8FZ
 cMruNZui6mqYMKsd7SaIEunKoF1M72TZXjEIZChZB1p2mz2Xi+OdwF0WTYLMnW4oqYFQdjQwPMo
 h1iG0auymJ7QYf16k9xuJduDwmU6RNprKama2Pdy5ekInZxaJLSx4gBpacmO+cRGOhCeVDhTY5L
 MPO6okzemhZT7omYyjqgGW6J9X3GEf2Yxy/msJVwQwPMWOAIx0tyoM6FCOE6VgMfX3g==
X-Google-Smtp-Source: AGHT+IEDrzf5dJkAo8wu7PABPnspZLwd0RXGNeVvmNqanAm0Fua06e7mQju0Nv3EeCWIktFuvIxYWw==
X-Received: by 2002:a05:6000:610:b0:3ee:154e:4f9 with SMTP id
 ffacd0b85a97d-405c523c2c5mr1727862f8f.20.1758623974428; 
 Tue, 23 Sep 2025 03:39:34 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm23619654f8f.63.2025.09.23.03.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:39:33 -0700 (PDT)
Message-ID: <a4ad976f-beb7-440a-b23c-45bd691fcc08@linaro.org>
Date: Tue, 23 Sep 2025 12:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/36] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Conversion between KVM system registers ids and the HVF system
> register ids is trivial.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


