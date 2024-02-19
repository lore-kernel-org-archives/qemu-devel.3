Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12445C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz2j-0000EY-M9; Mon, 19 Feb 2024 03:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2h-0000Ch-RS; Mon, 19 Feb 2024 03:30:27 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2g-0002A3-B6; Mon, 19 Feb 2024 03:30:27 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so3468025a12.1; 
 Mon, 19 Feb 2024 00:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331424; x=1708936224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTfr4UZR0ZDgzfI1nl1wTlpSSiyF2aw01vFNFGzy6W0=;
 b=iqvuRzLLUpAqah10DxroNr2Iw+7Q6kRFboVWFEjjxWrrAOtv0TgT18BotRuXomYA18
 gTSXfmnL8SPSH8Kli/YsyZMMamc/rkfIPqywkX/Xh0Py+AsbkaknQDllewsQjGneDh4j
 BIk72m9ZDq/IOcX6Wcf8BYN1vTMYioKNns86E6KqvKfrna2XHJXpqz3jDSbsweQq3p+V
 ea0sKn1Rl5kvHdNLDJi1Mxgc4aqcrbiFYY8QuqiWKqu28/NflJaNLPlF1qI0ZEHlMll2
 Fs3ag0wHe0piR54eRo4eTSXlrs/lvuanuntnNgHH3+a0XmL/s5S1qOoxUjJWNcYMcvPU
 akZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331424; x=1708936224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTfr4UZR0ZDgzfI1nl1wTlpSSiyF2aw01vFNFGzy6W0=;
 b=Vyx/zapTDffTzW4NegOwU+baIbR0fF3gtPuZ58KeH9BhbzeWPfrvyoE/3CuEW6Ndc4
 +4kINnMxHbnuoalb5YQaSXQBjuI/lhGZiJHlZ4Ur1zpSdrwohkQ621FZ9ahAmD79dNxO
 LAx49n0PhiLasVQWP/aMckaWmKIMRM4QcfJ2nUMCKmQzFPp59EUlzRTYtAQaD0TyKcYY
 3914ySbw+NPlRWWxczgGBMLN8K+yqGoaAmW80yaXKwyzRIEhYkUk7AJAgdKl5A3X2LVz
 usvUKD7ZWFjg+URjFsv+twf76sE1DPQtFnXqinGaM/BIZv8Q9LQYWXIs/cuWWildetBN
 SG0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXhokZtiaAOEBYTTLJBDRhMmmRxUyPCplhQibWzKsA8V6HrIPeK9Za2Nd+kYwCHB+eDWNTSn60ug3UzCa/HxVKuy+h
X-Gm-Message-State: AOJu0YwB/RrEwvd0Z5DNyd1S6yq5GY7Zl9q+q/lVrDWvq4rFjRNJ50ew
 2DB2I7+yMiZSymLG1csheu5SJaDg3peTRv4aaGno7GtzsLNe3v8C1wNoLeF1
X-Google-Smtp-Source: AGHT+IFBGJK5xVP4OxbzkHctZG+DJ8HYAx4S90tpa//Tg2DX1GqIFXjcfGK4K1WMKYfmozHMxusRSw==
X-Received: by 2002:a05:6a21:1518:b0:19e:cf31:6a04 with SMTP id
 nq24-20020a056a21151800b0019ecf316a04mr12002780pzb.59.1708331424208; 
 Mon, 19 Feb 2024 00:30:24 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:24 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 07/49] tests/avocado: Add pseries KVM boot_linux test
Date: Mon, 19 Feb 2024 18:28:56 +1000
Message-ID: <20240219082938.238302-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

ppc has no avocado tests for the KVM backend. Add a KVM boot_linux.py
test for pseries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index de4c8805f7..61ba13dda8 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -103,6 +103,14 @@ def test_pseries_tcg(self):
         self.vm.add_args("-accel", "tcg")
         self.launch_and_wait(set_up_ssh_connection=False)
 
+    def test_pseries_kvm(self):
+        """
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.vm.add_args("-accel", "kvm")
+        self.launch_and_wait(set_up_ssh_connection=False)
 
 class BootLinuxS390X(LinuxTest):
     """
-- 
2.42.0


