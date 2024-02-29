Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA9DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfe8A-00047i-P5; Thu, 29 Feb 2024 05:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfe86-00043j-Kg
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:59:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfe83-0007kS-3H
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:59:10 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tlp4r2VXbz6JBCf;
 Thu, 29 Feb 2024 18:54:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 4F392140FE5;
 Thu, 29 Feb 2024 18:59:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 10:59:01 +0000
Date: Thu, 29 Feb 2024 10:59:00 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Mattias Nissler <mnissler@rivosinc.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
Message-ID: <20240229105900.0000490e@Huawei.com>
In-Reply-To: <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 29 Feb 2024 09:38:29 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 28 Feb 2024 at 19:07, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 28.02.24 19:39, Peter Maydell wrote:  
> > > The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
> > > which was the first implementation of this function. I don't think
> > > there's a particular reason for that value beyond that it was
> > > probably a convenient value that was assumed to be likely "big enough".
> > >
> > > I think the idea with this bounce-buffer has always been that this
> > > isn't really a code path we expected to end up in very often --
> > > it's supposed to be for when devices are doing DMA, which they
> > > will typically be doing to memory (backed by host RAM), not
> > > devices (backed by MMIO and needing a bounce buffer). So the
> > > whole mechanism is a bit "last fallback to stop things breaking
> > > entirely".
> > >
> > > The address_space_map() API says that it's allowed to return
> > > a subset of the range you ask for, so if the virtio code doesn't
> > > cope with the minimum being set to TARGET_PAGE_SIZE then either
> > > we need to fix that virtio code or we need to change the API
> > > of this function. (But I think you will also get a reduced
> > > range if you try to use it across a boundary between normal
> > > host-memory-backed RAM and a device MemoryRegion.)  
> >
> > If we allow a bounce buffer only to be used once (via the in_use flag),
> > why do we allow only a single bounce buffer?
> >
> > Could address_space_map() allocate a new bounce buffer on every call and
> > address_space_unmap() deallocate it?
> >
> > Isn't the design with a single bounce buffer bound to fail with a
> > multi-threaded client as collision can be expected?  
> 
> Yeah, I don't suppose multi-threaded was particularly expected.
> Again, this is really a "handle the case where the guest does
> something silly" setup, which is why only one bounce buffer.
> 
> Why is your guest ending up in the bounce-buffer path?

Happens for me with emulated CXL memory. I think the case I saw
was split descriptors in virtio via address space caches
https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L4043

One bounce buffer is in use for the outer loop and another for the descriptors
it is pointing to.

Matthias' series makes this work fine.  I need to circle back and check
how big a cache this needs.  I'm carrying a silly size because of the
side effect of the address space bug here
https://lore.kernel.org/qemu-devel/20240215142817.1904-1-Jonathan.Cameron@huawei.com/#t
and can probably set it to much less than my currently 1GiB.

Jonathan

> 
> -- PMM
> 


