Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751B1D1F9B4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6uo-0002Br-LC; Thu, 04 Dec 2025 05:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vR6um-0002BG-Pb
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vR6ul-0002Cr-9Q
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764845422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i2L2bDIgJyo5amVCwiaT61QyiIDHFyCTXAFJ7ANy4bs=;
 b=MReWF0KvJiO1UB96zfeqBpsp8wSKq0iwrTACAlQ12wzwB/AEXw/E7yAC6TFfx4uk8Qo4X4
 uymGN4dBNypyg3SVaH0plIEW8s1l8iwCSBuFXauIvC9KUKQRW1NQNm5y8DBW9Y4dBM4IqB
 i1eGwBEoG1QDw1YJk1OyTxpzUmO085g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-7-XLTtvoMC2MRf5Rpl5oDw-1; Thu, 04 Dec 2025 05:50:21 -0500
X-MC-Unique: 7-XLTtvoMC2MRf5Rpl5oDw-1
X-Mimecast-MFC-AGG-ID: 7-XLTtvoMC2MRf5Rpl5oDw_1764845420
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so405918f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 02:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764845420; x=1765450220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i2L2bDIgJyo5amVCwiaT61QyiIDHFyCTXAFJ7ANy4bs=;
 b=RJ/38Q/t7yhs/OpWydDPIub5GnSwPn6/nakpcir+A/0PmaltJ5y+oCN/3j4odM3epp
 duGp20CNdaviu5UMYNZhnlNUCDfLMACXMR07ZT9kJhYTz49kS0fDDFj7XKBV5UqIEKUP
 NzVvQeMWK34nl9pJ0MpVD+OaTxvORHH8dfReh+V3CQgMkajzhOJ8As+DjS32KDTqRCgm
 SaM9YydGnUB12sqk+v0CqksDJVlgNa86a/eabSzTJZYM4ma7Zl9AkIy4jk2y/FVcny21
 6F+ioRkPew5K72TuMNiaFrGPt7QCQglAyN6BVIteVLLw2Pwe/tU4/JMwRCo+HGA7UT6w
 wFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764845420; x=1765450220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2L2bDIgJyo5amVCwiaT61QyiIDHFyCTXAFJ7ANy4bs=;
 b=lBGbslEo7tLxbBGapoen5C3mte30j+bWfkearLl9H69n7k6WdO09X44eKL1nUtn0e6
 Bm3mTOVyKHj1nP3RAX01QSA/kdFf+duMLKliSh2hmHeYbrLJT2az8woKj0ccvAnK5dIH
 7Y6IzxQ601nRCxfiH9VkQ1taTiyBuE29pPQlpNuYL0aDaZpI451T86ehfcfJZ67g20ud
 gvAPlAEIbIPaW/rD4JZIKvoDJJ6/hjwh4pP5MBGXsYnB6DEyyehXokluxLfXzmm4EOxf
 WVTkvaKtH5AJHZTbaDur5ex2BbD9QeYlFYpsgspK3HZa2aG73J8MZ+AJ4uPavpJpjH0U
 fnxw==
X-Gm-Message-State: AOJu0YxYHYiRSO/7q3IHjdqhrzNu/sLE7nAFhiCnbS0w0gObUKR3gRBm
 CgAijrXBYmg1lU3IEbbdhhdMho7S63pgnX8RPpk8DRy4/sPY36B7ElqZyEsZoFpWmaiVgp157IL
 RXnEENih4FQJXOyxNLGp1NcBugDI94NK9XRcYa9KIT14YIFLcZn4tTugmFS3fqALaoK9RESb5Mj
 yrthNBX0hxFVzNPSXYbYdHUYsTO5K2Hd85h00i+CBn
X-Gm-Gg: ASbGncvSyRX9etfCOrhQK56MFz65VK4oKWpzhbGlYvwnzXww9rsbv8yZeKXmIo/zOi0
 uJFQKHcjXMjBZ1tNOSZsy5TMOGGONh/oij/t494HMHIYNM+KLKGzOIfnW3rxpzFQAudqx56emP8
 ffVUCD5AEMQEWMspPeaXDYbAo/f0sfgAUnfFBkhnIf6Hx/zKAGB4hxy6MPtzVfKg6QaDKpH6x4Z
 UeGNEBrxhOr8Wby6c/99ZxbvRPSiDulTaWpgxvhm3NAZY0MSg2TACduwRLFdu5/klx4p0o3SQTy
 /Wg6VIioPfGkeAK9STtoFr3XoFwWAibSKWlbXSDGCeeV2iOXW2tKfWob6V6H9PhEAnK5I76BYhi
 mfIkCqa/fBgQ2riTDMhcUkg+mU9H5sUQLn/5hNS65LTVaJmiaSWY4KGN6Pl3e8GSrn1VNQpIIbN
 pKBaK4lju0wZ/hDRE=
X-Received: by 2002:a05:6000:c0b:b0:42b:3eb2:1b97 with SMTP id
 ffacd0b85a97d-42f731905a9mr4635237f8f.9.1764845419335; 
 Thu, 04 Dec 2025 02:50:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDKn6k/gpAIcrJEUW+zOk2+lqPffW0oRy2X2l0v6uJLA8SVYJGfQjNXnX1w+WnrsPN5Wj8Eg==
X-Received: by 2002:a05:6000:c0b:b0:42b:3eb2:1b97 with SMTP id
 ffacd0b85a97d-42f731905a9mr4635216f8f.9.1764845418878; 
 Thu, 04 Dec 2025 02:50:18 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331aeasm2455317f8f.37.2025.12.04.02.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:50:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: hide panicking default associated constants from rustdoc
Date: Thu,  4 Dec 2025 11:50:17 +0100
Message-ID: <20251204105017.2564277-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Work around rustdoc issue that panics while trying to evaluate
the constants.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/core/src/qdev.rs      | 1 +
 rust/migration/src/vmstate.rs | 1 +
 2 files changed, 2 insertions(+)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 4e983da28b7..c2ca17f6ce0 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -132,6 +132,7 @@ pub trait ResettablePhasesImpl {
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
 pub unsafe trait QDevProp {
     const BASE_INFO: *const bindings::PropertyInfo;
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const BIT_INFO: *const bindings::PropertyInfo = {
         panic!("invalid type for bit property");
     };
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 267f9c8e053..f9d9f335b98 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -101,6 +101,7 @@ pub unsafe trait VMState {
     /// type for the length (i.e. if it is not `u8`, `u16`, `u32`), using it
     /// in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
     /// compile-time error.
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const VARRAY_FLAG: VMStateFlags = {
         panic!("invalid type for variable-sized array");
     };
-- 
2.52.0


