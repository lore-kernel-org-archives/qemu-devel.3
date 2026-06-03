Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41F7CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 10:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUjDF-0005gr-Nk; Wed, 03 Jun 2026 06:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUjD7-0005dL-Bm
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUjD5-0003W1-4O
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780483950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljQ+vkEUt891DeynbK/0Hdj1GinxL1BP7yI3h1GXV3I=;
 b=ZaorU8z8Cqdw1sv9Ex+BGw6uKRhslSHNq6baAbGPoTdmMb7ZaxLxL2sTNf3zBJcUAn0WX9
 A5DBfvI9RUXRIHKO59MIT0AvdcXfPNG1TUjgQ3X6nPU83B2eMW3DHZoRHeyrqfL7iaB6ud
 i1ZIK7t1GWTa+LB9WMhC7rDfqeQok7s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-eQprt7zBPlymIDIzPJNn8w-1; Wed, 03 Jun 2026 06:52:29 -0400
X-MC-Unique: eQprt7zBPlymIDIzPJNn8w-1
X-Mimecast-MFC-AGG-ID: eQprt7zBPlymIDIzPJNn8w_1780483948
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso5951665e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780483948; x=1781088748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljQ+vkEUt891DeynbK/0Hdj1GinxL1BP7yI3h1GXV3I=;
 b=TXpEuK/RNWCTm3AvTxf54pb1+ZGDwHZOapSvGKc7INGPYJy1E9TXW+0Ha84m1rXYTY
 bi4ptKmjzCoo7iKJVCwXoN8jTg3n/eoUzpDdHc69aDKlaaBn3sEYKqGrW38PxkGZArXK
 NXZ085cSweWtJTtPk0wYCetcxnQhwNj26FrrUAZeckLGJLi6UKmm2BDAQYAJ8PTvC9+I
 KdyxprZTHGgvtb0WALRoohEwXJWy0Tq06IXh1JOUcVrDB+wwFnCxLBaShsML+LBmQ2RB
 kodU04AoSVOI5Ea38CSVouOnzjKCPzZKEl9ATzvBYFXnVcoinLCT5aaPR3VFlQJgTegA
 5m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780483948; x=1781088748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ljQ+vkEUt891DeynbK/0Hdj1GinxL1BP7yI3h1GXV3I=;
 b=dgSFBd8p4WH+1WPyVxO6Ve9kpNyqWNGrfjftMPVWayoGezrvTQOLYKpBJbOBsngkp0
 kXWf81huFsJsCMAGXo2XoBEa9TlEujdUnRhZra35+KYzFudylH23AVepK7XlLA5oeq0E
 HIkvN+jC8rjBiVXNlblBMkOAoapQNphu4Jb9c20uGA9qdLNWsGv0BA1MBF2XxoNR3RLK
 dF7rPqcu/X87Kz1rMnxF7OK2EJyReGzumQXkgN2wc71f4VJ1optQJq0tSfz/tUQSgtAQ
 y27Z0JMrfZ26AW7Jho/mkEQlteelTEyh+f8H2U4SOIKpTC6f1/2wat8BOcpWoIp0S45q
 Hj/A==
X-Gm-Message-State: AOJu0YzSL4uqYmir790tGpAuhz9yqZj9SI3M1mbn8p47XYO17E6nxr/g
 YhVPEhjM3KBSq4+idXe7k318YF3iZoppwBH4kmZUAo0Ef5rlxNeewAjboCubCvQHqtqOwfDeFxT
 tlLgYvSz3ra5yzOq0UWkqQ7YctHybNytuDEvH3kWcMkMhDmpbIWGX1VFM
X-Gm-Gg: Acq92OG/prqeRy2+5iBwPWmtboDfKUk5JDtR54P2Rh1bmUC+Ga5hIKA4oE8r5U8AkSJ
 xf9k7Zyg5lwjkmNb3hUDa2ZkQ4hD1XJ4yYm7oAwJ0MGl+gLBuPWvCbvzhKkKwcR35fUogJBszL4
 lu8w9qrgORex/HrwuW+nUGSCmuA82TBd/vTlCKoJYJNRk6lO8s/bQUagX6C5CNY/1gpMO07lZK9
 6KuxyqiiqNASI+RDIcw6yDtgEjCy4ig7r98jsX5fOFIjH/4geg836+ql+I6x59FsFI+rjfsiEUc
 h9s9XP6LvpBmwY3jjgdpi5f9QQypXRlOm91Fd8SJIBrpXTLG+cT3fDwZ81PIENSDZ24jjvDNvGi
 gNQKMli3lAuomnBjZ
