Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08FEC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWkK-0008OT-NQ; Thu, 01 Feb 2024 08:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVWkJ-0008Mx-09
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:04:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVWkG-00014Q-25
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:04:46 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQfDW6LTZz6K8pg;
 Thu,  1 Feb 2024 21:01:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 5DE29140CB9;
 Thu,  1 Feb 2024 21:04:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 13:04:39 +0000
Date: Thu, 1 Feb 2024 13:04:38 +0000
To: Sajjan Rao <sajjanr@gmail.com>
CC: Gregory Price <gregory.price@memverge.com>, Dimitrios Palyvos
 <dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>
Subject: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander shows
 numa_node -1
Message-ID: <20240201130438.00001384@Huawei.com>
In-Reply-To: <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com>
 <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 30 Jan 2024 13:50:18 +0530
Sajjan Rao <sajjanr@gmail.com> wrote:

> Hi Jonathan,
>=20
> The QEMU command line in the original email has been corrected back in
> August 2023 based on the subsequent responses.
>=20
> My current QEMU command line reads like below. As you can see I am not
> assigning numa to the CXL memory object.
>=20
> qemu-system-x86_64 \
>  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
>  -machine type=3Dq35,nvdimm=3Don,cxl=3Don \
>  -accel tcg,thread=3Dsingle \
>  -m 4G \
>  -smp cpus=3D4 \
>  -object memory-backend-ram,size=3D4G,id=3Dm0 \
>  -object memory-backend-ram,size=3D256M,id=3Dcxl-mem1 \
>  -object memory-backend-ram,size=3D256M,id=3Dcxl-mem2 \
>  -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 \
>  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.168.0.9,host=
fwd=3Dtcp::2222-:22
> \
>  -device virtio-net-pci,netdev=3Dnet0 \
>  -device pxb-cxl,bus_nr=3D2,bus=3Dpcie.0,id=3Dcxl.1,hdm_for_passthrough=
=3Dtrue \
>  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D0,slot=
=3D2 \
>  -device cxl-upstream,bus=3Dcxl_rp_port0,id=3Dus0,addr=3D0.0,multifunctio=
n=3Don, \
>  -device cxl-switch-mailbox-cci,bus=3Dcxl_rp_port0,addr=3D0.2,target=3Dus=
0 \
>  -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,slot=
=3D4 \
>  -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,slot=
=3D8 \
>  -device cxl-type3,bus=3Dswport0,volatile-memdev=3Dcxl-mem1,id=3Dcxl-vmem=
1 \
>  -device cxl-type3,bus=3Dswport1,volatile-memdev=3Dcxl-mem2,id=3Dcxl-vmem=
2 \
>  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D512M,cxl-fmw.0.interleav=
e-granularity=3D2k
> \
>  -D /tmp/qemu.log \
>  -nographic
>=20
> Until I moved to Qemu version 8.2 recently, I was able to create
> regions and run linux native commands on CXL memory using
> #numactl --membind <cxl NUMA#> top
>=20
> You had advised me to turn off KVM and use tcg since the membind
> command will run code out of CXL memory which is not supported. By
> disabling KVM the membind command worked fine.
> However with Qemu version 8.2 the same membind command results in a
> kernel hard crash.

Just to check, kernel crashes, or qemu crashes?

I've probably replicated and it seems to be qemu that is going down with a =
TCG issue.

Bisection underway.

This may take a while.
Our use of TCG is unusual with what QEMU thinks of as io memory is unusual
so we tend to run into corners no one else cares about.

Richard, +CC on off chance you can guess what has happened and save
me a bisection run..

x86 machine pretty much as described above

root@localhost:~/devmem2# numactl --membind=3D1 touch a
qemu: fatal: cpu_io_recompile: could not find TB for pc=3D(nil)
RAX=3D00d6b969c0000000 RBX=3Dff294696c0044440 RCX=3D0000000000000028 RDX=3D=
0000000000000000
RSI=3D0000000000000275 RDI=3D0000000000000000 RBP=3D0000000490000000 RSP=3D=
ff4f8767805d3d20
R8 =3D0000000000000000 R9 =3Dff4f8767805d3cdc R10=3D0000000000000000 R11=3D=
0000000000000040
R12=3Dff294696c0044980 R13=3D0000000000000000 R14=3Dff294696c51d0000 R15=3D=
0000000000000000
RIP=3Dffffffff9d270fed RFL=3D00000007 [-----PC] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0000 0000000000000000 00000000 00000000
CS =3D0010 0000000000000000 ffffffff 00af9b00 DPL=3D0 CS64 [-RA]
SS =3D0018 0000000000000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
DS =3D0000 0000000000000000 00000000 00000000
FS =3D0000 0000000000000000 00000000 00000000
GS =3D0000 ff2946973bc00000 00000000 00000000
LDT=3D0000 0000000000000000 00000000 00008200 DPL=3D0 LDT
TR =3D0040 fffffe37d29e7000 00004087 00008900 DPL=3D0 TSS64-avl
GDT=3D     fffffe37d29e5000 0000007f
IDT=3D     fffffe0000000000 00000fff
CR0=3D80050033 CR2=3D00007f2972bdc450 CR3=3D0000000490000000 CR4=3D00751ef0
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
CCS=3D00d6b969c0000000 CCD=3D0000000490000000 CCO=3DADDQ
EFER=3D0000000000000d01
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
YMM00=3D0000000000000000 0000000000000000 3a3a3a3a3a3a3a3a 3a3a3a3a3a3a3a3a
YMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM03=3D0000000000000000 0000000000000000 00ff0000000000ff 0000000000000000
YMM04=3D0000000000000000 0000000000000000 5f796c7261655f63 62696c5f5f004554
YMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000060
YMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM07=3D0000000000000000 0000000000000000 0909090909090909 0909090909090909
YMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM15=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000

