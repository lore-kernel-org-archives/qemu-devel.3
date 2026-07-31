Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66AEC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpakV-0001gB-WD; Thu, 30 Jul 2026 20:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakR-0001a0-HG
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:11 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakN-0001Il-15
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso562466b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456306; x=1786061106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6IlgMhpUv/jFrsAS48m1RtDHWgLnKH1jFwV+WI6Uaug=;
 b=seoXBSJJQTzS+Yr2Tg0+XNpLUSr8a8HTX8kodp0ed/69oFfEfBMKDcOsoP1lmaP5k2
 +GgyqpsjhDB7zqjIoU/UWUteN3c/9HY0nSgLlOCAwmhUOAFPDvPburfBhKHjjJu/ZV+N
 utQlXhqN2g84Mly9wCaeFnvqW70bm4REDjVh/4Snpds1LOQWLPg5mzmnM6SQq0rFRiKD
 M5D5//dMPJtc4o1V86AdWpgKu/mYHDquQEyiolimrijJMBzdt0lUwkpRFMBr0d7AZH6K
 ZNgr9/hbzpgvRL6rPh+dgN0uJcOifk/TKq+a0eF1Qsa94XUP/JpDgsMkWZ+A0HQBWoiX
 Kisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456306; x=1786061106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6IlgMhpUv/jFrsAS48m1RtDHWgLnKH1jFwV+WI6Uaug=;
 b=MSQ2KJcNu6ZjeNVMhjEfiwJLeMRcCIJzEEk1QNg517WVp/qB3We7Y8+c5XVmGEYTmZ
 fE2jtn059HujFhOJdcj38SaxMFOgeLjQ7MM9E8rm6PIVDvygxH9aKs3kotg9CySQ+rfW
 SvUUJmv1QMFH83zfyg5UM1v+w25qnLL2hwMJLdOmybdCyVx3tGnPQQ2iwAfo8kcljP2j
 TbPlSkWy5aNwhwomlEZAsWCsRWY0v122weMx8qBwqwA6FiNhl6bJ9wt/q4Rr8CWuxdq3
 DZSVYKkkRGVS+2rm7T5ft1zmMcpmG8DGvAp1Fwjn+y5ok/NQief4v1FE5LrnI+vGJ/WX
 1eeg==
X-Gm-Message-State: AOJu0YxB1/EwCtJO467HDSL/mSpee8oUadkshCbISG3aaKMohlsTNLlF
 hmM1P4W5FKn/Ed+OOxrQg49SmwXa/e88pzuAxZGB4NBTEzlXp4TwLRUfetw5NZAZk4QpK2KTQS1
 NyOSX
X-Gm-Gg: AR+sD12vRvY+bM8htUuhDJRStdG9PS1THQHBr1bKe1f1ckW3VyGK1oAdKNPTTG+TzwB
 /kLGZsH2hkvs3AhQbGtUElEriXWjNNgr0HeW75oEcKwEVhoZ2pNVVWaO/qD9ZTuyQIcGQRbyd45
 lhDv9snzsI9lpZ8N82KB3v7nmvwBy6skY2/tJDOaV4pVRUJKWY0CaRQj2xFhNHEMJEQ51stPkIs
 0dOxExE8G1O9te1wy7q/Wt8L/rY9zpaaHtapSA13i0EsdnzbLAn/5lzwtQw1rmdQrB2cdogN/TP
 cfS6Qi8kqwM/sUgO5VhnH+GOthrB1m5vMUJWfFW9H4lGqZkSKGde3mA33IgE1BRUee/nAInaqfW
 iz6wKQ2SM9hxjquCCrs2YrloDsSc+3S87m4fsAk9vxYf/OCS+xSdKTYRDWzzv1dWaWlc+hivLjO
 werglzrdwoZcbcNZE2I42uU1XkCrkvFoSTZiBNQitq1QOD1JN5bdE7E/LNwfApbANVK7IAuRRiw
 vuj5wnvBSyV+FUfKJZE
X-Received: by 2002:a05:6a21:7014:b0:3c4:1c9f:d90 with SMTP id
 adf61e73a8af0-3c9007f13ccmr3932778637.39.1785456305502; 
 Thu, 30 Jul 2026 17:05:05 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 01/11] tcg: Fix opcode dump for bswap
Date: Thu, 30 Jul 2026 17:04:53 -0700
Message-ID: <20260731000503.170446-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We use an array of char for bswap_flag_name, so some
entries in the array are non-null but empty.  Check that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1e77f2365a..e023ee8b9a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2951,7 +2951,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     if (flags < ARRAY_SIZE(bswap_flag_name)) {
                         name = bswap_flag_name[flags];
                     }
-                    if (name) {
+                    if (name && name[0]) {
                         col += ne_fprintf(f, ",%s", name);
                     } else {
                         col += ne_fprintf(f, ",$0x%" TCG_PRIlx, flags);
-- 
2.43.0


