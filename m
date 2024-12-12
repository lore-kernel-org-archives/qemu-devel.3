Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8636E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkue-0004CP-HX; Thu, 12 Dec 2024 10:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkta-0003A5-1J; Thu, 12 Dec 2024 10:14:30 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktT-0003fG-9N; Thu, 12 Dec 2024 10:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=0K+wmele5k2RU7N7ggIHaJYf7b8+tS9y0ujopotcxkY=; b=oPu9yUYHfI+Rm4c/5o02oPmtfm
 fqsoqulWhpBYSai8T9eZxYoEd/RNPEpWkgnMwvVkg92XMnRle3cx2LqN/E5pMY9+uy91hGFUaHKP8
 3xAmz/AktKnP0ROZOJwlkA7JuGN6gEGYPlYcYMqr9gAMw//8SufcLcVSIrTrUw+MBOZ5xtqMnibgc
 zZPzUcCWUDxXIpu4NFHaRhIqCNOfbh+O8Go8y5flqy0g5DmGPkA71lJVL6FEgg6/qiExymqOIMBN5
 0BMI0/21brMy5AjV0NXpjzvqukg461izjgJ3QTCbx2Ha2glngSxtCD5pQeBDVLFuLpOJyr4+d1zVm
 0Ndm/tOOj1+KqyVHvUbMkaFHloKjoAtl7mbISdN1ndR+XOf43UPXuC/0Bn0iAGNrHBxXdv0W1yhJb
 vUauxIItDUQb14Zw4wH6Wg3kKkNC+kI7KNAuZj5balFPD6IrUWMQr5HBDH8nFoHV+7WK/zbZWmjr0
 eHQ7/vaHdHCrdV3SWXsYTNjj6z6o1eQIXsLanzFbzEixKgy+a6y4Zq6wVkxTFPlW4UKySHyhCRFOW
 FF7CM1Ih4F3yy/9URFPlE7AG0jvu10ojM0dejpgePB8TTQ9Atdj2HrQHk4nmPCXkxFecoyJzgEBSG
 FVMw2IOQkgnDIPtKNn2u40umC94v4nJ/tptGaUpu0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLksr-0008Ue-Gv; Thu, 12 Dec 2024 15:13:49 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:01 +0000
Message-Id: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 00/11] target/ppc: implement legacy address-swizzling
 MSR_LE support
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

This series is my attempt at reworking Gitlab issue #2661 [1] suitable for inclusion
upstream. In summary, older PPC designs include BLRM (Byte Lane Reverse and Munging)
logic [2] and in particular the CPU uses address swizzling to perform word swaps in
little-endian mode. The main changes I've made compared to the provided PoC patch is
to ensure that configurations where address swizzling is disabled are not penalised.

Patches 1-4 introduce general accessor functions gen_ld_tl() and gen_st_tl() for CPU
loads and stores, whilst patches 5-6 implement the basic address swizzling logic.
Patch 7 applies the address swizzle to translator_ldl() whilst patches 8-9 apply the
swizzling logic to the load and store atomics. Patch 10 applies the swizzle to
gen_conditional_store() and finally patch 11 ensures that default_tcg_memop_mask is
set correctly when address swizzling is enabled.

The series boots the test ISO image provided in GitLab [1], however it is marked RFC
mainly for 2 reasons:

- Is there a better (i.e. more efficient) way to perform the swizzle?

- Which CPUs should have address swizzling little-endian mode enabled? I was unable to
  find a concise list of the relevant CPUs.

For testing purposes the address swizzling little-endian mode is hard-coded to enabled
in the need_addrswizzle_le() function introduced by patch 5 when MSR_LE is set.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[1]: https://gitlab.com/qemu-project/qemu/-/issues/2661
[2]: https://wiki.preterhuman.net/images/f/fc/Endian.pdf


Mark Cave-Ayland (11):
  target/ppc: introduce gen_ld_tl() function
  target/ppc: replace tcg_gen_qemu_ld_tl() with gen_ld_tl()
  target/ppc: introduce gen_st_tl() function
  target/ppc: replace tcg_gen_qemu_st_tl() with gen_st_tl()
  target/ppc: introduce need_addrswizzle_le() function
  target/ppc: introduce gen_addr_swizzle_le() function
  target/ppc: implement address swizzle for instruction translation
  target/ppc: implement address swizzle for gen_ld_atomic()
  target/ppc: implement address swizzle for gen_st_atomic()
  target/ppc: implement address swizzle for gen_conditional_store()
  target/ppc: update DisasContext default_tcg_memop_mask value

 target/ppc/translate.c                     | 262 ++++++++++++++++++---
 target/ppc/translate/fixedpoint-impl.c.inc |   4 +-
 2 files changed, 226 insertions(+), 40 deletions(-)

-- 
2.39.5


