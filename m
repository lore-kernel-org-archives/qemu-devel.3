Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9454C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiM-0007xO-KS; Tue, 01 Apr 2025 04:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiA-0007Od-H6
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWi8-00060Y-OZ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:06 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so2700323f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495063; x=1744099863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xf49rpCRtDiaQ+LoU13pvuqYxv6P0Zxq5lhMwhd2Njs=;
 b=WBjyI6sighsK5xDEjAkM7hIL3ts5aoPtXk4l4v8QVONm/a6SzmnvclkOYBKYkfZKDe
 74FjsFUaiQs0Sf4jQ/XlOhr0NBtzUs7Jz31q3tB5UvdKnSbQdgnCslLVsUFA3nA+h8Vc
 6DAIX3yfS3tOZgMIGsIhwuT3xIyB4G12kbk8Zg5lempkHgy92SIsKjVqIy8HMpN5rl/q
 rPKO+hDjY6NhMMiYHgs2+c0GcSsT69rBv18UCen7c4xcUB9ljUN/3qJXpc2QYOmM00IR
 RpgWAnEcXAZZcXZgQFb47ivzF8kcX09Qy7/KLJG9vp28V8UteTIjw5+HyMl+1BDtBKrN
 tT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495063; x=1744099863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xf49rpCRtDiaQ+LoU13pvuqYxv6P0Zxq5lhMwhd2Njs=;
 b=VR8ILlV7cQRx5TFx8sMJ8swPQ1vUgAHl/NfMClvYpCO5vsl7rxjkutg3NtZBgPDx6Q
 dypXm4KUZ7GerFi+ba/Q8PTqtOUIfA89HcV5mWqPz0un4NXP24jwej/2rXpf2Zuu9zYp
 483HQze7CQpaUvOikhxg2dVXv4NErfc5jFMHLkEYaVilPi5Fg6gEUOZe3TQVY73tKJOD
 EEOfkgRtIGtuLwSDiKexnt4v7VPVL4nFttiZ7tBDNF6yfWZw5HWbRHXPC6zvni8ZxgZq
 Nqh4Zozt74viz7lVG8zB2wKCkPpcvEdRXgfqcFAKyNwKLMq+djobHT7kmUUGR6WiLY7E
 Ljdw==
X-Gm-Message-State: AOJu0YyxFMO4NFwSIbe8RtoLve0x18LKAq8C7jtGGn5gUV6jxd5Na87a
 4QoV9gxlKY6lQNsmd8fNcG8D/inaCZb+irq9K74LJ8EDBOOEeU9lnUYU42t10g4kvgkrLpQ0mtr
 o
X-Gm-Gg: ASbGncsBvYjh7cTkELRFoAeqE3RXN341v8T/vNkkp+cm3hLFBsDVkfWJnS9xrbOkTFn
 UjGIhJjJIQUfCXLQBHBdV5OzsYF3pUDQTreFv1FlHaT/r2RLhglgUgO0UIg7ADQC7cS20qI0MpH
 QGDY7Y/FL87uj2viMa8HVRDe/0Kk+pHmdoZ2fwbdzeCo6UB9kO92WZpSL56CHdoNrrwOJQITajz
 KU75E0H+F/XxxhsMyWlQcRr6lpOEaFX66e0g2yK5IjhxR+MZ8HyVQ6T4ZPQA+8v+O+BbDfk0BMc
 SzzA2qp7skm+8IlRS7ZFmJ4o6ci0iH17nw4UGodwIuv+ZuyDGgCleG8nCRwpeL9zo1lBJFQsfJ2
 3ZgEbk08fr7aaItbR4FU=
X-Google-Smtp-Source: AGHT+IFz/JWVbcjLIHbSBuP20+bm/tV1I8XM11wCXTUKdFSC2MccdDzzXOCgeHeq3jSmooZjTl+qUg==
X-Received: by 2002:a05:6000:1ace:b0:391:47d8:de23 with SMTP id
 ffacd0b85a97d-39c120e3ce1mr9431986f8f.31.1743495062878; 
 Tue, 01 Apr 2025 01:11:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4294sm13165846f8f.89.2025.04.01.01.11.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 17/24] target/rx: Restrict SoftMMU mmu_index() to TCG
Date: Tue,  1 Apr 2025 10:09:30 +0200
Message-ID: <20250401080938.32278-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 723262f4b54..e14d9cbef93 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -208,6 +208,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .translate_code = rx_translate_code,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
+    .mmu_index = rx_cpu_mmu_index,
     .tlb_fill = rx_cpu_tlb_fill,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
@@ -228,7 +229,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.47.1


