Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C49C02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6iM-0008HJ-Pj; Mon, 03 Feb 2025 19:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iK-0008GX-BN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:22:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iI-00070W-Tc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:22:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38637614567so2222970f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628569; x=1739233369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Az8EPLdbpaM4rrJ7UfHg0zKoQFfHGEeaDufKhZSFa9M=;
 b=Wb355+44R5wbRQHVdlUmADuEDOQGuqE7WZl230AVRb0jvSsL77OQS4uKWgc26UqwtY
 q2llNUluOrfFzmEdyNxWzdco7pEqEhek9PwG/AGQ9ma3pevLbAcrhTwGbwdVKZFYMf/a
 e948WClgD5ydRKEdpZlIjYEHx5k6rzgVOpVBap5t+2Al/LXvLW323mRtSnN3hS3ZuNF9
 VfuvcSh2GKkzXkfF/mMqEwKjpOe+m9VKueY/qofcm3RqsQDlRzTDx8zOrB/cqDUYdfch
 aeWNyZKzdt9bZ/jNzW/FyTcdNpBT+S9opqLF/7kGuuox8fbNLlNlzkDtjQivg+ulBAbI
 EgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628569; x=1739233369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Az8EPLdbpaM4rrJ7UfHg0zKoQFfHGEeaDufKhZSFa9M=;
 b=ePEof+eYXsT8yboqmzKvkzm3FrX77YTZkvh4qq/Wsmf6Bz4WxqmYSHXxbW8zWHZv1M
 0ZTVJh54mttlJcRB5sGbYTZXWV7PHL0lG0A2U/cScatKTOYO3IvVw8PuFF3Z14rL4ij/
 qnuy1uP/IqhOGMIsY3gizVKk5nNPl3fz0ZXbK2ESTx4rSqw++q5ufG9dv8HiOUmdqeMl
 z32SLeBuBLmqKLBitdLNMrQ+wbirImJWcV7pguzDDFlHXCG3piiZQKjIxz1HSq2lK/6c
 SYQOkRQ18z34XkmQE5iIXx0pz2zSs6Ffl4uGhzxvQCQljkmJ/Qd950c7sg8+tw6Jj8rF
 MPnA==
X-Gm-Message-State: AOJu0Yxm/I297sJt/7MxqCT1BuOydUqAgqeBTAZN7X1DcZlDwJv5Ctdm
 NwJdTIQMffyXA4wDLLDV1NUgfEv0ppcnzO+r+gvQVhn7bVz4zemcE+pthCXbnQGPRGEN41/V393
 MRpI=
X-Gm-Gg: ASbGncv2su3Z4/t3js6BzM7B3EhTFk6fouy/xNakB6if7Ias9jyPrML+6uD/xUuNnKQ
 B2/vP0SAOrZnTX2gCtT9viCc0VweqAGlRhBPw4/J8LyR0PqE59MiocMFvB0dZW0rzFafd0v6Qar
 uRpqdgYCRyBkNp7AOsZbiWz1OQ5LBX67qvYFosx+Qvh2wZcu5WCKoI3ydCTBKyLaqA8qMa0uOTf
 AE++ZhHGphpHh5JwQhrcnIpeEZzvPBYMZgoKGAsBV6MPxfTqGVG+iYTx5CW4hxsrlIb8Hu3vfmZ
 1rRXEwHq8UztcioZx6EA6iWqh5v1dSKV+o5QYwNbPvUixQlzCZnvP4WfEQmC62Po/Q==
X-Google-Smtp-Source: AGHT+IGehyswMqyU/BOxxk5EPd2/kVZgXrKnQ5/w12TJ2w9ENui2JG35mk6P9Jze2hMJ186vIP0Ceg==
X-Received: by 2002:a05:6000:18af:b0:385:e30a:e0f7 with SMTP id
 ffacd0b85a97d-38c5195e81dmr18362724f8f.22.1738628569093; 
 Mon, 03 Feb 2025 16:22:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf2eesm13942861f8f.85.2025.02.03.16.22.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:22:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 01/12] hw/arm/raspi: Access SoC parent object using
 BCM283X_BASE() macro
Date: Tue,  4 Feb 2025 01:22:29 +0100
Message-ID: <20250204002240.97830-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
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

We shouldn't access a QOM parent object directly.
Use the appropriate type-cast macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c   | 2 +-
 hw/arm/raspi4b.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a7a662f40db..508f90479e2 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -312,7 +312,7 @@ void raspi_machine_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", soc,
                             board_soc_type(mc->board_rev));
-    raspi_base_machine_init(machine, &soc->parent_obj);
+    raspi_base_machine_init(machine, BCM283X_BASE(soc));
 }
 
 void raspi_machine_class_common_init(MachineClass *mc,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 1264e0d6eed..9b08a598f39 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -104,7 +104,7 @@ static void raspi4b_machine_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", soc,
                             board_soc_type(mc->board_rev));
 
-    raspi_base_machine_init(machine, &soc->parent_obj);
+    raspi_base_machine_init(machine, BCM283X_BASE(soc));
 }
 
 static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
-- 
2.47.1


