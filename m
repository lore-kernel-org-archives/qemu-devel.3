Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BC1C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5w-0003qf-Fv; Fri, 20 Jun 2025 18:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYM-0007Ac-Ge
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYL-0005wk-1u
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cf214200so19986825e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440563; x=1751045363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+4qrFz5UxRhB1xHQLBDc6jFqnnvLg3MMAjDFDMxhmQ=;
 b=SPd2ykdjQFlc8XtGxYgdcXJBH3PQiWcgF74+E8CXujLuluEpUQgRgs5gJ+442y/wpY
 fTslZbIcomKlK42piylYRSk/qyZBc1PaDidcfcA1CcsV1gaLZIUOCfset58GOIJDSYwi
 Ln5wwdRCween4r50qjmxEOFF4UYvVz6sJ/jR7zZSideuGUHA422PhLoG/yFBb36ZE8Vf
 Nb87iS4pODoIJ88O8B02df8IiZWTACchhnIw32/RUs5P/Z5eyl8sksyn+NWPpjn673/j
 mfZiQQ0FymzCyQdCjBkuO+PlXg7vaQg1keJqBOTJ405AeOgREGOaE8WiyuscPSDKbg6k
 IStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440563; x=1751045363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+4qrFz5UxRhB1xHQLBDc6jFqnnvLg3MMAjDFDMxhmQ=;
 b=nHn0XE6Q+Gd7uPe/LlgzsamgOG5LQSUEooHXC3u6yIwG6Qkuf9762bD1M8NXWzGzaK
 ysu/CRp8Tel3p3OM7P5y1VjPF4towNt3gWOmfZZv0ApGiVzSDOckE/agfSQO3MOaayou
 JCavTFGEylzfm3tEfY/gXqq/+Y8sW7VKXwVLlBmuxAOrUHGhBGUvYk4qDl30WvyiuAyO
 ytxFScooIWnT3YbNkcZr6irBwG4t8jul+XMmvrJcTJ7q6hiKVAWTqP+YHT1CUrxBtoCi
 qlovkFguhJ22WgO+OhKeUDg+8w3bx/z9bRpvSsI/pWgf2P9j2nYmEblqPzvVUjrmKfzA
 tOPw==
X-Gm-Message-State: AOJu0YzvLKopcyALsQx1s6kLCQjNR/5SldkGT4+Nnh/lnTC6P4Lxugh+
 xmxcSzfVuDP1p/xAj/fONosanHwToOLVvcktQK0vkRpJHAWkxiz2OR85aS6DIdTAp6P7ahUFLSD
 vbn1Lt8pI5w==
X-Gm-Gg: ASbGncs95bPVoCaONL+nUGNaVSnnC0I2V5je7AWfLeKI6e8ZpGR270RhmBdQfcukQZA
 1kZs7NLf7NdWcrGGkB8acduRJdo5V8L/DEf3l4raWAjAk7BRPArpEpQ3os5M4rLJ4qPaZn6i4de
 pxhkYIlyiKFUV4fWf/VhdFmbAeAg0YF18fX2AzfLlRpXVPTT4B9YB8DajYpoT8xFVNGBvJMfK4i
 LmmtzdMdKE6ph1jZE72g737Fq4qwOwIk1RKWwGSsrY6r+XyB1BzWGWNA7rhk+BfFe60XjNQgZAt
 cXdJ+pHpeuAYsOAyzYwTk2m8PCJnSKD1DCuFAs0fK7RcfJxKD7dr3u/HuZceSfp2pIAdmSGNl+i
 tjX4L7ERMiCLQAcYSvzHTZP6LJrUVo11i3UuqLfFJx1DSRDyKNu5coqDy
X-Google-Smtp-Source: AGHT+IHnNcxF5ay5VyHfb0T5ZISST8a/AEDzveENWZ2oAPcdg80AVPjPiTsb63a82thYNTvhcxmsWw==
X-Received: by 2002:a05:6000:2289:b0:3a6:d2ae:830 with SMTP id
 ffacd0b85a97d-3a6d2ae0c25mr2974004f8f.56.1750440563285; 
 Fri, 20 Jun 2025 10:29:23 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1054bsm2583987f8f.9.2025.06.20.10.29.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:29:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 11/42] accel/split: Register MTTCG
Date: Fri, 20 Jun 2025 19:27:19 +0200
Message-ID: <20250620172751.94231-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

FIXME: Use sw-hooks?

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index efef0d60fde..2c7945b6331 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -14,9 +14,12 @@
 #include "system/cpus.h"
 #include "split-accel.h"
 
+#include "accel/tcg/tcg-accel-ops-mttcg.h"
+
 static void *split_cpu_thread_routine(void *arg)
 {
     AccelState *as = current_accel();
+    void *sw_force_rcu;
     CPUState *cpu = arg;
     AccelCPUState *acs;
     int r;
@@ -24,6 +27,7 @@ static void *split_cpu_thread_routine(void *arg)
     /* TODO: check accel allowed */
 
     rcu_register_thread();
+    sw_force_rcu = mttcg_vcpu_register(cpu);
 
     bql_lock();
     qemu_thread_get_self(cpu->thread);
@@ -84,6 +88,7 @@ static void *split_cpu_thread_routine(void *arg)
     cpu_thread_signal_destroyed(cpu);
     bql_unlock();
 
+    mttcg_vcpu_unregister(cpu, sw_force_rcu);
     rcu_unregister_thread();
 
     return NULL;
-- 
2.49.0


