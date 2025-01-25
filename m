Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F39C0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiid-00079B-II; Sat, 25 Jan 2025 11:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigr-00056T-Hh
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:29 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigp-0000na-Vf
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:21 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1625793f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821237; x=1738426037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ0qtgTntar3QVC5dx8kSZPa0KtS/nd9q7NwrkDQJ3Y=;
 b=atzhW1vH19stUIwc7Q2FdITCTNois8GFoblgsX4g72LrYo32to0SffWP6fZK42Pxcf
 S+wCG2LPNAAEUyKcfyfTw9Y6IZvKIvR/Q6S2TaCofji5iZUvrDj22/BOpc7lC6ST9pLq
 RD6JQm9nsc1sVI6nkmaPnj+HCEyCWJy3d4N16kVb25I4EVbtTt6H2RKblXIYvdotAnmB
 DVzlh9jTDtFIfQzjWJStom/cUFS3qmIpOkL1U153eNXk1mSsC2eU37TOS1x0Lq8K6UYa
 0NHrYsrTN8KvFI+b59+5Cj6HXOw8/cBN8m5zrI3fl2ib8tmzIEm5oMNu1zG/jMBDJUp3
 +ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821237; x=1738426037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJ0qtgTntar3QVC5dx8kSZPa0KtS/nd9q7NwrkDQJ3Y=;
 b=CVJTw6O3Pdkkm8kAr3LkoIeV1Gr9HCongsjQU6tsWAmAKc8t8uoTQFniyxbTZTQB3s
 WLOzHgSJddDjD8VakZhoHbDdh3jYjFEs4i22ruha6e8/VDPwnXB7PCCyhKnG/Lw08PkK
 dbBqUr4f9470edsxKSqfBDwpwlbUGUGvi5asQ20dCl8FbjyNYt9ME8Bc+KNUFvsEEHtR
 ejw0t0QJ60n+XOnHIbBS4Vj4WoefZjGzZz5oTfdcMLHvlDA6pssBn2OeCaSFjyK408KR
 ndNO4byiBqHKeJJurrGklprP3yrKn0dDyBLXdlEjhQg9rrbrqTfmGYUWsYRN/Ob1OCFo
 hxsQ==
X-Gm-Message-State: AOJu0YzqrwlD8b5PsUGNnE+WmVSY5QMDYtFNXkN2gAFslzOsO7r/wj2X
 lS5vOV74wjvO/2Xrn9c0rQqQeVrtcviCM1DDA8zAncSfcgouZN+e/ykmy1o62EZ2YxHt4R9cu3O
 S/b8=
X-Gm-Gg: ASbGncte7G3tWJ2uXBEbMVLqZ3jK/8BNyo2FsTqfXykPtySJAdPvi0t6AY3jLV6Rklf
 MmQwvQdLwK19s964nHbIEEC7wm2DVn8H3Ild/or/P3Q6Vuum7JoI3/mMS38CRkPkreLNX7eRU/B
 tVSGeIWn4bCli95qBcdNqemIdHPDPSGu8gnhTSxtR8oQMGyawnifEVBBS1qvHb0gdJ1uXC/bmFy
 755m27hP7yKwhzDjmigti+hK4mZat/WPT0BmGMLYHhprWvzh96shQd9IJl1RjgM7FUqOELUXCX5
 F523TdjjIgzOx3Cayqadx0Xs0IlQVH997pvwVgp4TKA7BtoS16KirgBqwWs2
X-Google-Smtp-Source: AGHT+IGYkfYUrYo9gaezwZEcSP/KhLgJCk7dG3M3871x6TROReEPEBUD896SuG1dal2Z5xOH67agJQ==
X-Received: by 2002:a05:6000:154b:b0:38a:8888:c0ef with SMTP id
 ffacd0b85a97d-38bf57be3ffmr30005007f8f.52.1737821237509; 
 Sat, 25 Jan 2025 08:07:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6e2sm5858221f8f.23.2025.01.25.08.07.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/24] target/rx: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:45 +0100
Message-ID: <20250125160552.20546-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index aa310bd6144..79b95090e7a 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -187,6 +187,7 @@ static void rx_cpu_init(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
+    .has_work = rx_cpu_has_work,
     .get_phys_page_debug = rx_cpu_get_phys_page_debug,
 };
 
@@ -217,7 +218,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->has_work = rx_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
-- 
2.47.1


