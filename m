Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B12CFB450
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 18:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxsGd-0003lG-FC; Mon, 07 Oct 2024 14:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leon@kernel.org>) id 1sxsGc-0003l1-E0
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:15:34 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leon@kernel.org>) id 1sxsGZ-0003PQ-Sn
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:15:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AA21A5C5C50;
 Mon,  7 Oct 2024 18:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152A6C4CEC6;
 Mon,  7 Oct 2024 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728324920;
 bh=gqHJwCIbdfrOnxiwwaMf8fDbuj9L9oc66uFjUXYdzUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oGoCrGF/+YcDlUHOvZyUbYA89NGdxyJDwuCqJR+RDUVAIlFGzU4Z6U2SXBSfgUv7Z
 XVCribpgPF8WJTXvzUT5D3Uqml4PzZ8rNV1yP0f1uZTl7JUlc3Ke9sk+3w4GskFkZG
 EaX0c4Tq8cpk6z7Z9/4s+burBTqJVd9Nvq21xSMuNL3VmAE37efwkQLTQXMnZSnofL
 u+4atW6NBcMx7lVQjXkCBwQQ+uf/uJosjBqWQg8/zwsfr1IADJga2TqjNpxaNbjCCD
 oMix8Zs091IvflZwEdZHMy66haHs3NcGmvG+Opum19/JLGfrD3Vbh6mP3H3Paybp78
 jvIpOXPvNS14w==
Date: Mon, 7 Oct 2024 21:15:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Yu Zhang <yu.zhang@ionos.com>, Sean Hefty <shefty@nvidia.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
Message-ID: <20241007181513.GC25819@unreal>
References: <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n>
 <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n>
 <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
 <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
 <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=leon@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 07, 2024 at 08:45:07AM -0500, Michael Galaxy wrote:
> Hi,
> 
> On 10/7/24 03:47, Yu Zhang wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> > 
> > Sure, as we talked at the KVM Forum, a possible approach is to set up
> > two VMs on a physical host, configure the SoftRoCE, and run the
> > migration test in two nested VMs to ensure that the migration data
> > traffic goes through the emulated RDMA hardware. I will continue with
> > this and let you know.
> > 
> Acknowledged. Do share if you have any problems with it, like if it has
> compatibility issues
> or if we need a different solution. We're open to change.
> 
> I'm not familiar with the "current state" of this or how well it would even
> work.

Any compatibility issue between versions of RXE (SoftRoCE) or between
RXE and real devices is a bug in RXE, which should be fixed.

RXE is expected to be compatible with rest RoCE devices, both virtual
and physical.

Thanks

> 
> - Michael
> 
> 
> > On Fri, Oct 4, 2024 at 4:06 PM Michael Galaxy <mgalaxy@akamai.com> wrote:
> > > 
> > > On 10/3/24 16:43, Peter Xu wrote:
> > > > !-------------------------------------------------------------------|
> > > >     This Message Is From an External Sender
> > > >     This message came from outside your organization.
> > > > |-------------------------------------------------------------------!
> > > > 
> > > > On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
> > > > > What about the testing solution that I mentioned?
> > > > > 
> > > > > Does that satisfy your concerns? Or is there still a gap here that needs to
> > > > > be met?
> > > > I think such testing framework would be helpful, especially if we can kick
> > > > it off in CI when preparing pull requests, then we can make sure nothing
> > > > will break RDMA easily.
> > > > 
> > > > Meanwhile, we still need people committed to this and actively maintain it,
> > > > who knows the rdma code well.
> > > > 
> > > > Thanks,
> > > > 
> > > OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
> > > along these lines that would ensure that future RDMA breakages are
> > > detected more easily?
> > > 
> > > What do you think?
> > > 
> > > - Michael
> > > 
> 

