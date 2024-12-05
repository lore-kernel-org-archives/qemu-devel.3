Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7321BE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJ37-0001vc-MN; Thu, 05 Dec 2024 16:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJ33-0001tj-EX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:06:09 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJ2z-0007J1-0X
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:06:09 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385ea29eee1so1033257f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733432763; x=1734037563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PAkhrLwGmqi1fZGll5e5LUyn+/zJSLdsLNxxOCgRSFc=;
 b=r8UrVrUkzK2Tfp5fd6tRDcgzsKgsgGY5ecS92Vwfgf/GWwelVzRAhuThGvHBVVDkzm
 KNtGZbzypDq0ETbczc4t89oQDe8JfPtlZDnlYTtldFXeRjOHIA6R9w5IK2gMv/kAXLwG
 0eRfWgUiXeShV4mN/J5JW1mi9VZXCVVT0sVrFNAyiTMW7WJ9e9oWmrL/Vv2xGsAo+HtN
 aYdITyUbwjnAheeF+fmeB3G7MtYO6OVwL9JlHws3gyxt5JD2IWTYuz5Va+DrWBxCo7W7
 /ixtwdT+H3x7SpzkUei346NGPCsoL9jk0oxnWUEfftVMkVOzKtBOKzCLM5EMtq4vHuOV
 FZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733432763; x=1734037563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PAkhrLwGmqi1fZGll5e5LUyn+/zJSLdsLNxxOCgRSFc=;
 b=uin9BfHdgjvFEGS6n7RyCHG7Z3IX4HO3/psdCTtYuGl0Yn7h8X90yEdgbn9VnFHMb5
 PgmvqTIJ1lEzBXm6TiJLDXnlbDGDbRGqjDh59TrwpLakClIgfGA4MSKJeHqCH4L7jhB/
 pC7nbjpXSAqBNO0lTcVom166lbqZczv0dABIz54TO7nL2p/Qnks94IO0hxgK3PlOfrUU
 gruTVTcQWaZmnLYfv6PXnrtGNnR9c5kzSQMuKlSO1FDJRfW9dKv1f932EBbRwkTy5uJT
 fNafFe4R34uHaHmiGuflinAMaZ8x/T61gMcZJbEi1cq+j020s0/dHc7NdBSyBfA9F5ck
 BMFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWURCIC7u7KgKHw5P10mzIV0Fw4h0qQ1JNx5+L59ahRfp8DgOPpAkCkjqqGAd2QlhxlQrJ5RaKD36yZ@nongnu.org
X-Gm-Message-State: AOJu0YzcJXkVNVfoag6R+rpYOE4takArgnHSpcGA9aXM0B1kQNe1V0Vp
 CFgnzZI1dqYwJukqDYgRpEQeJIot5Xuz96UPTBhDHeRpQG1irpBtneArCSYbBZo=
X-Gm-Gg: ASbGncut8vxGYJG907E54aO7Mc/+KsMCawvX3SLboKXvE2e2EJsqrS3hwnxg2QmpvQU
 tY5vnwmLqt1vl1+Fb8wkR6DshZIXgHJr8xg80Y3DRFj+tGJQOWkwr3NW8PeK5SSxt5E8bbM1N++
 oK02tPCwnqbuCbN/bkIhD2tBepliFNiSjbduZY7qaSparhsLrDDoBZVCQAV8lnzsJUzfJH/2M4U
 ZvbhmdLAlflb93sUh/ymf8OVLj5rg9p0lUWuCo6yCDV8QRsZhY6qHPyT3dl5sBtzwYH2KoUdLC6
 RErNDiS9NRkty3ZT8g==
X-Google-Smtp-Source: AGHT+IEEOm2UOUGLv36zJ2tvbqYjmJBygmkE/iuTSc/JWMCEFBeKFiXnRGOO4D8hzyyOsPp1ci2EVA==
X-Received: by 2002:a05:6000:4007:b0:382:4d54:2cde with SMTP id
 ffacd0b85a97d-3862b3cea94mr373934f8f.37.1733432763295; 
 Thu, 05 Dec 2024 13:06:03 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862190966bsm2963202f8f.75.2024.12.05.13.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:06:02 -0800 (PST)
Message-ID: <4ef6acd6-6d40-4cb3-97f6-362552c7f7eb@linaro.org>
Date: Thu, 5 Dec 2024 22:06:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/ide/ahci: Extract TYPE_SYSBUS_AHCI into
 dedicated file
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexander Graf <agraf@csgraf.de>
References: <20241205131937.32833-1-shentey@gmail.com>
 <20241205131937.32833-3-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241205131937.32833-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 5/12/24 14:19, Bernhard Beschow wrote:
> Implement in dedicated file, just like TYPE_ICH9_AHCI.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ide/ahci-sysbus.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/ide/ahci.c        | 67 --------------------------------
>   hw/arm/Kconfig       | 10 ++---
>   hw/ide/Kconfig       |  4 ++
>   hw/ide/meson.build   |  1 +
>   5 files changed, 101 insertions(+), 72 deletions(-)
>   create mode 100644 hw/ide/ahci-sysbus.c
> 
> diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
> new file mode 100644
> index 0000000000..d43db0923f
> --- /dev/null
> +++ b/hw/ide/ahci-sysbus.c
> @@ -0,0 +1,91 @@
> +/*
> + * QEMU AHCI Emulation (MMIO-mapped devices)
> + *
> + * Copyright (c) 2010 qiaochong@loongson.cn
> + * Copyright (c) 2010 Roland Elek <elek.roland@gmail.com>
> + * Copyright (c) 2010 Sebastian Herbszt <herbszt@gmx.de>
> + * Copyright (c) 2010 Alexander Graf <agraf@suse.de>
> + *
> + * This library is free software; you can redistribute it and/or

Normally hw/ uses GPL, not LGPL, odd.

> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */


