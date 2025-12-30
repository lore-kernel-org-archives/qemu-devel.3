Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FCAEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyf-0000uI-Fj; Tue, 30 Dec 2025 16:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagye-0000s0-2q
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyc-0002PR-LS
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so6064447f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128997; x=1767733797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7PdapgrHunfm5ufaIBcnmA01QT5kJZfbNKwQl9yuLx0=;
 b=WDfBO0zYvzInPNet6tE5rULGvjVHWOSTfc2L27ndrblzVOMWA2N/aDSra2sQr5h221
 32RYZfRNmuy8YWfqA+kHIHBiwLm6qgJZvGL8B7Yh3/prJIv5dAUE1hOishMh22HGsmkw
 E787eq00iYgAz4/ynHCcTsp+CnT8e8Uxi3gP3A/EQw8hINmYZuiKhZc7HEp1vvuHhFMe
 Y8xEyHGbkDn8fx8VqckPteeIJLMKMpHbcR3AmRMstLaKAMCuvit0M55nxzw3RHb7b/QH
 wk6FLciWx2UqOdfVBltoDwG8rw8puYrUWXe60ui38M1Zfew2s5nEc06Kc3q3cvqYwElK
 rrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128997; x=1767733797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7PdapgrHunfm5ufaIBcnmA01QT5kJZfbNKwQl9yuLx0=;
 b=ICDD6y43Ci+9CSieLTTZdpB4DODfKbMOVs/tO5Y1sUx6dir/gksPoXAnaI7EtPdxF5
 Y+H9OJ2z906SCVsHOMVrvTW5Eh9c9RBBJTiYIyovOZwxl7/NG7c8kuHeCYM7wxMTTBGb
 sY797f4X+Wcuyf6xxm+ttuJM0ukW5axJqg94iLySW9obxEQYksWloj9ypuxOiaAw9fr+
 iJhMsXWwUFKuSHun0tOGaYbMvuExfmF8PrYVl3NDEklE0F4XUPUOXylFH5wXoSfvc0n3
 fR8CHJUYP5TGVZRQYoVKVRxT5l3tvK1lraM6E4OBfgM3aNFAQB/SJYn4LTpVm9lfeoiO
 D7AQ==
X-Gm-Message-State: AOJu0YxFMdgEN40qkfBm/Ga/SLCGz7VYICmrlvWsZZfkXzeFtokfVfjG
 mPP4/6Oi5/5xTa2FpxcGMYOD8avw/wxXKyCsWEd0hf5x7PNDuKVlEBvYH1bwlJX/Pcwe1W9w+2d
 ASHJnM8g=
X-Gm-Gg: AY/fxX6O8BMN1IAuLpu2pN57OegxnbO1omabz+SFeGO3s2DyQwYY1JPXEnQbgqfIyC1
 Zuekvq4r+zq5XwJkfu6zSYucMdE/EklsjIdCjH3QXm8tJZ3vfCSdFT8hrQTKQ8LxbHVhRnuLQiX
 qzeo1/Uvvi+mRnsDOH9z3pOLEFYt0RBO7CpGUZzJdR6AxaHLCS1CIwBeVAuChlt+0sNmZmAW+9M
 8Qj8DBnSgkQVjookQXsQoH13pImWb/uPbkUr4FBKsQP4aqUG14+aHoSszb5bmLTSGkFmbL4LcLS
 EurWkljPMpc4KLgs/nxt9pzpgIk2hopJJ34LKMQEsgNTCVMRy87l/yx/LIOFDJ2oquMiQwopRc0
 G+YhOvvoDLPNhZSyVg/wBybqvM8kjjpCCKHsj2SrayoTYTpYHTVaBNdSWZATDubrzRsrCTc/jQM
 pKHLxl5zbfm6wO1DVswFUddiAsLnDUjUQUnjgG+BBmGM85H8/3TakL9rTD9X7j
X-Google-Smtp-Source: AGHT+IHXPKs9PxNNeYlpsWVwJ3ry3hi50m0/5RdfTwQKTgyPjAlTgh74o+8C4mDkQ82UxZUe+STFvQ==
X-Received: by 2002:a05:6000:200f:b0:431:7a0:dbc3 with SMTP id
 ffacd0b85a97d-4324e5061ccmr44912898f8f.29.1767128996741; 
 Tue, 30 Dec 2025 13:09:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2721sm69926145f8f.39.2025.12.30.13.09.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/34] rust/system: Stop exposing bogus DEVICE_NATIVE_ENDIAN
 symbol
Date: Tue, 30 Dec 2025 22:07:40 +0100
Message-ID: <20251230210757.13803-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

We want to remove the bogus DEVICE_NATIVE_ENDIAN definition
(by only having it explicit, either big or little one). Stop
exposing it to rust devices to avoid it spreading further.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20251224134644.85582-8-philmd@linaro.org>
---
 rust/system/src/memory.rs | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 4b3316bf767..4e06c16a0b5 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -78,12 +78,6 @@ pub const fn little_endian(mut self) -> Self {
         self
     }
 
-    #[must_use]
-    pub const fn native_endian(mut self) -> Self {
-        self.0.endianness = device_endian::DEVICE_NATIVE_ENDIAN;
-        self
-    }
-
     #[must_use]
     pub const fn valid_sizes(mut self, min: u32, max: u32) -> Self {
         self.0.valid.min_access_size = min;
-- 
2.52.0


