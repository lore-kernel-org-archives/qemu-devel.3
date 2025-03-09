Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5117C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqu-0008PJ-8T; Sun, 09 Mar 2025 13:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqo-0008Es-S8
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqn-0004zo-1r
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso19982535e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542847; x=1742147647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wdD1Qd8KNe+bgctCgH2R6pDa3Tl0+wEQrO60raHjwyg=;
 b=WyHLghVuKtgBinojz6A31ft6oqe6XC+Vnw9NbrAUeErEcoTWKgi3j9fm5FPKPind6i
 iuWjIcEWiZv903mq45+bt5ai7IrWloi4drAnZPhTYqJUcWjQ6/tj5INVcbdf6MAEbSvn
 zT2lp6zluvchoMUolfxaGG5BFkmcfJu2I2b2FQEvQyr9cLvgLQzHwhxDEgke5kaBwJo9
 bWGdNYHfntxj0Laser6TJy5KvVCNo32QsriRpwZkot0BmDmCz1QHqocgk3Jq0gBL0aYa
 QkL9mchDZIg19AB+nCdXqpi9Fm5e8A/KvpgRvuSYYDDzspNYWol6ynYFXGYXd/DCSfsh
 NXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542847; x=1742147647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdD1Qd8KNe+bgctCgH2R6pDa3Tl0+wEQrO60raHjwyg=;
 b=UlGGJGS5q4PWf+a6Rq9M2XTZ7opWU/nI0cSxDhuSJYW+Y+hV05QKZFG/LVfwBn34bj
 SQnWp3v8DZ108nALYBqHLs6tKglZdkoosmYJzGr5a55vIoW227dWKGxw3hH/KNfBqqTp
 lGdt3/orsdUrsQ4ag16NubAxEsmO8fM/ksoIjLjCF1vNi6R/ZTxTyPCJnBKv1kE5qITm
 XUIKWpG8QhdjmW/2ufoIZ1eJkUnXY0mPLZheF5nZZeram7C72JGnbgVBYq6ObFmndS6H
 PZEXjjB5HBxBDSAGSwCNCEYlRZKPla3YLhurC6MPgE9YJ9XsbqiB1aUMxc2r7bHLSyec
 jUiA==
X-Gm-Message-State: AOJu0YwLau83kj47X9J+t2ZDocNz6owXCVJBVAn8D6AMrWIc46+9haCe
 imU0N4qKJI8wXHJl2q+3KtisSiaL9hDqKb9VCyITK2J7yixXD588PYEAXsK++sgq+XkAVBBy1Ie
 TK5g=
X-Gm-Gg: ASbGncveQM2A0MrV06nkiAxYg7WcXB1F2vlsSOAJ+yqxP7/5dspuwzBjenXimdqUj3S
 8OQvPA7WRp4ionW3G4SMISEem20Yj7MZ76C4zs7hbGUFbDq+BK7kwqsgQWaT5p3hnJj9E//I7kP
 DwMh4gbN9O67qhr/3yAHf1CzmpFjFiu58S2uRguSbX3TMXZJwgXnbO9BCa/jExh80zgFx9/hXSD
 JxlPu5fKgiaPa86xFd+7HeyoYaCyYposXLWhEWV95AjVbEbC5RlgZXCAWmS41oSU7LIuKckkjbl
 vXxzwaCTk2H328rKqW4S1av24prqb1wOupCYyweCTSS1VsGD5XzQ+lSHfl5tB3jaNAqVQ5AZBzO
 iY37VPyqG9GbcNYZMgzP9FjgGS4qeIg==
X-Google-Smtp-Source: AGHT+IGAFztx6WSE6Da2uAD1PzSy7wRzFymwUmzlctqI86P6x42KHXqYXUuFF6ynKhLC+lFwV2UgUg==
X-Received: by 2002:a05:600c:3ba7:b0:43c:f4b3:b094 with SMTP id
 5b1f17b1804b1-43cf4b3b345mr12075045e9.6.1741542847222; 
 Sun, 09 Mar 2025 10:54:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf279a1ffsm26151285e9.39.2025.03.09.10.54.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/38] target/microblaze: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:54 +0100
Message-ID: <20250309175207.43828-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-13-philmd@linaro.org>
---
 target/microblaze/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d5ee1244cad..f3bebea856e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -115,10 +115,12 @@ static void mb_restore_state_to_opc(CPUState *cs,
     cpu->env.iflags = data[1];
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool mb_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -417,6 +419,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
+    .has_work = mb_cpu_has_work,
     .get_phys_page_attrs_debug = mb_cpu_get_phys_page_attrs_debug,
 };
 #endif
@@ -452,7 +455,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
-    cc->has_work = mb_cpu_has_work;
     cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
-- 
2.47.1


