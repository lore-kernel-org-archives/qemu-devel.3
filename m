Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F67DC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sw-0006bH-4y; Thu, 23 Jan 2025 18:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sq-0006Zq-EA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:12 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sn-0004Df-Rv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:11 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso1317002f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675908; x=1738280708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDFP15LbfYjBwdgoNtB1SUTPS+QYiGObjjbLDQKpiPc=;
 b=JaYcnurg7Wc1NwUPixsucQNIRXRWSC7zgF3HVlaKoIglWMt+rPZfdnhXNVtV3jZGg3
 zPlLu9msph1F+zZJEkchUwhy8CuDQf9azL8r3NhYOnSKoxuQ/gTfRGkQb27JwK3hW/mv
 yvI36NjDuQfigkln3Y1fCDNWhgEa4v30Lx7W9juBDJzshr6BzT3h6enXKVzV23XHmwdA
 iA9A9bsQDzYfbAlaXEfd2OiXS5HXWP6n070H1kvmPOGhsN05L8t7G8VZ4cDWU+B0kWqE
 IkcKGRS0ATKKhaVmRaIckqPQRhYZMwTLPlL5NELqmojz6qHdKSh6oDu3yaDVANm4lnGB
 hboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675908; x=1738280708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDFP15LbfYjBwdgoNtB1SUTPS+QYiGObjjbLDQKpiPc=;
 b=KhjuWir67OlEl9mmqpKRw4DHJXyrKv4EVthejJTiEE88xVML89Jc0aQY4+/vwuqsae
 +Q2c/wWxy/PbMJMvTwPMr6DlrNAt4kCAFtPumVm1TxQ5exdMulHZBM/izxfwCHioM5N4
 5F8nEeWU1UppvOax7HekGntl8+p1QdbkyJPSPwuiBOYT3/b/iecAoSi20ASgTVtGYlak
 ib1uzP7o4cDlL4PJqvTH3LIAmn3iUMoflcYOcfhXPenj+EANODj8oXHUlbtZJ14LoXeb
 De6mQ4t9sg8QczbRCBmCygA7zIOvIC2Np0xxKxha8n63wS66jcX4+TMdz6mcthExWTTt
 Ut0A==
X-Gm-Message-State: AOJu0Yx9SiS8PW/q0kbjNGBLKX5ZeuF7DbfZYONgZpV5SUuebRCZ55vw
 afR5OrrdvYtsAxDqJ1/aetWk1J1VF+hKGrsDtAU3ibX88c3jaBzBkMlva8fThY21wdhgRd6lJK/
 Oryk=
X-Gm-Gg: ASbGncsIovLamNsvsLxqNYJU4AYz0l9IUnob9IOpaRVQcoxMpvvEcyIQkHXXOiKOdau
 RKYBjNfaKv9PECTM3+AYgzZ/3y722LQVlZJWYip+jKqrKyPi6Fqu7bh88SWvnLnnUg1CHv/ilSy
 98K3c6wb55ubJal+pHS0TAvJbn7wEaIMwxGUrRFpFGwwxyLc7xNGd2Iip3OU0esCuJh2NgW5QRA
 EkWhzpFmb6v9rpGdcpZYd37vXIgmMZE4m9j5FIlL2E99tdFba/WmJroEb3bP+xedbFEWWmVsF2U
 HbUIwOWjMh/m3MhliOO5teaIkxg2B/XWSuRbwf0KCRWQYBq8uRZ2OF4=
X-Google-Smtp-Source: AGHT+IF/y2rn8++eRXtfGXVV9eCNnufdJ4OAKshcVAU/XMr+be4nBaPjnThGR5Wf47h3eLbBgCoQsA==
X-Received: by 2002:a05:6000:401f:b0:38c:2677:9bee with SMTP id
 ffacd0b85a97d-38c26779db8mr3711264f8f.15.1737675907708; 
 Thu, 23 Jan 2025 15:45:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17630asm997952f8f.6.2025.01.23.15.45.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/20] accel/tcg: Restrict 'icount_align_option' global to TCG
Date: Fri, 24 Jan 2025 00:44:03 +0100
Message-ID: <20250123234415.59850-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
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

Since commit 740b1759734 ("cpu-timers, icount: new modules")
we don't need to expose icount_align_option to all the
system code, we can restrict it to TCG. Since it is used as
a boolean, declare it as 'bool' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 2 ++
 include/system/cpus.h       | 2 --
 accel/tcg/icount-common.c   | 2 ++
 system/globals.c            | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index d3186721839..7ef620d9631 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -17,6 +17,8 @@ extern int64_t max_advance;
 
 extern bool one_insn_per_tb;
 
+extern bool icount_align_option;
+
 /*
  * Return true if CS is not running in parallel with other cpus, either
  * because there are no other cpus or we are within an exclusive context.
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 3d8fd368f32..1cffeaaf5c4 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -38,8 +38,6 @@ void resume_all_vcpus(void);
 void pause_all_vcpus(void);
 void cpu_stop_current(void);
 
-extern int icount_align_option;
-
 /* Unblock cpu */
 void qemu_cpu_kick_self(void);
 
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index b178dccec45..402d3e3f4e8 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -48,6 +48,8 @@ static bool icount_sleep = true;
 /* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
 #define MAX_ICOUNT_SHIFT 10
 
+bool icount_align_option;
+
 /* Do not count executed instructions */
 ICountMode use_icount = ICOUNT_DISABLED;
 
diff --git a/system/globals.c b/system/globals.c
index 4867c93ca6b..b968e552452 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -48,7 +48,6 @@ unsigned int nb_prom_envs;
 const char *prom_envs[MAX_PROM_ENVS];
 uint8_t *boot_splash_filedata;
 int only_migratable; /* turn it off unless user states otherwise */
-int icount_align_option;
 
 /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
  * little-endian "wire format" described in the SMBIOS 2.6 specification.
-- 
2.47.1


