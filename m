Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66867C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTO1-00086t-I1; Mon, 10 Feb 2025 07:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1thTO0-00082d-1X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:59:40 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1thTNx-0000tF-Mh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:59:39 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id C386A1F38F;
 Mon, 10 Feb 2025 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739192374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OXQf41b3drE+ADh8gkGuOno6mrIPtvhvTaEaMxT4f+M=;
 b=I7AgZiGAwqXdI16JLsjpfNRWggwCeEistR1DwwKUE8IhwQ9sFRws2UwtZO0x68LQj72n5u
 RlVgCZ/tUfAVbnyyJIZqxlZPGseWUSzfZT9WDrjqQxCXDzVIbk+XGyIeW5UbnwER75QsMI
 FRg9RH1fXX6xQoKrXTz3e+TADcmTydg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739192374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OXQf41b3drE+ADh8gkGuOno6mrIPtvhvTaEaMxT4f+M=;
 b=ZVyWpL1gRsx5vdMrod3ngooUEI93gHj4h4b4TS9tpYPrarCAtY/RflqJ3QsMXHzC1rT0tY
 odgy7peTsq6VceBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739192374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OXQf41b3drE+ADh8gkGuOno6mrIPtvhvTaEaMxT4f+M=;
 b=I7AgZiGAwqXdI16JLsjpfNRWggwCeEistR1DwwKUE8IhwQ9sFRws2UwtZO0x68LQj72n5u
 RlVgCZ/tUfAVbnyyJIZqxlZPGseWUSzfZT9WDrjqQxCXDzVIbk+XGyIeW5UbnwER75QsMI
 FRg9RH1fXX6xQoKrXTz3e+TADcmTydg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739192374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OXQf41b3drE+ADh8gkGuOno6mrIPtvhvTaEaMxT4f+M=;
 b=ZVyWpL1gRsx5vdMrod3ngooUEI93gHj4h4b4TS9tpYPrarCAtY/RflqJ3QsMXHzC1rT0tY
 odgy7peTsq6VceBQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id B3ABE4A051B; Mon, 10 Feb 2025 13:59:34 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Move TARGET_SA_RESTORER out of generic/signal.h
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de> 
Date: Mon, 10 Feb 2025 13:59:34 +0100
Message-ID: <mvmed060xc9.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SA_RESTORER and the associated sa_restorer field of struct sigaction are
an obsolete feature, not expected to be used by future architectures.
They are also absent on RISC-V, LoongArch, Hexagon and OpenRISC, but
defined due to their use of generic/signal.h.  This leads to corrupted
data and out-of-bounds accesses.

Move the definition of TARGET_SA_RESTORER out of generic/signal.h into the
target_signal.h files that need it.  Note that m68k has the sa_restorer
field, but does not use it and does not define SA_RESTORER.

Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/aarch64/target_signal.h    | 2 ++
 linux-user/arm/target_signal.h        | 2 ++
 linux-user/generic/signal.h           | 1 -
 linux-user/i386/target_signal.h       | 2 ++
 linux-user/m68k/target_signal.h       | 1 +
 linux-user/microblaze/target_signal.h | 2 ++
 linux-user/ppc/target_signal.h        | 2 ++
 linux-user/s390x/target_signal.h      | 2 ++
 linux-user/sh4/target_signal.h        | 2 ++
 linux-user/x86_64/target_signal.h     | 2 ++
 linux-user/xtensa/target_signal.h     | 2 ++
 11 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 40e399d990..6f66a50bfd 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
 
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index 0e6351d9f7..ff1810b1fe 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/generic/signal.h b/linux-user/generic/signal.h
index 6fd05b77bb..b34740258e 100644
--- a/linux-user/generic/signal.h
+++ b/linux-user/generic/signal.h
@@ -15,7 +15,6 @@
 #define TARGET_SA_RESTART       0x10000000
 #define TARGET_SA_NODEFER       0x40000000
 #define TARGET_SA_RESETHAND     0x80000000
-#define TARGET_SA_RESTORER      0x04000000
 
 #define TARGET_SIGHUP            1
 #define TARGET_SIGINT            2
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index 9315cba241..eee792ef63 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index 6e0f4b74e3..b05b9303b0 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -3,6 +3,7 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_ARCH_HAS_SA_RESTORER 1
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 7dc5c45f00..ffe4442213 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
 #endif /* MICROBLAZE_TARGET_SIGNAL_H */
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index 5be24e152b..53fae473f3 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #if !defined(TARGET_PPC64)
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index 41e0e34a55..738e0673f4 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index eee6a1a7cd..0bde417fd1 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/x86_64/target_signal.h b/linux-user/x86_64/target_signal.h
index 9d9717406f..0af100c661 100644
--- a/linux-user/x86_64/target_signal.h
+++ b/linux-user/x86_64/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 /* For x86_64, use of SA_RESTORER is mandatory. */
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
 
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
index e4b1bea5cb..8a198bf8ac 100644
--- a/linux-user/xtensa/target_signal.h
+++ b/linux-user/xtensa/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
 #endif
-- 
2.48.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

