Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305ECCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVuU-0003d7-H5; Mon, 24 Nov 2025 07:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVr9-0003Tx-35
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:39:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVr5-0007iU-NG
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:39:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso41246985e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763987980; x=1764592780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSWi1J2brTEyYQcpIKpdBA6vEgQpg2LxGkNeDLumwnY=;
 b=WCCWSzWsGTkY3o52zqY0XwBCjzl6J1Hgqgflko4Y/sj5mqoPHMpoTt+oDlv2fhnMPN
 jdLZtgjqGBJE9PFbdzIJSMFbqsREulwjYRJdVXV3gaDmxzLHW07UTaRRILaJtSiJ6TS5
 WsBPVuKEX5CW7Y4QM4bvAXAMa55DHJPzGu9sJ9OsbkKsRy0wKQw3HrA2qdoe5ptbq1E9
 syaBsxqAZ5+jnRIDfq0fGbTLAREVkpbKGtTmzGof5d/MFxxr4SjBl9STYlzRlqzngfTW
 mnlzT8va0P0l0z52TdSSfBOzft4GmbpFjVn2zBHT3zx35HZNTlsvfGWO9zrMhrt2FUsx
 jiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763987980; x=1764592780;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OSWi1J2brTEyYQcpIKpdBA6vEgQpg2LxGkNeDLumwnY=;
 b=Qd/f8QL7bTeF334OI24ntLx5G5ZHXnHH/Zi1No/PpwquNAxzvMLAPhkqerajffz0Hi
 QYwkDxdCrzeBReH9fwzL8P6wD/5Q6Qfk2xjNCp+IwGky5iJJciajcqDCooKsGeHErwu8
 j3ZZFxippezXvGPu5vf7LkxDHDjN84b9hGFhsCLLqEoZG+RDIQ9KE9uk7CyTccUUmY2x
 ObY74nW+Jm9GfiSaoblr1TFvWFDI1qDt+zW9yC04wDTjjS33RitiZ4Q8COUU3ANsGcI0
 ap1BLXBgD8ltv2GJVhmPjVUCtWQuvGYq9Ue8PhOcTxO4HW4cVdRGyff9Z5Yz3lriYdr/
 +wfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNWWjJqMBJ0qGwBHiVbnMo5zZACqS9B6aocAjokUpb3HFHA83+RzkEbiFpEBorABKln45e6IeeMxB8@nongnu.org
X-Gm-Message-State: AOJu0YySAhU0gi1d6RTQQpNkrkCQIMeZbQOVrO2rCdNJY1+qu3sc1WNm
 1tsXsNA1VzpycHwqnZS//n0rPJ++xzYObHuFBpm00JbmAdqiuYPhlwY1JwFS6D3hLCk=
X-Gm-Gg: ASbGnct/bl3imh3ZUIIj84IxDzdP9piJj7A3r9ULavhJTwgWbCulmxD6wUTOZInk+GJ
 GrKWhrOep7m0yvkZB1y90Lf8FGkh3m/JnLHhfv9JiVi60SNEvkqkPZAsDRqEl+YMdnA7HZF9EUF
 Plvv9JRIlJw7pNV43ro8AXSQo5Vgl+SvZZ3/E6DBPf4frac6g4HuQ1JWmK0UjPnl8Noe+46v0qu
 vvc1GKVFIqRW5YR16QaxSl6SfFC2NG00VUwSK0uquNCT6i6tSyzqsp167atnnfjQjkEKMkHuSAR
 w/sBLkZLW3wZa64lViYQ50qJOPS82j+eLGGpmhay0V1d+6ES1yJbJrSYa1MXF2VlcUBHqgtULbX
 RbcwyIN1eXBRftNLa5l/i6YntfSXIytollb1o/ajrvheyauuJ5bEfvOGyUHgxcJhPXatYeSYtTV
 27pTRbB5l5yTUovUqkHYdfugoyZOir+k98A3Cyfrg/ge8Eh9jIifK9swH6wyY=
X-Google-Smtp-Source: AGHT+IF+ELbaFmzEaWWc9rVzBL4OB8JjW6zMG+mOAaowmAtaDShx9rKCs/UcI1FN0hAmk/5Pf7qIdw==
X-Received: by 2002:a05:600c:1906:b0:46e:3550:9390 with SMTP id
 5b1f17b1804b1-477c01d47c7mr96493655e9.20.1763987979649; 
 Mon, 24 Nov 2025 04:39:39 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf355933sm200693405e9.2.2025.11.24.04.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:39:39 -0800 (PST)
Message-ID: <6c7ae362-ed23-4e88-bc43-8be111c83441@linaro.org>
Date: Mon, 24 Nov 2025 13:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] Rename UBOOT_MAX_GUNZIP_BYTES to
 UBOOT_MAX_DECOMPRESSED_BYTES
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Paul Burton
 <paulburton@kernel.org>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
 <20251124123521.1058183-3-daan.j.demeyer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251124123521.1058183-3-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 24/11/25 13:35, Daan De Meyer wrote:
> For consistency with LOAD_IMAGE_MAX_DECOMPRESSED_BYTES.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/core/loader-fit.c | 2 +-
>   hw/core/loader.c     | 2 +-
>   include/hw/loader.h  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


