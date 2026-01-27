Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B00AD25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSi-0007va-Vo; Tue, 27 Jan 2026 00:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSa-0007TP-Cm
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSZ-0000DG-1i
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1g88IOaonMf2X9NU0RqGLSr/HucXkWAA/ZJSr/I4RfE=;
 b=FJoDTzI/ahFhm7Ib7bIcR9foDhn2hVXn2X3jS0mJ6Uq8iRB2m30Oa2U//BLEomQfOV9icw
 HlHn2/TyDKzSy5ZLLyPXFSF2oQo/qKiGi0nciRFj318J7uyfRZh0qTrF+ZtBRZn11+t7C+
 ARn55Ri3ujgYEF2sCSqpqErlVubJIz0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Nsv-h03JOLC7gzDZ_NYghg-1; Tue, 27 Jan 2026 00:17:48 -0500
X-MC-Unique: Nsv-h03JOLC7gzDZ_NYghg-1
X-Mimecast-MFC-AGG-ID: Nsv-h03JOLC7gzDZ_NYghg_1769491068
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0bb1192cbso42909495ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491067; x=1770095867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1g88IOaonMf2X9NU0RqGLSr/HucXkWAA/ZJSr/I4RfE=;
 b=ZpWCDt8O77akmlVRHmFKv9y1xJjtNBmILN+mbRO2M2oMQQR60H8DqCGTdIEoTwafcg
 DEGjrrdsPObWYvuWGe2eP5b8VkYcUt7K9jWNMK4rNsTaUVoFxRWn7xMnwbG/NF3/UEs+
 ZObStKFKuD/DeRIq1geDRkh0OGdKc/6YfiQfA2NEBT6r9e8ut9pNBId2zKVxesKeQ0T+
 5VIJIHduX2vgTLxDVbdVouR4JjEbzcXSUWi1m253DQoLOdOeP56rWUxkgWPpIImtw0a8
 QiANVWtgEr8dovux99QnpIW6W2CRRdTXUXRDOXsTix5MDkXDdQwX9IAHHJ0fq/1YpnJG
 u2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491067; x=1770095867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1g88IOaonMf2X9NU0RqGLSr/HucXkWAA/ZJSr/I4RfE=;
 b=H0gXys+EERFO2btM6X9uK7WW47BSviA7wVdldxWQxIOfOx4D1e1o8LUmjxu3j2iFT4
 NQjmBizLldf1PLzpjg2eYbXzM2+Q0tDDSA3NxOM/zoXq7cD5BDH4HzyJdnStyZUNXIOB
 3z4d0RaZkcmmsQ5dY0GS/zJske/BAiYS8oUt3PGey7hbX22G34Q6RGO9YEDNoFy1kQia
 zTAc+//IfJcFojTa/4oRf6v+mnKL+oM9ONakUJQ49ex+0cj8YmWgi5Tj+iR/nfCziJEi
 sWUzRgUxOnKwBph4v/FY8b5v8O1OTLRI04JQb9s0/3iSuI8uBOpk/KUf6x5U9oKHxw2/
 BiZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxAM8Vsl+lRrCpO4/kqcAgtO6m4KsaukjcmLf8rUrtpr2dxlm7xPyolGgkBjx2fEdbh7/8vjFJjxji@nongnu.org
X-Gm-Message-State: AOJu0YxivdcO1Fll1Gz7rx8IAKAdluMa+S62u/jAgjQXNAorxn9YS4Ky
 wOYO03Tr8VO+JwJGFbL+vpKd7SZEBu2Xrq/KujA1wERuM+/wG+OvIWRzjCb+TI9BB0buYaaz1VS
 XqSuOYvseUPcY+mL3ziqkRq+JpnmyThtcaDAGzk6AKYARwgSNWfOR5pE3
X-Gm-Gg: AZuq6aLhLRffXf/o3L/1fGYzDJfFcJdiGIP81tasdk+01VnW1ecDQ7JLn6DpTf8xqNG
 3yy5O9/isv6WSK3/34FIXEC+7dUHpNiMFUqi6On2Hwe0xCVJcPztDWzaIeFBcFcjq1qhSyy5R7N
 gFHb4TwW85i2AmgTlJ6BXzPpQIM9QuhtmbpxIKVDgKE2/wl2RG767mElj2uHZP1hvdGA+laQLXH
 2nSUjhdBkCOEpAiyTAB8YyHv9TGJi6ipw6HstzPPeP5tFUdlhIAkh3NVbrDRrmKgx5d5V920XBM
 hgTiQSAcVXT7Ge9os5VqAF96GAN7Q07LLfHkzJVUABCMreyPOTXdenhxVkBZ+wvi6wVP5wKN2Dz
 nUan9ZYjHTv7wyAnm1qjf6tPGQ/F2lPIUDHTF8FUWiQ==
X-Received: by 2002:a17:903:40cc:b0:2a0:f0e5:3f5c with SMTP id
 d9443c01a7336-2a870dc6deemr5356975ad.34.1769491067517; 
 Mon, 26 Jan 2026 21:17:47 -0800 (PST)
X-Received: by 2002:a17:903:40cc:b0:2a0:f0e5:3f5c with SMTP id
 d9443c01a7336-2a870dc6deemr5356795ad.34.1769491067129; 
 Mon, 26 Jan 2026 21:17:47 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:46 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 24/33] kvm/i8254: add support for confidential guest reset
Date: Tue, 27 Jan 2026 10:45:52 +0530
Message-ID: <20260127051612.219475-25-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A confidential guest reset involves closing the old virtual machine KVM file
descriptor and opening a new one. Since its a new KVM fd, PIT needs to be
reinitialized again. This is done with the help of a notifier which is invoked
upon KVM vm file desciptor change during confidential guest reset process.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 255047458a..a754de0c8d 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -52,6 +52,8 @@ struct KVMPITState {
     LostTickPolicy lost_tick_policy;
     bool vm_stopped;
     int64_t kernel_clock_offset;
+
+    NotifierWithReturn kvmpit_vmfd_change_notifier;
 };
 
 struct KVMPITClass {
@@ -203,6 +205,21 @@ static void kvm_pit_put(PITCommonState *pit)
     }
 }
 
+static int kvmpit_post_vmfd_change(NotifierWithReturn *notifier,
+                                   void *data, Error** errp)
+{
+    KVMPITState *s = container_of(notifier, KVMPITState,
+                                  kvmpit_vmfd_change_notifier);
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    do_pit_initialize(s, errp);
+    return 0;
+}
+
 static void kvm_pit_set_gate(PITCommonState *s, PITChannelState *sc, int val)
 {
     kvm_pit_get(s);
@@ -292,6 +309,9 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 
     qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
 
+    s->kvmpit_vmfd_change_notifier.notify = kvmpit_post_vmfd_change;
+    kvm_vmfd_add_change_notifier(&s->kvmpit_vmfd_change_notifier);
+
     kpc->parent_realize(dev, errp);
 }
 
-- 
2.42.0


