Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30729C02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyD7-00063x-47; Fri, 31 Jan 2025 16:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyD4-00063m-8i
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:54 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyD2-0007o8-Kz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so1587451f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357551; x=1738962351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIVJQJKGcg0YWEqQO8oUWHaR7BCknrlB7uO1Y3XbfxU=;
 b=OVjpK5y1pKIIw/QkKzIpMmQKB0ER0fOzShgcYrhL2GVU6ndLzYkrWzpR0xD5K6Mblb
 RgR2p4nM3IByvgze9JQN/jqIq136PnjgyJb6wlMQB7L9r0es75RcJb4M4a36wH90cE1Z
 tPem9aJ1+YVy/SO3xZTjs1oVfZh4UE60696PzMR46bVY1nZR0vLVT1mbONl35ZKMsKDC
 /WTwlphVu2FidoQQ9P9KCAXdGVP6gO0FHa6I+L+XFw94Xt2/qQNtsomTIdNe7vATAu9q
 WrjRUDtU6kLvs+eJXxAWlHdyiAnbNou2VoZiQEETD4z3BGxvIhsYlaRLycpVPqsXKLPi
 yrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357551; x=1738962351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIVJQJKGcg0YWEqQO8oUWHaR7BCknrlB7uO1Y3XbfxU=;
 b=VsgqqqzjlyIpTiClXz6kHwslvmJUSs1A4Y27KcqkkGgaCMRC3xMXFQpnARucOT113Z
 0PQrecwxeYOS+iJP+u52XzwIHNadMtk58Spf8uT1Hi+M/0KrmHsIYBWpVDDBq39tHMbt
 0SOJuYjzmi1hmM6yyMgmqk6IyGc/gqmY7JV+T4mSOADJ2dIZ9izZ7T4o+BCkmLGBzTi2
 rY1VQRnoMqjB7C4eG1D3wF5y7jxvvWimwmkb2L0HEucY8et/5QrcYkxLETFubCp3v/6a
 A4msA61y0Ji4qqDsr4+X2X5WtFNblxxfTCpEIV2eyclB/4UnkilcxE9o72b04vAcYcol
 kUUg==
X-Gm-Message-State: AOJu0Yytj02qmfBs6+IZ9ZBD5QelnRzhiF8PWIK+j1etoVBLEvODZqUv
 jr8bPQpg6vLeIh6U7ovG14lFvm++LPDj55ZgFo7Gf9QLc2o4nSTVN+9zdYqZik8gGKCgVuede9R
 C6WU=
X-Gm-Gg: ASbGncvBbVLGWo14L4SBu5g85nmnHteE246PRm9mBnC8mH5Mb2/4JWb0xDbFRj9NrLR
 98Yl0WEm2WesGWqasHn8J8wV4goMkDCmgeCBkpAyMMNKcQB9Ou42t8cXDvVS8Xm/R7D9Ahnq1pT
 mBntrEsQgTS9QpdwN4vSOjqj3mCozDZ+Wvo3AKPZm15RZKxw8t7Wyh4yFydo/7jxnOWbnd98ptr
 6YhCDMvtsS+XS9q2LsdAT35BkumCjhQCO3RSIbKZrQAGOScvfY2Ziig1G0gdw0AraZfHA24MlSB
 smsf52MgKNVBInFXSwUqs5XqL0B5N4YAF0vBZly5xuKmCv/ffGAvpSvbDW8YZOXo7g==
X-Google-Smtp-Source: AGHT+IHMYUHsLadZpB8NY6iQ1l994NQVviOZBVf8MHdApFxn5xR0mceVJAnIDyPMi3oraiSD/HiLbw==
X-Received: by 2002:a5d:6d0c:0:b0:38a:888c:676f with SMTP id
 ffacd0b85a97d-38c5194a531mr10995878f8f.15.1738357550885; 
 Fri, 31 Jan 2025 13:05:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c12247esm5765768f8f.53.2025.01.31.13.05.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/36] hw/mips/loongson3_bootp: Include missing headers
Date: Fri, 31 Jan 2025 22:04:49 +0100
Message-ID: <20250131210520.85874-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

MemMapEntry is declared in "exec/hwaddr.h", cpu_to_le32() in
"qemu/bswap.h". These headers are indirectly included via "cpu.h".
Include them explicitly in order to avoid when removing "cpu.h":

  In file included from ../../hw/mips/loongson3_bootp.c:27:
  hw/mips/loongson3_bootp.h:234:14: error: unknown type name 'MemMapEntry'
    234 | extern const MemMapEntry virt_memmap[];
        |              ^
  hw/mips/loongson3_bootp.c:33:18: error: call to undeclared function 'cpu_to_le32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     33 |     c->cputype = cpu_to_le32(Loongson_3A);
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-6-philmd@linaro.org>
---
 hw/mips/loongson3_bootp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index b97b81903b7..712439c2575 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -21,6 +21,8 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "qemu/bswap.h"
+#include "exec/hwaddr.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
-- 
2.47.1


