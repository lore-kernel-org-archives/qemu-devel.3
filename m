Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E4C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrR-0003Ns-94; Tue, 06 May 2025 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrP-0003M7-2r
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:23 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrM-0003pf-3J
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1046507666b.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536238; x=1747141038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndqF6zudXDapLEz8EejCHGTTdD17XbLc4AuhJOdW34o=;
 b=ovGS0wQUfYtXJnI/64IYIRcTspFX338MgnnTZD/67IQ75MShg7jQCYCPIIdYUdQFuL
 8JiBGDj4ne28//LZQcU3LNCPh5DYGy5ZGBdpfHU14Lk+jry96/9IzWTQRMCKVW7an1N1
 vB+y643rksVpb7h+fzw35x9HKweXK6Sdk2IA543EIcULC2ggx6zvboJIHD4clS+WE2yA
 su5zTjM7E9g7T7RKsCL2sz3QBDaXJwyEKhrL5HvgoKIPdiza1Hr0XBXyKJnCY/hVMFF3
 2CHzGgDNMLs0HBSufxANx84zc9/sPIxo8m9kkDvce+QgUl2Mh4NwgisorIC5t0rFmouj
 IjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536238; x=1747141038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndqF6zudXDapLEz8EejCHGTTdD17XbLc4AuhJOdW34o=;
 b=D7q1sB6rLPsq0ZmnZ7F6Xks7i7zOvlsvpdRhPgp1ZtDpK0Qp/lrAnWr/Wrpn2Vb3+m
 5A/L/QpwcM6YUZUa7BlxcVY358shRrWX6C1VtSqd0hVrl8GlaH/fEcFwKABjjeDSZNbP
 0Ej9D9W1UNUZMOz/CbWbvp5CL7XV4KYnNPgbGWJAxF46Fo1tjnhKTVYbm/wHC69cgS97
 TEeMKXDTq/QkxoX09g6fJViv9zjGlrJJm6+FbVLUY+HOYxBdXVhvXnGRoAkjB8qglBve
 TdPuNNsEZx4vRM6e/5QIx0a92J8gg+6g4YJzE7nrVLk3G8sHsOeKZUDzoV1OifcE/bwi
 THaQ==
X-Gm-Message-State: AOJu0YwHYEKh309b4TnOrkG+Py//NvOys6zmhONkTvVM7fiosgRJfXeH
 XJ0/SnK9gOamAI4UoWbqhsBqEi2G4pna+eUyKe0dXzsZ6bnnRIYyykLza8DoRmI=
X-Gm-Gg: ASbGnctVJ6xaJTk+S0Tpxj6Ai5IF5F5dfv9e0BVexTOZy7pODldIRvpQ81fDocJHZr/
 GJ64pa4pUuT3k5dOHUht9q/AzFQNSqad8G82A26UMcSYws8BIzK1YXQPQAqE5XLRemU1FlphnmJ
 rjK6nPnB48tf7DVopZPchmz0Lw64G0c/UFrljVSEBZxT4CHfi4m2Zq/xDK6GVM6qU0YSDrbSFCP
 MQDNV/NN+pQkgwOB4A8t4iKF9j2NHwrXJDdBf+ycghsRno8aqxxUHwzY2NCCH2bH8cFxdneoZPc
 BbS3wp8hBj8+bYwJARTMuKo3vjDz9/jjmhaWBK3FDYQ=
X-Google-Smtp-Source: AGHT+IH4BIUs6nNk7NpOZZHUs8Y7UpBIUoAXAcKqao+zVTUY/HUCtzXwdjUXWyUiF2NvOao9uo0G1A==
X-Received: by 2002:a17:907:160b:b0:aca:96a5:9861 with SMTP id
 a640c23a62f3a-ad1d4532a7emr296011766b.20.1746536238341; 
 Tue, 06 May 2025 05:57:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1e26fa7e2sm43978666b.97.2025.05.06.05.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 60F095FA34;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v2 03/14] tests/tcg: make aarch64 boot.S handle different
 starting modes
Date: Tue,  6 May 2025 13:57:04 +0100
Message-Id: <20250506125715.232872-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently the boot.S code assumes everything starts at EL1. This will
break things like the memory test which will barf on unaligned memory
access when run at a higher level.

Adapt the boot code to do some basic verification of the starting mode
and the minimal configuration to move to the lower exception levels.
With this we can run the memory test with:

  -M virt,secure=on
  -M virt,secure=on,virtualization=on
  -M virt,virtualisation=on

If a test needs to be at a particular EL it can use the semihosting
command line to indicate the level we should execute in.

Cc: Julian Armistead <julian.armistead@linaro.org>
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - allow tests to control the final EL we end up at
  - use tabs consistently
  - validate command line arg is between 1 and 3
---
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 135 +++++++++++++++++++++-
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 9c52475b7a..f7a7d2b800 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -68,7 +68,8 @@ run-plugin-semiconsole-with-%: semiconsole
 
 # vtimer test needs EL2
 QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
+QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
+run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
 
 # Simple Record/Replay Test
 .PHONY: memory-record
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index a5df9c173d..a52d28c881 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -16,6 +16,7 @@
 #define semihosting_call hlt 0xf000
 #define SYS_WRITEC	0x03	/* character to debug channel */
 #define SYS_WRITE0	0x04	/* string to debug channel */
