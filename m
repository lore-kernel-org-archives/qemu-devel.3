Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B550EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagwt-0004VP-4H; Tue, 30 Dec 2025 16:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagwr-0004Un-9z
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagwp-0002BA-SU
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:09 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so103339965e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128886; x=1767733686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GjeIlFrwrxliG9M3hGVWzNWmCSduRcXmwSt0xjJf9vA=;
 b=EGKK9uJon6d1bX5bd86umb8SNHmDo3E9auCWhPeun/4txHoDnL+GxnN97iKsqMAoNu
 Mod/ySSyT9JrBIJfBuFrvvE4LU0rdu2GHJMRygrcGVxdhvn7yiNeIUSFJkzS1u8UQZqu
 WD3bgA9vQLQlwjaih5aLVxTbzEom743gLKiybHNqZYkMePC5A0BS1RwCbXE748aLsFxm
 0/HDFDmFYBa7J6ygtmTBWSC5r7KyB13n5NQxAkPUxw0mn00HHJCQ+cimecnemEJYk0TT
 8JTone1jD0ZMmMo1WQ62C1Qa+Dw3z0vdyMWsZJbs/QSvDEArwh332qGBfcd+zwD2KTz9
 klHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128886; x=1767733686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GjeIlFrwrxliG9M3hGVWzNWmCSduRcXmwSt0xjJf9vA=;
 b=N6/ofET9UQuTVCXDZQQkNj5GBzjabu4CVDM+9B6/2zdfjU+TCyWXGlcc5piTYT+rb1
 Am20q7lqwHq4D2ESGpfn31rTHeAJ3vGa1iiXJ5ILfMScBFVeGtlI73t0QOqlF5LE/e5N
 Tl9g5b/PrT2WuyGKG/0qrUgV237hJnSXebecoBcVV4pfooIECCmh1rqJZ8EOXaYcE/O8
 BX6nVuYKEq8tzM+neqTbXRpTzUCJPguqmNfAR3bRE6AM2s1/KEbAVNE94jqbM538IEcr
 x9HrV4c7+ahyixAzSHp8NYMuGcqxKaQ6s5yzPoCFONwsLOXgfWxwa7zIi0pvja5Zl1tc
 uy5w==
X-Gm-Message-State: AOJu0YxK3RWlWdzcNW/X9DxCjcxzQBJU+XFpzkaZtEEvWvvifiGmWd5H
 x3INNg8NkS0OQ3EZcODwC7oxZWgrN1KdkFF3VhdMuQzyi+tZYiH6Yp+ctViq/538u8OYxdhoArV
 k5bGDh6U=
X-Gm-Gg: AY/fxX6A3PqftRRYPhk57hUuWkW8Y6Gxj+jUgRuM5mlhq/mbMP+8iGeFL16vu92gmBT
 KW2R4XIa4xy/+Bt1zwMYgk65eGofi4tzDBf9a5O5nmuLXGsEYGbgvpnrkwe5MEQyx+3G6/qyk0U
 y3qctHTJTEWw4XoTfPPAhzU5GZVXYBlI94G9vKCeDBC3EsrkPc5gPpHXh1FTd+/LGprSyZKnMPg
 gCsF2XQqFqbulVeftxYZW0b5mcMgPoOjdWzhkdkmUMXAnwmlNOyqoOdwTJS0nRSgk9uUbaF7TwP
 envhSGQffbS/eGQd/wHOP/3KILEzIc7pOPd5DICubPyoVIcBRSHPscNxA6iPFjhB0wDEK6ILKWj
 FL8mlmr+bOBK33g2+qYyGU3M7K9sEmfhWnokRQ42VbHLAO3LaYJxdUOeFZkjxnhY8nq3ifIY/dQ
 a1WZ5OOajScOrs/wDHn1xid0WtYAifXSTSN5OKGYX7lM983L9w3oLvx5lrXPE+vfNTdYLAlVw=
X-Google-Smtp-Source: AGHT+IET+NQM4/QwkDzDB5otrGFvTdqyFWj2l7qfTFDOquFdsuBv87tQNVVuHsgKPt6UystMfTNcxA==
X-Received: by 2002:a05:600c:19c6:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-47d195c201bmr438915905e9.33.1767128885798; 
 Tue, 30 Dec 2025 13:08:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a204e9sm255956595e9.2.2025.12.30.13.08.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/34] hw/sd: Remove unused header includes in ssi-sd.c
Date: Tue, 30 Dec 2025 22:07:23 +0100
Message-ID: <20251230210757.13803-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Bin Meng <bmeng.cn@gmail.com>

Remove these header files which are not used by ssi-sd.c

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251110104311.1640772-1-bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/ssi-sd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index c6e350af2dd..1782fb74316 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -16,14 +16,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "system/blockdev.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
-#include "hw/core/qdev-properties.h"
 #include "hw/sd/sd.h"
-#include "qapi/error.h"
 #include "qemu/crc-ccitt.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 
 //#define DEBUG_SSI_SD 1
-- 
2.52.0


