Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595CB10F287C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Gl4-0002jm-2s; Fri, 27 Mar 2026 19:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Gl0-0002jR-QK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:38:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Gkz-0000Ms-AN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:38:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486ff201041so24618075e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774654704; x=1775259504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4C6T8Bvc84JSNJ9moUVxE6PYm+POpf05K2xJHhaPqg=;
 b=hczXWAvsrK/CAECOjxqWqUdxCosiMO6gM+/HIzURri47uwwO4uIlyrUBXE5i7AzT0V
 U+WolM5PL2Z94m9KfXl3kS+FhJ25rEAV2Vo9BocK9svdsW2VTr/XIAL/Fl0rno6eh2EZ
 Hol7LLESLZzf6YUTNFcRY5nN9p+7iCc0kXvOrpTgKXGRUItM/DRcj8NKHp7Q2GBA4w0A
 8Z2CbmZZxcmOiOp0hD/IfZlMvk8upWyub72lR6usDsw7MVyP1cPB2fjhYwVYstN+ntJe
 YXvETf2jkVfVBkzjxDLYiiFT/ahPIT3bCOlBhSriECINE0k8GYIr6QJ5svhWYSm1KrdO
 91dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774654704; x=1775259504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4C6T8Bvc84JSNJ9moUVxE6PYm+POpf05K2xJHhaPqg=;
 b=PCFQJmojnS99/AhuGPm+81S76Ok83A6awg6knnfenD8yxYv9bNL86wrkFBWqsHoRcI
 tmnoQn2AXy6Ms7+jL/dlse0a3ThU5CnhUpdqZ8Fa4cdSmTnEAcmwHgNdYqE49vpc51g+
 6gy5xDlE4wrOPVQHYd2YzkcPkB4J1T9yo9MomrM4F2oIMwNos6TKbiv8vAvi+NieHQG0
 5FG8dJjXiLVgaWUMxSfD+ODn/8JC3Gsu5dMEakK/sv14uxrpvaNf4fzFwu3hce6S+EfD
 FDXnO9kxzd5ir4rmLNwN+TVV9Zu4r2H4YnP5OOfvKQGOnsWWDmhQWW/VFpczWIcU8km3
 QVZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXibAzirnTug9kEwMO/TKSfJYTyd/UlUihuUB5Pvf45E9ekg28B1RIHcRAz/txl2fUyAQ69fH0LnLSN@nongnu.org
X-Gm-Message-State: AOJu0Yw41GcQRQEtKpEg+ljA0VGVx3qXHg8ZfDUilIBipXQKmf8gXYx5
 O7Vf9hqsDig7clI1lBi5IKnecgdkLiFadEhbB0YeA4YMJWQ1c02BYba78IUkVznsE2k=
X-Gm-Gg: ATEYQzzV7bXVAI+uu0bICZbS/VibpuvBGBTJHCRQcjyU0K0a7RkNRGHzqbsOcp6vSzk
 u3I/VPczm0pdwdrTsmYVO2kRfVdtCE22SCt5m3cVwksqDbhDAImWZhxEUMid3VxMhsUcpK8BQmR
 OSrDVh4+gLXTyJ68ybReRpX1iDUnR1w9MCK13GObLG/5rl9BRKbHbyJlv/SmtTqfTJg8r4z4gjF
 //6viHegjmSytZD0Gtx7UamHBCOsTbcjclRsRHmImYu8tptjt0SXJhp2oe7NhrHa4AIRZh8ipUa
 XUtPLeTh9WQBBCfexAIyqiwbbp5sPqFAuy8p5abLeDOIkXMtdkmFgt4I78lJWT9+wFBKsI8+ubS
 OUCtYxT5ji2zpM90g9noiToJCUdXkcSp7Kb6SmEMtpjjEDSU+fbWF5EnoBX6ihCwWXR3vnvbdnJ
 Dx7pSCaTuRoZAkDe3XLGRZiYmk4Ti7jCkBdclDiUPF6W6YZavnVbrr5qvu95HF2RYSrdRKfv82
X-Received: by 2002:a05:600c:3f0a:b0:485:4eaf:eb54 with SMTP id
 5b1f17b1804b1-48727ec733dmr66913935e9.20.1774654703688; 
 Fri, 27 Mar 2026 16:38:23 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf1db08e6sm2981651f8f.0.2026.03.27.16.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:38:22 -0700 (PDT)
Message-ID: <262c9195-b189-4354-8c2b-a2ece3dcc801@linaro.org>
Date: Sat, 28 Mar 2026 00:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/acpi/tpm: parameterize PPI base address in
 tpm_build_ppi_acpi
Content-Language: en-US
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, mohamed@unpredictable.fr,
 Stefan Berger <stefanb@linux.ibm.com>
References: <20260327173209.148180-1-mbawa@redhat.com>
 <20260327173209.148180-3-mbawa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327173209.148180-3-mbawa@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/3/26 18:32, Mohammadfaiz Bawa wrote:
> Add a ppi_base parameter to tpm_build_ppi_acpi() instead of
> hardcoding TPM_PPI_ADDR_BASE. This prepares for ARM64 support where
> PPI memory is dynamically allocated by the platform bus and the
> address is not known at compile time.
> 
> Update the x86 callers (ISA TIS and CRB) to pass TPM_PPI_ADDR_BASE
> explicitly. No behavioral change.
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>   hw/acpi/tpm.c         | 8 ++++----
>   hw/i386/acpi-build.c  | 2 +-
>   hw/tpm/tpm_tis_isa.c  | 2 +-
>   include/hw/acpi/tpm.h | 3 ++-
>   4 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

