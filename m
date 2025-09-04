Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23DACA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu54S-00065J-2y; Thu, 04 Sep 2025 04:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54Q-00064V-K9
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:50 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54F-0003yI-DW
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:50 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b042eb09948so122900066b.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973496; x=1757578296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYe2srEOzuPavOLB2dyXu3UjjKzRy0khJhV96Tf8OLU=;
 b=GPp0vZemNvNyJgvcR7/O10++xWClSA71KC2YLk3EmCU58+nOcwVld/gkAU18UcC2xN
 5ti4gyT27VrUE0WpiveCDdag1ltms/+YkSY9AbrICuf5Yap97up5tycDZ71tRjQZgUu/
 ZoCoGstf/NuDpw4icSMUpQn76CSec4FSkAwWSkrQ4m7eci+l5EZ566NxN3ORr8LrCKA0
 pa9CCem66pmIviovYrKG9TK9/8xVztbdLRltNYlVLDSaylbHG2OU88LiUf+v6lROoPBH
 vhPPRCprtATihsd3oY65xQ2a4oernB8ShON7D+fXOZjmrdf/gibQMIwPuvZ5H7s9SMTR
 pKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973496; x=1757578296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYe2srEOzuPavOLB2dyXu3UjjKzRy0khJhV96Tf8OLU=;
 b=E4qTz3X092DU8JGEx4r+VAtk4O9joc+ieZ9+/u1v0FeorzZJ5g43+te1avSbc2Y1Or
 qKIT14M6O0SnNcZXTTAsfxWZwwIliEpbt+zfboLU3zxwCgA7aYxpR3Fn95/TJHkNvHa4
 d9NT1eSrcoxianCg2VhJDuG8cHCHUJpzFUFRxsX0SgFeW3O+YI0lKBGdB1ZYiFzdIZ/s
 /P9KAScW3mGt7tizh1ra1ZhDMOt8KfvqIzQe4yG9fivgkmci6jWQ9/iGAuGz8s+waIJn
 1WAd/jQ5SaDsx2XEU2nZXwJFFfFuGle1xl0ErHZ0pf6PcKKo5LBlu5gnSZHb1lXEJCo4
 Ozfw==
X-Gm-Message-State: AOJu0YwA9eVjVn7BBdlVTyokTCpMfq/07EMqP7RENmj1Mb7BFLcASsl+
 W1NgYPFBhKnQoYN8QKiWfh8l4mAtOAxTAjIipYF3UYiiyCIWyIiaFlMmJHW8nMsv11iir1Bnoq2
 jLJx5DvL9lA==
X-Gm-Gg: ASbGncujnJ+1+Flw5FyO53YhZ3Cye/I2ylIAGAhLwXCSuFd3aCNx2MMvFYYdIWUrapx
 QrCYnPo8aXXPIuGBOa3SCoXkKRXd9T1KpkpHjEEpU7JyvbKF9Lh//gdki3+Wc8ZA1sCVhqNtBWB
 IyLisLAu3oxSsfco62R1RzjdFcT9Bcs/cb/0EwYZXV+4qXyVbAijth5JUdhwDuUaKL107ge1j9j
 NeB2SYXI40N3+7IjlFJ8mCuWE0zSwW+Tj8+jQGJMz34MtP+iq2DA1IT0jhziG0yv9knIDGtBE9z
 NL1qYVXRM90tOrkLeNozQiXSG1DcG+LvQbC4VZOjYRr5+WaRbPPOT+fPdbmsmMGd0xaEyTF+Crc
 ZsCJUsr2RbX6wTRTi5EISPmILs3sck1NxWQ==
X-Google-Smtp-Source: AGHT+IFuFf8b0FN8m1f6QwjfoO5kUp2eWUieR36l5Mw4cqCx0SRMNKUchjBVGkuWlbdtmtCQOxC3yA==
X-Received: by 2002:a17:906:7953:b0:b04:813e:491 with SMTP id
 a640c23a62f3a-b04813e1a1amr139361166b.12.1756973495989; 
 Thu, 04 Sep 2025 01:11:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0471c7a163sm248962666b.47.2025.09.04.01.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 807A05F92E;
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
Subject: [PATCH v2 003/281] scripts/minikconf.py: s/Error/KconfigParserError
Date: Thu,  4 Sep 2025 09:06:37 +0100
Message-ID: <20250904081128.1942269-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Error is not defined in this script, raise KconfigParserError instead.

Fixes: 82f5181777ebe04b550fd94a1d04c49dd3f012dc ("kconfig: introduce kconfig files")
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250820-scripts-minikconf-fixes-v1-2-252041a9125e@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 2a4694fb6a3..4de5aeed11a 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -363,7 +363,9 @@ def parse_file(self, fp):
 
     def do_assignment(self, var, val):
         if not var.startswith("CONFIG_"):
-            raise Error('assigned variable should start with CONFIG_')
+            raise KconfigParserError(
+                self, "assigned variable should start with CONFIG_"
+            )
         var = self.data.do_var(var[7:])
         self.data.do_assignment(var, val)
 
-- 
2.47.2


