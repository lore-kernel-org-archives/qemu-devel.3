Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92142C369D8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1k-0004dq-QP; Fri, 25 Apr 2025 11:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1K-0003MR-NB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1I-00042B-9V
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so1760738f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595074; x=1746199874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WkHvd226Ypz8G1TSGXdLXTD8awP0PmcoXl0RA0stOw=;
 b=Qjqma+/JQEqavirCaVl5CnQMegR4zBzaZISOKqcHq89CYN4HdiC4QeBUFQq9JzUDJu
 m80eMPoIB9JJcfLqV+IBnbrAsEmXJ+cCEEeuAvSn4+Sf9/IaFe39xrv93+k/xXm0ew7N
 KsJXUuI5yXrcWevamMAr4eD3aYMOCtf+cG8VHdgBQkaiEr2UNxpN1HKFiwuZjQaRao79
 mRxbSxATaGBp15bUTEo+bw3Dgtug+pZGnpGlIUjHiEuMZVbuyaqOhrH3QlD0dNcqOVEb
 xJ/XCi0M4ehUIANslOiMCcFmenr7w9/ulXKf7BUqfEip5T7ZOWYQPy/MLuBm/sno20fd
 9S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595074; x=1746199874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WkHvd226Ypz8G1TSGXdLXTD8awP0PmcoXl0RA0stOw=;
 b=v8TuAUgOrCmzWFyuY7kXCIN6c92K5erR1w94EM9P/T9a8cIcv19v5+2FNX1IPWsxvP
 N8V+B/RDla3Eqb9qZZzxQ4iAqbJYenOz/Cuk//sQwLVAAO7jeIoxK265tdJFmzI/bnnw
 j0FRvIAPeBwvXBbQscdZqtZomY3cyucsMN5N+bMydPGZtdMRtfB0pmnDRA3AeLsLKLel
 823sfm4ODJ7LmjLRDxf8Ao5CqdQ8RvnVCwkF2f5dJ5cA/avgV507x9gG+nNhoCZlwino
 0fVk3tv/w7m1dVXvFCqpWpnGprDhglHifzCc45EqSN1VNVytyPDqMOSGdEYa9glWCsqC
 owbQ==
X-Gm-Message-State: AOJu0YxoddXdsV+WZ751SWYxpUTviB5bc6HK6R1dnrgEvdhNpaIhTDBX
 1j2EDYx9kXzm5hHmCCFy8SqJxi1FcXnCNsaIOxh6Zmc4+afaD3zgL8vYPL2lOYNK0dus5HtNZcg
 q
X-Gm-Gg: ASbGncttOD6tDVNALyK2G/vGSdqqboKs5nqWqzA4uCwQRyUBMMrzN/5lSbTrQRdsaba
 PdMBGro7CPKh8dI9bM9+DqQKduS32bPC5GR4iZ8vpJEIneBHxHgMLWPNv/aqWqqO0yYQ/vzr4Jk
 YdtLv+uDfMJWtQ8bUEu5WFEEdnV4U/WNBbppLTk0khLfvVNYbi/a7DQkNA2D7Px0M9ftgzqQCE4
 WeWrPKFVxDe6IId7ci6PqOsvZrfCWWwURrYEHjrjNuNAnKqMa/38xaTKkjA3PauzNqQGa2qZZv/
 GOToCpcXpw+MV/4nwWwhLCq+SZ3ZtyEA8t6L4G6XqCNfSzlmEVx3EDEgqoqNUTToAA07tt0yzHs
 uMtOiJW8WgDRsY+8=
X-Google-Smtp-Source: AGHT+IFPHUvutD9x44y2VkPzId9OGZF7HtDd2xL6FxgYEPHyEgW9Nflo9+uca3+aB4eG0d/bYsrFCw==
X-Received: by 2002:a05:6000:402c:b0:397:8f09:5f6 with SMTP id
 ffacd0b85a97d-3a074f4316dmr2343839f8f.47.1745595074164; 
 Fri, 25 Apr 2025 08:31:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46976sm2665566f8f.63.2025.04.25.08.31.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/58] hw/core/loader: Fix type conflict of GLib function
 pointers
Date: Fri, 25 Apr 2025 17:28:14 +0200
Message-ID: <20250425152843.69638-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <26dfe9191154ca65dca6ef51ce768ad2a0c30d5f.1745295397.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index a3aa62d132e..b792a54bb02 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1410,7 +1410,7 @@ typedef struct RomSec {
  * work, but this way saves a little work later by avoiding
  * dealing with "gaps" of 0 length.
  */
-static gint sort_secs(gconstpointer a, gconstpointer b)
+static gint sort_secs(gconstpointer a, gconstpointer b, gpointer d)
 {
     RomSec *ra = (RomSec *) a;
     RomSec *rb = (RomSec *) b;
@@ -1463,7 +1463,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
     /* sentinel */
     secs = add_romsec_to_list(secs, base + size, 1);
 
-    secs = g_list_sort(secs, sort_secs);
+    secs = g_list_sort_with_data(secs, sort_secs, NULL);
 
     for (it = g_list_first(secs); it; it = g_list_next(it)) {
         cand = (RomSec *) it->data;
-- 
2.47.1


