Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61698C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38Q-0004WS-IT; Sat, 08 Mar 2025 17:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38N-0004TZ-78
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:07 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38L-0005K2-Dr
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:06 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223fb0f619dso59273975ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474744; x=1742079544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flAxIFy+Ab6eUm0+9WbxQUDS52odshsIOHS0bGzzjls=;
 b=P56rkARZZdEBEDwzRA2WuJc4phTPiBnx8nNL8R3xom6duamJJNIw/lA4UNRmqC0hWX
 NxT/zwYyVbhFByeHLbAYjqQnxQXviRLEjQSF7UDgfK8Ow3WB2xPBvb7WZ3b6Sk+UxEcC
 sYwfgnSC7uRu6/GzJrVZgSa22lfPjw3ReIJqES6nyYnNhdhJFZo+NIBgLk9TVPsKiL68
 Jdl5UfAf9Kt4Hfp+v/0DuEYVfGm7b5rw1ThIbf6yKfVG0ztJKlfVCKKKIHURa0+wAtJb
 K8VgGIyw3fq1PFINXHr+YKHk3CZ1hamzM//ukdVmV36E5wXlJ8NQOU9OtruBrbKqnPNC
 cdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474744; x=1742079544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flAxIFy+Ab6eUm0+9WbxQUDS52odshsIOHS0bGzzjls=;
 b=fwEIud0yy4p/jGf7WnYUdL/379rRBoKg2WOy3zCAZM3hMjpQUAIsQP+zEYiHYiVKL/
 tei7K2Z/X6561/xJzpC45qNQ1eEBXEu27u3qMrr3iA8iRIRRopo84xe4XT2AJe+9+ZFt
 C533qBFenIOdGOzamwja0hL85ozx98J6ZlozMuAZhIT+1/dF4uMgX4mnWZvD8fSDoAMI
 gt1CgOJ4ynkHHuFvjTOCiJcn2ggMx64aXjU3uLBtv9GCcY3VUa3yD7vXYhqtjxHo9cyH
 DR9Y9a17/l5V0PqHSgFobZHmyKa9g2gMk6ruuTJjHauOSv1twZ5n2BcZtu1BQcDPb25o
 4Pog==
X-Gm-Message-State: AOJu0YzpVBnFTaDUoJirVFADhBoO/T5IdiC34ULonPQ+m9Gl2mlY0HlT
 IblZieXy75NmnegSuAlYJ4xzuw9HQknDXX/q73tc/1k8Ios8B39YPDbKCn1rOCIIOpOUAQ2TWgX
 g
X-Gm-Gg: ASbGncvyeDBNSGLFaTUfAFUmLYf/ofa0Co1IxHe+lJsoyqgCimR9fZujGP+5C3mH7xE
 Joj2ogPWu4SXt/N7ZxsiChUyLkBEeFxuf1EVHxO1k0YL6bRI7DnrMpLRGr+7ms7Jq4Z1pOq7hc6
 urnD/KKm5MO7c21BhT0p7vsEZAQhBGOFaVXjkHFvcFBecdtH1PlH50WisiIpUbbXnmREA3HyZtB
 yTP6gToJ0vc4lHYEWmq1SaSWDelzMVhknKdW07hok2ift5T0bIJe8ucJTkcGNreyTDs9EQdRzX5
 1bqkwkTCER8rXSjFe32mmQnrTOPOJjzfUy5xFJ3BLldo8Cg15PXLjBHEh20lFbLf8k+ipoo5Tn+
 O
X-Google-Smtp-Source: AGHT+IEEatxEcUKp1sk+eEQQ67IOIf6RotYkw8LxaYavtdWhEsYb8Hk8bJITF11MBSJaRuPn3e0akQ==
X-Received: by 2002:a17:903:40cb:b0:224:24d3:60f4 with SMTP id
 d9443c01a7336-224288940admr133018685ad.15.1741474743967; 
 Sat, 08 Mar 2025 14:59:03 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/23] linux-user/main: Allow setting tb-size
Date: Sat,  8 Mar 2025 14:58:39 -0800
Message-ID: <20250308225902.1208237-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

While qemu-system can set tb-size using -accel tcg,tb-size=n, there
is no similar knob for qemu-user. Add one in a way similar to how
one-insn-per-tb is already handled.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240730215532.1442-1-iii@linux.ibm.com>
---
 linux-user/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 5c74c52cc5..e2ec5970be 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -72,6 +72,7 @@ char *exec_path;
 char real_exec_path[PATH_MAX];
 
 static bool opt_one_insn_per_tb;
+static unsigned long opt_tb_size;
 static const char *argv0;
 static const char *gdbstub;
 static envlist_t *envlist;
@@ -425,6 +426,13 @@ static void handle_arg_one_insn_per_tb(const char *arg)
     opt_one_insn_per_tb = true;
 }
 
+static void handle_arg_tb_size(const char *arg)
+{
+    if (qemu_strtoul(arg, NULL, 0, &opt_tb_size)) {
+        usage(EXIT_FAILURE);
+    }
+}
+
 static void handle_arg_strace(const char *arg)
 {
     enable_strace = true;
@@ -517,6 +525,8 @@ static const struct qemu_argument arg_table[] = {
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
+    {"tb-size",    "QEMU_TB_SIZE",     true,  handle_arg_tb_size,
+     "size",       "TCG translation block cache size"},
     {"strace",     "QEMU_STRACE",      false, handle_arg_strace,
      "",           "log system calls"},
     {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_seed,
@@ -808,6 +818,8 @@ int main(int argc, char **argv, char **envp)
         accel_init_interfaces(ac);
         object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
                                  opt_one_insn_per_tb, &error_abort);
+        object_property_set_int(OBJECT(accel), "tb-size",
+                                opt_tb_size, &error_abort);
         ac->init_machine(NULL);
     }
 
-- 
2.43.0


