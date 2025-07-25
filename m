Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69392C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEw6-00086v-PE; Fri, 25 Jul 2025 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvx-0007ww-An
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:49 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvv-0006O5-FX
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:45 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so405236666b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753436501; x=1754041301; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=81X9JWZLMcoyz9677dNtF74dQOQRKg/cSylyBcaNqrc=;
 b=WNZDi7e6smm/Abvm4/lug7QMrI12gnpTQTvEf8hy9QxlbVeU8yY60Cvh13+1H4Jksi
 Sq40rMZd9vGEDdwZV9dF3/zo6bE+B4jVxoIUAZra2WVywYQ12AeYKixypLE3AEmAnFNN
 LPNepqT20J6XUkNzoFB468DZPS6hwvnZbgECuyno9R7XaPt/KU7AusDbOo045ELPAxJi
 h2zd3Mkd8rJNlg56UWZMBQnQFMIRbBjV5gxOfgIDt/zCvUl+lvvOPbKsFEGoduuuw3OH
 g7LD5aBxBCIlAXv905xXsZQcEEwWaqtkqqJZS5BmesfAY9iNAvT1WtGE/geumyinbGJY
 9WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436501; x=1754041301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81X9JWZLMcoyz9677dNtF74dQOQRKg/cSylyBcaNqrc=;
 b=gqDZP5biYlq198WiUR9QKEB4mRtxjThY6VXM/sdI78QJn/Bnt+vbQhgdPJ2K858AlD
 9N/OWKc1f03Vxc4tdNeeqwEhUjJaZbZFTuFTmz5JI9j/ravW4qczpuZcfztXMjuGgnJx
 0suYVkbkHqBKKOrhKkFOnUMP6uraDQhqTgsF4wZqnlktV86uzXX26hf+te/CLXBiTtv/
 bXu0t4H8yPdkXmTFepFQm1opxUJlaE1SyuHXUNFQwZEp+k03lx9zMIlwRweieQt45Hwh
 wto4n2iD16v3BHtfEEUgYQvLtjwKNNo/J9RkEszpAl/PcpvJHfBqvHa1nC/E865KJovo
 bG8Q==
X-Gm-Message-State: AOJu0YxQALw9wszSf1QWskFmQuNlhhRibGEs95gcEJlNkSf/bO/e70ZN
 RR62nKXKzpWcgGPdXJrPiZnkuH29LYosNwMjOZYggPRsKZmWvwVERRj235w+SwQS2v62DIZM9lw
 jJ5S/
X-Gm-Gg: ASbGncsot5s+wHZL+bAHJOaM1ZNI1SM2Z1svVFU2MFP64GoyT9QTFTmOU1JyCt0e62C
 5l9V46JcoikblmCwgBw+KKNKE9IhTjpyD63XHIKznpq10af3OLbopmcvZo0OZp+UbI8k2Yi1PIc
 IUBF0uYkI3aUSmXNDcpygJTEHGFk7A3lCqSxSUzaC8Hx4F6sd1kqwSa7keHIXyLaQEuhvK5GBeT
 bakQFH82HP/Y9rwdTLwEfVQiSJ5J50teW9391SlQhMfOvsg9IRcuSwbIJ9FzNBmtHQaYt6UbYNZ
 GDahoQ0yGyKPmMc8R1keWg2sWltqU7hvdGYfDdDj2opyaEsizALqSgq4dtVVOeCUnioCVDZCTKe
 yO1MZyQdTmxxPW4u7p3YDIZyQm23HbiHKievhnnsKttHGBAEpfGhEamxuYLN6usb1vmY=
X-Google-Smtp-Source: AGHT+IF22fBq65tZ3cIRKezujYQzES6STcdPHk8+DGMGsC3h+rQ3mt36Hp5EuP+NyubEQhNzTCK+8w==
X-Received: by 2002:a17:907:db16:b0:ad5:5210:749c with SMTP id
 a640c23a62f3a-af6175096b5mr143516766b.22.1753436501304; 
 Fri, 25 Jul 2025 02:41:41 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47ff42fc5sm243280266b.143.2025.07.25.02.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 02:41:40 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Jul 2025 12:41:24 +0300
