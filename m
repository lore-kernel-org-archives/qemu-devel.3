Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D69C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSZ2r-0001RS-IT; Fri, 20 Jun 2025 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uSZ2q-0001R7-MB
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:32:28 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uSZ2o-0007gE-Uz
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:32:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-234bfe37cccso21544985ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750415545; x=1751020345; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uDwKMNx1mSagwkEShBDuK9Ye1aPRQHv6/W4/I0+em/8=;
 b=FpnWz/O04qMo5ehM3tQ6B8wa3p/KnF2H4Q8GPx8VB+ZhS1pqJIZsGS5T92ZN9Hjt8L
 EdV9hmSc+0rMY3CmrCYlTjXddPKL/JbetMKn+X6udq+I73+46edpJb1mKGlH/4RX9KWc
 SBk/63riwKgB0wzZ50TLTxgtmQh4q1T36TS8pFDSdMEWBUONPArLmCmh8RPYYcIEmQqE
 686ZJv/ZGXTjgoEHMhXo2u6j7TwcBXll00wVBZuGMLukY13RLTInSIClpe7oaZ+8331t
 yjLBJKB6FZ5+1af9v7iIlKxwJCBCGVBybA/PK62lIHbaLlEmcOTZQ2d0BO3/rut3GeAI
 Uj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750415545; x=1751020345;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uDwKMNx1mSagwkEShBDuK9Ye1aPRQHv6/W4/I0+em/8=;
 b=NzgUrVPg2bq4QVJ2Ayc0n8Is1eFEsfdkUzguRMLcL+YJGihC/sgto/0M0lXiTCIxkh
 YqJ45cLCLJ7K4zJXk0wITnuYuEMZKjMIYqs2sgAso5lPFitBXximnPp2+7/aESh6BZfd
 M3GvpOTqHOaJl5lYGjnz8VbFTmarT9IjX6nBXSxnnABsBkDtkJMG2Dj58wn4C0EqcOPw
 zykZYD3+6ztKMNcA9b0EupxBN9UbSWdig9R3AXNt1k+dW7+TkOhOs+JWD/kQcHeDpcK+
 bmNXorOASlVe9v1mt/dIU54AIKK9fKipNyg3mtOintritF79SgV8XKApiRxU0dHrMklZ
 Q64w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxByh4F0BYHv60ImH9RZnTHaerDnPGCrYHEdJU1oxvbwfLCfMH4SV3pPhZGAGgyzxCixzUTEBXDdo7@nongnu.org
X-Gm-Message-State: AOJu0YyT04XgHHmLGfW28nmGro7LtY9/7KBsuic0dU/4V5ecO8hZhiHA
 ms5H45h1qc82hckBfgp1FYymkwnii7WVuz637lyxq9vDZrO2f5ntWJhU7jFKSqWxOSTL0fmczH8
 NdbCeaX8=
X-Gm-Gg: ASbGncuB8u8fYAiOkvF/BK5hg4oMtq3yxyer+HAwGToaDLl0eCYGgqOh9LC43cvSkZc
 1IXFQdY5ohjBU8qb4hyDitkzPTxJbb2mQdv8/7YuSl52rYxMwI/6W4QHTRG2bYRmtRez0KD/lMO
 bkDM4sgZqSPbpvwhJhLi8Z5pw1YPk7XWTHRu2f/wDbsVYfbN5tCN4GIv0FfPir/mS7PDF4mPYGp
 ZYv6atJcsb9GMx3l9kj9QYVcGhmt5VJkXP9JLcTxLaaRDRr9Zgtq4gnN66B2AtcBIMSqh+oFXls
 Pih6aoz5en42Z/VTSDVBzeT2vA3CN/448SU5SeiBGK98dH0K0HozpWrrchnp4+YnMcE6+Q==
X-Google-Smtp-Source: AGHT+IGUU0tu5VrY6yvsUN/91i4pF8oEFnvf5F/kJ4PNsvpVSfSc0ZTbXQk8TBf3NYa0OzP57RDSOQ==
X-Received: by 2002:a17:903:230f:b0:22f:c19c:810c with SMTP id
 d9443c01a7336-237d9af5126mr38978425ad.51.1750415545147; 
 Fri, 20 Jun 2025 03:32:25 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83934afsm15316045ad.22.2025.06.20.03.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 03:32:24 -0700 (PDT)
Date: Fri, 20 Jun 2025 16:02:16 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: liu.xuemei1@zte.com.cn
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, bjorn@rivosinc.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/riscv/virt: Add acpi ged and powerdown support
Message-ID: <aFU4sICRkvlT3GIu@sunil-laptop>
References: <202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x629.google.com
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

On Fri, Jun 20, 2025 at 11:30:09AM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> This adds powerdown support by implementing the ACPI GED.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Co-authored-by: Björn Töpel <bjorn@rivosinc.com>
> 
> ---
> Changes in v2:
> - Unwrappered acpi_dsdt_add_ged function
> - Modified base address of VIRT_ACPI_GED
> - Added conditions for function calls
> - Adjusted code formatting
> 
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/virt-acpi-build.c | 10 ++++++++++
>  hw/riscv/virt.c            | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h    |  4 ++++
>  4 files changed, 50 insertions(+)
> 
[...]
> +
> +static void virt_powerdown_req(Notifier *notifier, void *opaque)
> +{
> +    RISCVVirtState *s;
> +
> +    s = container_of(notifier, RISCVVirtState, powerdown_notifier);
> +    acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
Did you miss my comment here?

> +}
> +
>  static void virt_machine_done(Notifier *notifier, void *data)
>  {
>      RISCVVirtState *s = container_of(notifier, RISCVVirtState,
> @@ -1703,6 +1730,11 @@ static void virt_machine_init(MachineState *machine)
> 
>      create_platform_bus(s, mmio_irqchip);
> 
> +    /* acpi ged */
> +    if (virt_is_acpi_enabled()) {
Daniel has already reported the issue here. Since you are changing the
ACPI tables like DSDT you need to add additional commits to update the
expected DSDT file so that CI tests succeed. Please refer to the
comments in the file tests/qtest/bios-tables-test.c for detailed
procedure.

Thanks
Sunil

