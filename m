Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D32C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Msf-0007fi-BP; Thu, 17 Apr 2025 06:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsR-0007cD-Nw
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsP-0003QJ-8o
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so427228b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887227; x=1745492027; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=31sA8ZoJNIVGckIUDC4jt2xxe297otB918AQ9sayA4k=;
 b=nmUMWWfLY4qyOfwB3TFEJCNXlqN1f+Qrqh2E0d5mVZ05z4JX0FSVYXgfZTPoJZx7DR
 MfslXuyLyuHl3Myg0KnHQu2CNxlwOA+SuhvwpRdsrBF3+g85k+//J8qoOslMJfMI1I+u
 y0sh/CzjvdKGBS0nAOqkLXQkP6Ry3yTs8B82dokD/zMs1o1oYXMDnTR2um4KsM4Jw9KU
 xRo6aCLmhbpch85nTC8uOSwfFwNDwBroagu/uPEvxcdmDdPra1H2msHauR2XTeUNgdpw
 DC24I2SVeO3PDpnhrUaGFqRpsJBG2NCffUmlg4JGh+N8oJcTNSkfH7DjfFB5NAeFZqaN
 fhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887227; x=1745492027;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=31sA8ZoJNIVGckIUDC4jt2xxe297otB918AQ9sayA4k=;
 b=nmgXAcZnwwlANqikHM+xxrH6Z7q8IwwO9q5KyI6mFFP+RU9OYQdVZXaSYXXuVzRd+K
 y3juGETcceqraehqJ8UbkZjibj1C26RuJ08Cqsrgql4Put4blFFq5iwvsD++yWb+RAqY
 dXmdwFgTqE07qTlQA2WR89WaAYAeMBh1flQVKsIz5ctrom77tEx6p3kjiOGXx+tCKCNt
 1UFnoNvLHxljurvAJkLOXpuM9J7ab395nyjF7opwULwfJKOC4Nw8j4OCtljAKB+JcAyi
 E7EJFrj5bIOXpIg3PuwWm1iKZDnGff9wzylcWfoAtwGx8yEQ56qdWOh7O3bdDNibSvxk
 Jhow==
X-Gm-Message-State: AOJu0Yx8kA/k3fPtNEKVy8IrNxhMd7Wjut0mUXulJqRTSs4cF8hVuy+o
 YWoAcuL/5y/Pg+oYoKeOz6Fe783fIp4NRLj7HLHzf+tERNYIgrK/ftN5RPgYmIR3LoDkKUdqSov
 n6Y8I4wk6WN0cTEzJTUJacfrUo37LqXD7N4BcpchHcSAfWbvomfmnCqwdGe/VzY+esoOwMw2SwE
 UE0hDGyKJkpd8dx/61D5PREIXkrMSUVQrXyw==
X-Gm-Gg: ASbGncvas07tRjEwELJ5GSnnVeZaWj5epbO5Hddt2xqBDzLSL7P70nbSWK/oq7iIwLk
 2d6wzCJcAQcco2InRsN9y3bdMP2wQH2m1KoWER8EsZ0XZgKJxRATFougyZm77E5szFnyn6KTgFQ
 oy5YOT8baQZF6loQ82P9zarOkCHNVViT20Osw6OSRkFb8DSfuUoev5LeKOUgPk/mH3yZVWnYV5E
 Gou0Lo0+LvjiGAv860lhNKfJWEKFxc7lYHWGQmJb6f8SbIo+Mw6sRa5vMD+t932oxkzaEYXDdKJ
 peg61Nn/WFL4s3nysGcxeqF49Ribs9EMlFoeBvwGcPIFg/1gZR+rQzP+FpXHpqHJRRrFaoYS8A=
 =
X-Google-Smtp-Source: AGHT+IHdsLrCbuW1aeatAFe3irR5/r1fGLXPAu4NMLYEYp6v5RXrAbLkqQgEtPEohMi9Kv46uYpboA==
X-Received: by 2002:a05:6a00:240c:b0:736:5725:59b4 with SMTP id
 d2e1a72fcca58-73c266b5fcfmr8696901b3a.3.1744887227222; 
 Thu, 17 Apr 2025 03:53:47 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:46 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 08/18] target/riscv: Add defines for WorldGuard CSRs
Date: Thu, 17 Apr 2025 18:52:39 +0800
Message-Id: <20250417105249.18232-9-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x432.google.com
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

Add CSRs for 3 WG extensions: Smwg, Smwgd, and Sswg.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_bits.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c617..7705c6995e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -408,6 +408,11 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
+/* RISC-V WorldGuard */
+#define CSR_MLWID           0x390
+#define CSR_SLWID           0x190
+#define CSR_MWIDDELEG       0x748
+
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.17.1


