Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939ADCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckw-0005US-PS; Wed, 06 May 2026 09:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckt-00056r-H4
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckr-00089j-C4
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48374014a77so76873235e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075855; x=1778680655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W6A7GgrsjueT0xS7mHR1GVHfsU+Z/AFvXxLf0nDYqIU=;
 b=iyV9hyKC/DJUhdCMvYxqBO+lOaLdwPSaJ+XC0uQLl2iEercUspfAZJQRxTw1UGZEUu
 paxoGNNmFSmi4A4p14opGK180KDDA1hdubO+fp+2/43F2fpWkogr364nvRxTTooOb5s/
 2yXHGpxuhT1nAXn4p43bE9rRTsLgEXoswYRY+SjIBcUBQhwpJlslH6gnV7zGBM48N7ZZ
 mni+dbM7FhYwz2Zw+tsMPw5EX00UCDp7Pmp5ZsgPv7AH2JOVNfSd7PK0hSPTrnASvNs8
 0V3f4GIEgrmBN2iwvapBd1SkTYYik6TXAtJDawzjjyMyCB71piF76CO8Je6fx+7jqhUe
 A9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075855; x=1778680655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W6A7GgrsjueT0xS7mHR1GVHfsU+Z/AFvXxLf0nDYqIU=;
 b=qWaVj0FKybKPPdX6UPJKQdd5PW+zWTylKPe2bvoHbMeQVEdGByYcPqvC4el1Q5znMB
 +Lu0LE1uFr5F/xauaM7VZXkwvzyYH32ni70H/Azbg8GoUXuPbyOtrwgH8FHZoLUNHpWq
 wCeGwGHUah63hfxNQA9KmOj4/h/Wsgui0xkzu+U+DPRbqYlomjjyjDDisV+AvRPOFgV6
 szf//2daT0hxQo60txmq1rej9KB/W7Bm8Gpx57KSMENROXFEIdLtT3nSemksUjF4WY5O
 lC0VbGz3erJeMb3aallBdCTR2IMkJnlilkTYPQgDhhsB1CZjPe58sVLK5ZmCUZzx2m6P
 EVcQ==
X-Gm-Message-State: AOJu0YyFq4AHFDwU/rEYmB91agmXKzQ7w7SrrV8aICut3D7D9IicEuQ2
 MMgrkEen10xnIiZex7QjTKyqZMduX50wNYd90tF0Zl1EhkkeFT5jC5jT4SbW+L9LaqrMSzoPV/R
 NXGoyh6s=
X-Gm-Gg: AeBDieumZVNDsLwZ2h8e1MoDtqkkTpRBdPGXeWBXVJCqnhOE8F8+tiDbRO+uFypKXPR
 ZI+lvXpkZ724objl2CpAnwXMszgdRowGxQKT9d/YruUNlP8iFMHGpHf6g3rNT3h0eO4uJs3yM07
 Gnw6uqtswyXQs3g3mf6AQiozks0lBWhtLUtx1qH0MYBIG/j/KzVsdF7RY3iExYOiiVQsXS/eqtL
 czY1xwoDKcgYyEkOZADr+5J8w6S8ktSPLMmIp/TopjUJ5xreFRSTJQECedP5QvNZaia3691vCFU
 NbrOwFqWfVN8DWlufXsC/4/Znldd/y9cEDRT0cPYlnckZPxcY1GuTc5WJ/dlz1d6bHnCBalEXWR
 awGCaf43eaK4x7l0fqkf1/J5zKvAJarDYW7NVTqMuNog02nnTna/i5NJZRhpGcjPdrvlChCeSUG
 VzaHNayvLQN79dIcyee2/DN0u/F5R23VrZtmjrXGiYxMu20uqJ4+mWVBGpkds7w80x0vPk7v698
 G4gMkw8oD8=
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48e51f4652fmr64624515e9.29.1778075854578; 
 Wed, 06 May 2026 06:57:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538c4ae1sm47066845e9.12.2026.05.06.06.57.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 017/110] target/mips: Free mvp in unrealize
Date: Wed,  6 May 2026 15:53:49 +0200
Message-ID: <20260506135524.20617-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

We allocate memory for cpu->mvp in mips_cpu_realizefn(), but we
never free it, which causes memory leaks like this:

    Direct leak of 24 byte(s) in 2 object(s) allocated from:
        #0 0x5f9458e61c8d in calloc (/home/pm215/qemu/build/san/qemu-mips+0x4d8c8d) (BuildId: 4153e33b3d08657a71ce2a04a82d0c2954966d9c)
        #1 0x74761891a771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
        #2 0x5f94590687aa in mvp_init /home/pm215/qemu/build/san/../../target/mips/cpu-defs.c.inc:1037:16
        #3 0x5f94590687aa in mips_cpu_realizefn /home/pm215/qemu/build/san/../../target/mips/cpu.c:489:5
        #4 0x5f9459366a3a in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
        #5 0x5f9459380a49 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
        #6 0x5f945937bace in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
        #7 0x5f945938816c in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
        #8 0x5f94592cc100 in cpu_copy /home/pm215/qemu/build/san/../../linux-user/main.c:240:25
        #9 0x5f9459309931 in do_syscall1 /home/pm215/qemu/build/san/../../linux-user/syscall.c
        #10 0x5f94593058d8 in do_syscall /home/pm215/qemu/build/san/../../linux-user/syscall.c:14422:15
        #11 0x5f945905c73e in cpu_loop /home/pm215/qemu/build/san/../../linux-user/mips/cpu_loop.c:124:23

for linux-user, where each new guest thread is a new CPU object that
we need to destroy on thread exit.

Add an unrealize method which frees this memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260317175031.3035740-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h |  1 +
 target/mips/cpu.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 42c5ca89154..efb6a6df4cd 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1225,6 +1225,7 @@ struct MIPSCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
     const struct mips_def_t *cpu_def;
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 789ca188b5e..0663cda0036 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -502,6 +502,16 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static void mips_cpu_unrealizefn(DeviceState *dev)
+{
+    MIPSCPU *cpu = MIPS_CPU(dev);
+    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
+
+    g_free(cpu->mvp);
+
+    mcc->parent_unrealize(dev);
+}
+
 static void mips_cpu_initfn(Object *obj)
 {
     MIPSCPU *cpu = MIPS_CPU(obj);
@@ -606,6 +616,8 @@ static void mips_cpu_class_init(ObjectClass *c, const void *data)
     device_class_set_props(dc, mips_cpu_properties);
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
+    device_class_set_parent_unrealize(dc, mips_cpu_unrealizefn,
+                                      &mcc->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, mips_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
 
-- 
2.53.0


