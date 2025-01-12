Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A92E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Kb-0004x2-Le; Sun, 12 Jan 2025 17:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KX-0004tj-D2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:14 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KU-0006to-NL
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:13 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso26176525e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720469; x=1737325269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIb8JuttOpsx6n0lGPjJoZH2kDKEyQKUDAozyZfVQNI=;
 b=A66GUq5pwM3+pcjNcxe6chbLk7SSNG43CcbN+wX28YQzwJES5C34IIooADC/LbhK8H
 XBlFXskOU6W0QBFAHZIP6nkzCgYfi7tXzFryJuMO8UrdTVRjl5mlVbGnoVyyMdsr8teA
 t217kHLS6htCoDiPnGTcJmeUxjbOAfjQOLVTjMgbVCsA4ocF47Aph7KNdo9fit128JKm
 7mt7yL6hoQq+fewvHYZ4zrjS/d4JcdUwwSEUeZ+UrjMYvq3zazDderErWVt6RIxvGnIr
 m6lJEm166uThGi5kdNTLfW/hIOQzvsaM03Mdhq1pHy39PfSKgcZ3Bh3YMZ5rj4Ma782X
 e1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720469; x=1737325269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIb8JuttOpsx6n0lGPjJoZH2kDKEyQKUDAozyZfVQNI=;
 b=alerIpDsoo0LnQcx+t2Olr0YxQtjTyn6pBX/a+c/vdYCCGY6+R+sr/713KH2JpBNBm
 EhQuPannPVrux85EKkby9O9sirhXoZZ2o00A7orJHSPKYBb4VO0BQ1ekIx8hW5JBj7ec
 6mI9shBtSOaUKU566N0fONezHs8KBU29maM6IXc0PLPV6PMUA7E+Rx4Bd/nPDXtzYCBp
 74RQifSxIEumL2nNT4csub1+woxxKqER4cRBMkPX1vCVTP95w1ytLTfpMIwaWZDDl1i0
 evbOUiK+p38v/ve5mWuox6qlD3QH10pQC/7IZQV8F4RRjCtwoPwQuiJNI1MAE6lfNiNL
 rNbQ==
X-Gm-Message-State: AOJu0YxVHqnezVzlsniU72s0Bsly4tODm9MAZBUfNmsyg/w0AEG8QeiF
 Q1KNUU+xtbrsSJi9qcdzXLomWLqDheFrJ63ThazRPjMKrrlrljhUYfsHaqD7efzw2snLF2TLwPu
 +BOw=
X-Gm-Gg: ASbGnctDKBhl1RtPRJzf/Sq7au/+O7blpQK54MBvqdMeXauGfePTR+Z67m+f9w2ttsH
 oZB73Lp6ousI0fB1rQiBV/Lw6PT2tO79kaiIQmYJtlEmUBVEL73v7aGKZgxvxT0xzYpnje8DIKu
 64OyiBNuoUqoD196Utc2a+s5+njgAFCyVdND55K7sNWwQB1lLtkg7G7vCDmwre8r81wbsQzRlev
 Ni77N4vsQUJ+EeG7uWwAjEiTmwWXi/MpG0nDVRDEdAlR+69004i2JoI+OTur/celxhpHwZaXKBd
 KydHO3RxEnWdHL6F7QdiRhOoWUcriLc=
X-Google-Smtp-Source: AGHT+IEkBIux/+pbMKGUmXUe3lf6N1usP/74iCueDCTPlbh4zApMxhiCLes+3rAkj2t8ybp7H2kc1w==
X-Received: by 2002:a5d:59af:0:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a87313151mr17382755f8f.35.1736720469017; 
 Sun, 12 Jan 2025 14:21:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c76esm10367540f8f.47.2025.01.12.14.21.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:21:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 45/49] hw/tricore/triboard: Remove unnecessary use of &first_cpu
Date: Sun, 12 Jan 2025 23:17:21 +0100
Message-ID: <20250112221726.30206-46-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

triboard_machine_init() has access to the single CPU via:

  TriBoardMachineState {
    TC27XSoCState {
      TriCoreCPU cpu;
      ...
    } tc27x_soc;
  } ms;

Pass it as argument to tricore_load_kernel() so we can
remove the &first_cpu global use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20250110180909.83165-1-philmd@linaro.org>
---
 hw/tricore/triboard.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 4dba0259cd3..9cc8d282ff2 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -31,11 +31,10 @@
 #include "hw/tricore/triboard.h"
 #include "hw/tricore/tc27x_soc.h"
 
-static void tricore_load_kernel(const char *kernel_filename)
+static void tricore_load_kernel(TriCoreCPU *cpu, const char *kernel_filename)
 {
     uint64_t entry;
     long kernel_size;
-    TriCoreCPU *cpu;
     CPUTriCoreState *env;
 
     kernel_size = load_elf(kernel_filename, NULL,
@@ -46,7 +45,6 @@ static void tricore_load_kernel(const char *kernel_filename)
         error_report("no kernel file '%s'", kernel_filename);
         exit(1);
     }
-    cpu = TRICORE_CPU(first_cpu);
     env = &cpu->env;
     env->PC = entry;
 }
@@ -62,7 +60,7 @@ static void triboard_machine_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&ms->tc27x_soc), &error_fatal);
 
     if (machine->kernel_filename) {
-        tricore_load_kernel(machine->kernel_filename);
+        tricore_load_kernel(&ms->tc27x_soc.cpu, machine->kernel_filename);
     }
 }
 
-- 
2.47.1


