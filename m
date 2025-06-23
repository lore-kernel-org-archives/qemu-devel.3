Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B42C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg9z-0002Li-GS; Mon, 23 Jun 2025 08:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9n-00022D-Ku
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9k-0000t6-DS
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4536b8c183cso10208715e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681210; x=1751286010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zn98SRXtaFwoihOhnAeEFS9N5zUhWDF7TNyGo/TLss=;
 b=kSJ0gjZnx0yOTCKTTQOLPN/Gd2ncbknKSir+rJgpmyGzmvzVPpWAIQ0zE6Vl+CpWnc
 OpF3jKw59AjYvrUN6ODLwNNMjHSlhjPNV57gGLvHmxuz6qn3DZ3OsLjb0C3ybLoDmOiU
 adFJknYEUBlSUhAO12XtexnOTwGJzOGLvNp2r1cBTPqw2yEo5ozGlZLkCd7I86lRfPsk
 eOsXAeY1anWA2hNYe2AsxuJor/97WGSKVamUe73ikHtES1HGm/1NX2ODA8SO9YuIDWgc
 NeCC07cSfpWsAOg0VWlw9lV548psaBl2CNwgKbW3BzCoo76/iKo9LcAx0D0SweaN7Pjd
 uPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681210; x=1751286010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zn98SRXtaFwoihOhnAeEFS9N5zUhWDF7TNyGo/TLss=;
 b=dsJ5PxTmmbuHKU0aDXkgmKHZD6bovBKu6M/ZF3woZFqpS4rhGDbaVOAf+ZgQNIJ4J3
 FgDIKVH1PhPHcZnHHRjXvscsIOS6zsu5vTrvZh6Qcnq5hJucDA/TJJJb+A0PBchrXDm4
 /68jW6XC1jXRZmfiJJcjLX49FyuvqPud/Mydqq5ctjULqYbAggWROJHplI5JSm0VqmnO
 cQF93VAoD5NN3qEhLFJqgD70d29NxjJ2wFqQJ3vfrmw351D46wg0XvCBZfKhXnymkcDX
 HVr3DxmOl6g5UhoXirvZno/TdPw5tbc6FncIba7WHCZJy1I48UcxaACqfpP66tJHactE
 YrqQ==
X-Gm-Message-State: AOJu0YzD/xFBMHpcwHiAsDjybHY/lvidcDYnafthBZdSvGPNvKHQktcQ
 qb9HiP42XcZDNfzSQ27zh3DuHIMP5fjPmOja3Dp4CSKuwCnI6l22vERc7e7VuL8msLHzDM20iIb
 Mtgyg
X-Gm-Gg: ASbGncs2GiU1e7oIJdjTXI1W0tc46xaJesJjxjghDqbRsM+Mek1S8GxI25nA0HvbjHq
 vAQUafZyhr1L10M15QS/zYRmGjlaEFovD4s+81EhPuJcK20x0J5VoSPy60s98IumX5mf8JcdwUC
 h37WYyY8ltvCNHzsTNj9lkOdHu3ozpgqAOKOo7NjJlA0FYrpIhNcrDIIhWz4hIYpLsILzoK81jn
 HHyhXwBMb+i9HcL6IdKKaLhG5rRJF+LdpZXF8/9FlUAL3HQnUTDjae2Wv37s0jVa26+Jk2LJN6+
 yzbdeNEZ0KQjCLuOLrzhBYYzTG1bsFs5o3UBf0CU7IVTtXeUPok9/mYPp+gB4qDkKARm2SZvOoq
 8QZRp+HP/meM10HckSogmc9UlBoAgOjD77vMX
X-Google-Smtp-Source: AGHT+IFhxvf0pVdM4spy0FqKxphN+wj0nPLNYA/H7sLORxDSPVaYXm5uBRM12Jr6vzicVX+Kk0gVwg==
X-Received: by 2002:a05:600c:3b19:b0:442:d9fb:d9a5 with SMTP id
 5b1f17b1804b1-45365e5e41dmr102028495e9.9.1750681209616; 
 Mon, 23 Jun 2025 05:20:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1d168sm9202901f8f.40.2025.06.23.05.20.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 16/26] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Mon, 23 Jun 2025 14:18:35 +0200
Message-ID: <20250623121845.7214-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Implement HVF AccelOpsClass::cpu_target_realize() hook as
empty stubs. Target implementations will come separately.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hvf.h      | 3 +++
 accel/hvf/hvf-accel-ops.c | 2 ++
 target/arm/hvf/hvf.c      | 5 +++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 15 insertions(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index a9a502f0c8f..8c4409a13f1 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -72,6 +72,9 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
  * Return whether the guest supports debugging.
  */
 bool hvf_arch_supports_guest_debug(void);
+
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif /* COMPILING_PER_TARGET */
 
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b38977207d2..b9511103a75 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -588,6 +588,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_target_realize = hvf_arch_cpu_realize;
+
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b932134a833..fd493f45af1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1082,6 +1082,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     cpus_kick_thread(cpu);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 99e37a33e50..28484496710 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -367,6 +367,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.49.0


