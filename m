Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED02ED64065
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Rrc-0008Vx-G3; Fri, 08 Nov 2024 11:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrP-0008UH-Va
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrG-0003rI-W4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso21060545e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731083353; x=1731688153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXACTNjW7XQDDQR5ql26mWd2hLljWGI/IOPLLCh6Itc=;
 b=mn8AZG7XUiSSj4cuE2KzxLf2ESUpsC3E0YnVxELYevxX/wZFPSeb3C0Ht5YkKj1iB0
 vvTOTIkvNqaE9nhruIbWMIZyOTM6i6BnsoSAhubPxENPKos62HhSB5SSqr40txOZdgb6
 oETKQ82khSWAz8mK6wdzfUf1tENRp2gm1UO69OWnt/6ln1lmyUb4IZA5epL9LElRegFh
 Z2wMBBwFpSaT/2appLQFvkNLsOgF2mXOcy0x9diTg0IFuw/SHqb3r4KgRnB9phxgbCxz
 3a911xK/DwofiD74vkL+qk7RU/ibcwVvad9dNNa78vQn4ft4blbPz07lsc0XWgkZ4ugw
 KRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731083353; x=1731688153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXACTNjW7XQDDQR5ql26mWd2hLljWGI/IOPLLCh6Itc=;
 b=O9/4fu8HAyt1pXN3nVhWm/yzFp71zJ3dnk1YiLKuTrFDAmlQXK/Tv2WOS8nvdRkBRr
 fUqSXrk09XqZ/FDlX5ALbYXP2/ItaF4wGTTm92eNk8cSagfCJP7SmYQD/T/bKljwwK2O
 puyWnh5RBQW4ymlrmIGOkC+CHOqERMd3BNaLQR2t3mL8/755cFf5CzaQhsfDxyUzgF7i
 08cYUwJqu3oV/2yXW4sgtzNIgLYoQf+HvzThCyIYol5MzGu4mzj7IKTAMrIr0ECPRDZ/
 xxYLYevwQLSVi2MQOEFDdtdpmjeTfpV0/gl3AsJmkM7CG4wlKFRytyumR58Pij+5QvzO
 JhGQ==
X-Gm-Message-State: AOJu0YxpP1KPvumxBRUQCX5XaaYb1RGl5wtzBrtEz/NkrqTHnvSYC/gi
 FnT2KS9PmbtB+orIvG3V2YmJQjx2d18KkEXJ0AFOuU+7NrArQTnvviprt26MQAmhafWA36Afehe
 l
X-Google-Smtp-Source: AGHT+IE2c8SbrKfSxULUWrKMTy4exzFPF89kpI6EOyOdxYLONu8pHg33po8YpJ6v5OpUfZnr+pTvrw==
X-Received: by 2002:a5d:5f54:0:b0:37d:4cd5:ffec with SMTP id
 ffacd0b85a97d-381f18632f7mr2919213f8f.2.1731083352960; 
 Fri, 08 Nov 2024 08:29:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b0530599sm78109135e9.1.2024.11.08.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 08:29:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 3/3] trace: Don't include trace-root.h in control.c or
 control-target.c
Date: Fri,  8 Nov 2024 16:29:09 +0000
Message-Id: <20241108162909.4080314-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108162909.4080314-1-peter.maydell@linaro.org>
References: <20241108162909.4080314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The trace-root.h file has the definitions of trace events for
the top-level trace-events file (i.e. for those events which are
used in source files in the root of the source tree). There's
no particular need for trace/control.c or trace/control-target.c
to include this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 trace/control-target.c | 1 -
 trace/control.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 97f21e476d2..d58e84f6dd8 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "qemu/lockable.h"
 #include "cpu.h"
-#include "trace/trace-root.h"
 #include "trace/control.h"
 
 
diff --git a/trace/control.c b/trace/control.c
index ef107829ac0..1c8c50064af 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -27,7 +27,6 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
-#include "trace/trace-root.h"
 
 int trace_events_enabled_count;
 
-- 
2.34.1


