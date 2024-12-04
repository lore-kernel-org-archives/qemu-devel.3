Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF2E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvx7-0007W2-8F; Wed, 04 Dec 2024 15:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvx5-0007UQ-0h
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:27 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvx2-00071h-FG
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:26 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so174399f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733343982; x=1733948782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhKSMfIut/lDTwvjTF8AW4idKBvUZ60ritdW+EWnr7g=;
 b=gvOyf5t2epwIy3CQvNhQBPbIs2QT0OCLdG5TB6sIRX7CqUAisqIkGeUIHouTdo2IeW
 fbqmQ2uZLqUYObH9kMMTFYCYiLeN9PpYcVVmKYhN6BsYqdGffFg9F+/hEHr9MMI7ifc0
 Kbnc7zP3ETRX7/ichdZKr9u+F4YB4CK4HzobDUVWXefcrQUzO6c0KUbx237oVj7xG9eY
 98ZUD3QgJptFreeCWoW1BS9cuNF4yIFchPsRoOEVLdEqP75pOSsF+CTkS24O5y+LmDcK
 VBa2J9UILy5gfJ5Ln2X34F9rT8VBzZgZWhrlT4Qj51063gJO1tK+iRc4326enjpKgfav
 F2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733343982; x=1733948782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhKSMfIut/lDTwvjTF8AW4idKBvUZ60ritdW+EWnr7g=;
 b=syIaGrGbngsTtp8I2MfOcyC16QLgM447EOlEJUb0ZD4aoxvJP1xu/7VZhDnlb22M5G
 ieQVrvzEMxfpyp+Ulaor2u8linieXBJ36463vfJxiCvHl/BmMqfULH6Ymt6Gdhoa5k41
 MI85j/oKY7x4DFtXerXmE5V/XBzcsRA5YdQvqjiCOnd7TqmOfigeeGI9DPcjHT9bMMv7
 6PAH0Gj/sBsXHlrCFSJQcYSTZe0tk6VN0GrRaBJulVV6KneDSPrvDxbpoSHyuV0FtMhu
 j1Nd5XOE7tEGRmG1UBFlaCDOoigAeSw5DGFknXtWEOHkcb6KhNhEO8cp0LXASTJZf37k
 8sMQ==
X-Gm-Message-State: AOJu0YzSF+2ZbqBb0rsgjnB0grLVum0TneQCeyZS5vl66nFgRgeFhTzx
 RjO+tm14L093QqsWdTqyqYKhxqFJlUhFuEPnqEiTu3vzrQEvY/F9UFyDm5Tbxzga/qDbLJtWkq5
 k
X-Gm-Gg: ASbGncuJCaycRL0OMaPFYUlubuR/KH9GXDKNLx2l6izYGt7lyQyMy9ovfQWfhsnusOP
 MBSnaxMmR4Lsmlax0v4DS29G4kRIalAH39EEmZmCtswwUFbXG9pawKRLitGf3AL+X/H0hKKpXCH
 GYTLW350TUmwiET1O5E4m+csqUAX1Q7Q0dOcdo8p+h81anW0KJA6wUx4s4OGb7TdxiNrH5IdH4d
 p7Q58xIPZy9EAez0RIUX7k50+lw73YL21HWeLMsD+jK9ZMen1gZWh3VA2o/9ezLcUP08etjVYhW
 4IlpPB8vZbpKLwbFBQOmXUJb
X-Google-Smtp-Source: AGHT+IFJ+SOgmlgPnyukKmZpFbfdSn4zZ5sGZ1LRydSUp9JlgocOPOE3nd3fyAnpHvKcXu5besp78g==
X-Received: by 2002:a05:6000:4411:b0:385:ded5:86f0 with SMTP id
 ffacd0b85a97d-385fd3e797bmr3942400f8f.19.1733343982632; 
 Wed, 04 Dec 2024 12:26:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385d7611af2sm17657530f8f.22.2024.12.04.12.26.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:26:22 -0800 (PST)
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
Subject: [PATCH 03/20] target/arm: Implement CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:45 +0100
Message-ID: <20241204202602.58083-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

arm_cpu_virtio_is_big_endian() already returns whether
the data path is in big endian. Re-use that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b954..3061b2ac18c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1132,7 +1132,7 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
 #endif
 }
 
-static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
+static bool arm_cpu_datapath_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -2664,7 +2664,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
-    .virtio_is_big_endian = arm_cpu_virtio_is_big_endian,
+    .virtio_is_big_endian = arm_cpu_datapath_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
 #endif
@@ -2709,6 +2709,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
+    cc->datapath_is_big_endian = arm_cpu_datapath_is_big_endian;
     cc->has_work = arm_cpu_has_work;
     cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
-- 
2.45.2


