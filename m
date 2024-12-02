Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB33E69E90
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 20:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDDf-00021W-7H; Mon, 02 Dec 2024 15:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDDd-00021L-Iz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:40:33 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDDb-0005c4-VQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:40:33 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53de84e4005so5454218e87.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733172029; x=1733776829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2XoDAWdORdsMKiHDSiAyc0B9Se24JUBVtjW/pCowaE=;
 b=ETtWKxg/L6IGA3baNerVJQUI/dqQVC3gLbiEk8EFx/MIoTIMYDANcDWfD/0YjxLTw7
 VTcFetCSREiUNo/dmL7TzVFRkyIH4Ji1Izg2MrFwuKsxStcJr/G6J/fRn501o7SihV9A
 pXrGURG0RytQaI9VnR25w/quECFtCECnP4zjOT+Z/6CIhW95RZBBk6NfQNNNF9KXUGRi
 ULC4408mxaTR071f40+GXt54TQ1EXwew81PV88wy8K8k6TVqrT8/2N63kX97sNhhH+we
 gXARCV8/MI45SN8LRgLObCHEs0JJaaC9xoEwV5mS+uJLfiAENCaGos2w3zXKC6jeTi1G
 aIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733172029; x=1733776829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2XoDAWdORdsMKiHDSiAyc0B9Se24JUBVtjW/pCowaE=;
 b=VoNa5eyRbViqNFVTJbKoVNOQcbj4xJZ18NZXlHGHRk14Ee4bfD4VypPQwUwNBs+Mvc
 Gx6O1Fo6AEPNfWstEz4rnl8q1uQshMgnAXGjWMW7+vB1Fx4MdT7PtTsugcoAsOifMN9/
 DwT97T+YkxUJWOdgGAYBww/bScfpx6ehOhL3l6YU+qFuSME0jXvOGAlfBkqpOfxBBbwh
 eu9UQHDGiSq7/EWAhR+i9uF4nx5PFeE/PJBS7efzKKUZ8kWr147J5CiLbS9SIGeSnLKJ
 euZshyiJYEk8m2EKfymoRkKt46jvAuqCun2uV3YCON+/Lkc6Mp/igNaQtX12a4/SYAIv
 GvDg==
X-Gm-Message-State: AOJu0YxekKDP8AnKF2xgE06/yQSXTUSUrB3hrOcB8nq+htm3gy0jT5/n
 6BGzfk/8zO8SWrfnw0G9OTpkGoRGE524U3sSfiz2Q5T2HFBSSM+nibr2Qs9NlypUpnU38w1XpKF
 BzeA=
X-Gm-Gg: ASbGncsBf+ntwU7lv6L9S0am1RPAo4G7C67qL5pRMjEBG+stJa98CJ9uvrZYtLCs2k7
 LIGdsH36vklADWdBhrd3DzcP20xhj4HZcxrmf9TEVYpAnfgc6ttD4SHz27vcHc1s8ZGIN3oj57P
 welLGnt1ezDVjVVkRVUfPjibyVJ6qh9Eoqm+aMtaSSkDHBfwAx7mFhG5T4Y+LYGTIqzB8LmRxqD
 PVy0oaHo2JSzI4mDyLBNN50Fgk2ZrwvV82vATFPolFmgpMc1fkQvAZobgUcDQ8nYuWSWmJW
X-Google-Smtp-Source: AGHT+IGg4cOsDt79qCOwN3NcxhdyGA82BcfLjhbtDpBvRFyrQ6k5pa5Xs7ay8BwNkBGLv0U3eSFuaw==
X-Received: by 2002:a05:6512:b19:b0:53d:d136:c2dd with SMTP id
 2adb3069b0e04-53df0108f94mr14054372e87.41.1733172029468; 
 Mon, 02 Dec 2024 12:40:29 -0800 (PST)
Received: from localhost.localdomain ([176.176.160.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59991f11esm541817266b.167.2024.12.02.12.40.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Dec 2024 12:40:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.2? 1/2] tests/functional/test_version: Use QTest
 accelerator
Date: Mon,  2 Dec 2024 21:40:18 +0100
Message-ID: <20241202204020.55665-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202204020.55665-1-philmd@linaro.org>
References: <20241202204020.55665-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

When testing with a HVF-only binary, we get:

   3/12 qemu:func-quick+func-aarch64 / func-aarch64-version                                      ERROR            0.29s   exit status 1
  stderr:
  Traceback (most recent call last):
    File "tests/functional/test_version.py", line 22, in test_qmp_human_info_version
      self.vm.launch()
    File "machine/machine.py", line 461, in launch
      raise VMLaunchFailure(
  qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
      Exit code: 1
      Command: build/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
      Output: qemu-system-aarch64: No accelerator selected and no default accelerator available

Explicit the QTest accelerator to be able to run the HMP command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_version.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_version.py b/tests/functional/test_version.py
index 3ab3b67f7e3..477d3908d8a 100755
--- a/tests/functional/test_version.py
+++ b/tests/functional/test_version.py
@@ -17,7 +17,7 @@
 class Version(QemuSystemTest):
 
     def test_qmp_human_info_version(self):
-        self.set_machine('none')
+        self.set_machine('none,accel=qtest')
         self.vm.add_args('-nodefaults')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
-- 
2.45.2


