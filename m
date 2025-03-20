Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBECDC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 13:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvG1M-0001Iw-UQ; Thu, 20 Mar 2025 09:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvG16-0001Be-Q2
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:33:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvG13-0003RE-TO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:33:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so4926935e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742477574; x=1743082374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBdmphdV8HlBXhupNUNKIMGYjH2p/y/FMhqozqFd7Iw=;
 b=m5mYhvYGjhjkUwzSf+0O7yUYdc+MKm2VL1LokWXPQUMDu48C5Cfzcy25YWE4wspv7i
 5DDCPoSs+rQKtbnYjF2Ttqmk/wtmYlFF3FZ4Sq75Q3vA6MWNS+QYb7adqAC28fcaaMXA
 52SZmPzAYOVcsIlCvfDaoHCgADPI0ajzhksExH2NGiqyd9vPQjMkSmlvI2m7oWbtLwTC
 OPrlF/qc7WJar4YdlQwykOxTFxu4iUAC/wm6Wzq95CBqC+yG6hhvELVxUS5OIMEAbM97
 YecTps5hr1veGTrKXYDr+AGzlYqWp5ImwO5tl1NnOTVfU+I6ytVeOu2QHq8v+s5GloKz
 zeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742477574; x=1743082374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBdmphdV8HlBXhupNUNKIMGYjH2p/y/FMhqozqFd7Iw=;
 b=PJfkRkf5OIngYBWSTMsvee+D3LxCgS1ALYAlgfhTud66u/PZN/oyTNCBTm9C+5TAZa
 EbykBJHh/ADYpY7LvKztRTZWMjoqRW3ZWJcZHmbQEh9+WU14VSG4raUY+v9F7rwji0ge
 2IA/fkj5qFkbl+iNN26kAHhLqtzPGC8F2HhJOp5lqsbW89gFuo60Wvl8UR03oUZGRYjD
 J+yHQ6WJGpW0iZXCvdAg91AH1sZ9Z1J1XQnnC/sCwxE4cJcYe/4iD+zD1r7+OBBhzMSX
 RvdRPvnZDctPtiIXgohNu+YCE/tjcXVzjP0t80r53NP21N3qNFX0ZR+djFuqV65m0TMN
 6Mtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsLirJOFMEPdDyVd3ZJQ+Ue0QHxcVkaCp5swQbfDqiD7v42x72YutM/Uz0w17RwUMRjs0kWZxfoeBd@nongnu.org
X-Gm-Message-State: AOJu0YzBfbEtQulb/LiTx2AaSZc3U9Bl3BvGRZhLpfNi6rooO1GRcrwj
 NB6IAJ3uxsyvBk9oqSoF2/kaILRaY5/jLLG+w8VB4KXch2w0WyRpqxJdYVhpASM=
X-Gm-Gg: ASbGncv/v/c8ym4T4dqJ/Dr3aX66j/AskEwPFdZ3SF4e1tk1G0Um4Je2RczC88kr4Ea
 TEy/U/KFrGJ+GP94sF3kD2PLBf79IVZwmnbjTsbaYcpsLIUmwb2xr0UAu8gnPmqC2v3whGhFHI/
 Y4aQgd5CgMfl+L2HvMCzlT6H1ZrxYxQdKr012s/jYCPuqPAwOhJcMRI8TyVOubzrtz4rXHD+xyJ
 zAsFG4hmpWmSytm4hoJXa2aie15EFeS1mxq36y0yf8ME2LYLxMDhKWOF6RRvBmFGZ7ofVTcr6hg
 9k8GmQqFRaavixsekNSdurMkbR4kd92VOZRhoLmGu8Iwaujx1+Hr+zCC6wFMOg==
X-Google-Smtp-Source: AGHT+IFURlQjzDF9o9ZapOmB6C5zMq2hxxC6V8luruFEpHNsX2MDK4VozP3XkEM5Iq8SNTKSclrvRw==
X-Received: by 2002:a05:600c:19d2:b0:43c:f050:fee8 with SMTP id
 5b1f17b1804b1-43d437e1703mr55734325e9.20.1742477573862; 
 Thu, 20 Mar 2025 06:32:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdeba1sm48804525e9.32.2025.03.20.06.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 06:32:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] hw/char/pl011: Pad PL011State struct to same size as Rust
 impl
Date: Thu, 20 Mar 2025 13:32:47 +0000
Message-ID: <20250320133248.1679485-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320133248.1679485-1-peter.maydell@linaro.org>
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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


