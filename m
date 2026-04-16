Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D19F8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrw-0007KU-Mb; Thu, 16 Apr 2026 05:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqm-0005Jd-Q6
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqk-0007r8-Mc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so57674825e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331044; x=1776935844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DpqzcJ02jyhh4/DQ2bfF9z1miqmpX3vgPj8B37TNWhY=;
 b=yW9cuIp4PJw5v7lD4+6cQvMZWV4WupB6MDa2dB2aTdk5tyaMDulITK93r5JEpp/L+T
 Dxy+BQClpnz91gFAabMnmgBi72RU+CHhAmvir30ze5O0dyf+1ejdwsyBgjXf0155nDr5
 ZYWyG4/CUpZEpLGiTqNA7mOJl7IxH6KY4vmTy2m+3tbMpbnIx4T9P4hj24x5876Ad/yL
 ckLHwOdRXN+5J9IJFsFqY6gY6MjxeGTYL0BGR4h+Ngj589vtF508hFduJn1cWpsWYNiN
 bVsRWR8nZOFU07reYVWmMO5RYXCqgn/IeNKOjYzUCXEvSHgfGgvQ9uRWxSgKRoNRCcmt
 Vo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331044; x=1776935844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DpqzcJ02jyhh4/DQ2bfF9z1miqmpX3vgPj8B37TNWhY=;
 b=HZMG/YAjsAMZ6vFhGE9CaQeL6lDA0nevKu+Obhp2lqtmrI0BuC4Clf42H5LxYv4H9w
 VpMTgNo6SYU83gJZVr7ybZMWprC27ygTXs3C3wwz3c410wS8lbJNV/iuTvEP7vRlxnRU
 PTALsDKbpZ1icT+MssGPuoCycDm8lrnblFQoWM6BRHgCxj0AsQINYRNv+ntXpCU47Ck7
 0pAfmj8WmbIXmyF15v7lehg93ZFvhPpchbCvncrUy2R5bAX3G48m2louBqitizVGvsqG
 NSv/R6g6DMRq6XJerpLQts1cl8/6lGhT4ZZ5jnyPfQaGSNaxtYlrtl2VCQ3KGBDRs2M0
 4xkg==
X-Gm-Message-State: AOJu0YzjR54j0ovMOTdR6gwaisUpwAgG2fvUu1+7PtdzQOco0/zdSSbl
 Ofbfzr9KNltVETY+vGPoD6NRLHGHGKurTXvRVbkbZz9aX4CwPT+Hzpnm+SNVa2cbtIQYujJTdoA
 HQo9NxfY=
X-Gm-Gg: AeBDieuIE44jv6qU53JKM2968OEputK4U9INbXpxSFRmQfoC3XW0JulMTHd4DsMraKq
 VKZGJ2p+2CawbJHY/tJJBwtnqhXEC2GIhQnsV9MFJrrBjfHA+201BIG7/0Ot9+coMJBGbi8aocJ
 w0MtuuK/buTg8/RwO8gXDkuAQswx1sl8pUFUCVRRGuRqIS7MIq/gtfIzr2Je/Vbuou/O/dPmttH
 0NikU0AKn1at/lhIY8Dnvqt/9lBdkJlCud/X/lkutktGbYS8bk2cCb/zVBwxBu0pu/LG04ZThPv
 i6r0w5/97ZmtqpmIVWd+yGwhyOn44eOn+tb7/q39G3Z+F9x8CKRsaMeCxavxKWkD6IATi1grs51
 8ZduZEWTo/xA8nXOulQXPUdctBYFBLUIaB+oqB/+eEXSNt+rodrd5ZijfkcKsn35u6FDl/A1YQn
 Tu1LTbqRkqiJSDdd1Dn12+KiMC60KN9CiDRyKn+HcCTNADdXjqTpj1KT6/r3hIMz+ErE6jUX9l7
 DQm4oTFn4VRAkGKPcvx5uEb/PuRCf5m2JmvWSKsVA==
X-Received: by 2002:a05:600c:64c4:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488d686892emr308522415e9.25.1776331043981; 
 Thu, 16 Apr 2026 02:17:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/28] MAINTAINERS: Remove Xiao Guangrong
Date: Thu, 16 Apr 2026 10:16:53 +0100
Message-ID: <20260416091654.316158-28-peter.maydell@linaro.org>
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

Xiao Guangrong has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81ffb56c31..1fb56bdac8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3318,7 +3318,6 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
-R: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
-- 
2.43.0


