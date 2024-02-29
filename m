Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB73CC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdwA-0004UJ-AN; Thu, 29 Feb 2024 05:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfdw4-0004U0-AO
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:46:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfdw1-0003IR-J6
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:46:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlnqZ24Mkz6H78J;
 Thu, 29 Feb 2024 18:42:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id AFA88140B63;
 Thu, 29 Feb 2024 18:46:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 10:46:37 +0000
Date: Thu, 29 Feb 2024 10:46:36 +0000
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
Message-ID: <20240229104636.00002d14@Huawei.com>
In-Reply-To: <2a07005c-6465-47da-ae89-dd6151e8ed74@canonical.com>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <Zd_Z2f-5_l3rXNbp@x1n>
 <2a07005c-6465-47da-ae89-dd6151e8ed74@canonical.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Thu, 29 Feb 2024 11:22:24 +0100
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> On 29.02.24 02:11, Peter Xu wrote:
> > On Wed, Feb 28, 2024 at 08:07:47PM +0100, Heinrich Schuchardt wrote: =20
> >> On 28.02.24 19:39, Peter Maydell wrote: =20
> >>> On Wed, 28 Feb 2024 at 18:28, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote: =20
> >>>>
> >>>> On 28.02.24 16:06, Philippe Mathieu-Daud=E9 wrote: =20
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On 28/2/24 13:59, Heinrich Schuchardt wrote: =20
> >>>>>> virtqueue_map_desc() is called with values of sz exceeding that may
> >>>>>> exceed
> >>>>>> TARGET_PAGE_SIZE. sz =3D 0x2800 has been observed. =20
> >=20
> > Pure (and can also be stupid) question: why virtqueue_map_desc() would =
map
> > to !direct mem?  Shouldn't those buffers normally allocated from guest =
RAM?
> >  =20
> >>>>>>
> >>>>>> We only support a single bounce buffer. We have to avoid
> >>>>>> virtqueue_map_desc() calling address_space_map() multiple times.
> >>>>>> Otherwise
> >>>>>> we see an error
> >>>>>>
> >>>>>>        qemu: virtio: bogus descriptor or out of resources
> >>>>>>
> >>>>>> Increase the minimum size of the bounce buffer to 0x10000 which ma=
tches
> >>>>>> the largest value of TARGET_PAGE_SIZE for all architectures.
> >>>>>>
> >>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.=
com>
> >>>>>> ---
> >>>>>> v2:
> >>>>>>       remove unrelated change
> >>>>>> ---
> >>>>>>     system/physmem.c | 8 ++++++--
> >>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/system/physmem.c b/system/physmem.c
> >>>>>> index e3ebc19eef..3c82da1c86 100644
> >>>>>> --- a/system/physmem.c
> >>>>>> +++ b/system/physmem.c
> >>>>>> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
> >>>>>>                 *plen =3D 0;
> >>>>>>                 return NULL;
> >>>>>>             }
> >>>>>> -        /* Avoid unbounded allocations */
> >>>>>> -        l =3D MIN(l, TARGET_PAGE_SIZE);
> >>>>>> +        /*
> >>>>>> +         * There is only one bounce buffer. The largest occuring
> >>>>>> value of
> >>>>>> +         * parameter sz of virtqueue_map_desc() must fit into the=
 bounce
> >>>>>> +         * buffer.
> >>>>>> +         */
> >>>>>> +        l =3D MIN(l, 0x10000); =20
> >>>>>
> >>>>> Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
> >>>>> TARGETS_BIGGEST_PAGE_SIZE?
> >>>>>
> >>>>> Then along:
> >>>>>      QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <=3D TARGETS_BIGGEST_PAGE_S=
IZE); =20
> >>>>
> >>>> Thank you Philippe for reviewing.
> >>>>
> >>>> TARGETS_BIGGEST_PAGE_SIZE does not fit as the value is not driven by=
 the
