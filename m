Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB8EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7PU-00077i-9A; Wed, 18 Dec 2024 22:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7PM-00076i-El; Wed, 18 Dec 2024 22:41:04 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7PH-0004JD-81; Wed, 18 Dec 2024 22:41:04 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7fd49d85f82so184919a12.3; 
 Wed, 18 Dec 2024 19:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734579657; x=1735184457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dH0e3/pZqO5cSRapQt3yCMopH0TKWEFkSF3QFzJFiLE=;
 b=ibY8tRH0x64xikGaqRFhewe1HfIR8LRyNyG8dx2Prh14oygF8Oj8Um+uf7XS65clV8
 NIJHYVKWnGz+lg6FCatnZC6kCcmlXNtX9/zyG3/QoNNs+inR5Fwcjk3Y+o3ftsIh/Tms
 b5wn6b2QsISi4LKqGIcgcdLMGqy4RuZQ1Yfgbq2y6AjSrCk/hx7PePO/tqu4kT274gjL
 BjXyAOWnWI3Ts9s6SYgh7mi3II2h4og2qnBU9PM8vwVAZM/rmlH+TE++0aF8XTRR2tU7
 FBZ9Y6MC16xj2SH5rB4gHkSMqiSGZQ2/pXb6oEUOn3Tm9qmxyXeDDhXp8gz+RTQebJSb
 biZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734579657; x=1735184457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dH0e3/pZqO5cSRapQt3yCMopH0TKWEFkSF3QFzJFiLE=;
 b=bB1uOACURmwt8NfveagC4s0p0bw8aLtkBurnkk9plyrwsEbdQ0VqTvFTEhDFnDt1Fm
 WrYGESlHb5HepBZFcTz9Ol6UAGNzMhZgrPIarJD/pZoAU075Xm9ZtXQQNy6j+rFs57tz
 O+EAaPnEbIfrEekKF1k7MLG5NnRAKuXn8jM+H/3xgJW4lMpypk46Rx3VrDUsgYowccei
 gSg2+dYUx3uUm4XFx+Vfwradd10TuSJSXYjj5RFkZijGiOpsLVlan95L97fh87GHlB9K
 s1BBROCtrFT2GjsmcNDm0KhbO9vnubbOmmSFX2p+BEEG8ocP3Cqk5PJt6rAh0Pql9U1z
 GAYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOZs8GJ27DNti2wAddh32LIrPLH2dN53oeSBTMm0AUTIVc0dUVyQ8mWUQ+JCrf+mBVomgsUUtHivY4@nongnu.org
X-Gm-Message-State: AOJu0YyR15PkcOL0FNl2VxQ1kEMaBD3T7vDUjevUCIw7aLK7I31HILm3
 BqWbAmjmg1lBiLCYPtrxk3XCBd7bjAj7GWKHaGzKIMMF65YaW3efwphwfA==
X-Gm-Gg: ASbGnctkKKKVm9+wWQRgvhHiwKbwKWxCM1JAvOczOcexCwdd0StQNJl0NYAJ1Cm5u7v
 icDqgIYKUdq7+hbqql6afH3nfjdR/4A1LgToJg453dvS9FnC/ifgt1nCmyBEFQdU4L3xG1oWSny
 sKj5OSzX2KreXKjWxFfJ9An4AVAzaqaCVmykHzPh2AmXBCrcGj0QcqZfzU8sqi1tjSU0PQm+I3o
 W4LE6yGhHr4VQnrJXKHMRtPV/9nv5azfugaRN3NGNr+KM6lUASdlf1wosUPbz0qLx/7j/AiTKSs
 Wa5noendUw==
X-Google-Smtp-Source: AGHT+IF4F7xuIiB3HLAG4AJh4EeOoDe/9AIZQJAWe7c9SZj3c95DgHtuhbX1LEERG3D+53XZRg9AWA==
X-Received: by 2002:a17:902:ea08:b0:215:2f00:67b1 with SMTP id
 d9443c01a7336-218d6fd4be7mr65976105ad.6.1734579657231; 
 Wed, 18 Dec 2024 19:40:57 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc970520sm2881595ad.75.2024.12.18.19.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:40:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/ppc: Wire up BookE ATB registers for e500 family
Date: Thu, 19 Dec 2024 13:40:35 +1000
Message-ID: <20241219034035.1826173-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219034035.1826173-1-npiggin@gmail.com>
References: <20241219034035.1826173-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1253dbf622c..4f0a64e7f99 100644
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
2.45.2


