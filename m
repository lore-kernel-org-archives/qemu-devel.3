Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3608CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOb-0004oN-BV; Sun, 04 Oct 2026 06:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOI-0004Wv-Or
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOG-0002u5-SW
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vygvAJomWZefnLtthL0rW2ymfBkR+Pi9SToL5wZ5egI=;
 b=eDwcalt2dtEASJyohQrraSrx+J0LhloGsj2E0+CEAjVVTkjdl8r/i7sclE7aB2WcYCI9N7
 FdtxMDLsFsqpBrVYtUzv25KRg0v3yoU9vx4Z3OzznGFAdF4GBiDsuF5tXEId5LDrAO8mM/
 UITs1s9xMyCCdcU2mLjuZrlaGokS7Lo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-JCfeKv32OEy8xsWMdkWKpw-1; Sun,
 04 Oct 2026 06:24:12 -0400
X-MC-Unique: JCfeKv32OEy8xsWMdkWKpw-1
X-Mimecast-MFC-AGG-ID: JCfeKv32OEy8xsWMdkWKpw_1791109446
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7450B1956088; Sun,  4 Oct 2026 10:24:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2826340E; Sun,  4 Oct 2026 10:24:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:22 +0400
Subject: [PATCH 08/63] audio/pwaudio: fix integer underflow in qpw_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-8-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=991;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gaLK7xWYgkejITZbzPTgEMKfB8Q9SjD43HqsNcP+k84=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhMvF9RJ41XNxEsflfG/rncGm6xL7fgJ/Fs
 nmElxD99E+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5YUjEAC2dHlixwBMPHxIpUysJa96nbjr3XtD1POeO8HnQiOQMtp7liC0EBc5WXpzerIhuqFfe1O
 l2AAzqaLvgifZcX8pCOl6kwDaBS+1wzTnGmVd0jtqnspiX+pxZV1wZRBPPd0OX6hJzX26o5Fio+
 jfiBCd6WY/Lxaxcq20oClp8v5CPwiMX3Mz2nV56KzYQPttCrOIJyKaMcNduhvYlXbQcyEtCPYAr
 CujGVnEIflakEf44T6gQ7fvPWeBSCCrm84m4fFv8Ndp833Q/UBjyxD4VKxPbl7L6JiUBzqC2fN3
 dTQUW6m55HgU+3MWszmk21IDVquQ0CJfDdkaTmGLuQkFJWGRDr2J6qN+dB1WI3eagrt70VK2Lim
 65MvH/stzJ5fu2yolTOF8+2VHyZ8rJjSdkM8ug+Xpdy4tvXMFpVfompi1U4iD9M2dokKNOH3l93
 AhqoqNWjp66ioFu6qiGM2HvON+6YBV8wehi6inYn1AcBb5d14+g6ETnRSRiR0Ib7ZyhdHusceO6
 /Xc7pWeVqJL24MJbP/3NMG5awCvnE01x6+CmTV0qIla3OhKKYVr3pry8mrCwt96jDTyT7QCVB7C
 AK2J9wMbjwMBlsrzyrM2OL+spWFZXsBqfbSOx8lU4T/Kypr8DTKvAQSJPTe4e2LPnUmi1PsqDiz
 aNTilGh/fpNT76A==
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

qpw_read() casts len to int32_t for comparison with int32_t avail,
which can underflow when avail is negative. Check for non-positive
avail first, then cast to size_t for the comparison.

Reported-by: Pavee Hui <phui@google.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
2.56.0.rc0.29.g47ce80527c56


