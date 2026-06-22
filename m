Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24417CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcgC-0002ck-19; Mon, 22 Jun 2026 07:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wbcg5-0002bw-Kg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:18:57 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wbcg3-0000Ac-6Q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:18:57 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F5763F2D4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782127133;
 bh=OFXY3uU4SUcP/KBJ5jLbxc+f3/kVknIh5hga3kIE+WA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bZxBQ9Iz9fQG/fdcHCh2bTDI52a74TLq9x2e1yrJpydmq4zVXwE+RF/GbxMST5kBI
 srcN4OoJ+3lbccVFfha33ylwnMljNVl/eM+fbpW0z5SatRh6xRets/Ll6qFO37kQbj
 slErHszsAn5vkuaLyi6X5V4nxXqGGfufGLeTmc3EQRpeVp0i5Ahso1EdJlgd8dO6H3
 27BQFnarWFm51a4EiL99sHQekvORLNkNSadIDGnZz9WBjsSqaZcIVeTI0sAo3Cd2cI
 KnK+6haQ/lhDOHlxI7YwkWmUjA59u4J8kSNeNRQD498g6DN2SLBsKCXZD8SY3KnoDr
 mrHKuqu75fIXHvTK2GXdBPJmVl9cXDPO7U3S5ipQdIsQVDHWFF8n4DN2ZiKVRnkRX0
 7V3UFM7vruY6NlUI4YWcuAuDaeSLoE1ada1l1fSjPCVd2HGkGUkDs4TlOLdeSGU+51
 lfIkOR5/wmQt7Cy/57+7J8z1u3zNVlOKwi4tAn9juMG3AUvc+wgmQGLipIuBnLUfTE
 7O4mu0tTVdVKWNjXSf0aT8OmJ7X0CBJM+XUWBUwxWqhASoPQ0ok+j18EKZKkQuDEW1
 Pq9L9Xn7KxXktp9Le6jcNSt/wRM94iIJsG/pdGluAwY9LXNRxMLcTPh0k1mTnjQgeY
 eml/KZr2sfPHFagYmZ2Urahk=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-465874136a7so1819062f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 04:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782127133; x=1782731933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OFXY3uU4SUcP/KBJ5jLbxc+f3/kVknIh5hga3kIE+WA=;
 b=jSI3uqlUdv6jjVEjWDB9LMpmrqimNxcAyCbD2QtmOzPM/MRN+ula0kplvtlrUXxvm+
 FVmCtJyNIjLahaPAPKyqRmDHCDRjg/gG8gKk+5+m9JKnXs5Z4HXlZBfUtm9lG0xzJEuZ
 oju5SUT7YEAEoPppyHxqCfokK3JecUspneBdC7vOmunhREGWnQ5UC/bcmCNE3mJrml44
 ndbps2WFGYX/8zbH+TMKNjQBcdvLbYKlXKz8TuFgtaps7PqnY939CCvXS8OzK47cPbht
 AAXy1ArrVJ+RjiqFO1AvF3/oGlEay9sV0DBsaaKIJbOtUc2XKKl1TKBwZcdYnsAmxB6V
 27Gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HFrRfouJUtGD+TGhGpvs5ePx6DSmDk0p6t7Md81dFbAlxZhseawD6kJ+/UEN2nEfIF/ZruWifXSc/@nongnu.org
X-Gm-Message-State: AOJu0YwDBthuSMAWuSuyrqAXpFy7rtGSApwb4sRbRIuxDEb1tlo0sw51
 B3do2Ac8tsXwIdcrqWzz/DOm6mON0ibG+ktk+OzvdIzW21LmoO2BkcQqVfGgVbiIZoeMTFE4o1j
 8RCAS5b/WOur35zbXTZRfD/gJZHyDkOrCBSAmOoXOOGqQ2nwAOYc8+w37qzJ+bU25F1397EzNHO
 KhTMje
X-Gm-Gg: AfdE7clDbDYBQTDFyaULtl8u6WVh4c7b+FRPk6L4rpP85GKeqSmCZAi0GMOMU2vD8I6
 IS7sjKBR3GMbbdEWqDpj0qTGXJrMD9HVOSJYBuXhQ8XwWcRznBgUW1PmPKWSIQjMt7KaFfyRAB+
 eMBABSkquWwSjhQop7cGeSXPnfLfGMw2Z0A40hays8iIR8Mm1BhdOXXe0QWiTShV9Pyzk3ovB6b
 IqeTo+DyE6HI8waWp+YRpfu2fTPmnAXNZlRiTqD1Rf0igOhYBO9sKd3nZtLyHBlaJt9RaKcmeV5
 JxrinIGSddPLQOc+Mzi6YPTDxDDYY6AR9ndAUAR88ekXPfVUozpepcdQjN4yv5R2BciBKmTQBaU
 pdKCL+2q+Fbn2uXWa1m7VwJF/LtFd3FMmvNsAAua1We12r4hsoE5dKAAt7rIyaueHaA==
X-Received: by 2002:a05:600c:1386:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-492490a7799mr144631705e9.21.1782127132772; 
 Mon, 22 Jun 2026 04:18:52 -0700 (PDT)
X-Received: by 2002:a05:600c:1386:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-492490a7799mr144631365e9.21.1782127132430; 
 Mon, 22 Jun 2026 04:18:52 -0700 (PDT)
Received: from workstation5 ([2a02:3035:605:b91c:8708:9b24:1b42:7a43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a9e3sm313672525e9.14.2026.06.22.04.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:18:51 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 2/2] tests: update SPCR loongarch64 and riscv64 test data
Date: Mon, 22 Jun 2026 13:18:43 +0200
Message-ID: <20260622111843.34056-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
References: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
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

On LoongArch and RISC-V the SPCR test data contained:

    Terminal Type : 00
    Language : 03

The corrected values are:

    Terminal Type : 03
    Language : 00

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

The ACPI table data was rebuilt with
tests/data/acpi/rebuild-expected-aml.sh.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	Reproduce the test data changes using rebuild-expected-aml.sh
	creating the same diff as v3 but in two separate patches.
v3:
	Update test data
	https://lore.kernel.org/qemu-devel/20260618124020.640794-1-heinrich.schuchardt@canonical.com/
---
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
GIT binary patch
delta 23
TcmWFtm|!Qw%<vxw7?1z}S|J61

delta 23
TcmWFtm|!Qw!2BNw7?1z}S{?;}

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
GIT binary patch
delta 10
Rcma!wnqbGo%rMbG3IGpM0&@TW

delta 10
Rcma!wnqbGoz&z1G3IGpJ0&@TW

-- 
2.53.0


