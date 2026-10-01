Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6375CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGrT-0007WP-7H; Thu, 01 Oct 2026 09:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrM-0007RY-8r
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrK-00061i-D7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BXaeX1UwV3vIaqC+G5fHkdps2+vbYFs19Iq9Sgf7eo=;
 b=A9XLn21UuEoxCf3XnoSHbTNR3T9CgW+vKV/gVAV7bqYF2wU0vtljrL65N3i1PoMr/NmFke
 5Q6E39nfy8adleOEjLLGa+O1RbxFmoHx1jszZMJ11WEzSH4xjPwZ0GpSHoEOjNUFKzWoSY
 SzYm1OTD2owDuxZpXOvBlrSq+6SxZ2s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-87wt35VYPZCJPUw9RR21yw-1; Thu,
 01 Oct 2026 09:29:57 -0400
X-MC-Unique: 87wt35VYPZCJPUw9RR21yw-1
X-Mimecast-MFC-AGG-ID: 87wt35VYPZCJPUw9RR21yw_1790861395
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66ADB1979075; Thu,  1 Oct 2026 13:29:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D8141956089; Thu,  1 Oct 2026 13:29:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:41 +0400
Subject: [GIT PULL 02/27] hw/usb/dev-smartcard-reader: fix OOB read from
 pending bulk-in ring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-2-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dX/G59RIuIisRnVjfAi3Y4LVmlF2qz9ETVujx8YjOXw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBH5qYgXQWp5q8fPhk6qItrhJt8ZD5Xbw5S8
 nqIZET045aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5QFBD/9TYUBfssmfzpNey41Ar5CdlGjVsylHndZHMg1xSPr/SXXy+/gBa8miZbylJzcLLwUEpoU
 W0+agHJG9L95L4ANAFRM2DZucEgB4OSTljBZrThKszsEVtd90NcGtCh3yMqfPEc7BxcO322/lo2
 LT2WVUfTme2lzKVpy9M1FHqUz7LA/OngoXRQM8UPTEu9Oe21OxMuucC9u5sMOyr+PII2p2a3nIc
 rTOhwCTjXZcHFbY41j2juoUsXb/Y/JwkE0aqXne9vyJjgxaHmmon0kFo4XouBYmLlyTtI696fTg
 eGz5LAkO2PTkdzkHSYgTB3crz8on9uCIFGTZs3YbMEFFdbEV0CzsRWl+d0eAAjN88DTuNZUFVFA
 mC6h17KmTa9dGDmOhuFPp5FZTFWG8+WWnBWA18by7tKqO7h7NxRqyOYjLr0w5nR84I/zZ2WJF7N
 XpiBW842Dvk1RcMgRIoh0Wl39RbXfJ5EZW0BcrIgDKXmMzT2G4QF/4NknY1YPe4guN4VorupA/i
 VhvoAGSv3yx1wjEtqa8rs1toLITHz+wD8wC/QzrEeD1N6ZFJJQ8GwKPtWCXv6+1iHBYgMqYBCs/
 aWt/6Q7xJ0vYMCByoiRzGgpv+G9+gV82D9moLiSA2unzZtxj/S01/GOPKAoYUHRqoB2ORIgReuY
 1ND7W8iKn3G2/VA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

ccid_bulk_in_get() decrements bulk_in_pending_num when a slot becomes
active, but the slot is only truly free after ccid_bulk_in_release().
A guest can fill all 8 ring slots, partially read one (leaving pos
non-zero), then send another command whose response reuses the active
slot. The stale pos > new len makes the uint32_t subtraction in
ccid_bulk_in_copy_to_guest() wrap, reading past data[].

Move the decrement to ccid_bulk_in_release() so the slot stays busy
until then. Add an assert(pos <= len) before the subtraction.

Resetting or removing the card must also discard the active slot so
that its stale position and pointer cannot be reused.

In practice, the device advertises bMaxCCIDBusySlots=1, so a conforming
host never has more than one command in flight and the ring never fills.

Fixes: CVE-2026-18204
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4086
Reported-by: Warisjeet Singh <sinxx198@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bba97a2b19e6..aee966c0c92d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -570,6 +570,10 @@ static void ccid_remove_pending_answer(USBCCIDState *s,
 
 static void ccid_bulk_in_clear(USBCCIDState *s)
 {
+    if (s->current_bulk_in != NULL) {
+        s->current_bulk_in->pos = 0;
+        s->current_bulk_in = NULL;
+    }
     s->bulk_in_pending_start = 0;
     s->bulk_in_pending_end = 0;
     s->bulk_in_pending_num = 0;
@@ -580,6 +584,7 @@ static void ccid_bulk_in_release(USBCCIDState *s)
     assert(s->current_bulk_in != NULL);
     s->current_bulk_in->pos = 0;
     s->current_bulk_in = NULL;
+    s->bulk_in_pending_num--;
 }
 
 static void ccid_bulk_in_get(USBCCIDState *s)
@@ -587,8 +592,6 @@ static void ccid_bulk_in_get(USBCCIDState *s)
     if (s->current_bulk_in != NULL || s->bulk_in_pending_num == 0) {
         return;
     }
-    assert(s->bulk_in_pending_num > 0);
-    s->bulk_in_pending_num--;
     s->current_bulk_in =
         &s->bulk_in_pending[(s->bulk_in_pending_start++) % BULK_IN_PENDING_NUM];
 }
@@ -1078,6 +1081,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
 
     ccid_bulk_in_get(s);
     if (s->current_bulk_in != NULL) {
+        assert(s->current_bulk_in->pos <= s->current_bulk_in->len);
         len = MIN(s->current_bulk_in->len - s->current_bulk_in->pos,
                   p->iov.size);
         if (len) {

-- 
2.56.0.rc0.29.g47ce80527c56


