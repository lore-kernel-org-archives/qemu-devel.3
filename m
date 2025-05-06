Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852C2C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJX6-0001Wn-7t; Tue, 06 May 2025 10:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVI-0001nJ-UQ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVG-00028l-GF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so35758605e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542556; x=1747147356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A2xms1nxRmqWl4bVsTwmg4X2TDs1x1MpUAQTmcG45wI=;
 b=LtISyPspAnKo+8slG46fu7QdSw9yguIUhchVBLtu64u5/26vn4qpIUNaPU5BDP3wgm
 HCF9oJMW+Hkb3v7288ECVvS7gKv8Mt6/t0R951WldNk7bW8fzi4vazZWfYP/jbSozzum
 jjZwm1ezYWv+ef0nbvC5jT8LuhINsZRcla948QqTdYR8dPmAjgzCCekGmY58X0WiTbPA
 eHcHUHpgeOwgxaF/17SMOuSxLK6tB3g3KoQwOKzyloumMB4TKoFN5tu+/cdr3WQ4xVvW
 cEFUy4SWGG9FkSwws74ATA0SnIz7506lkRIyyojQzbEaVAVNy5NFzCexF+wT1aSaXMLd
 v5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542556; x=1747147356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2xms1nxRmqWl4bVsTwmg4X2TDs1x1MpUAQTmcG45wI=;
 b=qfBCIKCWh3nldo/lYGQO4/NAsKd3SKdtzGk83mpUYdMMVxZFtOR9jAbX3qPyCGHEF+
 9ybv77lZbZhIfbzlw4ilG/kmKI0x1ItHtr3D40X39yAu0i5kmkyiKzdNZtWmYLbB4rQW
 t7k0y9uQixMjFHiqerXzbT5bW5WLWjuTJdwxKdBrPTW6amOdrAU3Cqll1zUnB9i18KYr
 BeOryHNLp8IfXAaDCFSVeDD+P+y4tmw4q2FyvqxwwPnxJRbxzZW8P+126ox/Ap50CyCe
 S5g64gDVI0oerTuU9wDV1ttl78lBs7xjuR6gVt5/3vSBRtyLxUtdmCQ5rAZ/zS3qgtHW
 qn6A==
X-Gm-Message-State: AOJu0Yx+30Gcoq2fgi3nBCB8USz5bI+MDTU2hqBqdff6BPHhEJOlIz6A
 ekR7MHCLhJ8E1b5oP4SotUpcgPlT+37XK30ofcQXJo9GR19VDaw3iVkExzOM8DfBqAXl3OF9iGd
 A
X-Gm-Gg: ASbGncugUC28WKJfUzcjmpg51PvGQm5JvaMcALNLWDSxY6n054r3EDQsm2p/TKg9npL
 LcaOQ0rAfKgbZZ2pDxxw3JUSSGGgoGgggdDaeY+4F0TRscZB9mKeb8WISUyP+7r+hpCOhPDiIZy
 dzr3tWNtLYMC7qGW0o3lq1bHIlza4d8JXWnHTA+rQgdwRMbf0w3csJn6/+Yz2E2VDuPlTeTRx2V
 Qqz+YyQHd7PernXo0wNddUV9ej5E97PmqmnEyZ5kWx8mZ9sWC8AKgVIYXTCzp8Bztuait4OpKiH
 qs/YcZSpofVYl1xTCP24vHOMjofKQ9wtcuCVoSCNBvyuVQY=
X-Google-Smtp-Source: AGHT+IFkHQaheap5aa6mq6/88aZDcGKlsOPhjJXyJ5lEAbo08iq8a6pMbzUTiq3ZvzVWBOKL1RvS9Q==
X-Received: by 2002:a05:600c:1d0f:b0:441:d228:3a07 with SMTP id
 5b1f17b1804b1-441d3a78faemr141915e9.13.1746542556698; 
 Tue, 06 May 2025 07:42:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/32] hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver
 field
Date: Tue,  6 May 2025 15:42:00 +0100
Message-ID: <20250506144214.1221450-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtMachineClass::smbios_old_sys_ver field was
only used by virt-2.11 machine, which got removed.
Remove it and simplify virt_build_smbios().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9c531e28d04..b2cc012a402 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -118,7 +118,6 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
-    bool smbios_old_sys_ver;
     bool no_highmem_compact;
     bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4b21f3226f9..3488bc4fb9d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1699,7 +1699,6 @@ static void virt_build_smbios(VirtMachineState *vms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(vms);
     MachineState *ms = MACHINE(vms);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area mem_array;
@@ -1709,8 +1708,7 @@ static void virt_build_smbios(VirtMachineState *vms)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product,
-                        vmc->smbios_old_sys_ver ? "1.0" : mc->name);
+    smbios_set_defaults("QEMU", product, mc->name);
 
     /* build the array of physical mem area from base_memmap */
     mem_array.address = vms->memmap[VIRT_MEM].base;
-- 
2.43.0


