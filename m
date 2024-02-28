Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3E2C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGCx-0006LB-8y; Wed, 28 Feb 2024 04:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rfGCh-00065u-L5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:26:23 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rfGCe-0005yT-7N
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:26:19 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41S0ZW9L005654; Wed, 28 Feb 2024 01:26:13 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3whjm6bfuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Feb 2024 01:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jcx7Gdh/oqe0Ybk9d/xPtwHC+Cv2JUCSX9VAvVKfn9ysEm3MoZqGgfw2xR5z5ei4mojFeXVidtDdaP4uhi4mp2HleYrggpVCbYYtTDLUWc48AppqQnmo9vPeWFMQPAx1NSaAKSTwquZCJcPyPlRvGPKArYrNnHVbLwMLjB7TrDFuLTHM0/VGlx6s6g0dcC2xjQ7muFALZ1LrZ3bD97lqfkZrsZNQE9Ae6ovfB5BCNHt8VZxdf9o6N6pzpl6Ni3K9GqrnQ+mdxFLo3wW+hO0lrVkF9E5/vaqMZ7Ph5yO3d5DARDYWacldplnRtFvR9eRdc30gB9CibCr10hOcV2rkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+/b0Nn3dQurdh+xAjwr70uVooEUuNPNnhf21JnVCBI=;
 b=IrMnvR72qYDS5P84pU5cFwWQ6x91FTUwp3qgrLAF/xaEi+12dK7YZsgQKtQnolJTRoSmwuI6MuxRL0LBTL7u4h1pcDrmBWt7ssw9vz6ICv5Xf9ukOJS9spTpyM8LnvLhUZty9skiL64GY3j46jLR4iI4skX7+kPfrVhwOXU5XDB6aeg32qIoPRtk8aEvBusPq55m9Nyrvd079Zc3EVQoUbXfA96tgaownpIBfxTsUbGZtFVkdTRNVGucNEWbn2QvGCf/vD9qvb5y/pAVTXThvxFuzV206991HPskwAD7GUVrI8s1wX29Vbk4oPBZxJPdBId2NS6Y6XD2DjfeQsRCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+/b0Nn3dQurdh+xAjwr70uVooEUuNPNnhf21JnVCBI=;
 b=ZnLCq/CfTOSsOzs+OqrtaYKOGsQDemHwrKpOOt0Oxm6m0ZW8UawHsdrjWOe8q1Hhf4R8ZieIhnCznJBrjlzI/jA3GAMdPFLKah52v8HP0v+vlHNNs+dJtaSlnfVFVf7HYY9Znxe5bdwGwuRu8X0AEK78M2Vstp3QQjIuqHo6PqM=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SN4PR18MB4985.namprd18.prod.outlook.com (2603:10b6:806:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 09:26:10 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b%6]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 09:26:10 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci queue
 mem multiplier
Thread-Topic: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci queue
 mem multiplier
Thread-Index: AQHaZhjZPR1R5dL/kEuntGX42qDt8bEXcWQAgAfbrOCAAAwXAIAAKf2g
Date: Wed, 28 Feb 2024 09:26:10 +0000
Message-ID: <DS0PR18MB53683F5F209666C630FEEC99A0582@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240223052617.1867132-1-schalla@marvell.com>
 <20240223010723-mutt-send-email-mst@kernel.org>
 <DS0PR18MB53685A6DFD1E1184C2A60BF9A0582@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240228015016-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240228015016-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SN4PR18MB4985:EE_
