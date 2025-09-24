Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F5CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lp4-0005LX-KL; Wed, 24 Sep 2025 05:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lp1-0005JC-Mp
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lot-0004pj-0y
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIHJDm7aNxFUbTsEnGeRE1qG811mxITS7dOJUdDzhCI=;
 b=Cw+uy1P6DeLeyV2sy8tlfpDv+Oz3aoIoRIbxOeUtCfBt//gqDCSu4FxkwUaYIubou13Z22
 RPlCfFLwl0pZ+6icmbkaChlBICmtHCfzfW8Ovvfz8VQQSWTLHbQkllQFihWQMvGJNvNQrZ
 F3C0q8KlQ+A2NWqzJljQos+or42Aug4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-gOnjK2UxOay9E7HwvAUFFg-1; Wed, 24 Sep 2025 05:29:48 -0400
X-MC-Unique: gOnjK2UxOay9E7HwvAUFFg-1
X-Mimecast-MFC-AGG-ID: gOnjK2UxOay9E7HwvAUFFg_1758706187
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b2d604db3easo267300566b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706186; x=1759310986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIHJDm7aNxFUbTsEnGeRE1qG811mxITS7dOJUdDzhCI=;
 b=YV3QZXWcuTYR8iLZH+oR375DRTX+3C3asR10ATqBeCq2V1+ZtioiImyNIi3dzTMGpz
 2Sxg0nY+meGxqCXJQJ/LPFp6M+hrP2IgLFE7UTYdGkVk9Wx+x342nJLl8+jn9xJdpnwG
 GRVWfSjp4W227uqDbSETCDbcjOjUYDSLuOwsqdNn/6lN+qkssBl5ZiCl5iYIqSRYMk32
 5MP+WI1PxzLtMcPDMtxscJN4epTIEXx+MGbhjiuOyqlRLgy5rcvAZcacptp/86MPkwX6
 FxGtLJQY//L7iNCwG2xtblJoHmnlYkR8+QlAzj0jqWMH07/yWWjjw1hlavXF8eDDw0NR
 lJ/w==
X-Gm-Message-State: AOJu0YwVe3KLwO9mLfQ19RrNLZdz8qSjiBZs6W900Go6BhWblyJpd87i
 yaae01Rhh165tE6BoobBnKVDItzus0mB6qDE/freiK0cnZI/5sgIpjGMKWTirBbgqMpIB8bDjEE
 yDeVdp37ofWh9SpGUPc7c1pWnFveDcXasNgGW6EMQLWGLWPIEsq7CAsvOceXjTTXEYINjZHryzb
 yYeIcQ5jqIBP6upoMnkz7yxVAn1nrkiJw0MBj3dZK/
X-Gm-Gg: ASbGncvfDXB/tX0m2YVSMvCtMUV2i3krr+cV9EWsuJeuNsNgELI7TlZaNsT8aTgMyLW
 imGjgbBDvjvXH5bVhjXrAus5UI3rCY88zzuzr3KTtVRrGmnBJcxxhysQAoha/pmuwaPVo5ZuKF1
 tJCLmz6jJfwS8ERIxJSlc14bBGI8OUKqy4oA0UIF5ON7YRK01G7kwvgsLHTXd1sHnNfFBybMrjW
 +HPUmRMNTtnDiLys5h0o+heVulcGOss5uNXUVF5yzI6WsiExQRzNN7y1FxFZHNRnrBBRX+iEolU
 nliP0JKF+58IwZZwjlyxX70iYsvP8It9qnqi5uZuHor6hw4LrlbaPCwA/Qb3c8A1vYDAuga2liE
 nAc+lJBELsffphstCy2+cOyD9kaq5ExKDeUsMtk5Hk4vFwA==
X-Received: by 2002:a17:907:7f9f:b0:b2f:963:1d2f with SMTP id
 a640c23a62f3a-b302b2245c1mr588086266b.51.1758706186319; 
 Wed, 24 Sep 2025 02:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmoP3C/NHDS4xRr4gqAP8qX1UBKgqfm2XW05R9uIlJdS1Od78xbxBKY9m2d+9zBVQP43lM7A==
X-Received: by 2002:a17:907:7f9f:b0:b2f:963:1d2f with SMTP id
 a640c23a62f3a-b302b2245c1mr588084166b.51.1758706185893; 
 Wed, 24 Sep 2025 02:29:45 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2a2a5f6cb9sm834859966b.36.2025.09.24.02.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 18/29] rust/qdev: Drop declare_properties & define_property
 macros
Date: Wed, 24 Sep 2025 11:28:38 +0200
Message-ID: <20250924092850.42047-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

After HPET's #property conversion, there's no use case for
declare_properties & define_property. So get rid of them for now.

In future, if there's something that #property really cannot resolve,
they can be brought back.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-13-zhao1.liu@intel.com
---
 rust/hw/core/src/qdev.rs | 53 ----------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 9c82e1716c5..a4493dbf011 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -248,59 +248,6 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
     }
 }
 
-#[macro_export]
-macro_rules! define_property {
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, bit = $bitnr:expr, default = $defval:expr$(,)*) => {
-        $crate::bindings::Property {
-            // use associated function syntax for type checking
-            name: ::std::ffi::CStr::as_ptr($name),
-            info: $prop,
-            offset: ::std::mem::offset_of!($state, $field) as isize,
-            bitnr: $bitnr,
-            set_default: true,
-            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
-        $crate::bindings::Property {
-            // use associated function syntax for type checking
-            name: ::std::ffi::CStr::as_ptr($name),
-            info: $prop,
-            offset: ::std::mem::offset_of!($state, $field) as isize,
-            set_default: true,
-            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty$(,)*) => {
-        $crate::bindings::Property {
-            // use associated function syntax for type checking
-            name: ::std::ffi::CStr::as_ptr($name),
-            info: $prop,
-            offset: ::std::mem::offset_of!($state, $field) as isize,
-            set_default: false,
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-}
-
-#[macro_export]
-macro_rules! declare_properties {
-    ($ident:ident, $($prop:expr),*$(,)*) => {
-        pub static $ident: [$crate::bindings::Property; {
-            let mut len = 0;
-            $({
-                _ = stringify!($prop);
-                len += 1;
-            })*
-            len
-        }] = [
-            $($prop),*,
-        ];
-    };
-}
-
 unsafe impl ObjectType for DeviceState {
     type Class = DeviceClass;
     const TYPE_NAME: &'static CStr =
-- 
2.51.0


