Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139D9C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjf9-0003XU-JN; Mon, 11 Mar 2024 13:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjf0-0003Ix-Rk
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjey-0007Qm-3t
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so3381944b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178918; x=1710783718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eazafKsUh9Gq+1jlyAtlIIMsQVJTUKsjooFoPTkUTU=;
 b=EEz2UXclFZjsyfOBXgsGm4vyGiwoeo4+eSsPrX9ENO1CgfQEwcdlXWF19m14kWJ+DK
 WEPy7VYaUK6yLDW6xZM9LYioYdD3MwSE9dL+emCL7pEeatEwG6fc+ty8uQpez//NV5wI
 q5YDkEal92XHVJ1OpznwHSj0eMFaNkF5VlFdDkTuoPIIh16GDVu0hqGwO+2EB02M84mO
 htVkKrzu/pEibjv/FAN77Ncugg/0/WmjpTiqYWDT3LdyI1WOKEfc/RuCvlbKB8CHTrJh
 6km5SAVlGO+hHnYzmFZCYEfUhg45NHFZKO5MIq4meKLMpwoRhGr4zOuukaI/sDej3UnU
 LpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178918; x=1710783718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eazafKsUh9Gq+1jlyAtlIIMsQVJTUKsjooFoPTkUTU=;
 b=AefF9+z+vcmIOaBnBPA8ir8fNUaDrOQh2t39NhJPszs2BanFo1XGaEVwa62/exvliS
 zonN7m4DezhRu5gHBXwxgrmuhoDV7lxzYPhwQQt7yOVGH0Q4UW0awJ5gNFy1zbA7YHX8
 lZugg6+ViG5yUOiU5uLb6fKbl3JU2DZDAEOOV2ILaheOwq7VvSVlg59mgO2bjy0Cg8ao
 f/qcNHU+h+11p7UEzlcgItst9QXL+q/Lp/6T0K8/6+cbYgzdKzuupmRD+uHKyi+CYpXJ
 98x8Zoq4oMiaLU7gS2Kv5ONdBA5MKEJc+Ok75G336NkF5EcnVuV2VP2LXkZkQLpZXuR7
 R84A==
X-Gm-Message-State: AOJu0Ywe0c/jOFqpKenJoTBiQqilRmhm43dOiwn6/oRfmoelzfFgN2Lo
 Qb2KAoMCxNCYym98ZgBX8NdHRoc8Kj1o/NTwkKlUQ6yUV25G86jeY+koPWM424U=
X-Google-Smtp-Source: AGHT+IEwlmUuf3SMj1mN5Cry6+I5wPwFa1oeWtT5/HJBaYKr8kLP4c7r1U9FAggNX1PtQ+mN7DZp4g==
X-Received: by 2002:a05:6a00:1309:b0:6e6:6e12:493f with SMTP id
 j9-20020a056a00130900b006e66e12493fmr8739960pfu.2.1710178917635; 
 Mon, 11 Mar 2024 10:41:57 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 15/24] tests/avocado: reverse_debugging.py add test for
 x86-64 q35 machine
Date: Tue, 12 Mar 2024 03:40:17 +1000
Message-ID: <20240311174026.2177152-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The x86-64 pc machine has a problem with record/replay. q35 seems
to work well. Add a new q35 test and update the flaky message for
pc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 8fe76ff921..e76cf54ad7 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -206,8 +206,7 @@ def get_pc(self, g):
             + self.get_reg_le(g, self.REG_CS) * 0x10
 
     # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'pc machine is unstable with replay')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -216,6 +215,14 @@ def test_x86_64_pc(self):
         # start with BIOS only
         self.reverse_debugging()
 
+    def test_x86_64_q35(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:q35
+        """
+        # start with BIOS only
+        self.reverse_debugging()
+
 class ReverseDebugging_AArch64(ReverseDebugging):
     """
     :avocado: tags=accel:tcg
-- 
2.42.0


