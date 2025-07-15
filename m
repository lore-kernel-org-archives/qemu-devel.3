Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9102C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbcd-0006ix-5T; Tue, 15 Jul 2025 05:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbcW-0006ey-FJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbcU-0005tq-Mp
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso37597495e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752570396; x=1753175196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HeRttEAmKON49LT3x6332F1JOEdPXk8y2PB9EZ85z0=;
 b=ZBLetSbr/zl3PQEIBacGfMWE9ze+tA+rD4HfnlKINPOOaGwxGbvU7I6syxjYQM37FH
 BuClDBs7KTr2wQiRek30pvHw3t/2zE94A1PxMRv6UsEpYmYEqRKVe19W79tz7wL2KHNF
 Ij41zQOy4xDR6sYw1xHbStQx58l2Df0XhXkWfDI31EygClxVDA5T2pkwoMLyRaeqBTog
 Yt01X3SdTzZ8K1ef0+ZRm4pc6bpBK0mNKMKDKcia/iIWjwZ3YH+L8n5xZxUG3IBGZ/+t
 xpkjUXBDEaafxkXjRYJUFfCNck5FcEztoIwJQDurU/pf8UeZXtX522Gi/H3DOYzDGqFG
 b5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752570396; x=1753175196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HeRttEAmKON49LT3x6332F1JOEdPXk8y2PB9EZ85z0=;
 b=mUki2oCpzT2dP60WJqwjUL8xbWHWFuePnHJ1TOPhPNRRgCs2AA1M1TudhxXlBc3Twq
 PiZdhJr51YI9IKCHJZYGF8ia8v+4/ddkSzSSFWBwml+QYixGAKK97QlBp7pseAitoJMP
 wXj53S05sjN6TOcvtjoDirscvqXmuIh0UhdkCgAhKX3xITQRojz00uRf0vp3QiPvraqn
 Srtdode5dBFj7f9PlK3uqZhaRS0daHn1i+CrZD6R4SamCR3E7zZb+nA1QQ5O2YU1ncMl
 0u92diDeloUPiX+4pm7RxmBKsPq/JtmrYdWw4YoNrMORH1NwdvWMUiCbrgLHIF843ibN
 H89A==
X-Gm-Message-State: AOJu0Yyt1KlLdpbNw2jpqUTl3q/78lFDaGxk5sQP9c0LuJLG8wJm2bgi
 7qSVMtC/aUR56wtm9DEakElpSszpA8ZthUQjJdmJTIA4DEkeXQ51OM45k6S7BFcOMmq+gkpFxv6
 60UB3
X-Gm-Gg: ASbGncs4yecrx8V/LrM25LXqvOeV15kPEzRYJK9Bb54QvxZLdH0tU183VURKi0jTozP
 Qj9ajAyLmZdRscK31s6N6DrpNICHwzFI5pBsW1CGWly1bxr+jseY77WyjRrMyQ+wQhd/gO9x1/9
 mctOhEyDdjSQUOfyGcsEO0eP0fD3L6u/U4m/WUNV+dfQLdMqZyrAbVEozUUvkwrMs9aZ3hBoyDd
 G4EQTXa2UJ+UWqe59Jfr4SVHY9Lz71esW3KNlLq7jmuKNKyq4LGroOz7bCyEDuKSWgqX772aiG8
 NIki4cZRqH1ZPV0caByiN599frsZM+6MdD2t1jJo+Jb0Qp9nGQGmsf8Fs1eVBCBEsSZy8eQfxeD
 SRx6ibKxgWNgSMIpw4vM9A7fCuKmRXyyjvb1srTETDXAQhTfJMHFFfMdKSVkJE1kANmjdl+797U
 HGBQ==
X-Google-Smtp-Source: AGHT+IG7hzNOXhVxa8IqULWr44xWkR010ayQ2TrFa+JcSaiGs5C5sA2IUe4Ty8bp9JCrcAJoWBpW9Q==
X-Received: by 2002:a05:600c:1382:b0:453:7713:546a with SMTP id
 5b1f17b1804b1-454ec16cd4bmr163068795e9.14.1752570396462; 
 Tue, 15 Jul 2025 02:06:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd541a59sm154464795e9.32.2025.07.15.02.06.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 02:06:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v7 2/2] hw/core/machine: Display CPU model name in
 'info cpus' command
Date: Tue, 15 Jul 2025 11:06:24 +0200
Message-ID: <20250715090624.52377-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715090624.52377-1-philmd@linaro.org>
References: <20250715090624.52377-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 hw/core/machine-hmp-cmds.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index c6325cdcaaa..54b6f5406dc 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -32,6 +32,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     cpu_list = qmp_query_cpus_fast(NULL);
 
     for (cpu = cpu_list; cpu; cpu = cpu->next) {
+        g_autofree char *cpu_model = cpu_model_from_type(cpu->value->qom_type);
         int active = ' ';
 
         if (cpu->value->cpu_index == monitor_get_cpu_index(mon)) {
@@ -40,7 +41,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 
         monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
                        cpu->value->cpu_index);
-        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
+        monitor_printf(mon, " thread_id=%" PRId64 " model=%s\n",
+                       cpu->value->thread_id, cpu_model);
     }
 
     qapi_free_CpuInfoFastList(cpu_list);
-- 
2.49.0


