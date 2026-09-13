Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF047C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5ost-00020e-LK; Sun, 13 Sep 2026 14:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5osp-000202-I9; Sun, 13 Sep 2026 14:24:55 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5osn-0003uX-9h; Sun, 13 Sep 2026 14:24:55 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hjcBp2S2Bz85Fv;
 Sun, 13 Sep 2026 20:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789323890;
 bh=UZuiWt3qYOhWzMzCvHVD18lpRLhD6bhbFP5wXuV0kRU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s0YynF1yunKxZLasw1udrJ7/RSagr2MfW9y4vsH6Wh7HxgdPNFHl97FazulY1c3gy
 hf29Bh1xZrQYoOxZHP9tMyiaXyZbwWf6NKWaeyNfqgojUNe+5mlrZwxaeJFPQgSOIw
 aTAFuN7jCL/iyzhvwsAji9PXU6IQ9B69jbD+xr7FTXzLszu340Q5QoynwEzZGNPgYd
 gGFx/dhLdDUj3poL0+GF0KQa18Bijn9vX+Be8TCqhBCnpUaHINXslvq8fxe/9c7DBy
 61QGB4wAQ9BX0u/KVmMD2MgERuPn+y8ftSZg4ZdTNmXydn45FkAdo+CruuBWbjBZs4
 oif6HWAbrYkIg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hjcBp069cz7vFN;
 Sun, 13 Sep 2026 20:24:49 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Subject: Re: [PATCH v3 01/36] target/arm: enforce Armv6-M NVIC limits
Date: Sun, 13 Sep 2026 20:24:49 +0200
Message-ID: <20260913182449.3663-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFEAcA8PROO7xjG8DmqHxPXrPRjx_bHddPARyuFGejE9miOqqA@mail.gmail.com>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260906194438.93046-2-gilles.grimaud@univ-lille.fr>
 <CAFEAcA8PROO7xjG8DmqHxPXrPRjx_bHddPARyuFGejE9miOqqA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Peter,

Yes, testing ARM_FEATURE_V7 is sufficient here because later architecture
versions also carry it. I will remove the redundant ARM_FEATURE_V8 check in
v4.

Thanks,
Gilles

