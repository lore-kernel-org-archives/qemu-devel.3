Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F95CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE7M-0004PR-Mp; Mon, 15 Jun 2026 16:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7K-0004P5-QS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7J-00031H-Eg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRTIuFaXKBodOo6whbv5vzHQonso1L+1FMqyIqbmFbU=;
 b=gu+wFi8oOr/ZoJgwiu5ZJNgA6WjX/O0uR3f3DNK7Gqfz/Pp+YFIA7LazFnwIp0ZH6xbhQa
 bDGWciTxZyoO3zFa7TBI93Rl5BEnl3s99W/P4We4x5a1SxpCpdnRiBrfLSavPLUxB1IJEx
 qkUnmbJfw+6tMRdkykYmRXTBFnICg1I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-xhwX5otyMmSzbSGLTTcWyA-1; Mon,
 15 Jun 2026 16:41:05 -0400
X-MC-Unique: xhwX5otyMmSzbSGLTTcWyA-1
X-Mimecast-MFC-AGG-ID: xhwX5otyMmSzbSGLTTcWyA_1781556064
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28B8718002FB; Mon, 15 Jun 2026 20:41:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0747D3008B37; Mon, 15 Jun 2026 20:41:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:04 +0400
Subject: [PATCH v2 38/53] hw/s390-virtio-ccw: convert loadparm property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-38-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Gr//4i4oILxW+6Clh3DeXOPUNZCuh9dYC0ICaQZD5Tk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPFUDXY7sdmhgo3we7h1QbrF7nYmdYHOFMW
 lo4AqMTvLyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5XiREACvMUNq4MJ5XzmnmpfsjQe1VgvDamGoJCaC21rU+hkSDt79GESNdCghZ25KdDogbLC8bDS
 aea3FZX8d7/ON9TQ0WEcDfIApc3cHd+XdDGDgXnx0Jdu8d4xsmB9lQSKmR+ntkV/A3Ho+JUVjt3
 2cd2C3h+ivnn8IaLLwKFM8H5rUtXkTMXWnyf3W6ZwAdY1GY0I9Eon6BFQsxjMb5/qNIb9oAkaSZ
 WVTMedy/3FkhrCCN0Q+C50+v9yysFvozno+w1ZsMxKy7Gu2ECHFz20Wpd1JMDv2gHVFmb1rXtbI
 lcB29HnfJxYWp7C50xOgPR0MiGQBOhX4L3SznsMrTjtfzPeB0hxwr8CueWuz454/rDGm/Xy26kt
 9c0gvDJc9L18LzlcGmryw+jf1IU4O2gF3IoxMl2CwK0gFEsnuW3WEjIy3fv2T7MVxRonFJW4jrX
 YtCJ5FPb9lsN+HZcMz4lhxWDXNmL99baM2/xLN0D+jAj3hCD53xD4/PFW56u+DBc/pG6KRxJcWa
 7KbXWtXPh6L1r65So8qe+9WWCHwERJNwhSo3p+4H36bxlTS4P9Gnn5ZxFXaI/H5FD0a/lGuY008
 fWqc0VZXVhscLEuwffCA0G4Gsmx20XTqtAM8zVhE7dDxqqcDWTMlIgY/N4Xc1U35j/R8Fp4WQGO
 AVN3P0Lm9fAdqVw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QAPI type is actually a string. Here also, if we had typedef support
we could expose a more specific type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 25a9fa49554..dcfa9819afa 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -43,6 +43,7 @@
 #include "system/hostmem.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
 #include "kvm/kvm_s390x.h"
@@ -849,7 +850,8 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dea-key-wrap",
             "enable/disable DEA key wrapping using the CPACF wrapping key");
 
-    object_class_property_add(oc, "loadparm", "loadparm",
+    /* if QAPI learns to typedef str, we could expose a more specific type */
+    object_class_property_add_qapi(oc, "loadparm", &str_type_info,
                               machine_get_loadparm, machine_set_loadparm,
                               NULL, NULL);
     object_class_property_set_description(oc, "loadparm",

-- 
2.54.0


