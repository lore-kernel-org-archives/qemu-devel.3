Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E5DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkRB-0005XF-D1; Wed, 03 Sep 2025 06:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkR7-0005Ii-Kx
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:53 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkR4-0008UH-Vf
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3cf991e8c82so3585144f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894188; x=1757498988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gEfPabvomn383Kvb9BVWwQgaJJGjCsfNW+1Gzb6ZBJ8=;
 b=Hd1ctOC6zKbMPpmxd4eN/1IxotdTudqg1Ml84TVzbfl3e/AZJkEvNhrPnv/WHaYHjj
 hYjPawjSQljSlb+7UV6+F55s2SfP0oZ3ZHwGT7APy3lzYTFu7GyJz31bdfcfOmGvPWep
 AOqGVyVubzkmQn3xx0rvaO4bMDIrQn8XHmqH3zCqVpRkCBSONKZGiOZ0V/ejwNS8t+fF
 PKiAxkF1W/hUfheSDJolRffPB0QGQ5Ch/IRqSB0Gj8ws4CKCN4MfmDMiYQ9Grprcybda
 gF27MhO+Vq3BW0qVQ8goTSFk0waEgWnxLPEYZdXNaRUKX+TTVVUfOmj9C9Aex9CC4BRg
 IdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894188; x=1757498988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gEfPabvomn383Kvb9BVWwQgaJJGjCsfNW+1Gzb6ZBJ8=;
 b=ealJYqFZ2TrNw+Tdk78CT/bc404koSY3oAWsCuNaMQId3pEUn4xd23bKEr2yca9qUj
 iPfXdzJ9ZKGQFXxhtEGbtzTNZJ4f/70oLC4QbY2nbgNVEz7dvTHu3vQ9/0B4xLYmoxXs
 pW5v9h/ID+UzT0xLLyRlighb4hscnOWaqj92VwdVNFkZUJE5zGk2u5VBZ9V4BOYap/Au
 A5tq3O0NyeDBtZr8I580i/I2Wsl/bc93+PewSDP8CS7jpIfiJd+z8qWxZRIZNrdEYSHu
 ytxJiydQNSepjXjMOG8priX0kmG2Jw16eyDGez3Hco/36BTPNpg8/Hno2gJZN/GWROfL
 /OmQ==
X-Gm-Message-State: AOJu0Yzn5zEj4AYSdzzXhgZhPr9cEn/WpwqHoAbcpHh7CSCTVhgfZ9dC
 5FAeb1BaVU7erSVsQ9fQFpiz7MUKeYvmf5plE/uxXN/KeuD+Ske4hbm/dHpgCCaNJhw2CS/ShjX
 8OjEvzd1DCw==
X-Gm-Gg: ASbGncuVss7/k86Hqhpy0aF/GCE2Ju1r9jfkJ6kWZC2srlEJiiGtGI28WW1PlprVtsj
 sCmawALqsZPzwSYBHy97YrNBY/4G9O4Cw0fXL3RWV2YrPijZP/B5LZk4N1e5tYYylxWLphjGbF9
 IP7GftN6+d2yuUO9SdrzRn070zZqFPx7QFMaDsJn4n2IhfQF7K/b1bKK8RwG/7l7V0/AUSMQlpf
 JvVJkIuPWv+Co3NHrSah784ThebJzVD74kKGbdGOBK0VVDdtohuDPByojqZbXpGDpJy5rOpZ3kk
 z9Ag4bseRND6btuhkM4KCkeAeDCYNN5tecR6tzOaUp+E9teiOhQ9E6Yy4usUvU1USbMZ+0rNAme
 +KjJwO0OnOPRYg4yc5b0UIs6OvZDKdbvbI57HW5j8H09Ys8/kUSQXsvqNz5mMhNgSWBAugJBN2w
 l2UwwFaNj9C+4cNm1S
X-Google-Smtp-Source: AGHT+IHjeaXBZbON+AmbQcwUe0SBB9pAgd5tx8CaxlcG5omgkudltDqO1g1YjTt5ypja3T0r9Tow3A==
X-Received: by 2002:a05:6000:2f84:b0:3cb:cc6f:734e with SMTP id
 ffacd0b85a97d-3d1dcb74345mr11728532f8f.14.1756894188421; 
 Wed, 03 Sep 2025 03:09:48 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm23234058f8f.27.2025.09.03.03.09.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:09:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 19/24] cpus: Trace cpu_exec_start() and cpu_exec_end() calls
Date: Wed,  3 Sep 2025 12:06:55 +0200
Message-ID: <20250903100702.16726-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-common.c | 3 +++
 trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index 152661df8e9..614391fb9bc 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -249,6 +249,8 @@ void end_exclusive(void)
 /* Wait for exclusive ops to finish, and begin cpu execution.  */
 void cpu_exec_start(CPUState *cpu)
 {
+    trace_cpu_exec_start(cpu->cpu_index);
+
     qatomic_set(&cpu->running, true);
 
     /* Write cpu->running before reading pending_cpus.  */
@@ -319,6 +321,7 @@ void cpu_exec_end(CPUState *cpu)
             }
         }
     }
+    trace_cpu_exec_end(cpu->cpu_index);
 }
 
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
diff --git a/trace-events b/trace-events
index 3ec8a6c7202..faeba6242fa 100644
--- a/trace-events
+++ b/trace-events
@@ -29,6 +29,8 @@
 breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
+cpu_exec_start(int cpu_index) "cpu=%d"
+cpu_exec_end(int cpu_index) "cpu=%d"
 
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
-- 
2.51.0


