Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB8C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 06:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5JwH-0001Nl-SV; Fri, 10 May 2024 02:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5Jvd-00017c-To
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvR-0001Y4-EI
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715323212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnQHlqbpbwtC41oePd9E7PL+QKFsjDBZiYZDh48F+io=;
 b=K6KPNk0HmPI/tw8xuuaojDL922Y67xMXB+TtB9aMZMtTI+iDjx0FIJWq++ivk6Uid5d4Lm
 QRC6FujgE6dup8XZSXWL4WhyV9bd8Xn3hnheCQHPtJt06WnQ3Uv4N1Ya8lYgKDhSHD2k2T
 deJxbM0Gitvex0BqrfbvbLOIB23e5ZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-QI7Tx3fiMJK61xFSjblK7Q-1; Fri, 10 May 2024 02:40:11 -0400
X-MC-Unique: QI7Tx3fiMJK61xFSjblK7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCB13800206;
 Fri, 10 May 2024 06:40:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51C4D2087D72;
 Fri, 10 May 2024 06:40:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/8] s390x/sclp: Simplify get_sclp_device()
Date: Fri, 10 May 2024 08:39:57 +0200
Message-ID: <20240510064001.26002-5-thuth@redhat.com>
In-Reply-To: <20240510064001.26002-1-thuth@redhat.com>
References: <20240510064001.26002-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

get_sclp_device() scans the whole machine to find a TYPE_SCLP object.
Now that the SCLPDevice instance is available under the machine state,
use it to simplify the lookup. While at it, remove the inline to let
the compiler decide on how to optimize.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20240502131533.377719-4-clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d236dbaf0b..e725dcd5fd 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -21,13 +21,14 @@
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/cpu-topology.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
-static inline SCLPDevice *get_sclp_device(void)
+static SCLPDevice *get_sclp_device(void)
 {
     static SCLPDevice *sclp;
 
     if (!sclp) {
-        sclp = SCLP(object_resolve_path_type("", TYPE_SCLP, NULL));
+        sclp = S390_CCW_MACHINE(qdev_get_machine())->sclp;
     }
     return sclp;
 }
-- 
2.45.0


