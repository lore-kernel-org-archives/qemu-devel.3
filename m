Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B05AC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kU-0001EQ-G5; Fri, 28 Jun 2024 03:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kM-0000yd-0g
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kK-0004md-B1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-363826fbcdeso217155f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558610; x=1720163410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DS5w/rOHX5RjJWkmyFPsFftFPu5c4nwaKlj59xhrXaU=;
 b=CDSj3NT6P+VVs/CY9mPoepzDmo/l6jZpeMcjrJX62Sw2ZWOr9/wCmS4BAJCjVq/crV
 wIqgbY2n0OXemiypjPuk7GzKJ1JtdW1K6VUqUaSts91LqWCJ3N3nwWJ//LoTZRwO8nx0
 o+vagoML+KfEU7nIzvlyICenWWsmWLlSTAEncDlKDrzIwyGYlXGBR6Vx9jnimkZCfj3w
 lvInTp0UKVzEz8QiK7pxVVnqaul44hF7qBBu2iO3pwFnm6UpcfpNQ18+aNy0LI0hxJXb
 gl1jp9Ts843C7HTR6/v8JYkbrdaTj3SLO6TYAmbUfT9HE5bcxCKsFvAX6gsB7rrPjM9r
 /76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558610; x=1720163410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DS5w/rOHX5RjJWkmyFPsFftFPu5c4nwaKlj59xhrXaU=;
 b=ilNQnru5nhWPfChdhzIXZlepLlTFuTKfdoG53jnX0pbd4STXPp0FFHPFaA2LzH9cws
 3ibC5+TBsSEEyzccqSfKp6eHROqCcDFOY4tcPnZxeIMTde/YrcsAfY+X83SVmY0AlXk2
 o8cYSA8rk+euY1kh/p2utNZ1IOs1+6iG5klK2C1XNaz3jFgfQpPFEuM+uRkJuJVFj2QU
 /l0n/JK6U6mIEjRld5vC5aeyQiUBj8JzNDb79w/UEPKJRUoTjYW4mtjL4BA1Kye6JTlD
 6Sl+VQymt9FzIuvFfZ+iVKQhx6/YWBsoQqjd2BOSR1aJTEr8DVX5/0I37IFrUK2RELg0
 JK1A==
X-Gm-Message-State: AOJu0YzfnsIynYoYS+bFBSvqDlU07zjuXxKg4DSbrOs9LLxsNP9GuYh8
 6hGM29ej7tSIiyA0FraRZgQ5Gb/hLEL7h8ipWwdBHeFXzEqCAEERVwIDWcbblgTzCfXnzzgveas
 iNWo=
X-Google-Smtp-Source: AGHT+IGJck/Kxzj1SLwgB+78hbRNbWahwbyuTPMv49QxYHdJWhUGRUpdxj928fPf5QGLDuOvihYCjQ==
X-Received: by 2002:a05:6000:178f:b0:366:ee52:28bf with SMTP id
 ffacd0b85a97d-366ee522954mr12776879f8f.59.1719558609677; 
 Fri, 28 Jun 2024 00:10:09 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e143csm1340442f8f.59.2024.06.28.00.10.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 80/98] hw/sd/sdcard: Introduce set_csd/set_cid handlers
Date: Fri, 28 Jun 2024 09:01:56 +0200
Message-ID: <20240628070216.92609-81-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

In preparation of introducing eMMC support which have
different CSD/CID structures, introduce a pair of handlers
in SDCardClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h | 2 ++
 hw/sd/sd.c         | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index c1a35ab420..0d6d9e452b 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -127,6 +127,8 @@ struct SDCardClass {
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
+    void (*set_cid)(SDState *sd);
+    void (*set_csd)(SDState *sd, uint64_t size);
 
     const struct SDProto *proto;
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a0da06e017..b0ef252001 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -671,6 +671,7 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 static void sd_reset(DeviceState *dev)
 {
     SDState *sd = SD_CARD(dev);
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
     uint64_t size;
     uint64_t sect;
 
@@ -691,8 +692,8 @@ static void sd_reset(DeviceState *dev)
     sd->size = size;
     sd_set_ocr(sd);
     sd_set_scr(sd);
-    sd_set_cid(sd);
-    sd_set_csd(sd, size);
+    sc->set_cid(sd);
+    sc->set_csd(sd, size);
     sd_set_cardstatus(sd);
     sd_set_sdstatus(sd);
 
@@ -2472,6 +2473,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
     sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
+    sc->set_cid = sd_set_cid;
+    sc->set_csd = sd_set_csd;
     sc->proto = &sd_proto_sd;
 }
 
-- 
2.41.0


