Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2BC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJz-00068y-DA; Tue, 11 Mar 2025 09:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEv-0005v6-TO; Tue, 11 Mar 2025 09:01:47 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEu-0000L5-63; Tue, 11 Mar 2025 09:01:45 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fe9759e5c1so8054887a91.0; 
 Tue, 11 Mar 2025 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698102; x=1742302902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lV0y6ykMDBCM1ul3LncOR8t4MUHPncGhWb9AC9RcVko=;
 b=fnNjkko7V8djKvJXXLgjgrRE8/pdBbT4eDrQiXd9CbCsnT7FPhlllRMXIFPcNaR1/P
 6XteelwdKMTdsKtePyJqH0R6jZabemK5KAzTTI8wIitERtU6J0RmHKc3qH9tPHdDqYIs
 LiXhIXE2CxJpuK4NeyJiIkwyS3DoigOvxaYQvGTvLnpNkoD5CyeT4OMWOaVQDFlSHchZ
 FEnBWWMNyG+jvoLVLsZqGtMDN5vYcOSDUqzgkEVhZiYetuQa6+Opp7OQsR/OeR211sGw
 u2EKNyd+48wNDl3s7wPLOX/qZnxRFQPqb4B+fpDKggeeMh6HP1yVdFqI29fyqUgQmney
 XLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698102; x=1742302902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lV0y6ykMDBCM1ul3LncOR8t4MUHPncGhWb9AC9RcVko=;
 b=HWVEEfBQ7Et+vMDTIpnGiXCa7O2fdgFxxZM17BTreuZHHqntYaozYPvfXzowTkhzff
 6FZ/EMJ8Kn82SL44Z2sx5XfTxMYRt4NOFl+EnYaMiBBMddD6IU7mI2kjAx9HT/8Y8p9c
 IDXD/3jJSaop6zNQmKR/xNwougdnF/FSnjaOKUWY9Ka24cIwZnSgtyVGfb1hlkiWJzpy
 V9LhsJccW1avsD2ijz9gpKYkTy+N9jFh4HWGEGtDWE0e58WKJLa4cX3Y1aBM0OXWDV7R
 SoDUh+b/QJimPesPp0jtE/gppU52TdD/8m7a3zaJNRLgfEtfDqn95mCvXhQMK3btufDj
 6MIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIqn30pXoGwyVeLCP+XR4HOJyez/Rc8HKAikdNlHw271xvXc5z1m8cNj/VUHLvI5vVhJb5jmoJxA==@nongnu.org
X-Gm-Message-State: AOJu0YxkrRz1oY1HBTC3ZJkEqpqhfYrUpW+91xBmLkIfirHFqbL+NR/O
 methTdK/I62N0OoXXs0XZJ8T0dKCyfiHVED+2oJ5q5tSKasdX5tqB2lxhQ==
X-Gm-Gg: ASbGncskZbdojavG7J0FzybO8svhaWXFx5vXD9hSgbboV7Eo86g1imE+KcmbO2r/z7u
 Afod9WPTZtqnsUstRIZjYs0i/2S6UuDkrWJGS7K937NrwdhI53LGKGvf+QtshdOEEDuX427t2js
 nOCym8r9HBdbVvdmBFANVFlMMqUBIzTmcAC+7cM2bqp9a9AKYZC3XGr+bTsvKCqTeEU8oDS0PW1
 umwoA1fSXS29mIU+p6RHKyI6aUGn73NQW8WJEhOyTVCw4RRWc86dONtUjM0+PCvWWixTiIcAej2
 1+vQAN0CnxO1zxOGYVlgZHFbmWZ+slvdvyxrhvLDEyWcDFDxKXY=
X-Google-Smtp-Source: AGHT+IFdo6Q7W2VRMrdNXkKgtKJ7N7iDZIPAYVg198lj4C5MNEmZNVQa3zcn4h4O/NeQxEU1I74E4w==
X-Received: by 2002:a17:90a:d00f:b0:2ee:d433:7c50 with SMTP id
 98e67ed59e1d1-300ff351ae3mr4025558a91.23.1741698101874; 
 Tue, 11 Mar 2025 06:01:41 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 64/72] target/ppc: Wire up BookE ATB registers for e500 family
Date: Tue, 11 Mar 2025 22:57:58 +1000
Message-ID: <20250311125815.903177-65-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

From the Freescale PowerPC Architecture Primer:

  Alternate time base APU. This APU, implemented on the e500v2, defines
  a 64-bit time base counter that differs from the PowerPC defined time
  base in that it is not writable and counts at a different, and
  typically much higher, frequency. The alternate time base always
  counts up, wrapping when the 64-bit count overflows.

This implementation of ATB uses the same frequency as the TB. The
existing spr_read_atbu/l functions are unused without this patch
to wire them into the SPR.

RTEMS uses this SPR on the e6500, though this hasn't been tested.

Message-ID: <20241219034035.1826173-6-npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9dc5ace828..8b590e7f17 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -922,6 +922,18 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
 #endif
 }
 
+static void register_atb_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_ATBL, "ATBL",
+                 &spr_read_atbl, SPR_NOACCESS,
+                 &spr_read_atbl, SPR_NOACCESS,
+                 0x00000000);
+    spr_register(env, SPR_ATBU, "ATBU",
+                 &spr_read_atbu, SPR_NOACCESS,
+                 &spr_read_atbu, SPR_NOACCESS,
+                 0x00000000);
+}
+
 /* SPR specific to PowerPC 440 implementation */
 static void register_440_sprs(CPUPPCState *env)
 {
@@ -2911,6 +2923,11 @@ static void init_proc_e500(CPUPPCState *env, int version)
     register_BookE206_sprs(env, 0x000000DF, tlbncfg, mmucfg);
     register_usprgh_sprs(env);
 
+    if (version != fsl_e500v1) {
+        /* e500v1 has no support for alternate timebase */
+        register_atb_sprs(env);
+    }
+
     spr_register(env, SPR_HID0, "HID0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
-- 
2.47.1


