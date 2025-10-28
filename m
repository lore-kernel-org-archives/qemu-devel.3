Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB08CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbA-00068V-Ja; Tue, 28 Oct 2025 13:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnb7-00064L-9n
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnaz-0004Qs-E9
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NElcIQeJ5eQxKaGBT+BiWqWbXgYojExHiTsQPrKnKAQ=;
 b=Cyy1xc4ULGopxmnnP/AyS+MLAjWfUz1ND+ZNF7PkeFyclZMHlOQq/a+LB48vLeYfqh88rS
 +hpUgv9/Wc4Ji0tMoD7fx0JpXwjPUSVWWS4UIbGD1ab74wO3lAPqOG2T8iECY+eAyeY+em
 NRBJNsIQuk1E2kdg0nkHYfLYRjAS1js=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-hRHUGZNsPE2L96eX0v9elg-1; Tue, 28 Oct 2025 13:34:52 -0400
X-MC-Unique: hRHUGZNsPE2L96eX0v9elg-1
X-Mimecast-MFC-AGG-ID: hRHUGZNsPE2L96eX0v9elg_1761672891
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso65478f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672890; x=1762277690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NElcIQeJ5eQxKaGBT+BiWqWbXgYojExHiTsQPrKnKAQ=;
 b=rBp/PjXL9QzuYI5ptM4ccWBH0XRMb6XFf9FwkLq4J/NSiEDrw7cZDDZNPn0vXaqFqb
 qHA3DUrVbOmLrllgM0H1SFmupvvHZjxPy2R5a8ebpJicHi7nSAjktUw5KQH8ameABSmp
 p49+0qdaGDprguPpssP1+41z5NTsW6ZfM0/QuzyMC2Md3xB0xHrK0eVu2BLEGMJ5UgkH
 yRgDU4ZKdRaCmn2Y4KapoF15Qksph/ZhK65yh4XFTuuMKkTCXPcPSQwn7nHS6GQJzU15
 PMop+GE03znM22dBbyRnGJJPfwJx7OLHt1vYXAZQYS3YRljgoF6polDTkJU2of0iEZAa
 5VtQ==
X-Gm-Message-State: AOJu0YwyFTQ7Skgrfc++WravrcUiyP3mNIVDHSR9zmwGsCYaXDPYBED2
 bHYf+20Rf6afR4WrvnAJZAwSsi26TfwD1tAOM2LcTI0KDqri87pRFSf+GTUCDR2i1s0xsZKI8Cv
 iiKI8ZVmn867EMwELRtqF8/5pW4/n1UMU7ojp2S0hTwypnOcK0NlA+1CNOxTgkMSIgXnSG4fH5s
 zIQn8nnhzjt8QhXsxNw5wgOUZZ5kG8MXOVuYM2LDjt
X-Gm-Gg: ASbGncu71JtP4VRwQxveY+1Ujtaidp4tpPJXRc/2sCSGTjXDkpFo1+qQ01LGc5AthLg
 QGwPwMVJ6tMbUwRa6Pox0YrsfFiTB1rP/cNy2O6IE0hokullL9apjQttOExq+FXNZ+kMTiWHrOe
 zJ1dhOJ12bB9V0ojIZNAOWVyZ3F1knQRPumGk4nZ8vDk+lZOmepXNlDhThN8UH6DRlBrtP4Pb8p
 YgvJjuLGvsnk1Ul06BSHQq4wsRp9CnAzpfK/XHnjVIsnYAFJ1+3t1elCqmAVs5wNezKdcD9Q8eJ
 FEyFBhaMUvSLSzdWdKJfq4Zh6CfFgYlxtsYR4N1TJR3f2ZnZ31zL3lTZuWcQp3+Bu8B49JdmBIj
 UJ/7K5JCdI8IdHAo6pZwSq8fgNuzLYZTMKA7ckYcVp7Dj/9nVfOGFqWr6H4vXr583xb7D900G8u
 tKEvE=
X-Received: by 2002:a05:6000:2406:b0:426:fff3:5d04 with SMTP id
 ffacd0b85a97d-429aeb096c7mr57137f8f.25.1761672889706; 
 Tue, 28 Oct 2025 10:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDvxyN2FmjtaH4wxf7vQe8VuIresEoGbVTD1Jii10kP9uLdyOf5v4gsKzvC2aZnyfHCY6m/A==
X-Received: by 2002:a05:6000:2406:b0:426:fff3:5d04 with SMTP id
 ffacd0b85a97d-429aeb096c7mr57104f8f.25.1761672889244; 
 Tue, 28 Oct 2025 10:34:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df473sm21503944f8f.42.2025.10.28.10.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/18] qobject: make refcount atomic
Date: Tue, 28 Oct 2025 18:34:18 +0100
Message-ID: <20251028173430.2180057-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
2.51.1


