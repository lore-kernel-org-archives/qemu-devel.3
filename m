Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BD3C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTa-0001tz-17; Fri, 04 Jul 2025 06:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTS-0001g7-3s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:54 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTP-00072I-Vl
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so322490f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624210; x=1752229010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mmz1EiIT7E9enw2QEgqBm9stdbrwDBoce02YpMIkdwI=;
 b=abwrBL5iIUUcsZFbfyG2Zw5thXLGZ7/p0sDy0vSiT3Q+7sviA5r+BcFbUsnqPmgSm/
 UZUoKuUz3p6oIqOmuslmmW7gSH6rUkkfrf9pNCf8h9dr7+v0K/qEKlop0YTy7Ss7Jqcr
 rlciPd2A6EbFF/r6Ev1pDc4Svy0rtLZwnE3AkrCSUvpv9LUdP83c9mCIQLTTu+yZyvm+
 XSzFpZnlCwTy+6wN5MePe9uXgmIgyYNZ3GbEleuOsIEwuJmXD6cB61MoZkEu3QxUEpjD
 V3jIKS06byocbnnIQyor5UfiBGnF3elih0R/9/pQqKMJrisZiuStbhL0BKA3rw7Wk9Jw
 ke5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624210; x=1752229010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mmz1EiIT7E9enw2QEgqBm9stdbrwDBoce02YpMIkdwI=;
 b=KqUi7so7I1bQdTglWzZpi6QCANaPtCZDgPP/39ikVWbVzqpCyefghu8AZLSNH94mih
 ZMttayXO3SijKElALYLvSKkKt29u3oVVelHkOHVPVWsJjZkd4DmQsT/qQjYTy4xeRBDU
 hCtzQ2HMMTzN17u72ArXJy7rrln3r4K/5SkYmZyDf72yKuU16st4jZQXrU77b5yCVuS/
 vjjmcKHx8RbDUXj0K+Bj4luqOEluLMoUDiyjarP5+DyeFBzbtgg0f/kbiXWZXrUuLdOe
 f09Qui76fXaQOSZiSAoc+eLnTR+C3PtML/Wnnuu1niMwqRs2cdffUOmz06HkHlTMfLT8
 /gTg==
X-Gm-Message-State: AOJu0Yz3ayp563Q6wU1opkLkC2cF9fw8XXBrinXJ+Y4XGrZazRioQUDK
 F5x4vK/2YOMGSSutTJrsNinAOEjSMG/UnDBIwXGh6TOL+5mGCxit1Ksole4jy/7dBQ1CiQxaK5f
 vvmvhvC4=
X-Gm-Gg: ASbGncuHCCPJaMnwiYajhtT6gvsGA+eR1mjr4DxBZZMYH9946joZJOxYIAkmxG5my6p
 c8gaekeYeooqjl6vp0EIpwggsfw2VZm9Nkh3s+qp2fCc/J7zvics0Nrv3q6PpP2JS891mNEiDwz
 Tbb9f1iymhkxOt3wZCerWKe2v1EpsejhTGgL4DMS8hboJmrk0WwuQ9XhKF7ow/7cb3t6aAs0nWV
 gIN4ACpgimjou0qfdmADWJZtyY9RIbgXB6N9P+SXH00tYeUJf5Ekt5PKgOeswGhG5idqe7r4ZU5
 aJteOPLwBqHqkzhKoqbN7RTaCj/4vr85Ul3euznqHbSoSLK1FKtIDN2wl7XS7kZd4El+trVUXsB
 Vo50nf/jRRqYj0JUqCzrKrBWKIrybom01tnG4
X-Google-Smtp-Source: AGHT+IG1OvokeaCsO01pGcHKnjJJqIB4bcX3kZcdBiUO954sHRGsritFkO912tizcckONwxa/tPaRg==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:f70e:abda with SMTP id
 ffacd0b85a97d-3b4964eafb0mr1699730f8f.10.1751624209502; 
 Fri, 04 Jul 2025 03:16:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b97f10sm2133998f8f.57.2025.07.04.03.16.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/31] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
Date: Fri,  4 Jul 2025 12:14:30 +0200
Message-ID: <20250704101433.8813-30-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-Id: <20250703173248.44995-37-philmd@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/accel-common.c | 2 +-
 accel/hvf/hvf-all.c  | 2 +-
 accel/kvm/kvm-all.c  | 2 +-
 accel/tcg/tcg-all.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index a6a95ff0bcd..1c097ac4dfb 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -50,7 +50,7 @@ typedef struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
-    int (*gdbstub_supported_sstep_flags)(void);
+    int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
     bool *allowed;
     /*
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 4894b98d64a..591ff4cbb65 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -124,7 +124,7 @@ int accel_supported_gdbstub_sstep_flags(void)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags();
+        return acc->gdbstub_supported_sstep_flags(accel);
     }
     return 0;
 }
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 68f1425fae2..b6075c036e2 100644
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
index 6f6f9ef69ba..45579f80fa5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3980,7 +3980,7 @@ static void kvm_accel_instance_init(Object *obj)
  * Returns: SSTEP_* flags that KVM supports for guest debug. The
  * support is probed during kvm_init()
  */
-static int kvm_gdbstub_sstep_flags(void)
+static int kvm_gdbstub_sstep_flags(AccelState *as)
 {
     return kvm_sstep_flags;
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c674d5bcf78..5904582a68d 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -219,7 +219,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
-static int tcg_gdbstub_supported_sstep_flags(void)
+static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
 {
     /*
      * In replay mode all events will come from the log and can't be
-- 
2.49.0


