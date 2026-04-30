Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479EAFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrG-0005MH-1T; Thu, 30 Apr 2026 05:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINr6-0004zg-9n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqs-0002eE-Li
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so374490f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541913; x=1778146713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/gv/HytlUcW5dY9i00lhaI+5RvkDtcY5NICndqocfw=;
 b=uQMQ5wVPJRWQsq2VijeMwbzuDJU6BlvL3ypHngn+llroqhJJnX0l9J1Ehv/OS1FzKp
 cvkGDX6foL3TG3mM/Fh1L6jxrS2N+UFdM1P+tu7Rz+UqlHy6jzENZKFcrFA6qsXlQlKp
 2ReA6vN7tsnFN5nt9KL2Ux82HoOI1UdaydN3r4dsV01bijoo/rlvaEKZURPhoxAMbAHb
 HiBxZwP42REzXrHfRC2qBQDisGU/6rl5VLh31yp9rSjFO5DS85UxK5Ht80zK9NIeCKt4
 KK5KPBMK8v0/q47PEkULPOZlP1ROEeIDHIip1vBE5Xz3/cfbn1qpqrcLJ7weQa8D1jnz
 X3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541913; x=1778146713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/gv/HytlUcW5dY9i00lhaI+5RvkDtcY5NICndqocfw=;
 b=Vvwc4cswLCw0Vy7OJzh3YyF4qrlziqbUeBJbr78DicEyUefKijCr4bSwHMfj7UtjFz
 sYU1SYIJYuVv/I0QPGOJyBYCErBSUL/YIuuF6skbMoTTkJN7ulMLCyi2UujSEmCnUxSJ
 lEBBKaCqI/68W9y0AA1x5nWIi3rS+wYgLxBTGOCCUC2jPKIbvP0KiAMyAIYIgOrbmG8q
 ZGm3noLvsHZcCjDiGngV7vmO++f6QcuL8/SQGS1SqTX3xLIWQSCu5er19H0Igd8z7A5d
 QHj7Dgk0tggeLaF4cSGS7QlSK17L0t76XnQd51lT4fbaWZVPJK/KM/zZfS+2tsTN7PJJ
 53JA==
X-Gm-Message-State: AOJu0Yy8jqm67JPwG7gBQDpLfeKmSfzzW7xzVhKb47FXtGCOExVw2tL7
 ZT091QPgiapTiLEroCwuUrV8eeZp+5DMznd6DkN5nQxvTgqmVyhshW30G8muNIAOk8HTsU2Q79S
 Y8fV/
X-Gm-Gg: AeBDieteywDDAi2zGTjGeFKAX8/YBG4ZlxbJ+WSFquRrcdPLTAQZurV/uGkwepPYHhN
 lnfW0O/CIKKwR9GgE0tOsRcYoVYVFN66xqiBD96O5VWNm5mOFkzm0YJePX//LUtIxlmsV6C+pgB
 pzGzmzQH9hh+eHdORgtt0bu7NFSximxJ1G0lgkhk7VCfE9q0y1Gg+qY8u5rMNMV3lsGTS6nCrSt
 tSToi2dWiB7fL6tcj3WP6VkVb4bC6MzjytptA5LmgShjIQpGliK4Gcdgd8AOmOPeM6zOVm1QR3/
 5Y0Jvu0MrgRwQHVdnACtKBAhTKwXXLy601c8WKykYo0VJleD9Ru2OB6ACW1opguUZPBibVhzrGk
 GeuUAXCmLrpB4z3KuQMqQxlJbjyEjirQcI9FwHm0fVwRdZvtYc51R0nwNTpvCh6FNBwAhx/30h/
 Bn3WzF004fLD8RGylalY52IpD4rB9a6bieiEH5MCLVat4YTvxdXRYuj8RloDWkhI5HwoPcdt37g
 hcH0D0op7FIIqZywXR66ERGJVS4NsFCavpy4XPXEQ==
X-Received: by 2002:a05:6000:40c9:b0:43d:9bb5:bda5 with SMTP id
 ffacd0b85a97d-4493ee4d4c5mr3069153f8f.40.1777541912845; 
 Thu, 30 Apr 2026 02:38:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 16/25] hw/core: Implement cpu_get_phys_addr_attrs_debug()
 with cpu_translate_for_debug()
Date: Thu, 30 Apr 2026 10:38:01 +0100
Message-ID: <20260430093810.2762539-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement cpu_get_phys_addr_attrs_debug() with
cpu_translate_for_debug(), so that CPUs can implement only the
translate_for_debug method and have all of the wrapper functions
cpu_translate_for_debug(), cpu_get_phys_addr_attrs_debug() and
cpu_get_phys_addr_debug() work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-16-peter.maydell@linaro.org
---
 hw/core/cpu-system.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 252e90c8fd..954b81931d 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -90,19 +90,14 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
 hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
-    hwaddr paddr;
+    TranslateForDebugResult result;
 
-    if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
-        paddr = cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
-                                                               attrs);
-    } else {
-        /* Fallback for CPUs which don't implement the _attrs_ hook */
-        *attrs = MEMTXATTRS_UNSPECIFIED;
-        paddr = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
+    if (!cpu_translate_for_debug(cpu, addr, &result)) {
+        return -1;
     }
-    /* Indicate that this is a debug access. */
-    attrs->debug = 1;
-    return paddr;
+
+    *attrs = result.attrs;
+    return result.physaddr;
 }
 
 hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)
-- 
2.43.0


