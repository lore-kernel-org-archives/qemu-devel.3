Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AEFD7879B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAfv-0004ow-E1; Thu, 21 Nov 2024 12:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdu-0000lN-TO
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:07:00 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdU-0001ec-Tv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:56 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38246333e12so1071282f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208791; x=1732813591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPkgZb+7aZINgr5AlSQc2tvBZSl4x/+JOpQj7wrbfcA=;
 b=PDWRn1WpVxwaNmwFUXo+zQ1gD7vFSyhgPAf9nrUWwsoelI3mzle0b71EfpUBZ5TCyN
 L+9WKZWvZdfgqzAb1feWNRTqwzaF6UPzhF23E23zDvVNSLA+b5PmwdzG23sTbas7nuwQ
 oUtl9NH1g5Weo2CvTaEAEJbEfUHptPRZYLVQIgZrug0Ix7bH3+GygvGoFZIt4Ll0aHlG
 Ng1IXJPf8sH4mVc74n9AjxwPvEafCAP+1JqXjtNwaBRIlYqThTfNF1DHek9TEC1IwFaQ
 IrUFGTqDYSowZ15zdqBUtuWzU1nB/SpMYjcUqAja8OO4k/3DCkDD4mzx8P29eS3fc1/A
 mK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208791; x=1732813591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPkgZb+7aZINgr5AlSQc2tvBZSl4x/+JOpQj7wrbfcA=;
 b=G16AzYoRPLLjuaS+Qnb+RweRRFalRL95g2qcL4/YDlWzeicuNB2zPU0Lb3+7G7+KuG
 M+m8KwEtb7np0bhZaRuBvQY4BnyeYscKqaFwiHfI2FPEO2k+QWVW72vJtu3wvVus5U5f
 bTJ4Kclb2nRs2KlN2fDWkg4LxcKu7SBforhjc1sWv6p59Vm/pHU6u7HNRCNQJ/6ROU5d
 BqqFHuh0ES3oc1vIRdvP3KI+WUQUTrH/LAJ6KxI9fgHqYOyT28OsHCjPQXYKOy5awBp8
 U/I4gYZNIu1cO2xsaF8psqT3VrAqmU40VAFC3JoIiFd3+65WAtvDD+Z45lFF5BJR0vNM
 U2ww==
X-Gm-Message-State: AOJu0YytNDd3u3fmmts967znl+koySiMWaiwfhAs1UN+e0p9BPkTUcGv
 hv8HbRdkUu8LYLEG3VWqubprTYae51AZHPhbbaYlR39Lan0EZDaKUXAEU4pyXYQ=
X-Gm-Gg: ASbGncsDD3fuOm3CWRoWrwtbK94PED4ifEcQXAB9fI2WYtH/HZtaUjqnDiNNIgoewfd
 +zro0OnuQUuGw4OPcCCO2McWGz4WY8sgx+rgSON3UrgARO9l0vR4Jw4xB7Sw1iknnZI5UaO3fkN
 Xf8pDJuf2Fh8T9SLPvziCN1UKDviddDY5bHYwlQOWMbtx35j0/ARH4IsAkgum2uIXPBK+Cs4UCK
 0DqWGBRAiCa1fVW7CM+t2S3ATdM+HQnmRylCq5x8qgWv7Fg
X-Google-Smtp-Source: AGHT+IEqDY3AjBIogS78NyhIx+DW3tofme1nMDKHwlWuOVklANSLC1tQGFD0PhjFw4UFPjuYuu65RA==
X-Received: by 2002:a05:6000:184f:b0:382:3f77:8584 with SMTP id
 ffacd0b85a97d-38254afa9b6mr7159340f8f.32.1732208790548; 
 Thu, 21 Nov 2024 09:06:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad60e5sm58019f8f.3.2024.11.21.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B35956045B;
 Thu, 21 Nov 2024 16:58:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 25/39] tests/functional: update the mips32el tuxrun tests
Date: Thu, 21 Nov 2024 16:57:52 +0000
Message-Id: <20241121165806.476008-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Now there are new upto date images available we should update to them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
---
 tests/functional/test_mipsel_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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


