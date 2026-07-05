Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A3AC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgGOo-0002eO-5J; Sun, 05 Jul 2026 02:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOY-0002co-52
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:32:03 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOU-0002ID-3p
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:32:00 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B2BB23F11B
 for <qemu-devel@nongnu.org>; Sun,  5 Jul 2026 06:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783233116;
 bh=jDPVR7xcKkphwZhDAqDPMMWzoOJaydOg5RWPodLSt1s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=naMi6ewpWCDC4d+Ce8rSITv1qEn1Z1xP2LB+2dbMlFYmiEft8gZOyVswXK9hNvhim
 DTjoQ0KGa8dSkMcjfNKswn/4fq+sFvb6+nIUXm485DfZPk4t9/y4Eceqdx5IPDgPll
 glb8qOKUMLlpNQr3mcXfaWePVRiqAnFh8oTApFQ6jD09kxP0DXsmpZD2R/SomrF5op
 Po7XUZJjaL3bvvIfwgAjcPuI2pCU9ev1qLXgffSQAO0Zk1TPpKFvU7N2HIsfiy6146
 cDO97sFyNYE3PdqdB4teqckQ07iv0+SBRlW0fy8+RzWwChTvfHsQwmQmj9Yz7cEhdA
 XS3OVho30+WDHPOZlJ3ydS6NGcMMyfm1mOfs2RGV86svxl001oIBSX28X/poi32oZI
 ZFNo8652O8CW+K9ZZnlWJOKGdIhj11ebIKVBRnXBeYOO8kZ/tutc1PX39olQSkNPMv
 KtsvvZN66yD6Ly46N74K6pt9k2aQrFw/fMuZVuxJDJO5Eo8jbg3IJ6SnYq1Gyy3WMM
 wOOZHd6QLTVc60nov7snceUin3UC3ULufJRWURTlAT8cmgacY8AWqzEL8McemI9Xg1
 e7M3FctjSk0+IEy2AZlE0/9bwLPpElHQ4r3CcrA9JlW++oARaoOkBACzQLYH4gGMUH
 DpIL1UreK+C7e3Y13CYJUWe0=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4926d371224so11360855e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 23:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783233116; x=1783837916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jDPVR7xcKkphwZhDAqDPMMWzoOJaydOg5RWPodLSt1s=;
 b=BHNQ8FdSQD+Wrqq0w9ZnNFSYcQCAUld4z9irmfErB36FlgvZSTn7e7zqMOtGZtfV5O
 wVLOSYpPuC3dfNHwEax6g1eyDoq7CsV02QCeC7vr+XPHSZXxku2xy6hIp+RlsytAD8TN
 gOJrj/to4oEQKEemiP7R1zbu3kfYDnWOe/4FTrHd+2xQFyVAvnII+cePuLn7LjAQahTd
 srFOTnEWKaFLMn2MXB2u0Z6Mv4fKvrDAubZKsys+NSz3/LKr5fQCFAh51H9qGJypOClV
 S7R2kn+InvqtKl2IlI3pNNTYDyUqAJi5hLV7F5R1FGI21sMYK2mWvG7fQdv2EQ/+ShfR
 jh9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DREOLDfJ2ox2OnA+zPphTdKLp4HOkOk9kKUJVZq5P20GBCo4dbDSpTKhuAjI68nAK2nAFaZygG9hO@nongnu.org
X-Gm-Message-State: AOJu0YxGSOOkXydXaNZ2i9d296JPyAuk7kExq+tWoA96BOEi9+ndKQIC
 jiBLdeYu/xd6qTSBpElvnlCX6xxrcR0pKz6+7SzwmO8h2oDmRbXmaoEYGZngj3h+ZW587TCco1G
 3/OSstdkjGBM6vtTQEt4blRX8/+nz3y1iLVT0Z9Q7FQp5FP5XCocFUt3HtcKNJTO+sbVDbfb5
X-Gm-Gg: AfdE7cnLSWoTSYMaqxfp9znhOkMzYBFx8DOnKWdPergqN0GyLE+0jYIMCr5EPGpoAZs
 nW84b0xN4xer/KDaaYk6TSytv/fv2qfecb1JfzmZXYseblWl26jNMNhKDKop2wp6gfvwc3SXg3s
 fe98le/8oPRyDY8jCrEmhYnYKCUmr2D9I+lp3Z/7ACRVeT8JX+aSlAMf07E9JBRJqFWmfwqn+vl
 I4/K7MuLbT2eN1PfkhX7nvGg+aotFaXPHjaTYvvCTXjKaJd7mbAtKVjRDOfFTZMpcSyqDzoBKs1
 50o1giZjrEl1mIq5AEE5uKvZ5FoKtkjDpHSf20NX+TxKsPHkWJxulfRCtVLPEk3qbdrmGv+7KWC
 rgC+uag/BBkOcEih28OlFHJOqzhM4oCYWLSVjsrNp5n1/YsuLO9SruUnFUSDyQmO3cA==
X-Received: by 2002:a05:600c:3f18:b0:493:b92d:9166 with SMTP id
 5b1f17b1804b1-493d1d33d09mr55592625e9.12.1783233116343; 
 Sat, 04 Jul 2026 23:31:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3f18:b0:493:b92d:9166 with SMTP id
 5b1f17b1804b1-493d1d33d09mr55592435e9.12.1783233116066; 
 Sat, 04 Jul 2026 23:31:56 -0700 (PDT)
Received: from workstation5 ([2a02:3035:683:e876:a486:6b9b:f6eb:790f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm14293266f8f.26.2026.07.04.23.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:31:55 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v5 2/3] hw/acpi: correct field sequence in SPCR table
Date: Sun,  5 Jul 2026 08:31:46 +0200
Message-ID: <20260705063147.199732-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
References: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On LoongArch and RISC-V invalid SPCR tables are created:

    Terminal Type : 00
    Language : 03

The correct values are:

    Terminal Type : 03
    Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

This page shows version 1.10. But the sequence of the fields was not changed
since version 1.0.

Our LoongArch and ARM code uses version 1.07 of the specification.
Our RISC-V code uses version 1.10 of the specification.

Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v5:
	no change
v4:
	Reproduce the test data changes using rebuild-expected-aml.sh
	creating the same diff as v3 but in two separate patches.
v3:
	Update test data
v2:
	Mention the different specification versions used by our code
	https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
v1:
	https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
---
 hw/acpi/aml-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 9b3cdd3781..990abc64cd 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->stop_bits, 1);
     /* Flow Control */
     build_append_int_noprefix(table_data, f->flow_control, 1);
-    /* Language */
-    build_append_int_noprefix(table_data, f->language, 1);
     /* Terminal Type */
     build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
     /* PCI Device ID  */
     build_append_int_noprefix(table_data, f->pci_device_id, 2);
     /* PCI Vendor ID */
-- 
2.53.0


