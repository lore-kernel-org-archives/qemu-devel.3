Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFA1E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB6l-0005nL-Ih; Fri, 13 Dec 2024 14:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6j-0005bM-B4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:49 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6c-0007SD-Of
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:49 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2a383315d96so998183fac.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117221; x=1734722021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYpzCIIWLR+bvPU5Npbd9jfQ0yZt4mKlJCxKK1JYabc=;
 b=ZaqTBO0FNtQVwgom9XtgEvI30PJTwyd/ilPv8Lql9H6wkUFnzUgKcIaqDv6SD2AJ/D
 ss7JMB8urm25g7dN7QS+ygXo3ZNB7BCFeuWLVUGvnUIUtYUGBuvigu8Z8KbmWf9mlzi9
 M8D5p1qi2rp03NmFxBhVxLJX4V9Nmvbd0iezJY5/Hzge30QjO96O5Z8+zY2SPKfbTTvc
 VyweYR9ToQo7vBXvctOKhoQUjZjHMGs8RJVLpAQLsXpu0S1djSS1HPGmuvwKD/OUH+Cw
 nisDTEd06UCqAQ+kXCoz9gVMkr3+JEd23yORUPHG8TwIl380C6Y/D6oPsJIju21Y6q8d
 nnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117221; x=1734722021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYpzCIIWLR+bvPU5Npbd9jfQ0yZt4mKlJCxKK1JYabc=;
 b=rCmaFL8amHwbNlyygJ2sbcA+7ZMzHcgvU03pChbVrLJSnRiEAaETAKUQ6kiq0YTi4O
 7Ka1OagBS/ixj1UnPaqcrzkvJF38S4JNtXZfV6yZ65ssTDbxjWzhfYwsWz5UHPIH0N0L
 /yo7Dy1ZHHc2vnNzpNLY2YmMaYNVbHLzSEteKdLOLdi30M3TY3l3tqonyBZInVDb2nzj
 ibKKGSjQ/p+lfB2ToieXCNKwt5Wu6j54+rvaNESrg8UXYHdbfHsMUlNcZFMdMuYq38Fe
 fCMkl+YE9RAsv+xHVduF0bEBWPQoSVrAYITERnDDqKC1x90NLJLjaTzgAaCNG77hEpCr
 IQKw==
X-Gm-Message-State: AOJu0YxYUO7JX8qZgI2Im0/toOzLU9UeFP+CB8VNbou2FxxoqxY1yaHr
 A5vI/w37LWR5cKZZtf9b2a0piMH9HZwURnU8Sf3MgEj/RAqBG5KCQEia9JzQoG7bOhgcfwq4IPE
 INjMPTL0T
X-Gm-Gg: ASbGncs33RIDNfEwDY68U4BxiH0D+yk9SszZ3Esu6H1EvuX2VCXLXO1e1jKYa+MQGe3
 viXKKLune8IeEGYBqlr/iji9w/o8/kvImrOmdOGBIeGLPiq/GRGH0yu7v6/D6l6gAxuK1S+OS9t
 f6ITHBf9ALM83mCWyfsvCi+P5gtzoAIi55nc/LQ/ImlPxLrCK/Ih+uDg2S4Ax9HTQPH+tV1eHUS
 f/saMFpqxbKwPclNhSwh5Xis+A3lUq3XcBc/VwaQlaJrzp12VMI0mAawFEt/Cbq
X-Google-Smtp-Source: AGHT+IEwws67ez/3napcjb5XwQKoZikflC8B0cUpR3CDGDiQ1WzTE8Rnuik6XhVkYgTDS6LTrR/RcQ==
X-Received: by 2002:a05:6808:f88:b0:3e8:1f5d:b804 with SMTP id
 5614622812f47-3eba6871639mr1726929b6e.15.1734117221467; 
 Fri, 13 Dec 2024 11:13:41 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:13:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 36/71] hw/m68k: Constify all Property
Date: Fri, 13 Dec 2024 13:07:10 -0600
Message-ID: <20241213190750.2513964-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/m68k/mcf5206.c   | 2 +-
 hw/m68k/mcf_intc.c  | 2 +-
 hw/m68k/next-cube.c | 2 +-
 hw/m68k/q800-glue.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 7247cdbe5e..45e5f74600 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -600,7 +600,7 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
 }
 
-static Property mcf5206_mbar_properties[] = {
+static const Property mcf5206_mbar_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", m5206_mbar_state, cpu,
                      TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 9fc30b03ba..c24b0b715d 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -177,7 +177,7 @@ static void mcf_intc_instance_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
-static Property mcf_intc_properties[] = {
+static const Property mcf_intc_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", mcf_intc_state, cpu,
                      TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 08886d432c..a37ce00874 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -914,7 +914,7 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
  * this cpu link property and could instead provide outbound IRQ lines
  * that the board could wire up to the CPU.
  */
-static Property next_pc_properties[] = {
+static const Property next_pc_properties[] = {
     DEFINE_PROP_LINK("cpu", NeXTPC, cpu, TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index e2ae7c3201..0d8cb8b1cb 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -203,7 +203,7 @@ static const VMStateDescription vmstate_glue = {
  * this cpu link property and could instead provide outbound IRQ lines
  * that the board could wire up to the CPU.
  */
-static Property glue_properties[] = {
+static const Property glue_properties[] = {
     DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


