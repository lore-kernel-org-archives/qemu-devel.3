Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B5CC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyKc-0004SH-GY; Fri, 14 Mar 2025 02:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKB-0004JZ-Su
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:15 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyK8-0005MB-OY
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:14 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223a7065ff8so47701515ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932909; x=1742537709;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k665Fh18kw91BCPxxVd7NaE5lz+GDhDFPDvUkLol1Gk=;
 b=Hu58nvCOjQNQ9+nLzIaWWVCuG5XqS9z0F8MKYPvfaDKp1jSwwADSVpCU34zV2HWkze
 c1geHC8KMsvU0adtOZgjx30aUhODcZMwthQxwopwFKAWyGRur72xAaHqEfxY6j1nlox+
 Im43T8QzwNHoREONpit/JIRHErV+GN1GWEvVi17+OzWT2c5sVHDRTddBcIHNXOxKZbNT
 5jbAi8aqnDddsU/zi5EQ/CoMH10JeTtr8tqPc9KBJ4nOPc+IT/pyxvqVX3DPXk2XemCd
 4Fd0ZZlAuag05N2heqZTdviVVM6n8oZR05jvLxGi9/BjHqiY2Xad/uRgQ/2VtsGyxWJe
 pdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932909; x=1742537709;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k665Fh18kw91BCPxxVd7NaE5lz+GDhDFPDvUkLol1Gk=;
 b=cpfWyK2x1nWkzMIyIXGOUCJv1cxeApxl/nJac7Af8CVx3TOxiG0OeuaadLNiIv+d5b
 NjfkdEliC3Idz81ff95GoDIRtRDkQeiSri8Iey1/hTnc6Ajw2EvhQHrL3q2sfq2mmwMz
 jErZjjqm4d0Uv7s4ibCdQh1HrV4jAYPL2qEhRQMSdgz3eh4hBawqohxjiFYuJ5Gi4bLT
 LCf070H2a9x/QUQi/N4JiNpP6YlAKNk299uo/u0Kid49MTdsQgGYRvAYh0716K7fCSnb
 0j34GfBoZSqcjQHBYnFA4hdOjzwQe193smM6g6am+c7aWkai/VRrgDXzRvUBuT6P0596
 gZYQ==
X-Gm-Message-State: AOJu0Yz4QwsmHhZ6XchaasJWQ5XINnw+W2pUhz02yi/TpDOXH9cfX3N6
 ZmK7ndtZdjRtV3TwNZVIJ+BCb6wVf+duTXOWlD68AWd5+XdkXqbK2NChes/pUIE=
X-Gm-Gg: ASbGncuOfwyuqh41/muRAB5H+5U2m/OqulBtQriiNfL8HLymlDh4e3XB/p/g1Fy9IOX
 TF6ALXX7pzzsWvGgnozpyHRpnBKT0x8c9X4zPgmWvzs4R7lgTa28pDm4TU/2bM7v98JtusSoWIP
 PfOPkSwOrg3qyw3mW2xu2RzfjQx6t7pHV0uRouIPOluFiP8u7NBmqtmhGQg54WQvtI+j4a/KSYb
 dnGYMUDBoLJcP3V75t6Z4ozpLy3zl/Vf5kTlRkrWFQjIzw2pVV+etXbwiaRwhO4v+Y2gFecbQ/E
 bn46aIJdUi4MbX3fbQymnN7uwLX0yJ52R1/0JjCzbhN1ukf4
X-Google-Smtp-Source: AGHT+IGGwftsg7jjo3HfL0xLGNqUwjtAgMYFYjTwF6zewHTMb00bK+AJFXgoppenTspVwmBL7dF4mQ==
X-Received: by 2002:a05:6a20:2d12:b0:1f5:874c:c987 with SMTP id
 adf61e73a8af0-1f5c117814amr2356082637.15.1741932909375; 
 Thu, 13 Mar 2025 23:15:09 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-af56e9e1beesm2238763a12.27.2025.03.13.23.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:50 +0900
Subject: [PATCH for-10.1 v9 1/9] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-1-57dae8ae3ab5@daynix.com>
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2844ec55560f..8460b6105338 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2522,6 +2522,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar > 0) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {

-- 
2.48.1


