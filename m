Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176E5CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2Og-0002VZ-JD; Tue, 24 Sep 2024 06:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2Oa-0002Db-TK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2OX-000311-VI
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727172224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZBWguW1/yxKfTN4VFQnwjD6U0kQnYjphKMOOnuruhE=;
 b=U9uuu4xqROfNMT4+EqSpxG82DOSp0rx/QbJs7NuHTmJYWqgihqJZER0GKqubHZ1SbAK2og
 6PBMIBoHvBwJ1qxXSbsVc1TR6zKmk8GOZ2rI4dJPAq53dgmfs5JBp1s9ij7KrDeffAbcOJ
 6yfIzYL/fs/BBihSZIwgF6qgUd1HDCg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-JpgQ47lWMRKJvxxVLZpcQA-1; Tue,
 24 Sep 2024 06:03:43 -0400
X-MC-Unique: JpgQ47lWMRKJvxxVLZpcQA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A621219B9AA9; Tue, 24 Sep 2024 10:03:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A37C71956052; Tue, 24 Sep 2024 10:03:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 3/6] reset: Add RESET_TYPE_WAKEUP
Date: Tue, 24 Sep 2024 12:03:26 +0200
Message-ID: <20240924100329.248738-4-david@redhat.com>
In-Reply-To: <20240924100329.248738-1-david@redhat.com>
References: <20240924100329.248738-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Some devices need to distinguish cold start reset from waking up from a
suspended state. This patch adds new value to the enum, and updates the
i386 wakeup method to use this new reset type.

Message-ID: <20240904103722.946194-3-jmarcin@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 docs/devel/reset.rst    | 12 +++++++++++-
 hw/i386/pc.c            |  2 +-
 include/hw/resettable.h |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index ed41e09f16..74c7c0171a 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -44,6 +44,17 @@ The Resettable interface handles reset types with an enum ``ResetType``:
   value on each cold reset, such as RNG seed information, and which they
   must not reinitialize on a snapshot-load reset.
 
+``RESET_TYPE_WAKEUP``
+  If the machine supports waking up from a suspended state and needs to reset
+  its devices during wake-up (from the ``MachineClass::wakeup()`` method), this
+  reset type should be used for such a request. Devices can utilize this reset
+  type to differentiate the reset requested during machine wake-up from other
+  reset requests. For example, RAM content must not be lost during wake-up, and
+  memory devices like virtio-mem that provide additional RAM must not reset
+  such state during wake-ups, but might do so during cold resets. However, this
+  reset type should not be used for wake-up detection, as not every machine
+  type issues a device reset request during wake-up.
+
 ``RESET_TYPE_S390_CPU_NORMAL``
   This is only used for S390 CPU objects; it clears interrupts, stops
   processing, and clears the TLB, but does not touch register contents.
@@ -53,7 +64,6 @@ The Resettable interface handles reset types with an enum ``ResetType``:
   ``RESET_TYPE_S390_CPU_NORMAL`` does and also clears the PSW, prefix,
   FPC, timer and control registers. It does not touch gprs, fprs or acrs.
 
-
 Devices which implement reset methods must treat any unknown ``ResetType``
 as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
 existing code we need to change if we add more types in future.
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 79a626a3eb..80a65d965f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1732,7 +1732,7 @@ static void pc_machine_reset(MachineState *machine, ResetType type)
 static void pc_machine_wakeup(MachineState *machine)
 {
     cpu_synchronize_all_states();
-    pc_machine_reset(machine, RESET_TYPE_COLD);
+    pc_machine_reset(machine, RESET_TYPE_WAKEUP);
     cpu_synchronize_all_post_reset();
 }
 
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 94f6f22e3c..fd862f1e9f 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -29,6 +29,7 @@ typedef struct ResettableState ResettableState;
  * Types of reset.
  *
  * + Cold: reset resulting from a power cycle of the object.
+ * + Wakeup: reset resulting from a wake-up from a suspended state.
  *
  * TODO: Support has to be added to handle more types. In particular,
  * ResettableState structure needs to be expanded.
@@ -36,6 +37,7 @@ typedef struct ResettableState ResettableState;
 typedef enum ResetType {
     RESET_TYPE_COLD,
     RESET_TYPE_SNAPSHOT_LOAD,
+    RESET_TYPE_WAKEUP,
     RESET_TYPE_S390_CPU_INITIAL,
     RESET_TYPE_S390_CPU_NORMAL,
 } ResetType;
-- 
2.46.1


