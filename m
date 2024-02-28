Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F21C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 06:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfDBu-0002rh-MD; Wed, 28 Feb 2024 01:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rfDBp-0002rG-Mf
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:13:13 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rfDBn-00062D-A8
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 01:13:12 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41RNhhmv015505; Tue, 27 Feb 2024 22:13:05 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3whsnk91d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 22:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTKnK6EWC6shlYgL0Dd3Z3FW7wq0cWkY4M6ucKcr2cVjql4o9PdqeybaizmY5vmemNbcNlaiQUXZZtwAtBYW9K+2bZJzQVRk223MwxdGE+ndtwaUKHQ6G0aZIJoE01r8+o2tdw3U+mH/0zc4qUve4JdjfWhm/Elnyq+LgqZhBIp20ArZeqjIJuFxCAbe0xQ38FFcdRFKnsGln7WcQN9lUlZLBFLJUMgk/ilOrpsnwHHytDcYb4v/XV4wYEEFzGndQ3+NWiGL4rYsTUGRDKorFWIitQpXJbm9V7AspEOG6UA8JYQAqFccsLCl/+L49o4MbOtWasL5Fxl2SZ8WvNeRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeDsWIdLmT8Bh0qsyrQA5KEdiEYD7n+5uuA+fhPyOMk=;
 b=N5TWCWJNh5+hlOmYSIIhBbfuiZH3coub5TxWXUJJ9JqvSA6IR0uJuek2o5RaLqD3GG5arv9oxQszc1/upN9VxnkcPoV+A/S/t9UQs0g9QqlgikBInhwTYVvhgu+VTw3izkkS26EMtHuwQe+vA7DJ/4i9QBxApNW63amrRMix8rod0o608XJY+3umCrUvGPlBvI32aR/bycLOZFTgyyyWRXGcY016UQcEy1rJjh95gHjPGtHui8VRcXOkmFXkg622C1tJX34NHBYVo+iiu/vOTkEyGWzGEac6OWOupvmpHL4Ktla3Ap3u3MPzGgZPBhe0PowUqvQoiun4k5vNJDDVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeDsWIdLmT8Bh0qsyrQA5KEdiEYD7n+5uuA+fhPyOMk=;
 b=J06S/oh5V3fb6cbrAh+tN9t8ReIybNzY08+2+yJZzsohWLskVZKulPyO9R4kE5cs3SGLhCBvDnVZGTUcGBb1eTsFASVS2nnAEyiWFYqI+aHSSzWqb6rAFFHWrgIkapX5URNLY0s8rfKuVCeKwQ+c1hveGnZFjdjC4go8mn98rV0=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SA1PR18MB5719.namprd18.prod.outlook.com (2603:10b6:806:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 06:13:03 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b%6]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 06:13:03 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci queue
 mem multiplier
Thread-Topic: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci queue
 mem multiplier
Thread-Index: AQHaZhjZPR1R5dL/kEuntGX42qDt8bEXcWQAgAfbrOA=
Date: Wed, 28 Feb 2024 06:13:03 +0000
Message-ID: <DS0PR18MB53685A6DFD1E1184C2A60BF9A0582@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240223052617.1867132-1-schalla@marvell.com>
 <20240223010723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240223010723-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SA1PR18MB5719:EE_
