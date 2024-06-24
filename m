Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C1FC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgml-0006rA-27; Mon, 24 Jun 2024 06:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmh-0006oi-4L
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:51 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmd-0007hT-Tp
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:50 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a725d756d41so58075366b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224325; x=1719829125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOqcccRFtqwnOnQskJAEv5Hp+aQLehrHF9Mo27OLiHs=;
 b=eRNL3Z/2b7At9tCV5e0URQpy82BZ82qmdObN4IXf/wQhyF5EK4KCh0ukzwXA9I4FDo
 T+8yU04JkxqZGwTpbMEXTM+NBcrKZnK3P5gzp6qn7mXuitQr01Eyq7Eubika60bWFd4i
 Exh8i7PkdT1PwOw9i3gadwMUAsfQ8AkrPy3vsnTJVyD2aK4GS+okv4QMj88vxiWmHz6V
 aGyJKDsjkaFpkemCXhQcd/jM/wO7opK+ws6ra9D5NQr+0kaOuT42VKXTUGtZ/Bp5SdDU
 Ww8RTc9+kg2nCVkSFF0JxhzoB2+K3OVBojIYyJPxcsQR1NFspL47Em4glRuWYsQ3hs4V
 tELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224325; x=1719829125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOqcccRFtqwnOnQskJAEv5Hp+aQLehrHF9Mo27OLiHs=;
 b=D8T/8J1fJwbLdnadLx6bcXgcD2TQxcWSfdOV9HmhrzAaVkJVt0HoLGjeSSMMEv/k3I
 +SJxPlf41rZ09WKPRAZIc/xxJu45EmtRPH8a2b7AuEUjXYGeKq7FEsUG9AM4qJ6uPAKG
 6RqulYKoE5KgRN8OWmJtkOkVerTv69sq5kfasUcFNfuIZPkOky/KtZ3jE9j2pbMAmIx1
 U9esAlpOrJZ4GCsCMd/+t6TDSfmK/YPagQic2A62ptLEhooxVhfzSCZMS26F/2UqGM7m
 kYJaWYPWFKSfZCxuJjwvRHPwxRsy4twjcHMpVZ7mxhZwSiPeYnNc5CSsZm4q5o305ZY2
 BaLw==
X-Gm-Message-State: AOJu0YxewoX9iCzxAbszcckxR9stqF+nO5taSKWXHnckYcli+Y50qj1e
 wat0voq7ad26mek/KMH4ydX7SwvHI/0c8WP4WzvW1M6l6lcI3XRZ7cDVEftCXyKDYFaSzEBdpL4
 7
X-Google-Smtp-Source: AGHT+IGVV8EfcoWO/NT56w8v6aH5qpXhL92REndMYGyZvQDCrOk0fo/iVRh7SCRq4Lr1Ip6W9oKGgg==
X-Received: by 2002:a17:906:f34e:b0:a6f:b91c:5197 with SMTP id
 a640c23a62f3a-a700e73164bmr337627366b.36.1719224325233; 
 Mon, 24 Jun 2024 03:18:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72479f360bsm184669166b.173.2024.06.24.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 385B75FA2B;
 Mon, 24 Jun 2024 11:18:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/12] plugins: add migration blocker
Date: Mon, 24 Jun 2024 11:18:33 +0100
Message-Id: <20240624101836.193761-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

If the plugin in controlling time there is some state that might be
missing from the plugin tracking it. Migration is unlikely to work in
this case so lets put a migration blocker in to let the user know if
they try.

Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240620152220.2192768-10-alex.bennee@linaro.org>

diff --git a/plugins/api.c b/plugins/api.c
index 4431a0ea7e..2ff13d09de 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -47,6 +47,8 @@
 #include "disas/disas.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
+#include "qapi/error.h"
+#include "migration/blocker.h"
 #include "exec/ram_addr.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
@@ -589,11 +591,19 @@ uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
  * Time control
  */
 static bool has_control;
+#ifdef CONFIG_SOFTMMU
+static Error *migration_blocker;
+#endif
 
 const void *qemu_plugin_request_time_control(void)
 {
     if (!has_control) {
         has_control = true;
+#ifdef CONFIG_SOFTMMU
+        error_setg(&migration_blocker,
+                   "TCG plugin time control does not support migration");
+        migrate_add_blocker(&migration_blocker, NULL);
+#endif
         return &has_control;
     }
     return NULL;
-- 
2.39.2


