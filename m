Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52CC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2cO-0004EO-Uu; Wed, 02 Jul 2025 14:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cK-0003rD-5w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cF-0002G9-D0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so37031425e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482529; x=1752087329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7sqe5WieSfsWOfFniA97K4tiSwKm4bjRb1aMmtsHEE=;
 b=tycHHS4jc0V5cuADpwDcANWaNlCUbQuA546a6hp52/r5b66uA5HyTcob0fmk+0vRS1
 OcEAKgXD5ra5hBg6E4EwaEtfbKyopLARqXza+awxkkM8cqVbG+9LGmC1bhcq9Q5PYZrf
 W4vtde1rgcWoDiSHxfdOTPdHa6DxGBHOwqqftf7BZYflbfpWQosfDxJGPk6e9N/6Ebjm
 jTfZfQsBIelWQ0ij1nvUB8Lud6nVGXxOsSpsXhrfNUY4MDtDbpZhDhFe4HRZaJiySmeX
 WEFw2SqiCcEiocG+uigv33dJTmBtwX591t2hQPr+olbLb/iS9FT3RAbRNYnxkmqWw9Od
 KVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482529; x=1752087329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7sqe5WieSfsWOfFniA97K4tiSwKm4bjRb1aMmtsHEE=;
 b=J6Y1MIIXugHpwoAlkrAd8W9fNmHpkZQCRbTrEHFTjZ2n0LE2iMj8pB9dB+sWuQyK2P
 BgDOa1dBJA12nSOIzbNA/e96dfBRzD9aRRDTjwNTBKZZEZGQIcfqJU5HSapcPd0czTBA
 YUZxxYBFgaRHFqXN1VrhKfLaj00q6BtaKZuj/CvDAVg40SUtiM80pLvIYoqw9DXVyD1R
 fINpq+l8buo3zNK4TmidKVo1Ndt5G7czLDK/r1JNAKytltNJKhLMAZ4XwIdwD5YeD6ud
 yEeAkZYqGqlXrJBaHnPr/n65h5JJ64Fa1Pt3H7ULSO0xtJVeZX/xUVTTO4i7zWYdKnzh
 plMA==
X-Gm-Message-State: AOJu0Yx7LAPL+qL3YlV8JICbtLQF1+i1LQa/Y2NdRMhr+ggsWt7d4BGi
 gMAZi3orykBOLE5bGEGOrqE8VPeiqpCEZDv/pQ7sV21BCGzESGlnofvvVeochxVS2HBWoF+Tr6V
 /4HZE
X-Gm-Gg: ASbGncvjrCdVxj4JjX93tIGyoCDcg2IK01ef7+Mf8oUoT9x442nIgGgIl7YDT+gOJai
 WT3kqxW4WNx+7P6jTSKKo0X3xvJOYHtVsxGsRJJruuwP6B/gFWWggNJyBNXB7M11fyQvWscol55
 9MY2kbqEkWM1JICiCJm1DuZBtFZ+QsPK8hih6ff2HzHzwtgh7iHvYb4jKSyqUPN848ygCacG+3Q
 zasTdbx9sODkrkBMld9x7RwxjTZDQ0XQ3LZaNStdxdlnToUzXF8YIg5BOZIzdjV3W+nO2Ut3o/c
 eyzGccjLvZLSEPoy0+LXRK+zySn+WJmo1BumOnSBaU/k1kvD/euYvV/nL+qmrVKqU5UtZhiTVeo
 NNjydMaIO65fZDAfrnjpILWcAjfJXFDVo/byZvgG+1lRv4Jk=
X-Google-Smtp-Source: AGHT+IGmda3LM0dHY2HjDFQ52mTlnAGZ2QunZrg7bMjnKdM1tDfN3QqU8UbNLwJzvfvNCeQ7OUZAZQ==
X-Received: by 2002:a05:600c:1383:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-454a9c62561mr7565105e9.1.1751482528907; 
 Wed, 02 Jul 2025 11:55:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59884sm16363693f8f.80.2025.07.02.11.55.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 kvm@vger.kernel.org
Subject: [PATCH v4 16/65] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
Date: Wed,  2 Jul 2025 20:52:38 +0200
Message-ID: <20250702185332.43650-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 include/qemu/accel.h      | 2 +-
 accel/accel-common.c      | 2 +-
 accel/hvf/hvf-accel-ops.c | 2 +-
 accel/kvm/kvm-all.c       | 2 +-
 accel/tcg/tcg-all.c       | 2 +-
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
index 55d21b63a48..1d04610f55e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -128,7 +128,7 @@ int accel_supported_gdbstub_sstep_flags(void)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags();
+        return acc->gdbstub_supported_sstep_flags(accel);
     }
     return 0;
 }
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c256cdceffb..640f41faa43 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -353,7 +353,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static inline int hvf_gdbstub_sstep_flags(void)
+static inline int hvf_gdbstub_sstep_flags(AccelState *as)
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


