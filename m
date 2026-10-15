Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCE7CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLw9-0003xv-BL; Thu, 15 Oct 2026 09:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHLvy-0003tr-6m
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:55:51 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHLvw-0001FM-JE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:55:49 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8a83d2706fdso20924407b3.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792072547; cv=none;
 d=google.com; s=arc-20260327;
 b=QSGzRyUHbp6/TlzxpOdLKSVQMFFWiw/MnXbIf8rLje+64Bp58aNaDs0c3miqzoe+Fv
 X1087YMmTrqZDOGPw9FXSMwJQ3Sep8kdYxNJMIsBfB3pJE45nWHI8NVpmiA5GWWA3N6O
 oqdypcYLZ4I8KqdNsA7SapS8KHls9zVhZmZC5He6kTjHIkqJhxmv30bsfMx9wFP+GrOp
 03xNfcYNDTdOCLtso6My5KJv031QAtUshSTLj5g1hCQIVdzZay9/GqQWc77Qiaw5EGWM
 LV46DMXTNG0TWibCZuf9oHeCiCADZ7WK4yQu80GGCb+kveMGnLVcc8sa0bcr0GSq8uIk
 YlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M0gpN+JJF2TYnnPqlU+Vv4DSdt+bcp5pdt9jGNK5vkU=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=rykTaWta8T9R1atjjjAxzoHfYh5hLCxpar1A0POshHudxf/C+FdGJZXFU4FR1rU/XO
 kdAUA4POD4MQ0zz21wB9NAjToWWCG/RJl4W/t7Nbt3M/djPAUas+UhRg4tTqFoXqwtxX
 5hw8A5SkixitWiq69VJUwhjVBWMin+X+FjcGJ0B5odszseDfBhHtiZIw9V/gTAofhOOp
 UTCAQdL44WKA5U+5tn+D11Pt/0w96cmgXPdo8pNhGZlkqWAahfoU0MQbmbMgyEQSJDfo
 1N2mi7JljmefQBVaJyZ09PEta8XJqX/x88GUXs3K3vU0GlZE2b1KB77bVBeWmRPaY+Ph
 k82g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792072547; x=1792677347; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M0gpN+JJF2TYnnPqlU+Vv4DSdt+bcp5pdt9jGNK5vkU=;
 b=mNF2krjVyavyp3fYz6LPRktcTYNscm35hI1JVODqH2Xlj5wYcodTqDsxjnF+MiwWPB
 ftPUJSS9FNrzFrmr5CjI3qf5+pOpDqK8sWkDqcfoHw0x1A3iuGkt89Pj3n43YBLpR43L
 wKpF3GtQbX9FwcUNut63bDiQjMMgUdQO/wTT/2rIb70FnC7tnOUUl1fAZ/DDaaWATflQ
 vCHk5xMdN1G4LV10NUlF1k2RCogcVwjQljXBHYP1IIU4rQqSiA8zVj2/Gbs9rjiMyuod
 o1waYDVTmF7giVaaQaPdLrBRQX/mliXoc6YdGA4Hb9dwSYx+xrK+FTodUHnweL/qBumD
 9m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792072547; x=1792677347;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M0gpN+JJF2TYnnPqlU+Vv4DSdt+bcp5pdt9jGNK5vkU=;
 b=JHOBzXBP6BmtcMFdUNWNR6LAY5Zjiy/6+yOJMBlaTCxh7MyvC9r2yL1Xcr9uHDw+I+
 9V8jI8smsEeQYTjNeP3YUvDb7xTPGEJeF6qH0l5cX7V9BQZ+61j6kqdItH2L3rg93Lhl
 TNuFIMcCjgrMVm0edWjS5HgeYRwJxI7AeltidakyGjejsgfGDG9cq+aIKZDrwGhmEZUE
 AbeIvRIY5yU2FeaJti8IWifxNVsvKdoRyPA6pJL6PrAqrKgnz5tTx5UGb4tcmJsXK5JW
 M9A6WNc4wNU53BlHm3JGlsI6DxdE6VUewBvGwocybHBtTlVdMoBxOz8OHHp0e/TUB8cA
 gt/A==
X-Gm-Message-State: AFq9FYKgpg8gGHqMSwBx6vP4DsoBei8Ou02TeMVUkB2kG5qYIBTAVxhX
 ajA/YlFiTrYdGzBUj8XQw2ffENrcqG8ixERUske2+4uovnjqmDxx9oNVy5nuHjM9rvfldC5E5W/
 lpx5HyCnPd1JZTocKNNboohqWlY+4PgxdKIWbXlXKvQ==
X-Gm-Gg: AYBFou2dJYHbRenbyTaSWJxEFGmF79PIzgkGgUQHsOUnDza3SWDHELZpOisNfkPNDnj
 YHk537FNHi10ohtukjGxWwERU/Kx7GsRBA4n3IWnlORo+/2GLagqOda37XYlb5BZAPAp9GSXMgY
 Vh1229RPIceFocxIdx7GRl4XiSrxJ+O6MxYkdpWIe9Xn5dzIg+pa5xadEgBS78NehDS4/Vpc4Q3
 qYJTP35o71uSIAz5egrLNvFe2cWm8fHgZ2PAoJ56YL+FgksMekYp8puRcD3sl5oMRmgKOqY74lH
 UUJacXgVwCNuiqtszVPsaQBwwc4aWT/sc8mghJF+F6Qkivyx5lsAIj+qrF33Ao2MeGQ5gznM8NY
 XzYjxcIDV/ghHKH7EpHtP52RU6pRGaSHr1uvWHGw=
X-Received: by 2002:a05:690c:7447:b0:883:b158:49e7 with SMTP id
 00721157ae682-8b07edb8f64mr63710757b3.24.1792072546632; Thu, 15 Oct 2026
 06:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 14:55:34 +0100
X-Gm-Features: AclHuK9725igU50cCxm947ufpQXnYLIptKQMBhaQ8cS6EWuDU6ZauTOTTQ8FQVE
Message-ID: <CAFEAcA8Jj=+Lh1vkk9Zytst06cwD72EPy0VQ5759OG2xhx8Vww@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 11 Aug 2026 at 15:35, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> This series gets raspi4b's PCIe root complex and GENET Ethernet
> controller working end to end: the PCIe link comes up and devices on
> it actually enumerate, and GENET passes real network traffic (DHCP,
> SSH) under both older and newer guest kernels.

> Marcelo Manzo (10):
>   hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
>   hw/arm/bcm2838_pcie: add BCM2838 PCIe host
>   hw/arm/bcm2838: enable BCM2838 PCIe host bridge
>   hw/net/bcm2838_genet: add GENET stub device
>   hw/arm/bcm2838: enable BCM2838 GENET controller
>   hw/net/bcm2838_genet: fix PHY autonegotiation-restart deadlock
>   hw/net/bcm2838_genet: fix bogus RX checksum reporting
>   hw/net/bcm2838_genet: fix TX ring activation check

These three patches are all bugfixes to the code introduced
in the previous patches -- you should fold those in instead
of having them be separate commits.

thanks
-- PMM

