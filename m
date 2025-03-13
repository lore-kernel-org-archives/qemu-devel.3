Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5141CC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWS-0004m2-4x; Wed, 12 Mar 2025 23:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWC-0004gc-K2
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVw-0007ne-98
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22334203781so29536935ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837542; x=1742442342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDzOujbAgG9mzQExSfzVLdnEwm54eULxBuAHMS75b4s=;
 b=og9cibiK3xfb/8m46tZeymhjpiaCB7ZzngLACF7Ym1IOw42RcRxiZ+0toRCd/F7ZLw
 Px/8VyqoTwxwsWT1xXpd+ASnmus7wGdRrkdtWWwxoCjT3pCUsc4O7r0tQwuWtSDlas6+
 0KUrEFpNN+mAuC4ndfeWR3+KyKgSPJ408OnXu3kivRs/fFcAO2MOnaBHSejW31Vb04n9
 pEBahqa5ogFJ0BlhI7QnhONJxdqCOTuKDoF4PoXbZcnII4hhVvur6dAmX//q2aFZq056
 x2KyIMlknTLyxds7/wOwiWV/U7g8f105zLQQw3CnuD1WcAbWWuLS52l+ukmDhWjA+0wX
 gLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837542; x=1742442342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDzOujbAgG9mzQExSfzVLdnEwm54eULxBuAHMS75b4s=;
 b=XO1l22OFBMAQCHVdDPPbaAX8IsIvUmv+V1sHCsrR8Fx8eoH7qBWlfx3PepqbSLbdRM
 xOwwqDyI0obbFZm0s6TxgnALwUmymCYrApFXuLy/ecWoRM5L0m4BHvCVPGwsrl3C+MIs
 ojYCHFG4sD2i3I/tJ028NygKrHOTr3w9ERamSWcHjLm1yMaaEQoghmJbPsXpMkGXFTfz
 wWhSOd84GOAAzSyXo5sQ3crWRwTbD0lBXo9TOgcnrB1Sn0RhocuZ3NALRlVFgdfnqwJ2
 dBSCwJcLguJ7PWnZmUi5lMcY5NqSNw7458r8l1EXvjF8KrsOmxastubqHQXnVbEjXAK8
 j0CA==
X-Gm-Message-State: AOJu0YyZdKgTjiiCsP3F8y55jh7zNi5kYfAMRQX37/O4APTS0T/3miHx
 QIsl5ncI0uL1zBIBTezrLF0uqKjgtNUfS2K/1eB0KFuUM5qrt8KNoqr9A4PhfS5Zx1QGthcYWTk
 U
X-Gm-Gg: ASbGncvUk0zerfS0rhVY9uaGf8MjdKEjcnvt7eS+/DfD+ks8yjin9YU7dtWtGbLwZRY
 vtGXxZCaWfn/5lIglk6R1+OAtrTfFFKgRgUFc74msfnsC7phr9XZnSsEW65/+gtBZClcmTksQXk
 ZmalocCRo/AWv5Q2P9i9sLtWSUO59yEtO9HTV6kkUc1nFtfmd8mqfTpwYAY70pbA5VJbfRjFz7d
 7SUfM3tAyVrW++4Zv3hVqc6cjDk2VvSuwgk5/ei3gdfk3ZKC1ZSVNKzpaBiNDxu/jZBYXZ6UIGo
 Yh8B2CWRofiKSw1CPPgVQjtPAmXgT4kCCEuKiVW50DXUIUZ1sld0A4JH7xpBKrikikuVwIc0f1m
 E
X-Google-Smtp-Source: AGHT+IEU+qNHlwFxhQjoFd+k14ruD3W1tCh3b9a8+r6TxW9Rrk51zzPcAVmB11e8W1rWz8pZJx72vQ==
X-Received: by 2002:a05:6a00:6993:b0:737:cd8:2484 with SMTP id
 d2e1a72fcca58-737106f646emr1205616b3a.6.1741837542475; 
 Wed, 12 Mar 2025 20:45:42 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 20/37] target/mips: Protect semihosting call with
 CONFIG_SEMIHOSTING
Date: Wed, 12 Mar 2025 20:45:00 -0700
Message-ID: <20250313034524.3069690-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Semihosting is not enabled for user-only.
Avoid the test for that case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b207106dd7..1ca182c1a2 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -415,11 +415,12 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     restore_pamask(env);
     cs->exception_index = EXCP_NONE;
 
+#ifdef CONFIG_SEMIHOSTING
     if (semihosting_get_argc()) {
         /* UHI interface can be used to obtain argc and argv */
         env->active_tc.gpr[4] = -1;
     }
-
+#endif
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_mips_reset_vcpu(cpu);
-- 
2.43.0


