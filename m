Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6555C3601B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiI-0007ew-PZ; Tue, 01 Apr 2025 04:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhw-00071t-FW
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhu-0005zF-Tw
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso37526875e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495049; x=1744099849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvXtchFPfKjtzMUgyqA5zmnfVu8YMMkP3eOTXEU5C98=;
 b=NPV5+lKb3kxHDVgKnyNF5ocNLNjErUElsj6GdFNBJ141wS85VmgvZW6RLNt4iUVf8l
 Edl3qBAKts9LML5SXV4admNpRoYrqU8NwX7ni4iw1QzL3JH/z2qL6YkbZWf2rMLC4Hc3
 uYw01oJHyprdCX02AY0PFJqO4s2qqyPs1mQvW0TiomzTJo7QqOS5Cel2xYAy/a0lAx1V
 Bwbkp0XEfCH/juzeisBJROTG5pUVg3gqmMV5d9WGRHAg9jNuKjMAAVXhiLdaA08tJK4u
 Vgl+xD49s5aOK+Sux687poM5sApMeGxEnHnsgQ7cgar1bwol6rkxq0C3ciEbx3Aed2Ke
 1SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495049; x=1744099849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvXtchFPfKjtzMUgyqA5zmnfVu8YMMkP3eOTXEU5C98=;
 b=YRQDIsUZ3DmfiCSOSgjfTaPXaQJhe//qNYs28Z3eKxmv9UzlE6AaXRHtYICwRUKJPo
 jtntux9j1tMSCDIuA6Fr7rm36HnoNayXjqdbt4JBFLvNWCV5JjUTG/h0kgysyY7DmO1i
 ZpeSURAvL7/mdiG4hWKt01yYbHnw8nlwck3FZJx2q1gtZsF+qDbeleAqgb5CuRddRdvE
 GgTDRMGgchhzjEEForXMDLNQWAaH++65doMapvNEHMYRhDkMhDifqBZ0ZIAl6Sqhydtt
 oAtQV3/AUTBUfW23zd63328H6Ltuy5/D8/1pJQ9L0W5uagdb7GAZXzE2OaV+WPzC8/zS
 /C3Q==
X-Gm-Message-State: AOJu0YzQSiOxi4mbAdJh+r5Pe0DQp8ubVZZ70Gucpfpyt1Vusr8HyUMO
 NamwSta6Kf5jvAnURKlFuDYXMjDGqRiXLrnHMG8H683ECJsXK+2ua5uklypDVLHNBc3nd2e8cuM
 1
X-Gm-Gg: ASbGncuHauVs0gcIDpDlFrfJR83HasoWQz0QXQSo/9Hkp5uMlo4W8tGQCJoXyREhiLb
 9TDdYwDCtoXwaz5IBhJSlq1ZTj94RCrkWeuAcRaT39yXp4Bo63GsPDOPQ2irxKGPl707uYeHNrn
 knkMcQtFHXu1JFlzVCKnRUFW0WIUpuoCXLxCs+NmLipaR8InGe5/JN64Y7LbRl6CVDnEX+Xq3qN
 hnI3PzbMBM7fXS0/Ss7i2TSOWteOAWpEHu7wi5rHj04n/z4rL5+jVgK06fUoKyYyVLNv9la1uES
 toKsTYcKumU2JXiqmVmtkdszri4xvxZ6WnqprvYeGwfMHEicjEOytIz0SJloRPjQrLYo/v5UIq5
 xMHck/UZPOMj5v8yXnwuCEl1SduCYCg==
X-Google-Smtp-Source: AGHT+IF4+hnRJ1BVL4xV7fIH87eZ4/fCMc2egAN5FRlExHiJJgcMnDNiExfuWDG3YaKVyx3bi6xwHQ==
X-Received: by 2002:a05:600c:468c:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-43db6222f89mr112832925e9.8.1743495048817; 
 Tue, 01 Apr 2025 01:10:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314bbf1sm189138305e9.38.2025.04.01.01.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 14/24] target/openrisc: Restrict SoftMMU mmu_index()
 to TCG
Date: Tue,  1 Apr 2025 10:09:27 +0200
Message-ID: <20250401080938.32278-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
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
---
 target/openrisc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e8abf1f8b5c..dc55594a7de 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -247,6 +247,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .translate_code = openrisc_translate_code,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
+    .mmu_index = openrisc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
@@ -269,7 +270,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
-    cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
-- 
2.47.1


