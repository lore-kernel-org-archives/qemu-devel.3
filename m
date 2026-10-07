Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D5BCA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESnB-0007ms-6t; Wed, 07 Oct 2026 10:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xESmB-0007Bt-5f
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xESm8-0001ri-1q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791383862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CS1tmpYBN5Sup1NVnBDTkyXL4JXmKmC9VGKVMnvnKN8=;
 b=fPbNliWUiZfh26vt7ynoNcFfuDyxBx6bjnjOU96WncWrWv0Up0r7y373qvrzaXM8XrTmox
 aLSuaYtMquci+UcNefpJ6GFN6pZPhzIvuy+JyXrWYt/P9BoukCWZBuM7sWufSQGRKaFxR3
 XSZTS0Rig5gxBHfGaJuebiM6V1dkMAc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-OFmNYfYGO5adWrhAnqQw-Q-1; Wed, 07 Oct 2026 10:37:41 -0400
X-MC-Unique: OFmNYfYGO5adWrhAnqQw-Q-1
X-Mimecast-MFC-AGG-ID: OFmNYfYGO5adWrhAnqQw-Q_1791383860
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so30947475e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791383860; x=1791988660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CS1tmpYBN5Sup1NVnBDTkyXL4JXmKmC9VGKVMnvnKN8=;
 b=TlpZ1WgjbSZxuqel07EjVSBqFbbcrjzto/klJB062XN/bQ5U6fYO8DibGv+r6Fi0vp
 pUIzJtK2Gmph08nrtY4e3SlspjGARWq/07ZhJ6UdJuMyydvD6eREatBL/sRZ2Vnl8WI5
 adZHSrilItu3KD31lmSqcJ9svAN5outY3veTc4IUzqYqo30/wpnamfiYkdAF6t0GuwgY
 +nZBmKZwiUkE/oNhbt+7VoxnjWt6uO6KNqp9CMQL83ml12+Tje2oZ2JXFAqhjVbp8JUM
 C3UdEFuN2BK2pk+08CePHdrV4deG7I6sCK7TLWIy3ZO32cabrvGi11ThBCogRi1nZ59A
 H2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383860; x=1791988660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CS1tmpYBN5Sup1NVnBDTkyXL4JXmKmC9VGKVMnvnKN8=;
 b=UGmzc9Acy7tjBQrG5fjeekdtk4BJXwc4Y7Z1QewzWdUHXOgNVhQ0xzYHoFmii9nmBk
 oavsRge+LFppZ5TExxIEex+P8pYJULslMnBgBUiUdqRi76KIFMgsr1cKbmkgOicB7bpP
 4+ZH7ecPiudIFBPdGH+1K/RR4hI0aSeqrq3awXFczRczRFbDMuwkyH8JGs7VFMih9ERk
 EcITPsDU100CZEZ9X5FjG/GrvraEokx9LcP1tqiSi63CveNLsPFasOCAb8nBVDw2cQBW
 NECzJQfgcXh+c78uspXERNyB0ezIKFEcHe4mp95VPXIDEtl+ZNguLkVpeAOUJkimwvwK
 C/qA==
X-Gm-Message-State: AFuF++nhuimZh92yJKfvVr29ayewUUY8BSVXDGOcs1pyrGlFZ/QbMGLb
 6emb5NdfDugpNa8LPSIkvCMflY2mPs/Ult70yWDwmlriQeWdj54Rpx1LMGYCdXsSP/qR+DAB5Fa
 h+c0L8NMpmrjlW4zY3wf7vFyW481kVHEzOtEPNT6j3EOR1VUpM3NBO53Tsc5tS2ypdn3iBOu1E+
 pew2K4PcimH9KgrcZeYgwNhFbHr2/r+YjRdFCHLmZ0cA==
X-Gm-Gg: AYBFou3e3yXLR95Fr16tavku8Rzz3qedwoVthNFZoEqM3JdseVmlsHK1UAs1hgjAN6Z
 QyGPtGwGcbH6kbghnOvCRFMkGLB33+E3y5O2FG/fDXaqIdZf3+awWhn3Kv3xfDfmFZ2p9yWZq4Y
 2BLqiW8tnlyBGjM+k66vTeSp5/AjALkcjvgZy9CPZyfE/ZMpOCN5prnGYoW/qoKGSQBXJr2fw3M
 DHRI6WNQOuSUCbdx9c1RYYL7NFGjmufHCpinwuOiDP1tvonlUFklvUYpb6d6q/6Xr7R7vS195x8
 UaG9QfZBp9bysTF3O+nwxNn5XK1XsNL6E5R08yhP30TWDnc92mux2TlteTrK1+2mMexs+qH2
X-Received: by 2002:a05:600c:1551:b0:4a0:263c:704f with SMTP id
 5b1f17b1804b1-4a1804436c7mr38951995e9.16.1791383860042; 
 Wed, 07 Oct 2026 07:37:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1551:b0:4a0:263c:704f with SMTP id
 5b1f17b1804b1-4a1804436c7mr38951495e9.16.1791383859579; 
 Wed, 07 Oct 2026 07:37:39 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111043735e9.9.2026.10.07.07.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:37:39 -0700 (PDT)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Luigi Leonardi <leonardi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>
Subject: [PATCH v3] hw/usb/dev-mtp: Fix heap OOB read in
 usb_mtp_write_metadata()
Date: Wed,  7 Oct 2026 16:37:38 +0200
Message-ID: <20261007143738.58509-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

usb_mtp_write_metadata() computed the number of filename characters as

  filename_chars = dlen - offsetof(ObjectInfo, filename)

where dlen is the amount of data copied by the last USB packet of the
transfer, not the size of the ObjectInfo dataset. If the final packet has
fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
process memory.

Use d->length instead: it is the size of the buffer holding the dataset,
and usb_mtp_write_metadata() is only reached once all d->length bytes
have been received.

d->length is guest-controlled, so reject datasets too small to hold the
fixed part of ObjectInfo before dereferencing it. The check is "<="
rather than "<" because a dataset of exactly offsetof(ObjectInfo,filename)
bytes would yield an empty filename.

Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---

V3:
 - Restore guard due to guest-controlled d->length.
 - Improve commit text for better readability.
v2:
 - Remove the dlen guard and variable in favor of using d->length.

hw/usb/dev-mtp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc..45641c3489 100644
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
@@ -1704,7 +1704,15 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
     MTPObject *o;
     MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle = s->next_handle;
-    size_t filename_chars = dlen - offsetof(ObjectInfo, filename);
+    size_t filename_chars;
+
+    if (d->length <= offsetof(ObjectInfo, filename)) {
+        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
+                             0, 0, 0, 0);
+        return;
+    }
+
+    filename_chars = d->length - offsetof(ObjectInfo, filename);
 
     /*
      * filename is utf-16. We're intentionally doing
@@ -1801,7 +1809,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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


