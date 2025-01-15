Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4589CC02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 07:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxzJ-0005BN-1g; Wed, 15 Jan 2025 02:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxzD-0005Av-Hd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxzA-0007qv-7x
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736926723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrPe0c0881kkxVT2+6rc1SX1inpIngHCi1aAp4kb4n4=;
 b=P5shoMb7eeXCL9/D41Y+pu1qbsqff/zan6mSbCiz6JesFFYdGEiOw4x2flOAxLXeov0A3g
 7/UiYiip5K3Zsd2BGqdSYJV5AaXMSypvDTN6riVucpNknXhuWsnkWwb7AHvyS7nBWj9QFV
 629ysmOSRkxZJwvRGKo/mb7/WgNFLWQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-T5mIsYDMOsygrDAgOyZpMA-1; Wed,
 15 Jan 2025 02:38:36 -0500
X-MC-Unique: T5mIsYDMOsygrDAgOyZpMA-1
X-Mimecast-MFC-AGG-ID: T5mIsYDMOsygrDAgOyZpMA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BCE919560B7; Wed, 15 Jan 2025 07:38:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30AC3195608A; Wed, 15 Jan 2025 07:38:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/8] hw/s390x/css: Remove the obsolete "css_migration_enabled"
 variable
Date: Wed, 15 Jan 2025 08:38:13 +0100
Message-ID: <20250115073819.15452-3-thuth@redhat.com>
In-Reply-To: <20250115073819.15452-1-thuth@redhat.com>
References: <20250115073819.15452-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that the s390-ccw-virtio-2.9 machine type has been removed, we
don't need the "css_migration_enabled" variable anymore and can remove
the related code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/css.h |  6 ------
 hw/s390x/css.c         | 31 +------------------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index cd97e2b707..dbf919bdd2 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -333,10 +333,4 @@ static inline int ccw_dstream_read_buf(CcwDataStream *cds, void *buff, int len)
 #define ccw_dstream_read(cds, v) ccw_dstream_read_buf((cds), &(v), sizeof(v))
 #define ccw_dstream_write(cds, v) ccw_dstream_write_buf((cds), &(v), sizeof(v))
 
-/**
- * true if (vmstate based) migration of the channel subsystem
- * is enabled, false if it is disabled.
- */
-extern bool css_migration_enabled;
-
 #endif
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 4e27b2961b..d0680625ca 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -23,8 +23,6 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
 
-bool css_migration_enabled = true;
-
 typedef struct CrwContainer {
     CRW crw;
     QTAILQ_ENTRY(CrwContainer) sibling;
@@ -180,16 +178,10 @@ static const VMStateDescription vmstate_orb = {
     }
 };
 
-static bool vmstate_schdev_orb_needed(void *opaque)
-{
-    return css_migration_enabled;
-}
-
 static const VMStateDescription vmstate_schdev_orb = {
     .name = "s390_subch_dev/orb",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_schdev_orb_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(orb, SubchDev, 1, vmstate_orb, ORB),
         VMSTATE_END_OF_LIST()
@@ -390,33 +382,12 @@ static int subch_dev_post_load(void *opaque, int version_id)
         css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
     }
 
-    if (css_migration_enabled) {
-        /* No compat voodoo to do ;) */
-        return 0;
-    }
-    /*
-     * Hack alert. If we don't migrate the channel subsystem status
-     * we still need to find out if the guest enabled mss/mcss-e.
-     * If the subchannel is enabled, it certainly was able to access it,
-     * so adjust the max_ssid/max_cssid values for relevant ssid/cssid
-     * values. This is not watertight, but better than nothing.
-     */
-    if (s->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA) {
-        if (s->ssid) {
-            channel_subsys.max_ssid = MAX_SSID;
-        }
-        if (s->cssid != channel_subsys.default_cssid) {
-            channel_subsys.max_cssid = MAX_CSSID;
-        }
-    }
     return 0;
 }
 
 void css_register_vmstate(void)
 {
-    if (css_migration_enabled) {
-        vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
-    }
+    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
 }
 
 IndAddr *get_indicator(hwaddr ind_addr, int len)
-- 
2.47.1


