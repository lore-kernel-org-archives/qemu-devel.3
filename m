Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09238C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvaVT-00040e-0c; Fri, 21 Mar 2025 07:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVJ-0003vf-4m
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVF-0004Oc-J4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so1493555f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742556328; x=1743161128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwalI5yLXIYOeimdWTNSfaCvh6YDdb17pOS3Ktb3jnU=;
 b=tMXr9FSMdIAnk+lOHR9mvLUnfSKrhGFfKvNQ5+SYCe2MxHrGhy3PMlWNuzZ99kYmua
 E3bbmZwKIyOrrjjeq+NFsgWEyw+BAC1lEj+MHklzJLQtlB14o6uoTNxOdkavQSt8Dgky
 GXypwXPPS6G1ShqPRbiYmm9FV0EQssYjtOR7fT/AC9DU8jdZMHg1Av7cp0jwi9/H7tXE
 Z/t/3EVgpQF8EUX8DJ/wVewqqcwYYO54ZipouRgAEvxx58xuMiQo8Q7lvzKvhm85yQVs
 s229yjtjFyRDXjCkoCXN/gaXbtd0WqoKFch8yfvqXExY9xM9/Js93kMOszeE45P+LDM1
 IOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742556328; x=1743161128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwalI5yLXIYOeimdWTNSfaCvh6YDdb17pOS3Ktb3jnU=;
 b=WMJC58KB1Ci+C0dN9AQNDQMp9+/28f16GahgDxlUQ0VZm1GJEZoD963T9AyCZl0il+
 tYpVqGw2CgsF6I1tUAW9Xz9tuKi6EbgoG+CxJ7WQ5A68euLJPmK0aTnHD6TJvS/BvAXD
 Or1j/JKoKBsUMBg3oJT9k0IK+nPZerW1XQjzNPA+odPYzBwcsOg08+qWZhFWPeTF6FE3
 I+geNPykTNLmiThl5f9L5bn4gcvOo8xfVe8140Pdaj+e1FT0WsZgvNb7AGY6wPeMyMzj
 N7aB7aGjRgQrygdyhrwtpCVjrINSYuLis7xjSfWSO/mIrlnbXFXkglgRbhcISK858de4
 FV3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3cqDGc86+dMEnOHDzSy8oZ8dy+LveFYLeJIDtIwkpoL+JWTBm/yZiV0lutl2hC3UWKSxcfJ0qtnle@nongnu.org
X-Gm-Message-State: AOJu0Ywe69yj8LyrTwskc3ZzjBfbwrWeWQmbr8J6/5GRguFORYIf3t8p
 divNB0NPDnYNuOo6Exg2Mrp/ZE87DkAvaCeN/2CObyD73Umxmz3oc4Q0s02b5M4=
X-Gm-Gg: ASbGncsrEZjwtenrYhyE2yDSIEQIz5VA000HkRTJRW24p46KE4ACOShyFWaNEev9H9F
 cSLy3PTNdaNHlzO5zxMK1JH5OkS1DuDXeFit6ha1sm2I3cW63+HCycokS8WQxK4Kc2PNPA2zI76
 w7pPjI004GKpWIL39d8zbEN0GyTX/LWk5opgQrmk4UGCzXUH1XIYAVTfW6yZzZpu9Y+Jc+I1ar0
 r+6e+4f4o8vzvFPnS7LpQNzKhvRj1FyB6v6yBoYNRxSJ27I60V19A06a5NXbupw0Q0v86AYEIuK
 lhkWkGMQkjJ8c1xnFq4fj+NRbaYBMMsvJONbpkow03sqnSZn6/T9Rotjvq0Xxw==
X-Google-Smtp-Source: AGHT+IE3/7gPRhq9M4uWChALZapeqxzwR8Z6Lrx37jILxF5s+bFxLlE7PcB/6MXAsnvi0cr1Ofhh6Q==
X-Received: by 2002:a05:6000:188d:b0:391:3124:f287 with SMTP id
 ffacd0b85a97d-3997f9014a6mr3430455f8f.16.1742556327776; 
 Fri, 21 Mar 2025 04:25:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6767sm2132614f8f.66.2025.03.21.04.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 04:25:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 2/3] hw/char/pl011: Pad PL011State struct to same size as
 Rust impl
Date: Fri, 21 Mar 2025 11:25:22 +0000
Message-ID: <20250321112523.1774131-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321112523.1774131-1-peter.maydell@linaro.org>
References: <20250321112523.1774131-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

We have some users of the PL011 struct which embed it directly into
their own state structs. This means that the Rust version of the
device must have a state struct that is the same size or smaller
than the C struct.

In commit 9b642097d6b7 ("rust: pl011: switch to safe chardev operation")
the Rust PL011 state struct changed from having a bindings::CharBackend
to a chardev::CharBackend, which made it grow larger than the C
version. This results in an assertion at startup when QEMU was
built with Rust enabled:

 $ qemu-system-arm -M raspi2b -display none
 ERROR:../../qom/object.c:562:object_initialize_with_type: assertion
 failed: (size >= type->instance_size)

The long-term better approach to this problem would be to move
our C device code patterns away from "embed a struct" and (back)
to "have a pointer to the device", so we can make the C PL011State
struct a private implementation detail rather than exposed to
its users.

For the short term, add a padding field at the end of the C struct
so it's big enough that the Rust state struct can fit.

Fixes: 9b642097d6b7 ("rust: pl011: switch to safe chardev operation")
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/pl011.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 4fcaf3d7d30..299ca9b18bb 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -52,6 +52,11 @@ struct PL011State {
     Clock *clk;
     bool migrate_clk;
     const unsigned char *id;
+    /*
+     * Since some users embed this struct directly, we must
+     * ensure that the C struct is at least as big as the Rust one.
+     */
+    uint8_t padding_for_rust[16];
 };
 
 DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
-- 
2.43.0


