Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AE6C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7LG-00013U-FN; Fri, 15 Mar 2024 09:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7L1-0000LC-12
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:07 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Ky-0008UE-3L
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:06 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so7099441fa.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508262; x=1711113062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9q6xaVyoPJIMQfl186LF5IP9vgj5sXw3ui9Yz0YXC2Q=;
 b=TMVOa6AS5DHcYj9w4EjFpStIyqMpbkGn81Fb5r7+qlYyQ4rTH+i+rSeLABMphE+KLN
 8Zao5q1pbPFsXliXcmAMyRqM6/W+iBlnktK4DvSz6Is9eElfCqt6N0rxUZ6GXfTDGent
 p+oJjqjfasjEUcD/J2jrd6JmA5wyD6mAhYebqHmsc2fQd+1GSe4PGghlP6tWyc5DAAwQ
 WCJHKy32JsDYdxb1D8clU3ws1TSBnI652+pNexEzEnFoOzyzj68k2KkQzDp66anCz1ib
 a2q26oyfKaBKfJSl/sWZwWrlAvBfS4EIs/nRE8tlC4fw3vAhS1A+xeXAGr2aOLPwzj/q
 ilWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508262; x=1711113062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9q6xaVyoPJIMQfl186LF5IP9vgj5sXw3ui9Yz0YXC2Q=;
 b=bxOEOBysOmNRDl6Hr+dCiHYGNwnxKk/veOg0SnX5HVGtfBmU03zObsUcLfJ7o84tYb
 jRf2aLXFnJw1QjBnP3FdxQL0mIIYUpvs8znlFL6cV+7937KZD0F7pgEXZsrqMw5ucBPS
 +vKNY9zh3+qz2KWCehcm50rrJ8LkNSAvhXiXo8fB9oUSlrUcd2u1s/v6b7A6zUGXZVT+
 AUITwPMRbmB1FOAo+d6TOYvAZsZ9Q0gp4ZqTc02OPgY7d9ad2/fGLl4eM4EawHujZ9U8
 y39I4J1jWkYt4lP3xqHURHNyZ/rRiklFMAktSq4AC09rk9GX/++QAuZ0/JLcrgVO/EDJ
 HyFA==
X-Gm-Message-State: AOJu0Ywk303jt0gu7O0AvDY4r1kySdDld22xgLFhat8ALICrPXIXpVoc
 zZasMcfOkDEG2Mz998Ro9Py9XRAMYVY+pcVY36Sx7sBXJX2rKbwtC/eQwJCPMOsaVK4Cpnq3cEB
 K
X-Google-Smtp-Source: AGHT+IGug9mMTyD+ClS5FiGdRLYqtGhTbiwMx2zP8ulnJSipWbsuMSAlqPeuMtp7D26lqxqXlTB4Zw==
X-Received: by 2002:a2e:a9a6:0:b0:2d2:65b9:b420 with SMTP id
 x38-20020a2ea9a6000000b002d265b9b420mr4153813ljq.1.1710508262292; 
 Fri, 15 Mar 2024 06:11:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 d4-20020aa7d5c4000000b0056711540692sm1656538eds.79.2024.03.15.06.11.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:11:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [RFC PATCH-for-9.1 16/21] target/loongarch: Use QMP
 generic_query_cpu_definitions()
Date: Fri, 15 Mar 2024 14:09:04 +0100
Message-ID: <20240315130910.15750-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/loongarch-qmp-cmds.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 8721a5eb13..ef5aedc1cd 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -9,34 +9,15 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/commands-target-compat.h"
 #include "cpu.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 
-static void loongarch_cpu_add_definition(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    CpuDefinitionInfoList **cpu_list = user_data;
-    CpuDefinitionInfo *info = g_new0(CpuDefinitionInfo, 1);
-    const char *typename = object_class_get_name(oc);
-
-    info->name = cpu_model_from_type(typename);
-    info->q_typename = g_strdup(typename);
-
-    QAPI_LIST_PREPEND(*cpu_list, info);
-}
-
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *cpu_list = NULL;
-    GSList *list;
-
-    list = object_class_get_list(TYPE_LOONGARCH_CPU, false);
-    g_slist_foreach(list, loongarch_cpu_add_definition, &cpu_list);
-    g_slist_free(list);
-
-    return cpu_list;
+    return generic_query_cpu_definitions(errp);
 }
 
 static const char *cpu_model_advertised_features[] = {
-- 
2.41.0


