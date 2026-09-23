Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15AAC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9O8V-00021o-RU; Wed, 23 Sep 2026 10:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1x9O8L-0001xs-0N; Wed, 23 Sep 2026 10:39:41 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1x9O8J-0008Qa-Ji; Wed, 23 Sep 2026 10:39:40 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE9DB41466;
 Wed, 23 Sep 2026 14:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE81F00893;
 Wed, 23 Sep 2026 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790174370;
 bh=TK8VChsg1YSiYK3mE4qp91eSZZFQ48vKD4wOK86PQFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FCW5ly9nE0zCoykssxAqCRmbK6Quqt6wQ5yIpgEM6fPCrem34jb7fRxB1PUSQTDnq
 y8SpqUDSKcx3MWeWYAVIvHRetYeKA8rAZQ8X6UFV0+xv3xcqidj8mUvwqqA7fy+0Mj
 bvQ4/97td3CBre9vU0kNGO+HPAq6FqnuZR+IUavqGdGjIhc510YEk74MtdIO3VpgXX
 D3FkXsid0+GKhiN03VUX50205ic4xLZnoM42/gqCplULZ9nrr37ZFrfGv9PgjI8OIf
 nNqpVlFC/OSWtbDm8AzIImnkDqXFIC6gtz9OXS77LOdTlw/VZtimh+m0fPmwGvoSlI
 TyB8FoTKA36uQ==
Date: Wed, 23 Sep 2026 08:39:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Markku =?iso-8859-1?Q?Ahvenj=E4rvi?= <mankku@gmail.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
Message-ID: <arPkoItGqH5MY7TQ@kbusch-mbp>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
 <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 23, 2026 at 03:20:02PM +0300, Markku Ahvenjärvi wrote:
> cq_pending counts interrupt-enabled completion queues with unconsumed
> entries. nvme_cq_notifier() and nvme_process_db() decrement it whenever
> a CQ becomes empty, but they may also process a notification or doorbell
> write for a CQ that was already empty.

Is there a host actually doing this? If the host writes a doorbell
register to an empty queue, that is a spec violation on the host and the
controller should fail the queue. If it's not the admin queue, then the
controller should to send the Invalid Doorbell Write Value AEN
completion.

