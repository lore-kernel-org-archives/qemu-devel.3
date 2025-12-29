Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECCBE92FE3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMT3-0006xt-A8; Mon, 29 Dec 2025 18:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMT1-0006xa-83
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:15:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMSz-0004Sh-FK
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:15:59 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so74129195e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767050155; x=1767654955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CW/YJn5MuW9dB4A3MWgjxaS31yDOgYKq6yFfIsk2PQA=;
 b=qB2nJeCksmf3NO94BOeUyI50Ijb6MMJ7K7aJYHPhjIX/LwZRZnFV36HXIo0qfLC0fH
 EaRi8cUqjxldaS1aC18DIC5LnaUboatDu2P1c6BhrCxlnQUO/EJGXI7s9d1Kp8lLfhQg
 utvQXQmu5ZYEPIGMAc8tMhPBRwzJNYfqS3alujcJuvStIczQvhEtCYx/dCzrZCvcQyUe
 1sBMiwwkuAS2SDNGGcPblZK8wT4uSE6FOkjfviyQe/wSM5qhE7CCdjIuwHfu3viVzhHH
 rDeAfDbdSqcykVPHBI2L7vnnCnwOCRL7Sdq2v8BSLJqhqm4se2gAGDSgAIxeIG8HVk+t
 fSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767050155; x=1767654955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CW/YJn5MuW9dB4A3MWgjxaS31yDOgYKq6yFfIsk2PQA=;
 b=Mii6TOUqMGapy+LMF+WhlzRV6/h1Cd/pRJUF5FEfxedEA9kgnsKsf4SoSC0VHmNK5t
 mv8m9xlHdfi1XcgFazo4ofqW2kimL8CTBIN0RZ0eHyYlL342z4NFtcmfq7yUgwKpfYF9
 n17YyW5k4/YWx9Sj2OSWX1r4Ca/7FdsO0amVhBKNyTONPhA3FL4+nbS9s0+nByZkERt4
 cnB2jM7dDKjlQeTQHvytDDSSXtDssxM1n4deKjM0eiKssRGxph89dKJlFhb6RW6Hb5SN
 EOVqRg2/dmQ2ZFkVrkxijL3KR9moZ9WefiNmrKZbQ0KIG0HeDLw5dnvE2O+iK7N8nKdj
 jGAg==
X-Gm-Message-State: AOJu0YxzxMjRBIjEsaIOB42wOi5UcXfXdivPrFoqtHQmPKsyXYcetIes
 12Sb24YJSUZLpgzX5Nar4lIxKip7p/z0RtO5GTm/C/R4vyFgx6Lq8WdO36yR3c2rLck8Ao2E51t
 Apipb+MU=
X-Gm-Gg: AY/fxX7K3IWrnwPb/hjiLC2T9hC/YKxR6rLuU43biiyGuzWTDlc6wrZOuDs0Pb4gHZ5
 F+U2uthgt9mQYmuYr0edESkAvd01vVNNPsTGx5rx/KI3Gtb5UdGZwmY4eIoS5IXpkIh8fezIvsB
 +IfTn6T68/eH2iNFbdWUVGPxsVyfhgb3iygKiLxaIOGpsirCJg4OkjJyXcqKuZX65IfS+co8rqA
 gLc1HQJGBxKuBT5TcwAAApu4vg3y2xxqeJct3nGLkdJva9POLAI8A/jUiRYgrCfqbQOjPayjYJx
 cLOXciUTwWd1+3WbMv22ljMlGpJnu9S0HFTq7inYINYhHLFnF5v+kSkb2A/AptKXE8h2jOERvSF
 s20Ghyc8Ol9Id8jATh91eXwFqhVtz27rel4iQi42LN8+WUmuQbUMXSzkugqxMioyw+mHkuuAXWa
 PpTYlx9Y9OZEnsk2xbfySEA0D11pzAfHS5pENtuFQgN8Vidz2ZK+PIc1umgTV0
X-Google-Smtp-Source: AGHT+IGgdL3W2AiEP2i6uJUSj/QjKjggg5zBS3qTOc1wlM1bQf41oDKsmV10wHg4vZ/SbVm1mvCtDg==
X-Received: by 2002:a05:600c:444b:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-47d19549625mr329747735e9.5.1767050155378; 
 Mon, 29 Dec 2025 15:15:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm586742505e9.14.2025.12.29.15.15.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 15:15:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
Date: Tue, 30 Dec 2025 00:15:39 +0100
Message-ID: <20251229231546.50604-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229231546.50604-1-philmd@linaro.org>
References: <20251229231546.50604-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
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


