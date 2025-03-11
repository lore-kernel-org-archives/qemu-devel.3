Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D440C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJ0-0003SI-4c; Tue, 11 Mar 2025 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDw-0004zj-2t; Tue, 11 Mar 2025 09:00:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDs-00006w-EF; Tue, 11 Mar 2025 09:00:43 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223959039f4so107093655ad.3; 
 Tue, 11 Mar 2025 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698036; x=1742302836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SOjOhB33VcprDEO41KFUFk52SOqUV2z89oKt7zJj2k=;
 b=KMr1duMRe3iB4aMaisXIuLVJodxxkZWcf1mteaP9BR2aANi8AF84JXqAfCJ3gZYyta
 oLBHKZ8TarBOiS+ld9q75mhNGHj9xf/pEL6BACZHCYHbNMtz1FjDjehd+R7do38xtubG
 BqovjpnSvBZzz54jZytSAY69+PRYSZARsTZxEiVdI/KRzLomG02fLEGV29q/Jot2rBFf
 LsXc1lrdIPoTakZx+L1LObRHUuNCY9MiyU+so/UUgTtmI9LDNEJ4RpMgyfb92cskRcOC
 ii0zOtBHbAKXZoY7WFk3yI9YMpillTbnmTrNtL5aygycA1V30wHHP7FW+/4KQkShB5/o
 LSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698036; x=1742302836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SOjOhB33VcprDEO41KFUFk52SOqUV2z89oKt7zJj2k=;
 b=WZkxyca8GRCJwRuSfqFfMGUT2B4YkCPrcjWgpIYBp3/odEcOlPRNsrpDkDjuXxCXJD
 zpNU3AB88OqGfgSnWFH8AnihYLW+ZWPRlWPevbnwXfR9b4//azzwKY9pIB1y2Kkt6YoA
 GpHnCNPNbdmoRrTl3Qe3GZVdrXCF9QLc4P2VfK8ynxx4Pcny0596MQfH7Vx/Wcgrd9kw
 AFg6HoM5OzYZ8g4BzIBx+yc+VWX2LIm9RHtRMvP1YrHK3M3avXO2PvUfPnnT/3GANRFe
 Uak16ty4Lh0vcGTtyPg2gT13azzjSdxuBlIJoQfQmIM043Uh7i6WsPR0P94R3zy1oBDv
 BDEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEruztmpkhvsiWJnToFsbixJ8MFve91/eazdav/2iqG4ZBkAfrrkoNIC6/2BuNAZF386xAIU2u9A==@nongnu.org
X-Gm-Message-State: AOJu0YwM1J+KnEQa0oFoWvuX5J1M8FIJZ1NyAa9qHELrGit4FUpudQAO
 x8q0SKCWW+jW5zzf4Fx4S7uxsGT/n2BcED8XfaN9whGKLuvVGJHY9Zz10Q==
X-Gm-Gg: ASbGnctxRGV5KRQ/bmT1W09sLecOlvQ0vMS9tBn9zzprWqGhe5Bv86Q+jMOEM9IeSdj
 kEOWeoaTVBKS5W/EBMiDVqdJXMhK0ujdAWZIHoJ/3HIy9lmTTEIWRbUUxKjWI8j5UPum7ZdFENQ
 W+O6dNjQX3Cm1M4myBvmUYMN4PVorJcpsZYw3Dl3uqRqPw+o3EjWy+vustbMBsvTmIDaCaIx54R
 VvHpwOvwmMIVqaXsB36gblQtzSlsKgTPGdhmiIG7QlHygzFl1JSdQD/VnJvgnu6vWac0v/kFTYx
 G9dGi3uxclcXX1qvCkCPM1fyeGmsfhzxWGui03pKuoHmWQ+v0Ts=
X-Google-Smtp-Source: AGHT+IHEqSmL9HA6QPp39OII2HSFm1GvK8H36w04DYL7MNdIUNL8CqudgVl32QZt22hc/hIM1yxeNg==
X-Received: by 2002:a17:902:fc47:b0:223:5a6e:b20 with SMTP id
 d9443c01a7336-2242887eb29mr245014615ad.7.1741698035735; 
 Tue, 11 Mar 2025 06:00:35 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 dan tan <dantan@linux.ibm.com>
Subject: [PULL 42/72] ppc/pnv: Add new PowerPC Special Purpose Registers (RWMR)
Date: Tue, 11 Mar 2025 22:57:36 +1000
Message-ID: <20250311125815.903177-43-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

From: dan tan <dantan@linux.ibm.com>

Register RWMR - Region Weighted Mode Register
for privileged access in Power9 and Power10

It controls what the SPURR register produces.

Specs:
 - Power10: https://files.openpower.foundation/s/EgCy7C43p2NSRfR

TCG does not model SMT priority, timing, resource controls
and status so this register has no effect for now.

[npiggin: adjust changelog]
Signed-off-by: dan tan <dantan@linux.ibm.com>
Message-ID: <20250116154226.13376-1-dantan@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 682583d1d1..25b1e6d6b0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2102,6 +2102,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PMCR              (0x374)
 #define SPR_440_ITV0          (0x374)
 #define SPR_440_ITV1          (0x375)
+#define SPR_RWMR              (0x375)
 #define SPR_440_ITV2          (0x376)
 #define SPR_440_ITV3          (0x377)
 #define SPR_440_CCR1          (0x378)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 54035c7bbb..8d73e11540 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5773,6 +5773,11 @@ static void register_power9_book4_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_WORT, 0);
+    spr_register_hv(env, SPR_RWMR, "RWMR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.47.1


