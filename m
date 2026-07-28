Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6155AC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooye-0004U2-8P; Tue, 28 Jul 2026 17:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyX-0004TT-Gw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyS-0003hO-Hm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785272666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoCKTGTB00eE5rGMysylu8v8Cd44pkfWk8gVfgTvXSU=;
 b=WbowbVJScI+uMbG7Tt41fVWThFLSnzmnqGL6Cr5jIMZOAXnSj+VrgaVW7lZvZhg4k8hSEj
 4aRS8ODn0bok2kXYxEtheXm80p9SaFXKmC6voLyHj/mw0GkVZjDUosU/0neK7QUII2vR6F
 D5LtCPkqocolzEp1h5qzKvxFyZBsYvk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-ZPMnFipfOFGCbWunkRPqPA-1; Tue, 28 Jul 2026 17:04:25 -0400
X-MC-Unique: ZPMnFipfOFGCbWunkRPqPA-1
X-Mimecast-MFC-AGG-ID: ZPMnFipfOFGCbWunkRPqPA_1785272665
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e7ee64b25so53757985a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785272665; x=1785877465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VoCKTGTB00eE5rGMysylu8v8Cd44pkfWk8gVfgTvXSU=;
 b=FCVtdnhHteNYiQ9yzcf/4HNulTGjUgl6d8qMV5ept9eekEz8NSxhPXIB+FkQFff9nB
 GbfNj2FTcj7w//SAiWeTYNfPyQ2vVlpQpGoH/bObu/mITCL2r1zeDecqJ96iq8GhDnZK
 qlpLey7Quw2K0CwJ5w3Yg5SnEYmGdzfInCEC6q0X5xjcxl5Dxtpvqa97qR6XIUFuVQ4b
 WwxJSuptbHZi/sl0hsUs/0BeuLqNbNqTmJgQsYBlm81Xvq7rkLaPVbhHCMvH2vZPFzlU
 PguFoozSVzQz0lWtAXMuewBeT/2Ds/H5PyMr0fLzQYbcp4vdG5zx3PwVvZ/ujke1jHdr
 lvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785272665; x=1785877465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VoCKTGTB00eE5rGMysylu8v8Cd44pkfWk8gVfgTvXSU=;
 b=FeL8YybcmFJiMUCq1WmAIfP7amS7L4jvjRHPSrgyBM5nAqYipfD+59zYmR62Oqr8TC
 pINRsG8M+k8ri3BI5STofQKb7fphT00QLWpc1swl4s2NYjp3aCUtJO7XFgw/qNqfv38v
 S/2p9j2gByw2F+wkLrkKm0t0bTSV5WQ/eOowRPZnNNnCf2SpSb2sHyD7Kk3EtZSuytGw
 sW5A6lZYTrVvNS9iv038SFC/Maupz+TXy3x7DJfOyYLsjSuTRVgvOcc0XjWl5o/1N5/1
 gB+gPBmI9pQnXU1xPzVyTIm+SCnFbF6HSRlC/xJpiA+uW0vKOXg7D2oI5H2y7a+6TTIj
 uCdQ==
X-Gm-Message-State: AOJu0YxM8qu/brHc/HyirH7tdYdzwK9J4A/mOq4pdNxRDKlPM4Sc0gJx
 l7IlqvCUHBexcqnwGgy/+LvzcWR8UsC1uqLw5mMESgt6StD4aOoeEC0kBaDKG6vqtH4+2pLmnmg
 okKgru8spFWDF825/ohHuNlawe1O7zzv77W+z6jwMEjps1v6Jy6efq4A/EOHcOerYRXkVi1e/S4
 AW66PTNJyrIY9aXgIf58Nt9VSgmILQm6h6mmc44Q==
X-Gm-Gg: AR+sD13rhgtihgNE9NWEIh9s8Ur3Ch/jaFdpQvtzF6IgaxuYp3ij9Wp7RSsXlkc7tzh
 UMle8YectncsjDDsLhWDbZNVfgAS7EAAPAF8WpZkMNHn6ziav0H6s2KrB+LoRWp1C9w/QyGlVSE
 iA6C2fFsOaPUcYX9K3HEk4uTwZjMMjFsDMUou4hDvSviytKdVA/g+Ovl1ymxzUFWYMhXGLs2dKB
 bq5R7qycWFjoN+Re4a6h2ouRolINI+3zhd71bPk3qlA4Y5VeInhHQI9XK4kCxtOm7jKfatLmPvM
 fa7sgmJJ6LWtq1uvaXGTRFqQKdN4f6Ctr+fMwY+nEA36hJOs8gt6L8LR/+c6PkC7L7dCj8PkawX
 MmH+vo7ipFnmijqQwwZ3Qwpsg/TgQfN+MwbgC6XX78vuW4mXFPidmril/
X-Received: by 2002:a05:620a:2789:b0:930:a3f9:93b0 with SMTP id
 af79cd13be357-93302afd4cfmr461978085a.86.1785272664812; 
 Tue, 28 Jul 2026 14:04:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2789:b0:930:a3f9:93b0 with SMTP id
 af79cd13be357-93302afd4cfmr461972685a.86.1785272664123; 
 Tue, 28 Jul 2026 14:04:24 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3227707sm21277985a.6.2026.07.28.14.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:04:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Feifan Qian <bea1e@proton.me>,
 qemu-stable <qemu-stable@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/5] migration: Fix possible overflow in
 vmstate_handle_alloc()
