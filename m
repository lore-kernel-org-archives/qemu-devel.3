Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DFAE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPa5-0001il-Cs; Wed, 11 Dec 2024 11:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPa3-0001X6-Ee
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPa1-0000c1-MX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OshVopfsDLXhXQaf0FN9QUClgxDd1xn/z3ig2ZaD5Nc=;
 b=hTKXOx48nkQJ+BRjx+QacagfIU/0jl0m+NsikSz86wGMUw+Xej523O8fYgFI/50CM4eKBA
 xhiWx1Yx8d3gpxQd8QV5YPZ27GLF6uK38uAqZLupxSvwFJvmOObf54NgciVCzdcoVut1xC
 zU4uM7URAeJKOpB4PBoc0jxwZOIPImU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-f3cQVFXYNnKhtzCl1FwSmA-1; Wed, 11 Dec 2024 11:28:52 -0500
X-MC-Unique: f3cQVFXYNnKhtzCl1FwSmA-1
X-Mimecast-MFC-AGG-ID: f3cQVFXYNnKhtzCl1FwSmA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385df115288so2972562f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934530; x=1734539330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OshVopfsDLXhXQaf0FN9QUClgxDd1xn/z3ig2ZaD5Nc=;
 b=nwdf6ZV4MpvGrP+6lg1VyVNVz4eNkqbFfib/SeF3Mzrpbs5A+RsE3Nmrt/hldHHdWi
 qehxjbfC8rBsrAcGKgK4MacqEXdEjWGJYXKadGbaM7kEfbSPDuWuwsQIDjr2a3bxN/kT
 2/s0aPwOwJ+FM8YNLMk5R9v7oPKvYGbMcEfxDXx6azyNrmnKnSt8hxy2ZRlIQY8XpQNW
 QNMSFpyRgGyfenoQZ5R2wkZ4SBa3+mDQafUdRuxYx+EjVzLzxVc6zHWxoD71Tp3m4Hav
 VgFlQADBDdj5EU7FVeGRHmxUWCmV87N2Rs3kfQOh1dIUfirL15qqtmdWepGDa0UZ4DX+
 5YDw==
X-Gm-Message-State: AOJu0YyTs2DNqbjNIrreDqIM5+vakwJJ67+4LCCW9mqn+j5j7NP6zQLa
 qA8pmER3T7YioIwL8eR34ARhIAvXdFPEJBCQ60GaG3y+NTZ8cs6jqw1vw4r5yOBBo6tBAlQqZQI
 4HVL1/U74Hff4SDbfQZe05d9KqzzbOPC/jrlhWBBvVTGfs/YMMFfO4U9eY2bk7quiyNsNMfq6o9
 YFPr1WVANog5FRTvOdw5tWaUEPDhrSHEBXIdxt
X-Gm-Gg: ASbGnctuLEtBrEPb4v6wcxWn+iALnZoAsYq35LJC/BEuRCL6cn3OxlL5ClAowO+YGr4
 2/AYKOpL1QA9GFiIBfMc4fHBUm8xDhj+C598wsoqyyOTQNOKTMpsUbs+37rlglqpv7tPCajuuSx
 Nusa8x8uLKLuNCFTBT4XjZwFI9pM51RH9fC2bZWykqtxRAYffnJ9Plu2IY+gti7uN06DR3aYVZ5
 yMFoQrrnMlkrnyu9ewqa5mkcbiBsCk5z5AI4zHJcr/lDX4iRP/PRo83
X-Received: by 2002:a5d:5f4f:0:b0:386:1cf9:b993 with SMTP id
 ffacd0b85a97d-3864ce5c698mr3221018f8f.26.1733934530361; 
 Wed, 11 Dec 2024 08:28:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm5M7JM3EqpjlRcvk5Z1HQHInM2LjSBNDpmIUu89JtJkyk9MhoHQXCm7zJk47IxTPJLXLvnw==
X-Received: by 2002:a5d:5f4f:0:b0:386:1cf9:b993 with SMTP id
 ffacd0b85a97d-3864ce5c698mr3220990f8f.26.1733934529881; 
 Wed, 11 Dec 2024 08:28:49 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514dc3sm1605176f8f.67.2024.12.11.08.28.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/49] rust: define prelude
Date: Wed, 11 Dec 2024 17:27:08 +0100
Message-ID: <20241211162720.320070-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add a module that will contain frequently used traits and
occasionally structs.  They can be included quickly with
"use qemu_api::prelude::*".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build    | 1 +
 rust/qemu-api/src/lib.rs     | 5 +++++
 rust/qemu-api/src/prelude.rs | 6 ++++++
 3 files changed, 12 insertions(+)
 create mode 100644 rust/qemu-api/src/prelude.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index cacb112c5c3..f8b4cd39a26 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -21,6 +21,7 @@ _qemu_api_rs = static_library(
       'src/definitions.rs',
       'src/device_class.rs',
       'src/offset_of.rs',
+      'src/prelude.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index b04d110b3f5..e5956cd5eb6 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -7,6 +7,11 @@
 #[rustfmt::skip]
 pub mod bindings;
 
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
 pub mod c_str;
 pub mod cell;
 pub mod definitions;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
new file mode 100644
index 00000000000..dfaddbd062a
--- /dev/null
+++ b/rust/qemu-api/src/prelude.rs
@@ -0,0 +1,6 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub use crate::cell::BqlCell;
+pub use crate::cell::BqlRefCell;
-- 
2.47.1


