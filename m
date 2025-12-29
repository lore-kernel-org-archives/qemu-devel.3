Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F955E92FE3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMTM-00077i-Ih; Mon, 29 Dec 2025 18:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTK-00077R-Qb
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:18 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTJ-0004U3-Ab
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso21746835e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767050175; x=1767654975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/8cYZmYdBL+VWLXphrjYK3VWDt4CKidadasVU86r/0=;
 b=ZxFvoayK3ez0WqOUQEPbjWZeGvu1//MjSn3CIMAMN4GeUnhPaa85713URWRdXRGvBK
 kcJFIbXZCfHgreZNbNnOq3ynChL7Ux56gIeU91BHZCYMSdxwZRokfY8DTN0uquwLgZ7U
 LfSqXbP7NhbLe12lDiwvJdsVj07ISzRQvDAZ63vYC7eZcw4K/NQoSpPFY8MwCyEEplm3
 SORhEL7ExoXbpOjtz6dI2MgWMNe5A5VetaO7/Aw5aThIZl65tbSnFyRTt9taILT68/Y5
 jrxwkJTv//1+W+aIr+PI0cQ5/ftTh8FHWdDO26nr1K0cWic5O1DNf7zV24Tlamzbg1+L
 Ux6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767050175; x=1767654975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o/8cYZmYdBL+VWLXphrjYK3VWDt4CKidadasVU86r/0=;
 b=YKHhVGjw7o1Mj7tzRbqKTX+gc0qnEVjfBWQt25i+c5F7hbPpSUVFMrJpMhvwXSKhEU
 0QbGEWAAlmNKWEGsLGir297y0g3+rJUwYF/6rO1oq1ONIdPjJHJNUBCXGqEC7hth7EYf
 3JkiODct1bmkMPOZXVY7+zt0j4pjMtbFplK+uiHHfC2NVKatfEs1zGH+uQYSH+irC0Pt
 zZ56dHsqAsIdl+iP5QC6gaYAgcjRYeFBSajZHOGxb7Ya/PfJswF6ddkdGe81GJMKCjz9
 HE+E72XOJ1CQyL1LbhvtxZTiMmDIECCXgOO440xKTP+MeeJfEc23eAG8EO3wWOuqcAnA
 63Zw==
X-Gm-Message-State: AOJu0YzfHrDg1LeVdpEZAa6HflIuoSP0kTNSm0poF71P1qBijVYA2uYy
 r7bxdhojgDMNfeOp9girr5pavb3qFh0L2FdIioaaQv2CI4lutcR9TAGJ/3uoFzLygNzVFbFEBi+
 e/eunUG0=
X-Gm-Gg: AY/fxX6x/EgxHLGl6oDZjDj2RNNiruROcRCD5yEmTUxo74MPlrAezRYucjK7Y8BiwIX
 pKSR5zlcA6cpU7KdWjIUWWqTwJuOEf4OgQqrVTiVEHJ+HlDLae75yLqy6qcCkYc9NOBJjEm6WuU
 MHylIgoDrtPTPZVP/8X6SVNP2/qkfBzaf2om2beY8BzAhAe6v0EALUvrNK6cLNABCARAonynwVk
 7VOVUd5jx2lYiWt18Hz3ZAVN20jbCNfHCqtW+GM4mRRPCSxWpOFB4RSlMo0v2rDz705h+qjyUrD
 qVAS7oiGF98G67rfA+J0VvAYL56W07YjIzPVp+gEafi2Fcf72DW25ZOejQs+mxnSPn+mNKPrxx5
 e3j5Ul7s7ABot84o6/B/lxD6jYnxpuGXYyqM7yx5FyMsK6vQdLQAxLaPdEXX860CQvRO2ozBsTV
 SPrvwAgPlK6qUAy9+/dJIB1aIzc4+MbuRC274DzMsYElqe27xaWS3jMmpE8VkMKAMzjmNCGpE=
X-Google-Smtp-Source: AGHT+IE993cDsbTJXzfvD+sHTJGNrnmaLdTATy8vAzE6PS32zivYNKhAr0iIVKVOetgn5S2ltWBUlw==
X-Received: by 2002:a05:600c:45cf:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-47d1954986fmr342620555e9.4.1767050175215; 
 Mon, 29 Dec 2025 15:16:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19352306sm551499355e9.5.2025.12.29.15.16.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 15:16:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] monitor/hmp: Remove target_long uses in memory_dump()
Date: Tue, 30 Dec 2025 00:15:42 +0100
Message-ID: <20251229231546.50604-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229231546.50604-1-philmd@linaro.org>
References: <20251229231546.50604-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


