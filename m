Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB3C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 11:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uciu8-0002wc-B8; Fri, 18 Jul 2025 07:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitN-0002W2-GH
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitL-0005nU-QY
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so1867108f8f.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752836678; x=1753441478; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4FE6XAW701ynTljBiWtyWjziNFIq+ltoCFGeQIJ6K/k=;
 b=ixs+rO0bKOBtOwPE/cYBg16RLF0OgQ2n9YqUmcxNIiWoUicSIa/Rwvwk5NkvWyTZDl
 WgKRd4HFS4steW3TkPObr8qcPp6Fgb9fHKWcjgWnpS+qzjeSgedYHqsRxmjzaAojhl9G
 HEMg1aEnN+KFRF5nOMvMGmxkIcbDyHCm5EZbFjHGJp0G9ypfjpcvh+E+N09XFzzHUUse
 goA73t/+8EQnFVrgIwbgIMV7lzq/rFtURhwzNDwnAdHXe/pWFD7SnJFPHYH3rrGFUCT5
 y84AeFMJKxWzeWcXy32B9VyaU/OLFxY6pwH4PPSysxO9RIf2fVugLL9VUcZ1XCpz9im+
 EgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752836678; x=1753441478;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FE6XAW701ynTljBiWtyWjziNFIq+ltoCFGeQIJ6K/k=;
 b=BWGy16YAcThUMdBym0diApmrk/r08dQUQgAFcsLrSYcRB6MkShsMloBeY/G2Ym8AdJ
 MFVrUAnyRFWmhxMb8LwX6iEyHfOQWzKXWpMsn0bi8E37AiPe+APy3Ebd02jvaRy/DZEf
 Gxsi6CnxWuaghZNSO3P4r2vLFOaBpge31zX1Qb0xP4z19wbp8pGki3wpZylsUBBtC/mt
 o2LJGjcbER76+TriL2FaAq6aw9RLbCJMymyYrvZltYSnzqyY9K2HH8YGnjlshPNd6qcW
 68pxyXwajOwmbvcnP9QHIQfZaMSJbD4xIiv2gIahCcMX2hlEcDWwrSEtiN14B686I2ij
 lumA==
X-Gm-Message-State: AOJu0Yyh+q+o7aeQHGXS58i9LvPVoXdymWz+Q8/9qWCINvUuZNAimUE/
 zworXPXP+ymy3YLoIzNToNBlUrCWkd9OdOIWE7lEdUQm+S4udXF5LgluUG4keAmHhuBADY6w3rv
 84eYY
X-Gm-Gg: ASbGncuHqL8Vm4rbI5FEDFSP/NZnPJEEufWhhVlfksFTFIg5xPZUxL5mCjQhFV6g1i4
 zna8kLnjpH4gntXDYJGoL0nzPW28OCP7phHelWcPQxdb0QiaTIJTLIfD0ASz+ouB1hPluWC4q1g
 dECL9V+A1vfLdbk0v0x/25EKxceuszgC+lOgzwhdxAIAVvy8mtV7Nk6/5SRUd1DZrap1UWvSVnO
 EwJjsdK8DpCQCMTIiVpQosPR205bUO8v7G3kaY2B4mqrCijaoT3yF3B/b7reKkSNEmqnJ1YlTzX
 G9rv4oqcSIejlUh/ZJNQdHAjwFT7TlSCA500VpXMOPx/yfOpswa/DtqH1GX9nGdMqFZ173uOj8Q
 fPCUFlbyjI0tbF12MEyId+1VPkK1mLZBWsao62g4mEhOLmj0SuU7JL7FOftxJu4H77n8=
X-Google-Smtp-Source: AGHT+IHM+lZWElOff+5DxezrZrsWWmT1EcamKr8fpRJIe3MI6BhiZyAlJDQSESwGWs5efTjbq9SQeg==
X-Received: by 2002:a05:6000:2b02:b0:3a5:270e:7d3 with SMTP id
 ffacd0b85a97d-3b619cc16f8mr1857300f8f.13.1752836677880; 
 Fri, 18 Jul 2025 04:04:37 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8ab891sm76117585e9.35.2025.07.18.04.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 04:04:37 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 14:04:26 +0300
