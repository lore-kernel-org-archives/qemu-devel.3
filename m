Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C33D78313
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5WT-0006M2-T8; Mon, 02 Dec 2024 07:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tI5WP-0006L8-EA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tI5WN-0004YQ-QH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733142441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5CsPc7CIu+djHplbntg7+qspvRP3Au31bmMWN13Z2M=;
 b=Tqi4RiVN8obcinjAXYvcAmAFerkNlBuz0ubjPKLcvHaWXJYW4etDZdGVMVc1YLhABGxe9B
 EER0ghdwIvwcjPOUA8H15gGDCDujdL+zwd1C8yCMBrFVU6K58OAMNhNCi6P14dQkCfr158
 5jeBwyK8meR3CyHpXHWEkVw+x3fBF3s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-6YdS5h0fNMS8cDVVAzFxJQ-1; Mon,
 02 Dec 2024 07:27:20 -0500
X-MC-Unique: 6YdS5h0fNMS8cDVVAzFxJQ-1
X-Mimecast-MFC-AGG-ID: 6YdS5h0fNMS8cDVVAzFxJQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 964C71955D8D; Mon,  2 Dec 2024 12:27:19 +0000 (UTC)
Received: from localhost (unknown [10.39.208.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B2411956089; Mon,  2 Dec 2024 12:27:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, peter.maydell@linaro.org,
 Roman Penyaev <r.peniaev@gmail.com>
Subject: [PULL 1/2] chardev/char-mux: shift unsigned long to avoid 32-bit
 overflow
Date: Mon,  2 Dec 2024 16:27:08 +0400
Message-ID: <20241202122709.100177-2-marcandre.lureau@redhat.com>
In-Reply-To: <20241202122709.100177-1-marcandre.lureau@redhat.com>
References: <20241202122709.100177-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

Allthough the size of MAX_MUX is equal to 4 and likely will never
change, this patch changes type of constant to unsigned long to
be on the safe side.

Also add a static compile check that MAX_MUX never bigger than
`sizeof(d->mux_bitset) * BITS_PER_BYTE`.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org
Message-ID: <20241129103239.464061-2-r.peniaev@gmail.com>
---
 chardev/char-mux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index bda5c45e60..9d67b8bd9a 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -316,6 +316,8 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
 {
     unsigned int bit;
 
+    QEMU_BUILD_BUG_ON(MAX_MUX > (sizeof(d->mux_bitset) * BITS_PER_BYTE));
+
     bit = find_next_zero_bit(&d->mux_bitset, MAX_MUX, 0);
     if (bit >= MAX_MUX) {
         error_setg(errp,
@@ -325,7 +327,7 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
         return false;
     }
 
-    d->mux_bitset |= (1 << bit);
+    d->mux_bitset |= (1ul << bit);
     d->backends[bit] = b;
     *tag = bit;
 
@@ -341,7 +343,7 @@ bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
         return false;
     }
 
-    d->mux_bitset &= ~(1 << bit);
+    d->mux_bitset &= ~(1ul << bit);
     d->backends[bit] = NULL;
 
     return true;
-- 
2.47.0


