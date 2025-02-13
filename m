Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDE2C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibeu-0000xf-W2; Thu, 13 Feb 2025 11:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiber-0000wX-It
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibep-0005ZW-VW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iw0/AYRBwPsktKL9Xh//wvj/8ASNqeRu9rzaypgjUY=;
 b=EJ5xrA0xS8EogMElYHF5sREooP5ln+I3wx5t3UHbRC9hIXUxVzCdZ8kqkmJ84nsTZk/Wkn
 4B8vdsvMciWQpj9yS89EwMtFKhO/0LeoBaoHifp3zX/qoPb4nJAVUDfXft2KpwsRGIYc4V
 fw7saj7TfPkQQULUdYe8/3syiYbWSQ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-RyL3zWVEN4eNHjGr66Nt-A-1; Thu, 13 Feb 2025 11:01:41 -0500
X-MC-Unique: RyL3zWVEN4eNHjGr66Nt-A-1
X-Mimecast-MFC-AGG-ID: RyL3zWVEN4eNHjGr66Nt-A_1739462500
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so5890815e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462499; x=1740067299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iw0/AYRBwPsktKL9Xh//wvj/8ASNqeRu9rzaypgjUY=;
 b=HijHu3CWJaJXJpyr3sP9rgtLfjifzvUe9vaRikAokJWNAa+vuPPaj93AOWGPF9aSND
 7L7PFPSPrjo63Bz3vBZO9qx2b/xhbPIa52ry2O+HX2d5C1J9gg7m7Z0eKxVKxiVcwtN8
 N2prIkuYhJvfjItbTjA7ibImWbtct/oaAiT+qB/Xlj7kUswA+YSHWuV71tn3yJE6ZJCQ
 PCBPK2xBlcTaloLsRmiFDzOzmmKCC0YS86azgBsQmup4kxffh7Kjur01GQxZcd6JhOx/
 ZmLhno2DQGLYus9jVAnSK31KxhrmycYXxZfWTRjIOxghZVv1twTk7/FcSCHtuR0y4TXl
 LRkA==
X-Gm-Message-State: AOJu0YzDQxXB9MEFBfnDT5cD7xHlXPP1YIkvPQ9xACk77M6BiUeBMC8i
 5vXMR+0m8v4s0sP6UqATk2AE7QgeFf8YpL/uWrqfiqRMKjCx532KiUXfiYkdnaG0KG/idpYNGXF
 ttq3i5ZxWbNC8cv/2hoBkkRIJTb6u/vcG/W6WpENbdmhI/oTCTp8vNL3QqLWh+AC0BxRzTiX/N2
 IoKihyBDeg83DRn8bSFcI9uZYaWZ9Ce7bwZNR31bU=
X-Gm-Gg: ASbGncvt2bbHHJ4SdA6WwvUU0JKgIedhVDb1I5u+wvraFEvC/l8ULlmVSi/NreBvuyv
 uMlW3RJsl0OR9tUI6bVZq3iMBa8ip/dIZFFjItqTozip2pKK9iNRKGe1x/11sB0xe4MAjiMA2FX
 49900pvrtsJCUD0d0GxI7mA3Qag0P2intFJd7QjC//MhvQr0RmlMOajerK/jeCgVqF5sakUDXZx
 B1ccnAEdFe97FW4DMjJ/pa4GNbyvYSh6N7MI8tFyWBMDMhPE1hGehRNvL1SSSKXA7IPmYPplS+m
 KgqwAUwi2GXpsnWB3sf0RZXyxmOOExAxGGxojJdTvjsICg==
X-Received: by 2002:a05:600c:a4a:b0:439:57b5:f8a0 with SMTP id
 5b1f17b1804b1-439601ab838mr46795955e9.24.1739462499065; 
 Thu, 13 Feb 2025 08:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvGzqzxxPcE5zcFqijbmOw3CsFbgwzv0DTWm3ckR5l3JzPJTy4VDMg7p4dX1e8bkrzGBrqGA==
X-Received: by 2002:a05:600c:a4a:b0:439:57b5:f8a0 with SMTP id
 5b1f17b1804b1-439601ab838mr46793975e9.24.1739462496944; 
 Thu, 13 Feb 2025 08:01:36 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617fc885sm21272335e9.9.2025.02.13.08.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/27] rust/qdev: add the macro to define bit property
Date: Thu, 13 Feb 2025 17:00:42 +0100
Message-ID: <20250213160054.3937012-16-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

HPET device (Rust device) needs to define the bit type property.

Add a variant of define_property macro to define bit type property.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 73343e10b96..c44a22876b9 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -168,6 +168,18 @@ fn class_init(dc: &mut DeviceClass) {
 
 #[macro_export]
 macro_rules! define_property {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, bit = $bitnr:expr, default = $defval:expr$(,)*) => {
+        $crate::bindings::Property {
+            // use associated function syntax for type checking
+            name: ::std::ffi::CStr::as_ptr($name),
+            info: $prop,
+            offset: $crate::offset_of!($state, $field) as isize,
+            bitnr: $bitnr,
+            set_default: true,
+            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
+            ..$crate::zeroable::Zeroable::ZERO
+        }
+    };
     ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-- 
2.48.1


