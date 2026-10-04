Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6B3CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQm-0003lr-Q6; Sun, 04 Oct 2026 06:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQe-0003Gk-PT
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQd-0003SL-6j
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5DmzdgqXSGLK/B/CBtE0u89MdBnpelgTugR53pOvRQ=;
 b=hyqrwOj0RZbdKOIphmKMANDTEb9x6ZYyDFpFUdB6i/XsRt2ZzMY+PwaZqdaw3YazAKdF9V
 pmpOWVSgJJP+n7jLXoRrvxQ0YSOsqNooquB2P5EF8tXQdcyXgLy4PADTE61cJH8CwgHLbw
 pw37ZEogZSQAXBGdcV84dLUufYmdwR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-WxIdQki6PICRnSHWUu7lLg-1; Sun,
 04 Oct 2026 06:26:44 -0400
X-MC-Unique: WxIdQki6PICRnSHWUu7lLg-1
X-Mimecast-MFC-AGG-ID: WxIdQki6PICRnSHWUu7lLg_1791109603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48BC11829E0F; Sun,  4 Oct 2026 10:26:43 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DA7C1800345; Sun,  4 Oct 2026 10:26:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:06 +0400
Subject: [PATCH 52/63] hw/input/adb-kbd: validate ring buffer indices on
 migration load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-52-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cBY7qMLasrZAnJoG71WBzyQa6WGcjYSiQcqAy1KCrCs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklTr4uO1hO+32wFPQfJl8AkK7k0o/c5+YBI
 1zDnvAbnMmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5WOBD/wLl37yqcznk2r2hE0joFsA5wHiRSI+h77g/SWfPf9wwgIJrxIWkC9gk9RPpytzAjKsrIl
 QbyYSnOM9eiRnGDgO7vlXewrRQAT4o0GIAeaW8HGFSR1eEq8fzUkzsp2AtWQJ57RPui/fxgtIRb
 6i6iubzknH/1FqI7SVdi0Ykoy5Y2AXyI5B07PraBE7Vfp5thM6DG3pUt9Yl5Wq4sxt1aYV2vk6l
 G/a5MdYH2v5EhFTMTrCk9GW7LJNFZEMB6tN3LU0Wi1Dsy2l+TK/+X+l5FgzYYCty8OLQXFEoIiB
 efSda/opcxTVZHDiJy4ddtEdobD7eg0JgGp7Cd7OvT46/tcKZFq+Nbp7hJ/pBmIt3IhzCiK9U1J
 PqxMFFOCYFMDVBMG7hlsdn0qCfNVDabdI5TsL8zRUAd9vF9qPRFb2MG8ps95cAl33G3Hh2w6b93
 zsDue0tt9IYkfXRINNMpLlGFQ7b3ROnIdMAIkqbDJ4v/EYVBovFh56ZaqSR2fi4Wz2mFfOJXZUW
 0rbLggWUSKiiWUsQb7nw84MnC0Z63s+pB5kVZ6bIeih6VWswN29lUtHzz8Suymof8qVzpZ0yiV+
 zA1HMd1zeHzLX2jfgs3lDRnNkO9rUqwUVYRgMUbWoICJFKUZlpHafERErLEPJa1mAdIYwbk5266
 TKwFiRnqyU79GrQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A malicious or corrupted migration stream can supply out-of-range
rptr, wptr, or count values for the keyboard ring buffer, leading
to out-of-bounds accesses after load.

Add a post_load handler that rejects values outside the valid
range of the data buffer.

Fixes: 77cb0f5aafc8 ("Split adb.c into adb.c, adb-mouse.c and adb-kbd.c")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb-kbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 9d80a3849b77..8635354f024c 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -334,10 +334,23 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
     adb_kbd_put_keycode(s, keycode);
 }
 
+static int adb_kbd_post_load(void *opaque, int version_id)
+{
+    KBDState *s = opaque;
+
+    if (s->rptr < 0 || s->rptr >= sizeof(s->data) ||
+        s->wptr < 0 || s->wptr >= sizeof(s->data) ||
+        s->count < 0 || s->count > sizeof(s->data)) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_adb_kbd = {
     .name = "adb_kbd",
     .version_id = 2,
     .minimum_version_id = 2,
+    .post_load = adb_kbd_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, KBDState, 0, vmstate_adb_device, ADBDevice),
         VMSTATE_BUFFER(data, KBDState),

-- 
2.56.0.rc0.29.g47ce80527c56


