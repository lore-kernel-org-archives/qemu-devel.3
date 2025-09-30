Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B90CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeK-0000iR-1J; Tue, 30 Sep 2025 04:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdw-0000NR-Rc
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdA-00016N-OM
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso36253475e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220554; x=1759825354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtU1C0M8U0OTbHcI2E95ZD2Zrsmz5/OESKETD6NudSM=;
 b=rEBKSr+z2e5v81+Ut3ociqit4LzvaSZogqXI2psMnXYgSlUETJbCLlZiUYfcrqpP6k
 1ZzoFFhD3H4S/LH8p/D30gQ5oqbNZ0NbcMPExoiDf8olM8SlX3gMIAzOdHJGiEFMJcWb
 Jzo6+ORAr875A1LoNi1jfK3nHKsMoyMRmwF6zh2tey/hx/d+bjOh0prRCjSSxjqSQl3j
 /UDzUomhOno/0e6/OXpQHWES/Cu/Gi8qsGTRvxaogUj1do7YJ0SsY2rPzu3YtdtoIiCm
 L8kY4tuo/bWUlO3RKKwRceErUdGGg0mEwRIMxvUgncxVX0W51YenK0uHlq8jA5RMFrtl
 iRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220554; x=1759825354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtU1C0M8U0OTbHcI2E95ZD2Zrsmz5/OESKETD6NudSM=;
 b=CzBq/anN9sbl4294kCltKoodfLipv5AtGBZWnzU4cuOtAQ+V0ceCUqs3zWAIQY9erk
 aDXqdsSc5BJzSDXw1c8lZizcCt793ygPl/L7aPxura/+C6k0WDrJF3zoTXhU478c0zgb
 cQP/RlEHo8ooDCs4Dh5XKKIdSH1Dcmyr5cl7wpQhlqy5l7orAdEBoc16nZZhyIXkl4Tg
 kSVlVQ/nCLSpFOu1yrlF9PYcjOTAU4YT4aP6VnaufGmow9L2qHUIXMMI8bOOlWByFn9O
 EYLq5HXYzUcOtfgdN9HXGnEmyW90unCo3Ni/dnjcWFjk5bUNghIdCGGuxFlP2JMiAy86
 BYwA==
X-Gm-Message-State: AOJu0Yy5MmbYA6yxaOXoZJZ91veir/f9ngxRoUr6VOExSeQWu9mdyVn3
 sxgW0J9HTnrmkhpK+/7tjDOFLdSMIN/KJu9D+8p9WXhNBcwC/5mOlgT08I9hpQtC7cf84kGSClE
 1YgzVH65rcg==
X-Gm-Gg: ASbGnct2hm1wqU9OxuA6x/8NYZg7O6JourxDUHKATSKvioDp1vwWb05gGWQantrsLJM
 HZYUrS/JzpO0FYnkoa+/SznNdWYKeQLCEMvx7dZV8tm7Ddqnwk4GWZXOS/wN+S0wEDDhyeM0psy
 xxbCTU4wDqFdV+iMQ2H6pf93V1q30JW2ldCEYp6ONh+1t1yP2zisPlDLA/8SbBjCyvhkMW9KF3t
 HcDoHA/8fKvCgpuAbORTF6PY1N+8LrqILnPk3Epj+UXnKcACsmI5imZ0Yso1ltZqhj8gHNlD+gz
 jRtCzPjDMxtw8kdCwzaJuie2MGybpRXZXJTdtJ1UX0i7qHZgbvCunWnKs/XFkjQ2S6O/8H2QlQD
 iLItGk8E0PnDIbymwfTmMU67i34aVZlP5irSvA+DdU7OAn0HiYFfxJTXzMaz8C0JP1rbXSD/KEq
 XHbo1Vj/uUuZrikuX9O5EPh7ftxchra1Y=
X-Google-Smtp-Source: AGHT+IHFPJkofYr79h9pu+6ONde86qKMR3dCMR8GX+HG+gEgb0uWvZOFxlaIJxTQ7PTY8pGPvnTorQ==
X-Received: by 2002:a05:600c:81e:b0:46e:1a14:a81b with SMTP id
 5b1f17b1804b1-46e32a1a396mr111982275e9.36.1759220554357; 
 Tue, 30 Sep 2025 01:22:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm21775814f8f.8.2025.09.30.01.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 12/18] target/i386/nvmm: Inline cpu_physical_memory_rw() in
 nvmm_mem_callback
Date: Tue, 30 Sep 2025 10:21:19 +0200
Message-ID: <20250930082126.28618-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 target/i386/nvmm/nvmm-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index ed424251673..2e442baf4b7 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -15,6 +15,7 @@
 #include "accel/accel-ops.h"
 #include "system/nvmm.h"
 #include "system/cpus.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
@@ -516,7 +517,9 @@ nvmm_io_callback(struct nvmm_io *io)
 static void
 nvmm_mem_callback(struct nvmm_mem *mem)
 {
-    cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
+    /* TODO: Get CPUState via mem->vcpu? */
+    address_space_rw(&address_space_memory, mem->gpa, MEMTXATTRS_UNSPECIFIED,
+                     mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
     current_cpu->vcpu_dirty = false;
-- 
2.51.0


