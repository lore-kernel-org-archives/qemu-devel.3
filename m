Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21671E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfzG-0005iN-45; Wed, 18 Feb 2026 06:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfya-00042j-2L
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyX-0007wF-Tg
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=YTjHBx3lFHPkaL8visi/xk3E1EyezRES20122c87Q6Vi593v73O6oSs7QDGMv2Mvm0G6OP
 9yxlZs7x58t9EMbnW0GEJipn0b6er4AC4bHzhOteINTvV5XlfkrMVXFRWlsWWfi7O2DaSY
 M2f2oGBOZfMCpOV9Zn9Fo49p+qwga1E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Jiy1fpikMSq0Nw0avLrKcg-1; Wed, 18 Feb 2026 06:44:01 -0500
X-MC-Unique: Jiy1fpikMSq0Nw0avLrKcg-1
X-Mimecast-MFC-AGG-ID: Jiy1fpikMSq0Nw0avLrKcg_1771415040
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aae146bab0so63754625ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415040; x=1772019840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=N0apZ3kjCh8qdVjRoBQr9AQq2A8KwLONaot4LMVBtYzcQEkerHu7Gq21E7eNq0bdcW
 6OP+GOwjkbiJC5FbMpKDF84QjdXyzcBAdBSF6lyELukzl1ycG/s9kxnoUM0E/W9+tLis
 MMqRxHWuG3rIpXGawBWr6HLuQ8Rje92q3QZuG54/OVvywJwt3osFGNoEI1niQv7v9u6O
 9aGih5JSmfi+Hnhbeod5PPMyvutvL5TeFSfEsVBAi98tDqrvkweiR2ixCtK5Gj3i/4kc
 po4yRvDhVoC66R7NiEDn+EOj6gVCgDqmXvXqXmVwslVFQiwpNViVwl7p8Z1XmYDpdFIt
 zOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415040; x=1772019840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=LdI+MsRrM/K/fY8uQU39EZOSxacqa05N9hJjeR9a8G6ujXnLOMjaG3rha7Jo45O16p
 8EYy7xK+/4yTmPDGQc8UV0TGvf23UwHPSUhEdmWw+oDe0SNS+9BPmYallcu6ZiUnA0NK
 5maUO5j9C3MrRpXlfM8NlqszhsBMyrcb0hM65GVscwR/1qrO9tGvJHodQvWty+oyuxuI
 3MijmtbB+P5XLZ05WzuC6VhipS+hOrR5GEnaegZZLqHs5SZLbs2srb6pmQCy6EG8PdtM
 l9u8lnTh8TN2TD0VFekfdMHVRyoV73YAIAehgfnY9uwHPVIjOdPYoxuku4qpyTPdHnwz
 m8Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyhODSrpPepUkvKgvPWks3yJW4XTYbKRc+FXppN45wnIES6CEvPeUayfqFAEqU4W0R90kpJTqJruAW@nongnu.org
X-Gm-Message-State: AOJu0YzEm9JveUUrFM702dR8eiAS6No5r6ieWUAmZGRE8Ii+Y+OCDpoZ
 i3prKu7DNz9nxcanwiuyp2ojJcC79+MjZgEXvH6jl2RzL6yZmnyKVF50zW+yK0YAAEDi0W7W35y
 urfPwhCCqRKkyar1WrNKdmh7ebqg+V8ZzFIs8JdVCWPK3aBCQRftNWCnR
X-Gm-Gg: AZuq6aJR9tf6XTNe6cfAw2EW8GkaTBIwD3l+c3bX72tFX9Ipole91nPF+5Z9b5EFRFC
 5rL2MQbGgZLajO7GaspiW16RBmpeyOv5Umqzc6otfuf+Yepo5zjrrswcCYCRZYA8DmvTP4H7L42
 HsGPT4I/f5oyqh+y659J8yXQEHHbEyXT/9R/VCBn8dum08ISDeEkVV1ljl/vzUSk7sP6JSdJo5R
 Uah99IEBfZgRhvl2bOvUSb8acEAeFeszNj5HTLkM0tApS2M0LPQ+R5p8ZEFwFjsFhE/+116wfSJ
 IE3SrKDrqSlr/X4RI891ii1dW1D5syMC2121mMxmf3yxCto3wV4ZK7G17moUGtK5BhkkxRKBfHZ
 I5oKCZqMMLJxPD9Gnv0nB3aOdiDKhCCHCIxDkN2UL4lN6CSZtBoXX
X-Received: by 2002:a17:903:3d0b:b0:2a7:a9e4:babc with SMTP id
 d9443c01a7336-2ab50647207mr184076235ad.61.1771415040508; 
 Wed, 18 Feb 2026 03:44:00 -0800 (PST)
X-Received: by 2002:a17:903:3d0b:b0:2a7:a9e4:babc with SMTP id
 d9443c01a7336-2ab50647207mr184076035ad.61.1771415040119; 
 Wed, 18 Feb 2026 03:44:00 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:59 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 24/34] kvm/i8254: add support for confidential guest reset
Date: Wed, 18 Feb 2026 17:12:17 +0530
Message-ID: <20260218114233.266178-25-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
re-initialized again. This is done with the help of a notifier which is invoked
upon KVM vm file descriptor change during the confidential guest reset process.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c      | 23 +++++++++++++++++++++++
 hw/i386/kvm/trace-events |  1 +
 2 files changed, 24 insertions(+)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 255047458a..70e8fd83cd 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -35,6 +35,7 @@
 #include "hw/core/qdev-properties-system.h"
 #include "system/kvm.h"
 #include "target/i386/kvm/kvm_i386.h"
+#include "trace.h"
 #include "qom/object.h"
 
 #define KVM_PIT_REINJECT_BIT 0
@@ -52,6 +53,8 @@ struct KVMPITState {
     LostTickPolicy lost_tick_policy;
     bool vm_stopped;
     int64_t kernel_clock_offset;
+
+    NotifierWithReturn kvmpit_vmfd_change_notifier;
 };
 
 struct KVMPITClass {
@@ -203,6 +206,23 @@ static void kvm_pit_put(PITCommonState *pit)
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
+
+    trace_kvmpit_post_vmfd_change();
+    return 0;
+}
+
 static void kvm_pit_set_gate(PITCommonState *s, PITChannelState *sc, int val)
 {
     kvm_pit_get(s);
@@ -292,6 +312,9 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 
     qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
 
+    s->kvmpit_vmfd_change_notifier.notify = kvmpit_post_vmfd_change;
+    kvm_vmfd_add_change_notifier(&s->kvmpit_vmfd_change_notifier);
+
     kpc->parent_realize(dev, errp);
 }
 
diff --git a/hw/i386/kvm/trace-events b/hw/i386/kvm/trace-events
index 67bf7f174e..33680ff82b 100644
--- a/hw/i386/kvm/trace-events
+++ b/hw/i386/kvm/trace-events
@@ -20,3 +20,4 @@ xenstore_reset_watches(void) ""
 xenstore_watch_event(const char *path, const char *token) "path %s token %s"
 xen_primary_console_create(void) ""
 xen_primary_console_reset(int port) "port %u"
+kvmpit_post_vmfd_change(void) ""
-- 
2.42.0


