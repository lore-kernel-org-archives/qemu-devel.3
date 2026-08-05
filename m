Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6514C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraBC-0007UK-Tm; Wed, 05 Aug 2026 07:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraBB-0007Me-Eo
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraB9-0007EG-VA
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMibH8iba3oSpJwO21+PI+MpXq9PANZk1NviI0MLeWA=;
 b=YN1K818cKVdcHoFZGewuiWan5VEE4BxBb2vOH95zGzouh/SzAJJ7n3BbXQGLc+EVFW7eDb
 +hdtLEby6vhCmd4pQZyh2ScF0sAMJq/a6Oef4U40hrpo851YeUrpWqLUD3dhggIoN9NGhM
 V8pnj0n5nbiqDKkzCca38yGr084Av/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-EoirwjjVMkWgyhvHmnVxQA-1; Wed,
 05 Aug 2026 07:52:53 -0400
X-MC-Unique: EoirwjjVMkWgyhvHmnVxQA-1
X-Mimecast-MFC-AGG-ID: EoirwjjVMkWgyhvHmnVxQA_1785930772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A2A19560A2
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:52:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72B9C180049F; Wed,  5 Aug 2026 11:52:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:59 +0400
Subject: [PATCH 09/27] hw/usb/dev-smartcard-reader: validate migrated
 fields in post_load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-9-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vf6q3ker/6skkfLofV3IYMweVoha2qg+51FmyI3g6NE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOs2Fhl/j6IJoOofsW2hKw5OgMNnituTOvlc
 gIS+QeyawSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrAAKCRDa6OEJdZac
 5RsaD/97AaM+S452u3iRaTaImX8PikeJNedRl7gW4LoRjRgzGE+gzjddnzivsb1eLY7ODmO28dN
 6c7e0+Zx7DPud/PSoPoaFWq0WfM3bMz2z6Pw4+cLdQLC+OwfONmXcv5MKP0k80soB8xQPyWndmT
 7wC/D8ct1+GS3VIxee5SE6+M0TqGvbN1uKgHKiDTKLlmV02Y0KbP9y+vA83gcvqKbsFyrXzmeXd
 8vDlZMMWQ9R7EAHMsBK+7o/ymqPhx1AseEXYWCJLp/D4yoWKhxuBvlUvm9f2xh83NssUb2uWpba
 SqMPug5QweTZOBmd8iytVNRKFd/LJSalEHpsSmCKzmvCRg89vqnQxU6RahxHSk9keHRlWJ10mFO
 DIzW0S3Ikyu3+K8j+Rnhhpi+0uW/L2yKhj9e/jN3INMxw5i1tyWJ+DsCJMKsJo52/iXnun3biKj
 SQCnjaVMBkj49VP3UkB5JaZ4Oqpl+KNBW7g8MR7fpqCzxrZXDLv53hpFkx93eStZJRYKhBgGc6n
 S7z2hjqcjangH1Re76Kjej5Voz5u2N52tv3eQkqHnptyNnonmiMhj9bQKBOUGdDE40m/351AOb4
 R+YCRANyMOKXwAJEmUhRlV/G3in7DJLGiMYJzZ/T4cC4v1gWk0yoqIaFreSq3YmIhGtfiIyT6tt
 jAvyRDpGUt5VUgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Validate fields loaded from the migration stream to reject crafted or
corrupt data before it can cause harm.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index c6a9faf00d6f..bed641be4512 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1364,6 +1364,26 @@ static void ccid_realize(USBDevice *dev, Error **errp)
 static int ccid_post_load(void *opaque, int version_id)
 {
     USBCCIDState *s = opaque;
+    int i;
+
+    if (s->bulk_in_pending_end - s->bulk_in_pending_start > BULK_IN_PENDING_NUM) {
+        return -EINVAL;
+    }
+
+    if (s->pending_answers_num > PENDING_ANSWERS_NUM) {
+        return -EINVAL;
+    }
+
+    if (s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
+        return -EINVAL;
+    }
+
+    for (i = 0; i < BULK_IN_PENDING_NUM; i++) {
+        if (s->bulk_in_pending[i].len > BULK_IN_BUF_SIZE ||
+            s->bulk_in_pending[i].pos > s->bulk_in_pending[i].len) {
+            return -EINVAL;
+        }
+    }
 
     /*
      * This must be done after usb_device_attach, which sets state to ATTACHED,

-- 
2.55.0


