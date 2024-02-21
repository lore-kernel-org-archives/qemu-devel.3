Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD5FC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyY-0004X0-Fw; Wed, 21 Feb 2024 16:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyP-0003WG-Q3
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:50 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyN-0000z5-BJ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:49 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d26da3e15so126531f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550264; x=1709155064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TS/v5N8VdhzRmhkYhnKkjLky4Kvoae1G5ndSJvSbSPI=;
 b=qe8mzHBkyj6O/Omp2SsxsOjnG1sBVQRdEBzjCBFGHCIm29qXDuHR0hCpUd68Ki/Cbp
 nMxIMdYLvRjNvECbzOBEjd0oUiRii244jH720dTlMLxYQuhU8MoTTyCWeYY7YH3cQ5Ii
 lLR00QW83OHR1u+uHQVxkI7KkNHZyTmNnN8a/ZkCAdehFOeJ64GUc6fglig71E/uVqnH
 AQXNnB8qVRVtDCbnNmTu/0vTKkbydtHr3s9j2xXIuaSYKtqXOHD7owsXVr89rtOlfD0D
 3vSYjkwBzqZgW952fwZS5hkLUwKyK1fR+w9odJ7zFzZJ+7BUyn4c89aD/7mQmdBh9iPB
 rFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550264; x=1709155064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TS/v5N8VdhzRmhkYhnKkjLky4Kvoae1G5ndSJvSbSPI=;
 b=pJhSjmK9Y65kikdURIGUlZ+MNX+UQ5fmyhwGhCPEDXZvGNGwN/I8NmiDErOOntx7O5
 YGMRfLTBSRPBg0PFE+95EIwh74ycbuiKDLLrF6kgj8em8LiFFZiTpJkwAUFtnUBAUHFQ
 Yta7bFxLI4kZDxRcqQk4Duu9KAOrkoMgQwGRNIs/gv/idzLXyTzsLOjNgtltHDbwFuHL
 3V7HfA4JUFq/F0lyEM9K9DuTkE+vfwJrhO8ILafAH8CT+Ej0NMfT0SFIYiyzcYpJPZ4c
 OV6pAmkCzN0utLidSDXh7mPueMpAjPV49vwd0DfTDXMBYfwoBCX3jsSPFxFSg6Yoh2ia
 DF5g==
X-Gm-Message-State: AOJu0Yx7vV24sDM078AOvMoLlK37jJw+4Q7O4e8TCMPBrH6mdRYr4onx
 3043TtkkMyhB54DQsvHFHl8K8v5j7f8axJPXUB2jHPRBHs2P9vTt3IpXO5b0Y7tRiv3xnv5APJv
 D5Bo=
X-Google-Smtp-Source: AGHT+IFfLHK3TMMn59JlfPjRduUTVlyACZCCgT6GwnUvXVCJEoySOCu4hkxH0a6W8hDsoGZgOljxfw==
X-Received: by 2002:a5d:4fce:0:b0:33d:27c3:9f47 with SMTP id
 h14-20020a5d4fce000000b0033d27c39f47mr480220wrw.35.1708550264622; 
 Wed, 21 Feb 2024 13:17:44 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm18846364wmo.16.2024.02.21.13.17.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:17:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 08/25] hw/i386/pc_piix: Share pc_cmos_init() invocation between
 pc and isapc machines
Date: Wed, 21 Feb 2024 22:16:08 +0100
Message-ID: <20240221211626.48190-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Both invocations are the same and either one is always executed. Avoid this
redundancy.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240208220349.4948-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 999b7b806c..9064511507 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -341,11 +341,8 @@ static void pc_init1(MachineState *machine,
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
 
-    if (pcmc->pci_enabled) {
-        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
-    }
 #ifdef CONFIG_IDE_ISA
-    else {
+    if (!pcmc->pci_enabled) {
         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
         int i;
 
@@ -363,10 +360,11 @@ static void pc_init1(MachineState *machine,
             busname[4] = '0' + i;
             idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
         }
-        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
     }
 #endif
 
+    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.41.0


