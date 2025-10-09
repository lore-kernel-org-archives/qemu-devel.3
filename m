Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D89CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qX9-00077n-TZ; Thu, 09 Oct 2025 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v6qX7-00076o-BG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v6qX3-0001Yr-Io
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760015885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st7eVCyZkUUFHwBZ/R5BE0OrccUBlLlfl4/YPTxfBPc=;
 b=KnxhBeW26QtiDI4w2jY7FmgKeUIAh1V4nrQaGc1ehtb6dFzs8tATeAvucSOl8emc1Sf2iJ
 u+vS7AzwO4lINf46DQghNU79pUb5+vRFSxBa54+FrDKf4TcZYVdHdMYPKq9Yc5Vr18/O1T
 RydxG8dz0kvCQDXAd42WVO+oItb9n/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Pdi1n9rlO5iSxnGzlXxDeQ-1; Thu, 09 Oct 2025 09:18:02 -0400
X-MC-Unique: Pdi1n9rlO5iSxnGzlXxDeQ-1
X-Mimecast-MFC-AGG-ID: Pdi1n9rlO5iSxnGzlXxDeQ_1760015879
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso992537f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760015879; x=1760620679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=st7eVCyZkUUFHwBZ/R5BE0OrccUBlLlfl4/YPTxfBPc=;
 b=JhcjzHogw0gmyWbU7tsZO6/yXN7qzfN6okIq5s92VnUEC95K/+8y3qxnfc4PJvnDnP
 lEePoqOog/8yoEGpjaSW1B8oQAkmmbrhLP7q8R62KkiPJTjEtXPsLDMpX2Fi6/ubwKjd
 JclxN6VcpQFOQnGKJVDCzVbr9GErKzDm5lXNFKd1ETyMDg9SkVFTcB9zIi2wgIc+6h9O
 7ZR1tpYmfMhDakUoSei9lFv25ScHVcq7vGDLGV8DvyzSPXRv2SRlrVCNQTsfVfDK7D4B
 /gDjzaCto4IcTdOrR76pGGOel6CPTHYjrrDxEAbxJ402UzBMMoRfYZQoYUWqjFr6/WoX
 UzDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvCPo72ZpQcXUi+/oI0RBdZFvbiseH3R8U2nN33tppoocXyZUK2gYvr4Zq181czauJv3IX97i2Y8ip@nongnu.org
X-Gm-Message-State: AOJu0YyCLgv1uNoo5T9ykyYCJqdpfoSMXCujUcWwulTYNe03NNlgaJYf
 w1ceLpDya1ExJX6daBCnM4gXgOOqdqbMKkkhjXBuat7wFLGrLmfQmh3SPjNrp7vY3dCwU2cnCG5
 t3ybheJ5EBSf40z0wo2lNJO6iMzbnpleqhbqnXvxHGIy2nnpRYE9BTw5r
X-Gm-Gg: ASbGncsQPzctKF3CT3oUPtONn2rANn5gIjpGbrs5LyuWKe8iSwxtNvLu+Ky7GuYBdsu
 Lp9U9Mmq+n5WwkkvKNumZdg7Zy1SruVlD1oy5TFjtgAmf0KvZYigI3AKDOVpXx0qCY2rDqTFRP9
 /7pFLSwEnsKE+rNyFYN/dXkkXlR2OWYfyHx91Jvni6VP65xDcLq/2YFa3CP6MD8SJdUQ0xkMhip
 lyqzbQ8nbyZRCs1SHS1HUvMb9gIOQJFEfELXQ9PB9tN9yWUWo7xqAifv9IOSyzPZaxWp++t1Caf
 p745HpBfIfFYb/5QbWpKuGL4rOzkjRCkLq6t
X-Received: by 2002:a05:6000:1887:b0:3eb:8395:e2e0 with SMTP id
 ffacd0b85a97d-4266e8de16amr4776011f8f.51.1760015878566; 
 Thu, 09 Oct 2025 06:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkKedZ0tMLcCJr9wNaCpRdcM4VsmKHaB50IdVXsF70AwutFWMmkb4XtduBuxDtXRapYO6Tmg==
