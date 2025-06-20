Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F2C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5J-0002Zp-JF; Fri, 20 Jun 2025 18:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXb-00076U-LU
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXZ-0005uS-VS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so1389566f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440516; x=1751045316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVfl4a7zvO8Yq+0ojWc2U1WLc+2IZ+gWS0XMhXqWu+I=;
 b=vHEnxix22JjyjieKWX2fevIQEUEb0srNS9xKwdLZrka9CLDELYvG/Ivm4f75miMep+
 vlpz1KAm+Ke+9L0Na4DHeqt2GyQIoPq+P2Lv2KnGALYK47WwsiaaFuD0ZLn7RorkIDVn
 WSa8Tm6tnsTtPp0f48Ng2UfGfC4Eg5Rs99MVSeymhUV9G6OeuHuqAG5RzGxiPrh+7HOt
 UwWKfPUQvIw0U26XuNwlLl9w7luloA3wIb6T7g4YgG3cPQgaS2QXHV/ySPSkeZLBm8gv
 RKtzaZUrwgMIeyPhL7rXQdUoSTDc4z2WVAonyegrnx6TAQL4QK+RigIZP/OZ8BNiBc5u
 c+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440516; x=1751045316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVfl4a7zvO8Yq+0ojWc2U1WLc+2IZ+gWS0XMhXqWu+I=;
 b=d0HvZHscu32B99UZjqH1QU4hJrwwzydxLMFmvyPvkXcgBJ75YJnYV5ZV4rjWzViEiN
 Ncd+If+I6iRWUnI8PlO08qHFGoGgZcAmYD4by47Nb+nUfJcLuin++mqp/AFFy82gdXNM
 IM+8FvboG0ly5a2BzM8CX135vbtdoyQUW5NtC/M7TvIPeoIQ/vFyDgW8a10Hg63UKnfG
 rOG93PsN0joTfCV9TOzB1fcFsFhV+/f1QHaGyEJLVgzyBOGwbUSr2ofuDIDle+DGbIUU
 sI/1md2aoufbl7nbNZ3MbM5hFIhZGrEZBRdHT2qVM7XxBcWrlHYKspI1EyFM5yzVs1i+
 Jo6Q==
X-Gm-Message-State: AOJu0YwuqYiyBdMyGPYEeNrUb+mtNMBeLZZXSBs00bI0ZfMgJcHWCwnE
 mNuAcN/8Ju+qwkvt0FUckPSaGMT5jlcFZ+eGsElcFLq4pBStHbwxB8MCb/0sfo3fTNeWeTkOsHw
 NePHx7JP8SA==
X-Gm-Gg: ASbGncsRPAjWsx9izFgoqudZPbSaUE1CTPZX7TfZG2GCBFVKBYmZ6tgfz512AuLzW+j
 1IR3EPPBH4IfGUUh5hE73tjQCN9JeQ55kpErstInjpRozDmhxggqz9OuP8KI/Jm6CGCp26rRjvq
 6P7wUtS8E+pN/JLHh6c5WDTzAB6qkrOVsUq0vt9+6XV25wEB1MiczjeV/dCYT0fmj4TZdIWaQ+7
 qV6IK24qlWFuRiS0wC5dahWvLNJBJ/W9LoMT2VO2U78zNqNp2dNBuXYQUbQGieDycQwv3Vw6qcr
 RAfiFDfAoZ7uzeRICFacuge3QOR+BshcgccHL584elDfGPLFC4K5bjNz7GiDuU07/I5EHmO/Qz1
 PUxyYNrKIPiutburjCRCB/a3acw0DWatk/jO1swdsX9Ctu+3Vvza4QygfCiWYZ/pYrIg=
X-Google-Smtp-Source: AGHT+IEAkv3Pa7GOZEsZM4opT+mJ556FcRV4bQ5YN9/6kGe/S/Znz5iGqPDz272WqKJH5NRx9Y/qyw==
X-Received: by 2002:a05:6000:178d:b0:3a4:ebfc:8c7 with SMTP id
 ffacd0b85a97d-3a6d278a2a8mr3083233f8f.8.1750440516113; 
 Fri, 20 Jun 2025 10:28:36 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117bfd9sm2647567f8f.57.2025.06.20.10.28.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:35 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 05/42] accel/split: Expose 'hw' and 'sw' properties
Date: Fri, 20 Jun 2025 19:27:13 +0200
Message-ID: <20250620172751.94231-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In preparation of other accelerator (or potential emulator),
expose the "hw" and "sw" keys. Only HVF and TCG allowed so far.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-all.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index 7cbe32ea768..28f626d0ff4 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/error.h"
 #include "hw/boards.h"
 #include "accel/accel-internal.h"
 #include "split-accel.h"
@@ -78,6 +79,42 @@ static void split_get_stats(AccelState *as, GString *buf)
     g_assert_not_reached();
 }
 
+static char *split_get_hw(Object *obj, Error **errp)
+{
+    SplitAccelState *s = SPLIT_ACCEL(obj);
+
+    return g_strdup(s->hw_name);
+}
+
+static void split_set_hw(Object *obj, const char *value, Error **errp)
+{
+    SplitAccelState *s = SPLIT_ACCEL(obj);
+
+    if (strcmp(value, "hvf") == 0) {
+        s->hw_name = g_strdup(value);
+    } else {
+        error_setg(errp, "'%s' accelerator no supported", value);
+    }
+}
+
+static char *split_get_sw(Object *obj, Error **errp)
+{
+    SplitAccelState *s = SPLIT_ACCEL(obj);
+
+    return g_strdup(s->sw_name);
+}
+
+static void split_set_sw(Object *obj, const char *value, Error **errp)
+{
+    SplitAccelState *s = SPLIT_ACCEL(obj);
+
+    if (strcmp(value, "tcg") == 0) {
+        s->hw_name = g_strdup(value);
+    } else {
+        error_setg(errp, "'%s' emulator no supported", value);
+    }
+}
+
 static void split_accel_instance_init(Object *obj)
 {
     SplitAccelState *sas = SPLIT_ACCEL(obj);
@@ -100,6 +137,15 @@ static void split_accel_class_init(ObjectClass *oc, const void *data)
     ac->get_stats = split_get_stats;
     ac->allowed = &split_allowed;
     ac->compat_props = NULL;
+
+    object_class_property_add_str(oc, "hw",
+                                  split_get_hw,
+                                  split_set_hw);
+    object_class_property_set_description(oc, "hw", "Hardware accelerator");
+    object_class_property_add_str(oc, "sw",
+                                  split_get_sw,
+                                  split_set_sw);
+    object_class_property_set_description(oc, "sw", "Software emulator");
 }
 
 static const TypeInfo split_accel_type = {
-- 
2.49.0


