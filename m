Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F60E77199
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz69-0003YN-Mn; Sat, 04 Jan 2025 03:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz65-0003Wl-DZ
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:25 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz64-0006eU-1Q
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-219f8263ae0so136955335ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977683; x=1736582483;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pf5SZ6e3cD61gqtSQU/hVD3w+JbOpHtrUnhXJppalog=;
 b=PdlIknEujYSbYgGRr9gpokQ5w2eGwqMlXGau7fXI2x8W15GjelWWzpTHHVmUB4hVfh
 7YW3irRpc7a2xrNjXzCBFS+iPSFH17xlzGjr7JcuVK9DhTJZUA0XJ+HnZbqw0Eq+Tg20
 n2m6jbIp5P4zFOi5rHWU8BW7TkN1Fd7sKqQcyf8ZmIRrNhDhSLERO/2vS9ggHUeVmXGR
 qb4USu3fIpjWNM5B6oxL2IL+Q8Xv0eJ3/VDvppucfwpmsuSNo8TGUxqf8ukFHFMzJ+6k
 dzwTDVDV0YqFqdcEncRpAa6BjQYWUXKfAEdW6NGNP9ZPYyr/5kuDL+o4V1BmbAO0J8nq
 DWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977683; x=1736582483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pf5SZ6e3cD61gqtSQU/hVD3w+JbOpHtrUnhXJppalog=;
 b=wKndTP3tjVhB/1b/hwDazvxIAL+9drVqo2s8jIndbBkUeJ88EMd5QhSJW6iEYY9Omd
 jF7Vjow7akEEd4h1nUbZrUhVRQ28GM/jcdRAyPTDWiQAVunbZvWwEW7GNy8/B9WRq49M
 1QXY44PntCmE0yojuSo1EcebnaWcjXie4Y1DdYtTqss6J2exXkcFZraDczMN2byd7c7g
 vnF53lDWohf32fNCGEPd/Ysx3jvavawW+XmeSw2IDHFQqgDP7ZdEYSjOW3i/u4/I/+hp
 HdOsGpHts2A8nu9rR8HrPj/xf2jgKuPdOMFlluEUs2KckArp6rb5IvOVOzz8CMLUKP89
 2nwg==
X-Gm-Message-State: AOJu0YzsjrNQigPHu97PyTCthuNyl7uGz7oTzwPC+Px5z7WIWMQxNPPq
 8vgeFeoMoDQ9zjeyvRmDi0d4YZQoaDb2kFXnR53oj09Hl19gRKVY7qKpkdqQcoU=
X-Gm-Gg: ASbGncu7TjrQ7bO6L627YqSV/LQgb47eeCmGy/2DABCxszHHt/mQmweJcBFprJ6rQNb
 0CSuLuus6Hw4Xid1SqOliTKaZEwwT0U/N8joAbvOz7weuxEISjjo4Mo+9XroiDb7k0S4dvAHPDj
 RnBBebbi+7BpCidll2oYWiCvPp7XELHAdxCQHUGfKKj3NEMsap84CXlQkDavY65OR2tCIukEVFs
 3Fdpxs5Kvr2Kh9718URxICRHmVp31f9qUJPCY3/0NOS48elEcGvAsePIwmN
X-Google-Smtp-Source: AGHT+IGsAWzPzd75/veVnKmlNmphUQNMqY6BodbR1KsWAbqUjje6GVNQxcv/Tq4d/BpEujrc0H6VtQ==
X-Received: by 2002:a17:902:c40b:b0:206:9a3f:15e5 with SMTP id
 d9443c01a7336-219e6ebb6e2mr710534215ad.32.1735977682796; 
 Sat, 04 Jan 2025 00:01:22 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9f5211sm255346465ad.188.2025.01.04.00.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:22 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:00:54 +0900
Subject: [PATCH v8 1/9] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-1-56144cfdc7d9@daynix.com>
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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
index 8f160c0c0d8a..c4fa32dc987a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2432,6 +2432,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
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
2.47.1


