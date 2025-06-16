Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13665C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR5oQ-0002Jr-Uo; Mon, 16 Jun 2025 05:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR5na-0000Vc-FY
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:06:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR5nY-00076b-PA
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:06:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so35247385e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750064794; x=1750669594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kc4tC5QN954gb6LWO30gy1l0ONnT9hdO1D0bYxQuIMI=;
 b=q4gNr6QnrIhzKRQt9rKEAThqfJrdMOXWBVi7BfdFOOEC/o+o/60mtnNPJwiHN1VXzW
 RD8/Fw1cXnibcrL4loH0PAcfOK9+4EnAAZ778awa1J4LTV5ZfjezhfU+qyqLtu24k8Ce
 zuYxs5fzjgETTzt2uKwmpQ/kQAJ/8RngCCd4EtsPw7VfW/SziEBksVbCvVS3Xd6aUstw
 gvheHJVgCznvJIPdplqnOTx0dqTQV8ahUH2rYD2Gnutu8Qhn9KxqpLGVISq5W1Hp9Egi
 tnBgR6zUG8BDdU/BmEcxWe6TT+hBZKg86tazwTfxVNK4jmFPYFLW7Z2WABiUV25h6Rrb
 n/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750064794; x=1750669594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kc4tC5QN954gb6LWO30gy1l0ONnT9hdO1D0bYxQuIMI=;
 b=JCcnAbFBP1LxUwduf7nDOKQdddwFOPWNm0llgW2vuatOqKCTeP/jmDS+m3ufKSeD/y
 Eoacz7hFrZhzJXARkfKlS7gFvcpvhqxIOsuXrNmXAbPkM5hBcBncG3CI2P6wRr4jWfKL
 xgXGznImVNUzgaEMfnjZSvraMOCkiXm6qSV3pEkiGKKA3QnqTiLXsQclejQ8E9XIss0+
 kG0wJiGlYHMO3+P97ymTmZoZanF/8MoIF19Ubb7PqhzvGymnFXVCZNsKota2Ud2aAql0
 P5Eqq91OJswfqwztIOvOBxMYXkbdJ+73evOyuPJwTGIWkmVWiuEXfjG+398ovQ6Usv1R
 dAxw==
X-Gm-Message-State: AOJu0YwZApxI5AdnMbESVwrIwmezCq8J2VEyw2H3Xa7XMoL/Z99sJCvZ
 fow2tS/pE1uACGO3dUwdWuC/YJvLh8UIWqkxSaDoLpSQ5RE96rIPJ6WY4ikLPx0ErMUez12whEu
 S28GWjVk=
X-Gm-Gg: ASbGncu1lLOt0KXi3hEX4TDkTXtG3CyE3o5HnonhgardRXHiprns8XRzvXYHd45Tgnk
 7YmxOw1HFIlCbQ7qrhMuxcQvHO+z329A2m3HCU3cPBgmQ1aYKm3qBaxyTmyF+lkbt5cMdPGbUxw
 3aYkahuMHLMPDtxTAV46V9SFvpx2E6dN0VaWk3W0KW9h8ARz8FG7AvoPXuiAx4f3pQHftDLXOiL
 A7HavYJ3jmKzDBDTwto6imOjQI5pUdhRz3RJZQOkFeHzzSZ47t4bhXJ6bVpxZEyjObt4NmrDu/h
 bJGu7hEo3fiM59GtA1ZKYVkDQiHCLnOBl3NxnYgULWEWOQddiU8bLP9mTQQJdW6vTkRDMARkpCp
 UJQKOhvDaneHXI13J28SzculWXlo5RJqx9lzq
X-Google-Smtp-Source: AGHT+IHmR36M+6BChUKDsFyx3IBHRHg8p7tj5VvN5hYkAGoe7Ns+rWP/xBBM1aUmYghiOh6pAUvFnA==
X-Received: by 2002:a05:600c:1e1a:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-453501b41d8mr353275e9.13.1750064794348; 
 Mon, 16 Jun 2025 02:06:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232b68sm136640115e9.10.2025.06.16.02.06.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Jun 2025 02:06:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Subject: [RFC PATCH] target/i386: Report TPR accesses to HVF
Date: Mon, 16 Jun 2025 11:06:32 +0200
Message-ID: <20250616090632.55214-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

HVF should be able to handle task priority register accesses.

Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Untested as I don't have access to such setup, noticed
during code review.
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index e0aaed3c4c4..a0555e74cc6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -549,7 +549,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
 
-    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled() || hvf_enabled()) {
         env->tpr_access_type = access;
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
-- 
2.49.0


