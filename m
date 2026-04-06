Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191DFEF4ECD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9iVt-0002VH-Qp; Mon, 06 Apr 2026 07:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9iVr-0002UL-SH
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9iVq-0002M3-Aj
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775476381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=At4efh5zbXMwqFU0+ES27jl76V1LSdL1JadRGtGkEcc=;
 b=Di+VQKxhntbTLylZThkp3lUrETYkf7PZdsQvyR8uyMTnynI3Z84+h0hKeEixqkPEewstwR
 D6//pMHon/Wj0VNV091WwX6mEojrmDFQg2dRKsgpVuiapf45uKBlNqFLbDhDvxHeC4b5/A
 w04x0G6utXchKvJbTtCTQZkmxkEuQQo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-VEgNwjhJNr-jQ3jJ0-NlTg-1; Mon, 06 Apr 2026 07:53:00 -0400
X-MC-Unique: VEgNwjhJNr-jQ3jJ0-NlTg-1
X-Mimecast-MFC-AGG-ID: VEgNwjhJNr-jQ3jJ0-NlTg_1775476380
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c741c4cebf3so2496154a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775476379; x=1776081179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=At4efh5zbXMwqFU0+ES27jl76V1LSdL1JadRGtGkEcc=;
 b=RfUfiqm+woIp5IfdqubTRNjBO8vQnDMrBL5yx85/8us1N/YZYKN4yY1qKFep4e1LL1
 O/dmfyjUPCjFaPzY4zoTcJUHwb/qCT6qPmo492kOlnPWuwUFQHJGLAbd3QJy32NUD9Zp
 5gWHwbYvQ/wVBguFIWgpSJ2IdyM8DVkm0CPx2Ngx8Pu1+U4tdoK+uX0BGqr889sRm2Ix
 vbQ95vLPosFGZkTa3M5TFd28DTUGGHqYA/csKHMDT5ikI7X9v3PR7r3lbNWnsKjv/UfD
 apOinPaHYESJ8S5Xsj5f6jBFJ0e2qVaEt/I5ulsamipg3xI+sG6T5mvP1lmb9rHe/+Qx
 F1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775476379; x=1776081179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=At4efh5zbXMwqFU0+ES27jl76V1LSdL1JadRGtGkEcc=;
 b=BuNDj+Edh3dO2LGoqz0kK9BgmMxg9HeuGJDzisWI8yUCSYYjRAxXNJlpawA9RRZoJo
 yAycjaOyii97gObLSqi+BFxi1HFmz5sKMJAUXT+7zTHwCtGPa7Ry5rTVMGjqy/Rp0rfi
 GkmFOQAEz3IS9pEcXWZHmfeFU8ICvzznaOTV7Zfc4j+/Jj3VVrUMMTMzlUGc5BxgDHv3
 1cVqp1KDtmYcKRCOorjhb1GbS9SvLqhFtmf5RGtHzCQuIAx6gwA7vYsklX9bUXWypn61
 aj1Dik7agZzQH1UfjU2wzXRmxFueu70dafiiEKGlZzvrPgfKTNViBdtri+e/EKLNNhde
 9EyA==
X-Gm-Message-State: AOJu0YwAKyMT+OybKwib7ieDwyePXRNJyEfQsDOPYG/EdoJR9Pd7fj7V
 BT14Z1FID+Fy0OpVl+cgS20arJZtzaMnKV4gTG7AYd9V0GRr4RbeNTmHOVSARFyn8ieoIPAx5wf
 QVEzN7u4Zi4sI5YTekreaw7CXIc0L2b1MFCp26H1ZABhIiddaBAvLwnFL7LDpFQJJcdM14oYTRw
 L9ds0bczLkmteWLpwvWlBx0arMdTUYxFLwgSFvpls=
