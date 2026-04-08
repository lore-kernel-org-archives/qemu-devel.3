Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7DB10F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYDU-0002Jp-L0; Wed, 08 Apr 2026 15:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wAYCo-0001WI-OM
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wASE7-0003We-0t
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775652104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oh1lToRqu67BUbbJ1vjDrDDoEqqKRCKZp+BOZVyLi2g=;
 b=cZv0XJQSKELUQSMWwN+zNaodSH/Ufy9meacbfYjsGXxAF7MdlE7Yr+u08Vu9xoFcPaMKTS
 YLkOWlxzFSiN2HrUURQwSemeB9E8dLi5riBvpnB1ayjt//W+v1oeyDPqqr8lhfP0xnWb+D
 W7hJ5GJZxQ8BKdR4o4vLYrzwPYlPOqE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-kVcyDHiWMlSj31Pge4rR3w-1; Wed,
 08 Apr 2026 08:41:41 -0400
X-MC-Unique: kVcyDHiWMlSj31Pge4rR3w-1
X-Mimecast-MFC-AGG-ID: kVcyDHiWMlSj31Pge4rR3w_1775652099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50EF11956057; Wed,  8 Apr 2026 12:41:39 +0000 (UTC)
Received: from localhost (unknown [10.44.33.128])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 506C718002A6; Wed,  8 Apr 2026 12:41:38 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 14/15] s390x/pci: Implement migration for emulated devices
In-Reply-To: <e4e1ea36-29c7-47df-86d1-d108106a006a@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260402022921.298818-1-kshk@linux.ibm.com>
 <20260402022921.298818-15-kshk@linux.ibm.com>
 <021768ba-9871-421d-8b45-80c5ade6a456@redhat.com>
 <e4e1ea36-29c7-47df-86d1-d108106a006a@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 08 Apr 2026 14:41:35 +0200
Message-ID: <87eckpd3pc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Apr 08 2026, Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 4/8/26 6:01 AM, Thomas Huth wrote:
>> On 02/04/2026 04.29, Konstantin Shkolnyy wrote:
>>> Implement zPCI device state migration, consequently enabling migration
>>> of VMs that have emulated PCI devices, whether virtio or not.
>>> Migration is allowed for devices whose function handle has the
>>> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
>>> state of its zPCI emulator.
>>>
>>> Passthrough devices will continue to block migration.
>>>
>>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>> ---
>>> =C2=A0 hw/s390x/s390-pci-bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 112 ++++++++++++++++++++++++++++++--
>>> =C2=A0 hw/s390x/s390-pci-inst.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 include/hw/s390x/s390-pci-bus.h |=C2=A0=C2=A0 2 +
>>> =C2=A0 3 files changed, 110 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index f339a0fd94..b3037b9a8a 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> ...
>>> +static const VMStateDescription s390_pci_device_vmstate =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_S390_PCI_DEVICE,
>>> +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
>>> +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
>>> +=C2=A0=C2=A0=C2=A0 .post_load =3D s390_pci_device_post_load,
>>> +=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(state, S390P=
CIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT16(uid, S390PCI=
BusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(idx, S390PCI=
BusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(fh, S390PCIB=
usDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(fid, S390PCI=
BusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(fid_defined, S=
390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(fmb_addr, S3=
90PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(fmb.format, =
S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(fmb.sample, =
S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(fmb.last_upd=
ate, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64_ARRAY(fmb.co=
unter, S390PCIBusDevice,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(((S390PCIBusDevice *)0)->fmb.counter)),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(fmb.fmt0.dma=
_rbytes, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(fmb.fmt0.dma=
_wbytes, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(isc, S390PCIB=
usDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT16(noi, S390PCI=
BusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(sum, S390PCIB=
usDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(pft, S390PCIB=
usDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(routes.adapt=
er.ind_addr, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(routes.adapt=
er.summary_addr, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(routes.adapt=
er.ind_offset, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(routes.adapt=
er.summary_offset, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(routes.adapt=
er.adapter_id, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(iommu_enabled,=
 S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(g_iota, S390=
PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(pba, S390PCI=
BusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(pal, S390PCI=
BusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(max_dma_limi=
t, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_PTR_TO_IND_ADDR(sum=
mary_ind, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_PTR_TO_IND_ADDR(ind=
icator, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(pci_unplug_req=
uest_processed, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(unplug_request=
ed, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(interp, S390PC=
IBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(forwarding_ass=
ist, S390PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(aif, S390PCIBu=
sDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BOOL(rtr_avail, S39=
0PCIBusDevice),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 };
>> =C2=A0Hi!
>>=20
>> I assume this will likely break backward migration with old machine type=
s?
>>=20
>> Could you please try whether migrating a s390-ccw-virtio-10.2 machine
>> from an old version of QEMU to a version of QEMU that includes your
>> patches, and back from the new version to the old version works as
>> expected?
>>=20
>> If not, you might need to add a ".needed =3D ..." line to the
>> s390_pci_device_vmstate, with a function that checks a variable from the
>> machine state whether the PCI state is allowed or not. And then enable
>> that variable only on the newest -11.1 machine type once it is available.
>
> +1, I was having the same thought but hadn't gotten around to trying it y=
et.
>
> We do already have a few examples for zPCI where we did this even though
> migration was not even supported yet to kind of lay the groundwork for
> backward migration ahead of time.
>
> But honestly, looking at just this series in isolation, my concern is
> things like an older machine type would not have the IOMMU replay
> functionality added in patch 1.
>
> So yes, please test to see what happens but make sure to include IOMMU
> activity in that testing.
>
> Tying this to a machine type is probably the safest bet, and given that
> virtio-pci is not the default virtio transport on s390x I don't think it
> would cause much hardship.
> 11.1 machine isn't available yet but I imagine will be soon after QEMU
> 11.0 release -- you can use Connie's series as a base:
> https://lore.kernel.org/qemu-devel/20260331140347.653404-1-cohuck@redhat.=
com/

I agree, that needs to be tied to the machine type.

I'll pick up the 11.1 machine types patch as soon as I prepare the first
s390 pull req for 11.1, so there should be a good base around soon.


