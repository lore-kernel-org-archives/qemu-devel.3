Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A26CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSj-0001UY-Br; Wed, 30 Sep 2026 12:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSU-0001CT-7J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:08 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSR-00033c-C0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffa15f67fso27505985e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786822; x=1791391622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pP8CW0DdD6OVi1FZU8ePNpvrPuPVg9nsFqkyTueQ8JI=;
 b=WFrRh98tlu9nOB9+g95ihKR20A9ibtMADkyKOSzAW0n3X3O/9rHY6k6ImujyKk7Jxu
 h9l/8crTDiwd3lqRme8r05nyEKDynaZiP0M+ImDQg9yu96tgXvsPrxSVpxW6ivcXQuRM
 UAmtCX0mfofb10MkPBvagUz2La7G97SUxHo34SBhjMEnHtPmxI4Y2qDVBPpW7UA0pxW+
 N1s0oXjf9C6yQhxuWHc4gUChGapSzqdyHWzkZy1539fGLBr4Tjvy/4sKF9TiNs9o9c+n
 GapAJsPd5z9hShB3oLN2vqWLKruzxk/44whte9FfwCiZgqwOZtEXd2159YoL1cJk60m9
 ziIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786822; x=1791391622;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pP8CW0DdD6OVi1FZU8ePNpvrPuPVg9nsFqkyTueQ8JI=;
 b=dF1PBvj+yaIJV6xvWLcXHParECqeyLXc6+kcnZx8JUD6SeGVrwFyTnQADtgtJDTMwC
 wre6K0KzVHhDVzCHp/uVW8B2wVrzkcaRYiHL4jizxUaCqQ+uNXdu1quEOijjN08VL+eu
 rfH9XywQo0CAz6c5AYOJLKhwXHtxpuVVWw7sz6cG2A//UqgbxclbW9CETfa1M9z8Ye5I
 etiAdb5cJJeHAB4DDD8YznSjUERY2CB6cuI2LXtZopE/ILamXB23wQ9y2I0InOa9bdMW
 /7ykpyFFeg2CeLZSyT47waBTMzn32uZSyhxhJSVF3O9JpKqe1uW7TgxdwzqfzoQtMOA1
 BEcQ==
X-Gm-Message-State: AFuF++kGGsU3S5L4eFkHB4rQobdYZdIpJiCg8BkB0ybWAOOUI/ioGUTQ
 QiPJBRKqWketuFVeyYWCOIhPR6m9Xo7doCe2DUnY7vzsqV7AyhcfOxCvbeTC4yBZUBc=
X-Gm-Gg: AYBFou3R6jrYUVOHlrapbwNAom2kWbfuVxCHzmPmxYLnHTofT82Zu7oelb0PvFIIwUS
 l7c+xd3kwNDJ9Gdg3heHGIdxXwmdpUC4XAEgB1h1vC0/eHP6SVnAy0cuc93zkWlKyvAeYT4ai/6
 om7Bl4btJn58c2bf6QTr4Mqx6gX6oQcoUvngbaFqtvTDVbZ0tUkjx94lAST3+xvTAT+lRurXJ7n
 L8T4vDugjdOGNNzRb3g5ywgx5sWRF7O2K5Uf3icb6KJdEWupVmMa+mlBjpP8xF/My9qIxx8XkwZ
 pAK/ei93YHZZWqZykGSZQ8kziGGDh5Ezw1yry1sG4ajXHXo4W3fwN/f6O5G004F6B0AlyE/lbyl
 Ilid6k2aNxXFuMwbmW1rf8Ppaf1N8/MvMYo0oSSpd8ezxQ1mzKDzB6OtnWOsy9Zvjfti19qk/dX
 w3iB0yihy2UjrG3WuWHojs4lF0kqaqXD/TuaU+z4xYfzdT97RRSUXKDUI5BgT8WxV063rnqQ==
X-Received: by 2002:a05:600c:45d3:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a01aff9b3dmr28871565e9.12.1790786821642; 
 Wed, 30 Sep 2026 09:47:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca310dbsm17408335e9.0.2026.09.30.09.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F4EF5F9E2;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/13] tests/functional: split x86_64 tuxrun into tcg and kvm
 run
Date: Wed, 30 Sep 2026 17:46:43 +0100
Message-ID: <20260930164649.433573-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add an explicit "kvm" run to the tuxrun tests. Although running on an
x86_64 host would probably have defaulted to "kvm" anyway we want to
exercise specific features later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_tuxrun.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index fcbc62b1b0f..729f6447d05 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -24,13 +24,28 @@ class TuxRunX86Test(TuxRunBaselineTest):
         '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
 
     def test_x86_64(self):
+        self.require_accelerator("tcg")
+
+        self.set_machine('q35')
+        self.cpu="Nehalem"
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
+                           rootfs_asset=self.ASSET_X86_64_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0",
+                           accel="tcg")
+
+    def test_x86_64_kvm(self):
+        self.require_accelerator("kvm")
+
         self.set_machine('q35')
         self.cpu="Nehalem"
         self.root='sda'
         self.wait_for_shutdown=False
         self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
                            rootfs_asset=self.ASSET_X86_64_ROOTFS,
-                           drive="driver=ide-hd,bus=ide.0,unit=0")
+                           drive="driver=ide-hd,bus=ide.0,unit=0",
+                           accel="kvm")
 
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.3