Subject: [PATCH v2 2/3] tests/functional: add --list-tests CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-functional_tests_args-v2-2-cde6e08bf98e@linaro.org>
References: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
In-Reply-To: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=joWFlCcQxxcouUINLmn1zvetOg8EQnvEktQFlMPdPTA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laXBCc2hXenVSR3UwRTJ5QmQreHBNUTFaUGNICm83cTBlY2RJdW1zbkVBcXRK
 VGFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvcVFRQUt
 DUkIzS2Nkd2YzNEowR3VvRC85dmYwd2hyaFhCMVQ0QlhYVUQwNlM1UUo1ZWJpcll1bmN0TERFZg
 p6T21lMGU3UmdqOGlEVEhmajg0MUVNUjZVYk1kTmFxMjF3RWhoTm0ydGdjdzVyNGFScnJheWVPL
 3p5eWhkWFlWCkFCN0ltLzdHMU5VMExTMnlpZXFFZHBPbS84SXBEYXhDeDhSV2NMMjBDc1YzTzIz
 SFFLYjVNSDNnWDZhdFFVSU4KTHpFNjJZbDlhOFdqcUNqK09kdSttOXQxTXhvYkE2dHA5UmlRTHZ
 aVGE3WlY0b1gwSEROenJQUGZaMGQ1bUx6bAptVzJtdWFwN1ZwRDd4Qm83U2sydkloUlEwMlpRbX
 VLZlNqT3gydG1OK0p0QUFFSWhKVTJoaExVNW9pUEJGVDZrCnl5T1RveENvWk1ubVZVUXVEdW1DS
 FFDeTRrSngwS1V4cVoxS3dIZXJjVDVxRnV4dTlNMlR3eDFUaWVSREZ6MWUKeDdWU3JrbmI5bzN0
 QkYyZUNRbTg4TGYvOG91WjN4OTJURnpCMElZS0FJTWNMNjR0YkNodG5GL3haTjRwdW5zSApaL2t
 YaU9VVW5TQ0F6aUE3Qkt3SWpxOHkvQjZyTTRHUHI1ZnFQbTlNakRRSnBFcTRpS05qQTZiT0l1aG
 hta2ZFClVpWmpGeGppUmtnTVhrbThlTmZ3OTQxekRQQmtBUEdwWmJySHJRU3NGMzJjN2NocHhDW
 nJyY243UXdoWmxuRU4KWDNURDQ3dVFkUDV5MitxWGEzYmVuK3ZNeFc5Rk92ZnJBS0N1dUR4ZzJz
 M0ZGSFRweG91ZmZCc2gyOHh5QWdQWgpELzVDSXh1WlRtMWpYd295VlkyVXRMTUNsaVR2WkdIQi8
 wb0VPdCtwRHhhSU1mTVNzSVlYajNodUxiTFN6UzRWCkdPWStsZz09Cj1Ga0pxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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
 tests/functional/qemu_test/testcase.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 9b00c63e6ca7a2a669fd456f1d1b51501ce4a726..bfee6638edf6f9853ead1e3809ae3c9152089406 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -50,6 +50,11 @@ def parse_args(test_name: str) -> argparse.Namespace:
         "This is equivalent to setting QEMU_TEST_KEEP_SCRATCH=1 in the "
         "environment.",
     )
+    parser.add_argument(
+        "--list-tests",
+        action="store_true",
+        help="List all tests that would be executed and exit.",
+    )
     return parser.parse_args()
 
 
@@ -280,10 +285,13 @@ def tearDown(self):
 
     def main():
         path = os.path.basename(sys.argv[0])[:-3]
-        # If argparse receives --help or an unknown argument, it will raise a
-        # SystemExit which will get caught by the test runner. Parse the
-        # arguments here too to handle that case.
-        parse_args(path)
+        args = parse_args(path)
+        if args.list_tests:
+            loader = unittest.TestLoader()
+            for test_suite in loader.loadTestsFromName(path):
+                for test in test_suite:
+                    print(test)
+            return
 
         cache = os.environ.get("QEMU_TEST_PRECACHE", None)
         if cache is not None:

-- 
2.47.2


