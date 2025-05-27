Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180A6C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK27o-0001Id-BI; Tue, 27 May 2025 17:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK27n-0001IM-LN
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:46:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK27m-0006ge-5z
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=WQxExaAzIIDN1D3YOjeRqRgj8jTMXSxBSNMEL4Vz93I=; b=t8EUyUdxPTGTuVXcwwsN/3olAb
 N4f5n8hA1buMdvKrm5LQhtBRo+oD2+jDUpDZtpcEoJCb14gIH34+AEihjeSbaY9NSZTDYSgneXwnM
 FwS0ov/9HvCwbFSqcvNnO2MEJkkMjGtOnIF0DbAc+xoej74jzN8ru4NMCRpaPpim+MWoo/9/CL8BU
 HIJwbpsFcPdlckNT9intRIef9rj0gU3PLG438YyLBo1790KeFRuHbMrFB3Z/LFni4q6QB57BR/oQg
 GNTZWa4jc+89vCuWM80a8F0kx+ssVIcfUHcf1h00cwOC63tennYYMJDq8wwtl9zToGEL5MKyhy0bt
 0Q30q22G6LCbRkIpw2io9H5xZFtXVMB1tGGyyKckOg9uNAwr02sW1K+aK+4cJJJUUASNCD/T19l/y
 Db/7OdWXy+vAeGjRmv2zWhGRW9nrXsJSbgNv5MhKwpY1PsBfc4EpU+djCqIyGCD/4tkV2990KSUBB
 FJihRto+IxWDkvPk6dwXy9f5Elw+OkWv5TJ3P7R4+xbl1tNd9pwg40VspGDgUPglBJOxB+SKuIelO
 pkgc//7SnVasd0NF7sHmnRSpEHaFzBae/ODZBybdkPfMZ0ZnJHhSJP0KKBczyqhAxw3SF0Vy0JOx/
 dU1MzU3hIfA0ziXMNnBaG4gnlyYkhb0z9s4IpaPh4=;
Received: from [2a02:8012:2f01:0:7607:4cc5:5176:1da8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK26P-0002hf-Do
 for qemu-devel@nongnu.org; Tue, 27 May 2025 22:44:54 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue, 27 May 2025 22:46:05 +0100
Message-Id: <20250527214605.350903-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250527214605.350903-1-mark.cave-ayland@ilande.co.uk>
References: <20250527214605.350903-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:7607:4cc5:5176:1da8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 1/1] target/sparc: don't set FSR_NVA when comparing unordered
 floats
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Clément Chigot <chigot@adacore.com>

FSR_NVA should be set when one of the operands is a signaling NaN or
when using FCMPEx instructions. But those cases are already handled
within check_ieee_exception or floatxx_compare functions.
Otherwise, it should be left untouched.

FTR, this was detected by inf-compare-[5678] tests within gcc
testsuites.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Message-Id: <20250425093513.863289-1-chigot@adacore.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/fop_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index a49334150d..29fd166438 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -445,7 +445,6 @@ static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
     case float_relation_greater:
         return 2;
     case float_relation_unordered:
-        env->fsr |= FSR_NVA;
         return 3;
     }
     g_assert_not_reached();
-- 
2.39.5


