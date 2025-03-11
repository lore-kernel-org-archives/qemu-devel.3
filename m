Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031BAC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzHM-00015x-O9; Tue, 11 Mar 2025 09:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzED-0005Ng-Kz; Tue, 11 Mar 2025 09:01:06 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzE7-0000Aj-Ou; Tue, 11 Mar 2025 09:01:01 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso9412283a91.0; 
 Tue, 11 Mar 2025 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698053; x=1742302853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXbLVl+GmIzuW1zJgw//SH32S1N1RiaYQUubYyQlPG0=;
 b=Bh/r8up3aPDla4svFh8HanutVZTxATTXNNt3bC7Xbc05twUzQuIrWR4oJMua9uuvw3
 sn67IRL0MbaeWBPCoYqL6YsM4w8nRNLFz6nERJ7KOiyrdnbfNRi5qe43IATvf/y8DOw7
 owkYpoiBPMKrWUaYwNdtlHz6A6ahDNIkqYvxZYilthWz2KnEBhaKX2UOFae9yoLPIwp7
 h+qCX/X4D/J8DDLzjbfkje5KuUISAsZeV0ykw5HBE8eq4/VYEl0M2CnkmU2q4w5Nt66L
 IhJ0kjh/Kn8voRpFhsHvGiLzVWS3NslFkRZtxqRsD5zBfPkFflYFGL9mM0U/q/QG1OFg
 1yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698053; x=1742302853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXbLVl+GmIzuW1zJgw//SH32S1N1RiaYQUubYyQlPG0=;
 b=Cc2vnNybVBggWjFFw8G6lXZdltllyHf9a1GRF8jII9A/L+lwmYBMyyJDlyyFKukkSe
 I6lgVod2DXvvY4aakT1zRb0SWqEOTJpkz1TMJF8x6NNe2YwoJVduMwH801x+NCs3uLV8
 zhHlhIwcdLK8xTmal+Dh2VRUKnldl/Pzbw366jpgUqtWIXBsgVygb+Y3v8b0E1uLFGdz
 VtxExglvg3b3BzIG4L+YF1ig4COrZdLtWIJcdFP//YoL1zjtidvuTX5IhwHoABXzhbYg
 guVI/gcw/+53ejYKhOSZGqB4X9XRoAQpf903gkZfoXOXaI05IxI8tUpQGPkNjzbZp3BJ
 W2YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz9xEFVrOrAYYC15wUf6rDh6dtqgXZ897imX/glH4vg/8l6pXUz6ZRRCPYV53EXk88rD7C91Y9Dw==@nongnu.org
X-Gm-Message-State: AOJu0Yz/Y2i6fvNEyOps6rFDdke4VQvIGSWRlWbuteewvxIZvy0wopsB
 QzBz2jY4oS0A/RZ0/ZduZ/0msZlfZXgWh5Slo+wJXsREWRC01C6dVemW9A==
X-Gm-Gg: ASbGnctvXzxkaYfQ2/4CweMyFAbto4I9W5YmyOAE83YzCt/iwkmzPipF1SjRBpKjzus
 C/suJbNBz1cIRzIRqwgHqLZcvti8LQKtZm7ecrROLwZaj6/tsuYWZh74fbeuZ/rWFHCmIGFz3S+
 zZwpDjhGDryMatAKYwqyIBoBoMLtJ4AP2fXs20i6fQN1E6rNb1E2e5lJTzzjNrP+VgEDo88jjzT
 /AXI6gvtMuYI+tWfPOZSUAodfHK/XyjIga+jS5P0dWRESVXhR4447BjhTtCnPdlqakEY8wGcw5W
 plCroTl5+yzbr/kQ9/1rXEVo33pYPDSz+VQw41AAGT48BNX+pQY=
X-Google-Smtp-Source: AGHT+IHnqpZUL1uuPGF2HHgzmnk1DrgtTaZH/qHHRmSOFnKUqmV8NiMImsPjDSvzrVxu//xlhETawg==
X-Received: by 2002:a17:90b:50c7:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-3010051c043mr4492197a91.7.1741698053591; 
 Tue, 11 Mar 2025 06:00:53 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 48/72] target/ppc: Remove raise_exception_ra()
Date: Tue, 11 Mar 2025 22:57:42 +1000
Message-ID: <20250311125815.903177-49-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Introduced in commit db789c6cd33 ("ppc: Provide basic
raise_exception_* functions"), raise_exception_ra() has
never been used. Remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-9-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         | 2 --
 target/ppc/excp_helper.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25b1e6d6b0..505b589714 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2756,8 +2756,6 @@ static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
 #endif
 
 G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
-G_NORETURN void raise_exception_ra(CPUPPCState *env, uint32_t exception,
-                                   uintptr_t raddr);
 G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
                                     uint32_t error_code);
 G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 236e5078f5..9e1a2ecc36 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2528,12 +2528,6 @@ void raise_exception(CPUPPCState *env, uint32_t exception)
     raise_exception_err_ra(env, exception, 0, 0);
 }
 
-void raise_exception_ra(CPUPPCState *env, uint32_t exception,
-                        uintptr_t raddr)
-{
-    raise_exception_err_ra(env, exception, 0, raddr);
-}
-
 #ifdef CONFIG_TCG
 void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
                                 uint32_t error_code)
-- 
2.47.1


