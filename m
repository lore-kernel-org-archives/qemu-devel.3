Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F5CD2E022
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Wr1-0006pt-Jg; Wed, 23 Oct 2024 04:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t3Wqv-0006p2-1r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t3Wqq-0005uk-UE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729672579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sixUmv3PGx+pYKXdN/nhCdqAcaHSIuduixwvpL8fRM=;
 b=Ae8Gg3CGiMxnBKh3SETS+5PZxHkHnm23gecaJ/agknM1o2gUWZBpxMaxdOQBftyfBvp8JC
 m6a+eDwjv6itg9ZbSdPjrfyZPHREMSPDl4gdC967fv6iIIpTPOUxmqI7r4az/ThgNrjSyn
 tUZvYoYAalsGbtcIbcbQ3ef9RBU2p+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-e9ckaq32Mta40OagH-2eWQ-1; Wed, 23 Oct 2024 04:36:18 -0400
X-MC-Unique: e9ckaq32Mta40OagH-2eWQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4cf04be1so3257867f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 01:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729672577; x=1730277377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sixUmv3PGx+pYKXdN/nhCdqAcaHSIuduixwvpL8fRM=;
 b=RTH0R5hB634C77n12DPTnWCkA/EcOflyI5POF7NnFVZMbeS5Xb87LScjzSLN+ox1uI
 9GizyG2vs7JZtaYpBkKD34UT8wbxpajpsdvYyPeMRyBRbL5rk4AFr5aa++l+NFAus9Jf
 MjsBx39rjbC8MRk1ChyddcdnnxGXJ5iRlacN7k/M00wu7hT9mzjeCIg1I1M9g/xz0bXH
 4GivcFjQEO5Zg/1KGQP0dgfpBRZatS4zF8I7QhhXkMFx0QdVLm8vWCL/SXzkdc4q/XVy
 4Sk63KPIplNp0R+XQ5CBylzdmGcudPmUfrh6H2IhN6dq2bjRuQLaBbTNAG4e/MMgCtOY
 Fy1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlet7rdV6qLTSiefWV79rFXwJnPLRyrYVkcbxsz6bY6V9j1Wu3ymgXBawTe+0/xS1G7YPT1+JbN645@nongnu.org
X-Gm-Message-State: AOJu0YxgpuyMNQZIpyVP5YSfhWANeMASQzZ2N5dDtNWNk7bEv5xX8YR7
 miYrIGDa7LL1tPG6q5mURc46Yr1m53q65PWrb2AdqNNEuD/cXfhyDIKAUlLfl2pPvA9AUSPKa5s
 DfUimjTONpaC0miGbdSSvwqbUhO3P0YYnnpdrN7W1xnc1ZAcgTzbO
X-Received: by 2002:adf:fa51:0:b0:37c:cc96:d1ce with SMTP id
 ffacd0b85a97d-37efcf1f8a1mr1115338f8f.24.1729672576849; 
 Wed, 23 Oct 2024 01:36:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP3R2/7eLZC4jTW2QoTjJYxSBenRCPxvjkfH065SNYzdOB00wEt3UgdM5qMeM51ucz9wBAog==
X-Received: by 2002:adf:fa51:0:b0:37c:cc96:d1ce with SMTP id
 ffacd0b85a97d-37efcf1f8a1mr1115321f8f.24.1729672576419; 
 Wed, 23 Oct 2024 01:36:16 -0700 (PDT)
Received: from redhat.com ([2.52.26.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a48564sm8392575f8f.29.2024.10.23.01.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 01:36:15 -0700 (PDT)
Date: Wed, 23 Oct 2024 04:36:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v5 0/3] Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Message-ID: <20241023043544-mutt-send-email-mst@kernel.org>
References: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 28, 2024 at 06:59:17PM -0700, Sia Jee Heng wrote:
> Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> The SPCR table has been modified to adhere to the revision 4 format [2].

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Pls take through the arm tree.


> Meanwhile, the virt SPCR golden reference file for RISC-V have been updated to
> accommodate the SPCR Table revision 4.
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
> 
> Changes in v5:
> - Reverted the SPCR table revision history for the ARM architecture.
> - Corrected the output of the SPCR Table diff.
> 
> Changes in v4:
> - Remove the SPCR table revision 4 update for the ARM architecture.
> 
> Changes in v3:
> - Rebased on the latest QEMU.
> - Added Acked-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Changes in v2:
> - Utilizes a three-patch approach to modify the ACPI pre-built binary
>   files required by the Bios-Table-Test.
> - Rebases and incorporates changes to support both ARM and RISC-V ACPI
>   pre-built binary files.
> 
> Sia Jee Heng (3):
>   qtest: allow SPCR acpi table changes
>   hw/acpi: Upgrade ACPI SPCR table to support SPCR table revision 4
>     format
>   tests/qtest/bios-tables-test: Update virt SPCR golden reference for
>     RISC-V
> 
>  hw/acpi/aml-build.c               |  20 ++++++++++++++++----
>  hw/arm/virt-acpi-build.c          |   8 ++++++--
>  hw/riscv/virt-acpi-build.c        |  12 +++++++++---
>  include/hw/acpi/acpi-defs.h       |   7 +++++--
>  include/hw/acpi/aml-build.h       |   2 +-
>  tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
>  6 files changed, 37 insertions(+), 12 deletions(-)
> 
> 
> base-commit: cec99171931ea79215c79661d33423ac84e63b6e
> -- 
> 2.34.1


