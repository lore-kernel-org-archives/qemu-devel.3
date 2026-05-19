Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB663CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBgJ-0000Pn-Ty; Tue, 19 May 2026 00:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wPBgH-0000PD-R8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:03:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wPBgG-0001nb-4g
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:03:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ba25c9bb9fso6087695ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1779163422; x=1779768222; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:cc:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qkf+g7cdFt1RtnUkxkBEq+F7wkb8utwM7NUiDc7Vnzc=;
 b=N/rdv8nQ/+10MLwIqSytzdDH+8EhOcb34xPoO6LLtNeDCP6/hGEasCILsBSks2yjf+
 U14oGdap1U9NksNtxERldt35ABI86Pc2S1kJPxo6TJCEfm70BboU1FWwynU89cGquEqi
 j9Tt7uIPNjgqpzGoOPWFt6Ccaj0ys4XvWbmcxjvslo5cl+t8v/cVC+mNgIvfjGf5zUvw
 Gh+0VmLS8yjv/hvt9TbLH+tFoo6BQhyBviDyZDbFnFrCvIvCs76Mc7xFlmWH6lhBT+9/
 RB5GRRRQuEJXHRTa+BgEuNNbsVii95a7qZm2ihvYbBoV68WH9yl6ap/C0VMjQt/ZdYOD
 0joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163422; x=1779768222;
 h=content-transfer-encoding:subject:from:to:cc:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qkf+g7cdFt1RtnUkxkBEq+F7wkb8utwM7NUiDc7Vnzc=;
 b=SmRXbt573g411105/nh4tnqzCc57N52fozjSIr0omNG9R7Grl3mOciaGPs0PKhsmKU
 UMA6BmiN6kEd6teNnxfo247XGoxNgK3zOpdP76oV7/mONFMDbNCDQP2WEaZPXiuM77IX
 hCY+rl9a+JG8GbNRU8M47cI/NtIh69EAsbM+TDPpJHS0t/BbrTbb59LNW9tKsz1HhVFx
 l9UTeXVLgazrG2Njisdct0bbBdjs/ItN1sf/pFHPbz1ejKiJ1jPiCBerbGm1EF8Yij++
 wzhLeITJ8RQDNGGgzGvKvnu7OzujoOzlbJIrJpRJbIOgQiKTUKPu0DFJCn2ZL0GWcGms
 ejew==
X-Gm-Message-State: AOJu0YwVL2xQnVXWW1/wFW9IBa+S8L+ek6+RzmMArrQhQRhj6aadLMCk
 ndsMJpiW5ye9g9NlvwUzwVOPu0Zt4B4WTA/72QnZYOwlC/JvPny534jwKt5cRubpoC/7ist8WVY
 gy6EfFHS1Vw==
X-Gm-Gg: Acq92OHD0STkiAe9UqDY2dS6GID29hXhE8t9BczgkiBHASHBrlpATb7qxNTEQNIy/19
 sx3FkNnUMEY2WJyaLhIopkmabphU5h3xFB/6TVMKVwUQYhTnBuSXIxAOlS+7REUEv3BqwYQIX6s
 ghaJTYWk4DWT85AJBYn7Bto2KKCcM45Q3dr4YW9XYlZZIBDy62rshZgmHlDpVoWKjfTyU/8JL+d
 7PznHq/lwAaryMI7J+0bvG2dExARVmHHC7S28CBUFYt0rIHLlQHg9qNnJNY0sQY7U+wGjhNLfJI
 haQd55yD5q+670W4+WCnQAwXg+A2aFwI7pivHhJ4aBWDPJ1EZfPYS9BmsbyT2grOxgFuXLmzQEf
 FCguenZdIldxQilsqyUpSRDkesyjaRD8RqFdcNG5bsmFVd5bMfdLYxeb0nEm3pxU2sPA/PKuHa0
 ipIeN8rqXONrfvsj4jSWxoO24tAk47YVGzN2xARj5PC0QnpS4cGolykJ0J8IS1CQ==
X-Received: by 2002:a17:902:e8d5:b0:2bd:6e1c:3c1 with SMTP id
 d9443c01a7336-2bd7e77778emr69735685ad.2.1779163422202; 
 Mon, 18 May 2026 21:03:42 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2be2f604fdfsm3509325ad.18.2026.05.18.21.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 21:03:41 -0700 (PDT)
Message-ID: <90ffd339-28f0-46e4-bc3b-f7aa650df1c0@oss.tenstorrent.com>
Date: Tue, 19 May 2026 14:03:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: stephensportia@gmail.com, palmer@dabbelt.com,
 Alistair Francis <alistair.francis@wdc.com>, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org
To: qemu-devel@nongnu.org
From: Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH v1] target/riscv: Make hpmcounterh return the upper 32-bits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The counter value was not being bitshifted for a hpmcounterh read
resulting in hpmcounterh returning the bottom 32-bits.

Signed-off-by: Portia Stephens <portias@tenstorrent.com>
---
  target/riscv/csr.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cfd076b368..c522533807 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1389,8 +1389,9 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState 
*env, target_ulong *val,
       */
      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                    ctr_prev + ctr_val;
+        uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, 
ctr_idx) -
+  ctr_prev + ctr_val;
+        *val = extract64(cntr, start, length);
      } else {
          *val = ctr_val;
      }
--
2.43.0


