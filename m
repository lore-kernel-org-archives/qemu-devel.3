Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A950C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcg-00005f-Rm; Tue, 30 Jul 2024 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpce-0008OJ-KT
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcd-0003YP-1e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:48 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a9e25008aso619453966b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356565; x=1722961365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De4SMrBSDt0IKfpACiMysHGGtZ7LaSlvWkE+afXomyQ=;
 b=oeVnyjS+0H70oXQpfVztCnbIbiZ2QUYf+bmsdJemW89wnRIvN4dRVuOzGvD27YQGq7
 BT1BNaoaeIYxbuCeS44iPGGPewAJCl76fusWIpsPKVrIYNb4qdPRKyAOY61/ZJzEY9O+
 +ml/NyaCpgKk1F40FTu4IeBF1um8cnvoqowTCqQFuG5b27BenrdMWJ+vpY1ML/CnJIhA
 SXNliTfcbSKrBk5uznENytuC7QTDlrgRiTrffHavZtPBtVR/bhc4Gudc0yBuefAqB0U7
 xBE5z8zRhOceHU8gnt+gbX3C9b5+NFk5eatGY6QQj7ZAatiUM1CQaB2uLSRHyEYINg8o
 QfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356565; x=1722961365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=De4SMrBSDt0IKfpACiMysHGGtZ7LaSlvWkE+afXomyQ=;
 b=u7PLAhnsc/HPeTe20B7OT55hAMMnWGy/l9WL2XKVhajb6FsXC/c/HzIzUatmPI9gmu
 NN8H98dV+3bf4L75dbweoEDFZBVfZnA0vzcbXzGXlittckikIc7g4yz1NstHn7Rd8DOJ
 Kb/sSwxO6Ymdr5TYumwlPJcUGzgTx4xYWiycEAXzfrpqD0RgaErkA1kAx7Scfly0GYd4
 7vfNwi2a1qsxyUVj4SihAzyd28qLeNqZVRZC2AejSQdsgSl9QAbBtrmpmW/jk7BmCCGH
 dJRseKHHdmn1LmKzxKXNR7bDGsK8YiOX+vTVfGIpkjP58JcWPDPebUEJ550iDmKBAHge
 EZ9g==
X-Gm-Message-State: AOJu0YyJjSxvU8KDWe1Hv6vZVEGpaJ0wxRTQ7eYIR2Fp5r1sANznloyc
 vwcJcZIjQhl9xiqWv+DYTl2ndcKg2g2kl2T6aueW19LL/RCcWKdaYlSCux7gFcM=
X-Google-Smtp-Source: AGHT+IFPqROpx0V8jxvENDXxM0BcR9BwAzQaQZwgpLK7k9cHtaDtsP0/3AopMi1H9LwA0yKBxH4lyw==
X-Received: by 2002:a17:907:d17:b0:a7a:c256:3cb with SMTP id
 a640c23a62f3a-a7d400e1442mr768461666b.39.1722356565189; 
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab5c8fdsm663824766b.89.2024.07.30.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 909945F9F3;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 08/14] tests/avocado: remove tcg_plugins virt_mem_icount test
Date: Tue, 30 Jul 2024 17:22:31 +0100
Message-Id: <20240730162237.1425515-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Since 4f8d886085 (tests/plugin/mem: migrate to new per_vcpu API) this
test was skipping due to not being able to run callback and inline
memory instrumentation at the same time.

However b480f7a621 (tests/plugin: add test plugin for inline
operations) tests for all this matching up so we don't need the
additional complexity in avocado.

Remove the test.

Fixes: 4f8d886085
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-9-alex.bennee@linaro.org>

diff --git a/tests/avocado/tcg_plugins.py b/tests/avocado/tcg_plugins.py
index 15fd87b2c1..a930fca2c0 100644
--- a/tests/avocado/tcg_plugins.py
+++ b/tests/avocado/tcg_plugins.py
@@ -120,36 +120,3 @@ def test_aarch64_virt_insn_icount(self):
             else:
                 count = int(m.group("count"))
                 self.log.info(f"Counted: {count} instructions")
-
-    def test_aarch64_virt_mem_icount(self):
-        """
-        :avocado: tags=accel:tcg
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:virt
-        :avocado: tags=cpu:cortex-a53
-        """
-        kernel_path = self._grab_aarch64_kernel()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyAMA0')
-        console_pattern = 'Kernel panic - not syncing: VFS:'
-
-        plugin_log = tempfile.NamedTemporaryFile(mode="r+t", prefix="plugin",
-                                                 suffix=".log")
-
-        self.run_vm(kernel_path, kernel_command_line,
-                    "tests/plugin/libmem.so,inline=true,callback=true", plugin_log.name,
-                    console_pattern,
-                    args=('-icount', 'shift=1'))
-
-        with plugin_log as lf, \
-             mmap.mmap(lf.fileno(), 0, access=mmap.ACCESS_READ) as s:
-            m = re.findall(br"mem accesses: (?P<count>\d+)", s)
-            if m is None or len(m) != 2:
-                self.fail("no memory access counts found")
-            else:
-                inline = int(m[0])
-                callback = int(m[1])
-                if inline != callback:
-                    self.fail("mismatched access counts")
-                else:
-                    self.log.info(f"Counted {inline} memory accesses")
-- 
2.39.2


