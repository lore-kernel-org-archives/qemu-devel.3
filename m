Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B994CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwLQ-0002VM-5G; Thu, 23 Oct 2025 10:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLN-0002MV-Fe
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLK-0001qa-Tn
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso7004825e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229863; x=1761834663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/5WvYcYJ8yp0ccFt2pcnpeZY9JJpwnARpW25qBUYws=;
 b=RWXF7h3YTI7xEfZYCMyLx7/YS+gdwv+VjIC2WiRCtBgKEfc2UEercQwxCvwiXBIH8K
 8gujDFK/M9LINUld/Dk61sTd6nY2jhpHmN39KeXCc1yp0ZdK0p1SR48FlzIKeXLXn1Hw
 fmlpAR+xsmBrc+fCCby//8wnxJaypGolbOroHAs/sThykHk9VbcTPrFthWiEqDXxb7vi
 VeIuxJhvawKZADYJB7FP7swfUexO7VafzFPRL4ZxTFQo062RTnRtQyIN6fhffOh+zMPw
 C1PHGYLbUKTIj5rPCLbnCwRCJ+l8aloXlQr1MjHxahFH5jGolQW2C1DPxe8GQ9/x8wGo
 Bf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229863; x=1761834663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/5WvYcYJ8yp0ccFt2pcnpeZY9JJpwnARpW25qBUYws=;
 b=cZBSTMRLCcTtUclt4kMvEx6s1/5DWUetiSvnwCuplbcBssktuJkzkA3wYWaME26cYW
 iZ8g2YkKi5WsPnBS3bFEn7DkLXUVUgBuVIsDNwtDfMIntI9ot+6l+m+5koCSX+jQgcx0
 dR0YG4PRoBGOohz4Eaq07EDkDv4VPsrGJosWoADrqiXq/roEFhAT7jqifmowknIyQ5tj
 U3hKpayPywOxXzSU0oQL7yGhPz5Usw59dDD/GTVRHGryoldny6pmACtl34N8FYneL7+Q
 PRaWB8joAGigDNMMy1N+s/oBcDROgSw05CVaKnJGt+zjb8kqejksEIimx/A+uXWojiTe
 Bdbg==
X-Gm-Message-State: AOJu0Yx7lai78PSHhRn8DPc2UCRTCBGZUy2aalSw4pFWFj5/xN7vuIvN
 /q2plWzrQE6t4lOpOQfVvWXMYvuWrZZNYQWBXGcSOgRAtq/aKxP1JNBq8LD2GLMjtn164/Mbqtw
 GiA5vIPE=
X-Gm-Gg: ASbGncvxHMvlaGK79/3HspQ10PVeKK0czmJSJyWey8tDoJxDpH+sCvd5477MPbxbfnM
 m0WGMZ93Iv0SsOyb8sLokQsxgdb6NMq7w0tWGnG/8iQTWeRxs5PHz6WMMGU9Gggyvw370NqoTB7
 ffIEX0s4RjOKloocJEF3aHHhKaMpOcL2jhkd7bsMuEP0mn5Wc62wG1rS3bYO1G3I8TUs3xAzybv
 H6DycecZtTsohjX0Pol/e9P4H8n/fr4sogoRl/eirycyqSQ7H8D7ES35NvJmErfhAiVhT2Vld0R
 P5RakU1ynlbnCaBrEGr0Ge1/+riKY3QqX0PrGm8ePBLIXCby0KWn2rQFi+moTenaCU77Po7loGl
 lgRX/Npyjq/x6XmpeDiMyx2NPOCkOqxY5rOLYTYmxycs6R/ZeDEzgMqwOxe9eg3/5ReVtRF7dDF
 UTI6CinEqUl+RYSwW+rS4S2Zvb4kVh7l7QmpdHW/zycqD8mn5PsXkg8ui4nqYr
X-Google-Smtp-Source: AGHT+IEqpoi13AH0kldXC38uycff9piRT4TNbZHtmzsemW55pwWAXcaSN0OAkWJHRuwpkfCzmkGtoA==
X-Received: by 2002:a05:600c:a4a:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-475c40013b7mr53414085e9.17.1761229863263; 
 Thu, 23 Oct 2025 07:31:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342373sm119172675e9.12.2025.10.23.07.31.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:31:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 22/58] accel/hvf: Guard hv_vcpu_run() between
 cpu_exec_start/end() calls
Date: Thu, 23 Oct 2025 16:30:43 +0200
Message-ID: <20251023143051.11195-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Similarly to 1d78a3c3ab8 for KVM, wrap hv_vcpu_run() with
cpu_exec_start/end(), so that the accelerator can perform
pending operations while all vCPUs are quiescent. See also
explanation in commit c265e976f46 ("cpus-common: lock-free
fast path for cpu_exec_start/end").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c  | 2 ++
 target/i386/hvf/hvf.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 79861dcacf9..c882f4c89cf 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2026,7 +2026,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
 
         bql_unlock();
+        cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
+        cpu_exec_end(cpu);
         bql_lock();
         switch (r) {
         case HV_SUCCESS:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2929a92defe..ab59381b500 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -992,9 +992,13 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        cpu_exec_start(cpu);
+
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
+        cpu_exec_end(cpu);
+
         /* handle VMEXIT */
         ret = hvf_handle_vmexit(cpu);
     } while (ret == 0);
-- 
2.51.0


