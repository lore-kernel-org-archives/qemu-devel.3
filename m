Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3336CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5P7-0003iC-If; Thu, 21 May 2026 11:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ5Om-0003X7-HJ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ5Oa-0000zd-Ko
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779377581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mzjlZr+R4ObJ7iLyzh4BeKfen8hi75dcrlFM1IOlIYo=;
 b=GEfFwY549rAE/hDsveLhncoqyAQveh7wGKB4FhRC7Ujn6bjqW1UkMmoKJhvCuQjGMBqnbN
 arpFc9gHCi1QjkGAEa7lbfJ2gGi2UkLKFzjgvuRzOm+4RVAtNB7CDaSx5rs9q1nxlf+e86
 FY/vTXBb3hmnEQQ8ENyWxE1fFsx/iSk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-HoWVU8k6OUujTawC4HFZUQ-1; Thu, 21 May 2026 11:20:38 -0400
X-MC-Unique: HoWVU8k6OUujTawC4HFZUQ-1
X-Mimecast-MFC-AGG-ID: HoWVU8k6OUujTawC4HFZUQ_1779376838
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b58065ea15so10422596d6.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779376838; x=1779981638; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mzjlZr+R4ObJ7iLyzh4BeKfen8hi75dcrlFM1IOlIYo=;
 b=S3vGyvVMFOogyPMU4pphoreA3wHmixXmLE4U1Qe9oX4WpKNqrXlx3YH/970v6llMOg
 PwaCrBHLtRmfPvcghiVhS7jou57acMAC7AMJwyzWcJtBMPmLyPB+VNeFG6X4VUKvLmr9
 Oc04+yeG1kf8C1bXfl7cysd2bLxhi76pF2P6e2u/57uIUJoc9V900c2DdN+BfPYCDnji
 57ZcRjGXFaKeFr+1f7bFNP0Gzbqe3ba5sL+MKB9BzbYlZdevA9VBj8tv0dsh3Nfdorv2
 Z0UYJxwHqoWXT3jRXeQOuOhLO1iLvyvrDWoTY05wBtCN4nsle3bvvJRMGAtHDAvhVD5V
 FxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779376838; x=1779981638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzjlZr+R4ObJ7iLyzh4BeKfen8hi75dcrlFM1IOlIYo=;
 b=I4CbuU0lmWQ0Vyb9zJQBKY3NsPRpTGwylf3VpjPr1kt/C+bjKycK87eBFYtHaKLDHY
 uJrZEa2XftX5cITOXlSJmsW3Qy8s51JZC+tYMQpI0Oi1RHCjC2KnnEps+TAsQSfghi61
 iYBEB2iDW3scw5WB56oIRNuFCI2fCBJVWJVua35SRz2mb9W1HSXm67RVhn2+k4t2p3iZ
 PGAHqiSzPB8nMhB1CcHMSVV+/ia4O2FskIKZ58LMkv6Rz9KC3GQFM3jFVI1Ln8upYdip
 CSGkrI/ehDTtc+YnRcWfRFKq6MOSc2hyL5VvUGznytBSnvBXuBZarkt8AYxqvB6eOTAk
 07Yw==
X-Gm-Message-State: AOJu0YwGtbmKmoYJdRI2+LHuzu11IWB6k3IENP8ap+jZ1olHuO9XlUjH
 EWzBqUsUByYXnQikcKp78YRRp5orljEmp4UAn300YSsl5n+FofDGSKZV17p0Ye1kYPWtBj8+mTs
 8MvYIKSEFoLiIRIYHEse+bwGfNExMNjfKdP/abr8OPPpqyOamVgZYh51+
