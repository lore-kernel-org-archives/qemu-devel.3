Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC2C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Mst-00088C-KU; Thu, 17 Apr 2025 06:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsY-0007f7-2P
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsV-0003S2-0Q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2243803b776so9597585ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887233; x=1745492033; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vz+7rJLKk52J8xcxBS8V6jPxUUQa+S+ay0i6P14+Mmc=;
 b=RlGEw3A7mt8SrbKIYvda6F/VuXxnZaXh1AGvVEMFHkrvMPW8Nxb05wOLMOfeAhyegk
 ID7AXxqbX2fVqIlf7C7Sgvxhxz+MBco00mXsRaqmbtKR2GX+m6mvYz3KYILd8JERVu12
 1oq/qHhJ9uqE3gk+b1ZFr6XlFBjltNbG+q1Bu3zsYgih+Je2Mh7/GsOE1kZ265vI7DE9
 e4vA4xTeIRE7hTBFhZohDQ6c7PwXCwXvfTobmZIQTVxlGD1PEevyUf0zuwPVH0VDmc/Y
 biyg6NKLSZnpAyUPUeCoYg3Ntk9JKdfMeBnE46Wt4Oj5QGR7XXeLieacp5BWnvfTYmEc
 egaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887233; x=1745492033;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vz+7rJLKk52J8xcxBS8V6jPxUUQa+S+ay0i6P14+Mmc=;
 b=F8H4k6akdKECBPk9BU9N7dBflPlTg4BQtPTI7UhrQtr4C+cYhjtobYAzxz3l8mFrZE
 +flEosLjek9b3jYuYm40hxAWK35nP7wR9mmiJbL3YC/vsKdBfeZmDRqI3u7eQXcWtvjp
 XzIymBtGPgo2iyUJEem+5RM7iSrExV6O0zpVfSTkF4VUTyYlFaqDazXAk/SYhM99olrV
 9tiHPChHyp542oGG+/AJhKLeUQJPdUIYHgQaFs7lCpNs+xQlKfAuJxEJ12F0tEgc8WXx
 5yYP0uE7Hh5pBggZWLM+AFddOkj/Ti2hAAJOWnFr71al4UwIFLApgAXPKt4Nxt6nEcci
 I8mw==
X-Gm-Message-State: AOJu0Yznw6xYodh4C51KJUB34DjWvz5KHwR4yeTlNCALZsF26gja+H7w
 cxTtmv0yaN3cPmxk68xlQZ6yEDeZg+/qAuhaIFmRgpeq8WV47ZVOcyr3EM+G9+wFO6ngdoJraok
 GxrnANm+5fGb2orr1E8HaCTHM/KaEnNdQrHQibgxYVKoI1NAtm+i/G92PZwvYlq6i0ctOgwRwnZ
 3z4Ir14iX2lVykFrAlyD/rN8We4pc3kfhKBA==
X-Gm-Gg: ASbGncttRjxayQjBnrtOA8OAvibS8lCPlRjMbMXQbxewHfuUUhz4POm1tWh7NEw4Xe3
 Wn4EGD2SPHz7piF/DCLC0xkrE6/qGGfBbdaLRSPSZd0ujC8p9XG/A1MFHyviAP+jOKRCxSmJ6g5
 +QQEoEDtKel7iSJhh6buQaixIa2WPInOeGlscyfgnrWbDdsMTsg0scipBOxK1h91PpJMQfgoTLd
 cRT2PXrvl8eMf1iR7tKfrJeiBeQBsiNpyllZZWNEeNPgxfGgpn05Yck7kFwgJshf+7wzNSlrOfd
 W6FOo9dEPoNaqx0Zww3EP/aAwrS9r2wwMjhOkC1N1UQ/Db8mrs/UOo/vMjJinnI=
X-Google-Smtp-Source: AGHT+IGzltfdtJbSZf8YTPoY/XTmtC7TK3XCLZHrCC3bsXH7eK1800buUunBw9IuipQn8mMusQMVOg==
X-Received: by 2002:a17:903:11d0:b0:223:635d:3e38 with SMTP id
 d9443c01a7336-22c358db3f4mr77653625ad.15.1744887232614; 
 Thu, 17 Apr 2025 03:53:52 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:52 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 09/18] target/riscv: Allow global WG config to set WG CPU
 callbacks
Date: Thu, 17 Apr 2025 18:52:40 +0800
Message-Id: <20250417105249.18232-10-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62d.google.com
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

Some WG CPU functions depend on global WG config (like num-of-world), so
we let the global WG config device to set callbacks of a RISC-V HART.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ac50928b57..6dfc260a07 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -500,6 +500,10 @@ struct CPUArchState {
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    /* machine specific WorldGuard callback */
+    void (*wg_reset)(CPURISCVState *env);
+    void (*wid_to_mem_attrs)(MemTxAttrs *attrs, uint32_t wid);
 };
 
 /*
-- 
2.17.1


