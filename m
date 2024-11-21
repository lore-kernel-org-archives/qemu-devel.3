Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F83FD78797
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAWS-0005gv-1N; Thu, 21 Nov 2024 11:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVo-0004nO-P1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:38 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVW-00084N-AD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:36 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so6661075e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208296; x=1732813096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2HZ23XNFOLk981JEHm7evbs/KcDQehVIWxXpboMiiM=;
 b=ZrMbeQ3ZJE61lgT5ynpIQkaQfqe1xdVyuEnHHbFuJj9nPfIBt+0toE4IoWWE0nfiVV
 M8IPHu9iKWjej8FWPzFtAEaBoz6+tvp5It3nrgd4sxTE9deqv/c5EJ6BkmBRvNsuKckp
 OP1jN+UDk9YrCyaFaFIPiqMJMA5pzz1LSauiE42G4UI3p6U0QkrdSL0oZDCEhHkPwpx4
 ML8NO+VBTqOGxkwItP8TuWkr8kGOrfCWAXIy5FRT4tP/eK9Cfq70FEPxQcP8hMsD6B6q
 Pk/WVT9TDtRvtJbh0pB+7tuseOI4hSfpoF1H4Fay58Fp4gL6TGMGJbvvUkIRkXPNDRZJ
 b3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208296; x=1732813096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2HZ23XNFOLk981JEHm7evbs/KcDQehVIWxXpboMiiM=;
 b=sgPFMKWkZbhZLzWFfF7Z87qwIwXFoado5PfiCZwYsrGpi4Nt2h4p93dQOoQQEXKssl
 GQKNePTWXZMSkRke6153PU+3bJ82Ar3quD9IRJcDsv3lCOqYldX3X7x9S0Aoi1AauMfu
 Xch39pNrRDEuMuh0xOLigcZE7hKG2QaXdckS72ITloBttGmrl8xBiHZonNAAQpI6srYE
 0O/UH30gwGMhSwvJjpwK3aXGJaZ+x2DckfNlTpjFhwX19YruLubRsVcbEIMIPr7k1XTs
 auvg6psYO2cZOX+jTMeUFtHvFwveG5h+MCn+vvCuALZJAPGU+3e/Xg2jp+kDWDpS9rRW
 1l+A==
X-Gm-Message-State: AOJu0YwJYuPu5SPOYyWx/8ghQuo9Z6Vp4WymWW5ta/5T6jKx4qYh8jkx
 iw96rx1NEnTzPx/XjtkXAftepQ1uUOBEhhdkx2GAwdX1ZvmNt7myl8ZR8IpknUo=
X-Gm-Gg: ASbGncu9JB4SW7c0uhvwJWq99nw3nGdC6nMw0AjyHje4NlwBXIZJyF6hyAo2FDYzrul
 iZ0eBefVoJzaTzHR9cHCpUswSQE63vKkaiESfcgKji+iaHSmp53nPSyKvidR7F4hVYWS9tLsr35
 cYvkRj02V0MSsWmDT7ol+cxbcnf3KlXOajAKw88l3pQJmmJgVQnFwajXt6uWd2RpJMZ/aoP00yN
 0RK1ep5oDpEqXWzrF4YDq9OMXOA5VHUpD91e7YEy3ih1EeK
X-Google-Smtp-Source: AGHT+IGDHBlSamv94hqq39SE1SaufjquwOaoSGOK1WLNw6iTeG+uZEgDu2CvhBFW9NHQ5b4/zJX4fw==
X-Received: by 2002:a05:600c:a4b:b0:42c:b166:913 with SMTP id
 5b1f17b1804b1-433c5cb049dmr36104345e9.11.1732208296361; 
 Thu, 21 Nov 2024 08:58:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc44f7sm18708f8f.82.2024.11.21.08.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7AA3D60357;
 Thu, 21 Nov 2024 16:58:07 +0000 (GMT)
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
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 11/39] tests/functional: enable debug logging for QEMUMachine
Date: Thu, 21 Nov 2024 16:57:38 +0000
Message-Id: <20241121165806.476008-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Set the 'qemu.machine' logger to 'DEBUG' level, to ensure we see log
messages related to the QEMUMachine class. Most importantly this
ensures we capture the full QEMU command line args for instances we
spawn.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-12-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index f9c9de1166..e2a329c3e5 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -57,9 +57,15 @@ def setUp(self, bin_prefix):
         self._log_fh.setFormatter(fileFormatter)
         self.log.addHandler(self._log_fh)
 
+        # Capture QEMUMachine logging
+        self.machinelog = logging.getLogger('qemu.machine')
+        self.machinelog.setLevel(logging.DEBUG)
+        self.machinelog.addHandler(self._log_fh)
+
     def tearDown(self):
         if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
             shutil.rmtree(self.workdir)
+        self.machinelog.removeHandler(self._log_fh)
         self.log.removeHandler(self._log_fh)
 
     def main():
-- 
2.39.5


