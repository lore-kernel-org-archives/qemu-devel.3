Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA0DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcp-0003nN-QR; Mon, 06 May 2024 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcd-000393-70
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcZ-00026i-HL
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34b64b7728cso1575803f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999145; x=1715603945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDCtZ5R6jWRdBusTW5eWLGmV5MNQ1/vJ4icErDbd6hU=;
 b=uwlnMA9Ecrm258wYw/yWuYGmP61sfj4BDkRMtW5uK5BnrqkxIcInzOlgNhxXZyAMyl
 cAvEplUrYA9hq778fqQADQkfj1bfmZ9hu5OStYKoGgUI05m5w69Ww6knZ9glJf6qvwAx
 GeD5Yl0mvlORRIEiUl23/GfjikBUtdNxHn7MYPG9//Lof/c2NoMQNkGxNMzDB7KI6KGi
 lrVbKGEz+fXejh07idWWrGZD9zskDCKm9wsQ3ZLLSYqnursLfv9zznsleXo7hzJBdBkj
 5sPQXFkZ4A+ty70XFqH594ak9q3pqBHkVLozjXFpAGIRreHu4PKxVMb6THCA5VbfMldA
 6QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999145; x=1715603945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDCtZ5R6jWRdBusTW5eWLGmV5MNQ1/vJ4icErDbd6hU=;
 b=royKOlTKmyYtDPZpsLtzsrSJSIsK66aHbotMHwSZ3bXThsTmH1aKhliSUMjIj1dr9p
 XDK34wqVPyuWaDczrCyOtE7h6gbAXl0jLqLtoPgLITcfphddGHGy2F2P6KMJOTR7bTSU
 Fdh44/NXnYAgWOrmWpPqoH+z7GejUmICY5mg2G9WyVsbr1n0axWVmr/TP3rlP5z1x1iq
 dMCDq7LOC9HPVT4gd1AuhtBvleSVJ0SjQGrSQSzAGlIaZwY/GrOU53PlpdTfCy5uMjhu
 nqksC/pqq49tGJfLnd3/Q9oS22js79VFmMU4o/E1bue9adVVxEQOiDzC57K+NpLY4zRd
 YcOg==
X-Gm-Message-State: AOJu0YxxJko0rtWy5CHRtMMerTJMR8hiIvCY+xKOn27cxqtz2JsPJzqD
 SlNRh2BrMmIV1WTmz4z5vno853u0A0Ek6BgcVEG4/2Tv5+ylDxZHc6j1eQGnTz1WmUYUsj8hnyF
 3
X-Google-Smtp-Source: AGHT+IFf1HCZemRyst4urnJsbcV/fmfR3PwPqXOIv1B/AzeLX60LPneOwv5OGkqAuQmMhKAX4IUHfg==
X-Received: by 2002:a05:6000:11c9:b0:34d:a0b5:3c57 with SMTP id
 i9-20020a05600011c900b0034da0b53c57mr6060906wrx.23.1714999145528; 
 Mon, 06 May 2024 05:39:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 h11-20020adfe98b000000b00343d1d09550sm10622257wrm.60.2024.05.06.05.39.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/28] user: Forward declare TaskState type definition
Date: Mon,  6 May 2024 14:37:13 +0200
Message-ID: <20240506123728.65278-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Forward declare TaskState in "qemu/typedefs.h" so we can
use it in generic headers like "hw/cpu/core.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-9-philmd@linaro.org>
---
 bsd-user/qemu.h         | 4 ++--
 include/qemu/typedefs.h | 1 +
 linux-user/qemu.h       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 322177de16..1780f485d6 100644
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
index 263f445ff1..7df4645c2b 100644
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


