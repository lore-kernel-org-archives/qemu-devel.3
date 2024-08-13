Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A49C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtcp-0002Xd-VB; Tue, 13 Aug 2024 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtco-0002WC-4s
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtck-0007Nz-Re
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723563587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKlbBxCYrHitgNzBkF0+aHXTCrRmB3QYkEvCuJrF+lQ=;
 b=RivFbuh8sFaLOA6RsEqsRK+w/8GeInB9Miggobjwo28KjzIdUQpMRJuBoeJxNGxoYCg+c0
 fB+8UQgN4VssjAyBXsK4g2m2BGZmy9KIzIw7Yjle3/z0u9zWOUeDAYwm+ZeLhqj5bqQELc
 3Fhsvnda8TsYKKVFpbZO3iKYMfCxusA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-MN-JatbMM-6Xyl5IWu6uvQ-1; Tue,
 13 Aug 2024 11:39:46 -0400
X-MC-Unique: MN-JatbMM-6Xyl5IWu6uvQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB2EB1955F45; Tue, 13 Aug 2024 15:39:44 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.226.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1B53300019C; Tue, 13 Aug 2024 15:39:42 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
Date: Tue, 13 Aug 2024 17:39:18 +0200
Message-ID: <20240813153922.311788-3-jmarcin@redhat.com>
In-Reply-To: <20240813153922.311788-1-jmarcin@redhat.com>
References: <20240813153922.311788-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some devices need to distinguish cold start reset from waking up from a
suspended state. This patch adds new value to the enum, and updates the
i386 wakeup method to use this new reset type.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 docs/devel/reset.rst    | 8 ++++++++
 hw/i386/pc.c            | 2 +-
 include/hw/resettable.h | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 9746a4e8a0..a7c9467313 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -44,6 +44,14 @@ The Resettable interface handles reset types with an enum ``ResetType``:
   value on each cold reset, such as RNG seed information, and which they
   must not reinitialize on a snapshot-load reset.
 
+``RESET_TYPE_WAKEUP``
+  This type is called for a reset when the system is being woken-up from a
+  suspended state using the ``qemu_system_wakeup()`` function. If the machine
+  needs to reset its devices in its ``MachineClass::wakeup()`` method, this
+  reset type should be used, so devices can differentiate system wake-up from
+  other reset types. For example, a virtio-mem device must not unplug its
+  memory during wake-up as that would clear the guest RAM.
+
 Devices which implement reset methods must treat any unknown ``ResetType``
 as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
 existing code we need to change if we add more types in future.
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ccb9731c91..49efd0a997 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1716,7 +1716,7 @@ static void pc_machine_reset(MachineState *machine, ResetType type)
 static void pc_machine_wakeup(MachineState *machine)
 {
     cpu_synchronize_all_states();
-    pc_machine_reset(machine, RESET_TYPE_COLD);
+    pc_machine_reset(machine, RESET_TYPE_WAKEUP);
     cpu_synchronize_all_post_reset();
 }
 
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 7e249deb8b..edb1f1361b 100644
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
 } ResetType;
 
 /*
-- 
2.46.0


