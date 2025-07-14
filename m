Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A824CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH0d-0001X3-8x; Mon, 14 Jul 2025 07:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyx-0000Yl-05
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGys-0001VA-Mp
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=667vf6t5S/DRVJXbv1nK/TLEey3e0SHyQWAEBT4VGFU=;
 b=Vn1STIslWmF1PlI5/MQbjVlBTwDxUBSwxi/y/tgMNjOIk6sTDX1gT1xCIEAzjbTKD1q2ku
 Kg7qBCRGsWKgQZhxIsl7//4xt38sMSqCbCX8FnifiBM1koHgwMC9UaWnCePQr/mPr6qKg4
 Ndw0makRvgbdWz5a7WjJSWIxRwoSHB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-BsZT-daePcyIhRE6hL-uKA-1; Mon, 14 Jul 2025 07:04:17 -0400
X-MC-Unique: BsZT-daePcyIhRE6hL-uKA-1
X-Mimecast-MFC-AGG-ID: BsZT-daePcyIhRE6hL-uKA_1752491057
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so24419835e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491056; x=1753095856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=667vf6t5S/DRVJXbv1nK/TLEey3e0SHyQWAEBT4VGFU=;
 b=tOIx1iwTO8sqR21wQ7NC4RHm+spJrYrU6VKXMQzHz8Py0nqOLsnSG/9TdOYQZGHfgG
 yiNveOdZjjT7Z+MZkxPWsNd6U0BtYzbiUMaNtBhu7dsPHK3ejsy5X5Hwp7xHhCcIdEZq
 y6D/X7DB3Kl/AY6RLzHRIQp9IAfBYefa3lGo+hMdxzCXuXpMZIbu9arO9KwbvKIz0IFc
 5gzlARQqyXJOFxr69elg6BTTmLL+VTtXENCdm6t+J3RihhJbySQvlK6WPZvO1NegC3D8
 /7ZfapB4+JvXUyq1/B06rv9A46xcsWBmTJho/kESnAzvXJEToXEIlYzNq/EAn2LWx7F8
 Li6Q==
X-Gm-Message-State: AOJu0YwrmrM4Mf4Fr9NvlPARKK6A87kU1Ye+Y/Ug+vnLB+hV3XIedwD1
 kUJbhMGiiVEjX81BGh4SKWcJ988mYshF7WxSH0aX64DIaKjKL0kc8eZB2PtDmIgL126S3P5Jccw
 Be64VswiE9dBoOqUmkX8gC8wicVnB+ccPKrKpZtBbfLfvHOCE7FjXC+hMmPR333YRAkEI3qkbtL
 tRbONQyt6WhXVpCKPjvjcxJpJhrIKSGE1lhyAl8a/u
X-Gm-Gg: ASbGncvM0NYEAQvKSu7REa9iXY8OijfpP3LQe3jPigA56bnCfoNRwBo6hYOTJav0kGp
 b4gPgvp6Cm9MS8KH2In8QYHTOUdyWWdVBU8KhTf3wvedZ0MCkgq3B41ArSSsLxlubPBgbVjlZM/
 nN4epuj810ChQ1CSRkulSWXFEPeKATrnilCy+uByoF5Nn81U6OF1ZIBOA9Bdftez5G4peC3u03g
 40ARQfFFc1HE23qgZUOT7DvViP3fU0Jd8Z9DwNkl9vat6bWPZkCTlghPH2GxL705I4xMb3vG0QU
 PoXikanJwEcB5kamCBEgwMCESrKmTFFAu5uurZB/CXM=
X-Received: by 2002:a05:600c:8b84:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-454f42722a5mr124104255e9.3.1752491055897; 
 Mon, 14 Jul 2025 04:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESGHhWjE5RGHheDZpoOGG9ItJcpJ+IT9iQEwtKaRvBuRBbQHltbJRogO3jLz3kt8zqbTgK/w==
X-Received: by 2002:a05:600c:8b84:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-454f42722a5mr124103845e9.3.1752491055339; 
 Mon, 14 Jul 2025 04:04:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561d19a21dsm19827075e9.24.2025.07.14.04.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 03/77] rust/bindings: allow unnecessary_transmutes (1.88)
Date: Mon, 14 Jul 2025 13:02:52 +0200
Message-ID: <20250714110406.117772-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

This is a new lint introduced in Rust 1.88. It does not affect
compilation when using a previous version or our MSRV, 1.77. But with
1.88 compilation fails because we deny all warnings:

  error: unnecessary transmute
     --> rust/qemu-api/libqemu_api.rlib.p/structured/bindings.inc.rs:729:18
      |
  729 |         unsafe { ::std::mem::transmute(self._bitfield_1.get(0usize, 24u8) as u32) }
      |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: replace this with: `u32::cast_signed(self._bitfield_1.get(0usize, 24u8) as u32)`
      |
      = note: `-D unnecessary-transmutes` implied by `-D warnings`
      = help: to override `-D warnings` add `#[allow(unnecessary_transmutes)]`

Allow this lint, which even though it does not exist in previous
versions, it works because we allow for `unknown_lints` in
rust/Cargo.toml.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250703-rust_bindings_allow_unnecessary_transmutes-v1-1-692ca210d331@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 057de4b6467..3cdad0f0ec6 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -6,6 +6,7 @@
     non_camel_case_types,
     non_snake_case,
     non_upper_case_globals,
+    unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
     clippy::pedantic,
     clippy::restriction,
-- 
2.50.0