X-Received: by 2002:a05:6000:1887:b0:3eb:8395:e2e0 with SMTP id
 ffacd0b85a97d-4266e8de16amr4775964f8f.51.1760015877950; 
 Thu, 09 Oct 2025 06:17:57 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d62890sm81702145e9.14.2025.10.09.06.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 06:17:57 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:17:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "salil.mehta@huawei.com" <salil.mehta@huawei.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "armbru@redhat.com" <armbru@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>, Karl Heubaum
 <karl.heubaum@oracle.com>, "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 02/24] hw/core, qemu-options.hx: Introduce
 'disabledcpus' SMP parameter
Message-ID: <20251009151755.79b4e08f@fedora>
In-Reply-To: <9143F5AE-967B-4499-8A12-E7A47A764E51@oracle.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-3-salil.mehta@opnsrc.net>
 <9143F5AE-967B-4499-8A12-E7A47A764E51@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 9 Oct 2025 11:28:40 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> Hi Salil,
>=20
> > On 1 Oct 2025, at 01:01, salil.mehta@opnsrc.net wrote:
> >=20
> > From: Salil Mehta <salil.mehta@huawei.com>
> >=20
> > Add support for a new SMP configuration parameter, 'disabledcpus', which
> > specifies the number of additional CPUs that are present in the virtual
> > machine but administratively disabled at boot. These CPUs are visible in
> > firmware (e.g. ACPI tables) yet unavailable to the guest until explicit=
ly
> > enabled via QMP/HMP, or via the 'device_set' API (introduced in later
> > patches).
> >=20
> > This feature is intended for architectures that lack native CPU hotplug
> > support but can change the administrative power state of present CPUs.
> > It allows simulating CPU hot-add=E2=80=93like scenarios while all CPUs =
remain
> > physically present in the topology at boot time.
> >=20
> > Note: ARM is the first architecture to support this concept.
> >=20
> > Changes include:
> > - Extend CpuTopology with a 'disabledcpus' field.
> > - Update machine_parse_smp_config() to account for disabled CPUs when
> >   computing 'cpus' and 'maxcpus'.
> > - Update SMPConfiguration in QAPI to accept 'disabledcpus'.
> > - Extend -smp option documentation to describe 'disabledcpus' usage and
> >   behavior.
> >  =20
>=20
> Specifying a new parameter for the user seems unnecessary when the system=
 could
> infer the number of present and disabled from (maxcpus - cpus) and those =
this
> patch calls "disabledcpus" could be obtained this way.
>=20
> Naming is hard although it is of my opinion that we shouldn't be
> calling 'disabledcpus' here; I understand that gets carried by previous
> administrative power state meanings but machine-smp level being at a diff=
erent
> abstraction level the administrative power state concept could be
> decoupled from machine-smp realm.


> My suggestion would be calling those cpus 'inactive' and not carry previo=
us
> patch's nomenclature.
>=20
> CPUs in 'inactive' state are still present in the virtual machine althoug=
h this
> pre-condition may require post actions like being explicitly 'enabled'/ac=
tive via
> [QH]MP.
>=20
> Overall, I believe the above should be all it takes to simplify acommodat=
ion of
> CPUs not to be brought online at boot time within this patch's context.

See my reply to cover letter, we shouldn't touch -smp at all.
And make -device/device_add work with virt/arm cpus instead,
that solves a number of issues that this and -deviceset patches introduce.=
=20

