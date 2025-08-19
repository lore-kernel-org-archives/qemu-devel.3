Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36750CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNVC-0007PU-8Q; Tue, 19 Aug 2025 10:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uoNVA-0007Ny-Ij
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:39:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uoNV8-0007sE-Qb
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:39:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e2ebe86ecso6139141b3a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755614389; x=1756219189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bg+k3hCxedWSieuVGpi9ScxqcvbuIhQ+IUaNh83oJgU=;
 b=UqqFoPtlEenOMevwVcVChSm1/Ob6vkbHvN7OOkjsuFb7VCM1T/9f8K9anPvfdCmfj6
 BU/nU76NWiDI9ypRtjmng/b3HKoD5YUtd7fEyN7GqK9yqGBNvuKplI5I9aAcqCmHWqBv
 ZFiMlss5pZspbphJqwO69J83OLgTP1Q/isXEaejEZM/0F0WKDT1kC4eAKAehlvsfMv13
 N5C0bRc0Uu7p5BP06EXfpiCJfItSBbqG6L4qv3aV1T3dxWMhmfKZ/aBlbXjNi+mS5Bd7
 TL9nVUue3nrQcLYzoupub4ZxMFV72HS1I+NI0QkKlnGOw2EC7A1zmrjmtonQeXb6FSm0
 9dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755614389; x=1756219189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bg+k3hCxedWSieuVGpi9ScxqcvbuIhQ+IUaNh83oJgU=;
 b=wlZI1zy0bIpjFJLU06kv+L1s+vDUCm2v4/3yUPAwtL82n969GIqp4PZrxYSAwiGccf
 6YP+rYf4iWGBMKHphyCI5GalgQTpsdN/g53rLZUjI2e+fjNeQlW5dwR4YZbqhNcEDbzn
 h1dMHlKqc+Utu7tUpgiI+60q2hpQYvw5OtUF+98Qmri8oAdgaCebiPw1MuFgCT9Ia4Zw
 wG0D1EXjWoRmVXiuhCrRr2XTTcPdBvVQMv77BxIv0INu3DwES1eaoDxcQbjA7KKlp4gg
 K0zVDSg7kGjSN7x9YmO1mL/C/WKqzxVwK7sLeLnqkT52IGpAB/gR5XuMj5vb6zoReqNu
 O7Qw==
X-Gm-Message-State: AOJu0YxS5xOwWS/DD8/yIonFRrkhNqGHnHu7tfACwUrx9g8+TRchOPYQ
 lZkU8ii++tL9UiQMQrn/7X1QEVcmfB/574SNS/cAZdIzBiZGTjcfF6ZzPX/MMMKn67kFpB1NA8e
 prOEa5sY=
X-Gm-Gg: ASbGncs2a/UdSPLrCias3WOKcs0zQmSZCW4wuZSnbEQU5p9/WZVyV9BsqjfIHp2Xh7Z
 wVmCBD0VYx6tihun3iquvqwmn35jDd4LTyxYlhxTB42q394JA4k6kGgdaZ8zON+G3h866YTD40r
 wrQx8FgNbwgaSfm7D6e35YksLruwUYCr6fEby93TlQ3SvsCsUiq+/wNzCCpST5E8mar7GNvVxx1
 nH50GbAKvKE/GAzPvl0YAZigKmu3MgC3GXziPe5XKp12QpnN6h3GFm+tfCSGblp9MmYXpre/qab
 OjEmcq/GoWJjHNtEpOTr/Q2EWNZVUV+oRUOj4zZfonUi2tFvI7zu+06+cRIXSfTckF8IpbcmYMA
 FWK5yRMQmwW8pxVfyAeOZb6SaporBYDkAthiGfMxJMhwkwZFnygYLiUh7vr+LCr+YURPU
X-Google-Smtp-Source: AGHT+IEQPB8dlBCjPRoo4crzTen0dvdrgPYMiDq9BkmQNghMGicvOR5AGdOPpStkm9SS0/utOaEf5w==
X-Received: by 2002:a05:6a21:3394:b0:240:1e63:2e13 with SMTP id
 adf61e73a8af0-2430d4c7384mr4097668637.41.1755614389253; 
 Tue, 19 Aug 2025 07:39:49 -0700 (PDT)
Received: from gromero0.. (201-1-50-181.dsl.telesp.net.br. [201.1.50.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d0d98dfsm2769781b3a.17.2025.08.19.07.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 07:39:48 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org,
	thuth@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH 3/4] tests/functional: Mark main in QemuBaseTest class as a
 static method
Date: Tue, 19 Aug 2025 14:39:15 +0000
Message-Id: <20250819143916.4138035-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819143916.4138035-1-gustavo.romero@linaro.org>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42c.google.com
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

The main() method in the QemuBaseTest class has no parameters but is
defined as a regular method. Currently, this does not cause any issues
because in the functional tests main() is always called directly from
QemuBaseTest (never from instances), but the way this method is defined
makes its signature wrong, implying a 'self'. Hence, it's best practice
to define such a method as a static method, so decorate it with
@staticmethod.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 5caf7b13fe..fbeb171058 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -235,6 +235,7 @@ def tearDown(self):
         self.log.removeHandler(self._log_fh)
         self._log_fh.close()
 
+    @staticmethod
     def main():
         warnings.simplefilter("default")
         os.environ["PYTHONWARNINGS"] = "default"
-- 
2.34.1


