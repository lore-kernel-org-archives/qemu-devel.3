Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF82C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkCK-0001V3-UM; Thu, 12 Jun 2025 11:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPkCJ-0001Ur-Cz
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:50:35 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPkCH-0002br-H4
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:50:35 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e6bddc30aso10104007b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749743432; x=1750348232; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OLTAohOKFgTsQdF8xG81s6MQnvoE3qlqimT31SghPbw=;
 b=wFAPIbc9CKupDWlTni7RFIPBLVwv0q/3DqHRcD2RtfxSasR7SLMp0rwA2bSAaQKitF
 9c2UgrQGKCSWXOvNF1vstfcPyI97EcsEX44mEIrAJ6lDGwQCMRclXi+UD0ZPBbRYJxPx
 GcHReQib+k1vcAeaFxw09wN2QYwoChwSDcXGxPrVgg3tq3IrIKuc7EHTUzADgUu7flcg
 3pdCqdFkKo1gKh+9ioWzGd9/syFhU548Kx2b6rqooDfpjUApbINwdMT9QqqFRPWN0vq1
 7WoY+ugi+iC6+pZr8HODSzjFP/s9/it1AW4mzwVCu5SALcB2E2gQojUba1UfEPcsEJ8b
 0YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749743432; x=1750348232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OLTAohOKFgTsQdF8xG81s6MQnvoE3qlqimT31SghPbw=;
 b=GQtJQ0sZ0Z1r1SvwSDOFqqUVs7v9m5cltKWQ6RB96oJVYpjH0YFqwV3j4sUIs3BSld
 sfuM7KSSIL+3IbYwXEDwI9yyyybFfZcO0004uwjBpEgOWwIU0K+mOdvsb5nJGcTy4V6i
 gq/pHzcRcKxO2avzoex6mW7pyn7LVSixBQE13AmwgGIWgJN9mCLp97luVgNBpiISlWut
 AVleFof5KJlyIZZL8AzQ3JxTI5Vb4N+b2RCE0Q2AhUoT4WH0BNHnuYWZp/z/psUNhKT5
 vOhW/loLUBfOpMuJ737+qq5wtd4Bb9Mj7p5sxrR9yYzOtvh/9jdJclDB1w8fwsDMU+sy
 FnAA==
X-Gm-Message-State: AOJu0YzUi8T58fD3me7CaQEpZpuVzOUXsii/czL5uR1mySDBUeoNxt4o
 UfCzuK4qgQAJXSSRQtXOVdWounfdFe+1634SaaClXiF+LFzeMojjnPXAv5Fb0Jw3Kw7lA/mGDOe
 m0ayZB4ZamptA0njdMkyF9JFTcm6DWfaqYS5aM7OlWO7DSFEWZH/h
X-Gm-Gg: ASbGncs3HucnhKIjiudMj+CncEkWRNloFChKBD0TIa6RvEes6z6GpMamvAyJmPNZJtD
 N30ZgQ/ETqJUd4409AHevh26h82Tg86bzrLogSGxr4TXcUNjfRzpAz3U4JH/pQLVtV0CMm2TIGd
 jmkHNNEgz3akdQnqV6Pwmjnk6VLlPkGNXIHzQr1sCzgFLvoOKTQW5RTOc=
X-Google-Smtp-Source: AGHT+IGYecH4xH9rFhKOy21dXSWJ86V3yZTV0SzSmJ+WHYV/ceNVnTkgVBQuUjBpFRwHbiMGSfjD2yY0fxz77p7FnE4=
X-Received: by 2002:a05:690c:fce:b0:711:3f06:6109 with SMTP id
 00721157ae682-71161ef893bmr6076977b3.20.1749743431709; Thu, 12 Jun 2025
 08:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1748432169.git.pisa@cmp.felk.cvut.cz>
 <db331a037c362f5e9e4f35cf61fc1670aa7c96bf.1748432169.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <db331a037c362f5e9e4f35cf61fc1670aa7c96bf.1748432169.git.pisa@cmp.felk.cvut.cz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:50:20 +0100
X-Gm-Features: AX0GCFucMqGHWOkCpmwuVrgPyClP7DnuvQaCUzA_qHP701kXqHH-Cu8eWrFjDxY
Message-ID: <CAFEAcA8BpF=gRAfUHk1i8avgsB3Cs7GY=L=S_ANysZApXCHLXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hw/net/can: CTU CAN FD IP core mapping to the
 platform bus
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
 Ondrej Ille <ondrej.ille@gmail.com>, Jiri Novak <jnovak@fel.cvut.cz>
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

On Wed, 28 May 2025 at 12:50, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>
> The system/platform bus mapping alternative to PCI/PCIe mapping.
> In this case, the platform bus is used to match FPGA design
> for Xilinx Zynq MZ_APO education kit with four CTU CAN FD
> cores on branch mz_apo-2x-xcan-4x-ctu of repo
>
>   https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
>
> The system is started by command
>
>   qemu-system-arm -m 1G -M xilinx-zynq-a9 \
>       -kernel kernel-zynq \
>       -dtb zynq-microzed-uart1-2x-xcan-4x-ctu-axi.dtb \
>       -initrd ramdisk.cpio \
>       -serial null -serial mon:stdio \
>       -nographic \
>       -object can-bus,id=canbus0-bus \
>       -object can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \
>       -device ctucan_mm,iobase=0x43c30000,irqnum=29,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus \
>       -device ctucan_mm,iobase=0x43c70000,irqnum=30,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus \
>       -device ctucan_mm,iobase=0x43bf0000,irqnum=31,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus \
>       -device ctucan_mm,iobase=0x43bb0000,irqnum=32,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus

Please don't use the platform bus for this. Command line
created devices should not have properties like "iobase"
and should not be mapping their own MMIO regions in their
realize methods.

If we have a board that does or should have a memory-mapped
CAN device, then that board should create it at the appropriate
address and wire up the interrupt lines.

We don't have infrastructure currently for users to create
custom "frankenstein" setups on the command line, and I don't
want us to add small disconnected portions of it ad-hoc.

I'll let the Zynq board maintainers make the call about whether
they want to add a CAN bus controller to it.

thanks
-- PMM

