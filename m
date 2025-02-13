Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF772C021A6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibf0-0000zS-GS; Thu, 13 Feb 2025 11:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibem-0000su-NC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibek-0005XK-D3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zMrreiA6fXml/tyoB0xwdzip2po3nTWUJjLq04bCbM=;
 b=itf1G/ncKn6Rm4YOxyg9FLIzatHiW5ZqZ98RWIl6yHodf8+KBf8wQUSZ/wfzR2OqGbUdkw
 zhWSb1KkTmzHjqlj0leIXrqaw5P67/D/AI2oL8u++6qO2kNbicRSkPbVEFpvuyKI8Q7C2w
 tZlIKBnrb+AfXZmzXbZhXxXfINTm2iI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-30kFj1oXMUaBlEa3nqhMQg-1; Thu, 13 Feb 2025 11:01:29 -0500
X-MC-Unique: 30kFj1oXMUaBlEa3nqhMQg-1
X-Mimecast-MFC-AGG-ID: 30kFj1oXMUaBlEa3nqhMQg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393535043bso6150155e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462487; x=1740067287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zMrreiA6fXml/tyoB0xwdzip2po3nTWUJjLq04bCbM=;
 b=TFN4LTrYX3Td9gK/z/EnzQ+z7ElWi1hd/hOA8cvU/7RF+voIPFWXWOAwoTifBf63ML
 yA7GZTn9kNVZzYDnWNcOToyo3lJXgOlXQVuv232BjZyF+Huo+4Msdh6dyrZCQ44MmoST
 Po1z0ZBigOyZ9sNfeW0mUaF7feMzAcoAXv1evF8mvkoqZO3rkh81G/ahOX3LUXjfj/yj
 lyUmiFIUqkLZ7PX3ZHR3wmPDZvoUgijmdxRWnvegyJ8YMMV2wPUrkre4ZImcj5hyz9ui
 bhDBvBDfwEeXbksoN6MDL7xN9P+n9afDamVDqoQOeTcxueXGbwhM40sPrb2vYdaDHgxf
 CG5Q==
X-Gm-Message-State: AOJu0YxhAcV21V3b024dLflVPpBNdAZKpmxhH1QNGRpbthJaniTs/ksJ
 leYyVrgbtnZ+8IbUUqbBTQ1jrwVKAh9EkfiPrc/uf/mloNMze6j4Id0IsybjqTFRbhxyL720/yY
 gc7B9O4ljfhmGim6l2pTDdcwdy7CY0H/49Oa1Dz70vppTrelLw1EyPMBKy5oxnbwHCjX6SB1xSy
 1pf+G8t+k065QmcWVOhjKmC3SB5/V1do5Tc7jj3Dk=
X-Gm-Gg: ASbGncvS25PBpuQYrrxPCUEnuJwFYII6u2z+n4Zg650Ni0DrzZM3FhP3wWyRn2QnnU6
 xDyWtXHZaR/V8Wg6n7V1rn/en49nz2V57ZwnPp064qb4f5G2vkvCouroRE5tUsf2YMLjRa6pWrH
 ilZw1jHH1LDdJE6W1nHwYOJEOMsS5WwJTtKMbj2ldrek6S4PhKAwmrEuAoLHelK7RjbRl7vsLM2
 sAu2tZisohiCMZwThdzg09Ht4W1/gtvGe+mjZB/2GfRTLWiXvw93DgzTFXSixe3mCb2oNVnSZeY
 HnKJjJu5hvWfjCItEQiYodWpUiJoS9URKYfRVgztS3/twQ==
X-Received: by 2002:a05:600c:1784:b0:439:5fa1:af56 with SMTP id
 5b1f17b1804b1-43960bbfd9fmr40320075e9.2.1739462486802; 
 Thu, 13 Feb 2025 08:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb22ek4gAyWo8DumBxedsHT7YsZjI5woIb02D0k81UFNRgaJD1el82dfCWNaim7qA0aZ5Gog==
X-Received: by 2002:a05:600c:1784:b0:439:5fa1:af56 with SMTP id
 5b1f17b1804b1-43960bbfd9fmr40319395e9.2.1739462486088; 
 Thu, 13 Feb 2025 08:01:26 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b83a3sm51986045e9.33.2025.02.13.08.01.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/27] rust: irq: define ObjectType for IRQState
Date: Thu, 13 Feb 2025 17:00:38 +0100
Message-ID: <20250213160054.3937012-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a small preparation in order to use an Owned<IRQState> for the argument
to sysbus_connect_irq.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/irq.rs | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 638545c3a64..835b027d5e5 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -5,11 +5,12 @@
 //! Bindings for interrupt sources
 
 use core::ptr;
-use std::{marker::PhantomData, os::raw::c_int};
+use std::{ffi::CStr, marker::PhantomData, os::raw::c_int};
 
 use crate::{
-    bindings::{qemu_set_irq, IRQState},
+    bindings::{self, qemu_set_irq},
     prelude::*,
+    qom::ObjectClass,
 };
 
 /// Interrupt sources are used by devices to pass changes to a value (typically
@@ -21,7 +22,8 @@
 /// method sends a `true` value to the sink.  If the guest has to see a
 /// different polarity, that change is performed by the board between the
 /// device and the interrupt controller.
-///
+pub type IRQState = bindings::IRQState;
+
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
 /// a function such as [`SysBusDeviceMethods::init_irq`], and
@@ -91,3 +93,10 @@ fn default() -> Self {
         }
     }
 }
+
+unsafe impl ObjectType for IRQState {
+    type Class = ObjectClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_IRQ) };
+}
+qom_isa!(IRQState: Object);
-- 
2.48.1


