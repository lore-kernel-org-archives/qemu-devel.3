Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC54C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7wf4-0004y6-An; Fri, 17 May 2024 08:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wf1-0004u9-B5
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wez-0006HA-H4
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715948764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTxNrBzfSiSy5sRAFW60eW3MEqICmX9H7w1MzFepTP4=;
 b=VKJMCXeZmderqyDhI9knm5KUNt0YA5a+69wdIwlHqsdiC8dKIB1z9TI0SvNTnfbZB9pbEc
 pXAcOqIrhxAk4h7nx8HwM795800/CZJTMk/1m7paPIU7KdqVZdSArSZGmZ0Wm87lSvKWTF
 +LQocL6jGNMXVrN7X7VvnuzYSbfoJds=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-ov6S77mJP9WMxskeRWQ2Jg-1; Fri,
 17 May 2024 08:26:02 -0400
X-MC-Unique: ov6S77mJP9WMxskeRWQ2Jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FDCC1C0513E;
 Fri, 17 May 2024 12:26:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B88F01050173;
 Fri, 17 May 2024 12:26:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 6/6] hw/intc/s390_flic: Fix crash that occurs when saving the
 machine state
Date: Fri, 17 May 2024 14:25:52 +0200
Message-ID: <20240517122552.584215-7-thuth@redhat.com>
In-Reply-To: <20240517122552.584215-1-thuth@redhat.com>
References: <20240517122552.584215-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
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

adapter_info_so_needed() treats its "opaque" parameter as a S390FLICState,
but the function belongs to a VMStateDescription that is attached to a
TYPE_VIRTIO_CCW_BUS device. This is currently causing a crash when the
user tries to save or migrate the VM state. Fix it by using s390_get_flic()
to get the correct device here instead.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: 9d1b0f5bf5 ("s390_flic: add migration-enabled property")
Message-ID: <20240517061553.564529-1-thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/intc/s390_flic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 7f93080087..6771645699 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -459,7 +459,7 @@ type_init(qemu_s390_flic_register_types)
 
 static bool adapter_info_so_needed(void *opaque)
 {
-    S390FLICState *fs = S390_FLIC_COMMON(opaque);
+    S390FLICState *fs = s390_get_flic();
 
     return fs->migration_enabled;
 }
-- 
2.45.0


