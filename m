Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29738C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9nhd-0003Xo-Kr; Thu, 24 Sep 2026 13:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1x9nhb-0003XG-G7; Thu, 24 Sep 2026 13:57:47 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1x9nha-0006I5-4O; Thu, 24 Sep 2026 13:57:47 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E271601DE;
 Thu, 24 Sep 2026 17:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9531F000FF;
 Thu, 24 Sep 2026 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790272657;
 bh=YjyjYiIZHOIt90u202iOg6BlB2dIWPwFSRTV/ldIk34=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Zt+o9WC8TrabE3i4IWsLZ8qYSOmIP7UqKPZLH/znzgMJt27AonpiXeRvpRm5leCWt
 4VfZoanR4ikStKrmIgVrEcJK80Z2JozwjupawxSk1dmAGvIJCJGQ+NWxL5prKQuEun
 tvNeKmOGCMzfnSOdXcE9yWv9sahhUBnJqKKzv+HyZYlO2OG2gMW7ShocNRTGcf9+Yl
 ly+yXStv3CwrKyu3Vkzi/fpTBe4GUrKb9Cz87YQa2HRLxBkKzMdPeNHT5ujNlpjlfy
 9CSJ1QQ9VZojEGbq4JPRqWEfVvP0b6OXIPGlZlrsZ0TDD66IkpWQnvBEbeZzE+17zx
 dHD49E/Glkd3w==
Date: Thu, 24 Sep 2026 11:57:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Markku =?iso-8859-1?Q?Ahvenj=E4rvi?= <mankku@gmail.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
Message-ID: <arVkj2tPEtYtM-w3@kbusch-mbp>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
 <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
 <arPkoItGqH5MY7TQ@kbusch-mbp>
 <CAO-Q3byewGo8azAhhkHSQKzU=T-h5gose1_=GXZXq3fdvvX2aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-Q3byewGo8azAhhkHSQKzU=T-h5gose1_=GXZXq3fdvvX2aA@mail.gmail.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=kbusch@kernel.org;
 helo=tor.source.kernel.org
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

On Thu, Sep 24, 2026 at 09:56:11AM +0300, Markku Ahvenjärvi wrote:
> nvme_post_cqes() also updates the CQ head, so it can run before QEMU
> processes the corresponding doorbell. I observed this with ioeventfd=on,
> where MMIO doorbell handling is asynchronous, which makes the already empty
> CQ case more likely.

Are you also using shadow doorbells?

