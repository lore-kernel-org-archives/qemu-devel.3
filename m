Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9ECF8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrs-0006li-5m; Thu, 16 Apr 2026 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqc-0005F9-LN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqa-0007my-Hn
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso75723585e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331035; x=1776935835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1UBtdWXot85r851npBWgsMYIWpNFBG1/VAYhlAZ/Uow=;
 b=bFRpDNqqPZYHZ5vUtgHqA/84cui3rGXDDU3R3kWl9bICvoK2gCyApFtRjrBWCd8wcW
 pcbyOS/G1HhpYo8Uo1UaUYJ1k1s2uoszOGhEwFV4yZ8CmXFKZfH8HpEEoGOAJborYDEP
 39IYp0CaCpMMSWRU/g8lDYMMzbMGFY7Psp2vBEaaAAsGi9Owkf+QoXO2lzEsqv0qKHQJ
 pI+yNeduHbA55YdHGZwMoYfpiGgdzr+EKkd1q7f2TEshYixDlBKKBP2mO1NV9HYI2SFK
 0+GIEi7ZTqc9R4qufvLI3h73/ZCrUO77NMtljypAZoXzxGo0QA4CuaBX8fet+VocHDrH
 InNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331035; x=1776935835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1UBtdWXot85r851npBWgsMYIWpNFBG1/VAYhlAZ/Uow=;
 b=oGtTsvOuwxYRPIvIduasEN9xD4AEj7OOICFw5MIZz2xA3tlnStNl7+8srvS6cB439h
 1NuVz7vcMc6hzjFKcXYEWsDIeztRQvuSiOsG9eCPdP4saYpGapwNuRf+6FSROTExSZfE
 7SpUiktykhgzEu0NJIOCU8+V03CdDUVtX0oPASgM3WEqB7GEugu4ZdT9iMxyKhwmfST/
 ShvCKr8BfxtqsMKn6xofSHJkm9o9PiplgS8eKpdb/YQ6HvzO9K1/1TNQ2GlvRIEI1mcz
 jCWNcao7RvWtsSmjpkkkCaC6Ty8YVEblsU7ATQxydRETFZBDXTnUXSLZUci1HalJQas/
 LSTA==
X-Gm-Message-State: AOJu0Yy3Bi54FEwsDp3/5nHDtg7X90BEodGsdL8tay47I6XDsoyqSHpE
 lTsh3PK9yFdkglRGYW3YZY3OH3++R9Qa0mQuDtda/yt+nBFTQHzv1qgG7iZFh0B7NvL9IgtTefz
 iIgisPjo=
X-Gm-Gg: AeBDieuKCaqidmpvVLOWfhavKeKpZT7f5RFpX6GUp3QZIdprJ7fLjjM9V79Pmp9x/f9
 lvSy1TF5CEs0mosgiTT5USZDsr1iXZXgt6vIRPMV4N34yh8uqVZYrYtOJ0GnQdD/SWazsHZlKW0
 J6Sc8EaUNvQ8THWcuLWrmDmkIDStDb2peKY4A3/FC93qla6A7Kl9ER8C8ceupLqQNu15FBis5qL
 RGN8ofJvza9/jiq9PAfaN40pjRm3siTo+GQJsIqs4aKWcki/Yzdl73XOPzu0vw26UN2sfa66vax
 wMr7otUrM7PwmQVXINcyJuzc9/7FyfOlA27uBSPUb1VSEsorEVp5Yr6HcnBhToFx0C1L7hqhM1n
 ctkOfkqtMh6b69cmIFirFDNL4yaqTRz9whcvQqzbxKHrmMLWLrPBFYTcxhOG9iSAA5AUf3H9QHf
 vU9AyFMRFOKWhO+r+tgQTQcZaT2r93gZKOnfJW7bJBOotXD6LMBzRw3qO5y9ulayw3BUqsV06gv
 v7Zm5R3H2Ax4R2HhiisAYtLkKkCmpLRQhSu4EmpZg==
X-Received: by 2002:a05:600c:8b27:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-488d687664emr326299445e9.17.1776331034810; 
 Thu, 16 Apr 2026 02:17:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/28] MAINTAINERS: Remove Qiuhao Li
Date: Thu, 16 Apr 2026 10:16:44 +0100
Message-ID: <20260416091654.316158-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Qiuhao Li has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c16a726cde..fae251a642 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3606,7 +3606,6 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
 R: Darren Kenny <darren.kenny@oracle.com> 
-R: Qiuhao Li <Qiuhao.Li@outlook.com>
 S: Maintained
 F: tests/qtest/fuzz/
 F: tests/qtest/fuzz-*test.c
-- 
2.43.0


