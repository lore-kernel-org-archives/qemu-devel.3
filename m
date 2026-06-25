Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D744CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcoJq-0005Tv-Gv; Thu, 25 Jun 2026 13:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcoJo-0005SC-QE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcoJn-0005af-1L
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782410208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8TeYDKp4gBioofaB9ljwXOEql2s+CCJZWxTR2OhMDqk=;
 b=PCXXt0nZA5qwAAkwm3pyoQM9ZxKZtwjfvBBctVSVGoBcVVr7chjdh52copZ4DmqbBoKzwG
 qVpyxyHbMUK6l0KLtiNixvDaMRlQUzQH8bEbFd1AfHeoJsCo/GZNkYGVambrbF3c1+6iFM
 p67cbrWDM7tExr6dIKBdgCw3eBWcu90=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-jq3Ua4FjPFKU5WLYbm1JPA-1; Thu, 25 Jun 2026 13:56:46 -0400
X-MC-Unique: jq3Ua4FjPFKU5WLYbm1JPA-1
X-Mimecast-MFC-AGG-ID: jq3Ua4FjPFKU5WLYbm1JPA_1782410205
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46d84c6b452so15957f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782410205; x=1783015005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8TeYDKp4gBioofaB9ljwXOEql2s+CCJZWxTR2OhMDqk=;
 b=H2aOG6XqCaFOAfEoAfKG9LdMgo3ua2rYVfgdjV7f3WT53BoNRpfTkQ/s5SwYMAvKPA
 tuxqRQSFbHqjilduZWxZasRkh4JbM6CcwBycqgELVLR6ARskjorlts1pWOFYthQS0eDk
 6Tp907UUbVX5nfYtHlT/9V96N2UZLaFBhEtefowvnRo7JlamgUcGdc5eoQ8q6gGjeVyA
 yupEDukUsgA9l3kh32XeDEDakcDiQerggA/wJD2CIRxO578WPyhKEcZtsZsVBFDiKRN3
 EVz1nGOP+/5rQwBUTjaeBDt+ZtwJgMKeaxVcnBIweUBCGjKVY19YBlQu+2eRomIUWz1n
 fJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782410205; x=1783015005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TeYDKp4gBioofaB9ljwXOEql2s+CCJZWxTR2OhMDqk=;
 b=ZEuhjIjJE+bii3E+Ug/M9grLAa+SlOJsPCcF3Q2FoUBU+od2Yk4Optb7NIaqrUfkp7
 CVF+Qk5dJLviSsxTC2jgdV9hXuMEgRnFzGZSbo8BuLxzBfQ4g4MZj9XofQMov6rlwWwQ
 Fp/MgULt/Qcwh5CK7tBXpQrqe0emIwFYaovpw4/fVJyqwM2zxzZcRDOoabTnEHukPUsJ
 vfikbxPaxKd1fbS3Xh2aykajRe1Z6oxVIiKd0Kk2BfXIz8ZEA/6hlBaQQ+hNqANDL3ys
 gnloJRqljBVthNwYXnLVGGBWn1z78zdURPyk60UBjNMznys8o1H8+MBmNsVfUPkfpZT+
 c8Ig==
X-Gm-Message-State: AOJu0YxO6XYnSHEGJzbFTTjRnpm5m2g01DhYOuhqgj4Jw2RQvy53MHaR
 OnHRisLv2quZ4x1vml+OzO/1j4PaszWNWCPhBwpbqGaPJPbDVZJTlZm7z5g0tMsWwBmLsQJfRZI
 G236XstXQEC5izeX3t3xIB8cRbyb4OCsEhiBiVkCY1VvcE69lH7lAeTw2Pg5W4gyAaEtRstUfrH
 W7KnuCQadLJ7v8mVVlYEW+obWMjboWWoqiJo15OYjZ
X-Gm-Gg: AfdE7clRXjVLynYhjKkq70Vrb7XXYw+WpDMO5IbvKcDr+6B3YD0xDfmicNTftdbqKnv
 RbMlKUN8WwQKrL78r1QsRU3asax2UU04/GVkylTH79aTCEdmdGk+0jmwJu9ypFUgDunDQrEhPzt
 M7eT+Wn2IeRvDXJuTGccFLim3AUz5gDnpm/nsg92GhK9jYLrN7AvcFW+MoZR91RJ9lDpQB2ESRc
 /jBqFj2pmHVTYxaNCLqcME810IkWXcZ/PGnpOV/aBPmFrI92ut5cEsVqg+skcRCxEICy1yDL0wm
 eteaxbmanODPec97oyHp2+VpMH8CWkfylVYfF4dbegwIs43SOAI9tkmFOAWB3ws9qjfY/9kHNE9
 ua/ZG7sKCYU19wiQmlJMp5opeyWD8mU7vXXPPNjEiZhKsQAAz8ZA+7kFeD5KDMUIlJ07D1UxNvG
 J3lOKNeF5nVle5wbpI
X-Received: by 2002:a05:6000:4819:b0:45e:739b:3e43 with SMTP id
 ffacd0b85a97d-46dbc69bae0mr5051725f8f.0.1782410205279; 
 Thu, 25 Jun 2026 10:56:45 -0700 (PDT)
X-Received: by 2002:a05:6000:4819:b0:45e:739b:3e43 with SMTP id
 ffacd0b85a97d-46dbc69bae0mr5051675f8f.0.1782410204687; 
 Thu, 25 Jun 2026 10:56:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b734sm18100078f8f.30.2026.06.25.10.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:56:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH] accel: remove unnecessary #ifdefs
Date: Thu, 25 Jun 2026 19:56:43 +0200
Message-ID: <20260625175643.1635827-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
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

Based-on: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel-irq.c | 14 --------------
 1 file changed, 14 deletions(-)

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
-- 
2.54.0


