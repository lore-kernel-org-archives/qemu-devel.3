Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECACC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfr-00067U-DC; Tue, 02 Jul 2024 01:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfp-00064H-8m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:26 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfi-0007gX-4T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:25 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ebec2f11b7so42175661fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896595; x=1720501395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53/vSX2DxNBsJLADWGWkRKviz9VffjPRlWD9A4UquyA=;
 b=h44J3IKFJNFo1CVZoQVIyuWP7fu2QjPjDvTjCIGBF/XgSCbqXPpWd+L/j8PZdefA6K
 PaNdIPy11gRsHe2JIpIglfV/t1rWFUL/r4VDSR0SaFuOYApK5l/w8/X47PusLgE8K9sF
 NsKe3FZepOjQYnpS+DmVsAnw7uuM7oTJ61P6YskW1p2/MVLSmciC/ta7056dI/jyv24e
 aQc37x9RQtXJvVYmvbi/GqoJXtj/LPpHBJuvwPpjYhTnlp95iuHubLGk2Q0BoaXrrKzW
 f0VAiqFpETddHBt6cnUCAqpcP6I/vZwjJZhDFLjNH3grmb/oCgV1AW+N4JhOYFAacdSq
 EwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896595; x=1720501395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53/vSX2DxNBsJLADWGWkRKviz9VffjPRlWD9A4UquyA=;
 b=GDLFuC0pg5Gmk/NShN69nge9dOKVhSoInemhFUvNGaDUch1f45CHJkqa1h43ntIbqK
 5KShzqIYtzjeZv9ZTtssfy5QExhaEW+ZV6H/qFv1fZEN9qGd+dXkntMzoRGo00DbY/uU
 lCoz0DKwnOp0ycIS7QrBt4CJ5+Gj0GW/z3bhf5Xv6ShS32hb4cigv6wyaoS6x2MBs5KL
 pY4HqkwaRELFviSEAGEDTl6mG7GN6oo91MIpnuGOE9MxJwlqggrG0ZUTNOY70zo+PXCs
 zIx6cdYGGzxaLM1j6dkd2f7dBlUPg+L0qkInUMy8wOTybfWPtvNo+Cb4rZGCIRst1/kM
 fXzg==
X-Gm-Message-State: AOJu0YwJepa28cPqZ9VQx03JAAX84j5WQyBKDnngKrxgBPLwrvBCOjBe
 s8YO+uNvyuRhREMSSeKx5csfFPziSwRdN6l3+zrB/TEATU0ccLfpvMxhK4IGk60ZvahljzYO8jx
 M
X-Google-Smtp-Source: AGHT+IF3inc+SMBrVDi1A04FMRpqgod/1yt8wgvcaHOIxvX68MHQgQg1wjKyPI3/bS5sNX92mQhpdA==
X-Received: by 2002:a2e:a902:0:b0:2ee:5ec1:182f with SMTP id
 38308e7fff4ca-2ee5ec11972mr63928441fa.6.1719896593167; 
 Mon, 01 Jul 2024 22:03:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257dee5f2asm91804815e9.22.2024.07.01.22.03.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:03:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/22] audio: Drop ifdef for macOS versions older than 12.0
Date: Tue,  2 Jul 2024 07:01:09 +0200
Message-ID: <20240702050112.35907-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240629-macos-v1-2-6e70a6b700a0@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/coreaudio.m | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index ab632b9bbb..cadd729d50 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -44,11 +44,6 @@
     bool enabled;
 } coreaudioVoiceOut;
 
-#if !defined(MAC_OS_VERSION_12_0) \
-    || (MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_12_0)
-#define kAudioObjectPropertyElementMain kAudioObjectPropertyElementMaster
-#endif
-
 static const AudioObjectPropertyAddress voice_addr = {
     kAudioHardwarePropertyDefaultOutputDevice,
     kAudioObjectPropertyScopeGlobal,
-- 
2.41.0


