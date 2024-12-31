Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E8AE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSimV-0004wk-Hb; Tue, 31 Dec 2024 15:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimT-0004po-Ca
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimQ-0000v2-CN
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so22693825e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676632; x=1736281432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24stuC9Tej+Nlsj2a7JI1tcgZwdo9U7YvTPvHeYqEOg=;
 b=T3865P7teJ34HIBo6CBKzJhVfGyg1V/5I9y8bynOOb6j7vjPZ3wdmixb4vbWh6es7w
 FYZgReyt21TB6M0TI3Vln9UUOYJzd62kuxJihtQpOeLodys7quSDXMDoAcioAs3dfzHC
 gDWemRv3LfvTThckII5YtHj1T6hTPcOV1lAg4mQgeLzDm0dxkslJnVHU4XaByQxRYgK9
 e72WsbbHst/QeIz/BvvOt04QbM+xXIMn2Dd92yaImO13MflRuxvWILnEpULdVjFzDOFg
 bcAUWQs8Vp1WZUTYMzNei71Ep4ER3bXtxRYZmS6+aGW4z4/Eh8nbGRjPCF1t6hWXE1z5
 Zn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676632; x=1736281432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24stuC9Tej+Nlsj2a7JI1tcgZwdo9U7YvTPvHeYqEOg=;
 b=DmxWDkinY5uJgUqcycFu5MMHPQAT8vootO7tFxb5Ydo9RCaFg2/Ne9eO8ijyJpebfJ
 UrkTef2BsSAufy02ZCW2ba2idNSVnZlsjCpH2zs3SzoD4UAtLk5OiFNUuUKTV151U3VZ
 OyHDvSvPnnj0jUpyJERTLPsOoWjxF7sMpUjrjooaV1DnGpl8Wxrt2n4Pd8+GtsJHYEAj
 93KcR3simVRbtlN02+mUj72JANn1C2hJ8CXx4YHV/2qmTs14fwx++CTe0HgSFJ39Q11c
 EDJjwubOjlivNqUnsn/Yw0Dces+u5sQST+/2IrF5jyGRd3IKnYl9WZXfUpM4Jw5zZQiJ
 bwEA==
X-Gm-Message-State: AOJu0YwZdasMiFh18qxp3yBy6EX3unpsVNa/M0a8Vkrzbtr7GH5Nr66E
 w1axGmpXNKQOUIxPSzRkrbs7VHAJDWLomLfMF0bqP7t2NrarPHc7grRZKXrvcBTeWM4AAsz0q5r
 jzY0=
X-Gm-Gg: ASbGncuOpU5GidbGu8aftfWD/U3RjqpJz9d0Fu/WTvkk5vhkizavPfGhChwyOCoPTkX
 DmOcl6LdjP0iwl2ghn3zbW9M7A9GbA88cOvLirCbQQtKYe6rYrHIMfrQA3NE9GOfS0SJOJ/uRAP
 6EkB1lqY04d6PFgGbrC018qlc4VCQAyI3huBVGN7MhFwN61KqOb/T1U8RmpmvRZLolkvv7E4uLJ
 //EpZueIg2Nkfq0xDAal7Is35ywhc3rfxFKyIwEUnt1yAHl2NwEfXTbRPMirYboa+GyItSg8+ap
 YWGaRU2gByXjwOBLMqDQvhGiGejFfcc=
X-Google-Smtp-Source: AGHT+IHQaxwxSJl1/6yWEnOLAH9uOXCjyW21gae9112DYokFOjaO0ELF7GmQOqUy9uCkQWqrxAQk8w==
X-Received: by 2002:a05:6000:4024:b0:385:f6b9:e750 with SMTP id
 ffacd0b85a97d-38a221f31a9mr29076092f8f.9.1735676632326; 
 Tue, 31 Dec 2024 12:23:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a3766dcsm329449335e9.0.2024.12.31.12.23.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 17/29] hw/misc/vmcoreinfo: Declare QOM type using DEFINE_TYPES
 macro
Date: Tue, 31 Dec 2024 21:22:16 +0100
Message-ID: <20241231202228.28819-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241219153857.57450-2-philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 0910c64866f..31073c8de2a 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -93,16 +93,13 @@ static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static const TypeInfo vmcoreinfo_device_info = {
-    .name          = VMCOREINFO_DEVICE,
-    .parent        = TYPE_DEVICE,
-    .instance_size = sizeof(VMCoreInfoState),
-    .class_init    = vmcoreinfo_device_class_init,
+static const TypeInfo vmcoreinfo_types[] = {
+    {
+        .name           = VMCOREINFO_DEVICE,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(VMCoreInfoState),
+        .class_init     = vmcoreinfo_device_class_init,
+    }
 };
 
-static void vmcoreinfo_register_types(void)
-{
-    type_register_static(&vmcoreinfo_device_info);
-}
-
-type_init(vmcoreinfo_register_types)
+DEFINE_TYPES(vmcoreinfo_types)
-- 
2.47.1