x-ms-office365-filtering-correlation-id: 4b108ab7-3cf9-4753-6ee8-08dc383f4cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdf2Qc0qxsNnluPMsLHJQvTpUc9udqgjsDOAfJ67kntfB6EQNqLUMwEr0gDUsmvYPmvBUatL2OY/iPazP3frXt1O3hxQoEmsmZKXK0pYwxnBo8VdtMSISePmWBttOXk9+o1W8ALGW51HN96OTXic4tLYqNB5qC1jsiJ2KHZR+NEd8S9G5CX7gWwKLd+XWUrK+sdZHsLohfSAG7XzuCsLwrlmTW1zsufHu9bhqmW2QdiNwxqWU/HqRxb74ZyH9/K4q7kQDbEIC9I6R3ESzvvWiPLa28tNlr1cFUVkkfUXQeI6VJGuT6JyXg9HgiYYAb1tc4+TmxziNoF2jA3Kf6UNJU4QVnMY7FagfSgHdGf+xufxe8v8NMrx5PqHhCCGaTi6K9OqwFhiJuQeoMIlmk4+UNzNckIwnvoOC8FUHIug+qISox4gVzYiHlNvkAi/2A1afVwGGILFjV41Ltj4G/U8iF9hpSQcDzZoQNpXR8HLf4f5UM0/vA0NbQbDtcqSTJyDsiNgL/nEYVg6BlN75Vh+sgMoI3/ceis3JMpUey6CMvQUT1ik+No4w5tEksJP6xhOJKuzOAazMJW/m1unMvCUTqR3wRCuDrf37n3uNhzraaY2WDFzvxEv0qEfFpSH+a/z6f0/tAjRyMu9aPFqs0xaZ5VsV8MgG8htGe5zPT2f6SrOcB/9Iwn81gzVAFmCXM9KYFlrt5ZqQEdgojQ0JMmXNY/NdIX/FzMHRtJ5D6V9w+U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qXZ1EXjW0rzMrOGKws+1XLGaQb2ujvxuYMGecT84ot1Jh/WB7MQuQ/5xKARw?=
 =?us-ascii?Q?Qy2btmoPtv2DlDJDyODOg22Hb18ombtInKiyxlYQLUbdI6axk2jbVh/REOZ/?=
 =?us-ascii?Q?ukcZludfk3+V71hG9xeHvSY8kt7FG/O8XaCoVhbFvu1dJ60igR0FQ/v2S8hU?=
 =?us-ascii?Q?J5KFw+OhknP8rTZWkx+jojhzhca9abDpj3HmE2Yn1JjB+eOc+idA0DCIDbto?=
 =?us-ascii?Q?GxRJEaY9oTZq6MxtBWc1HvWa0ewqK8s7y8bbzqCl614pig7REn6QkozK72XN?=
 =?us-ascii?Q?5EgKay0K5Vhfe5y+rntTH6X4NZSC0sSHf7dNSll+p4cXYCE23bDJih4p21Je?=
 =?us-ascii?Q?n4g2r9bBv23okTqKufwBUuSwxDtRlU4Tp0DoSac/ywH8iGFARPRe4I98w72m?=
 =?us-ascii?Q?C/ODmD5QfZ6Ui/6yxw3XcxCufQW2jNAJhj1bqItv/AOMbfQciM9DgK/4j/1c?=
 =?us-ascii?Q?EJBhjcSU5XU4DCBFtJQj92s04yKSw1dUj2/V9gnPL+ZKriqtKQbLJoyeyQZg?=
 =?us-ascii?Q?fVRmOksQM4JzY8AhNZ4BK63xa218E2jSQ33QfnukOeoD7jTp6AriCdBBXLIT?=
 =?us-ascii?Q?F4NbXQvOk3NCjqGLUWuOMk3ZE1pIX2XFSJGVEqcK1jSXXUZJn9PY12RsV7MU?=
 =?us-ascii?Q?A7injVnZfz0fwo4NGLdmbHuG/RC4OegjCSRZbSc4vcK3HhvxMnGQDur50JcY?=
 =?us-ascii?Q?ydOzSGGqMdu8bAzaMJ7If4+4t2zNXWO2Qx0CqkbEWLg8M9foOChp34cXh8Na?=
 =?us-ascii?Q?+aFDOcLWV24LS5FGzVyFc01wcWhojYuZpymG7Cu0/9/Ce++99sNmAWxlz1o3?=
 =?us-ascii?Q?GhjGSIMXubakkv98Pg2y9ftKdxMbqqxIAudx3u0Y85p21yZOP+ppZncDPWQ6?=
 =?us-ascii?Q?CGyJt9mbyBbzRTZ8qXvP+/nXcewQTyXGKN+akms6rsb64WZwKBtNIHdKqYOY?=
 =?us-ascii?Q?goafFDhC5UZbnqeCnXTXbZAczkbgIpGblmCacWJJIGfKgQ24D6s7riENT6PE?=
 =?us-ascii?Q?/TP/6Z/Dvc5PffJYQgt35+HPuNGmTsnpyUf9usBKQSqOjNQldqRZ8Bj7TDm5?=
 =?us-ascii?Q?WRg4hgC8BQNYV5opGhlYqdT/m41JzjIcYcJXQUUHA2CEc+2cfU8cpaf4JYYV?=
 =?us-ascii?Q?MQtHmiACDwfcx9tUp9sz22Ky93dIhTT3k/ulL2k5dapAHHTtJSUz/Kq9gff0?=
 =?us-ascii?Q?PM5+qKvz7uQUoag2jgUA3z5JAWWiwWvSMnr4qcwTyaZUhob/btLpq0Pw0+VJ?=
 =?us-ascii?Q?Yn+aDg4Ub7VWrz9m9TPtpLNg9HkQg8PzMinN1wF0Lef2aS5OmrlUGgfnP5us?=
 =?us-ascii?Q?sIM+s9QPDtZh5VTqfyjvthG1KPSSA2kfuLM2stkXT412cglsFhO342bAp2xH?=
 =?us-ascii?Q?u7Eu7i342UTl8Jc47TSDzf/D0JcNQh98Ui8oyHliyMGr7OCvJadyU4+MfePc?=
 =?us-ascii?Q?htG3LBrYt981kltDlLrek5InE13H/tNNbJzoHFhxZ7Wt02qfAz7b7rjpheM0?=
 =?us-ascii?Q?MJip3duA6/TIl9uODT7tYAYiaeRkNUcvRYLcM4tZ1rfmIR9sSQiowaTzIwy7?=
 =?us-ascii?Q?hFisWsx5RRV8EdPBqKhMWDGD3gY1aLghDJ+Oprdx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b108ab7-3cf9-4753-6ee8-08dc383f4cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 09:26:10.2047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTubdKIqdYHEe9ttSpTn9RY5dgNM0FHKjs5cx/FSyuWKIRJOs+cCWwj8PZUjNMTeYEvvTDBLLGkNPfRqrxMNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4985
