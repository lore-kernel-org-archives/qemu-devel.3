Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969A1CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauA-0003Qw-61; Thu, 28 Aug 2025 07:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau6-0003N4-8K
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau4-0005mH-Ft
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3c380aa1ad0so414695f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380891; x=1756985691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b8ajJViGCAPLZDLfex9Nz79/xy+FoUmGUxGAj6rowos=;
 b=P8RtFVvFWcHXayJ0YacnwLRc9+ZCGT55V+4Wii6kE1Zx2RF6sQCkEo1bOsaIFVrsVD
 0lG1DQOx0K42o5LOFZri66S2sw4Kqv9RAvACtuz+4QY9NAQJJyy9KOTeReyYjBqWRGLh
 PgJ1NSaCKbVKKr/Zm0yERDSEg1uz9I972tGnI/uIKUxExnCmdHnJ1jJUK2WdMurbBCE6
 2XD34IXft007lY2U33XJswcrXIL/1OgqEFx9AIFW2pXIKPJJaPpVuVuJgth+EPXLlxyU
 dsSba/pOjhozXofFqjxIgR5ahlXUt9anjXLXxFbUvalilR4ca1UD+b5dDhPYipDNwYj5
 m9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380891; x=1756985691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8ajJViGCAPLZDLfex9Nz79/xy+FoUmGUxGAj6rowos=;
 b=JRz1EqtuXfKwvu/lxF/EyEB/e037Z1s5IAvXPWdF/q6XiHrweaqn6xsPUBitew7VaI
 ykGUC13SKCC4v+M/fN0WQCTXlN/9PCRB8FLI5ikSKi5ZxkDM1kUaZ3Z+hejzXV5uUsM5
 1sPs2SEhGuF1qpSMiWEjFjzS8uq6TremvN4du6RufKR5M1BiNM5HYKJhG9s1kalcjayj
 0G8XebDRQxF43E9z3BB0MJ9nyDBFAviVw6KzTm4BNQ/thN+PBVP3mpAv6bwc3vEvKgOr
 sniq+S71Bp5A7or+jqopLLZ1sH+mM/5KvASLnC/1Wab4+lIjAZaEPoBXZ3exBvG3DLcy
 MVvw==
X-Gm-Message-State: AOJu0YyCjZyuH3dpCieud6vlMGnFoeV3fyA3rAPafApvmXQfHE7JvfYG
 HB5IYaDWvUoHvY+S8u59GKHzVsSAD7d+dAQpx/YZYmRRxAOaBcwY7j+2ejvwnRFPmCIQaYWgT5Q
 /UJXj
X-Gm-Gg: ASbGncu8BJynG59h1+ob8iqB1pI6O83FTuWz/TVjZKlTJrOmm/83YBEtENf78jGhybx
 Y82KY1Ij27Zr5jqpUDTeZ6jDKCl554HwUXfh8myJK37CHB3UVAjc339u+78nybrRGqQPxn+rtCz
 l6mHtQZ0LX2HyPnZQ8WCl7lx0gbuayWpbFVz6JkpzDc5TDnH8U5VrxkhLh0idzLtukgzDHkycdJ
 0xVz8nrjh0wNQE9VjJmqWRT1r/s5nCbYSBvslQ47VKZpftR5EDhlfyS2gm7/kgpXUB6TA/gs4NA
 rrG30ARZPAgh0Te8Nog6d01RZiLPvBJhYvv4tqNhnR5LCTCsYDoottzKxwtsM2bor+Zl4fV2L+P
 ZILi4LhzBrOBzV/+WvNYZgZX4aKHeAE9fK8xAieE=
X-Google-Smtp-Source: AGHT+IFAeSI5GNTUXewe4bTR1E5szjXbERv4PTa6rRXhSrFnGH2FI00CNCfJ2GyeGsRxWrTr3gYvQw==
X-Received: by 2002:a05:6000:2013:b0:3c8:152d:a707 with SMTP id
 ffacd0b85a97d-3c8152dad20mr13764707f8f.53.1756380890553; 
 Thu, 28 Aug 2025 04:34:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] docs/sphinx/kerneldoc.py: Handle new LINENO syntax
Date: Thu, 28 Aug 2025 12:34:13 +0100
Message-ID: <20250828113430.3214314-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The new upstream kernel-doc that we plan to update to uses a different
syntax for the LINENO directives that the Sphinx extension parses:
instead of
  #define LINENO 86
it has
  .. LINENO 86

Update the kerneldoc.py extension to handle both syntaxes, so
that it will work with both the old and the new kernel-doc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250814171324.1614516-2-peter.maydell@linaro.org
---
 docs/sphinx/kerneldoc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 3aa972f2e89..30bb3431983 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -127,7 +127,7 @@ def run(self):
             result = ViewList()
 
             lineoffset = 0;
-            line_regex = re.compile("^#define LINENO ([0-9]+)$")
+            line_regex = re.compile(r"^(?:\.\.|#define) LINENO ([0-9]+)$")
             for line in lines:
                 match = line_regex.search(line)
                 if match:
-- 
2.43.0


