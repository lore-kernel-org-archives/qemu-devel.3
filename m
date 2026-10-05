Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFCDCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDiSL-0002kP-B2; Mon, 05 Oct 2026 09:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1xDiSC-0002h3-JR; Mon, 05 Oct 2026 09:10:04 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1xDiSA-0003CI-SV; Mon, 05 Oct 2026 09:10:04 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE3B74031F;
 Mon,  5 Oct 2026 13:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF0C1F000FF;
 Mon,  5 Oct 2026 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791205793;
 bh=1tJlcGV8aZ4THHNU05lxZ2u293eFIbaS4+Ea0cYYWXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D1T2NNKO5sbkLs86majqV7I2CtIcuZHOsHFtSX5A27kFLhqxt0sPu56avro1EFJ6/
 LDfbqlAgWUij9i/k/bCgow43SJ0tktT5G/qwngbkkk2vcD0K/4mFIe+j2SGJVnUjex
 11dpeNL1G2D6oWK3GMfuFb327BD7LO3Y68evXnybDZBkVMGJFo/BfgXaUTlr6pAwqB
 thDHeyXx8JNpQrlVVa//HlgbhMFWkkZuPd6kg80TUD3DRqJKCdY6daK/rxDVCSoG8d
 MSjywkevdq/qkMytcin7vrO49t6EjOCG9gteITGPhkuGBRK8C4+sbBcNCoh/ReuWlc
 sd+QScn+e/IOQ==
Date: Mon, 5 Oct 2026 15:09:49 +0200
From: Keith Busch <kbusch@kernel.org>
To: Markku =?iso-8859-1?Q?Ahvenj=E4rvi?= <mankku@gmail.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
Message-ID: <asOhnbcUqDbvVbR2@kbusch-mbp>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
 <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
 <arPkoItGqH5MY7TQ@kbusch-mbp>
 <CAO-Q3byewGo8azAhhkHSQKzU=T-h5gose1_=GXZXq3fdvvX2aA@mail.gmail.com>
 <arVkj2tPEtYtM-w3@kbusch-mbp>
 <CAO-Q3bzJWY7tmaz708VUd9=i2Uiqw6zB-KstdwJBDkriyCzoaA@mail.gmail.com>
 <CAO-Q3bzaFyzQ8md_NBKLV4t_e5j1kEjz1_XMFu3P-4YYF4RikQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-Q3bzaFyzQ8md_NBKLV4t_e5j1kEjz1_XMFu3P-4YYF4RikQ@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, Oct 05, 2026 at 08:54:15AM +0300, Markku Ahvenjärvi wrote:
> Hi,
> 
> On Fri, Sep 25, 2026 at 10:32 AM Markku Ahvenjärvi <mankku@gmail.com> wrote:
> >
> > On Thu, Sep 24, 2026 at 8:57 PM Keith Busch <kbusch@kernel.org> wrote:
> > > Are you also using shadow doorbells?
> >
> > Yes. The ioeventfd calling nvme_cq_notifier() handler is only
> > configured when n->dbbuf_enabled == true.
> 
> A gentle ping on these series. Please let me know if further
> clarification or changes are needed.

Yeah, this looks fine to me. Lots of conference travel the last couple
weeks, so perpetually behind on reviews. :(

