Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C351CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu54W-0006As-Jq; Thu, 04 Sep 2025 04:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54T-00066y-Qa
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:54 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54G-0003z1-9d
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:53 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ad4f0so1271189a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973497; x=1757578297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npkBvBgQubJv2X1tCwkde0FzzeXErtznEAkpfHdfgYk=;
 b=YJSqYBGfJzloAoEmG4V4W4s/srpTTlggN2pwLVIhrqC0ZPRVs+AUNZxQ8tOoi40Hld
 9KPpn+z2rxryeH4fczClJx/AXVQ15eixEPElawdRXTBsBJzkbbPf5mNmZRTqaII/29QP
 GaqF7dDlMRi1zoBQHHbCutZ5Ar1Y/fNqfCiMno2IQRYGk+hhTfxU91rwAQKJYmOW/1My
 pfys+jbx2MoxgjBb9DDosJiBMG2rU11sQyZKYiwOfYsoOH1KVA2bu1dkNhE/bRc1v4w8
 riNwQxQiZc4SGEkvKlV2/FSp4/n4Tx53/zrAl7o8f2AYAJ5rhpfdyLupqr4gl7OAzqa1
 hHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973497; x=1757578297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npkBvBgQubJv2X1tCwkde0FzzeXErtznEAkpfHdfgYk=;
 b=JiwEKHeb7Leq6LS9qgQQY4QkBUOZkUh85W5w8jdLJPW8hMm8Fs22Zg9e/KJMdf7dxv
 sT7183QA9PUDjyT9nuQPS6sgpYujq6LwUw1/PeMgRR8JmGF4gxCSYGrEIsSG4Io9YwBd
 cqJwGhh3AARLmb71kIIUioJDJlSRUcOg9nLh86oJ20Kf/g9T9r8E758ttJZxPXhdLsVy
 lBz7KYKdjsnzKqQzYuWLZfmkt+nHsEhx8ekAk8IvMBDVobN/YMn1yZOTZtSaYIAKDlTW
 /axXFsmVRM+2QWdl0j5Yb0/wniaDVqIYJU8cIoQH2hZgec3P7ZHz2iQuvzelZ3QLaj40
 F3gQ==
X-Gm-Message-State: AOJu0YzwqakRbIYT1qsvWT06PI4Ofxo5pX1dBFCNuBspZGrZLFfZD+t8
 KBMtaeP0lxFe9M4ktoP4fW9bDEdTS33mcM7t5NUZ1epWd8Fj6G/kPc+TXeIrpIwmMZxazkM6vyr
 lzs+T9qQKXg==
X-Gm-Gg: ASbGncst9YOXx0Vai09aoLnXgoWXxslU55aSQywYCk+FhV1t1cqyxRjIxZzbo6bHa/A
 /PjZ2DRC7jfiAfZOi2ZmzCALQiGUjJlGO6nuCPq7pWFTyqT6vHhfFp5QxxaQMffT0t3Rrxl7Fia
 AXTHInGGKmBU6PtltTElWsIFak+cROfD7Er+uMN6Y3h6jS43lJ9vpmnz05D4JR+EqFqCEvaxQHx
 AVcUp+0LCgHWOmlQxnMGc87X+sAWoINRbKdK4mqorw7RhoTilo5z4gGjJVHSz4gVYJU7G4482GZ
 pJQW9a17CP5z1Wn2CxE+5+f21ucIUqJ9wycenWXvP03XqUcYdkA3EsCzNs3rZHLbs+1lXDQdMHh
 bQwxUhtNgYr35yQGv7Q7oNYE=
X-Google-Smtp-Source: AGHT+IGEHcZDYSofdWUr8Bqng6QeMWXp/4Bc/tOlM+ePo4sSl/15T602ad6FUMUNNzOlh6Biq8rLZw==
X-Received: by 2002:a17:907:c1f:b0:af6:a10a:d795 with SMTP id
 a640c23a62f3a-b01df90c1e4mr1937783366b.55.1756973496744; 
 Thu, 04 Sep 2025 01:11:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff9918dbd2sm1326671166b.103.2025.09.04.01.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4E6D5F937;
 Thu, 04 Sep 2025 09:11:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 005/281] MAINTAINERS: add a few more files to "Top Level
 Makefile and configure"
Date: Thu,  4 Sep 2025 09:06:39 +0100
Message-ID: <20250904081128.1942269-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

A few files in scripts, and the list of packages in pythondeps.toml, are
strictly related to the toplevel build scripts.  Add them to the
MAINTAINERS file stanza.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed762..0f3e55b51e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4392,7 +4392,6 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: meson.build
 F: meson_options.txt
-F: scripts/meson-buildoptions.*
 F: scripts/check_sparse.py
 F: scripts/symlink-install-tree.py
 
@@ -4403,6 +4402,9 @@ R: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: Makefile
 F: configure
+F: pythondeps.toml
+F: scripts/git-submodule.sh
+F: scripts/meson-buildoptions.*
 F: scripts/mtest2make.py
 F: tests/Makefile.include
 
-- 
2.47.2


