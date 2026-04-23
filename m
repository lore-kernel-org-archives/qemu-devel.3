Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E0F9936E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrkp-0000rh-OK; Thu, 23 Apr 2026 06:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFrkn-0000r4-Qt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFrkm-00050g-9R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776941871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7eIb8iAvGQk4TDjBMbdfb7Iw7V4QRw3ih4nqSU+64iY=;
 b=ItDA64MIcFACZGjxQtIK3lCpE7Qy4sDQDfsjPmWtIpzfK2dDZOZGpNuR1CTr89xlrpr21i
 f6dMdRjJLXJOB5hAUlDRdaLamG+Zsoz0E7yQVG+a6aK/UpmRl2FqZ5Vw7O10oRIIlKF0yA
 h3ho7Uiz9ZxQr3BXyL83zVpjnSRQFaM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-RCOdMmBONy6SjVUwxidOFw-1; Thu, 23 Apr 2026 06:57:50 -0400
X-MC-Unique: RCOdMmBONy6SjVUwxidOFw-1
X-Mimecast-MFC-AGG-ID: RCOdMmBONy6SjVUwxidOFw_1776941869
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fbb5779e8so7516517a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776941869; x=1777546669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eIb8iAvGQk4TDjBMbdfb7Iw7V4QRw3ih4nqSU+64iY=;
 b=rUhGkSzx1LZArCeab0CIXP6uaWI9DtAou7dwQmNXSnwoKm1ryPFiMTSvXaXcLn2Al3
 7NSY0iprYL81l41JNFFzJul/+f/FThHc4ZPJ5Jm8/ECw/kZseXcCbjHc5AzmFFE/7zWG
 GVPIQeGHC5BxQyhoUPqlMXIvV/Oj3k8X6P0co/CYQtYN/tePpy0gmIA9oehGUBdNhFT5
 82Skv6khmYDASda/8UWhERlC5LSEkkAxYD4R//LCJooRN/var+rAjNuliLnQIQ/2vDpf
 giT7gI6ffLAQTXWoryP+jvSoKd1gy4CsyHPXIdk0Gg3ZRq8vq6k2ZVyebu03s1Mcap0b
 H+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776941869; x=1777546669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7eIb8iAvGQk4TDjBMbdfb7Iw7V4QRw3ih4nqSU+64iY=;
 b=DBtStqIJXbp22EQmgML0KGfYdqOcJsrqrkXGnPRdgkj+pMyowLgJtiDGKcj+WjMfIL
 8DfzrgN8VxO3o9diJK4MsQmt6idJn1niCS3ZXn8/FmeeuoA3TMM25HDyqTpSI6Ay0jz/
 9WmPCebKxiLkOULR/Xr0nFStq8sw2jPq3cDJAT5mzEfXFOlVMDdYAhFw8hMfPDgag81h
 qKv5phgP2SL0MU8z84CNYk37qceHWCt0Vhx2ths3kPGuHGHruzkLf/hNWyEMPvNVqGVv
 vJzTzAJtRWMOvxaWzRjH1WzBrLob7eYm1QKlsW692j1VmU81saC/pOg1xlL0Rsb0RTNA
 z2iA==
X-Gm-Message-State: AOJu0Yy+oTvDdnbHihmmzo4C/dnfiEsUj6fV4t6SYu5SEJ/iE2iJKXHz
 GiSJeRKcOlVFQvbcPW7CBe4rTw1VDdlPHwy8nnnruuSX4Vu+U5+/7yomYZo2mp8/3GxCt4td/EZ
 PRqwxzS03xnBi6CL/VfdnEc/xTEKzLaJWZ7aZhYGSKb16uEtIrWw0SN+CT3wBwwzbooVMeyQuLA
 Vv+0p6rhVlGaJd2mBqbkyfNaRYZn8aiKAkgqY3KVA=
X-Gm-Gg: AeBDievhYeWW1huK1qTuKGYLmny2m778cWqjQ53AU5pQmKH9a9B0CR5SUFAURAxVflX
 zXuXEJM9BeDBOLhE7ylGWDoyrTvFlv45wOmQI+aBdqA0BcFXASTHyCyVuNNta6dreLQNE0MJ0JJ
 i09T7AZJs1h2YMuSnBg1FD7bb22mez2TrxGHlta0Wyr5ISZcoGrR9rXJjdX2Jh8gwWW4ms5uINO
 Vz7RGxDGAEvsD8WIOD9qYFujOaUJLtfVn/SxQsU/89AxRdqr+/XpEkXHc7MFL8STRXHfIdsyhbD
 tx3jUh4EbnX/P1L0fDqrmKeOL/A8XRd/kAGiSiwV4uGlB2H916tJ4OcXim16DTLZTYT9KH/zx9q
 CryDAgP975sxM+OJx2xMRooKxgpiWejYQo4bTy7TcMyFPSHRs6A5Yt2xNU+6D6qn2N1mj0yOuNg
 ==
X-Received: by 2002:a17:90a:da8c:b0:35e:3afb:a3ff with SMTP id
 98e67ed59e1d1-361403cbd7cmr27149010a91.3.1776941869025; 
 Thu, 23 Apr 2026 03:57:49 -0700 (PDT)
X-Received: by 2002:a17:90a:da8c:b0:35e:3afb:a3ff with SMTP id
 98e67ed59e1d1-361403cbd7cmr27148978a91.3.1776941868443; 
 Thu, 23 Apr 2026 03:57:48 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fc575bsm19835240a91.4.2026.04.23.03.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:57:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 1/2] migration/vmstate: Add VMState support for GByteArray
Date: Thu, 23 Apr 2026 16:27:32 +0530
Message-ID: <20260423105733.113046-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423105733.113046-1-armenon@redhat.com>
References: <20260423105733.113046-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index 89cb211472..b05d65d31e 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -942,3 +942,31 @@ const VMStateInfo vmstate_info_qlist = {
     .get  = get_qlist,
     .put  = put_qlist,
 };
+
+static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field)
+{
+    GByteArray *byte_array = *(GByteArray **)pv;
+    uint32_t len = qemu_get_be32(f);
+
+    g_byte_array_set_size(byte_array, len);
+    qemu_get_buffer(f, byte_array->data, len);
+    return 0;
+}
+
+static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field, JSONWriter *vmdesc)
+{
+    GByteArray *byte_array = *(GByteArray **)pv;
+
+    qemu_put_be32(f, byte_array->len);
+    qemu_put_buffer(f, byte_array->data, byte_array->len);
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


