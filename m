Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9437FC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwR-0005OB-JT; Tue, 04 Jun 2024 02:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvF-0004DI-4L
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvC-0007Z5-KL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F96vCbKTWnHFnpkB8xUgBzHfJZX2/SvjrcR+hO1orlo=;
 b=JXftRmf+aGqpgUnVv40/gsFaovAqANGa1BgZDoyzgMVgOj6SO2HVOx5SgA4aLt/zVqVOS/
 vczNONHd5h5NzRbwmIG0iy2IyVOA0x+tkOxUpWW5GVydOiOYCJDof+1kWUSrHuFLWD8SX4
 jPMvqgzLts5MdEip1bwur0GwNwt/ylA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-2GeEnBhqNMi46ifBKUlfRQ-1; Tue, 04 Jun 2024 02:45:22 -0400
X-MC-Unique: 2GeEnBhqNMi46ifBKUlfRQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35e0f069ad4so2754335f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483521; x=1718088321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F96vCbKTWnHFnpkB8xUgBzHfJZX2/SvjrcR+hO1orlo=;
 b=xFqavJWIra4ez7UQE+OO0U5pXknE/01sj5OKxpPXBubpZUD6feLN6gOC5yht8gHTEY
 1qoliR9XDZ9/MAJKaboRMZjNYB2crIdxtyAuYhcDkbFyHoN3+7ADnbevQet8WMP3JBuw
 uqZgfaeQeLFYaz3k2azZPxfuP0+QpxpK53WQBEKfZTxlfurhJMYFy3WaOm5jmXzHkwd1
 OCU+r/+2FmDsJ1eM14SEtcJsruhBCZMgrUkaDzfxfWx0x/evvJNEKokL7wfK6qU96StT
 axkm4EH4qv+J2VtrN6yabfKnzqm3fXcAwLgq+OV9UZYMLiyNJJ+GZaf/tzwfdBFFroHS
 5gXQ==
X-Gm-Message-State: AOJu0Yzx+evnoTaUIgUh5fk+4vqHPaDxxeMN71RglZec7cDxIpDcBi6c
 AAJ0PB+MWsT6CE6r4/dcZH9UsOPor5ycSruI3yfoNr0PLcx1ASNZk8cnjIEah9BdV0M9+xmIGdk
 0E18DGKu5mZJJiqGYwCrW9bdoHLrckeqPMzQ2YaiGAFBKWk9utnSamDCk1HjIXbQimgCN76hFV4
 cX3IU7PuD/sAo7/AqUEB/esU+6VXYxdu33R9gt
X-Received: by 2002:adf:f844:0:b0:354:fab6:3103 with SMTP id
 ffacd0b85a97d-35e0f34ebebmr8760554f8f.60.1717483520702; 
 Mon, 03 Jun 2024 23:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUwn/JZmwBYGE4+tw/lc6TDBi0VNxTnTrCcNJXup/KqBrUzvnwfgc7uTZYI60m80WxJrjQJw==
X-Received: by 2002:adf:f844:0:b0:354:fab6:3103 with SMTP id
 ffacd0b85a97d-35e0f34ebebmr8760528f8f.60.1717483520195; 
 Mon, 03 Jun 2024 23:45:20 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eb3444bfsm579142366b.201.2024.06.03.23.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PULL 23/45] i386/sev: Add sev_kvm_init() override for SEV class
Date: Tue,  4 Jun 2024 08:43:47 +0200
Message-ID: <20240604064409.957105-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Pankaj Gupta <pankaj.gupta@amd.com>

