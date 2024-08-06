Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E20C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJhC-0005Jn-MI; Tue, 06 Aug 2024 08:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhA-00053h-4j
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:44 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJh8-0000BY-2u
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:43 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so62018366b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948820; x=1723553620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSCuGHe+AmukzYVW/13LuZhAtRaauQM2euUp0akLJd4=;
 b=pFbcNHRWTZKYaYVh0tCeTb5UU84l4HQhvSzXnHPChULI55tkvl3HQxSPC/NujbKZRM
 GhfNl+jAk8curiNNx/ag91Nn8xDZwvdoMTDtzFfBap0rFSdTBIXu6lUVUi7fbYTsog8+
 QR8qAQFl1HtwDi+Ql92Eu2nIHX1Wz0cILKfb1/RAQKQ4gUpGfQGFcx/9ZjErQRESzy1i
 CQHgPAz9xyDOaXp5aGX0/fBwIM06zjsBKIcX1RY5wRqyPawnWQN/xpQY2IQnoUABb5ed
 hEu4Fh5aF30cP2I1xAAzVtdEq0OsrWovTQcaNcRPjeeCy/fib7ZaGEDOwH6mquRb/d57
 hNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948820; x=1723553620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSCuGHe+AmukzYVW/13LuZhAtRaauQM2euUp0akLJd4=;
 b=FtOky26WFB8fexx10Pk6utQ06Y3V2Xao2YeYv7HxP08PSRXsnkAQlNUlEsGdqz3+fm
 1GZ2WhmTYYBCKCGhLnZPwP9hoXaFiOLKERW5k2U55bJrelYBmpuC2pR1L1hLgLwwT/Fu
 EmdzkRnLEGLUkCoX2X0mTYGtBZqkDgy693rjy8AXhbuUndutam+VwixYyRn2/jgPGFIz
 a8y8HVvNUI4jCXJkOFB5qz+S4avY8h4QJGUWf/7LDttYRnzV2q7yuuCzyNTQ9HYOkgzh
 4F0QV+gvWTy3jGa0lx00VBZOliwrTw+sAC+YRuhdfvDL8LeOoAev++e9B68M55SFtriK
 KmOg==
X-Gm-Message-State: AOJu0Yy9X2Izo1ZEq1xA8E9CxUfEEDe9cFHpBIA1ikAs4K8gzXLBNn0R
 DIIuQFwMjMtkgpF25OgAWQmxRbKDE7wvYTOEeLXLN9fZDW49+Xd6SR9GEiCbi9NMqak/WinLL00
 N
X-Google-Smtp-Source: AGHT+IH/qbh6cT/QUfP3qWT8WPfo8GgsqC45i9V/3IaqLMDpJUQ3EKvajzC2OFAwFi4tfeMLDpYTnQ==
X-Received: by 2002:a17:906:f598:b0:a7d:e84c:a9e7 with SMTP id
 a640c23a62f3a-a7de84cb5bbmr539226066b.53.1722948820221; 
 Tue, 06 Aug 2024 05:53:40 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c0e0sm549658566b.67.2024.08.06.05.53.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/28] hw/sd/sdcard: Do not abort when reading DAT lines on
 invalid cmd state
Date: Tue,  6 Aug 2024 14:51:44 +0200
Message-ID: <20240806125157.91185-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Guest should not try to read the DAT lines from invalid
command state. If it still insists to do so, return a
dummy value.

Cc: qemu-stable@nongnu.org
Fixes: e2dec2eab0 ("hw/sd/sdcard: Remove default case in read/write on DAT lines")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2454
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240730092138.32443-3-philmd@linaro.org>
---
 hw/sd/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index de27e34fc8..a140a32ccd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2540,7 +2540,9 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT read illegal for command %s\n",
+                                       __func__, sd->last_cmd_name);
+        return dummy_byte;
     }
 
     return ret;
-- 
2.45.2