Date: Tue, 28 Jul 2026 17:04:13 -0400
Message-ID: <20260728210417.1925078-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728210417.1925078-1-peterx@redhat.com>
References: <20260728210417.1925078-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Migration incoming side almost always trusted the stream data and allows
allocation to happen with whatever size received.  With it, malicious
migration stream can manipulate destination QEMU behavior on g_malloc(), in
path of vmstate_handle_alloc() on specific VMSD fields.  Fix it by limiting
all sizes with int32_t positive values (INT_MAX) explicitly.

We have quite a few bug reports recently leveraging this defect. It can be
reproduced in many ways for (I think) all archs binaries, but the simplest
reproducer is:

  $ hexdump -C ./vm.img
  00000000  51 45 56 4d 00 00 00 03  07 80 00 00 00 00 00 00  |QEVM............|

  $ ./qemu-system-x86_64 -incoming file:./vm.img
  VNC server running on ::1:5900
  qemu-system-x86_64: GLib: ../glib/gmem.c:106: failed to allocate 18446744071562067968 bytes
  Aborted                    (core dumped) ./qemu-system-x86_64 -incoming file:./vm.img

We could assert here, but since we have errp right above the stack this
patch routes the errp over to allow destination QEMU fail gracefully.  This
means there's no way to DoS coredumpctl as well because we don't generate
core dumps at all. The output message could also hopefully help triage
issues when it's not a malicious stream but only wrong image used.

When at this, making sure multiplex also won't overflow.

After patched:

  $ ./qemu-system-x86_64 -incoming file:./vm.img
  VNC server running on ::1:5900
  qemu-system-x86_64: load of migration failed: Invalid argument: vmstate_size: VMState field 'name' overflow

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3805
Reported-by: Feifan Qian <bea1e@proton.me>
Reported-by: dong ling (@dongling226655)
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 91 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 50ebe37845..7bf0c2bae5 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -78,9 +78,10 @@ vmsd_init_ptr_marker_field(VMStateField *fake, const VMStateField *field)
     };
 }
 
-static int vmstate_n_elems(void *opaque, const VMStateField *field)
+static int32_t vmstate_n_elems(void *opaque, const VMStateField *field,
+                               Error **errp)
 {
-    int n_elems = 1;
+    int32_t n_elems = 1;
 
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
@@ -94,18 +95,35 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
         n_elems = *(uint8_t *)(opaque + field->num_offset);
     }
 
+    if (n_elems < 0) {
+        error_setg(errp, "%s: VMState field '%s' num_offset overflow",
+                   __func__, field->name);
+        return -EINVAL;
+    }
+
     trace_vmstate_n_elems(field->name, n_elems);
+
     return n_elems;
 }
 
-static int vmstate_size(void *opaque, const VMStateField *field)
+static int32_t vmstate_size(void *opaque, const VMStateField *field,
+                            Error **errp)
 {
-    int size;
+    int32_t size;
 
     if (field->flags & VMS_VBUFFER) {
+        /* For both int32_t/uint32_t we only allow 2GB limit for VBUFFER */
         size = *(int32_t *)(opaque + field->size_offset);
+
+        /* Check this explicitly for untrusted length input first */
+        if (size < 0) {
+            goto overflow;
+        }
+
         if (field->flags & VMS_MULTIPLY) {
-            size *= field->size;
+            if (smul32_overflow(field->size, size, &size)) {
+                goto overflow;
+            }
         }
     } else if (field->flags & VMS_ARRAY_OF_POINTER) {
         /*
@@ -115,21 +133,45 @@ static int vmstate_size(void *opaque, const VMStateField *field)
         size = sizeof(void *);
     } else {
         size = field->size;
+        assert(size >= 0);
     }
 
     return size;
+
+overflow:
+    error_setg(errp, "%s: VMState field '%s' overflow",
+               __func__, field->name);
+    return -EINVAL;
 }
 
-static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
-                                 void *opaque)
+static bool vmstate_handle_alloc(void *ptr, const VMStateField *field,
+                                 void *opaque, Error **errp)
 {
     if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
-        gsize size = vmstate_size(opaque, field);
-        size *= vmstate_n_elems(opaque, field);
+        int32_t size, n;
+
+        size = vmstate_size(opaque, field, errp);
+        if (size < 0) {
+            return false;
+        }
+
+        n = vmstate_n_elems(opaque, field, errp);
+        if (n < 0) {
+            return false;
+        }
+
+        if (smul32_overflow(size, n, &size)) {
+            error_setg(errp, "%s: VMState field '%s' multiply overflow",
+                       __func__, field->name);
+            return false;
+        }
+
         if (size) {
             *(void **)ptr = g_malloc(size);
         }
     }
+
+    return true;
 }
 
 static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
@@ -335,10 +377,22 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
 
         if (exists) {
             void *first_elem = opaque + field->offset;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
+            int i, n_elems = vmstate_n_elems(opaque, field, errp);
+            int size;
+
+            if (n_elems < 0) {
+                return false;
+            }
+
+            size = vmstate_size(opaque, field, errp);
+            if (size < 0) {
+                return false;
+            }
+
+            if (!vmstate_handle_alloc(first_elem, field, opaque, errp)) {
+                return false;
+            }
 
-            vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
@@ -650,8 +704,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
     while (field->name) {
         if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
             void *first_elem = opaque + field->offset;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
+            int i, n_elems = vmstate_n_elems(opaque, field, errp);
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
             /*
@@ -660,6 +713,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
              */
             bool use_dynamic_array =
                 field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
+            int32_t size;
+
+            if (n_elems < 0) {
+                return false;
+            }
+
+            size = vmstate_size(opaque, field, errp);
+            if (size < 0) {
+                return false;
+            }
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
-- 
2.54.0


