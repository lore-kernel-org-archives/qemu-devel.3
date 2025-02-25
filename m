Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9EAC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLC-0003WL-JB; Tue, 25 Feb 2025 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJi-0000I0-Ge
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:12 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJd-0002It-Ak
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:59 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f31f7732dso36500f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506744; x=1741111544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RSEvJELY/PKgd7UH4JirdIAJtuLDcuhNTTiwDpBwLjA=;
 b=Qzwy9KbKjt5DhFAXkf3piYCk5baEN+jZMBs913EAdmrebB11feX0Xci35pIh28aK6t
 wmbyi8HaeRVNdgpfKFdXMgMTOZeEqBqO5J6XHIQyQY8jJ2+AzNTvorK2C+sGqwmGyf6e
 /kxN+JHgxrZkOeWwolpKIJqMHJ8qFMTAdGxBTDutnFs3QAySLfDq5S/bpaZAStGV4ro3
 +MNhoEj+WOhkoLm/Z3/xtKwgw8hYaddMlzbblA+WKsXKtojsm+XuDn3I2UyhyZXMfC+y
 hmmqpSzBEz1nIfCCjHFGu+x4lJZzAruFrMD7YoLFo9ljFajwfelZt0co/70kizbQsDk6
 RDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506744; x=1741111544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSEvJELY/PKgd7UH4JirdIAJtuLDcuhNTTiwDpBwLjA=;
 b=wn3BuoJSslCYDBHzyGovqVTjeTD8J/hoUNaezcRRpVNnF6zyhxuweqYRx3PcbW+tQS
 BtNJ+JitsnwWAtxcsgM8r48w7R2VmtaFNds+PLzvM4uJ7+/CQaG012Rz7+trPHzu7Xfr
 iRioW+8WKfDG6PBrAkwXKNMgKJ3LVHh1EM/ppkRDls0KM3xQqsYzNH4lrSXXuJqI79YT
 LEbDGd98YnQkZ1FzP6JkZbx3Xqvyy62YWoFqCd4dV82AevMgRwtjd4/av8pMPPOjmldn
 fsPvLL5xPbc37s5yrNGEyX8CB76t3oX2Oy/QAQSdiPx1Z+GK3Hxy6cYIdaoUqW3mMb6v
 +DRw==
X-Gm-Message-State: AOJu0YzPJwAXuWJOVjyJtWuA9/ronG591bm+uUiuU20JU0vFg51Nvtaw
 dOWzXz539mErxhEQdfz1Kz5+pP6a0i+APk2riWSAHHAfQ47yrDzRTFTvG8nnydf575aCYeRebb5
 k
X-Gm-Gg: ASbGncvQJp3kLt/YStrh4Jl6XPpxrYcRXZOVciBXcj1etbC10sWYpKuokRpxK6A3xju
 uuZ8cyrPGH2CqHFzEAw2vIqHlIq5YJTeYr811TqMvPWmkzfK3uKac98TbAue/6MUM8OFIiV9X+O
 nJag26sgtR5n9uX6RacONc0B29MapT2NViqGfQsH/tbN3cYlpZ1PO9lsRt5oRkdWhK5AiSuqsmR
 5hohm7AWjkKQj6/6NX7O7RAw86b8q9VSzIULuM8oTQk5SJxu9rFvPcieZNFpMVzSatFRSoaFOD0
 VEHxfrlKpNz/m8+PiWjVyankATLF6Ukh
X-Google-Smtp-Source: AGHT+IGcNu7t4gyIYpSDaTtju2/XlBFGWHBsJLfbnoZ656ZA7BC5pRX+a/mqjL2r4UrVq5J8z4JOOQ==
X-Received: by 2002:a5d:5f84:0:b0:38d:d8c0:1f7f with SMTP id
 ffacd0b85a97d-38f614b6817mr16251793f8f.9.1740506743090; 
 Tue, 25 Feb 2025 10:05:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/43] target/arm/hvf: sign extend the data for a load
 operation when SSE=1
Date: Tue, 25 Feb 2025 18:04:52 +0000
Message-ID: <20250225180510.1318207-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Joelle van Dyne <j@getutm.app>

In the syndrome value for a data abort, bit 21 is SSE, which is
set to indicate that the abort was on a sign-extending load. When
we handle the data abort from the guest via address_space_read(),
we forgot to handle this and so would return the wrong value if
the guest did a sign-extending load to an MMIO region. Add the
sign-extension of the returned data.

Cc: qemu-stable@nongnu.org
Signed-off-by: Joelle van Dyne <j@getutm.app>
Message-id: 20250224184123.50780-1-j@getutm.app
[PMM: Drop an unnecessary check on 'len'; expand commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 872a25be869..2439af63a05 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1983,6 +1983,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         bool isv = syndrome & ARM_EL_ISV;
         bool iswrite = (syndrome >> 6) & 1;
         bool s1ptw = (syndrome >> 7) & 1;
+        bool sse = (syndrome >> 21) & 1;
         uint32_t sas = (syndrome >> 22) & 3;
         uint32_t len = 1 << sas;
         uint32_t srt = (syndrome >> 16) & 0x1f;
@@ -2010,6 +2011,9 @@ int hvf_vcpu_exec(CPUState *cpu)
             address_space_read(&address_space_memory,
                                hvf_exit->exception.physical_address,
                                MEMTXATTRS_UNSPECIFIED, &val, len);
+            if (sse) {
+                val = sextract64(val, 0, len * 8);
+            }
             hvf_set_reg(cpu, srt, val);
         }
 
-- 
2.43.0


