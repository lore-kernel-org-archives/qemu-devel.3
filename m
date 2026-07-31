Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A843C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppds-0007np-Qv; Fri, 31 Jul 2026 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wppdq-0007mg-UI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wppdp-0005uN-39
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785513558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z96UI2D0MnuiTDZYPb7vgLMGWAvNRYOxdHCL+rlAqJ4=;
 b=QevUa0Rez00T19YsVTFaWSsrPmU8mH8tZUkvTAiMjcct3wYmuJX64kLmkbE9WNmhyI4gZW
 SgzqD/5+IeE3yzeFuXC5Lqs51SKq6rF1DtCEdrHnIwYDy5iJnre3HuinWXgTEu2ylJhQYn
 xdwnb68aQapxjGxx/Io5b5TDZlZ+MpQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-TNq1xvcoN0eQJwjrAUrnrA-1; Fri, 31 Jul 2026 11:59:16 -0400
X-MC-Unique: TNq1xvcoN0eQJwjrAUrnrA-1
X-Mimecast-MFC-AGG-ID: TNq1xvcoN0eQJwjrAUrnrA_1785513556
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97762b21ba3so884919241.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785513556; x=1786118356; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z96UI2D0MnuiTDZYPb7vgLMGWAvNRYOxdHCL+rlAqJ4=;
 b=FOiMzn1zp1wAYrCvMKWdFQoJNb7f23/mm8BnS29ez+tJxiIgM9xdwEN3KweYGUyehW
 UWrDOSM1H/WK2tbg3TCuQTRQeeaDdDbD2bdNHg0hTcgtRLk3Z/+ltfeaCHGp1cjnGZIP
 FVe4cx5601+CeOvDiLz8ubCULkinx/a2k11N6AQriuPbGeTlFxkoymiDkyvGzmM4Ddzd
 pAwaiEGNCZ0XtUfSxk8LPZ9mo5UkxxLiEP5E+yu2jUhqi3fkI2v2Y4WWGVEQfpH4pZqJ
 zHJlML0ZdbsG0Pygjz8U0P8CnxTQKPYxD2c2mg4Wtj2ca/W/XQzJmfNVv91dW/tFILX4
 kbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785513556; x=1786118356;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z96UI2D0MnuiTDZYPb7vgLMGWAvNRYOxdHCL+rlAqJ4=;
 b=ZUmJH6SrGV2K4NclBj8SYvEd/BGsb5vhWHGH7TcidHZnUeLaItz42n3ugBJq5EQD2/
 nQw3LEhm44vrpX4K9jvK58B8Xvf6StWZ6h7X2/pdRf0+5Q888oCNooafawXjz3NRih82
 KqApR1I0BWbFRwEp7/33PqBxFgsqenuT2sRNlXG3kOMpKHLhX/PEDwLXQuop0ZJ2Y3o8
 4Cstz729t4pt4sICO4foWruEZR0QJc6qnKPUq1/v3+4La/YE2hbkUMlJ4UAxa6MoG+zT
 E2Hdk80Zoqi7FdaXNY3mQArtelAQUtNQD6jkl5+NXCpIss2aawLtnuJWSlnC28/xkmJO
 T2Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYBz8BwbFaaW0hFroYl06hpf33Ja5j2hrYjyX8L9/eLq7jibKhE5RaTkKJgiXJ9id/0GQAcajaYvk5@nongnu.org
X-Gm-Message-State: AOJu0YzLuHndKApzSUA0ch+ZuhCRFaY7Jq1IdRrV5/95ir+0WwkvjKlg
 POFBXGwccFWtr/yQhDx9RvyZFFRrS7/nLA9/5gkECLQw4bqtmAGfq1dojxmGA9HK7VjxvLpRakD
 r4QHtgiM/Pji7dR368nwAh8I8ohIGNmf3nA2UIbp8VdR6YnenBXEG0oIn
