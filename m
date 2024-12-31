Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54806E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShZh-0004Ia-Ot; Tue, 31 Dec 2024 14:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZg-0004IS-TZ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:41 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZf-00083w-7k
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:40 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862b364538so5871979f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735671997; x=1736276797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAtXelESZqP9EpLglyIc26IsQk/mXnYos/ye7zC5LFE=;
 b=e6C6G1RHQbsEgdiL9YKcK/ySQ43gJVVIVQFWBksWtvnhMLyrnabzqmot7lEIs6G6cD
 EGoPrXGgk//+VZ5TdMyeBWiwd126OFJLM9tHKJEoRbPfdIrGCrZeL7PQxYAbsLeAMf6N
 7QabdYKENT4ur49dnwR4HzcqfTxw1ofdc5ZFEXuZEhdAv27WlHaYOz6warWnIbiTRHdA
 cJAY0TeWvHMkpQg1ZGg9GzVvnbbF+JASoAYuyhsS7mLAzQyKLgDQ5krnMrIZUhrvCEBV
 xOtt52g9MCXf7JlTvisxwZQPJGhcVrv59KLkJgG0QTAlU9wtaZOdVU3Wo55gaFsA4oHU
 vLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735671997; x=1736276797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAtXelESZqP9EpLglyIc26IsQk/mXnYos/ye7zC5LFE=;
 b=r+YVXTBHrXpkJVVKUy++BPWonOm1YVPj3EqZBrcGsv6JoMqw2Hts57XcRXv1OWw6b/
 cM/kyTjhKPXIJyBovvNh2F21YwVq/vBGO/UqvhsPg6W4GwYkD1AzcdUkd41Dg5KnxoUS
 /AOyhIpGEzwwu4wLdmr51xFesFLDRzAbPDOuvZaK9kpkfViUA/uUW4JBCpbC/Fmo5VWD
 gs8NF81d9GUepuFFvn/gJfpAn35vCeNr8yreU+hxJV+ap7/Dof44kKxJhb0Wrlln+ooc
 lB/l6orMBTW7NWfq6sD739m1gKxp6K0R1RvZtc+gY/Efvnkii1hKskJYf3WCDmeLVmah
 Vwrw==
X-Gm-Message-State: AOJu0YwyqyuvUSqeJlDw5e363+UfYCDVbDEvfFIg5xlg2fTYORSRJTA1
 ULmAw4x9lfE4Al7yszBT+mxwV+HlKQy0ltA7DSYDaGoh7E2Ha2WS2Zv6pWWwwZfgKyeqR3Z5ZZZ
 PKc8=
X-Gm-Gg: ASbGncsVrVo9UUk82+dlkzJEOBolo7fwMXSprYc6mcuNCYEvHJWz357bkj3n3zrSJPM
 Juv8mdwspVc/BRVhSMS9Zn92W2ltfih1V98c3m1G/9yA+IIwKwpw34HfNoGHhFw/Yw0G8LlV3G8
 HXPv3ru3pPrm1wALK/OeLB5o5yNypc5kgOZoU12UTAtAo2DVDOkzJAscfpTlHKToyDZekoKOU5y
 2WiM3SPgR8jkVv1F33oAt++r3fmZmpgxsaEQ4nks+I3luikBKY5/BgRdeEvEIqIbTos68QTyisA
 LXFetvewZ0GbV1V+saEMd6Vw797sqZg=
X-Google-Smtp-Source: AGHT+IE3DIwtSg6CuX/wOrQmnkzUlQSocrZdkDNX4ilZX/fsmrntgn8kvwzSHjirCR2MmMUVFWXdDw==
X-Received: by 2002:a05:6000:1862:b0:386:4244:15c7 with SMTP id
 ffacd0b85a97d-38a1a27499amr40080334f8f.25.1735671997224; 
 Tue, 31 Dec 2024 11:06:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c488sm395913725e9.27.2024.12.31.11.06.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 11:06:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/6] hw/hppa: Reset vCPUs calling resettable_reset()
Date: Tue, 31 Dec 2024 20:06:17 +0100
Message-ID: <20241231190620.24442-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231190620.24442-1-philmd@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Helge Deller <deller@gmx.de>

Rather than manually (and incompletely) resetting vCPUs,
call resettable_reset() which will fully reset the vCPUs.
Remove redundant assignations.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 6 +++---
 target/hppa/cpu.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 65259308e2e..8230f43e41c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -655,12 +655,12 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     for (i = 0; i < smp_cpus; i++) {
         CPUState *cs = CPU(cpu[i]);
 
+        /* reset CPU */
+        resettable_reset(OBJECT(cs), RESET_TYPE_COLD);
+
         cpu_set_pc(cs, firmware_entry);
         cpu[i]->env.psw = PSW_Q;
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
-
-        cs->exception_index = -1;
-        cs->halted = 0;
     }
 
     /* already initialized by machine_hppa_init()? */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index d784bcdd602..41538d39d62 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -204,6 +204,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
         scc->parent_phases.hold(obj, type);
     }
     cs->exception_index = -1;
+    cs->halted = 0;
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
-- 
2.47.1


