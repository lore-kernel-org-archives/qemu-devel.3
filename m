Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722B8C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CoC-0006XM-Tc; Sun, 28 Apr 2024 18:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoB-0006ND-6d
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:43 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Co6-0005dI-Bp
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:42 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-571bddddbc2so4569653a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342536; x=1714947336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aM0sC9LJo3MsBrKnxAqhq0R7PzMkuVnjASQsrgigLYU=;
 b=oGvccj9mJPJpAulNIuJ7a/8dKMkX+oiCbVypgMMTzEyI0kjK1mYSCfPHvbWXfG2D22
 yvYtiOipzfUD3HKRL9mCXqVY9qGoaIHsP+HEtCYq39oEvQ9h8x7L2Nq3SsL9286LdrnA
 062Z23vqm9K572nj5NBTxX5Om+yHXsYDaODUOnm/u475XbtnSh3oTbiF1Bj731jZ22Ra
 LaKXnFhpDjx0QMlkHwgcrf7TR6wmpA4w/KaLTjMMpBRdXnYrqELTqo07NuK7bCwwGWRI
 3/24LOdt0H1bUH8qVl560UxFYQCir+B4P6qC+gu2ubrRQXG/3Bv0lXRC4Zr+pCL0z2K1
 fgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342536; x=1714947336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aM0sC9LJo3MsBrKnxAqhq0R7PzMkuVnjASQsrgigLYU=;
 b=E5t31NO1puLC3L6Dti1exvdo9vBwESOrFarjgbhijQj1KCCsiSUfkfp43sQBbjCo2I
 cEyYCgLt/h5AoMA3wgFlTLIVbYDLCdlt7oCcCDUAYempLaURJ5/ii99FSwE/gol+wxFe
 fHNpuCTYzXPzXFofxLsH2EQGulPPndVkh2oGnhj2nFgqtuJlH9XoflRYMn+B58V5y8Um
 n3HtfSZ+qhSgHlqeNVTumDvW0BCJCnKvdZCHs+VMwe65VqjL6nuxokGi8eHWXKVKTX5L
 9Z6p+4vOy0k6/kaCvnf+F+1s4MuCwf0InTr7+QjVP6/6AZujJAY9tIM7B03GESO6+x6F
 WjuQ==
X-Gm-Message-State: AOJu0Yy1n+RGAbfumtukBRrdu2MEyqaNzAheRwa2sSZ1zsir9wUXQslF
 hpZu3b9EuRpVr3zQsR4y/7ylHdTzjJxRXlVBKvkYMtY9fgIQWuYIrSI68eRKOUlo6srDk5GPxMR
 P
X-Google-Smtp-Source: AGHT+IEnjdZA8A7fFFpZXneTpR7wX71kxX8KbPiYhWSBtdRDwAuvTMxFnV9CzCb3pj0COT0A6uTqCg==
X-Received: by 2002:a17:906:3811:b0:a55:99f4:549f with SMTP id
 v17-20020a170906381100b00a5599f4549fmr6071347ejc.48.1714342536203; 
 Sun, 28 Apr 2024 15:15:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 kx18-20020a170907775200b00a57e2d39d56sm7731187ejc.223.2024.04.28.15.15.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/24] user: Forward declare TaskState type definition
Date: Mon, 29 Apr 2024 00:14:34 +0200
Message-ID: <20240428221450.26460-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Forward declare TaskState in "qemu/typedefs.h" so we can
use it in generic headers like "hw/cpu/core.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/qemu.h         | 4 ++--
 include/qemu/typedefs.h | 1 +
 linux-user/qemu.h       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index e562adde65..be57374b41 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -76,7 +76,7 @@ struct emulated_sigtable {
 /*
  * NOTE: we force a big alignment so that the stack stored after is aligned too
  */
-typedef struct TaskState {
+struct TaskState {
     pid_t ts_tid;     /* tid (or pid) of this task */
 
     struct TaskState *next;
@@ -114,7 +114,7 @@ typedef struct TaskState {
 
     /* This thread's sigaltstack, if it has one */
     struct target_sigaltstack sigaltstack_used;
-} __attribute__((aligned(16))) TaskState;
+} __attribute__((aligned(16)));
 
 static inline TaskState *get_task_state(CPUState *cs)
 {
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 50c277cf0b..36f2825725 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -134,6 +134,7 @@ typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct TCGCPUOps TCGCPUOps;
 typedef struct TCGHelperInfo TCGHelperInfo;
+typedef struct TaskState TaskState;
 typedef struct TranslationBlock TranslationBlock;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4777856b52..16d9f6ae8c 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -95,7 +95,7 @@ struct emulated_sigtable {
     target_siginfo_t info;
 };
 
-typedef struct TaskState {
+struct TaskState {
     pid_t ts_tid;     /* tid (or pid) of this task */
 #ifdef TARGET_ARM
 # ifdef TARGET_ABI32
@@ -158,7 +158,7 @@ typedef struct TaskState {
 
     /* Start time of task after system boot in clock ticks */
     uint64_t start_boottime;
-} TaskState;
+};
 
 static inline TaskState *get_task_state(CPUState *cs)
 {
-- 
2.41.0


