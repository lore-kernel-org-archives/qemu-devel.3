Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BF3C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublnv-00011p-Dr; Tue, 15 Jul 2025 15:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublb0-00028M-JI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublay-0002gZ-ST
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so30723525e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608743; x=1753213543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mg0kAtPoLtyuNx//5J8QI2+xgJAwgK4CqzuD5gBbA9M=;
 b=BkJ0S3AZRWNVlrHFb+60BIIkc5EkF89x1g5FUIR4uOIqNQ9WDdKdrKnF5iKZ0ubiZ3
 31tkuq99U8X2qgLcv07Q3jtcbQmftTJlTOfb6kDVe8TkTKay49Jj4edEsCcfj4wufE1W
 naogMe4iTwhOd5UvX2AG2YnObqKXSdV4gsW7zXt76Qkm1h1CrEJJbs9l1CuC3L1UM7Vs
 WpCJXY0mhTjYmY7acH+AU3vGS+GTrp7AssjUJ1XDXidcGIECEq1T4FSSuC9/z/F5RiiK
 7Bn26gzJlupryn0OFTb1YeAsuQQO/DHtbrRqVcMbgIIxCPRFlye1ul6VrvQ98GAuQof/
 vi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608743; x=1753213543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mg0kAtPoLtyuNx//5J8QI2+xgJAwgK4CqzuD5gBbA9M=;
 b=pHjPPHD/XuB9SkzEjOdk3cflvDJd/yMLvDNz927hxW3VW2gCu9xiqeBGCqI1IdADVn
 jp2co5co91BqRkc4ZmFABhanVijBMfxhVQ+XHg2r0mm1/fchUvvjSJ1Vi+ror2Rq02Hf
 kAwIiT2sQAN3gTlD2AL8u6tvuntAfUXWiJU14PWndXBu1fDV66U+K4bXVl2znwWp/eXn
 ad66L09oZQaTs3OjCaCAmeF5X0/hTTAw0OVwi8JvpZXdpVgCiLQFsdFXVLYql7oxWnMV
 P8Kx/i59fobyGQRpKbNIEYhSNB+IWh3py5LD36oKnD9yiGtXd8MjQL/oHY3y+8zm8Lav
 B8Jg==
X-Gm-Message-State: AOJu0Yz/4CLjzuomhqj71XLK45cLfCvRqOcOkABjEDePRqbadqQQAVr9
 E1RxsG+icm6wow0rZvDw30/c9sh6urDyHiA92dhw8DSakgIWT7i4ACdPvv8xzMorHCiSSMk3JUz
 sWmN+
X-Gm-Gg: ASbGncv5GhrQb5mQdJy1s9v97mX2AoWVGOj1C3CR19kxzEnj8AcT/XOYGO8p5cRRVF3
 L1KfAYsbiBk3mvoHKWNO0Kc6ugt9b1rqRorY6SkREgmSfvIoBhUrbuLUDta55KSNkZOAF73lXYz
 72w5K7nCW/W5b1YBJ2F60ZMb9Vmq2T228yU0dOSFEH9SK00a4gFJ/htjv9I9hMtf0aIhH6T6shm
 DB79oz10SfbWs9uhLSYZOWO2nKWwVo5NWx6MnqEWl5CB0Lx3LRvYHK4HXosTnp7mr0J4c7mX+GR
 CAZtExd5xRvaQcLvN7nkhR2GG25g21puLCvVvrsOkaWElDedDKuOctoo7ZPROu5vv5sEyKo3qza
 qTEyvTY20SuP1jmuvS+UKKc8zxOr/jcTuP0/v01pRFeiMpJ7ghvDYL83K7G9n98Q8avcUMUJzsT
 pSWw==
X-Google-Smtp-Source: AGHT+IGd+YL3xbeMnIF/YY+qKHthQWDxQdpn8zi7r87LKBS/d2aao1Rr3a8Xo6WVMya9+36A3TNASQ==
X-Received: by 2002:a05:600c:450f:b0:456:19b2:6aa8 with SMTP id
 5b1f17b1804b1-4562e27497dmr1618115e9.19.1752608742907; 
 Tue, 15 Jul 2025 12:45:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562bacfa41sm9300245e9.40.2025.07.15.12.45.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] hw/core/machine: Display CPU model name in 'info cpus'
 command
Date: Tue, 15 Jul 2025 21:45:04 +0200
Message-ID: <20250715194516.91722-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Display the CPU model in 'info cpus'. Example before:

 $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
 QEMU 10.0.0 monitor - type 'help' for more information
 (qemu) info cpus
 * CPU #0: thread_id=42924
   CPU #1: thread_id=42924
   CPU #2: thread_id=42924
   CPU #3: thread_id=42924
 (qemu) q

and after:

 $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
 QEMU 10.0.50 monitor - type 'help' for more information
 (qemu) info cpus
 * CPU #0: thread_id=42916 model=cortex-a72
   CPU #1: thread_id=42916 model=cortex-a72
   CPU #2: thread_id=42916 model=cortex-r5f
   CPU #3: thread_id=42916 model=cortex-r5f
 (qemu)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20250715090624.52377-3-philmd@linaro.org>
---
 hw/core/machine-hmp-cmds.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 5ca0da77b14..3a612e2232d 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -33,6 +33,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     cpu_list = qmp_query_cpus_fast(NULL);
 
     for (cpu = cpu_list; cpu; cpu = cpu->next) {
+        g_autofree char *cpu_model = cpu_model_from_type(cpu->value->qom_type);
         int active = ' ';
 
         if (cpu->value->cpu_index == monitor_get_cpu_index(mon)) {
@@ -41,7 +42,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 
         monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
                        cpu->value->cpu_index);
-        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
+        monitor_printf(mon, " thread_id=%" PRId64 " model=%s\n",
+                       cpu->value->thread_id, cpu_model);
     }
 
     qapi_free_CpuInfoFastList(cpu_list);
-- 
2.49.0


