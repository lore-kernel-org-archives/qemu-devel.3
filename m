Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DFC88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5p02-0003R5-Ns; Sun, 13 Sep 2026 14:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5ozl-0003Q2-Kr; Sun, 13 Sep 2026 14:32:05 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5ozi-0005MH-P9; Sun, 13 Sep 2026 14:32:04 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hjcM223NWz7vcn;
 Sun, 13 Sep 2026 20:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789324318;
 bh=Q22PWF5bua24RDjHjF+oC45tvT+ULlUTVHBuLQdpqvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eLxCAUPaONWtSBa81bFw3BXr9uw/4P0NdNYo9uPZ+uBeQgi4w0Ny/ws/kqiEEFeBe
 sz1pLw5ntogs9AjG4eH9xjgGA7Sc4Rcki1NMNm5arv2GahBw9XGmpg3KPBsZdSakv7
 qrbGJtBXZY9PXZ5b3GMEysUr4qD8M4ohG/xIBR3YgwKIlNayfKDDuC7k17PScLkrma
 xZ498VwyPurMerkAfA5W455H5/D09jIyBmoE3Yf8fJlLgLHys5jGtE/0kpdBnK5VFP
 jHPw/e3F+vMgYnRIzVJvSYmSDpLlDb27x9UluPaPg5elhpHVb0x/0iJ5SmJo/zUvGW
 tHitzp8VUh6wQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hjcM20Lfdz80CN;
 Sun, 13 Sep 2026 20:31:58 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Subject: Re: [PATCH v3 02/36] target/arm: allow Armv6-M to set CONTROL.nPRIV
Date: Sun, 13 Sep 2026 20:31:57 +0200
Message-ID: <20260913183157.8294-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFEAcA8OYNNDn7tV8gzoVcKnpNc5MZZ1u0AmbbNpRfuzdoqfKg@mail.gmail.com>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260906194438.93046-3-gilles.grimaud@univ-lille.fr>
 <CAFEAcA8OYNNDn7tV8gzoVcKnpNc5MZZ1u0AmbbNpRfuzdoqfKg@mail.gmail.com>
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

Thanks, you are right. The v3 change incorrectly treated nPRIV as uniform
across all M-profile CPUs.

For v4 I will add a dedicated ARM_FEATURE bit for the optional
Unprivileged/Privileged Extension. Cortex-M0 will leave it clear, while the
Cortex-M0+ configuration used by the RP2040 will enable it. Writes to nPRIV
will then be permitted when either the Main Extension or this new feature is
present.

I will also adjust the tests so that the microbit Cortex-M0 case verifies
that nPRIV remains clear, while the RP2040 Cortex-M0+ case verifies the
privilege transitions.

Thanks,
Gilles

