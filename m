Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90428E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN295-0007MX-D0; Sun, 15 Dec 2024 22:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN294-0007Lt-87
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:46 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN292-00060r-Pt
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:46 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb7e725aa0so1762471b6e.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321103; x=1734925903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQ8DmbEliR36Gw9tzToNMCsxXQSyqG0+BCSp50GnSP8=;
 b=hIWlae6xZoB2uA8InVyLjMKmQJfXzQhny6urf95sneeUQP1Pa6BmS5Bc49kyrSAwy8
 xrxW1le3NDYE1S0kh6Md3i7PMt75MmFy64Dc32TgTMsDZkuLyQD5u8e3WQGfG/0Xr1Lf
 nAe2UMeAC0VebwdizhmSPZwF8N+ELobvUr/PWFjEoQYcbIV0GYjpjvEDa0QZDug+uSzb
 kzOA4+PM7tnQwTWvgDeTvFrI6XnM+2SdMuwjmEiFCW26LkAr/nCa3N6pIVSy4AzZuPK5
 iHJ+woL+Z0SI/8RYmZElc6OeHsPqUmQCerDxCDhDf8LB1OJU10xMNnOe7CvlXzJBuJeA
 aCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321103; x=1734925903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQ8DmbEliR36Gw9tzToNMCsxXQSyqG0+BCSp50GnSP8=;
 b=pudVfF1kyATGgR82dALma4255upwuUDNKiNpC0ublQabu9QorrFv2Kg3nVHpiDsEYK
 LFbIrbQgVJ4quDLU4qSpwxEaLXlJihlrr7QfiZa4dzPOsUwwvGBl20N+0mNe0CtJSpvO
 A42dv1rkfXj5LWmPR/Zzo73q1uF1eFrC3E6TcaU/qI28b33veP/kCDIk6RoAg10og73+
 JIwUBalGp8/czZ5wk5hylrVFVEBoTX0R35VLdwKSOMcS8VzV/FBnQHRIp7arbwedIscP
 E0k/yphvZq+gakay65bMzS2VNIn6bgxEYQ8I5hE4HsKBBHwL4vC+dTQ6oiLEWGhl9Vwn
 H4Qw==
X-Gm-Message-State: AOJu0YyOGTo1BdFhCIeF8DIHHJUA/uqnZVwa8oLdeyYHqy849vfD4KdQ
 eO5Uy3pK0YhpRpuEiON2lz10WGRVFOccAfb0AMte/xW+O04zf8veufi+F7B/QhISoamGgeEw7yR
 5PJrNIm4b
X-Gm-Gg: ASbGncs9ZjsZzJ5nuupWqkHpZZhD+NF4LUfqds++sTzvEBugd32kkM9daqWjPV0Zoqo
 MX1Yuj/19p7gHby2Uh+Xh2i+0zrIUNOuUWa+TI1MDUx5AT84DA1txgSHs4VkLcXBisyfIk0pZUa
 bBAbImGkrPa31PD8qzUgDTaGo9pvwyDb24zgPBuleBu8BYa55+LyQgw06TnS4/RKJUQSR8ySCm+
 VN/5eQy4O3LsGKbkDHxkDFNuDuEn9HosRM/FOZd9GaunY+E4AsraAMI6jKrmXwnGmf7KYdvH0+l
 ie/sKoGsBRiURcc1/gHML+CovaEsdHVajMr97rTJSx4=
X-Google-Smtp-Source: AGHT+IHOtWQ7btirqjH1OislPe5s72vDzrqnrAM6Pe7Fyp67u/vGiNyvYw4bE90FQvyey6z8L0FPfQ==
X-Received: by 2002:a05:6808:4488:b0:3eb:7399:29d3 with SMTP id
 5614622812f47-3eba6955c77mr6097287b6e.43.1734321103632; 
 Sun, 15 Dec 2024 19:51:43 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 17/24] rust/qemu-api: Use device_class_set_props_n
Date: Sun, 15 Dec 2024 21:51:02 -0600
Message-ID: <20241216035109.3486070-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

Cc: qemu-rust@nongnu.org
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