X-Gm-Gg: Acq92OESHDf6MATEaw1p+YvJ1LLzFpP5znDYBN3pnimfZBPZBJOgD6SWZ1rXpzFZ9vp
 j8V3+JYuYk8o7S2S4cPNatC1x+o8GTLOb4MwAATu8YsC7kvrWm9J20yDwCfrfAz4Z1z+C3uoGP/
 DuQGZWwo+M0qJcYuNqFG2nDvNb73BYWlCIC62y5msqDbmqp2s5/RKnDFMUFuoZ9qi3dTmFZVEDo
 ZJnd0qVzRULaaTHqwF6oCELDjLnc/4Xtw92FG7LXMD6NQgZFrg4muBfT6FegK+V6KYfDCQgVLSD
 67q2wIBh17mp0Dvm6fHEYTtSlqZT1YiZhhZUoF1cvEq46F7VmCPVXkZHXxZtzTXtp1STeAgyFTQ
 45MRnG8hIJuc5CHYHb/nB+ZCnndBOrP9yROZ8gUOElNzHw04=
X-Received: by 2002:a05:6214:27c1:b0:8ca:1ddd:a69f with SMTP id
 6a1803df08f44-8cc6e2e8d74mr54933636d6.2.1779376837844; 
 Thu, 21 May 2026 08:20:37 -0700 (PDT)
X-Received: by 2002:a05:6214:27c1:b0:8ca:1ddd:a69f with SMTP id
 6a1803df08f44-8cc6e2e8d74mr54932526d6.2.1779376836745; 
 Thu, 21 May 2026 08:20:36 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc768b71d2sm8088876d6.9.2026.05.21.08.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:20:35 -0700 (PDT)
Date: Thu, 21 May 2026 11:20:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Message-ID: <ag8iwiwMz5IapU5i@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <agzDdH5vClAqwjAs@x1.local>
 <3a1d0bc7-7656-43f4-b763-5114d9dc57a0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a1d0bc7-7656-43f4-b763-5114d9dc57a0@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026 at 04:53:54PM +0300, Avihai Horon wrote:
> 
> On 5/19/2026 11:09 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, May 05, 2026 at 11:14:09AM +0300, Avihai Horon wrote:
> > > Performance tests were done by migrating a single VM with:
> > > * 8 GB RAM
> > > * 4 mlx5 VFIO devices:
> > >    - One device with 1GB of device data (stopcopy data) that runs
> > >      workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
> > >      (generate new initial_bytes chunks during precopy).
> > Could you elaborate a bit more on what workload is executed, and how that
> > will affect REINIT reportings (e.g. is only one REINIT generated, or it
> > keeps generating)?
> 
> Basically, I create and destroy RDMA resources (MRs, QPs, CQs, etc.) on the
> VFIO device in a loop for several iterations.
> This generates several REINITs.
> 
> > 
> > Can I understand it in this way: without REINIT, device is forced to put
> > those data into stopcopy size; then with REINIT, some stopcopy size is
> > essentially moved back to precopy phase?
> 
> Almost:
> Without REINIT, the device is forced to put this data in precopy
> dirty_bytes.
> With REINIT, this data can be put in precopy init_bytes (and do the
> switchover-ack dance again).

Hmm, then I don't understand why moving some chunk of data from
precopy_bytes to init_bytes helps downtime.

Essentially, QEMU makes the switchover decision based on the math of:

   init+dirty+stop
   --------------- <= downtime_limit
         bw

The possible min of above is:

        stop
   ---------------
         bw

Here whether some data would be in init or precopy portion shouldn't matter
for a min downtime, since both portions are allowed to be moved during
precopy phase.

OTOH, if stop_bytes unchanged, min downtime is still the same before /
after supporting REINIT, if we try harder.

Say, with below testing results:

With VFIO_PRECOPY_INFO_REINIT:
  1335ms total (~520ms from the VFIO device running the workload).

Without VFIO_PRECOPY_INFO_REINIT:
  2352ms total (~1600ms from the VFIO device running the workload).

What is the downtime_limit you specified for both cases?  Have you tried to
specify lower downtime_limit than what you specified, so that both results
will become even closer (until they become, statistically, identical)?

In general, I can understand the REINIT will stop converging too early, but
it'll be the same IIUC just to turn the downtime_limit smaller..  IOW, I
may still miss some important piece of info that how this REINIT feature
helps downtime..

Thanks,

-- 
Peter Xu


