Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE150D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1BH-0004Y5-N9; Mon, 18 Nov 2024 07:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AQ-00044y-Db
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AO-0005Qa-EZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso29026285e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934062; x=1732538862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivNPlPth2SDoxFGmnFqTJP3RbkCwlecXTja5E4n2oyQ=;
 b=LpJW46pfNKOoEuCQ/SIqWbD9LmiUwR4SSsLDLuSiHBIc2uzqC4PkR1Z6Aac+h/P39Y
 MQFS2zV11FjajsD7/67kohR8/eIz0fhsQNlOttKl79yaSRNM1lvp4XWJJDyVwKtOH8du
 NecVL4oRJbGikXFSysTFRADZFNiKHT4FE/BY4+tsRlo70DDr3UWCVamY98XPrjQ0rGwv
 V2A4hOF+WceYkTFk5tiohViCrDcn6HGJ6eq8IT2oOygYzK5MHg0EQq6WrZ9qUsRAFqrI
 3xwy9wOLYIfXtivB9II3maOWxVbXEr3e0rRSfdEUiRINnBhKQy46WWaOIZXxn8vPZNUC
 HWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934062; x=1732538862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivNPlPth2SDoxFGmnFqTJP3RbkCwlecXTja5E4n2oyQ=;
 b=B/RCGupStOUq/ZHfE/uXmBBbpqpz7nHgKHfa20g7jSxm2fmi+BWyfl614eprWyyRDa
 cUDOrAmwY6oqMuRKONOW3ENGxk5DMIt3TJkJtN3UT5SwhunXSRThk3uoEGZ3TUjywVh3
 rCA5ZJpGeJmFkelFeJ79bi8k6J4vfbu9zmg/Dz8luUpX+4kXt06LTY2B+BOHtvc8BNPv
 VKUhqj7DcMLBMk8v0TKRqXa9G7UfLoyIHxWqbY3HJMYhZ6iBIotuIhVg8PPbcNr8XxMK
 YLK0IuD+bSIHdZWFknivQVb/jxVxQgimfALyg/FKbyqGz/FxVlShCfT3617bLypv+gzS
 bLPQ==
X-Gm-Message-State: AOJu0Yz8lR3OxbizO7DYBH2cUBlMwZ4ovksBSWpAc4ktaeZ0jWk6MvVk
 iwPnlgKvC5NdwDVm30p2wprJP9v/CXO/5HkvV6kYZmQEyZ2pex/1U8urV/GUM4RmARFqqJMzScP
 d
X-Google-Smtp-Source: AGHT+IGgCnq+uEOOEMn/m1jC1NPofGZApuhcPNDc0yz9EyYAQWH953i7rQP5LQR7qaMwyl5cqKWqnQ==
X-Received: by 2002:a05:600c:1e18:b0:42c:a387:6a6f with SMTP id
 5b1f17b1804b1-432df78f3c1mr121231735e9.20.1731934062603; 
 Mon, 18 Nov 2024 04:47:42 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244cb6sm161593995e9.0.2024.11.18.04.47.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 10/15] hw/misc/mos6522: Fix bad class definition of the MOS6522
 device
Date: Mon, 18 Nov 2024 13:46:37 +0100
Message-ID: <20241118124643.6958-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-cfi, the "q800" m68k machine
currently crashes very early, when the q800_machine_init() function
tries to wire the interrupts of the "via1" device.
This happens because TYPE_MOS6522_Q800_VIA1 is supposed to be a
proper SysBus device, but its parent (TYPE_MOS6522) has a mistake
in its class definition where it is only derived from DeviceClass,
and not from SysBusDeviceClass, so we end up in funny memory access
issues here. Using the right class hierarchy for the MOS6522 device
fixes the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2675
Signed-off-by: Thomas Huth <thuth@redhat.com>
Fixes: 51f233ec92 ("misc: introduce new mos6522 VIA device")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241114104653.963812-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/mos6522.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index fba45668ab..920871a598 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -154,7 +154,7 @@ struct MOS6522State {
 OBJECT_DECLARE_TYPE(MOS6522State, MOS6522DeviceClass, MOS6522)
 
 struct MOS6522DeviceClass {
-    DeviceClass parent_class;
+    SysBusDeviceClass parent_class;
 
     ResettablePhases parent_phases;
     void (*portB_write)(MOS6522State *dev);
-- 
2.45.2


