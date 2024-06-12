Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9ECC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQ0R-0000ww-AX; Wed, 12 Jun 2024 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0M-0000hL-VM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:19 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0H-0004KW-61
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:18 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so107166b.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718206512; x=1718811312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UFHAsoemA/1ZyFVkieFp/Fehtdb65Sq2hGoqSQrpDk=;
 b=zxqKA84oXR+mtYuxxvWvdUd4yx8ec6lG2s0QKMG4hV3ozJ2XKuzLrnxMMbTfXGlOXx
 5vZ6boR56bHcKthgNxYc/S3QnahgRKwTphgU2L3TMO1AtyM32Ku7GBTcX9Bjy4Pd4cDK
 fy+ZCM8tnb5kBNeoo4712B1HTHmoIg0yDIyDwv7m+1x4JSu2cg3pNGKqhrg9U+kJxM95
 q/xaPP4cLzxGFApc6pvLPbrXaCSKqvUloKPnIJ2mmhB7/xlkWtiEZTb/diZnnO9HhwC/
 IMqtYH46t86YGbLRWOr6teNB7fSB5qSx6C6+wCyDgj7aJN2MQAXR1B+b0EaRV8gMEaut
 ldBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206512; x=1718811312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UFHAsoemA/1ZyFVkieFp/Fehtdb65Sq2hGoqSQrpDk=;
 b=IyMdRKoIhTz8WZSdl3lQALKJZgoW8RknhVPVqKAIWqq96hGYkUNEouSdS95CbELLf0
 wllmX9qMxPDu/mJA6LDcJHstA/pbkvEWqjkvP9foeypjyWmI1SywJV0Tn3ufprDu3mpG
 r7Msel9UTY0AS8hk/VMzb6TXzE07sbo7CtgiUVJEuMV/JRDQhZhhMGHkzK1ARkm4HCaO
 T9zxxdwuCxT15bWZLCTN9dsCKROEhRgUzlrIHk7uTXLJOYyilD4cTzeOgvL/rk2DKHLR
 mLxDsFMWd5uggGKIf9ncXV4s9S+smR72gkK8d2YD9d4Wt7ZkLyMUVntNMOYm/FG0EHJt
 zorA==
X-Gm-Message-State: AOJu0YyZIC49AnMPJ/3r5G0Ff/CSMVgEQsXa5XghK4nGK4jdiwNnamX6
 aKnTy1ZIIuXvxRRvldJ/b0h4tq+/jOiOo7y/rGvZCFoprbojJ4Gp88VAatMj0Zk=
X-Google-Smtp-Source: AGHT+IGNS2xktjqcOrTpVg66Qr2sh2nrR4+EQZaLWm4leOeKKyIa1XGx1bZYYSow5mTnEGpMAhUn6Q==
X-Received: by 2002:a17:907:7756:b0:a6f:4f3f:e6d8 with SMTP id
 a640c23a62f3a-a6f4f3fe75emr48893466b.20.1718206511842; 
 Wed, 12 Jun 2024 08:35:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f2195a2a3sm370298966b.99.2024.06.12.08.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:35:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 784465F93D;
 Wed, 12 Jun 2024 16:35:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 3/9] plugins: Ensure register handles are not NULL
Date: Wed, 12 Jun 2024 16:35:02 +0100
Message-Id: <20240612153508.1532940-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612153508.1532940-1-alex.bennee@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Ensure register handles are not NULL so that a plugin can assume NULL is
invalid as a register handle.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240229-null-v1-1-e716501d981e@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 5a0a7f8c71..6bdb26bbe3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -507,7 +507,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg);
+        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
@@ -528,7 +528,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
 }
 
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
-- 
2.39.2


