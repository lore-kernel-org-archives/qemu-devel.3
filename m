Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22179C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9x-0007Lg-0g; Mon, 11 Mar 2024 15:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl53-0003PK-2C
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4u-0000N7-Qs
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:59 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5131c48055cso4854512e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184369; x=1710789169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A59mPIOzxW832wrj7lv9qR1xuPqLZ/08WFi3vivBPC8=;
 b=KxxvvvXaEgfCf69n2HPy1ikFwOA9GWxtlvMwh+bdzolvDUdnf8McL21+I/aJiReaqo
 4p0ddrfgDTAFam547eBxZ3X9jv1LZfWEGnbA2Ffrig6Ak47TNxHDtTHKC3UHZFINQT2a
 xX6rpaOMYrol0Xxga99Hew5Iio0NaKEEazgJ2hdtS7W2BZv2dmyZVAKdE+WdMbnLP6e3
 tyNdON9cIZkeL3LAIjXWMOCyOco9JCMuDWHJ1CCradP7pVjGF9Ma6V3cLYezMMvxBN8s
 sbI8jR9ZIIsLFmyy2GuFuUDdfzCuBGGsFYh13gRlm0lUIe5QCjXLWw/C38xC/PT22uF8
 Q5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184369; x=1710789169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A59mPIOzxW832wrj7lv9qR1xuPqLZ/08WFi3vivBPC8=;
 b=gOvwWtHeBBTnaQ3YQhkbPq99jVH7JC6CNzIP92J1oI5OL7t5H445vZbuXiTVO6Fpf4
 m+FxJX8ZcJqxuiSPGuinTHs9tTT0Gb+HGi1Xkg7mLGPkjgQeOborxEyh5JdC6Ea0lFP5
 4sS6lO7vY6inSgoKXpR8lhfm8ncvyG49DqxPLOReHDEC82TtOiMqhS6HaJ0iVCBiAygF
 ZV7w5KyFIWIal0mvebyb9BMSmwbWuSPFjj3j75y4i33cqq0PP96Ndlkwa5yrOzZE/vTj
 VtP3AxuM+LNMw8w4BMukLuuLmoW/rvmd/4AwxfuKtAUjgaBLS/AZ1h1LuD2WA2E4Zgy3
 QoEQ==
X-Gm-Message-State: AOJu0Yw5Dmmu/QQkNVW9AnWpNoJ51KEyatxvX0thxYexafN9tMyDvTTn
 1hpOI+XRfST6kLnX5RtTozXEUFNvMKIXQBu/exJxBvxxQU1ZMxaTCr2iSNgZ2YQCKbh/9AB9Iex
 4
X-Google-Smtp-Source: AGHT+IHdr4RW8zTJJTsh7MfdPEoyH5tXSF1I6bJo6z6bDB0UYUTmp5KLFcP4/Pe/ly3dh8HG1zKOhw==
X-Received: by 2002:a19:3855:0:b0:513:506:219d with SMTP id
 d21-20020a193855000000b005130506219dmr4371888lfj.49.1710184368783; 
 Mon, 11 Mar 2024 12:12:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] contrib/elf2dmp: Ensure segment fits in file
Date: Mon, 11 Mar 2024 19:12:34 +0000
Message-Id: <20240311191241.4177990-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This makes elf2dmp more robust against corrupted inputs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-12-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index e01860d15b0..81295a11534 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -88,11 +88,12 @@ void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     ps->block = g_new(struct pa_block, ps->block_nr);
 
     for (i = 0; i < phdr_nr; i++) {
-        if (phdr[i].p_type == PT_LOAD) {
+        if (phdr[i].p_type == PT_LOAD && phdr[i].p_offset < qemu_elf->size) {
             ps->block[block_i] = (struct pa_block) {
                 .addr = (uint8_t *)qemu_elf->map + phdr[i].p_offset,
                 .paddr = phdr[i].p_paddr,
-                .size = phdr[i].p_filesz,
+                .size = MIN(phdr[i].p_filesz,
+                            qemu_elf->size - phdr[i].p_offset),
             };
             pa_block_align(&ps->block[block_i]);
             block_i = ps->block[block_i].size ? (block_i + 1) : block_i;
-- 
2.34.1


