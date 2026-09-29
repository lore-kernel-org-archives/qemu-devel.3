Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AFFCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTrh-0005Pg-Tu; Tue, 29 Sep 2026 05:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xBTrg-0005PT-9L; Tue, 29 Sep 2026 05:11:08 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xBTre-0006Qr-Ib; Tue, 29 Sep 2026 05:11:08 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hvC8Q5DzFz88pq;
 Tue, 29 Sep 2026 11:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1790673062;
 bh=6qTRERzkc/QKHuFsrT+/MZ5ncwl6UshJ9OjB/4k0hmY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RZmwBh+m6iirUVgCcxNLFLwjkjFew+JDck4KfBBVwjpkRPPiNFPikzRpyMCUk9QLD
 /wA2yliCvQUdLjjupIRfU6dNIWS2iV24xbiURxvWiN/OmOZ1JTep2ttmgz1JuTdYrO
 AZzh3tap6OWMzkUX9PLALmMI/8IICWinUBZUuTPyaMplYKmACRghhNigV4OdoeY0dN
 2dcUFZo1EQuJ2iAWo3oCjt1p8LzJd3L6yP4Vfws5SZdPHcXtxxK9ecGbrCQoLEjk5E
 8N0Fhyau82oe+W9cnBmm3fYJLKmimB1+R0TFlYGfDy8dxu2BEhcYBiCi/lYy95ZsXv
 vS6JUhk/zb51w==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hvC8Q3JLdz80Rl;
 Tue, 29 Sep 2026 11:11:02 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alex Bennee <alex.bennee@linaro.org>,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: Re: [PATCH v2] target/arm: model Cortex-M0+ privilege extension
Date: Tue, 29 Sep 2026 11:11:01 +0200
Message-ID: <20260929091101.78789-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFEAcA9ScL5mmu1LKEhq3Qo0OSJL+-Ee4K6ura+2SgYYZi9O6g@mail.gmail.com>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-3-gilles.grimaud@univ-lille.fr>
 <CAFEAcA_=sRZboB1GyGDxEa4vTZe5YS4GwJV9aK=6h-fONgLVkQ@mail.gmail.com>
 <20260920220722.73501-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9ScL5mmu1LKEhq3Qo0OSJL+-Ee4K6ura+2SgYYZi9O6g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thank you for reviewing and merging this.

This was the last remaining generic Arm prerequisite for the RP2040/Pico
series, so this now unlocks that contribution.

Best regards,
Gilles

