Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4472DE64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8W-0000BS-Po; Tue, 03 Dec 2024 06:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8M-00007u-Jq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:03 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8K-0000ZZ-Eu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:02 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so2402508f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225519; x=1733830319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oU20d9+ticWenlMt5qSEyuabqKxdhpNZ4aYUuZ3tAj0=;
 b=jf3BFouz66Dhxe+w9UaceZCGMCoUREu3kg+rbWzuzUFEu+nzhaqTf2Xu0uCqn7P603
 iJ1G/2SCmurQWoMSES03TOAn2IIbX5hIgQ+znkbig+Pdze2kXOAB/a35ddw4R67BRFth
 TMZUaVHVLEzovbwAMBQgz9nbK2ZwmVXlKBtJeY1+wKlmypGlwN3moKYy9IcAn5Npuh1/
 bDtQWwaaOf8rZj/289eulxU558jwKLJ5J6a80obDLFe6NXVTu67lN7GBnFC98W1v+nUl
 S4FgLra0P6OQmZkb1Ct+HKIenDBWuJ07n/p8qUo9t6oyqNrITvsMWmQV4oec1Uuh3R4Z
 Fzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225519; x=1733830319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oU20d9+ticWenlMt5qSEyuabqKxdhpNZ4aYUuZ3tAj0=;
 b=p5v1VNqRLPbpqWRRJ8EovsCGh+m7ox7Vbs+mGzzyjdZtFMBCGibgdgPF5oFpwzQPV7
 v6FQWxcEtYFSLsOEYB5Lbu4dnQjYnVcfVpO37vFVMDy4UTWfMS1tjfS/CnmQZ6KemQmX
 hg0x6iFHruOuqESyWfcRwkQTOa4L7j9f8anB/iKhy96pwie+cw2c31Mt6gEK1uTbw+yb
 Ac9mDBEp7//p/X/KGE936hHQ3MoKqG5lQ8kGL8+xczgTpQlfCLyxHwgduOgjjn98OU/H
 TxA90bh+0MWGnX+9Ut237ODmrgY4xGy2nE7txbe6/kGBw3AqHvZbndJdRyzXBcJbF3ar
 z5aQ==
X-Gm-Message-State: AOJu0Yy+Y08r25r5gfsDDe7P5CUuhOlR4MZsafnviYw8MI5yNAVFKkJv
 UNHxCmtrbZfAaRrj0+6m+cMafisX/xB/pT5+Wpmmj1tY9wd/jCmEf73wY/ScnPwj61P5sNuKsjL
 lSz0=
X-Gm-Gg: ASbGncvWKZB/yF01ISHu+V2abaQmEqEbYjfrv3ZOSS82hpN6zd0qZ457ehvYrZ+aJfN
 Rn1nGePWVSAZ7tHal4y2e00icq4uTXLhI4iCe6PvJumeot/01zyOmKxv5NXpzWOJAj+0VlaozHU
 DzPMgDxXI+qkMUiXIk/6wQkvMj3Ltezhy6lKW4/lAxrLTuzajORweuYvVx+x6NcsWcLoRFKWM2U
 +b0Kqw/LI5XQLwn5aX/q96OP0HZAzBTUsuiKjKhBXn2LGCjIP7Mk7VQxuwGTwhxuy2KXCS5
X-Google-Smtp-Source: AGHT+IEtZWmegdICLI9aWtlYbudzUo9oMZeYY9rnzYt4FNGp82Yy25Z3gmDGzD1WC42+1GQOp4FHDA==
X-Received: by 2002:a05:6000:1866:b0:385:e429:e59e with SMTP id
 ffacd0b85a97d-385fd424daamr1880609f8f.52.1733225518677; 
 Tue, 03 Dec 2024 03:31:58 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e86f5dd2sm9167687f8f.18.2024.12.03.03.31.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:31:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 03/13] ui/cocoa: Temporarily ignore annoying deprecated
 declaration warnings
Date: Tue,  3 Dec 2024 12:31:30 +0100
Message-ID: <20241203113140.63513-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

These warnings are breaking some build configurations since 2 months
now (https://gitlab.com/qemu-project/qemu/-/issues/2575):

  ui/cocoa.m:662:14: error: 'CVDisplayLinkCreateWithCGDisplay' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
    662 |         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
        |              ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:89:20: note: 'CVDisplayLinkCreateWithCGDisplay' has been explicitly marked deprecated here
     89 | CV_EXPORT CVReturn CVDisplayLinkCreateWithCGDisplay(
        |                    ^
  ui/cocoa.m:663:29: error: 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
    663 |             CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
        |                             ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:182:18: note: 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' has been explicitly marked deprecated here
    182 | CV_EXPORT CVTime CVDisplayLinkGetNominalOutputVideoRefreshPeriod( CVDisplayLinkRef CV_NONNULL displayLink );
        |                  ^
  ui/cocoa.m:664:13: error: 'CVDisplayLinkRelease' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
    664 |             CVDisplayLinkRelease(displayLink);
        |             ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:249:16: note: 'CVDisplayLinkRelease' has been explicitly marked deprecated here
    249 | CV_EXPORT void CVDisplayLinkRelease( CV_RELEASES_ARGUMENT CVDisplayLinkRef CV_NULLABLE displayLink );
        |                ^
  3 errors generated.

For the next release, ignore the warnings using #pragma directives.
At least until we figure the correct new API usage.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-Id: <20241121131954.98949-1-philmd@linaro.org>
---
 ui/cocoa.m | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4c2dd335323..dd88115dc6f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -639,6 +639,9 @@ - (void) updateBounds
     [self setBoundsSize:NSMakeSize(screen.width, screen.height)];
 }
 
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+
 - (void) updateUIInfoLocked
 {
     /* Must be called with the BQL, i.e. via updateUIInfo */
@@ -685,6 +688,8 @@ - (void) updateUIInfoLocked
     dpy_set_ui_info(dcl.con, &info, TRUE);
 }
 
+#pragma clang diagnostic pop
+
 - (void) updateUIInfo
 {
     if (!allow_events) {
-- 
2.45.2