Subject: [PATCH v3 3/4] tests/functional: add --list-tests CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-functional_tests_debug_arg-v3-3-b89921baf810@linaro.org>
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
In-Reply-To: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=xoXEOsuC3Si79RsCr5E0Hl1RUWvEca1gYm5ywI/ZdJ8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9nMUZQdmNFNmxoU29OV0lNamorMmFDaEZqSVBaCkhrYUZ1dUZzRzA2cmlLVHJB
 MmVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUlOUlR3QUt
 DUkIzS2Nkd2YzNEowTmFxRUFDTnRqU3ErQTZFQXk3c3hXN25EVDVLcDNTRzJEOGVjMUVNTnRyZA
 pMVUFUNERoRDdEYkU4aDVMRkZPOC84ZXJlQ2FZTFFqcmViakdVMTJvb0paQTBqWTVXeEVaOHRzV
 jFxQ012ZVdXCnZJWTFVakI0ZUtKTlh2Yk1LZ00reFZ4VStMR0EvT25lN2RGdk1YRWsyZ3ZHZ3ky
 YklpcHpuZFhBaTkxeVhFcmEKdDZvNWd5b2hnM1pqemdvNDR0b21nRzhEQkUvM2lNUHhleVk4M1Z
 PenRiWld0UmZtM3puZHZHb002ejhIL2F0cwpPWk12Y2Y3ZEcxZTBKSDBIZE4rZE1HejUzeVdPck
 9uZng0YlhxSkRDWVlWcUQ2U0JQdTZXakhuS3MyYVlrby9HClp3a3U5VjRsL205anloSGt6QWlPM
 GI4K2pSc2RFUEQ5SmRhVjcvTzM0ZkdTN2k0b3pnT3A2bXZMYStLQUxZUGgKSVcvZW9Hb0dSNXV1
 eEFUNzFRNUpVbjc5QmFLY3pFOGpmWEIrSjJzVmZ5R0JOZVgyeTVubTI5aTJnRFQ1R2Q4RworNjd
 qaytUUUgvNk1NTHdKczc0bjRSaXA4RThXR3NiZ2w4NXN5K2VjdVIrMi9ZQ1EyVXJkRjNuSXJ4Un
 Q3UU5sClhReUhFUTR6WWhoVkpEdU9wNHpKVld0SXZGY1dTMmNPVHU5WjU3SXArNTFGakRKRmVvW
 GQ2OXV1MVVFYXdqUnkKQkNERFAxbHBSYzRuMm96dU05VjNPQXdWQUtTdzRFMnhIc29HUHNZemhk
 NVVYaGN0N0JRamwxTGpjWDZTTUprdwphUVdyNTEwYTV6cEsydzVjSVNVaDcwVktYRFIzeGJkY1B
 sTC9vdWJUNXQyc1ZxY2MxcWJoMWJmVzdYSG8zY0tFClFEWUJUZz09Cj0rQSt1Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
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

Add CLI argument to list tests and exit.

Example output (current dir is build directory under root dir):

  $ export PYTHONPATH=../python:../tests/functional
  $ export QEMU_TEST_QEMU_BINARY="$(pwd)/qemu-system-aarch64"
  $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --list-tests
  test_aarch64_virt_gicv2 (test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_gicv2)
  test_aarch64_virt_gicv3 (test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_gicv3)
  test_alpine_virt_tcg_gic_max (test_aarch64_virt.Aarch64VirtMachine.test_alpine_virt_tcg_gic_max)

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index f7e306cf749e8b24a712b09dfe8673660cbb5085..ab564f873c303bcc28c3bf7bec8c8c4569fae91c 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -36,6 +36,7 @@
 class QemuBaseTest(unittest.TestCase):
     debug: bool = False
     keep_scratch: bool = "QEMU_TEST_KEEP_SCRATCH" in os.environ
+    list_tests: bool = False
 
     """
     Class method that initializes class attributes from given command-line
@@ -61,9 +62,15 @@ def parse_args():
             "This is equivalent to setting QEMU_TEST_KEEP_SCRATCH=1 in the "
             "environment.",
         )
+        parser.add_argument(
+            "--list-tests",
+            action="store_true",
+            help="List all tests that would be executed and exit.",
+        )
         args = parser.parse_args()
         QemuBaseTest.debug = args.debug
         QemuBaseTest.keep_scratch |= args.keep_scratch
+        QemuBaseTest.list_tests = args.list_tests
         return
 
     '''
@@ -292,6 +299,13 @@ def main():
         path = os.path.basename(sys.argv[0])[:-3]
         QemuBaseTest.parse_args()
 
+        if QemuBaseTest.list_tests:
+            loader = unittest.TestLoader()
+            for test_suite in loader.loadTestsFromName(path):
+                for test in test_suite:
+                    print(test)
+            return
+
         cache = os.environ.get("QEMU_TEST_PRECACHE", None)
         if cache is not None:
             Asset.precache_suites(path, cache)

-- 
2.47.2


