Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C41AF417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyh-0006mH-C7; Mon, 09 Mar 2026 10:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbx7-0004LT-Jc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbww-0005kW-6l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso106124505e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067872; x=1773672672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfrbHFhAv8bhscS2w7kB7DC3fNMKySB4UiY5tzkGzOE=;
 b=ON7Z+ns4hWiJ2eD0ZK2czi7L3pv6kBvDd6CrYaDLrx+vWrRperoSrnVmZgEjUiiYpZ
 yT2npLRaVbAKwHjdAUFv6Bd2PYikP6ic2HgpPU6u/LaFhbDEDQ56agB1lId7vQ92L0hd
 EwHbKZCjSJEawdmOMR2492xQ4pZ75qhTsvP9LKciJPeQ5JAzYXiNUkah8zd5kkYZYxLV
 4y+IvMDt9TgtuoOqNsOZqU0bsEaATTCYFAOJgTrFzqMwwdwry+4bBwJdpRRvjz/ckT4W
 WDoVvFon3H6r6MQ6tpAY7dr6SNfb/7SHoiDOQJnasKIGAKCgCOUu1S9SXXVxiTUNoNxZ
 oqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067872; x=1773672672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pfrbHFhAv8bhscS2w7kB7DC3fNMKySB4UiY5tzkGzOE=;
 b=COnf+cT7JNNzNhWDJ3N8ag817dnT5VGeoiTQPv6vmPOPQvshh5XIrLIZrYKcQiO8zr
 kxO0huGjxfkN9nyx89PV5DlWmrJ5TJS/OYnbPenUf7gUvJqasgSHaRfU6Si0YvmiudaN
 FWT9ghbPixmgbuXoREc9YcTEAK5xsuIVHkCDQvHguVExKvLzlq8VNYqPIjvi2ZnNLntG
 sXiaKfpURR6VVmqwmhxiK4CV/06f+RaekkSWsp5NwDky1dsw8P9gCN24bzEiGL890mlg
 SSZuot7fhB+8wY/mjX9Lu7MiscWHxFcjwVxtSrTlzihtoreWmtdd+/4gPbcuSr3BI8Xq
 z6kA==
X-Gm-Message-State: AOJu0Yx0Iacx3Vpb/6/uAXsrVM5VkAJFe/LYglaS1IMYyg+QJnzaBlJS
 MRYgrsaQDbldpm3FVJE0oTD6W94tpvk9Wv7eJR3zjDHqL9E4R7+dvL0IrRjlz61IC2SPM1zmyTC
 mlz6Ku58=
X-Gm-Gg: ATEYQzxDTZo8opPpDL0LjAXc0EWc2qfYl9ChxTHhXWPyea+6foI5L6ZgLXFQHRqGqwp
 QZttjKCo7htT8JKuJQUyVppqN3LZXjcGoRGO1bxJmeUUAVCDg65C7R1Cy62mM0WnIrUpzciDtQE
 L+8oYuapE/lGtPmGefzv+3JYqzBeSSLyCVdNAUTioe54WaPBeVGRyUNEIAvTVy0FJXbw6u9P3mK
 fe6okVXieF649YPkNGTcO5bXgWT743caZtKPsbMRJ+TnSnP9iP75bwZwu227vjCjNEQCpZh5cnG
 tMgOiHKIeuSwIPMgf6ebASaeueMuGeq1niD2gMDXtp1JrfrScM76RBSY4nZWsDGCVxBZivd+wdE
 OlsPOgJyMt+zp1Or0hqE0bu35LEMdhNrlGu2Terpknavtu8jt6DRtvPojiB+e1iLJ6NGqYItDY2
 TU/ghf//3p+Ma3ps7eLuZuztYdEa70LHJbqqCnlFzeUcMSjzg1eDXVWQAAyD9XOGe4u9ho6cQb8
 aZ68x//TIVTCuJi
X-Received: by 2002:a05:600c:35d2:b0:485:3ca4:4eee with SMTP id
 5b1f17b1804b1-4853ca45255mr43424175e9.34.1773067871917; 
 Mon, 09 Mar 2026 07:51:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b0adasm248388175e9.10.2026.03.09.07.51.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:51:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 08/10] hw/core/machine: Remove the hw_compat_3_1[] array
Date: Mon,  9 Mar 2026 15:50:10 +0100
Message-ID: <20260309145013.44327-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The hw_compat_3_1[] array was only used by the pc-q35-3.1
and pc-i440fx-3.1 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-9-philmd@linaro.org>
---
 include/hw/core/boards.h |  3 ---
 hw/core/machine.c        | 17 -----------------
 2 files changed, 20 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index e15dbcea83b..9155e0cc9ed 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -867,7 +867,4 @@ extern const size_t hw_compat_4_1_len;
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
 
-extern GlobalProperty hw_compat_3_1[];
-extern const size_t hw_compat_3_1_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 162600425b0..9a3d826c3cb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -221,23 +221,6 @@ GlobalProperty hw_compat_4_0[] = {
 };
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
-GlobalProperty hw_compat_3_1[] = {
-    { "pcie-root-port", "x-speed", "2_5" },
-    { "pcie-root-port", "x-width", "1" },
-    { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "tpm-crb", "ppi", "false" },
-    { "tpm-tis", "ppi", "false" },
-    { "usb-kbd", "serial", "42" },
-    { "usb-mouse", "serial", "42" },
-    { "usb-tablet", "serial", "42" },
-    { "virtio-blk-device", "discard", "false" },
-    { "virtio-blk-device", "write-zeroes", "false" },
-    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
-    { "pcie-root-port-base", "disable-acs", "true" }, /* Added in 4.1 */
-};
-const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.53.0


