Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A64EC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs9k-0005cq-M2; Wed, 04 Jun 2025 13:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9T-0005WF-7n
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9R-0004BP-6W
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:46 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-742c5eb7d1cso186488b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749059023; x=1749663823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGdzMHaC98xoNo4pnLALcBmJMoP7ii68m6A0DOqBTrI=;
 b=Afvw9W1HybDqxc1m/ZvXUPQc8v4203y+dtL+G2KMtDDhCNGDoti6G7uAk58asjkgVY
 vojV62L6NvlTTbXJ6VDLg4CydCegDQJam4tyuRTXECOIUh+dGr28Qp5m4Of1MbCBVeOu
 Crb+GgNzdTIfil+WvGnnpyVSRzNKeMRtDuQe2l7PRSZa0iet4FSSLirQRj68DxhsUWHn
 30btKOtdJR81qpIjJqHh0gqNkaW+y1I8ZqJBMfEXkV+uI0jy7KYRfgcEAlKd5/bPrwRs
 6IMIn0IDMEQmuc4MkA6h3FdV+ZGEn1LEJEg2hPh7ZqN0uw3mx8YZujj40fZpqG+P9Vus
 FPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749059023; x=1749663823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGdzMHaC98xoNo4pnLALcBmJMoP7ii68m6A0DOqBTrI=;
 b=JJL5gLacDGzxV7jMzZCaKnIB/kEzk3VPUcs9+iFtUGnXYEefcsuTLfK4jXvBXgMF6A
 kuLvFao7S6gHX+r/0DY9lIzPy7YwWRWexu2LNVwMYMXBfoBoU2a0GR4znhnCCeb5uIDW
 KFWG8qgzAn8b02RNlM1FtCH1ldKQNygB2bqy/+plsW1KDDXmQKDv1Ar9bAioGoA5zWRd
 vFijHS01iT48N5sgYEQXXCTWRSJfLCWx8boULKbEKMEH6/AqIPxWLV4VqhgXzUJznlgi
 bVsOdlY0S4n6iiyVSa9KbFuqffMxZBxb9Hr2awGgmHmCUH56l12c1K1io23hvyoqBFST
 r/AQ==
X-Gm-Message-State: AOJu0YzqD9EmhsZkvbyXtysOMwt45TdF/vh+9vfh8so9QD4PjrYv9TOn
 F8bQD7B/9yAKS9HvvgzuUEinbdiM7rzGPCuH+yOqrlTnZPngDQz9NQwIYGrincrrSrg/rAJiFDD
 8NG7vdR8=
X-Gm-Gg: ASbGncs9wHnYzPLFf+EAKIgIxis6o7o8SFyfO7vbMshj8wYRAi1cD0hqjvZxKgriuJz
 TKd/OXdUfr4fij/NvK9FUEJufWlfGBKJdhEeVRaQRkEBtA4C6NXkcgkhQ+SpKVX9sDZynNtfNYD
 E4aZig3jHIwBCblwthM7t45T4L4lW/Gsv+VYYPUJBW/qLCTietYtfy8eSPSrj2qpO1+mbyxGhir
 jJPT7js5VMSs7nYbZPN7jnsdzxaQMvvZCLXSwPvaIbhDAoUZfb320BaR/7YgpXTC8jsxh75PBro
 I8AAmxtqtUnpZw30306hA41CgoIh5J/etKuClxEzILm5mFilndzM5aTto4vqaQ/7IfeoSrqbk+w
 MiScQAkn+5Lkp+O8=
X-Google-Smtp-Source: AGHT+IFfEU8EKrgbpk+RUEcqmlGFxpsm0YfTaKoMu8MBZU9SneeNTEvTgmX/gH+lRoekFGTiCV5NRw==
X-Received: by 2002:a05:6a00:b93:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-7480b1e4e07mr5164684b3a.2.1749059022792; 
 Wed, 04 Jun 2025 10:43:42 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab109sm11418482b3a.40.2025.06.04.10.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:43:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v2 1/3] target/riscv/cpu.c: add 'sdtrig' in riscv,isa
Date: Wed,  4 Jun 2025 14:43:27 -0300
Message-ID: <20250604174329.1147549-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
References: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have support for sdtrig for awhile but we are not advertising it. It
is enabled by default via the 'debug' flag. Use the same flag to also
advertise sdtrig.

Add an exception in disable_priv_spec_isa_exts() to avoid spamming
warnings for 'sdtrig' for vendor CPUs like sifive_u.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                |   1 +
 target/riscv/tcg/tcg-cpu.c        |   9 +++++++++
 tests/data/acpi/riscv64/virt/RHCT | Bin 400 -> 406 bytes
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee3ee0e883..eeb44a2f1e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 81174de409..7fbfc26adf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -451,6 +451,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
                 continue;
             }
 
+            /*
+             * cpu.debug = true is marked as 'sdtrig', priv spec 1.12.
+             * Skip this warning dince existing CPUs with older priv
+             * specd and debug = true will be impacted.
+             */
+            if (!strcmp(edata->name, "sdtrig")) {
+                continue;
+            }
+
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
 
             /*
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 13c8025b868051485be5ba62974a22971a07bc6a..156607dec45b0e63e5b3ebed62e81076dacd80d0 100644
GIT binary patch
delta 49
zcmbQhJdK$v$iq2g8Y2S(<Ex2W2COEGj0`#x?N_s=loVyAPkd23IgL??BZrZJp^TA%
F0RTq!4730M

delta 43
zcmbQnJb{@j$iq2g0wV(h<JXB?2CRCFj0~z1?N?9ySUowLQJEu+k%6Irk%0jK_Q(p3

-- 
2.49.0


