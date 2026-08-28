Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD8AC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvKV-0005jR-Qq; Fri, 28 Aug 2026 08:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKR-0005Ye-VJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKQ-0001pp-Aj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryj4j8cwb+L87RB5THQx359dU0bCD3EIL92GqKreHVI=;
 b=WqWULNPMNuO/AxrAJE3/T2ekNgis0Hh161xGelPLjatQHCw2eXOjO8skxV0iGqO58yS7/t
 PwHV+rULzp75B5mELvME5o3U/V6mf5LdZ7Fnhb8ejGHrI1NeRgsTQDUEdKyOOLRg6BenyY
 rpg3ze/Rc9JCqE2ml+PDp3POw/5efTg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-N1c_EQqRMzq8toLfhBgPrA-1; Fri,
 28 Aug 2026 08:04:57 -0400
X-MC-Unique: N1c_EQqRMzq8toLfhBgPrA-1
X-Mimecast-MFC-AGG-ID: N1c_EQqRMzq8toLfhBgPrA_1787918696
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B34C41956047; Fri, 28 Aug 2026 12:04:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7AD31956049; Fri, 28 Aug 2026 12:04:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:03 +0400
Subject: [PATCH v5 06/50] target/i386: return an error for invalid CPU in
 hmp_mce()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-6-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TKMHsISeJFnOg9PU9gqpis8lZrnYbUihXFpgcYqdi0w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4YOnPpLeEoasgzSjVMoWhYQ9YRiFyOHMer
 prikssgnm6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5XC4D/9Fup+EeiRevOsnys3wQS8tnVcoHCR+2/3+DlfTWvBn3jify7+fas/ZRESW8SqDC4UAqkw
 qrOg0wLDx+yvMdC5f2HF7/2k0ddO/2JSCo8RChgGHaDpDvRydqGseGdbjjCYINhpa/vL02hg62+
 W3KJNjZ0xZN+Mhmuhc+nGaImhT6tuyf1q0DmUeFfwZA6i/tAlOM732FbW/VuBMICVSkALkoRcUe
 P0pnGmX/TR+LPD3DZYqu8KNY/Fdatc3PmB6KqSj4eBay8ecAjlDD+/qqdLBQWIQaGtyNdfQHp9R
 XHpa+BtHmR5q8ltGwDIndB8eIDHN41zA1euWsCd4PcIdZOm7ls4ncAxrxWBmhjvCoi/iCdtP5na
 OgNpOiuCSJZlqb43h6I9gYr2im3/cyy7wOLEr7K5hNv1tQJzQfO+umZ/GTcq0MbtNhklxymNeKe
 p7Yedw2zp3dPfOCmOpxUL19y/Wz2P1/ytUEE2dfryvVe8sfYnUlHnJnu6ZTjs7FTptxGFF6txkw
 aw3F/Yf+F5HkJEHaVZZAOqiGJ1ERfbf9CqyJEEP5bVSR9FGBmK0Wdnv+OddFG7MjLxXZtdrTDA0
 CZOUeCgXW4Q4rxR4Qy/7kIRasnFAUqklseald5usY9LMVnm7IQGEBAl5Djf4LMUBfsFkA+LUk3A
 aE1i3XRYyfXIvUg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Rather than silently doing nothing.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/monitor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 785a13dd7107..9ed772e6d7f2 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -586,10 +586,12 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
         flags |= MCE_INJECT_BROADCAST;
     }
     cs = qemu_get_cpu(cpu_index);
-    if (cs != NULL) {
+    if (cs) {
         cpu = X86_CPU(cs);
         cpu_x86_inject_mce(cpu, bank, status, mcg_status, addr, misc,
                            flags, &err);
-        hmp_handle_error(mon, err);
+    } else {
+        error_setg(&err, "Invalid CPU %d", cpu_index);
     }
+    hmp_handle_error(mon, err);
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


