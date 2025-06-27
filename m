Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ED9C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVB4e-00015O-R4; Fri, 27 Jun 2025 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVB4c-00011D-G3
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVB4a-0002z4-JB
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751038383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n85c+fKIADcqu3bqGUuNCT2Q53aJTQeyoEktYXoDZl0=;
 b=NzzS5+zVvJya2+jF20T+O+IeVB+XbkoCg4XlAQ8Sjo0tZGwp7IumYQ0dsJhmzrPC70SgML
 2RfoDTLcpXYZeRlNkGRw/SN0RF77sL7O89fnZ1TA0QUttXzz1dpxS7Qskkl3D4/819MLmf
 5dK7BWZ+9NSCNjlWNnYC1pfOHzmGLco=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-qEOAt2dwPhyp79awE_cXMA-1; Fri, 27 Jun 2025 11:33:01 -0400
X-MC-Unique: qEOAt2dwPhyp79awE_cXMA-1
X-Mimecast-MFC-AGG-ID: qEOAt2dwPhyp79awE_cXMA_1751038381
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eec544c6so1032904f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 08:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751038380; x=1751643180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n85c+fKIADcqu3bqGUuNCT2Q53aJTQeyoEktYXoDZl0=;
 b=DTFx5dlRfFEjR1DQOOEjWbRpaSeuh4PDwa8Ythwu7PuWAnpxPoZrKWv6nddTo2Hv5o
 kiMECT7a+lFmxWrlKwQI5GbJHuQB/WcVFsb8TDFKNSOU1vNKggyRhqob+aiXt1c3V0FD
 Se1k34W5WSGnTZK3Q23ZQOFafyEEvubbjg0Gcu4XbkSH2Z+f9lrGWaVOT4w43ymbRV1C
 4t4om1mm0Rv9MWljnSULbA3U5ZrthPRDSZFHmbHqArDmUDpNxSOtt94vvu3BktWm0mKm
 R7s0r7Hn6DqNTG/PWYvzlXwFcWVUkJgnJXO+2On9sYizpfr8fx8mUKjBPJFM1yyqB08+
 uU/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUaIQjBykqMk8DWhAa7K+bCR1/jF3woporjiJFhoaAHuh9Rq/Fni8veaWHY+rF81CbS+NLQfNvcbCw@nongnu.org
X-Gm-Message-State: AOJu0Yx1Bn8wsdmogtSCjH4mjU1IAs6zb3ltZGAtehqCec5Rdw+jK5RA
 slrkyWyCzc+q/f7iTq59p+sWi4kQpj38nIxGnPV+IiX0u4Z5WMMv5RsFUQNKaDZsNWGUs0X9NrV
 z0tARgLDgUCZMU7NygKon2aJv3KJk0BjE4QGQRp5wUhvuwJW1Td3r5CWKtJxdlAYD
X-Gm-Gg: ASbGncvBsT3FU7iHzrfDU6uTWwkwk8On0DMnZsx+UOwWMymmoODm/Z8JD3u6XslO6C3
 DplBPahUTTh+OPFSs0LxCnI3W4dxIhNkC15N693mPf8jx2KjGzUJpVmj1vUYXrSCyKRx0WHz1HI
 j8XrNBjyvlSLGwQ/5UJsudRSfW171hHh5/Ztp2bVPLgVkM6gzkZlyowmFk0twgin7TH9dJwhYBc
 w3GJqa6qUMovRo9dVbo1KNt5M3t24UYuRDFDyTYbg7+ig+y0SOzgm0WZb20T/VSFNLLul8zkLcD
 WGRrBQ3My1a57WytBcvvlVG2WGqUUSW6GLp6pnQnLUD2agmpnoWTmopflsFSMqAChSefwQ==
X-Received: by 2002:a05:6000:2307:b0:3a6:d145:e2cc with SMTP id
 ffacd0b85a97d-3a8fdff46e4mr3628392f8f.15.1751038379958; 
 Fri, 27 Jun 2025 08:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA7cV7UB7O1U9kUJZm31VAXYx/hbrvw3n3IJrGTssJV9tNjGXbQ/pt7Yhi4le4HqzpAg3SiA==
X-Received: by 2002:a05:6000:2307:b0:3a6:d145:e2cc with SMTP id
 ffacd0b85a97d-3a8fdff46e4mr3628363f8f.15.1751038379471; 
 Fri, 27 Jun 2025 08:32:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7098sm2962670f8f.4.2025.06.27.08.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 08:32:58 -0700 (PDT)
