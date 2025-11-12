Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4618ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ53f-0000FF-Tx; Wed, 12 Nov 2025 02:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ539-0007xc-GF
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:13:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ538-0005ZP-2c
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:13:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47754e9cc7fso2654105e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 23:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762931626; x=1763536426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JP15IZWR8qAc0tWzr+vK1k14ifPXVpBaDW6ReMVdEJ0=;
 b=GYEmHZkDd/cP+lc4pIycqnsA/KYmUAr7/owH61U1eiUJdXZOahuVT0goVAMJKlSwhv
 0XOsXo9WFnEklLAxMckfD8EfrDwYW18bsCQTDSlHMKI9kATMdLfzn6jaSonEGz7qb1yW
 WZUfY/JongV/9FftvXjkQqFgA65AjnovcjV9MoHbxD1oE9byTn9OrD0Fy6hY45gAb/d1
 ERQ1FuKeNT17mVdiwCEJeqY0PkqjaY8M83QnyvyL3s9lqZ0j4ipqrDiAlXTTlKVrbx8T
 yjNX2OesAL65LqEfCOiwXE3yPfTtnum9+n1WBJCsGs2FddLtFksrQiKUMSoKDErMVdZf
 8C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762931626; x=1763536426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JP15IZWR8qAc0tWzr+vK1k14ifPXVpBaDW6ReMVdEJ0=;
 b=oGC1oMbdusd2f7/r6hHI1Fuf7OMzs/6NQwf9SZdmnTMwnhw2IbNlYcQt7QQnHdR8e1
 MBj0YFwvER/Y/IVCPNO/H+CPdZGJpnCx8dHHGjPmzOVDcKBITnHhH+WpQ/CHmd8kp4az
 YpOuQAis67BHlCciMksc0Pz89lVbbVW4UuS67FKEqT+bLi6sDGQkNeUGxhbvnf0A8xej
 k9lsJABmAidtUmXy/Z8Cv8cJtmhDL4xrgzVwabr9pPYQejvnA3/ORFk1TXqmAT3mF0K/
 12Jap5B5HFWLnS4tuf684gbk9ZnEIXZBmFCq853QuXqrwSqGlfqWi6O/7GSCJUA+7KHU
 XkMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+r4L4g4qsOuUpn7/ArI2UuyRZHOWeDHyLwfm9rxAliOUvRT8NGougkS2IBMHDE7zhY9PKnKBQAfRh@nongnu.org
X-Gm-Message-State: AOJu0YxS9kw7yk8C98cpClTzJSekJGi3tTTOLfjxLPX3y8KA3Vof6OAE
 NheOHpQ+PJDvnuQ55B0xUbcQ2KGxkBRuk/t76hIDVgZBor091aNcKRVZddZcJamQhuk=
X-Gm-Gg: ASbGncv9SGwHeXw2CPKFNOgUVlTYMYTrazBMOx50NI67eITVyMycHxPfmRQP43LgfdE
 g7B3KNbU79f41tmnc8zPLmh7RWS5S7QUsyxYeKmtlnvils5pIXXcrgdYYlOAfo3ZoCcn/l/M8m1
 7bIscqo0+Lpp+PFxKB0ZqRRo0A0PI8pBbDHZlwOso3mbLpEq6pohTuLtSsAXBZSFR1b57zSn84t
 XjU1EhyNXZlCOfs5p6zMpd7oVpHxEJJupyUu1ROWd0XrBXnqkSiQ/9nGgPFcitEPpAcKsyX6E1b
 vcsUkX8KFFpIhATgmPbTGkE+0yIxXW7Hzv4AYzae/SvYoqkOVPKMg827mvD6Mf49t0h3HD3pnP4
 SXu2x+VEiDCg968yPjrxeyED+jNCeQBkv/FRX+jK3+TL618WCRQ4lRF/l/qPtX6Z07abhnCxc2E
 i/NdCVss4hpHnjq9b/ZSf71Bxj0gn+YjykMqWI3dYLO8FTv0k2X+cN+H5oBCI=
X-Google-Smtp-Source: AGHT+IFgDUFQCJ7adEN0Il+lrYYzAtCB2COR3CBdk/PGv+TskJHC5uo8S0feCdXbxgFzyDnT/oXisw==
X-Received: by 2002:a05:600c:1f8c:b0:471:16b1:b824 with SMTP id
 5b1f17b1804b1-477871c47b6mr18358705e9.28.1762931625640; 
 Tue, 11 Nov 2025 23:13:45 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e2bcf9sm19860375e9.3.2025.11.11.23.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 23:13:45 -0800 (PST)
Message-ID: <6697cd8d-4bd3-4492-9e43-b56d65709187@linaro.org>
Date: Wed, 12 Nov 2025 08:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] hw/riscv/server_platform_ref.c: add riscv-iommu-sys
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Andrew Jones <ajones@ventanamicro.com>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-5-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111182944.2895892-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/11/25 19:29, Daniel Henrique Barboza wrote:
> Add an always present IOMMU platform device for the rvsp-ref board.
> 
> The IRQs being used are similar to what the 'virt' board is using: IRQs
> 36 to 39, one IRQ for queue.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   hw/riscv/Kconfig               |  1 +
>   hw/riscv/server_platform_ref.c | 78 ++++++++++++++++++++++++++++++++--
>   2 files changed, 75 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


