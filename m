Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE17CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy8k-0005Ju-QM; Mon, 20 Oct 2025 18:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8j-0005Ij-B3
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:14:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8f-0006Vk-FW
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:14:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so31953155e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998435; x=1761603235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+e7VY5y1q7fPnyvbmyUJua9whr/xsLflgiFLuiD5Ih8=;
 b=lQQ9qlSMBTHbk1z1gENldiiTOdPU5cg5ps0Hqkytn2hiQBGwJ6gHHum+1WrPlXx8VX
 fnNu+HoSg2IbjsUT6XEenId/V1d6ytXTxeRGg1O7kdr1FIfwo977UOj3FUBvfEAMzVNO
 oCphHwRI/DL9m9EgowRDG/Ut7Tf6KIICnEH7lTuKw9dECu12hH0wSSPsL7FCvDz3Xp3G
 qNgdeyGY6IQcvO5rZWjzeBe1Vh33++4yBNmKil8PP2b3EGSIn0o0olTNDhC273lVzVpG
 FHWjEIpUVOg/N4Fof44rY5KY+sn5TWhHJNEebuk0456zpsQr9ZLmEelgh4+xWqVdSrW3
 pfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998435; x=1761603235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+e7VY5y1q7fPnyvbmyUJua9whr/xsLflgiFLuiD5Ih8=;
 b=oWE2FxqtZY6P4YRupbCtX4pExjaUkWPPgRxGXxXch3ctg8S4XIHUDznXeWeVWPPvoO
 isBYLwRRgmqHErk/I82LLglSM1j/Wx9Qb2PSvXE0D7Ltn6wWxEacNkQknt/5SgbySEch
 plm5dfUElQA9EgsucGEKEPv+dGe7Dc4X/OT2W56dL02G4Xv4hBrqdXwflxc4/669R4fv
 UFs520BzA3LFbMdfauQLi/vRUdyxL6/MlCbD/lN0bcw7qg9LUzBgvDjQjCyqYD4fy6R7
 4Ek10RPE9ReKIedLL4bz42hrFqzoByWoktJWNyuvXjcLEskmaNV+DrNjh1TytyA5bQTI
 kJHQ==
X-Gm-Message-State: AOJu0YynLHsAXdH1GrV7MMVUmxBj3VdAGqBlmUalY596cjMjyzkiEKQu
 /LbAWBDY+fbZ4XIrp1040D4Zna6qbGoM4WGSbSO/7VvkB/lxrcv9LcXZhKgS3ZupzH91q98Y/E1
 /3vGJkao=
X-Gm-Gg: ASbGnctzA7gfTSNlu0r86IUQlTwj7gT8BGGXcdd/UMQsVeHu1pwmYkXhLhTwnVXOGu8
 0xG5nRUCLDGWHrPPJYFQa+HurCPC3C6yi3rvm7Lct1U45ogpGZcPpDZwjqdo9Juyy21EhS8Lwq9
 2VqYsKkI9XIVZv7SdepxTOiSHgIwR58tYlBMU7zB/EyAipZc7OJyUik44IWVhFGQDkWwsJ5xUj0
 zhiEKhMRHX5HMBrChCXbsbsNOXcfBB2WF3gxsWYgnCq0zTkUOHJZmwN1Uso/rhmqjElXOZ8hApS
 sPV5xeVQIPuyCjBNk4YfQdyQJyLhn4eALFZMBaD5Qi+RFQzKVkAMvgfqXa3sF9rzrLtr0iYYZ5q
 uBGE8v3Q5aWsGyEXl+y8MbS9oN4fyMgMdT5wjdlpI4Y6sHgp0LcQHN4ffUBKs5KsWm1n49uEu1/
 QjUdepKDdKDFnTeH9F/Ym0Jzr+cKtlQKnK7d0s40yTiiAM7MKxa2FjHQICknX3
X-Google-Smtp-Source: AGHT+IGtAoswsOqV2aBqA209eTMwKY6N297qrLfd/+nlmxs0B2DzWhPZz43+vA7zY4vg6H+eYwyhJg==
X-Received: by 2002:a05:6000:2911:b0:426:fec1:a58e with SMTP id
 ffacd0b85a97d-42704e0e681mr10936952f8f.53.1760998435377; 
 Mon, 20 Oct 2025 15:13:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00cdf6csm17124823f8f.43.2025.10.20.15.13.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:13:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 14/30] hw/core/machine: Allow dynamic registration of valid
 CPU types
Date: Tue, 21 Oct 2025 00:13:19 +0200
Message-ID: <20251020221336.66479-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
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

Add MachineClass::get_valid_cpu_types(), a helper that
returns a dynamic list of CPU types. Since the helper
takes a MachineState argument, we know the machine is
created by the time we call it.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h |  4 ++++
 hw/core/machine.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a60e1d83390..8fc34579412 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -259,6 +259,9 @@ typedef struct {
  * @smbios_memory_device_size:
  *    Default size of memory device,
  *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
+ * @get_valid_cpu_types:
+ *    Returns a list of valid CPU types for this board. May be NULL
+ *    if not needed.
  */
 struct MachineClass {
     /*< private >*/
@@ -305,6 +308,7 @@ struct MachineClass {
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
+    GPtrArray *(*get_valid_cpu_types)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 681adbb7ac5..5d9684fbc85 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1573,6 +1573,8 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
      */
     if (mc->valid_cpu_types) {
         assert(mc->valid_cpu_types[0] != NULL);
+        assert(!mc->get_valid_cpu_types);
+
         for (i = 0; mc->valid_cpu_types[i]; i++) {
             if (object_class_dynamic_cast(oc, mc->valid_cpu_types[i])) {
                 break;
@@ -1599,6 +1601,32 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
                 error_append_hint(errp, "\n");
             }
 
+            return false;
+        }
+    } else if (mc->get_valid_cpu_types) {
+        GPtrArray *vct = mc->get_valid_cpu_types(machine);
+        bool valid = false;
+
+        for (i = 0; i < vct->len; i++) {
+            if (object_class_dynamic_cast(oc, vct->pdata[i])) {
+                valid = true;
+                break;
+            }
+        }
+
+        if (!valid) {
+            g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
+
+            error_setg(errp, "Invalid CPU model: %s", requested);
+            error_append_hint(errp, "The valid models are: ");
+            for (i = 0; i < vct->len; i++) {
+                g_autofree char *model = cpu_model_from_type(vct->pdata[i]);
+                error_append_hint(errp, "%s%s",
+                                  model, i + 1 == vct->len ? "\n" : ", ");
+            }
+        }
+        g_ptr_array_free(vct, true);
+        if (!valid) {
             return false;
         }
     }
-- 
2.51.0


