Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172451077609
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2w3H-0002zL-4t; Wed, 18 Mar 2026 14:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2w3F-0002yn-JH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:55:30 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2w3C-00070g-SP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:55:29 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E08874C3637;
 Wed, 18 Mar 2026 18:55:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (100-117-57-254.trex-nlb.outbound.svc.cluster.local [100.117.57.254])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 905094C3868;
 Wed, 18 Mar 2026 18:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773860123;
 b=12qW9zgpXzBm40hjxFvVZQ8BJVHR7KfcMvdmX2gEIyBm6KTleb1c/KCQL4mfoQijIEzILv
 q9xKD9JWAq1IyOqGLqj8aaNIlb6ve1ySCbkTYfX9+wdULXpZfu6kf4ED91cI25vgr/8pNE
 RPNiQM2dE/d5sNsu7ENP/JyJ2HmaMhhp+PyHuph4rn5KO5hEcKmGgYGfj9tKXko5ghkc1O
 1iNjJSKX+vZ8Jknmedla4x7WhRq6Qi/743nFv1wkuDHLviW+ClcKB2Lp0VgEEESxAbWah5
 D0RXqfY8H9+9Ml6z/xmhBdgxQfjsrhVecXB97J9RHj2a1nZ/srUk9iMmEkU8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773860123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=FxF3AC/kTZqacub0KGcZN70llm2LI5A4Np3en7HHhW8=;
 b=W89UEYzwNYtxaT3Mp2smGBHMi62DpwHLLGq+/6nARG1ykoId2dh5Q/+k3PV15yRoFCrW+0
 mkhntW502Swt5JyKwwLa0FFD4t0XccVJARuIkcpRswBxh0XaFfVkmSTdNTZKNoAswXXCN9
 mbe0wYEoXZYnXukNUoWNlty8Vc9w5wZfLGjIv96jivqBmuhpeIn7BJCTrw8wlOsno+DSgg
 C21y81QkaWhEz0xv2MsklF/hIEDTlAtrXvm5hTallmkN+7dH8Erv7e9UsaIyvNWYAbhEif
 obWrHpkus46U1Ud5DRAEKco+zK3Grxacyl3HtAXqPOlM6NSvm2nyXersAyJHfA==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-2x4br;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Army-Ski: 2ef823ea0cff0c2f_1773860123802_2105714562
X-MC-Loop-Signature: 1773860123802:1021080898
X-MC-Ingress-Time: 1773860123802
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.57.254 (trex/7.1.5); Wed, 18 Mar 2026 18:55:23 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbdLg07nWz1079;
 Wed, 18 Mar 2026 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773860123;
 bh=FxF3AC/kTZqacub0KGcZN70llm2LI5A4Np3en7HHhW8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=mOMXz4nu7PRuJ452Di2+Ci1foY1W8eI/jhi+L0h8Cu+s/LzR27YyI/YCo8oh32woT
 wr6wzmk00HqPzM/WXZw3RyaN4I08IVnORLw7RirtTLa5BfyI+pU3cX/pYiaZLEyoZP
 ZkSlwKOkGGeDlxXGGdmHfHtGvKC80vENqerS8o/7gj47cZ+DBWKaeuLkcdaQo2Foon
 45msNC/jqKlPArUxCB3MtWOCCyh6o48DrvYj8E29RXFYI0P89pT8is6kmi5LKpC940
 RaC/r7yOuda616U7uPY6KXzuEorxNQRtSzEfwhwY4L6Tcla3S+pGUJ+uZHXCVVEiJ7
 D11LuwKe4jQng==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v2 -qemu 0/2] hw/cxl: Media Operation Discovery fixlets
Date: Wed, 18 Mar 2026 11:55:06 -0700
Message-Id: <20260318185508.3683044-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.223.164; envelope-from=dave@stgolabs.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Hello,

Changes from v1: cleaned up comments in patch 2.

While working on the driver side of this, I tripped on two qemu issues
around discovery semantics. I think this is the first time these code
paths are exercised.

Applies against 'cxl-2026-01-09-draft'.

Thanks!

Davidlohr Bueso (2):
  hw/cxl: Respect Media Operation max ops discovery semantics
  hw/cxl: Exclude Discovery from Media Operation Discovery output

 hw/cxl/cxl-mailbox-utils.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--
2.39.5


