Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635B2C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchEG-0006AS-Uo; Fri, 18 Jul 2025 05:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9t-0002N5-BC
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9r-0000M9-9w
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so3028755e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752830013; x=1753434813; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OzsBvEnuBuem8f8dBJF+l6tBY8V6RE8gWcsguX/ipV4=;
 b=DoTpzlej4PmSpjZd3LhO0q1I/DAgW+3ySoP6HoHCUHA1nOVkBwgWeDQ8sqzBPUsftz
 U0DUk+8CMEvDhK7WhpjT1g6AVMm4BIGHbmo7syw7Y4borupDvjc8DAl8+xgVpEWRZ7VB
 83OfWBk7B2szHf4xaqzbVuAxxMcu+fpSc9edAtzss+kLSXDxa27C83e5TIlDyDtySM6B
 Fm4SR7fx3IF78ATP/TJVFsyFIqzVSncRInbvzoh/1TjL298uPIiqNTj3iGdSN00h+mL/
 Pe/pj8rRZeDgO2pAOeB0lvDXYKb1ChkxvSZIVgknMk3IznG2aIwfq3wU2CmvBL37/K0D
 RNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752830013; x=1753434813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzsBvEnuBuem8f8dBJF+l6tBY8V6RE8gWcsguX/ipV4=;
 b=WTUmqC+O5/UhlrBatroG/cv+y2MMiQrI8P0xojzMTbNjUOZvhFLsLjVTZUdPNvZ7js
 jYxU7kfjkQiAeIOpRiCOZHAbPrastF7he4k+ZSjavZijUvYk5R0ieCL4PiJlvaT9LY0i
 sOU/EJp2g8kF/6/2cJJhZ5jjo8r2vv58J6c32h5lkp6ZSUf3LvRxNTbKP+jcfKgeU08V
 OPiO4r1Sya6Q99gFzKNroNdB/ZFYvM3jEfiUTlMLGat3eglFAEPeT1hHCtbLwdo9mKYc
 BGxJiQYZLgBGB3OaICNrTLUicVsC95L6RQSJ1N2CNHk8cjC1hl+LhHrVXFwzfhLsSVIr
 O20g==
X-Gm-Message-State: AOJu0Yx7Nuk5o+cFGtnVtP16sXl2pb9x4hjldXPHPejYHOS4Fto1D6Dz
 10RGqk5L7WhMTFq2MFLbrxf/CIreSwQNUe9eVIG2f+7y8yuA5V/vnSiWqcotC23FiZs=
X-Gm-Gg: ASbGnctFTF8TkT8TiZj8/7M1bEr4ouZTYSlApXt8lz2Pmh9ryBSF70Ct0qvGfHj/HIo
 h7IDRw4ZclZl6NT5vtASX80e/xku5gRmaP+nzG6hT5RnbVeGP+BZv1RY/EFRBqbEhhzgJVuSxLh
 jJNl1PYkZvrhaq6uqfNcy7qimgu1HH7z7/X1tpJt65ejEuI7i6i6Hcc14Sk5IMYY1+gn6pwyrFz
 oQyNX3QZ0ZOw+Q0qSbY1FRJUPLujWi5peOpVZdB9HPfEf26Nx0AH2K1mao0I1g5nhwLiebbQIUp
 ds2jYBvlLr7cknm9l5Yu735kWYQB1/Jx9v26jMQePVbjt691Ld4417LB7lwxhIQmhkC82/Augk8
 iDYv3pSpre7D1Kdz2xbq/S4t0U2H2ckHh0Kx7BwxFszyOepKMZnHIp91064BUJBEDYMo=
X-Google-Smtp-Source: AGHT+IHUla4UM9rIQP7MbPg6r/ODOlALUh4jSjsPVFoV1ccjBTZtgXagt0ScEUwbbx2VOWaTAtfGgg==
X-Received: by 2002:a05:6000:2c11:b0:3a8:6262:6ef5 with SMTP id
 ffacd0b85a97d-3b60e4b80a6mr8874595f8f.10.1752830013373; 
 Fri, 18 Jul 2025 02:13:33 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca487fdsm1267145f8f.48.2025.07.18.02.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 02:13:32 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 12:12:53 +0300
Subject: [PATCH 2/3] tests/functional: add --list-tests CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-functional_tests_args-v1-2-54d4c6207690@linaro.org>
References: <20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org>
In-Reply-To: <20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=L7NfVvYqmwA+Lo4/7oYRawHYzlttF/tNf4Bie8Kzyes=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laEE1Qm4wRTk3Y3U1bm0yc0VOdlNGT00wMHpRCmZIdnA1TlhjZmlJMlI2TDVJ
 V2lKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvUU9RQUt
 DUkIzS2Nkd2YzNEowQ21yRC85Z3JZSTFKK09FSnpXNzNKS2FjQnVacCs2WXFzZ2NheURKemsvUQ
 pDNnB1RzYxZDRaclg1OWp3T05ZSm9UOFphVU91SmFPY1c1MCtpODZjMEZKQ0hTamtmQW0wUWF3a
 3l6SC9UUk03CjAzT2xLQ0wvZUlVOWRaYjVGMmhObStzcldPVktmQnBYT0RWc0VZdzJKRTh1R0VS
 bTlmY2paaHJFbHAvaUh5OXUKbEFQN1YvZlNOdnFjOEp0cmc2RWc5MndHOXkxT0RmRUFCUGNxSWZ
 Yd1JZQ2xqUCtBYWVBanBZa3pycUlJTFdnRQo5QXNFRmhpRjFSY2RBWHV1TmUvam53SlRSN2tOSU
 E4MHZVdUtaV2JwdmdROWFadDdlekszeWJYYXJuMVNkU2Z0CjZaRXBPSFVmb3RYRTJnVGI4RVZLN
 WUxQVF5bm5ZM2Q5TkU1NzlaL3YvY3JsbXRwcUU2QW91S1FydEpVTllTSUwKRGh0RFZiUjhsRzlG
 YUliaVE1Sjk2SWtIWk9uWk1YYU1pdmtnY3BtTE83N1ZLdU41bkpMMFoxRVJnZ3p0ZEt1OQpvcHQ
 2MTgydnlpdHRPdzhwcXorOHZ5RTBDTGU3NVBlM29Lc3dVYmpHaTdNanFkRnZRS3NtTThoR28wUk
 FsVlRlCm9ibkc1ZkNjUGNROTY3TVZ6dGxGZEUwTzlaMTlJcUFBSkl2ZVpjT2paMVhSNlVYck9hW
 TRka0hDUDQzS01HK0kKSkNrdjdERTV0QnRpekxYNU51dUhPSjBIVHBPQ2FQSG9GY1RNSkcvN3k3
 eHR1eTl4SjF6cCtuMkNlR3FNb2VJVgpqVEEvdXg1enU4MUNFZE1yaURMa2ZNREFTZHdrQURpbmF
 UbUtXdk5NNFRrVFZHWk5MYW9YZ1FLdFVCdkpqQUIxClNqQ1kyZz09Cj0xK3NiCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
index 24f0b452964012532530a92018b2c4367b39fb77..4455fcc38016c14db04019bbd64eaae9b47363c1 100644
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
 
 
@@ -281,10 +286,13 @@ def tearDown(self):
 
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


