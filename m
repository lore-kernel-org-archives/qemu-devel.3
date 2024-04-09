Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEDCC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 21:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruJMb-0002NV-V4; Tue, 09 Apr 2024 17:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akpm@linux-foundation.org>)
 id 1ruJMT-0002Jv-RX
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 17:50:37 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akpm@linux-foundation.org>)
 id 1ruJMM-0000iW-Od
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 17:50:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8D1C7CE2241;
 Tue,  9 Apr 2024 21:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEBCC433C7;
 Tue,  9 Apr 2024 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1712699424;
 bh=OdGUosTzjanbGQAzwiEZydBArCk/VVr1V8XWzZH9fJo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=foHbs2y4veHCZfs0/a/bJgqhpH1/Q4SmRz5GRT6k1OqlMTTh9R9uAGwzpqnzyMq40
 dWeDHzl6heeYaGWfAM9PxBs+DeYmyMwFKSAZGJtv0vyf9t6UMcAMP5JEZJ+mPiUP2j
 SeFl8DMHv4cS2TSoqhH11UKLSYubelRlhmuua22o=
Date: Tue, 9 Apr 2024 14:50:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Huang, Ying"
 <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, Vinicius
 Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc
 <Ravis.OpenSrc@micron.com>, Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae Park
 <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
Message-Id: <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
In-Reply-To: <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-2-horenchuang@bytedance.com>
 <20240405145624.00000b31@Huawei.com>
 <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=akpm@linux-foundation.org; helo=sin.source.kernel.org
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.751,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, 9 Apr 2024 12:00:06 -0700 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> Hi Jonathan,
> 
> On Fri, Apr 5, 2024 at 6:56 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri,  5 Apr 2024 00:07:05 +0000
> > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> >
> > > Since different memory devices require finding, allocating, and putting
> > > memory types, these common steps are abstracted in this patch,
> > > enhancing the scalability and conciseness of the code.
> > >
> > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
> >
> Thank you for reviewing and for adding your "Reviewed-by"!
> I was wondering if I need to send a v12 and manually add
> this to the commit description, or if this is sufficient.

I had added Jonathan's r-b to the mm.git copy of this patch.

