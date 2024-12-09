Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C660FE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd2n-000503-R1; Mon, 09 Dec 2024 07:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1S-0003z2-Rx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1P-0007TK-OL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc6FheuyZyH/oA7b36KKccLApc1+iqI4hAPCi9UKt0s=;
 b=BXJMp1qJL1V2a9J0R9Rt/RZkDnJbvId0cbazSwHtI7GCCTDReiyssbEFj8W9Dlbh4KFWIy
 DpLTe+iJwibzV7XPO8kMz5vwN+9INyXY/uFmG1jxtFucDgmTmJeVfilLgmlq9G7LuMzjU+
 KXs9p3vZuePLPmwJIVY1qgmD1f6dZpM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-OIl3S_9hO3CESclEld4GHQ-1; Mon, 09 Dec 2024 07:37:54 -0500
X-MC-Unique: OIl3S_9hO3CESclEld4GHQ-1
X-Mimecast-MFC-AGG-ID: OIl3S_9hO3CESclEld4GHQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434e81cad70so16184315e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747872; x=1734352672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yc6FheuyZyH/oA7b36KKccLApc1+iqI4hAPCi9UKt0s=;
 b=IwGZU191Rd1ayzhsghZGdqRGUKjo8LRgOnfbtuVZ9Vk5z0djG9smnvbqaI/cLWxuPF
 sz39b+GGd0tOsxHxkd6oNY2CddPGfMp0l6oUCB4SWoOaU1RjoqhakXbopwGAapOqgeIE
 /Vtf78zGG82492VN3ywX2QQnlV58/+w76jMHrH+9Tf7TS3l3HZ1DcCXW0zgHCMBgr3NG
 Wj9aBiZv5Jg0xjMBTqPhsSZG0eoYxvfRMTe631JPKi/N8t9M6E4Qi6svPZLp7Xd7fOgT
 2EZo8cnYbrBiupiQZVNxNOP/cx4JehjPV4rW9e8IOtIhGOmpicVvpAH8keoyWnksZA4z
 Owfw==
X-Gm-Message-State: AOJu0YzzCvps8PZxoJJ+/YgqBM4/e2QnQkPw3KWk+vae69fHmxBo1aO1
 tu51G6c4hnYevTVwM050WkCZzCX0KGn/xhZOv171r2Z/neLRXvjj7brVy4aLnodWZleG+js4mz+
 cCMy8oghl8lF/eyjFA4mCa/q9xExQ6S3zfdlBWSuNByn0F60S8AEkV6W03t6ZHk8C2xfhM2GWgY
 AIcW2u8PJRmDvDKp3PxHbCoXDZV2lrwEGWadQk
X-Gm-Gg: ASbGncv3U5rbxS1uDWg4NAg9ZtqnDjTC6ZtKCfNKTNvBbKYuXgypjIYIIJqZ+wvb6fL
 NIFIhAxCAo1I+0yU/AINCvJ0liBXJk4ca0d/aXH7rSwQ7ylUJzW8TNPkRJKcMly4sal5CEJgksQ
 ImGYYt/zoDTlDnw9NNIYYmaBtRjFGYs8nyY3EzP3AAaGxW3d2zfkzXE8okAXWKlPf7TOGr/egih
 AORFqeEnZHPgsSJVlIdRYHj8B1GzJq/3/7MmetDSnqErKpxKn52Cw==
X-Received: by 2002:a05:600c:458c:b0:434:9ec0:9e4e with SMTP id
 5b1f17b1804b1-434fffba059mr3550135e9.30.1733747871697; 
 Mon, 09 Dec 2024 04:37:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXo5oYAIaHVB3/q0A3uBCASjycc1vAb0yhaygilhId7tYKgqlabvux4EtEuo9ZUx2wrcbr3A==
X-Received: by 2002:a05:600c:458c:b0:434:9ec0:9e4e with SMTP id
 5b1f17b1804b1-434fffba059mr3549755e9.30.1733747871210; 
 Mon, 09 Dec 2024 04:37:51 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f43aedb2sm55069405e9.41.2024.12.09.04.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 13/26] rust: qom: automatically use Drop trait to implement
 instance_finalize
Date: Mon,  9 Dec 2024 13:37:04 +0100
Message-ID: <20241209123717.99077-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the customizable INSTANCE_FINALIZE with a generic function
that drops the Rust object.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/definitions.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 0467e6290e0..d64a581a5cc 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -8,6 +8,13 @@
 
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
+unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
+    // SAFETY: obj is an instance of T, since drop_object<T>
+    // is called from QOM core as the instance_finalize function
+    // for class T
+    unsafe { std::ptr::drop_in_place(obj.cast::<T>()) }
+}
+
 /// Trait a type must implement to be registered with QEMU.
 pub trait ObjectImpl: ClassInitImpl + Sized {
     type Class;
@@ -16,7 +23,6 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
     const ABSTRACT: bool = false;
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
     const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
         name: Self::TYPE_NAME.as_ptr(),
@@ -29,7 +35,7 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
         instance_align: core::mem::align_of::<Self>(),
         instance_init: Self::INSTANCE_INIT,
         instance_post_init: Self::INSTANCE_POST_INIT,
-        instance_finalize: Self::INSTANCE_FINALIZE,
+        instance_finalize: Some(drop_object::<Self>),
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
         class_init: <Self as ClassInitImpl>::CLASS_INIT,
-- 
2.47.1


