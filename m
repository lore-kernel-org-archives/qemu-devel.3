Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725E6CD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrbq-0000s4-DV; Mon, 04 May 2026 07:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbX-0000Hj-KT
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbV-0000zq-NJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WA7HCr6BRcLTeqx4HsKUg3WORqn8eiFYwWxgxz8jrOY=;
 b=JpWRXBLnLhY7ZhA+NfWHnyGBM3+t5n6spRlO+wneN2fxrrq/ZbHY8chm+zKe/it2OjAJku
 GshjBWF9Ay3mbmpYAG3GFCOtkm4nLQOrniU7eslDpgPwBLoZgmKatMidipUda7DWSxRSCH
 wPpGDNr7/k6BPQcEjIrXGoLuinrvSns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-cqOgIstqNLq9FGGxZ15TAw-1; Mon,
 04 May 2026 07:36:46 -0400
X-MC-Unique: cqOgIstqNLq9FGGxZ15TAw-1
X-Mimecast-MFC-AGG-ID: cqOgIstqNLq9FGGxZ15TAw_1777894605
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCA41180034C; Mon,  4 May 2026 11:36:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71EF219560A6; Mon,  4 May 2026 11:36:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
Date: Mon, 04 May 2026 15:35:04 +0400
Subject: [PATCH v2 16/46] system/ioport: Fix qom-list-properties crash on
 portio list obj
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-16-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OiojSRVbGrDtH2nEC2hxpx2beSqgCFB6TOBqj8+YtAk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsP7CyQfyq6qKr1yVRRE2pUfqrXKwRoezQn
 MZ2EWNfkjKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5cCgD/0UN3lXBmEslYfzE732Gn6/8UEPqTUft3IfE9TODBxP0G9ttQWDyhX+/+eBGBfHbPARhiY
 OUvDtZBE6I7HlLQYgBR2VVd3t5blDGIOM9WH2wVC8jFCKNq1n+NCyIyI+0aBrtgnbGaeC/X/OSh
 50gtot4GdmK8lupw3SDbYCP9uh4TEgMatbSSk8H2GpKshLampPR3V8Q6QEjQeSQDdv9rUZEe3rn
 um9xDRdR6SIxxdp9fCU8qHvjpS2sO4uLE9AfmMIJuqnHXl0QAosi9M/b7gxcYw03hAzhxJBxfeq
 +6UF+79zGAwI8tCN9CYZyosK5w4kqSlFi3KsUxyw4HPGSqGaVEpKI4IJPa0QAsdnrKDU5ar53SU
 PBFtxQyVUXG0PCgnrgn9FWI3fbN4CNT2wq9P2qcWR46Fn5YA3f4iBMDLOdmuJLbTsWxB5avHeBT
 gIQZpC8t1Mb6g6lFfEOwQ58zswAoiN52c7VAu9FWlNkbeLmRDMuL/5Rpidy3gpxu7LKRtqWR9pd
 8ohGdF0fxGNW7Gid36YNNIXgx9mG+RJv0PTnYjb4Z7Qna/KTnpwK9TR8Rcv2SV8PEfiH1pKofFr
 ARtmxC7iw6o1AXhpy8UlMZL0pfaZKcHJxfVy9fA0Di2UcwQaShTd58Y+dmO9i6rWh6YFkEoQuLx
 1y5p6bvLpw9CE/A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

From: Peter Xu <peterx@redhat.com>

Currently qom-list-properties QMP command will crash when querying the
portio list MR object.  It's because its finalize() assumes full
initialization done in portio_list_add_1().

Provide a simple fix for now to avoid the crash.  There is chance for a
longer term fix, ideally MR should be initialized in instance_init().

However that'll need more work, and that should also be done with cleaning
the hard-coded MR operations in portio_list_add_1().  To be explored.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Link: https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org
Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ioport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 303fabf063e..0a1b80f2994 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -345,8 +345,15 @@ static void memory_region_portio_list_finalize(Object *obj)
 {
     MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
 
-    object_unref(&mrpio->mr);
-    g_free(mrpio->ports);
+    /*
+     * This check makes sure any random object_new() (without doing the
+     * rest inits in portio_list_add_1()) will not crash when finalizing.
+     * One example is QMP command qom-list-properties.
+     */
+    if (mrpio->ports) {
+        object_unref(&mrpio->mr);
+        g_free(mrpio->ports);
+    }
 }
 
 static const TypeInfo memory_region_portio_list_info = {

-- 
2.54.0


