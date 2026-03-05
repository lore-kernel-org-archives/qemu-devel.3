Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1C4F30937
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Jn-0001GF-GA; Thu, 05 Mar 2026 05:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Jm-0001G7-9q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Jk-0005Tl-Pq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=la+BOr95aUp/W7ujdDTh9VuCUIxhvdF/jCyLNUWQAJE=;
 b=IwpxjdQBLp77SXnU0tAR1GZx04e3/vBrCo/eZu6PDd3mP1pLaGaZx3ZdqRWpzPwHJWsgPF
 F50PX6zGFLyWIuCN1bTOR6GTrOu0tefTXZb6UiIJ2KaYeoFYWSnq+hSNoEpXqnazxgtTCp
 ZND83cHVOWqWrqTDi+ZXis9zCAG/IqM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-zTM_p58OMge8UcQdouwq4w-1; Thu,
 05 Mar 2026 05:52:29 -0500
X-MC-Unique: zTM_p58OMge8UcQdouwq4w-1
X-Mimecast-MFC-AGG-ID: zTM_p58OMge8UcQdouwq4w_1772707948
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 059C319560B3; Thu,  5 Mar 2026 10:52:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB4FC3003E98; Thu,  5 Mar 2026 10:52:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 03/28] hw/i386/kvm: Remove
 KVMClockState::mach_use_reliable_get_clock field
Date: Thu,  5 Mar 2026 11:51:50 +0100
Message-ID: <20260305105215.302571-4-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The KVMClockState::mach_use_reliable_get_clock boolean was only
used by the pc-q35-2.8 and pc-i440fx-2.8 machines, which got removed.
Remove it, along with the 'x-mach-use-reliable-get-clock' property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-5-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260225092024.794595-4-thuth@redhat.com>
---
 hw/i386/kvm/clock.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 10d34254f02..7d167c8b006 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -23,7 +23,6 @@
 #include "migration/vmstate.h"
 #include "hw/core/sysbus.h"
 #include "hw/i386/kvm/clock.h"
-#include "hw/core/qdev-properties.h"
 #include "exec/cpu-common.h"
 #include "qapi/error.h"
 
@@ -44,9 +43,6 @@ struct KVMClockState {
     /* whether the 'clock' value was obtained in the 'paused' state */
     bool runstate_paused;
 
-    /* whether machine type supports reliable KVM_GET_CLOCK */
-    bool mach_use_reliable_get_clock;
-
     /* whether the 'clock' value was obtained in a host with
      * reliable KVM_GET_CLOCK */
     bool clock_is_reliable;
@@ -292,18 +288,10 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
     kvm_vmfd_add_change_notifier(&s->kvmclock_vmfd_change_notifier);
 }
 
-static bool kvmclock_clock_is_reliable_needed(void *opaque)
-{
-    KVMClockState *s = opaque;
-
-    return s->mach_use_reliable_get_clock;
-}
-
 static const VMStateDescription kvmclock_reliable_get_clock = {
     .name = "kvmclock/clock_is_reliable",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = kvmclock_clock_is_reliable_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(clock_is_reliable, KVMClockState),
         VMSTATE_END_OF_LIST()
@@ -364,18 +352,12 @@ static const VMStateDescription kvmclock_vmsd = {
     }
 };
 
-static const Property kvmclock_properties[] = {
-    DEFINE_PROP_BOOL("x-mach-use-reliable-get-clock", KVMClockState,
-                      mach_use_reliable_get_clock, true),
-};
-
 static void kvmclock_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
-    device_class_set_props(dc, kvmclock_properties);
 }
 
 static const TypeInfo kvmclock_info = {
-- 
2.53.0


