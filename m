Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C894CCCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x7K-0003RA-Nw; Thu, 09 Oct 2025 16:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7H-0003Qx-FM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:19:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7F-0007L7-Cc
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:19:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so11685605e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760041194; x=1760645994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgE+KmUu+8asGstagQ07U/gni/InJ2CL8fkkZbDftqg=;
 b=fJpTHzHy4zPcEf6W1gu8JJyYDZTZokGUiFRjfGQ2HIbqOoT23poj8iJLZgdmEO1Hko
 lPYRPHA58dQoz57hyZG6rtHco8FSNmoXC4Uxz/UGxFsUKB5Ff+WeT5GNXsr4xnlNCiSe
 l7kEjW2Lq0DbgznU+Is/NfN/lfJuNE0Aq+zdCbsaLhSbllso33sPW19pxCvqY2jiQpmb
 1BkDNysNtvQ6TCuL/qPNShGTOCs5jyNBopyWvRcpURO/gSYLGKFbXh/MU1EripOYnUqM
 iiVg4FP8Tp968OtHDKFyYgF6+ddRVXdHfyZnEwe7CClKp8kJNWvibxWV8qK+X1UW15Da
 eXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760041194; x=1760645994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgE+KmUu+8asGstagQ07U/gni/InJ2CL8fkkZbDftqg=;
 b=Wmg0nZTiLWyECpRcj3/UKGVzFYw8J+0Sbv46M5ORJ2BNUzMo5o9Kdye6zT7lDmqkmX
 GaY29g2tlYA2Yxm3mMUPKDg+pdTiHkCpuCLAcbdxH8XwuNopXoK0LF3B3ztuSzp/k6pz
 WDsJ4JZzjtEyYN6CJc66BixX0MgWR0wXwNUE80+x6qGNrlbGR9D6bwxe2Cx0OJ36Js8x
 tp+GuZHpI0gIU7Iy7d50ODxCUTDxEzU91DWrBUfqoqbHv9DHonWwfPDq2oLkhPI0lFaD
 MaEZVSKm4nzCAmmjnQ2bFLZWPTYGyIQNLdvr0v78yr1nA/zEQ/o/IesOSA6yYrmr+TFQ
 +zHQ==
X-Gm-Message-State: AOJu0Yx+o9bsAxtuwJq2JgrN95qbhrb0J7EP+KC6mAxTaasp48sntwjZ
 EVtAJRfy+v2PonPb9usuoFHGrM1WzbIGfgW0mi4FCh258WjnZQc5DVI1ea4+Hw7SqC4+tAj5WXK
 +YOqarIa+Xw==
X-Gm-Gg: ASbGnctAGOw9YcNpzRNqa4uanehTaFtqVkR9zqagArB/CElqraU2OzXzunGaY2lENUI
 o/HHP++rkANRzt5qXp/XFvIn7VjY6thXbUgmOKvUFExa4J7uDNbwMkmaJvDCiQ7eyylnjGz474/
 pIJZhroZj9GcFrJ6U9HVQZVqgbOFyXfz0fMdwlMDIMmL/mPh5uLY5cBNfy/22YKSKFKzLOMPhaY
 e0H5wUaRQADmkBRYFtvu4QQ/3qlPGjsKCeLIDiiIpONon4fw65aMEtP/brEpEIFMlDdqriwNWcC
 doUef47UaBiGO8QNNgvYTgBgQg/p/lnMF4MAmGlgZaq4JPMN8wzjqtrd3HeemIOCidnRossprdd
 RPXl+B/zWMt7z19zr83SFx/FIZgK6y20JStRHbNGigzGbGUE/EasStWRvpKuYjaMly8MTGWgLwd
 gIHwC8YtvktREOJrNNfdxTE7mH/mK3Pei+v84=
X-Google-Smtp-Source: AGHT+IGue7uS7sTV8x13qSPKyfphTzUmnM0o0QXbckQ/prbU8hrPG7OYIZ91unywxyngz/q4JXvZQA==
X-Received: by 2002:a05:600c:1d18:b0:46e:3901:4a25 with SMTP id
 5b1f17b1804b1-46fa9aef67bmr62823645e9.20.1760041194545; 
 Thu, 09 Oct 2025 13:19:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49be017sm10448765e9.13.2025.10.09.13.19.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 13:19:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/loongarch/boot: Remove unnecessary cast to target_ulong
Date: Thu,  9 Oct 2025 22:19:43 +0200
Message-ID: <20251009201947.34643-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009201947.34643-1-philmd@linaro.org>
References: <20251009201947.34643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Reduce initrd_size scope. It is already of signed type (ssize_t),
no need to cast to unsigned for the comparison.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/boot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index a516415822d..3dd48cb8aab 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -306,7 +306,7 @@ static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
     uint64_t kernel_entry, kernel_low, kernel_high, initrd_offset = 0;
-    ssize_t kernel_size, initrd_size;
+    ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
                            cpu_loongarch_virt_to_phys, NULL,
@@ -328,7 +328,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     }
 
     if (info->initrd_filename) {
-        initrd_size = get_image_size(info->initrd_filename);
+        ssize_t initrd_size = get_image_size(info->initrd_filename);
+
         if (initrd_size > 0) {
             initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
             initrd_offset = alloc_initrd_memory(info, initrd_offset,
@@ -337,7 +338,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                                               initrd_offset, initrd_size);
         }
 
-        if (initrd_size == (target_ulong)-1) {
+        if (initrd_size == -1) {
             error_report("could not load initial ram disk '%s'",
                          info->initrd_filename);
             exit(1);
-- 
2.51.0