X-Gm-Gg: AR+sD10sfuWWrciHSrIvlGVhkDDIOqiBhpGooBUta6m2hqEkalnRGzE1tOT2lwNjaAv
 QldGLYBG3rhvWIfDiBEQ8NdInGuJFMIhfmHtTGjz8274uS6KXtHyqdSmvqlJ/PPzYpMTC5eQwxi
 kDyY91vVIWCppHJYyBtB/4mN7pR+Ku5UKmwQemluOR2A1DE9LChIjBdhmXFZXL7qa/Gu/A8MNv4
 yjMEHkFJcwMWeKvgwT/DrPusyQzlddl5PPaqBBLZhIrESKwjuJuH29+dSSb2e8TkTkrIFCCezb7
 ccfukN/b7HOIQsp8Nb2R7z9Cm5BplzN3spFcjyCCbSLkF4yMEAL6Z0dQNUNYUyrhZfYo
X-Received: by 2002:a05:6102:fa5:b0:74a:b492:3a62 with SMTP id
 ada2fe7eead31-75b21e6b74emr639184137.4.1785513555892; 
 Fri, 31 Jul 2026 08:59:15 -0700 (PDT)
X-Received: by 2002:a05:6102:fa5:b0:74a:b492:3a62 with SMTP id
 ada2fe7eead31-75b21e6b74emr639155137.4.1785513555325; 
 Fri, 31 Jul 2026 08:59:15 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-759c9051f94sm818495137.9.2026.07.31.08.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:59:14 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:59:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH 2/4] migration: Introduce VMStateOffset
Message-ID: <amzGTh3DXvX9ovJQ@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-3-farosas@suse.de>
 <3166925a-0456-42b6-80d3-8154e3e66825@yandex-team.ru>
 <87o6fnmf4c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6fnmf4c.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Jul 31, 2026 at 11:02:27AM -0300, Fabiano Rosas wrote:
> Hi Vladimir, I've been looking at this, could you clarify which vmstates
> do you think we could merge? I don't see it, either VARRAY vs. VBUFFER
> or VARRAY vs. BUFFER, also ARRAY vs. BUFFER doesn't seem to work.
> 
> One main point of difference is the size_offset/num_offset variants are
> only known at load-time, so we can't convert them between each other at
> build time because the either the total size or num will not be know.

Something like this?

NOTE: I hid a fix to a comment that is irrelevant.. which I mentioned @size
and @size_offset can't co-exist, but it can when VMS_MULTIPLY is set.  I
had a vague feeling we can further clean vmstate flags.

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 24631fd678..3a02709650 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -69,17 +69,15 @@ enum VMStateFlags {
      * }). Dereference the pointer before using it as basis for
      * further pointer arithmetic (see e.g. VMS_ARRAY). Does not
      * affect the meaning of VMStateField.num_offset or
-     * VMStateField.size_offset; see VMS_VARRAY and VMS_VBUFFER for
-     * those.
+     * VMStateField.size_offset; see VMS_VARRAY for those.
      */
     VMS_POINTER          = 0x002,
 
     /* The field is an array of fixed size. VMStateField.num contains
      * the number of entries in the array. The size of each entry is
      * given by VMStateField.size and / or opaque +
-     * VMStateField.size_offset; see VMS_VBUFFER and
-     * VMS_MULTIPLY. Each array entry will be processed individually
-     * (VMStateField.info.get()/put() if VMS_STRUCT is not set,
+     * VMStateField.size_offset. Each array entry will be processed
+     * individually (VMStateField.info.get()/put() if VMS_STRUCT is not set,
      * recursion into VMStateField.vmsd if VMS_STRUCT is set). May not
      * be combined with VMS_VARRAY.
      */
