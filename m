Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C672C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbGU-0003J2-AB; Tue, 18 Jun 2024 12:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbGN-0003Gq-9B
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:00:51 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbGL-0006jV-Lr
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:00:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so1498525a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726448; x=1719331248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hsn1dzY26DF1TLxl9KireRz1A8Sf8ZBFLuWm3kWcmI=;
 b=AIZaWhQfJcJKlb1HjPXlrqbFKmOpnwXozCyJH20MRnmIPxm0O8rP9GzMiIRJ7Tnk9W
 RqCadU554s7xsP/JT3dDhsCh2og0ftXtbj65XujWJks+HdByCZAdrrsHzWopPbb+VjbZ
 4cXO11bIixnupPvcocJL8ewp22JThkSHgA04fde+/P/XVMWQhvDEekR21IRHjzHfeD89
 shO0lxdNLzCvnuw/SV2yE/jLL162ML8riXQORN7PReQvWFK/r/6oOr9khuOAlxIxeQBu
 NNQOZ/Vn4xkhpl/1TQ3XYT8JhZN3A8ad8eUo9g7qbeMEkr7pgiFgGRwBEna4OQ6a5ogF
 PU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726448; x=1719331248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hsn1dzY26DF1TLxl9KireRz1A8Sf8ZBFLuWm3kWcmI=;
 b=Y3DelLSljD/sCs2Kdq5ctY4keRxYEcEtv/8BPNptL4fi7IGS7PX1+NDY9+Z7+NsKWj
 lSf0fL7d1DLpP6CbPxk849qJqu6POFwRXKLL05dOM9wkoSzswxVah/H5EiDSWFUKUs2L
 V9x1mcbS/TVSn2t1mbCvknILr8/PW8s9yl+ble7JDkSfFjNTo6zXzBXQ0OKrktEC7Yti
 UBHEhC8SoYDXuVmizv4QY0izdABiVpQ4jA9IlXq4B87Foad7Y0jNX7MvNbiFqS5TRIVR
 +lVEfb+Af8ALiLEnJ44182lNh+okbeqQ/Wu+Y8W/B9U1rj8JfH8fYmpTCNwy+Ba8W3vd
 QgSQ==
X-Gm-Message-State: AOJu0YzzOq+LsfKKiZtonPWNRb7DIj3CC6IdlmT2z7MVcY/XvfwvqSkn
 Ts9k/uB0amloyi611V5E0O9bxbfDg0S1oWg8Vm8k3Kadsyc8I6t7X4CVnkCOiCkXuMicAbRXtRI
 3
X-Google-Smtp-Source: AGHT+IEbux0/JDxRYooh7zJXJwXy0LAikIw3kqyH+y6w4JxSMWmTyowpNt/vHNK8wLfOiOhzYwScwQ==
X-Received: by 2002:a17:906:c243:b0:a6f:1839:ed48 with SMTP id
 a640c23a62f3a-a6f60de24c9mr1047303066b.66.1718726447743; 
 Tue, 18 Jun 2024 09:00:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa416asm634920566b.224.2024.06.18.09.00.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:00:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 01/76] hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
Date: Tue, 18 Jun 2024 17:59:23 +0200
Message-ID: <20240618160039.36108-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Similarly to the commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated",
deprecate the 2.4 to 2.12 machines.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-2-philmd@linaro.org>
---
 docs/about/deprecated.rst | 4 ++--
 hw/i386/pc_piix.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b62877e51c..66a5f43626 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -212,8 +212,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ebb51de380..02878060d0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -742,6 +742,7 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_3_0_machine_options(m);
+    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
@@ -847,7 +848,6 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version = "2.3.0";
-    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
 }
-- 
2.41.0


