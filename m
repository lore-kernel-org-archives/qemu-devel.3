Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C061CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJRF-0005AU-80; Sun, 04 Oct 2026 06:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJR3-0004t3-Jo
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJR2-0003VB-86
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c0N5pTMxpzdb8y/HI7QS3BV33KRa32DmOxO1R2qOX4=;
 b=K+ywMUJGSoamCHQfjt8KoVKXdCg33iFn7HYDwAR8HZ7V+9A/vPD7KwCvLocv4M/+v6gbET
 k9tUAKHqkKmUdf64TrjALTsLH31Ezi20VrxXx8W0tOSxyCaTCrtRLETUH5+WcK4VKwuW8B
 Wiv/XlolNAm0tIHaWakZscyWtTdvvdI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-IKFrOTvHPb-O-T8NEvhR8w-1; Sun,
 04 Oct 2026 06:27:08 -0400
X-MC-Unique: IKFrOTvHPb-O-T8NEvhR8w-1
X-Mimecast-MFC-AGG-ID: IKFrOTvHPb-O-T8NEvhR8w_1791109627
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 569651954194; Sun,  4 Oct 2026 10:27:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B0CD1956089; Sun,  4 Oct 2026 10:27:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:13 +0400
Subject: [PATCH 59/63] hw/input/hid: fix off-by-one in pointer queue access
 on migration load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-59-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=303pMCEXPuIYEYvmL1/sUKEZVIwUzvjbkk+4kSb1q3I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikl0sTQiWQ1xXB4ikR2WNDagY96Ho5FiK+at
 cTYO7msP6SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5SAMEAC58qjS+bcddPwvfoMeNHt0AZnGmv7QYxwJiA7+a/0uT7LdL2kFLurmyaWowWbIgsOWPXi
 I3lLyqlRA0SsEt1W7IjWsQbmoCLanvU+d153Vc9IC7O6rmyDOnkK1eC0L4FXsia8QOZUNNguEaJ
 LE2/9ESZnUth1KqJEaihqq+8pRvf9AGmrE2p+gmv8/rvmVasZSWBPTVSxHgBtLvDhxRASkaruGf
 HswMktQqSJvuMJpfO5x6/E+DHq5ZYzRRWy9AU/XZU6zTVfAUaKaPdNVIfPCxpdnzGe7BGFVna8O
 hAal6b+4jw52+au+evdDg64NBWp1hN2x5PRIIkRquBpLti6XE3YR+DyJOG/asFlXOdQuGHPXR38
 38niEaDIeN/c7LqnjfdsbwMCC+EapLzurYGs72X40GxMxYPnOdDUTy+s3K1GBkAWEdl9hL9evZY
 18DSggONkFhdsMSpb9CT3L/+/EPQk+/O3D1PELWrP8qJ22V9elpn72eotObiCM3CCMXmKnpkHjB
 W4Ws8fE/lPErFNtD+u7UjCzjUsTuM+rVdaL173E6H2HIEEOsB0bts7YHBda+wZ5jjPh9hl0Mhl8
 toH3StH6hVbap37ky6ETONhVRVRCFySXoEjuI6OV92l/lB8pvCqTLQcWTvNz6uhor/0yyIFgoGm
 wrg2tW1iedi7qBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The post_load handler reads the last queued pointer event at index
head+n, but in a circular queue with head as the first element and
n elements, the last valid entry is at head+n-1. When n equals
QUEUE_LENGTH (16), head+n wraps to head, reading the oldest entry
instead of the newest.

Fixes: ba4d26064e8c ("hid: handle full ptr queues in post_load")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 5098497f41bb..847eac97cbe8 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -567,7 +567,7 @@ static int hid_post_load(void *opaque, int version_id)
          * mouse.
          */
         HIDPointerEvent evt;
-        evt = s->ptr.queue[(s->head+s->n) & QUEUE_MASK];
+        evt = s->ptr.queue[(s->head + s->n - 1) & QUEUE_MASK];
         if (s->kind == HID_MOUSE) {
             evt.xdx = 0;
             evt.ydy = 0;

-- 
2.56.0.rc0.29.g47ce80527c56


