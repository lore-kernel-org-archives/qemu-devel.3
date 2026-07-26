Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC868C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pu-0007kK-V2; Sun, 26 Jul 2026 17:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Ps-0007dS-RH
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pr-0004JQ-1e
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmjxM0bW5yUwJzCUC3NFASMiWkpMePhE/nKwj2PfAqI=;
 b=exn8JsPHcATvERY1yXnturuWIXuZ5wlJO9BL77ECTvcipzMuvLfo+T08RUZM2Jnc9WCFcn
 xjtZfhZrqlKDwNf5tpM34SzAENP9lgYjw0VoI4c5xW3+NJEpqdXKF00sU4dFf53tJ9Yhht
 WbRv0EqWF56018gtVa4AvsJ+KkIizGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-fw2VPmSrN3eChuEqMJ7m6w-1; Sun, 26 Jul 2026 17:29:45 -0400
X-MC-Unique: fw2VPmSrN3eChuEqMJ7m6w-1
X-Mimecast-MFC-AGG-ID: fw2VPmSrN3eChuEqMJ7m6w_1785101384
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954fe32d6eso9966945e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101384; x=1785706184; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jmjxM0bW5yUwJzCUC3NFASMiWkpMePhE/nKwj2PfAqI=;
 b=jecV200CtTUWWLKApYl213qaOahNmnUSseh+MgdXNuvFq0c1FWE7Ia2RFgV/j4cphL
 3ZPX2v7Zjtul303NJ21TzSe/LwhuNwYYjXvgKEpC+oFeFjBhsFjS/TETrXc8ukyB+4DL
 Vll5JXwbAEaYiE02Ld+piloY4HeGFwgM68DB0jcRB5OPJBjvjf9Ud2YYg3N3c+FM7EPD
 THCfSuNPwH8EGeKJ2BxKz64hD2d0pZR0zX1XKeXnFXoRL6W5MdQ5E7pKqv9ZRXAwcdBF
 L5TMokCtk8IVU7Ptzs/239lBts3SMfBnh5ERohtc7CwWIyYExWiYxFt7MPPBi5sXSCGd
 orRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101384; x=1785706184;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jmjxM0bW5yUwJzCUC3NFASMiWkpMePhE/nKwj2PfAqI=;
 b=cIEH2SdgBPlNxtQ2NkS5W6xKeM2aybrdGWmoLFa2+N+04Dj2SF0bGf0bckfB6JRQNc
 XOa6HtQ81/Qta6Nr4S4A/dKCSZ8GTU7zOHuf4QrbiAndUVgc5ggjKG04D1JJecX/cRaZ
 AGj8aXmZCd1aV0hDq8AXoHZifMc0643mXgxJ12DMbw5IMJ4v3TAcmMhx0o4AlG4xcvBK
 qODrwtWxLBkHllllaroVX+p43w+uUH2hEffByZviH0lt9UBFIfSviJkNpf4bCjKzc32G
 rak6wAm71Y6UIfujQMGw5wA2pcHfFEDWWguIZp0sN2VfSrpf8gd5vb0uWvtieR4wzJJb
 MuEg==
X-Gm-Message-State: AOJu0YxuAmO5oMvTtGpICHlgiyYaNGc3lo+DqhKYzM6sUUKa/tJl1J5Z
 NLb6YjN0rU/sn7rCFF+d9fD6HpVwzKVuZMudTcqsKk41JvuZ7g3ShngzW0lWIi9zwWFAxYl3ppA
 /3+wFD1uh7KGS5AEM405x3Y43dv9+GnLcfFPUKhf8AdV+0W/AbNK3RtcorffQentN/7HEQKobwy
 Zl7zBPU/BUrSxmQFbCrcnUb6oUeVksUs6r8w==
