Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2048C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zn-0000tN-Ep; Thu, 20 Aug 2026 12:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zl-0000kH-75
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zj-0005m5-HM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grbbqIO9jjVpbq7Q90v8npzwn7LTzv2DIl2/Aovo9vo=;
 b=gb6KhF2+sRlNIhpoeeIWDLedSzuahV8Qy2OOU5z6TvSEcKxFBFiG917lNqaTPc9tFnlwtX
 aIXLgiL6XJ2eF/CV8XqDQx0TqLHj71jY4Qtw/ZQaSzFBVin69beNZP4KmWBml2oX2T15NY
 KY7PVSPtjOLHQE1jINsWZ21SHYSvJLo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-gzMeCXPNPkyW_qwQJCcZeQ-1; Thu, 20 Aug 2026 12:51:57 -0400
X-MC-Unique: gzMeCXPNPkyW_qwQJCcZeQ-1
X-Mimecast-MFC-AGG-ID: gzMeCXPNPkyW_qwQJCcZeQ_1787244716
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-496c06ba017so8343575e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244716; x=1787849516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grbbqIO9jjVpbq7Q90v8npzwn7LTzv2DIl2/Aovo9vo=;
 b=hdBjLeazDJ1aT9QKkrKLvnqKe6bWaG0Yj3vcPygPTUlvNqsaNk0g1/Kpmk0x8tjXGN
 0VnjgDx9/s682uEtHw7r0I3LjU2sq5PrJ/YaT6JsPMPXySYzD8kDAjjQ0MKIUW7NAHaQ
 blBP6RrvVSfPwVkMwT89Wsf7VNpM8Kgcwm5jG6RbVttr2fEUVh0Xdi5gQMbq/IzIcatQ
 vVPy1mEPiTpEtVHJ8ueKC6iR+xqeYXM2x2OG+pSP/qOf07+L7lkmETKYjwf7oHIgB1Gj
 ZKxDrHssQDrFodPdwGd5Aeer+8uibr0/SrK7kfwQhD0F41QuSFQSMy6wbkzyOwH44uxA
 3hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244716; x=1787849516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=grbbqIO9jjVpbq7Q90v8npzwn7LTzv2DIl2/Aovo9vo=;
 b=OGYK9oP6nLuK/2chZvEb87+oZLWg6U25kcxfSyxYJXJbGdzCr5p4CfSsiin69OLgQf
 yyGyUg1O1Qv6LBXuxT8pEWoW1wPRPFEQ18mLirMbMtqqga1fTNiv3RG7qEpWBhv/s1uC
 kSUuqpP/olewcjUsT69C0Hz7YGSXo57hLnelsvV5HL1mTQEUYFtqKB86RVZcNE/bkSee
 uZh9+MAOhF2xS8h7qYFrlHj0JEhvM4Y9ZRwBNCuiOMoYQLlCtw4lVXmWcMFtDF2aVpxe
 +TM/Q038JuKQLQ5tPGkeenqMdjDdpbblJ2FIjwTTYqYuOAWS2SrWhga9y/9jk7R3TJXx
 zSIA==
X-Gm-Message-State: AOJu0YzgZuvizEM8/M4XGxstkfsKy+x120MwaUbzCqwv4iAwxxVOHmVL
 QJGsGY/nIw+++Nflhq/8VtIFFsledX+cScP2tZ4iKjb2q9VWaodEvdKgHClkDDKzfIUni3VbT/V
 yDsAQ4JWPh9zPhjjj8CRaTXq6iKG2JJZRsUiL3SYdZ3jAUMA+XV9j1bPXf7lLmUL40FfPzFedhw
 meUo6HAZ5BHg18vRQkRj7+UOx9BBz++71eyMYF8TJj
X-Gm-Gg: AR+sD12eyOXyCPD0Am+EDCFHeHW3DiHwE1fTcU8CAZMBuxfSVFXL6I9Gbk1g4LBE4wn
 JbEyc7//NQmB/J8azCMwE6pXnAl5CwUQCFA+7LUiS7GfcLb2eXBRfN6WDJyHkizuv5WZx5UIEgc
 XZ2bm4EWbHLKQryqs3xwzp/2asDS6HGAtzFZSMdDqx/n0o031DwWLj/cgLRSwQl20vHpygx3k0o
 /+lnS2tUBFdGskrvfl2B66PTfjW3Jf+mlTsZP5tEZsij13illFW6WDGwiCxgDXn+/VXvwYj3olL
 W1N9sLDTjzhOi0Ftgub9pjbBBmSPNFlZY21pxyq1GAMU7gbVUOoIrXrY/y6TT+Uhzv3rZBbC94A
 9SCZI2G/5GBJLYxMuvtIBUwgR7u3laV7+igeqwajD6Ttdvaxiodlu1ZPa311nUck0SDwHXgGtqG
 kHmeM=
X-Received: by 2002:a05:600c:c4b8:b0:499:a5cb:b7c0 with SMTP id
 5b1f17b1804b1-499b06adfaamr41341215e9.3.1787244716144; 
 Thu, 20 Aug 2026 09:51:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b8:b0:499:a5cb:b7c0 with SMTP id
 5b1f17b1804b1-499b06adfaamr41340675e9.3.1787244715780; 
 Thu, 20 Aug 2026 09:51:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm94903345e9.4.2026.08.20.09.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: [PULL 42/53] rust/bits: Align SubAssign behavior with Sub
Date: Thu, 20 Aug 2026 18:49:45 +0200
Message-ID: <20260820164957.1895963-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update SubAssign to perform a bit-clear operation instead of arithmetic
subtraction, matching the behavior of Sub.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Link: https://lore.kernel.org/r/20260802170346.3493821-2-phind.uet@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bits/src/lib.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index d1141f7c882..60b63f969dc 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -320,7 +320,7 @@ fn sub(self, rhs: $struct_name) -> Self::Output {
 
         impl ::std::ops::SubAssign<$struct_name> for $struct_name {
             fn sub_assign(&mut self, rhs: $struct_name) {
-                self.0 = self.0 - rhs.0
+                self.0 &= !rhs.0
             }
         }
 
@@ -443,4 +443,11 @@ pub fn test_xor() {
             InterruptMask::OE | InterruptMask::PE | InterruptMask::FE
         );
     }
+
+    #[test]
+    pub fn test_sub_assign() {
+        let mut op1 = InterruptMask::E;
+        op1 -= InterruptMask::RI;
+        assert_eq!(op1, InterruptMask::E - InterruptMask::RI);
+    }
 }
-- 
2.55.0


