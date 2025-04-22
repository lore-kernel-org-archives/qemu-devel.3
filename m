Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB162C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F3G-0000FX-DZ; Tue, 22 Apr 2025 10:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2x-0007kT-HV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2v-0005HB-HN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so36535005e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333783; x=1745938583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//lWNuvQ6UGw8pV9YB76t13j7KMrlQtFLuwBcbqd4aA=;
 b=Nigl8UwaQaq34CnYOnwyLwn/7cwaTg7pV2MAuLtKdL3pahuexFc914wHO2A93FlHTr
 jRseqi5GKaPCwF3Ct/AvVk53jglcfZY+niHyvTVBDG4Gdfo8fMU1gJMXkf8fCVGMTPKr
 EyEt4Xf2hcTqn54PbSWhcfdmT8SUzmWRJkjlAZMiJ00DqOGgPJygyK/VhcPjTpn/Y7AN
 IQXe4d27c99u8HuolnidJkS+KTXGM0+WQ5Ujiz2i7ySHFkGnM5FFPvsguidgDIbivEzf
 XVkQmKDpOkeznxYErA68XiumaL9MS2dEuTQxXA6DDwx7Ufb41Y8zbwphO5aQpLrvrrnu
 /0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333783; x=1745938583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//lWNuvQ6UGw8pV9YB76t13j7KMrlQtFLuwBcbqd4aA=;
 b=c3jzV70IiPpAw/ZbWyRT72IMfjNVHp7DVohKO55U3V/QbcpwWo9M3EwsPw10rZEikp
 5AAxeYnLxeHGxbBN1EXt29XSGNQgHnEUFZpGSsutchb0UtKYDVHp+OgD1OGvyHGW6XQP
 wd2gQ/ImMpQwvDcPlYGWqSADQ2PsadOSX/RWexcnI7B/MXQQFBfKP2SPsuFKjE24KFCs
 jfx/fs3z8AClZqHM5uSf0NtBh6VQkgn6zekQGpKVDuYBdWG5aaf/kWKIxB6F2E1bP4VR
 mLd7/Xf/rgVvsqxZ4Bsnl8iWghX+be8A1ovMPJwpDPe+4r4xlFrwBF1lqytwboohfMPe
 a22Q==
X-Gm-Message-State: AOJu0YyCdGB0u/ipRgOPfNe42K2fIktu/pZrmiQBkuLW3aJysghg7bgA
 j2LoZsWYbt/DGx0oJpFP1Oa5rpvSStaLakNeuOsDUwlt/PcUUIAwYNNkDrsMi33xZGvSxV1JrJX
 k
X-Gm-Gg: ASbGncv31d4ye7F0iW9bdpK9m8aKjWFNjLVhL7S5fYnY9QT83t3vBlaoZokJLxQ3F/n
 AyXgLP/CNhHjUZgloQ3sHDQ2wQnRAxGhjulPuzLe2iV+GXA76G2zPl2YtmagsULSPrgR+6Mp4NY
 XOzLs4vR+Mv36f8JMyyYlS2XBZZE9pv7JthD04eC75kDyZ2cvOvHxBrFRgcf5OWIN6cQGnnWr0H
 j0C72IpGxnfW05bTQyqZ7YAupRWQPjKyOsSZGP+qfudhq6a2k+BRyI07bh+B2qhVUD24L5kb15X
 MVTFwxe0oL+HnbwXtXdjB27JIHg1Cjio8MjOZVTKI/pmYWkPXQb8LJhLvBeyBcLAR1hAy6TttXk
 usgBkoZaiIBQyyxY=
X-Google-Smtp-Source: AGHT+IGBjDesCYXEWUBP+sFv6d5whiPkKTQJizkHxFBAXyr+qjIXDWqp/MBxhYc/BQLDvnmABzhCew==
X-Received: by 2002:a05:600c:13c3:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-440697104f3mr121451035e9.5.1745333782851; 
 Tue, 22 Apr 2025 07:56:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408c7cfcabsm13658495e9.0.2025.04.22.07.56.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 17/19] hw/core: Get default_cpu_type calling
 machine_class_default_cpu_type()
Date: Tue, 22 Apr 2025 16:54:59 +0200
Message-ID: <20250422145502.70770-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Since commit 62b4a227a33 the default cpu type can come from the
valid_cpu_types[] array. Call the machine_class_default_cpu_type()
instead of accessing MachineClass::default_cpu_type field.

Cc: qemu-stable@nongnu.org
Fixes: 62b4a227a33 ("hw/core: Add machine_class_default_cpu_type()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Gavin Shan <gshan@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 5 +++--
 target/ppc/cpu_init.c      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 529ce8dd9a0..a8f8f8c8138 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -73,6 +73,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+        const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
 
         info = g_malloc0(sizeof(*info));
@@ -91,8 +92,8 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         info->numa_mem_supported = mc->numa_mem_supported;
         info->deprecated = !!mc->deprecation_reason;
         info->acpi = !!object_class_property_find(OBJECT_CLASS(mc), "acpi");
-        if (mc->default_cpu_type) {
-            info->default_cpu_type = g_strdup(mc->default_cpu_type);
+        if (default_cpu_type) {
+            info->default_cpu_type = g_strdup(default_cpu_type);
         }
         if (mc->default_ram_id) {
             info->default_ram_id = g_strdup(mc->default_ram_id);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a3dff0814d1..2c0db2a05a9 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7081,7 +7081,7 @@ ObjectClass *ppc_cpu_class_by_name(const char *name)
     if (strcmp(name, "max") == 0) {
         MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
         if (mc) {
-            return object_class_by_name(mc->default_cpu_type);
+            return object_class_by_name(machine_class_default_cpu_type(mc));
         }
     }
 #endif
-- 
2.47.1


