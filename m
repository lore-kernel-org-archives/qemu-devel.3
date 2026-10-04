Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA081CA5FF4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJR9-0004ym-GE; Sun, 04 Oct 2026 06:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQy-0004om-MQ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQx-0003Uv-95
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6yF7LsqwKY3BrBu3csJ6TmdbWWJaM8iH081bP/ndMbg=;
 b=R1UcN/+L2HLhbtHg6YwY6+qJu5PZXZD9VSXZE6ZTTpQOHf8Y+xSxZDjn3lcUOvaFnsLRSo
 rcFvfxZJT/lux08L+zPaWVtnOePMIiLiJ4y9o82fpHfQLyf4YUnQYEkoq+Fk3LJZQr6PCV
 sI83hiXFpnrn0SvyKIOtJ9RkMQHLNc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-sR4hW81gOT2QUcs8fjXxoA-1; Sun,
 04 Oct 2026 06:27:05 -0400
X-MC-Unique: sR4hW81gOT2QUcs8fjXxoA-1
X-Mimecast-MFC-AGG-ID: sR4hW81gOT2QUcs8fjXxoA_1791109624
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39566180AEE1; Sun,  4 Oct 2026 10:27:04 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 086F01955F73; Sun,  4 Oct 2026 10:27:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:12 +0400
Subject: [PATCH 58/63] hw/input/hid: validate queue length and key count on
 migration load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-58-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dwCP1tyWZ/764RY+qiLIoX9rNSsbHNQhHzwFnF4HaSo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikle+eTTI2MMwE6IiTjeLMCv713xhDH3TUtf
 PvwzDfvYKqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5ZLhD/9z42CHW8gSUzXU/vEOsG5Mi6hIOvHqwDxCeZgky7EadsmTCaFFx/4td1ZkE6bRxYDo7si
 bIfak1B4HvJjP20XRamRflT9PdoUlyxYdPFsIKgpMu98qU2aGQ/pm0EyM5LHVGv1ps3UUn2OTB6
 Gg7UqEtw1PCJvMVwCVf53CI9xEGewU3ZTDqi3hiUaQCkgLFNVnBufUSdRwyrbhBOFWhSsKtjr7+
 OVxryxvOnwtMuuaRQM7ng/YpHAKjMMg7+pg9igWsUIpgHJZiztbt6yUTMN4/mzPu8b2Y17tfUr1
 yfpmZOfxRmqJ0DdWWwJ11jfUTf0504BjWNEAoT5AW+EuB6xwqNRD22i02Ucj9bDwJVvYLcDoTaQ
 QLohIsxvnT8p2Ah9uggh8fzkoC5Y0db7PPfkrtEBVpBObmVbRzBeCbikee5lvm8z4PrW5ysDwJX
 KpjO83R1CTOzm0D4A46kTMoMLStht6g9pNGpRN7mMjucCdtODqr73F/CuIh/3ta2RnWh//xBoUZ
 bUI4/jqU8p2GeMC6ShjhTnOVeuHzq52IMAyjbVIU9uisQtJU7XW+tQI1BWNhX3mDnTmyobQYmfk
 7nv7zQr0okEXeBuQWweX+9lY2qpJQhlIuHx+52z9VaqIVGWINzvwdSZ8pB/oGBbQo9WhWCwD2R3
 gN7ijBCrvJg+t5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A malicious or corrupted migration stream can supply an out-of-range
queue head, queue length, or keyboard key count, leading to
out-of-bounds accesses after load.

Validate that s->head is within the queue bounds, that s->n does not
exceed QUEUE_LENGTH, and that s->kbd.keys stays within the key[] array
bounds before any post_load processing.

Fixes: ccd4ed065be4 ("hid: introduce hid vmstate macros")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 0f28827554e3..5098497f41bb 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -547,6 +547,13 @@ static int hid_post_load(void *opaque, int version_id)
 {
     HIDState *s = opaque;
 
+    if (s->head >= QUEUE_LENGTH || s->n > QUEUE_LENGTH) {
+        return -EINVAL;
+    }
+    if (s->kind == HID_KEYBOARD &&
+        (s->kbd.keys < 0 || s->kbd.keys > ARRAY_SIZE(s->kbd.key))) {
+        return -EINVAL;
+    }
     hid_set_next_idle(s);
 
     if (s->n == QUEUE_LENGTH && (s->kind == HID_TABLET ||

-- 
2.56.0.rc0.29.g47ce80527c56


