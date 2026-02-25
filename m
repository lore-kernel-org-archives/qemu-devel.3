Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609E1FD377A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIxC-0001Ms-21; Wed, 25 Feb 2026 12:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vvIx9-0001Ln-5X
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:45:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vvIx6-0005VC-Iu
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:45:38 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fLhnH149mzJ469l;
 Thu, 26 Feb 2026 01:45:07 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id AF15740571;
 Thu, 26 Feb 2026 01:45:30 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Feb
 2026 17:45:29 +0000
Date: Wed, 25 Feb 2026 17:45:24 +0000
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <anisa.su887@gmail.com>, <armbru@redhat.com>,
 <david@kernel.org>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <lizhijian@fujitsu.com>, <mst@redhat.com>,
 <nifan.cxl@gmail.com>, <peterx@redhat.com>, <philmd@linaro.org>,
 <ppbonzini@redhat.com>, <venkataravis@micron.com>,
 <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v4 0/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <20260225174524.00003830.alireza.sanaee@huawei.com>
In-Reply-To: <aZ8pZXR5Jv4_uB4q@gourry-fedora-PF4VCD3F>
References: <20260225151916.390-1-alireza.sanaee@huawei.com>
 <aZ8pZXR5Jv4_uB4q@gourry-fedora-PF4VCD3F>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 25 Feb 2026 11:55:01 -0500
Gregory Price <gourry@gourry.net> wrote:

Hi Gregory,

> On Wed, Feb 25, 2026 at 03:19:12PM +0000, Alireza Sanaee wrote:
> > Hey everyone,
> > 
> > This is v4 of performant CXL type 3 regions set:
> > 
> > v3 -> v4: 1) Tear down path changed, given that it is done differently than
> >           setup.
> >           2) Dropped Gregory's tested-by tag due to tear down changes.
> > v2 -> v3: Addressing Zhijian Li. Thanks for the feedback.
> > v1 -> v2: Mainly rebase.
> > 
> > Base: 6593154e7d65f61d8f9dbeb98224731b7137c53e
> >   
> 
> slight oddity - i should be able to pull this in with b4 shazam directly
> on top of this base commit, but i had to give it a merge-base manually
> with this commit to get it to fixup conflicts.
> 
> I would not have expected conflicts if this is the actual merge base,
> you might want to double check that.
> 
> ~Gregory

I will send a v5, it looks like there is also a problem with the patch-style :(

In the meantime, this is the tree: https://github.com/sarsanaee/qemu-lab/commits/performant-v5-25-02-26  and the base looks fine, just double-checked with a new qemu clone directory! Not sure, what did I get wrong.

Ali




