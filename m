Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4149EE75459
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYP6Z-0002VN-9x; Wed, 24 Dec 2025 08:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP6M-0002Sd-Fi
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP6K-0002aI-OP
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so43010695e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766583625; x=1767188425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0MnkHx8beE0xTm3sEpW7oObMdRyrLSD6QHpxN3N5Dg=;
 b=oAL9MG6IFpiBbues8rSnBOOrimeEt6eHy+5g+PKhhSjXuNXIYNRcpI98V8Xi84h28a
 ncglN62IU3ZBhGJ0qOEqNiDIJ5QyiyOAj5zwn+2Sio9/YZcw7uyesFtOVhYsGFyk7J31
 PWU5XaibftNsWaPM1+3OWi5MewMNrcAgAGmBYOIfINPkt9m8dcpBdZTX48ozblfQ/ibp
 y4M/kfg1DSZ1WjzhZzj5aVio0wBS4+Nl2S8W+AIvZwI55+KccxAREfP95Bm1DnFlOfoC
 b2/O4WnulrDkpKwiQ/Q1MyPueym8k2uGaw6JJVaR3u9tjWIrCjJaD5QO1UIY/5Vj73ou
 ESSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766583625; x=1767188425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S0MnkHx8beE0xTm3sEpW7oObMdRyrLSD6QHpxN3N5Dg=;
 b=InMlOfOb0lpXyrNl5tQH2ArrrqhZugvYsiSPms7TRqzHrP2IRcaBXAPZToW/JPvGoy
 RTNHgUIG1w2oH8tGYsZsUVhxKuXFvu2zmzLF8DBxik65gfEKEML2m3k3J2HLh2TYG1Qc
 vsa61ci5ZVyWmdmIs9NBcs6VL00qj+QzbvCFy6vqy8T91i1ImOpaTcTEnxlIqkxRS6AG
 rlsaYgDyN8kqdvhrt9jibjKnfpWwZnzmWxMf8qNZ7oTgmo8uieOdtAondq1IwSbMzBU0
 oL+8vAu/AAGOnk9s63KmyZDGPCccTGuBecznQunMf0MW+xFwO/WpMjzVButyyDPCYo6f
 chIg==
X-Gm-Message-State: AOJu0YzxzOUnHGMEqL4ItF4K0WhuzNxsDnrXkYFw+BImjMxJSuGjS7jj
 OfnMc0bIPHtSgTkjYw6d2OmO7VDU5Nrhg0VPbc8w9eYCINpOw9kPvRgeyU6Ed5dhWhW9Q56JPLo
 batVIb5Y=
X-Gm-Gg: AY/fxX7YZSBNeewKD6JKbz4gelP/vaCxqCdvHff0SCkLgtGQHEKIbCd8gGu/P2L/i62
 9XjtgE9U/m7PGqmik1QnejfYvAvWsZywvqxUk+8XHYhTflG2480g3Q3wkVwLpDwivc87ADx6snV
 gCIiTk4FuNGWP7pV8Uko8vnV25wy/EGmaTZLdQWzHpRbtbXaxxWA2UHnPum8WbFlu9jl5H83p1I
 fVHsrHfrLfeoaey6eEXNTkVUJnYOMgS+qFdYHW0I7OJiLw344JcfC7jA+B54JNhGt2W7QAyzYTB
 prwJgXLy6MDAOQ5hqbW4s4w5S932SHsgVKjUJnfalRoF8A3DdLvktEb0PmPN9e5UYTCavWVd3ka
 UUEuqY10+noE1GHqm5/OrNVtclm/Z671AKTSet2pBJkoM9sOX6UlhT2/Iw8B4/lO6ecc0zl/edT
 BDn4uPRTXH9tJjPFyfkriTwxDZSOR2hcppK4fMV0C5vm1QUguvfsHdrkT4K3QW
X-Google-Smtp-Source: AGHT+IEdYT7u7b8cciqbPQYRl7Pvbf8lH3Ft25qDVSG/0cY7KopTILu/l8qctsLtYzTnYXcZvVdxpg==
X-Received: by 2002:a05:600c:64c5:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-47d1959e2b3mr173182905e9.26.1766583625208; 
 Wed, 24 Dec 2025 05:40:25 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c5f8sm332071485e9.9.2025.12.24.05.40.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:40:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] monitor/hmp: Inline ld[uw, l,
 q]_p() calls in memory_dump()
Date: Wed, 24 Dec 2025 14:39:47 +0100
Message-ID: <20251224133949.85136-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224133949.85136-1-philmd@linaro.org>
References: <20251224133949.85136-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Remove the last target-specificity in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index d2bdf44dafd..efab133cf2f 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -129,6 +129,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
     const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
+    const bool big_endian = target_big_endian();
 
     if (!cs && (format == 'i' || !is_physical)) {
         monitor_printf(mon, "Can not dump without CPU\n");
@@ -192,13 +193,13 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
                 v = ldub_p(buf + i);
                 break;
             case 2:
-                v = lduw_p(buf + i);
+                v = (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
                 break;
             case 4:
-                v = (uint32_t)ldl_p(buf + i);
+                v = (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf + i);
                 break;
             case 8:
-                v = ldq_p(buf + i);
+                v = (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
                 break;
             }
             monitor_printf(mon, " ");
-- 
2.52.0


