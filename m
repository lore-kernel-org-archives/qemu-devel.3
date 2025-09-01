Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A301ACA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2Wy-0004Fj-FJ; Mon, 01 Sep 2025 07:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2Ww-0004Ew-4K
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:16:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2Wt-0004fT-6d
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:16:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7d87b90fso26232235e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756725409; x=1757330209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SeDYy1DEgpcx4+sqiAQw9KNiJu2uZ5LQ1cRlI1CZNsQ=;
 b=AFXhgxL4/wbsgdE9DlSToEyQE4tZ/du+BiD3xeo/Y13AqcC0D6fw87oveDDLxHX1gC
 sYs1EsYc3SqHVhQDjpnekMhS7eLqw53TY3eRRnOXDmD2XlydzUHbZe6CZAu7eCdymYN9
 fYXhjXz7H99u5dWVfoWJeqgaSs9oMVm5FshzljZy8r+smAfqXgRSsBWXn+10MPirdq2j
 aXqkH+sL08YCFTlSvxf2MyPQWjfWNPf0fkKl8kPEaAYsOhtZ2JkM9MOzDvFS0ygTOaNp
 gLtmPZvRhZ6Ej7feK+qdaY2npeV055uvYV3c657SHBzyaMC/s70YSA/MiTL3CFO9szoi
 9t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756725409; x=1757330209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SeDYy1DEgpcx4+sqiAQw9KNiJu2uZ5LQ1cRlI1CZNsQ=;
 b=ZRVraNj6dT0hNNtYyQDWdXlVJCpVry23dCL253mJ2FJ+HLGUsbygAPjJcu46MYufUW
 /shtVbPwBc1kxfjKMKfQ7qausinP64dUsgFSA2Vs5kCq2RxGQW9zy0q/VhTug81yZSb1
 rC5aT1hrbWBCrSq+7vPzrrN/+3yZM7qIECnRwx8yi5pJ9Lc1S10suF5ai90xNAecuAix
 IJxIuqUvzgoHjiAkgxb36eSbxqIBHff4N0kMY19Z2dQfhptFA+7BKAbMhV5ZPXLiL/J/
 BxTLVHru/lZWHuS2mgFDHMt/dieYPy2/YPX29JiT2jH4D6hYKK3ggwDzHWTo6WiN4PpR
 B8Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyukuQ9w847yz5o5g6ERcMQpiHQx8AlFYh7foN019ZDDYyI9GNzArsOgClPcNAaobOOG1vu0r9nPM8@nongnu.org
X-Gm-Message-State: AOJu0Ywm+MZDnYnTItHcskdoa7E3XfYoiIMsKbCw8BYcRDTJ29jgZRNN
 4pPMg3di3aIeGk9esLwUbCeIVPfjXT+CoQSYIXSyEj/KMd+iXng+gqAJjX4W3yK1rtA=
X-Gm-Gg: ASbGncsDCmdWDOb0Ig/KgiITCvIf2Td8VXspJ6hLedm+ybRLpL+u/YiJmMFSjEmS4EP
 WhIuGOk9b9TDeTTaWe0yl+969G5qMoImYYd7+kQZWD8RxrsEmWXG5ClVQHbkDVyYegiQco4bD9/
 sTroYBcTU0+5Yfi9IK0xVZfPuldfWP1Mhgy1r3dSRtW4lGgh9x8SF+l0Umy9zZd4la/E/MPaXcp
 X+6KJ/eTq11JM7czqRSIHgOKh6KjvVUDph4zYibxvj7yCW2SKycllgg55uC/VAwozJ7dqljgGtW
 p0yXMkc43WFV2MyO0PL4gYaqGwBfqV1pFimffNE3ge5wFCT2kAQoBB9fRD+7tGYbO6s1RwBK0SI
 nhrQXNRnKH8w5jG/wX58gLmopunfBwtoP9YkZtmyekTSmQiryQLzMq0pxa2BohSlfmzmma73ady
 HE
X-Google-Smtp-Source: AGHT+IGYCiFhbzG8hE1HPz2tiQL8ZlJymxcKbWzkZ5BTsFKvL13gq0SSyI64VNQEDIRSNJBBmZZl0Q==
X-Received: by 2002:a05:600c:35d5:b0:45b:8996:997d with SMTP id
 5b1f17b1804b1-45b89969e0dmr46245175e9.16.1756725409510; 
 Mon, 01 Sep 2025 04:16:49 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d141esm157883025e9.2.2025.09.01.04.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:16:49 -0700 (PDT)
Message-ID: <a250edb4-7df5-4e3d-9f82-361778d8612a@linaro.org>
Date: Mon, 1 Sep 2025 13:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/14] hw/pci: Allow explicit function numbers in pci
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
 <20250901102850.1172983-13-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901102850.1172983-13-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/9/25 12:29, Djordje Todorovic wrote:
> Since there is no pch_gbe emulation, we could be using func other
> than 0 when adding new devices to specific boards.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   hw/pci/pci.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceeba..0c6d11e145 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -984,14 +984,15 @@ static int pci_parse_devaddr(const char *addr, int *domp, int *busp,
>   
>       slot = val;
>   
> -    if (funcp != NULL) {
> -        if (*e != '.')
> +    if (funcp != NULL && *e != 0) {

s/0/'\0'/, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        if (*e != '.') {
>               return -1;
> -
> +        }
>           p = e + 1;
>           val = strtoul(p, &e, 16);
> -        if (e == p)
> +        if (e == p) {
>               return -1;
> +        }
>   
>           func = val;
>       }
> @@ -2054,13 +2055,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
>       int dom, busnr, devfn;
>       PCIDevice *pci_dev;
>       unsigned slot;
> +    unsigned func;
> +
>       PCIBus *bus;
>   
>       if (!nd) {
>           return false;
>       }
>   
> -    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) < 0) {
> +    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &func) < 0) {
>           error_report("Invalid PCI device address %s for device %s",
>                        devaddr, model);
>           exit(1);
> @@ -2071,7 +2074,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
>           exit(1);
>       }
>   
> -    devfn = PCI_DEVFN(slot, 0);
> +    devfn = PCI_DEVFN(slot, func);
>   
>       bus = pci_find_bus_nr(rootbus, busnr);
>       if (!bus) {


