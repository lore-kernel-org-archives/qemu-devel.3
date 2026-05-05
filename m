Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADC7CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJaj-0001wG-OP; Tue, 05 May 2026 13:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wKJaf-0001vu-6F
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:29:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wKJac-0002UT-K2
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:29:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so3920956f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778002184; x=1778606984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyaAkabMJvUFOvU8uLyog+hcEkYJAZfMRJ0zkLwucxQ=;
 b=UsCPAqdjcJMYd2nkEUtR4fqgzBgAecOcbNrXmS/fCB0wWVolsrZx0CMfIQAo+pwNn8
 BOMX89+T+tiSaoLBavrtOO4MzHnCZHBUFbeT7arYfwcTyAe9Y4Ub6mfw5cZAx9D0CM+F
 0Dx2cf171dpfmG8lBGFFWpW/NQFrispupSZ3ay/RFVvFx22/M+p1DKoy/WZcZ6W0fycx
 P3Ia5JVbaQhr47P1bZsqGyldm/t3TY9XfnScz/MjUJ7I5CcCu5YnZmhgNPpRVQSRArLs
 Q03iaQM2lpAhwt40crzVSypDx04q8O0sCOT/8/KbrDq1vwISs3zYdDXRGm6lJfOQFros
 pa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778002184; x=1778606984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uyaAkabMJvUFOvU8uLyog+hcEkYJAZfMRJ0zkLwucxQ=;
 b=HUCGCV/7aMfFKwxQb029ma1obotNTCDFjf+06GW8xCmbM2GkQw/AmxBrizZ9+Cb7nR
 kyX0rZViyxoH8fV8pf4NxjLUfvLMFdsSrXbuRVzowQn28Gh5T1JOwNhA+2bi0AmAFwqi
 1mzOHuWgRLw9r/ph0kn7KjAMPxUUteWQHosEiYlSLE7RTemup1d329hbZCgVxWxo5L7Q
 KKPKfzzjjayOd6oEeBz8c2Cs6WURwfoai0MogpYDx5o5xRI1JoIWFsgzvBJ2D6AVAhwe
 vr99yFBLmPCTj/o/mrgTndQ8VYJuRwYnz1cOOnZdW29dKRIs0P3WhC3c9GZSfNds/Clg
 dmcQ==
X-Gm-Message-State: AOJu0Ywk1Sky5Qu5JVohT7lv0F994+z9IOjfoA2E6mGjjNCFnjP/8pYC
 rbu61poM0LAVY7kNoHJK8cPBCo/F6BNbQYNKEBf9HEAAmZKOkjBcRivnj7X0gQ==
X-Gm-Gg: AeBDievURp22zP9/A1k0KDuH0zIqljmeBVCnCMqbPMMumOko042FRh6HbzPcMfXo96l
 uI2AL46PKDmoafsSnQuqcYSy6/QxcG5r/bGlDhM7cTmgBBuJweMydpw8bc4t7kQ3eDv607x2GBQ
 FzYOw6h8n152qSkEMws5uIML2lsd+HUDWQ6vG+jAJ5pTnQ6Z2GMyUESR25Yvvn8L7y0/ftPNFj3
 NlxuYkPKrXKrkXc97uf0eEyTuv/60WmFGGpXtP7j5/lyXlW4NDeKb1JZBuPkF/g1Rah3vQagAyn
 7cxFHa/KiTbokYrWAU76hguA5B9gtqjYLHjEKUXkv8ZHb3ZJYYiqp+OIgkgpkyme3OATMBibgUs
 Q/lBcsRISDDjSg2qV7xWaJWczcngEC02QARDQ6ufnL2UZchzb9lF7vC87kqlVyzUhSoY+czh3Yk
 4UhdYXPzzGxM36RP9bolwnOmojvBN+Y2e6FIPTbejSrZp9Xs2WauqsURWKvoIAuIKfTFu+fF1oH
 JhuI9NoOhh0DTX6
X-Received: by 2002:a5d:5f90:0:b0:44a:8c10:40dc with SMTP id
 ffacd0b85a97d-4515b9f3c74mr97263f8f.18.1778002183738; 
 Tue, 05 May 2026 10:29:43 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960902sm6694853f8f.28.2026.05.05.10.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:29:41 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>, stefanha@redhat.com,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/2] MAINTAINERS: Add myself as the OpenRISC virt maintainer
Date: Tue,  5 May 2026 18:29:26 +0100
Message-ID: <20260505172926.2235826-3-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505172926.2235826-1-shorne@gmail.com>
References: <20260505172926.2235826-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I defined the virt board but didn't realize there is a separate section
for listing boards in MAINTAINERS.  Add myself as maintainer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44207949d7..e9807fe6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1516,6 +1516,12 @@ F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
 F: tests/functional/or1k/test_sim.py
 
+virt
+M: Stafford Horne <shorne@gmail.com>
+S: Odd Fixes
+F: docs/system/or1k/virt.rst
+F: hw/or1k/virt.c
+
 PowerPC Machines
 ----------------
 Bamboo
-- 
2.53.0


