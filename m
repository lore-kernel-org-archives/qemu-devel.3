Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4469C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9oNi-00052V-Jf; Tue, 29 Apr 2025 13:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u9oNh-0004zj-4b
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:04:29 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u9oNf-0004oI-EO
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:04:28 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30384072398so5366526a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745946265; x=1746551065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pXfIvvLPEoJkDhc+UeevpmG/kxQGyml4Jhd4d3dRFg=;
 b=Y3DaX+3zyHgTWI/YoPPPPOCphSpOFwbtTHR/zBJ5ZmE8lT4hljhiczB6L76EA1CRnz
 u/k21aAqFg/GSxMOc4cuSRMtOO2SQZ3hMy6xvgFqYo/xLKlWnJ9VAbZGsxWlcIZbMJ/+
 +JlZoJ7igseiZ6gvMimMkc16SrCf6TfBPF/vHzb0EViFF6vmsgKLCx+7X9HapQY3b6t3
 4xy4Ir7nfN3oiO1WTF+9qzHnshnEHdUoEYBNGnq5IqtrIzYVWmwIS5OYguGbaJphdV5q
 kfSKmrrpzGQc/yAYNYGc8TElC+5jGPv+21vaumZy3U3PfizxX7ON0SCwnSTotZ2v1ipc
 C2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745946265; x=1746551065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pXfIvvLPEoJkDhc+UeevpmG/kxQGyml4Jhd4d3dRFg=;
 b=iAxFEwby3LK3qtTAfyE7ir4g7C0aqMeCqOYn8ZU86JbgOyP+wCBlYD2IC9IzqBHT3M
 6wo5PYiYsSvNL9KjjUxtiBRDkfUOb1gfc1aUbC6ZwW49qQZEYJiaqprv3HsULyrEUi6W
 Ax8fp1u3R4fjU9Vg/8gH7TYV2+kQTBCjvSqIvcrsNywhHlBDnGfOWyRKkIz/+X9RYNXz
 tyL3lOz+U096r0dtiMD+wyqZjXy3g8fepZpugv3GiOTGobV58bWKLvEUkrH00ArhVBF6
 mi4Ompy9rmHo6z27Q19tFR7eCP1hElQmMVWOJMuq63PuLo2G++61+jm8LZznhlZloxPh
 DMRw==
X-Gm-Message-State: AOJu0Yx1SbCeQBbINe7TIqZQ9APtx1Fw4EFJaKxjRRlvo6PlE08TG9Ko
 pv3HqEcX+bbAZBSwBaWJWSEhqXalTYApI+0YxN1Iik1DGTAfjbyNQCnCgQ==
X-Gm-Gg: ASbGncveHUexcMDYzEIKJRrkMc50NRkhg1R5hG4Lv2F+u3j+zwHnvradDd6IrPoRNCK
 H2Iv4odIfOPSSpjkzWqJcw5+5Xk/hnZvsfcjXo2JG11wJjb/FVL50TSBahWRmq1uyqIE/9utpj6
 jarjbZSmNaqb0atHBVMb7MXnG50yFrOZuzkVq+8VlWBYj4zOCt7XYfhQipVNgUB3o0WoF9msagp
 YE0uE8k2IVUQzS1kp6CmC7fDlbIxLMg0aRMN2JYng9VfdWRfg1IdlaTstaeX/nxham291MHkNeC
 KxocwOe5eCUZDCSnsbgVaReOFQvLj6j9xWM/GeNVHLWnVL+w
X-Google-Smtp-Source: AGHT+IEc2hRXVvRnzcIirO/+1rtfUIfy2I3o1g/5fUAWYTpibv0yNgr4C0fuC8NqXBvFb3OAvX5okQ==
X-Received: by 2002:a17:90b:254d:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-30a23de9182mr5104361a91.17.1745946265349; 
 Tue, 29 Apr 2025 10:04:25 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2012:c135:ab3b:a163:4eeb:c538])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef03bb26sm12678043a91.6.2025.04.29.10.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:04:25 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, thuth@redhat.com,
 balaton@eik.bme.hu, rakeshjb010@gmail.com
Subject: [PATCH v5 2/2] hw/pci-host: Remove unused pci_host_data_be_ops
Date: Tue, 29 Apr 2025 22:33:54 +0530
Message-ID: <20250429170354.150581-3-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429170354.150581-1-rakeshjb010@gmail.com>
References: <20250429170354.150581-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

pci_host_data_be_ops became unused after endianness fixes

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci_host.c          | 6 ------
 include/hw/pci-host/dino.h | 4 ----
 include/hw/pci/pci_host.h  | 1 -
 3 files changed, 11 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index abe83bbab8..7179d99178 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-const MemoryRegionOps pci_host_data_be_ops = {
-    .read = pci_host_data_read,
-    .write = pci_host_data_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static bool pci_host_needed(void *opaque)
 {
     PCIHostState *s = opaque;
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index fd7975c798..5dc8cdf610 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -109,10 +109,6 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
 struct DinoState {
     PCIHostState parent_obj;
 
-    /*
-     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
-     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
-     */
     uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
 
     uint32_t iar0;
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index e52d8ec2cd..954dd446fa 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
 extern const MemoryRegionOps pci_host_data_le_ops;
-extern const MemoryRegionOps pci_host_data_be_ops;
 
 #endif /* PCI_HOST_H */
-- 
2.43.0


