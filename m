Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A712CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3el-0001mC-8s; Fri, 26 Jun 2026 06:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ef-0001DB-4g
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ed-0005O6-Gh
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+xth3zJnJDFs6lGu71xiSdWTKM4W7NCVGErv5m3aMI=;
 b=GjKrPqbp4ehvkLAE/nWNftzUkJIxX3488kc4nakUWSZyGVcmglygJVv/KvheRjBQDFlaez
 mynIN66HwzlbbRyFDmGKN+A7PsFLLprk693mlPXJD/rBW8VmBIqjeUTm69GDaOhZahpKoY
 dcbyi1MRtyMql4j4bh4RbQNwBIw6rsE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-qzDUd8QGO3WdKt5Rh4B96w-1; Fri, 26 Jun 2026 06:19:21 -0400
X-MC-Unique: qzDUd8QGO3WdKt5Rh4B96w-1
X-Mimecast-MFC-AGG-ID: qzDUd8QGO3WdKt5Rh4B96w_1782469160
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46fa65abd21so42036f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469160; x=1783073960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q+xth3zJnJDFs6lGu71xiSdWTKM4W7NCVGErv5m3aMI=;
 b=icudgYHaoItoMI86Qw4tdZTBXIxYeki7I0CrqBnZO+I0CTEjkhRWEsxvy1pH1Qapa9
 h/4JZNvnE7y6skoUck8eUX02lOS1kUSBHcsbJCVlhnfEZwglce7D9xregxLi4wzBU/IP
 Vrxxj2/IoZ8KXKlnJ7wd8zj0iAgvzM9LZHdsOavoMEqrprZu7LrCN8XuhjDYs5CAPSdb
 tbp+8qfzgo+mOXbSv2yp6kdwUtXTc39uWTMmOCVgMLKTM1UtLG4Ap65pukbJpBy5AsQ/
 wamJMRIPeM2j0xA7D16/R/sIeXFrtPi5Qh3LTIRuP5PM6msTFrEaGhWZL2Op8oPmg0x4
 Q8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469160; x=1783073960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q+xth3zJnJDFs6lGu71xiSdWTKM4W7NCVGErv5m3aMI=;
 b=oVofNQWN/4bQnAuJlZn8eblDFEV2rzZtbzGBe794nmJK7nYOy+Hmkf8Gc97sTwlhhS
 M0dxpBi3U9v0s5Tp6tosG32j78qwgDiJ2oiX4m+/8aYOqPAUsjo2zUr+PIgO3Na1Wi9H
 aeY7Cw+kKe1gpX+cTso1dcLztxIQL1Bo+uFNvDBhy2Cmbg9JBlU0USx7qZsi2ijM8t51
 xaLmsnqb5eqCdebwSdLMHpQtvgg6BlQQpinogLSY7E2jqMpvusO8p3G17d1FtyJl2rRN
 242cGVkYPa4P7Kp6HhHzFSURVWBJvmHAJu3/LKlF5/do5n8vRxUGm7OrMhIt2f2D+hNe
 SiUQ==
X-Gm-Message-State: AOJu0YxzilwiCnn1l+kwEssXVzD0gI8N+c552PCF22536RQiN0Ucdd73
 sQqiW294B+uWfnrE2ohg0+azIOhG3wr6T6ufeWhKoCFexT6XsxiDC1LISBiZK6pCDi78BnZyzaY
 YHw9RwyFtpV5wSAsWqps/0ucLn1Wsar+fXX4MT3jYVo5voeVIeLgRrBvSIcb4aPDhXKbmiWSARm
 +AqjoJOvt1aiCu3TZLRkGImx5gpCPWo004qZmvfvqg
