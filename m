Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF430C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX7n-0000b0-Vy; Sun, 04 Aug 2024 05:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7n-0000XA-2i
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:01:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7l-0001A1-EW
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:01:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so33046235ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762116; x=1723366916;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=DFGTpe5FkK5NSoLKnyGB3CDrJ8XKRYFODYkfxVgbxw1gyrsgp/qRaLaDr5/Ac14+3N
 98bmQBWRIJ3QAvnzDoZFhl0F1sB0AhoHjb6BDRYBPT19Ndv5Dn0kDBCFJtdIOTSzTQ+s
 cC+zT3sSGWg7c3SDSbA/LjoSCi8l+QV8ZhjRkEfew0glq5UAyhykLxT90inK4H2ekqjG
 lRU2ubHlZTb0HfZ3CjE2YhBoYxnWjBf7F4gsVb53HW1Bzu6yLtpOQyboUOzkFOjckxUb
 u/7Ginb/z5Vv3Su2Bcs/xW6LqlzC+nnVgD93N0DjxwfN1Mo0RQ8FgSxbJN+Wxnj+kg4D
 pJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762116; x=1723366916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=M54M3wvijbe/gTV9Xihkk4B0jWcqcPRCLN40l9jSntqKuws/g9m8lyJRvdfBXggHVc
 pMggaSIHTCwTWoSpPNnQzsG2NVPsUThTjW9CrpwBOwtCQqJMhzGa/v+5NCfgeBSCaRBE
 8wursFERAZ+l0ivZNHR+hJuMVYkjnSUXdPwSC9KUeMHen7iGJySBFWtqyTIHHyGOWd9o
 AAimPFzgjvTBIs56A6uQT+mSMhq/zcMSlgAqxAeJhd9oQ4AWHbEcXzBoF1sZoW7mbVcE
 do56hwW+4IttVC6v8OoswW7FUZeRrBoAQrqFrZvOgaatbohQhpslzEH1Et5XWgSZFAZX
 T5OA==
X-Gm-Message-State: AOJu0YxebgPHWbKL0drSizq22aqKGH2KydCWPvmdSo8gmWQa+OmBXWpy
 eDKH0wtgXXUTsOiASbIG8JbXh3VKQsC4tNECuFBb8N7Q2ds7EDQ69J1rGWb6VT0=
X-Google-Smtp-Source: AGHT+IH6hvACC0/67UXXIMR8Dw71AM1UrQVeCxJ8kTmPPYgkbvYXlf0nAAGLQnFgQQc4gqpJWplcZA==
X-Received: by 2002:a17:902:c947:b0:1fa:97ec:3a4 with SMTP id
 d9443c01a7336-1ff57b81828mr150036305ad.8.1722762116065; 
 Sun, 04 Aug 2024 02:01:56 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f19f0asm46257095ad.6.2024.08.04.02.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:01:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:38 +0900
Subject: [PATCH for-9.2 v12 02/11] hw/ppc/spapr_pci: Do not create DT for
 disabled PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-reuse-v12-2-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c3546..f63182a03c41 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;

-- 
2.45.2


