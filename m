Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F76C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlgS-0005T9-6K; Wed, 19 Aug 2026 15:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwlgP-0005SO-VJ; Wed, 19 Aug 2026 15:10:41 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wwlgO-0002Fc-G8; Wed, 19 Aug 2026 15:10:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E7A940E45;
 Wed, 19 Aug 2026 19:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755C21F000E9;
 Wed, 19 Aug 2026 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787166637;
 bh=lyUEEgCGWh7apxrzz5QbJ9UD8tP92+gSIRXdeqlhM9A=;
 h=From:To:Cc:Subject:Date;
 b=HUF4sJUjqJXE9qidgs99wM6gDCOTyU/UwkvgxSDqSkLJsDiQ6a2TAhIXFAimCsPP7
 9GB0zP6kmRIn3PdQ2K/4y7wf9tBh80iRo49b5kw2oXi2q2dTrFus+MozRXBYIJh6yN
 L61BrGJLCKCbVR9kR6PrcYKgVs9HxhfIo1DP4QRP/2MyPBycjuEuDD4ZhcpBZU8XPL
 5OFH/WjNMwW23FvhxRAKNXr9cNFF/GfZizvRJlmNvPmipl8eaWaXniQKyBjCyRxvsL
 7FWof6qtr/XgQLc5Wb8e7KtxCFc7G86Gh9w2hYjA16KcAdLYE5vkSlMeT63n0lJzXv
 SAfy76x8bQlUQ==
From: Niklas Cassel <cassel@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] virtio-blk: improve zone write granularity handling
Date: Wed, 19 Aug 2026 21:10:29 +0200
Message-ID: <20260819191031.3001633-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello Stefan,

A small series which improves the zone write granularity handling in
virtio-blk.

Please review.

Kind regards,
Niklas


Niklas Cassel (2):
  virtio-blk: report the effective zone write granularity
  virtio-blk: check the write granularity of writes to sequential zones

 hw/block/virtio-blk.c | 47 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

-- 
2.55.0


