Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C36C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWJ6-0008Ct-Bb; Tue, 18 Jun 2024 06:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWIs-00084h-Vu
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:43:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWIq-0008DF-UM
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:43:06 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso615329266b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718707383; x=1719312183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D5NbY79AM2b67sRaKHbPCGnmscd7M0SYUDO1aWIC8FU=;
 b=fF/7uygIi0qwMZlrcxR28tmcZrzrmLUjP085+VtzG8KkAXkcBoduzwgw68pu8T7Uwt
 pc3PXdnkXOoTjGAqXcDe3Xtx9fKn/Ay4it9cOI2AasrmozMHDA7tZf/vj5nNjvRpy5Eo
 OynrTDUSZi1oTb2UOL50ucOlPIuWZ+KyN1RTrMvOq9e/YsNVuUBVgTVDwdF2OH4glL6I
 Hx00ueSI5QC7e6FtawL62xMXAjH1gDZNWFnmMZvR0/ZAlg3oakHymeD4TxWrQbJ3yz0J
 6wSmjWPP3WKWcMKRqUlQz/PdWrPSDROtqiZoei+vSu6LWz6k64/hjvn1JxouUzH0JZls
 szVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718707383; x=1719312183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D5NbY79AM2b67sRaKHbPCGnmscd7M0SYUDO1aWIC8FU=;
 b=GztESNbhNhrTaHLyjYA/x1ocDSgSt6Z+ZrikqTyHwu3Z5RKGn0LGj7uMXD4X1Iyuj0
 PM41tKxebWxUBZm/cB2D3qb9Bm+0VN2noWSM4bymHT+t0BX3c5wSOyYoTkdBTlLJq8S2
 y3/ZQapI/4t7kIu9xF8oacu015MvCZRDIHoLJneOTXhMq5kwn51cOTwJDfuEfYiid8Ed
 tx1bD/H/6cnId+Q/iK5nMMPheNDs3Wf5ctVHFZoLEtc3vJItLwcNO4ETDTnMdeGmtiQ+
 /QHhRZIvaqEZ4IaISbB43vlY9NqAfoxPERkUat1//oKf7A91cpa/BUCQttsCyIEkFQ7u
 XuNg==
X-Gm-Message-State: AOJu0YymuHCHOscZVBaBgM9uCjdII9zSwiNUVb2ZRvGY8wZmk84LDubA
 EgpmK0fji8T3UyNWZCILKrw2gBgtk/EqmvOGx5a9A+6us5KFjx1b0exYdsD1Q4PvoTiqtLAR2KA
 wTjo=
X-Google-Smtp-Source: AGHT+IFE5HxIoRk4QugCDHQDlXw6rluxZYAc/DUe+gUo66tZDkMa1B+Wlp6USKF4lEZhQvPfnfVCkA==
X-Received: by 2002:a17:906:2c02:b0:a6f:24fe:f2a7 with SMTP id
 a640c23a62f3a-a6f60cf1dcbmr785391566b.10.1718707383031; 
 Tue, 18 Jun 2024 03:43:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db6b0fsm607309366b.74.2024.06.18.03.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:43:02 -0700 (PDT)
Message-ID: <109bd3c2-e96b-4cf0-9445-796cf270c756@linaro.org>
Date: Tue, 18 Jun 2024 12:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/6/24 08:20, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (26):
>    hw/ppc: Avoid using Monitor in pnv_phb3_msi_pic_print_info()
>    hw/ppc: Avoid using Monitor in icp_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
>    hw/ppc: Avoid using Monitor in ics_pic_print_info()
>    hw/ppc: Avoid using Monitor in PnvChipClass::intc_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_queue_pic_print_info()
>    hw/ppc: Avoid using Monitor in spapr_xive_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in spapr_xive_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_source_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_end_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_eas_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_queue_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
>    hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
>    hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
>    hw/ppc: Avoid using Monitor in
>      SpaprInterruptControllerClass::print_info()
>    hw/ppc: Avoid using Monitor in spapr_irq_print_info()
>    hw/ppc: Avoid using Monitor in pnv_chip_power9_pic_print_info_child()
>    hw/ppc: Avoid using Monitor in pic_print_info()

Series queued.

