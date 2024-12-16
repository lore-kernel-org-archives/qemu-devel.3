Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05084E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28w-0007I4-V5; Sun, 15 Dec 2024 22:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28p-0007FF-Tp
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:31 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28n-0005xt-Ud
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:31 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e3cbd0583so421147a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321089; x=1734925889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bp/oRY40UFC3tdQVPiyIpJHiv7h6gPdhenpcH06yx70=;
 b=LObmuccdYr1BYjN12bdL2stwvn/eR+GnQvWB7Qka95rP9OV2Dybw+74H0SpEOZFJaM
 gTX7k2moPQVBvOwl7WSqyYRv0a4129zHonnSStEEPzwKA/4vYEXBt7FYRsjpKz+tWI6E
 vcD+QYrE2hyUgz4EkGDe/bUQrFH3hT35Y2ARTN8wMVcprbYvyb4WubH5CX46uXuQsVW+
 Qlly575h91VbR4bP1Q/KdiEASskYdfRX9mW9doh9Jw5OI4X9dZCn7hOmseqNMtMSDufp
 I5m9SpLIuPhBn9Gpw37ewIkjXaHfxj7tNkNTt+5mhOddmHQ/ABzWmaUyxW9UAppbpr5g
 7y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321089; x=1734925889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bp/oRY40UFC3tdQVPiyIpJHiv7h6gPdhenpcH06yx70=;
 b=G3Q+YvntkbQUMTKOzjjQgAJ3DCcPHPyZWgEkFe0kTB9aJ7SwjejS++McbU9VgRdVkY
 MKMxD8+G/b73m6Xgq1+hD7ubkrk/QEEoAeHwzYi3GwD24KY610zmS2Y9Jg5PMm5izPMp
 kI7H0FK4M7fQRPaWXQPmU03KduDhS375ubxAkKEgU2ccG0qe7Z4xP+qlus4QSdJOvUrP
 JGWJUSrskcE19JrgOTrRBbBCK4nhcIwrwCnhMXUZY6LujJUxtfkrG2VtCEQzjaIOkYmm
 vK4JoGBVch9V+csvv3mOZWKbuWK8hqQO5jfucAS/zCopp8hqynm8nlx3une7jEVkOEL5
 6ArA==
X-Gm-Message-State: AOJu0YztKcI7djIH5c3TKbadPsQSJd9e1EDwVCIHXYolqZZYmZIMSfn1
 s+kMbfP9BGuW1VuDQsFTFwwPctxo+LPCuh7+1fgXEzSPdoeW7d7BMdP37ITLXeTRC4U12WkYayX
 D4LuFMOOt
X-Gm-Gg: ASbGncuvG5C09YpFpLERtT0UbN/1ccPXjDGv8QpBvow2Amxr4iC+NGeMxAxb8fQJTsW
 r1QGiS/bRwFH8Oy2u7zCqNXe3KceJz0if3EE5kChcMcmezRMjCyiBUD9hpDbe+QHzb4nCBJX5Me
 hiTgl5d94gZHnwcNiGae9sWk96Xe11pIlt3lTbd4WH+O5fUlSegM+g85pex+E1SPFVsZ9/CXot+
 xKqXM8p/qvQNOQzc3L6Bvpy0Lm0cHUwT9nFSjWokltfROPFfQc3dNPkGABbIVaG4ZFCead53nph
 SqPC7MxmRzxILw5BuiItFgM3fixEq5K7Jcj+A4OeuMI=
X-Google-Smtp-Source: AGHT+IGB/IgZVAmYL9iW74wyCOhorLKFWPHIyykKwQxh4IkcfnxJGIreEp/cLW+vP4d9iLqz5MGh6g==
X-Received: by 2002:a05:6830:917:b0:718:1163:ef8f with SMTP id
 46e09a7af769-71e3b812c59mr6711292a34.2.1734321088694; 
 Sun, 15 Dec 2024 19:51:28 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/24] target/s390x: Use s390x_cpu_properties for system mode
 only
Date: Sun, 15 Dec 2024 21:50:49 -0600
Message-ID: <20241216035109.3486070-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Avoid the empty property list for user-only mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4702761ca3..263f9e84ed 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,8 +309,8 @@ static const gchar *s390_gdb_arch_name(CPUState *cs)
     return "s390:64-bit";
 }
 
+#ifndef CONFIG_USER_ONLY
 static const Property s390x_cpu_properties[] = {
-#if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
     DEFINE_PROP_INT32("socket-id", S390CPU, env.socket_id, -1),
     DEFINE_PROP_INT32("book-id", S390CPU, env.book_id, -1),
@@ -318,9 +318,9 @@ static const Property s390x_cpu_properties[] = {
     DEFINE_PROP_BOOL("dedicated", S390CPU, env.dedicated, false),
     DEFINE_PROP_CPUS390ENTITLEMENT("entitlement", S390CPU, env.entitlement,
                                    S390_CPU_ENTITLEMENT_AUTO),
-#endif
     DEFINE_PROP_END_OF_LIST()
 };
+#endif
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
@@ -388,7 +388,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
-    device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable = true;
 
     resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
@@ -404,6 +403,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
+    device_class_set_props(dc, s390x_cpu_properties);
     s390_cpu_class_init_sysemu(cc);
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
-- 
2.43.0


