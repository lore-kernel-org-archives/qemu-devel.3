Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073B2CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOb-0004o2-BO; Sun, 04 Oct 2026 06:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOE-0004WK-3r
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOC-0002u0-Od
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHVhv7fpp7NliLjZJ7qydywVHcgmDJ+h4DZZHSBLuTk=;
 b=YReBa1nBVCMXMCig9tO+pEj9g08ek1fcJZtq2cQnpNpbfoHUjvbhrKSbkRTtqdysKNN1jl
 ppQav+WI5VZIR5A8+PG/1PMWSxQRBD0iKo1pOjBvvg80wUUQ59N9J/CH+Vhuwz+zOH/aIH
 EYF1J1IkhxiePgAwPlCROHyPNGVlkms=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-BqevnLYrP8yYfHro8TMBpg-1; Sun,
 04 Oct 2026 06:24:11 -0400
X-MC-Unique: BqevnLYrP8yYfHro8TMBpg-1
X-Mimecast-MFC-AGG-ID: BqevnLYrP8yYfHro8TMBpg_1791109450
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E6C919541BE; Sun,  4 Oct 2026 10:24:10 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F13B119560AB; Sun,  4 Oct 2026 10:24:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:23 +0400
Subject: [PATCH 09/63] audio/pwaudio: handle negative avail in qpw_write
 and qpw_buffer_get_free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-9-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LwxoCw883Hs2WNOuu21yrMCHfejWQHYO82Yo1xFHQ1k=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGrCKSGjfqdseEmGxmk7Dy3hkREGMUYFuybmrqZFhdknwFv0f
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqwikhAAoJENro4Ql1lpzlXZ8P/Rhx
 eQllRXNY7E+GYZpHvm5M7jIRYAilZUh/cj9b00DS5IG/3uxwJJQLiw3SvfyNbo2fPtgzJd3+wQM
 OSmR4/aXY3+vH83dA6IsV9agzQtCuMbGoVxnCbSFE9LIGhnbHM+6Zyfk29+aQcDk2tnM5XP6VUl
 36ZYIpCMV4wuCzYV9tXlYEG7xGQ/uHK380uI6SwSv+A8OpB1rBLa1Lv6P6u5Tbsdh3HFLgKMd4E
 ml7g/wovZzCZawDKxvxFQ3gX380/l+eKQt120Y47cjb3tJcfX+9dmD1TYArD8TAxk8KHFy7qCo2
 UNHZ3QOHEO1SqWFK076sLOlvCQsnMfwAEIfSwplN7Wn/J1Hk6fnbsZGCPPUMA14pv8wBsQox7PG
 /uv5qEC+MZsKltUsAm4vV4+l/AmHJVqprR4elFFs/WmourC6BD7FSw45bOCm48hUqDB9sXrJ2JB
 PKRlIRqgkERzDjZT+EYoC8t8NmUtn/EaATLINzuvXenBfcAb89U46453AziP/mdw7rSglrhZyXe
 fa+VsSO4udOGJNReN6ItVc+QPPXFiGw5d7LPLttKDzXSb0tCE6WvL5vNf/mz145iHIF4oJX6pF4
 wSYiTvQQINGI/WD2wMqRlQXV9lKRQ4zLBW6YYyIMHUW/xqK1+98UHCusXF03Ga4EFA/4QYg133U
 S9tRJ
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

qpw_write() and qpw_buffer_get_free() do not handle negative avail
(highwater_mark - filled), which can occur transiently. In
qpw_buffer_get_free(), clamp to zero. In qpw_write(), bail out early
and fix the signed/unsigned comparison with len.

Reported-by: Pavee Hui <phui@google.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index a8c18b9ecf85..8b3faae8a907 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -286,6 +286,9 @@ static size_t qpw_buffer_get_free(HWVoiceOut *hw)
 
     filled = spa_ringbuffer_get_write_index(&v->ring, &index);
     avail = v->highwater_mark - filled;
+    if (avail < 0) {
+        avail = 0;
+    }
 
 done_unlock:
     pw_thread_loop_unlock(c->thread_loop);
@@ -312,8 +315,12 @@ qpw_write(HWVoiceOut *hw, void *data, size_t len)
     avail = v->highwater_mark - filled;
 
     trace_pw_write(filled, avail, index, len);
+    if (avail <= 0) {
+        len = 0;
+        goto done_unlock;
+    }
 
-    if (len > avail) {
+    if (len > (size_t)avail) {
         len = avail;
     }
 

-- 
2.56.0.rc0.29.g47ce80527c56


