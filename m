Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ED0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtSv-0006QL-9J; Fri, 01 Aug 2025 13:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3M-00037b-CY
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3G-0000yX-0r
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b7823559a5so1335117f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063527; x=1754668327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oirmS+SjrCLZzQhC+0iWfATmWhPBgexkPGpM/2V1o2c=;
 b=J6GSg2E6hpmAFIHuqS17d1eilb3THXxgYSNkT/N0jUUkhKAwHgFkhuGwmHbUb2MGyn
 GFer1Fi1vhTTuJBaUUVjKGxXkTmgzXORmeQgQ1xo+46Q6VNVZMlGD6/YvvMcIVGHS7w5
 G+BMLE9MbciWR/01vVPWyg4Csv+VKWDT0UqZpLwHLmIkLqmPmj1nU8SJb32ByjNWgDO8
 uGoBjut0FUAGsvijsZy8pLtwkv5t3agvRii1zp8VggAsNSEp5XQvFAWHqY/342kh+Vt8
 NPmZB6si2oDA1wn63FNcRKp1FjF9L0LmliVxrARH4oG9AagNUHJx09LwLsiOAazWnYoa
 09OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063527; x=1754668327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oirmS+SjrCLZzQhC+0iWfATmWhPBgexkPGpM/2V1o2c=;
 b=kFWOYhBRLZ+8jhqHCuKs+OlwwCc/Q7fSkDWL45ZcMKaEqM5P2Kyv2AkdXkGJxkA3zl
 7xBU/UwoHzPYKvJ6PGNv0NBUOXcw0GDhpmeHpO1kSw7UKBjUDKmuxRWDqKfuCNE6e5QO
 JYBAWXTdH7bgR47vhqX+mIEJ/UF4hDrrQc+7itlFuY2RDgZDl+omnNPtm9hqimAh3vNh
 l+yE4Sqzvv552ugFR42QtM0HmaPbJfWIKwhxUZifUKnZufIqzre4aJvrSYEeQ35huptC
 2ItWKUBFrQr8YAceNqbBjlejp7xV5GcmZ5gl6km6HTyGo1MIvVCjNXUQNHsbxUD+n1Am
 CCjg==
X-Gm-Message-State: AOJu0YyMEcFn41da8DmshkbKJHJJgNHUTcoiGM9A5JM7odoYi8ndvWFc
 U6vXEYSErRtL4lKeTcXlq4AhtU7VtYpzfVDhRWTmiXgshxI+AFNti3jlCk4AP1hhNewzKZsZ2+8
 2SN0N
X-Gm-Gg: ASbGnctjuHEVuG1Bp2O1Tyeefo9D3PKDRYDgtvuKC5gyXNMrbeM6sePMscfKYIHTfVI
 2eeWTNXhDBPuBXTmTjPug00WgzIHPiJCWOUlnRWOslO+HOuA9oSQj7daAfc0JkfYzAbRRfRlRK1
 UTC80DyH1pbTzYWh2kv3ZapksYMSM1JQunGx+05mmoBPg1NGxxkXjy5wazdonGN1QF0f5taLmdF
 jyBTEButKXZ6hjVCpnJpEdIvFRHI8GoTPueqjdFWqTWuA1v+OQVcHhUhtLaJH7olEkICOb3+rsC
 J+OFg7MAYAhKi5vM0WbOSPvNM8dz3yRALjYnbiznNA8VSDZe7cBohQ2tgF1czYMnx5Jag+eYsG5
 U+caob8Tv163In3ZYoPCPHNCj/3J+vCTYCGw+tpg=
X-Google-Smtp-Source: AGHT+IHW0vOblllVcKa68jQyOFI0cWRD1HmFFx/yH7oYznBv22D84R7ZXbC5UXHLoXzELcANtSUfow==
X-Received: by 2002:a05:6000:2584:b0:3b8:893f:a17d with SMTP id
 ffacd0b85a97d-3b8d94d35d6mr178504f8f.49.1754063527452; 
 Fri, 01 Aug 2025 08:52:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active
Date: Fri,  1 Aug 2025 16:51:54 +0100
Message-ID: <20250801155159.400947-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Zenghui Yu <zenghui.yu@linux.dev>

KVM's userspace access interface to the GICD enable and active bits
is via set/clear register pairs which implement the hardware's "write
1s to the clear register to clear the 0 bits, and write 1s to the set
register to set the 1 bits" semantics.  We didn't get this right,
because we were writing 0 to the clear register.

Writing 0 to GICD_IC{ENABLE,ACTIVE}R architecturally has no effect on
interrupt status (all writes are simply ignored by KVM) and doesn't
comply with the intention of "first write to the clear-reg to clear
all bits".

Write all 1's to actually clear the enable/active status.

This didn't have any adverse effects on migration because there
we start with a clean VM state; it would be guest-visible when
doing a system reset, but since Linux always cleans up the
register state of the GIC during bootup before it enables it
most users won't have run into a problem here.

Cc: qemu-stable@nongnu.org
Fixes: 367b9f527bec ("hw/intc/arm_gicv3_kvm: Implement get/put functions")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Message-id: 20250729161650.43758-3-zenghui.yu@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index f798a6e28ca..6166283cd1a 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -295,7 +295,7 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
          * the 1 bits.
          */
         if (clroffset != 0) {
-            reg = 0;
+            reg = ~0;
             kvm_gicd_access(s, clroffset, &reg, true);
             clroffset += 4;
         }
-- 
2.43.0


