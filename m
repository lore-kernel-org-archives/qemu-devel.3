Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9473CCFA07
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 09:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGZPs-0005Cr-Ov; Wed, 05 Nov 2025 04:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vGZPp-0005By-EC; Wed, 05 Nov 2025 04:02:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vGZPk-00078i-GG; Wed, 05 Nov 2025 04:02:53 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1fV73J7XzHnH97;
 Wed,  5 Nov 2025 17:02:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 796A91402FB;
 Wed,  5 Nov 2025 17:02:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 09:02:43 +0000
Date: Wed, 5 Nov 2025 09:02:42 +0000
To: Gavin Shan <gshan@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <anisinha@redhat.com>,
 <gengdongjiu1@gmail.com>, <peter.maydell@linaro.org>, <pbonzini@redhat.com>,
 <mchehab+huawei@kernel.org>, <shan.gavin@gmail.com>, James Houghton
 <jthoughton@google.com>
Subject: Re: [PATCH RESEND v2 3/3] target/arm/kvm: Support multiple memory
 CPERs injection
Message-ID: <20251105090242.00004f93@huawei.com>
In-Reply-To: <a4960b41-dd92-408f-a5e8-620b35be212b@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-4-gshan@redhat.com>
 <20251017162746.2a99015b@fedora>
 <a635de53-71fa-4edb-87c0-8775722c284d@redhat.com>
 <20251031145539.3551b0a5@fedora>
 <88a41137-d5fb-4b61-a3f2-dd73133c17ec@redhat.com>
 <20251103105216.1f4241d7@fedora>
 <20251104122151.00006feb@huawei.com>
 <a4960b41-dd92-408f-a5e8-620b35be212b@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 5 Nov 2025 10:40:10 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Jonathan and Igor,
> 
> On 11/4/25 10:21 PM, Jonathan Cameron wrote:
> > On Mon, 3 Nov 2025 10:52:16 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> 
> [...]
> 
> >> My idea using per cpu source is just a speculation based on spec
> >> on how workaround the problem,
> >> I don't really know if guest OS will be able to handle it (aka,
> >> need to be tested is it's viable). That also probably was a reason
> >> in previous review, why should've waited for multiple sources
> >> support be be merged first before this series.  
> > 
> > Per vCPU should work fine but I do like the approach here of reporting
> > all the related errors in one go as they represent the underlying nature
> > of the error granularity tracking. If anyone ever poisons at the 1GiB level
> > on the host they are on their own - so I think that it will only ever be
> > the finest granularity supported (so worse case 64KiB).
> >   
> 
> Well, I don't have strong opinions, but I intend to agree with Jonathan
> to report all 16x errors at once. One reason is one as Jonathan mentioned.
> Another reason is per vCPU error source is a bit heavy for the improvement.
> 
> So I'm going to improve (v2) series to address all received comments and
> post a (v3) series.
> 
> I already had the prototype of error source per vcpu, which works fine for
> 64KB-host-4KB-guest. However, it doesn't work for huge pages. For example,
> a problematic 512MB huge page can cause heavy memory error storm to QEMU
> where we absolutely can't handle.
> 
> 1. Start the VM with hugetlb pages
> 
> /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                                     \
> -accel kvm -machine virt,gic-version=host,nvdimm=on,ras=on                                  \
> -cpu host -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1                      \
> -m 4096M,slots=16,maxmem=128G                                                               \
> -object memory-backend-file,id=mem0,prealloc=on,mem-path=/dev/hugepages-524288kB,size=4096M \
> -numa node,nodeid=0,cpus=0-7,memdev=mem0                                                    \
> 
> 2. Run 'victim -d' on guest
> 
> guest$ ./victim -d
> physical address of (0xffff889d6000) = 0x11a7da000
> Hit any key to trigger error:
> 
> 3. Inject error from host
> 
> host$ errinjct 0x11a7da000
> 
> 4. QEMU crashes with error message "Bus error (core dumped)", which is triggered
> the following path.
> 
> sigbus_handler
>    kvm_on_sigbus_vcpu           // have_sigbus_pending = 1
>    sigbus_reraise

To me this sounds like something that should not be happening on the host unless
a real memory error is detected that blows away the whole of / most of a huge page.
I'm not sure we care about surviving that case if it isn't mapped using hugetlb/DAX or
similar in the guest (so contiguous in both with contained impact in both).

I assume the issue is backing with hugetlbfs which doesn't have a sub huge page granularity
for poison tracking.  I vaguely recall an effort to solve that
https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
was the first thing google threw me. Looks like it got to v2.
https://lore.kernel.org/linux-mm/20230218002819.1486479-1-jthoughton@google.com/

+CC James.

> 
> Thanks,
> Gavin
> 
> 


