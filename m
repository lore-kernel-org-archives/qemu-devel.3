Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DECFC36001
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdjk-0001g8-Si; Fri, 21 Mar 2025 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjQ-0001TK-0E
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjM-0006wO-Oo
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742568736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4IlkA+BDEs0dZvUh1iG6H9r7xIlAl+U1LpUL2MidbY=;
 b=CUb+6yv5x7ZYvZG4dYnpfZmqh2TigfxbwxegktQ8C0nHHYuZ3/FF+j6GhhRHE8WpL+RSy5
 UMzK1KqT3iKnLGkKWGkp1UtHg1tyqm6o52fgKXhILvUNGAtHiRt7zqNFIr46EOu11z28JR
 bcLwWI1/ZxCMGebaiyO+n9T825rItzw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-gThA4hAkNiq4EXWvzJsi2w-1; Fri,
 21 Mar 2025 10:52:10 -0400
X-MC-Unique: gThA4hAkNiq4EXWvzJsi2w-1
X-Mimecast-MFC-AGG-ID: gThA4hAkNiq4EXWvzJsi2w_1742568730
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73AC7180025A; Fri, 21 Mar 2025 14:52:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142401955DCE; Fri, 21 Mar 2025 14:52:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0D5D21E65DC; Fri, 21 Mar 2025 15:51:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 8/8] target/loongarch: Clean up virt_cpu_irq_init() error
 handling
Date: Fri, 21 Mar 2025 15:51:58 +0100
Message-ID: <20250321145158.3896812-9-armbru@redhat.com>
In-Reply-To: <20250321145158.3896812-1-armbru@redhat.com>
References: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL. Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

virt_cpu_irq_init() is wrong that way: it passes &err to
hotplug_handler_plug() twice.  If both calls failed, this could trip
error_setv()'s assertion.  Moreover, if just one fails, the Error
object leaks. Fortunately, these calls can't actually fail.

Messed up in commit 50ebc3fc47f7 (hw/intc/loongarch_ipi: Notify ipi
object when cpu is plugged) and commit 087a23a87c57
(hw/intc/loongarch_extioi: Use cpu plug notification).

Clean this up by passing &error_abort instead.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250320032158.1762751-7-maobibo@loongson.cn>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/loongarch/virt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4674bd9163..63477de5e4 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -327,7 +327,6 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *possible_cpus;
     CPUState *cs;
-    Error *err = NULL;
 
     /* cpu nodes */
     possible_cpus = mc->possible_cpu_arch_ids(ms);
@@ -337,8 +336,10 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
             continue;
         }
 
-        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs), &err);
-        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs), &err);
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs),
+                             &error_abort);
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
+                             &error_abort);
     }
 }
 
-- 
2.48.1


