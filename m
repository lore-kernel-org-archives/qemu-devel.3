Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FF2C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84wu-0004VD-IB; Thu, 24 Apr 2025 18:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84ws-0004V3-9n
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wq-0000xN-OM
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso1667413f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533295; x=1746138095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/h/8JlKQTj5C7D4ksIw0VPKDSTa8HWXtIX5aCCEMPI=;
 b=WU5ToOAZ5pr7+slmxMEMr7csmSVFSCXjkhas5U4pPpZpGaBTMsn7l39GODDxUFzI7f
 W2Pf9ym8vg+xxa0YEeEycEapv8pJYR3M71XlNr8r2NtaitHLvNWtEUcww9uS1lIW8ymd
 i7WlSfx7LzZLiFCEcPQbleH19qreWChbVYhnx7opqRVUe4o9lfcxDtP9ruG6zlv4NzC/
 jhtWHd/HJF4byUuS8iaGGV/XX9keEkdMu6fVZ0dtqyL2SwPmMrZ2ZPypIAJEGVmnUruk
 JezLr1/Fy5gr2WtKEsxh/EI9B1ZbiEg4N1GVAo04dCal8pkn+b9NZMpRdAiArJRBbL1D
 SdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533295; x=1746138095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/h/8JlKQTj5C7D4ksIw0VPKDSTa8HWXtIX5aCCEMPI=;
 b=icbtvmZ8WV2xze87KHVaUSMGdUQRq6n68+mp+1WFghzH7j1huQyvfVnHZxvg/Webug
 9taglft7VuRRGZdJkBJrNpR4jqmfzRE+LoGMv3/X5tz5qh56fcjSQu1z04CD8sbp8X3X
 7LM0sinki8pf5dFkCEsuWQWR2s/+d2avbuBe5doUppo4MlvHPA8qwC+It/Ik77isZvuD
 VJaTTl8H9aaSNLF9SMI7BjiFdD4/pvdiEzBkDrxOF48pb9swmA47AZrLYvvFNbnAQEbe
 704cJi673TERjYXDwSG5lDMjkrXhXskhDf6+VKWM6xHBMM9Jt5KZRt7uqsxpsEU/lM4M
 zk3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7TbNHSWDbxh9UMz9iehYygUW/siiC3b6Aln1lORXnVZKyF3xEYhb+VBK/Y3S1Bfuz1P2I673cIM4T@nongnu.org
X-Gm-Message-State: AOJu0YyS03zFULR1OKk4sGHjqgu4vaU3NL+lXPTaCIJ0xG19a6etTb0f
 RxcZRmNAxqZPeR97/C942cgZ/EAKXQEI0H3LukaVl6zsQMMLFYSGQQfGV9JUwgg=
X-Gm-Gg: ASbGncsJmos9Y3WjxS8BM3rdKWnIkWyGXQq8bmmyIk2olMKwbbHgUZrnK7gYsWNiB5i
 HZ3vQCey7jmHFxYyf2FHF9N6E/8J4lhecBSA3RtdYgu8CCzC8dkTzK36nOLoYP7Yhaal6NHemN+
 CZpelmcGvjLvoCRs9tvHXRZwwBNzP4KN3DknjBpHkrnBrU5XNcSdqRVTAfKJzmnIV/rRylFHLzK
 yKIPQJ6+5sKioYWAhynuf2gS2PVEFCyIJoy9IKGsAn3fr/oHnNftzIZPPlV6mpJ/cp72iXkhdai
 iRNjxW8IjFAUiQlqkwqH/whckL0Y2V5hZxfCF9BgFzvhJq2TrQyI6UIejHsK7I3/d6FFvF6tQMh
 FPXpid+AT40E/JAQ=
X-Google-Smtp-Source: AGHT+IEcPYJ8l5YJSwxwLEg4adEyzminBQ+jPeMMb2aBshDPaYxQRi9tHcqxkU5K1dFJavZl19bZ3Q==
X-Received: by 2002:a5d:59a9:0:b0:39c:e28:5f0d with SMTP id
 ffacd0b85a97d-3a072ac8c28mr806800f8f.25.1745533295016; 
 Thu, 24 Apr 2025 15:21:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53044besm3258715e9.14.2025.04.24.15.21.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 04/21] hw/core/null-machine: Define machine as generic
 QOM type
Date: Fri, 25 Apr 2025 00:20:55 +0200
Message-ID: <20250424222112.36194-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/null-machine.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index a6e477a2d88..3e03771d570 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -42,8 +42,10 @@ static void machine_none_init(MachineState *mch)
     }
 }
 
-static void machine_none_machine_init(MachineClass *mc)
+static void null_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "empty machine";
     mc->init = machine_none_init;
     mc->max_cpus = 1;
@@ -55,4 +57,12 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE("none", machine_none_machine_init)
+static const TypeInfo null_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("none"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = null_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(null_machine_types)
-- 
2.47.1


