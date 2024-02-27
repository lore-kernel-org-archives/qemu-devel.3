Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB99CC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reypl-0005Fl-18; Tue, 27 Feb 2024 09:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypd-0004W3-L4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypK-0004rn-0V
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:21 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412b15c97d4so213625e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045580; x=1709650380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS/EGY2tGxoW2u4p636lnzJLhbzW+SUrMSj5Qfa0kZY=;
 b=l8FQOhMDo1lm41CiXYfdGTQNHNVSgqtKbLGr9K+9kIRB6RIZ9675k6Y1CePVXD4VXW
 UBRT5jNVhuhI6R7c9OIBE1ssWO8gSG2XCuqxHWTq6wm/t1RwOpGsYFktsa7E7HxFbRGP
 +lAuS+zO8kxpNwHDdgNGb0FC+qj4ubLjQhyMGwi2iz3ZHYHOXIlpPuQWMd4tWgg5cKJN
 RVkvIoIj9lqtVHrFuw9UWB4+bej2/DGZ3IPJAUkzhz5MCPvvwVjHsprrdCxmGsF6dBk4
 xisrt+9QRYFBCVw3YmU2Hu61s4CdXmVqnOucB8btjvQY2ffDK6r47ENRDPubg8I/yx2e
 f7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045580; x=1709650380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DS/EGY2tGxoW2u4p636lnzJLhbzW+SUrMSj5Qfa0kZY=;
 b=DawLsP7Iy+0eyCHE/Ck7CyV92E5u6qyYdWSjKZ0ciOv3BXCUK5J54iPbcj+akrTeGB
 1p2Ez5lbadG8h3UZj9BoQFUr3maJzSa4R0jTXEcZ0rtQjdgBXipkzMQkyzxwGZfKc6At
 uy3xfz2ufjabEVw2nkKvu/sW44CPAwgRuyPm3b446g44/PPlpeHbz8MEuBXqTjCJQsIk
 MuKAlcfFwRJMgCldVOB6ZkSSR1SCRF5D0XtjpcWEzEeZx9BVN3eosWL0lUxgWXQ3Pu8J
 2N7y1+QBPl3qOZ7m61EYeZutDPcGjw1/+cRZLWyGel9HP3ngwE3s8sYf8pch1Lmn2nXp
 JEDw==
X-Gm-Message-State: AOJu0YynQ1PH2WMgeJnJTT3zB4QmTrEXps1GbS4lpe6SDGXhAkkvDBR1
 qLbmE/BRj4pTQ8ZM5fo7W+Nzr9kf8EirZq8dr6vlRSPFhHSv2IUH6263h6S1fhg=
X-Google-Smtp-Source: AGHT+IFp2qY1yTh7nKe5J3lMjvBCga2j9Q4uCpSn8lGlJYyYv0WrUhHFgAWJOyBSxlFBOVTJrrh/+g==
X-Received: by 2002:a05:600c:1e1f:b0:412:a9b1:148a with SMTP id
 ay31-20020a05600c1e1f00b00412a9b1148amr1993642wmb.23.1709045580107; 
 Tue, 27 Feb 2024 06:53:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c4f4900b00412a013817esm9639489wmq.7.2024.02.27.06.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:52:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 489D95F920;
 Tue, 27 Feb 2024 14:43:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 18/29] linux-user: ensure nios2 processes queued work
Date: Tue, 27 Feb 2024 14:43:24 +0000
Message-Id: <20240227144335.1196131-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


