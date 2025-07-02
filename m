Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B473BC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2c9-0002rk-Cd; Wed, 02 Jul 2025 14:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bw-0002RD-IO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:14 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bu-00027U-S1
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so139132f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482508; x=1752087308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6K9mSwv/CYdnYj/oy8Qn9vjsBz9CL/OwJ6+0PwH1Uw=;
 b=nG3O7mddAbFpf42uQWfB3VJh1zPnqmohIc5PYcTtn4icnNmF4tLhM5JNtjBkiGovX5
 EIDrlRXr9E6U85I/l/xvsu3TOjCr/5vF75esAr7cR3t/4/aIo+ZvibFPWNZsVEE6OvjE
 sbU3j2HV2d3IfAukfVi8+GWA7UaG5ymIXEDZiBVteC0jcpaOaoiIUmYjvxKO7ecMnWY2
 wcL/x1+zOHrae0hfzk1+XddYE6mWFvXhv/J8bhQoTkDYgBH7qD1S8oBmtKqAsneb1Sgv
 P6jW3FoSnW5/POoUMgsEh8gr/D+JkQ/0GTlesezAaOEN+rCfe8Q8DzBVIGQ8qemXbc07
 Qj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482508; x=1752087308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6K9mSwv/CYdnYj/oy8Qn9vjsBz9CL/OwJ6+0PwH1Uw=;
 b=OM/1oZPrNJvo+ghTadprTGCb0Gcmx45VIhGnyFggsv1EpcR1pcf8S++pGnp8m3w8Oc
 i0U3aiJcSRlA2vUmL3hJ5uVs/jRwTuqGhbXidwCsWWSbSShwRi1KYY0Y1uVjfgFDsUAP
 wfhNo+hAfkcB2anwakLSlZjdcQl6Xql958WCf3w8fLLVdPh33Ef9QqXcK6DiWnhZCUxj
 8hUSlTnHWNXMSzBNcHHyX/kYk5xNRKfiMwfvTD7+ReFB+mcwl1XCTOZ5kRh+2EiLhLcT
 IX5gokyfr5fp2P9gCRpw6pMud4SxDve8ge3hxzAB/YaKryWtALuP/LWpzwh1y4Kgya55
 epRQ==
X-Gm-Message-State: AOJu0Yzk3qeqnYYY6y4RCCzgTyIUoQLY+dOXddPDBjPtZBXBKPzZMZtB
 CQkiwMxjrmPCBt9NMTlIJctYy6VpzabAHXqqaS5qr4XC7vS4GWShaiy1A2kw49F0Uy5K5FR592r
 svjjf
X-Gm-Gg: ASbGncvmIh2OCNQAicJT/lH23oxKp0Sf/MYLQepJetWUe12TxQcBLf+efFcoPXIP/+s
 7SnJKSaoA9at4S2ZpGmbBvl0vfTX3iH3/7Zz3pCX7UGI+v1EgWeGq7fqUom1BoLoyaaFfrG2DxR
 4bfycApGWL2EYyQqskcOd885egMawGEAAbI3wFR8RvMc9n0r+dhmyKyRg6NEjeTUO8FcmolPcPi
 a0tkqGw2Gwe1X4EWdE6uoyyH6Ncg0B8EgwfnPuzWvtWcegyi2ZFySF50kg+LkpIio+rLvGzKsox
 Ck0/9Mu5FeDWyTnI7yA9QBDrTPVe58oBORL/NywHGOtGVQ6cwzMIdlAFU/RrMnblupCBOGAmumj
 b8RqCaWNYVW9UZNJ5zB6j0StvyAwCIyHfw8Bi1kSvCwtUDdk=
X-Google-Smtp-Source: AGHT+IEzzMX2NSpxlPsQ1b+gUvUOHoEJg0ltNzuqMHl7tYtFJYsLby7jGahEMqpM5rnI2gJXqZ+Fmw==
X-Received: by 2002:a05:6000:1885:b0:3a9:16f4:7a38 with SMTP id
 ffacd0b85a97d-3b34243febamr29187f8f.2.1751482508444; 
 Wed, 02 Jul 2025 11:55:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5b2a7sm16819760f8f.69.2025.07.02.11.55.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 kvm@vger.kernel.org
Subject: [PATCH v4 13/65] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
Date: Wed,  2 Jul 2025 20:52:35 +0200
Message-ID: <20250702185332.43650-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/kvm/kvm-all.c  | 4 ++--
 system/memory.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index b9a9b3593d8..f327a71282c 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -46,7 +46,7 @@ typedef struct AccelClass {
 
     /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
-    bool (*has_memory)(MachineState *ms, AddressSpace *as,
+    bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72fba12d9fa..f641de34646 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3789,10 +3789,10 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
     return r;
 }
 
-static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
+static bool kvm_accel_has_memory(AccelState *accel, AddressSpace *as,
                                  hwaddr start_addr, hwaddr size)
 {
-    KVMState *kvm = KVM_STATE(ms->accelerator);
+    KVMState *kvm = KVM_STATE(accel);
     int i;
 
     for (i = 0; i < kvm->nr_as; ++i) {
diff --git a/system/memory.c b/system/memory.c
index 76b44b8220f..e8d9b15b28f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3501,7 +3501,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         if (fvi->ac) {
             for (i = 0; i < fv_address_spaces->len; ++i) {
                 as = g_array_index(fv_address_spaces, AddressSpace*, i);
-                if (fvi->ac->has_memory(current_machine, as,
+                if (fvi->ac->has_memory(current_machine->accelerator, as,
                                         int128_get64(range->addr.start),
                                         MR_SIZE(range->addr.size) + 1)) {
                     qemu_printf(" %s", fvi->ac->name);
-- 
2.49.0


