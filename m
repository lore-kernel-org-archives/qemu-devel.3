Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2A7C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfP8-0001Li-3G; Fri, 20 Jun 2025 13:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfMO-0004Kz-7N
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:17:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfMM-0004k3-KM
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:17:03 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so1686770f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439820; x=1751044620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRf9yAzhlgNVS6RKT148G9E3d3UkN9hZ1qj0XLXjjrQ=;
 b=s+h1tiQZpYzhCR08ynTfX+sHLsovzEC73BUwBGKa4/BAvYZ6491wZHPMBcqRcmr2o0
 d/SWmcCcc1QfWD/yfNvhgQKG+9fl8o5JKee1UjeQZF25TKWjxNkeQUBEV1JqIqWnDWud
 R1yTQiXAjJ36B+HbDhyHhQ69sCQagOt7DLk0dNKK+O5h2wotIzkmVMqh8SxlFvHJzBVU
 nMmP2vpPssDn18DxzCvn2BZZNDogu+uBizgzmpoS8LNMauq2w+dtlPej8MS5Ajdkmvm+
 dpW5wuJxC8J65h35Zp9yp7c0LIezr4d89CX9c3B1q7IBRRIZ2RfNZ4sol54uEQAh/l+w
 9vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439820; x=1751044620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRf9yAzhlgNVS6RKT148G9E3d3UkN9hZ1qj0XLXjjrQ=;
 b=tD/we5HyNH1WSdVY0c+fcpnBXN4L04iQRAAw1towJTMJqWpwIlj2Vgux+ySrgkxD3E
 HnDCFbkYWq0GS4LkV2W8zR9fzMWhJSKo39RN3zpsySj6HFt99J+ZnyKCuCz+CFc/rndR
 +9+Rf7hhjpaSQKZmjel2NcV0BlRUUzMEySYFKctM95uxjwRy29RkfmVKCRFz7xnJPH6o
 vk5YWFkaVKlToSCjmJ9/2TwcxCx/Ded9IgQupwkoogCcd5IpnlJZ9NrtKpIoRFzvi73T
 VsdqVSweguRzjshkv4TA6MgGZqi0i6vdFx1kCo2N0QwqnEhHd/uPmtZ9plNo2Oy5+OPG
 on/w==
X-Gm-Message-State: AOJu0YznrUgRLp9pw7VO8WBx8dermPHq2NRk3YNmP/22kBmUPKBFrTqT
 x+uV57KBUDporh0yo79suLOGrJQn5WuMt1Bv318nFHMLcuchm4QLqauxqNT0sbFiRcRLrwZwTl1
 dXJhs+94=
X-Gm-Gg: ASbGncthZE/ry30qjAELtggkDCjY7brOkqNu5gk+qpuH9tFydDE5Tgn6op5ry6pXO+U
 U+Kt2R/r9RZb0Kzfajd/cD6Zfm09Jt4qqi9uaQVw2DBu5zgPEX29f8sFJmC+RS5kVvEshcoc8ij
 g4bXYXmUzjg8nagMGc+r5ZjKnno1+QIXOLV9o6/DOeDhceCesqTKetDu5A4aHeDbbJc6CoDW4Hl
 qT+LHAXqsXNBMoHKaMsSSA8Ergf2FNLhtFw8/QUvRwpsj8k3CE+6X5rsNVblNpdEF40k2q5QcV7
 JOLx0NapPToB6QKjX/0T7t00Wb+9dRMcnBpxOUbr5Vi1icaZW0aVEdRcHJCWZ3NC1vdXZjQc6Oe
 bM2Cu9Jh3Yk93YzNUFdnVviUmFdCXLL89Nx7P
X-Google-Smtp-Source: AGHT+IFM17ELLCe/FoMp7G+Z6ToDkg0Z0RlxNZCpiBo3At7lPnV8Kktpj3sw+njl+fx66IuXo8a79w==
X-Received: by 2002:a05:6000:651:b0:3a5:39a8:199c with SMTP id
 ffacd0b85a97d-3a6d13129demr3286169f8f.53.1750439820568; 
 Fri, 20 Jun 2025 10:17:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1815dsm2522539f8f.28.2025.06.20.10.16.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:17:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 40/48] accel: Factor accel_cpu_realize() out
Date: Fri, 20 Jun 2025 19:13:33 +0200
Message-ID: <20250620171342.92678-41-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Factor accel_cpu_realize() out of accel_cpu_common_realize()
for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-internal.h |  2 ++
 accel/accel-common.c   | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index d3a4422cbf7..b541377c349 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -14,4 +14,6 @@
 
 void accel_init_ops_interfaces(AccelClass *ac);
 
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
+
 #endif /* ACCEL_SYSTEM_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 24038acf4aa..0f2aa783ab2 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -122,10 +122,14 @@ void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
     }
 }
 
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp)
 {
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    AccelClass *acc;
+
+    if (!accel) {
+        accel = current_accel();
+    }
+    acc = ACCEL_GET_CLASS(accel);
 
     /* target specific realization */
     if (cpu->cc->accel_cpu
@@ -147,6 +151,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+{
+    return accel_cpu_realize(NULL, cpu, errp);
+}
+
 void accel_cpu_common_unrealize(CPUState *cpu)
 {
     AccelState *accel = current_accel();
-- 
2.49.0


