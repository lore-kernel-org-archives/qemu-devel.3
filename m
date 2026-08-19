Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ECEC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkCd-0004RO-4M; Wed, 19 Aug 2026 13:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkCZ-0004Qn-09
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:35:47 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkCX-0001Om-Kn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:35:46 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwkCT-000000005kj-17Dn; Wed, 19 Aug 2026 17:35:41 +0000
Date: Wed, 19 Aug 2026 18:35:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Matthew Jackson <matthew@pq.io>
Cc: Alexander Graf <agraf@csgraf.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/2] hw/misc/applesmc: implement GET_KEY_BY_INDEX,
 WRITE and TYPE commands
Message-ID: <20260819144200.d4e5f6@makrotopia.org>
References: <20260720164930.68383-1-matthew@pq.io>
 <20260720164930.68383-2-matthew@pq.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720164930.68383-2-matthew@pq.io>
Received-SPF: pass client-ip=2a07:2ec0:3002::65;
 envelope-from=daniel@makrotopia.org; helo=pidgin.makrotopia.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

I implemented the same two commands independently and ended up at the same
place, so I have read this one closely and tested it against a macOS 26
(Tahoe) guest: with it applied the guest issues cmd 0x11/0x13 during boot
and both are accepted (no more kSMCBadCommand), the boot-time key writes
(NTOK, MSDW, QENA, HE0N) succeed, and get-key-type is answered for the keys
it probes.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

One minor observation on get-key-type:
Inferring the type from the value length reports REV as "ch8*" (six
bytes) rather than its documented "{rev" fourcc. The guest I traced
accepts it and boots either way, so this is cosmetic -- just noting it
in case you want to give the handful of typed keys (REV, the
"flag"/"{fds" style keys) an explicit type later.

