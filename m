Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F34AC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBLH-0003r3-8w; Thu, 06 Jun 2024 07:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leon@kernel.org>) id 1sFBLF-0003qd-7Q
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:31:37 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leon@kernel.org>) id 1sFBLD-0005l1-C5
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:31:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E1A6E61D3E;
 Thu,  6 Jun 2024 11:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C9BC2BD10;
 Thu,  6 Jun 2024 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717673486;
 bh=c21ncF4LD5w9wgc+ddGeBjKuWf0dlNtci4uPHd+IY2M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GGOAURs2j0aZkDsyaieY0mM/zXrJ0Dad6nPMtcVbw9019FN/ipQyfsuD2NkwUxLIB
 U9ADCDF50tVDgDKil00GsiebiRpYMpbTxZtCBO9ufQgqm6lJljKW1cTzyfmDfsudJi
 BzDe3uJJr6pBslypGwwSsdfCj5mFrxJOXKSpo6TxyYG3lKItvzjxbiGHp8QmEYeUbm
 Iadmercg+2S6/893cLhO0hgMeEchOkyITz1PVcJhQvELbQqJhyRZDvXOhOLfrwa8yD
 YoZ4bBOf4BUAztC3ib9hCz9I7HFqNdMezG7gbN+bZZeT7W7KVZ1iFieWNs70shjwNC
 R6DsCUm/+iJCQ==
Date: Thu, 6 Jun 2024 14:31:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <20240606113122.GG13732@unreal>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org>
 <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=leon@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 05, 2024 at 10:00:24AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Wednesday, June 5, 2024 3:57 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > Hi,
> > >
> > > This patch series attempts to refactor RDMA live migration by
> > > introducing a new QIOChannelRDMA class based on the rsocket API.
> > >
> > > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > > the detail of rdma protocol into rsocket and allows us to add support
> > > for some modern features like multifd more easily.
> > >
> > > Here is the previous discussion on refactoring RDMA live migration
> > > using the rsocket API:
> > >
> > > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linar
> > > o.org/
> > >
> > > We have encountered some bugs when using rsocket and plan to submit
> > > them to the rdma-core community.
> > >
> > > In addition, the use of rsocket makes our programming more convenient,
> > > but it must be noted that this method introduces multiple memory
> > > copies, which can be imagined that there will be a certain performance
> > > degradation, hoping that friends with RDMA network cards can help verify,
> > thank you!
> > 
> > So you didn't test it with an RDMA card?
> 
> Yep, we tested it by Soft-ROCE.

Does Soft-RoCE (RXE) support live migration?

Thanks

