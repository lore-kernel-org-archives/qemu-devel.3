Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514C9CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlgA-0004cu-JP; Mon, 08 Apr 2024 05:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlg3-0004Uw-Mo
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:36 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlg0-0006MX-J6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:34 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e47843cc7so1237815a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712569950; x=1713174750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SX5xakbdEor+CW8HJ6tUewkIqcSRy/qmJlj1fBtPDng=;
 b=aJfW2gG5FbdRsMCASpI0isTwKKbSIUr1bRkAbYbTkQIDM826KzZ90wh2zd50kHQPif
 oj6NWIqltICwqdVwMhtOC6UPSNgWNnddvcDp4+WkkJKhL8Tx/sJvMr9cEXdEfFMZRlGC
 u58JkyC/d4Ma/ijLmfjBqmcNl6CLfAY4L+ahfbqQGDqQNGjW1uUEleDi5LmqHq2X8klh
 +1Qf63zYZUtbV9ivWAbKVdln8mj/uspX+Wtj0lIDfVtTPLt2yaYTm1mtJKy8BayPoZaV
 WFNrFkyRubc/mopUKTlbTfqvAm7tv8IokgXBTWNU7vdPfKwvbFve/aZ8UsfxGFX0TQMm
 I/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712569950; x=1713174750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SX5xakbdEor+CW8HJ6tUewkIqcSRy/qmJlj1fBtPDng=;
 b=s1M28E3VbLYWbaUgL6bJykBAYjRHZYYYM307Ih96uEePVzsnSm6ChtLow0kPs/ShG8
 Zwi/+AxhNr0SvkSwOAW7FxXR6bMxX4DuIEg2Nttt++UhDLHGB2I7JkImlUFwsAmVRcY2
 sx5LMh9gxnxiD3nS9nRMVB4cq7KNTq6aumHQ6Tjj1bYkXjfybo78PSF/bAA2UaORYqBX
 79cNWI4Vf6drrgzxsRwsW5BKdK6pN1RBIAmLcq8x/exGEkdyNSkOulI8o94YORGV47JU
 gRKEi9D8HV/z3QtV6f4JTNwJXRwoBjlKNFLZwTEoT9zRc+uP883uZZXVzfZFFl0zcvD8
 S21A==
X-Gm-Message-State: AOJu0YwbqekxePbWUWryhe+GSqmGTZxSXceybBeUfWvY3VXGUgmrzsEa
 uN20FBDkNjypjj+D2RsTI5GX169FcQEHebDg5zL2zYP1a+e6OzkxnIA+jwNxi4fIggngliM9uqc
 4
X-Google-Smtp-Source: AGHT+IE9zdnbDSjX5h8fQtyGnepEYWsOFE0Qaa2SFl1gvr0OWlqkoFPHn7rlUFY6wkM4JXxDHkEYpA==
X-Received: by 2002:a17:907:7ea4:b0:a51:c975:f02a with SMTP id
 qb36-20020a1709077ea400b00a51c975f02amr2584452ejc.65.1712569950602; 
 Mon, 08 Apr 2024 02:52:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 ck20-20020a170906c45400b00a4e23400982sm4250084ejb.95.2024.04.08.02.52.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 02:52:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 2/2] hw/misc/applesmc: Fix memory leak in reset()
 handler
Date: Mon,  8 Apr 2024 11:52:16 +0200
Message-ID: <20240408095217.57239-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408095217.57239-1-philmd@linaro.org>
References: <20240408095217.57239-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

AppleSMCData is allocated with g_new0() in applesmc_add_key():
release it with g_free().

Leaked since commit 1ddda5cd36 ("AppleSMC device emulation").

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2272
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/applesmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 8e65816da6..14e3ef667d 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -274,6 +274,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
     /* Remove existing entries */
     QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
         QLIST_REMOVE(d, node);
+        g_free(d);
     }
     s->status = 0x00;
     s->status_1e = 0x00;
-- 
2.41.0


