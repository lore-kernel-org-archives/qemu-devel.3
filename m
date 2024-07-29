Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14715C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRc2-0004Qs-AK; Mon, 29 Jul 2024 10:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRc1-0004Lh-4I
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:33 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbs-0008Pk-BZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:32 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so4785709a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264263; x=1722869063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k68dUaa5yNSOgGnmccLcS4zpOsOezQjGJywa7D7FDBg=;
 b=BoV095cys7xqWDm8wqPwaBpdfNGen9D8k02VQOZjkxN/vb2dSOODpfQFF72ROMHJQL
 1KO0wZtX/DPNqXsaWigkSjzZm3F+T0m5RQ/UDJspmHZEctQLDynD6D0hLHXF3P9N+Zxz
 0Z4aaY2XHfG2oizP/NxMaEvw6xEB61cqlJaPGjgTDCAF1mBC3vCxtrPbFFP8yrhp7AUN
 MZ0/dLaAIe5Cr/qi8xG6DNjK1ItgMLrxFSiFJWsP288srNXo+zhOrGVo33ihnCj39qK/
 zl+sqFM/mY6aiO9G6/9OK8Aqy5NCtfjkmNZmZyBpIUxO5RJhY1oOmcZ/QSiJkm4LHONF
 wdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264263; x=1722869063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k68dUaa5yNSOgGnmccLcS4zpOsOezQjGJywa7D7FDBg=;
 b=eUR9OYgr2p2mkyV50jDT1h6HVCDOfE9A4c1gU0ddhji1G2rZie3p23OTwClJP6AxBt
 gsrI+owR98tiVbzKFRS7psaKPzARkwrbSSgPue8+pddgUgfgyMQZrwqeP0SfYgsEKxio
 KX5WP9W1iJcvF05r/Eh/D0J4/mlkIEgCGk18GJ0xP5ufFaDgmPdS9iZfJb41Z+xgKEIu
 6ChlQa/hhhPzSeEIDlAhKyY3NHB7ncYNCLAyCkjyo7+m4t/gFAV3qSOt7aK7P7YCyp/z
 YfWVZ1p0Egf6fFONfoelu4rvSlJsNfE2uKj3bXAO866fTk/WCuvPXUiMyRu5QKbydjiT
 PVlA==
X-Gm-Message-State: AOJu0YwZRonmam1oYeAjTHNF5e9UWcYakZuty9vDRdiQy9MPKd+FdNTc
 wuW6nv3/PhE41KWaiRZ/F5aZkIIsEUgd4S9T+C3vjG8R22UWuf+GAjzDydNVT68=
X-Google-Smtp-Source: AGHT+IHisnIBoJDnsJGlOaz1G2ZgOZJJy3ylebaI2AyDcFA0RiUAwTnoNA5VQHG6BKW8J01ncI8GJw==
X-Received: by 2002:a17:907:944b:b0:a7a:bae8:f29e with SMTP id
 a640c23a62f3a-a7d400a0385mr487093366b.29.1722264262589; 
 Mon, 29 Jul 2024 07:44:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad902e2sm520163766b.146.2024.07.29.07.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC9615FA08;
 Mon, 29 Jul 2024 15:44:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 08/14] tests/avocado: remove tcg_plugins virt_mem_icount test
Date: Mon, 29 Jul 2024 15:44:08 +0100
Message-Id: <20240729144414.830369-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: 4f8d886085
---
 tests/avocado/tcg_plugins.py | 33 ---------------------------------
 1 file changed, 33 deletions(-)

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


