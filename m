Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5954BC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiEE-0001wE-KH; Fri, 17 Jan 2025 04:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiEA-0001uN-JO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiE8-000856-Bw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eYY5eNnWTT8Na4EOEM5TaLYcFyvLxA//Me2yYZ88AI=;
 b=HRrvef+cE9sNb2blJEeEZrdIxTTLn/Nhtnkt4dX1U22hSOyVIHmDyNrRCKU0VcKTIgVd8K
 El+B1iyM1H2/y4nZl9WO26vAgPLStqml+HNTke+PM+oKwnLSNEg5i091a0z7zFd7TrKUr2
 Duk+bmnDDMrJ+2vSQXO7UKXslFpRayo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-JgS_0ldWMlmOdZkpj9afgw-1; Fri, 17 Jan 2025 04:01:10 -0500
X-MC-Unique: JgS_0ldWMlmOdZkpj9afgw-1
X-Mimecast-MFC-AGG-ID: JgS_0ldWMlmOdZkpj9afgw
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa680e17f6dso141356366b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104469; x=1737709269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eYY5eNnWTT8Na4EOEM5TaLYcFyvLxA//Me2yYZ88AI=;
 b=No1AMMjXaEsbmZXs0A0btGYg6121cLCjLrvasuCF6vIkwU3czl0jSPTRlig2SNrwIF
 dggyfNRGbuQKFnkRhwl3PqorjLUlnlTP61iqW9jG1aMn4WuQOMs9L6c62ftfswi86OYa
 iQpammT0NaCNOmouMYUJNV6xxQGoA4ZRBGRxbdlAotJ48CAHRsz/7ZMKbWBIr+J/kBWP
 Prxz+mVZ2F9WtOiu/Q6+qrDYHAm31yrdOWk+yLIWXbWQDKS/xssFmshnWQBQISAAPGUS
 fcu+CjlJq6NHPujcpjiMfaNgnRKopYfUurdGYuIZJ980+u0OFfD6cU+9Nd9vTEIbZA1v
 9NHg==
X-Gm-Message-State: AOJu0Yy8Y5aDvNNlISQEkI1YjqNBXunbNOLU9w5TSX0XTa/7IcrwEiBz
 /uKk1Ti3PIYYiH7xan3NWrwGVj6T4CMfSnrA7NYUAQB/IR3wvV2QOdoHHvX2Hn1FcPo1PFtr+tW
 UWzb/idOLaonwBsufZ56zyhxYld3zSEigdKDjNC1ckbl8KWhnbuyAFFUl1ksZtSmodykr3Yu9h7
 kOgc+ZIhZPZsbG0+SdLAMsX0clN5Dd9Yl4iFjJ+10=
X-Gm-Gg: ASbGnctGQNEG9S4hV7Pkg9QQQBfWa/DMcqpzgmg9eFcMHCNQ8lEdvXkWqBDufXeNmND
 1k/T3oehLCVx8GJ1T9eZwtt/Fhdjc76HYxclOCjeDkluMNTpLtVKiQEMSTibfq4gqdPSvqad+Yu
 2Wulfv+NAvaZP+y04BboPYhY1MQv0H4Ya/b5ISLOVn3YhSHfgw4nLArePvRX0CMNvM5aUylVCaV
 s4X7AyipkLnhFWuXWfOnljEcQexQtwxYgdUT5snlclmZh7j47CuXPyXh8+H
X-Received: by 2002:a05:6402:518d:b0:5d0:ed92:cdf6 with SMTP id
 4fb4d7f45d1cf-5db7d30114amr3798742a12.19.1737104468683; 
 Fri, 17 Jan 2025 01:01:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSTfN0PC8UGWM2PPeDtDBZUuiUqq+gLt/lv4Iz/gcM/WQEzHZWsLe/ftmEPpF/FM3io9g/Qw==
X-Received: by 2002:a05:6402:518d:b0:5d0:ed92:cdf6 with SMTP id
 4fb4d7f45d1cf-5db7d30114amr3798684a12.19.1737104468117; 
 Fri, 17 Jan 2025 01:01:08 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8d86esm135654166b.154.2025.01.17.01.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:01:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 07/10] rust: qemu_api: add vmstate_struct
Date: Fri, 17 Jan 2025 10:00:43 +0100
Message-ID: <20250117090046.1045010-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117090046.1045010-1-pbonzini@redhat.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

It is not type safe, but it's the best that can be done without
const_refs_static.  It can also be used with BqlCell and BqlRefCell.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 8f32c72a0fd..94a2a29fe7e 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -628,6 +628,39 @@ macro_rules! vmstate_array_of_pointer_to_struct {
     }};
 }
 
+// FIXME: including the `vmsd` field in a `const` is not possible without
+// the const_refs_static feature (stabilized in Rust 1.83.0).  Without it,
+// it is not possible to use VMS_STRUCT in a transparent manner using
+// `vmstate_of!`.  While VMSTATE_CLOCK can at least try to be type-safe,
+// VMSTATE_STRUCT includes $type only for documentation purposes; it
+// is checked against $field_name and $struct_name, but not against $vmsd
+// which is what really would matter.
+#[doc(alias = "VMSTATE_STRUCT")]
+#[macro_export]
+macro_rules! vmstate_struct {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), "\0")
+                .as_bytes()
+                .as_ptr() as *const ::std::os::raw::c_char,
+            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            offset: {
+                $crate::assert_field_type!($struct_name, $field_name, $type);
+                $crate::offset_of!($struct_name, $field_name)
+            },
+            size: ::core::mem::size_of::<$type>(),
+            flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
+            vmsd: unsafe { $vmsd },
+            ..$crate::zeroable::Zeroable::ZERO $(
+                .with_varray_flag($crate::call_func_with_field!(
+                    $crate::vmstate::vmstate_varray_flag,
+                    $struct_name,
+                    $num))
+               $(.with_varray_multiply($factor))?)?
+        }
+    };
+}
+
 #[doc(alias = "VMSTATE_CLOCK_V")]
 #[macro_export]
 macro_rules! vmstate_clock_v {
-- 
2.47.1