x-ms-office365-filtering-correlation-id: bd4816c8-e345-45b0-9e12-08dc3824528b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQwlYiww8kuhNXT5FxRo5IzI82QFgtDrGR5WcjZsUbJvdJIq+iTQMsmuv3PGJPgAYkT5abwCVehUwD9pnZnB0d09qgPxC0f+Gi7grufkCZJ81bbQpWsNGM0vyOJxkDDnLn/qcb9GpShzt6JHL8zSYB26zDgTw+R9k45cpH1gKQ0SQpJa8G4Gt6GUvzwOryahLLQG5gxXFAObApw+Rl2vNiVqP+j4mPRPqUqsCGeaoJJYki1xaFGuPAtOFZjsuIgmXGE82WN7dmAYSTa9Z7oraqkQGejOFiixD3RK7PH+wjZ7x7SXDGTRNKtfDUoWn/3ugLWuszH4A7Qz5+8CM38nEBaGvOzOYixulSbi7pbNL6TjgksJLUc7mz0/Oz0oF9bnkr3LoHqxt8ZXupKnH+TNR4aIphnCXZFqbB+1fzELH4mnvU6jvO3er9oRf59vQRGse5GRs7ewj4kENN2OI7XFWaQn7X8G7vZoeir23L5MZXm+PFjQiXdm/OqBief9re8T3UyIIAQGwXwgJcqRVleWXpqxeqnxCaiGA4dAl3wNF42UkZkcRrMXB5/a1x5U43VVtJa0B7QUF6kByEusyJGhu1euMx95xgtOuvuW5sNoZqY/OTNqf6cD6T36jFokOR7T+UhkIJIp+zLUil8sIgvRHZ5Dxn/w6JAeXI9lYrS7Xj++yYHBWaA9orgtoSHFL0xwLb+Dyci2BRiH8iZdR8oWqv9Ir6mukiMsFii45QpNlhA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RV6AyAsG14sMRKJe3UvppelUYawud+bRWQSuciuCWD9rn7sgnaTgxKJ9O2B6?=
 =?us-ascii?Q?RtphtLbz8tDvgOwxMBZZVT/c0+8vh/ahrpZFCab31fCtjLLCq9uAYh7r2UTt?=
 =?us-ascii?Q?VenmLUaoLZAOyPDZb6F98JL8mm4jGCN8bmUiGY8U368Zkl+4u7CdWzcqJYwc?=
 =?us-ascii?Q?UPc4LXsgpKMQMZtDTq/siv0jGzOagKtebKGzIi9UjxVBWmGNCn39r0Vzm9jY?=
 =?us-ascii?Q?9ktUOUw5JxzjBTBi6xoTWE8jH/vg/7EkrC76uP99dQAQWesIBeG65cIujYTF?=
 =?us-ascii?Q?EM6CIGeU0du5pLBYF7vzUiQBHtyWL5ozVxQCxI2S4MJ+3M50lZZZ6no+22yq?=
 =?us-ascii?Q?ZOGAQ4oADOcAe+3v6pz+gaKExa9WHKh3gsTdT49PnEpYX6nfteWo1AzhSlip?=
 =?us-ascii?Q?BdMLZ4NwQTdXpzAqAb9cbjW5pE6cf9nxDJwOfLPm50VrL4Z1HI/tAbENaYYN?=
 =?us-ascii?Q?XLjZzkuz3mypyG6hHwghkVGZZsCF7IwOGP7esEfhjYQn9on+MVWzGV+f1EUm?=
 =?us-ascii?Q?jDxgehalg2xPambTif+/A3/sIXzdvDEmQjfouL35Ku2gabVeCT3Ll+jbrIsV?=
 =?us-ascii?Q?BnHEyqrLq6b2OjI7LgPxLLSVK298dpFHb2MZ8MGich8rr6WyXznWXgQNVO4x?=
 =?us-ascii?Q?3iJvf3Q6FXXfh/L+D+Oj9rBLodeWhY/X51AL/tV0afA8mm01HGpjoy4EnkYW?=
 =?us-ascii?Q?MqVzY0SZ7b+kBlaF+wjwYJ8IdEU8o8uK6w0j3y2zFWVYJF8Zkd6N/0hEdwOg?=
 =?us-ascii?Q?DtGs0Si+aL49EoQfrs8kKa4Sk3Y7fl/frGI0d1Et1xwP27pdX9U5XL57MDY5?=
 =?us-ascii?Q?ixGlJmNMfakwag5gcNq/U+e1hHAL8YcLZgQMTB0Odb6E4hZgGL7oCgiNnXt+?=
 =?us-ascii?Q?WW/MaCuCBrTyKMOc9Lh6jsndFCju+quqXRLey+3rNvaCz9qwa7is+fCrTVWK?=
 =?us-ascii?Q?Dzw8j01M2la80NVfwiRvX9HejjpYLYnEY748fKmFZwmWMIstgh9iwKWhyzcR?=
 =?us-ascii?Q?J47T4+VF6Vo2OsE3hekKRKZw64WuyC+mO6QVzwDrPNNRPWqohy7yxkUA8IM9?=
 =?us-ascii?Q?iLcnR4li4pmlBB/y+vIzUMGhFdTqONWFadcTEXFCE4VsIYk04kJJQ/V4x582?=
 =?us-ascii?Q?mqLh3+3mYFh/gNoOov/Bg9cBzNnfkcXdwYE/LWsA2FsrYyXR5lYC4BQ8TdPy?=
 =?us-ascii?Q?+eaEivpI5/3nnrDVSlWd7xri4uvPyf8PDZQRs81E0mHbOhYvz0m0eKT3XFcT?=
 =?us-ascii?Q?yGQcSuJsanynPtOI6CBTqjhZ1RXVlE6c4VfydnMxOaLaFRhSonXCOz2Mig8L?=
 =?us-ascii?Q?ZTV280wzO49rO/d8WELM5RMocBCJ20caLhSFLB4AOskYbldrA6IvItrkwKfc?=
 =?us-ascii?Q?yswINavRzkfvMTvpmeEc9sA6x43v3Nvz8WMwkkw7L6Pza1zchqrrDWEmAsZq?=
 =?us-ascii?Q?2nTpqaSGlLuJrXkxZSktAT64a/8R51l+rmEz5m3M+mvbxOYcf2pu0BJlchHt?=
 =?us-ascii?Q?3JA/LB8XvBaObMHgrMt4DtKNrxPGACxsBhOOvYPz5oB7bCgZCtMSJWkCKzQW?=
 =?us-ascii?Q?tWk6h5+Z93S5U//fMIe0CdKAwiKp55HPSGgT9263?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4816c8-e345-45b0-9e12-08dc3824528b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 06:13:03.4466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIn8GzDu5aGlBwRgsRFD9/knhrsAMySW4jOR2qI78uQqJO4mtVAPzWIGZeSdv1dY27pLBCb8T8CJJV/gK+CLFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5719