X-Gm-Gg: AfdE7cmLF0807llI/+UmQtJpWVRbCZGDS+zUS7NJDpjJ6/rXY6s/BFnksa4ivJejldw
 fmjevkBHPk0Xt0wU9t0g/Nm8Ds3BUpxeRIZreDYKiKysDimuNtoseiOboMUtP5xNj9ENXzhwgaE
 awdmJZJSPsxgOWMzVCu3PR53aawtcdj+XsWGeWbNLj1sGgQJ0TwaVAv3P1rFEudxG0RIuMrN70w
 lBNAyCGSDPW0ci16obgGJHgdWe3M8Xs8jMNoAgGQUtiYBLHVMs46EML3FQMZHNt+sFiDlYITna6
 /ZzZ7MScKAv7vRXAPf1Su9nQ5KvnSo1VOADaopI/Y45rD30YJoMaTpOOqZRxNRa7Noi4nF7clCe
 elFApW5kZzWAx/JYyKsn44IJFIti/gRN+pKtGZx92nhvde2kJ7TfslIIhjw5uG5qXGL702uhI71
 7vJ+juN/JXPpiDlr3e
X-Received: by 2002:a05:6000:2c0f:b0:46b:ea12:2912 with SMTP id
 ffacd0b85a97d-46dc05553f8mr10474554f8f.5.1782469160395; 
 Fri, 26 Jun 2026 03:19:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0f:b0:46b:ea12:2912 with SMTP id
 ffacd0b85a97d-46dc05553f8mr10474494f8f.5.1782469159960; 
 Fri, 26 Jun 2026 03:19:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46d3b59cef1sm16715500f8f.26.2026.06.26.03.19.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/45] accel: remove unnecessary #ifdefs
Date: Fri, 26 Jun 2026 12:17:36 +0200
Message-ID: <20260626101748.1728079-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel-irq.c       | 14 --------------
 accel/stubs/mshv-stub.c |  1 +
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 4303e10e408..830be27c7f9 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -19,11 +19,9 @@
 
 int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
         return mshv_irqchip_add_msi_route(c, vector, dev);
     }
-#endif
     if (kvm_enabled()) {
         return kvm_irqchip_add_msi_route(c, vector, dev);
     }
@@ -32,11 +30,9 @@ int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 
 int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
         return mshv_irqchip_update_msi_route(vector, msg, dev);
     }
-#endif
     if (kvm_enabled()) {
         return kvm_irqchip_update_msi_route(kvm_state, vector, msg, dev);
     }
@@ -53,11 +49,9 @@ void accel_irqchip_commit_route_changes(AccelRouteChange *c)
 
 void accel_irqchip_commit_routes(void)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
         mshv_irqchip_commit_routes(mshv_state);
     }
-#endif
     if (kvm_enabled()) {
         kvm_irqchip_commit_routes(kvm_state);
     }
@@ -65,11 +59,9 @@ void accel_irqchip_commit_routes(void)
 
 void accel_irqchip_release_virq(int virq)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
         mshv_irqchip_release_virq(mshv_state, virq);
     }
-#endif
     if (kvm_enabled()) {
         kvm_irqchip_release_virq(kvm_state, virq);
     }
@@ -78,11 +70,9 @@ void accel_irqchip_release_virq(int virq)
 int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
                                          int virq)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
         return mshv_irqchip_add_irqfd_notifier_gsi(n, rn, virq);
     }
-#endif
     if (kvm_enabled()) {
         return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, rn, virq);
     }
@@ -91,11 +81,9 @@ int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
 
 int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
         return mshv_irqchip_remove_irqfd_notifier_gsi(n, virq);
     }
-#endif
     if (kvm_enabled()) {
         return kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, virq);
     }
@@ -104,14 +92,12 @@ int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
 
 inline AccelRouteChange accel_irqchip_begin_route_changes(void)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
         return (AccelRouteChange) {
             .accel = ACCEL(mshv_state),
             .changes = 0,
         };
     }
-#endif
     if (kvm_enabled()) {
         return (AccelRouteChange) {
             .accel = ACCEL(kvm_state),
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index 8b69539a85a..566a17ff9e4 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -13,6 +13,7 @@
 #include "system/mshv.h"
 
 bool mshv_allowed;
+MshvState *mshv_state;
 
 int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
-- 
2.54.0


