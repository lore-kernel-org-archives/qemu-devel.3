Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F0AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByJ5-0000aO-0P; Tue, 28 May 2024 11:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJ3-0000YU-8I
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:05 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJ1-0006sY-L4
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:04 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6265d48ec3so104009166b.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716908401; x=1717513201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1Z65Olw7qFihD1LZKiHkfm7mBVYbNrglt/V1Ou6QFA=;
 b=SJRmQ+mTXs7A0O5UB6trSJBXXBAnbKWFoORq3vpjCQcIIh/xHhIRN+L5QIaHWKYfII
 JQLexskqh3CfiimM4eNQS8lkIf2drAVxn39pMzn7sXqNLQMBFFz+eGwSxZ2pMMfT+SN5
 RRaKyCZ3Wpi3PpIVP4J9E4A7ylAh9nT9QxYzEZXzOIvs9Ioa8I/+OFj7KTh0gODVi7Wt
 F7X3l0+786N7O+DzSi6vXKwdMIRoo92VoEHynyJ5F0eXWulIpkbQ5vyxtehWL1FDFoJe
 MFX/N/G0FGl6XZZoEV7udMczsJM9lQ1a6fXcq2thREPPTePaircyXzKM58xY6cLqwJU9
 4jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908401; x=1717513201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1Z65Olw7qFihD1LZKiHkfm7mBVYbNrglt/V1Ou6QFA=;
 b=svESAyfyOv3fZNuUiVLNuMwieFDtfF8zbb18ZZQrtoyiekUkU8Lrha8tRrkfVYM2ys
 MXbUeQjNt9tVcS3wVTLPH5OusJZPSIqzbIdn/gfAPpd/OadfHKfq+Eg4lHxSJmd6482l
 txFfg6FvdgWs2+AUxFkdAtjVLA2HOk0D+Vi13UxEgDT4dpFM2twZKcS5T7XxgMvAqplq
 uTUbIUTpwuIXZIGmYMT+YzFcjXnqPc/t+2zQKwBpftbX/DUN5CJoBBgGpfAftLOkPz/F
 Br3tTbpWk5rlM+iwYcT8quPxTkwmXNjE8ipwEhsbY845AAD77U5T75ooxZ5I6/nJLAWo
 hvTA==
X-Gm-Message-State: AOJu0Yx0th/dB9mTVp+nWjryVAU53dii/7Q7qnWY3vDUNXKwgjQf+/Bp
 gKLSXcmevaejO9IYyiYwv7voFaIv2LqE5iapxDSoPQojN3uhpXwhmKlnipKsSsmBOlTLPiv5PgP
 e
X-Google-Smtp-Source: AGHT+IGlod3Le+eprfEOTDMKSd1HoZZpL9ypwVHiZ5EsFhpqK053zNgZSEiZv/PpaygLDuKM+d8URg==
X-Received: by 2002:a17:906:57d9:b0:a5c:ec66:226d with SMTP id
 a640c23a62f3a-a62641b1bb4mr854593066b.17.1716908401301; 
 Tue, 28 May 2024 08:00:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8e714sm620053766b.186.2024.05.28.08.00.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 08:00:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/6] system/runstate: Remove unused 'qemu/plugin.h' header
Date: Tue, 28 May 2024 16:59:47 +0200
Message-ID: <20240528145953.65398-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
References: <20240528145953.65398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

system/runstate.c never required "qemu/plugin.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/runstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index cb4905a40f..ec32e270cb 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -45,7 +45,6 @@
 #include "qemu/job.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "qemu/plugin.h"
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
 #include "qemu/thread.h"
-- 
2.41.0


