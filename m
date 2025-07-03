Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B001C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNr2-0001CV-Ec; Thu, 03 Jul 2025 13:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqm-0000sH-7p
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqk-0001qA-D9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453643020bdso627105e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564152; x=1752168952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNEz7S5Pg2QTsssvmOiqXSpVHK7X0tn5k6hlRokSPQI=;
 b=w/eavJLJZwdFiYkEwjcIP8pYqWYLsXG/ueSZ4VEsa0wC9tx7stdCtH4HPESYNi74sF
 bXeBOalQ8aHlI0rPYnsRHpkdAUsMpz04zETFPSFJj+Hj5r/chLnYtfp1PE/fDofwWlp1
 r1niDxlHrUnkpaMyXjl/oYqN9RaJqRY//n+0Z5jGqy1aIGR21y3+DZFAFyOuyQgCxR/5
 LyAKw3yJZibJuEkXJ9cU/5QWas3nmd7wDSfTi46lFSMSeK5EIp+kf/7E8xfbR9UHeK+e
 XhrjBYEcw+FPpUuX5LRuMMbuT5pJ1Nw+ZKZ8H4OOjAx9D5kM/ffq4t1Mfc+W9xqO9fcx
 SSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564152; x=1752168952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNEz7S5Pg2QTsssvmOiqXSpVHK7X0tn5k6hlRokSPQI=;
 b=ZkzzPvHU5+lNItO4QfoSkhio98+HAbXuo+VQ2JYg5x+mVZReBLQP0KhPswSfsfgEaC
 iHVdmJSHGLMQkdeVryDAPv4j9ETnFiMYX/JM+dmCSccDdv2AdywOZPu5KN+p3OBUxxL4
 bmMLOhwo/H6UG3ms46ZeoLzusOLhb1QS4OqMyZX0wFbOGH3Mymk2zscPyqTG3Yi2WgOO
 T5t3sM4axJ3htE5vcYS4n343cEMQiPUY8D1PxTdGGkBYGDoO1QiLawoqPB5MrV2tSGMk
 in7ozdMZtABqqLrM0uyfxKNDp5SR0yjBAwYSnn8ba/2tM9fPekBEqeIPSm30YiEHtWnl
 NGTQ==
X-Gm-Message-State: AOJu0YzN9jWcpPA75kWTq/6ys0HlTrRcjf9oGEo1jjt9sBPLfqalk/bp
 OtEOsP7LwkyvwYXVQ0eSETQ06twW2+4nigwjn8G6LUj4UFZT/Dm2l7K+Vy0e/qU3xfHJBHqoNeN
 gZrIhu+0=
X-Gm-Gg: ASbGncuOUreR0N5eutk1GkLFHEB0XDWY74o1Mnr4/WISxxpIB4ENDFir5yNqqz87NAr
 7qLxd/HjWIV9OtMnJZb3eDOLsEIwVqnsNDHbrcrjuwEj7bYSp/NnmwMTXqUXXlgJUXTsDwOKaY+
 5nhPZMRCys0q+l626Xa1xw8zVzYcHp13umpT4Md+65k+OyXlTkeCnLfvNMlcCBkC9GiQlYUAVtX
 uamxwCLjxX8HB6OiDl1ugbzNUD6cIf7bSGGmjqdRuqqne06qR0Lt3D1SMCnbp6J2sHfIuCvEA+t
 pZVGAfB/T+CXr/n9R4DuQZSGi83Mrd5o4LNxibA1kenF2YVangnkFWbgyzFfVVTbiEudlSehUN6
 bHGBuR662WNZRdI7yBGWOHEmX93YctH0s7CR+
X-Google-Smtp-Source: AGHT+IGG9cwkbptc5qjJh/iBIUTkTEqak4gJcRB89ikAjNxYhsBkJvLXzAiMyUL0ZnaTv+toNbITUA==
X-Received: by 2002:a05:600c:1c0d:b0:454:ac5d:3919 with SMTP id
 5b1f17b1804b1-454ac5d3bbbmr36513685e9.2.1751564152351; 
 Thu, 03 Jul 2025 10:35:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e367sm32048195e9.15.2025.07.03.10.35.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 kvm@vger.kernel.org
Subject: [PATCH v6 33/39] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
Date: Thu,  3 Jul 2025 19:32:39 +0200
Message-ID: <20250703173248.44995-34-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
index b040fa104b6..44189b77daa 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -46,7 +46,7 @@ typedef struct AccelClass {
 
     /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
-    bool (*has_memory)(MachineState *ms, AddressSpace *as,
+    bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
     bool (*cpus_are_resettable)(AccelState *as);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a6ea2c7f614..0cd9b2f29ab 100644
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
index 4f713889a8e..b072a6bef83 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3496,7 +3496,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
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


