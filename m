Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A3BCCF9EF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL1z-000110-Kg; Mon, 27 Oct 2025 07:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1S-0000et-8V
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:23 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1I-0005fm-Ng
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:21 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so1073627466b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563036; x=1762167836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MFngHGehXpgcde25fEDm3yIeCRkA5CYGfoJypWa7UA=;
 b=A3HiKZAag/VDzVesdW8W4BzzVnQ9fQelHdrZha6zAdsN1IhDvaYM2QqkLblgo+w/iT
 7R/T3T++7LRK1JI5crVUUJjbBEkpr3kcNrG7MKXLZ3bQPlOdt9HfI5xeHNEU08V+fpdd
 F5PG0wV/GbyLLi/DOIJZlyQzgvvtPaX3q7s8U07RdZQbMZJgTw0hNxcpaisRyYaUtg8S
 1dep6JMdfEVtdrkF4t7c3POCAcD6/FURfCIya/d68TKwB6ZDCFM5BArqbLkGtG2yFDJf
 cEbyrhPA2MOiTVusla+TOMrJaTnwBhep5J4p62h0JrxCU1cKxygllqgOrvCjf8dnXewB
 N74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563036; x=1762167836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5MFngHGehXpgcde25fEDm3yIeCRkA5CYGfoJypWa7UA=;
 b=XhYV2XvdkA0hyHfDIXkokCfiwJvOH7AQAqQVOmzanSIKiURZyPbeom2kQ050MZWo7Q
 N+AxZyn+Zy7bXE85QXHPB7Zg3zK0hp020D2ud1dfOzgQ8oK34Cmd4AgE04bGvZURKlVm
 Qw7Op2dtraAR6j8yMZsdhASrmf2oWN43tDhXE9B8S1pBRXhCcvo4un1G3RsIPsZZ41yQ
 qaYZuUmD55iwlU4IAlZhrAbDj+ISXDjC4vu6YvIgd8z3I/GCLKAVLgz2d3H2B6/CWSPl
 wrDwvLvaStd4MHk7Q5IUPRkM58kO60B3PL0jXlsQC96IYmkhpbybXxSnS57Jy49aQ1vJ
 3/KQ==
X-Gm-Message-State: AOJu0YyKYifschNYSW3XwfMIykDrReY5ZfI4F6YNFf1z+LuMcRdp5ghp
 x/ef1Lu1tuEk4+Fjuwqo3P7DTa5eqO128HMjfTRX8MG7dXFxnROQU5dxOuphyH1iA8o=
X-Gm-Gg: ASbGncu/D+kSYYXuugydzg6SqIYDq2WLEN9VvThbyAsGD1Fm+fffZV4k7CQSWkZU7U9
 XdOl9zvXU6xb7EpqGcmhoY4gTsI6JSdiijuZVDfyk6lD5f/2HOatc/2xTg+k/kNDomxbBvThgSe
 AvSyk+b9E6TpFZrCXM3zN4x69gaf5tSf8CG4FpxJBo6Jyq2HWEeajFVe+czLUQpU+65bPYEqtlx
 hchjP/W4Xdc7yuFpsfmTJr/HPVnt8zFtiSwCzBFzt6xfmyDlmnQSzkqBTI0HUZoTbboAb3DI84b
 xupStEZNA+YvKjcahlBQyhze+ipH0VP6wcjQs1SFo43CkKNFN2G8f1VZSszlThFvygCcyUi4OJs
 Cjf1jYRMjpKRI9dRGJtDilqp76XcVolGVM1yl5o096aaNhctiScyD+PcjMdvd1OWu/dmSdEhZs4
 IkAaRYyuG5QT4=
X-Google-Smtp-Source: AGHT+IH3tkpPI8qkMNzSSKaTH+LGz+PSEOooZ0h8e2NnoKxhhJh8kTHLf7OwlNmHT6Lz3ZHEnK/s9A==
X-Received: by 2002:a17:907:7254:b0:b6d:6955:aaff with SMTP id
 a640c23a62f3a-b6d6955aeeamr1290331366b.63.1761563035774; 
 Mon, 27 Oct 2025 04:03:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85369697sm757955266b.26.2025.10.27.04.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 528BB60A0F;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 13/35] target/avr: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:20 +0000
Message-ID: <20251027110344.2289945-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for AVR targets. That architecture appears
to only know interrupts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/avr/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 4b29ab35263..365c8c60e19 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -28,6 +28,7 @@
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -102,6 +103,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
     env->sregI = 0; /* clear Global Interrupt Flag */
 
     cs->exception_index = -1;
+
+    qemu_plugin_vcpu_interrupt_cb(cs, ret);
 }
 
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.47.3


