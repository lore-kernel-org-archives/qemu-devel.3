Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E9FD1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CZl-0002ma-98; Tue, 22 Oct 2024 06:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ4-0001qi-Jw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:38 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ0-00025C-Ot
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:37 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso442420366b.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594593; x=1730199393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pgb6ox3Ya7i122uZlocXrETTS1VOKhPW7bSAndX3jjQ=;
 b=X02Ook7/58CsBExkq0/lvB1P8dip2HNM/87gbjsnCpsXVg/uzlJ43DJ19XP+kAL910
 4bQKFRMW9BdFhVO5im+FI3FWpjBxn4WPK4VAwzcNWMP5cHVU8VnBlW1Ko8CBU65S9khW
 ondalbrvdcf5M3e9A4aW1LfSKZLjsnANn/cyBPlpgAqtc5qc0uNlQTihh/w24u6K5ixE
 OJU3dnrUlqnTHNdKx2OwSBerjxcPsKtokos4rsteSM7KzMWsV36/PvpVqxUpBo7eFRG/
 PDxj7TIns5gymfEb5K/pcD7dQjog0SsVGizXvskkZi8MDJc/52aLSp3m1bsYxhCM0Ool
 ebMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594593; x=1730199393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pgb6ox3Ya7i122uZlocXrETTS1VOKhPW7bSAndX3jjQ=;
 b=hrKu8Fmj18EbFP60iIi9yl8feZH4naHcnKDOl7sBA1C0m4HADpNh5MNRP4mYchn+a5
 3S4YgksLrUg9GSSsQDiHU3oAkHAtjcQebZmr1tCTxKnzOhTqxwyF2aYkyvtMkp+q/9c/
 DH6ruLrf2S1KUgmnzZzhGIuGFJqFLdvvfEzStmjGRwp16fGgvse35Ue9fuxzFBr/6Clq
 hJfhDLcQ400R3gU+Rx6A/wX0ZZcpn6DQ0c7Z7gVFH6EgT7p7WgUMnqU0CuaQqthAwtxK
 uwZL5jTLbPfn1sZFKrOa9if/RhMl+eTgkKHTkzdGhwzY4Ci4M043O4ZBOxWBYHLsKtga
 TZaQ==
X-Gm-Message-State: AOJu0Yw4aq1kfuMDSxapRvNRWIEaWKKboZ5aw7Yttj/3eqe8yhY6YxRz
 lDzg/iQt4CHmDWnOtgI9JrDC6BLvrSl0pEix8JoS+ENlwUXkIsKx34FXt4xT5Ls=
X-Google-Smtp-Source: AGHT+IGPREmWhIG8Sxc2dRJUVUnivk8DPIAg98Rjd0GSZmqkbNvMhBR1OB4OKQK6ufaSF5tJ1fK0uw==
X-Received: by 2002:a17:907:97d2:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-a9aace98a17mr198686166b.38.1729594592591; 
 Tue, 22 Oct 2024 03:56:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d838csm323114066b.8.2024.10.22.03.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D97B25FC0F;
 Tue, 22 Oct 2024 11:56:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 14/20] tests/tcg/aarch64: Use raw strings for regexes in
 test-mte.py
Date: Tue, 22 Oct 2024 11:56:08 +0100
Message-Id: <20241022105614.839199-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Use Python's raw string notation instead of string literals for regex so
it's not necessary to double backslashes when regex special forms are
used. Raw notation is preferred for regex and easier to read.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241015140806.385449-1-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/gdbstub/test-mte.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index a4cae6caa0..9ad98e7a54 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -23,8 +23,8 @@
 from test_gdbstub import arg_parser, main, report
 
 
-PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \\(0x[0-9a-f]+\\)."
-PATTERN_1 = ".*(0x[0-9a-f]+)"
+PATTERN_0 = r"Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
+PATTERN_1 = r".*(0x[0-9a-f]+)"
 
 
 def run_test():
-- 
2.39.5


