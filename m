Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFA7D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8c-0002FB-1n; Fri, 15 Nov 2024 10:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8Y-0002E5-R0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8X-00047N-9q
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so17230905e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684083; x=1732288883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4OKJRqPnTe7YcrvpW1zRARrSn3+9ueaSfuhvBrykFc=;
 b=Q+ImcEyYKSQEeyJW7bHwgOl5q//FN01StOW1m7rk2yzNYgk4n0p5XZ/BEw/za9QwOH
 HW/iS1YjUNNr1ehRqyGSwnK3+Cn6NQM4EC9NXVYjyvzTxVXI9vEEgmv6QgGIRLIx6DF+
 wY3mfXa1/Li7ztsV3KGNhOgmckCkba3hxTn6hEdrgQ2iCjCb1m1RGywrUAa2EAhA+uJr
 glDHvdfuZQ3kC19RF+TCJNE9x6kfBXCREtq353/GKIomJO6bzg2Y6qu9qYVwZPRls/RD
 jDTZR9GCkcHEqo18LsqbX0jF+liDw/HAJCdTcpC7WZO+OcaqsNzb+/7TINr6PXU7un8h
 S+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684083; x=1732288883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4OKJRqPnTe7YcrvpW1zRARrSn3+9ueaSfuhvBrykFc=;
 b=SFZ5fau38EnYPnrHsOP416QkSZg426EJm48An9zMxSUwsHVXc2pg6FuoMQvoVcMG8p
 L+l/VVseF43S+ee4I1c057DogXZKt7xrhdpcEysuHSq0Ct2j9L7StC45he4siGBbg3uw
 YQpZTRq4uPSNLZXIo58GBzElZEjq5TS2oHWSYkyDZPFw8099x3ieBTCOf2OUoO8GppaS
 O/L/U6obhmi/vKE1r2teRCtnmk9PjwLKKEV3g+vViXm9ohauATgJDBSdluvkeCCRwnlB
 zJUOtDaZAyjIz45h7f3WR47dURDxDG6SLZYUVj/XgmvFFLgothgGkdaQeoBn9vFB5i1r
 ibXQ==
X-Gm-Message-State: AOJu0YyZu9HHUDyLV2GpinIolU7DjvInZ2351lYAxektW80soAkrZ1qO
 2CxfCkh6fNkPnozb8KbmFN3/X3weE391ruANuMx/vQCVfWwO4ZM3mcQ0obVHMaQM5gJV64lweVY
 a
X-Google-Smtp-Source: AGHT+IFLmrRv17ZtP4qeMoM5Wo/o9YHjBBpOCOeUtURfLycwsVqGyY+eb8PJNx5XJXZ93tYmySadTw==
X-Received: by 2002:a05:600c:3c9a:b0:431:5465:807b with SMTP id
 5b1f17b1804b1-432df793de8mr22303915e9.32.1731684081208; 
 Fri, 15 Nov 2024 07:21:21 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80582sm57070575e9.19.2024.11.15.07.21.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/10] accel/tcg: Move cpu_unwind_state_data() declaration
Date: Fri, 15 Nov 2024 16:20:48 +0100
Message-ID: <20241115152053.66442-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

cpu_unwind_state_data() is specific to TCG accelerator,
move it to "exec/translate-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h    | 13 -------------
 include/exec/translate-all.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5..b36fbf2a39 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -193,19 +193,6 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags);
 /* current cflags for hashing/comparison */
 uint32_t curr_cflags(CPUState *cpu);
 
-/**
- * cpu_unwind_state_data:
- * @cpu: the cpu context
- * @host_pc: the host pc within the translation
- * @data: output data
- *
- * Attempt to load the the unwind state for a host pc occurring in
- * translated code.  If @host_pc is not in translated code, the
- * function returns false; otherwise @data is loaded.
- * This is the same unwind info as given to restore_state_to_opc.
- */
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
-
 /**
  * cpu_restore_state:
  * @cpu: the cpu context
diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index 85c9460c7c..f06cfedd52 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -21,6 +21,18 @@
 
 #include "exec/exec-all.h"
 
+/**
+ * cpu_unwind_state_data:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ * @data: output data
+ *
+ * Attempt to load the the unwind state for a host pc occurring in
+ * translated code.  If @host_pc is not in translated code, the
+ * function returns false; otherwise @data is loaded.
+ * This is the same unwind info as given to restore_state_to_opc.
+ */
+bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
 
 /* translate-all.c */
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
-- 
2.45.2


