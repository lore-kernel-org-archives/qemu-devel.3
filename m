Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A2DC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcZ-00064M-Ro; Thu, 20 Jun 2024 11:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcX-0005zm-Iv
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:41 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcU-00081J-BT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:41 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6fb341a7f2so130464666b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896957; x=1719501757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQ8CEbgFXQ50Jx+/zMrlpDCus+bU22jqqVwm5sZfxvc=;
 b=qyTwHgqYX6E3DfIN8VEFe6Y71TU8F1nmaGduFYVpRCLkMoaXz96+iyyJkslvLOpOp4
 FF6nJjLkfCfRa7E5aEdJXHH95U5DYD6cvHa66P5t8rvUYTnjJdfet2SCynF4UBXXDYrZ
 aS5zd96v3Qof9gigW6Q12xT7tEmM/oQj5zBEgRdzFaWC3zk0f6hOzm3tBEP0dDX67vnl
 40vEMer0v09Z2vn0AykHjiuKoAvdFl6rUPv+eeAUx1kkFTQMI/MZBleEKSTKoakEWBZc
 WRpE7epu6uFMgu1urh9ZHM2zVTyFA8m0y+UVGgrk7y8rg9QqS698kAzlu8JF3WbXcV5q
 AGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896957; x=1719501757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQ8CEbgFXQ50Jx+/zMrlpDCus+bU22jqqVwm5sZfxvc=;
 b=aX8Ogj4VUdPP+PB/m7GkaOvtt8q4vBey5l22sRYE9RCbc+j/bHDMc15enMG8vOYeK5
 DK3jzI58h2sQdYHE5AyiWPadC+15EqT/tcykGYBymAuaUg6hOZcCvYUaxYRYJ+BwzvAL
 6fd6TPaJMDcnEq6y6Bc/lMsmecUOAtnd/xNoHWl6Ci4hosZNZ+0vTedhNZfFiecgTZTN
 UJTaA4qbxjI+y1O1meMOR9nbmFEnpipfnPV1I0XVckFgqsMnTMCiOLV86rN9/FWbZiIU
 xqhjBRDLbQsLH52BGWsT3gS/iwTHvxFGJkhvZPHn+3FQshkNw8+PieQH+OhhqP0tY1U3
 7HZw==
X-Gm-Message-State: AOJu0YyOzbB/+Q9UBDURMXIuBJuscHLHL5mW+9zzwNYCFc2wx2rXhF3B
 6fS3ZSYuog7wV/4/n7mt3MqLCKR3Sf49QlC5BgqRNjdTm/ZkSDYo4G0bCU4hXtk=
X-Google-Smtp-Source: AGHT+IH9ydE3ImEmECu/jTqHbMKjkbdYKCQBP9DWZg1r82biwaNCpjgKg3b6KL1DuAkpxGXNwAJwVg==
X-Received: by 2002:a17:907:a092:b0:a6f:4ae3:5327 with SMTP id
 a640c23a62f3a-a6fab609e5dmr478736466b.15.1718896956518; 
 Thu, 20 Jun 2024 08:22:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed3590sm782032166b.98.2024.06.20.08.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6E735FA08;
 Thu, 20 Jun 2024 16:22:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/12] plugins: add migration blocker
Date: Thu, 20 Jun 2024 16:22:17 +0100
Message-Id: <20240620152220.2192768-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620152220.2192768-1-alex.bennee@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: "Dr. David Alan Gilbert" <dave@treblig.org>
---
 plugins/api.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/plugins/api.c b/plugins/api.c
index 4431a0ea7e..c4239153af 100644
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
@@ -589,11 +591,17 @@ uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
  * Time control
  */
 static bool has_control;
+Error *migration_blocker;
 
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


