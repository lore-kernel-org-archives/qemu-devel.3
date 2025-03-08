Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C935FC28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3J9-0005Ep-R1; Sat, 08 Mar 2025 18:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3J8-00058J-2A
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3J4-0001PP-NG
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948021a45so26055065e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475409; x=1742080209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfxwOIZGSthGrPYmV9+XOb1nB6O0gzLqIcndrzluicE=;
 b=demB/umAMYnLYGxk0+xkQpkajuZQBHlOyuixnX286PgQ3JoelcZV72M7Z23W/K12Zu
 sIlGRBhhk1UoCWJLh0wFZcbcsYkUVc9H4vVDf3NKzf9b5Tt2JvBQOXhlizE/bQTF3BF3
 YieV0cZvGPv7sqlgb0GQ04UBFeDiz/dj//f+H6FG3PuuXihR9rzwggz4mNVRdLb5ysc2
 HQ7N535IUKm3Yye3fqMUE9lvmTG3H3VIjvSPCYYg+eayNbbtqc9VlU5CjBamnWLUAlcM
 HQEf7sV5rQ5KFTRB04nPakR/zkl8aML62MOWGiOB6iX5fpAwe/h9SqDERaBX0nC/t/3p
 so3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475409; x=1742080209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfxwOIZGSthGrPYmV9+XOb1nB6O0gzLqIcndrzluicE=;
 b=UvNOrJCz1P516gYi/LbLR27xBsbF3tauRxCYFm2S6CtjhgTX2pedExOgaQ1bFnmcS2
 gNRXmPoL5i1uM3lyQ0ZA1xpYIjkC6NRdpbzF9t0fwLdAlwcAuhcEhYQ0r3R9OWfzOg4r
 zTVSfhgJ09ABJ3JmCGhmWsQtr1NoWnDCgCcKYj7woUda84zXW2cOx67o56JOQ3qz5Xhp
 +ankHdTEVOjh/jd0FjRTFWRabNCiA1EKXXEAexNIFdoNg86gkuNOFT1wRT4CVAxUfx7b
 dfu+usNGQ/K8BRjOEV3KtOLyr6AFYepqdXwdBlTXpC1UWKfmYbzQhN4vLucqVSpbqBHB
 mBJQ==
X-Gm-Message-State: AOJu0YzBBj0rMUZP9qwCkJDvOBTkzfO9u7ELN3jijrzIjfo2sm4VLKgl
 /Mf63hPnXYsamu6xCs75ob3/2RVG4nPMN011aid203I6IiM0TXKK+KjuUO4DfYC17/J4UOsF9vE
 BI6I=
X-Gm-Gg: ASbGncv1gMyoQj/49QPv9EyXhJxUnvzhP4AQ9VSTLDlAlWDzAo7UHLTOyW76gDrCMQP
 jOYvZNU2g/1PvKsLbUAOhb9IbCIUw5X3CtWk2v88FODCvjzW6jz8X3QhoGKaXw962EgpnQOBgne
 vQX5Sqg2QQbAP4iVQ7BB5yKMR9NdSrgBFtVSaeOEGmrSfVOVRGWQHRRbRjN7eezOBzvtxEJO3J8
 noaeH+YIMP4CIKECwC5ykQZF3xNHXIqi3BIm5Fm9Bnf4hiBcoL13aGdOENip1NiI2ibzQF1dXQU
 0ab1g5sK4CVDIe49XlBhs3e3+CugH5QIOZtTEkw8DYtvm34HfMGpdYveJtvAnZrfkedj7eiN5O8
 BCACTzL9ail2SV8yWAIg=
X-Google-Smtp-Source: AGHT+IEqYFt3ONWw2rS9Wwh6tBBRqOLce/1aiPLRA7IaFr0DAlK7OI2TQrPavd/72gpTyJnokKbccA==
X-Received: by 2002:a05:6000:1a8f:b0:390:f552:d295 with SMTP id
 ffacd0b85a97d-39132dd8711mr5569888f8f.53.1741475408786; 
 Sat, 08 Mar 2025 15:10:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e3250sm10154532f8f.61.2025.03.08.15.10.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/21] system/kvm: Expose kvm_irqchip_[add,
 remove]_change_notifier()
Date: Sun,  9 Mar 2025 00:09:04 +0100
Message-ID: <20250308230917.18907-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently kvm_irqchip_add_irqfd_notifier() and
kvm_irqchip_remove_irqfd_notifier() are only declared on
target specific code. There is not particular reason to,
as their prototypes don't use anything target related.

Move their declaration with common prototypes, otherwise
the next commit would trigger:

  hw/vfio/pci.c: In function ‘vfio_realize’:
  hw/vfio/pci.c:3178:9: error: implicit declaration of function ‘kvm_irqchip_add_change_notifier’
   3178 |         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |         kvm_irqchip_add_irqfd_notifier
  hw/vfio/pci.c:3236:9: error: implicit declaration of function ‘kvm_irqchip_remove_change_notifier’
   3236 |         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |         kvm_irqchip_remove_irqfd_notifier

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a551..75673fb794e 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -412,10 +412,6 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg);
 
 void kvm_irqchip_add_irq_route(KVMState *s, int gsi, int irqchip, int pin);
 
-void kvm_irqchip_add_change_notifier(Notifier *n);
-void kvm_irqchip_remove_change_notifier(Notifier *n);
-void kvm_irqchip_change_notify(void);
-
 struct kvm_guest_debug;
 struct kvm_debug_exit_arch;
 
@@ -517,6 +513,10 @@ void kvm_irqchip_release_virq(KVMState *s, int virq);
 void kvm_add_routing_entry(KVMState *s,
                            struct kvm_irq_routing_entry *entry);
 
+void kvm_irqchip_add_change_notifier(Notifier *n);
+void kvm_irqchip_remove_change_notifier(Notifier *n);
+void kvm_irqchip_change_notify(void);
+
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq);
 int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
-- 
2.47.1


