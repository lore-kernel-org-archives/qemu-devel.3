Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3677D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sG-0005OV-9M; Mon, 04 Nov 2024 12:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sD-0005N5-K5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sA-0000La-TT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mcZD6E6f+0cy1tj4iIQ7hxtvKuCBvQujdLmN6nvks4=;
 b=QE0uu6zKFdFWWAj/Z5P6PXgNItN0FQrmRZPqVGnZBr4DGDk2p39X1rKZhrml7+g4dxicdr
 vQrP/000U4LhYy7Nder5Ch2b8OKxmM8kqbbQb5KsjC7IQO6yQ61pbcpqI9BoqdssweoIp/
 Qa+Iy1vwT66uHG8eyGC+o1el/3JRhJE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-fg93quK1NLWEfICovJ4BUQ-1; Mon, 04 Nov 2024 12:28:11 -0500
X-MC-Unique: fg93quK1NLWEfICovJ4BUQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4cf04be1so2355515f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741290; x=1731346090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mcZD6E6f+0cy1tj4iIQ7hxtvKuCBvQujdLmN6nvks4=;
 b=Au7VcbWwovJycrthgdSfBzNP8ILul6HVv9Fvvv4oKZ5Kg2iaqy1HA/iRyDJbpio4eB
 Zakp8Bf2Fc4tb687xkJGIOa2P2yQzErWQmQLO/d2A+wAgp9I8eb+WooNGtnsp4KyBg3B
 r1zSTguUvntimPthtAjKNbdEZ7MX7Zxoc7vOCcdnJvIqWODWuqAWxjTUZiBHgtJ0cl2p
 ThJojuwfDDwRhxUZX5owVIl7COyy5Jh9FW9hzztj2yeG15kwgV5k3crfJ+f1HK51m/t0
 qTx1dJCUzBAaKA8iDksOEZSIjQSyU8d6D9wR3wNIsduWWdeV99+lFcCY4Iwz91e+zKaM
 BJqg==
X-Gm-Message-State: AOJu0Yy5trrd7ZKnLLXNDM0Kusk+ZzCBCEoh86/oO0ABJ5U0fJdr4otV
 xXgH9du967XHpcLJ6xpyOehbFU+5I6s8MpebmsYMQgc3Kb8nBK9PmVW1SDlXL3zWPiLX1hAWrW/
 KTaAD7f04Xq2B1E2U0NRbIOqX2g15VogD+S2c2Z7q1OwD4Jsnv6Q5O+IAf+sro0RZVJ+Xm/Cquu
 3X9uZdgAImDSjM25lx+QO0fUOqGvAoWH9pzfMICUs=
X-Received: by 2002:a05:6000:1541:b0:37d:4e9d:34d1 with SMTP id
 ffacd0b85a97d-381bea1bbaamr12916852f8f.37.1730741289784; 
 Mon, 04 Nov 2024 09:28:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGejlL5lNi07Qp5ReauSa/W4LCvFqWXjZ4hzhSldNaliNL22gpp1OU8mblMpOJvft7Q+Iu19Q==
X-Received: by 2002:a05:6000:1541:b0:37d:4e9d:34d1 with SMTP id
 ffacd0b85a97d-381bea1bbaamr12916816f8f.37.1730741289272; 
 Mon, 04 Nov 2024 09:28:09 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e74casm13686402f8f.65.2024.11.04.09.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/40] rust/pl011: move CLK_NAME static to function scope
Date: Mon,  4 Nov 2024 18:27:00 +0100
Message-ID: <20241104172721.180255-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

We do not need to have CLK_NAME public nor a static. No functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-5-051e7a25b978@linaro.org
---
 rust/hw/char/pl011/src/device.rs | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index dd9145669dc..f91790ff185 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -102,9 +102,6 @@ impl qemu_api::definitions::Class for PL011Class {
     > = None;
 }
 
-#[used]
-pub static CLK_NAME: &CStr = c"clk";
-
 impl PL011State {
     /// Initializes a pre-allocated, unitialized instance of `PL011State`.
     ///
@@ -114,7 +111,9 @@ impl PL011State {
     /// `PL011State` type. It must not be called more than once on the same
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
-    pub unsafe fn init(&mut self) {
+    unsafe fn init(&mut self) {
+        const CLK_NAME: &CStr = c"clk";
+
         let dev = addr_of_mut!(*self).cast::<DeviceState>();
         // SAFETY:
         //
-- 
2.47.0


