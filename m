Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D74ECA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQe-00039j-7s; Sun, 04 Oct 2026 06:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQT-0002yc-HW
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQS-0003QW-4e
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dg29o0yqvlBEnHExSppCjAqhKdabPoAfVOp/PkgXVQ=;
 b=BjU1ePiub9XRPGv4riqY7ot5CGw9hr1YVVDzhSXDnhw/9tFHpAU6VYMtgxrbw9NYUGGZew
 YktcIRaWV857tkZoWjk0dJHAIqpJerrOMiNlo7UWfKqLtG3Fos/zLfFHFerUyK634c0RoW
 W3cuHK+wr+wUMBrNeR5vtPIRul5kbLU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-tAA_M5oNMRm_2zC7mq0WbQ-1; Sun,
 04 Oct 2026 06:26:30 -0400
X-MC-Unique: tAA_M5oNMRm_2zC7mq0WbQ-1
X-Mimecast-MFC-AGG-ID: tAA_M5oNMRm_2zC7mq0WbQ_1791109589
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B0A31955DD2; Sun,  4 Oct 2026 10:26:29 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D49D51956089; Sun,  4 Oct 2026 10:26:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:02 +0400
Subject: [PATCH 48/63] hw/input/adb: reject zero-length requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-48-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=927;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6fep3I/ry8R6FwSeuAFi/g1+uQ5CHThQE/P0DN0kjQs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkNc1DVQoDu+/AAWxlhANgZGeMFf9k5RFlu
 4vOc/Jf9XeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5Z1DD/4zoXuhWC9B7++c+5ayVcv4b3v9hn2HKSP7MOlDJBAXu94pIPWAQfZovEEITG0AA1Z9EwY
 etLIobv/xdtC2sPDoywuH6N7Po/LbOyWoTLk9gJM457PBlke7cAIf81sHgT9bUbz4yyIXUvhyhh
 6KFPSP3I1YWzTIqK5qaucodAzWZdx9DpzA8j7V11TTXJBCHEybk9I40kppQJ3wjz+5IECbhPjd3
 3d9N2pTQX6/pONk5XllGuWs+QTtWGMXE5FdQkziZA0pjtFmrYxULhNTX2V8OGYFpGOo8gpxs6zP
 lkQ0TxQ53x0cmpW6Df+YTWhyF2tEdiOtdg+U6BhjdkiEceXlj+0XOAR2WOD7FFlRzzNOd+KGYmA
 9D0C+EsnmazCYJBMy2QAE0vqhJocgRk8MP3cFyPPJXJZ83fX6mZn3Yv8AqIR+MaMbk7NwtVgSkX
 IxAq4gWc6VKK+Z1QcSJ5XvKTe9KniDLMRylYIMKlq+uhUaneXv6yOeZteZLmeXAtoAyQY9UBNbj
 gP/6BblsbPRIEm/ks3I+yiQl1w33r3vwd1cMSaDSc+LnVWaQ4HX6v1agyWHlP/wJC7vR+pZCC5I
 0RhDB9QZR8zpS3zGWb69nxS4/Hpcrktd5QWdqMceVwJtPr/JcUHe0gQ+LlJNdinYieaahi5k5iv
 gXytDPp5Pg2Y/Qw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

adb_request() accesses buf[0] unconditionally for tracing before
processing the request. A zero-length buffer causes an out-of-bounds
read. Return early with -1, which all callers already handle (they
check for > 0 before using the result).

Reported-by: Pavee Hui <phui@google.com>
Fixes: e590e7f01479 ("adb: add ADB bus trace events")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 29c09c755966..7c67d2baa663 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -96,6 +96,10 @@ int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
 {
     int ret;
 
+    if (len < 1) {
+        return -1;
+    }
+
     trace_adb_bus_request(buf[0] >> 4, adb_commands[buf[0] & 0xf], len);
 
     assert(s->autopoll_blocked);

-- 
2.56.0.rc0.29.g47ce80527c56


