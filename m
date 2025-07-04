Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50B0C83F0C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDp-00086D-Vr; Fri, 04 Jul 2025 12:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDn-00085M-Nn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDl-0005rI-Un
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so6161755e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646304; x=1752251104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0FNB0Y/hxjBPu/8t+fC050+nfMllIieEiCtJqxKj6X8=;
 b=ir0uYMR8IgrlCvEdseZPCUBrQh0cVY4uONEZbSDEXqiCshDpRAjo9WFnZN2CMyRvNB
 tmCpBZvCzSlnlO2AtZ/Jh9T3KtbqJFs225ifKfpeCT9xxExzzHQBVNI1xRfsf46EYxn4
 90jc/yNkAi/w0PHvxLo9MovkhczGphN4vnKY7MYD12fUuf/uPoPcIglawyNtFfNz8+rX
 2eI7OgrPacmQdkj/nfwkgSVKIRleU8scPNQGICTji6Qpp0NCKFJY1tAOHLFNptMKR5Ce
 Boed5K1I7IVz6kwYfOWxoC33ppwK3REK0EzANZ7MkgKYTuU2CzGbE+pHtDHa6vndYfFb
 XM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646304; x=1752251104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FNB0Y/hxjBPu/8t+fC050+nfMllIieEiCtJqxKj6X8=;
 b=Idyb0O+arXaRvHrD/5Ub8MV+GmmxvU/yGenJ88xy9p1BWiiaENHNIt0ZIT3NVxZEDX
 4Zc0qm8pqccd2sjML5e9zO/44qoGBWpXjdTDPuztY/MrWgiYBe4WUr7QIG7Sl9T+lFEp
 1aAyzu05SBnJN5MHtF1Z4sxTZAMTyyMEccyf7SwS5dFKhr2vCTt1OWhsC75HfYwnEZ83
 j/tXm13OtO2pG9kDrGQ0B1qfUnk0ysuv/i7EGFluiKIacvn7ELc3RtB0cnyY0yGaFoj5
 Znj/OPWohsmYYeSiPYjZZpCBTbnkQKLDcPk74d2S1oxkoRSaolt3Nv/xiXQLFVaBTZXs
 Uedg==
X-Gm-Message-State: AOJu0YxQ6g2+8jfUK0HtF3JFLMThlCi+EcA3JqOOSLqQKJjZ8uCYAWWU
 H6vSOH2C8YB5dSL/88OPYsYqNPJxsBdMmAWcritEvs4HjDID8iPKdUMtLQ1m0Zb/66ZKulGrH1d
 T0CjX
X-Gm-Gg: ASbGncsU+NokX/iT68pABk207kKs+NUEdBmloFEw5Vag26sYJIxp2/l639hGwvOFN2d
 HWdQNGK6Hd9UjmgB2k7OP88gk9i/1zE4gXndkFVv3znzwktf9PG4Vi4CX4zgsatMBGcaqeFGslP
 AtLUWOsINKCgU4OdDdPIbtxEi9skbmLv9FrcvZ3Un/RnCNyWabuQo1jvDBbW+mveACaOK5oYrBi
 RibKvwMVgafDM0Nq2K1h1fkzuqcekjizkssAXXKx8Ht8Soi6g3hwo9wtKipXs/55iua9q6dr0GN
 kaFLMHjUK41RO9gEg/sCABrPd2EZYIKMRA2/yD3lQmy8rEzXXzTSnnHMONDjAx4/Kb6e
X-Google-Smtp-Source: AGHT+IHmgJ6dzJmJ7eytg1AsD50sYGIjW6Bw7mgvuH3rHCuoEnZYRfgkiL+yUggK9/kbbaSFB1a57A==
X-Received: by 2002:a05:600c:8219:b0:441:b3eb:570a with SMTP id
 5b1f17b1804b1-454b3107ef7mr29878825e9.2.1751646304181; 
 Fri, 04 Jul 2025 09:25:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 001/119] hw/arm/highbank: Mark the "highbank" and the "midway"
 machine as deprecated
Date: Fri,  4 Jul 2025 17:23:01 +0100
Message-ID: <20250704162501.249138-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Thomas Huth <thuth@redhat.com>

We don't have any automatic regression tests for these machines and
when asking the usual suspects on the mailing list we came to the
conclusion that nobody tests these machines manually, too, so it seems
like this is currently just completely unused code. Mark them as depre-
cated to see whether anybody still speaks up during the deprecation
period, otherwise we can likely remove these two machines in a couple
of releases.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20250702113051.46483-1-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked deprecation.rst text]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst | 7 +++++++
 hw/arm/highbank.c         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 42037131de1..b24c278f707 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -344,6 +344,13 @@ they want to use and avoids confusion.  Existing users of the ``spike``
 machine must ensure that they're setting the ``spike`` machine in the
 command line (``-M spike``).
 
+Arm ``highbank`` and ``midway`` machines (since 10.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+There are no known users left for these machines (if you still use it,
+please write a mail to the qemu-devel mailing list). If you just want to
+boot a Cortex-A15 or Cortex-A9 Linux, use the ``virt`` machine instead.
+
 
 System emulator binaries
 ------------------------
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 3ae26ebebdc..165c0b741a5 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -357,6 +357,7 @@ static void highbank_class_init(ObjectClass *oc, const void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->deprecation_reason = "no known users left for this machine";
 }
 
 static const TypeInfo highbank_type = {
@@ -381,6 +382,7 @@ static void midway_class_init(ObjectClass *oc, const void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->deprecation_reason = "no known users left for this machine";
 }
 
 static const TypeInfo midway_type = {
-- 
2.43.0


