Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6FDCCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9f-0006ZE-29; Mon, 27 Oct 2025 07:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9b-0006Qc-Qv
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:47 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9C-0007d3-B3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:47 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63e11cfb4a9so8163296a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563536; x=1762168336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0z28648v5upStp3goElPTngqMFpsAWHgbwxGLXuRw+Q=;
 b=xDt0juC3FhSkM2G8QWu34cACJfUUH5PywrVchPt08lXsbt33JjavVn05QGhvkzWjf2
 bv4Ksgi0cuRoZBGeOUcSj32ckJ/OSAOQDX2KQFWTSrtGpjI3QnLV9nNNh5KXSJDX0M/1
 mncLpmM3o5UuLEeJtB7p1sCNHVJGaKuDgEX7RqEhN7qXUw1qZJePliW3GggZqi/1oOce
 2E4RNX6oJPrZNenEHSR8q8ECB7CWK3H/xLyWBNrmdFulxQ58hff5DhBG5XgexganfT8T
 qz4mXiIshX+Cks3wr1v6tSSkLfQYjzGLCtcH1CB0/CbvxoTzZRQ6BU//7zbnyPsF7eux
 FBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563536; x=1762168336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0z28648v5upStp3goElPTngqMFpsAWHgbwxGLXuRw+Q=;
 b=OwlUBKjZV44W7KvlD6cayT9N1D2t3atAbn0XeiG5EtRAneQZvXl5M3lPj6zyNpi5tX
 q4R27mnEOF0G5Y12XGhS68uQ4yL4awQq2kWFCElcxowHsRfrTHbB+qBgYihFpj7nWayD
 pzxFrC37gvOSylAEqJfuy6RPDj0m7AQNSTRo3dFeHweOobDg6Hv2CHGwRJhYi/4eA/Mk
 MYsVSV0KNH/YKQpJDXCdPOonAp2Z2jjrSeWmHplA99pf0VZ3fX0+u3NeLwWiLno8nVSx
 lMXBmBgfePpKi+oTXu8sKdbGu1JUoPx3DSPWMS/d7+mqmX10ltkyf3FS7YBVdzlXNAYs
 mU+Q==
X-Gm-Message-State: AOJu0Yyf8PcRKjq36yoj/y+bWDIxzSHZU+I26k9QanAEhS+Utiox9b5y
 T5aEuY95tIT1ZWdYoQNo1/3Xwa+2JL4eXl87p+CkSB9rEQz7HdNKtsAso61yC6sx0e4=
X-Gm-Gg: ASbGnctFsyP/VGQGulfzSSeELNDNPdSK2z4cZN/DFE9yt1yGfSKCxtkQ+EYd3rARgOg
 IVtNw09qqhUuuOy+diUm4X6iJ0/qy/3y5yaGIWVTGRsnPScESfdej3nDTgPlr+TqBlpn78xvNis
 RwuKde321+aa4B+43//Utujqpbw14uMRPSouh8CVg8T0LBNRMpPt4tcyKfMHiH3Ir4JOHPmAi44
 62Pg3Y2NzltkYp5t158A8XNePZKLuRsrGvSlv2o4Yv1zY6awXt/J4r69Cx6ma9k58egnGPhEOA+
 H5UNKXZAQTZS3D9zX6xDVdOhFqznqne0/Lr/4hvkPDLdpjFlgnLQaZeK9U4yHKCMiW7M2THAB5/
 P3t+l+Hn/flRaIFmB4W1joA8Io8A8GsPvT2Vhs6JkUMiOmTBU50BkZFsnqEr44akFYHzmyvucUP
 gY
X-Google-Smtp-Source: AGHT+IGtXcILpFjNKjHSXNgWZhHZOhoowu/Ap3Pe4wTW27bBFXzroSN+iJ+/t9zMqaCjNKOlNCR34g==
X-Received: by 2002:a05:6402:1d53:b0:631:cc4f:2ff5 with SMTP id
 4fb4d7f45d1cf-63e600e9980mr8555052a12.25.1761563535726; 
 Mon, 27 Oct 2025 04:12:15 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e86c6d7d3sm5603164a12.27.2025.10.27.04.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBA425F8CD;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
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
Subject: [PATCH 20/35] target/openrisc: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:27 +0000
Message-ID: <20251027110344.2289945-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
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

This change places hooks for OpenRISC targets. We treat anything other
than resets, timer and device interrupts as exceptions.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/openrisc/interrupt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 486823094c8..d357aaa7da1 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -25,11 +25,13 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/loader.h"
 #endif
+#include "qemu/plugin.h"
 
 void openrisc_cpu_do_interrupt(CPUState *cs)
 {
     CPUOpenRISCState *env = cpu_env(cs);
     int exception = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     env->epcr = env->pc;
 
@@ -98,6 +100,19 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
     }
 
+    switch (exception) {
+    case EXCP_RESET:
+        /* Resets are already exposed to plugins through a dedicated callback */
+        break;
+    case EXCP_TICK:
+    case EXCP_INT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
+
     cs->exception_index = -1;
 }
 
-- 
2.47.3


