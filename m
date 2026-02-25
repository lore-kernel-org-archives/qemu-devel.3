Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ADDF55456
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5w5-0002EC-03; Tue, 24 Feb 2026 22:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5w3-00023l-4P
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5w1-0008CB-Ax
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=OFdBz+yeBqQpxnewIwIHxK36ZswQbznvjoriV1+Yw6EDY/lcLvOR1rop4dRrwgWtTVxHNq
 Asggvt0l6Q1diHx6m/Z4I/OijwGGzsYQAOsa7K+KOJJLO1MRBUfg+LotqDWMEqcIolufcY
 fhGQv4/Wjw+Ch15VypLmkW+wIdurHOY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-W1cgUgYJMaumF1S6cDzOAg-1; Tue, 24 Feb 2026 22:51:34 -0500
X-MC-Unique: W1cgUgYJMaumF1S6cDzOAg-1
X-Mimecast-MFC-AGG-ID: W1cgUgYJMaumF1S6cDzOAg_1771991494
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3562bdba6f7so37447399a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991493; x=1772596293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=Gd6OFKn1ph9hw3hP+qx7iV9Egk91EWdlgX1e+ZPLmA81wrVFvSFE6DiZ1jES803qfS
 fzrVUUbTGlleuEv/PAA6EWbx0aIQjdk4ZavwyULe0hgz4BnKQEgVkD0oVkDem1qbTkEm
 nWDHoRMR9ppaOK5PDO6Ac7XriooOBwUvSoa3prt3es7tJhdQX8V0p62W/AOHkaZNea44
 KZtA4uXhXnyhpD7Bc4N/XKf6hIsMO/MLeP3xDSzGlSQDwSZtJb2mJ+dw6Gbi1X1lywv8
 N9db/5N/D77WS4I0ZqDrMHDH25mRgMe15nj3baBKXmXWRXPPUHDz0VFlntQDn8ATocN1
 cXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991493; x=1772596293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=Gw4IOmNR3ynVb3R9SuWATOt33H0cqiFtCu+e994YeMKnX/z0UzM1fTqrByaIYoeFJG
 eX/BziBKzpg25gGYKnSkumaWar23UJ2hOskk21Zw2xaLeUaZuEgCwMCnVCl0GmTnaF5o
 mpfwa1LwvyPyj/kTPQcynnhch5k6YXmJZ1d5GI96QrvWDoJZOzju/iHsE23hNfga8TLi
 mK89JnC3AMZtASgj4NdYwSPEOlt+nWy0akHYsdWi8mhS+3FB0hpFlDlqsOBqmCIaysfv
 NSGoLlvpWEf2/J7li/42qpfFQSPvdX7I9kwoyDomdiHRqt7+dQJ+XP+8EJIebVTVtwlh
 TAMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxkM/IBnS5wLCMyhlHs6cdrZV5NDw6u6AroaRgFkeB6+gW1sxpqaB+J6b7a5mRySLztkTLV8RVrFAy@nongnu.org
X-Gm-Message-State: AOJu0Yy3+kuOfc+dvk+9AzjqiJ9MwSaYAQGQXZQCygRqEIoR8CGY8+sE
 XWenrRgmxVyw+ViE/jO0S6tM7fXKVQXO87crwQI63XfKMni8DqIg2nj/oeBnYatrOJ57re+GYfh
 pE4rX0yw7+b3KfklDlLVX+QRUDKx8xTLQ4Inu+9gfoxZa8R5IgRIUmnSi
X-Gm-Gg: ATEYQzwi0uMnK/0c86IKIP1jovfX3KkzxnPoM01THndDGCfrPVedH0QqMix6+hVexXp
 ClKEPhMkSGxEPc7KeeQVhIc7KDlHaGPfSCfLeG5cFRKBoLa/ifHFo4H5qRzKUa4qXpO3NEpJk1r
 8zur6IcZ2Hap8GPNtKm3xJ6ixKPFILOrY/aoepNFOfGDN+czLMXycG7ipnnmhA/aYZDrqo1oMYw
 w/4KdRmbo5ZPoNlL7i/WhagnEhhE/oqwxq0n8h4ggFhFQiTOwG8mgPrTmHR0Qj0WH/btHX1SpYF
 UiuI/e0wEkcg+hFNRfQIDQ+NbYrNNSJUY9Z6kJqFLYCzJxN0I+46qXgcN4k/YUGyALGzQOuPo/G
 G1nrGAvfRadc7n0tflKOR7aFs1OWsYEB46jdkYMTr/ibpMofSOJL6gzA=
X-Received: by 2002:a17:90b:528d:b0:34c:f92a:ad05 with SMTP id
 98e67ed59e1d1-358ae810f2amr14618588a91.11.1771991493582; 
 Tue, 24 Feb 2026 19:51:33 -0800 (PST)
X-Received: by 2002:a17:90b:528d:b0:34c:f92a:ad05 with SMTP id
 98e67ed59e1d1-358ae810f2amr14618552a91.11.1771991493231; 
 Tue, 24 Feb 2026 19:51:33 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:32 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 25/35] kvm/i8254: add support for confidential guest reset
Date: Wed, 25 Feb 2026 09:19:30 +0530
Message-ID: <20260225035000.385950-26-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


