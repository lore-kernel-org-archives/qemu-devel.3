Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5043FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6W4l-0002PB-64; Wed, 08 Oct 2025 11:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6W4i-0002P3-4T
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6W4Z-00067u-SN
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759937233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lPTPz7XtOk86T3MaOEJikScfofStaNctO3EOk3cjOVY=;
 b=Ikpv04KFcmQpAsO8dNTZMvraeJQIvz5RfUIUrvQsmM4HZ06nmTPs44vWMabfusaWcMAa3e
 tDAaWvsZloUeVAMa9DM+HwXkOsFAV+lSzdTP+S/Q6vS1G71xKKplA8S1EFr4jV6yzmCOCY
 hrU3Sytq2YlTMurFXD5cYBqddnVWeJs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-EGZpufmUMMOSfFD5HOmdrw-1; Wed, 08 Oct 2025 11:27:05 -0400
X-MC-Unique: EGZpufmUMMOSfFD5HOmdrw-1
X-Mimecast-MFC-AGG-ID: EGZpufmUMMOSfFD5HOmdrw_1759937225
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-632c9a9ceb1so8420500a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 08:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937224; x=1760542024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lPTPz7XtOk86T3MaOEJikScfofStaNctO3EOk3cjOVY=;
 b=ZjEvv8IsHnFYmOQ7LKVLSh+Xd7iXAcRULDuKUg9LBXreG2z4U+aaL4GFJ+4v9cZ36z
 vAVz8H6KGcgWKpvNIP+oaftTawOMqikdyu8P8qd6KBqJ1XNPaaIzBsYscmsoSIT8msM1
 AO57XBbhzH+ys3syedx84WvRhfSLCC33Rp2x30NZvDeAeddvfXhwR6JSpceu/uq+8+g5
 RDjdW+wWw57CjnbFpzMV7x+mumENmFNMPJxD1m6DIna0qnoTZk+Nx0KopU/GJupBbu7f
 L7+QHw8DMcaHHOQasagaLcwLiP6+RQ5RCknqE4rG7FgACbxleM6oPp25WR9Da9yE4d2N
 IZUA==
X-Gm-Message-State: AOJu0YxtsdOUlHCgRQNGUnNHh2LpZVlTIMlQMDkbMxLQmO8f/SyL6fqk
 6h9ufH0qKh8+NtpF0OMZl56BZpLFAnx2nUOVcXnVmGv5KbUmsURMmV/C1tPI5niyyiJwdZvxSCo
 LrF2MODyarYuXTquwydlA10spBMeNBbgU+v+4w40jpcqOy9EsA1TB/ibWHP2EYVfepMrE6wuOge
 ehziQSLoG42+/tU2vt5i4Knz+tAhRdwDyPGi1UlXu4k2o=
X-Gm-Gg: ASbGnctwaHQ8BS/yifVfjv/vItauruDMdXKh88CbTtqZyZneTSPQ1JZXlVCa3x4WjCq
 23ylyVWZ3YxPi9eMXCYlhr3C9mqXuLBNGmDpBFGqbw6W5o6UwIoWen43fAnHdu6LnXLlr4nePA3
 FzZBy1FSM3TjrH6HbhemK9+cSTVLPJnPv7V8PfjUFbgH1S6ihXuGed9yI8vPovY4SlWRZpjO5Qo
 EA7V/MpGnXz7FAFjruFyLRjIXBTgROX9fC19Pi2LEW3vJ6ehtE9zih4px9711Ck/hE4gI9q/nRD
 mTP5vh3mI2dkr+0NgO2YFZAZ67PL3S3Embn7MzyeNcW4fN8U/xe6hFho6bvoNfi6/3m+NMF5Nkn
 iwK4z7DsipYCtUTKqsO+MsHFxNZaDpUIMmV2gLHoJgovlEXIc
X-Received: by 2002:a05:6402:b22:b0:634:4d7a:4d94 with SMTP id
 4fb4d7f45d1cf-639d5c75dcamr2714935a12.34.1759937223918; 
 Wed, 08 Oct 2025 08:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZWbmRNzJDZFJBTlkb3g22EZWO2wvnt+H2x2GjLXJX43DMgIPEGk5IRF6SUiPapVKnpQucGw==
X-Received: by 2002:a05:6402:b22:b0:634:4d7a:4d94 with SMTP id
 4fb4d7f45d1cf-639d5c75dcamr2714913a12.34.1759937223559; 
 Wed, 08 Oct 2025 08:27:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-639f30ad2f3sm220122a12.9.2025.10.08.08.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:27:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] qobject: make refcount atomic
Date: Wed,  8 Oct 2025 17:27:01 +0200
Message-ID: <20251008152701.411964-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Rust bindings for QObject will only operate on complete objects,
treating them as immutable as long as the Rust QObject is live.

With that constraint, it is trivial for Rust code to treat QObjects as
thread-safe; all that's needed is to make reference count operations
atomic.  Do the same when the C code adds or removes references, since
we don't really know what the Rust code is up to; of course C code will
have to agree with not making changes to the QObjects after they've
been passed to Rust code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/qobject.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qobject/qobject.h b/include/qobject/qobject.h
index a6244d0ce00..02f4c6a6eb2 100644
--- a/include/qobject/qobject.h
+++ b/include/qobject/qobject.h
@@ -32,6 +32,7 @@
 #ifndef QOBJECT_H
 #define QOBJECT_H
 
+#include "qemu/atomic.h"
 #include "qapi/qapi-builtin-types.h"
 
 /* Not for use outside include/qobject/ */
@@ -73,7 +74,7 @@ QEMU_BUILD_BUG_MSG(QTYPE__MAX != 7,
 static inline void qobject_ref_impl(QObject *obj)
 {
     if (obj) {
-        obj->base.refcnt++;
+        qatomic_inc(&obj->base.refcnt);
     }
 }
 
@@ -95,7 +96,7 @@ void qobject_destroy(QObject *obj);
 static inline void qobject_unref_impl(QObject *obj)
 {
     assert(!obj || obj->base.refcnt);
-    if (obj && --obj->base.refcnt == 0) {
+    if (obj && qatomic_fetch_dec(&obj->base.refcnt) == 1) {
         qobject_destroy(obj);
     }
 }
-- 
2.51.0


