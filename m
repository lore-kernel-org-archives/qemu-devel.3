Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C58C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFK7-0002df-C0; Tue, 08 Jul 2025 16:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEJb-0000oy-Jj
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:49:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEJY-0007e2-8a
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:49:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso3608178f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752004153; x=1752608953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycwknzCngZdet5bhLiVa2iCoPjVKd86Y64oKSJ8ora0=;
 b=EjsdhzBH6qiQCPf4ILRISiJR5lPSbyxPGNaVFPLhv+xLpbCWxap8APmDOaiBFrZ/RJ
 Sw/Ae4eKYqbn0HbZtt1gnRR6uaOiteG/0IFhu1GS233aNztFBdr9KkEWde250ew+/L17
 Rx9WCpZav6w2mvif0kuXAVAeGL92h0be8n3gNVgrYrQX24Em+6nZdAxDqwHEzFQrdS+B
 829Tymv9L/I2SwulPvteBKPKolHTyQqQsXgSXGHWc1kPLyhXGcD/BP25bdk/NyYnVa30
 OoOWRJZQyEmdoCPFr77la0YqnXHkPfebnfP65/uDTMr8pI4G2yZtmlcjgHuWtIa0JMMe
 DDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752004153; x=1752608953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycwknzCngZdet5bhLiVa2iCoPjVKd86Y64oKSJ8ora0=;
 b=DGTm9W/u2/cKdNBuq43dH9780+45ZDI4vv5iwrYWLmDLmRaUi6SalLImeO78yxcben
 tYJOctuNXKlol1EwdcPnYNf51OeFYLJXSsm/xCanqrcvlaCrddIi2gcrt6ahICaMJ+m/
 2zapi/hkJIUUmLCBLsyL+GJslB2ZQCHUJTSGDkEVj3sDaKlCjFSRgC/QAD/J8PYu29jI
 O5C2TbvoOFDqDOekGRFkaAFeVqglO/uXcPr8HuVKkijnPotxUSIA+LxNSQVy0J3WNbyD
 PnCyM/8cw2Hx7CH17NgN1FdF3BMLHR9pLLwNafcIX2qJb8HRVVQbmd6I8i64KxdvPi0E
 jbsg==
X-Gm-Message-State: AOJu0YyAffWugPc6rHovmYSeowV6NhFu+0tvT9HMYo4AkcgFxHQT1xcJ
 2mmMwtCfG7HcG565RpDNIQk4LpgqNpTDGNk4Fu9fRjz+A0S5d6Liu8Jol/vsTVK4P0qiVgy/pwu
 SJkF33Zk=
X-Gm-Gg: ASbGncux3UzbIJqxSKAIJ2o9TlGLHOl9uioY0lLPYoUPglN2aD/sgyWgxfHxMS147wG
 1gR7NFkfeZqkoiTc1smZuALKBMwgW9spwCGlHH459zqgRzBhu0HuRPSrBq1X4BYKjG+j4US8+ST
 rAriPK/FW3fQ9AvkH1DcCEF+yuz0GetVlauBBjDiKion7brvexVhyMl1yejoxKa9QXVetOTvJJ6
 4ZJ8po0/0A8FxWqfujuQz8DYNKKZVBzyjPbWg4kaoFqrTTwdhec6878gY93MbnRbBRI7xVqjBBs
 xJVJnR9dOshoNE2lzZ2L9jIv5oZQySVt3L1ZWbDFXl2tEg6rXwKdJwlTgp06T2EfizcqPrPZ8KE
 vOu1xW/FhVWtSomO4/2npX9VRpsqjVy+2n/GA
X-Google-Smtp-Source: AGHT+IEPDjL2hmy7kOoBvtLFEqJEwL31ue01+/iFCZqr/1aIiZstTgRh9S43FxBZoXmNZSFZ+V6Leg==
X-Received: by 2002:a05:600c:540f:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-454b4e85deemr154571915e9.14.1751968682660; 
 Tue, 08 Jul 2025 02:58:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd38eef3sm17502655e9.2.2025.07.08.02.58.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 02:58:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/s390x: Have s390_cpu_halt() not return anything
Date: Tue,  8 Jul 2025 11:57:45 +0200
Message-ID: <20250708095746.12697-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708095746.12697-1-philmd@linaro.org>
References: <20250708095746.12697-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Since halting a vCPU and how many left running do not need
to be tied together, split the s390_count_running_cpus()
call out of s390_cpu_halt() to the single caller using it:
s390_handle_wait().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 2 +-
 target/s390x/cpu-system.c     | 4 +---
 target/s390x/helper.c         | 4 +++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 145e472edf0..56cce2e7f50 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -239,7 +239,7 @@ uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
 /* cpu.c */
 #ifndef CONFIG_USER_ONLY
 unsigned int s390_count_running_cpus(void);
-unsigned int s390_cpu_halt(S390CPU *cpu);
+void s390_cpu_halt(S390CPU *cpu);
 void s390_cpu_unhalt(S390CPU *cpu);
 void s390_cpu_system_init(Object *obj);
 bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 2fa8c4d75db..709ccd52992 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -214,7 +214,7 @@ unsigned s390_count_running_cpus(void)
     return nr_running;
 }
 
-unsigned int s390_cpu_halt(S390CPU *cpu)
+void s390_cpu_halt(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
     trace_cpu_halt(cs->cpu_index);
@@ -223,8 +223,6 @@ unsigned int s390_cpu_halt(S390CPU *cpu)
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
     }
-
-    return s390_count_running_cpus();
 }
 
 void s390_cpu_unhalt(S390CPU *cpu)
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 3c57c32e479..5c127da1a6a 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -91,7 +91,9 @@ void s390_handle_wait(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
 
-    if (s390_cpu_halt(cpu) == 0) {
+    s390_cpu_halt(cpu);
+
+    if (s390_count_running_cpus() == 0) {
         if (is_special_wait_psw(cpu->env.psw.addr)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
-- 
2.49.0


