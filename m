Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29496FF6E97
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlJ-0003w5-HG; Tue, 17 Mar 2026 19:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlH-0003vE-FL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlD-0006RR-OI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUBKuj9y3ughYvyRrD8j2p4lQRaYcWCVG4lkyAlW4Ok=;
 b=g/t6EOYQ5GRC4+r6dg0LIwP040i+Jy5X1jSPnCeQt9v2hLKXspY88U4cXH/OUnLymIXtnW
 Ej6yTEl7mAW/mViX/NIbbDbk0p3ZzBjpeUbZ41QsL0JZVIHEEdvG3Q6s/1voq+fqk0GP7P
 Y7kGGwbzTVUf6QYqe1Kb+Gx4NgS0jfo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-iz-8clSkPd6VfyhSjIwEYA-1; Tue, 17 Mar 2026 19:23:37 -0400
X-MC-Unique: iz-8clSkPd6VfyhSjIwEYA-1
X-Mimecast-MFC-AGG-ID: iz-8clSkPd6VfyhSjIwEYA_1773789817
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89c4885814dso563422326d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789817; x=1774394617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUBKuj9y3ughYvyRrD8j2p4lQRaYcWCVG4lkyAlW4Ok=;
 b=aXhAJluL05TYWWrDyuLzuVtjMHED0nGlNYe1hnGNuiuBEv9VLHg2+oRM0z/xXY8YuU
 CIiaicbtzKHZQhozCWVhxtB01eFic2F0DWY3eSg5uvDA119UvKRozsYD3q4RdBzTyEqm
 yhEezQ+Bs6KwJnDWgyARY9FMjNsV2YabRNQTh8F48IWdDsK/2eSepBT9HtcTQvf3t/t4
 vSzS5cCutam4gLbNDhfdIF50fXqrPwZA27kRokWuAia4A9W0gLOoiyzOOmxWpuS42Mad
 aCTg+vl3eBV4o6/qGxjaJe5o4chpsfStH6HsKk7wvMDY0aMargKQzk45JxStZSgFHA1x
 EOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789817; x=1774394617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xUBKuj9y3ughYvyRrD8j2p4lQRaYcWCVG4lkyAlW4Ok=;
 b=YgZkHOnW3yjXKuNed2HNJFXfi3jzuKdSzDVlqvTSLKm3GDPOVDRb0heZz+jjGNDsM/
 uxTpRb4NDJtsD023eSQEFv9J7AWTmeWnhZta21jd7F9mOie6ElMuQ6fSHTKbBuOxj3yy
 iHmvS6izwZl5ePhJhm0dej+TjCxbvMJj39ecozmbBG5mWcr04o5KL9fKqpNYPiXhxQ7P
 gFS/XPlcbcsJL1Lk5KN1qPHJrzraHgHscRQYHCL5WFkJCDCEIB73mqoYlUfc+VfKflBo
 ODzG8k1GwCvqNTfMICCLrVTZ0s4J6MZ7ujusGGQP0pwMw0mFwUwJfKu2M1qM6xFfc4pe
 qtRQ==
X-Gm-Message-State: AOJu0YzSM0b5e5WErt0rmRv05Om3CJgXM4KrClFmbcGUVx/Z+gYljI1I
 Qevw5UqJiSFUR2KjCtjNJI9BY0kfLbooN0T2EY1O0H5wnpSk24WpcKf7YmaILNNe1PIQvXR0aJv
 pPn4Q8fj8qta3PQs1rM9ZFZpI4RdHHAPUDL1zYFC5dOaOv7DEWfm+/2rO8I8ROYI+PnzTjXtY1w
 CZMAIjgsw+sNYbP0d5VqfxfiM2ax2swyuAY+TXPA==
X-Gm-Gg: ATEYQzxmlfh9SDKUB7IVb8qf9OD308VEOb5P1FO5b0yXN0tOelE3gl4GKaqTicwsh/P
 pLfVFE452HO761E1sTdbHqvzNWMk8TL/j6mNqU1al5u4DOGOFQAguoyv5qeRVIOYJGiAuqRFDMR
 yh1qmHyAKLqzUD7/Ap38bfoirpNC7++Oilz3jz9e+aBCyv06ND4AXMl8n/xQp6QJVpmA9qPlfDV
 WxfF/3l6QUTFsEf61QiAEqk3dAth0dORyvfWL7cFqDUBJvjY9FlGWQd2dL7dXtMncVZ8FJTNSwC
 R+DBk2HNcotB/ZUB2MzYDjGkDFZgy517McN7++HvsF2VhAEGwS4qnYeb2oj24jfPMCtlk2j0CYJ
 j8WmSxJ8lSi4Qrg==
X-Received: by 2002:a05:6214:c67:b0:89a:870:2ea2 with SMTP id
 6a1803df08f44-89c6b59c895mr23109676d6.48.1773789816778; 
 Tue, 17 Mar 2026 16:23:36 -0700 (PDT)
X-Received: by 2002:a05:6214:c67:b0:89a:870:2ea2 with SMTP id
 6a1803df08f44-89c6b59c895mr23109326d6.48.1773789816311; 
 Tue, 17 Mar 2026 16:23:36 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 01/10] vmstate: Pass in struct itself for
 VMSTATE_ARRAY_OF_POINTER
Date: Tue, 17 Mar 2026 19:23:23 -0400
Message-ID: <20260317232332.15209-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Passing in a pointer almost never helps.  Convert it to pass in struct for
further refactoring on VMS_ARRAY_OF_POINTER.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 6 +++---
 tests/unit/test-vmstate.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d4a39aa794..8992fba57d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -547,9 +547,9 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                        \
     .num        = (_num),                                            \
     .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
+    .size       = sizeof(_type *),                                   \
     .flags      = VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
-    .offset     = vmstate_offset_array(_state, _field, _type, _num), \
+    .offset     = vmstate_offset_array(_state, _field, _type*, _num), \
 }
 
 #define VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, _v, _vmsd, _type) { \
@@ -1093,7 +1093,7 @@ extern const VMStateInfo vmstate_info_qlist;
     VMSTATE_TIMER_PTR_V(_f, _s, 0)
 
 #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
-    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer *)
+    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer)
 
 #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
     VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index cadbab3c5e..6a42cc1a4e 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -668,7 +668,7 @@ const VMStateDescription vmsd_arpp = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
-                AR_SIZE, 0, vmstate_info_int32, int32_t*),
+                AR_SIZE, 0, vmstate_info_int32, int32_t),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.50.1