> Thanks
> Miguel
>=20
>=20
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> > hw/core/machine-smp.c | 24 +++++++-----
> > include/hw/boards.h   |  2 +
> > qapi/machine.json     |  3 ++
> > qemu-options.hx       | 86 +++++++++++++++++++++++++++++++++----------
> > system/vl.c           |  3 ++
> > 5 files changed, 89 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> > index 0be0ac044c..c1a09fdc3f 100644
> > --- a/hw/core/machine-smp.c
> > +++ b/hw/core/machine-smp.c
> > @@ -87,6 +87,7 @@ void machine_parse_smp_config(MachineState *ms,
> > {
> >     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> >     unsigned cpus    =3D config->has_cpus ? config->cpus : 0;
> > +    unsigned disabledcpus =3D config->has_disabledcpus ? config->disab=
ledcpus : 0;
> >     unsigned drawers =3D config->has_drawers ? config->drawers : 0;
> >     unsigned books   =3D config->has_books ? config->books : 0;
> >     unsigned sockets =3D config->has_sockets ? config->sockets : 0;
> > @@ -166,8 +167,13 @@ void machine_parse_smp_config(MachineState *ms,
> >         sockets =3D sockets > 0 ? sockets : 1;
> >         cores =3D cores > 0 ? cores : 1;
> >         threads =3D threads > 0 ? threads : 1;
> > +
> > +        maxcpus =3D drawers * books * sockets * dies * clusters *
> > +                    modules * cores * threads;
> > +        cpus =3D maxcpus - disabledcpus;
> >     } else {
> > -        maxcpus =3D maxcpus > 0 ? maxcpus : cpus;
> > +        maxcpus =3D maxcpus > 0 ? maxcpus : cpus + disabledcpus;
> > +        cpus =3D cpus > 0 ? cpus : maxcpus - disabledcpus;
> >=20
> >         if (mc->smp_props.prefer_sockets) {
> >             /* prefer sockets over cores before 6.2 */
> > @@ -207,12 +213,8 @@ void machine_parse_smp_config(MachineState *ms,
> >         }
> >     }
> >=20
> > -    total_cpus =3D drawers * books * sockets * dies *
> > -                 clusters * modules * cores * threads;
> > -    maxcpus =3D maxcpus > 0 ? maxcpus : total_cpus;
> > -    cpus =3D cpus > 0 ? cpus : maxcpus;
> > -
> >     ms->smp.cpus =3D cpus;
> > +    ms->smp.disabledcpus =3D disabledcpus;
> >     ms->smp.drawers =3D drawers;
> >     ms->smp.books =3D books;
> >     ms->smp.sockets =3D sockets;
> > @@ -226,6 +228,8 @@ void machine_parse_smp_config(MachineState *ms,
> >     mc->smp_props.has_clusters =3D config->has_clusters;
> >=20
> >     /* sanity-check of the computed topology */
> > +    total_cpus =3D maxcpus =3D drawers * books * sockets * dies * clus=
ters *
> > +                modules * cores * threads;
> >     if (total_cpus !=3D maxcpus) {
> >         g_autofree char *topo_msg =3D cpu_hierarchy_to_string(ms);
> >         error_setg(errp, "Invalid CPU topology: "
> > @@ -235,12 +239,12 @@ void machine_parse_smp_config(MachineState *ms,
> >         return;
> >     }
> >=20
> > -    if (maxcpus < cpus) {
> > +    if (maxcpus < (cpus + disabledcpus)) {
> >         g_autofree char *topo_msg =3D cpu_hierarchy_to_string(ms);
> >         error_setg(errp, "Invalid CPU topology: "
> > -                   "maxcpus must be equal to or greater than smp: "
> > -                   "%s =3D=3D maxcpus (%u) < smp_cpus (%u)",
> > -                   topo_msg, maxcpus, cpus);
> > +                   "maxcpus must be equal to or greater than smp[+disa=
bledcpus]:"
> > +                   "%s =3D=3D maxcpus (%u) < smp_cpus (%u) [+ offline =
cpus (%u)]",
> > +                   topo_msg, maxcpus, cpus, disabledcpus);
> >         return;
> >     }
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index f94713e6e2..2b182d7817 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -361,6 +361,7 @@ typedef struct DeviceMemoryState {
> > /**
> >  * CpuTopology:
> >  * @cpus: the number of present logical processors on the machine
> > + * @disabledcpus: the number additional present but admin disabled cpus
> >  * @drawers: the number of drawers on the machine
> >  * @books: the number of books in one drawer
> >  * @sockets: the number of sockets in one book
> > @@ -373,6 +374,7 @@ typedef struct DeviceMemoryState {
> >  */
> > typedef struct CpuTopology {
> >     unsigned int cpus;
> > +    unsigned int disabledcpus;
> >     unsigned int drawers;
> >     unsigned int books;
> >     unsigned int sockets;
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 038eab281c..e45740da33 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1634,6 +1634,8 @@
> > #
> > # @cpus: number of virtual CPUs in the virtual machine
> > #
> > +# @disabledcpus: number of additional present but disabled(or offline)=
 CPUs
> > +#
> > # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
> > #     machine
> > #
> > @@ -1657,6 +1659,7 @@
> > ##
> > { 'struct': 'SMPConfiguration', 'data': {
> >      '*cpus': 'int',
> > +     '*disabledcpus': 'int',
> >      '*drawers': 'int',
> >      '*books': 'int',
> >      '*sockets': 'int',
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index ab23f14d21..83ccde341b 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -326,12 +326,15 @@ SRST
> > ERST
> >=20
> > DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> > -    "-smp [[cpus=3D]n][,maxcpus=3Dmaxcpus][,drawers=3Ddrawers][,books=
=3Dbooks][,sockets=3Dsockets]\n"
> > -    "               [,dies=3Ddies][,clusters=3Dclusters][,modules=3Dmo=
dules][,cores=3Dcores]\n"
> > -    "               [,threads=3Dthreads]\n"
> > -    "                set the number of initial CPUs to 'n' [default=3D=
1]\n"
> > -    "                maxcpus=3D maximum number of total CPUs, includin=
g\n"
> > -    "                offline CPUs for hotplug, etc\n"
> > +    "-smp [[cpus=3D]n][,disabledcpus=3Ddisabledcpus][,maxcpus=3Dmaxcpu=
s][,drawers=3Ddrawers][,books=3Dbooks]\n"
> > +    "               [,sockets=3Dsockets][,dies=3Ddies][,clusters=3Dclu=
sters][,modules=3Dmodules]\n"
> > +    "               [,cores=3Dcores][,threads=3Dthreads]\n"
> > +    "                set the initial number of CPUs present and\n"
> > +    "                  administratively enabled at boot time to 'n' [d=
efault=3D1]\n"
> > +    "                disabledcpus=3D number of present but administrat=
ively\n"
> > +    "                  disabled CPUs (unavailable to the guest at boot=
)\n"
> > +    "                maxcpus=3D maximum total CPUs (present + hotplugg=
able)\n"
> > +    "                  on machines without CPU hotplug, defaults to n =
+ disabledcpus\n"
> >     "                drawers=3D number of drawers on the machine board\=
n"
> >     "                books=3D number of books in one drawer\n"
> >     "                sockets=3D number of sockets in one book\n"
> > @@ -351,22 +354,49 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> >     "      For a particular machine type board, an expected CPU topolog=
y hierarchy\n"
> >     "      can be defined through the supported sub-option. Unsupported=
 parameters\n"
