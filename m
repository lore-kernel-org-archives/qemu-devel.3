Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08A7D78312
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5WZ-0006N6-Uc; Mon, 02 Dec 2024 07:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tI5WX-0006Mp-Lw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tI5WV-0004Zz-L2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733142449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvZcOCuHqlQ+KugXG0gYzlGUPxFnOSpG7EH1+lC1fW8=;
 b=X6e7mrzSWXdrGJ+1tnoiHThGCamhLTE96Yc8qa3FVpevITHrcjKUSU79NRYhT0nmAAUtKN
 Dw0OU1rGNKuaJI+FJBVMTChW0zulfsaaDukAGRczJ0J+AMyR+nBSPFkUNO4/QGgJ5y1OJF
 C0mD3Nj0KvS+xo24oDowHranQ7rWmoQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-5uPES4iPNsCLME6USGzn4Q-1; Mon,
 02 Dec 2024 07:27:26 -0500
X-MC-Unique: 5uPES4iPNsCLME6USGzn4Q-1
X-Mimecast-MFC-AGG-ID: 5uPES4iPNsCLME6USGzn4Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6959E19560A3; Mon,  2 Dec 2024 12:27:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62EE230000DF; Mon,  2 Dec 2024 12:27:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, peter.maydell@linaro.org,
 Roman Penyaev <r.peniaev@gmail.com>
Subject: [PULL 2/2] chardev/char-mux: make boolean bit check instead of
 find_next_bit()
Date: Mon,  2 Dec 2024 16:27:09 +0400
Message-ID: <20241202122709.100177-3-marcandre.lureau@redhat.com>
In-Reply-To: <20241202122709.100177-1-marcandre.lureau@redhat.com>
References: <20241202122709.100177-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Roman Penyaev <r.peniaev@gmail.com>

This patch simplifies (and makes less confusing) bit checks by
replacing `find_next_bit()` calls with boolean AND operation.

Resolves: Coverity CID 1563776
Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org
Message-ID: <20241129103239.464061-3-r.peniaev@gmail.com>
---
 chardev/char-mux.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 9d67b8bd9a..e13042d381 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -336,15 +336,12 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
 
 bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
 {
-    unsigned int bit;
-
-    bit = find_next_bit(&d->mux_bitset, MAX_MUX, tag);
-    if (bit != tag) {
+    if (!(d->mux_bitset & (1ul << tag))) {
         return false;
     }
 
-    d->mux_bitset &= ~(1ul << bit);
-    d->backends[bit] = NULL;
+    d->mux_bitset &= ~(1ul << tag);
+    d->backends[tag] = NULL;
 
     return true;
 }
@@ -353,7 +350,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) == focus);
+    assert(d->mux_bitset & (1ul << focus));
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
-- 
2.47.0


