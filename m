Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D76DC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFx-0006ot-Hk; Fri, 21 Mar 2025 14:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEe-0003C8-3g
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEc-000760-GD
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/dAnBUJOA44LvY1dVtr1Z0PiQh72oKyIjeNgHJkIAE=;
 b=M4RHjRFhJqMyV8LCQDkK7J745iCSniBfQ3pjjPAYyD7CWxIjEbgO6NC/15h9rXNwl0z7Of
 lCNDoAwt/vajMdTUNfcX6aNmG+nKbmnBENch5SEfRayyPYsmyUbatYoqmiSc7Fy4MQS9jM
 XFiQmNIiDQwI+ijHKzcxJr6ebhU8AR0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-QUZ7EXemMOKe8srBCiZYCQ-1; Fri, 21 Mar 2025 14:36:41 -0400
X-MC-Unique: QUZ7EXemMOKe8srBCiZYCQ-1
X-Mimecast-MFC-AGG-ID: QUZ7EXemMOKe8srBCiZYCQ_1742582200
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3914608e90eso1434083f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582199; x=1743186999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i/dAnBUJOA44LvY1dVtr1Z0PiQh72oKyIjeNgHJkIAE=;
 b=YhX7iN+ZGyhGMEaMjIoNRcNhuO55HIOvrDwnePEB2HI/dgToRyvB0HrschhQepMxVo
 zYfp4dOa7S7j3dwaEy+eoVVS4sgGMMFXJ64v43RHT6HwE/WxzRhAxXOCWI4qUAoPGqsQ
 7/5NelRCzG8SGKeMjQcpq4ESnookqGKmbDATBc021956ctNoYb+blcmD073VoFdBNeRv
 Dq1BKPeAHRjFQnsKCnm/k4YM1F6MXTwxJ9+a/PtF6hZbHxlsS5o4DgwQEgYcIG34obKL
 Cb0GcmT9Fx2nYygDVXgcUW27pXjOKmeg/1r5gEW7/E4bcLEFzWALRwNRAy8kgvtJSIMW
 kcLw==
X-Gm-Message-State: AOJu0YzrzArUgM3ze2W32y7pzM3thyB3AjVIlHAr3uQAG2Bm8ZMz8Yql
 4X/LujDcwHhsvxZdcNdniJ7tpqrzn5QoZAYrxsl8vTavlNyQs4PW330kwweEGy/Hjb3VVTDID1u
 wurPZPP6W7DsXeQlo7d4iSCOFrNO7yHmQ9nEy96LG32aSzgDyC13efbzmRVR+uZVAQq/NXLuFc1
 3NKth2JtQxc0oDtW69ix49TzDbSRw6LVZ2h43y
X-Gm-Gg: ASbGncvzGaoeNi3l7oq0ANKwP8RyGPNa2MDPv/gLWWscrAFdsfH+EAda7xXGW26YqcS
 fJ3/oYPLOEh9UeUa2sZs5KG4+R5e/VMIbPpmovEP5LLB8bIQb2W6tQk9JEh6fX4dfzEjpAsHTvu
 qVJ29+CAn+6qEJf/5coJMqcv8eS/7h/wPhprgih0++Pf5p77EWrSEyZkGKI4K6s03MfVsLHlaS0
 KAw81BKYufgeyc7j7fs/mEw2ohzo1Rqp3qL9okDi6zivyep/XLWMpwvLf/GhdjQ1sEum9KJvmWZ
 Y0dwxi8qKltVWO5SiHdC
X-Received: by 2002:a05:6000:1f8d:b0:390:ee34:228b with SMTP id
 ffacd0b85a97d-3997f910522mr3591937f8f.24.1742582199534; 
 Fri, 21 Mar 2025 11:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa1zaUOLNEj6Hmsf7qNVPMUCvTJ9B3t1S++6Iu65DRnagHHodKczXnzw1fE2dRoYEzc89w0w==
X-Received: by 2002:a05:6000:1f8d:b0:390:ee34:228b with SMTP id
 ffacd0b85a97d-3997f910522mr3591918f8f.24.1742582199012; 
 Fri, 21 Mar 2025 11:36:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957efsm3094662f8f.14.2025.03.21.11.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/24] rust/vmstate: Fix unnecessary VMState bound of
 with_varray_flag()
Date: Fri, 21 Mar 2025 19:35:47 +0100
Message-ID: <20250321183556.155097-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The VMState type bound is not used in with_varray_flag().

And for vmstate_struct, Rust cannot infer the type of `num` from the
call_func_with_field(), so this causes the compiling error because it
complains "cannot satisfy `_: VMState`" in with_varray_flag().

Note Rust can infer the type in vmstate_of macro so that
with_varray_flag() can work at there. It is possible that the different
initialization ways in the two macros cause differences in Rust's
type inference.

But in fact, the VMState type bound is not used in with_varray_flag()
and vmstate_varray_flag() has already checked the VMState type, it's
safe to drop VMState bound of with_varray_flag(), which can fix the
above compiling error.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 3be3a7260fe..792a74fdfc0 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -275,7 +275,7 @@ pub const fn with_pointer_flag(mut self) -> Self {
     }
 
     #[must_use]
-    pub const fn with_varray_flag<T: VMState>(mut self, flag: VMStateFlags) -> VMStateField {
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
         assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
-- 
2.49.0


