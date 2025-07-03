Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E889C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNrS-0001la-00; Thu, 03 Jul 2025 13:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNr2-0001Cj-BK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNr0-0001sZ-Dn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so39642f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564167; x=1752168967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kicmersWSEwnQxJBAM0jhQPBISipbGX/ta4y64dxhJM=;
 b=Tzy0Czg0GriP3lCRQlWSn1XVLC47QZFDSBp1iRWLoNBOi/yE1cqRcb3vr0oJH+5eIr
 jHmH994QU+pMp2VU/aXTWlqp87mXkDNrjfIVawLJdnqHZ54Pv6QxYgRRhU28tCLzcGCp
 4Tg/ipx1v67yJ/t8Ax9iA/ONe9qwVvoiwYktAKNp7qSKLXRORWs4UztCEXUiLSSVo+cd
 dQeuyrIBfMXY2HlAriNdlJ0Nz+H/vIYK6ms5XhSRShNyZ6P/Y5kcNerjLSdnL6MNlMnE
 VuZJXUYPmPLTdcB+69HJ79ctDZNeAijBKDwyCHcQh0sl3m9lh9yrZymtONVTGKhTUuIb
 XiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564167; x=1752168967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kicmersWSEwnQxJBAM0jhQPBISipbGX/ta4y64dxhJM=;
 b=xOwiv1uspBWLVo7xsxtb6N5VZoGW1QRZJwwVd8NA1qlCi/0g78jCLMtcRjSmAl3bg3
 imA6l4fsYudeWeZuPr01Bs5+9xD0imeccwvHQutAFP5h+PKfe5wnkRxNv3qRbGIRRZYX
 YyGU7b+FID+7dDOY6CTuPA9YOnPYn2c7IRIFHQYYfDYOu7psI/hoApJ4YdV/YcJqLSTI
 SgDgckRysJfr47n0VSZqn/5NnGAiiQksEkUWaC3VvQKExjHazejLJr4fgTS4fA18vFUK
 qPISKr/y//fJsS4uGUqtUUt4mVXAACQLpfjIglv9JOW24hnafVzTaEluRPQz6zd4ozE2
 9WDA==
X-Gm-Message-State: AOJu0YxslQWExNB+JpYzF4Xn6Xc9cUpLzKpU5LP6sAWY2+FDSqgwPY2p
 WRLqITVVjQyV+xyjk+jnsxRdOUmpzTacDKIFvcR3m3+dc2NPrlPpemlzTmuyR34dSr1NeFS79dm
 oXJoShh8=
X-Gm-Gg: ASbGnct3kb4+24ZxF3TCorikpoaC+Y9b4CuV8GtY4yvDv6QzmJT56jGiRWXTQQRyc4M
 iVg/PUgLqmjrd8F7JCgTDo7ulxZOFEwzd5fVZvxzQTUmMv1J2uNd5oCzhggS8tb7hmwgQ5aqlf8
 OjXI0Nfn/kOijVf3532iZiMMgfMWKhSsMaYjlrrXUMVEjyVtNZJIBUUKIewrG9YbkXlKoAp9nMu
 nJN0i/1ydL/ENohHCvFg++hTskJXq93bleb86/vpsZxIznrK8q4cT+3pmbSAGWjWsD0FbaS4AD6
 nJOYX2DEz35hrIyPHJb/uDYho33HPrXQYeWn1xU1oaolFA7W6FiBTSHooUZ1/BzlR1vRKoAijPo
 e5IRXYd1YhEepWPsvYycYGNz3s/1izZfOoftw
X-Google-Smtp-Source: AGHT+IG0qQcqhoVbvfzfM31MKr9oMRdxY420l+gPXOEgJg6BZR9qG6bnUXWA/grDOvUug904CFLjvQ==
X-Received: by 2002:a5d:5f81:0:b0:3aa:ab93:c7de with SMTP id
 ffacd0b85a97d-3b20095ce9dmr6768426f8f.34.1751564167394; 
 Thu, 03 Jul 2025 10:36:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm309707f8f.83.2025.07.03.10.36.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:36:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 kvm@vger.kernel.org
Subject: [PATCH v6 36/39] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
Date: Thu,  3 Jul 2025 19:32:42 +0200
Message-ID: <20250703173248.44995-37-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/accel-common.c | 2 +-
 accel/hvf/hvf-all.c  | 2 +-
 accel/kvm/kvm-all.c  | 2 +-
 accel/tcg/tcg-all.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 19ccc5ef6a1..3c6350d6d63 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -52,7 +52,7 @@ typedef struct AccelClass {
 
     /* gdbstub related hooks */
     bool (*supports_guest_debug)(AccelState *as);
-    int (*gdbstub_supported_sstep_flags)(void);
+    int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
     bool *allowed;
     /*
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 56d88940f92..b3fbe3216aa 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -125,7 +125,7 @@ int accel_supported_gdbstub_sstep_flags(void)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags();
+        return acc->gdbstub_supported_sstep_flags(accel);
     }
     return 0;
 }
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 2cf2b18fd23..4fae4c79805 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -281,7 +281,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static int hvf_gdbstub_sstep_flags(void)
+static int hvf_gdbstub_sstep_flags(AccelState *as)
 {
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f1c3d4d27c7..9d1dc56d7e8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3985,7 +3985,7 @@ static bool kvm_cpus_are_resettable(AccelState *as)
  * Returns: SSTEP_* flags that KVM supports for guest debug. The
  * support is probed during kvm_init()
  */
-static int kvm_gdbstub_sstep_flags(void)
+static int kvm_gdbstub_sstep_flags(AccelState *as)
 {
     return kvm_sstep_flags;
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 969c50c87ea..93972bc0919 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -224,7 +224,7 @@ static bool tcg_supports_guest_debug(AccelState *as)
     return true;
 }
 
-static int tcg_gdbstub_supported_sstep_flags(void)
+static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
 {
     /*
      * In replay mode all events will come from the log and can't be
-- 
2.49.0


