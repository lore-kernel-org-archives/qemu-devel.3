Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426E606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5gPBLrc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVbsU-0007lU-NQ; Mon, 23 Nov 2026 16:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVbsJ-0007k4-5X; Mon, 23 Nov 2026 16:47:01 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVbsG-0006cz-Lv; Mon, 23 Nov 2026 16:46:58 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1176D611AD;
 Mon, 23 Nov 2026 21:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0EB1F000C0;
 Mon, 23 Nov 2026 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795470414;
 bh=tXPDT56QxnRQdey/fp+7Tb9WcgKnsZ2DbGrWc2y15FM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=V5gPBLrcUwdV2Zfox+Vj7Ud+HOynbN7gKThC7rVP+a93SpPOsXk3B5d5Kh/Zaraig
 +lhjeC+NArPevxTYpXRSV1gO1AQUOW68MdfcyF5NneHnxp5Xh5MnxwKAGP1uOHyXHo
 r5ezEltBeMg2w05GCRz1gGAAOZaJuV5paZIEhqrtbCodYNeWP6aA5EOg5tP41AzYHL
 uK5mmZx5L7/EZrEfwPHQz+Dd30RyviURDt+NQ5TcAK8IMOZNyJ2foJQlsktFmKTqXN
 /upBua0KnpjFbI0Nss0vTKHDgsgf2tNTbOIAbIrzxBpY1iMzsMsGQvQPHJlD+Nn5BD
 yt5BjK4Mg4AZw==
Date: Mon, 23 Nov 2026 13:46:52 -0800
From: Drew Fustini <fustini@kernel.org>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Subject: Re: [PATCH v8 4/6] hw/riscv: implement CBQRI bandwidth controller
Message-ID: <awS0TGb7HbDVm7Ru@x1>
References: <20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org>
 <20261111-riscv-ssqosid-cbqri-v8-4-121f6dcfb573@kernel.org>
 <87e5d269-d875-4afb-87cf-2b2658a7b740@oss.qualcomm.com>
 <awSBkD9LuNBoZLm4@thelio>
 <a39697db-832b-4746-b16a-d4df27c5171e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39697db-832b-4746-b16a-d4df27c5171e@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 05:39:24PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 11/23/2026 3:10 PM, Drew Fustini wrote:
> > On Mon, Nov 23, 2026 at 12:22:03PM -0300, Daniel Henrique Barboza wrote:
> > > 
> > > 
> > > On 11/11/2026 8:38 PM, Drew Fustini wrote:
> > > > From: Nicolas Pitre <npitre@baylibre.com>
> > > > 
> > > > Implement a bandwidth controller according to the Capacity and Bandwidth
> > > > QoS Register Interface (CBQRI) which supports these capabilities:
> > > > 
> > > >     - Number of access types: 2 (code and data)
> > > >     - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
> > > >     - Event IDs supported: None, Total read/write byte count, Total
> > > >                            read byte count, Total write byte count
> > > >     - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
> > > > 
> > > > The controller gives the Linux resctrl support for CBQRI a device to
> > > > configure and read back bandwidth limits per RCID on the virt machine.
> > > > Only the register interface is modeled. The configured limits are not
> > > > enforced and the monitoring counters are always marked INVALID because
> > > > QEMU does not model memory bandwidth usage.
> > > > 
> > > > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > > > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > > > [fustini: rebase, add fields introduced in the ratified spec]
> > > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > > > ---
> > > 
> > > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > 
> > Thank you for reviewing.
> > 
> > Alistair told me in the qemu riscv call last week that I should have a
> > tcg test for srmcfg csr. I need to send a v9 with that added.
> 
> We had a call?  Guess I missed it :D

I would have too without Palmer's calendar:
https://lore.kernel.org/all/CANs6eM=nBQO-dpY6ib0qdfihJUPcYmM3xAhkqV6_6d_jsX5K9Q@mail.gmail.com/

It was only a couple people so I think most people forgot. I think
Alistair said next time he would try to ping the list beforehand.

> 
> > 
> > Alistair also expressed concern about adding caches to the virt machine.
> > He explained to me that the virt machine is really meant to be used with
> > kvm and there really is not a role for modeling caches in that scenario.
> > 
> > I had recently considered sending v9 with just the Ssqosid patches and
> > holding back the CBQRI controller patches until there is a real hardware
> > platform to model as a machine in qemu that implements both capacity
> > controllers and bandwidth controllers. Atlantis only implements capacity
> > allocation for the shared cache with no monitoring, and there is no
> > bandwidth controller.
> > 
> > However, I am thinking this morning that I should probably just post all
> > the patches again for v9 and see what people think. I think the RQSC
> > series is more complicated since it does need caches added to some
> > machine in qemu and I am not sure what the right answer is for that.
> 
> Fair enough.  Don't forget to add all the acks you've collected along the way.

Yeah, I use b4 trailers -u so it should catch them all.

Thanks,
Drew




