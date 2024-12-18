Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CA1E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuQB-0001Rd-BP; Wed, 18 Dec 2024 08:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQA-0001Qy-1n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:02 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQ5-0007jr-Oy
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:01 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216728b1836so45845475ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529736; x=1735134536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K6fBfkHLqLtHfyHLDkCreklvvU5UrFkOcriNnBJ8wb4=;
 b=FSzYk0n8B17cj2B5fBY5Ji34c0snRj3Usym0MDkPrRZndzN+9XxOderv5pBnc/7EuA
 ZoNgXk7CcrRtcxuEUYQGQXKOsMQctxOzfMpFNOuahwgtoj9GUDaxxqsF+yoqUW6fjDAd
 CCTzLuLk9DvGLLnhyKU2BuTqsGGXmWX6IMHv6wHzxIG/agbSYby80qPtZveOyAQ+dnuS
 paPMONYGdK2GGkKwRai0dfuGThe5emcqP5pyzBAQdnjCd/aEknaZL6qPqZhqN00KGm00
 d38kO65cpcLJxmNlcAb+DWDRuUGsW2wogDmJt5hOYk1v3TxsxS4n1j6/piUmpvPimmiz
 7mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529736; x=1735134536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K6fBfkHLqLtHfyHLDkCreklvvU5UrFkOcriNnBJ8wb4=;
 b=v2EitiJQi9Mzm+BCWnG3WKFOoZiRq7D/sqnNg88mxwYxQSVSuRBHrB9pdCyqD+25hL
 QkMhxMQw/GPoZCzUvhCexwVFIZ2NoxJ7fNSST28osPD+B/fT6FPcJbi+j+pfYxM/kima
 ZT0ZlTJsKXmz5dWFe84kKlWKGBn+fQahTiVgbnqgRquZVnqlXrqoORhTG3vI1x7b62JD
 mAZ+9mp14nlNxjYdoXApqqby5u6WgOUiKmHWGJ+PCunOgfuaPF6XgOY9VzHJGJcV3aFy
 OXrFwFoqCMrnqrkyfBtIos2QiarGiUq0deMOpUMOrwS0O6CafC0PFNJe9RSn6uEPb2mY
 dJ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWefLmqilkQWg08DdTcf1aEyv2kRYG957PpPFjfX31aBIzSWcwrpefwfFk/1zZ+2aj90l8o0yk1vdV3@nongnu.org
X-Gm-Message-State: AOJu0YyRPv4Xq/12lwzBQR+v5uN/XbpVIfQ2p2H7QgeBBVPNS8FdobJT
 DlSf0I8I6y9lFJuF1F/MZdMtpkuEF1g4GukyJSDTWHFcCIHwQieR42OJOaUIoQc=
X-Gm-Gg: ASbGncvE5WsVCRgktRsOGExin2AI/IIepwq9qblY7TlVexhwiZ7RCawAGDHS+/E2TCP
 tGIdLBA2kFtHE7V8WoMGF9rXTpHk7ILX3lYgNNQyKT0O7pNowoNvsjtMM7VmVtuiq0h3qCOuSdh
 XmbFsMSaCezso6RZfPTV9fAoXIo2khirBBAqnZsBGrzUHMPZjEsdzxV7RhesdBPQa+xIYO7TVH8
 n1tiSRg4o7Njl9+XjciqCEKv3RSrSdCqWtA6LcryIznN9ycf3AxDiCBtQBpfZLB8Si17URK
X-Google-Smtp-Source: AGHT+IEZQaxtzn4k27e3VX9X5AsMeM40Br6n8Ht+GCisMooeXdRzxRCs1CDm+06c0m8DhA3MvpMqlA==
X-Received: by 2002:a17:902:f64b:b0:215:9f5a:a236 with SMTP id
 d9443c01a7336-218d6fc3a62mr42349105ad.6.1734529736444; 
 Wed, 18 Dec 2024 05:48:56 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c50081sm6232668a12.86.2024.12.18.05.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:48:56 -0800 (PST)
Message-ID: <10261959-6948-416e-b720-0512871a8c4a@linaro.org>
Date: Wed, 18 Dec 2024 14:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/pci-host/astro: Remove empty Property list
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/pci-host/astro.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


