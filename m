Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC36DC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAHF-0001UF-3q; Wed, 14 May 2025 07:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAHB-0001QM-N1
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAH9-000296-RP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747222070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwRDJpGweeeWzHShTIeNusKK4wD5yUVy6zBeHHNs8cA=;
 b=G0VFPgn/RoyFVAGFlV0QBdWrvFq3G+h77IuC6oTSQ9XJGNLAeZLPQdFFsLWNkg4GHgSQec
 vtJeG8lyHEfPosvvrvP2LER9V4CG5TQeCabBUON9ZwoLQirHhig36pfgRW/FxrNz3Vm7i7
 HPcc4o5irKehOpPaDNQqwdUQ1IaMdYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-b-PRk7CiNou56PbNz-TBpQ-1; Wed,
 14 May 2025 07:27:49 -0400
X-MC-Unique: b-PRk7CiNou56PbNz-TBpQ-1
X-Mimecast-MFC-AGG-ID: b-PRk7CiNou56PbNz-TBpQ_1747222068
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 086091956088; Wed, 14 May 2025 11:27:48 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A55D219560A3; Wed, 14 May 2025 11:27:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 07/13] hw/s390x: Remove the obsolete hpage_1m_allowed switch
Date: Wed, 14 May 2025 13:27:27 +0200
Message-ID: <20250514112733.456644-8-thuth@redhat.com>
In-Reply-To: <20250514112733.456644-1-thuth@redhat.com>
References: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Message-ID: <20250506062148.306084-8-thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
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
index bec4690e857..b013bcd076a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -748,39 +748,6 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
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
@@ -814,7 +781,6 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     DumpSKeysInterface *dsi = DUMP_SKEYS_INTERFACE_CLASS(oc);
 
-    s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
@@ -888,7 +854,6 @@ static const TypeInfo ccw_machine_info = {
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