X-Gm-Gg: AeBDieuephmLxW0nvA6hkV/vFJSAYbgzPl7bmWPbrpIDNQVH5orpjw/ZJLbZQjQCuaI
 I/TfKP1MEWr93DCGCzO57nYkThWFHWdO6lJ5MvcglbC3k9lqpoHpy1RWdoIC+wQDlhZ/iff90KK
 nUurJNaUDetr7i8pexgbaTr2qKkiC5+udLayMaD4rQg8/POre1wWMRqIUCfv4DtU1xxjZvUfOR3
 1H4+NeeUEafDV9cA04uE93zCBM1V3yTvyRHe+v/XrpMZ4fe3OWqQXrdh5sEa3Y4YDgXsLdrAngj
 cc2YrVyltpwitEN15QevU3hO4+Himf59JKEQtRBbo2T/UxYIOBl1OAQAROd9W0flMpeBE520vP0
 HqKJFkBVPbXvE0NMAd2DvTt2ZVMQfhcIJu8PJGEIZuwjSe23BFkXiF6VOK2+Rgh5ZWBEf
X-Received: by 2002:a05:6a00:6ca8:b0:82a:ea3:c16f with SMTP id
 d2e1a72fcca58-82d0dbe3dabmr12061947b3a.53.1775476379036; 
 Mon, 06 Apr 2026 04:52:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:6ca8:b0:82a:ea3:c16f with SMTP id
 d2e1a72fcca58-82d0dbe3dabmr12061927b3a.53.1775476378454; 
 Mon, 06 Apr 2026 04:52:58 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82d12218738sm11547849b3a.21.2026.04.06.04.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 04:52:58 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH 1/2] migration/vmstate: Add VMState support for GByteArray
Date: Mon,  6 Apr 2026 17:22:46 +0530
Message-ID: <20260406115247.4879-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406115247.4879-1-armenon@redhat.com>
References: <20260406115247.4879-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Arun Menon <armenon@redhat.com>

In GLib, GByteArray is an object managed by the library. Currently,
migrating a GByteArray requires treating it as a raw C struct and using
VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
ui/vdagent.c

QEMU cannot pretend that GByteArray is a C struct and simply use
VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
overwrites the data pointer with a newly allocated buffer, thereby
leaking the previous memory. Besides, GLib tracks the array's capacity
in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
sync with the newly allocated buffer, potentially leading to heap buffer
overflows during subsequent g_byte_array_append() calls.

This commit introduces VMSTATE_GBYTEARRAY which uses specific library
API calls (g_byte_array_set_size()) to safely resize and populate the
buffer.

Signed-off-by: Arun Menon <armenon@redhat.com>
Fix-Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 62c2abd0c4..ab20445c4c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_g_byte_array;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -892,6 +893,15 @@ extern const VMStateInfo vmstate_info_qlist;
     .start        = offsetof(_type, _next),                              \
 }
 
+#define VMSTATE_GBYTEARRAY(_field, _state, _version) {                   \
+    .name         = (stringify(_field)),                                 \
+    .version_id   = (_version),                                          \
+    .size         = sizeof(GByteArray),                                  \
+    .info         = &vmstate_info_g_byte_array,                          \
+    .flags        = VMS_SINGLE | VMS_POINTER,                            \
+    .offset       = vmstate_offset_pointer(_state, _field, GByteArray),  \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 89cb211472..ccac731388 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -942,3 +942,40 @@ const VMStateInfo vmstate_info_qlist = {
     .get  = get_qlist,
     .put  = put_qlist,
 };
+
+static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field)
+{
+    GByteArray *byte_array = pv;
+    uint32_t len = qemu_get_be32(f);
+
+    if (!byte_array) {
+        byte_array = g_byte_array_new();
+    }
+
+    g_byte_array_set_size(byte_array, len);
+    if (len > 0) {
+        qemu_get_buffer(f, byte_array->data, len);
+    }
+    return 0;
+}
+
+static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field, JSONWriter *vmdesc)
+{
+    GByteArray *byte_array = pv;
+    uint32_t len = byte_array ? byte_array->len : 0;
+
+    qemu_put_be32(f, len);
+    if (len > 0) {
+        qemu_put_buffer(f, byte_array->data, len);
+    }
+
+    return 0;
+}
+
+const VMStateInfo vmstate_info_g_byte_array = {
+    .name = "GByteArray",
+    .get  = get_g_byte_array,
+    .put  = put_g_byte_array,
+};
-- 
2.53.0