> >     "      can also be provided in addition to the sub-option, but thei=
r values\n"
> > -    "      must be set as 1 in the purpose of correct parsing.\n",
> > +    "      must be set as 1 in the purpose of correct parsing.\n"
> > +    "                                                          \n"
> > +    "      Administratively disabled CPUs: Some machine types do not s=
upport vCPU\n"
> > +    "      hotplug but their CPUs can be marked disabled (powered off)=
 and kept\n"
> > +    "      unavailable to the guest. Later, such CPUs can be enabled v=
ia QMP/HMP\n"
> > +    "      (e.g., 'device_set ... admin-state=3Denable'). This is simi=
lar to hotplug,\n"
> > +    "      except all disabled CPUs are already present at boot. Usefu=
l on\n"
> > +    "      architectures that lack architectural CPU hotplug.\n",
> >     QEMU_ARCH_ALL)
> > SRST
> > -``-smp [[cpus=3D]n][,maxcpus=3Dmaxcpus][,drawers=3Ddrawers][,books=3Db=
ooks][,sockets=3Dsockets][,dies=3Ddies][,clusters=3Dclusters][,modules=3Dmo=
dules][,cores=3Dcores][,threads=3Dthreads]``
> > -    Simulate a SMP system with '\ ``n``\ ' CPUs initially present on
> > -    the machine type board. On boards supporting CPU hotplug, the opti=
onal
> > -    '\ ``maxcpus``\ ' parameter can be set to enable further CPUs to be
> > -    added at runtime. When both parameters are omitted, the maximum nu=
mber
> > +``-smp [[cpus=3D]n][,disabledcpus=3Ddisabledcpus][,maxcpus=3Dmaxcpus][=
,drawers=3Ddrawers][,books=3Dbooks][,sockets=3Dsockets][,dies=3Ddies][,clus=
ters=3Dclusters][,modules=3Dmodules][,cores=3Dcores][,threads=3Dthreads]``
> > +    Simulate a SMP system with '\ ``n``\ ' CPUs initially present & en=
abled on
> > +    the machine type board. Furthermore, on architectures that support=
 changing
