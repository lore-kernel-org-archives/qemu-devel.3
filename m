Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC55C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gF-0006rM-74; Thu, 25 Jan 2024 11:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gD-0006pg-Jp
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:17 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2g9-00028c-Lu
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:17 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso4741618f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200452; x=1706805252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1djk9Mx2e66FY1I90FdC46YRiQSkTTbTopB41mRqY/E=;
 b=BT2Q5L6FPLJcD/jSKXnk249PDNrv6ov26TMQcaHHnPc8X/JGUzcS9SgQO1IjmBW3iz
 OrGc1vt2Bg9BeNDrfRJ7mn5WaOOdmnHJ6TSOfMTg2mkh6iQJ5vR6DfKtI8fMthzbZg5l
 ZJ0XEP3C1ZYJBaHTP8F0ni9wIOgZF0rsjtUdWDd0DiCUoPcY9C/r/bjo7d2VT6mKJUum
 j0WCgEVc3id9s+czxpW5BusmrjmvdhFK8w2c+mdECBEnts5AyxyGCD4xnft9KnOO+1n0
 T5pSCm9lfHKGHAIQaYSQ66/Klf6G966Q8WsVKGB+t+WFp07qkcxpJtPSoABmF+dE6x1w
 lmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200452; x=1706805252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1djk9Mx2e66FY1I90FdC46YRiQSkTTbTopB41mRqY/E=;
 b=KQHFjG1SKbk21u//DSXlVZ9QHee2814x+9mUfNBXjnRzCKS2h6SvzbNwVeehsEofos
 Yafj2RmbRK4fyYS+MX/WOWjwwP29NOUVc3GJvJylYJyMBZL/de9AioNr7iX9KLUI2mXx
 qrrNCRDZKqd0HRC4xosy+LUYt1fyiUyjgRUVPNXor0+eacMlrC7UlfMqZ8KFvMLF/TJk
 QiqBX4FrpGs3i260ICbX3bhWjNeN66rKVF4Mn0HA0VrgtSaNChOYsA7VcqWTjaK/k1vr
 rEjjn8rpfK3LaU7h4ZdffkvXZcCBsiJcvYQIGUZTM8GEtpyWseIEeq2PAde0iBUymtGW
 Zr0A==
X-Gm-Message-State: AOJu0YzJj9BQHzSYyQG0lXz3AaNbtj5HsQlwkqXDSAI8kVVuglM2e8nl
 gSSjA24mQVPptSaXoF1PsGuZSgIAcGkYsVEYA22r46yp7PjH5U1eFnOaQ6ladp/pUYbOpltq5il
 C
X-Google-Smtp-Source: AGHT+IEBT4lW0PjnuwQtKEuRYzIUG+veTyNR8elNqgPJe4sY/WkL5skwdc7hJOPIWdbW6s6gy1QRnA==
X-Received: by 2002:a05:600c:5022:b0:40e:d232:b5cb with SMTP id
 n34-20020a05600c502200b0040ed232b5cbmr558309wmr.195.1706200452194; 
 Thu, 25 Jan 2024 08:34:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 06/10] m68k: Clean up includes
Date: Thu, 25 Jan 2024 16:34:04 +0000
Message-Id: <20240125163408.1595135-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125163408.1595135-1-peter.maydell@linaro.org>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

This commit was created with scripts/clean-includes:
./scripts/clean-includes --git m68k include/hw/audio/asc.h include/hw/m68k/*.h

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/audio/asc.h      | 1 -
 include/hw/m68k/q800-glue.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index 4741f92c461..04fac270b6a 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -13,7 +13,6 @@
 #ifndef HW_AUDIO_ASC_H
 #define HW_AUDIO_ASC_H
 
-#include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "audio/audio.h"
 
diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
index ceb916d16c1..04fac25f6c2 100644
--- a/include/hw/m68k/q800-glue.h
+++ b/include/hw/m68k/q800-glue.h
@@ -23,7 +23,6 @@
 #ifndef HW_Q800_GLUE_H
 #define HW_Q800_GLUE_H
 
-#include "qemu/osdep.h"
 #include "hw/sysbus.h"
 
 #define TYPE_GLUE "q800-glue"
-- 
2.34.1


