Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC66CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDctg-0007x6-6u; Tue, 28 Oct 2025 02:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDctQ-0007rs-5E
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:09:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDctI-0006Bw-Nb
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:09:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4710683a644so45990305e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631746; x=1762236546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gg8KFIu162xAUD3ojqlP0hPF5Yesx/MjE4Lk5N+Iivs=;
 b=ozj8DX1hQ7Hy/Yxyg7kvHD+rb1Zm3Flp3j5IFKntgAx5TOncHGhkrQeUbm/L2nKBvA
 peKjabO+oP0UyyG9RKQ5EXiYSh148Qu1M3wAk53T66KIO9sMXOpnV20a1Z4QHzJitLw4
 uLp8H25Vizf2y8BV37OdF3EdaRFCy8RzXKF3ekSVkRo3Qj3qRteI+jy0oUOrVTzZ6pS5
 /o78Mw67+OXC/VoNIa7xVqs9BwmAZXZNUbA9Cx2KALX2vVd/7iD9fm/Eg5tjBxQ7vcEE
 +k/a/2C4/TmuvHJA4CqHxGonJGNdIQMCrBCEsNq1XBrdKsUym88BX4o6Gy+CRuqTxCad
 pWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631746; x=1762236546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gg8KFIu162xAUD3ojqlP0hPF5Yesx/MjE4Lk5N+Iivs=;
 b=IZYZ3zOJyPWBEHl43H8UPjY2olEpdULOFCXJti5Ixh8w9wG4bpPorPCJ4yex8N9KpH
 2d44QwUIs8cX1R6A/SfVNNA8YCDmK0oCN0XfvQVbjhhqM7Eyc1jD7pcjQukk2QPwzcNq
 ddwzroq92Ak70x0yZOAbD7WL8dK+IasEY0mYnLeZ6T87oHasQ8vUAAg9ufBXm+V0m5pS
 7B+KA+nN5tcWW4FWMHPoVzCGRjU8//FbFi8HGJkbGs2wk02PpslQ9B4/S6COHdb297Xm
 z7taO/qnAQbPT8eCA1Qf9s6HrnSeh0d0NmX6zbTkC7o/7oH9lK2tJk2D9/l6m6VGIST5
 g/RA==
X-Gm-Message-State: AOJu0YzzURHOy1eAe5CUH15RY4s65HIFnRI0KoWs3pcTYUVTMSWExIT6
 0CUk8c5RDrFv5zmPrhi64s5iHSSsXkvbMzowECbIUHwiT/LckKmVC4vEgtoksDrB22rBdv0aDwv
 rE0QBUVE=
X-Gm-Gg: ASbGnct7VIA1f0cLYzxH8K/itjL3BJ1V2NULUhCb9zOjbyGJ4tMKcAe+CO//gt2crot
 87/yaQzy4ZHjtvyFUEEev0b7F1YHEbFuA5xrpOsKxHZI96KxxgYlrCAFv9oHqbGsJjiJ5znejDw
 SChriy0ctqnJCSifGTxsrN7umvKh+VVdjVodS2+0Fqs/pjaZWM1sIBWEq2V1yRioHjrpa9JodQv
 gEYb96g+696fd7Zt5HBQ00gwmJpSttvxN02Bp82k3LB83VRw/Sy1ujb/J/BFQ/KcHnO8USDvv7l
 bb9lwXDFvE3FjQcpEa8xsayA7PSdGu9ejFDXz/PsRbTr6H3kKL/tQJBxxLFqMFBElfZS3+xocHh
 yxZoBvSWsEYimtKWrvKGTXSjjIQ7j/pqBvptJNlecjuPdP6mHJBaw5fUzn39512FQjVQnN/vFzs
 jbvrOoh5o/w/CeeHKkqmGe5gWUplcCfQcFV8mkO1ftA0aScd4yC4CyBIo=
X-Google-Smtp-Source: AGHT+IG8AgGTkhfVnAdja4F6R3Y38ls6nGTFw292Qxu+898jzmfEA3pFoTuM/WPGMrtKLD7dKTiGsA==
X-Received: by 2002:a05:600d:6251:b0:471:ea1:a460 with SMTP id
 5b1f17b1804b1-4771816e8fdmr9281555e9.11.1761631745976; 
 Mon, 27 Oct 2025 23:09:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771906af34sm10675755e9.14.2025.10.27.23.09.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:09:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 37/59] accel/hvf: Move hvf_log_sync to hvf_log_clear
Date: Tue, 28 Oct 2025 06:42:13 +0100
Message-ID: <20251028054238.14949-38-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Right idea, wrong hook.  log_sync is called before using
dirty bit data (which for hvf is already up-to-date),
whereas log_clear is called before cleaning the range.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 361d658a186..4b0a1af9fdc 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -223,12 +223,13 @@ static void hvf_log_stop(MemoryListener *listener,
     }
 }
 
-static void hvf_log_sync(MemoryListener *listener,
-                         MemoryRegionSection *section)
+static void hvf_log_clear(MemoryListener *listener,
+                          MemoryRegionSection *section)
 {
     /*
-     * sync of dirty pages is handled elsewhere; just make sure we keep
-     * tracking the region.
+     * The dirty page bits within section are being cleared.
+     * Some number of those pages may have been dirtied and
+     * the write permission enabled.  Reset the range read-only.
      */
     hvf_protect_clean_range(section->offset_within_address_space,
                             int128_get64(section->size));
@@ -253,7 +254,7 @@ static MemoryListener hvf_memory_listener = {
     .region_del = hvf_region_del,
     .log_start = hvf_log_start,
     .log_stop = hvf_log_stop,
-    .log_sync = hvf_log_sync,
+    .log_clear = hvf_log_clear,
 };
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
-- 
2.51.0