Jonathan



> I wanted to check if this is a known issue with 8.2 and is there a way
> around it.
>=20
> Thanks,
> Sajjan
>=20
> On Fri, Jan 26, 2024 at 10:42=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 26 Jan 2024 10:43:43 -0500
> > Gregory Price <gregory.price@memverge.com> wrote:
> > =20
> > > On Fri, Jan 26, 2024 at 12:39:26PM +0000, Jonathan Cameron wrote: =20
> > > > On Thu, 25 Jan 2024 13:45:09 +0530
> > > > Sajjan Rao <sajjanr@gmail.com> wrote:
> > > > =20
> > > > > Looks like something changed in QEMU 8.2 that broke running code =
out
> > > > > of CXL memory with KVM disabled.
> > > > > I used "numactl --membind 2 ls" as suggested by Dimitrios earlier,
> > > > > this worked for me until I updated to the latest QEMU.
> > > > >
> > > > > Is this a known issue? Or am I missing something? =20
> > > >
> > > > I'm confused on how the description below ever worked.
> > > > Assigning the underlying memdev=3Dcxl-mem1 to a numa node isn't goi=
ng
> > > > to correctly build the connections the CFMWS PA range.
> > > > =20
> > >
> > > I've now seen 3-4 occasions where people have done this and run into
> > > trouble (for obvious reasons).  Is there anything we can do to disall=
ow
> > > the double-registering of a single memdev to both a numa node and a c=
xl
> > > device?
> > > =20
> > It would be novel for us to prevent people shooting themselves
> > in the foot ;) but I guess this should be fairly easy as the
> > numa node logic prevents the same one being used multiple times so can
> > copy how that is done.
> >
> > This should do the trick (very lightly tested).
> > It's end of day Friday here so a formal patch can wait for next week.
> >
> >
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index f29346fae7..d4194bb757 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -827,6 +827,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Er=
ror **errp)
> >              error_setg(errp, "volatile memdev must have backing device=
");
> >              return false;
> >          }
> > +        if (host_memory_backend_is_mapped(ct3d->hostvmem)) {
> > +            error_setg(errp, "memory backend %s can't be used multiple=
 times.",
> > +               object_get_canonical_path_component(OBJECT(ct3d->hostvm=
em)));
> > +            return false;
> > +        }
> >          memory_region_set_nonvolatile(vmr, false);
> >          memory_region_set_enabled(vmr, true);
> >          host_memory_backend_set_mapped(ct3d->hostvmem, true);
> > @@ -850,6 +855,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Er=
ror **errp)
> >              error_setg(errp, "persistent memdev must have backing devi=
ce");
> >              return false;
> >          }
> > +        if (host_memory_backend_is_mapped(ct3d->hostpmem)) {
> > +            error_setg(errp, "memory backend %s can't be used multiple=
 times.",
> > +               object_get_canonical_path_component(OBJECT(ct3d->hostpm=
em)));
> > +            return false;
> > +        }
> >          memory_region_set_nonvolatile(pmr, true);
> >          memory_region_set_enabled(pmr, true);
> >          host_memory_backend_set_mapped(ct3d->hostpmem, true);
> > @@ -880,6 +890,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Er=
ror **errp)
> >              error_setg(errp, "dynamic capacity must have backing devic=
e");
> >              return false;
> >          }
> > +        if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
> > +            error_setg(errp, "memory backend %s can't be used multiple=
 times.",
> > +               object_get_canonical_path_component(OBJECT(ct3d->dc.hos=
t_dc)));
> > +            return false;
> > +        }
> >          /* FIXME: set dc as nonvolatile for now */
> >          memory_region_set_nonvolatile(dc_mr, true);
> >          memory_region_set_enabled(dc_mr, true);
> >
> >
> >
> >
> > =20
> > > ~Gregory =20
> > =20


