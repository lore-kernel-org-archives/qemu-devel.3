Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CECC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUVe-0006HU-VQ; Tue, 20 Feb 2024 13:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUVc-0006HH-6P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:06:24 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUVa-0001I4-75
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:06:23 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d26da3e15so2287530f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708452380; x=1709057180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gy0uyTZDmtZ+i4SSrESvP+mArKg9fpKgPqDQOb4z4qA=;
 b=qPmqN4pdMMa+z+S0GhLa5Ncrt7m1YplPxwrMpWav6M1wr0jACXnDsIOtkuXwdh3xqo
 P3+gONMmGu/EpvetjfrAij3Ww4wr8opA7kaDfrFOnRS03iUlkrlTJ8kACgyQrL/X5p09
 mzPBjV/YwtTO+4uJS2AtFC9NbWFItkZh2zXHIEiu6fCFhzmDxLzQGFx1cpAC/B/RNnJn
 QrFiaekR4qWDtO5pgXrOhoyuzrlRoSflTDHGlu8TNHTW1ag7KQogC3u8phcV9XcLaMPr
 OuKtFhd7ndAUJWMf182fq870AIGBRZHIJNqHhx3UcrSGD4yF4EPqL6F+jETCS3GyO5f8
 UoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708452380; x=1709057180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gy0uyTZDmtZ+i4SSrESvP+mArKg9fpKgPqDQOb4z4qA=;
 b=cktDqapljzXijpEK70rugTqZVmT6Aj+xMaAOO9C0XGvcq+HTRzGGCKQwL6pFe+leyT
 gXKqi+jMzcKn9NNWsQUFyG75ZjWE/3mMK/2Z4jG1uLY0uif0R8pBnfGsg7jKz5LHea1F
 O+IQAR9yQgvphtjPewGn5WBn4nMFGZKnMhTI0kXVvfCkq1Nxv1wjD8sDKVbUOkBWs0I6
 CM0whY71S8Fm1YdLRx530WtZh8bfxXCsMRRmoLvq+T9mmOqxxw+UmXlkf7JnY3GQDJfy
 pBBq5nf47ZgzyMjA9V2jm+gQhUi9FdY+WXB9S6cQYT+QMSRepSayJesBJnklW4+I3r3x
 g5/w==
X-Gm-Message-State: AOJu0YywFzqHd2ZcMe+SYHe0qlQI2ZHtiIgW6sOsp0N1Fs2hWrvtsaxO
 F/KuFJ1rvQpP/Pf0p0RP94lC/y4PvPFAwJszmjcxTeFrmglpZIZB4+PkR9lj2KoAsThW8GhD0Zc
 s
X-Google-Smtp-Source: AGHT+IHGR+SS+AVQ4IPmUrbKWP3oHBY9Xk/N6kPO3NJV4YZRmAITZj2VHXz2dr+cfsAACkKhcdQN1A==
X-Received: by 2002:a5d:4e4d:0:b0:33d:1fc3:68ed with SMTP id
 r13-20020a5d4e4d000000b0033d1fc368edmr12115719wrt.2.1708452380011; 
 Tue, 20 Feb 2024 10:06:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ay3-20020a5d6f03000000b0033d1b760125sm14730294wrb.92.2024.02.20.10.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 10:06:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH qemu-web] _download/windows.md: Drop 32-bit Windows support
Date: Tue, 20 Feb 2024 18:06:18 +0000
Message-Id: <20240220180618.158100-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

32-bit Windows is no longer a supported platform for QEMU, and both
MSYS2 and Stefan Weil have stopped building 32-bit packages of it.
Remove the no-longer-working i686 pacman rune, and state explicitly
that 32 bit Windows isn't supported.

Fix a grammar nit in the page while we're here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 _download/windows.md | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/_download/windows.md b/_download/windows.md
index 43c9ac7..8ce3f0d 100644
--- a/_download/windows.md
+++ b/_download/windows.md
@@ -10,12 +10,6 @@ follow the [MSYS2](https://www.msys2.org/) installation procedure. Then update
 the packages with `pacman -Syu` command. Now choose the proper command for your
 system as following:
 
-* For 32 bit Windows 7 or above (in MINGW32):
-
-```
-pacman -S mingw-w64-i686-qemu
-```
-
 * For 64 bit Windows 7 or above (in MINGW64):
 
 ```
@@ -28,8 +22,10 @@ pacman -S mingw-w64-x86_64-qemu
 pacman -S mingw-w64-ucrt-x86_64-qemu
 ```
 
+32 bit Windows is not supported.
+
 Some QEMU related tools can be found in separate packages. Please see the
-MSYS2's [mingw-w64-qemu](https://packages.msys2.org/base/mingw-w64-qemu) page
+MSYS2 [mingw-w64-qemu](https://packages.msys2.org/base/mingw-w64-qemu) page
 for more information. Any QEMU package related issues can be found in
 [MINGW-packages](https://github.com/msys2/MINGW-packages/issues?q=is%3Aissue+is%3Aopen+qemu)
 repository.
-- 
2.34.1


