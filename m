Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DBECCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCN9x-0004Eg-8b; Fri, 24 Oct 2025 15:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCN9p-0004DJ-PT
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:09:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCN9n-0005et-2j
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:09:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dab5a5acso1804275e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761332936; x=1761937736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bJEm1B8ks9h5HyZDKkIUNIPRZdg3XjuMbaxmF/lz1I=;
 b=OMZLuMlgScbEpVJTEMU1XaZyLgGJ7+vQ+SEhnl69IIRwatyNc19aGSC7CXlj4Blr2B
 kMjes+FWEHqwKTXDKlndrlxEvdBoyz0L0lJCPn1UN2MS+ZDZtLJW1sQAfNv9bw/3iltf
 /+61GYUtRz7EEl6CW/krM2T2sM7gym4OPXk+gpLP8bXP/QM9C5jSMN2UjT7MMY0RwnCK
 X3Nt0E8ifraKdGOwYxC024ceR/Us1Q8V+PjdDgaKXbYEvSmZff+pLXny4On1dOVoQ/Cy
 xLrVOvI8sZdmkaG6CIPUkNxvTF14o2BkSM8lbyQZb0TPg8RTt0byDmP9a2ZEvw1NJjh4
 LiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761332936; x=1761937736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bJEm1B8ks9h5HyZDKkIUNIPRZdg3XjuMbaxmF/lz1I=;
 b=riOb43eVg2LUvvy8yRY8c9tLhbkDih3Yg4m9wUYJ+qtD413aJ/6CW29+y69NkltlwR
 EISLp/cALW2rHgLQ/OJMDXwBut4SD+Kfoo872qj3vpCdFKM2AJDBMZGUrVOfke/teAXm
 Jol4ZeCE+cTSSwB2uSkiHSrtK/zuINPvhssAuYnzHcNCbn0BcHoHEE4XrHV5drzbbZtz
 0eLMpVK1F58vv5qfasHvJ/33DGFcQOdyfQZSOJJTzBYg/SOvy1jwtNU2dqXMASbNNMEk
 Mf1p0fe90lrSoiJ6401mblXYcAhciOC/601CyYtrVToE4dJueS3I1kzjGYQN8ujM09Ir
 +faA==
X-Gm-Message-State: AOJu0YzSLkmGuCXgvL9ZOozxLMmxDgfkEGmp7KcLVHW4KnxSOX5rJNjA
 3iBg5OJizrVhMTcssgBn7B30+x8F0ByD9ENWrPDN/xqIQmxIzXpgejc60bvOk42n6JtabcEV3xS
 3jPDUAIA=
X-Gm-Gg: ASbGnctf0BLnOeDUDLa+fmH+3S8DEsSy8A7WeegtfIbLavIoxWseWTNx/c4Vnv1HuVq
 KpkVL9HW/N8tDH0Te3E9yIHwg39OkB+LDmjf7bUkfjJM94RkSvOlom6mVapS9LI29k41URfS4Qb
 A2mF5Pkkh+P54Y4YD2N5V6xJZn2KWtiwq2AecsqDSo2QX+Emt3yrL9KEHsHZDnvKHosWWQBx0tb
 elB2p9JwOCx3m5AlI9AVDqiNnu+zp6YD0/bNnPAFnEMUdUnnSVNcIFpEkzjd0cciapVEDs2FvqW
 X21Klfe3fsynuYRi1UMGkY+RnuqswTEBDYShTSG+0ggP/Gy4rldJODTXYgl2xRwjePt+GqF3GmW
 diiB9g4IAuXv0JFMc4IeGYRmIrRPIq4q5A3G99s6xI7OVPzVU67kcPydl13lx/IOGACLea6WUgC
 r+T2Uco7qNakVRGHEJhhd4CgNixZ0/7GRlY4/4hZjTY1/zkDHqZg==
X-Google-Smtp-Source: AGHT+IH7uFP2VbAwVOM4jvgZOI8OcnuQri3rTPILars/XP8JloR9dg5JJpRLnjtpmhZBeq5akwoqNA==
X-Received: by 2002:a05:600d:630a:b0:471:1b25:fa00 with SMTP id
 5b1f17b1804b1-4711b25fd7cmr146316775e9.36.1761332936522; 
 Fri, 24 Oct 2025 12:08:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d269dbsm87481825e9.11.2025.10.24.12.08.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:08:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 03/27] hw/sysbus: Use memory_region_name()
Date: Fri, 24 Oct 2025 21:03:50 +0200
Message-ID: <20251024190416.8803-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MemoryRegion::name is kind of internal. Use the proper
memory_region_name() accessor, which might return a different
name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index ae447c1196a..d33be6b2b52 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -154,7 +154,7 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
 {
     for (int i = 0; i < dev->num_mmio; i++) {
-        if (!strcmp(dev->mmio[i].memory->name, name)) {
+        if (!strcmp(memory_region_name(dev->mmio[i].memory), name)) {
             sysbus_mmio_map(dev, i, addr);
             return i;
         }
-- 
2.51.0


