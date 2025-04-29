Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C98C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d6k-00018T-05; Tue, 29 Apr 2025 01:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4z-0007aX-Ks
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4x-0005ze-49
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227c7e57da2so47219455ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902822; x=1746507622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmDBK1mwNkNbnmEBtgMmVcGSzIRc7rMtBzbRfWVwQJ4=;
 b=yT1cEf+vtQbWSfuaTa4nli9sIA6eFilcZrmLQXMneMMyg5BOBA688rW2mKoRiGn23h
 2AQ9uFF6urvVjBQlJfEQDPeuNkJVF2oTZAktElQ7Hl2hHTw8tXFNIq1D80LGMdEemaF1
 +jpYvHVkKhBVa6BCJYazYTkieXaBvCZ6Q1RElcBAIkKgzPzq2ZCcXT8tRFmpFpaEnuWb
 ucYXUSQeFzPGIr83qqVhKdNYgDMak5eqQGm1LREN+vN8cje7udbj1Tl+bHg4gr8QdafY
 UYiqpmRxiyo5auS/e+AEwyd4Zmr59uL4+ptIrjzswCSrzTbAItn1PGs/+I544mjlLZrI
 /h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902822; x=1746507622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmDBK1mwNkNbnmEBtgMmVcGSzIRc7rMtBzbRfWVwQJ4=;
 b=ieNoxgT+/jXZ0OoE87AteVNfT+E4v26i5yMKmjKyCQ7T67Qmb/QaCfSX45qCMfmA9s
 hexV/9Ob3tHQ5tXn6jelYn/s84ikH/CN+1H1EHCvbleyx9xTyNmnbf8trJ0bS9ZsF53d
 7XLyx2700Z3k+K71XDcOaNFkfBI89jyRKx7RF6k1Vx5KNQdrt4+8kDFvG5A3XxgXiUiC
 3GuhepShap1GDmLCgFlDl/ErKQ6jJowKYmmpGQpXqG5olmRuzR/g48YcEWNvfZQXaDPu
 9vCRA/2UKgcwMQkYf7jtflLyp4J4VT7ROVjHPfrNjJErFD//AveSPJWx1dZXN/O8dqMW
 wxoQ==
X-Gm-Message-State: AOJu0YxgqRTDOxLhlrKlp7SaJ7ccwa1CB9EtlzInn4i4KTeo5E0UJ5Jb
 UiAl5CPrBygmin4CAj5fUhNzjrKFrpnfzsj65px8ngJkPwbpQ2WlZx8285WLZHpEtKPXpzQUIJ6
 K
X-Gm-Gg: ASbGncvijdjusSYfrByz5AUNWYiii/L2U677ojldjFgACcWRvEMGxnXex1AdiJV+RRP
 BuSxf5GOYqJbG6d3n6Y7QSc24v8sd+jsDyiv37NmcAqidHUFCHvDKg495R2IzGGIM8oB0LVtgZ0
 Fiu4ARyKHgmQBcPBau0cx1mU8WuIbBfIVLbyAad1Q7gkyCRXY/vhJ57OCnR8mMwIu/daOdv9qjJ
 SowjqXPryrapSz+Rc/6/CgWGJTyiBaU6gVUP2juSF3ECukjOi8d4w8zY+LfrwaMq7bzvwsybnRj
 oLPc9NHFEzQyBsJ7XeOr28R0oVok6KUsA1iVA2OI
X-Google-Smtp-Source: AGHT+IFu3N+jj+Ept4mXyFeiTkaqrsFaktsu0U/CH8Tvkf94SUE6QCp5G/0psN7lUde/shvF6Qz/Rg==
X-Received: by 2002:a17:902:d2cb:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-22dc6a546bcmr176908975ad.34.1745902821676; 
 Mon, 28 Apr 2025 22:00:21 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/13] target/arm/kvm-stub: add missing stubs
Date: Mon, 28 Apr 2025 22:00:03 -0700
Message-ID: <20250429050010.971128-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Whem removing CONFIG_KVM from target/arm/cpu.c, we need more stubs.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 2b73d0598c1..2d369489543 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -99,3 +99,13 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_reset_vcpu(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


