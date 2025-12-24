Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D6E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRo1-0005z3-G8; Wed, 24 Dec 2025 11:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRns-0005lJ-Pm
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:40 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRnq-0005Dg-24
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:36 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so2569191a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766594010; x=1767198810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEDrnWk8Wr15rxH47m0OeFBvz2nNNe1AWutUXoPYNWg=;
 b=XTCWn8fJGfAI5fgUPw6wBxKXj/4pBUcnpaQGuvanG+uclnJoIxRgyOgoPPLSFiAWs5
 Mp4rVxJF+ZoqrMmnUi0qGs6qDCJmYYHggbpWPfbZCcggcVYWGJ5eqSENCnUF1yRrM8Ac
 Uupg+rYK/Pu4Sdi0Tzqu14V1p03eZZxiRarz6G9ScLnOkVIAFZAS7Gam8oAusam4gUjn
 IuAzR5YnEKvjV7sQYYYudd6/G70j0UXg2Sx6a++rax86p/vlCDCmWjlOm8szE//35Z32
 esxVfjH/PibmcXxbIciu766BVeavBq8KGnBmES2tz1t8uc+D9RxwPIgUB3DwEmYjPdue
 AbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766594010; x=1767198810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rEDrnWk8Wr15rxH47m0OeFBvz2nNNe1AWutUXoPYNWg=;
 b=A8uWkt3nHD6TqU6zDbkpfjIhFZNemzrelcmdcLWU2ZpMzuHL0+unaGs4phmUGZs/6s
 mEaS12S374OtkrEEhUUM6L5AutSXldEWEWVlzU7M/7NRXxKxyg8MqcBbwreRqk49EHRS
 HQpOPBzWL5Z7Jyk3Had4doV/P7IQ146sVBqLkAROo6bDLppG3l8iT/qx5VfXRcNdm96d
 e2BIIDiS3KM/Tk3QJ7F2AgtbF4RnL4ZLQi4TefeQHpKtUyW3PetQsm4C2iGyj780bNrP
 psKYOQf9O22xp5VHg6SeNIRetQ4v+U4cgACDx5KsaCzxxPfukpkpjZzTu+YlV+wlmeZi
 VWFw==
X-Gm-Message-State: AOJu0YzLtDHfJo28aH6dKuUZrVMSwxuncKIbuqGHZTpKHxEfgKdRCQq0
 2SvJ+XmQkQwTdQMk2Ra1HcdXA1rvLj/lFEpVc15S0P2waaSMFpan/7pxAPuRetti09tqMley/+w
 VyxIZRmQ=
X-Gm-Gg: AY/fxX547X3OQ68MkzNa5P3eHRjqKyWfig5/vBAoQz3JJfwydtisYT6IlhYbKid4dAS
 aKwYi1aeq9kGvuiItcWToIn5uPLqX+b0S5GKAczd+HXj6pOMsi0+izUqsbAVIVV+A5pYmhBw65d
 nitzFaXAXkTsYmISjb/ndOLHeK2Qo1WruIFvhbp/MoycjOsB9NZXKg8TZfgtYjXC+ClXkAAZ6+5
 izXpxQdfMgdoF0irGbqyL5iDdwK0X8Fvszm7IirlPX2KpAYHG9JmW0aGq2WY/BFCVPyK6gcmkgb
 uAQcEgj47APo5nUl6OLSdX5n8hsiBklUMq8BIz/+6s5OVpggoKrcj3EeDRVz7N+tfCBf05NKwvt
 5T+uvWmXClO7HG7YTRjPg5B8DLZ5mA2kJqf79y9sCVPyjPd2MKYjn697PY4R8wYq7WBLo4ra+CF
 fNSzqLOq/owBtda7PHPBjRKnedw7zakdMuwJuqlIe1iQ9HXpzWzwk1VBE=
X-Google-Smtp-Source: AGHT+IE9YQaIknZmwXTCk7LT5v6I6OU/nslpTppYr1DxRR0nOY50YmJsd8daFIKxsHwa0DSVZh3VWQ==
X-Received: by 2002:a05:6402:5107:b0:64b:474a:d295 with SMTP id
 4fb4d7f45d1cf-64b8eb619bamr16509803a12.18.1766594010029; 
 Wed, 24 Dec 2025 08:33:30 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b916b66e2sm17541788a12.34.2025.12.24.08.33.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:33:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] target/rx: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:33:02 +0100
Message-ID: <20251224163304.91384-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224163304.91384-1-philmd@linaro.org>
References: <20251224163304.91384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

The RX architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/rx/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/cpu.c     |  2 +-
 target/rx/gdbstub.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index da02ae7bf88..0841b594f63 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -99,7 +99,7 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     resetvec = rom_ptr(0xfffffffc, 4);
     if (resetvec) {
         /* In the case of kernel, it is ignored because it is not set. */
-        env->pc = ldl_p(resetvec);
+        env->pc = ldl_le_p(resetvec);
     }
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index f222bf003be..30074c9da7b 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -56,7 +56,7 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     uint32_t psw;
     switch (n) {
     case 0 ... 15:
-        env->regs[n] = ldl_p(mem_buf);
+        env->regs[n] = ldl_le_p(mem_buf);
         if (n == 0) {
             if (env->psw_u) {
                 env->usp = env->regs[0];
@@ -66,38 +66,38 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     case 16:
-        env->usp = ldl_p(mem_buf);
+        env->usp = ldl_le_p(mem_buf);
         if (env->psw_u) {
-            env->regs[0] = ldl_p(mem_buf);
+            env->regs[0] = ldl_le_p(mem_buf);
         }
         break;
     case 17:
-        env->isp = ldl_p(mem_buf);
+        env->isp = ldl_le_p(mem_buf);
         if (!env->psw_u) {
-            env->regs[0] = ldl_p(mem_buf);
+            env->regs[0] = ldl_le_p(mem_buf);
         }
         break;
     case 18:
-        psw = ldl_p(mem_buf);
+        psw = ldl_le_p(mem_buf);
         rx_cpu_unpack_psw(env, psw, 1);
         break;
     case 19:
-        env->pc = ldl_p(mem_buf);
+        env->pc = ldl_le_p(mem_buf);
         break;
     case 20:
-        env->intb = ldl_p(mem_buf);
+        env->intb = ldl_le_p(mem_buf);
         break;
     case 21:
-        env->bpsw = ldl_p(mem_buf);
+        env->bpsw = ldl_le_p(mem_buf);
         break;
     case 22:
-        env->bpc = ldl_p(mem_buf);
+        env->bpc = ldl_le_p(mem_buf);
         break;
     case 23:
-        env->fintv = ldl_p(mem_buf);
+        env->fintv = ldl_le_p(mem_buf);
         break;
     case 24:
-        env->fpsw = ldl_p(mem_buf);
+        env->fpsw = ldl_le_p(mem_buf);
         break;
     case 25:
         return 8;
-- 
2.52.0


