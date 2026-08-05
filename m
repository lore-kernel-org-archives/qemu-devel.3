Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE5BC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraA3-0004fN-CQ; Wed, 05 Aug 2026 07:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraA1-0004eo-1U
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wra9z-0006j9-FN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32hlOoxGcOHc+TuHMabHzUMn9fLw1XdnOt4vvPs+mgc=;
 b=GCNkcsFsmJJ2jwc12hamaJUYNw/vttT2kmc5s7ipiBOM36BB+XtD4rVY7xVwBFtZVvv4ng
 i9ypcq9Zy2WYxJheXLvCEKK2AzL2TPLMWFzyFXciEXnuYsXEYHh88N6Ig9+Sfehxr+w99b
 U7MVzqjXj9o4qEQA3/Np9tvsqAkQW1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-V5sGPF6xPRaSKfF0rpQNng-1; Wed,
 05 Aug 2026 07:51:39 -0400
X-MC-Unique: V5sGPF6xPRaSKfF0rpQNng-1
X-Mimecast-MFC-AGG-ID: V5sGPF6xPRaSKfF0rpQNng_1785930698
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F06A1955F2D; Wed,  5 Aug 2026 11:51:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98CE41956094; Wed,  5 Aug 2026 11:51:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:52 +0400
Subject: [PATCH 02/27] hw/usb/dev-smartcard-reader: fix OOB read from
 pending bulk-in ring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-2-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Warisjeet Singh <sinxx198@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=g51vDtQSsX4MUh7GbI6yZjnSsCXHFNXZm1WmNeBdFT4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOrxtC07a9LGJRB2lYReVpDllIPRMeRTA0fA
 35TDWIk+EuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjqwAKCRDa6OEJdZac
 5fswD/oDXdxLo6gvuIhvFRnY7vqAO9IUzoMepLXE/cev6ziMkdp6J7fiz8i6v0nw6Dv2dHWGMlF
 MwUFE/E6xfuqnrS/ORtyjsqTCR6LlFbD9M0fujlK93XvG0PF+ynuE/ijl6vp2H2B14RUQuF6T8P
 3vkdAoGB5ziwynjoYQeGE2Bz9u4fIjZ41Av+SJxBP7RjIgeke9rcjrW+r3gQf/42FHFNj6qpplH
 nBMqLLO+Qm9jvWuhq0yoUut/wCVb1AyzXcVYCdNrZ3mHTAaT2geBPuFDzZ6WEUzL5cd9Bi0UvQ5
 ywrPgLYjRbrbBYW41UnIzOBmshJGVpK/61CJG//tm4OkUKVt2cZDk8IdHtnt14khqxRfx6kTX9b
 m1LiS6mSrX83hTgaaN7RYgWuz7tmxCHSdItxtamNIeetHehtnQpTnafMPDfArn5bi/Lil71j5S5
 nOi3dVbFjPrsvtU2yqFxepDGbye77ebonOp9k9/zg0sq6J8oSh7XKpRCx3ONIqdBNC1QX8s1Wk2
 dxyVoha1dHIIpvqQR81Q8HzWiEHox9JnuJdexHYGv+32hYqCVbmaIAo8Ko5AE9Tfwa4uqwSvqL9
 uAwMhWgaWqYhTR8afECbPy2DKuUbYIPaOy8ubE+ThSKuTfHGur/yZqf1nsmyieEWcBcVdQ4k7FK
 Ud5RrdUoZovKeEA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

In practice, the device advertises bMaxCCIDBusySlots=1, so a conforming
host never has more than one command in flight and the ring never fills.

Fixes: CVE-2026-18204
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4086
Reported-by: Warisjeet Singh <sinxx198@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bba97a2b19e6..8241cd07648d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -580,6 +580,7 @@ static void ccid_bulk_in_release(USBCCIDState *s)
     assert(s->current_bulk_in != NULL);
     s->current_bulk_in->pos = 0;
     s->current_bulk_in = NULL;
+    s->bulk_in_pending_num--;
 }
 
 static void ccid_bulk_in_get(USBCCIDState *s)
@@ -587,8 +588,6 @@ static void ccid_bulk_in_get(USBCCIDState *s)
     if (s->current_bulk_in != NULL || s->bulk_in_pending_num == 0) {
         return;
     }
-    assert(s->bulk_in_pending_num > 0);
-    s->bulk_in_pending_num--;
     s->current_bulk_in =
         &s->bulk_in_pending[(s->bulk_in_pending_start++) % BULK_IN_PENDING_NUM];
 }
@@ -1078,6 +1077,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
 
     ccid_bulk_in_get(s);
     if (s->current_bulk_in != NULL) {
+        assert(s->current_bulk_in->pos <= s->current_bulk_in->len);
         len = MIN(s->current_bulk_in->len - s->current_bulk_in->pos,
                   p->iov.size);
         if (len) {

-- 
2.55.0


