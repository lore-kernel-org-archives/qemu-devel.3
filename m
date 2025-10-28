Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D8ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoWj-0007L1-EQ; Tue, 28 Oct 2025 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoWc-00077N-U7
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:34:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoWO-0004Ib-Lz
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:34:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so4579049f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676448; x=1762281248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DmeGIOtnQgeitCackLcdl7/cs7kVLgAOODhMbDoGJI=;
 b=dlz//2b/LqJ9+l44emJzfc7Ki0c2Rt+fLe1uIMudzuhcnHcKiOB8+KeU+peYtwkR2o
 kw3RgIUWwBd81ellbWlWVhAz+xwr9zIFOqjNftHEkbUEEFNwsXFIrq9TU5ngrDYaztXd
 /YaxG1MvMULNR+6oOBHG4R7+pJqyixrWBOBSZEEAK7UrChBbLmx1N7BkzZtHr8YSA/Cz
 X5AuoAlGm99hknm7ODnyfCqU4q0N2b5c69FOVF/xLsCJdC87R7oO1lG4ZgD408IwpOMW
 nNDI5IYWhY8iwfzCxhhpWOtBeGGoHs5WDCs2+HUmxDMB8CYiNwEt7F3EmVy1HXsiMTBh
 iLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676448; x=1762281248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DmeGIOtnQgeitCackLcdl7/cs7kVLgAOODhMbDoGJI=;
 b=Lg0HLh+aF3t2koUi1eDNiBFrblPB4Wry1whF2z8b8sDpmeddidQwakYsQSp0My9PwQ
 74PMreJYI5LPg2ublH6WvhIESN9DhBEQPxSFYZqB0vy5r+r55hyqdDpISEE9sBqH68nC
 PqTKthDzBGaN/rur1gP3eUcCzSz2kNi16EjzGgKWpGH49pdWJ8E2gxFXsyV1gi66QJJo
 AwG9HEDYAdQwJphMzKvXeIK7QiEqVzGJo7Rv9LRiLHVfw4Yka+ADZf2gflPSJARWAWfz
 LWDcGHyPKSnu/BCd9bKh6Dux3vumrd7Y6+dF/DhudFgOzv5YMOg3nmRqL6FceuMiN/sE
 MuKQ==
X-Gm-Message-State: AOJu0Yy+TB2n5Tcr/PFRysR8t80eGDAF0NUyuay3UCGOKapj3Bz4kqSP
 QcOG2YhDizSbRgQUIflKQ09eh/zExVg0KqHslBAGdvnCZp6/YdbtrZTBgNyyha/aHII2EJ8zAT9
 zfoe/wCg=
X-Gm-Gg: ASbGncvUwnKzh/FuI67CzLj/VxpEgUNibmUfLqH3Amr7Q0eOTsww7hlEG2ZE7lueEcu
 eVA+SjtTAvSen2O7joTLZ2J6IJ78hYv9ZdD4x6mYb4O1cGT+RpCXIOfa9peK8e66lt7+AVNVyAi
 VwitggNa2h9NcxF7n6zpiQ+Nu4vIh8D9uwFmAC8umWv0cMQM0Nn7V16ggNzgGoqwMpt44KTASde
 +HAQF8i0mNpUR9vSpHzXR2NMggTUnkrUFG6n56jWMsBnFXXKD9SqZ5VoNP02Qznulof0gw8Wu5d
 lMg3Nq7Z6Ylu45hlYPtDc0hCR9vc44X1jHe2Mv5avB5mf8BPXoh/Fo/SLhBU0c2APR/v1O9QbjY
 OcYl164hyX775Mwl5ObWyGYYRkKSsHPhsE1NVAD1xMsYOSR4t/G4m4dPRjKxVBLy2Jg7uwcR4YV
 6qXJ0Ia55UUEaNdVEsoI5TaUEsavkiu3xVZWeeh7LcDig0S/dzAw==
X-Google-Smtp-Source: AGHT+IHsIum+c9nT7pG2emhzPJVq5xAQ7ZBeEj43AMtw4RcW7IdMZOY2egDdd/SBNbjY67+SkP8JZw==
X-Received: by 2002:a05:6000:2512:b0:427:6a4:93da with SMTP id
 ffacd0b85a97d-429aefbe0c0mr45031f8f.49.1761676448174; 
 Tue, 28 Oct 2025 11:34:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbb2bsm22064803f8f.13.2025.10.28.11.34.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:34:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 18/25] hw/watchdog/aspeed: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:52 +0100
Message-ID: <20251028181300.41475-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/watchdog/wdt_aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 30226435efc..f842d8e973a 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -274,7 +274,7 @@ static void aspeed_wdt_timer_expired(void *dev)
     }
 
     qemu_log_mask(CPU_LOG_RESET, "Watchdog timer %" HWADDR_PRIx " expired.\n",
-                  s->iomem.addr);
+                  memory_region_get_address(&s->iomem));
     watchdog_perform_action();
     timer_del(s->timer);
 }
-- 
2.51.0


