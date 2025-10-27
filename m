Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D7BCCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9j-0006hm-Jx; Mon, 27 Oct 2025 07:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9c-0006VH-VL
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9D-0007cA-AZ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:48 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63c09ff13aeso7714026a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563534; x=1762168334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99wY+4qgow5/XXKtFXSxRzQjqRZizwoEw9ERNRXbkf0=;
 b=y1s9NCkigk50JZDbj1DlK2PjS3XKZabSJqRNhbKz7LQrbY1oFI/VPBr2Y3MpI9E4mL
 wu9GvMvtZvpVONga522a3tqFAaLckYygoe10mN8ZYUnjhovDKVs1sR7J/VUagYAUm+FX
 L0fugHo51Q7uabBN4aYDzMGjIm48GhyzeSfXuI49v2KficbK8M4h3luhmmMBbySTUdqJ
 FKxlPkcqV467fAd+lXSFdpy3DNOmzSXFGAWYl8dj5T6OpkNg9QPgePPOBocdbRRcF0j1
 Ge4PsFCwPFp2N+5Z+L7r/ozuej3q4RUJXMezvG9p3r6mWr0sw1KD0h1f07EjNYyh4vvg
 1Svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563534; x=1762168334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99wY+4qgow5/XXKtFXSxRzQjqRZizwoEw9ERNRXbkf0=;
 b=mHiLlo8UZIkCVBlTAuiSUzdnrDIZeOfsNK/SQyCNnGHRfXe4qfsZqhb7OSGIektits
 9nhZTsXYr6gw75j/apdGAzV5uOO2tK6cbch9JIC1xY1kBmVDFh00mCl7UrjhE1tn0Der
 7oH/U7+qNsuJxY26z433/o2u3wbkO9tkjEEh46AB3ujeGmxlEF7TH/Mm9HOMoO5NL5uo
 xLleDKm7j9bEaTis/gwTOopOcIbNMl6pvlpkWdl8FywDVFvZT8iDsBeRmmOoxKPIu6fg
 DwWI43Pf+rFHuLqoBpyv/A8928tpq/C7i29lME+1Teb+CdMqqaWR4/CLj4VkD2WFuqrn
 MTcQ==
X-Gm-Message-State: AOJu0YxzKNbzCYwpQF86A7YYMxan4gDk2gmNHZ7vBVssNcfYvJA4NWLc
 1FMY1KHeeqhxL0uVS6hvlzt4/JOXpuCgkbQWIwJ6S153H00i+DdslFYzJzkSRpKYGL8=
X-Gm-Gg: ASbGnct3PHSwdYvuxDaA1xA1UuvXwywNhj3vseXpwS2ADjN7ijGVDdlqzWLd/MoIxuX
 H86ZZ/FH2LNybr0yCFK1v/gO/0sejc+fv4OsHV39dbHfOGOiXKI57ronCy4rzdCzp4OVZQ4ljch
 XT6OgL2scvlMEg0qJdpkPer7jQh1tlAaMCTZQj9kzHQlWMuDDizpSw+5l8bLfVTCy3oTgTgrEWT
 cJPtNrBZE/Dkox+eKlf0UBCNHoc6APBhGD5Eo3n8XZ0JX9Nec16/pP7J/fDI/0+XAsLMSt5x8/p
 atll3kZ3ipqLhuNYlb1/OqSOVGLg9Dww0npPH4UvwAmgWDGVRLW6xRTdUdXiJYUnE4HsaDnsRAD
 sQ6U5ftyx1TTPIA/dE/38oVaHaWmim1zcvohN8BJMHo6MG9DG1drh3GynEkxZXhugVo59djDnwu
 nj
X-Google-Smtp-Source: AGHT+IFAsNEZ+YI0fTj3+OVyMqueS8NODeiYMhkciUB7twUSrCCRe95Tk7Kfy7cqzVEbD+wz6+XjSg==
X-Received: by 2002:a17:906:fe4b:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b6475a0347bmr3777669866b.64.1761563534193; 
 Mon, 27 Oct 2025 04:12:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853386casm723218466b.15.2025.10.27.04.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6FF7F60F51;
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
Subject: [PATCH 25/35] target/sh4: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:32 +0000
Message-ID: <20251027110344.2289945-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This change places hooks for SuperH targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Signed-off-by: Julian Ganz <neither@nut.email>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 3b18a320b86..5d6295618f5 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -24,6 +24,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/log.h"
+#include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/sh4/sh_intc.h"
@@ -60,6 +61,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     CPUSH4State *env = cpu_env(cs);
     int do_irq = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
     int do_exp, irq_vector = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     /* prioritize exceptions over interrupts */
 
@@ -176,12 +178,14 @@ void superh_cpu_do_interrupt(CPUState *cs)
             env->pc = env->vbr + 0x100;
             break;
         }
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
         return;
     }
 
     if (do_irq) {
         env->intevt = irq_vector;
         env->pc = env->vbr + 0x600;
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         return;
     }
 }
-- 
2.47.3


