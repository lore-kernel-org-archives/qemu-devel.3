Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF1BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOKZ-0006IQ-Bc; Wed, 07 Oct 2026 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xEOFO-0000Ea-Nz; Wed, 07 Oct 2026 05:47:49 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xEOFN-0000p0-0m; Wed, 07 Oct 2026 05:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=NN5yN358XE8LB2DdmwQwos4dLO6h/lXG5oy3BXleXmk=; b=PBEmYWGO9fl6G8MZQq2X457AM4
 JYOTMrIWtTzOMWc03csrKOEXEAn9Hj5RhZxxquFT0tZLSm29N+bCON2hdJJ70+UTxrJ/7FHWg6t9u
 KX6o/Xe+RWG5n6Us4agOdvj1MvxIpNhJUKxhpdbpQkDGvMKUpcBpmy8HNovOsBoex2e3xwhp2ZM9e
 HhtxVL/Mw507cQ/2r5j78dNy0zIN3CHPY4IWL44r9108VCopYZbOFAWr0YUSyM3W4SKe/i1e1XoQ9
 j4A0gCkR0TObUR6VVnaddd7xaY9KwW85UhM/3ym/YhxtJHP5PjvWa6Xoi/tvbP6U7w7LQFHMVTO94
 KrRFO1WHah2iYfGZUX3v7Qer3WzHIRpRgAes0vjD5SnGvPUNugj/nxPOengcxLQb4VGd/hoAI65yW
 1Xa5yIL4PL1hNuLx4DPXx/kv8/ZhTrRKWY04+osZLgk7Atam0lgSbuQR9CGca0QnVAirBhry2PC42
 dfGTUFXqnyZSTO/gxwdQ+dMvIrIXbRiaQ9xLevVh/ZM+MtNelQBQ0nQngSubd+7WViYDMNR4n0VJh
 nbJSWFKdT22wwxP3O08JDrzgJ/AKG/a6kNRWmH65pOYRVWfjwCEXGQxJHgYX8fAktI4eIwqYpE6Vh
 gaQkSIYPNKN/Mak9ZTh94eu9JYxQ7k3CnwF4mH4BE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/9] 9pfs: add race test suite + fix 9p2000.u dir stream
 race
Date: Wed, 07 Oct 2026 11:47:32 +0200
Message-ID: <6310923.lOV4Wx5bFT@weasel>
In-Reply-To: <cover.1791291812.git.qemu_oss@crudebyte.com>
References: <cover.1791291812.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Tuesday, 6 October 2026 15:03:32 CEST Christian Schoenebeck wrote:
> This series adds a race test suite for 9p and fixes a race on legacy
> 9p2000(.u)'s Tread request on directories, which was uncovered by this
> new test suite.

Urgh, I screwed the time stamps.

Disregard, I'll send a v2 with one minor change on the tests anyway.

/Christian



