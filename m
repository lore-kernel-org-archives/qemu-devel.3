Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE90C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCa-0000fj-Ly; Tue, 02 Jul 2024 10:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeCV-0000Cg-4O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:46 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeC7-0008Ke-88
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:40 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52cf4ca8904so6958824e87.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929355; x=1720534155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvsDqyOLxb1We4xAO26ZSKOk+5yWllmPJC+X7Ugk7Rg=;
 b=gWkO9/D9CN2GiRotl8BjLAwtu/J+BswaAdjFItiGpqxDRxbUSt2rdaAsrCeMIa+1v/
 qRC/IzWuitgjq31nlDHH9Q/UZrySC+XjBP68SZFVuOSOoPfFG83tziOMHQLUaDMkqX9v
 TMnaKjaISUzh4NEsW7FNbvxbvIuiFDxTDPTJNyQ4X4e9xLv/zUnlWaIPpHO6a+QW8C0h
 uX3YuZVVM4ZG1ya11C8dQgcsERYZAwliWEFXCWNqjjYcCoYFwKjFjY75Epf3AeGUtNc5
 6xPr5Bfe/sW/1BIQ4glYpzBP3XhwzzMut1sRZlQwBaf2Ar1FZS1ImQUzCFgdOu6kSHy7
 arrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929355; x=1720534155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvsDqyOLxb1We4xAO26ZSKOk+5yWllmPJC+X7Ugk7Rg=;
 b=Ovmp3LiRlCPpU7p4bJnv3LmGHM1wanM1FF45ele7Ip2/ytYF3sRxXNpVoyetsaOROL
 A2rNCnbM/yL4JxliTj6FHrkIIKaCXmkbS9NM16V0fbQGsN6/hbJm6DxwNVDjPbdhKnO5
 4TpK2HaTB5luijXISpx5X7OBkwPa6+cid4DuIlXiKPQCwdKAK2422OiLOnDa5PAeNEJE
 VVC5L/SnJou/CvD8Arq0ec1KfPYEdqMwi2YQA/pXf5+AVvZ0VIrKUTHu7/WJ39bGNCWR
 170WKK0wEh/meTenDEYaghNRexnBkR/3eKcEd/cI7uN0w0DjRWV/PBPqKZNOS9Hdmg5t
 cNoA==
X-Gm-Message-State: AOJu0YxWzMcuJCjO7NnUJBckdRSIKdlSs9eZvXNnqjFbvpXmSc72mblT
 zLf4NbkgX3kFjFx9Hj54Ga2hex70qce47KvZzA8paBndrvpQQfs+ulvfpDklIg0pzK25Gyi6I2W
 v
X-Google-Smtp-Source: AGHT+IFpqfH5sYVvgaifNTf67R5YPYYOT83w/LYjsVcNsLQWPKl5kgLZ0c3+Y3plNbcfQfYdrL2L9w==
X-Received: by 2002:a05:6512:2255:b0:52b:c0b1:ab9e with SMTP id
 2adb3069b0e04-52e8264bc11mr6428691e87.5.1719929355583; 
 Tue, 02 Jul 2024 07:09:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42588492b4fsm59489235e9.4.2024.07.02.07.09.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 07:09:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Thomas Huth <thuth@redhat.com>,
 Shengtan Mao <stmao@google.com>, Chris Rauer <crauer@google.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Laurent Vivier <lvivier@redhat.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Patrick Venture <venture@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/4] hw/sd/sdcard: Generate random RCA value
Date: Tue,  2 Jul 2024 16:08:42 +0200
Message-ID: <20240702140842.54242-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702140842.54242-1-philmd@linaro.org>
References: <20240702140842.54242-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Rather than using the obscure 0x4567 magic value,
use a real random one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c         | 11 ++++++++---
 hw/sd/trace-events |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a48010cfc1..9443a9439d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -46,6 +46,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
@@ -490,9 +491,10 @@ static void sd_set_csd(SDState *sd, uint64_t size)
 
 /* Relative Card Address register */
 
-static void sd_set_rca(SDState *sd)
+static void sd_set_rca(SDState *sd, uint16_t value)
 {
-    sd->rca += 0x4567;
+    trace_sdcard_set_rca(value);
+    sd->rca = value;
 }
 
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
@@ -1103,11 +1105,14 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 /* CMD3 */
 static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
 {
+    uint16_t random_rca;
+
     switch (sd->state) {
     case sd_identification_state:
     case sd_standby_state:
         sd->state = sd_standby_state;
-        sd_set_rca(sd);
+        qemu_guest_getrandom_nofail(&random_rca, sizeof(random_rca));
+        sd_set_rca(sd, random_rca);
         return sd_r6;
 
     default:
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 724365efc3..f1281aecd3 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -43,6 +43,7 @@ sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
 sdcard_reset(void) ""
+sdcard_set_rca(uint16_t value) "new RCA: 0x%04x"
 sdcard_set_blocklen(uint16_t length) "block len 0x%03x"
 sdcard_set_block_count(uint32_t cnt) "block cnt 0x%"PRIx32
 sdcard_inserted(bool readonly) "read_only: %u"
-- 
2.41.0


