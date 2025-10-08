Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5CCCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P2H-0002VM-LF; Wed, 08 Oct 2025 03:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2F-0002VD-Ji
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2D-0004qA-VL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e52279279so48484065e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910188; x=1760514988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKcghvRtIB/x4QZ5QnnQf0KA5bfAqUY4z5BaPvWPzfc=;
 b=DGPmc2HtMK4u5DWeCu+K7Fl4XrfuErqr/tEpHITg5x9K/+szhcG+IfInLvf8RayArB
 Y6hFunOalctpYcXYx93xhMJxytzLSyuiICYcpheW0+MURJaV83ohJ5YDuL7S15GddE+X
 3G0f9Un7q5X3TF7zjsJKJnDVBTdqoQkZM7ZCx6N7EJrDlCvquKXjWR03uNhBvmXSAf3T
 S8FYJHd6y3Fdf0Db4/yebu70S96o8CqpG5t51Du+j/WXLtLUN6zQbgnjt8h7vfwV6B0z
 NJYh2IaQUf07PXXaoxzSrr2NseoyV5IUmiB0pNrk3qcpcIIA6df0L2hDwEliwUxraVSG
 UZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910188; x=1760514988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKcghvRtIB/x4QZ5QnnQf0KA5bfAqUY4z5BaPvWPzfc=;
 b=oADOB4Zie82vemK2VJMEvoAhQkhqz107osr70+xOACfWnR4KAoRDkcQ2uChHra3/yB
 HEn9T/p5tqXlu/H0Jj0AjuSBpetMt7pgJ3guCjiI3ScQHtuMt1q/gG3b9F+Fkq+3Ce8r
 HYVAKKlza8AG7TtAAoYXL609XxGeb943cvk0NGrg6wPzdmfUPuRIQkCDf3ZkR0aqCVQC
 eTM1u+Mpa0Ikyh8yYjI0Sm1jXZgWN2PdkXHh+UxMRVnAcmlKUqflJYnRapNwONBwZSy+
 EpBXsk6HiuwKFuNG6TgUeszKCkDq2be0nDzHjuyBoWFLgLHPiUTKpChjM5/KwtI7EbKC
 8QiA==
X-Gm-Message-State: AOJu0YwtIQ6b87CtSFiokrI/WQyFThlvlf6QXzrTNL2gn7HTepHDMxhb
 mLT8nIseMYHwsyS7zbFOuZbnpA7ztShK8dFYfGSySLks1CvRa//B7i7SbQebKlPMPxmrOKks6td
 xrTD2wNMfcw==
X-Gm-Gg: ASbGnctj55gy28Tn6LaFlCJ2ZTzWaCoZxxrlxoYHn9pzU4SxRkvk3kcvWQHiNoJlV9T
 V/BR0ilaY7q2EPa5KPFz/Saql0UMZ07vjhdx/68jgh6hxxixJq3C+uAJN/LJXfbjk6TY8ilqZr8
 Cc/iylqZXL4KiQyHubTRzJ9bnC/cDMqMcZKwI2TgRc8hNgpBk6eyJaojw7bi9Fe9PKahLYJYW4i
 CBsWq/E7XDEetlJGw+pO/6jD5q4zn1hWFyeI9q/55clJMqnrW9lciXu/F1SgGZpVkMoFyOKNcoN
 s2y+B/7nF0Ai7FQbBZSCnWzDv+vREusie0KmNcbrebo+F8s9H4VwsWydgHE6upgPl2gi3uV2fs8
 QTpasVFVlU9B5ErUPF/uA8jFV2NC0eL7wikU3AYBf7KUHoc1xWMpd8AHUthDwQ9xAVwIdmKa0ZB
 gak5LXu0arPXeYgxZj4Fp/XHcl
X-Google-Smtp-Source: AGHT+IE7gpemgwiL/jLKufTzby8LUq4T7/9v1nM+r7/ewmYvKkKVuWkOW6HXAJCMYwUMUO36dWDyuQ==
X-Received: by 2002:a05:600c:46d1:b0:46e:45fd:946e with SMTP id
 5b1f17b1804b1-46fa9b078e2mr17579985e9.31.1759910188057; 
 Wed, 08 Oct 2025 00:56:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e980dsm31162876f8f.36.2025.10.08.00.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] target/openrisc: Remove unused
 cpu_openrisc_map_address_*() handlers
Date: Wed,  8 Oct 2025 09:56:07 +0200
Message-ID: <20251008075612.94193-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008075612.94193-1-philmd@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Commit 23d45ebdb19 ("target/openrisc: Remove indirect
function calls for mmu") removed the last uses of both
cpu_openrisc_map_address_code() and
cpu_openrisc_map_address_data() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/cpu.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f4bcf00b073..87201365a91 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -220,15 +220,6 @@ typedef struct OpenRISCTLBEntry {
 typedef struct CPUOpenRISCTLBContext {
     OpenRISCTLBEntry itlb[TLB_SIZE];
     OpenRISCTLBEntry dtlb[TLB_SIZE];
-
-    int (*cpu_openrisc_map_address_code)(OpenRISCCPU *cpu,
-                                         hwaddr *physical,
-                                         int *prot,
-                                         target_ulong address, int rw);
-    int (*cpu_openrisc_map_address_data)(OpenRISCCPU *cpu,
-                                         hwaddr *physical,
-                                         int *prot,
-                                         target_ulong address, int rw);
 } CPUOpenRISCTLBContext;
 #endif
 
-- 
2.51.0


