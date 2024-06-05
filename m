Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65EC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEnnv-0007y7-IV; Wed, 05 Jun 2024 06:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEnnu-0007xt-7M
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEnnr-0001FS-PU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717583013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=klsynvVKW5DTrmtKye+CioTAaTuFcNWDg8W+GFHUKSM=;
 b=X5WaPngirLImkaJUjgxyYf4Bb1VelhLYcRDt0HpA9lkQBrJfFkxvoYvj9iS/jxBvjrn5Wh
 b4xwlsQU8oThbG+AaeMfAYq4DQyQpL6yvzPICXuOe1q24K5tu9uU/D8KVGXs3XxHpQ2lEu
 3SYSNJNbo29yxtvR7fMZ00HBnAtRFVc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-56PZ5grKNia-wFEPtFFjDg-1; Wed, 05 Jun 2024 06:23:31 -0400
X-MC-Unique: 56PZ5grKNia-wFEPtFFjDg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52b9267d9d6so2891502e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 03:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717583010; x=1718187810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klsynvVKW5DTrmtKye+CioTAaTuFcNWDg8W+GFHUKSM=;
 b=YXms7Xjs78kruJ0Nq/EsqvpXRR1vh1eKJDPo9QxaBbGQpUeJ86HdKSv0mffTQKtZyP
 g99Yzn5DPcFk6/UoUkB6lURlo4hSc2JyRKKvW62S3aSMM1MraZdOOFen5n7IzS0Ptfvc
 x5aT4cQfkezJncXqdRqjML5+oSJD7APE2E4XUmiKZ9wj/nFc/gi/q1E3lgNTzZkQUUV2
 Ii+fOg6U4EuXGfaf7dFWdJ1Ypv8R411Nnd3DdGejcUpcCjBPPqoZcLRUQ8H68uJMeHOe
 V6GUYFPequDCwgEXWryFIfC0dCIqy0nSP38YXvJI1X8oHoFEPzUyB17RlHSQ2ny45LTn
 HW8Q==
X-Gm-Message-State: AOJu0YzehwAp7mqA6FjhJa/WbmqyjrRxW7Wd7ejPm0RJnA9DcvSszgA/
 rQ35PUURZA9pH4FzQozHrV3etbTINnBMqEBphKPHRd+l2mlnpsep+bg45dIccjQIzPfP3PEMt6F
 /X3OebKbhNYuGTd6ORtXAk+UTX92jmQ9SSwRucEl1AJjj5h7PLDZU
X-Received: by 2002:a05:6512:3481:b0:52b:8ad9:cf0a with SMTP id
 2adb3069b0e04-52bab4fca86mr1550274e87.51.1717583009774; 
 Wed, 05 Jun 2024 03:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI1EJwq+5iigab/2MhCGWa1YF9sou6D3GeBKs8zG0mx052UsuPFS2c2AdvBSeo1GOQhTitJA==
X-Received: by 2002:a05:6512:3481:b0:52b:8ad9:cf0a with SMTP id
 2adb3069b0e04-52bab4fca86mr1550248e87.51.1717583009169; 
 Wed, 05 Jun 2024 03:23:29 -0700 (PDT)
Received: from redhat.com ([2.55.8.167]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e1201a89sm547324066b.32.2024.06.05.03.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 03:23:28 -0700 (PDT)
Date: Wed, 5 Jun 2024 06:23:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
Message-ID: <20240605062209-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org>
 <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> 
> > You really should test with an RDMA card though, for correctness as much as
> > performance.
> > 
> We will, we just don't have RDMA cards environment on hand at the moment.
> 
> Regards,
> -Gonglei

Until it's tested on real hardware it is probably best to tag this
series as RFC in the subject.

> > 
> > > Jialin Wang (6):
> > >   migration: remove RDMA live migration temporarily
> > >   io: add QIOChannelRDMA class
> > >   io/channel-rdma: support working in coroutine
> > >   tests/unit: add test-io-channel-rdma.c
> > >   migration: introduce new RDMA live migration
> > >   migration/rdma: support multifd for RDMA migration
> > >
> > >  docs/rdma.txt                     |  420 ---
> > >  include/io/channel-rdma.h         |  165 ++
> > >  io/channel-rdma.c                 |  798 ++++++
> > >  io/meson.build                    |    1 +
> > >  io/trace-events                   |   14 +
> > >  meson.build                       |    6 -
> > >  migration/meson.build             |    3 +-
> > >  migration/migration-stats.c       |    5 +-
> > >  migration/migration-stats.h       |    4 -
> > >  migration/migration.c             |   13 +-
> > >  migration/migration.h             |    9 -
> > >  migration/multifd.c               |   10 +
> > >  migration/options.c               |   16 -
> > >  migration/options.h               |    2 -
> > >  migration/qemu-file.c             |    1 -
> > >  migration/ram.c                   |   90 +-
> > >  migration/rdma.c                  | 4205 +----------------------------
> > >  migration/rdma.h                  |   67 +-
> > >  migration/savevm.c                |    2 +-
> > >  migration/trace-events            |   68 +-
> > >  qapi/migration.json               |   13 +-
> > >  scripts/analyze-migration.py      |    3 -
> > >  tests/unit/meson.build            |    1 +
> > >  tests/unit/test-io-channel-rdma.c |  276 ++
> > >  24 files changed, 1360 insertions(+), 4832 deletions(-)  delete mode
> > > 100644 docs/rdma.txt  create mode 100644 include/io/channel-rdma.h
> > > create mode 100644 io/channel-rdma.c  create mode 100644
> > > tests/unit/test-io-channel-rdma.c
> > >
> > > --
> > > 2.43.0


