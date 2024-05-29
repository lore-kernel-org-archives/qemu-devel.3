Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CACC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBg3-0000Ry-RY; Wed, 29 May 2024 01:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBg0-0000Rq-9R
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBfx-0005SQ-MU
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so14456325e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959795; x=1717564595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYfe4vc/CTJtZbzEujtkTGONgqf/hq328cSMsazz6nQ=;
 b=PovN6opYaNu1Hrs/HLw3MrnPJL3+/OYVNXL1EQmHaUXBzhaiz52zr75nqu+h3jiK6Y
 PnhI5u9/4C5572h/+pHO4YuWchPcTjnUVcV4DYd54WuWsCE0aYPjJXEzMSiCeFc+vNEA
 G6sHe9CcT2lu/Hg9oVjNTEDbJ8QRbjdjmgApeXFX5QT6I6i88/DXW0LykyfCrdAc/20F
 Onc4zOI4KtcWXKkZpO0/Ogkt7DJx3W6O/TqvawSOoilZPu0KVs1MFCmtT4KtI1etk0aT
 IS3vpEy+d+vW3p5L7BGXVIi1A7FG54XRzG3JSK+mxsRXbC60fSHH6A8PxPxpAyGFC54w
 ReLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959795; x=1717564595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYfe4vc/CTJtZbzEujtkTGONgqf/hq328cSMsazz6nQ=;
 b=ZjrVeoNqAeR3VJaXL56OSXCFSWqC5x1BZJT3aDRmI/3C+GO1wBgkUDlORYrPNfcWuW
 Y59aaj1TlnNQQ3WrfnQyPvBLDbcJNLYWyDaJvX8JMe5ANL+wfcV+vChxjrM0oJXXVi3N
 dCg+PTTSM9BkBsnRhqdiaX0QGoXMXjoKdrSd176qQA/r9I+yYD0p4eDZOzTwLsCAds0A
 rC18wpvXJrEiGsu6eFgsS/rIMpfZOMyXZ9k1jwGRFPhpoCqDMfrtX53OLELnS8vFsp7/
 J2aE94tTwlh+MRnJR/sWOb4xaOHtrR8ew2BbP9Vb/s1mYikhLVmGr3fpmFPb26ES5eSl
 vuIg==
X-Gm-Message-State: AOJu0Yw0NpX2d6C2fkMYf19xHbeiSVyamydQ8qxpbaGOWi7vQNWX0jnw
 nUnjG/ixjYz4rf5t5GyNVJPPyP9PjWnHbQUz7Q32hLWZi+jJ/P0p2lwPBpK0RfTrNGTAod/6WJ6
 7
X-Google-Smtp-Source: AGHT+IEkc8iKL/RCcL9yCrmvVdFzlzCik27p1E/HI4uJiU+V+1oYdBeXWn5HaP8tj0gi/FpEiBbQqg==
X-Received: by 2002:a05:600c:4f52:b0:41f:fca0:8c09 with SMTP id
 5b1f17b1804b1-42108a15120mr100716555e9.40.1716959795700; 
 Tue, 28 May 2024 22:16:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42108970b4esm166657385e9.14.2024.05.28.22.16.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:16:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 10/23] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Date: Wed, 29 May 2024 07:15:26 +0200
Message-ID: <20240529051539.71210-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

PCMachineClass::smbios_uuid_encoded was only used by the
pc-i440fx-2.1 machine, which got removed. It is now always
true, remove it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/fw_cfg.c     | 3 +--
 hw/i386/pc.c         | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index db0f8e0e36..bbbf58bd42 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -109,7 +109,6 @@ struct PCMachineClass {
     /* SMBIOS compat: */
     bool smbios_defaults;
     bool smbios_legacy_mode;
-    bool smbios_uuid_encoded;
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 6e0d9945d0..f9e8af3bf5 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,8 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
 
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc, mc->name,
-                            pcmc->smbios_uuid_encoded);
+        smbios_set_defaults("QEMU", mc->desc, mc->name, true);
     }
 
     /* tell smbios about cpuid version and features */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f27c9fd98c..4b2a29bf08 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1790,7 +1790,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_acpi_build = true;
     pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
-    pcmc->smbios_uuid_encoded = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_aligned_dimm = true;
-- 
2.41.0