Message-ID: <f0969147-78e9-4f46-a951-3c2fdf9f7d4d@redhat.com>
Date: Fri, 27 Jun 2025 17:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] qtest/bios-tables-test: Add blobs for its=off test
 on aarch64
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-8-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623135749.691137-8-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/23/25 3:57 PM, Gustavo Romero wrote:
> Add blobs for test_acpi_aarch64_virt_tcg_its_off(), which introduces a
> new variant, .its_off, that requires variations of the MADT and IORT
> tables.
>
> MADT (aka APIC) diff:
>
> +[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
> +[004h 0004   4]                 Table Length : 000000B8
> +[008h 0008   1]                     Revision : 04
> +[009h 0009   1]                     Checksum : C1
> +[00Ah 0010   6]                       Oem ID : "BOCHS "
> +[010h 0016   8]                 Oem Table ID : "BXPC    "
> +[018h 0024   4]                 Oem Revision : 00000001
> +[01Ch 0028   4]              Asl Compiler ID : "BXPC"
> +[020h 0032   4]        Asl Compiler Revision : 00000001
> +
> +[024h 0036   4]           Local Apic Address : 00000000
> +[028h 0040   4]        Flags (decoded below) : 00000000
> +                         PC-AT Compatibility : 0
> +
> +[02Ch 0044   1]                Subtable Type : 0C [Generic Interrupt Distributor]
> +[02Dh 0045   1]                       Length : 18
> +[02Eh 0046   2]                     Reserved : 0000
> +[030h 0048   4]        Local GIC Hardware ID : 00000000
> +[034h 0052   8]                 Base Address : 0000000008000000
> +[03Ch 0060   4]               Interrupt Base : 00000000
> +[040h 0064   1]                      Version : 03
> +[041h 0065   3]                     Reserved : 000000
> +
> +[044h 0068   1]                Subtable Type : 0B [Generic Interrupt Controller]
> +[045h 0069   1]                       Length : 50
> +[046h 0070   2]                     Reserved : 0000
> +[048h 0072   4]         CPU Interface Number : 00000000
> +[04Ch 0076   4]                Processor UID : 00000000
> +[050h 0080   4]        Flags (decoded below) : 00000001
> +                           Processor Enabled : 1
> +          Performance Interrupt Trigger Mode : 0
> +          Virtual GIC Interrupt Trigger Mode : 0
> +[054h 0084   4]     Parking Protocol Version : 00000000
> +[058h 0088   4]        Performance Interrupt : 00000017
> +[05Ch 0092   8]               Parked Address : 0000000000000000
> +[064h 0100   8]                 Base Address : 0000000000000000
> +[06Ch 0108   8]     Virtual GIC Base Address : 0000000000000000
> +[074h 0116   8]  Hypervisor GIC Base Address : 0000000000000000
> +[07Ch 0124   4]        Virtual GIC Interrupt : 00000000
> +[080h 0128   8]   Redistributor Base Address : 0000000000000000
> +[088h 0136   8]                    ARM MPIDR : 0000000000000000
> +[090h 0144   1]             Efficiency Class : 00
> +[091h 0145   1]                     Reserved : 00
> +[092h 0146   2]       SPE Overflow Interrupt : 0000
> +
> +[094h 0148   1]                Subtable Type : 0E [Generic Interrupt Redistributor]
> +[095h 0149   1]                       Length : 10
> +[096h 0150   2]                     Reserved : 0000
> +[098h 0152   8]                 Base Address : 00000000080A0000
> +[0A0h 0160   4]                       Length : 00F60000
> +
> +[0A4h 0164   1]                Subtable Type : 0F [Generic Interrupt Translator]
> +[0A5h 0165   1]                       Length : 14
> +[0A6h 0166   2]                     Reserved : 0000
> +[0A8h 0168   4]               Translation ID : 00000000
> +[0ACh 0172   8]                 Base Address : 0000000008080000
> +[0B4h 0180   4]                     Reserved : 00000000
>
> IORT diff:
>
> +[000h 0000   4]                    Signature : "IORT"    [IO Remapping Table]
> +[004h 0004   4]                 Table Length : 000000EC
> +[008h 0008   1]                     Revision : 03
> +[009h 0009   1]                     Checksum : 57
> +[00Ah 0010   6]                       Oem ID : "BOCHS "
> +[010h 0016   8]                 Oem Table ID : "BXPC    "
> +[018h 0024   4]                 Oem Revision : 00000001
> +[01Ch 0028   4]              Asl Compiler ID : "BXPC"
> +[020h 0032   4]        Asl Compiler Revision : 00000001
> +
> +[024h 0036   4]                   Node Count : 00000003
> +[028h 0040   4]                  Node Offset : 00000030
> +[02Ch 0044   4]                     Reserved : 00000000
> +
> +[030h 0048   1]                         Type : 00
> +[031h 0049   2]                       Length : 0018
> +[033h 0051   1]                     Revision : 01
> +[034h 0052   4]                     Reserved : 00000000
> +[038h 0056   4]                Mapping Count : 00000000
> +[03Ch 0060   4]               Mapping Offset : 00000000
> +
> +[040h 0064   4]                     ItsCount : 00000001
> +[044h 0068   4]                  Identifiers : 00000000
> +
> +[048h 0072   1]                         Type : 04
> +[049h 0073   2]                       Length : 0058
> +[04Bh 0075   1]                     Revision : 04
> +[04Ch 0076   4]                     Reserved : 00000001
> +[050h 0080   4]                Mapping Count : 00000001
> +[054h 0084   4]               Mapping Offset : 00000044
> +
> +[058h 0088   8]                 Base Address : 0000000009050000
> +[060h 0096   4]        Flags (decoded below) : 00000001
> +                             COHACC Override : 1
> +                               HTTU Override : 0
> +                      Proximity Domain Valid : 0
> +[064h 0100   4]                     Reserved : 00000000
> +[068h 0104   8]                VATOS Address : 0000000000000000
> +[070h 0112   4]                        Model : 00000000
> +[074h 0116   4]                   Event GSIV : 0000006A
> +[078h 0120   4]                     PRI GSIV : 0000006B
> +[07Ch 0124   4]                    GERR GSIV : 0000006D
> +[080h 0128   4]                    Sync GSIV : 0000006C
> +[084h 0132   4]             Proximity Domain : 00000000
> +[088h 0136   4]      Device ID Mapping Index : 00000000
> +
> +[08Ch 0140   4]                   Input base : 00000000
> +[090h 0144   4]                     ID Count : 0000FFFF
> +[094h 0148   4]                  Output Base : 00000000
> +[098h 0152   4]             Output Reference : 00000030
> +[09Ch 0156   4]        Flags (decoded below) : 00000000
> +                              Single Mapping : 0
> +
> +[0A0h 0160   1]                         Type : 02
> +[0A1h 0161   2]                       Length : 004C
> +[0A3h 0163   1]                     Revision : 03
> +[0A4h 0164   4]                     Reserved : 00000002
> +[0A8h 0168   4]                Mapping Count : 00000002
> +[0ACh 0172   4]               Mapping Offset : 00000024
> +
> +[0B0h 0176   8]            Memory Properties : [IORT Memory Access Properties]
> +[0B0h 0176   4]              Cache Coherency : 00000001
> +[0B4h 0180   1]        Hints (decoded below) : 00
> +                                   Transient : 0
> +                              Write Allocate : 0
> +                               Read Allocate : 0
> +                                    Override : 0
> +[0B5h 0181   2]                     Reserved : 0000
> +[0B7h 0183   1] Memory Flags (decoded below) : 03
> +                                   Coherency : 1
> +                            Device Attribute : 1
> +[0B8h 0184   4]                ATS Attribute : 00000000
> +[0BCh 0188   4]           PCI Segment Number : 00000000
> +[0C0h 0192   1]            Memory Size Limit : 40
> +[0C1h 0193   3]                     Reserved : 000000
> +
> +[0C4h 0196   4]                   Input base : 00000000
> +[0C8h 0200   4]                     ID Count : 000000FF
> +[0CCh 0204   4]                  Output Base : 00000000
> +[0D0h 0208   4]             Output Reference : 00000048
> +[0D4h 0212   4]        Flags (decoded below) : 00000000
> +                              Single Mapping : 0
> +
> +[0D8h 0216   4]                   Input base : 00000100
> +[0DCh 0220   4]                     ID Count : 0000FEFF
> +[0E0h 0224   4]                  Output Base : 00000100
> +[0E4h 0228   4]             Output Reference : 00000030
> +[0E8h 0232   4]        Flags (decoded below) : 00000000
> +                              Single Mapping : 0
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
> ---
>  tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   2 --
>  3 files changed, 2 deletions(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>
> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..37d82e970b1331cb5b259f0bd2d3654bacb2d623
> GIT binary patch
> literal 184
> zcmZ<^@O0k6z`($A(8=G~BUr&HBEVSz2pEB4AU24G0Uik$i-7~iVg@p}17JJ`2AFzr
> Zgb>LrJ^_#xE~p*f82CkCMsUFG1ppOZ2>}2A
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
> GIT binary patch
> literal 236
> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index a88198d5c2..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,3 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/APIC.its_off",
> -"tests/data/acpi/aarch64/virt/IORT.its_off",


