Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35C7D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFayn-0006yd-6n; Mon, 25 Nov 2024 10:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayg-0006uU-O0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:18 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaye-0002Xp-VJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:18 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38242abf421so3065614f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548375; x=1733153175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAncWUHXyfA57+KSZY1P9qzVPf7uUwxapVn6zYWCi3g=;
 b=yQEdAk89NP8AEo2nC1uVIh69LDfMQxOV9pyc1Exte2dSd2QGiTr21d+QOXLrIDMSnX
 RBOB4pJAtVhOXHjej9ycU2GAVXaH7VCSKZKaTjBGX859qxziKEjRH/Zp9uYNdf2Jikd1
 bTEbX7Ouq3k6zTL5itcPPiRsG/XxuVjBhTEjfNLpiv5bpPZNlBwZJf2eAuJXHFohXFVs
 h71CD/J7GifLcyevlrG+WbynUC2KhQ23BW8dBunb7yqtxktS7UNN7S904ETiDhXokq5b
 n523cXt8sdBeoDMMGADNjnHR2Z/Gk9t3DI+a6C8dFYJwpl7QkkPyPlxOz6yG4qh+aiAP
 czQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548375; x=1733153175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vAncWUHXyfA57+KSZY1P9qzVPf7uUwxapVn6zYWCi3g=;
 b=oll3GyuIrL/oNVwf/iIT+KbubrIjcWW6XkttfgbXw6vV4atTbHLFx4alCzuC1djfq1
 oh2wsb3fUe5MkoSX0jWyf2jwADsLHeDkxYHXNiP3nVsiGTDrGcFjdUFz7SqNTjs/BUks
 B3IeEvcIDl6jPmnLMfMnsmGhhRDOByCXcEKYlRfeMpPiek+v8OPNn9E54acDdVtN+qYc
 eZFMSgaAxezgHhuDBfgY3d91PfR9RK644JA8ovDReD+c+Xhd0m2J2QMD4qv+WLISiz/2
 ccWmZiHHgSLcHvmxkfsocipIDJiTdqQFBYGuC2LoGMIhnh65QxnpYD53UaBKeP5fFog+
 5DMA==
X-Gm-Message-State: AOJu0Yxv+3TjRvw9j9253xDBiI1iYNz4U7ApU/+umZV6m7mL1RP5K5dq
 Hoj7gv0ZtqvdhrpseErGKvqi5KIkGia7uv3aco9GUzGWrc/dt4QPAhaQj3BLGDE=
X-Gm-Gg: ASbGncu9gv4HPaBVVcUUjrQI5/Ea6ycmovz65oArR0q99twLDvbVJO4NVTVOeBG+XA+
 RnclEqTL9PFwHum7tgR25JZFcJREG2BP7gTZ4cQULTwElB69lBgFU3xFqxkEeh2TKRlc9Nh93J1
 LqQR2G2ffw7ozuxejOFR9YnvJ/QkhKQFnnkzkYfC32ZWazOg3QF2VfJc/p4LcNUGQReDX3sIv9e
 Z6iA43Qrb7Il3lx79Eq8v9GRzLpK9SjFGNa+DyxEeWtLqR1
X-Google-Smtp-Source: AGHT+IHs5kBLqvglIGb0rAAHuNp1SW6Ksisw7uVNx58pzjDAU6zTXIFFVB/6IZ05F2dSuGF1mY8+3g==
X-Received: by 2002:a05:6000:18ae:b0:374:c847:852 with SMTP id
 ffacd0b85a97d-38260b806f8mr11899215f8f.29.1732548374880; 
 Mon, 25 Nov 2024 07:26:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe98asm10565203f8f.39.2024.11.25.07.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5786D5F8B7;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/28] tests/functional: add a QMP backdoor for debugging
 stalled tests
Date: Mon, 25 Nov 2024 15:20:54 +0000
Message-Id: <20241125152105.2100395-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Support the QEMU_TEST_QMP_BACKDOOR=backdoor.sock env variable as a
way to get a QMP backdoor for debugging a stalled QEMU test. Most
typically this would be used if running the tests directly:

 $ QEMU_TEST_QMP_BACKDOOR=backdoor.sock \
   QEMU_TEST_QEMU_BINARY=./build/qemu-system-arm \
   PYTHONPATH=./python \
   ./tests/functional/test_arm_tuxrun.py

And then, when the test stalls, in a second shell run:

 $ ./scripts/qmp/qmp-shell backdoor.sock

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-18-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-18-alex.bennee@linaro.org>

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 6b5d0c5b98..b8ad7b0bf7 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -176,6 +176,16 @@ primarily depend on the value of the ``qemu_bin`` class attribute.
 If it is not explicitly set by the test code, its default value will
 be the result the QEMU_TEST_QEMU_BINARY environment variable.
 
+Debugging hung QEMU
+^^^^^^^^^^^^^^^^^^^
+
+When test cases go wrong it may be helpful to debug a stalled QEMU
+process. While the QEMUMachine class owns the primary QMP monitor
+socket, it is possible to request a second QMP monitor be created
+by setting the ``QEMU_TEST_QMP_BACKDOOR`` env variable to refer
+to a UNIX socket name. The ``qmp-shell`` command can then be
+attached to the stalled QEMU to examine its live state.
+
 Attribute reference
 -------------------
 
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index e2a329c3e5..fceafb32b0 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -175,6 +175,13 @@ def _new_vm(self, name, *args):
                          log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
+
+        sockpath = os.environ.get("QEMU_TEST_QMP_BACKDOOR", None)
+        if sockpath is not None:
+            vm.add_args("-chardev",
+                        f"socket,id=backdoor,path={sockpath},server=on,wait=off",
+                        "-mon", "chardev=backdoor,mode=control")
+
         if args:
             vm.add_args(*args)
         return vm
-- 
2.39.5


