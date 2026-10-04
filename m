Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7EDCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQN-0002Wh-9i; Sun, 04 Oct 2026 06:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQK-0002Di-2k
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQI-0003Pq-Iz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K68SL7Zw1WlphO9hYZy2CoOvh32oLqkqEo8UDVPKQlM=;
 b=KQ+RJ2Gj8runSjHhXRVbYQoEsJmnYCpJgXbLn/yp9m3Fo5kb7rD3l8R1SMIFX3n60wY7Zw
 +VHPeQ7YtUpvxJdCKxFj1P9I25dDsqU3WOPbFphHCdGtiXPWWWc1EH29h3J2q+L0/sjUJM
 K073XaqXUtLeG5pH4F/yogtCq8dEz3o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-ESmxKlkgM7y-ShhRycT6HQ-1; Sun,
 04 Oct 2026 06:26:22 -0400
X-MC-Unique: ESmxKlkgM7y-ShhRycT6HQ-1
X-Mimecast-MFC-AGG-ID: ESmxKlkgM7y-ShhRycT6HQ_1791109581
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE9661955BC9; Sun,  4 Oct 2026 10:26:21 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C37C140E; Sun,  4 Oct 2026 10:26:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:00 +0400
Subject: [PATCH 46/63] hw/display/ssd0323: fix signed modulo in column/row
 commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-46-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RVOp73iAGsj+2KWYKFx2H/8gTKMg3qp/TUngEQeiFF4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkIsF3+SBUckCu/QIPmoM5dXlwxti0vhsm7
 OqNVKmLeemJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5XWzD/4zunHNZghjJYWsyvUMeuzeLsk0gqsAhOXLJc6HMKDub+T3z1Vd1G21BddP17alF0uZfHL
 0/FEYRydZTAcMz9WrUoW0Zy7XGdhgP917yOFidVVLWqyDopFNBs5+Lh6lFLur01VOcr//Qb1Tsv
 wq+44elW6Y+z0Ye0pRXH/Q0R7ffe0smB3Ssa9Sate5pRJgxQWpmapIS6R46SdX2ZAAAaCkvL++e
 EgUrDCKJ79vCmi02sDpuoEpD8m7ZvLb1WvMIPYsfCDgWnB/7sJzZ43DXQ3bPB8535nn0Toexo0y
 AvqYCtqMAUwZ6CmuJiZX4JxKrBJdeFr/akRXot7tEaTDvtCGUPi/MJDMEuYcldqMP/ewi58tfne
 hoaOkzDhbAHXUnLPNAo2JyZk9eyn5mA+HrgyggrppnPb5enD+o9IDFywgAPF9043RON/Q3ew0br
 IAwx3AsJ4NdpTtH8CjuYEbeKeotfneYk0uVVRfC6LBBkFKE0Q0K7xLaEpkLYyTzKEaLkD3R7BfL
 wqm77Eq/+lJtQVmb4jQ3jlktn7E825y2Tbigh2UeF37Bsr3Z8sS5v4mk7IFC+NrNs/Fv0X/WQjN
 MMDv3I3Arn1A3EfULsL6NQJkgzlQ6mruBSw/2rFuJ2DXOL+7BcNaximHZnf34OuUYwI3P4NfVPO
 TqI7oQS+KlaeDEA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

cmd_data is int32_t, so a negative value (possible via crafted
migration state) would produce a negative result from the modulo
operator under C99 semantics. This would set col or row to a
negative index, causing out-of-bounds framebuffer access.

Cast to uint32_t before the modulo to guarantee a non-negative
result.

Reported-by: Pavee Hui <phui@google.com>
Fixes: e7f76c521f4f ("vmstateify ssd0323 display")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ssd0323.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index 6172596abe6c..0a6f8cb686b3 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -113,13 +113,13 @@ static uint32_t ssd0323_transfer(SSIPeripheral *dev, uint32_t data)
 #define DATA(x) if (s->cmd_len <= (x)) return 0
         case 0x15: /* Set column.  */
             DATA(2);
-            s->col = s->col_start = s->cmd_data[0] % 64;
-            s->col_end = s->cmd_data[1] % 64;
+            s->col = s->col_start = (uint32_t)s->cmd_data[0] % 64;
+            s->col_end = (uint32_t)s->cmd_data[1] % 64;
             break;
         case 0x75: /* Set row.  */
             DATA(2);
-            s->row = s->row_start = s->cmd_data[0] % 80;
-            s->row_end = s->cmd_data[1] % 80;
+            s->row = s->row_start = (uint32_t)s->cmd_data[0] % 80;
+            s->row_end = (uint32_t)s->cmd_data[1] % 80;
             break;
         case 0x81: /* Set contrast */
             DATA(1);

-- 
2.56.0.rc0.29.g47ce80527c56


