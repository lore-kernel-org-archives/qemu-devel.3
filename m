Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1A2C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwj-0006ir-FU; Wed, 02 Jul 2025 06:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwX-0006g2-Jr
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:59 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwP-0001Jc-Ae
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:57 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60c51860bf5so11214363a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453024; x=1752057824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qecS0tIoe0ls7nw8T86Ife3RJh0yHDOjkyPB/fpRPNc=;
 b=itPZdPCv72aKkdPH7jgkwwE9ZGDYQx5pS/051e0ch0Blmp9MMCXhArhi4tYsrqnpdk
 tqR/Zpa2kSD0f5yW1GQ9apcKeZcAhYWEJFEXzF+s742APbvheu0TaiB90Bwh5vlVBSWj
 7Js5LO8b2O4P179rN7p1vsmDH1dgKw1CglG6pfoPmcOZCy+45cWSctknPMo5Drbbz+hr
 s1K2bAzQGFYk3wsIMvgTivj7H0FhxwDhGYqgjqZtxhqq/OmjWsioMdBIVlItMuNUusR9
 W+lJirjAwuZO5ff1+65JsCFjhhiQzxTFFjQ4NPBdKck2k7FtVZVLd6ds9oWd+FbPmtSQ
 Rp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453024; x=1752057824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qecS0tIoe0ls7nw8T86Ife3RJh0yHDOjkyPB/fpRPNc=;
 b=kLW4q+ZPwysfn/Z2XVnNbRdscihivUNdYniS6hIKFRnjzKSXa2yvalEParELL/7QKQ
 EHzmtu6wEW6nhmhBkO+ET5Nx2qFgoBfwrvNHfzjlrJLu4hCIKwVQjU7F8S7OCt9+zhYd
 vvXltmrAEaXZe1i0cScDPazE6cmC2UsVBMSJ1T9b+nrYC52QmvFRWZeN4XI8FaKmh9/q
 wfaxK1kA+bmymW+p6yRxd2LIcOsAr1Nl52Waekq0jCODrbrRqT1XA703aE/7S3aCHn4n
 2EcP/Wfao1R2KddQ1AWab7p4kOdEYe5zvNUnxL7lXafUwqjW1mFi2BqM7hI4UmBm3NTU
 Uewg==
X-Gm-Message-State: AOJu0Yw+Ih2Sd1VnVG65zg+Yjl9NrNpAShdApiuPGk5pKgbLlmPj8hGy
 CaJqRboAdcSDQriFhEqmdYUCrNDChl98afSVVUmKrLD/rmX/k7Gtj0Fva98pVBP/itU=
X-Gm-Gg: ASbGncsMjvRpTb483YFCXpi3pW4ffZjWSceDQDrNAOJbLpnOIbyqeW770KI5Mi/wleb
 UPsYdmtEtyysdjFqGYgGCNfWjpB+XPstk+OWL4Btay3hATrp26zVxg6F5mkRzfW8ldlI7gZaKE1
 BrAe9kTndHVGDbibWTpLsmdlKDgI9ZQiZ51Au6LPvAe696RSbAcwZIB2klYkJuDuMCoR7URgc2z
 wuJ/nuwGbxktQSZP3wFnN8cgiffYO+oim/SoG1frJh1BGrDcNqNc9Wt50NecS+a/IOk6k+f4ms0
 AHjLad5F8CMMaWG/PWqv61GFI/su82l75ho1CIeU98/tNVnkynkXLu5us11y9VU=
X-Google-Smtp-Source: AGHT+IGKFxBc0IKymfZi5lAnMERXh0IK39138Ys1k2mAGPuaM7raXlDl5uXk0t2RD2aR7HbSKEKSAA==
X-Received: by 2002:a05:6402:2685:b0:60c:461e:7199 with SMTP id
 4fb4d7f45d1cf-60e52cd31d5mr1816202a12.9.1751453024506; 
 Wed, 02 Jul 2025 03:43:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c8321a08fsm8757433a12.78.2025.07.02.03.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EF6C5F8DB;
 Wed, 02 Jul 2025 11:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/15] gdbstub: Expose gdb_write_register function to consumers
 of gdbstub
Date: Wed,  2 Jul 2025 11:43:26 +0100
Message-ID: <20250702104336.3775206-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch exposes the gdb_write_register function from
gdbstub/gdbstub.c via the exec/gdbstub.h header file to support use in
plugins to write register contents.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-2-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-6-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0675b0b646..a16c0051ce 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -124,6 +124,20 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
  */
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 
+/**
+ * gdb_write_register() - Write a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the register contents will be set to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * The size of @buf must be at least the size of the register being
+ * written.
+ *
+ * Return: The number of written bytes, or 0 if an error occurred (for
+ * example, an unknown register was provided).
+ */
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
+
 /**
  * typedef GDBRegDesc - a register description from gdbstub
  */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index def0b7e877..dd5fb5667c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -535,7 +535,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     return 0;
 }
 
-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     GDBRegisterState *r;
 
-- 
2.47.2


