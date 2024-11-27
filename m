Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F76D6ACD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIYV-0003kG-9N; Wed, 27 Nov 2024 08:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYS-0003jl-TN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYQ-0007lM-Eu
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhZA6ORaO2duS0AgwjGZ6tlQJYQfNk0S+QGZU86VpQM=;
 b=H8mja4V3Rmctu6ZJovBKJBDESp+7SuXGHrKAuE/3Rb1HmQPQgVXq/IVgSihnrL/1hgVlxV
 +KThkY8e/0lmi4OCVcq6yfW+OqX/UEjFVrt3Y8c8I5zLSV0nNksUkVgVYoNPGe8zDAZpf9
 fPVtEjB7hid4JvXb4oK1hxHm2GPjBcY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-4PatTNZ-OH-mad5crYClLg-1; Wed, 27 Nov 2024 08:58:04 -0500
X-MC-Unique: 4PatTNZ-OH-mad5crYClLg-1
X-Mimecast-MFC-AGG-ID: 4PatTNZ-OH-mad5crYClLg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-382342b66f5so3881363f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715883; x=1733320683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhZA6ORaO2duS0AgwjGZ6tlQJYQfNk0S+QGZU86VpQM=;
 b=AUMpiGnyzxHeBloeQGZt3EF0r/vODfkNeKQM4nRZaUZpb+6Ubk+oDIs3MCe0SuguHW
 EuDPwyepNNhcWlftYTV3MWa/78EL0fX2Ywtpholipwp5ptemg6OtCuN90/GljcVlSu/8
 kyIHYKOh6Jjl7nC+GGyYYgUUU5YQSnaD/fcZQfZSvEflho3rf+Igro3ze/fZMpUvYijm
 MaQ7tws/CwnfXJthwoFvewDe/XUn73jAZCHVYJp6BkbsWLWwI4TVE42PLtyczeyEf70t
 x0kOl6bdSG0y+YoeGm+TlTU5hAn2f8hqqHxNFfZWQcmc2jtGNSDyKaQ8atUWMgIhVPrw
 Le2g==
X-Gm-Message-State: AOJu0YyqMrO6lL/IeoTeA4Zwe+/wc7u6AolPzvApFE8bC92DlvPiv0sS
 mpROd8BSnAkRnHJHgaADC2sOlvT5z4obaWlhqE1TAZotCNSfavccEYVu4n3L2XUXuhazZu86qq/
 uvVh7nnkK4zFztEKNdU0wY4pw40c2MyNIWu1AbyL0v9I4NLRzqHH6uSxk9uj8JQxXiuQP2i9hs4
 2szp6LM2azchbDW89b4lEXn2lNjngBwlV4
X-Gm-Gg: ASbGncvzFQ9Q7DHJ8proPGo2jvrqJdMS4V+VKREqh/Rp00QCAFBcyQ54DGS+tyii3Ni
 5VcImRerhrDAUQ4zdv8bUiGBKee8YqeE6Q5hrllXgdFvEghUkDjHaQ07XvewygXbS9eHgFachTZ
 FUrwAScAyDVyY6D/UuLM+C9UDJavetFbJAJLXXgyavEo/bXj39feYRCudDnQLCDOvnKBoZ5QYiz
 yVIptgibogITHDpGXYTvmrJWPJtVWb6pqng4XxrRRCm
X-Received: by 2002:a05:6000:1545:b0:382:49f9:74bc with SMTP id
 ffacd0b85a97d-385c6edb224mr2127297f8f.41.1732715882673; 
 Wed, 27 Nov 2024 05:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQmrKcq5JaJoDZOYw9p+666j1t64477UWYM33Izq40Lk5HTponQB1otj+LotlHOLs1QBynnA==
X-Received: by 2002:a05:6000:1545:b0:382:49f9:74bc with SMTP id
 ffacd0b85a97d-385c6edb224mr2127264f8f.41.1732715882100; 
 Wed, 27 Nov 2024 05:58:02 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbe901esm16617807f8f.87.2024.11.27.05.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:58:01 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 12/13] bios-tables-test: Add data for complex numa test (GI,
 GP etc)
