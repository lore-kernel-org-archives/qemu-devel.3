Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4922DC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVxW-0005j1-Lr; Wed, 27 Mar 2024 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpVxK-0005ig-Cd
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:16:51 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpVxI-0001Cj-Gm
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:16:50 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a44665605f3so826202666b.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711556206; x=1712161006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bAqfmPHU6eSgDittaGCcO2PKWOLIbl5GKHge5h2c9B8=;
 b=mxYYFUHWhbRdtlbbfbdu4ubQhtzTSiYLbCrVVLTMqMTgggZiawPv7Jm32k2tQcQAn1
 J5/Y39TUReVVhmgMQGheMlqcEX9xBG9iCQAnWgoLIEyc9Ih6jAySKRj3f7h08b/FhxOS
 clncU/e9C2m+bKgE+XOzVtZ/TziPYXLEKoeDn7PqB4FFp3Om/iImNVGGLR5EagMhj4zt
 LPFkD+ON0M+WjOQtIpYbTbkOsCQ06JchE1VGH0jSiAMHCPt3S4Hows5KBcXqnDWNjfIp
 fg8OqKtSBwaRVF/8jtqLrzXcNNIQIvHmhT7iGFNaxe/wzb8NH9o/+JDLqZE2fmhP7N3m
 Jhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711556206; x=1712161006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bAqfmPHU6eSgDittaGCcO2PKWOLIbl5GKHge5h2c9B8=;
 b=AEThr1xJrOWo3XVTQvwlJukDLQFHMWFrJlC5V5EQbqxChBKPihKd6EzAChWFQ5LU1i
 tCcZw6rg0KOKRi3uZc/K+ISqYOLRZmD5r/krWURrbhlTqS0Wew8bt7e0DNdI6M2kI/GS
 XTd6e15zIuPJVd//cyxOENz479OLMiKLb5j6jh4MP2lsDdcWHaSgOiozjrr9Tdyo3wvr
 Olt3fTd4amBDY79kOwYD7gLoM2p4/FI4ok2IW9U0UfFCY5ok5f42AVAQUvA00Z7er3k4
 v+QhZ9NyIGuOo6F8hMIMnEKQ9pn4/9cdmSTksr01h/buUW2wnCq5d7eOk+16uRKWJzzG
 HsiA==
X-Gm-Message-State: AOJu0YxLSPmVA2iRsZ4c3bO0ck33utQbUOSEP8Dz9KwOcEXsroiB6MyX
 PwhIfWoPi7lIxHEXT6rdyfCNWDIipcCDcRUkeYX38lsZqX9tJvbhmjmHx3S80Ifq7c2OlS5ZPHW
 8
X-Google-Smtp-Source: AGHT+IF2O6fRs0xet58sOzEDdjg/Qlybe4aN7R6q42XZp/85TQJwOY2Q7pySU8mYUFMlIltmCGG4+w==
X-Received: by 2002:a17:906:fac5:b0:a4e:30d:ee7d with SMTP id
 lu5-20020a170906fac500b00a4e030dee7dmr1426206ejb.12.1711556206076; 
 Wed, 27 Mar 2024 09:16:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 e25-20020a170906845900b00a4673706b4dsm5631061ejy.78.2024.03.27.09.16.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 09:16:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] hw/i386/pc: Restrict CXL to PCI-based machines
Date: Wed, 27 Mar 2024 17:16:42 +0100
Message-ID: <20240327161642.33574-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

CXL is based on PCIe. In is pointless to initialize
its context on non-PCI machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e80f02bef4..5c21b0c4db 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1738,7 +1738,9 @@ static void pc_machine_initfn(Object *obj)
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
-    cxl_machine_init(obj, &pcms->cxl_devices_state);
+    if (pcmc->pci_enabled) {
+        cxl_machine_init(obj, &pcms->cxl_devices_state);
+    }
 
     pcms->machine_done.notify = pc_machine_done;
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
-- 
2.41.0


