Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61E1CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wb-0005Nt-V4; Sat, 16 May 2026 04:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wL-00055h-B0
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wH-0007AK-0q
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUOSWzhXl/k5m1peWGpzHvutpmGh4e3ebknaM+K7zLs=;
 b=arx1hqoF1pDNm3rMLp+s3VCvnOi2FDyUUoo0ukAloCB0vLeKEcHSBqh+hY/fj4c6d2Snbv
 aFpF5EwuQTE+hkuzN9fuVsu1n737jxOCbOphB9eLA7ezsJVjWxZ77dMLIHNDBUUZ9MkrZk
 rS/XqdufinEqI1znOt2NIapQSofL+JU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-ERnuTVFEO_i7KQSIvVg8ZQ-1; Sat,
 16 May 2026 03:59:58 -0400
X-MC-Unique: ERnuTVFEO_i7KQSIvVg8ZQ-1
X-Mimecast-MFC-AGG-ID: ERnuTVFEO_i7KQSIvVg8ZQ_1778918397
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0DC11956094
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 07:59:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 901BD1956053; Sat, 16 May 2026 07:59:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:06 +0400
Subject: [PATCH v3 07/24] hw/ipmi: reject NULL 'bmc' property rather than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-7-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=711;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hN3dhAnonNDSvyTPH4pe7+NR9c8xdMiWFLz/sdnw2qY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPtFy5k6DHrXUircADXNtRAQLBxZPJbE0nP
 V1tpzFN7LKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5VshD/92cZRblsDR0GmpZX3t7ALc7ceboY7Cy4/D2i3x8jS8i2LnJJXA8Qfp1kZ+udJtLrlvaP2
 QCMlBtNfvcrc0nCJNG4B5H7d/pnFdhpKOvTeFaKgsSAqiBJzNcppxgbS7TxkO4v72nAXeQb0wzz
 P3/WYvre3Ys5K5lBabsERidyVK8HJz/xs+/I2xhL2iaUOMqprUFvLmIB0pPBL6JVT7rGbDldnKL
 753K/O5h82EaWVk9rkLECZwB6mvOQ7WpQEPFYyvch26dx6APYeNZgiTV4LJabxzVQClXcOyHnsg
 iLUm8LJkh55X+2fI+ij4kzN4KhdXNpoH3T5ludqw4ptRjqbA2WPc8rcVm5X1aOfKX6yMGoA+e0B
 zlIgOHncKHrZNUcZj5jxMbllEQo0/gOVrxEYSmw/g90PsNxKYtcd6UsDBq6XcWN7P+jYrGzPKV0
 fpmonVvVLfniblb+Ffi7xIc4e+0wWUPFO442tOZPKeEviJo6RxUfq0+VxvLEVERn25D8ZIF3roL
 N1xLMPRs0Gznqa59JUVI3Kx7fKnAVHZD83+kCN89rDWqSkcLIaY0h6UY1ip8VudOebd4gzBFbSF
 jaH7V7SIjhK5mweAqCz/ig10IILtyDgV0P1WtM5WdQ4ZbOD97+ab9FAeLTpbwPR1ztzjcgUo8jv
 Cku9jlFc1+2VwRg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ipmi/ipmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index b49affaccec..74818ff3cea 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -97,8 +97,14 @@ static void isa_ipmi_bmc_check(const Object *obj, const char *name,
 {
     IPMIBmc *bmc = IPMI_BMC(val);
 
-    if (bmc->intf)
+    if (!bmc) {
+        error_setg(errp, "%s cannot be set to NULL", name);
+        return;
+    }
+
+    if (bmc->intf) {
         error_setg(errp, "BMC object is already in use");
+    }
 }
 
 void ipmi_bmc_find_and_link(Object *obj, Object **bmc)

-- 
2.54.0


