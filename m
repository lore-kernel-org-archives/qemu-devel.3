Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FA8C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCA-0000HI-JE; Tue, 01 Jul 2025 10:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBz-0008Tw-NN
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBr-00070B-FM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso38407325e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380946; x=1751985746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1OZb9Kl+4lZDh9KBCT1cYYDblubQbpp2G1iwduVoYo=;
 b=yr2+/lOVXhTqJE4qC820cQwa+1L9AsYe2l5JvIoiddhGaq9IM9bZuQ5RxH4sqOiUs2
 CpO+t7euRwzVtTInlWq+TXbQ2cURTU9EjxP0qoA4SGhuo10+AULaZGnKfyrVL2fkyiAg
 oHNJRFAjJpmpSIIP7pkCfREnuamWBgNoE3aSRLDbSO1pKA4FWKv8BhEDoadVGSkyElHN
 boBxrvLEs9xyVyF0XOtn7c193/A8qV0myfz5LeYcGFPDl0TLZN4vO0hnGZsmvqcO9GBv
 sUCIJBEkKevstbkv2G1xls7C5SOET4pckv4ew32QMEPRj22qsplutowSo66ZIAwtml/9
 ytjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380946; x=1751985746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1OZb9Kl+4lZDh9KBCT1cYYDblubQbpp2G1iwduVoYo=;
 b=NE29XeqwAuYOCe2y0J0xSeNMuWJn7lxJswv1L3jyIJSMDj6+ZQxoFNwSpf2l0BLjta
 QiXkVL0jQRAQYiMJCzFKXG9ytIkoa48QnleNPsQOeWSWL7lY/kewn2m/S2QWmKwS0mYL
 dfZZTukBZAjWz84wPcj5w+xedZ2p9V1sjtHe8UqO+kPe1VWURRXOR8PxfRK1wJNtmpDt
 U+//m3z4CwoEVS5xca1w4ayrm7vU9xBH4iIe+69e14v5XCU3lRIV84753xMhNt1NNepr
 pVMP6fmy5I5mr+W8rRrMbaQgsUJt2E82KEGi8ZYrsXIMDBx2H+7pM8o0WpSxHba+cAlG
 7+IQ==
X-Gm-Message-State: AOJu0YzjOLeqhc4OyipRFU3JuYe9v78HQ8jDfzkK/838CRwCqrFrdNuG
 8G7/Z4l1nmMin49o/cLOrCQP/nxivzeOR8gCkcN6ku1Lzt2XWvYmPNAu86tOhaXhrpXMustd1M4
 JBoMS
X-Gm-Gg: ASbGncsRwxvg5GzIEVdaoprMUSLL+LB+TS4CwEyTwzjGNbLeHY7/lCYmKGIO/7JNnr7
 p2KYRzMZcyKqHotpezoQFjQ51cA1Cft3+FHQljQbIQwp4lalKXqX+jYKdXZEGrw2zrhIWjRp4d7
 uHmJlfDDtatClcy8ydzHdAUPT3UWvV3VYi40bgxu3z+rdPZQj6zhU6VUHZSzjVazlpZw+2s/nKT
 9WrMl4uoZH/SoB42/408PCtjqG6DyuoB0A60LQAVnhVlWSvNRBz3sM00TR1iK1zIFes/U1Yet2r
 C2ilcbu0qVOacnH4qZL/Q9WaZKdWvEpLK28P0Ai4F1CV+R4xg118JHFaR3vsH7GzxbZAKHIfRJO
 +qbiM54tEYYoMhofhrujtONnT2Jb/gelG9Q4L
X-Google-Smtp-Source: AGHT+IHwKkT2ZOaapDzSpT+XG+VDyQuPaXyh0D/HJBnATBYYTY20yeVzDGAKfXqXXlE4+oS5wm56Vg==
X-Received: by 2002:a05:600c:a119:b0:453:45f1:9c96 with SMTP id
 5b1f17b1804b1-453a7c8fc79mr30674785e9.14.1751380945936; 
 Tue, 01 Jul 2025 07:42:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a5b7fsm171981125e9.10.2025.07.01.07.42.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 23/68] hw/core/machine: Display CPU model name in 'info
 cpus' command
Date: Tue,  1 Jul 2025 16:39:31 +0200
Message-ID: <20250701144017.43487-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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
 * CPU #0: thread_id=42916 (cortex-a72)
   CPU #1: thread_id=42916 (cortex-a72)
   CPU #2: thread_id=42916 (cortex-r5f)
   CPU #3: thread_id=42916 (cortex-r5f)
 (qemu)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json          | 3 +++
 hw/core/machine-hmp-cmds.c | 3 ++-
 hw/core/machine-qmp-cmds.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0650b8de71a..d5bbb5e367e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -80,6 +80,8 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @model: CPU model name (since 10.1)
+#
 # @props: properties associated with a virtual CPU, e.g. the socket id
 #
 # @target: the QEMU system emulation target, which determines which
@@ -91,6 +93,7 @@
   'base'          : { 'cpu-index'    : 'int',
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
+                      'model'        : 'str',
                       '*props'       : 'CpuInstanceProperties',
                       'target'       : 'SysEmuTarget' },
   'discriminator' : 'target',
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index c6325cdcaaa..65eeb5e9cc2 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -40,7 +40,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 
         monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
                        cpu->value->cpu_index);
-        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
+        monitor_printf(mon, " thread_id=%" PRId64 " (%s)\n",
+                       cpu->value->thread_id, cpu->value->model);
     }
 
     qapi_free_CpuInfoFastList(cpu_list);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c68..ab4fd1ec08a 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         value->cpu_index = cpu->cpu_index;
         value->qom_path = object_get_canonical_path(OBJECT(cpu));
         value->thread_id = cpu->thread_id;
+        value->model = cpu_model_from_type(object_get_typename(OBJECT(cpu)));
 
         if (mc->cpu_index_to_instance_props) {
             CpuInstanceProperties *props;
-- 
2.49.0


