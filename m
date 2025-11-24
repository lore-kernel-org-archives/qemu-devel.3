Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E786CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTGh-0004uj-VG; Mon, 24 Nov 2025 04:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEB-0004Qg-AS
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTE7-0001WS-MF
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:20 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso2302061f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977878; x=1764582678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ewny7Ig+IF5SZ44xAxxXp2VzjXnLsFkLvuWLWJotnY=;
 b=BvUuVxH57S8dzOfD8yuqmGBV91+IBYbYnrW1DjIZ1PqyxyE/QFW9MoLZSG+NELnuy5
 2/5d39iF/3hOADgP7tIV8wv5eAiVJN4Q9/PblrC+gtnvPjvb8V6hvLewwpZkJBdI7W01
 9gxFwrfmgzIAlJGnDbbVHdv6B/wv6pQIll6CtEzDKgHjO2aBlcvsFiTLpWhB1ipI/Zem
 +7cMsBWLMiXSQghz8T6n+1sdQqCjoP981shQ6iUq/3YOuxqqN4tdcWyePA6wigcrk5L+
 FpQu4VShjGXLxLUISpmlykkuDcg9cfzFAX7a436XO4AGSQL5aswkfyvH2jE86UonmvcL
 SJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977878; x=1764582678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Ewny7Ig+IF5SZ44xAxxXp2VzjXnLsFkLvuWLWJotnY=;
 b=cW4Pg9RkS+8FilwhxbzR9+8Xvd4ZIOCraUK115+SGyo5QjFcXvA3rnEYkrPcC3t9HZ
 YTHEdLjCPrkzHfB+XOIT66YCKZ0Fbx5kyeLDE68kmXdfPAZOx8L9a7+drr8FSiZ8rVfy
 8HzC0IBT6NCAXnnzNKKVxT/7pxGgoNXUZhlZqxW9vkDLQhuLJ/Bapqc8lh+/E5Bsisyc
 2GXH89xZRyg05iN4TVKUIRKClZT8yS+Prmgovq0jN4PIvJbu4DnlvRZJNzZQPz6XfF52
 aZ3MPxDeGMaRkyiSUzK31IHU4hWFEG4iSDEieF5HusNre6caiFnj1dQhXJUE4lkvrTEt
 7OMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHhTmbtJLkDW1XjUSKnNj5+KTLe4b8I0ZoAisV9i5cSSjUdw1PqybedHPqdS9cYcFatDWaN2cr0FFG@nongnu.org
X-Gm-Message-State: AOJu0YyP9HbKvWDFJTkiQKVbyqGq601WAsnfpHPrm9BxSfvtwJfpoFlQ
 hl9Fik5xLv3IIjkZ5NtKbTqfJ462cbb1T6CwddzMaYHZ95tx9gZzL1q2CP/MN1RdYq0=
X-Gm-Gg: ASbGncsjv5AMVwZZBN6UVJt6AP/0JZ28ob3lUThVo3TUj7+ceq8LuMEmxha52sXo5VO
 QaznwXgssSt2Har3+XjIIDwUfkuLrW4bEVvlaMjPnIRLu5apYv42kBCnPD59JvsMY31n2AS4Yzf
 /aMQSdtGfV3Za0IiyuqrdeMTKx3TCtatjCUpVpItW7+nWqAuUJ8aFFDBxUgxcAXcpf2MaT+5N98
 phyTiZdnoWeeIJSUdDiVW4stakJUXQWh9cAQfcabak+oEoNKYe0nyybk84dwka3K2p39WdRfJnf
 ubURBHIE1swvlbhmjkfn7zDxuc8VitAE7ZxLvk+sWz3Ep86wdOFulaFjuGpxl4PkbWfJUeaoUXa
 3Gtr09RIVGuX40B7VvkGoFEmRxRuNsKZdzDQ6PFe9ESj83Mz0HsjsraTpBQGlNV8y2nghfx3h4Q
 10DX7CdaR5T2KTuMI06T6T8Nkgb4S/d0Scbk1Qzbv1/5vvjy6IKcEUWtfH0whz
X-Google-Smtp-Source: AGHT+IFTNqHM7/uE6ftUdJ+eRm0sgsWm9rqk858WJA4coPUZA/uz2p50OaVcY0Ej99Z1mdf5StX0/w==
X-Received: by 2002:a05:6000:40cc:b0:42b:3cd2:e9b3 with SMTP id
 ffacd0b85a97d-42cc1d2eee5mr11828305f8f.33.1763977877983; 
 Mon, 24 Nov 2025 01:51:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm27299457f8f.36.2025.11.24.01.51.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 01/13] hw/sh4/r2d: Bail out early if user request
 invalid RAM size
Date: Mon, 24 Nov 2025 10:50:56 +0100
Message-ID: <20251124095109.66091-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
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

Do not give false expectations, as this machine only
uses 64MB of RAM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 010be6d5394..56da48f64cb 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -251,6 +251,14 @@ static void r2d_init(MachineState *machine)
     USBBus *usb_bus;
     r2d_fpga_t *fpga;
 
+    switch (machine->ram_size) {
+    case 64 * MiB:
+        break;
+    default:
+        error_report("This machine can only use 64M of memory");
+        exit(EXIT_FAILURE);
+    }
+
     cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
-- 
2.51.0


