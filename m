Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C04C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZXe-0005dE-Lh; Tue, 14 Jul 2026 05:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZXd-0005cr-D6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZXb-00019W-LQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784021702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpqPu6Ft673rxadU8U4q5p7PwhY65vWe7XWmoTLN7tM=;
 b=U+S43YdK1ZvyJjRNRpAHJPUisgG4eVvp4v3euE0rbJYCfeyjVuk1WXFhhzaUOHXCf6CXUM
 INM0EALuHuKXPohMqkvHOlK1hzcsmBbIuLT3r2ES8MkF0/R8AkmbFM/CHfGfCAwbFErUxS
 0EL1BL+jE1mgChC4S5CusYUFvoljsUk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-qtVcUgfdPK29frIrDXJNzQ-1; Tue,
 14 Jul 2026 05:33:10 -0400
X-MC-Unique: qtVcUgfdPK29frIrDXJNzQ-1
X-Mimecast-MFC-AGG-ID: qtVcUgfdPK29frIrDXJNzQ_1784021588
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA699195605A; Tue, 14 Jul 2026 09:33:08 +0000 (UTC)
Received: from gondolin.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FBF0D6E; Tue, 14 Jul 2026 09:33:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL for-11.1 1/3] s390x/sclp: prevent re-reading the sclp header
Date: Tue, 14 Jul 2026 11:32:58 +0200
Message-ID: <20260714093300.2193848-2-cohuck@redhat.com>
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

We verify the sccb length and then allocate based on that length. The
following access re-reads the sccb again. This can race against other
vCPUs overwriting the length field.

sclp_service_call_protected does not need a change as the ultravisor
provides a consistent snapshot.

Fixes: c1db53a5910f ("s390/sclp: read sccb from mem based on provided length")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Message-ID: <20260709142906.197474-2-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 2d2cde7803ff..3c8cb164888f 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -329,7 +329,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     /*
      * we want to work on a private copy of the sccb, to prevent guests
      * from playing dirty tricks by modifying the memory content after
-     * the host has checked the values
+     * the host has checked the values.
+     * Reuse the previously fetched header
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
     ret = address_space_read(as, sccb, attrs,
@@ -337,6 +338,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     if (ret != MEMTX_OK) {
         return -PGM_ADDRESSING;
     }
+    work_sccb->h = header;
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-- 
2.55.0


