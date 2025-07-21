Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7057BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYy-0008Oy-1V; Mon, 21 Jul 2025 09:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYQ-0001Er-Je
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYO-0005Mf-Ih
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so2163906f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104459; x=1753709259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=USS+LUKtNag6d2eiZksJWjkEukkIMnnF/u6m6cyUqYo=;
 b=R6u72qwUMv8RihgsQd/qAcnNe79FNnGs8CHgsjBO6ke2hrXyn+Zw8wNjwDKVLFAHGI
 tk1IL8jNWZ4x04kOYnKKzfZuOZinXQbh+0tklCHsfa1aFzJxU8ThVU1hkSWHe5aX2PuN
 3z9KnsSoa5YI2T4c5D/WjNM+lde/1ixCuCK8G6u50OjEGX3JvtWW9gnyD8HauSbHkQy8
 QLIeHPsSTb12V3juZQIxowCjEcK7hFoRaBtQEferbmYV2TD16z3F+NrtNEs9HDWfMrXr
 R3lO3mnxR4zEqknscHrvFi84inWWNb2b6bCzQI4XuLQ5f9lLLtTi/T7Lqpj87lfta8ei
 FF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104459; x=1753709259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USS+LUKtNag6d2eiZksJWjkEukkIMnnF/u6m6cyUqYo=;
 b=auviRtJYujfV3V1qLGwIdpD8we0ZYe9cTxPxAwM5S2EvxdhLzh/txRLSUMq9ElAUSQ
 1zBINnKHrm76Ssp/mPU9jf03oyPx59Nt2I6GsmDeLULxBE4WUyd5pSdeMss0mpSsA7n7
 8t9RYJlVcHGM4Yl4UGW88m8dkLR7ok7JK+Z8wEjBoQQ4Bd7rlgyv9Qo+EqKWPKfzH24w
 OULHTAdi99+WCd5z36+lagpJrscaESSbYQNfYrS0qwCTxCsCkUWiJOhNLM8Phvc7H/nZ
 6GPyeOt5y/a6yLzxBr/oXT5MS9FKMW7cSpfMDMS8w1dTNUEsoxHhFq+3C+89cL9/iR3F
 LCzA==
X-Gm-Message-State: AOJu0YzjZ3kOmOT4BCWXlrR8tbNq1ttxE2KXBMHQp7We5L1KE1dLRj/q
 JrTbpA3NUF7k6dJOg06NN1hE6Cbjzci6TrxeSqnYv8MdNh8ZHmb1tMX85FL+4QQqKVT/o9z5rHC
 cvEFc
X-Gm-Gg: ASbGncsAEOzqFTh0F9F2K7LgRmjk3TwfPqzM9/bmQZ3Pt4tBkKueB4ytiJSrPk9FRHB
 NFZoeXslzzZbFPJKqcKY5Ki3jlbwogr5yXhuX1nLk3rQQOaloToLQILxc2BomawEFRP95EiAI4V
 7Us9aprwESiufkBibv3fa0NHar/RNEI6LeUaocjFC1lHIlR5DYpp69AQ5uBLchLqsEgHTZkfmk4
 jaz50EdxulvhSL7/rQskEQSOcZ8skoI1ZVbnoSrZsUB1fyy4NufBvFU0QWsBkFCsVfd7RdOU/tK
 Q727juvy9IhSCEiHom0JTfQnZFYWbmLUmcG5vZw4PpeF8TowsS6pBOSaTVbuPiYy1vJpWEBGEvX
 XOVYQlsnGC2Mt+Ta18Evn1FvtMNQ3
X-Google-Smtp-Source: AGHT+IE7T+5iw4yqfP1wLfClW2d7hvDfQYf9fXISShDBLngPoDTdEnLrXhO04RJIwLdy6y9oWx/Xag==
X-Received: by 2002:a05:6000:2002:b0:3a3:7ba5:9618 with SMTP id
 ffacd0b85a97d-3b60dd95c7dmr13989090f8f.29.1753104458755; 
 Mon, 21 Jul 2025 06:27:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] accel/hvf: Display executable bit as 'X'
Date: Mon, 21 Jul 2025 14:27:17 +0100
Message-ID: <20250721132718.2835729-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Developers are accustomed to read RWX, not RWE.
Replace E -> X.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index e67a8105a66..0a4b498e836 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -84,7 +84,7 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
     trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
                      flags & HV_MEMORY_READ ?  'R' : '-',
                      flags & HV_MEMORY_WRITE ? 'W' : '-',
-                     flags & HV_MEMORY_EXEC ?  'E' : '-');
+                     flags & HV_MEMORY_EXEC ?  'X' : '-');
     ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
     assert_hvf_ok(ret);
     return 0;
-- 
2.43.0