X-Proofpoint-ORIG-GUID: z4XjKouYfI5qo02hEZHC82PgBD2KtzX5
X-Proofpoint-GUID: z4XjKouYfI5qo02hEZHC82PgBD2KtzX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.156.173; envelope-from=schalla@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Subject: Re: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci qu=
eue mem
> multiplier
>=20
> On Wed, Feb 28, 2024 at 06:13:03AM +0000, Srujana Challa wrote:
> > > Subject: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci
> > > queue mem multiplier
> > >
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > -- On Fri, Feb 23, 2024 at 10:56:17AM +0530, Srujana Challa wrote:
> > > > Currently, virtio_pci_queue_mem_mult function always returns 4K
> > > > when VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't work for
> > > > vhost vdpa when host has page size other than 4K.
> > > > This patch introduces a new property(host-page-per-vq) for vdpa
> > > > use case to fix the same.
> > > >
> > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > >
> > > Looks good. I'd like to fail realize if both
> > >    (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) and
> > >    (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ) so users do not
> > > start depending on this combination.
> > Could you confirm if we can add assertion for this case in
> virtio_pci_mem_mult() function?
>=20
> No, reporting an error would be better since it's user-triggerable - it i=
s not nice
> to report user errors through assertions, assertions are for conditions t=
hat can
> not be reached.
Yes, but returning error from virtio_pci_queue_mem_mult() would need change=
s
In multiple places right?

>=20
>=20
> > >
> > >
> > >
> > > > ---
> > > > v2->v3:
> > > > - Modified property name, page-per-vdpa-vq to host-page-per-vq.
> > > >
> > > > v1->v2:
> > > > - Introduced a new property to get virtqueue mem multiplier for
> > > >   vdpa use case.
> > > >
> > > >  hw/virtio/virtio-pci.c         | 10 ++++++++--
> > > >  include/hw/virtio/virtio-pci.h |  5 +++++
> > > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> > > > 1a7039fb0c..f29e60830b 100644
> > > > --- a/hw/virtio/virtio-pci.c
> > > > +++ b/hw/virtio/virtio-pci.c
> > > > @@ -320,8 +320,12 @@ static bool
> > > > virtio_pci_ioeventfd_enabled(DeviceState *d)
> > > >
> > > >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy
> > > > *proxy)  {
> > > > -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > > > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > > > +    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
> > > > +        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
> > > > +    else if (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
> > > > +        return qemu_real_host_page_size();
> > > > +    else
> > > > +        return 4;
> > > >  }
> > > >
> > > >  static int virtio_pci_ioeventfd_assign(DeviceState *d,
> > > > EventNotifier *notifier, @@ -2301,6 +2305,8 @@ static Property
> > > > virtio_pci_properties[] =3D
> > > {
> > > >                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> > > >      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > > >                      VIRTIO_PCI_FLAG_AER_BIT, false),
> > > > +    DEFINE_PROP_BIT("host-page-per-vq", VirtIOPCIProxy, flags,
> > > > +                    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT, false),
> > > >      DEFINE_PROP_END_OF_LIST(),
> > > >  };
> > > >
> > > > diff --git a/include/hw/virtio/virtio-pci.h
> > > > b/include/hw/virtio/virtio-pci.h index 59d88018c1..81b6de4291
> > > > 100644
> > > > --- a/include/hw/virtio/virtio-pci.h
> > > > +++ b/include/hw/virtio/virtio-pci.h
> > > > @@ -43,6 +43,7 @@ enum {
> > > >      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> > > >      VIRTIO_PCI_FLAG_AER_BIT,
> > > >      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> > > > +    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT,
> > > >  };
> > > >
> > > >  /* Need to activate work-arounds for buggy guests at vmstate
> > > > load. */ @@ -89,6 +90,10 @@ enum {  #define
> > > VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
> > > >    (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
> > > >
> > > > +/* page per vdpa vq flag to be used for vhost vdpa backends */
> > > > +#define VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ \
> > > > +    (1 << VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT)
> > > > +
> > > >  typedef struct {
> > > >      MSIMessage msg;
> > > >      int virq;
> > > > --
> > > > 2.25.1


