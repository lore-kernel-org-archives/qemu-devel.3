Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E0AC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeIk-000739-2N; Mon, 26 Feb 2024 11:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeIh-0006qi-NP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHv-0007lw-2r
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:59 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412a9f5f797so960745e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966624; x=1709571424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS/EGY2tGxoW2u4p636lnzJLhbzW+SUrMSj5Qfa0kZY=;
 b=ZV3vCPUtz1IeVn0WCT7JjlsxfmyT+rLn56AsodqWxsmELVOOarHX5b/7flJMVjledJ
 HHccpSD/WPShDLKdWSc5e9XVvQppGW1lJ2F2+TCLR6Sox+tnTEkc22hpxyP23x6CpS24
 p71u8GoCevZdhAFfvQYUFQ5je1lzrVKAwtl7MZ+46T5pIrKyUmSIHaXHwYQ7VfyMVJtU
 WuRWyc+b1FKz2TkQp5X8cCif8G1lN15WiCx5b/Vl4T8u+HFz8YF7g2RthKILErzijpDk
 bAhTC+5YwzM2Rkn3nqgxN7M7I9MeUj3EkRxAtfYMfKTl4Lz/cLruXQsloziMLyxx8+ld
 2G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966624; x=1709571424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DS/EGY2tGxoW2u4p636lnzJLhbzW+SUrMSj5Qfa0kZY=;
 b=C+1OMP9nOVbTQ2YK8TuckqpS/VlAkBGlyaIBud8xKROAl/ld5ardlUStkzRiu2o9hb
 3WRrybj5Xy7r5EHGTnjPt5kS7ITuZfT64dlA5BRNemPv+tL4t8rPmi+isYuWw+vuVgSH
 lF5DqezO9DlvWchNt4aNjPZCqshMOoAmuiGiOhqFZUCZ+zYE4grtuh63FjzbSzZpX7TU
 G9h7l9U2S0xsSn2OfNf+XCpX77e+wce4XqY+L686EAu3hc1FnjgMuBQV5y+PuwUsAi/d
 m/pVhxWP1htUddD7WIlcbgW0qhdhc3vpJu4Dd/IrtsSG+Yh+7CDDenoV8t6/YmzJB95X
 7Msg==
X-Gm-Message-State: AOJu0Yyjc5PJ766mcB7DdSH1hM7ItQqDysY2DQIEC7i2zeXEjAE6yrYD
 E+NjzsP6kOwVvE42SBvX6uWZDuRhpuGvf8ku8V05LPTxc44UbhlKHzGtt1l7fFI=
X-Google-Smtp-Source: AGHT+IHvzDyWOlzzxecmLxmVnIW5FpI5JNQnMKK3T+9/7uHGxXBtbdsVFcilr0cJVNl+VjOUoiVfZg==
X-Received: by 2002:a05:600c:5198:b0:412:a9e1:ed8b with SMTP id
 fa24-20020a05600c519800b00412a9e1ed8bmr286685wmb.27.1708966624207; 
 Mon, 26 Feb 2024 08:57:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q8-20020a7bce88000000b004101543e843sm12440932wmj.10.2024.02.26.08.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 08:56:59 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A0285F929;
 Mon, 26 Feb 2024 16:56:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 16/27] linux-user: ensure nios2 processes queued work
Date: Mon, 26 Feb 2024 16:56:35 +0000
Message-Id: <20240226165646.425600-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226165646.425600-1-alex.bennee@linaro.org>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


