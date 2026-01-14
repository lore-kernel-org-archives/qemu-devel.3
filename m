Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8502D31A0C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsbb-0006B9-2V; Tue, 13 Jan 2026 23:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbZ-0006Aq-J8
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:37 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbY-0008LI-94
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:37 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so3684931b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768365335; x=1768970135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8DcrnEjphKOWXSl7mahCJlmtxkm2g8RSUes1tVeSkw=;
 b=CQnLmyJtoQWotoCQrfXPvdYHo1/N+N5a7UAnGmJkh7s38yBlqwE3aKxvMumCTwjoC4
 dbhFwB7I932tQVLtamX6PJaBU01sKflzMw4Yx75t1mrGChTF6TcUNZrBiD3PqxnqzJ6d
 OxARAYxm03e6z9AV2zZDRuCKp9q5rpD2RnoSRfG4AXWyooq1FnsH3xVtsjNkBswEHrjs
 WBAWGxsNs1mCTRKAzJHep79lF3ENpMvdzAqpv65aAmcCyyQfBRFkMvBb9f7Fc/KpAB2O
 YOc76AaLFDIeVQ/wGrgkLBwnIF0p3X1+UjpBTRZoAK12UAcrgbuysFKtvXFSBMO5VPcT
 QYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768365335; x=1768970135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8DcrnEjphKOWXSl7mahCJlmtxkm2g8RSUes1tVeSkw=;
 b=ri+wpWYtpmKnEYHD3rITizC6jLcHCyKifvTx+gYpaaqt7sqso6kn+e8pBfL0q6Cd7d
 MNBR41Igfj1X9NaU+FlbH1+bqf0y4WLVbCWUAJqW3qyhcuTA/dGOCO0wjVtde2we1LET
 NQtqOVIercSmuu1jWTPqSOWwI/L2aH8TENGEGQjy3w1aXwNmO5297KBp11oH+SGsefwJ
 YBFYRYB0pgFjBgBBdUdcOm3RHM7aeRkaEjMlcvGImehkbxdgjzvE8Y0rJKKxcLgV5Pbr
 D36M4sOUJf2dQpil1fejpWhWWkR1EzNMtOfyIiAcf9cbBqUr4k/ndJTWDOGMtYiK0bIQ
 bYYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDIlTyixxPUGtM6nsAg4839h5i+7/rTNuyrJTimJBo0a16kRpw3b+P7Ryer9bGSskAPW+BC8DUGXrb@nongnu.org
X-Gm-Message-State: AOJu0YwucK0/7oE7vXIP9QUhfu9juGTEpU25cv1PQaWV+/G16koc8d2V
 EKR+/Eq4LRTuHu0Ds9qiu344AHIprbxGTJwSJpCoflYNMeOuCPuCFiKU
X-Gm-Gg: AY/fxX5ZfboOt+1maPW4d4eoMkpIuLvTIMQfobSlyKMLpQV2hSNh+UK0IE+iD1+gP7Q
 eITnvbXKZRQENzJWyX0r2lqh/M1VQIHY7T9Xbunm/BONvmkxH7hPWGtLcEymNF1bsxx8fJcinFz
 Vje62WlJvBjH7v1habgOEajzoS4+mxvGfZi6aqEW0XIy37ZMtBc/wNbuSV0rhh83350hDX7yyzN
 6ABpC2FuVRqzyMyoWFYOnIbYLNnUamFs3qNZSU+f2ZqVyN1AUppR/5/g7USgFLxq47/5zST4ihS
 fjyKhmSsYacPnfvxE6mz5z04FfdLUTmgeKXbJ4OchpgFh6Sh4gfaCuL29caTGoGAnMqqZR3Udzj
 A0VIHotaDl6u+4OdUlrYShsnMjqPdgUlr7XIxKJXTD3FtzLNjF4IpF69BuhdhQNinQvAK8YpcJ/
 HAysIcZLugEjxgSy5tz//b
X-Received: by 2002:a05:6a00:4517:b0:81f:4708:b477 with SMTP id
 d2e1a72fcca58-81f81ffde1dmr1111239b3a.60.1768365334810; 
 Tue, 13 Jan 2026 20:35:34 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cb5352268sm20702659a12.0.2026.01.13.20.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:35:34 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 6/6] hw/riscv/atlantis: Use halting kernel if there is no
 payload
Date: Wed, 14 Jan 2026 15:04:28 +1030
Message-ID: <20260114043433.1056021-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114043433.1056021-1-joel@jms.id.au>
References: <20260114043433.1056021-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

To avoid OpenSBI hanging with no messages if there is no kernel
provided, add the simple payload in that case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 2e96c5954268..cec17e7cb952 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -745,15 +745,15 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
                                                      firmware_name,
                                                      &start_addr, NULL);
 
+    kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                     firmware_end_addr);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
-                                                         firmware_end_addr);
         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                           true, NULL);
-        kernel_entry = boot_info.image_low_addr;
     } else {
-        kernel_entry = 0;
+        riscv_setup_halting_payload(machine, &boot_info, kernel_start_addr);
     }
+    kernel_entry = boot_info.image_low_addr;
 
     fdt_load_addr = riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
                                            s->memmap[TT_ATL_DDR_LO].size,
-- 
2.47.3


