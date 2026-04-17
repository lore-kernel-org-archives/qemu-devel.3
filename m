Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59398F436BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn37-0007PE-4R; Fri, 17 Apr 2026 13:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2b-0006tX-E6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2X-0002DQ-4D
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so668442f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447094; x=1777051894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaHo77KFkT8Px7cBdcv5JOj+A13ipNoa8Ob819EY2bI=;
 b=tQGlt1GZEojDuX9Dg/lQDy8T4nru8/CFiRct/cnw/92Z4UegPtrB2okmRUI70A6QhL
 6Lxr/3LFPOLQi8UgDCG03xA0fRvfN4zta/7D80q8pk1UNNXr1glWBXcfhfDHElwEKuQp
 vwQXAgK2Pwvf+FtgLTVe7rEHHRpxDsL91R+AQ04Vg+FRdjnNW5o/KwSzHWV365Fu8yLP
 CZeh2/CU8ekuuKnGNqo02PmbonGAGsUmFPurZNQdNSxry99aaNlwC8zyeBCAww7fZ3lF
 ttOgT7xrv2CuYfB9q3HSBHAS0dbE+2Yc4LhbAt1nCteiZRxzXyvDgLfxLt48X52Ofh75
 nW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447094; x=1777051894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DaHo77KFkT8Px7cBdcv5JOj+A13ipNoa8Ob819EY2bI=;
 b=Tyz5RPOX5FVbTQI3VGy8Jlf1WysfXJeCMOAxf78uGvluOkZBB1r4tPQXM4uLVsmW8V
 eCo6c2U98frz3yMF8rdcyPnqlVhoud2TduEqX9ycZ2I9uV060ZS0iL67e5rwun8dMBK6
 +E0e167wMY56KhrviBazfe/gaQaL1uKbK6aqc+1ouwYd9uhmAoF0NHVadFD0SzAC9bY7
 6SCeFDxrzzeCX/McPWJzhz9Y9MUbzo/cS+q9v3rq6YEOpU9pQ4JRxD2N76vUpBSIUvth
 F2o/xkgUtdjmLJFRJejCD+pJ6oLb/yluILcnNPJ8EKQS4GcbR+oHvi39XZ7WlPbkI6+L
 6GdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d3fDeD8BAbgBcXEEbPnC9NA37IxZX7I1wjNlP/41f4ssScsMrsxYowOp3dnhhXtKDrJWkGpQGnoIP@nongnu.org
X-Gm-Message-State: AOJu0Ywh8Kx4NcX5RLB9E9k/0yfqXhnYwRaukvp3aGwwPbNDyUpMBg51
 FlkJ0p32Xk7vFWIbvrXZ28IV2qn5CpsXaWkkqZIrJjjFM8Odjs7KRrP7c/usjfJAkF8=
X-Gm-Gg: AeBDieu3azdZveT1spGkx2NQdA7/ol1HfmIgI+bTVRX+a2SWnH4qyQ0D7foG+liQibp
 9kS1iXyulBNG1eCkKgL1eeFuV7B2FEnz4Ei9NOITwXnRAWb2saDPgiAWAbxE386w2SylcJpaUTL
 1A8RcMecaGwBR9+ld5TANWBOi5J+tTIUTvrgkCjoO6GTPYwRx+B13GfUoUX6QNKohrzNlHWh6oi
 bh5YAqIfZnawcZJF//cGxEgxQSFo5dFW7vYgtlL+Ae+xmTHkcKtHR3aDpct6zZb6ugXaz3GIJwC
 uUgy7lx8acXrvY1GU4HBYCbJ6RWdH5DbRnPV9s70dNKtjUJpJeUu22xOs2djJEo2iGzjp8qqPqa
 C3fWshca/tfvDQjTsD4+P2+gbL0aIyrE72jPWeh1OgDdi+JqpnutG3A6cmNeJbpQf5zUVaq3+s6
 nC/SSnet3ot61vl0H/2Gx97zrDgd228f7i74PMSbC3QiSa5OiAPvZjN4KUokxgJXKI+Xre2N6qY
 vPowOxs8BYE/4d1bJ6yTLneR3oLsSzUWfEO+OQkOg==
X-Received: by 2002:a05:6000:40dc:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-43fe3dca95cmr5737764f8f.11.1776447093977; 
 Fri, 17 Apr 2026 10:31:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:32 -0700 (PDT)
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
Subject: [PATCH 13/17] plugins/api.c: Trust cpu_get_phys_addr_debug() return
 address
Date: Fri, 17 Apr 2026 18:31:01 +0100
Message-ID: <20260417173105.1648172-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

In qemu_plugin_translate_vaddr() we have a workaround for not all
implementations of get_phys_addr_debug returning an exact physaddr
for the input virtual address: we OR back in the page offset to the
return value.

Now that we guarantee that get_phys_addr_debug returns the exact
physaddr for the input virtual address, we can drop this workaround.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index 4b6fad4999..c97cc68882 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -625,7 +625,7 @@ bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
         return false;
     }
 
-    *hwaddr = res | (vaddr & ~TARGET_PAGE_MASK);
+    *hwaddr = res;
 
     return true;
 #else
-- 
2.43.0


