Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07EDC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Oi-00076q-0m; Tue, 07 Jul 2026 08:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5Oc-0006rH-O1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5Ob-0007Lt-6x
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/x1Nrf+yaPiS52MQo6qAtWtDTqRczZlHJPxKq20iLU=;
 b=i3MAvrxjaoAl924QIGg/9e6fB51Hg7i29WOzIXGmtBS+LttKalJE4W2SCVdZzKzHdqDyOr
 YQooP67wiVJWcNwTy+B3XIGEXV/fznKBX21UcGKGDn8r7vFEUydjpbNtVjgOsvQbO1DtUW
 B137/WTCEPBW7GMFPMIZdKU7qsafb+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-0QA_DNsuOaO5PKGh8rrp3Q-1; Tue,
 07 Jul 2026 08:59:26 -0400
X-MC-Unique: 0QA_DNsuOaO5PKGh8rrp3Q-1
X-Mimecast-MFC-AGG-ID: 0QA_DNsuOaO5PKGh8rrp3Q_1783429165
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 457151801322; Tue,  7 Jul 2026 12:59:25 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 584A81956040; Tue,  7 Jul 2026 12:59:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 14/15] s390x/css: limit number of CHPIDs in description
Date: Tue,  7 Jul 2026 14:58:46 +0200
Message-ID: <20260707125847.1785168-15-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Farman <farman@linux.ibm.com>

virtio-ccw uses a single virtual CHPID for all devices and
device-types, but vfio-ccw (passthrough) shares real CHPID
information with the guest. A sufficiently large passthrough
configuration would exceed the defined response payload.

Fix this by limiting the number of CHPID descriptions that
are returned based on the given response format.

Cc: qemu-stable@nongnu.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-6-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 96d5378f3c18..29ba39f79ea1 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1872,6 +1872,7 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
     int i, desc_size;
     uint32_t words[8];
     uint32_t chpid_type_word;
+    uint32_t max_chpids, chpid_count = 0;
     CssImage *css;
 
     if (!m && !cssid) {
@@ -1882,9 +1883,25 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
     if (!css) {
         return 0;
     }
+
+    if (rfmt == 0) {
+        max_chpids = 256;
+    } else if (rfmt == 1) {
+        max_chpids = 127;
+    } else {
+        /* Should be rejected by caller */
+        return 0;
+    }
+
     desc_size = 0;
     for (i = f_chpid; i <= l_chpid; i++) {
         if (css->chpids[i].in_use) {
+            /* Limit number of CHPIDs sent back */
+            if (chpid_count == max_chpids) {
+                break;
+            }
+
+            chpid_count++;
             chpid_type_word = 0x80000000 | (css->chpids[i].type << 8) | i;
             if (rfmt == 0) {
                 words[0] = cpu_to_be32(chpid_type_word);
-- 
2.54.0


