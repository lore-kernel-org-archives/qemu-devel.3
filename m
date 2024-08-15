Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA289C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebmx-00036W-SB; Thu, 15 Aug 2024 10:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmv-00034k-Rg
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:17 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmt-0000Bh-Us
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1639897a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733354; x=1724338154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWTKlDd6LK1VooQusJJbhCpW5WJ0iCeY5ofYJWN9ldI=;
 b=wwRl0KHBVClQxe4erm2www7r3dC1S034jYSo8lvdK8ti0kUhnPKUUjUkmw0MmHhB91
 7Aee7YrX7pMOjyDT1pz+5MHQQ1rmUay0qsuQlnE5TwtfwVzNTt7g36wa7Inc5oM5b7X5
 ZfZlvJwgemy2S37zT6bnko/fqJljDgLlj2ZGcp4kWk1PMmUUNz2SoRix8+Fiy7u4o/6b
 tG6HjGvDrNHOz9+8hSat3IQCNrMYMp+XxgzP8PT8bo0/Nh6MJH8x7o9+x5L2DW8pQXcP
 jZmj9BEaNkmv0+9SPMw8G5o/h4VvH4aDsR+ayvihN4/qixVapASMcuzL/vFNiHdLmq7x
 vsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733354; x=1724338154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWTKlDd6LK1VooQusJJbhCpW5WJ0iCeY5ofYJWN9ldI=;
 b=aqRogeEvPVz5Mf3moR/v+40reFPwsjWq404CPlsSXHBeiMgevq6if5NhNhs7tSxx/F
 uLbBKSdDmFkD6pKmZaOH2QVasPKZXXPoHcqjsUDvYkAumgba231knvzCa4CSHvuLIr/A
 MJQye9z0wI/JmdHXCG1XGLT8KcJOdC+PmssqwHo7EdtX+yF34WgCPsRfojBY2CJiBo/e
 dTQ3xQ8uzGtQvut9xPROgYMAZbXt8sWAPZf+agLXz4gAXs1L38sU3ZK+AigKlcvxAOF6
 nw4gmR0xu9FCCcfUSpg1V6znAJ5pOKqqEgtZHOJjUeYUDtGfquJ7vwX8AWKBkDgF0flw
 mlVA==
X-Gm-Message-State: AOJu0YwiHqq8JzLq49PRR9je0jkh85Z4Y4QVgySGz+UeORfhZ3xl3AwL
 +vwMkRrQ3+XnhZUe1bNiil1Gs9XNk5Su/eP8emPfilwH2OjCMaFhdj0gjLZQ1zI=
X-Google-Smtp-Source: AGHT+IENyghTMykpQlzwhyebQBu97V2cNcAdQG8P+4fqGQiMKtZCLui91LF8lWF9Iasbg2HL7FHObg==
X-Received: by 2002:a05:6402:280a:b0:5a1:4f76:1a25 with SMTP id
 4fb4d7f45d1cf-5beb3c255fcmr2917353a12.17.1723733353544; 
 Thu, 15 Aug 2024 07:49:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc081a19sm967489a12.86.2024.08.15.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C85AB5F8ED;
 Thu, 15 Aug 2024 15:49:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/21] tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
Date: Thu, 15 Aug 2024 15:48:51 +0100
Message-Id: <20240815144911.1931487-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We disabled all RX tests on commit 9b45cc9931 ("docs/devel:
rationalise unstable gitlab tests under FLAKY_TESTS") for
being flaky. However I don't recall the U-Boot test to fail
(the problematic line checking the 'version' string is already
commented out), and I'm running this test reliably, so re-enable
it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20240801172332.65701-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-2-alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/avocado/machine_rx_gdbsim.py
index 412a7a5089..a83873b738 100644
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/avocado/machine_rx_gdbsim.py
@@ -22,8 +22,6 @@ class RxGdbSimMachine(QemuSystemTest):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
-- 
2.39.2


