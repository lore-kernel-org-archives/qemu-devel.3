Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063AAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSini-00026J-Bl; Tue, 31 Dec 2024 15:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinO-0001jP-Qw
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:55 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinL-00012U-Oc
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f796586so106901725e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676688; x=1736281488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AloPmLUtJIdEn3N27rO6zDqGnD5UcjWX7RRR5V1X2ow=;
 b=snu2RYw09AfV61WBEZGxUx/cihUsE4gekL+Zmxfic+lEOcMxuwKRJbrUuXQNVYRang
 vXfDRIOUUiR3gN2gmDLEjEm+rL/cPfxSVZOr0mKwsdUYS+Qs2rEy6wTmAzmyVF8oZkZm
 GOsTZklIktlU2ATK2blJeyobb/yc2IvOzhY3u0i55cyNv19ym0qyadrduRviIGgQL17d
 bj4FQwD8X8kUKvhkV4t9lXPG6fIGE5hHckCUkw9cQ69oenY6s6bgjB9cDqvMJdP8vivS
 uBJlGHTrPaz7cL9VfwgKJgyADqTQo8KSfa8Zr+Y6lTI4KZXQ4R8JFNeC/LFgC8LCqsBb
 qYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676688; x=1736281488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AloPmLUtJIdEn3N27rO6zDqGnD5UcjWX7RRR5V1X2ow=;
 b=hOlw3MK1mRs9mYKMzVJQgOWs+qxSes6dhqtOZLASCVdKiDxqwEHiTzugu7ffEWfTGk
 tgZ7s64f8IiwY4w/wWbKbjn6b6tuVz12nlleyiEx53XLu/5cDsNqNUvKAEbsDDbbvhky
 Rt1v6t5GFHxOWOqNWt9JX9O6z2KIYvT7L6FbSZ/SGPCRIueaSDDjxP6QlKnc4LvsPM38
 phmlU9Dc5tGwDIs0WMAkyHcSMnVGWF06Hwe9VWx4TNwnSjQ1c789KLypLWvDmAd+c3CT
 9Sro9vscQVU77L+jjX665JyrYSKF35tbN6F7V5r9PoAJFCpi+YiR7oOPM/cLXV2vDxd3
 XB3g==
X-Gm-Message-State: AOJu0Yyx0tP2deqyk+bD+BxbEIyQw750KLFHD3IutUFfsfHwDDWfpF/g
 +NuYmfDFVLrw4OclPQIpQBqDpaMIVkGxaOcOgFGR0aZ5e34ZZmfCZR9ATG3xJ7X5dbdw9mtGDa9
 A3U8=
X-Gm-Gg: ASbGncvxjdxmru6Qo67coUU/kA/3cvtlHwRApe9h6UygiyEnKOO8WWN8AwnejOr1H+k
 Sq6g/mopeQtUjhU2BRDH1TTHyiQFA24IV9zvYJLRsV88bLJVduaURJqSYlqlDTXABNSI+xlBrXK
 IeFFAqocLQlRYc21/AA5b2QAuapCJEICIw4agySzBDjUEMUGqwH9CAmZteD8dcWaVGFeDbtCZ8H
 6UvseRePlfYWSttD2k970KkDvDjICwM0HTHjG4sDBg1Jd3Ya4l/HaNw2KHlvIQfXyzP7h64twFs
 u6dzGGaSJmKdbjaSDDc6UJiBAlqXi1I=
X-Google-Smtp-Source: AGHT+IGVOsMXejfyighUGwAQuClVJ+TINyjHYZxVMAgIAi0hhbPSJkUAZO1xSYO58AI947OKNg9OJA==
X-Received: by 2002:a05:600c:4f95:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-4366854c111mr370799555e9.12.1735676687957; 
 Tue, 31 Dec 2024 12:24:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119ccsm431476045e9.24.2024.12.31.12.24.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: William Hooper <wsh@wshooper.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/29] net/vmnet: Pad short Ethernet frames
Date: Tue, 31 Dec 2024 21:22:27 +0100
Message-ID: <20241231202228.28819-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
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

From: William Hooper <wsh@wshooper.org>

At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
host's ARP replies, to the minimum size (60 bytes before the frame check
sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
drivers may drop them with "frame too short" errors.

This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
and net/slirp.c. Thanks to Bin Meng, Philippe Mathieu-Daudé, and Phil
Dennis-Jordan for reviewing earlier versions.

Signed-off-by: William Hooper <wsh@wshooper.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-ID: <20241102205653.30476-1-wsh@wshooper.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vmnet-common.m | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index dba5b5bab13..54d900ba679 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
+#include "net/eth.h"
 
 #include <vmnet/vmnet.h>
 #include <dispatch/dispatch.h>
@@ -147,10 +148,26 @@ static int vmnet_read_packets(VmnetState *s)
  */
 static void vmnet_write_packets_to_qemu(VmnetState *s)
 {
+    uint8_t *pkt;
+    size_t pktsz;
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz;
+    ssize_t size;
+
     while (s->packets_send_current_pos < s->packets_send_end_pos) {
-        ssize_t size = qemu_send_packet_async(&s->nc,
-                                      s->iov_buf[s->packets_send_current_pos].iov_base,
-                                      s->packets_buf[s->packets_send_current_pos].vm_pkt_size,
+        pkt = s->iov_buf[s->packets_send_current_pos].iov_base;
+        pktsz = s->packets_buf[s->packets_send_current_pos].vm_pkt_size;
+
+        if (net_peer_needs_padding(&s->nc)) {
+            min_pktsz = sizeof(min_pkt);
+
+            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {
+                pkt = min_pkt;
+                pktsz = min_pktsz;
+            }
+        }
+
+        size = qemu_send_packet_async(&s->nc, pkt, pktsz,
                                       vmnet_send_completed);
 
         if (size == 0) {
-- 
2.47.1


