Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4982CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2R4x-0008Di-Ic; Thu, 02 May 2024 03:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2R4v-0008D1-JE
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:42:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2R4t-0000Ir-Gr
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:42:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34de61b7ca4so700823f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714635721; x=1715240521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uJqQFQLxnDneJQpNwePbjyQtotXX3ciG0fz6r7EnZkI=;
 b=BOeuon0KpcB/2NusDzgya7gRV36zYV8NiblZBvjvArI7CMzfCvoepBpcIHF15kiBCu
 lXAhyuyeYozCFedk8ikU8haNaQeMB6okb8a3R5Cb5wIft0Ue+Yl+Ss/mfe8TLOw8MSYH
 TplMSurF5D5X2nGJwpEjA//Hp7gFwIVAtEcCTenZgmwatZf8N6dXQIXVMy5KNuYcBFxH
 AT56i0rdKq3pFS2rF6z2GIr0+DnUVzmqNDfNfs2XSzO/Ba4Gyl5Sfat/MLqhWuCciQfU
 nY+1nkWWkAsQKAf327GWqX/xHz9o+CfDVPUrxxeJTf728kxTgzQu2Ld3BIv4UEXg7/+D
 kK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714635721; x=1715240521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uJqQFQLxnDneJQpNwePbjyQtotXX3ciG0fz6r7EnZkI=;
 b=WWndejR7aHJ8k3UKpXkuTB7siFoLEJ6+rjEGVFKwi6SqvII2PzTigEu0KP3ObjzwjB
 xgQsPeLiDS/udPgGBK2Vi0CPbbZ32pWrQguLX0nuM9pjOsv1mt0JP7e0k3cUKX97bifJ
 1GT4ag/04hVWw3IKfdX4WFBxeNkwj7DhW+OiY78VKk34HXm8Hobbfw236tzR6VT+HLDv
 A0NV8LC966BnjUfKYWZxH64Mu7HR35602dRuoW0FCsg5ZtTPojXYI/4UNSzlUBmTalHJ
 tKfC8KWU9O9E5gh+MK24MHwFxmEpBKr09utZWWxRgOISupoJopy9HwPKQOTVXr/RrWaC
 bQJQ==
X-Gm-Message-State: AOJu0YxGKfBYC/ldedMyFBTDXs09Ad/eJCmw63rqg5ucB2hR7HiaWL3l
 GKUF/Yk7yINCBXT9B014NWC42ATGdttiRThwwxvhr0/Fo6YSbDc+ngBRhsB955kT7zyQo6pM+9X
 Q
X-Google-Smtp-Source: AGHT+IGfqwAWToqP3C4WtRycIOROP/6SCh3cnTGtwUCaAaemV+q7UjF022wAksQ1sPQFcPcGqLIW8g==
X-Received: by 2002:a5d:6ac4:0:b0:34c:fa17:f4fe with SMTP id
 u4-20020a5d6ac4000000b0034cfa17f4femr1168832wrw.21.1714635721145; 
 Thu, 02 May 2024 00:42:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a5d5917000000b00346ceb9e060sm556455wrd.103.2024.05.02.00.41.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 May 2024 00:42:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/input/tsc2005: Fix -Wchar-subscripts warning in
 tsc2005_txrx()
Date: Thu,  2 May 2024 09:41:58 +0200
Message-ID: <20240502074158.85800-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Check the function index is not negative and use an unsigned
variable to avoid the following warning with GCC 13.2.0:

  [666/5358] Compiling C object libcommon.fa.p/hw_input_tsc2005.c.o
  hw/input/tsc2005.c: In function 'tsc2005_timer_tick':
  hw/input/tsc2005.c:416:26: warning: array subscript has type 'char' [-Wchar-subscripts]
    416 |     s->dav |= mode_regs[s->function];
        |                         ~^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/input/tsc2005.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 941f163d36..fa93eb5d25 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -406,6 +406,7 @@ uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len)
 static void tsc2005_timer_tick(void *opaque)
 {
     TSC2005State *s = opaque;
+    unsigned func_idx;
 
     /* Timer ticked -- a set of conversions has been finished.  */
 
@@ -413,7 +414,9 @@ static void tsc2005_timer_tick(void *opaque)
         return;
 
     s->busy = false;
-    s->dav |= mode_regs[s->function];
+    assert(s->function >= 0);
+    func_idx = s->function;
+    s->dav |= mode_regs[func_idx];
     s->function = -1;
     tsc2005_pin_update(s);
 }
-- 
2.41.0


