Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C69DE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu0-0004k3-U2; Fri, 10 Jan 2025 08:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtr-0004eq-Bb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtp-0004k2-Gj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso22398325e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515084; x=1737119884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYLt5BP51hVy6G9xp0FYQ0lGfcIVn0JoIDACOPUe2Cg=;
 b=Y3aYZpY5W2EHauxOU2wyJ70MtEffeEVajsUb6QACoHEE0z9eppiI07N482ZkWHKm/h
 42Aces7zsK9HL7Gq7MWzyuaPO5B5awSz7sDONbGK9ube1SdeXy+TFizagXw/5NK2MKsu
 4MARaVfFhbw4zYwLv8u/EAXBSdOyGoTASvCgZCDsJ0STWHqC1aHvkNEYkneTG/azk9m2
 Bop9MR/dHuT8HZW/nYLkKzTlsbjPSPtK6qqatPzl8TmeGs7Vw5f94SstgLEYchDzRjMP
 uEbKOuvWICbRhjt1CUdLlJ78p+5llj5ybCHaJxddo92bgack7X11MP0McAdScG0LXKz1
 6IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515084; x=1737119884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYLt5BP51hVy6G9xp0FYQ0lGfcIVn0JoIDACOPUe2Cg=;
 b=NTsmDe0yOWG4HQuYG9viisdD2Gd+Corq8BV3UIkAmzq11qy2syMnLioDVGWuekV/f+
 o3txbd4sz5WBPxGOZJlADQf2tgj2qe2cHEFKlSBoX0ajSyTAeF3iRP0DqsCsLqN0M5Ho
 9OJz4TJfYtGkdrMWkkD+HNugyytGamNQhKyxG+Q/iibhCbEMNE4Klduy5We9mCvnpssb
 Qql3DW4ewmNvN3f5sRBiU4nHwqpx9Yi6lUh89xndQ9yHaah3G/e2A+OBMFKwc20YhYrF
 UnSwj/owXGrm/Z7vvvZw8o3MC9ZgIbV8a7Q9cTSNEAK7qMpKmx5MpB8jwu0mcvbQXeeM
 52gw==
X-Gm-Message-State: AOJu0YwhpSF3aAPKQtWLDrDIkmt0ZUi2RKxR6DfJgQsTlxpB6wJ63eng
 m/3BpUbAp4lJqaCGGh2PmIg4JL4i1g2UgV6QDOMyw7JnDT+D+cHj+daxLthJbjs=
X-Gm-Gg: ASbGncvXeWV4AZfG0WGomfD/gJx+yyMck76S5PHhfOPMMQ6hyIWKJbWQRf82rcphTLy
 WnUrh+83AyUNvrRxm3vjx8PY+i3nY0FEAQlFuJd4JTZHA2bS5thbkLwEFeGBQ6RlyfD0rafp3xU
 tNS12KeM80woqYRKWRA+e/7WX1UsfbhkR8U1WbeG5lrKGDWfvxfVoYN8LFwLD2lYAwlx/HIhYTc
 JDKOJvC0Jf9UO0gq9xfStEhdkJT7bfbU4be5ZkuDz0lBSY+UjqYPTA=
X-Google-Smtp-Source: AGHT+IFtEujC1AAxRcOvPG0Mp3pKJxOcTrcbRjhMOxSlvc5wzaEw+/TSe8N6xYQxgRP/ZKQobTgvXQ==
X-Received: by 2002:a05:6000:188c:b0:386:8ff:d20b with SMTP id
 ffacd0b85a97d-38a8730ce41mr9558139f8f.27.1736515084029; 
 Fri, 10 Jan 2025 05:18:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d050sm4623995f8f.15.2025.01.10.05.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5ECEE60679;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/32] tests/functional: update the x86_64 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:36 +0000
Message-Id: <20250110131754.2769814-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Message-Id: <20250108121054.1126164-15-alex.bennee@linaro.org>

diff --git a/tests/functional/test_x86_64_tuxrun.py b/tests/functional/test_x86_64_tuxrun.py
index 4f96139871..fcbc62b1b0 100755
--- a/tests/functional/test_x86_64_tuxrun.py
+++ b/tests/functional/test_x86_64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunX86Test(TuxRunBaselineTest):
 
     ASSET_X86_64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/x86_64/bzImage',
-        '2bc7480a669ee9b6b82500a236aba0c54233debe98cb968268fa230f52f03461')
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
+        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
     ASSET_X86_64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/x86_64/rootfs.ext4.zst',
-        'b72ac729769b8f51c6dffb221113c9a063c774dbe1d66af30eb593c4e9999b4b')
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
+        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
 
     def test_x86_64(self):
         self.set_machine('q35')
-- 
2.39.5


