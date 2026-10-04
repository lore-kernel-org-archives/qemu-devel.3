Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096C4CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJO6-0004Vl-Tp; Sun, 04 Oct 2026 06:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJO1-0004Ug-1z
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNy-0002tT-LM
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQS0+VEO0sVtBPeZRRVHikul6JzRVKKjdGKMjWsSehc=;
 b=RDd8Do9Ff7IV0/Wk79x+eUXICPnaNL65UuGK+LQNi6zh12YRqxYiwqA7gHJ0kQK8nC5tk+
 qrIRvmYbR19eEH1z994Vr1jgbRiq8Dwlmsuul4aH+320xCvQCWHO1HkhypidqcrPvMCRd+
 eWvl3xUT8M9xthvSe2KF9OfoLdzfqjE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-SR2Wm5j7OtueLCyR7oGjSA-1; Sun,
 04 Oct 2026 06:24:00 -0400
X-MC-Unique: SR2Wm5j7OtueLCyR7oGjSA-1
X-Mimecast-MFC-AGG-ID: SR2Wm5j7OtueLCyR7oGjSA_1791109439
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A9EA1954AF9; Sun,  4 Oct 2026 10:23:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E7001800348; Sun,  4 Oct 2026 10:23:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:20 +0400
Subject: [PATCH 06/63] audio/pwaudio: fix capture buffer leak on early
 return paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-6-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=S7KAAh7lIQSYjjZfx+F/PvPV+tYXhOd2jEBAX3pCVU0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhEWuo76c72d2qKJ+BmUtAZsNpxrIhzRZbY
 YZFc50hfZOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5ZgeEACOBXBjQLFTAhdEkhBsatFWrPKhXUp0QpnpKFhVXSzDNOE0acHXYw6MVQAfxdSxkRjn1bR
 w1TLOQuWA3wiTgsKRP5eUK4K5YRqh+TrhlYaFNC0QwaGD1rxaUGAGujqAQLf8yT47gl62LuseTp
 tPi1Kkj6QFMB4g1WhI4zCJYIHdwTGf+i/Vof3IhE/FW3lhkvI0slV1e4P/Wdb+C0vMYHNqCMbnC
 /P0US7Q+4JHjzxx6E95jimWgbYSp9TWSNNqrvBSNWXZhkgYOTwtR2esEK6d23O9wQylTeQYMsAB
 Jsuhuro6gGu8YSFUjT3pyWyN0+oQmr3yxnqXYgCJs/MEcm0w1T0bMKsf5bBCg1R65sAk9vnQDCo
 LmK88g4OjQ34EOXvuOEc44oSA3o2L5vPp4s1kzLrDQFnSe+j91Y6ufwmoIq5QEpAO4SEaOMKPFh
 uhtsf9pfM1zBj9u3YlIliWSYy2f1zaO5LMxBr6Tk69taF/y6TxjMP0bzaxac6H1MADyysj7AYfA
 vFMclVX86/lNZQg7PNnasn0fcp0chl/hTod+7GfDP7eSI5WIgwCf0KvPtNxG5ta3b+kSTlFBkdT
 +b6od/PmtX8wBLDN0qw5B2bvT+dAq7CJ06c/Sz9u8fe9l0VP5YETqtSHdupiNJhmPzKDYau9HO6
 sx7V9BNyUN4Etpg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

capture_on_process() leaks the PipeWire buffer on the p == NULL and
underrun early-return paths by not calling pw_stream_queue_buffer().
The stream eventually starves from its buffer pool.

Reported-by: Pavee Hui <phui@google.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index a59c22e60b87..af360e2ec5ed 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -171,6 +171,7 @@ capture_on_process(void *data)
     buf = b->buffer;
     p = buf->datas[0].data;
     if (p == NULL) {
+        pw_stream_queue_buffer(v->stream, b);
         return;
     }
     offs = SPA_MIN(buf->datas[0].chunk->offset, buf->datas[0].maxsize);
@@ -181,6 +182,8 @@ capture_on_process(void *data)
 
     if (filled < 0) {
         error_report("%p: underrun write:%u filled:%d", p, index, filled);
+        pw_stream_queue_buffer(v->stream, b);
+        return;
     } else {
         if ((uint32_t) filled + n_bytes > RINGBUFFER_SIZE) {
             error_report("%p: overrun write:%u filled:%d + size:%u > max:%u",

-- 
2.56.0.rc0.29.g47ce80527c56