Message-ID: <5d525294626ebdc2741c19167217ec79a6c2cc08.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given this is a new configuration, there are affects on APIC, CEDT
and DSDT, but the key elements are in SRAT (plus related data in
HMAT).  The configuration has node to exercise many different combinations.

0) CPUs + Memory
1) GI only
2) GP only
3) CPUS only
4) Memory only
5) CPUs + HP memory

GI node, GP Node, Memory only node, hotplug memory
only node, latency and bandwidth such that in Linux Access0
(any initiator) and Access1 (CPU initiators only) given different
answers.  Following cropped to remove details of each entry.

[000h 0000 004h]                   Signature : "SRAT"    [System Resource Affinity Table]
...
[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00
...
[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[042h 0066 001h]     Proximity Domain Low(8) : 03
[043h 0067 001h]                     Apic ID : 01
...
[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[052h 0082 001h]     Proximity Domain Low(8) : 05
[053h 0083 001h]                     Apic ID : 02
...
[060h 0096 001h]               Subtable Type : 01 [Memory Affinity]
...
[062h 0098 004h]            Proximity Domain : 00000000
...
[068h 0104 008h]                Base Address : 0000000000000000
[070h 0112 008h]              Address Length : 00000000000A0000
...
[088h 0136 001h]               Subtable Type : 01 [Memory Affinity]
...
[08Ah 0138 004h]            Proximity Domain : 00000000
...
[090h 0144 008h]                Base Address : 0000000000100000
[098h 0152 008h]              Address Length : 0000000003F00000
...
[0B0h 0176 001h]               Subtable Type : 01 [Memory Affinity]
...
[0B2h 0178 004h]            Proximity Domain : 00000004
...
[0B8h 0184 008h]                Base Address : 0000000004000000
[0C0h 0192 008h]              Address Length : 0000000004000000
... some zero length entries follow...

[1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affinity]
[1A1h 0417 001h]                      Length : 20

[1A2h 0418 001h]                   Reserved1 : 00
[1A3h 0419 001h]          Device Handle Type : 01
[1A4h 0420 004h]            Proximity Domain : 00000001
[1A8h 0424 010h]               Device Handle : 00 00 01 02 00 00 00 00 00 00 00 00 00 00 00 00
[1B8h 0440 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1BCh 0444 004h]                   Reserved2 : 00000000

[1C0h 0448 001h]               Subtable Type : 06 [Generic Port Affinity]
[1C1h 0449 001h]                      Length : 20

[1C2h 0450 001h]                   Reserved1 : 00
[1C3h 0451 001h]          Device Handle Type : 00
[1C4h 0452 004h]            Proximity Domain : 00000002
[1C8h 0456 010h]               Device Handle : 41 43 50 49 30 30 31 36 40 00 00 00 00 00 00 00
[1D8h 0472 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1DCh 0476 004h]                   Reserved2 : 00000000

[1E0h 0480 001h]               Subtable Type : 01 [Memory Affinity]
...
[1E2h 0482 004h]            Proximity Domain : 00000005
...
[1E8h 0488 008h]                Base Address : 0000000100000000
[1F0h 0496 008h]              Address Length : 0000000090000000

Example block from HMAT:
[0F0h 0240 002h]              Structure Type : 0001 [System Locality Latency and Bandwidth Information]
[0F2h 0242 002h]                    Reserved : 0000
[0F4h 0244 004h]                      Length : 00000078
[0F8h 0248 001h]       Flags (decoded below) : 00
                            Memory Hierarchy : 0
                   Use Minimum Transfer Size : 0
                    Non-sequential Transfers : 0
[0F9h 0249 001h]                   Data Type : 03
[0FAh 0250 001h]       Minimum Transfer Size : 00
[0FBh 0251 001h]                   Reserved1 : 00
[0FCh 0252 004h] Initiator Proximity Domains # : 00000004
[100h 0256 004h]  Target Proximity Domains # : 00000006
[104h 0260 004h]                   Reserved2 : 00000000
[108h 0264 008h]             Entry Base Unit : 0000000000000004
[110h 0272 004h] Initiator Proximity Domain List : 00000000
[114h 0276 004h] Initiator Proximity Domain List : 00000001
[118h 0280 004h] Initiator Proximity Domain List : 00000003
[11Ch 0284 004h] Initiator Proximity Domain List : 00000005
[120h 0288 004h] Target Proximity Domain List : 00000000
[124h 0292 004h] Target Proximity Domain List : 00000001
[128h 0296 004h] Target Proximity Domain List : 00000002
[12Ch 0300 004h] Target Proximity Domain List : 00000003
[130h 0304 004h] Target Proximity Domain List : 00000004
[134h 0308 004h] Target Proximity Domain List : 00000005
[138h 0312 002h]                       Entry : 00C8
[13Ah 0314 002h]                       Entry : 0000
[13Ch 0316 002h]                       Entry : 0032
[13Eh 0318 002h]                       Entry : 0000
[140h 0320 002h]                       Entry : 0032
[142h 0322 002h]                       Entry : 0064
[144h 0324 002h]                       Entry : 0019
[146h 0326 002h]                       Entry : 0000
[148h 0328 002h]                       Entry : 0064
[14Ah 0330 002h]                       Entry : 0000
[14Ch 0332 002h]                       Entry : 00C8
[14Eh 0334 002h]                       Entry : 0019
[150h 0336 002h]                       Entry : 0064
[152h 0338 002h]                       Entry : 0000
[154h 0340 002h]                       Entry : 0032
[156h 0342 002h]                       Entry : 0000
[158h 0344 002h]                       Entry : 0032
[15Ah 0346 002h]                       Entry : 0064
[15Ch 0348 002h]                       Entry : 0064
[15Eh 0350 002h]                       Entry : 0000
[160h 0352 002h]                       Entry : 0032
[162h 0354 002h]                       Entry : 0000
[164h 0356 002h]                       Entry : 0032
[166h 0358 002h]                       Entry : 00C8

Note the zeros represent entries where the target node has no
memory.  These could be surpressed but it isn't 'wrong' to provide
them and it is (probably) permissible under ACPI to hotplug memory
into these nodes later.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20241107123446.902801-6-Jonathan.Cameron@huawei.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h     |   5 -----
 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 12565 bytes
 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3c0967078f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/APIC.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x b/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..317ddb3fbed94e4f49a87976fdc7f23b1a6c3fdc 100644
GIT binary patch
literal 136
zcmXxb%Mn0O3`XITcnlXkq!sRl6*D%L%2Ae5RD#JhHu=utPrpp@0J43U<G9+eEz!(O
p0B;wrJ6XY}$fv3+t#8iTuLjWcqk*CTI<LC^D}=wACRJWOATL<W3;_TD

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31c9011663639b4a0f4816f3b2b06398f94682f7 100644
GIT binary patch
literal 68
zcmZ>EbqR4{U|?Xhb@F%i2v%^42yj+VP*7lGU|;~TK{Nw{0)qoc4VVoE6CiAe2mn)-
B2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..497706c9742a9ea5396d6c9c4cc1cc2a4a530339 100644
GIT binary patch
literal 12565
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
CwhOfY

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0e5765f6ee4c07638c70647ae145e968718b67cd 100644
GIT binary patch
literal 360
zcma)$u?oU46h%)`E5*sdrCT<g^9Qy|7pb6wAJD;1aP;%?S#r}?8U(=$A@?0_a^G+{
z-=7Zr*p2;g3*F<|hY*4T<aIAP0p<Kl%1LivWByzE=Veftt@-_NO)66XwIR*knBIts
t?eaMgjn%}QYk&q{c(?Xe^KMITx#vH<336X#q6H=((dJuwh>OiW@d0Cl4*>uG

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b45838adb7d304f8a36c38c90d89f3629ec48353 100644
GIT binary patch
literal 520
zcmWFzatz^MVqjn_cJg=j2v%^42yj+VP*7lGU|;~TK{N=%fdD$6nGsc<l?j>8r~%gr
z1za!&in$1N0#Nx6%rJ$h=CQzpVGJ0JrVgeIKS0=v9}JW_Rs{xV_%bpfyAT#8Yzhnv
iAPGn308ax0Lo)}cBA7g*1}j_}RBQrF03N^$3=9B2oeTj0

literal 0
HcmV?d00001

-- 
MST


