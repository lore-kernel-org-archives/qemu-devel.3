Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F28EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZVy-0003uL-8n; Tue, 14 Jul 2026 05:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZVv-0003sD-52
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZVt-000114-Nm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784021597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDKgAs2x1Nfh0CRXksnOX3J7Z0BVFqSTf5B3EBdO7Og=;
 b=J/2zAD/BU9tZ5sUO7+dqNICLYIM27J2/rRm8rHz8VhzRejRMvnVtSDHs+YONFg+UXBtsG1
 /KpfhqOtXntTFW4TROSrBbngwCaL/4aFyNfAfeEUiLeAg3RBW5bRFfGq9RxBz862A7NHHO
 ob9VfrigJV/G/1nGwUpaao+DuoUb6Us=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-p7WE2GvSO5qKUszCFTP12w-1; Tue,
 14 Jul 2026 05:33:12 -0400
X-MC-Unique: p7WE2GvSO5qKUszCFTP12w-1
X-Mimecast-MFC-AGG-ID: p7WE2GvSO5qKUszCFTP12w_1784021591
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2478195606A; Tue, 14 Jul 2026 09:33:10 +0000 (UTC)
Received: from gondolin.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10033D6E; Tue, 14 Jul 2026 09:33:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL for-11.1 2/3] s390x/sclpcpi: check event length field before
 reading from buffer
Date: Tue, 14 Jul 2026 11:32:59 +0200
Message-ID: <20260714093300.2193848-3-cohuck@redhat.com>
In-Reply-To: <20260714093300.2193848-1-cohuck@redhat.com>
References: <20260714093300.2193848-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=cohuck@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

A guest might send a too short SCCB with SCLP_EVENT_CTRL_PGM_ID. QEMU
would fill its data structures with garbage data. Check for the precise
length of the CBI data structure and reject otherwise.

Fixes: f345978f24be ("hw/s390x: add Control-Program Identification to QOM")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20260709142906.197474-3-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclpcpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 68fc1b809bf3..ec4bdf23509b 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -97,6 +97,11 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
                                              ebh);
     SCLPEventCPI *e = SCLP_EVENT_CPI(event);
 
+    /* Caller checks sccb length, buffer header checking is our duty */
+    if (be16_to_cpu(evt_buf_hdr->length) != sizeof(ControlProgramIdMsg)) {
+        return SCLP_RC_INCONSISTENT_LENGTHS;
+    }
+
     ascii_put(e->system_type, (char *)cpim->data.system_type,
               sizeof(cpim->data.system_type));
     ascii_put(e->system_name, (char *)cpim->data.system_name,
-- 
2.55.0


