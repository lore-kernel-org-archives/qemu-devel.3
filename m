Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09C9CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlsZ-0000bq-GP; Mon, 05 Oct 2026 12:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xDlWx-0002Pz-Vz
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xDlWw-0008Q4-Ag
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791217629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kuxxhof2ZuTH5CX/xqszah5j+4HNselzA7UkjaGZ5so=;
 b=OUxqsPhngmU7md1lm25zRmyuTwXJtqc/0I/1mm0/t1fr24DXqini2gX0r9blOX7daGel4V
 HcL624Fc9+C4VthqsanuaLQyLWPiiNBDUr0XPE7+5FqsHef1Wj+JYSzGDWLyhhhrMW5Y6p
 hvMqBXfo82LVXNG1CrZK0INoVXoJjlk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-NF_d4B_IOeOCaPU4KXGy_w-1; Mon, 05 Oct 2026 12:25:59 -0400
X-MC-Unique: NF_d4B_IOeOCaPU4KXGy_w-1
X-Mimecast-MFC-AGG-ID: NF_d4B_IOeOCaPU4KXGy_w_1791217558
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a01c621dc2so14446115e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791217558; x=1791822358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kuxxhof2ZuTH5CX/xqszah5j+4HNselzA7UkjaGZ5so=;
 b=sGYAC3QyCpXRWXuFCwyZppNdu2ZJ5gJVx0i6fWk91+KlyUYD3ITVfN+va1HFwCugop
 H8l09jJFkZLUl4T2K5cjSVgj/kpgFeD1H5Aak4C3vjpFYJo113dvu1anja7wKVCeQ0mv
 9Ygvq3P/VFCnhM8mZTxWLd3VRXt+I3ZsqWlhltMy2oQGp3F418yWWrbjL9P7QbN1f7OJ
 SIlpp2CPWaViIhD22hmSqUHUZyJbeYJdH5VE2sKz7/rWs/R941a2Q2BLN3SF0EdLsCjf
 jB/UzBxHQYlWcWNAM9OR57GnTp+7PR1HTlDwoRIfixNdnvTuniqT8/JTWea/QP3xLLGm
 r8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791217558; x=1791822358;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kuxxhof2ZuTH5CX/xqszah5j+4HNselzA7UkjaGZ5so=;
 b=dYJrighhSlFZAnp+LKJL4NtAlOgsEYkUCqG7gYZvjZbmXPV9u0oRffrNJH45ak4CPw
 Nu2PFdlFOKjTG2z/fc6bOiWq6XULeHYtd3YHSutIBZ/28WqOphs0kMnOrKZysB5B5FTJ
 rOEd2p3HlLRylgcnDJ4F3V++obq7jKsk8lYJVW3rI5gGPCrs4f+rXSb7AsNPW9qxF+cm
 TaD3eb2S+7FB8iQ8Oaupu+uBu/HWOPYUQBQHwckNOEiD37BVmTAToo5rSeBJ7VYXoYgc
 hH6S0VtkrN8UKIpqI5BOZEC1ReVpL20N1GQc4M9o7mc2OEpl/DHdHUWot7FlNiQb5eIo
 i3Lw==
X-Gm-Message-State: AFuF++kw6uHTZEg1QUL+qAu0KqQ1mW8r7GjtxqMZwXpE/1USwiyzh87B
 yirj3XV+1FfftPOYMcvVLsn3FmbefxbLvN3qIkIyjDFg3Wb9qX9Zq9ke6svekDrPMnyQ7aujBbv
 Jo775HG4pZOv/mN18tscQpDcLg9uSGJg9kQXkZ/2/ZrC8coiHfURB1TC71DRRpTCzPAFzbyiiB3
 gKv4OYKvb9yCc0nJb5Xex/gCNzmlZ9FRtkVaLELr9BeA==
X-Gm-Gg: AYBFou3jUsZcjGe2WIUUBHYk6PWkK9rDVQ5G18SiVxry8FTP7QL9vJc78csTkazLDN1
 ebYqgDsBCNSIhhCsqm1nuf60qA5qfSdqz1j7EL6GhrgNZE7X1c/U9Gyp6yF7USeaniugqv8BD8K
 2PPoCVf/fwOp7tpIsPw0sINUz7deFap8HPT8bQpdHZF8PKp30VTS/ZnDVkDrMB2klqrFAMOYPgY
 rDKVAXeMW2ZdI5BAyn9n6UXxR0cKT6wmvoA25dhkaTfOkKQfhrFADqAr46NgFiYnI3PMTknXD/B
 6VNEFyQHJ6t0Y/NBGwKn9Q+LeA0xOgmrM0/a1lqqfeOmegX2L81MmTyt9eaV4TVLWABfmAuN
X-Received: by 2002:a05:600c:c16e:b0:49f:ffdc:939d with SMTP id
 5b1f17b1804b1-4a02755fd8bmr178371105e9.9.1791217558353; 
 Mon, 05 Oct 2026 09:25:58 -0700 (PDT)
X-Received: by 2002:a05:600c:c16e:b0:49f:ffdc:939d with SMTP id
 5b1f17b1804b1-4a02755fd8bmr178370765e9.9.1791217557965; 
 Mon, 05 Oct 2026 09:25:57 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178db8b09sm691695e9.13.2026.10.05.09.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:25:57 -0700 (PDT)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tommaso Califano <tcalifano@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2] hw/usb: Fix USB MTP heap OOB read via dlen underflow
Date: Mon,  5 Oct 2026 18:25:49 +0200
Message-ID: <20261005162549.120647-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Oct 2026 12:49:30 -0400
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

In QEMU’s USB MTP device, usb_mtp_write_metadata() computes
filename_chars = dlen - offsetof(ObjectInfo, filename) where
offsetof(ObjectInfo,filename) = 53. The dlen parameter is the size of the
last USB packet, not the total ObjectInfo size. If the final packet has
fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
process memory.

Replace dlen with d->length to avoid this issue, given that the latter
represents the total size of the buffer allocated for the unsegmented object.

Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---

v2:
 - Remove the dlen guard and variable in favor of using d->length.

 hw/usb/dev-mtp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc..53b5904a5c 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1696,7 +1696,7 @@ close:
     s->write_pending = false;
 }
 
-static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
+static void usb_mtp_write_metadata(MTPState *s)
 {
     MTPData *d = s->data_out;
     ObjectInfo *dataset = (ObjectInfo *)d->data;
@@ -1704,7 +1704,7 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
     MTPObject *o;
     MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle = s->next_handle;
-    size_t filename_chars = dlen - offsetof(ObjectInfo, filename);
+    size_t filename_chars = d->length - offsetof(ObjectInfo, filename);
 
     /*
      * filename is utf-16. We're intentionally doing
@@ -1801,7 +1801,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         if (d->data_offset == d->length) {
             /* The operation might have already failed */
             if (!s->result) {
-                usb_mtp_write_metadata(s, dlen);
+                usb_mtp_write_metadata(s);
             }
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
-- 
2.55.0


