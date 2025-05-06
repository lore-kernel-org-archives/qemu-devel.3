Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4905DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 06:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCBhF-000850-6l; Tue, 06 May 2025 02:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBhD-00084T-78
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBhB-0005vo-EG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746512544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3cJkgFXgK3LTlw3ckwp1HepM2so4vHXarjCd9syzLs=;
 b=isGoVaHyPD1i/DAFqRAJmlr7DvRt7I6/wL56Ehj4l9a0xgd5e64k2QrVlhrA5Ye7tjMzCe
 /i7zvyuGzkJpFZpaltUad91g9pbSvRuoSRQrDHHuW5XHFukO6Xo+a+ThlLcnzqD4MFzdn8
 uMx7sZVZocxq6YxCukQ0VeAmYAYAS2k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-p7JO6RDWNN-O7TfSdQW3JA-1; Tue,
 06 May 2025 02:22:21 -0400
X-MC-Unique: p7JO6RDWNN-O7TfSdQW3JA-1
X-Mimecast-MFC-AGG-ID: p7JO6RDWNN-O7TfSdQW3JA_1746512539
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE969180087F; Tue,  6 May 2025 06:22:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.237])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B2B118001D5; Tue,  6 May 2025 06:22:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 7/9] hw/s390x: Remove the obsolete hpage_1m_allowed switch
Date: Tue,  6 May 2025 08:21:46 +0200
Message-ID: <20250506062148.306084-8-thuth@redhat.com>
In-Reply-To: <20250506062148.306084-1-thuth@redhat.com>
References: <20250506062148.306084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The s390-ccw-virtio-3.0 machine was the last one that used the
hpage_1m_allowed switch. Since we removed this machine type, we
can now remove the switch and the related code, too. This allows
us to get rid of the get_machine_class() hack and the big fat
warning comment there.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h |  4 ----
 hw/s390x/s390-virtio-ccw.c         | 35 ------------------------------
 target/s390x/kvm/kvm.c             |  6 -----
 3 files changed, 45 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 686d9497d20..321b26df308 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -53,11 +53,7 @@ struct S390CcwMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool hpage_1m_allowed;
     int max_threads;
 };
 
-/* 1M huge page mappings allowed by the machine */
-bool hpage_1m_allowed(void);
-
 #endif
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8f01e68ef11..301668a0bff 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -746,39 +746,6 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
     ms->dea_key_wrap = value;
 }
 
-static S390CcwMachineClass *current_mc;
-
-/*
- * Get the class of the s390-ccw-virtio machine that is currently in use.
- * Note: libvirt is using the "none" machine to probe for the features of the
- * host CPU, so in case this is called with the "none" machine, the function
- * returns the TYPE_S390_CCW_MACHINE base class. In this base class, all the
- * various "*_allowed" variables are enabled, so that the *_allowed() wrappers
- * below return the correct default value for the "none" machine.
- *
- * Attention! Do *not* add additional new wrappers for CPU features via this
- * mechanism anymore. CPU features should be handled via the CPU models,
- * i.e. checking with s390_has_feat() should be sufficient.
- */
-static S390CcwMachineClass *get_machine_class(void)
-{
-    if (unlikely(!current_mc)) {
-        /*
-        * No s390 ccw machine was instantiated, we are likely to
-        * be called for the 'none' machine. The properties will
-        * have their after-initialization values.
-        */
-        current_mc = S390_CCW_MACHINE_CLASS(
-                     object_class_by_name(TYPE_S390_CCW_MACHINE));
-    }
-    return current_mc;
-}
-
-bool hpage_1m_allowed(void)
-{
-    return get_machine_class()->hpage_1m_allowed;
-}
-
 static void machine_get_loadparm(Object *obj, Visitor *v,
                                  const char *name, void *opaque,
                                  Error **errp)
@@ -812,7 +779,6 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     DumpSKeysInterface *dsi = DUMP_SKEYS_INTERFACE_CLASS(oc);
 
-    s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
@@ -886,7 +852,6 @@ static const TypeInfo ccw_machine_info = {
 #define DEFINE_CCW_MACHINE_IMPL(latest, ...)                                  \
     static void MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__)(MachineState *mach) \
     {                                                                         \
-        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(mach));         \
         MACHINE_VER_SYM(instance_options, ccw, __VA_ARGS__)(mach);            \
         ccw_init(mach);                                                       \
     }                                                                         \
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index b9f14221976..6cd2ebc5f1f 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -298,12 +298,6 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
         return;
     }
 
-    if (!hpage_1m_allowed()) {
-        error_setg(errp, "This QEMU machine does not support huge page "
-                   "mappings");
-        return;
-    }
-
     if (pagesize != 1 * MiB) {
         error_setg(errp, "Memory backing with 2G pages was specified, "
                    "but KVM does not support this memory backing");
-- 
2.49.0


