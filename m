Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F58E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtz-0004jb-JO; Fri, 10 Jan 2025 08:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtn-0004dL-2L
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtl-0004hv-47
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43618283d48so15497965e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515080; x=1737119880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPGscaPoZLhdOfaktuh9yWmMZY+64kVsJGcwXdqOLG4=;
 b=xs6pY3Z8ksagru2nWHWUt5Tck7+GuT+2pgn2qaomVYOzd7e5GhbiV/aETXsi0njXC/
 jusTF8LOc6E4xgyUNfPrZ35PLyOFt/82UlZuwVTy3pODt7Ryxw0+VQsz6ZUTR3pcWU4l
 a+Hv0eYwaDCG7U9VMu+MgZvVp/brB0/rAbi26DZGg4y0iZV3/Ro6UQxQDPFdqP9Ue2YG
 yhLeoI/nuawnfdsg02UXlP7OwrMwsmnCXdkVekUoz8Ifp3zZsTX9MLbv8dHFY3mkes6F
 gEaDstMTXqc2IadQrlhzZXuEHMepcjMYaip453Mxr/mW07qE4nhuLt0EoX5T2xrmLvMq
 xUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515080; x=1737119880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPGscaPoZLhdOfaktuh9yWmMZY+64kVsJGcwXdqOLG4=;
 b=uEsBadDZeXa2n7fiXa3jvvQzSac/08z2mpxcBdANGO1QvwC5tJ1nV6jF5q1ZBGTLw/
 wzFOT87EtKTMzbbRVuE1P3uEklPJOZCuOORijSuXO7u8mgoToCe+vAmtUbfH2DzTiRsY
 tvy6bvkAKb1hbxAIlPEOG0N6sTDmQf09d9dr0fXdeErVHpYGl7gDtgt4jdn1LZwFchy3
 3MNwmsuT95/AX5b1WkOkbpQ1DXE9M98A3dJLQikIyuOdxzLDg4zyKGZjSR0nX+rDIwvb
 3n4PadKol7pV3MkKDYqhmi7yHw+s1a8Mw2vvGhfFr1TBlDcj0CHKV1BKSDMlU5KFqmEL
 w7gA==
X-Gm-Message-State: AOJu0YyK6uHldJuJxgJIxVhc7Esta0MR2nMF38OG66DKEWVlE7Q5Hnmp
 MPu57yo1VKLJSboOhC8fboGYGMxdFBUWTf3tB8jI7RZ4jCOPp7sljLzBswr5NJ8=
X-Gm-Gg: ASbGncsNzR15kG00W3fZzxb2dqydY/MY6sF2ntk4WV9IpPbJcVq5PSxoaQ5iIHFjHAT
 iIPerxDkuSSZyyCjWZZDjIEGiQwKijPVFeNhlUxzuImiS1Kg1GE6K7eBO6YY8jCmGgU5XM8nvBF
 JTCP4kigedQN14cyQp32ttJtlkITAk2xxRxuXlEZvNXKhI93d373DiQFsCXr4nUzkRcottMDHDu
 Pt0IC2yr2aibQrmzn9COPZmCkskGyEn6GMdo6RED7yHgoCGYYQpmeY=
X-Google-Smtp-Source: AGHT+IGYEHcYtEork1L0s/18/9B8UF3/8gYPrZllb6AUmqakjswAjs71C/xNS1ZXzFB9SLRFOwQS5A==
X-Received: by 2002:a05:600c:510a:b0:434:a1e7:27b0 with SMTP id
 5b1f17b1804b1-436e2696db5mr103513325e9.11.1736515079696; 
 Fri, 10 Jan 2025 05:17:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f54sm52170095e9.21.2025.01.10.05.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A6BE5FA29;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 05/32] tests/functional: update the mips32el tuxrun tests
Date: Fri, 10 Jan 2025 13:17:27 +0000
Message-Id: <20250110131754.2769814-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-6-alex.bennee@linaro.org>

diff --git a/tests/functional/test_mipsel_tuxrun.py b/tests/functional/test_mipsel_tuxrun.py
index 2965bbd913..d4b39baab5 100755
--- a/tests/functional/test_mipsel_tuxrun.py
+++ b/tests/functional/test_mipsel_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMipsELTest(TuxRunBaselineTest):
 
     ASSET_MIPSEL_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips32el/vmlinux',
-        '8573867c68a8443db8de6d08bb33fb291c189ca2ca671471d3973a3e712096a3')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32el/vmlinux',
+        '660dd8c7a6ca7a32d37b4e6348865532ab0edb66802e8cc07869338444cf4929')
     ASSET_MIPSEL_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips32el/rootfs.ext4.zst',
-        'e799768e289fd69209c21f4dacffa11baea7543d5db101e8ce27e3bc2c41d90e')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32el/rootfs.ext4.zst',
+        'c5d69542bcaed54a4f34671671eb4be5c608ee02671d4d0436544367816a73b1')
 
     def test_mips32el(self):
         self.set_machine('malta')
-- 
2.39.5


