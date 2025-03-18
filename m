Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5ECC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWlo-0005KU-Ez; Tue, 18 Mar 2025 09:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjY-0002Qp-Bw; Tue, 18 Mar 2025 09:12:02 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjT-0003tr-4D; Tue, 18 Mar 2025 09:11:48 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so1037392666b.3; 
 Tue, 18 Mar 2025 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303504; x=1742908304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EVxpnQ8AEBa+S4Znun5esfO9UMpfrf7hVR1yYjzFCA=;
 b=ZaNYSc/Gs4+gIVGoF/QVMsJ+AKUH0kyDaJcU5w1tyCixvto78znvhWZUIxJG+hFGRm
 Y+5FavMRFTjT1SRqfcvVMatUzu1YDiT2HqStIBCuXFcfcHH6e6rzNUv6hmOs3gQ1wiyy
 DBAyzuqcioP/brsR5W0+94B3ivZlBTakktQmyy0OBkr3Dsvcq9hasMdBoBAy+WHLGr3+
 YxvLy9m6kg7fnGHSJsD6snCSiXB2Yz/VakTfYO9bF5yHEicE5vYGFEG8ilxtk8ry8wsK
 Xim/V9Vcw7uei0uAc2iRAis1XaXRmCKnP/705j/IMuhatTVYhNd4l6xcRchhyi3GvSaw
 m/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303504; x=1742908304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EVxpnQ8AEBa+S4Znun5esfO9UMpfrf7hVR1yYjzFCA=;
 b=qw1Y7KqobI94kDPaa+kk9DZEJ3Bstzpwny9igvJd6mG1zzXRxZ+wfALwpbkrHXZgX5
 3zClFQSVTTx4wjWqSlnpZzb9foyh7+rzXe61jqa0Edgf/2/gJzgYhu6BsfHe52atSmRp
 CqR7VN3DSfjFkTfvauXzeauKr3yRd19SP82vCxW9g5Jdbfjd6TZArmLWUZ3TYJiMB5SU
 V9zGgeGGs8YnuLvDgNZKQM8nTf3ABIBa5zE+bHjSI/rlvlBtTQOkOnegU+m0rsX5Sd3p
 T4vkJWE/c7VFi0ns535XaP8o1dDOushRl3ue70PpAuGxwII7ADAJraPIQFYZrTktnK1P
 NQwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqs/eVlKZZdVj3zYEJ/11HpuenpGjLTu8d+5FVxJmAnzFdXcyPt5EHyWhqdFKEgTkx5qdGyBLWQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz5EDnSA4ZvqUh0iC8j7m3nGrSwjm6ultlr5MeIzPl+khpbOKbh
 sCVKNYb06UMJxE1GXSufHK00/m6XFTt+G2U/Y9Z9ZZ6U9BwP0GiiH5isJDhf
X-Gm-Gg: ASbGncs6XPEHEXjIisRrceLrcRQ+wlsDV/zpBYwQJlEwiVUPTs5IKop+2yaZXvggUsb
 VIF4x5Tw8OAMRTcDB2sq9IAgbDcHFOCVT860XECrcHe4HAlzWqcHnJiNvAsCF/pm+o6ZJdsXQik
 B3uSIRjS5fqd7QJEHo9bBLiFbCEyEB4qXJjtDK/QKjiXfzBL57C6taZAlLdDKPLKRey/bqG69Wi
 zREXlzHnCsuyc61d8GOp8MoMY5NJD5BoIPigY898LXGXylGloGnnYk+VfMfgma+qVl8SwVAyNZ1
 rv4cuGtM00J1oMaGVNzSBXKt8QoCQglcdC0348caXDVWpWXKFWmJGLpokAcsPLUc3ZU=
X-Google-Smtp-Source: AGHT+IGFhtkm/+/tOjIpZakKVZobpqBEwhKeG6Z3oV3g9BYhBDX9dQQpDK42p0TrasQIF6j69a1y2g==
X-Received: by 2002:a17:906:1117:b0:ac3:3f11:b49d with SMTP id
 a640c23a62f3a-ac33f1203dbmr1302062666b.0.1742303493022; 
 Tue, 18 Mar 2025 06:11:33 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:11:32 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 15/21] hw/arm/beckhoff_CX7200: Adjust Flashes and Busses
Date: Tue, 18 Mar 2025 14:08:06 +0100
Message-ID: <20250318130817.119636-16-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

The CX7200 has one QSPI flash connected to the QSPI bus. The
defines are adjusted accordingly. The QSPI flash is a is25lp016d.
There is no parallel flash.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/arm/beckhoff_CX7200.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
index 3ceccaa9e6..1e7152e871 100644
--- a/hw/arm/beckhoff_CX7200.c
+++ b/hw/arm/beckhoff_CX7200.c
@@ -48,12 +48,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(CX7200MachineState, CX7200_MACHINE)
 /* board base frequency: 33.333333 MHz */
 #define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
 
-#define NUM_SPI_FLASHES 4
-#define NUM_QSPI_FLASHES 2
-#define NUM_QSPI_BUSSES 2
-
-#define FLASH_SIZE (64 * 1024 * 1024)
-#define FLASH_SECTOR_SIZE (128 * 1024)
+#define NUM_SPI_FLASHES 0
+#define NUM_QSPI_FLASHES 1
+#define NUM_QSPI_BUSSES 1
 
 #define IRQ_OFFSET 32 /* pic interrupts start from index 32 */
 
@@ -164,7 +161,7 @@ static inline int beckhoff_cx7200_init_spi_flashes(uint32_t base_addr,
 
         for (j = 0; j < num_ss; ++j) {
             DriveInfo *dinfo = drive_get(IF_MTD, 0, unit++);
-            flash_dev = qdev_new("n25q128");
+            flash_dev = qdev_new("is25lp016d");
             if (dinfo) {
                 qdev_prop_set_drive_err(flash_dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
@@ -242,15 +239,6 @@ static void beckhoff_cx7200_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
 
-    DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
-
-    /* AMD */
-    pflash_cfi02_register(0xe2000000, "zynq.pflash", FLASH_SIZE,
-                          dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          FLASH_SECTOR_SIZE, 1,
-                          1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
-                          0);
-
     /* Create the main clock source, and feed slcr with it */
     cx7200_machine->ps_clk = CLOCK(object_new(TYPE_CLOCK));
     object_property_add_child(OBJECT(cx7200_machine), "ps_clk",
-- 
2.49.0


