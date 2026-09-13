Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D177BC88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5pFd-0005xA-NB; Sun, 13 Sep 2026 14:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5pFP-0005wP-28; Sun, 13 Sep 2026 14:48:16 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5pFN-00080r-6U; Sun, 13 Sep 2026 14:48:14 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hjcjk2Gxvz7y0L;
 Sun, 13 Sep 2026 20:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789325290;
 bh=TcYZXXMb5SilzCQ1pInkeuuKZ1Kb+f6Cdp+aPMJ5rWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ie/pxgX993p5gbYNKB8xwqcPnqBxhjsNUNJndK5+yehz7nQdbMtOETrOn5EssnLE5
 qWgoYz26i5+y3oZptOyK5ZWsNh5sJCgyqBM/ISmb9L9FCLoc24uoeNfQQywoFrcTP9
 uQCr8HesE0p2HcbCuJBPt3tZXH/R21Nbp1Gd6KAgssApN97TE1Z5bp+u0yZ5K7LzRB
 X6lHD+zQMtDH52YQ42cuxPSv9aexTkha0ZASyfJewBQiKpwtYPhWiR2jiHr16yNYMx
 psQjxhx6v1TaZnD/hzOMUq10BOf7T9KRbV9Q4G/Z2/Kg4G2bl8PXJtsbQqadHaAPaK
 3JZLjstIwRWkg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hjcjk0Tkdz6tBM;
 Sun, 13 Sep 2026 20:48:10 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gilles Grimaud <gilles.grimaud@univ-lille.fr>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Alex Bennee <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 03/36] target/arm: support Cortex-M0+ MPU
Date: Sun, 13 Sep 2026 20:48:09 +0200
Message-ID: <20260913184809.11542-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFEAcA_O=k4=9Y1tnmuv0_Bfn8rfAzZ1gdR3br80=obYgObuFg@mail.gmail.com>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260906194438.93046-4-gilles.grimaud@univ-lille.fr>
 <CAFEAcA_O=k4=9Y1tnmuv0_Bfn8rfAzZ1gdR3br80=obYgObuFg@mail.gmail.com>
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

Thanks, that split makes sense.

For v4 I will replace this patch with four focused changes:

* gate the RBAR and RASR alias registers on ARM_FEATURE_M_MAIN, using
  the case layout you suggested so this also covers v8-M Baseline;
* make the TEX bits RES0 for v6-M;
* fix the minimum PMSAv7 region size validation for all affected
  profiles: v7-R, v6-M and v7-M; and
* enable the existing PMSAv7 state, property, reset, migration and
  translation paths for non-v8 M-profile CPUs.

The dedicated PMSAv8 path will remain selected first. I will retain the
other condition changes that you confirmed are correct and add focused
tests for the register layout and region size behavior.

Thanks,
Gilles

