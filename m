Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C04EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WHu-00012Y-KD; Thu, 02 May 2024 09:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHs-000113-NU
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHr-0003W7-2a
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714655746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0P1R04kR/8Ez2AjKF+QPAXV1TLd3NHcfL2DBy3G8lxE=;
 b=CxcJI656bWnh3SlgH9lb55WZ24rXCzkAL/69oZFLGvmKFZ7GAfEQC1qGhJZ9b3I5WX7S9B
 mumh+HD4wfCQl49qMMHEeNfwr+RY1wz4xNEHUR751cyUvOb/3cmbvSH4q94yNBSstIioKE
 I4/scm021het8uuTjEEQruPDK6v7uok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-SfjbLmwcN9KNQ-iieOzn2w-1; Thu, 02 May 2024 09:15:43 -0400
X-MC-Unique: SfjbLmwcN9KNQ-iieOzn2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD24F18065AB;
 Thu,  2 May 2024 13:15:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12CDE1C060D0;
 Thu,  2 May 2024 13:15:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/3] s390x/sclp: Simplify get_sclp_device()
Date: Thu,  2 May 2024 15:15:33 +0200
Message-ID: <20240502131533.377719-4-clg@redhat.com>
In-Reply-To: <20240502131533.377719-1-clg@redhat.com>
References: <20240502131533.377719-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

get_sclp_device() scans the whole machine to find a TYPE_SCLP object.
Now that the SCLPDevice instance is available under the machine state,
use it to simplify the lookup. While at it, remove the inline to let
the compiler decide on how to optimize.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/s390x/sclp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d236dbaf0bdd15c3fc07749a98a5813e05cfb9a1..e725dcd5fdfd159f20307e930a38bed3326c9e0e 100644
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
2.44.0


