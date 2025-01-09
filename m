Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B8CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzf-0004lD-NH; Thu, 09 Jan 2025 12:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzc-0004kN-60
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:48 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvza-00071d-Ji
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:47 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so2088757a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442405; x=1737047205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WxsgJL7chOGbG+/17n3vpjWqUAThC5sUhtSd92NFE0=;
 b=vvYBbl19KP5MVN838skQ62mP6o9yCISQmJlcMNkBQKUcDU2oIvnOAXC+UNccEQqLhf
 aj3muIL04sgnp6swsixCxArVBc47x7kl7OJ9RInQQM+e/8J2j0IEs6D7s3slBytBG4u0
 UjeYuUhaAnNGgfJo0mnJ20R9M30eiX78Nh68Odu/W+pv/+5s6AMiCgb33EOiTpB3v6xw
 h+5eapFeuNLcy6dVfg54uzaMM7GGr48nzzBhrGXM4jWn4spKycECA545U2EdAghV3MHG
 Y1X4nPczhIx+1MogoJB767t1WA23wHED9Css9aVDlBTgJsbz4rSmKnkxqMokzSH3wp8Y
 2RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442405; x=1737047205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WxsgJL7chOGbG+/17n3vpjWqUAThC5sUhtSd92NFE0=;
 b=to9HsttrdUN4YnBtfyK5eRAalgoYxl/QLvbgz6xQr43h9mMOyU72F0UHMuxbliloGP
 v5glvv3ib+d7MkcAIupU+NMuaBfh4vSUrv8rZ8HXqrxVGZSuz7aHuT42bHIZs7FOmiFW
 WHop7a+WzvWYwE5Fyi2LAcbBcI8vebJajib3FuIjpo8zIP6oG/gVNNS7tiK3l9M254uf
 T3F84mIkB4OFQtpQ5ZVdkQ35Cy5X5Xa9aUwa3kRTXG6sCW1LjimgCkduKw58h989RZsN
 PLaFubBolWHuqwvQvFwV4ypbdtbuYiAVcGgr8+4YJyP0P+vdeKHYboOrvJi0vhv6LhUI
 OWWw==
X-Gm-Message-State: AOJu0YxoIW32tpR5dKQaOmFxcuEYJGIppM3fbjxy17AhYYzbIaq1sZXF
 skSPMkLwk/SRTVlCZtZrIUOg9qq8KM53ciZ7czoVlO5Vz2q6z05WEe7sWAige+E=
X-Gm-Gg: ASbGnctEvqTuoQUo0X1LHS24NyNQQDIhDlraGtaiG7VCDCiuoxIjDf+ZIWEtb3diGVK
 ie+/rjddrJOJ4/hxbZ+jwmhhkJvRfc6cwevHzOXLVOTuhnwo5ECjtnQUxYTyV6HSTN8of+TgtUy
 xOwANk4z8O2ldKKJlUNmjSv27OOvZ02WNNxGYoZjzNkrJyZ29s+rA4CKfoNMYxtFidR2HFrzYT1
 tb6D9i8pP6fz+ThOQmtRzuEJyE5mJGiNLF+Z599w9GAuvY17a1R4y0=
X-Google-Smtp-Source: AGHT+IFdJT8QZSt3ckJzPVfU/vpWIxhv53dQGCArdAhe2i/p/O+HRGOMjeyTPi7bS0L/GEKNmgXc5A==
X-Received: by 2002:a05:6402:26c4:b0:5d0:cca6:233a with SMTP id
 4fb4d7f45d1cf-5d972e04ba8mr7336880a12.10.1736442404696; 
 Thu, 09 Jan 2025 09:06:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c4b2fsm759923a12.29.2025.01.09.09.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E8B215FEF9;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 12/22] contrib/plugins/howvec: ensure we don't regress if this
 plugin is extended
Date: Thu,  9 Jan 2025 17:06:09 +0000
Message-Id: <20250109170619.2271193-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/howvec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 9be67f7453..2aa9029c3f 100644
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


