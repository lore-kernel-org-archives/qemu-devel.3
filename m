Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E6E75453
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYP60-0002Pp-J1; Wed, 24 Dec 2025 08:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP5w-0002Ng-Jj
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:04 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP5v-0002LZ-2C
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:04 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so47169805e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766583601; x=1767188401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npTLL+HNAjuRrR3R9RZSM7yLL2ZqtYn4UMz3SJMLrrI=;
 b=nz4n3U8GEH0lmsQFY+CavQ+EVCUDLgvQKS3Y1pSAwWp+oKTiz3Rk1t5kB+Rbc8c38g
 ciFHFS1l57EMLhu2CsDotJeacdeQbpV+wqh9KrRr+5F8q1JbnribYaFqY7xrHZhaTgsO
 LCJZBEOte1LTVZvxbDrwDUs36is/JqOpvH1b64rq+OwEbD6ibr9jYhEk3LL/tDlUdHj0
 8E0BVEkc1MUDgUsPEuYGxA8AQghLQxz254GP1sQrsYmChiZ9xsARjHLd8RX+0zZgzhLz
 HJDDx1xjSwBT5tC8IpduEQAvCHYNncJ9+ypaZvaMZ64zp361WbphwgMTKkl8pxg6SGUB
 egzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766583601; x=1767188401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=npTLL+HNAjuRrR3R9RZSM7yLL2ZqtYn4UMz3SJMLrrI=;
 b=Dm7vtObJyrndwq0cYwIgubn/U/p7RW6tTPXdpjyQqfcWw6HSIoaRK8NsSsiWn7L+QV
 Cs/Fm4rtMbhNQuT2UExICpAxaiyiLehJH1rSRHO7gJKxf3BMFWCdbiX6Z74Jplqb8ShG
 P0YJ5T+YorwYswJNjbMd4V6N475L22dwZRqSccEeI83YdUoMG7eBuzdKKlFaJlymq5h+
 ZyNk7jZSMt4/E2vUb+83TSIc0NbLbOetTsvDzg7NqqE1wmRXb/Nuf29dxc6WhgTlEdpu
 tc4B/R4scePKCv0OiopFSiFizXveo6P+7tQJviK7lWXkGjFOIGKL2bi1jxfi3vcPb0AR
 dAmw==
X-Gm-Message-State: AOJu0Yxac+CpDXbrZFqlFL872kiVW9CCWVgR+nNR6e0XXSGx3cKw/5yr
 HRN33AcWKjq8qT4GVlWY+c54uNw1IcXKHyh/f4KIrFeKL9ynvNJt0yJ0zqCZVlEVnn4FA5gRBY7
 3UGua3tQ=
X-Gm-Gg: AY/fxX5D1FCjtl2nKhdtLAt09Vb+nDY0tNJexUF8UWKforn8HcqQN2/fQmeWfwnBhMi
 USMj5T6wvcD02/hLYEN/1BD9hAf8DVhXpdVzl1iMBnUWS4u0AxQPxH4Yx3w7/LLwntUlGp3C9On
 kSeLh94kds00gD3+QR7kBdM18lbzcT+KSjvXuccKhKkGXnwlDjOeWFMdJvu8UzGban583rdr+Hf
 7sW5XRadEsF2ke2ijtO/ZYFdItd4o00YzQbAi5ERtXvpmOxty/4jdbWq4zlroGOaea2+UIPwQAd
 KOtpwy1jOLv8T87RWsEvAWCMU12Q5WuoHrHUF5YDeaWK4Wib+LiuQdzKCeeGsZFjWJO+eTeg8ba
 CM9oFo3x6qmQE9YczjGTKc0YyityvATk5rEdJwICtOlAh3+RPTRRDNEWmmfBsP7hbbCJzwyP+iZ
 iA3Xn4hc7h130M4d0qBUIdTu90nA6ofV0aOiSfx0mLwRBV71SsVp06j2Wi937n
X-Google-Smtp-Source: AGHT+IGDh5UlHu/Ogt4V7UIVyWzH8BgS4jMIYR7F99WKAJuofh9mtCpHdmJkC4l1sJn1r8Xt4RBBBQ==
X-Received: by 2002:a05:600c:3b9d:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47d19555e07mr222050455e9.13.1766583601206; 
 Wed, 24 Dec 2025 05:40:01 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aac6d9sm144306225e9.4.2025.12.24.05.39.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:40:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
Date: Wed, 24 Dec 2025 14:39:44 +0100
Message-ID: <20251224133949.85136-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224133949.85136-1-philmd@linaro.org>
References: <20251224133949.85136-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

cpu_get_phys_page_debug() takes a vaddr type since commit
00b941e581b ("cpu: Turn cpu_get_phys_page_debug() into a CPUClass
hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index e9820611466..2976f986d35 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -301,7 +301,7 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
 
 void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
 {
-    target_ulong addr = qdict_get_int(qdict, "addr");
+    vaddr addr = qdict_get_int(qdict, "addr");
     CPUState *cs = mon_get_cpu(mon);
     hwaddr gpa;
 
-- 
2.52.0


