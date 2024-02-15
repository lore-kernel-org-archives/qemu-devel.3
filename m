Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C9DC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag0O-00026F-PG; Thu, 15 Feb 2024 12:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0H-0001pf-Ep
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0D-0001Xm-Sk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-411a5b8765bso7195585e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019908; x=1708624708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3zPvVIMcLhE7BLwqgmHZIk2g3tz5ma+i24zz6Qyo/c=;
 b=W4QhkEQxiPRlxEH5qhQ11n83Bcx417vXOO6suJ9noFNTocaJDAFJCQhhEJGiwoHlJh
 FV6dEfVf7kJCPZnapToNKBD4AKuhmuLsZ+roBexUB1KACZXvnug74YLphH9UYENgU4oy
 Pj9Ma8YvJiFXN0Aadt50LrPKokXw3VHRblbj7czalpZki0RUGR2rzCMYviao3oBbIKv0
 R9p4HNZbps4BhkJhsldt+FF/aqnlGFvCYmGjMuQj5NpR8UkCX8WFR5wjiZ7tS89qsXtx
 9W/vV6JK0MSznGpv14WQ1LhJVtNnm4NcVeo68LqW/TdTiQ+Txmod2igldmtEDnKjgnM0
 ozYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019908; x=1708624708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3zPvVIMcLhE7BLwqgmHZIk2g3tz5ma+i24zz6Qyo/c=;
 b=CsDWW0zLP3SahxjwFRVdmt6IyPpBOBChBLUJgDjoQPVm7EMkW3z1wWVCFCHckm8qo5
 HScOvzpxQboWn22ay9nYrF7OSJyb6T8LVWyvePZGsEX0LZ5IuHkXpv8YSgOGGmJQpdT8
 gsbU1/Z4cn8dj9Er90osGNYVamExI8ti3zuY9Xasxxx4fw75f8Tt94iiWEMUrCDasALD
 6ijRlB3wPlbH3uO/GkNS/YAlIozBApBvOa0jKZHLhWLYHjfgo7ll35EEws7frVIDyNZA
 A96ZL3v1BkUIMq/Xw8hVl4BwiIZerp8YMD3fhYo+l1TN8Hr1PTDNIIxOt+LLD38CXUue
 51Ew==
X-Gm-Message-State: AOJu0YyRQzI3B+CYAvoq8QSASjVqp4HRixEle+gYOMVspNOCpVGnhLOh
 WPxPyI1rS+j42WWByFhs8qk5hFXpZb4aPBJBjg2zxlSXLv6FrGY9yl36KXhCJFQtzAqYZ2Y9JkT
 Yoko=
X-Google-Smtp-Source: AGHT+IGL2MjT2Uac/p5rMCkh0KMIc1OnH5CgBsztWPpWb+qXOWq2gxBqVqGeFvdNTomW3Y6hVW/Gwg==
X-Received: by 2002:a05:600c:358c:b0:411:e0cd:9916 with SMTP id
 p12-20020a05600c358c00b00411e0cd9916mr5451880wmq.0.1708019907978; 
 Thu, 15 Feb 2024 09:58:27 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b00410ab50f70fsm5602288wmj.15.2024.02.15.09.58.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 05/56] hw/misc/mips: Reduce itc_reconfigure() scope
Date: Thu, 15 Feb 2024 18:56:59 +0100
Message-ID: <20240215175752.82828-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Previous commit removed the MT*C0(SAAR) helpers which
were the only calls to itc_reconfigure() out of hw/,
we can reduce its scope and declare it statically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-3-philmd@linaro.org>
---
 include/hw/misc/mips_itu.h | 2 --
 hw/misc/mips_itu.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 5caed6cc36..3a7330ac07 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -79,6 +79,4 @@ struct MIPSITUState {
 /* Get ITC Configuration Tag memory region. */
 MemoryRegion *mips_itu_get_tag_region(MIPSITUState *itu);
 
-void itc_reconfigure(struct MIPSITUState *tag);
-
 #endif /* MIPS_ITU_H */
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 37aea0e737..db1220f8e0 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -86,7 +86,7 @@ static uint64_t itc_tag_read(void *opaque, hwaddr addr, unsigned size)
     return tag->ITCAddressMap[index];
 }
 
-void itc_reconfigure(MIPSITUState *tag)
+static void itc_reconfigure(MIPSITUState *tag)
 {
     uint64_t *am = &tag->ITCAddressMap[0];
     MemoryRegion *mr = &tag->storage_io;
-- 
2.41.0


