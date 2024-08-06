Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653B2C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJhT-0007KG-NU; Tue, 06 Aug 2024 08:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhN-0006t0-NO
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhL-0000Jp-Vl
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7aac70e30dso58972166b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948832; x=1723553632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOLg5Vi3ZKfkY84yToih/WZzzIJIKq2Y34KfZXOpYeQ=;
 b=no95ZLQvcosJocWsWEj/XtQfQt5OhX5b12WmRhZDr2TQi/p5Eyh94yXljaFqM/SMVs
 upFhbVVwfK+Pj02lYbLGR3IDWzdHB/NKKLITYa6mDZCpBLhwhQP7gBfQnfiW9e4l79F+
 4wERMAefTaPLv2OSSkbY0X+tCyAxIGNkebVBX77O9Srwnmqlxu6jJeoOqb1OH6Ry53o9
 OVi15bmJuHQ42fGRHQG0m2ZXIN9XgXBXLJha+l9mkFGJE8UU4+f0WDYk2PTl2sbfFpMj
 JbaJOnXKtsBPMexIDO0+IbDxl6vZf/8a70L/SbLU+YKQ+FbCJf1R5BHyqB3hlKjYnIS2
 2W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948832; x=1723553632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOLg5Vi3ZKfkY84yToih/WZzzIJIKq2Y34KfZXOpYeQ=;
 b=bx3JDFQ8FzvKpgiXlYc9Mc1cHATT2ZT1vMSSmS06R6Pa3cFPXGFsEw2MgmtWiRqq2m
 t4J9uq8A1EvtIE1UgKNqgxIGHTbLsREjMb4CwV9+gYDZFIt6u9WvLokldTMC0etLesvF
 zdvl3BKpWdVkF5luUbvw4rwmYi9JErQa/uEUbZBI5dTrrplZflc3pTKa8FekMJfzZWaq
 Mme+FeRpns9LYlrcojLHwFX2plrwnKoeLmG5w9aRMmsfoKlnKhy/V6BhRX7WCvKe4Q9F
 rEZorkcyv2nUqYzt43UBUAmWEbvm6H9nKkHL2zBeZjoxrwKmTdz2gUuD2Yxab2cQA1tM
 g0Hg==
X-Gm-Message-State: AOJu0Yy20wbC31CQh4y1I3UwQHy22aBh8u3iBu+7/xiq9n0z8w6qa6O1
 h6kWiJZubhAVdzFgDgWVELzxpuUEsblPowskT2aSjmVRqavbCjTlmIsmAYKKRF8JlUVsniINkjR
 k
X-Google-Smtp-Source: AGHT+IGRaM4WMc9qgogB5AShB+bzTSo/cHkQ3V4A+4cH5o1QooY7YebFilHRAhzKUkqJtd4l6SCNXg==
X-Received: by 2002:a17:906:d262:b0:a7a:9f78:fef with SMTP id
 a640c23a62f3a-a7dc5179f86mr1164585766b.45.1722948831676; 
 Tue, 06 Aug 2024 05:53:51 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0ca00sm545543866b.68.2024.08.06.05.53.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/28] hw/block/pflash_cfi01: Don't decrement pfl->counter
 below 0
Date: Tue,  6 Aug 2024 14:51:46 +0200
Message-ID: <20240806125157.91185-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In pflash_write() Coverity points out that we can decrement the
unsigned pfl->counter below zero, which makes it wrap around.  In
fact this is harmless, because if pfl->counter is 0 at this point we
also increment pfl->wcycle to 3, and the wcycle == 3 handling doesn't
look at counter; the only way back into code which looks at the
counter value is via wcycle == 1, which will reinitialize the counter.
But it's arguably a little clearer to break early in the "counter ==
0" if(), to avoid the decrement-below-zero.

Resolves: Coverity CID 1547611
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240731143617.3391947-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index c8f1cf5a87..2f3d1dd509 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -614,6 +614,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             if (!pfl->counter) {
                 trace_pflash_write(pfl->name, "block write finished");
                 pfl->wcycle++;
+                break;
             }
 
             pfl->counter--;
-- 
2.45.2


