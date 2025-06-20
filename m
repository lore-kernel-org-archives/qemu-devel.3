Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D0C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3g-0000bZ-Kc; Fri, 20 Jun 2025 18:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbQ-0007zD-Hn
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbP-0006bn-0r
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso10285315e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440753; x=1751045553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMBGvk/ssc64Bo4PIfVmVgfcwr6UcoTUDZkYavd25rQ=;
 b=mRC+FHnMwsl3Kja9nOFwbPTRHxevvaz0wINhubYMhEjBHnkQbWj0D4JbMt4FeBMi+z
 d2GKv1h823H3oByAnJbnOxe3cSxnvPyyi9+KVVPQsFR6eqh3RmwITdlk28VAJHocEqmB
 yFlcPsUOvs7np7lrhG1pwiHwEh501Pp7YjRF4ThVcan8Ix+ZIeTbuhgAWy4uK/xrc0mn
 8imgtlKX27txxwdKxM+XDbhFGTT4MJUInQwpbsJtUWE470JU9O736FKaRkPnS0Jk38VX
 +q94fvMLGbe4SIUGSCQtuwj0ufZiOXlIuLTgL9dY4xxtnyJoI04kaqPyWg3oZmjywWbe
 +Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440753; x=1751045553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMBGvk/ssc64Bo4PIfVmVgfcwr6UcoTUDZkYavd25rQ=;
 b=KZao2towbrbiJ4Tvu0A/MzytjtBscSulb7ksdq0jdhjWIzFjh5qAAWGxu316dJ+Zfb
 +GTOTOzBlvbVueXUFnJkd+nkNJ0jEf1/JGuOoLPHpRw0iUXvyKd4IEl6FdibFasHYn/4
 O9bDha/AG2OcZ5rVW2VIg78xnt78zRSKG6WxjqZHslTzEpzye2D35jByF6YxnYGWO9Ip
 Qtyj6y5wYilyIVTLMud/NtP6wDCP/ddVHWyth0FRg4fecXJKpGAjCoX3118IMaB7HiNU
 trnINJ4kw8xSddNZSqawIDoDOK9mEBef4Jps3RUuLASJdr7ausNERoNuyBdDclw/MPTg
 tnaA==
X-Gm-Message-State: AOJu0YxikXD9jeYb//fKHUat3WYdErtraPOk/VFNCZDZx/3E05fRN/IO
 AvAIAdIyXNpxKoySaHqI6wK+wkKRKqnnW95SylGuNbAEV6tblTU6pRPggVsiGiZYorbLeQzrbMo
 AVxmQ5RMlbw==
X-Gm-Gg: ASbGncuqKYcYJn8CTfsJmDR8RIA5MybzTEk1TIuro+wdfpaCAu5Gi5rf1LYoWg/Do0G
 zRbMnM1ygLZvgZgoZvdpneoFamz4B6O1QG64Zsxxg7lz7zKvJy5NMEdmjbo81xSWcTpeB3jJ2vZ
 uKRLRrx8wuNtEYbIsrycJczxXtvONLI8YaKZr2d/KzqFT78hua+s38UlB5rPnYteOhRbco/HcZv
 Tlug1RGtgW24ziSJg618nSyCOywcazRA8OkDZ+mKP/vsEQmXwzl6N4E6skXZ5dg0dHMiuIGJoOk
 2SQM8+AOuKqNYURKEgXlDSe6uc9A/JRWzVAEWzOlEPGZJxbu1GCiTZTiCy1yPKnAbnYSTDD04fX
 TK0/1mgeKyLUDjjiAXC5Y1yzZDRx7/dA9zrHpzOznHSYD7xKE9JTCQjjF
X-Google-Smtp-Source: AGHT+IGq2WbnJyV4O4zYRdXeBJfJIlMpZPZH66Q9pss88LxzwhdEUVglGQqBHSY7TrlGKzzb/izdnA==
X-Received: by 2002:a05:600c:6305:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-453654cc279mr36427445e9.13.1750440752969; 
 Fri, 20 Jun 2025 10:32:32 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646d1508sm31553015e9.12.2025.06.20.10.32.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:32 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 32/42] accel/split: Implement insert_breakpoint()
Date: Fri, 20 Jun 2025 19:27:40 +0200
Message-ID: <20250620172751.94231-33-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
 accel/split/split-accel-ops.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 40cd39aea5c..eb52d690c7c 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -258,7 +258,18 @@ static int split_update_guest_debug(CPUState *cpu)
 static int split_insert_breakpoint(CPUState *cpu, int type,
                                    vaddr addr, vaddr len)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+    int err = 0;
+
+    if (hwc->ops->insert_breakpoint) {
+        err |= hwc->ops->insert_breakpoint(cpu, type, addr, len);
+    }
+    if (swc->ops->insert_breakpoint) {
+        err |= swc->ops->insert_breakpoint(cpu, type, addr, len);
+    }
+    return err;
 }
 
 static int split_remove_breakpoint(CPUState *cpu, int type,
-- 
2.49.0


