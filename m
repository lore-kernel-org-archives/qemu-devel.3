Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789CFC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E5B-0005lT-25; Wed, 15 May 2024 08:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1s7BTO-0002ac-RJ; Wed, 15 May 2024 06:02:58 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1s7BTN-0000gL-3n; Wed, 15 May 2024 06:02:58 -0400
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-36cc8dbe09aso22902505ab.2; 
 Wed, 15 May 2024 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715767375; x=1716372175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cmh48SqCH9MqJ9uPIpx+IaN+RkLYVxlVbRRVtQTgRLg=;
 b=BvQ05JVi+lvYZcxXKRyGSQRAgxe9VGrIg+MNzTfeWFK9e3q4SFY1ARtwaT2sexEwO+
 zJvfYcOJLrDqD0QTxO3b/DhAnBoGn8hqbBi8ttN5Pn9ZOq5pcCj1JrmwPhgzHgUEeFxw
 YHqV4FBEFetqNAwvEnxkt/6bXY6cFARH8zgZ+oYCH9D1KXxSk0n46xeaO7GVCO9g5mqe
 eU+KTrq8+KpI3Cs7d5lcy8+LSUhMtbXgQUNuMOvuSRZuA4KN+Ay2PjNZQyPMiicUdtpP
 qniKY83lX3E9oIZ3zE3m5DwkF6dXPwXbQ5ea+k20QWs1XijfhNMf34JcARcV3CdCDs5S
 Um5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715767375; x=1716372175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmh48SqCH9MqJ9uPIpx+IaN+RkLYVxlVbRRVtQTgRLg=;
 b=WwFUbEGpesL2nbBdjiX+Q4s0dZCsOmHNlHy7WfmEw/Qtm3SE8FqDHfZR3F07l3bRqM
 EeZr05c5ZQKjt/1NsOrH2pwaNVaBUwDSx5J0Hz/NKn62IMxG1TME6PljwgNgJTClkEyU
 fFboRtzG+tPvKhQWY1Rd8w8ZKO3P4m2DtPiYs4Ju3f/HkeVjwQikZdl44bDHMs5EVaGG
 9adm57jyAooYxfIPq6z8Tp4Vgcdom9RewjlG5W8xWbzAaPSG9sPjdvxWePLfaz5qL5nr
 76yLbdZ/A2t+UBhtNFOjHoPR1QPadJPH5UJRIiujIxkKU51OvovpxY8u3ogEYgbj1ymq
 jM6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5w2+SlheoxkZKJOJLw/qmXQKPjcu1GpY1tB67bZMp/U6DvUfN0VjyMfX93qBl/DbYJqxAMJfiVKNd7kYc7jGZpuDssHs=
X-Gm-Message-State: AOJu0YwFJdMr3naxHONUBM3ubJiUERYKFMk/fD6s91Kh9dlq5hRldhvO
 YQJJ7NGJfaVIHCl0ZE3FFQP81408te4oNPeOckEkE5exZYNrN97MXaVttSvE
X-Google-Smtp-Source: AGHT+IGVxrHXoTy+jU+560T7j9aKcCFwfNcrb8Bx05U2UnNz4kSUtCIgTKiVh+9W4e5aYM7EaM49TQ==
X-Received: by 2002:a92:ca0f:0:b0:36c:c5ca:9f9b with SMTP id
 e9e14a558f8ab-36cc5caa0d8mr186104035ab.14.1715767375324; 
 Wed, 15 May 2024 03:02:55 -0700 (PDT)
Received: from [172.27.234.193]
 (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340c99b915sm11026683a12.41.2024.05.15.03.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 03:02:54 -0700 (PDT)
Message-ID: <637ee935-6753-468e-b003-e0f544d468fc@gmail.com>
Date: Wed, 15 May 2024 18:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] hw/riscv: add riscv-iommu-bits.h
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Eric Cheng <eric.cheng.linux@gmail.com>
In-Reply-To: <20240307160319.675044-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=eric.cheng.linux@gmail.com; helo=mail-il1-x143.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 May 2024 08:50:04 -0400
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

On 3/8/2024 12:03 AM, Daniel Henrique Barboza wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> 
> This header will be used by the RISC-V IOMMU emulation to be added
> in the next patch. Due to its size it's being sent in separate for
> an easier review.
> 
> One thing to notice is that this header can be replaced by the future
> Linux RISC-V IOMMU driver header, which would become a linux-header we
> would import instead of keeping our own. The Linux implementation isn't
> upstream yet so for now we'll have to manage riscv-iommu-bits.h.
> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/riscv-iommu-bits.h | 335 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 335 insertions(+)
>   create mode 100644 hw/riscv/riscv-iommu-bits.h
> 
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> new file mode 100644
> index 0000000000..8e80b1e52a
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -0,0 +1,335 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright © 2022-2023 Rivos Inc.
> + * Copyright © 2023 FORTH-ICS/CARV
> + * Copyright © 2023 RISC-V IOMMU Task Group
> + *
> + * RISC-V Ziommu - Register Layout and Data Structures.

Is there still the term Ziommu today? cannot be googled. May be just a transient 
term during spec development? it puzzles new comers.
> + *
> + * Based on the IOMMU spec version 1.0, 3/2023
> + * https://github.com/riscv-non-isa/riscv-iommu
> + */
> +



