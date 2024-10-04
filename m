Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF3CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlFl-0001hr-Up; Fri, 04 Oct 2024 12:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlFX-0000Q2-3f
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:33:51 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlFU-0005yj-Ph
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:33:50 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5399041167cso4063653e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059627; x=1728664427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLzg4uMG2cx+IKbaUwzfii1q1L/0Wc5xbNn8QzHBma0=;
 b=ZGrzTCf0aCI/SK37IHwhcqfSdUL0BqiYgZlmmGh9E5PRuKKQtMsCFhpfEPhnJKOZpM
 vqxW/IMXXxRX+SJjfAvBdyT1ahHT+jgYymKp1oh8BtS7SfuUy0XMCWjGBULu+CG1Hhge
 PDEwk6NO8dZnWz7xQIc2KsgOXAxCfDPvWL9fIVvEoFp7DuXZ9ki0FhNvTppASATzKJCq
 cx0PWWffM29TZ10u9jJ+ZOWgMR1VD/ezvd86tZHdPwUZ5PSWQvtNICCQgLW4EM+U2Ys7
 gu45omNUfAzy0hvL/4Lgw3qyMf4MfMhq0sNqcYrW2EV8c6cZGEDHwf5iRcBgP2Lh+K3N
 8HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059627; x=1728664427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLzg4uMG2cx+IKbaUwzfii1q1L/0Wc5xbNn8QzHBma0=;
 b=hzyT9Dox2rNDs/86IFgbuKDb16Jlq8UrqDK0aVT+7r44dQ0bjCLRG5pDdaXnjROOZT
 kL/H25iZd4vk4zHodQhII8uQWKomO/j3ibYlRr1kDnFLw1lF+stzSfY3VNE63nm2qAHv
 yNr1AxQAc9lDocxle7fZ6ivZ+bNOUQsojkyl2s67WDo4Ew/wx0otzdIVYEy1JvJPqTpz
 PREp++uHnP2bYg5bRC1CarbbcpJacLw7Wgf3cBrdsljSWkTNpunt6Bc37kSN/yu+nIr+
 +xXhEnX16rcuy8rpc/HYVqSR6ncb7CbdbOiZj3Pv2bg/Oxh6LBzwPWRiTEYnVhavJptG
 Pchw==
X-Gm-Message-State: AOJu0Yw2QCSJoiBAXZka+7BJzsvlICd9CTUtk9r3JnQcJ1MsMIHC/VIA
 yifvJQhvSeI8FkHozMibtXu04X6hVIMQtka1BlbsXhV64MVGJa0f8HaKu0evSNp48yl4lwW3fd8
 1qBj5lQ==
X-Google-Smtp-Source: AGHT+IEuSAOZSCN26tBePII+5E9mmDeltRZqJrGv08/GBrPxmSMNYn/k2BT5kWYju5saHekA9/bXHQ==
X-Received: by 2002:a05:6512:3b98:b0:539:9ee4:baab with SMTP id
 2adb3069b0e04-539ab87dcbfmr3297739e87.30.1728059626757; 
 Fri, 04 Oct 2024 09:33:46 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539afec8430sm2064e87.98.2024.10.04.09.33.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:33:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/25] target/loongarch: Use explicit little-endian LD/ST
 API
Date: Fri,  4 Oct 2024 13:30:28 -0300
Message-ID: <20241004163042.85922-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The LoongArch architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/loongarch/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/gdbstub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 3a03cf9cba9..dafa4feb75d 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -67,10 +67,10 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     int length = 0;
 
     if (is_la64(env)) {
-        tmp = ldq_p(mem_buf);
+        tmp = ldq_le_p(mem_buf);
         read_length = 8;
     } else {
-        tmp = ldl_p(mem_buf);
+        tmp = ldl_le_p(mem_buf);
         read_length = 4;
     }
 
@@ -106,13 +106,13 @@ static int loongarch_gdb_set_fpu(CPUState *cs, uint8_t *mem_buf, int n)
     int length = 0;
 
     if (0 <= n && n < 32) {
-        env->fpr[n].vreg.D(0) = ldq_p(mem_buf);
+        env->fpr[n].vreg.D(0) = ldq_le_p(mem_buf);
         length = 8;
     } else if (32 <= n && n < 40) {
         env->cf[n - 32] = ldub_p(mem_buf);
         length = 1;
     } else if (n == 40) {
-        env->fcsr0 = ldl_p(mem_buf);
+        env->fcsr0 = ldl_le_p(mem_buf);
         length = 4;
     }
     return length;
-- 
2.45.2


