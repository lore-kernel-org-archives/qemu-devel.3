Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123F9D25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbT2-0000fV-9a; Tue, 27 Jan 2026 00:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSs-0000O8-Cg
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSr-0000GT-0L
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=f1qsQa9H6ir8jeTKBevpfUy+xFQPbl3RGSk4imVNTk2FyAoIiGBKsUqtZiJ14TICujS/E+
 1+2LN/ug09MGgtuMwz1IB7qO6hhr3QDNI81pI6qJfLMP5UivK3T53KubjJCXtiAaNAxjQs
 6t9GiAsjeBVuyy+5xH6UFE18tSslOUE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-ojrE7eJlMBihbRlQuNXSTQ-1; Tue, 27 Jan 2026 00:18:06 -0500
X-MC-Unique: ojrE7eJlMBihbRlQuNXSTQ-1
X-Mimecast-MFC-AGG-ID: ojrE7eJlMBihbRlQuNXSTQ_1769491085
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34e5a9f0d6aso4700038a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491085; x=1770095885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=RsgYDxECYEcfivs9UviQ/N10b9ESaK1JBvUmEVXE9CJxozztSIsZlkAt18NEcjL156
 nA/7nylznKZdLImc5JT3fhBkAb9A6k0wuMsWc1ZZ3g4a8zT9jzpOPUFU8gGcQtwGDLSs
 rCX5IjwAQC35RDXYFumSvk43sKyLbp7L/XZqD4IE5dazsuBZ+tkDGbogZFNr8KFllamU
 PEvhFu6mH5lsSDNd3ChxHTKbnP7w2ZE6npUXKOUNnE0bEcIIfv34+BznXyodyS2ViyoD
 s4rv3G0qy4RGK1RGW5X1TLr37cQ1noIHYZdFA3pxEtELTcO73SmN7XVExdab7jSD77JY
 UeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491085; x=1770095885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sZTC0TaeHDKR66aLqLlM3/y/CGbtg30ikDOryFdUyg4=;
 b=O6AsRNZK9kFjS9e7rRje/9sogYabsHqKuS8h3C8cs1H//GShTaejAygNpNly8FeOCp
 w8fPXSv/w7S2ejfbhS5ZVYm3nv6TIWMvbivtndIwRX7u1ppRYHcNQCGNXrSKi05tMYDc
 AU4e7v8HtlTQD/RqpGGoXa0gyWWEqGD9xZRbrCZM9CAks04RkZklkpIXACkehlN5gfUE
 dnbUjSM8VHbc7zvXUTYCnpRnEZsoeDaC2aDMbH//RnTqBZaHe5C/CIPoWvcv0h/g2Xvz
 T5piQBKa4dO9B/ZMpddXf45gAvf5IggzHDMpNE4Gca+6OC4MTBAwVgZI+CfUKPKO2+jF
 XszQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTTpQO+qTSJ3oJa+yUhDBe2iUCzQkvBZGK0JcvP6eQjN4Nyye2S3+Vrxnsf33UELBBlsQXV91PHuJd@nongnu.org
X-Gm-Message-State: AOJu0YzHrBq/PlJSqq1FAbCBG6YgOmvSQDTy9mwOTrrH47smMqtW6RB3
 YzVAOkP6jucZzjjuNlavm0TVR4TdB1LqupI8FPL/srzxeW+KTZsw5PeIB3eF8UAXoza390Zfg7q
 mx+pj54j0GGqsmS0c5oEWmgugJeI+0zXsOY/8ltS9b1KKKBhZQrT3iNmc
X-Gm-Gg: AZuq6aIpPTUfvLsW1Sjg2Q6xjqaKW18Eu8w1Wuv1sLUubQXGMDV9IeqSm631GaM2cmy
 O+eZz0YMJ+21hLG+iBQC3zDgPSWgpNqgmyEm43hd6DucBi/Nq76KPu2I+S7r0Qh739tMjwVXD7Q
 J+5LenpRnMg0hwe4Wn5cSKxt6kDPExmAmuEsCSxkGeiWkKe2SRp0aGJzOdfJpD97zll0imjF5q3
 xWVC8oQHSPvfl2yFDOQGUYgcO/iSzrqwcfJwZhP55b+TPpP2jCfW68Sh6RwwsIGW1vsviMij/n/
 nh7V0F0ujd7HNCbZt+gFQkpaioN19ZuAQsntvvPdPi1G5qpxCWgDrURq2qNqO2GTBak7TPOEpap
 P617MAZ+YQ0aGf2X6c+OntDaHC7vU+XOlzpIUtXL8Rg==
X-Received: by 2002:a17:90b:3802:b0:343:3898:e7c9 with SMTP id
 98e67ed59e1d1-353ff8b45a6mr479140a91.2.1769491085047; 
 Mon, 26 Jan 2026 21:18:05 -0800 (PST)
X-Received: by 2002:a17:90b:3802:b0:343:3898:e7c9 with SMTP id
 98e67ed59e1d1-353ff8b45a6mr479117a91.2.1769491084654; 
 Mon, 26 Jan 2026 21:18:04 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:18:04 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 30/33] kvm/i386/apic: set local apic after vcpu file
 descriptors changed
Date: Tue, 27 Jan 2026 10:45:58 +0530
Message-ID: <20260127051612.219475-31-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Once the vcpu file descriptors changed after confidential guest reset, the
local apic needs to be reinitialized. This change adds a callback from the
vcpu fd change notifiers to reinitialize local apic for kvm x86.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/apic.c              | 13 +++++++++++++
 include/hw/i386/apic_internal.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 82355f0463..f6f8ac2764 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -229,6 +229,16 @@ static void kvm_apic_reset(APICCommonState *s)
     run_on_cpu(CPU(s->cpu), kvm_apic_put, RUN_ON_CPU_HOST_PTR(s));
 }
 
+static int apic_vcpufd_change_handler(NotifierWithReturn *n,
+                                      void *data, Error** errp) {
+    APICCommonState *s = container_of(n, APICCommonState,
+                                      vcpufd_change_notifier);
+
+    run_on_cpu(CPU(s->cpu), kvm_apic_put, RUN_ON_CPU_HOST_PTR(s));
+
+    return 0;
+}
+
 static void kvm_apic_realize(DeviceState *dev, Error **errp)
 {
     APICCommonState *s = APIC_COMMON(dev);
@@ -238,6 +248,9 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
 
     assert(kvm_has_gsi_routing());
     msi_nonbroken = true;
+
+    s->vcpufd_change_notifier.notify = apic_vcpufd_change_handler;
+    kvm_vcpufd_add_change_notifier(&s->vcpufd_change_notifier);
 }
 
 static void kvm_apic_unrealize(DeviceState *dev)
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 4a62fdceb4..ffe5815e7f 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -189,6 +189,7 @@ struct APICCommonState {
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     bool legacy_instance_id;
     uint32_t extended_log_dest;
+    NotifierWithReturn vcpufd_change_notifier;
 };
 
 typedef struct VAPICState {
-- 
2.42.0


