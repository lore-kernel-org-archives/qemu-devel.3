Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA11EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 15:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVJK-0001Sr-Fi; Wed, 27 Mar 2024 11:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpVJG-0001Rs-9m
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:35:26 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpVJE-0000IA-1F
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:35:25 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a474c4faf5eso465092866b.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711553721; x=1712158521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J+//+hsMjxhL/OIhDXH4ZqoOHcXVPUdaTBq4imnY3JA=;
 b=tqPIDbnGvTw9nz0nozgg1htyaqKqtqMx7cPgezCM/K863RI+FR6UyL/J2dl3lsnh6F
 5X201vPNjyKSNB7QKEnOhgyzdtnsEuJxokYeLqSLKHoEiTp47ad9rt9S7LmzLuJbDjc4
 K0/qqwpRoHI1AoYt3r7ZMRxBTEg0RcOwZFQwu6jWc7qy+3Zb4rAFHeU/xlgLVIMP16cS
 MR70AgQ4QqZ7UL93J/mdapaokih14lg8y7nNV9jIUIWM5gtFV8zWdsOlGlKqqPpTert4
 sI+rchoncr5O2ZSBQJx2SqCHFXHVGechypuBY5/248+xDsDEBx0CXMJWdtjRVNGCd7/M
 8XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711553721; x=1712158521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J+//+hsMjxhL/OIhDXH4ZqoOHcXVPUdaTBq4imnY3JA=;
 b=LVozE5wDyTE4rSYGCYizP/sq0XqPXgG21ngOFC8np9RUOVPaO78spYHyCsPrd1slOE
 SOrVUgAZedmTe/kCnjjlpy89bbqssCdWqqqaqTN/JxH0FmaPADen52wjdDei9bB6HNpr
 poSREz8n9BbSF0JR1coHTlc9CrNHhtZm+TmYcljOSiEyGv5sfpWIU5viIR8icGblMYnC
 gLgTGiKj1rFCsgVFKxGKAMULvFTG+GvpJk/ALqGWQp0axednbdDxbpM07FrMuEYuWmCI
 xgR7iB+5jkg5pIEeLOZjfO748L/8cty5e8InBFgSLIXLsmxyahlUe1RJM14hPRrNqSOU
 tr9w==
X-Gm-Message-State: AOJu0YwJdy1K8QldBpdF8e/QP0ZD7rVp6PeomRnv0K+CC1HRNGkAllKx
 eb9cx11QjoQfvkqQicg/rlyErhyeachF9Deo2E4JdMgdzMmGryhod8KPFH2dU+67MdPjDE7Ur/Y
 J
X-Google-Smtp-Source: AGHT+IGTaJlxLH0o6cacUHUc3a0w3puqvce48haCcgjaIQj6Lges5gTm5nCQSCMIyml+37TZ0xIJXQ==
X-Received: by 2002:a17:906:a2d8:b0:a47:479a:a12b with SMTP id
 by24-20020a170906a2d800b00a47479aa12bmr1087708ejb.43.1711553720937; 
 Wed, 27 Mar 2024 08:35:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 hg11-20020a1709072ccb00b00a4e03823107sm938776ejc.210.2024.03.27.08.35.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 08:35:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mst@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-9.0] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only PC
 machine
Date: Wed, 27 Mar 2024 16:35:17 +0100
Message-ID: <20240327153517.31285-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Per Daniel suggestion [*]:

 > isapc could arguably be restricted to just 32-bit CPU models,
 > because we should not need it to support any feature that didn't
 > exist prior to circa 1995. eg refuse to start with isapc, if 'lm'
 > is present in the CPU model for example.

[*] https://lore.kernel.org/qemu-devel/ZgQkS4RPmSt5Xa08@redhat.com/

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..345c35507f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -208,6 +208,13 @@ is no longer packaged in any distro making it harder to run the
 ``check-tcg`` tests. Unless we can improve the testing situation there
 is a chance the code will bitrot without anyone noticing.
 
+64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``isapc`` machine aims to emulate old PC machine without PCI was
+generalized, so hardware available around 1995, before 64-bit intel
+CPUs were produced.
+
 System emulator machines
 ------------------------
 
-- 
2.41.0


