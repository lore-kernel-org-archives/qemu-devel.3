Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ED3C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcBL-0006pK-Rb; Tue, 01 Jul 2025 10:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcB3-0006TP-Rk
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAw-0006uU-2E
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso21787835e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380891; x=1751985691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXF6WGGmmwy/yt/TE6WKliMeWMxcd7vOuV1UqDr79LQ=;
 b=gJdJwos7UTphOKhtxgPWZdMinZTZhaXrj9P6Mn96zL+kHgWVAUw+j4DbNzDtNxZ7C8
 mqOrHEKP39yOOpiLRUrteYrv0NAzCZcwEFUg8r4DgoKaoio5XDtvfFMcuMXEtOL2/n0z
 VA88MyBdCJP9YKvX6M7tl50qV8KQgM9xrSj5oWPGWreuRCT5dRh1rW3Ln0nu0UBfG66b
 dVEYZ4g4F/CL5rDx3jVVl/cmlYmfusLtLhnjriHqQfueb0qM65lg7ROJ+ieLVoc2o/A4
 e+KDzBt1Z0ZUr4CpdhFfQCmQeKkZeelqWxV/Bczn2DcamacwIljO09qSHhKTJ/Z2s30N
 RYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380891; x=1751985691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXF6WGGmmwy/yt/TE6WKliMeWMxcd7vOuV1UqDr79LQ=;
 b=M7jQJtSg4DJRM1eU2tqsadz+j0+dDH3nckEFoQ43hL7YPnxbXgU6csOglJgSgQNbH7
 w09ZuJj4UzQmUj8cVLiFvJDTi6uqATVr2gIDoZHFDHvYbQ6lIVjNHSgksyJehGX0Mqdm
 bHMnhaf4KZ05wXyjf3Q2tmvC7V98L3X07z7+Ohs2H3RFjlR4La8Y9tI9RnwpMh2SszU9
 M0WBirKVEMB5DktqauWjYYxfyYpT/qXq0S1lVtlwtwZaa7+FB067UxcItli4cg87/7u/
 NFVzFsQCjpyQ8enL4wQliOzyCWFiM87IoFy+hnOYkkmEaXFCGUG9GaMJcoEPc7WrfLd6
 d7vg==
X-Gm-Message-State: AOJu0Yz30GTnHLJx4OgYYYKgzPTOzP4+e2hRwqsebLYHyWfe15pv80Dr
 fFaIn6zjI0kZLEWWkKskJPxu9n29l/qd3rM8FoSy+EdCGhnV7BQ70ZQ1V7tOK7MtVJCqRVGHhmW
 9pDRX
X-Gm-Gg: ASbGncuMRMJieKZKLlsdeUclYmZP5nXSIVJvkFV7rWJnyiM2FdfiW7hOy8EWAxYXIFL
 Z4MOPi+hkzK7yQCJ9KaZ6nkcTN7QryAArKVS59ymToZpqBJIdJqQ+R632orE8XN4ADeDqNFa/rk
 sdXZNaavINuDRzvIq5ymTrRs0No04MpbEace6ZMhbgJEU2KCUods2XnnL+OzzcarqTunjwSXZwg
 HS+rQFw83mDxJpzZNFt7mSQtP4kvNcalcL92nWvQPIQ+6buv0betdiDNnOe+NhbnVibqCSaeBmE
 KLOwXilvF/dD6ykAqZL0/uE+kYW128TJrw2vwnsr3Ejg3YcBFV5RjZJcHPmd12+BXtqhM1iyRjH
 c2zUcvqaLuRB9JEPLLbT+exxF1B3JMkfhfPeq
X-Google-Smtp-Source: AGHT+IEITtpWbZiA9JDh3WDYl7w7vzNGkQdrQhwe8qf2qBM7DI3TMkXY/yvEDPRQ32Be/Aho1pAsew==
X-Received: by 2002:a05:600c:4e52:b0:450:cfcb:5c9b with SMTP id
 5b1f17b1804b1-4538ee2a8cbmr153061925e9.1.1751380891020; 
 Tue, 01 Jul 2025 07:41:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c0812sm196534185e9.34.2025.07.01.07.41.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/68] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
Date: Tue,  1 Jul 2025 16:39:21 +0200
Message-ID: <20250701144017.43487-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
index 72fba12d9fa..d56ac2a058f 100644
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
+    KVMState *s = KVM_STATE(accel);
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


