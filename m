Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F6CF6BE4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 04:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdLXS-00073A-Mm; Tue, 06 Jan 2026 23:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdLXR-00072b-Tc
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdLXQ-0005mb-A0
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767761567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=L1ipOddK14ruNLkuMSUgqvjUQnelCDaxp1SObaYsrog=;
 b=WDFkZjnJHd65ueGalOvz/3kGeGVmott19ZdoY04NiZA0QIsmDziH1xyShRoOkvRfdkeXdT
 S4wwrnmWXcRW3nvnza7FozAiOsIXSbjVV4BjniIPGDvYIF+Sv+E+Pp/6SaEF/aHipXn1MH
 UVUzzGGTKUwdG/I2OKlKred1HhZ8Q60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-fvbCa4KjNmiFn5uJuNSPQw-1; Tue, 06 Jan 2026 23:52:42 -0500
X-MC-Unique: fvbCa4KjNmiFn5uJuNSPQw-1
X-Mimecast-MFC-AGG-ID: fvbCa4KjNmiFn5uJuNSPQw_1767761558
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d3ffa98fcso11855435e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 20:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767761557; x=1768366357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L1ipOddK14ruNLkuMSUgqvjUQnelCDaxp1SObaYsrog=;
 b=ckXSmJVGC1Lz2w/VfqRjuUMGHl3HXil+hxnnqwjIHCAvKb3Cn+g+/nIDfkT5+7CJUA
 qj0sPvYVaTbYkB4cBM1vSGreSE/Bvj66bzD25GMnDAa6UrfBDmJTfhb01aVHD6ZFIahM
 9MZ3vt2MVBa5hkrd9b3MgS4pGgATv+Yzbd2MiUwgI2YPCLKAQnIOY5mP4ej3ZLyqrELZ
 6dzBQE+/Y92YXDx9KdlWFO+Dg9Y9lfdbwdHCxmFH6n5xjSZiq1E1Pqyt/+mwpyLyNC6g
 W/2bGpV0HfIpWxfzqAlWAiVA5ylMy82ZkDHbe6Q3HwiTz0Fc4iBQoWRr0oWlYO1zQ+7n
 3PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767761557; x=1768366357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1ipOddK14ruNLkuMSUgqvjUQnelCDaxp1SObaYsrog=;
 b=NoyNAF5q3jYZ16kqJddi6XkX0Tn80VuTGrgJeWzm1LDLBYUhkoVFn+L3kCEQQo5kog
 9p6zoLwmWw7xw76O2dypm1cHqF3T9xBRg5zKdJFOQrSwiiz6emlTApXRUXk+DXTUC1h8
 7mioakRZT5ZMWvYr+nIHYaO3Y5scm0PEMuFvO0Q4/rpin6ddTwG9knAYAbGRNROM6BLa
 NVoC+Yla5Osn1nKoE1w4qqbQdycq9FEdsXyujPwTVU4FnN4H9q6KK2mEpeE5OdhPeEbJ
 kHaEdMh+4jhZKblTIfupFM+x2nWSqWlxfMFDsGtQWdOgqMSZRJsO+RRPJV+qQS+n8LXB
 +ncw==
X-Gm-Message-State: AOJu0YxInQbf6zBQR+3FZc1AZixXoyIKyIet1J3+UZqmNCL53mgBol0J
 b8Pm+QJEZvv91jF+dJECE4TwkiHAq0uoZbBofbK204v5MQ4FziAKrrf75wwj9svufw5k1A+3VoK
 vioitnNP1F89J0rjcHpibxDjMp9vlTxn229/WQ3Xew9FFsyw3SzZbkhH1L3B+HGldAL16ApTE6f
 PVTktQWzDN0IipdAEvKk5QbRNAtJ5fg/a9ahMbBn9y
X-Gm-Gg: AY/fxX4BtZ7S54vmZiJ2DxpfThtum3kRrKRDpBGkDKGSaExOolPeeHzNTMTHq338WVG
 cSstJb6sVGfhJsvkR2ngcVCVHhajiXCdqwnom4IsBjuF8j4q4G+XXegi0Uv0pr0l17C6BzO3uKy
 3rFcIgg/OD+E9EUYDVIKY1H15XXhPN3BxHhp11NSxW/rcbOsBrvH2MRd/mzQqBgmn8rPRgarT7U
 eYUVBYaZ0OG/9msJ/mf2bWldDJGuInCPGrKBYMWoxAxjIV8l/yjc3yP59p6WW/OWC3IH3l+8I1o
 sCcErsR6Sbjue2QXi0/K+b/90Vg7Yxd2cHOuDRpPKRCPGUo1MUTpdM85rzzdYoNYq4oLuoB1p13
 lInHJhDOVvvhKW8vAbkJ8J9zeTvMODTg3SKq9ACqTTjrPtd2qyjFkFxlvug0Hv1jwtkgJPgW0NR
 wtWwZZOlmeYUxqYg==
X-Received: by 2002:a05:600c:8484:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-47d84b1a095mr9112355e9.14.1767761557276; 
 Tue, 06 Jan 2026 20:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA0YCZevNqMudE++7YosyBxCLX27FBuA1uI5YmIgQFml6gvnYIK+jJmp6jGVDtpSWHSGLQXg==
X-Received: by 2002:a05:600c:8484:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-47d84b1a095mr9112185e9.14.1767761556691; 
 Tue, 06 Jan 2026 20:52:36 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8660be14sm4098035e9.1.2026.01.06.20.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 20:52:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH] target/i386/tcg: do not leave non-arithmetic flags in CC_SRC
 after PUSHF
Date: Wed,  7 Jan 2026 05:52:35 +0100
Message-ID: <20260107045235.94348-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The value that is pushed by PUSHF is the full EFLAGS, while CC_OP_EFLAGS
only wants arithmetic flags in CC_SRC.  To avoid this, follow what other
helpers to and set CC_SRC/CC_OP directly in helper_read_eflags.  This
is basically free and fixes an issue booting Windows 3.11.

Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: e661e2d7a37 ("target/i386/tcg: update cc_op after PUSHF", 2025-12-27)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper.c | 4 +++-
 target/i386/tcg/emit.c.inc  | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 91e492196af..6ddd64fcb07 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -414,7 +414,9 @@ target_ulong helper_read_eflags(CPUX86State *env)
 {
     uint32_t eflags;
 
-    eflags = cpu_cc_compute_all(env);
+    CC_SRC = eflags = cpu_cc_compute_all(env);
+    CC_OP = CC_OP_EFLAGS;
+
     eflags |= (env->df & DF_MASK);
     eflags |= env->eflags & ~(VM_MASK | RF_MASK);
     return eflags;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fde3d669d9..e55b65176fc 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3253,8 +3253,7 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_helper_read_eflags(s->T0, tcg_env);
     gen_push_v(s, s->T0);
-    decode->cc_src = s->T0;
-    decode->cc_op = CC_OP_EFLAGS;
+    assume_cc_op(s, CC_OP_EFLAGS);
 }
 
 static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-- 
2.52.0


