Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A1CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDchk-0006iY-72; Tue, 28 Oct 2025 01:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDchX-0006gN-TV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:57:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDchV-000556-2z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:56:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so3314561f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631015; x=1762235815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0MAWX3PF+zlZmdiNXq5RCA26mpljCPV09k/qwEJKNk=;
 b=OL/f8cTnfRcj1VHH+toIgAIci/WbiB/s3e9NOGynvEFOLqS91KF4fJTD0aCwIjdYyo
 DNh9ZqtDx7jt7Yijvb1GMETHmbkpX7txwn/WBLG50UUzK7ryHWcN6oLl2lAJcZkN8iVK
 fKdiJ3qmWBQsbrvZigvEB3qzl+2RQSsftuhn2hkMfuoX9bASichvF3VmcmWqIzsyv8Kh
 +xR3vOgCsPRvzNZLlBZJzS1ATkDIsKtsYJNKP3Z8pBOfoPdGl3T6P6Yzx42Gr4Q6HTIh
 Y/Cr6vsiAgQypGjeNUO8xyohqpEliumroeF/TGgdLwLFPaFsoIFgWVOyl3ohl6ao5euY
 kkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631015; x=1762235815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0MAWX3PF+zlZmdiNXq5RCA26mpljCPV09k/qwEJKNk=;
 b=syHaX/1SaKdrNLqgWAJd/MJKAZdJBmO1b24hV7uu6TZAVNvrCw1uBZl7NRrZ6qQcA9
 iIbXk4AOobcyY+Z3Fz2+5LlUmpqo4hMw1Ob27QfM6v2t1XqsfGKdU/PEoPH2PU9YTRx+
 HhLHJoK5NjHv9ZRn72WMiNiz9RySmzDdJJusPfi/okpWssPYrPM2WF3hR8VI+cNT+mey
 gxXs6UhGW222vQBzg+/1DQ6wfeMejThHCnegYVjlHKv06/NEryvB4Jsxqvj+KK4vNrbS
 5XvZ4mlvITIwGrosB8gU9teuo9WsuvRlarldAL9CHYvdDhk7A9LuvmOsX5wARHXdufHj
 czxg==
X-Gm-Message-State: AOJu0Yyw63MghjKHpVWeSFC1A8FIxIa8+hdO3divRnzHZRU6qTMdNxno
 W5nBcL7SPKWIkHG1Tqe2feeNtFLo6OOO+yGQkoWfNy1DmCvRcrV5J3sEFsTm4lEbQGOFl6dz4t2
 ZcxvahPM=
X-Gm-Gg: ASbGnctMJIIGPNzrZRS31luNBkbz3kkpBGFMdID3htD2c/z8pkLwyzEw9puCDAJRZb3
 vlehc2kyu6znnY65s09P16xt43N7W6wyCG0YuadvJ4GVzSOpY0Zvl+H1HkQOajjwzEySfxOrjj7
 dBuAew01NvfYmcLIQHdnXrkw69fY4XWfizEAR/TBUGfrCdFiqS8/7aYIvk2VNHl/bRTWdJtAWJu
 ZCp7KL9XhC6Ip82K6/o62kK4qfp6YlM/PkEG811r8UnHhRNcvY2e7O/6Si2e6G7NhkrQ4jXzOR1
 1LL5IwI6le2rb3c9V/CJRfBhuplQr/FS2gwaR/iKk1pd7+03vqMRTHg1Z6t3yRZ00bmJMq5Hd/3
 qVuOhpQFpiZxPbmKwPFkYxBX2scO1AK8E6ec7wTAuP81j6oaztnYX1vFoMDME3dMbDMk967vV2d
 BKzbS1GRTv1Ao5Wf/YRqa5J1wn1LtrZz5CBffSHnWau9r9HXS5NMdW3DY=
X-Google-Smtp-Source: AGHT+IF1EfMJ1fmeA1/3h/+dFL7cSxAoDjNucZEIXuMbZCW2LH/dMI1rmB1kJfhwKmz05bB/Wda02g==
X-Received: by 2002:a05:6000:65c:b0:425:7e33:b4a9 with SMTP id
 ffacd0b85a97d-429a8060ee8mr1587024f8f.0.1761631014910; 
 Mon, 27 Oct 2025 22:56:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbc55sm18985207f8f.10.2025.10.27.22.56.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:56:54 -0700 (PDT)
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
Subject: [PATCH v3 20/59] target/arm/hvf: Keep calling hv_vcpu_run() in loop
Date: Tue, 28 Oct 2025 06:41:56 +0100
Message-ID: <20251028054238.14949-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 27c600148f9..79861dcacf9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2013,30 +2013,32 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     int ret;
     hv_return_t r;
 
-    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
-        hvf_inject_interrupts(cpu)) {
-        return EXCP_INTERRUPT;
-    }
-
     if (cpu->halted) {
         return EXCP_HLT;
     }
 
     flush_cpu_state(cpu);
 
-    bql_unlock();
-    r = hv_vcpu_run(cpu->accel->fd);
-    bql_lock();
-    switch (r) {
-    case HV_SUCCESS:
-        ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
-        break;
-    case HV_ILLEGAL_GUEST_STATE:
-        trace_hvf_illegal_guest_state();
-        /* fall through */
-    default:
-        g_assert_not_reached();
-    }
+    do {
+        if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
+            hvf_inject_interrupts(cpu)) {
+            return EXCP_INTERRUPT;
+        }
+
+        bql_unlock();
+        r = hv_vcpu_run(cpu->accel->fd);
+        bql_lock();
+        switch (r) {
+        case HV_SUCCESS:
+            ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
+            break;
+        case HV_ILLEGAL_GUEST_STATE:
+            trace_hvf_illegal_guest_state();
+            /* fall through */
+        default:
+            g_assert_not_reached();
+        }
+    } while (ret == 0);
 
     return ret;
 }
-- 
2.51.0


