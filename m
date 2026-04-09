Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C45F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtYM-0007yd-FS; Thu, 09 Apr 2026 13:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wAtYG-0007y4-L3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wAtYD-0005IT-7S
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775757140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpxskO25poCqMwG8Rlk4qDtN3+z26Jd447w2s/nj4gc=;
 b=HMVjA4BuBZzygucCgmFCPxwIZVHI8wxqer3ujsumXtHcJIUW676R0FXHPj/LnmaU18wKIM
 5PsqwhztTAtl3lugWPPYCRi5L2XjI3CkkfQlqRy63fHltoRRs7EiASuwGNX1RY55kvtv+4
 8RJF9IuNsGgscEcYqadzPwL3n0dCwzM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-qS3O6k_vPayOf1zwQI9HmA-1; Thu, 09 Apr 2026 13:52:18 -0400
X-MC-Unique: qS3O6k_vPayOf1zwQI9HmA-1
X-Mimecast-MFC-AGG-ID: qS3O6k_vPayOf1zwQI9HmA_1775757137
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c76bb22a8ceso1393488a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775757137; x=1776361937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpxskO25poCqMwG8Rlk4qDtN3+z26Jd447w2s/nj4gc=;
 b=lIEpnd3vTifVmwEytBijN54/FeEKbJEtElD+PvBdvFRTIXahWNKulHbtaXUeKXXDbu
 lBK9DjcLkNEQb3pOedJyE3pKNYvTg4GCiRi8ZYPc4iVt0PDk123sHUh+HjYbLbKFgvhv
 5qcIYvvBsKo63IDMlmOKxp0YkOc6mIAA1bQa+zQ0DiPWeZhai6Rf8kAbfTkzalWQefwZ
 vtFRdKVYxcNVcHrmZ/8yLOv2etbfAz9pM9VoQqkMY92c+d36Z5AcU57uziUyZkT3J5RP
 lucfBC7SR2DCh1Xhx6P7wVxJhkSWoi5945ZwHAiSgtk/Wvj38i1QDf7c0aldgwFE92k9
 qUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775757137; x=1776361937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OpxskO25poCqMwG8Rlk4qDtN3+z26Jd447w2s/nj4gc=;
 b=ZONFm8AAZPkoEyH0WSMy1lvmb8551ujLDNTlRB/TsOYLtl0G5moNc8IFPtIKk016Cu
 GJ+JAIGxSWlir3TFBTMbb0yG42QNu1gZkHQoEaemQoBb1YiDp6CnkjSdG/mzWMl8RJtD
 TYULZ9mDbz+DaUW8MSvrsjbt7b0a/qS4IRKa40QV33AdbvDbAQ+7WejAB2PZ7TII54yN
 pmt64ylkG5PSdX13yVWQ6bGp+o2qFY5tOAgA04bzRMP8uJH1AU9NSEZZonKXOmDonzS8
 faTOxW0+5d71+mxIsshm+WL4x6hMIE1Z9fXmZHLpFCkxJ2FJxrTYyDOSwZI78qK+9nH5
 c6aw==
X-Gm-Message-State: AOJu0YwluTGTDimJA63pVSFWbYsOkRr4Uqapo+Qo66Svx4f0JN1E9NtQ
 JO3tu12ihnZC5M9q44vY2Y+r00i5FFO4sNuoYoupjOgTVRNYkhRpRnI3iEO8BOEnzSPj12Bsuuy
 hfCMQ2N+GAAhbuIkAiKg2JgNKh3wRUh2OGDXtXOPorhR1v1R4YHV3AjvxRfFg2Vxa7/Dygii/Er
 POvGvsDqK+ziENyer97W45PNRensF87KPiGF/X81A=
X-Gm-Gg: AeBDietuUXVLSFNVOYIxb2EJHsxTmwBzhkssWjjLSHofSzXNGmM2F/Eo4U13dxinVGA
 ZKz1iH5pX7m1+8kCKrhR9zSqtRj2RlYVTOLkrej0QlGuAe87HmaevVjqp6WOCmlT+OfdXOgnVb5
 Tr0aWZUteLvRyJ4ULCmE6wbtii1q98m/tA3b63qr+Ck7CW4Mq3FLWSSwuTr08uR5wJY4Ai+dNO3
 iP+GETwLfk/5rcRhWCzdCKPdlYtkGZ7kAko/dAXPibjv/ka9TpokWDcTQ+nPBuB03jDLTDD+F2a
 qlrhgXSeHfLXV7v0Ur66KrUXWABwnYDbF+CaZhHvSR+8iPVmWRBSVZ9lgZY2sjG49B/DgPvjfik
 3OVcExcMEJudkcLaQFS+pwJkXSHhLcrLGS+zArw1eWyqF0Y0RiWbk5PP1LqMTOfM=
X-Received: by 2002:a05:6a00:3907:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82f0c29fed7mr140580b3a.25.1775757137098; 
 Thu, 09 Apr 2026 10:52:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:3907:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82f0c29fed7mr140540b3a.25.1775757136342; 
 Thu, 09 Apr 2026 10:52:16 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c52cf05sm27736b3a.61.2026.04.09.10.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:52:15 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v2 1/2] migration/vmstate: Add VMState support for GByteArray
Date: Thu,  9 Apr 2026 23:21:24 +0530
Message-ID: <20260409175126.5921-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409175126.5921-1-armenon@redhat.com>
References: <20260409175126.5921-1-armenon@redhat.com>
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
index 89cb211472..743c2092e9 100644
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
+    if (*byte_array == NULL) {
+        *byte_array = g_byte_array_new();
+    }
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


