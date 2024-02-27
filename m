Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7901EC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reygS-0005La-Qz; Tue, 27 Feb 2024 09:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygO-0005IB-Mg
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygF-0001x6-BM
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:48 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a9457b2eso9775535e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045016; x=1709649816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ij5ZdnIJjaB2d5j9f+EAx/syvnIPQ+iaNJFFiZwFn30=;
 b=vJchKstrVNiNk53ZAd2oONmiMJyS/I5gLDGVsQwqyRj7Dx7OQ198eqyjtNxc0Q/mNP
 Oy9boSu84k1WlnBhS1uECN+JT7VlxyH2eepUg/q9AnTwc4buaWAFsYpBzusPWE5wqbKD
 ASTAJ7aQTxpOnrKcYsi7F0BQc6+A8be/MJjs4om6Vu41Q6drmKqs3O5GEi9xZPI9tKA1
 XAlk3VMHUrc7Iclt3a1CM/cxpVjfdyDUp2qhYfCpentnFXQuRL2SOknhjfjBI1Qy014O
 i+pJVoeqFQlIwzXJ1mcmO85gWWYtOoxi0T04WPHCoJHYlnShdhH2a25cKz5t+AJhqzEM
 bKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045016; x=1709649816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ij5ZdnIJjaB2d5j9f+EAx/syvnIPQ+iaNJFFiZwFn30=;
 b=BnmCgpCeNp0T/c61s3po56eg3kVuRvZc0VbkAOgfpzpUge5Ldm9bdmwz+G2RhShUS6
 OgWo2L38LjeOdB5iKEZVXKjcUYN3hcxNWzSSzfBgMzMb02M5IEq9WY2zVc2lmeHh8o52
 dL3UdUQlrtrCDH00mB7E7X269HnvEytmF1u5gkOc2ER/G5Vcm7SuWgAyV6WEs9DaLyWd
 lr3dVJXE2DxqnJLcwrX4lBO1lfg9OdihKzXosHYfKByQ0pEN4tB02E6xRCRHy+QgDhEY
 7fxgEFrnHWgsuWrP+d1jjRXq4PEDwKqMJ+twkFU7mN2UGmTKX5zVcjHUXcxYekKAnO6w
 b7Yw==
X-Gm-Message-State: AOJu0Yw/4zoJfhQ3xAjsHiscSDt2+HZ/xnu93WC9SCjHjuNDRXaT63cF
 gVIn7386k/u4Nxv62doHz6IEkwxY28o9gfu2NXVRutkvRakob9zX7cz2M40+rG8=
X-Google-Smtp-Source: AGHT+IEGS2vftHGUTYkCBG6KHKkHoYCekFxa+LvbTXnZSRBpQQ3AZilviHOmiwHXb7kn03s57jN0vg==
X-Received: by 2002:a05:600c:4591:b0:412:a332:e1cf with SMTP id
 r17-20020a05600c459100b00412a332e1cfmr6651963wmo.1.1709045016391; 
 Tue, 27 Feb 2024 06:43:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l20-20020a7bc454000000b0041249ea88b9sm11378267wmi.16.2024.02.27.06.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C47C05F8FC;
 Tue, 27 Feb 2024 14:43:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 04/29] tests/vm: update openbsd image to 7.4
Date: Tue, 27 Feb 2024 14:43:10 +0000
Message-Id: <20240227144335.1196131-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The old links are dead so even if we have the ISO cached we can't
finish the install. Update to the current stable and tweak the install
strings.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2192
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/openbsd | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 85c5bb3536c..85c98636332 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.2/amd64/install72.iso"
-    csum = "0369ef40a3329efcb978c578c7fdc7bda71e502aecec930a74b44160928c91d3"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.4/amd64/install74.iso"
+    csum = "a1001736ed9fe2307965b5fcdb426ae11f9b80d26eb21e404a705144a0a224a0"
     size = "20G"
     pkgs = [
         # tools
@@ -99,10 +99,10 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("(I)nstall",               "i\n")
         self.console_wait_send("Terminal type",           "xterm\n")
         self.console_wait_send("System hostname",         "openbsd\n")
-        self.console_wait_send("Which network interface", "vio0\n")
+        self.console_wait_send("Network interface to configure", "vio0\n")
         self.console_wait_send("IPv4 address",            "autoconf\n")
         self.console_wait_send("IPv6 address",            "none\n")
-        self.console_wait_send("Which network interface", "done\n")
+        self.console_wait_send("Network interface to configure", "done\n")
         self.console_wait("Password for root account")
         self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Password for root account")
@@ -124,6 +124,7 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("Allow root ssh login",    "yes\n")
         self.console_wait_send("timezone",                "UTC\n")
         self.console_wait_send("root disk",               "\n")
+        self.console_wait_send("Encrypt the root disk with a passphrase", "no\n")
         self.console_wait_send("(W)hole disk",            "\n")
         self.console_wait_send("(A)uto layout",           "c\n")
 
-- 
2.39.2


