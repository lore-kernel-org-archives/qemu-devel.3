Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664A4C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 15:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPOH-0003nj-7d; Fri, 08 Aug 2025 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPOA-0003fe-SK
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:52:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPO9-0003YR-87
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:52:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso1665403f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754668331; x=1755273131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f7oT8vg7HMFo/rfWiiwua42SUDaULdyy8fUyCy39DeM=;
 b=Cy0fwPeVT7Uf0j4+xLRX8B+3AMPfUGiCuTew/dzFDo3YMSleWa2mmqubS36yf7CJ4r
 gOh/fGaxPgS5Q8/W4LWfjXL9RhDVp/QkO3uiiZGfNFPKDqlGKNUfgY7La1adSmtm08wE
 0LHwuSnR1CnxMpXDBFe8oZ7LzzhLNGwxNxJkTm4VJpRcHisz+40xt3cHXcal1aH1EQb3
 DUd2gjlIlN8G6891j6wRlOAx92r2DDvi8I5cbg/zR08JJuHfl7VoN4r/3e1eFM8eFMJn
 U/0QWxk0VzlHKcuNRpByg8Hd7hMi4HZjjLzy9nidAvUhlrrzdA2bAmU5ZX0KTmTwPXl1
 PQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754668331; x=1755273131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7oT8vg7HMFo/rfWiiwua42SUDaULdyy8fUyCy39DeM=;
 b=N5Dqg2IhGUEgK3m/2m0R66XeNaGUmWiA2iEDAFOAFccORAQPrWb1S7TMSaKYU2+35d
 EVxRD6fi4lYpDgE51VrznXzhhBJzE0RNed08/O0VH0m+1kLd3YrKiJcekBXzZODEj+eP
 ltvtr7KKM0E1TpUuDa+TDxMbiG1Xzx1BbJwpfAthchlGXP6qaPVdaMGS9sNqQyAjuiZr
 54zAZ/i+27XB1xn+rw3Xe8SpPIShAXOFgXB/Xb+LJlvnSfLahJwktp4Oxmhcsmrlf0Pv
 UIbFk/9NwvLmSweeSI5V14xwxXW7ej9oPwsCO2yjRIZ/Uz/vpKfIAIo6RUSinix6ev+J
 FoXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuv0YaoMKq4hLtWxs3y1v7UWcVx3pRM4LkBGiJjAmb9xr5escMx7UsN1xWV+O8B0uvltYl2GX4gxRu@nongnu.org
X-Gm-Message-State: AOJu0Yz1j7IFxmZFtA9OLu/0rNDONvBloyGUbamuQnmub7vypU7XFZyT
 O/VFWDu78Y2y4nRpJlZEFawiLzj95lmA9jO4W58kzyS8PIQewCgUS9KBGYqjDeYtmLE=
X-Gm-Gg: ASbGncuNgl8z8cUc9Oq2MZ68Itg9Qb1xm6s7JCif6cjs+ePyulYRndnPDfSDHwiS8lQ
 YhN+/elpop4AJ2aWZRzvYbB9XNpY24KpO103mGp9eD7pWDvMTIStlufylm0jXG1ii+CheaYLu5N
 dDVBJ17/2U2HrQVJzQXXBeYpfHeg+kpstG/kaVIQ0Sv7jcNWoAUj1oWhdXWeRElt6qxHqMT6bP7
 viaxgKXXKHzmz/nqZT2KRznzE40Yoqnws0If3lrEHN3MskUd7K3mXKOALaPOY/0FQo4jgepTvDy
 mCMQjljmjEwznkBmASRJI1tXIKspw5YA9BbCEiQYVUIY3vEQNzf8pM5kl7mK9a6h8gFt5JwSUzG
 RPBDBcitwaXFjfcxKhqY/CD15HOdKkSR5HcI1bOGqFrRyGsXjoU/5hm1//jjf+S7H0A==
X-Google-Smtp-Source: AGHT+IHYn+tlP0TPdz5qomcIZqdRf8ER/rsL3zip1JDD5AGh7alaEnE1zumE4m/yiycVxz0VGHTbvQ==
X-Received: by 2002:a05:6000:4028:b0:3b7:8842:8a0c with SMTP id
 ffacd0b85a97d-3b8f97ec49emr7295254f8f.19.1754668331440; 
 Fri, 08 Aug 2025 08:52:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e3d37439sm88430145e9.2.2025.08.08.08.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 08:52:10 -0700 (PDT)
Message-ID: <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
Date: Fri, 8 Aug 2025 17:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 17/7/25 11:38, Djordje Todorovic wrote:
> This is needed for riscv based CPUs by MIPS since those may have
> sparse hart-ID layouts. ACLINT and APLIC still assume a dense
> range, and if a hart is missing, this causes NULL derefs.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
>   hw/intc/riscv_aplic.c  | 11 ++++++++---
>   2 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index b0139f03f5..22ac4133d5 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -292,7 +292,13 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>       s->timecmp = g_new0(uint64_t, s->num_harts);
>       /* Claim timer interrupt bits */
>       for (i = 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
> +        CPUState *cpu_by_hartid = cpu_by_arch_id(s->hartid_base + i);
> +        if (cpu_by_hartid == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid hartid: %u",
> +                          s->hartid_base + i);

DeviceRealize() handlers are part of machine modelling, not guest uses.

IOW, triggering this is a programming mistake, so we should just
abort() here.


