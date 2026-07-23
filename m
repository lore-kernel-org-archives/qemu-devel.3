Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE80EC531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmugO-0008Bk-3p; Thu, 23 Jul 2026 10:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmug1-00085f-QJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmufx-0002UL-L6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784817928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ro1C9a4VNUaYhe1YQZOb3MZWp+iKmkgZAyELuJt4D0Q=;
 b=XaB8Gvrph8aeV1sIPZua+WHJC2uUH2gZt68EPhNbhExiqAxIs38k44FTSMB6vLaz2U7gzR
 PLVSDwa9DmkhRtosCPg0Iyc6HzZvGyW9jdDRAFzDNc+1Dn1ouGEGUcjNSA9M4hEv/hAjVl
 ls4EJ8X6fFHI7N0iN/bd2zHH2ruVx4k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-hufl0Fk4PvOfZvVtUcIRMg-1; Thu,
 23 Jul 2026 10:45:25 -0400
X-MC-Unique: hufl0Fk4PvOfZvVtUcIRMg-1
X-Mimecast-MFC-AGG-ID: hufl0Fk4PvOfZvVtUcIRMg_1784817924
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DDE01955DE3; Thu, 23 Jul 2026 14:45:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4AB0180029E; Thu, 23 Jul 2026 14:45:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 boy juju <agx1657748706@gmail.com>,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH for-11.1 1/3] dmg: fix out-of-bounds load in search_chunk()
 (CVE-2026-65929)
Date: Thu, 23 Jul 2026 10:45:17 -0400
Message-ID: <20260723144519.364701-2-stefanha@redhat.com>
In-Reply-To: <20260723144519.364701-1-stefanha@redhat.com>
References: <20260723144519.364701-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The binary search in search_chunk() uses s->n_chunks as the (inclusive)
upper bound. Chunk indices are in the right-open interval [0,
s->n_chunks) so it is wrong to search all the way up to s->n_chunks
rather than s->n_chunks - 1.

The worst case security scenario I can see is convincing a victim to
hotplug a malicious DMG file to a running guest, potentially causing
QEMU to crash when loading from memory beyond the end of s->sectors[] or
s->sectorscounts[]. This could be a denial of service.

Fixes: CVE-2026-65929
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3844
Reported-by: boy juju <agx1657748706@gmail.com>
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/dmg.c b/block/dmg.c
index 33dcb3a3498..e325127d144 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -609,7 +609,10 @@ static inline int is_sector_in_chunk(BDRVDMGState *s,
 static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
 {
     /* binary search */
-    uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
+    uint32_t chunk1 = 0, chunk2 = s->n_chunks - 1, chunk3;
+    if (s->n_chunks == 0) {
+        goto err; /* should never happen */
+    }
     while (chunk1 <= chunk2) {
         chunk3 = (chunk1 + chunk2) / 2;
         if (s->sectors[chunk3] > sector_num) {
-- 
2.55.0


