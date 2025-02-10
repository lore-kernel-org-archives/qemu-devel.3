Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA20C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTv8-0001GU-BR; Mon, 10 Feb 2025 08:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtD-0008IP-An
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:00 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtB-00067O-E9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:31:55 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38de17a5fc9so354490f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194311; x=1739799111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KA3PYFl+mxJRTVPlW5hor8tDZDSjl9tizJiUvoZXrI=;
 b=lupSslrhQVGQQEmAfuGpMtffQ2WD3MaH6AoeRGYAbSVJEjHinS+bQUFCKW0yn+Agwe
 8NLWpt70MMzl+FZka1hvJTJ/21L2eJd8lj5uh56FGihdaHrk6b4bfgZIsAj56nKgv8wp
 XlIYr7UtIOPtp8qDyZGHqxApajskITmCt5aZz30Zk2/CFVecvqPfb8oEROedNx2Frk29
 Or/V/17vXvo1TLCubuXpJRXTW2CHjh9x4IQc50F+d7L7IOjQUEL5p9GDzAZPN77yeugN
 vn87X6/2NgUzaaWIEw67KDsDFbufsOsMqJOYpLUE8PAUqLPJk+ZhVIHl5Sx3f/gl4Qcp
 kkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194311; x=1739799111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KA3PYFl+mxJRTVPlW5hor8tDZDSjl9tizJiUvoZXrI=;
 b=NZBYLJ55BbSIOLXWafuLUOCZggIO5lH2B/cTxz9SYlqg94UD6rxNQjqHYebA1iu4/H
 ptRkxjSln8qQppvK5pGx5hZTj5qnPpKjLgEFnkVLm3m2d70y37OfSxS6np6kPvyTevtr
 o00ugVLuPDqkdGrrzC6TXLnWp6eRH6kR+wkAWSZ7vzkjTCcXCK8V1K7kuKoF7bHqF9iT
 bCLlwq42pO3rWsxmOMU/vUx34Nrylpm72KcX/K9mb+aGUWeWSN8Js/cVT4dWRM7RRDdj
 f/17/f2B3UNBV7sKOIpGlyheiT4MjyhepkaUky5eJSsEqMjAcnE4vEuZdbJ7DnjE2kXv
 ti3w==
X-Gm-Message-State: AOJu0Ywlhy075D8T7TI3qLZvwbwq6pLXq1evJjBkQEZIwQtRUXu1HgG3
 e2mH63AByuAestqDowkubHFJNBlDio3YRCYuZFDLc3Zq670vqOT23Od1RDqlxerkR5M7ZkRDdbm
 +4ig=
X-Gm-Gg: ASbGncvGZxhIXcfTYfVAOoaHgycxcjNbZHgCnruZrkeMY/xet6q/fm7HijNilGK6V9V
 VCGEeKbrBvy7WRenpG7ws+3eKfe2Yzsg59x1d4aFn1dkANfTcDUA2Klg+ho8s1dxM5YKX+lcEMh
 1n1/yq6Mje8okvqOSwu8LO9hk8J55arWsinKVAqqIqVD7heugJzJt1czJT3b2DCHy0/chqv1gq2
 1QRS3i/xZOafOxeyrspPGF87i3F8oHEzuYQpzEjxYk5iCnol0sSXECSRr8o9kziC3QdKCs0r4I3
 E3cr3xqfYO+zocMuJgRdSWCc8R0bXmcRtfG4kLw59VQJMXrFWILsfzamFu2DSDb4/SSo5KQ=
X-Google-Smtp-Source: AGHT+IE7jlmR0AAKLTD8eqeVEQgNFAg6z03k7hE7woO3b3a4ldCVpH2iXxybXmVScPXOvfIreTXsqA==
X-Received: by 2002:a05:6000:1a8d:b0:38d:db8b:f505 with SMTP id
 ffacd0b85a97d-38ddb8bf70dmr4124914f8f.17.1739194311151; 
 Mon, 10 Feb 2025 05:31:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbf2ed900sm12165980f8f.53.2025.02.10.05.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:31:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 03/11] target/xtensa: Finalize config in
 xtensa_register_core()
Date: Mon, 10 Feb 2025 14:31:26 +0100
Message-ID: <20250210133134.90879-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
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

Make XtensaConfigList::config not const. Only modify
XtensaConfig within xtensa_register_core(), when the
class is registered, not when it is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h    | 2 +-
 target/xtensa/helper.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0e6302c5bd3..8d70bfc0cd4 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -490,7 +490,7 @@ typedef struct XtensaConfig {
 } XtensaConfig;
 
 typedef struct XtensaConfigList {
-    const XtensaConfig *config;
+    XtensaConfig *config;
     struct XtensaConfigList *next;
 } XtensaConfigList;
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2978c471c1f..f64699b116d 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -173,9 +173,8 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
     XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
-    XtensaConfig *config = data;
+    const XtensaConfig *config = data;
 
-    xtensa_finalize_config(config);
     xcc->config = config;
 
     /*
@@ -195,6 +194,8 @@ void xtensa_register_core(XtensaConfigList *node)
         .class_data = (void *)node->config,
     };
 
+    xtensa_finalize_config(node->config);
+
     node->next = xtensa_cores;
     xtensa_cores = node;
     type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
-- 
2.47.1


