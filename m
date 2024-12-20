Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2EAE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjH-0005Je-58; Fri, 20 Dec 2024 11:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfix-00053M-2o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:37 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiv-0008IF-JT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1234168f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711572; x=1735316372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q99/bsif6wpzwYmznsUtKMEpC3SzjXOMyKElTz2bhrs=;
 b=pSCi1Ukvyg5/Aqp97TpmTF5CuQ8CbvmSBKPaT0K6zDqph75v8e5AghhF8k50XaIdRi
 J8X7+VYrYwqdGde5vT8wJTPiXnn5TV1U4DC1Eh5n3EUBitGNCOjeMUimxwPe/Mg0Yg9j
 u1/h7W+uo2mF0ODqMj+tgFfnX37HfpOvIOAHjuWfgknRVU9VFztaVcALY1y/hepMkaLc
 7sTUwJkiEeGyJM8CkXFJT1LWDnve9GSch5l59F94Q3WhGi7J+xdxyfW5HGI19b6A+DGx
 kc7LEOCaZ11AcXED2P9bjbB4O8rh4sxtNDQnQGjI5twOk6YD2f8idBsa9q0X5gbgGvX4
 7G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711572; x=1735316372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q99/bsif6wpzwYmznsUtKMEpC3SzjXOMyKElTz2bhrs=;
 b=AeT1W35mRQnyq0vN4HAXvZk0eq29GVJ3jhZ73XXz6Cpl7Kyp9FO1HvLISrhB9wRbY9
 jBwYMppFqWVN6dUpkDqXK+8fmtQWzXfgPGnZNMXfCsPGpc33Tt8QIZFW+SfMIzPjtC65
 X3B9SC7xbnkuiHcbwG2VT5bbqkiYXJyzuNtjZ7UtsSV4Vvaczz8o6H3PKvilGSLMgpaX
 OKMy5MFRNHx0UIGhuKbPcmbZLLpY7Pq5US1SafGyFTOhhGdAxSkZxT1bq6owUMhjLlps
 t0Tr4vSQH+ehjXffAw2updr7bSDSrQq9l+i45AhEJhVDyA6J/y5xMQEjyoDuRdiXpEFO
 iM/w==
X-Gm-Message-State: AOJu0YzDv1EEpcwY8Xy94TkaJVQOtqX6GSQQTLvocFaWBVpoqskG8dfp
 XTdmvT+yeCru3A7yctESLUj06HO8lTJRtwTr157RyBpvdRHImx03sARy/6iaBg4esNRxE1oJeEO
 2
X-Gm-Gg: ASbGncsN+ZM1C+KWUtlnmnuqJ9muFWqVvqFQs7Wg0ayUlkarBdkaqf/PcwlPYGt3Fdw
 WNYoD0tpuBXzFQV21EnttlcgSJZyZ33srBDJKbPC5gdaZBEuzZIh36E4HVqQ3iptoPTNyu0Ym6P
 phLH+hfZqR5XYq9MI3RDDwZqutIZJIlBRZwxCiJfor1JVO6HDV7+evzCSBKDtmHZW4qM4jBsv4l
 Y/gA01aGVDbrgWPGHub0pbtiVh/pLAeEitSiA48ryAktj1x0VgjI3Ds/mQeESb7pmi4rQlXX7I=
X-Google-Smtp-Source: AGHT+IFFwhdIaAH/DQZMGTnZ02SK+K67gNXy2JVKRBcsXg375tAFuExCc+RX0XTdK9nNPfi+lTkyTQ==
X-Received: by 2002:a05:6000:4012:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38a221fa22cmr3767527f8f.21.1734711571860; 
 Fri, 20 Dec 2024 08:19:31 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6d02sm85487275e9.1.2024.12.20.08.19.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 48/59] accel/tcg: Restrict curr_cflags() declaration to
 'internal-common.h'
Date: Fri, 20 Dec 2024 17:15:39 +0100
Message-ID: <20241220161551.89317-49-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

curr_cflags() is only used within accel/tcg/,
move its declaration to accel/tcg/internal-common.h.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241216214030.59393-1-philmd@linaro.org>
---
 accel/tcg/internal-common.h | 3 +++
 include/exec/cpu-common.h   | 3 ---
 accel/tcg/watchpoint.c      | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index a8fc3db7742..c8d714256cb 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -56,4 +56,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
+/* current cflags for hashing/comparison */
+uint32_t curr_cflags(CPUState *cpu);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 0cf9a3d369c..74e947f3adc 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -191,9 +191,6 @@ void list_cpus(void);
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
 void tcg_cflags_set(CPUState *cpu, uint32_t flags);
 
-/* current cflags for hashing/comparison */
-uint32_t curr_cflags(CPUState *cpu);
-
 /**
  * cpu_unwind_state_data:
  * @cpu: the cpu context
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index e24baead562..fbaf45d10f2 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -27,6 +27,7 @@
 #include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "hw/core/cpu.h"
+#include "internal-common.h"
 
 /*
  * Return true if this watchpoint address matches the specified
-- 
2.47.1