Some aspects of the init routine SEV are specific to SEV and not
applicable for SNP guests, so move the SEV-specific bits into
separate class method and retain only the common functionality.

Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-10-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 72 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4edfedc1393..5519de1c6b2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -73,6 +73,7 @@ struct SevCommonStateClass {
     /* public */
     int (*launch_start)(SevCommonState *sev_common);
     void (*launch_finish)(SevCommonState *sev_common);
+    int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
 };
 
 /**
@@ -882,7 +883,7 @@ out:
     return sev_common->kvm_type;
 }
 
-static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(cgs);
     char *devname;
@@ -892,12 +893,6 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     struct sev_user_data_status status = {};
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
 
-    ret = ram_block_discard_disable(true);
-    if (ret) {
-        error_report("%s: cannot disable RAM discard", __func__);
-        return -1;
-    }
-
     sev_common->state = SEV_STATE_UNINIT;
 
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
@@ -911,7 +906,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     if (host_cbitpos != sev_common->cbitpos) {
         error_setg(errp, "%s: cbitpos check failed, host '%d' requested '%d'",
                    __func__, host_cbitpos, sev_common->cbitpos);
-        goto err;
+        return -1;
     }
 
     /*
@@ -924,7 +919,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         error_setg(errp, "%s: reduced_phys_bits check failed,"
                    " it should be in the range of 1 to 63, requested '%d'",
                    __func__, sev_common->reduced_phys_bits);
-        goto err;
+        return -1;
     }
 
     devname = object_property_get_str(OBJECT(sev_common), "sev-device", NULL);
@@ -933,7 +928,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         error_setg(errp, "%s: Failed to open %s '%s'", __func__,
                    devname, strerror(errno));
         g_free(devname);
-        goto err;
+        return -1;
     }
     g_free(devname);
 
@@ -943,7 +938,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         error_setg(errp, "%s: failed to get platform status ret=%d "
                    "fw_error='%d: %s'", __func__, ret, fw_error,
                    fw_error_to_str(fw_error));
-        goto err;
+        return -1;
     }
     sev_common->build_id = status.build;
     sev_common->api_major = status.api_major;
@@ -953,7 +948,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         if (!kvm_kernel_irqchip_allowed()) {
             error_setg(errp, "%s: SEV-ES guests require in-kernel irqchip"
                        "support", __func__);
-            goto err;
+            return -1;
         }
     }
 
@@ -962,7 +957,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
             error_setg(errp, "%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
                          __func__);
-            goto err;
+            return -1;
         }
     }
 
@@ -980,25 +975,59 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     if (ret) {
         error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
                    __func__, ret, fw_error, fw_error_to_str(fw_error));
-        goto err;
+        return -1;
     }
 
     ret = klass->launch_start(sev_common);
     if (ret) {
         error_setg(errp, "%s: failed to create encryption context", __func__);
-        goto err;
+        return -1;
+    }
+
+    if (klass->kvm_init && klass->kvm_init(cgs, errp)) {
+        return -1;
     }
 
-    ram_block_notifier_add(&sev_ram_notifier);
-    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
 
     cgs->ready = true;
 
     return 0;
-err:
-    ram_block_discard_disable(false);
-    return -1;
+}
+
+static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+     int ret;
+
+    /*
+     * SEV/SEV-ES rely on pinned memory to back guest RAM so discarding
+     * isn't actually possible. With SNP, only guest_memfd pages are used
+     * for private guest memory, so discarding of shared memory is still
+     * possible..
+     */
+    ret = ram_block_discard_disable(true);
+    if (ret) {
+        error_setg(errp, "%s: cannot disable RAM discard", __func__);
+        return -1;
+    }
+
+    /*
+     * SEV uses these notifiers to register/pin pages prior to guest use,
+     * but SNP relies on guest_memfd for private pages, which has its
+     * own internal mechanisms for registering/pinning private memory.
+     */
+    ram_block_notifier_add(&sev_ram_notifier);
+
+    /*
+     * The machine done notify event is used for SEV guests to get the
+     * measurement of the encrypted images. When SEV-SNP is enabled, the
+     * measurement is part of the guest attestation process where it can
+     * be collected without any reliance on the VMM. So skip registering
+     * the notifier for SNP in favor of using guest attestation instead.
+     */
+    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+
+    return 0;
 }
 
 int
@@ -1397,7 +1426,7 @@ sev_common_class_init(ObjectClass *oc, void *data)
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
-    klass->kvm_init = sev_kvm_init;
+    klass->kvm_init = sev_common_kvm_init;
     x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "sev-device",
@@ -1486,6 +1515,7 @@ sev_guest_class_init(ObjectClass *oc, void *data)
 
     klass->launch_start = sev_launch_start;
     klass->launch_finish = sev_launch_finish;
+    klass->kvm_init = sev_kvm_init;
 
     object_class_property_add_str(oc, "dh-cert-file",
                                   sev_guest_get_dh_cert_file,
-- 
2.45.1


