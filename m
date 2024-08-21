Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1F7C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 15:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgnQ8-0005bj-A5; Wed, 21 Aug 2024 11:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgnQ6-0005aa-7S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 11:38:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgnQ4-0006rt-2a
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 11:38:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42ab97465c8so16749535e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724254721; x=1724859521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=naHeH0U6aHnuRCT896fHl0WFuLymRF+ETiA3SIMH19k=;
 b=S2hHC38dqCpbh0s8QSt+/huCLgrlA7B2CABNRmgEytzaqXZI79+SjvS/MQZ7i+xe5I
 n22bX1bsiNRwJSYo+njRZ+qIjWDgKv/Vv6iWhcD1u1IJfqSwOm+btWFabgQOOuaCyagS
 ZrbHq3B4DLY0qDlyBfXXxoyZyaEuM4vWEXuM9TVbniZLkQiObqdk2Q3RwImF2DWmhNAY
 r1Gv4KqdCuBBYhs6pIj8VxfbdvBzFLlzQ8xZMysDkBqUi7h/FaiZIPFI/aWqoKLH5/9Y
 f4cCvOS/vdJvkL5P7sikPtBhMcUpusciXJ7B0uPow0NopXxsUHEPV8QbaAlPq2ydP6NZ
 JV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724254721; x=1724859521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=naHeH0U6aHnuRCT896fHl0WFuLymRF+ETiA3SIMH19k=;
 b=T6pe8N17MwR3tuGlUmZBJzhnmDoQyJX5uIjmCdr5gKonMnFBSvQ7bdSorg1fcYvOlS
 BQl/b35toU4qxOgKnVtYSx3BS6kBCbtKienO3vAO4j0hREC/dHahsci7bpleM1+OoDBd
 Ib2CTM/mFNdTHrssU2LKsslQakJJ7XhUGxEp6rdLfrUZq5ZoX7nt6yuPbGdSYHP7Bqb4
 EDMOdd49LNEmLiodCJocGxUChgftvXZBcALcPwgj9tnIClsLCFnuPexknOfw4fZVTKAg
 etRH9utFgrmuzvkfePiiqHab4bC7lFmotJd090mzWwBxWVVb6+WZhfRvJm6KbUce1sPM
 8bJw==
X-Gm-Message-State: AOJu0YzSKwvK29JXnPGZd9HpJLSFyMjQTH+7TPRRKHtRPoBtGE9ojwBy
 S1FpKzHpbMN0I4plDse5uRk5vB++XOuAeAGsinq8Ujraz1nDe4A5hjmERn9ZIWh3WHRar0H0++/
 SS+0=
X-Google-Smtp-Source: AGHT+IHOqr2uYhV6AlLRFKaK5AWMWb5rmEzfUnqaj5uqaUf63Wd07qTmntpUekGjvxelPEnNSe93Fg==
X-Received: by 2002:a05:600c:4692:b0:426:61f6:2e38 with SMTP id
 5b1f17b1804b1-42abf0a00dcmr15487855e9.35.1724254721231; 
 Wed, 21 Aug 2024 08:38:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abee86da6sm29008275e9.17.2024.08.21.08.38.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Aug 2024 08:38:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/avocado: Allow running user-mode tests
Date: Wed, 21 Aug 2024 17:38:36 +0200
Message-ID: <20240821153836.67987-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Commit 816d4201ea ("tests/avocado: Move LinuxTest related
code into a separate file") removed the Avocado 'process'
import which is used by the QemuUserTest class, restore it.

Fixes: 816d4201ea ("tests/avocado: Move LinuxTest ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Unfortunately the single linux-user test is not run on CI,
and I haven't ran it manually since too long...:
https://gitlab.com/qemu-project/qemu/-/issues/2525
---
 tests/avocado/avocado_qemu/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index ef935614cf..0d57addfea 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -17,7 +17,7 @@
 import uuid
 
 import avocado
-from avocado.utils import ssh
+from avocado.utils import process, ssh
 from avocado.utils.path import find_command
 
 from qemu.machine import QEMUMachine
-- 
2.45.2


