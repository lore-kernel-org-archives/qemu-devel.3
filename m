Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED27CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lol-0004wO-JR; Wed, 24 Sep 2025 05:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loi-0004uJ-7o
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loa-0004nj-Tr
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltuB628keKCxP/f10xoJleC3spK/ALW7x74bQTNSw6c=;
 b=GqV//MTQzIcD6ji/VuXI8RIMOP7IPRl+legSQmLfftnfS2JgC80RzI7x9AGLHDZAZMXrrB
 wkjwdX6HVEKaFKK4/U6tMyAORxiRdeV9yG1GyJEvsumP+UFNi1ab6840n9RWNIsPw4LD32
 it1+M3PPaJWGNIriALpB4+1R3pGkbhQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-Xq4U3lLZOiKiMJkqfy7OnA-1; Wed, 24 Sep 2025 05:29:28 -0400
X-MC-Unique: Xq4U3lLZOiKiMJkqfy7OnA-1
X-Mimecast-MFC-AGG-ID: Xq4U3lLZOiKiMJkqfy7OnA_1758706167
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-63267baffcdso3458963a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706166; x=1759310966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltuB628keKCxP/f10xoJleC3spK/ALW7x74bQTNSw6c=;
 b=UKvHNNg+WrXhzVdj75Vp45RXgDPwLqLf5Oh/7RtVMa8didifg7oXAE8bLh8y5Xcwnv
 7YXCLxxMYpQH+SHTro2H1D83c8Nkdyvx7S9C9zMiLUEatIjR6ymrylARrnmeiz1OhPft
 DIeHYoiyWjO5+9rqfOMI7n25HgmvO2BMRKQg9WcqGYPERFnoNELRArlTk3JP/7Ts1vxP
 UyYcEdpWZavshIDnxBALb5C1Y7ZxuueMcrXg09CSMI1J36JHVR1nbVsDW9l7TFVUgEX3
 NjaDLBppWQXyqvVMrhdibc6XoqYjdwKo12lkoLZqthC5HfoVB+ezAFApYlFtVrAYVryG
 4Awg==
X-Gm-Message-State: AOJu0YwisNIR2auFnScdtpKO3wKWUOlZVl7AZnz0xEO3Pv7rMcqXPcd0
 4vRE/jTjmBR7jmlUT+O5BcdNYNcV28F9/DBekrF1BbBHD+kG/CIamVTG8ZY6I8q3EO9SNomdg/G
 f8Wu5WlmxjnfzIastZAdUut8oSjsJpc6PM5vDauG37asXw4E4qLNu4Cw7MJ1agtQ3t6O2Ex3Bnn
 9uJ6MeSHOPDL87IvqudSArynMOtuLjfmzo8CZzsNz6
X-Gm-Gg: ASbGnctXXvBoHIl00jE520vKniufh2zUFmu74eA9LZMFS4DnSEAqYcg5aC+qpBenrA+
 me94j+rfVxQreZz739NqYGwl7r9NyrsjW3ZyKFP6bIvh/aMsFt8E016Y/ZR/dFIFxeozULE3iat
 IxDTw99rpac56kCtceQDu2cuxI+YJuvf2GApGMcwmyyK6nivTg8EIxdAfXSl09jv4AXqnWLCCQL
 92jAymKuBOJkjw8wLa3oN7bINHGrjYGwPZOy8xJm2qIN36nVkb2vryRWu9xtwDNyairUgeE9VbD
 dE3FUMxybh+SZ8Ms17oUK5IoQrV49mce2NBFLYTJEogvrIb5S431tuSGeCjZ+1jt5IOav4HZ96t
 cmZANFIba8ie9cl9doo5f5pah5j3xGE/auAOmjcEtbmDRAA==
X-Received: by 2002:a05:6402:5246:b0:62f:26cb:8072 with SMTP id
 4fb4d7f45d1cf-634677b5849mr5032332a12.13.1758706165854; 
 Wed, 24 Sep 2025 02:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEokRPoNgqaoabBYr5yUq8U/XC1DqxoUY9DayzWZfluI6qRymWdVqbp42/bCzvltMfRMpySbQ==
X-Received: by 2002:a05:6402:5246:b0:62f:26cb:8072 with SMTP id
 4fb4d7f45d1cf-634677b5849mr5032295a12.13.1758706165301; 
 Wed, 24 Sep 2025 02:29:25 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6344e493329sm4798120a12.14.2025.09.24.02.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 11/29] rust/qdev: use addr_of! in QDevProp
Date: Wed, 24 Sep 2025 11:28:31 +0200
Message-ID: <20250924092850.42047-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

We want a &raw pointer, so unsafe { &_ } is not needed.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-6-zhao1.liu@intel.com
---
 rust/hw/core/src/qdev.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 71b9ef141c3..3ee5b242622 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -6,7 +6,7 @@
 
 use std::{
     ffi::{c_int, c_void, CStr, CString},
-    ptr::NonNull,
+    ptr::{addr_of, NonNull},
 };
 
 use chardev::Chardev;
@@ -129,17 +129,17 @@ pub unsafe trait QDevProp {
 
 /// Use [`bindings::qdev_prop_bool`] for `bool`.
 unsafe impl QDevProp for bool {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_bool };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
 }
 
 /// Use [`bindings::qdev_prop_uint64`] for `u64`.
 unsafe impl QDevProp for u64 {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_uint64 };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
 }
 
 /// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
 unsafe impl QDevProp for chardev::CharBackend {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_chr };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
 }
 
 /// Trait to define device properties.
-- 
2.51.0


