Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB44BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwnp-0007h6-PB; Wed, 18 Dec 2024 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnW-0007T3-NJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:19 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnO-0006gb-Qm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:18 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so1161410366b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538869; x=1735143669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FzFnlzkuRqAIG729x/b7511sIkBqkjnI6qfjXVG1TA=;
 b=G3ouKdqBdzbeYc8c/9J20+h8BfE88IIlqIWnACoXqLJCxAA04aVwmETwU3J+9Gntlc
 7quomLLPPZs1DINB6zPSmQvLvrbjrt/PeHUiKK4PQzG4pB4z3SZNKLKA+LcIFnRYm1C+
 LJafVmsJYDHVvmPbYrfIk7Va+lLOa/MwwsR0wp7tdCGTZ4PAHmvXjybL3dH5qm1F2j5y
 ZEkTU0+qhAgo42emYUWvyuXSsifapz04nHnC3zG1OiXpmwV0gmehg80Fx+90vxAZY2tw
 fXP4k8G0jZpUA8A+Tt/8siPa7tff7SkflRg1Is71LaW0WqDyTzr42eypsBxyHGpRART/
 UEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538869; x=1735143669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FzFnlzkuRqAIG729x/b7511sIkBqkjnI6qfjXVG1TA=;
 b=GjEkdJJNpvq0I6tbtLzvRd0SXjZ2Az+nmisbEFUO/ytQtphRU2j8vZwPMH4DqoNYvP
 o38KeSGc1lJsDuyteHNrq71v+zRsXgzl/c3JQ5HDJQeUEP8KkvbY22Q6k0Bq+55JHv0q
 JvzBL8DZe43J85ySzJB1SMAwWPoNysDPq4ukdj9YSq9ZHSX1+FrRgV36cuafkudaP8yX
 6he2L5eTJoo0w544IMDCEW93AK599SfWv1vhvk8Sul/n+Hrhnz7hmNBK3H+8M90fJtkm
 tVZ3SRY1kYp2yIq66K3yW6WgOZyaDWfvOP6ltGWcA7goxb//MluRoC14AIMyUA1ZIv+7
 QFUA==
X-Gm-Message-State: AOJu0Yzuj6j5mimYPjl1IwkHDj3Kokz99VgrOfZsuDOp835TlJZYUZ66
 10+UdfMsoihSvoawMaoVXyveTk/Ef9x+TILq8vz3A7CeHey+fAVvs8H4DUpq1zI=
X-Gm-Gg: ASbGncvPcczAHZmIoK/ddtmDOWP0rLOxt78VosAFlIvPAjOo7E8d9sRulOPuNRAyk57
 76uBUXuZCL5AAXUgliElhjIRxdN9ZMNtqgb2GO88Yi6fMuuwaBLLOXAw4RFv/Y23GB8cCmItCKv
 +hsJoKl6lC8/hwOBm/75Je0AjJlKuHBWEAPoRzVUMF0rSSqflznlFnxvjDjVis1BxSiOkyBL9a1
 whvaJLUGmpwiL4+1cWg8O2+jwLnpRLx1EH8urarLkbyG0fLBp/RYfo=
X-Google-Smtp-Source: AGHT+IE91x145yzxpYwWUCesBG8kozN/ag5NrxwX0+lzc9JQNfpiRYXs2Bkdl+p26NY1HWEXreojGg==
X-Received: by 2002:a17:906:32c3:b0:aa6:b4b3:5925 with SMTP id
 a640c23a62f3a-aabf474b941mr307966766b.14.1734538869028; 
 Wed, 18 Dec 2024 08:21:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9600686csm571971466b.33.2024.12.18.08.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC3D75FCE4;
 Wed, 18 Dec 2024 16:21:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 06/27] tests/functional: update the mips64 tuxrun tests
Date: Wed, 18 Dec 2024 16:20:42 +0000
Message-Id: <20241218162104.3493551-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-27-alex.bennee@linaro.org>
---
 tests/functional/test_mips64_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/test_mips64_tuxrun.py
index 54af1ae794..0e4c65961d 100755
--- a/tests/functional/test_mips64_tuxrun.py
+++ b/tests/functional/test_mips64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64Test(TuxRunBaselineTest):
 
     ASSET_MIPS64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/vmlinux',
-        '09010e51e4b8bcbbd2494786ffb48eca78f228e96e5c5438344b0eac4029dc61')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/vmlinux',
+        'fe2882d216898ba2c56b49ba59f46ad392f36871f7fe325373cd926848b9dbdc')
     ASSET_MIPS64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/rootfs.ext4.zst',
-        '69d91eeb04df3d8d172922c6993bb37d4deeb6496def75d8580f6f9de3e431da')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/rootfs.ext4.zst',
+        'b8c98400216b6d4fb3b3ff05e9929aa015948b596cf0b82234813c84a4f7f4d5')
 
     def test_mips64(self):
         self.set_machine('malta')
-- 
2.39.5


