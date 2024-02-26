Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7BFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWQ3-0005AP-NO; Mon, 26 Feb 2024 03:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNy-00035H-Ns
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:31:05 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNw-0005nL-Og
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:54 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so5383865ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936251; x=1709541051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GhIegaqPh+2F5bGtrPWjGv3DhZxRhRPtOUxR87HPoU=;
 b=k3Gye/DGP1U5R3/W6VCnlJ03rFO/A0VBFiaU40jfy4BErQMUt8Nl8vkI2JJv105bcI
 F6rZoKmINEevlx8S8naoN2q5WyIXUaaxhbBhVe0pSyaPgxBQUK6PeIr/1eM4ry3Xf4Zv
 3T5Ze+ldSsG9+WbkF8RKmZDMjO6evkMtexmoS291X9euP6Xalwy2PiBkyiLu4ewmYT/B
 e5vpqNY1iDHTbIzATC0s3DGwPs12Krf67Q0ZQLL7WWC4JdR7Ffk3w389662/2oR97s2/
 iTxPfdm18JG6cYNs49FNLwlIKzRE3GjFB1/T+ILPfXIvK/hkaBe/UroAN7nCasLn1icn
 fCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936251; x=1709541051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GhIegaqPh+2F5bGtrPWjGv3DhZxRhRPtOUxR87HPoU=;
 b=N/wi+9lnOIc0QQevAiziDXY6gogfwHwS1wrrDMtIoovvC9KaLm6iDiRXutZQabt1Tq
 3L6CioQ90qUfJsR/Sh1VOzdNNJLP44iF5GxHVwodb1YiccxYjVk4VAvHrWVwvwdEiVQA
 CYkJmD0d3xmCgtKUVDPP/HmAELWr5KRNgStEexQD9cLunvZi1dcmVWhs2kv1/uIz8+z5
 DATxYV13vCQUoh2+iY1aV7VbgfMZBiLBh8QyEYIT1Ot2axPKJrl0wRFy0ycZM4D/Pdc2
 9wrq3DPqh9pfLyVW/vX4+VXq/Orq7jMWKGD4RWVu5R6HNMc3+N9XOMQRT+Q8V74qAbdm
 SApA==
X-Gm-Message-State: AOJu0YxpmRzIpiDGUGeiBybIkXB3ij728sUEWNvKhFAHbLsBt5p3tAgQ
 eatdve2daWbi4jmOAvnk30PPv/FG8qZEvcnxmV5A6KyTznmB4PWEqELiiBQt
X-Google-Smtp-Source: AGHT+IGtaVwieVvTt5edonRqVilmhepCSSW8NYN+I2NllhVZeG2//+/e6dUERcqSwvdZtr2M9R075A==
X-Received: by 2002:a17:902:c942:b0:1dc:a681:ca08 with SMTP id
 i2-20020a170902c94200b001dca681ca08mr1646050pla.28.1708936251379; 
 Mon, 26 Feb 2024 00:30:51 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:51 -0800 (PST)
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
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 9/9] tests/avocado/reverse_debugging.py: mark aarch64 and
 pseries as not flaky
Date: Mon, 26 Feb 2024 18:29:45 +1000
Message-ID: <20240226082945.1452499-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226082945.1452499-1-npiggin@gmail.com>
References: <20240226082945.1452499-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

These seem to be quite solid, including on several gitlab CI runs.
Enabling them should help catch breakage in future.

And update the powernv comment -- gitlab isn't the problem, there are
known gaps in implementation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 92855a02a5..8fe76ff921 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -223,9 +223,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -248,14 +245,10 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     REG_PC = 0x40
 
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
         :avocado: tags=machine:pseries
-        :avocado: tags=flaky
         """
         # SLOF branches back to its entry point, which causes this test
         # to take the 'hit a breakpoint again' path. That's not a problem,
@@ -264,7 +257,7 @@ def test_ppc64_pseries(self):
         self.reverse_debugging()
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/1992
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'powernv migration support is incomplete so rr debugging is flaky')
 
     def test_ppc64_powernv(self):
         """
-- 
2.42.0


