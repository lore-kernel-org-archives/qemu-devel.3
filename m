Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA63C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nsx-0004XO-Ct; Tue, 29 Apr 2025 12:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9nsb-0004G4-A4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:32:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9nsY-0004fM-Jp
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:32:20 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so7204212f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745944336; x=1746549136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9X12hAVFdbebjHYEQDRzia04epp7Dk4I6xOhWrWV8E=;
 b=QEjWfLW1b1uDEffAAvlEF6Lo8mCYXOInkxjKAq5NTYCTxXd4paXAuDjSV1oXOZkIDf
 fn9jA2txfZrRJYGdqoXPYiDVSwh0EV/1TJFDzIdWLWVpERXL15ZngmcPRdzD4OUa9Vmr
 xXlT3GjP/TPfvNPo67cep4PXW5xta7V5p3Dea3A9CsoWgzTaxdnbc/XPae0f5xGNZzbO
 /jt+Wt30/cJMChcr/Z2gYI2Wx4baDrmnfPbbcgndVPao0AFshaslbxuTnaXnbewb8AzI
 YPvVDDzNNaJFn7ceYX8HLxY+8/nq048k5wUpZrkZzpRcIFcHYdN5cMNnpY4nzSipTZQj
 w9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745944336; x=1746549136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9X12hAVFdbebjHYEQDRzia04epp7Dk4I6xOhWrWV8E=;
 b=Z7KrzehU45UU61PN/okMOKtytTXvb79z+cQNLrCDuK0KzsGMChnAzA2v0ltpGUg9Mk
 AILDKNkMRi8RijHxno83vTNo3hj3r4KrnClZgXfJoW9vuUhcqCX+qtPl3p++gSATOAbT
 4o6wrK+OMNK6XX0sxrJM3SmzHp5kR04JmbDWqh7aUKh5kUNbmB6Wf4bP/QfMbU8zwGSq
 lA0RKikhvbA8UXmeq7GtXht3Ouc1zz9M++Ldfih2tiONtgb/clSSR0k2XkqZSH9DkzbN
 yp3LWCsLLdKvQbhBQmmUcv5aX0WQAkZMYlcHo0io85Webicr03X7XDjm+NFvPrsqXg1a
 /9rg==
X-Gm-Message-State: AOJu0YzqsxHgt5LK5kkkGsby4BcpySyjBVfjqag9Wxtd+P1SFY0c2zfq
 WJUoF+KJVHFWsXWOC1q7CAhjjMNIdPnA4tHJh9A08lnXNQ4bNXdftmyRZ87xRmNTv5W5ROafDbg
 Q
X-Gm-Gg: ASbGnct6fgGZDI4Tch10XOkq5WCW4O9oXf3r24AG7nfiS3zvPLJneysRzHCLutvsixu
 bonYZqrW2kCJrq3aZJFGult32Xu137eq3nHJEj5O8rqRcm8KaTIwtacZzU59kNMt6uqAsBEVS9s
 jJqoHmIW2Ixz3ohSju0SPkYnCBDU1cbKK++3WhRE02v+m2UP8ZfRYMruVFJqDVm5aDgG/maeir7
 G6WTO33whth6TQ/6EPyFLYnP9k3XQcQgyx8sf6gBZ9CszZTRzm7EmVO+AiQHnD7wJBOqf3qlN+z
 Zchkmbf1+uC+47u3ExO0TRpw9IRTpcwQjtjWsYlcybYbACo=
X-Google-Smtp-Source: AGHT+IHmd6wr0LEUIg/GUJzVo23tmjG34a5HjAQD10PRGaFf+B5aNUmPV+ImnL1Fsm1q0Z+u9t1Rgw==
X-Received: by 2002:a05:6000:4304:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-3a08f7a3ff1mr16922f8f.45.1745944336468; 
 Tue, 29 Apr 2025 09:32:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4cbcsm14176326f8f.25.2025.04.29.09.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:32:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] docs: Use uniquelabel in qemu-block-drivers.rst.inc
Date: Tue, 29 Apr 2025 17:32:12 +0100
Message-ID: <20250429163212.618953-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429163212.618953-1-peter.maydell@linaro.org>
References: <20250429163212.618953-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Use the uniquelabel directive for the 'nbd' label in
qemu-block-drivers.rst.inc.  This avoids a complaint from some Sphinx
versions about it being a duplicate label, and means that we can
reliably ensure that the link in codebase.rst goes to the document
file that we intend (i.e.  the section of the HTML manual on disk
images, not the HTML copy of the qemu-block-drivers manpage).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/codebase.rst                | 2 +-
 docs/system/qemu-block-drivers.rst.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 40273e7d31e..f3f133e9adb 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -116,7 +116,7 @@ yet, so sometimes the source code is all you have.
 * `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
   `Monitor <QEMU monitor>` implementation (HMP & QMP).
 * `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
-  QEMU `NBD (Network Block Device) <nbd>` server.
+  QEMU `NBD (Network Block Device) <system/images-nbd>` server.
 * `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
   Network (host) support.
 * `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index cfe1acb78ae..1a405e47823 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -500,7 +500,7 @@ What you should *never* do:
 - expect it to work when loadvm'ing
 - write to the FAT directory on the host system while accessing it with the guest system
 
-.. _nbd:
+.. uniquelabel:: nbd
 
 NBD access
 ~~~~~~~~~~
-- 
2.43.0