X-Received: by 2002:a05:600c:4687:b0:490:a298:acf7 with SMTP id
 5b1f17b1804b1-490b5ed42e5mr51855875e9.17.1780483947764; 
 Wed, 03 Jun 2026 03:52:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4687:b0:490:a298:acf7 with SMTP id
 5b1f17b1804b1-490b5ed42e5mr51855315e9.17.1780483947346; 
 Wed, 03 Jun 2026 03:52:27 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm7733326f8f.24.2026.06.03.03.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 03:52:26 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:52:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 3/3] tests/qtest/bios-tables-test: Fix Terminal Type
 and Language field order in SPCR table
Message-ID: <20260603125226.0f501343@imammedo>
In-Reply-To: <20260529023100.42508-4-wangxiang@iscas.ac.cn>
References: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
 <20260529023100.42508-4-wangxiang@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 29 May 2026 10:31:00 +0800
Xiang W <wangxiang@iscas.ac.cn> wrote:

> According to the ACPI Serial Port Console Redirection Table (SPCR)
> specification, the field order after Flow Control is:
> 
>   - Terminal Type (offset 62, 1 byte)
>   - Language (offset 63, 1 byte)
> 
> This fixes:
>   - tests/data/acpi/loongarch64/virt/SPCR
>   - tests/data/acpi/riscv64/virt/SPCR

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> Diffs from iasl:
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20250404 (64-bit version)
>   * Copyright (c) 2000 - 2025 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/riscv64/virt/SPCR
> + * Disassembly of /tmp/aml-3fYW7T
>   *
>   * ACPI Data Table [SPCR]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>   */
> 
>  [000h 0000 004h]                   Signature : "SPCR"    [Serial Port Console Redirection Table]
>  [004h 0004 004h]                Table Length : 0000005A
>  [008h 0008 001h]                    Revision : 04
>  [009h 0009 001h]                    Checksum : 13
>  [00Ah 0010 006h]                      Oem ID : "BOCHS "
>  [010h 0016 008h]                Oem Table ID : "BXPC    "
>  [018h 0024 004h]                Oem Revision : 00000001
>  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>  [020h 0032 004h]       Asl Compiler Revision : 00000001
> 
>  [024h 0036 001h]              Interface Type : 12
>  [025h 0037 003h]                    Reserved : 000000
> 
>  [028h 0040 00Ch]        Serial Port Register : [Generic Address Structure]
>  [028h 0040 001h]                    Space ID : 00 [SystemMemory]
>  [029h 0041 001h]                   Bit Width : 20
>  [02Ah 0042 001h]                  Bit Offset : 00
>  [02Bh 0043 001h]        Encoded Access Width : 01 [Byte Access:8]
>  [02Ch 0044 008h]                     Address : 0000000010000000
> 
>  [034h 0052 001h]              Interrupt Type : 10
>  [035h 0053 001h]         PCAT-compatible IRQ : 00
>  [036h 0054 004h]                   Interrupt : 0000000A
>  [03Ah 0058 001h]                   Baud Rate : 07
>  [03Bh 0059 001h]                      Parity : 00
>  [03Ch 0060 001h]                   Stop Bits : 01
>  [03Dh 0061 001h]                Flow Control : 00
> -[03Eh 0062 001h]               Terminal Type : 00
> -[03Fh 0063 001h]                    Language : 03
> +[03Eh 0062 001h]               Terminal Type : 03
> +[03Fh 0063 001h]                    Language : 00
>  [040h 0064 002h]               PCI Device ID : FFFF
>  [042h 0066 002h]               PCI Vendor ID : FFFF
>  [044h 0068 001h]                     PCI Bus : 00
>  [045h 0069 001h]                  PCI Device : 00
>  [046h 0070 001h]                PCI Function : 00
>  [047h 0071 004h]                   PCI Flags : 00000000
>  [04Bh 0075 001h]                 PCI Segment : 00
>  [04Ch 0076 004h]             Uart Clock Freq : 00000000
>  [050h 0080 004h]           Precise Baud rate : 00000000
>  [054h 0084 002h]       NameSpaceStringLength : 0002
>  [056h 0086 002h]       NameSpaceStringOffset : 0058
>  [058h 0088 002h]             NamespaceString : "."
> 
>  Raw Table Data: Length 90 (0x5A)
> 
>      0000: 53 50 43 52 5A 00 00 00 04 13 42 4F 43 48 53 20  // SPCRZ.....BOCHS
>      0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
>      0020: 01 00 00 00 12 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
> -    0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 00 03  // ................
> +    0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 03 00  // ................
>      0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
>      0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...
> 
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20250404 (64-bit version)
>   * Copyright (c) 2000 - 2025 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/loongarch64/virt/SPCR
> + * Disassembly of /tmp/aml-Z0WhKt
>   *
>   * ACPI Data Table [SPCR]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>   */
> 
>  [000h 0000 004h]                   Signature : "SPCR"    [Serial Port Console Redirection Table]
>  [004h 0004 004h]                Table Length : 00000050
>  [008h 0008 001h]                    Revision : 02
>  [009h 0009 001h]                    Checksum : C1
>  [00Ah 0010 006h]                      Oem ID : "BOCHS "
>  [010h 0016 008h]                Oem Table ID : "BXPC    "
>  [018h 0024 004h]                Oem Revision : 00000001
>  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>  [020h 0032 004h]       Asl Compiler Revision : 00000001
> 
>  [024h 0036 001h]              Interface Type : 00
>  [025h 0037 003h]                    Reserved : 000000
> 
>  [028h 0040 00Ch]        Serial Port Register : [Generic Address Structure]
>  [028h 0040 001h]                    Space ID : 00 [SystemMemory]
>  [029h 0041 001h]                   Bit Width : 20
>  [02Ah 0042 001h]                  Bit Offset : 00
>  [02Bh 0043 001h]        Encoded Access Width : 01 [Byte Access:8]
>  [02Ch 0044 008h]                     Address : 000000001FE001E0
> 
>  [034h 0052 001h]              Interrupt Type : 00
>  [035h 0053 001h]         PCAT-compatible IRQ : 00
>  [036h 0054 004h]                   Interrupt : 00000042
>  [03Ah 0058 001h]                   Baud Rate : 07
>  [03Bh 0059 001h]                      Parity : 00
>  [03Ch 0060 001h]                   Stop Bits : 01
>  [03Dh 0061 001h]                Flow Control : 00
> -[03Eh 0062 001h]               Terminal Type : 00
> -[03Fh 0063 001h]                    Language : 03
> +[03Eh 0062 001h]               Terminal Type : 03
> +[03Fh 0063 001h]                    Language : 00
>  [040h 0064 002h]               PCI Device ID : FFFF
>  [042h 0066 002h]               PCI Vendor ID : FFFF
>  [044h 0068 001h]                     PCI Bus : 00
>  [045h 0069 001h]                  PCI Device : 00
>  [046h 0070 001h]                PCI Function : 00
>  [047h 0071 004h]                   PCI Flags : 00000000
>  [04Bh 0075 001h]                 PCI Segment : 00
>  [04Ch 0076 004h]             Uart Clock Freq : 00000000
>  /**** ACPI table terminates in the middle of a data structure! (dump table)
>  CurrentOffset: 50, TableLength: 50 ***/
> 
> Reference:
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  tests/data/acpi/loongarch64/virt/SPCR       | Bin 80 -> 80 bytes
>  tests/data/acpi/riscv64/virt/SPCR           | Bin 90 -> 90 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  3 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
> index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
> GIT binary patch
> delta 23
> TcmWFtm|!Qw%<vxw7?1z}S|J61
> 
> delta 23
> TcmWFtm|!Qw!2BNw7?1z}S{?;}
> 
> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
> GIT binary patch
> delta 10
> Rcma!wnqbGo%rMbG3IGpM0&@TW
> 
> delta 10
> Rcma!wnqbGoz&z1G3IGpJ0&@TW
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index aae973048a..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/SPCR",


