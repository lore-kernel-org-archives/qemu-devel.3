Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F6EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Oj-0007EW-A7; Tue, 07 Jul 2026 08:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5Of-0006uR-2k
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5Ob-0007M6-KW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oku21rhRmXEl10yV5mMlbPqzo9z3kdkE5xZILBVSfZg=;
 b=Ld+zVktGmmvZ7eol/gts/1GON8KhMYMwqKkKQjHWswq8mNGsdBwCDx/cX3efyEielfHTMk
 lgNkGFG8VpJSdA4HvtB7tBI/q7m2xH7d73ADshiDOs+eTVaW1k1UK8qBWeKl7NyyAnYPQR
 jMQE3u41KwblFy2KrUE2BB3bkxo2Rhs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-be4c0iStP6G2KF96FgdusA-1; Tue,
 07 Jul 2026 08:59:24 -0400
X-MC-Unique: be4c0iStP6G2KF96FgdusA-1
X-Mimecast-MFC-AGG-ID: be4c0iStP6G2KF96FgdusA_1783429163
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8B1C1954B07; Tue,  7 Jul 2026 12:59:22 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D3271956040; Tue,  7 Jul 2026 12:59:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 13/15] s390x/ioinst: Require strict length and format for SEI
 CHSC handler
Date: Tue,  7 Jul 2026 14:58:45 +0200
Message-ID: <20260707125847.1785168-14-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Ensure SEI commands that are received are of the appropriate length and
format before handling.

Cc: qemu-stable@nongnu.org
Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-5-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/ioinst.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 2320dd4c1224..94619f92155c 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -609,13 +609,27 @@ static int chsc_sei_nt2_have_event(void)
 
 #define CHSC_SEI_NT0    (1ULL << 63)
 #define CHSC_SEI_NT2    (1ULL << 61)
+#define CHSC_SEI_0_FMT 0x0f000000
 static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
 {
     uint64_t selection_mask = ldq_be_p(&req->param1);
+    uint32_t param0 = be32_to_cpu(req->param0);
     uint8_t *res_flags = (uint8_t *)res->data;
+    uint16_t len = be16_to_cpu(req->len);
+    uint16_t resp_code;
     int have_event = 0;
     int have_more = 0;
 
+    if (len != 0x0010) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+
+    if (param0 & CHSC_SEI_0_FMT) {
+        resp_code = 0x0007;
+        goto out_err;
+    }
+
     /* regarding architecture nt0 can not be masked */
     have_event = !chsc_sei_nt0_get_event(res);
     have_more = chsc_sei_nt0_have_event();
@@ -642,6 +656,12 @@ static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
         res->code = cpu_to_be16(0x0005);
         res->len = cpu_to_be16(CHSC_MIN_RESP_LEN);
     }
+    return;
+
+ out_err:
+    res->code = cpu_to_be16(resp_code);
+    res->len = cpu_to_be16(CHSC_MIN_RESP_LEN);
+    res->param = 0;
 }
 
 static void ioinst_handle_chsc_unimplemented(ChscResp *res)
-- 
2.54.0