@@ -108,18 +106,10 @@ enum VMStateFlags {
      */
     VMS_ARRAY_OF_POINTER = 0x040,
 
-    /* The size of the individual entries (a single array entry if
-     * VMS_ARRAY or VMS_VARRAY are set, or the field itself if
-     * neither is set) is variable (i.e. not known at compile-time),
-     * but the same for all entries. Use the int32_t at opaque +
-     * VMStateField.size_offset (subject to VMS_MULTIPLY) to determine
-     * the size of each (and every) entry. */
-    VMS_VBUFFER          = 0x100,
-
     /* Multiply the entry size given by the int32_t at opaque +
-     * VMStateField.size_offset (see VMS_VBUFFER description) with
-     * VMStateField.size to determine the number of bytes to be
-     * allocated. Only valid in combination with VMS_VBUFFER. */
+     * VMStateField.size_offset with VMStateField.size to determine the
+     * number of bytes to be allocated.
+     */
     VMS_MULTIPLY         = 0x200,
 
     /* Fail loading the serialised VM state if this field is missing
@@ -181,8 +171,8 @@ struct VMStateField {
 
     /*
      * @size or @size_offset specifies the size of the element embeded in
-     * the field.  Only one of them should be present never both.  When
-     * @size_offset is used together with VMS_VBUFFER, it means the size is
+     * the field.  Only one of them should be present never both, except
+     * VMS_MULTIPLY.  When @size_offset is used, it means the size is
      * dynamic calculated instead of a constant.
      *
      * When the field is an array of any type, this stores the size of one
@@ -696,7 +686,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .size_offset  = vmstate_field_offset(_state, _field_size),       \
     .size         = (_multiply),                                      \
     .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_MULTIPLY,            \
+    .flags        = VMS_VARRAY|VMS_POINTER|VMS_MULTIPLY,              \
     .offset       = offsetof(_state, _field),                        \
 }
 
@@ -706,7 +696,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .field_exists = (_test),                                         \
     .size_offset  = vmstate_field_offset(_state, _field_size),       \
     .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
+    .flags        = VMS_VARRAY|VMS_POINTER,                          \
     .offset       = offsetof(_state, _field),                        \
 }
 
@@ -720,7 +710,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .field_exists = (_test),                                         \
     .size_offset  = vmstate_field_offset(_state, _field_size),       \
     .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_ALLOC,               \
+    .flags        = VMS_VARRAY|VMS_POINTER|VMS_ALLOC,                \
     .offset       = offsetof(_state, _field),                        \
 }
 
@@ -798,7 +788,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .version_id   = (_version),                                      \
     .size_offset  = vmstate_field_offset(_state, _field_size),       \
     .info         = &vmstate_info_bitmap,                            \
-    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
+    .flags        = VMS_VARRAY|VMS_POINTER,                          \
     .offset       = offsetof(_state, _field),                        \
 }
 
@@ -1200,9 +1190,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_BUFFER_START_MIDDLE(_f, _s, _start) \
     VMSTATE_BUFFER_START_MIDDLE_V(_f, _s, _start, 0)
 
-#define VMSTATE_PARTIAL_VBUFFER(_f, _s, _size)                        \
-    VMSTATE_VBUFFER(_f, _s, 0, NULL, _size)
-
 #define VMSTATE_PARTIAL_VBUFFER_UINT32(_f, _s, _size)                        \
     VMSTATE_VBUFFER_UINT32(_f, _s, 0, NULL, _size)
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index bc8eb3d3ca..f7363a8776 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -102,7 +102,7 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
 
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
-    } else if (field->flags & VMS_VARRAY) {
+    } else if (field->num_offset.size) {
         n_elems = vmstate_read_from_offset(opaque, &field->num_offset);
     }
 
@@ -114,17 +114,17 @@ static uint64_t vmstate_size(void *opaque, const VMStateField *field)
 {
     uint64_t size;
 
-    if (field->flags & VMS_VBUFFER) {
-        size = vmstate_read_from_offset(opaque, &field->size_offset);
-        if (field->flags & VMS_MULTIPLY) {
-            size *= field->size;
-        }
-    } else if (field->flags & VMS_ARRAY_OF_POINTER) {
+    if (field->flags & VMS_ARRAY_OF_POINTER) {
         /*
          * For an array of pointer, the each element is always size of a
          * host pointer.
          */
         size = sizeof(void *);
+    } else if (field->size_offset.size) {
+        size = vmstate_read_from_offset(opaque, &field->size_offset);
+        if (field->flags & VMS_MULTIPLY) {
+            size *= field->size;
+        }
     } else {
         size = field->size;
     }
-- 
2.54.0

-- 
Peter Xu


