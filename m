Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE882C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEJ-0001uh-3t; Fri, 21 Mar 2025 14:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEE-0001c1-IB
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhED-000721-1r
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJYKYEdYqunbqZeqDFgxfiUWf3ISoZFIFoRTEsG2okw=;
 b=Lv3d/+5khy+iuc9JuMxCJTDreityzFYJPXpuWpApSuekolNRUOZ6+5eUrnUMzr2VKXsIbL
 qyVIoGccmZnttsX3RrC/pfu5zzi34uLzUJ8PhB/8TOmH05HJd6qoQ8BWf/eEsI1PzDGsCK
 P/FkbUxuuwpksQowshH/o86XFyozQ/Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-dIX4ENo2Ohil7_2qkJn_3A-1; Fri, 21 Mar 2025 14:36:16 -0400
X-MC-Unique: dIX4ENo2Ohil7_2qkJn_3A-1
X-Mimecast-MFC-AGG-ID: dIX4ENo2Ohil7_2qkJn_3A_1742582175
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac2aa3513ccso200186166b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582174; x=1743186974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJYKYEdYqunbqZeqDFgxfiUWf3ISoZFIFoRTEsG2okw=;
 b=ZBjiVUrLQNJq51tJcE8sLFpVq8mK3SLtVQTvrJqjcJXhypEOdqVvETq9NAuDlmDfKR
 dDwHEIBbeAu91ucAVxzduwqtv+p/FN+CwdP0pCzOyyAiD8PFtSHBBrwPXdcLZdFVTBMV
 wUmA0GDPVkkhyEQqdXIT4oDMCMmgEcrbT+/kQfifCbbOeGfbKYQwaZSjJVYFF+tVLIdR
 gux3nL6r8AozpZRS1xzfoD1qln8jGTL+FGNJaD0ijqwDgEibEtb+3OgYLgo879wY1xEz
 ZZYIrN1IlCISJiX6LYGp0BzHFmsBSPkekbnRQ152C9YamkPWRStCOHJCYjJLkky6IIIq
 i3DQ==
X-Gm-Message-State: AOJu0YxXwF4hEXxDTttuycJGRuTCGEOchbiw1R6n9hGVjbqqXKDM/scN
 JOxxhYfVO8lLD+5dl54Jpo8tMuOSlHj3HuBxw/KeVp+GgIZsE+F7HM6AFxdawBXCFojGFT4LHXM
 KhPfIWuDaAASlrNA8E2VWLl2XRxNGYy+rn2nK0XmzWsfZBu6WCjgIjCwdJ5XIY52G2+W3JwR6Xi
 iIdJ+ERI2CBXSiJ7ZOIFdMRIOh9Vxf9XFPcFEs
X-Gm-Gg: ASbGncuku8SJL1gqQJZ+222cJquj/rAhNVChdRNL5TbCfCY/OQUFVZPmZ9FMaiz3sD5
 HGM28HKzaq6jbZC2bMhAobQfdEwfTEQ3Jlfys4JKQfLx7bzv3zKsgMYGUpOPBq7rYIBvAwU8Qk3
 TJbCbFCVVDURGo40mVV9PoVDnfe1DjGxTPKf7XKliTVgKn3xua1fVID2tvFjcxgZUDHZzu1851a
 pLW63Gzxgn5K/TmLvOC+LWRFYiUSxEDARkPmPdsG0Em7sQc8Lw8Vin1fuq0GY/jGM6F/iTp5SB2
 AYn1dEfbJz/LKPVU796K
X-Received: by 2002:a17:907:1b2a:b0:ac2:8784:4bea with SMTP id
 a640c23a62f3a-ac3f20d30dbmr511750366b.8.1742582174134; 
 Fri, 21 Mar 2025 11:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL4YgOLDFgh9WOMJ8s5Q5SuMud/esYx0rtiJijczdi/umgHKyrZPamHaubZXyqWbh03KPGhQ==
X-Received: by 2002:a17:907:1b2a:b0:ac2:8784:4bea with SMTP id
 a640c23a62f3a-ac3f20d30dbmr511747166b.8.1742582173616; 
 Fri, 21 Mar 2025 11:36:13 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccfb049csm1802736a12.42.2025.03.21.11.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/24] rust: assertions: add static_assert
Date: Fri, 21 Mar 2025 19:35:36 +0100
Message-ID: <20250321183556.155097-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new assertion that is similar to "const { assert!(...) }" but can be used
outside functions and with older versions of Rust.  A similar macro is found in
Linux, whereas the "static_assertions" crate has a const_assert macro that
produces worse error messages.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20250321112523.1774131-2-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index 104dec39774..bba38cfda11 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -120,3 +120,25 @@ macro_rules! assert_match {
         );
     };
 }
+
+/// Assert at compile time that an expression is true.  This is similar
+/// to `const { assert!(...); }` but it works outside functions, as well as
+/// on versions of Rust before 1.79.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 3);
+/// ```
+///
+/// ```compile_fail
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 2); // does not compile
+/// ```
+#[macro_export]
+macro_rules! static_assert {
+    ($x:expr) => {
+        const _: () = assert!($x);
+    };
+}
-- 
2.49.0


