Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85BD116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxxt-0001N4-NW; Fri, 28 Nov 2025 07:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOxxs-0001Mw-GY
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:52:44 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOxxq-0004Uz-S7
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:52:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so14702095e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764334361; x=1764939161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mGlBpb90CNN4Fv49hDWYBWK0lQheeV2gLmZNDv/5mSE=;
 b=Nz/vXfPDkZleUbn6SeY20UeP6MUXsbNIOqHsg7mq9dd0WOK2lfThRwzEGpIKpsaGrB
 YsV54tCJ8mxE1QDOU36mkZgWL4cqjjOOHgaDJ/MNpwFUbOXRRhEYxS9/Y0O6Hpa40Zee
 Zsh6DBl/4ZRRPK2LmQlbsIDy4zSd7FFqQDt8SJ32O6+8P5s+7TBfHylKXpxTKgCNA7+t
 KDty8AtHVgJgDHbh7gSIl3Y5qzyqnOe4DnQwqU8aQAotCoZDYAXgLiHeN9tRlK+NemeD
 moPBoIyDBNZ9bJwEcP69Esjx7p+tpOu2EAGALxBtMkoBO9KksG5briCWfVjoT46AZHGf
 XPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764334361; x=1764939161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGlBpb90CNN4Fv49hDWYBWK0lQheeV2gLmZNDv/5mSE=;
 b=jygleRvMODycxMAWUDagI+lUPRwOF67WjJ6U6/cQ0uQcoPSIPrUI4sJE33oHEom89S
 fL6UF9MRElKNA4DAbqOiKV9CSY8FWPtSodVqDJUps6UVqkc7dCXxT3M6MyLSv3q7kTY+
 9AaO/OnmBpsVmDlgji7IAEywd6GQ5mpguKIqf+ErX7nPUtma2aqKEfl2BR6hzfaTIx4a
 DvrVLnJABpPl8YmIDlRvctZD56hpon3WgXALfBPQ6RfScg7u6g3Pb5xZNyPDXr/2SC9N
 gvWilt7uGKaWnWeeLgREMaWvd0Lpy2ju7CoeMQ4qa0oW4Pst05yxG8TFaC0cm4addeAk
 +q9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHTk9E4LubdipZNlEMSp91O8K1vETwR3Ip/X8h80kLkcAYchFb5lAImlVl2X+Ao1o8j6gzpVCsCcvM@nongnu.org
X-Gm-Message-State: AOJu0YwLlXny0mHqi5JJcsLVbf0BrNpJMhfJeXOgEc1ahoUo8EUKbdiB
 9GtFj5Zf7idIM23ldxk8xI+vOQslm2IPAvWjEZhKbWqe0FGkQvrURxzCvUc9aXRYCMg=
X-Gm-Gg: ASbGncuNMoPEtc4IDTwNEgzQP5cZJ+oKk/BjOTuZ2A3n1xzo7WBu5XlOvb5dyYJ328P
 99COagwE9lzFXySY+4m91Y8U3K/0o0ye0hYRYvYm3VGWfWqwy3+C32k2pZ00Sb7SEVkSzIO5Kga
 cgUbWx7nQU7btqGxTjk4FAnYVgJxw6Gtb6kMYGixITQ5OvTD8gMbVBqfoVQkY0dVRQAk5uErGN5
 XA/KXaHl7Z/eaaRix5YlCy2jVYxSzogqRYE0c+B6EDewtV2reux0zr+zocja2DuOliBJI42oLlg
 A9YdPn+QgG7BEIdnbJFNrNktS+7lkGlxOe3X89DXc7xk6t4deAQTF+Xdk1J4MdbvXtCIj5NDgd+
 jUTCcSBC2HVfhl9XbbvavdGBUIlqA3T4ht2+oeNik36lMCTTPrbloQrJRbgIgVTauL/WqbV26sY
 3mOwviAEIbWfdidb47/AxVmql/FRMwzO98I6x6oVqpxu5GxXkwXtHOyw==
X-Google-Smtp-Source: AGHT+IHPt48v9RqB+XMXvlHDcFUtE/8WYLEkorIP42c0qVxdJg9cPcY4OO4y6wCDLpASOm9ls30YpQ==
X-Received: by 2002:a05:600c:4fcb:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-477c01eea7fmr247050235e9.25.1764334360664; 
 Fri, 28 Nov 2025 04:52:40 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c302esm9473117f8f.5.2025.11.28.04.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 04:52:40 -0800 (PST)
Message-ID: <595ab068-df24-4a76-972a-90e7204d3415@linaro.org>
Date: Fri, 28 Nov 2025 13:52:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] edk2: rename risc-v firmware builds
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20251128084524.363989-1-kraxel@redhat.com>
 <20251128084524.363989-8-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251128084524.363989-8-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 28/11/25 09:45, Gerd Hoffmann wrote:
> 'riscv' => 'riscv64', for consistency with the other
> architectures which all have '64' in the name.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/qtest/bios-tables-test.c                      |  12 ++++++------
>   pc-bios/descriptors/60-edk2-riscv64.json            |   4 ++--
>   ...2-riscv-code.fd.bz2 => edk2-riscv64-code.fd.bz2} | Bin
>   ...2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} | Bin
>   pc-bios/meson.build                                 |   4 ++--
>   roms/edk2-build.config                              |   8 ++++----
>   6 files changed, 14 insertions(+), 14 deletions(-)
>   rename pc-bios/{edk2-riscv-code.fd.bz2 => edk2-riscv64-code.fd.bz2} (100%)
>   rename pc-bios/{edk2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} (100%)

Thank you :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


