Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B0FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWeg-0003m8-R0; Fri, 06 Mar 2026 09:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWef-0003eq-76
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWed-0002JH-Jj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48529c325f0so2588325e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809190; x=1773413990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cCN+SNdahMWTqcQKACyPmGcrF0RK5lEl6zLjOWcoCMY=;
 b=n5HVz/rq6nuEtZtCeaENXPm6YkbzoQRTDlBF3aOjWZWYOwVojCCwWVLsWP5rbpD/tv
 j3kceOVlKag3VzaQqQEd+O3bV1Py7wfL0xdERTL35Sa01BeZMWC/qWFAVJvZGyTDHXEk
 Zqj94nXMRzr/9QD29z16xnCda4kMI9SzieCGxOkLoZUephdT2tjTkpAY4MHSr1a04Xpv
 lgcrW8GBBQBqUDDJ9SrdCMAUbFclZuPRiNaTQYRYCgnLyXOKVhq/8QgG8MtjvCS6a1dv
 ONoJe/E6sQkZy2hxvHTf1//TLwI6WoZ2JiwGq7fpJ2cgpL9c/nJyVNFkjRo1KlHpLaTM
 Q75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809190; x=1773413990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cCN+SNdahMWTqcQKACyPmGcrF0RK5lEl6zLjOWcoCMY=;
 b=OWSyOuzD/pnKV4G/Bn0roph0IDGv83BKd776+K4Ki7ZKgDMTWbPK5OGjUMslvkrFmB
 SyRT7SLFJbNLQo+9aL8Pb3qZwZyuwhAMER/qLFVnt652IHXzkxBWge1fAh8xpRmLA6Dt
 bz9scU3FLM12W3vQOnaUn2886T58oyf79o9OstrNcF2jQaNUGWAaF9ZYqsXaSh9LRwad
 x2j/b+EyMKB5OSBpV9ujfVQq4mvh10lwKk64kNk0eBCrNhbmrnET/vpsijZVqB630hhz
 /jeE0InqINwmoHNUZ8TqOGNENn+pazKxiR9BeHxb0VOmvUyQqCVM5TLz71lkkh4dygj3
 bCrw==
X-Gm-Message-State: AOJu0YyzNAxGik+qctsZykxLX8OOZLkpBAQCnv0L2Syuj7stJmbwdmM1
 JBoBQUEavjTA0BW+DkIGk01e2QTvBkjy3vA8FKAkDZTp4sirzJ9gBHnY2/GwcBGMAgmHlf6JeeV
 XaLBs
X-Gm-Gg: ATEYQzzK4UKyVGM1dISqiNJRvGogDySF58rxCooBTOs2lkWpZEEdBRqw0AJj1P2+G2z
 BH126PKWnkQtN29LGJz6oTq3JWtImcjTnPyS79h62ybvNdeGOq/+pyfhwLUfkVUDgqEuvJAE+H/
 tWsy40Qoypa7G1/exw7sOqSdp1n5026S0hxgpP3wz7EcocPBY4Ne+lr8NQERSPnUHuuOOSERAT9
 WUPpssCnf/2QSUokBwDrAleeZSSqNWze/bAl4DxCF1h6xBRLSufvGcyg9VubJNgDibnT4QoBggA
 HWO7SoglR+8Stfhi95yif58ZAgbccFuAwYoGGXQPuXWF0GEuZGu6PNsEEakFe5HVHX8fd6t9lRO
 HMWnox0kg3/7PoJ4b34pVowaEnC2sRR+6dvnT4g8n4HOUoiI/dQKfOJMk46jtA4xqzgetRv7Tuk
 CpmXVhBteCvlfzPrv92jwKjenhCLwTMe43UVTzAJyjG+4KXI6ocDP3B8SmgwP+Ze94KBb53E9v/
 SLPwDPk9Iqs5NMpD9OO/6dwnI272DY=
X-Received: by 2002:a05:600c:3b17:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-485269587bbmr41502965e9.16.1772809189985; 
 Fri, 06 Mar 2026 06:59:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/49] MAINTAINERS: remove myself as a Xen maintainer
Date: Fri,  6 Mar 2026 14:58:59 +0000
Message-ID: <20260306145939.2162189-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Paul Durrant <pdurrant@amazon.com>

I am no longer actively involved in the Xen Project.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Message-id: 20260224112215.83355-1-paul@xen.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3245fdcd2..57524906fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -619,7 +619,6 @@ Guest CPU Cores (Xen)
 X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony PERARD <anthony@xenproject.org>
-M: Paul Durrant <paul@xen.org>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
-- 
2.43.0