+#define SYS_GET_CMDLINE 0x15	/* get command line */
 #define SYS_EXIT	0x18
 
 	.align	12
@@ -81,10 +82,137 @@ lower_a32_serror:
 .error:
 	.string "Terminated by exception.\n"
 
+	.align 8
+.get_cmd:
+	.quad	cmdline
+	.quad	128
+
 	.text
 	.align 4
 	.global __start
 __start:
+	/*
+	 * The test can set the semihosting command line to the target
+	 * EL needed for the test. Keep that in w11.
+	 */
+	mov	x0, SYS_GET_CMDLINE
+	adr	x1, .get_cmd
+	semihosting_call
+	adrp	x10, cmdline
+	add	x10, x10, :lo12:cmdline
+	ldrb	w11, [x10]
+	cbz	w11, 2f
+
+	/* sanity check, clamp to 1 if invalid */
+	cmp w11, #'0'
+	b.lt 1f
+	cmp w11, #'4'
+	b.ge 1f
+	sub	w11, w11, #'0'
+	b 2f
+1:	mov w11, #1
+
+2:
+	/* Determine current Exception Level */
+	mrs	x0, CurrentEL
+	lsr	x0, x0, #2	  /* CurrentEL[3:2] contains the current EL */
+
+	/* Branch based on current EL */
+	cmp	x0, #3
+	b.eq	setup_el3
+	cmp	x0, #2
+	b.eq	setup_el2
+	cmp	x0, #1
+	b.eq	at_testel	     /* Already at EL1, skip transition */
+	/* Should not be at EL0 - error out */
+	b	curr_sp0_sync
+
+setup_el3:
+	/* Ensure we trap if we get anything wrong */
+	adr	x0, vector_table
+	msr	vbar_el3, x0
+
+	/* Does the test want to be at EL3? */
+	cmp	w11, #3
+	beq	at_testel
+
+	/* Configure EL3 to for lower states (EL2 or EL1) */
+	mrs	x0, scr_el3
+	orr	x0, x0, #(1 << 10)    /* RW = 1: EL2/EL1 execution state is AArch64 */
+	orr	x0, x0, #(1 << 0)     /* NS = 1: Non-secure state */
+	msr	scr_el3, x0
+
+	/*
+	 * We need to check if EL2 is actually enabled via ID_AA64PFR0_EL1,
+	 * otherwise we should just jump straight to EL1.
+	 */
+	mrs	x0, id_aa64pfr0_el1
+	ubfx	x0, x0, #8, #4	      /* Extract EL2 field (bits 11:8) */
+	cbz	x0, el2_not_present   /* If field is 0 no EL2 */
+
+
+	/* Prepare SPSR for exception return to EL2 */
+	mov	x0, #0x3c9	      /* DAIF bits and EL2h mode (9) */
+	msr	spsr_el3, x0
+
+	/* Set EL2 entry point */
+	adr	x0, setup_el2
+	msr	elr_el3, x0
+
+	/* Return to EL2 */
+	eret
+	nop
+
+el2_not_present:
+	/* Initialize SCTLR_EL1 with reset value */
+	msr	sctlr_el1, xzr
+
+	/* Set EL1 entry point */
+	adr	x0, at_testel
+	msr	elr_el3, x0
+
+	/* Prepare SPSR for exception return to EL1h with interrupts masked */
+	mov	x0, #0x3c5	      /* DAIF bits and EL1h mode (5) */
+	msr	spsr_el3, x0
+
+	isb			      /* Synchronization barrier */
+	eret			      /* Jump to EL1 */
+
+setup_el2:
+	/* Ensure we trap if we get anything wrong */
+	adr	x0, vector_table
+	msr	vbar_el2, x0
+
+	/* Does the test want to be at EL2? */
+	cmp	w11, #2
+	beq	at_testel
+
+	/* Configure EL2 to allow transition to EL1 */
+	mrs	x0, hcr_el2
+	orr	x0, x0, #(1 << 31)    /* RW = 1: EL1 execution state is AArch64 */
+	msr	hcr_el2, x0
+
+	/* Initialize SCTLR_EL1 with reset value */
+	msr	sctlr_el1, xzr
+
+	/* Set EL1 entry point */
+	adr	x0, at_testel
+	msr	elr_el2, x0
+
+	/* Prepare SPSR for exception return to EL1 */
+	mov	x0, #(0x5 << 0)	      /* EL1h (SPx), with interrupts disabled */
+	msr	spsr_el2, x0
+
+	/* Return to EL1 */
+	eret
+
+	nop
+
+	/*
+	 * At the target EL for the test, usually EL1. Note we still
+	 * set everything up as if we were at EL1.
+	 */
+at_testel:
 	/* Installs a table of exception vectors to catch and handle all
 	   exceptions by terminating the process with a diagnostic.  */
 	adr	x0, vector_table
@@ -100,7 +228,7 @@ __start:
 	 * maps RAM to the first Gb. The stage2 tables have two 2mb
 	 * translation block entries covering a series of adjacent
 	 * 4k pages.
-	*/
+	 */
 
 	/* Stage 1 entry: indexed by IA[38:30] */
 	adr	x1, .				/* phys address */
@@ -233,6 +361,11 @@ __sys_outc:
 	ret
 
 	.data
+
+	.align 8
+cmdline:
+	.space 128, 0
+
 	.align	12
 
 	/* Translation table
-- 
2.39.5


