Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE71C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zo-0000wU-Jr; Thu, 20 Aug 2026 12:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zn-0000uZ-SW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zm-0005mJ-5T
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxNRiJVA7E+GGf/dhgdT99BwGl1cbWrRLb+kygYE3XU=;
 b=P+aVaGyZ4VF6p35l5DQm7XFW8k8kCjzJJ1rw+ARjNNCmCQqTiWEJFMxY9PvhO4OAyOCxVp
 FWrGx3twMwA+eKra18B8yyCwZ5+1Pjv/g+h+JMzKHQ1jYe4eFFduUzMltdIckYMcdfWG7U
 ydOP5WgjKFgWNVzQAWImv/tsIDEfwFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-C78f55TIMV6qmRCZAlacaA-1; Thu, 20 Aug 2026 12:52:00 -0400
X-MC-Unique: C78f55TIMV6qmRCZAlacaA-1
X-Mimecast-MFC-AGG-ID: C78f55TIMV6qmRCZAlacaA_1787244718
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-499574e98a1so165975e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244718; x=1787849518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RxNRiJVA7E+GGf/dhgdT99BwGl1cbWrRLb+kygYE3XU=;
 b=QmPy2mcG0SL5yN9Odr9x02Ol0pbvm/duG2IA4PMuP3/vu+q6g6ZhD+XYjzVceeVJ6j
 IAu8uzMy+owLlIxTavjYNDP0vbkZutiQHv96HAz+CjyQudfWGSZ6TatwhyJAy4T8P3Q8
 CS8eqQ2y2SWymVF9+4lPYIRGDE1/e40awfDY9TddtBnFdbbPgEvKCzxXKtgNcmnxp9lC
 PuRzzN0czBXZF8TkJ6XCiDrex9sZ0QYpcnFF8fLrd67eaLN5ofbdrZWSJFvJdzdgCdY/
 N365HR8TRSmNCvqp9IuXJrR1fv35oll0QJ7GzuZdRlANgNSBipXfHhbr3JH8TPqhbtBA
 bYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244718; x=1787849518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RxNRiJVA7E+GGf/dhgdT99BwGl1cbWrRLb+kygYE3XU=;
 b=LjW9nYFuF8VAUaqqRyBlyaZwfusghB9Ew75w52uCqV81YWROFsywPCZIpFq64KKHjB
 LIT35C7NTQ3xLV59bHGjx7ObTC92zZhJKeFGEJDBg8W9e8wh/ezmW8VC8lbk1kBgwypD
 KcZHtRAyH07n6yDOj342oemjTPByde3jZOrbpGNqf9XXV7tpTfdRrd8yh4wcX+H1Fxdo
 CmgyxketkLQWy1sALh9A1EJCjijLMlB4Mr7VRnjFuoZn875DjlYxjKHB/17AOichG50h
 sS67+ydOB54o8QjyvOn0+lUAhGfx0yBw4bKbLbIQRYdIbSY1RSIXQKm0UqTMl/p9uy2x
 74Gw==
X-Gm-Message-State: AOJu0Yzg4+uMnz8mLDqiQ1Cn33O+kNmSnduT6gvHJjiVNV9TqufphKjM
 VwKDWo+Q0wdsUBcNMTmr5DLLOx9Hix7AwOp0PMUG/g6t9+tqodn9pIKZNi2spH78Rq6PqAk1DJE
 kfXQgIX3pMMNEgufNgaoaLl6KquiJobplyeR+QKWEmm76TIVq2WHsYXjWdvjvdJL3Qix2O4Z1D0
 dXM6ipnMO4t8PI05BfVD2/BuHIn+++kql7ZJWLKA12
X-Gm-Gg: AR+sD10Fj+pvPUOvBJ+lZeSBx6gbxJvLBIV5AK6bflMF2ck577uxsL6TXDBgFpvPrlN
 cGVqesNy2aEXWOLgbbdUAy/aCiJJ1dCAEfI4lz5/q6OvcCv0kLV+3+xx5JBLXOsFbtyfigKt5Sl
 fC5gk8VTW7kvMVc/Kbax+PoC8WHSk4Yw/pVbXyeyxQEyBPb2Oixso1rc+kWotlNvyPACibbIedZ
 C2IjGrft1EXWcguDFK29d1SV9wxBQQMwcOdFKeV/jleJUp0CjRvRFQ3Ws6gG0UWy7AvtW+R9PZ7
 KqMEZNBWHcAPi/Gs/h8F7F6nZCxMNuKrl6EiuPCLge6vUM8plluOZldiNhlFMUdd3UT936Oz3lP
 C7KmsgCBRRQHLfOvGOqYuCezI5vz6/Iu4s+8KoG1ZbMIISqI6bsfo+FLL5M38vbFXvnVxECjx+e
 MzXiU=
X-Received: by 2002:a05:600c:19cc:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-499b847725emr3358705e9.15.1787244718001; 
 Thu, 20 Aug 2026 09:51:58 -0700 (PDT)
X-Received: by 2002:a05:600c:19cc:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-499b847725emr3357635e9.15.1787244717536; 
 Thu, 20 Aug 2026 09:51:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e78496sm167740515e9.2.2026.08.20.09.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: [PULL 43/53] rust/bits: Use checked_ilog2() in Binary::format to
 avoid panic
Date: Thu, 20 Aug 2026 18:49:46 +0200
Message-ID: <20260820164957.1895963-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

ilog2() panics when VALID__ is 0 on empty bits. Switch to checked_ilog2()
to handle zero safely.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Link: https://lore.kernel.org/r/20260802170346.3493821-3-phind.uet@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bits/src/lib.rs | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index 60b63f969dc..5769bc761ac 100644
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
2.55.0


