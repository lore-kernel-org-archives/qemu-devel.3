Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3611F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcpd-0006N3-8P; Mon, 09 Mar 2026 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcpV-0006Gk-FE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:47:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcpT-0006z4-My
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:47:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439c4bde55cso4154532f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071254; x=1773676054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRb30fu5gErroAKi6DgB2cezgJaGqabrAkmfdbQOouo=;
 b=XhbJgJBqnX5EN4SY8VVTHn1kKvtm1aKAI+5gNCoF48UyQ714fhfW6s5N22Kj3+/4WH
 iLBP50Fj7YHZ7QQ9RMvJHPrEOtQAFtzAa+vTjRNUGSl3avZjWj3HpbNSXK6NY01xp+Rg
 OYQg0QELzYTqvPSgvnpuW6pbwUVWlfRxfBi/H084oDVOHIezT6tFhRXR8w1xwq1kFcuO
 c3gIoi68pWwW6MwokZ7PzRD5ozLI7YE6ZXn9b4XWtO2r9YQ4e2Spo1SXgdvwxKU6u0XX
 oyD+IgTx/wGkwDP1Y65zFl72/77KniLiT2FtW/5FRKc95jmCIDb0rBZ/1N+eeNnxy44k
 PH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071254; x=1773676054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YRb30fu5gErroAKi6DgB2cezgJaGqabrAkmfdbQOouo=;
 b=u72DR+6Dgf10NRgoeIcqhHTuNsJSeHSTxIrshBPDagxV9pxe/PjZN84nGODHXHqoV0
 vRbAIuQYNw5iDqOvYrTTgdHC88x/W7xs3nP1pPYZUiOW5TBPU4bhx2Jgz+gZ+EB14qzO
 97poo3xq64LrGXZUV2P4mf2AHwaqxu2qqXNx8Qoz7aVUin/gWPgiZvgM0j+AHxHUb+gG
 vS6l1obdPhJoJy8ZgdDSZ9VQB2DPAbaNpLSqFPM2DTHo8NIW1yKRbXxrAOcVGaKd11fQ
 EbtX2Hs3FlWawhcH68KVaY80SpQKkpgoWE+WcyWCLfwereEXXOnIQFzpMg+YCrxkKs3Y
 UD+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIbpaWcXBJ6fvZ8fSNq2nMMn+4EjZOKfdCFfRj4d2gfgLAZn0WyepWIt2hqNllXqPdlUPKea2t56bN@nongnu.org
X-Gm-Message-State: AOJu0YwQhIF27CsKCcpjOeXFcmaYB9zxYjm/8Lo1F+MwzNSz4VlW5zPu
 dYCLY7wFmuzIxQzpIpME7NdhSOT0Vw0RwZNXibpBvM3U63PrFocUXngbs7VYbUn2xYU=
X-Gm-Gg: ATEYQzy1LXzhlVb5iyCNGPfF7/VXS8Ss4N2zs8ja044MTBTuizzkErE4w7JYtesBlWh
 rT4MtHX/ReZJINCQQTVunYtTM/QA9pokmEqD3aiVjczNyYf8D50u6djRiT/DbP12rIPhT5ev0TR
 E3yi2qCemi0am8Sw3ZOajwVarXIF0ccrd4EjZqCrNq1U3tsugLAFn/ERHhdQwbA5zMrlcBDPjcG
 fOz8i0KJurFEi6MZc+5jUXn0LQOIspSycJrTu0hRp7MAf0/6zJ3Le80w0Bo+0ck9UvmEuq9qdxx
 n48EbNqZiVlizkzG11efHYQj5U55+F3d1cDqQDK5wb/2IXZePfl9Ylil7kfB2zx6cTQPrUrkZMe
 5EKJUF9h+k9bg4V1xmZS8GCoR0kcIhXOyRfPk4FSBn1qfKQkDJU0Y6fUZyPfaM0d7s9w85pBmlg
 +2n4EPqoRZFq3yWBdo3hbyGF58TsDeYqxA5uoMR0x03hmBeSBcQxiO+KadCoBRN8miMP493qkw7
 cMv
X-Received: by 2002:a05:6000:178f:b0:439:be3b:ddb6 with SMTP id
 ffacd0b85a97d-439da653249mr19586084f8f.59.1773071253610; 
 Mon, 09 Mar 2026 08:47:33 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm30824170f8f.30.2026.03.09.08.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:47:33 -0700 (PDT)
Message-ID: <157f41e2-58da-4f56-9a62-0f082ff48a9d@linaro.org>
Date: Mon, 9 Mar 2026 16:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i3c/dw-i3c: Fix memory leaks in error logging paths
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Nabih Estefan <nabihestefan@google.com>
References: <20260309093838.364126-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260309093838.364126-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/3/26 10:38, Cédric Le Goater wrote:
> object_get_canonical_path() returns an allocated string that must be
> freed by the caller. Use g_autofree variables to ensure that memory is
> not leaked.
> 
> Resolves: Coverity CID 1645550
> Resolves: Coverity CID 1645553
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/i3c/dw-i3c.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Patch queued via hw-misc, thanks.

