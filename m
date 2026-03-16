Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B319F46449
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PL-0001OQ-KO; Mon, 16 Mar 2026 06:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PJ-0001Ij-Ev
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PI-0003fQ-1J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b3cfc38edso1719383f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657762; x=1774262562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/FWSfH5tKcpm2wUddelCmhQ+B0HS9LSM614NqsUStrI=;
 b=itucuy9YeglAyvoZ2tCfwXgxb6E3906KYCYcKEdhMBiMAZpZ1WVYrxLyJRsqNJLWV1
 UPjlWE/RlSX6PBxX4yUtnP1zGJbNs2jQOAzN/OW23d1pEzdTumEnWA0XLGMCX8FADA/E
 EJj2dxND9x+K16pf0S9Ahf+xJDDrhUqwpZKlOsZ4Q+APXTbUL0acIf0u368IixjS/Lhy
 Z1kb00fQet7arawPia1VyEOGseSH0oJV9PDBmdqsCSI4itL1+0FoUHY1/VqFCt9UUH5Y
 JrwmbdH8Kwp7GTSlZrngDMczjSNHV2J8dStzy44L4P1n5pk862xPIm5/6cU7eNp8k911
 qAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657762; x=1774262562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/FWSfH5tKcpm2wUddelCmhQ+B0HS9LSM614NqsUStrI=;
 b=hludxBy3sWK/mo/2Q47rOIyFd4stPplDI5GdXG8jkGoJRH6Fp7TKRMmNHCrc3NCLw6
 vXEGGQuwDU2q5j3OsOTeI/lDcDtiyCrtoioqu9F9lXY68eT7ZnFlJH+nM9JREOg7lwfD
 dgaZfK96+10CELnhmIz1Vk/ZZWwiTRs0A46d6PhKQKZ9dVNxr6KsuAtJ9UI0BFPJpBpa
 WK3zGMQPLRwcsOs9oQpmmNfwpuaRs/7N9Ff/Re1XUhAkfHqXrW2963wIRnXL4c4q4Cy3
 jD0SP1a+2aSWYzJ+qSeJ1xdxBfdHQPkvbi2NtThR0aZ/xqeNOllYQDlr6tODz6OGzWtW
 XI9A==
X-Gm-Message-State: AOJu0Yyb2WvqwEdZ65tJAoxeLuRWoZbpe2KD22fwafQ+bxPCpg6tfsvB
 ciTuhmOSLRb5KxieS9YrXMBT8PW449iobEl+EYe3fwk2i313PJESVCiEl31+Kwesgt3HWGOISe+
 JJWxq
X-Gm-Gg: ATEYQzzaeG2LAJEho13BVAYZkPuZajDUIgk6K9IWokTW+p+MRUzEbT7B6Ga6mg6TF3g
 S8b4ClJQcvAK0sloF19vX6Mki+J+I7Vex/AiCOpIPvMRZ8lGihoZpuqH6QFYZ+hR8IAw9LPL81I
 YKG8YuqH0m/EcVE2Uq/W6/KMMW+8JaThM8GSveayc8A1we+29ROZGZvVU7BkKyOU9Z1UBD9hm56
 i8yKMx1D1T4BW06L7ivJ+pTnG6B73VhexiKnEcsrnwYuAk0EIvjaRSaYfZ1g8vnT/AN5jgU4slF
 YJRPjUr7OwXv6Z97F8kTU1T3lPZkr0+djahWbeedKhYQLfC6XcC6+FNVccX1uLSYVLi8tg+QOhY
 PoVNkglhzH/G4ksU/S/s4cTpycGcKjI0853Zf71QAZMfbf44HjPiE3B+uVQgM0eSty5B0JkKnoL
 g9AQ6/WGCVGLwZS35qvA1s+i+1qxPcjzd5yRKaO66PmyXOIxyN+s37psMwxdk5B6GgUH/kDywr2
 GBLNn/0GAQ=
X-Received: by 2002:a05:600c:a09:b0:483:9139:4c1d with SMTP id
 5b1f17b1804b1-485566e1a4cmr228163565e9.14.1773657762208; 
 Mon, 16 Mar 2026 03:42:42 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] MAINTAINERS: Remove Hannes Reinecke
Date: Mon, 16 Mar 2026 10:42:21 +0000
Message-ID: <20260316104230.836962-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
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

Hannes Reinecke doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

As 'megasas' no longer has any listed maintainers, move it to
"Orphan" status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306120555.2035421-2-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 247799c817..e691ac2662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2636,9 +2636,8 @@ F: include/block/ufs.h
 F: tests/qtest/ufs-test.c
 
 megasas
-M: Hannes Reinecke <hare@suse.com>
 L: qemu-block@nongnu.org
-S: Supported
+S: Orphan
 F: hw/scsi/megasas.c
 F: hw/scsi/mfi.h
 F: tests/qtest/megasas-test.c
-- 
2.43.0


