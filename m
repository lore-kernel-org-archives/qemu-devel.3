Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9B3C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcwQ-0001U1-5Z; Fri, 07 Mar 2025 14:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqcwK-0001Sq-U8
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:00:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqcwJ-0001Ff-AQ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:00:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so1151532f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374053; x=1741978853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ov10O5xJ0eWfryJceZIMZwtAJQT4LfG+/G3LlkHNLc=;
 b=FCxTZz7SFMo7yvbl8hhLP1N3TajhIKMfjPb49eHNopwsx0hVl5+dTJLFHdErGohrV2
 5LIyh6kmlWi13g9pxRfUUeg4La/zHPJ6sUQQTG4fEemUY01U6aiIdOn/331YSbnoIY71
 3wSheb6dzllMdvwgkqKyGUb/UhwBxmOdFFIFNzjU0dq8s2oVxBOvRVEqe7y17BZuGnUp
 dmQ+8FBvB9m2v7LOkaUVfGvQvsYBqLZROT2ryrAXqlBjezwg0Xca17TcdL/Q53KHG28M
 m7qcsw/Q484nLloSRx4T9a67nJB9xqPC/GkbhrJqaTJKtT2wWXLRll72+75ymSI/6FsR
 CGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374053; x=1741978853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ov10O5xJ0eWfryJceZIMZwtAJQT4LfG+/G3LlkHNLc=;
 b=uot94m5LDdA9ui7dUTg4fnHKV7Dr9cvxAxVPF/2CjSJYArNJkb5iD4qSstUUHU1/TW
 /oBhFksavqiOymFwcvpVklcbHMMBDOjhmYGzKQBlTbj2fuvtPAarToI+lkINXMHoFjG+
 dUhNsCpmUqhhJ315FJdySdwzdqxVYE5Lq2Zra02Kv45cDjw4tNED1cUiRtorM1jPTj/A
 sTX5UbYqC1migXU2ZRX4RMHJ9+hQ97NASO7/pmGj7tQyIBf3NLgrKOx/42qQBjUl4Gnd
 eOxF+w3TpEcwPSB5tJv6zQ7en/ZjwhVrnBCtkRlXb+OOjJyvLBlgN9cQihlCFfVmSBeH
 0T7w==
X-Gm-Message-State: AOJu0Yx+K8u5wK3VwiORotuvXxzQlXi91HuUTCJ1Szj7+1JYNvU0CSER
 TOBz6PbTStCF4I0Ie2Ul2HhXvhafpPzNRH/UOiQkmcerrdUCpw99vqnvfuwAKMImVL4GlAh/af4
 2
X-Gm-Gg: ASbGncv2GV97sAJbzK4tDmUOtRlAFp5ciUH+dyMzccF1oULOgcFSfCS8vX9BBClFp1h
 hM3RKFCPcX1kI4Pf7b9GvupPg38Dr4oeuDTf9kVmoOgf3kT4n3Yn8pU5+py41sMc4E+JHEcztYa
 9XXVHIXRmOHM4ZpsKXbomT2iV26lC2js88OaGLypiulyI7bu61s8w0O2kCbU2Tj3UBuF+paOlRk
 bj2LaqSxj0lGMinuBuYU96WW4WZig0i7NYl8HR5DHeZRlmFY//f36vVJ2llNFzyMUdVKPJDxLqw
 B4e1TMYgHqw5fNgnP1+1OimOOODtzV9/V5IoWS4ugHmfNiw2fg8=
X-Google-Smtp-Source: AGHT+IHUtqLHeofBpGNp4lhvKCSdp/4teFVcM8y0kf9G06pVKZE2dh5JQYZ+FQCvLyjEOrTugGG4Jg==
X-Received: by 2002:a05:6000:402a:b0:390:f6be:9a3d with SMTP id
 ffacd0b85a97d-39132dc5627mr4175296f8f.35.1741374053458; 
 Fri, 07 Mar 2025 11:00:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2eafsm6357147f8f.68.2025.03.07.11.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:00:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] rust: pl011: Allow NULL chardev argument to pl011_create()
Date: Fri,  7 Mar 2025 19:00:51 +0000
Message-ID: <20250307190051.3274226-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's valid for the caller to pass a NULL chardev to pl011_create();
this means "don't set the chardev property on the device", which
in turn means "act like there's no chardev". All the chardev
frontend APIs (in C, at least) accept a NULL pointer to mean
"do nothing".

This fixes some failures in 'make check-functional' when Rust support
is enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is my first Rust related patch for QEMU, so I've
probably got something wrong here :-)
---
 rust/hw/char/pl011/src/device.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index d0857b470c9..8098f762f4b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -713,10 +713,12 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
     // SAFETY: The callers promise that they have owned references.
     // They do not gift them to pl011_create, so use `Owned::from`.
     let irq = unsafe { Owned::<IRQState>::from(&*irq) };
-    let chr = unsafe { Owned::<Chardev>::from(&*chr) };
 
     let dev = PL011State::new();
-    dev.prop_set_chr("chardev", &chr);
+    if !chr.is_null() {
+        let chr = unsafe { Owned::<Chardev>::from(&*chr) };
+        dev.prop_set_chr("chardev", &chr);
+    }
     dev.sysbus_realize();
     dev.mmio_map(0, addr);
     dev.connect_irq(0, &irq);
-- 
2.43.0


