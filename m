Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ACEC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQrz-0001ZX-DY; Tue, 04 Feb 2025 16:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrw-0001Yz-Me
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:09 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQru-0008UG-Qx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:08 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f9e037ee4cso215534a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706045; x=1739310845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKWqfZr/ly3gmQRbhv9ZVAtml+TTp731tjlwJ2lULuY=;
 b=eomqP4u+XADCj1UcavmfVyUJ+2twetMrju3pARBKOlN5v5fSN1lQPtuE45eFcwf1Ok
 1pXtX0htRGuszm58t30UHfg5uZbol9xYzSE88crWMMXx7aI8pYxB5lmYVgvErJgtrjhO
 2k4qej/0JcDltHsYmdEIDqGi/gmvSPzNQ7wKF5ZR6WHLwaly+FTp/qSokYAF181+gdi8
 XA+hxqz9JImsiqjWPMLNunB2t6Usq58xplH2ZjIt8fxBhk/kLyuSKugkzfC6j9ioFXwT
 nWJA96UW3Dk21IKFF2IUxAx8WM9G+TuC+j+ZCH1Ua7zYyiSRd7QGDNIfWwYqarKoOFMc
 xtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706045; x=1739310845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKWqfZr/ly3gmQRbhv9ZVAtml+TTp731tjlwJ2lULuY=;
 b=mAQF+R5XKF3SWxiNONj4e7dVleey/AtqwUeAlDod8RGG9UGkSYJoKTrZRU6BduNb8M
 yVqCyteYGHxlVAtA+XuH0UFtm98+NkjWL9FGYwgG4ZwRHkHY8CC77vibe4tibv3mZ2wq
 9/b3dI9RcdpLmL4gOzwA18BSzzzNmi3ptcXqfC2a9CwR2VzOM5qk2aIRqeJSBEJ4Pwnq
 P4NNgpiNu9LM8XZR9qi3isQEklGQVDIm/RgPdYj+449JTPPsFQrrpDdo8ACXxS/GOfEG
 eoVkWaBYvQ1Pdabt4fgQS2fml8MJnw2qjuEYEY6W0v8679YNjWuGZ0vl+IoNyF0sR0Ri
 0ykg==
X-Gm-Message-State: AOJu0YwpgjIowO4M8mWERiUjQ+pGJYbjxt8WtBzfl3nGNVsUmCKIcU5w
 Bzev0IhnA0M1HNWpwj6Zp+6kWatAyLR+wHKN8Uc1X+R00MoDZkeGvISljHftdvf2zfvxH/TSF0a
 F
X-Gm-Gg: ASbGnctiJfrbmOIrj682dOHwWm11pbxFJiVncPeb8XwfjzbuYkQXcAzVpLIVG2Zwkv0
 DtjUxeFVSKasPteJzv0J4dOJDHvVLz0cu1BJsDUZO6top3fbuwn7wNMHhV+nnCVDSN1ymdkEkZJ
 P7vlCsDKaUSOZHMGMQd3+9WcSOP1k+vjFA4VmdCITAgN7TPG3ZlUoP8cIMXCzcon7nkrnxLNGM1
 HOyBWdjZkPeau0SwHzftlU1C/0+v+evBw2Skn2Q2Qb52vhn1yGG0CXYBygyGMY0XfsrTrPPFx1s
 mvd8wh9qXeRsrj+OL5Ssrikmhs47yt5WJEyqbZfZ4SJh64Q=
X-Google-Smtp-Source: AGHT+IFyZ+7AM4K8AzoeNjp1MuTEOjQSpKWtpPCakpHfXoZ/MTiZuyRaBVG3zNCVc4bvV6IZy9E4qA==
X-Received: by 2002:a17:90a:d406:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2f9e07fbf3dmr584609a91.24.1738706045239; 
 Tue, 04 Feb 2025 13:54:05 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v3 06/12] meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX
 emulation
Date: Tue,  4 Feb 2025 13:53:53 -0800
Message-ID: <20250204215359.1238808-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

For HVF this is trivially true because macOS 11 dropped
support for 32-bit applications entirely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 0ca83135e2..c80382befd 100644
--- a/meson.build
+++ b/meson.build
@@ -319,13 +319,16 @@ else
 endif
 accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
-if cpu in ['aarch64']
+if cpu == 'aarch64'
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu']
   }
-endif
-
-if cpu in ['x86', 'x86_64']
+elif cpu == 'x86'
+  accelerator_targets += {
+    'CONFIG_NVMM': ['i386-softmmu'],
+    'CONFIG_WHPX': ['i386-softmmu'],
+  }
+elif cpu == 'x86_64'
   accelerator_targets += {
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
-- 
2.43.0


