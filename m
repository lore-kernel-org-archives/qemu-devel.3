Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BB1CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDciT-00076S-BT; Tue, 28 Oct 2025 01:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDciL-0006z6-IF
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:57:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDciI-00057q-Ft
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:57:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso76844345e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631058; x=1762235858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3asS+wXSq9uXqx9Uo0sg1PGthTH+0LCho3xSIRojV0=;
 b=wyBvagz37SnQbMRpttTXXC246eWbIezqCUmOlI/1cOPoTix9zKea5vBCCKSW21go3n
 HGLxFsiYnZtvIai/VdUj6lc9bOLfg9cpiaKROGQ7Dijm8T52sARytHtZyOtkmivK3Cda
 nbICdvAr7BBCR6PbAr0qXmyHigCyvLj8Y5crkiE55x4fJLAda+VrURBxyuqjIEbgX9U9
 iQk8Eb+IC2+JycOlJ+85qOhbf3jPF2rckJeLU0VGMYB84GY+nApf+8TvuMMgopCR9Xdr
 a3zXCn7mx98d6ft9aKoxYPG8ERIPS+T4a8i+cBi5fe4CJLmDJ7zhTLjaM9JnBcwV5ovn
 zPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631058; x=1762235858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3asS+wXSq9uXqx9Uo0sg1PGthTH+0LCho3xSIRojV0=;
 b=iRKtDQFP40qZWsG78lLzhG2PIXl8VyHDRZRSGY5u26g4TVyHpPOt65pgGrrSt+CAsT
 BimCHkXqVVEKKMeS5rCMn4S0iyx3qiYVbiMd0YRH8cGU64uG49UEQgLRcNKFuFyKiuv3
 VUGZy5U05h8fXbnBrXUvfeYpsqZunIC03mkAGC+5U9NnWisbHgSvtDkUJvl/OvcgKfML
 Md7hsRN0Ve8x6GkR5g6XaTxWF9NMu/MGF3sp5vlU85ORcSHYccS+6aNcZhjBAzeERt+1
 a+BddRXX9ooTrRcHstzwf21sb49g4wzgbQuJXSjLQYPtedTOd8+YccWCY/wEU5OX/S9p
 wFdA==
X-Gm-Message-State: AOJu0YxTYy8yKqtCLiUIN5d1D2+2CpCysYugJQJf+NgkmcIA/imI1u7a
 tKoozGj6UV4i/jEtt5cbz6aDDQkD/M46RcjtkyqsuIDwmJihDfIPQfF2qNYzXuVx/22Evvedcz/
 zh+D70JA=
X-Gm-Gg: ASbGncuouJi3O2Ul+cZIOvKXuLBeDlWmfldp3wuiyjxUXA3r0xsUtBp1Uljlymo62cg
 JC3IuuT5oh6h/ACwCN4y/ZHS3Ns9AvhwWIgLxQKC8/tjy6gXP3kgtAB9I1Ibty1X0g586Ain8s7
 t0vuX85yUIYTYAAT88j/KwHTD52ViaKAHRIJajmeUcts1jU33xFbmUpIUR1oMwgoXY9oLbn5IBL
 3FW8x1nVCZMKWIBlxzu20gFQzbFfKrp9AAL2IvH6p53bB2KbSt3Y+hmdo1XnBuPQD1IYVfQjYRZ
 eTZpZ8/hmtdaJnYabznzwE32o361WC5jvgXSNXU7LNCYf+FWdyPYEVIIOT5UfCkGpoxuWM19Ede
 5KTQlbVw7oGdJl6ZsIGeTZYIYdoU+ZSFypcGE6itBsQ3TjpXDL/+JpD6TmsmsXdNwlO1Z0Q+uJ/
 OqgoMZUzKE9dXXrFhBJXKW7XbCCkzQ967l/BTDlURpjRCFWMoKe/Gc664=
X-Google-Smtp-Source: AGHT+IEQOreI1wA0xpXjfOGo3Mvh+iYCSphq/tHpW3YNjxoOX+8AGPcu1utd3Gnmf375WNCvQF0rug==
X-Received: by 2002:a05:600c:4747:b0:475:dbb5:23a2 with SMTP id
 5b1f17b1804b1-47717dff6ccmr12658375e9.16.1761631058368; 
 Mon, 27 Oct 2025 22:57:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4e30f5sm175990045e9.17.2025.10.27.22.57.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:57:37 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 21/59] cpus: Trace cpu_exec_start() and cpu_exec_end() calls
Date: Tue, 28 Oct 2025 06:41:57 +0100
Message-ID: <20251028054238.14949-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 cpu-common.c | 3 +++
 trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index 0eb5c7b8f24..988d057d844 100644
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


