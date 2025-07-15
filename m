Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBACC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublkj-00030Y-62; Tue, 15 Jul 2025 15:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbN-0003AX-BF
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbL-0002j9-7p
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:09 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so4657758f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608765; x=1753213565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IbiqYat6kh5gVkuB+6mqM5XRDlpnNaNJ+QLnyUJ4G1o=;
 b=xVzdqQ1jJ0dG6VeNs2ilrOUrIWk4FnYIJsMX5Iu+BzYK7upjXMACKjbSQt8Qr4bMJF
 BdA9rT53BWfbjEqZo2hD5ZuP9YcvRY/eIT0zGyThp8NChn7Pocj/h7+tjfuZwmyjlBzv
 uyextj6PyQCrkxhJLLRZ0IpfpHqlcL7zcPECRCXCcaCQxgoqmrBUr5oXEJbxuHwH414K
 Sre3KJoYOfFQ+oSBM+D3r97mL87NLkSVg2EVSMc0gPOWlGFkWcJhhyrQ5HWCMNAiMyCx
 3oNJSOSY1hMuxGO3tkiG1vs0h7NMrHYCbRofPUucdFf333QldV5w2+cDNrnvK53cCk2F
 VrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608765; x=1753213565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbiqYat6kh5gVkuB+6mqM5XRDlpnNaNJ+QLnyUJ4G1o=;
 b=BBd/LwlrcYTzs9TcIzqhvyXunVjle2IixfiPQGVhuTBimspi63NjiG3CUjU38UOWFY
 mhhYwboK7RkjHSBG//Iq+bwNCVhvlGkR0maqZBSaolqgbhlCgpKEKF1ynGs4eGUGJHAa
 Kz7xoboxxzQFCBSfkOyPjisumLh3e7YoBKNAlUX0zX1Vf+qs41OHhzAv9Xk1JFnE1ykR
 JomdDXWrJDyUz5g7+HpZnaf2fEVtAQHdxodkvwFlgvVGQjmhgP8FOo4oNPaonUUJoeR9
 bldkpPR2C/VpqLptO8cEQwLyemK8QHvE9dHpFlQIUuSHShprXUdQ1PYMWWURy0b4wlLI
 4DZQ==
X-Gm-Message-State: AOJu0YybiEBuRe2uoc2wNBCbDXDAf4Rjpk5vEpg8cKSrbOZy8qQpVdUn
 fp9K+aiofOdlTjYjcXs6UfNJbeHoobdH8QTU97KyA2sK6HZd+/IEm2hw6c6bzNt/w+JCNHAgni4
 iT+Y+
X-Gm-Gg: ASbGnctNHuLcDcrAAJkAVn5AzpuWltmwsP9V/sbByOI/vRp0BaF508d6lHm3dXHilO8
 w/giu6BC4SmmiI9ncxwHw53d9O84uTnUoD7fZVbReGOtZy9ntwMhVkuyyeEW2eN7nkfQDBmHQcO
 lnkNV0r6m1pqUYP8spsfiKXkLUIyQktSOnJ0tUFbO+m3OzdcIrQ8cI44vPb6vkyes1zw1rjkc60
 H/F+Ht4PKa5VEfmHT1tkaGuSo4zcR8c+HPq7Aye9sKxM13PkL63tr6wRvrDRkLrnwyqqSVbAXxs
 mHTBgmh3lXZLnr+yjfoOw8nt9PLIFTkJQoq5Vc3UjATCE/aTinVO7Ux9NUKlagvQIJpelJ0/4+t
 GY5A3S7SbRJFvHD4EW5N2Pp4XYRIGmiR772TzR0iUfnfoicNvsIoN0auRjnFIdslvKKIqFsex43
 q3rw==
X-Google-Smtp-Source: AGHT+IHkIV3rYRWjgbFKcaWuIBuaqVKEbjbJpzB1StG0ubeWMXu8cBfvyhP8D1wkRwxujhGvlJ1XiA==
X-Received: by 2002:a05:6000:23c7:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3b60dd555b6mr236015f8f.18.1752608765082; 
 Tue, 15 Jul 2025 12:46:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e135sm16018805f8f.72.2025.07.15.12.46.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] Revert "accel/tcg: Unregister the RCU before exiting RR
 thread"
Date: Tue, 15 Jul 2025 21:45:08 +0200
Message-ID: <20250715194516.91722-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

This reverts commit bc93332fe460211c2d2f4ff50e1a0e030c7b5159,
which was merged prematurely, re-introducing Coverity CID 1547782
(unreachable code).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250715104015.72663-2-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index a578698d071..6eec5c9eee9 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -302,8 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
-    rcu_unregister_thread();
-
     g_assert_not_reached();
 }
 
-- 
2.49.0


