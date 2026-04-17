Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F5FF8DFF9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn3D-0007aH-Nn; Fri, 17 Apr 2026 13:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2i-0006v2-GF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2f-0002N3-0b
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so254989f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447103; x=1777051903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mjdw55nvUmDEoZC6Zfcjvd3ZPIFn9XfgQXXNer13HYA=;
 b=sz3z9UdOQD5jqbwweL59/qtGEIowTsxd5PXnzmESRR6dZGdszmFLUByU5JWPh1aEkJ
 8Kc2ok2qflCZkJC/eYGhYSZanS+aa48ayJSVbjYE5lM7xeUJxTnTLRIGaT5DgrnG4FKj
 b5tzB9G6+lSA8Y0VLxI2PRxHduTCjUJ0IiOHAV25ettwt/pkIa4uYD+JLkipSWlqYzv1
 wWRY8BuHSZlT7huvziV9buSX3b8rfP9enFLVAIuZzlVRonOAy6jRfx+RNHm8HZsSEJ5C
 o1/GdwVQZ9So9eLsyzDROhwHtkeaHnn4dKAqyV7MUQA75cShJ/MMGOHDsWJLfOT7bRiq
 S2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447103; x=1777051903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mjdw55nvUmDEoZC6Zfcjvd3ZPIFn9XfgQXXNer13HYA=;
 b=jZ1ZQ5kLOJlY/3AnFZcPba+nirvqgCR3iRgddUKsVkhFY5jRjbek3DwA+QnQqTCFU8
 NnbCOWeF9RIxLX9kOrz0IIiga/5cxOCspvhRJ9AUFOSb903Ci/nOzhOWW/gkOKGHSA05
 Snv48vjhNZx8dV38p/YQ4VsHDkW53Lje2pkfqZj57YmzN9fv0zhtnAgxlcUvd5JdHPji
 tU9X9ExcUg5C9nZ7AqfoSrTi8BEq1/zWKRdDMXrmyDkSLMasS5dygnULfJW37B9wawTs
 J7P8Q7G+55fBF1AVXsPG06fQ++S2hDJLjgxDuQVGW3kWSXPplkL+7EHgEXs95jDLus3e
 02mQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8njdpPZh/LIhEGlesz9+OxNZkGIt2//Cl2dmgxjxl9mWuqPmBzX6EUW4t8JQIGD7jKX64a9Hh+tCkw@nongnu.org
X-Gm-Message-State: AOJu0YyJUfp+UrBt87jjfoKblG1+Mys7uF+oIbh68+cfHd2n2Szxs9gz
 /fNnwH1yC2g/Mo2yK25o4QuaVKcJkk3+iFvhVEQTMiwEjVJObaY8T+/XGNvCVKqnTZM=
X-Gm-Gg: AeBDiesqiHyE7FuCrVt6bcGwFJUjwbZVXF2EiW/NG+4l+7Vb91XvJ/KFMGkIHwbxPOn
 UPsHato8+h9ruTO7P2usXs/YMBn5HiEfO3q1K2gqUtVPRNMMvSjKGSCPbiy9ak4h4+oiC4fn1py
 RwMqZP4OL1DLnkg5Zxq37Q+155xxtOPcAFOEgoZSSyzok/wIEIygrf69XNJ6h134v1M9LbRhUCT
 WgMVM4iyrRkFcgbAOrzdw/7sSDCqH3fHVdc0zQOxlYDnzs0nleAlWjXvytA5O1gtL768Azl1q4F
 piFVIJKDyESHPvQRgWX3l080bEno8FDLzorauVM+sTKnn9jrx3csUgPnopRlQN/GPHVnS1Llhlu
 CldxG7pSS0f0BW+SjJyHrzjbH9taxJo9BRQHsBh7idtKDthd8W2wtQyISVCzizSpudD3L/VhQeX
 9CkHKcNb53BRdome68tl0/HUpqYJGngw4EeeesMniLWwloxhk0aeJGeQ4PS/uRR+MQ8SSxMBarI
 6l5K1eyz8DapxX1Q1e5ETX4BJIJ2EKmyXLjlUkRFg==
X-Received: by 2002:a5d:584c:0:b0:43d:7403:4b57 with SMTP id
 ffacd0b85a97d-43fe3db3ca7mr5903786f8f.10.1776447103468; 
 Fri, 17 Apr 2026 10:31:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
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
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 15/17] hw/core: Implement cpu_get_phys_addr_attrs_debug() with
 cpu_translate_for_debug()
Date: Fri, 17 Apr 2026 18:31:03 +0100
Message-ID: <20260417173105.1648172-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
---
 hw/core/cpu-system.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index cab65d549a..be5cb48126 100644
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


