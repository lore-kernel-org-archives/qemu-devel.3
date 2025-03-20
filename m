Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E5EC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 13:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvG1S-0001Nh-JJ; Thu, 20 Mar 2025 09:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvG1A-0001FT-Od
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:33:08 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvG14-0003Rd-75
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:33:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso425422f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742477575; x=1743082375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcxOk5H8Mf+hivpUxneXluEV3ozaYLM9gcAGfs012Is=;
 b=uLGwHfsHBX6vpRpMcVBh5IyII1WY0kglkOaLW3Rlw2vqW/F180laGzhsEkAtKRMXsM
 OXtF0IFqMA+3SuS2O83C/w5wKTXtAx6EIFxWWCMHx/9Ul9MEec/jl5vcKjYX2Uou7lKx
 x+pRF/5UJXP6NscZ7ziysxngbDrUV403fwpaDDiJ2rAasLrBNduRHWpw4m/ljhrQorTr
 MZBdoJgITFTmT8dLZymCcbz6WqlOfyB1kt7rkihxTXAo4u4LPf2+Qon/u/BShBIeb/RS
 k3dEPeJTmvnheOYUJjS4gqKb/7/F9IMnFIBn6lY1WC4edXAlMgHA1QULGAnhm7/5kCpl
 eX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742477575; x=1743082375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcxOk5H8Mf+hivpUxneXluEV3ozaYLM9gcAGfs012Is=;
 b=ZTWBkBLEp+VUQSLhYz+NuHKhd4B8wbTvyErt0Na5gFOQlLYZ0vjCO7+pKUXQ5rwsOx
 wv4/X4dROhqBgnc+aEpWDhHR+kcNirwwqsRrNFri7KnNMW24gnm6bUHY8nSN/mVlp9fW
 MbTGgHMkUNvmnDu0Shd+XZxm8yz0QWldrbrioUxVQ5jVFWcDJyL2RVOGh4E1r/eOaMDz
 yiQMxWqL5dfkmPl0lHYFrttGx2s9v5jwrr1n8aaD6aqjWxpSucoEYTqOySzK5vPlTA0k
 LbslEaES0ZbRi0fs3gBdIslhEGtHOxrTiEwzAYURzq4Xh9YFlNck5stUm3BOqvy0oBIe
 XCdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI7/7Y38w9Aim6NLRXMvms2FKEcQTtFo/Xnu72dfcPekqlqt3sqMFYPhX1xXuV4+MOZ+QRgqDEdtzP@nongnu.org
X-Gm-Message-State: AOJu0YwejgvQZP06tA/Y8UOFH2IV1tIn92KQ96Gn2NEL1K4Ks/gCMxf2
 ID8ATEzTYlSbK0BmV87xaKyaRrRO/JX0vcQxFvN2lYlihgud56cyLbCIqQL2O9geY4IY8DB0wPK
 k
X-Gm-Gg: ASbGnctZXTDpzBsHQ5WE05iE87Br+si3bLjcN8S6DSM0ou7WwpUeDRo4Z3H5peEs5Jj
 2ztW4/pfc0ok0KIELDXLQp5A6dk4VSeea92tgY0ueu7tP9CAUBW+zT6/DUaFtZYIKd2JKUCLUBw
 mRS2cPgJwMWbmV9wYOZABCJlovYsX6YYHEGjtPGT5SDuMfekfRDHbMuFndohTfzeIhHhMvFFYZR
 CgBgSWSdXzyge2GQo2jSZr5DF62YkxtyjVX6IJoUFktXppoP/wvSnpKmoDx4xM4QH9vjQ0u5B9b
 EBgR8OsfsEcLaw4QDQYinZyQac5kh2S3ORm4XpGv5mMVkRqB2BRP/EXw2CAyLg==
X-Google-Smtp-Source: AGHT+IFR5oINv+0Crr3f1aQU19UJw0EsirCW2cEBpooXpAcqVMvgxmK0ofGRL9Dwm9Ii1WjbK+8uww==
X-Received: by 2002:a5d:5f87:0:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-39973b439cemr6758857f8f.51.1742477574964; 
 Thu, 20 Mar 2025 06:32:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdeba1sm48804525e9.32.2025.03.20.06.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 06:32:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] rust: pl011: Check size of state struct at compile time
Date: Thu, 20 Mar 2025 13:32:48 +0000
Message-ID: <20250320133248.1679485-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320133248.1679485-1-peter.maydell@linaro.org>
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The PL011 device's C implementation exposes its PL011State struct to
users of the device, and one common usage pattern is to embed that
struct into the user's own state struct.  (The internals of the
struct are technically visible to the C user of the device, but in
practice are treated as implementation details.)

This means that the Rust version of the state struct must not be
larger than the C version's struct; otherwise it will trip a runtime
assertion in object_initialize_type() when the C user attempts to
in-place initialize the type.

Add a compile-time assertion on the Rust side, so that if we
accidentally make the Rust device state larger we know immediately
that we need to expand the padding in the C version of the struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 rust/wrapper.h                   |  1 +
 rust/hw/char/pl011/src/device.rs | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/wrapper.h b/rust/wrapper.h
index d927ad6799d..d4fec546571 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -65,3 +65,4 @@ typedef enum memory_order {
 #include "exec/memattrs.h"
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"
+#include "hw/char/pl011.h"
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f137b49feaf..f9b1c307289 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,10 +2,12 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, ptr::addr_of_mut};
+use std::{ffi::CStr, mem, ptr::addr_of_mut};
 
 use qemu_api::{
+    bindings,
     chardev::{CharBackend, Chardev, Event},
+    static_assert,
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
@@ -124,6 +126,12 @@ pub struct PL011State {
     pub migrate_clock: bool,
 }
 
+// Some C users of this device embed its state struct into their own
+// structs, so the size of the Rust version must not be any larger
+// than the size of the C one. If this assert triggers you need to
+// expand the padding_for_rust[] array in the C PL011State struct.
+static_assert!(mem::size_of::<PL011State>() <= mem::size_of::<bindings::PL011State>());
+
 qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
 
 #[repr(C)]
-- 
2.43.0


