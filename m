Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A99FC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYVr-0000gO-VT; Fri, 23 Feb 2024 11:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYJx-0004IK-SP
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:22:45 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYJU-00068f-RV
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:22:45 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d269b2ff48so6324251fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705335; x=1709310135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS/EGY2tGxoW2u4p636lnzJLhbzW+SUrMSj5Qfa0kZY=;
 b=gr609NOKI+9ho6OomofVKW8jj7VnF8pSJiKrKtVhlCJCLLiOBiFFqAr+kDHpJL8RZ3
 gAv/4a4cUupPGzsNUFHw3kS4CYlQqvrieIcOZaNLJu5+jR4o6vJzYj7yYbWQZ8ZmKptW
 sKA9nrhsAxFIXJ94YuXB8yxUHgFhYXsDZaJ8N6+SIP/+dW3aDMu5e5wnKfkf4VN7Y05+
 Chmvqezaklq5wgHkpSATTbaQb8NPcEhoURa8xf//2yir0db9NEww5nmNF7ANdxjJWYdo
 M8qmcI+8vKQMfXbI6YruB/OF0rMaWAFfzsSzlvYzdRkVdjRWpENtZJHTIPFGM98Nhslc
 YGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705335; x=1709310135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DS/EGY2tGxoW2u4p636lnzJLhbzW+SUrMSj5Qfa0kZY=;
 b=EZVND5DY0JeFwk7hULqpizP0k//tTIpyKK3LAljKH7OjN4AuXTQGdKra+x/PtirAW4
 JlraidVGT8PMuu9Tt+7RV5mKV9Neu3d0M8HVoIYqeY/d1R4fLugD5TrmROJo4JlChx8d
 jr0BX+CzEoUN7bH/mwMmHmuuI8LFP/Eeky1ZQLynn8dCmvlX+VuRdhZ6uNFdtjLBxAHG
 ha+7C8llY57UkHeYLpvnpMrjHgl4Ach8/6NhbvCX8gSagnrbsZ1eDkoIugoAE4fD9wJt
 iYX1/5R9kjClVOQ+0I/SBLqivBMVak9v1DqmmprHtxlhbIv4jMOA5OsA0o4Fo/E3Tltm
 cVtA==
X-Gm-Message-State: AOJu0YzEEBrKKiQfAGj7ks/lWV2ipGXlM6DOYRNXskVCmJMyaKy+OTPP
 jGVF0zRg0UC3J+PtGpAwmpN8xLH8ucBXKHOF3OXUv8fDP+mmoFZWDOwmEcYNrzs=
X-Google-Smtp-Source: AGHT+IEfPGR9BBDQFxWL7BA0WYTIhiZ+qr0jGHmFDImoxQlfEnCAg+xrv4Dx1JPnswXJdxd95WzcKg==
X-Received: by 2002:a2e:be8b:0:b0:2d2:2fc3:7b03 with SMTP id
 a11-20020a2ebe8b000000b002d22fc37b03mr255281ljr.41.1708705335232; 
 Fri, 23 Feb 2024 08:22:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l4-20020a5d5604000000b0033d4adb3ebbsm3293200wrv.26.2024.02.23.08.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:22:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 19A2F5F931;
 Fri, 23 Feb 2024 16:22:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 16/27] linux-user: ensure nios2 processes queued work
Date: Fri, 23 Feb 2024 16:21:51 +0000
Message-Id: <20240223162202.1936541-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223162202.1936541-1-alex.bennee@linaro.org>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While async processes are rare for linux-user we do use them from time
to time. The most obvious one is tb_flush when we run out of
translation space. We will also need this when we move plugin
vcpu_init to an async task.

Fix nios2 to follow its older, wiser and more stable siblings.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/nios2/cpu_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index da77ede76bd..7fe08c87501 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -32,6 +32,7 @@ void cpu_loop(CPUNios2State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
-- 
2.39.2


