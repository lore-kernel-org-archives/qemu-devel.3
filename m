Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB72BCCD183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 01:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5wqC-0003j3-1G; Mon, 06 Oct 2025 21:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wqA-0003iu-3C
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:50:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wq8-0005cZ-Hn
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:50:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso45684265e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 18:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759801806; x=1760406606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0NVp6FWOpDyQ2aeQ5klk3ElVBvfq+sxzQxdk4HeBQgc=;
 b=w6UEu05GkzuVWXJzylF81nIfkWho1aKQl73Asmr1sOPXrUvAG4qIxVvV6fOCxtzvFn
 revXCF6WCgTE0Lktrs653WYxdjcJDK2b6Y5FTRXIol3c5tG4UZ+81fq2QaSG7iuY2TrW
 UmTJxWTsgzGIgUmMAYqcbFvLdU5kGRaPbjX2Xo5obJyFShOoZJ1ja7pBhIxCV2c3XXro
 CWFkvhK9qIHywrKGLfC1ZkJWx+Z0JEc89rOd89hTUU6MdPTUhLiDNDotYnunw0/fLknM
 /JlGWX0daKyA2g3ZVxpJciZ4swXvq9G7ZQu3KHeYsx8LF2F2knAl3h/JytkAcbY1fKmb
 W72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759801806; x=1760406606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NVp6FWOpDyQ2aeQ5klk3ElVBvfq+sxzQxdk4HeBQgc=;
 b=wkIuH9UpaTditxiAh9CvOH67Aiqlzh8kkLn7R7T2uvB4sF35rWudprXzHu7V6Qnj8L
 QabE8v0ku20vdAxTVzwz7t4IsXO3TWdfIDtlkhfv5NmZ/gpKbOh3FPUZQTNZL1BVH7gJ
 hCJg0q8obomfccAmRUmfAyVkiYFztpcOuNR9tMV/PVVfbOnUZjyykbU46UgY7a6O/hLc
 od10boFUq3/QWJVvotiPfxV1x9CMlZjnSy39oCdQnj2weTudsWSLhqZPzd/JGsDsscoJ
 uu+rL/x6+bXdnalEoF7ZNK8mmxD0fTYCtHsWyBngJS92VLTJN82aIOnXZXtsLOwQjGoG
 tOwg==
X-Gm-Message-State: AOJu0Yx4dV913+z+CDdmJSVcyIWeqoKnnHKXX9hw2/uBYlf9zEdDgxmV
 KWBREpOA9rODpl+AdvBP6bwWALhtp7EOuyljqa6lodetwxOEDHvMyUpjqiQBR4nfq3xMnxW2J+G
 JP56cmpI7rQ==
X-Gm-Gg: ASbGnculxrdIj+FIzEgII+wTFq7BeFTCgDnehx7knAkxPEEpkAnjUuRn5H6yfERqEdw
 O98Y+poqLIC+ZH9/DhfDiK9gK2NWY2BAosWlQ7AXll2xe0ToX+lNYQYOpujCmadAYO9hBrbmfCf
 g8+Xv2BdfzK9vn93uZGgkWkaM7c60kmTYZyPJ1Si4bIo6pU7F/vhCEXrsn1cTveL1K/3pyx0k4+
 sM0ReSh6plDpPDggLDGpCOdYmwrhnY4NKWYH+cjTjT3dNp8fJwNC/LesB1DzRyIReSVta1Qkyuw
 lzopp00gPyX3+4foPL9iLTkqQMXsIWftXgZOWbsix7eHi1el1qABqDxc9LHlUKYU5+arFPolXbk
 qbplSfI1s3Uifk9j02XgOpqbWLVHPUlbwcnrLdEU0/7f7nISMpfxt8aTtPvcPoYVbJV2SJsOfWe
 aWjnGYQUyfnyIoDcM7VHRtCeyr
X-Google-Smtp-Source: AGHT+IGjEi1w+bPDd5VrQDxgg/hhsu+Z0FQxiF0NE1Syvbkt6+mWTPnBX0XjMqJ/5vu4Cuz9GzmnJQ==
X-Received: by 2002:a05:600c:5403:b0:46e:6603:2ab0 with SMTP id
 5b1f17b1804b1-46e7113f4bemr93677965e9.24.1759801806477; 
 Mon, 06 Oct 2025 18:50:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723591fcsm180508335e9.10.2025.10.06.18.50.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Oct 2025 18:50:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
Date: Tue,  7 Oct 2025 03:49:57 +0200
Message-ID: <20251007014958.19086-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007014958.19086-1-philmd@linaro.org>
References: <20251007014958.19086-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-10-philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2a85168ed51..256761834c9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -788,8 +788,11 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
     void *ctx,
     WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
 {
-    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
-                           ma->Direction);
+    CPUState *cs = (CPUState *)ctx;
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
+
+    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
+                     ma->Data, ma->AccessSize, ma->Direction);
     return S_OK;
 }
 
-- 
2.51.0


