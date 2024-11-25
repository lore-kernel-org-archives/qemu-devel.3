Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA0CD3B7E7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU5w-0004ma-Q2; Mon, 25 Nov 2024 03:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU5u-0004m0-IK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU5s-0007Gp-QW
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bw+iN8fKxiF3pJPEF1ZMN/bkTyNEV3JjeMKpd70KM5M=;
 b=f69+u68z2pJ+uNA3ik9iKcB3QMtb+t2dY0Eu64Jb4BxBUCWuqMq8addgbZ/GQ18kqSTWXT
 XP/o5Z+7uOddjfpwcLChjZk6PNhLHQ2g0pLWj2v/mjhdQdOr/Z2DINSSQ07T58PTw6vZ4B
 8E7kh0Ol2vq4BumswIm3SmkkuloFp2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-I_IK4mdfPxGtiQvxWS1ccA-1; Mon, 25 Nov 2024 03:05:12 -0500
X-MC-Unique: I_IK4mdfPxGtiQvxWS1ccA-1
X-Mimecast-MFC-AGG-ID: I_IK4mdfPxGtiQvxWS1ccA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4349e97bfc4so8235205e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521910; x=1733126710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bw+iN8fKxiF3pJPEF1ZMN/bkTyNEV3JjeMKpd70KM5M=;
 b=mQR0yoGXB6iR4caveWwNCZOIzQX+bbvGaOuscwWrGsr9V8+ydsFqvwYKwpzHUK8N3i
 cHKJWT0HwN7zhwTsAHFaGIUsyohtbDahzkytqvX+aIh/CyNg93pKpa1KsOrTunREt62b
 nHh1m+UapIkIwMaXRf65nWSGOU3irnRc9RnSR9x8A9Yp9tGra0e/Tu2VZoj1l0eiUi8O
 CbYuk+LyonYCFFHtZynebWGExxUISWIoOvIQyVosob8PKiirQSAS3O8uHWaS6RnSr+5d
 DFbF/slh1qs43BmjeMyNqX1xsZAD7z/RVGs0gieqH/vBJPan9l+cj1eKSEsdGys0jAur
 SkZw==
X-Gm-Message-State: AOJu0YwED6lQtAK/8A+26PYsJbgIrtbmS48WIasqsv32Nvgnd/Ig9rlU
 vIyUQ/IM95dbVWKiZviosF6U16L9lmnL5CrPZGruuchAZMo/gFBI5fJQ7Yr/+u45gcXGqDbfiUr
 HUi1B9785GgcRCvgwMEhCNpS6pleVUtTuupXBzlHBKKLRSULQMPI65fVmfzZMmR8IQaFuZGxvVX
 n0qV1tN55cKSj4Q9DvK1tF0hjH+mjyIJzYJcUj
X-Gm-Gg: ASbGncuk4si66N6gDdYWVT+Y8KdPcy8oJJ5dnV0zjue//I32GnYygNBlOzfqW4MSH7D
 pHcjGMk7MytFDaI3jZ8+Y48heCWVr8l0/Bw3OW7ktQSjrF4d9vN6ZI4bKRxbkKbrgHu+fKGqiAR
 9cXZLuXM4N7NCfFn/BVyHds7mF/hHd7TLSpKGmKlcu6W9S8PxwDivxWaeDiccZb4kzJwa4TQnDI
 43cSGi0W2B9gScYHPEnwl+l2HcOj95OU5Wu7ibNIMTAkoMVDWXfmqU=
X-Received: by 2002:a05:600c:4fcc:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-433ce410337mr105830885e9.1.1732521910104; 
 Mon, 25 Nov 2024 00:05:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1zBCfDrGIynB2ASOwAQjAJVdBuUepbytkFetSs2xQwWRCpw2J8N5+BIUNDD8lv6ehM+P6Kw==
X-Received: by 2002:a05:600c:4fcc:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-433ce410337mr105830325e9.1.1732521909421; 
 Mon, 25 Nov 2024 00:05:09 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349f2e1b3bsm32303775e9.25.2024.11.25.00.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/8] rust: qom: move bridge for TypeInfo and DeviceClass
 functions to common code
Date: Mon, 25 Nov 2024 09:04:59 +0100
Message-ID: <20241125080507.115450-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

This is a first step towards modeling QOM in the Rust type system.
This is by no means the final state of the bindings; rather, the
one thing it focuses on is moving unsafe code out of devices.  This
in principle removes code duplication, though with only one device
the duplication is still theoretical.

In particular the pl011 device includes bridge functions for instance_init,
DeviceClass::realize and DeviceClass::unrealize that take raw pointers
and call to (usually safe, though not always) functions that take Rust
references.

These functions would be the same for all devices; parameterize them on
a generic type, so that the implementation of TypeInfo.class_init can
reuse them.  Likewise implement TypeInfo.instance_finalize simply as
std::ptr::drop_in_place, which automatically bridges to the Drop trait
if the class implements it.

Some of the traits resemble those in Manos's implementation at
https://lore.kernel.org/qemu-devel/20241024-rust-round-2-v1-3-051e7a25b978@linaro.org/;
in particular DeviceImpl is an extension of his same-named trait, also
covering properties and vmstate, and ClassInitImpl for now is the same
as his ClassImplUnsafe.  I have not added an explicit "Unsafe" suffix
because I don't plan to have separate safe and unsafe versions of the
traits, just like there is no DeviceImplUnsafe.  The main difference
lies in the usage of generics and monomorphization over macros;
generics are always compiled and any compiler error messages point
at the implementation rather than the invocation of the macro.

While at it, the series starts adding documentation to the QOM machinery.
A lot of the extra lines of code in fact is documentation and/or safety
comments.

Paolo

Paolo Bonzini (8):
  rust: qom: add default definitions for ObjectImpl
  rust: qom: rename Class trait to ClassInitImpl
  rust: qom: convert type_info! macro to an associated const
  rust: qom: move ClassInitImpl to the instance side
  rust: qdev: move device_class_init! body to generic function,
    ClassInitImpl implementation to macro
  rust: qdev: move bridge for realize and reset functions out of pl011
  rust: qom: automatically use Drop trait to implement instance_finalize
  rust: qom: move bridge for TypeInfo functions out of pl011

 rust/hw/char/pl011/src/device.rs       |  85 ++++++---------
 rust/hw/char/pl011/src/device_class.rs |  34 ------
 rust/qemu-api/src/definitions.rs       | 140 ++++++++++++++++++-------
 rust/qemu-api/src/device_class.rs      | 114 +++++++++++++++++---
 rust/qemu-api/tests/tests.rs           |  33 +++---
 5 files changed, 246 insertions(+), 160 deletions(-)

-- 
2.47.0


