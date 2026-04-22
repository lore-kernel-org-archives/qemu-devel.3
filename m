Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B934F55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSr1-0006PG-BQ; Wed, 22 Apr 2026 04:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFSqr-0006N9-UP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFSqo-0006ar-T4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Joilcik9KtEdJZjq4mdYWkp4FhfcJg7uC8Vb6+X8nd4=;
 b=g1Tv3AiKU+/LpaTbO9o8Dy2rVshGLWiCnSV0aRU4G8uM1H3AM4FMzGIXekgH5p/H1rO1Dd
 leoAkkYwRpLMudjCdE0yrA7TJn/CnZReOu0eZzIKLIXPEvVbNc2OcDDmElVzbVYQlQcHBX
 2nMK5UVg4MKqw9s85L/kvEmEcH6Mh20=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-FVPFynTXO0qGkrhOe1enhA-1; Wed, 22 Apr 2026 04:22:24 -0400
X-MC-Unique: FVPFynTXO0qGkrhOe1enhA-1
X-Mimecast-MFC-AGG-ID: FVPFynTXO0qGkrhOe1enhA_1776846144
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso3467905a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846144; x=1777450944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Joilcik9KtEdJZjq4mdYWkp4FhfcJg7uC8Vb6+X8nd4=;
 b=TkoankDlRhkHuvk3cAydhqza4XL19tcq+QB5dp8RUZ1FF/mZi6VjxL3PTt07s1haKk
 cXQ+meTPhSFvpKfMaV5YonfFRPjJYIqkobiP8eCezzbpH7U8T9SHOaxuxxEPzX4eHDuU
 VOQ8yS3yrdI98taCsdxSxCGAguWCBCwk+7R8gdiuNGaNSCULQO0YKjv7LkF8FIvzDNmk
 tbkB8xqRfPiNxJUeaW51Wj3LT9dGE/aXNYEbfr6jBrYyG4t6KHhrq7kADpI+dKKb9Vst
 oYPOZ3yYjeQJsolqWrd2dlQ6v97RuZWu+2IDhKR5NpzxFM+sG8iaAzUfiPGjN69cKUIT
 xigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846144; x=1777450944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Joilcik9KtEdJZjq4mdYWkp4FhfcJg7uC8Vb6+X8nd4=;
 b=m25LCpLtiWRQTCDh5qO4gFqx88f/ophYnR4RYRZdW7TEvjSAyhvel5Hh+pn3y0dHRH
 KpAxG2ZcfEhkPYExrhuP2uKX3r/nt3Fiy9XHoOUzTg+9V9NDL+hiFT/oZ51TuLKUYgYx
 cdLDiRDqPbYqWcmx8WfAYDTfayEN8g7RU3XGuJ6kNz8vFFEtVHQi2V++F77giqSJQpiA
 xujFn1qWPWR8xTvR37jOuHil3MfUtqw6GDQ+kAwZ/DngjMch42DajDC3SFok5OJpC/nt
 J3pA3SL5idadaXINBtIhSbbRnkQim5aC7ljJAfJnh1GP3iHFWmV0GD30ClrIJ+0atjc5
 3oKA==
X-Gm-Message-State: AOJu0YwbVhxWC7534HL7qMZk7C3ZJUCQyKRWgPbpJ5xAsCSNJhmsew39
 kNZswlzfidYBaClHTsEE8Yo6ezUH0Ia+X341ev/kE8CJ0TG6TwUy9LxwJoM6Ig+3kAHN7wie+AX
 3EzuIT5rS/K7lFESt27dH6OleA71CXTzchP7YrlhpdnNIi0phS1OpwAyY/Rw0vxaQWhY/A6cONP
 8SOdp4pCmuv1nwrAbh3q1mMX/JmrVf9VaGnHtYpeg=
X-Gm-Gg: AeBDievx3kP5EX6iHKJNf/LdopPabUD1ghNqKq3VQuHFb0rrhxsjbmqWkj5HHbby78W
 ZRoX3rrLdavbOj/TQxRZeB8uJybiknT8n5ubskP2bCYPZQ0jjLpPutMMjGPExBeRZi5+zOawY3t
 juDBKciNKOV92lRVDraQsBggW2QwAqq4V3+j3+hhCllSO1MOBx61FW2aXG1MdNwuw0mpTPP2ENh
 CrFMHXsBbO2sfoCWVtb5gD9cRJqBCrQ1v4u5l+ro1HyxSsycpQQFCwTWT27ZOo8P9MW5cgQXmQW
 nxqai4dlKh87C95qmH/N6Ztb1Xkjao5eryZPsAlQA6rUitdM1psnSTbR+nfHL74/3ZdGqdNhpmf
 I8+/mycRq8lnRguYV7j4vVSqUk1Qwub7p5DbMSMl5fE/N6zpZ0kYAKHQV9NwPdCj2q6HLJTvayg
 ==
X-Received: by 2002:a17:90b:3d01:b0:35f:b75e:fff5 with SMTP id
 98e67ed59e1d1-3614048b7admr24121777a91.22.1776846143685; 
 Wed, 22 Apr 2026 01:22:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3d01:b0:35f:b75e:fff5 with SMTP id
 98e67ed59e1d1-3614048b7admr24121739a91.22.1776846143066; 
 Wed, 22 Apr 2026 01:22:23 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fabeccesm5991459a91.6.2026.04.22.01.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:22:22 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 1/2] migration/vmstate: Add VMState support for GByteArray
Date: Wed, 22 Apr 2026 13:52:13 +0530
Message-ID: <20260422082214.10390-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422082214.10390-1-armenon@redhat.com>
References: <20260422082214.10390-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 62c2abd0c4..f503a40ec0 100644
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
+    .flags        = VMS_SINGLE,                                          \
+    .offset       = vmstate_offset_pointer(_state, _field, GByteArray),  \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 89cb211472..e3a47e60b1 100644
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
+    GByteArray **byte_array = (GByteArray **)pv;
+    uint32_t len = qemu_get_be32(f);
+
+    assert(*byte_array != NULL);
+
+    g_byte_array_set_size(*byte_array, len);
+    if (len > 0) {
+        qemu_get_buffer(f, (*byte_array)->data, len);
+    }
+    return 0;
+}
+
+static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field, JSONWriter *vmdesc)
+{
+    GByteArray *byte_array = *(GByteArray **)pv;
+    uint32_t len;
+    assert(byte_array != NULL);
+
+    len = byte_array ? byte_array->len : 0;
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


