Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A224E75453
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYP6B-0002Qm-QN; Wed, 24 Dec 2025 08:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP65-0002QZ-1z
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:13 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP62-0002Yf-Nr
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:12 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so1849185e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766583609; x=1767188409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnHAAvQ7KeLMZzzpATHJdXiQ9iksZ8WqgrEdFTW4jwI=;
 b=TRWSQHUjnxdS3Zp7Q3v77XDkXBHJv4YUot5zS8Wv6x98HzeLKY2vFG0KiGfphlCPRW
 dcG6jTUREVd7Y9MllpKGoTtvri4kOiSVPjpMCr+yEchx3bc6KpqjyfgMPqVS1khRO6v7
 0YBV/Px7IBGGojEkfy4fFCb0xOxFUXvokdq37Zlmuj3ts2/NHwSb0RUm5dbFzx10MJz2
 TZa7ugrsQkYe6tgD8WORhBCM5r204NYY4ZDasHGmN2MLBI0fOr43/YWhj8zkH+bf/WIC
 5BviSYM+P9jmbGdynfw6KtetfVUsOL1OnLlqY6W4YKAlJfrehUWNNc4bH6q8po/COtvz
 ae6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766583609; x=1767188409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lnHAAvQ7KeLMZzzpATHJdXiQ9iksZ8WqgrEdFTW4jwI=;
 b=X7COg6gC9MbaqCoU6uXgWTyfwqe5lA0XcReOiAM5OTuoYM1+0Cf3qpp2HUzFcTpYf5
 b5uB9n+UCm8BCu/efkWnH/2ITBbpMZafeik/MorvPqpfe+E1CAZcRaGy01TDdI+GQ6D9
 ddgKQPXpl22k4AN5oQZkG5FaGRB+NOAtM9IufO1gGLY9RqwE8w+6s3eaysMluKR3DZoU
 3WYxXtJ4dTg36uFPdl7VC+37ZmTSQy1+RWX/tsMdGyo9XW8VsfpuM4tD5buuCCSOdbNh
 EFg3f+Ow+0MeMdHxYXxHX6m8Kp+H+SHiWDnRjTvCFfihqLdtAf9KRMZdK0tuotdE/v4T
 exlw==
X-Gm-Message-State: AOJu0YzHesAZCzV6uOEUGEp8c18flcUR3iR1uGa33r9ZtPzIgvIHyt7m
 Z61q/qEEsN+9493t9NUu+LMk/GasPxmwM3VlSL4NmHKEvTQk6bKf+JIsGEsTpssxFQnQcnFY+Pn
 bjs8R/wo=
X-Gm-Gg: AY/fxX4Cq2pBDCH7wdnxXljGWwwtpnZuc0rYu8zJ4dclttdYn6jXGTC+gURVvQjbmpa
 lVuHpZkiCjTEOwTMPkPqF9tacQcp6IP4vYpzS8us5vNnMaRnEDdNGYSPcSvMcqf83D2782TnO/9
 MGT1W3qOE2rlsg+TeppdT7dcVTFNsoRI/w8yt079KYa51CuirKEYlMF6OjDo/mURXMMQ+QZXzPd
 pIXmabf+1WEC6fLc9tOfXG8CR1gLLUZpfQIr6JlkZ4wR63Fi8neHIEzZb6+NVj3tiBG3WRUe09y
 Sn0SCFW9nryofGE5/vFNcmPgQ7zRrtzJaCR4ayZevz5dLAFZu33GXtx3kwB9B9BJRUxAzXKiSLQ
 DkfVIFavnrI/uuhA1ZWq7FPzjOQRE42B2qiOZOEl4UKUdYmUunmcugO4fhZbBlgXfxWhLoAd0Zw
 +8/goTwmA1GW9ePK5bUfNhutq5WhP1k9eoyrzW6lzEmULX8pjNOcu5LQeGx1yi
X-Google-Smtp-Source: AGHT+IG052qBOgBfV5wXTnonMj1M1LJCqcGYuRPnLNrDG1lFtBJPw8NAXfxg/BejGnAxtGHD5+RuHQ==
X-Received: by 2002:a05:600c:8216:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-47d403e9f61mr10353635e9.11.1766583608780; 
 Wed, 24 Dec 2025 05:40:08 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm341295395e9.4.2025.12.24.05.40.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:40:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] monitor/hmp: Use plain uint64_t @addr argument in
 memory_dump()
Date: Wed, 24 Dec 2025 14:39:45 +0100
Message-ID: <20251224133949.85136-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224133949.85136-1-philmd@linaro.org>
References: <20251224133949.85136-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

memory_dump() takes either hwaddr or vaddr type, depending
on the @is_physical argument. Simply use uint64_t type which
is common to both.
Pad address using field width formatting, removing the need
for the target_ulong type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 2976f986d35..c00f75eab3c 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -122,12 +122,13 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
-                        hwaddr addr, int is_physical)
+                        uint64_t addr, int is_physical)
 {
     int l, line_size, i, max_digits, len;
     uint8_t buf[16];
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
+    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
 
     if (!cs && (format == 'i' || !is_physical)) {
         monitor_printf(mon, "Can not dump without CPU\n");
@@ -165,11 +166,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 
     while (len > 0) {
-        if (is_physical) {
-            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
-        } else {
-            monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
-        }
+        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
         l = len;
         if (l > line_size)
             l = line_size;
-- 
2.52.0


