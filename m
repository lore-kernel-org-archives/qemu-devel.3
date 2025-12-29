Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52375E94102
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMTF-00075m-Eh; Mon, 29 Dec 2025 18:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTE-00073W-8j
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:12 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTC-0004TY-DC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:11 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so4446215e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 15:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767050169; x=1767654969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4/z0QQPHUWriuxdqOrZVej0Q7UwOmQHDYQSDtJ1LOs=;
 b=rSIjNGYgLdtgjz9unD+/DH2yaJlDWGffxzrkHDgWQdpSfzZra+IxAaIikKM8pGaU4O
 RfBQ2P92CBvPFQy4t4vXze7VXWF9LKRU4AW4uYuIM+9xwVenpfE92n1J2F/dlnB7f/HL
 rIZxZNqOr+iSKOH9a3cRHf+MDlEXzl0s5k5yorD3X1GPo2dwJuTPJgRmv7STgB2VoXZv
 5wmOONaNrWgjGa30NB3QTMCq6FFhq6PXtx6GuptnJJA97dfwl0STteL7KeDxLj4Nzx4n
 GTIZMHd7iyqoXMBVv6nylw8NyMhFWUNwMYz/WHN6y2D+fWJHtGVOziVxCPUbfPP+iylZ
 BVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767050169; x=1767654969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v4/z0QQPHUWriuxdqOrZVej0Q7UwOmQHDYQSDtJ1LOs=;
 b=vUvZRkAfQODrsqsBq0dlamDaYl9+P9mBYgb+UFacXHFIGFuk3yNd13eflkakuLIfEt
 pmApWzuHdq+q8eu7AkqpxbmxKa4/4qbPduNxBc1kYar5TkolX51Pgi2yZSzsZKbZxGQl
 GwW1CAtzMY7F2Jo6S89RRBz78xLXMlGKrBK7VpSU9uVQn0R6BpCd50qP3JdhG+tbFC7M
 WM02ML7k0jNMGsGkH293w3vs9pKsf0bPq497Vtc6cJS6sBFnKXcl00RWoFOzEGsLNxEf
 wn1M168+vd2z3+sd0rnc1wbzKR4JL1olZStTDtiT80vOKMKK9BjJ4gRji3bNeJzhspVw
 TtSg==
X-Gm-Message-State: AOJu0YwvR8L+ovrHwL6lqi/5GBm2DFpR2RnYbE+XqZ8cc5xCrJ9RXBYA
 6KUEU/N9qB9bI0HUN1qb5u4wiFwGdKH06A9xz3XAICTiha5RK0f6aN5H3+bsO+Q83xyGQEzc/aG
 N3KITrgQ=
X-Gm-Gg: AY/fxX6kkhJHJyrQclVkcYldUl+ysbepnnDx5iLMJUGZk/JR+7vEeW5SAdzdVDTh86Q
 qw5U2s47m7kYlf7hTTEJhTAiXTBei3dCGXiVQQZR8V/SmL51SqfNfj/czsMkllFF7BbDPoQUt0j
 IAY58F3eeSE4xmnJysx+YxJSDC22+vzIjy2SPSllTVxCrjJ1ajHx2raJosFKJfEAr9Wphy6wP5Y
 IanVjRQF3NvZJFfwtlk7rQVoRfqsFeYjf3eXRj7y7N4lUItUCS2HBHkqrAojPwXZBfgHgCQEB/B
 rzlnlVuIPpHq5BaA0TxP1DX/VlvJdvHVeKR9x2NXDIkRuNWrIXFnP5FKdCMO7hoBvuf4aoRuzqH
 o7awbfFezwJER2c86bTL4zKC4D5Ta/h9lexHYgRFeR5NyZWc+IxUFLdxW0gqmW+uOIC7GM+0MWM
 Z382jsBlL80WXevWJHQwDWg6XL588CWeiPTLND4TFB9hPw7XPUhdaBSMfRavn6OeJpdevvwRQ=
X-Google-Smtp-Source: AGHT+IG9DHSZOqzETmmAgkk9ePtcdYNtwEQWstcomqOqjBynSEfi5HbsE68icwdptDV1T/ZlUs9F0A==
X-Received: by 2002:a05:600c:45c4:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-47d403a0498mr189924135e9.4.1767050168603; 
 Mon, 29 Dec 2025 15:16:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbe58sm560664625e9.9.2025.12.29.15.16.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 15:16:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/7] monitor/hmp: Use plain uint64_t @addr argument in
 memory_dump()
Date: Tue, 30 Dec 2025 00:15:41 +0100
Message-ID: <20251229231546.50604-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229231546.50604-1-philmd@linaro.org>
References: <20251229231546.50604-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

memory_dump() takes either hwaddr or vaddr type, depending
on the @is_physical argument. Simply use uint64_t type which
is common to both.
Pad address using field width formatting, removing the need
for the target_ulong type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 monitor/hmp-cmds-target.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 51dcb9e314c..e855c0d8a2c 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -122,12 +122,13 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
-                        hwaddr addr, bool is_physical)
+                        uint64_t addr, bool is_physical)
 {
     int l, line_size, i, max_digits, len;
     uint8_t buf[16];
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
+    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
 
     if (!cs && (format == 'i' || !is_physical)) {
         monitor_printf(mon, "Can not dump without CPU\n");
@@ -165,11 +166,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 
     while (len > 0) {
-        if (is_physical) {
-            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
-        } else {
-            monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
-        }
+        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
         l = len;
         if (l > line_size)
             l = line_size;
-- 
2.52.0


