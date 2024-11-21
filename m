Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3494AD6ED2A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 13:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE76S-00054E-9x; Thu, 21 Nov 2024 08:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE76K-00050k-5f
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:20:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE76I-0005yk-9V
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:20:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-382325b0508so655145f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732195197; x=1732799997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pS9ZcEKi8UeVfGQOjmFhhvFdLoLu3gKgufD3uqpB6sY=;
 b=C3vaFLNqijD3c+muGhqmG/3ihx6lvYVW2tNey+Mi6FnJr1csmePUCR+Hg+DJBjuvVK
 jP891U/feLf5MWjbad3f+dIHegZms4bj83azC222XvezU33C8TtW7v+OJWrCrP299T2e
 A2eI1mzyGKBfCop4dqMIzOX1NFPfHGC/VA7Cy6AcsdVrxqiYMDS2JIOC6tT0wr9O+NYc
 Q07d68w5KC4KhoxE/2EXgYd1f8a/JpbgkbjhQQ4t/pM+tXwKa2FWNzNAioYJ7HxuowIe
 9Aeg1s8eK+cnzzwl+rZspwTcVjhGO/jHJDeSUAAFIPurlaByn9ewGdIRcHounbODBaCb
 aB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732195197; x=1732799997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pS9ZcEKi8UeVfGQOjmFhhvFdLoLu3gKgufD3uqpB6sY=;
 b=dswfOjGfcv6GiYVRMbPiRm1SoopVcARTsW+jp2IFNyxlcL8m/qXYi2BTwQvVJjcV72
 0D4+Egn2bq60CeVXkLBHcVQFI7WMPTniiY16AANKJQLy71muaJebX+5IRCDORjH53i8O
 Kvo+JBO67w4kRujROxPqWYj44lRpkxaJFr1tGo6J26i1AHPIxYfQeJ056GnIos3oHxxg
 3tHOVH8CCN9Om1Ix7JCNGQquCwWPZTIgvwllwsGJLEnkQTEw176ymPhvZLwqTENNck4z
 jH6VCJFsxevrktYxezywn1gtxwKTHB5JECkksCTCsMef+f+UbTOWYddbSHM/nLAjCSA+
 Hxrg==
X-Gm-Message-State: AOJu0YxguzGYEL6TdjQtdcXVDtg+ZpHpu+7EJEyB12UCvhvta7htm+i/
 rw7PSAe5qGtjyDarcN48JeLiUkjO+XBfxvtHkUVOADMEOuEO6vQbgE9j4K/kab4CncnISEuqNFg
 L
X-Google-Smtp-Source: AGHT+IESdmb9pXFJrCA77H3syuXsd3hMKpGtGXSwa+Q8giy5eFFONyKmB1caxlhHM8zS/zllQcV9Jw==
X-Received: by 2002:a5d:5887:0:b0:382:4fd6:405e with SMTP id
 ffacd0b85a97d-38254afa8ecmr4746611f8f.29.1732195196716; 
 Thu, 21 Nov 2024 05:19:56 -0800 (PST)
Received: from localhost.localdomain ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254905194sm5192750f8f.5.2024.11.21.05.19.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Nov 2024 05:19:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH-for-9.2] ui/cocoa: Temporarily ignore annoying deprecated
 declaration warnings
Date: Thu, 21 Nov 2024 14:19:54 +0100
Message-ID: <20241121131954.98949-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
---
 ui/cocoa.m | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4c2dd33532..0422dafde4 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -639,6 +639,9 @@ - (void) updateBounds
     [self setBoundsSize:NSMakeSize(screen.width, screen.height)];
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 - (void) updateUIInfoLocked
 {
     /* Must be called with the BQL, i.e. via updateUIInfo */
@@ -685,6 +688,8 @@ - (void) updateUIInfoLocked
     dpy_set_ui_info(dcl.con, &info, TRUE);
 }
 
+#pragma GCC diagnostic pop
+
 - (void) updateUIInfo
 {
     if (!allow_events) {
-- 
2.45.2


