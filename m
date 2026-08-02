Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2494BC55162
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 17:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqZbj-0006U8-Nq; Sun, 02 Aug 2026 13:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1wqZbh-0006Tg-Kl
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 13:04:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1wqZbg-0003RL-4H
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 13:04:13 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1894137a91.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785690251; x=1786295051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJNYg3gDw8yzjUzuXDYu3JnAfxkmY+unI72WmZ+GOvg=;
 b=rR/UE/PsXw0740dN7HvaDbYKyOssSJDJVJb3TIbry6GTB50imwlY7ngjw8zjZLUA9A
 zOcikUzRDwTsKdsn90q+u8YP9hXIXANTkMrV+jlAKl8BqXexHjM4Uv8ATXg9YG9WbCGA
 9GWP9bEa5mjfneWoDf2XnzaI6hzTqxM1KR8umhiFWgLhxBmAM7lmKSSGxBrehFV9c/hI
 TKpJsmGgGl7ViVl++yj26af3q7zwfVI4+7n84iNq2IA3K0GxAKBLLsxfwuW+md5YlBqb
 Ge6l6GugPykc82tEXt/CAtliDhycQzfPzMJWjFF394m9rNayIK4y8uyP0Ea0+qpp/QZL
 N7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785690251; x=1786295051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IJNYg3gDw8yzjUzuXDYu3JnAfxkmY+unI72WmZ+GOvg=;
 b=R7QV4L7pwxcNdPOoL4WaK2SOMZD9S8ZyGJQwNOvompEwolkrAGA7iUGuDicC7iBwpQ
 PaZVpupQBUEBs/T3dSQH/wRfTUxCXtQJW7nT0RAkiqsd9xS4+p0TWvZl8iz21ZZPgKYq
 SlrzFzJ+cXH0U+JIxIvKfgASRi6aaGnRNDLpr3tpuBllQ84iBDI0S/xbCK3X6hwKBI4Q
 evOSHQ5UE8RvO55vL2atrkINJ6c4ZUN97tKSjhJzASBMYcPkQEnj23b8/K6b/LidXwMh
 QBg2K+lDmJXX69+Atk+JiaCb5mfpj38BKDvO64pYi2Y+1AI2RapdtQyk9KppWp0RmQ07
 Ub0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLe0yGpW7X0LDzlyRWy0pKJS9c6PHVaHZDNNKqfRPYDJ70tySEeondEECO/Hq7scN6Eyb1Hay4ZyO1@nongnu.org
X-Gm-Message-State: AOJu0YwuKQjJx2GOKte7juNKOgG621rLuRZ96qJr95S6y9FxeFVs89gM
 +kmZr6ttXJnNv7mgg85OzoIV5VNNCdyEVi6Ir7jbD41l8Jo6l0U7LSAN
X-Gm-Gg: AR+sD13+2HixGlgAnsMsoYgdbf5+kNqQi+KYR7e3HhnEbWEkanu7yzvkllPSbvqOKBA
 ZVpGQJROgnozGjC6pLYpUE1UKxWSY0YY4CMC0Rpk+XvTnPv2AFSQ6nRH+SRNN2xAM9Xult5CXR6
 FQZ0PPaVX028QIxqiaz1l6lCcFqbReIZz8jdjEqG0ZrEQu0yVkWK8rCnaDpqsV9o7qA/G/J7ByJ
 UYfsQGB4iccF3Ty2Q7RHfzuNroPgijLj6k0f7Ofrg+HSIzcRgjP14toqXbaWDn43xNLBjdqJBP4
 s7NkT9GN8t8ydzlFCyB7VSoWUc3DMTxqRDKiePFLDh0vVARVj7zcb/wrNwUf9BKe6JAx01Jeccs
 EQIS8cAL0WdYNS+yzuctwqj+Fb1HIrMeqqnxclvSGPi8BwV/Gl3hJp5DLZ6qe21mQWd+JeQ2b0d
 ZSBKbLAYfFyLBBR5tud02TDa0nVnaqt+LqzPUAUOqpBolR4FeOgWwUmx3GEQS5sA==
X-Received: by 2002:a17:90b:2251:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-38fbc438274mr6902033a91.13.1785690250799; 
 Sun, 02 Aug 2026 10:04:10 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm22982126c88.2.2026.08.02.10.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 10:04:10 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: [PATCH 2/2] rust/bits: Use checked_ilog2() in Binary::format to avoid
 panic
Date: Mon,  3 Aug 2026 01:03:45 +0800
Message-ID: <20260802170346.3493821-3-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802170346.3493821-1-phind.uet@gmail.com>
References: <20260802170346.3493821-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=phind.uet@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

ilog2() panics when VALID__ is 0 on empty bits. Switch to checked_ilog2()
to handle zero safely.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 rust/bits/src/lib.rs | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index 60b63f969d..5769bc761a 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -215,7 +215,9 @@ pub const fn invert(self) -> Self {
         impl ::std::fmt::Binary for $struct_name {
             fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
                 // If no width, use the highest valid bit
-                let width = f.width().unwrap_or((Self::VALID__.ilog2() + 1) as usize);
+                let width = f
+                    .width()
+                    .unwrap_or(Self::VALID__.checked_ilog2().map_or(1, |bit| (bit + 1) as usize));
                 write!(f, "{:0>width$.precision$b}", self.0,
                        width = width,
                        precision = f.precision().unwrap_or(width))
@@ -412,6 +414,12 @@ pub struct InterruptMask(u32) {
         }
     }
 
+    bits! {
+        pub struct EmptyMask(u32) {
+            NONE = 0,
+        }
+    }
+
     #[test]
     pub fn test_not() {
         assert_eq!(
@@ -450,4 +458,9 @@ pub fn test_sub_assign() {
         op1 -= InterruptMask::RI;
         assert_eq!(op1, InterruptMask::E - InterruptMask::RI);
     }
+
+    #[test]
+    pub fn test_bit_display_empty() {
+        assert_eq!(format!("{:b}", EmptyMask::NONE), "0");
+    }
 }
-- 
2.53.0