> > +    the administrative power state of CPUs, optional '\ ``disabledcpus=
``\ '
> > +    parameter specifies *additional* CPUs that are present in firmware=
 (e.g.,
> > +    ACPI) but are administratively disabled (i.e., not usable by the g=
uest at
> > +    boot time).
> > +
> > +    This is different from CPU hotplug where additional CPUs are not e=
ven
> > +    present in the system description. Administratively disabled CPUs =
appear in
> > +    ACPI tables i.e. are provisioned, but cannot be used until explici=
tly
> > +    enabled via QMP/HMP or the deviceset API.
> > +
> > +    On boards supporting CPU hotplug, the optional '\ ``maxcpus``\ ' p=
arameter
> > +    can be set to enable further CPUs to be added at runtime. When both
> > +    '\ ``n``\ ' & '\ ``maxcpus``\ ' parameters are omitted, the maximu=
m number
> >     of CPUs will be calculated from the provided topology members and t=
he
> > -    initial CPU count will match the maximum number. When only one of =
them
> > -    is given then the omitted one will be set to its counterpart's val=
ue.
> > -    Both parameters may be specified, but the maximum number of CPUs m=
ust
> > -    be equal to or greater than the initial CPU count. Product of the
> > -    CPU topology hierarchy must be equal to the maximum number of CPUs.
> > -    Both parameters are subject to an upper limit that is determined by
> > -    the specific machine type chosen.
> > +    initial CPU count will match the maximum number. When only one of =
them is
> > +    given then the omitted one will be set to its counterpart's value.=
 Both
> > +    parameters may be specified, but the maximum number of CPUs must b=
e equal
> > +    to or greater than the initial CPU count. Product of the CPU topol=
ogy
> > +    hierarchy must be equal to the maximum number of CPUs. Both parame=
ters are
> > +    subject to an upper limit that is determined by the specific machi=
ne type
> > +    chosen. Boards that support administratively disabled CPUs but do =
*not*
> > +    support CPU hotplug derive the maximum number of CPUs implicitly:
> > +    '\ ``maxcpus``\ ' is treated as '\ ``n + disabledcpus``\ ' (the to=
tal CPUs
> > +    present in firmware). If '\ ``maxcpus``\ ' is provided, it must eq=
ual
> > +    '\ ``n + disabledcpus``\ '. The topology product must equal this d=
erived
> > +    maximum as well.
> > +
> > +    Note: Administratively disabled CPUs will appear to the guest as
> > +    unavailable, and any attempt to bring them online must go through =
QMP/HMP
> > +    commands like 'device_set'.
> >=20
> >     To control reporting of CPU topology information, values of the top=
ology
> >     parameters can be specified. Machines may only support a subset of =
the
> > @@ -425,6 +455,24 @@ SRST
> >=20
> >         -smp 2
> >=20
> > +    Examples using 'disabledcpus':
> > +
> > +    For a board without CPU hotplug, enable 4 CPUs at boot and provisi=
on
> > +    2 additional administratively disabled CPUs (maximum is derived
> > +    implicitly as 6 =3D 4 + 2):
> > +
> > +    ::
> > +
> > +        -smp cpus=3D4,disabledcpus=3D2
> > +
> > +    For a board that supports CPU hotplug and 'disabledcpus', enable 4=
 CPUs
> > +    at boot, provision 2 administratively disabled CPUs, and allow hot=
plug of
> > +    2 more CPUs (for a maximum of 8):
> > +
> > +    ::
> > +
> > +        -smp cpus=3D4,disabledcpus=3D2,maxcpus=3D8
> > +
> >     Note: The cluster topology will only be generated in ACPI and expos=
ed
> >     to guest if it's explicitly specified in -smp.
> > ERST
> > diff --git a/system/vl.c b/system/vl.c
> > index 3b7057e6c6..2f0fd21a1f 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -736,6 +736,9 @@ static QemuOptsList qemu_smp_opts =3D {
> >         {
> >             .name =3D "cpus",
> >             .type =3D QEMU_OPT_NUMBER,
> > +        }, {
> > +            .name =3D "disabledcpus",
> > +            .type =3D QEMU_OPT_NUMBER,
> >         }, {
> >             .name =3D "drawers",
> >             .type =3D QEMU_OPT_NUMBER,
> > --=20
> > 2.34.1
> >  =20
>=20


