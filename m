Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A80E92FE3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMTA-0006zF-A4; Mon, 29 Dec 2025 18:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMT8-0006yx-8K
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:06 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMT6-0004TB-Lk
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso59065945e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 15:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767050162; x=1767654962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5D4I0hKen7zTmms4TFT5Wn2w/psueUc6XUEBMd2bJm0=;
 b=x7KBbOwmZDop+Y1bgKoxY6RQ/clZ5N1uUrpzQXv7zgYnftCVeiAewavitqbk4TwZ2d
 dnyYa1ans9Kly8e8l5XqFz7xFOgP8oaAW48oJ4/7lOAOL2guYMJ7axEfaAMxTQDsh+hj
 YR8YtNJSfUyBWKTdjl3PoUSfIl+pfvmZk4IbHG+0DVkIW5zCorp4BvKkhPzocjfPAgP8
 WFB4Z07f3TD4zqIFXB8DcfXQtqXk2ybAj3+IkQR4M7JEOWK0Z941CeLFLm+0OBwT4u3G
 Fw6eEKpSx9WnkbRGX8JJxOGAV8Ty/xgXPhoHUP2aCBp9nLetjZtEUOkx01U2GpKoFYYO
 ph9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767050162; x=1767654962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5D4I0hKen7zTmms4TFT5Wn2w/psueUc6XUEBMd2bJm0=;
 b=lywF+bqcdZv51IZ1SI2Lp8uj8fSths8HbS6zp6HdBhVz6wq/uo+3OFViOJwjqQm+Vz
 AfiyzPpsU9VAH/ByjbfLc/lH1P7fN9FkX6GvUb5H7yDYJXMhmL8OjF050BCFnlyWiCyz
 PKUevaTzBDgqz3Jfp/5XAJf8Kv33YVw2eTkzM3cpL3Lmbndp+4VZ2xYmJlvtdDJpJlRv
 i3iWxed/qFmeV6xnExLmbKOsFOBF+0PoSorvNy1UkGNuukp7L0eZGBLLudxtU/n8UwJg
 CLxBmcHi7jcZqLo+Q8OE7t+a/dUQdiUqy2N0Sp/gNl7APjFPLzCXwaojdyrnBXAymveO
 M5jA==
X-Gm-Message-State: AOJu0YzZlKGpRGRor1kteOBF9HXYDPmCHG8qzzpKbY/hzUixppV+f6Fu
 HUGToOua684QYKCYzSun9e3QyoO8bFgkQNaB7V3APvUT+2+KJcT5rjyJhWNHL2fy7Sef5hJaUBD
 RhOtQKzg=
X-Gm-Gg: AY/fxX5h4DoZ/tzb44i539joxnXnP6hsTFNejAEuYwiHyS042cB2icGWH2knhmx4VQf
 IuWiEnuyTWWp9iakje3JMGh8NpzCB9ZDSO3xJUDjSuY1+37RizIlXFDJAVCOOH4myhPJtB/feKT
 E9R0YlwLTajJoiCixY2YFGSRnEBrZqH0y/gNtel1AV9lFUAqTOCHjOZilLxbkDZVGhcsHLHas2p
 XE7D0YB8vZaNIFdPVYirDAM+rW9kncy0FKwtRK6NQ90qVnpra+mifAA2MsqFHOft1X9GVgwcPFY
 CxNH1Wl2cMQpTQP2ARBwZvn134g1dBMQMNF/zZKQm3MkTf0xYWj72hjlbTXbM2jnrgDv+xQWBhi
 4844UOpmm8zMDyXkUZ8RzjC96X1Bil/SEROkvSA/aCKGHMHIUq/hi1bnBmbnMbduoSxuR88CZri
 Uhb91nwuiSk9iRIUmWPGHZ64/69vexNgxMMQS50dMl9m/i/t9nDDOe0D0ovcwu
X-Google-Smtp-Source: AGHT+IGFjGITe1wntBwZcn6FdjWvyNhJmHGqDQex4ErHbg4KhXXNqSUgN9EL8w4dk2+eNGxn9QeOBQ==
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id
 5b1f17b1804b1-47d19583142mr443798655e9.31.1767050161908; 
 Mon, 29 Dec 2025 15:16:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c5f8sm587408345e9.9.2025.12.29.15.16.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 15:16:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] monitor/hmp: Make memory_dump() @is_physical argument
 a boolean
Date: Tue, 30 Dec 2025 00:15:40 +0100
Message-ID: <20251229231546.50604-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229231546.50604-1-philmd@linaro.org>
References: <20251229231546.50604-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 2976f986d35..51dcb9e314c 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -122,7 +122,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
-                        hwaddr addr, int is_physical)
+                        hwaddr addr, bool is_physical)
 {
     int l, line_size, i, max_digits, len;
     uint8_t buf[16];
@@ -237,7 +237,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     int size = qdict_get_int(qdict, "size");
     target_long addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, 0);
+    memory_dump(mon, count, format, size, addr, false);
 }
 
 void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
@@ -247,7 +247,7 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
     int size = qdict_get_int(qdict, "size");
     hwaddr addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, 1);
+    memory_dump(mon, count, format, size, addr, true);
 }
 
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
-- 
2.52.0


