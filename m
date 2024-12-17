Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E2FE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgD9-0005Ly-Ma; Tue, 17 Dec 2024 17:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD7-0005LF-Ja
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD3-0008Q9-Rj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:37 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166f1e589cso60826695ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475112; x=1735079912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kntzVB1MiyL7bevKjAuLTyrUWmHMkhYgMIBRD8JjWYI=;
 b=jka0e2/rf1fDc5ExS59m06zL3kXhOAxCTG5Hz+s8CplkqIHkVPmFGGxGwhKOlrEElj
 c3MwdfqjiO1kCZdYkYwLUlHRFCRiER89tg6Gg2gIncm/44O7ZNbY/1HziSUdTDuEisWw
 3S8Vrkcdmap0n92u/YDL57XHtrE1KzceKcSQdXEvn0Bn6QC3gUvhOMFy7HIyfeIpJD98
 UVruR/+dDSIWHXEfI/dKzRbBRjauQ0oGs4o/pkL/djaZKt4nzlE1ZSfqMLY47VL/wIIP
 EOu/fQB9iZdswXjc2R2HlSolElQCksUswt/Kns1uVWC6mmbtYPrPwBV89mWBZmbxuq5q
 p6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475112; x=1735079912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kntzVB1MiyL7bevKjAuLTyrUWmHMkhYgMIBRD8JjWYI=;
 b=e4RSpQsQbJh47hgAOGryD2lFXN85vJ85OzSk+0P36YPOziv9JvzL2yKsuql2Zn6+Vk
 mCiilNmwPQmbryNlVRMoMLXkckMYYVjZQlRGc/+3LEjLSen8xa6CYggxwnrN3bUbfw+5
 FQnwDyvUYd0lvuzSPgZ+8fQ+r6zV2IhTWQnYMHdlbR8c+3zEX+RNoT6CVmI9Mdt5tf1m
 WgKv8piCwl8Mx76GKPT5lpWm8oS3DNjuSGW0w19jU8JsYDTy1WmiY9sykmNUoJWr3R7g
 MhmSAdtECZLP5JnUmk4bx+gCMp85iI5T2vI0WQVfHvq+bzE62u/wQCMrnWLkgAlBGBfZ
 pPiw==
X-Gm-Message-State: AOJu0YwoFKxeSG5YK0eU+ie+nWyiRfOqJpxW3Rv6pkro/yOxQ8Jo78zz
 +3xbQQ2aGGEg03mjBTC/2rmZNdIDUTrVHuY6V5su+e2nTQvDC0O9eD2O8R7rC+ypwRFH6u6a31G
 zCiA=
X-Gm-Gg: ASbGncu4FpBY4Q2LYMd2DxES+TUGk9XxY/MF7kJU1pB2ofC/WQi4dRNOhCiMtuoCZqi
 oJnDhuJLK1gQg4ckKYcyLOclvJDtvwIkY81T60GDTtkVqcDSazFVIWYI+r4nm99t2MH8mVVtwiR
 EP39oFfDR6c+R5nAxF28JEus+hRuK5Zoxpt5JMolJ91IDjUj2W96mnfIblciUv4pRo6sy4eY4Yg
 0zOVbzkgwWa41ssUi8ayyiEtPK9ZHxkh+hW1gMDdAW/teUU68Rt5qPP
X-Google-Smtp-Source: AGHT+IF16Rr+8F/X6xljZxHlirG+maJGPKkqFWBKXmjLXE0pyuYwA+Hv29I4NYNtc8W6CjshjLy8yQ==
X-Received: by 2002:a17:902:c94f:b0:216:281f:820d with SMTP id
 d9443c01a7336-218d6fd4bdamr6186205ad.11.1734475112348; 
 Tue, 17 Dec 2024 14:38:32 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 02/11] contrib/plugins/howvec: ensure we don't regress if
 this plugin is extended
Date: Tue, 17 Dec 2024 14:38:16 -0800
Message-Id: <20241217223825.2895749-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/howvec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 9be67f74534..2aa9029c3f0 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -253,6 +253,8 @@ static struct qemu_plugin_scoreboard *find_counter(
     int i;
     uint64_t *cnt = NULL;
     uint32_t opcode = 0;
+    /* if opcode is greater than 32 bits, we should refactor insn hash table. */
+    G_STATIC_ASSERT(sizeof(opcode) == sizeof(uint32_t));
     InsnClassExecCount *class = NULL;
 
     /*
@@ -284,7 +286,7 @@ static struct qemu_plugin_scoreboard *find_counter(
 
         g_mutex_lock(&lock);
         icount = (InsnExecCount *) g_hash_table_lookup(insns,
-                                                       GUINT_TO_POINTER(opcode));
+                                                       (gpointer)(intptr_t) opcode);
 
         if (!icount) {
             icount = g_new0(InsnExecCount, 1);
@@ -295,8 +297,7 @@ static struct qemu_plugin_scoreboard *find_counter(
                 qemu_plugin_scoreboard_new(sizeof(uint64_t));
             icount->count = qemu_plugin_scoreboard_u64(score);
 
-            g_hash_table_insert(insns, GUINT_TO_POINTER(opcode),
-                                (gpointer) icount);
+            g_hash_table_insert(insns, (gpointer)(intptr_t) opcode, icount);
         }
         g_mutex_unlock(&lock);
 
-- 
2.39.5


