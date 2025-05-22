Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87385C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 11:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI4Bn-0008JN-02; Thu, 22 May 2025 07:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uI4Bd-0008E5-RA
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:34:11 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uI4BY-0008K4-C6
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:34:09 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4947635914aso82241171cf.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 04:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747913641; x=1748518441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pvtJvKwED2g/sZa1Pk53e57hJmDqDX/ksZLl4/V2mTo=;
 b=fa9nWotXASHcE/BB3lSkmxrgoDHp7wyE4wRgqk2Um99P2NvpCn2l2LS4JxVTbAaR1E
 RQZGsUgTExS+/qudrnQ0ZeBa4CNRma2qfPw4Rcuntlwgyuu9rQUJvD06R0/xDw0WmH8b
 aabQ+dkODmaV6tsQIYroL86Z1HTgJ6xCosemmHbLrZSN2dkt3ZXYTRtHPGaoMvkTE8lO
 fK7plEqY+6+OjU3+3asqmbICjsj+3YTg3x8N4B7BfWVkWoKVBZW+QpWGXam2GoodMzwq
 btK20KGy/kuk4RC6HhJk+eLWgeDe353oU82DOXBCw6bjZWLrKKy/oW/ZArA/7LDz827e
 YcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747913641; x=1748518441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvtJvKwED2g/sZa1Pk53e57hJmDqDX/ksZLl4/V2mTo=;
 b=lhI93aajEDTyAeZBlWpZFRzdQSoIfgKJ2ewbjdBFYJ79qFhCoGE8eyZVikiSzrAQgW
 MgF7aEfon9j8SAAc8IxiSKGTQN+VqEi7v8vSsNkJ67KWUigXRal6YDcErtRDjHI1I9EA
 pOuV87jQF5zxo4mLV4zd5EkyAoiF1HNaowA1S7LftDOC1k9i95xNyWiiodcucns1q/9K
 xJ35DL6H24Iscr7rlA7Gb7VzArIICH1A0tjgR1lnbSP0fagZWkO2FMBZYgX/ub/Oy0EU
 PEdigdXjMlwxUgfw4po4XfKqrBsIWEQbMWoQvg8dhzt0fwQqcbnq20bAn8XGr+lirJzy
 vk2w==
X-Gm-Message-State: AOJu0Yx1xMW3VvyCsT4iFE34PSHOJ8FzSEAVEUUn0UvUXSMA5j2wP7qd
 ESX8RlODi6zX/Oap3l2jzsKM/3YR2UI1gOhWhzRDc3h9PZbR98oZA3FeE91FgeKfF7cfPDWBo+d
 uIYWR
X-Gm-Gg: ASbGncvbHymWsRKfwiahGWSfSLBJKv3meya8ukA6KuY2gu0OFDPPVt+NM1/F16tydUm
 SRtCyyVPcj9T3gh3xRPRNN0Vh33ZblRhUnb6e9OSFgtkiyEhLLbysg2Jqah1s9klBIRjSjKTNWl
 ijWVWL8dww8S1oOktunBmfliMc/4YNRYWiF90aiL95q/IS0rX5fen2YQ+PQvRew92Uc15G4U3gM
 Oo8uUx9ak3fbmKnrDcjWUGG77nTR9dj6OihbvKZ/1NJBuwAqFxxnjhE83bZUQipQjpUmuA9K04a
 D+EaijTry50T+2tb5baloZyswVzUpuRqsrMk3N3JCkuBplxRFVo18pA=
X-Google-Smtp-Source: AGHT+IFo5+kejL+1q9pTU9z+PYylIyDVyGojvS6ukE9jY+rlX+f4ftGNkfHM4KjSbiiKIPQWGIQKrQ==
X-Received: by 2002:a05:6122:88c:b0:52a:cdd8:fc33 with SMTP id
 71dfb90a1353d-52dba614e02mr19310817e0c.0.1747913630748; 
 Thu, 22 May 2025 04:33:50 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dbab6c0c2sm11514466e0c.42.2025.05.22.04.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 04:33:50 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH] target/riscv/cpu.c: fix zama16b order in isa_edata_arr[]
Date: Thu, 22 May 2025 08:33:44 -0300
Message-ID: <20250522113344.823294-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x82a.google.com
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

Put it after zalrsc and before zawrs.

Cc: qemu-trivial@nongnu.org
Fixes: a60ce58fd9 ("target/riscv: Support Zama16b extension")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..fe21e0fb44 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -127,8 +127,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
-    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
+    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
-- 
2.49.0


