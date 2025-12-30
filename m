Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94346EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagxg-0005Sw-Db; Tue, 30 Dec 2025 16:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxd-0005H4-E1
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:57 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxZ-0002GQ-Pg
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:55 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-432755545fcso2370702f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128932; x=1767733732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K7woP2d9AEbAAS/OFb9VFEAdFLMEwZL/u+yEwg3TqSs=;
 b=YBFUlroltgM+vJWOnTRFQcP+sCfpeBmWI58H301g6q3vBMda1wefPOaL/3jhIa5knz
 8Jj5piI8yxUZlNYOxRSZOH/MgOFiNVJZWEI5BoP6MV3wIMm7zkCKdcHkU/ZmeOZVSwrf
 AqfgVr7L86SE3gkMaNh8Fx2lkrOyiH8RhgE1pkHzBL9UrdImXb7xZY7gY+BXbFUG6Kw+
 w4gLrk92z0TQg5qtfWR63l0zpMnwk84QVui3jICcZUrirS58ofbURdQjhXJNKM5tVhgA
 97OBDztrCU13TVj0rVm0r07DjhF9i6B8rp4f4Hu5HByj3i1rIt9R7MLFW8n40NKGhmO/
 KkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128932; x=1767733732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K7woP2d9AEbAAS/OFb9VFEAdFLMEwZL/u+yEwg3TqSs=;
 b=eXY1AO7JxTl6HpvvwKaH3UhyFg/QV/RHDV4URme3bIUOXYJFt64nDq10lu2wdfngTP
 a/u9VzhD+dvrNRR2rruBlede0tBWt+p0ek735ul4tuZnXipzmTXTebXR+mtIMM9HCpPO
 qTejgXtDjOwtgsgZLD8qDxtBYEo19IE3o8KjJUUSuwQzu13am9NVIR8YXyxVM6rz639S
 claHQf5G6HjSh3gAeReRneDUjXMD/INqGu4HHDc5FZtah3zhQ7ucDWXFc3dTC4+OoceT
 9WXkIPf5oCUNs1uddJgkQtLv5IX7qTtP97stluRD8fSA394xJHg5Q/ixw2wJnXdd1FcG
 TRbQ==
X-Gm-Message-State: AOJu0Yydlz5K5d7vfgVnXwN55G0tdJXEykwnN/f2zWDHsIzTJCSJ4Ma7
 P62U9f+lhRH2eaxK5NBEUnj5FtE+A5F3QRljckWA0D5qRNFWJ2v0fEW5wH+fo2yvqlvW5+APEr0
 eslNCzdA=
X-Gm-Gg: AY/fxX5Tiq1FPXE30YMW+YWZDrpACpgSYARYnTLSS+JVCrA75IOIHRpNRpPNvYRQ7nu
 WDz55LPHI8dKAxkejx2qKrONMjpVmae1KoUTglY0nyJ4ZLPQ7YRxeslxUYI1Bs7pWoh76xCsYYZ
 M2KnpYw/gJwXla+s1BPFPUALAu+6+sTrKJyfi7A3cquXyu3N5bXsIYWllX3R6exI1opuTHkpHrN
 vF1SuyhVA+X9cKUYlEISTJi0TlHFQ/1mRFo3T0yGAwpBYNwFYfgMauQbgE52yfN9b2Fv1BOx3q6
 1j68WypPDdP5B9kqm16Z+2t5y6lepZxououYlrCOuPYj3jIarB7r2BGiDRzCJwssbux9n2xdAyJ
 HgKfSv1/wFcSkDFDDElBZJVs9PNfgjdNpK6O3SxXHYf71DuMowbWlYleFRlVeCi6QHptsV/gDLA
 dQrTzFBb0AuKvk/HUJ6XzhVwz3WWISOBcDLc56wZBoMB3L8d0oe5IZX8C9zlOh
X-Google-Smtp-Source: AGHT+IFeMlUuHuI+0USpLD4M0aMIjIKz1j+ESIxghIoud7kcR17oTLbQe/F7mS6C6EFDRdz7VRkHtA==
X-Received: by 2002:a05:6000:2281:b0:432:86e7:dd7b with SMTP id
 ffacd0b85a97d-43286e7dda0mr15096016f8f.0.1767128931739; 
 Tue, 30 Dec 2025 13:08:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b36fsm69879299f8f.5.2025.12.30.13.08.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/34] monitor/hmp: Remove target_long uses in memory_dump()
Date: Tue, 30 Dec 2025 22:07:30 +0100
Message-ID: <20251230210757.13803-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Pass a plain vaddr type to express virtual address.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251229231546.50604-5-philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index e855c0d8a2c..7c8bddabbac 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -232,7 +232,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
     int size = qdict_get_int(qdict, "size");
-    target_long addr = qdict_get_int(qdict, "addr");
+    vaddr addr = qdict_get_int(qdict, "addr");
 
     memory_dump(mon, count, format, size, addr, false);
 }
-- 
2.52.0


