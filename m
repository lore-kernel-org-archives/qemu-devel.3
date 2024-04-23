Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A9AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHng-0007S3-FZ; Tue, 23 Apr 2024 11:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn8-0004eB-TK
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn5-0000H2-SG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3b4NZw12C67fnamLmqGsicV6QSJgJKW9M7T4Bs+Krw=;
 b=K0UFeoqNRb2oYTp9vlZOuMV26/di4cK+Q3z4xfA93eXOokGtZkhcTr21M7lthfhN7YGQUo
 0vkyAk97ldIwWVSmKkSpG6uhD+l4MlsoyGXlo8hdyQRFkqYzF+cmh+rW7Um22XDi1pgFOa
 64urgne0Xyb0c4BYu4jB/cIir+nbvlM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-vEZD-7t_Mtu7tNDSbX1CVA-1; Tue,
 23 Apr 2024 11:10:33 -0400
X-MC-Unique: vEZD-7t_Mtu7tNDSbX1CVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4272F29AC015;
 Tue, 23 Apr 2024 15:10:33 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DBC8200E290;
 Tue, 23 Apr 2024 15:10:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/63] runstate: skip initial CPU reset if reset is not
 actually possible
Date: Tue, 23 Apr 2024 17:09:27 +0200
Message-ID: <20240423150951.41600-40-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Right now, the system reset is concluded by a call to
cpu_synchronize_all_post_reset() in order to sync any changes
that the machine reset callback applied to the CPU state.

However, for VMs with encrypted state such as SEV-ES guests (currently
the only case of guests with non-resettable CPUs) this cannot be done,
because guest state has already been finalized by machine-init-done notifiers.
cpu_synchronize_all_post_reset() does nothing on these guests, and actually
we would like to make it fail if called once guest has been encrypted.
So, assume that boards that support non-resettable CPUs do not touch
CPU state and that all such setup is done before, at the time of
cpu_synchronize_all_post_init().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index d6ab860ecaa..cb4905a40fc 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -501,7 +501,20 @@ void qemu_system_reset(ShutdownCause reason)
     default:
         qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
     }
-    cpu_synchronize_all_post_reset();
+
+    /*
+     * Some boards use the machine reset callback to point CPUs to the firmware
+     * entry point.  Assume that this is not the case for boards that support
+     * non-resettable CPUs (currently used only for confidential guests), in
+     * which case cpu_synchronize_all_post_init() is enough because
+     * it does _more_  than cpu_synchronize_all_post_reset().
+     */
+    if (cpus_are_resettable()) {
+        cpu_synchronize_all_post_reset();
+    } else {
+        assert(runstate_check(RUN_STATE_PRELAUNCH));
+    }
+
     vm_set_suspended(false);
 }
 
-- 
2.44.0



