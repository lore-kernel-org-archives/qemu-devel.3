Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA1D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFP-0005Ip-0G; Mon, 25 Nov 2024 14:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFH-0005AZ-Hk
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:43 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFA-0004qe-6j
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:43 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3822ba3cdbcso3014201f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564775; x=1733169575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a59XHnG8h+nIeFzh80GUuHguY0Zka09dW1/TbkEKxDk=;
 b=pprp2SViVYifoJn3Kcq5KOfLqCasJhpKzWWwaH7WDQpsWMIOpIwKPI7fc9JlRBFHa2
 rcwCjfFPICqZ9gbPMx6kg2tMVoCEA9dx+/KR8gel8h35UIuDJqppeRKLUu5FSOZwjrnv
 e9iloj+43He6qmjh5qpGvhY4cZ1HYwvVzwIOVT4tO/GG5NlEW1Alet8Lar/PNGqZ7sCN
 UOhXVQeUUWljQxhqIipMjy/UU7BkY7Eqm7+ULkPrH+27kQdNnUG8autZtH7DGiXQV+09
 0k6ydZbvnaFWVJNvX4LXrTW+tAnGbmBKmr8hA4n7zqzRoL9Fa7ny8fcNuwNuiBbBTILw
 FrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564775; x=1733169575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a59XHnG8h+nIeFzh80GUuHguY0Zka09dW1/TbkEKxDk=;
 b=wZ+MWl+1IWOLhtDGxk64vn1ouCNxZmMB47DFyTSzjffduatRUJN98z8ie9GyIFj4x0
 0t+lwb74ajdl5GU545vRM9/tLh/iVylB9Sc++qT7rjxsOq6k0bEQeWkTYmul31GKT0vw
 c3gZ1RZND/JnqPpHaPmAFTN7crSP7EZC3LB/JwkwQFaiz/xgwi+WM5yaowMUfTVZ6Fbr
 eeWlfSctjQW8J5eWt3IFu/G0b9s7vd4gWiBlOpWlQWw8BGFHF+Zps7ivXYa5TjoKEhcn
 cAs5gBPKwCZLRZWLCdBS8CySndFhby+XUDxE2acvY5TAnR4jmD2ZjDT8qGNb5l5xjdgv
 DYCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV4ViuKeAAbEgRYXVrCxc0/5KjUItyit2G3uoGjSWARNUvWQmONZiX77JFC7eMSRCaCrbUSzGEmLtl@nongnu.org
X-Gm-Message-State: AOJu0YxoWk2I+8ZuVb11BPGOMBVpLvoHdfegAm5nJs4kB4HY4SFchbU0
 hMtq08HHghAopW8VgMZuQKOioQ3zkzA7JQ79BaAbCbrK01+fLrhUYt7vubKoJR8=
X-Gm-Gg: ASbGnctunQArlFsDe1kJdmvHr0cfz1txsVJZKWHH1MdvSDrArCu9fUa/MQP8czsAamS
 nPIxKBSJd1Ta8ZzARMs6IFI5roRwDJob6wG+aUaCLLTBGhkS98Lky3Z2rA+rMmzVmExPV6XM92b
 Z+cTPRKBD7hfJHQa6OxzJQIc/M084kcDDck6W9iuKUeHneB3A2XPk8IO89HFCkth4Tux5JFdCwA
 ugbvWKJnXQFFss9FM7pXDYY9HIQ99+JETce+hm10TVQShs8GXBnTVgD4fcuE/vob4IY
X-Google-Smtp-Source: AGHT+IHw3piCsY1SYgCrnqKdV96wffE5D/aAxPSvz1IACBcKd/oVvMDVzCGHC+uO8C/BpUQCIXl+JQ==
X-Received: by 2002:a05:6000:184d:b0:382:4b5c:419d with SMTP id
 ffacd0b85a97d-38260b878e1mr11702601f8f.28.1732564774795; 
 Mon, 25 Nov 2024 11:59:34 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:34 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 18/26] hw/arm/boot: Mark all guest memory as RIPAS_RAM.
Date: Mon, 25 Nov 2024 19:56:17 +0000
Message-ID: <20241125195626.856992-20-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42d.google.com
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

All Realm IPA states are by default RIPAS_EMPTY, and accessing them in
that state causes injection of synchronous exception. Either the loader
or the guest needs to set IPA state to RIPAS_RAM before accessing it.
Since a Linux guest needs all memory ready at boot [1], initialize it
here.

[1] https://docs.kernel.org/arch/arm64/booting.html
    https://lore.kernel.org/all/20241004144307.66199-12-steven.price@arm.com/

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: New: the Linux guest does not initialize RIPAS itself anymore,
and expects the loader to do it.
---
 hw/arm/boot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5301d8d318..a2414b1f98 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -26,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "kvm_arm.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
@@ -1238,6 +1239,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
     info->dtb_filename = ms->dtb;
     info->dtb_limit = 0;
 
+    /* Mark all Realm memory as RAM */
+    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
+
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
         arm_setup_firmware_boot(cpu, info);
-- 
2.47.0


