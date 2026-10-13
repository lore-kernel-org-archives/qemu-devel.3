Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB6FCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXO-0005j6-OY; Tue, 13 Oct 2026 09:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcV2-0002fR-Kb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcV0-0004mS-Ix
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iB8JGYIvwcKydt6jMlwiH/M6fnC7o+jJvDxPlYUl6Co=;
 b=BjHDYkvF16pdtZl/hDkdnTRDAF+SIBPyDhMeTnT5RaOdJTJpBh2qUpSW4Rup2rbf4xzZgk
 E+ZJq+Fo30f0MRuha+QJDcelQolaSgwQaLs6lcP2dQikedU3l1rjhpjyotnYBPwYy9iX7F
 tTGbANG41OhdnvMM8xuMYeR5as2F54s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-UCVgkbNlPsWDAxVJ3h8KIg-1; Tue,
 13 Oct 2026 13:24:54 +0000
X-MC-Unique: UCVgkbNlPsWDAxVJ3h8KIg-1
X-Mimecast-MFC-AGG-ID: UCVgkbNlPsWDAxVJ3h8KIg_1791897893
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B33FA1945CB0; Tue, 13 Oct 2026 13:24:53 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1F581956086; Tue, 13 Oct 2026 13:24:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:22 +0400
Subject: [GIT PULL 25/40] audio/pwaudio: fix integer underflow in
 qpw_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-25-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9dVfU0qfpi2U1N9n22axIf4XRKRI6b4H4xRxQw5SSoU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDz3wSk8k1UrgPgX0PFWKRl8riKVtvAbC9X
 J3OZoCpCNmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5eLAD/40iwUeWapn7sir6Ob+D5Zdvmb1a5i1x/W7C6PRDHkkI0eyQ+Uu97WBStKeF6fsXPNIjUZ
 icMoNuT73TcPdvI/c8XFUyJLI+R+3jUxjXKniXnvE+PoogPRS13/O9pOoe7sSZFjgkj8HI3qA/b
 gPsIh/qKhcYqYHZY99L4uHnuf42G4u3M5TSobEKHzwMPB1txxgD2ZvB8iZJARY5IfY32Oxk4cbD
 6jlvUYBG5n38XjysP46x010R8Ek56P+CcqpqHIFe84K1c/9x1iC6sGuvTgSBsMJzkGndzdbx+8r
 fK9D5/QP3NTxIRqVg7R/JsXPOwH/aXQ3I8ixweQWR6KYuGQv0GnIeG9M/UCIlBC6X5hmZfYlvOn
 OzkYGtBxWrRCIJH4spsU/hORDABA9CClt83zV+tvEeggK4rD+Mv1BAGEZ2yziXX+ECY9Jb+DASf
 n9C1v7HqhTcTiXxJsW7MtqXjUjvxnnwlVxJWpDysdnr4ooWebeV2EW38GJE95BR7JpTzqOKR1rc
 QdIoL5h4MK6Uk2XdXk04YoMyu1mhSh2gfA/vv4hAGhTl4Y4G3xfZByLvyXUGnWc8y1FjMdcnlXx
 2FJU3caAUz8YdnVB4+GqLf5pzBwwF7OYeQ5ueSrJA5/uqtzmtLKC7k79jS4/kCRFyWJIsIsccxm
 dOmKQ4vM8hIX3aA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

qpw_read() casts len to int32_t for comparison with int32_t avail,
which can underflow when avail is negative. Check for non-positive
avail first, then cast to size_t for the comparison.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-8-ccbef537cbeb@redhat.com>
---
 audio/pwaudio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 1105e920f3c2..a8c18b9ecf85 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -247,8 +247,12 @@ qpw_read(HWVoiceIn *hw, void *data, size_t len)
     avail = spa_ringbuffer_get_read_index(&v->ring, &index);
 
     trace_pw_read(avail, index, len);
+    if (avail <= 0) {
+        l = 0;
+        goto done_unlock;
+    }
 
-    if (avail < (int32_t) len) {
+    if ((size_t)avail < len) {
         len = avail;
     }
 

-- 
2.56.0.116.g6de20f6092dc


