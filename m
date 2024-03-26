Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF714CD1284
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp8zT-0003fA-Hk; Tue, 26 Mar 2024 11:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zS-0003e5-8w
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:30 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zQ-00018g-R5
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:30 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d6dda3adb9so21223081fa.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467926; x=1712072726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDRJxqQMAhWnh+G5jpK8UG7ljcyYHl8RJLjLiMQKlpg=;
 b=NGt7zk7NnvkLiO+rmxYS7RMgb414csV3Ce7YRpBUytr4vqQ6harrMRHoCRHpYzgSnP
 ve4OqizHNcnjwLv/LNyIcvteT4qwfM8Lzn/lzNoD3oWMVBLiA9QrdyoxzTcJDxX5jgDV
 5G9ILGB8IsJDu0rjmGu+De/91OHsaN+pQ45vHPsvRiIDgimbtzbuP8I7wy5aleErE266
 QnjP+F5RBoNv7J714TDXZxQbqp88Gu+30ffj/33LxptrLWJrMKlfkZS9IRd3K2Z9r2YX
 0Bo/tBlmt3ouLtslQcBNfTg2R9XSl3p38MoiD4UVKm7MQ1YLTAefEa0tri7gjrJOWcmC
 jwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467926; x=1712072726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDRJxqQMAhWnh+G5jpK8UG7ljcyYHl8RJLjLiMQKlpg=;
 b=s/nUc19k7sbNIWVfGbYIEVYMbX1Gs6Ba+06DqEYsQHHi1R1V6b7subeszsm98sRBkY
 qZwlTCveZETRN71ChUPVij9GdhIkfD2URO/zQKTZywYkokxK5CFAAm0ljix0wJcjYjU2
 syGxM3zSPXjJMoo9aABUMz5EQW2NRGok9LvPcy7yQxptDCEHw6gPw448BeLOkp2u+Y7k
 xTIYF1g/nTvj5bSSwjV4pxayg2mrH9m/dsMutJP20+LcR5r1goHNulfdminyPFSm30oa
 b+ssxar+e7UtFCjFu4MaaZr+5kdURkergzWDdw6fbH/X/N0zn2c/lYS3ciENBuU8wmVm
 7t2g==
X-Gm-Message-State: AOJu0YxGbi/60nkU7nv5h7Zv02BGEhPqX3e4UqZd6bkLrO24V/fL7wBB
 8zuWtheBGq12rfG7sx+DN9Ewxfpq+Tv0oMn3zltZp/19jqqQAiOb0eQgxBUs2vGtXSFAyBpvs5K
 b
X-Google-Smtp-Source: AGHT+IFqE/msHvMueVXJSeWqeznaanf64OTWLSApiWnDNA5v58x32u5IKEF2KoZoc6z5RuTm+RYh0A==
X-Received: by 2002:a05:651c:b0f:b0:2d6:a2cd:bb8c with SMTP id
 b15-20020a05651c0b0f00b002d6a2cdbb8cmr2493212ljr.10.1711467926018; 
 Tue, 26 Mar 2024 08:45:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 hg9-20020a05600c538900b004101f27737asm11836235wmb.29.2024.03.26.08.45.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 03/13] monitor/hmp-cmds-target: Append a space in error message
 in gpa2hva()
Date: Tue, 26 Mar 2024 16:44:54 +0100
Message-ID: <20240326154505.8300-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

In qemu monitor mode, when we use gpa2hva command to print the host
virtual address corresponding to a guest physical address, if the gpa is
not in RAM, the error message is below:

  (qemu) gpa2hva 0x750000000
  Memory at address 0x750000000is not RAM

A space is missed between '0x750000000' and 'is'.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Fixes: e9628441df ("hmp: gpa2hva and gpa2hpa hostaddr command")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 9338ae8440..ff01cf9d8d 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -261,7 +261,7 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
     }
 
     if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
-        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
+        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
         memory_region_unref(mrs.mr);
         return NULL;
     }
-- 
2.41.0


