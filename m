Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5924D58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFayq-0006zs-CN; Mon, 25 Nov 2024 10:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0006wm-DF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:24 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayh-0002YH-58
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3824a8a5c56so3076647f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548377; x=1733153177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVMl7r/1fgVSH8/n/aNIg8kgc7q28d2pUpabg4PkhwM=;
 b=BoBqtQS85eTH1xTXXUSWMj9Hzi9YjXuYSZhV2xSrBJlDsY2rkDgWRJ0inbz+NOGjG3
 bZ67vXwvUTIkuP+JQxGVu02oyw5Kuj05wEAL/3eh8MZNhaG4wePHUdvkxeEYWKhshr5c
 EE2vJAa8B1d1/bX4RLDfYQI3uliBde8wM4BVm9Dtdi5JRIcLuRWAozhsMrvVAjD3Pkp2
 cASgwJtttUWwOg0+SPIusOqvHt4ATePNsa3GQ0pBKKNUDPBqTfvT6liTLWB2GjrdlurW
 mmQVlwROgd68C7K12/n8G/jlmHK41ZQIGWHnlsnA5wBUk7WLOGygTT8A+ZD5xIV8/y2P
 fnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548377; x=1733153177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVMl7r/1fgVSH8/n/aNIg8kgc7q28d2pUpabg4PkhwM=;
 b=VVAHWeSQnKPu1gVeERVLSsX7t0a3GHdJz3EiPk6av7vh4UE4k3B2nV6fhJZP9LfCkf
 k2Ch1rjA8UKN1eTBmnHG12C2OUZ1QHjcjXRqv9i10N4v+9cFDDSneK51tchzE4VHHSnA
 2L4oYhFt6yfYQnxSW+LUIuW7f55AO3Em/ULtCSMaPYC3qrPrz8MX5+GkXcob1PxGQsW1
 yTpOUW/bpKxD2e0JTpVBzQRJT1d+Xqom6EawnmPG3tazPWhJX6PoDB+SZ9bEFueKRU+g
 F/6i7DUSlIuVwetouXImTL5vl0Be5vZ6AsvsirIMrrZ9iK0JiAHqwf29ttU5Sk5hBltJ
 L2Lw==
X-Gm-Message-State: AOJu0YxvKl7kCBuvsfKimSMItmmEEfYH2WOheMw/QDj/vh5yAXGKpEfR
 f7kjNVv51MrIHj4CW/qiqaxKvLGE28GpJiiCEcNK8LaASmqMjxsrn0zdLadUQPo=
X-Gm-Gg: ASbGnctNNPIEsMlhmTYuBOqIRLVRKqkATAbCPrLbElX32PKYRayanxQXvQjyjR3ogVB
 dJ09Rwge7J2dPhZ7XC76Gg0drLJTqqbsGBfUvne+5zlpCOLARhjo+KJTpjG7Smgd8uysY///QSe
 xL8miCEmBkNYQFY9vXKe6E56CrbTuRO+ziLD4rGPoHTjU6F6M/FXzV/67TyTdghOqosx2B0Mos5
 Wsmout67ur4cd+VbbhcsMg2vvxr840FanJiMxIjjaI0a7Qz
X-Google-Smtp-Source: AGHT+IEEKr6dXMb+Aunofvy+nuwN9wTujrt5Og8F/L2UCry/5ep7kSHTKF7fvE0G281Tdt2Mc3yITw==
X-Received: by 2002:a05:6000:1f82:b0:37d:5364:d738 with SMTP id
 ffacd0b85a97d-38260bcc4cemr11861047f8f.45.1732548377338; 
 Mon, 25 Nov 2024 07:26:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb4ecd8sm10658416f8f.60.2024.11.25.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6DEFD614E3;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/28] tests/functional: avoid accessing log_filename on
 earlier failures
Date: Mon, 25 Nov 2024 15:20:55 +0000
Message-Id: <20241125152105.2100395-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

If a failure occurs early in the QemuBaseTest constructor, the
'log_filename' object atttribute may not exist yet. This happens
most notably if the QEMU_TEST_QEMU_BINARY is not set. We can't
initialize 'log_filename' earlier as we use the binary to identify
the architecture which is then used to build the path in which the
logs are stored.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-19-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-19-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index fceafb32b0..90ae59eb54 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -81,10 +81,12 @@ def main():
         res = unittest.main(module = None, testRunner = tr, exit = False,
                             argv=["__dummy__", path])
         for (test, message) in res.result.errors + res.result.failures:
-            print('More information on ' + test.id() + ' could be found here:'
-                  '\n %s' % test.log_filename, file=sys.stderr)
-            if hasattr(test, 'console_log_name'):
-                print(' %s' % test.console_log_name, file=sys.stderr)
+
+            if hasattr(test, "log_filename"):
+                print('More information on ' + test.id() + ' could be found here:'
+                      '\n %s' % test.log_filename, file=sys.stderr)
+                if hasattr(test, 'console_log_name'):
+                    print(' %s' % test.console_log_name, file=sys.stderr)
         sys.exit(not res.result.wasSuccessful())
 
 
-- 
2.39.5


