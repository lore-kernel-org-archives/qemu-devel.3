Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D9CD5BBC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWS-0007ye-JM; Thu, 13 Nov 2025 05:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWP-0007sw-IA
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:45 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWF-0007Jq-TM
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:45 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso2743966b.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029534; x=1763634334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RQ91nM5L2zJYd64DP2sn9NSAph1jmTDyv/4IpoM9Qk=;
 b=NePmby/xrgANgJb91rJN2zFpzDzc4wQqj5/du4WLPwbc9A2UGGvWRvK4prgn8BL3Hk
 yvSfTBoKCTwNsMFgiINgzYM0RNobNIIoYc3CdcoJ/OcZtqUqCqut0W4Z+ZPuJhrWvHGF
 wYw/gLJhhGZDtMYkl8YvOh5vUwuraSTQ24u0olKP9lVN0qMt3vN3ifN1v03fNGMroMvE
 SkJUAKT0pGAjgEVQfsX/OBgrFOvLqnPEGVnoBsUp/VefE+5woAHO8c7vM2n9B1Gp8vqN
 iH+4pndBX3Cf45g1athS7Q5bKem4S7zqBUnTmjf3k1px5+ILictg5/sHqRNF5LsDmNdF
 uHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029534; x=1763634334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4RQ91nM5L2zJYd64DP2sn9NSAph1jmTDyv/4IpoM9Qk=;
 b=Q313lL7XvDygz99z4HMiMqBkI9R0kV5Bxq6jmlQLyh86KpLruAT0Ebn6mnV+RCtG3S
 VnSsj8tga9P65pbA00izOtzqY8r1AfO3jCj1CA617xmmdzYoOwGTIQVgCnRU1wbGxcWW
 fPwDCuoFWh3J36N8fhEFC7YKlIM8WDUmeWokqpPapAtycVnJyHFHflfsTpnF/Uh8C26F
 ZHX+mn7Vjhh543kDltZktA3uZUZU5xjfZJdg4yaRwd3bADd47GNroiVM1ELkfg23rEpM
 Q1nPcJKbQ5ZgyVtJ15fGn6Y3mixqud5/KjEAdGWogbmDZVdljD6cqY+/3yr5E0Dbon2o
 WwPA==
X-Gm-Message-State: AOJu0Yxe0Y60Sq8iLxccUHcQHprSKiun5buU02mLlFWV28zVE7W4ssjP
 Xaxo3afr87hF00XwOw58dzkxMJL5ky1wQCg3NhNW0fJ2jz2sFMZvuQcE25P7WDbScmY=
X-Gm-Gg: ASbGncsP2rLPbQXkDp7K50JlaVX3GWkpJUQQBHEB+cpL3gyMr+wNTzVGQe4wTMQBiRJ
 atURs+u/JZBKAkIN76QUPYo3FU8y+HzbfVKZUUVlNAsSlE+G5CFXNggMTL94eYVXf6Pzp/OLqfB
 R5g3DbbhYWwwhlK3R0TbxzbG65FJTve31maQv4J2ybUQxKt5aoVRg+PMY88WqcpxlROAVUGV/b7
 yxtyuAKyXfv6qBbjzCQmHqSHswCshY8oyMA41kwd2kf2nmrn8VPjW8n5SL5/SA6HwjPWZGaK4jd
 Ls29hGyYhVWiGmtNriR0jSO4Vaolf9qz9EUagWPSYd2Rg5Bw5MfVMUuSVQlqAOEGQPbdaKF1SVd
 ksrpLID9QcKxSozOlK2z3vZyezz29jdZwLScE6r0WxM8yaWtIZ+345921E8H8oXc8JIqB9BHKvx
 Nk
X-Google-Smtp-Source: AGHT+IH9+pvsB9Ni2cu5kuvCdvMtVCZ/Jm83YSit+2xdUlFf6tmKByrtfFoItch8ylf1U3g6P+QsRQ==
X-Received: by 2002:a17:907:96a7:b0:b71:ea7c:e509 with SMTP id
 a640c23a62f3a-b7331a970f1mr628958566b.41.1763029534156; 
 Thu, 13 Nov 2025 02:25:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fd809d2sm133615866b.42.2025.11.13.02.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D397C5FAED;
 Thu, 13 Nov 2025 10:25:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 09/18] tests: move test_netdev_ethtool to share.linaro.org
Date: Thu, 13 Nov 2025 10:25:15 +0000
Message-ID: <20251113102525.1255370-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 tests/functional/x86_64/test_netdev_ethtool.py | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tests/functional/x86_64/test_netdev_ethtool.py b/tests/functional/x86_64/test_netdev_ethtool.py
index ee1a397bd24..ac8a92512cf 100755
--- a/tests/functional/x86_64/test_netdev_ethtool.py
+++ b/tests/functional/x86_64/test_netdev_ethtool.py
@@ -16,16 +16,10 @@ class NetDevEthtool(QemuSystemTest):
     # Runs in about 17s under KVM, 19s under TCG, 25s under GCOV
     timeout = 45
 
-    # Fetch assets from the netdev-ethtool subdir of my shared test
-    # images directory on fileserver.linaro.org.
-    ASSET_BASEURL = ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/'
-                     'download?path=%2Fnetdev-ethtool&files=')
-    ASSET_BZIMAGE = Asset(
-        ASSET_BASEURL + "bzImage",
-        "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
-    ASSET_ROOTFS = Asset(
-        ASSET_BASEURL + "rootfs.squashfs",
-        "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
+    ASSET_BZIMAGE = Asset("https://share.linaro.org/downloadFile?id=QD37GYYAJhGOgVe",
+                          "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
+    ASSET_ROOTFS = Asset("https://share.linaro.org/downloadFile?id=YAqnr0W8fruDh3f",
+                         "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
 
     def common_test_code(self, netdev, extra_args=None):
         self.set_machine('q35')
-- 
2.47.3


