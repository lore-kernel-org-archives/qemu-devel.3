Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB9FCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL22-00016E-Ky; Mon, 27 Oct 2025 07:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1d-0000iU-4B
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:34 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1O-0005jA-T4
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:32 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so469905066b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563044; x=1762167844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmAk21K9OGPdvmtO9tCUzb+x/HUizeGKzsfhOfuchWo=;
 b=mOhP9aUFsO4eYgckLXEVb7cZgx11BuPyaHmswlXCVJg4uTeVOCqog17x9LuCsCUZbz
 cbg6bqVGmn7uW0lP0PlRgQM/oarCUsuNXt5rFUuZp//ayqIEDUwY4Q8uzH+LSvKOxH/l
 I/K9r4H01gp4FCjFtkR/Ap98KZgVMzC9+KBH0LismLkf8lBKm3M6eJ76tl2dYQ4GOGl+
 2GYqf6t77DCX2wVkxxW4VrtmIyPoH9UT3tDNB+9D1GZF+ByUnCI38gzm3iMbggwOApua
 km/n3LuvOkNc1ZMBUrrTfs2yYjeSGgYyqXXyVZ3M+lnG3BafKuCYTPghjDVJJ8eLiMjk
 x2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563044; x=1762167844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmAk21K9OGPdvmtO9tCUzb+x/HUizeGKzsfhOfuchWo=;
 b=NjNcEVyngpw2cycf8CclDyXoD6vKZaWCLP1XvpWFc0cNLULCPrsIb4Yfwvob+G0aKI
 ajK2EEdPJ1lyUWz1PgogZH7/tXe8Hz1SQUoPtVMPTBZL1W01nMIpP2VsJSqAadZpfbbc
 3lLRz0IoUr81HgG/4eORLHWS1505g44I2Ik+6JeIMqz5FQvsvQODyXFGH46CxuiEZjuV
 j52hoABs1czD+AE6wDq1Fr5OIQr8kpGelYLa8hgLofr1wVRogXpzo0xHrRs5l6nUf39S
 1VNNCx5FvXN6GsTkl9LvF151O7mPJ44tGb8JA595Qhl3qHGwshx1KNsJAfd93iqI19AE
 2Y6A==
X-Gm-Message-State: AOJu0YydbLJIEoBOAWdj5EG27qa9iaDOFft3CY0lchRP7Ck7uSW9MzYW
 9obnBbW9fruNtCokWYOTKLLw7FuHgKinzcI/q2IZqdvhcjhsE8ncVlmCirUmasDbRGw=
X-Gm-Gg: ASbGncu9UXZGNQKh3nJlR76sZBoCi6h2yFfd91Q9+u8Z73+wy9yCMyYZeaBdhaG5yrS
 qVtizrvLia9yZ67dbx1znPxqJw26zxRdsuCoKKe0gMIrD1STH05am5/vh6SFA9MHiA0vuEEbwx9
 UgZk+IkTX2KITjTa1UUFPq27X/IXBpPlZKPDaqnupcTwMErBdOoQIwXsT1ZAM7/SP1dQip3e0Bv
 1V6a8qgi2alo6fi5t/Cctp4KeJXCcDw/qiCyjuBm526Tqhiofj9zS0fNE8kytAIZ8+6H5T8zw04
 ftw8M0+rjcxl3zVvcSB4GczYIRNHTuyJwfOUnJdIKqNcFbgzHwQ6euWLTvmuNleixobjeGEhl8F
 1sBZcbxBJy5Vmw++JupKiVK+YdqL4aqa/kc6w4LaXwYst3XbKoXPlExQfbxLxp7/m/PfmlpLv34
 qe
X-Google-Smtp-Source: AGHT+IHjNGOYSB3Uoie3aPGzFHTm6SS3tVoFQt6o3B0HAd5FWBxEzFE3cDSEV9z7klyWAfsDpBXRwQ==
X-Received: by 2002:a17:907:9691:b0:b64:6776:1ee2 with SMTP id
 a640c23a62f3a-b6473f42d78mr4014852866b.52.1761563043587; 
 Mon, 27 Oct 2025 04:04:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d854395absm730117966b.62.2025.10.27.04.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 891FE60F68;
 Mon, 27 Oct 2025 11:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 26/35] target/sparc: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:33 +0000
Message-ID: <20251027110344.2289945-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for SPARC (32bit and 64bit) targets. We treat
any interrupt other than EXTINT and IVEC as exceptions as they appear to
be synchroneous events.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sparc/int32_helper.c |  7 +++++++
 target/sparc/int64_helper.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index fdcaa0a578b..b29f693a6bf 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -24,6 +24,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "system/runstate.h"
+#include "qemu/plugin.h"
 
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
@@ -174,4 +175,10 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         env->qemu_irq_ack(env, intno);
     }
 #endif
+
+    if (intno == TT_EXTINT) {
+        qemu_plugin_vcpu_interrupt_cb(cs, env->regwptr[9]);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, env->regwptr[9]);
+    }
 }
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 96ef81c26cd..60ab0478fc6 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/log.h"
 #include "trace.h"
+#include "qemu/plugin.h"
 
 #define DEBUG_PCALL
 
@@ -256,6 +257,15 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     }
     env->npc = env->pc + 4;
     cs->exception_index = -1;
+
+    switch (intno) {
+    case TT_EXTINT:
+    case TT_IVEC:
+        qemu_plugin_vcpu_interrupt_cb(cs, tsptr->tpc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, tsptr->tpc);
+    }
 }
 
 trap_state *cpu_tsptr(CPUSPARCState* env)
-- 
2.47.3