X-Gm-Gg: AR+sD12O534b3jeJaod5jAsXR7AWHx1s4ChjtrkdubC5NgQ8r+2iUclhpW/lM2Y7o7p
 MFnaCHt6GYjm+qGCN2evXggf/hF8vEQ4Qh1dl+MJN1sRhlctcQhI4b6F9i+O0NbiAouk8oQD0L4
 j/YywlZgBpvxTokCjn4JV7VNdiMGJbwrUbiCu8vIcehlRfiiqPJyB3PoyRnSSteG1bnylnqQvD0
 YclZlVthqog7qM8YMZ1BpqXJT7C9O6QgpknI1UxblVEhIzfVeK+2CU+7p8aSWmZun/DnakI8mZN
 qTt/MdutYEwPleNJDK32J8M0Cm2oYUcZwmFrDmGqpxXeMe018MUnea8Y9IXuef1eJwEEmhREoBW
 86YwEP9R2vvUYQoNH7y404w==
X-Received: by 2002:a05:600c:1f92:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-496b56f97e7mr86283475e9.15.1785101383793; 
 Sun, 26 Jul 2026 14:29:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1f92:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-496b56f97e7mr86283205e9.15.1785101383212; 
 Sun, 26 Jul 2026 14:29:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9ae5c3sm259277215e9.3.2026.07.26.14.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:42 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 17/30] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
Message-ID: <9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

vhost user currently saves the inflight buffer to the migration stream
using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
backend.

But the implementation of that is broken if size is >2G: it stores the
buffer size in a uint64_t field, but vmstate_size() always reads the
size field as int32_t regardless of the macro used. This, in turn,
causes negative or truncated lengths on load, leading to undersized
allocations and down the road out-of-bounds buffer access.

There's no practical reason to support such large sizes, so it's enough
to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
reject negative or oversized values, and propagate errors to
vmstate_load_vmsd().

Note: the large value is coming from the backend, not guest, so this
shouldn't be considered a security issue. The CVE was assigned before
the qemu security policy was updated to exclude this class of bugs.

Fixes: CVE-2026-6426
Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
---
 include/migration/vmstate.h |  5 ++++-
 migration/vmstate.c         | 31 ++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1b7f295417..e7095cd977 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -168,6 +168,9 @@ enum VMStateFlags {
      */
     VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
 
+    /* Use a uint64_t size field for VMS_VBUFFER instead of int32_t. */
+    VMS_VBUFFER_UINT64              = 0x40000,
+
     /* Marker for end of list */
     VMS_END                         = 0x20000,
 };
@@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .field_exists = (_test),                                         \
     .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
     .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
+    .flags        = VMS_VBUFFER | VMS_VBUFFER_UINT64 | VMS_POINTER,  \
     .offset       = offsetof(_state, _field),                        \
 }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 50ebe37845..d7f03a9f5b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const VMStateField *field)
     int size;
 
     if (field->flags & VMS_VBUFFER) {
-        size = *(int32_t *)(opaque + field->size_offset);
-        if (field->flags & VMS_MULTIPLY) {
-            size *= field->size;
+        uint64_t usize64;
+
+        if (field->flags & VMS_VBUFFER_UINT64) {
+            usize64 = *(uint64_t *)(opaque + field->size_offset);
+        } else {
+            int32_t ssize32 = *(int32_t *)(opaque + field->size_offset);
+            if (ssize32 < 0) {
+                return -1;
+            }
+            usize64 = ssize32;
         }
+        if (field->flags & VMS_MULTIPLY) {
+            usize64 *= field->size;
+        }
+        if (usize64 > INT_MAX) {
+            return -1;
+        }
+        size = usize64;
     } else if (field->flags & VMS_ARRAY_OF_POINTER) {
         /*
          * For an array of pointer, the each element is always size of a
@@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
+            if (size < 0) {
+                error_setg(errp, "VMState field '%s': invalid size",
+                           field->name);
+                return false;
+            }
 
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
@@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             bool use_dynamic_array =
                 field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
 
+            if (size < 0) {
+                error_setg(errp, "VMState field '%s': invalid size",
+                           field->name);
+                ok = false;
+                goto out;
+            }
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
-- 
MST


