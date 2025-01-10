Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A454E7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtw-0004hd-53; Fri, 10 Jan 2025 08:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtl-0004c7-Os
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEti-0004h1-AM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so24061895e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515076; x=1737119876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APotq0+3EJuwxRhMo93UPR6eJLZZtzlTb7igZFjtUqw=;
 b=hfmJwj/JGnjqEKIv+NGXCMhd9I0wQ9QHfYB2+y25mOYtT6tJVyHOiuJ9gnUvtOF/wd
 NamyFzhgciwi4jniCqJOZIo/NJ+xaikZ/SAgrIqy9+E43E/YufNLXrqZjeUZjS9vG/KF
 MMp87jWSU21fh2BcZZ4nXTeyRJfPnmlO1/OyZhXbxmvIDtZj2LNsv7EX/IriijvbwKij
 cIPZvNnohwx7+2QmtRHR6OZqOV8rtaU0OIHFLtQ0WU5DoEDZBmO24OMM1nLIYyuzjBJt
 9IJvIOOMIisG+rlFNHvzkaDqu14UlIm3dS0kAbWGGP1tUeA629IetG38bM3EDB70Seyu
 gYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515076; x=1737119876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APotq0+3EJuwxRhMo93UPR6eJLZZtzlTb7igZFjtUqw=;
 b=ePlJKN0F0c1EkdQdjX6x34gCf0BEBzNDatUanCH1wsGOFNo+8LtbYGcV7OO2qzRAzS
 IB0WaqtXbgS9o5GcUo1p3J0jliRSy9bZ+KjrBcaGb/FcqTi/TAKSoGszhhr3ws7C2PV5
 +F13wFv1usuVSQcw+7E1YielMbOnwSvLstNHGnhWQovhUvDgTbq8EOGNr7tGVrdPLpSj
 PmlH3SeltuLqn3I6H6dZRuXuf0U+gYW9fkYeymVLa/gh1iBxcR0pupy4hyS32fYqTBxT
 prXqn2ZFmxV6kMRs+F3ImORsIRL5ih1f2B9lVzLdgIsjMqyjTLWAUECaveo6b0mTXkzN
 /fgQ==
X-Gm-Message-State: AOJu0YynD73B1Gzkft9bR8GTgVDK4uklqtT3OCnzUMkUQerw9ncEXDHE
 Zm9u9CO0252BaWzquiNQfzTgH4SKIsBQwKndDYYzPB8cMdHJe8koKS5fqEJyPnU=
X-Gm-Gg: ASbGncsS+GKu65oXUWpvzI2WMlvFHSu2Qu0xokBlJJTePTVXPXOvIQozZUMUdsNBac7
 U7qIvJ0lztrAKW46QGUmC8gW395c2wA0HR6qA2vUPfHRuHMmnlsqgSY/w6bJLNAU5oWDHAQDUjD
 6ilVOoSjHBghEHs3P6BaspMy/c1uLITECMLb6zgZ3W+dZMlzsyz2jw3IvPSaMDseqWdL2BFCFap
 HqoKrW897IhJIH58/n0oBWlKRar0V8yeuXPeKnL84HIGpfcrd5uDm0=
X-Google-Smtp-Source: AGHT+IEMWjeEHuf8FXmbx+NJ9dMikVeNxS5TkPUIIYhzTDW/MwXk6AFg4fQARvDQgF6vXVb14cyo/Q==
X-Received: by 2002:a05:6000:470d:b0:385:df2c:91b5 with SMTP id
 ffacd0b85a97d-38a87085becmr10454512f8f.0.1736515076489; 
 Fri, 10 Jan 2025 05:17:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3834fbsm4482071f8f.26.2025.01.10.05.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 479AB5F9D7;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/32] tests/functional: update the i386 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:24 +0000
Message-Id: <20250110131754.2769814-3-alex.bennee@linaro.org>
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
Message-Id: <20250108121054.1126164-3-alex.bennee@linaro.org>

diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/test_i386_tuxrun.py
index c593ffbe8c..f3ccf11ae8 100755
--- a/tests/functional/test_i386_tuxrun.py
+++ b/tests/functional/test_i386_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunI386Test(TuxRunBaselineTest):
 
     ASSET_I386_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/i386/bzImage',
-        'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956')
+        'https://storage.tuxboot.com/buildroot/20241119/i386/bzImage',
+        '47fb44e38e34101eb0f71a2a01742b959d40ed5fd67cefb5608a39be11d3b74e')
     ASSET_I386_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/i386/rootfs.ext4.zst',
-        'f15e66b2bf673a210ec2a4b2e744a80530b36289e04f5388aab812b97f69754a')
+        'https://storage.tuxboot.com/buildroot/20241119/i386/rootfs.ext4.zst',
+        'a1a3b3b4c9dccd6475b58db95c107b468b736b700f6620985a8ed050a73d51c8')
 
     def test_i386(self):
         self.set_machine('q35')
-- 
2.39.5


