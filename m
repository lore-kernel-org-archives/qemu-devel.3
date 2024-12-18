Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BAAE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLO-0002aF-OW; Wed, 18 Dec 2024 08:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKf-0001NF-0R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:25 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKc-0005hO-Ce
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:20 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ebb669df2eso336230b6e.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529397; x=1735134197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub08HVX45BPcHxWhYRhQRxpr3H7LZw9OUR4p1/1w0V8=;
 b=aeHjGcRQ8UmLvHLhMTNyaZKTxugBTm8/dhskHisjIXdmFcovryndxeCuhJ5A6X4yru
 YecDkdCYTXrzZubBf8BR3SeyXxh9uktx0S+wMcog+GmXfu3BVjLR4UOgvB+HL6ydQYEv
 DazU+oEGLk2i1OE9fsWfSW2vm+LxC00lka9RnID7ID+ubs96byA3fK03ry4e4WgrdKrF
 ZZleAOHsVo2jmRzRygukiDhLLjXeaSPh3dsy5aQNoHbqyO3ndrUt5ha4noCbShGg/yOd
 X7LXS5uum3ElhZHvZfbyVl3gwDhfQOW+dUMFLY/MlUs/qk8ZaBBU4af03P09ZysuL4s3
 M/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529397; x=1735134197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub08HVX45BPcHxWhYRhQRxpr3H7LZw9OUR4p1/1w0V8=;
 b=JX6eKSrwzV3AFqeaEg4OKmIllRjXD0NEwRFlzh1ixtvOqmlxghHZqZ9Y7CjrBVKGvC
 5Ou10N9k3iwSqYHx8oFnlk+iMma/TOj4rRh5l7ZgornX9db37tDpkcGAKtDjeHdOOL4c
 G9BbufjQZZyp0Fz3qWywsMhY0n2sXO/yIrzjjHWeQNzWhlSVSz4GRibnngK+6DwX0a6o
 oIZQV4VSXz3+Jq6wuhCLJaBZQmIg4Y49pdnuTd9KQajs57oa0xg2WYnDrZ9jx21b3l/c
 sr8/P2PVBRiQKbweWMW/7e2Eeo+bs4UVFNxkg/qEfYvGHdPo8WNiPt0k9RJwnIl0kLwA
 HOJA==
X-Gm-Message-State: AOJu0YyEUKgGlOuvhDipf+v6q7ITBWRQ+VtOIkie/3zfmPnP/9JoPcwc
 9aHmzoUGl++OnW2/ISI/bjTbQnzlMDbiAMlrl+p8voC+CuLtzO/rBjdbPVIwIfhTr+gH4V1O7I3
 Mmpgh7EQt
X-Gm-Gg: ASbGnct+wuERGEGXBEqpEe4OY+EUtOEoUO8IZsmDUnPP8wtOCl7iD3maVhyaltjA3MK
 mgTnGKag/69FKCk+N9sPH/YN0aldl2OQgcV5t0s//xX9odqK8eEZZW2tEupijv+HHd0nORBs0gA
 I/QPH3f1j+VdfslsmSuc1hKesmp5ddTdZzmb9MQXy1imZYBYNQ3Pg2XQ2kHL41KBFpAPqZJaKr/
 TeSWi+UX6Cw6ayMJidW/jqa6oJaT7xxLEzWYUgYXKVsa9p3uaa8JiIts0pi69jV
X-Google-Smtp-Source: AGHT+IGofGh6snlqxq10wUz77IzrU1jPA1UwWlQ4Lg+TdHboXjn8kLolfPZfx3NYxs/lvzJ/hke57Q==
X-Received: by 2002:a05:6808:4494:b0:3eb:52e6:1b3e with SMTP id
 5614622812f47-3eccd001d55mr1577443b6e.1.1734529397129; 
 Wed, 18 Dec 2024 05:43:17 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 17/24] rust/qemu-api: Use device_class_set_props_n
Date: Wed, 18 Dec 2024 07:42:44 -0600
Message-ID: <20241218134251.4724-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This means we can update declare_properties to drop the
zero terminator at the end of the array as well.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 rust/qemu-api/src/device_class.rs | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 03d03feee8..cca51fe1a9 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -7,7 +7,6 @@
 use crate::{
     bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
     prelude::*,
-    zeroable::Zeroable,
 };
 
 /// Trait providing the contents of [`DeviceClass`].
@@ -31,7 +30,7 @@ pub trait DeviceImpl {
     /// device.  Not a `const` because referencing statics in constants
     /// is unstable until Rust 1.83.0.
     fn properties() -> &'static [Property] {
-        &[Zeroable::ZERO; 1]
+        &[]
     }
 
     /// A `VMStateDescription` providing the migration format for the device
@@ -87,7 +86,10 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             dc.vmsd = vmsd;
         }
-        bindings::device_class_set_props(dc, <T as DeviceImpl>::properties().as_ptr());
+        let prop = <T as DeviceImpl>::properties();
+        if prop.len() != 0 {
+            bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
+        }
     }
 }
 
@@ -134,7 +136,7 @@ macro_rules! define_property {
 macro_rules! declare_properties {
     ($ident:ident, $($prop:expr),*$(,)*) => {
         pub static $ident: [$crate::bindings::Property; {
-            let mut len = 1;
+            let mut len = 0;
             $({
                 _ = stringify!($prop);
                 len += 1;
@@ -142,7 +144,6 @@ macro_rules! declare_properties {
             len
         }] = [
             $($prop),*,
-            $crate::zeroable::Zeroable::ZERO,
         ];
     };
 }
-- 
2.43.0