> >>>> page size.
> >>>> How about MIN_BOUNCE_BUFFER_SIZE?
> >>>> Is include/exec/memory.h the right include for the constant?
> >>>>
> >>>> I don't think that TARGET_PAGE_SIZE has any relevance for setting the
> >>>> bounce buffer size. I only mentioned it to say that we are not
> >>>> decreasing the value on any existing architecture.
> >>>>
> >>>> I don't know why TARGET_PAGE_SIZE ever got into this piece of code.
> >>>> e3127ae0cdcd ("exec: reorganize address_space_map") does not provide=
 a
> >>>> reason for this choice. Maybe Paolo remembers. =20
> >>>
> >>> The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
> >>> which was the first implementation of this function. I don't think
> >>> there's a particular reason for that value beyond that it was
> >>> probably a convenient value that was assumed to be likely "big enough=
".
> >>>
> >>> I think the idea with this bounce-buffer has always been that this
> >>> isn't really a code path we expected to end up in very often --
> >>> it's supposed to be for when devices are doing DMA, which they
> >>> will typically be doing to memory (backed by host RAM), not
> >>> devices (backed by MMIO and needing a bounce buffer). So the
> >>> whole mechanism is a bit "last fallback to stop things breaking
> >>> entirely".
> >>>
> >>> The address_space_map() API says that it's allowed to return
> >>> a subset of the range you ask for, so if the virtio code doesn't
> >>> cope with the minimum being set to TARGET_PAGE_SIZE then either
> >>> we need to fix that virtio code or we need to change the API
> >>> of this function. (But I think you will also get a reduced
> >>> range if you try to use it across a boundary between normal
> >>> host-memory-backed RAM and a device MemoryRegion.) =20
> >>
> >> If we allow a bounce buffer only to be used once (via the in_use flag)=
, why
> >> do we allow only a single bounce buffer?
> >>
> >> Could address_space_map() allocate a new bounce buffer on every call a=
nd
> >> address_space_unmap() deallocate it?
> >>
> >> Isn't the design with a single bounce buffer bound to fail with a
> >> multi-threaded client as collision can be expected? =20
> >=20
> > See:
> >=20
> > https://lore.kernel.org/r/20240212080617.2559498-1-mnissler@rivosinc.com
> >=20
> > For some reason that series didn't land, but it seems to be helpful in =
this
> > case too if e.g. there can be multiple of such devices.
> >=20
> > Thanks,
> >  =20
>=20
> Hello Peter Xu,
>=20
> thanks for pointing to your series. What I like about it is that it=20
> removes the limit of a single bounce buffer per AddressSpace.
>=20
> Unfortunately it does not solve my problem. You limit the sum of all of=20
> the allocations for a single AddressSpcace to=20
> DEFAULT_MAX_BOUNCE_BUFFER_SIZE =3D 4096 which is too small for my use cas=
e.

Agreed. For CXL memory (which indeed hits this with virtio-blk-pci for exam=
ple)
I'm carrying a far from subtle patch [1] on top of the series linked above
(which I would very much like to land asap!)  Note I also need:

https://lore.kernel.org/qemu-devel/20240215142817.1904-1-Jonathan.Cameron@h=
uawei.com/#t
[PATCH 0/3] physmem: Fix MemoryRegion for second access to cached MMIO Addr=
ess Space

otherwise the second 8 byte read comes from the wrong address space.
That used to accidentally trigger very large reads hence the rather excessi=
ve
size set below.  I haven't checked yet if a smaller size is fine as obvious=
ly
something as hacky as the below isn't going anywhere! Perhaps we need a rat=
her more
global version of x-max-bounce-buffers from Mattias' series?

[1]
diff --git a/system/physmem.c b/system/physmem.c
index 0a838f1b33..10e9d8da86 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2554,6 +2554,7 @@ static void memory_map_init(void)
     memory_region_init(system_memory, NULL, "system", UINT64_MAX);
     address_space_init(&address_space_memory, system_memory, "memory");

+    address_space_memory.max_bounce_buffer_size =3D 1024 * 1024 * 1024;
     system_io =3D g_malloc(sizeof(*system_io));
     memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
                           65536);


>=20
> Why do we need a limit?
> Why is it so tiny?
>=20
> Best regards
>=20
> Heinrich
>=20
>=20
>=20
>=20


