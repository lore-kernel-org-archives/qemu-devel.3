Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4743BE9B359
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0eC-00030H-23; Mon, 02 Mar 2026 05:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0e6-0002y1-4j
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0e1-0001qD-Un
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772447815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7hdK2T2rhmDCPf6n3Eg8p5Wr+WAP8uwwd7SD8gK1RA=;
 b=BELndcV1N3HfB4/t9pvWMKT/gvRpRbzk43eXnjdHKW4lClBnQq4w96F1wLIi+Hy0ubonZM
 8mT3xcmU4JsMY3O3wuGEqGJ/fT16K9hywrPsRas/kpxiBjf8XNHR/ovD2OrIOxIHwvm93o
 0BCo1fJ1xK9g6hQqGdwKNFwSgiVcHKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-cgu0EvQxNU6Mc71-aMnsnA-1; Mon,
 02 Mar 2026 05:36:52 -0500
X-MC-Unique: cgu0EvQxNU6Mc71-aMnsnA-1
X-Mimecast-MFC-AGG-ID: cgu0EvQxNU6Mc71-aMnsnA_1772447811
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2936118001E3; Mon,  2 Mar 2026 10:36:51 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBF271800666; Mon,  2 Mar 2026 10:36:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v7 1/7] target/arm/machine: Fix detection of unknown incoming
 cpregs
Date: Mon,  2 Mar 2026 11:35:23 +0100
Message-ID: <20260302103640.1362564-2-eric.auger@redhat.com>
In-Reply-To: <20260302103640.1362564-1-eric.auger@redhat.com>
References: <20260302103640.1362564-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Currently the check of cpreg index matches fail to detect
a situation where the length of both arrays is same but
- destination has an extra register not found in the incoming stream (idx1)
- source has an extra register not found in the destination (idx2)
  where idx1 < = idx2
Normally this should fail but it does not.

Fix the logic to scan all indexes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: 721fae12536 ("target-arm: Convert TCG to using (index,value) list for cp migration")
---
 target/arm/machine.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 7a3b5a87932..9297a8f5b41 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1107,6 +1107,29 @@ static int cpu_post_load(void *opaque, int version_id)
         i++;
         v++;
     }
+    /*
+     * if we have reached the end of the incoming array but there are
+     * still regs in cpreg, continue parsing the regs which are missing
+     * in the input stream
+     */
+    for ( ; i < cpu->cpreg_array_len; i++) {
+        g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
+
+        warn_report("%s: %s "
+                    "expected by the destination but not in the incoming stream, "
+                    "skip it", __func__, name);
+    }
+    /*
+     * if we have reached the end of the cpreg array but there are
+     * still regs in the input stream, continue parsing the vmstate array
+     */
+    for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
+        g_autofree gchar *name = print_register_name(cpu->cpreg_vmstate_indexes[v]);
+
+        error_report("%s: %s in the incoming stream but unknown on the destination, "
+                     "fail migration", __func__, name);
+        fail = true;
+    }
     if (fail) {
         return -1;
     }
-- 
2.53.0