X-Proofpoint-GUID: 7aFWPoXOciBAzjlBFauFmrTLaIf1GLRp
X-Proofpoint-ORIG-GUID: 7aFWPoXOciBAzjlBFauFmrTLaIf1GLRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.148.174; envelope-from=schalla@marvell.com;
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

> Subject: [EXT] Re: [PATCH v3] virtio-pci: correctly set virtio pci queue =
mem
> multiplier
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, Feb 23, 2024 at 10:56:17AM +0530, Srujana Challa wrote:
> > Currently, virtio_pci_queue_mem_mult function always returns 4K when
> > VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't work for vhost vdpa
> > when host has page size other than 4K.
> > This patch introduces a new property(host-page-per-vq) for vdpa use
> > case to fix the same.
> >
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
>=20
> Looks good. I'd like to fail realize if both
>    (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) and
>    (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ) so users do not
> start depending on this combination.
Could you confirm if we can add assertion for this case in virtio_pci_mem_m=
ult() function?

>=20
>=20
>=20
> > ---
> > v2->v3:
> > - Modified property name, page-per-vdpa-vq to host-page-per-vq.
> >
> > v1->v2:
> > - Introduced a new property to get virtqueue mem multiplier for
> >   vdpa use case.
> >
> >  hw/virtio/virtio-pci.c         | 10 ++++++++--
> >  include/hw/virtio/virtio-pci.h |  5 +++++
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> > 1a7039fb0c..f29e60830b 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -320,8 +320,12 @@ static bool
> > virtio_pci_ioeventfd_enabled(DeviceState *d)
> >
> >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy
> > *proxy)  {
> > -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > +    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
> > +        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
> > +    else if (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
> > +        return qemu_real_host_page_size();
> > +    else
> > +        return 4;
> >  }
> >
> >  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier
> > *notifier, @@ -2301,6 +2305,8 @@ static Property virtio_pci_properties[=
] =3D
> {
> >                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >                      VIRTIO_PCI_FLAG_AER_BIT, false),
> > +    DEFINE_PROP_BIT("host-page-per-vq", VirtIOPCIProxy, flags,
> > +                    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT, false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/virtio/virtio-pci.h
> > b/include/hw/virtio/virtio-pci.h index 59d88018c1..81b6de4291 100644
> > --- a/include/hw/virtio/virtio-pci.h
> > +++ b/include/hw/virtio/virtio-pci.h
> > @@ -43,6 +43,7 @@ enum {
> >      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> >      VIRTIO_PCI_FLAG_AER_BIT,
> >      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> > +    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT,
> >  };
> >
> >  /* Need to activate work-arounds for buggy guests at vmstate load. */
> > @@ -89,6 +90,10 @@ enum {  #define
> VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
> >    (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
> >
> > +/* page per vdpa vq flag to be used for vhost vdpa backends */
> > +#define VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ \
> > +    (1 << VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT)
> > +
> >  typedef struct {
> >      MSIMessage msg;
> >      int virq;
> > --
> > 2.25.1


