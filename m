Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438FFE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvxN-0007gh-AZ; Wed, 04 Dec 2024 15:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvxK-0007eR-4f
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:42 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvxH-00075C-PD
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so836312f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733343998; x=1733948798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcqXxb9hdcFJ7l5TfHoNchwB1oNn7eM/DNMTs0fqYbc=;
 b=huji3LWFMRoMtbSsB44ClNzKogtWW4RICRcnr75VI1gp3u/bmBfB1S/OOZp8J2V7qc
 6Qd+zcA8GJGWSXhynrSp+WF1GSYxx5doiGV0K6HLEoLJnHutfDjVPg05dgrZ77v0kko8
 6FvcmIe6i2nw8f1OhJDrIxnJmMmDq+/QKUKti17I3M+SWa47v7xh5VmToiljB6e0zdDF
 AtyVh/6OEICIYPqIPjTXFlHXeAiLdHGcU5Evvaqaw/k7zVpmYk85gzQOR213EykQOmtn
 2rH0OlwxEflnm1YJSIB0Am3u9BgJtQzZWA1EoTrteKZM91XV9DubHzOnyuaROP78GEwe
 gKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733343998; x=1733948798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcqXxb9hdcFJ7l5TfHoNchwB1oNn7eM/DNMTs0fqYbc=;
 b=upRoH6UVX9VeTVBtXeQ/cylbHAmhHBAzPJGxaDHWfWZKW777mKgCfRCay1yBNrCAMf
 v5/8pFPGY2JD3F3ORA0EeLT3BGWdGQvpFdVAFeIOtpVufFDjecL3iU4wlWivCADrAJVZ
 43DzBhsAytt6Yllc1Xwn9vB9nFZ4e5RurSkhl+Qq86dLxVb38grMkHXGg6E+c8F+FFM4
 5EGHzS6/0ZRZPmeT6N+7tim95RuEYcK5EgkHGvqntQIbvtqqIMIjTTIIE7Yw7Cjk4Lwb
 5BbYHM9c46iTGvKuhwsyvjr7hXPeQ5hUJC0BnPXEXcxb7G8xCjXNYMfRwumc6JUokYae
 K3dg==
X-Gm-Message-State: AOJu0YwFi60EVM9FQagMT+RYGJdyhOZCqNKG5zt+WJtC9PXWnnNBekHV
 YgjSUPihE7bXmp20J4m9v5NrdL1j09Om2lQhErRClROR6hd6Y7rbmlLdjgmMhn5Ir4LWPaLlZTO
 0
X-Gm-Gg: ASbGncvmgCqgJRaFDjPzZ9WXWwE8ZvTFLOS3mRPvp0/n3F5o6smCL66evvKQ+2bBPmn
 rc4NsYYFUxBCRUajx1UT6x1+JkTqOq7lDNyGLDtIUu3xGR8INPHu7lquPYYqpOT7ydl9mg7gqOf
 p4ualaTLc/5oDKdbSRW9ZOfj3HlRRx7qgDofvbHPs4gsVJt++MK9dDyrydWTHoDzHQHNw10sapm
 q7X4efHq283j3hWEOgF2uNhqeYg1gvgWYp4nzNvGKCyDDZHB9zcr8AsJF/ImGXyzMaMyNMXdfrH
 Ny9HNxzOTPgfNHd/WBEW/sKz
X-Google-Smtp-Source: AGHT+IGzom8YBc2l6q0doPnVLmL9m17aIXaAPwIBHw1YDr4BhvjFN0i1tTry+zE/z0HeVpG+vkxmQA==
X-Received: by 2002:a05:6000:2cc:b0:385:f138:97ac with SMTP id
 ffacd0b85a97d-3861bb5a565mr532650f8f.1.1733343998156; 
 Wed, 04 Dec 2024 12:26:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385df74157asm16690526f8f.0.2024.12.04.12.26.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:26:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/20] target/sparc: Implement CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:48 +0100
Message-ID: <20241204202602.58083-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

While the SPARC data endianness can be changed at runtime,
we do not implement that; only big endianness is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de73..de0386dbf64 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -688,6 +688,20 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "\n");
 }
 
+static bool sparc_cpu_datapath_is_big_endian(CPUState *cs)
+{
+#if defined(TARGET_SPARC64)
+    /*
+     * SPARCv9 has a couple of PSTATE bits that set the endianness:
+     * Current Little Endian (PS_CLE) and Trap Little Endian (PS_TLE).
+     * We don't implement that yet.
+     */
+    return true;
+#else
+    return true;
+#endif
+}
+
 static void sparc_cpu_set_pc(CPUState *cs, vaddr value)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
@@ -958,6 +972,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
+    cc->datapath_is_big_endian = sparc_cpu_datapath_is_big_endian;
     cc->has_work = sparc_cpu_has_work;
     cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
-- 
2.45.2


