Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2D1C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrJE-0004x1-Iz; Tue, 13 Feb 2024 06:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rZrJE-0004wm-0B
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:50:44 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rZrJB-00075c-Sh
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:50:43 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41DAHJFj023388; Tue, 13 Feb 2024 03:50:38 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w67cpg658-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 03:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeARf1Qk8ZS7lvr4sFYeWrJIGrltJ7B+4IU2gWG5xNAmztXVsEm6QPfRg9ZjhqdLRneFsaqq2DQN9HIkyau/emS4TazVXVn7lx1fKAdDRwsk/AsR/naxkqQzHnoBVLCGZmnqR69OJrQvNRh844LDi3O6POSi+QxxeZYZMbGBlYMULJIo6SsCL2kB52CFJFzUPKCz/cLm7+0QQ5ZjRgsBsvEnjxxj69PMouCS+JIaSCykb+IYPp9LPwFDNCHWN6BE2O/IADVOvsSUJec3Jjh+dznXF2xAfrB7ASBkOWTjAWptjNt8uI8l27pob8vuULfPr74eaexBh4yDCPd1/x7C4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkqk8UVtwSuxWmbRaPDF3fVkJt92pfIEi9Mp09OMGCs=;
 b=NWTchXpXRm/z/90pUERAo8BurbXGCL/VVgBHUEw59V83fRxjort+J4Du8o7ZLqwtYyNWd0LyfrRwwQ/qgJd0pblKPjtPIkBu6ui1SIklAq5zQMJmLo7kETRu/1vw0JtyNge+3nn/n//XGeP6cSGsRdbwXQsGz8s9bMX6ia4KyEq+R9Sx5DFeqMHASWE41fxDgmV7jKJbSE6aSd43BB6lveL+dEBwipLu9ic//eE2VwzhkLF0bvNbkyTtzY4x28EwCTVIecyrC//UARiimUxwOHyWSbDP+yOgfKSwAsN1xBr5SkT3sdRhLene15Q/lzqY7iBYfAiqEsxWUmlvQMF+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkqk8UVtwSuxWmbRaPDF3fVkJt92pfIEi9Mp09OMGCs=;
 b=mIvrGRUfzNDfZaKtCn0LhaIpozuTaQGseCviNSqbHjDcUu7KhT8nk+D0QkvalKMdTzvya55L5mxjTyQIJaXe87ccksse3cgDE+/LQXEB2nFiW7vGDqw1Z4uav4f1yRuF5jKVfisqx7qGLIq/7MkfUyRoMM5I/mFKwAR0ktTvQZo=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SN7PR18MB3885.namprd18.prod.outlook.com (2603:10b6:806:10d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 11:50:35 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::aa61:cd94:ca26:14af]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::aa61:cd94:ca26:14af%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 11:50:34 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Topic: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Index: AQHaXYh0jRmGyuikgEmPDkiM/Dgp47EIGPYAgAAIAQA=
Date: Tue, 13 Feb 2024 11:50:34 +0000
Message-ID: <DS0PR18MB5368A9931C4B4E8E8E866066A04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240212075233.1507612-1-schalla@marvell.com>
 <20240213054513-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240213054513-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SN7PR18MB3885:EE_
x-ms-office365-filtering-correlation-id: 46b35429-c4e9-4969-ac94-08dc2c89fd1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7b6QtaB9On3/9ZscGLNm9THDQXHKrHYYfCLcMlYwrL+Ba3Sn0yR9ANNcgZa767rm4vT63H3kZ6roe7RYgA+A5dNIenjV4C+zk+5qrLABDEam4iaeWFiN4VmpzbO7o2d97wVnkjeSEGofM5X2LJSS5ZfKJ6TN5VQ8RQre3zHNF1ADXO2HdDpWZ+MJ3mb+dUE5JEzBixrgT+PnMNfj9joS6M7uhxBo9UnLeHfGfBUiWAicD6aEK7kq+MmGMCE7jAdwYfwXFXUXBxvpHJks8A7GBqCfG0gkemdEjsyHoh4pyJjtQB2ZTqIDyEQvwm0b/6AgpX/E8LqOvMYkqA87q+dLxdCnaH66yNzblr+AO1655+NWCydR4z0TPTHlZX/tJDXiV0JIF3SiE0He7rSIDL03ajSwnzyRkMyvRkJWKYBSH0QxSNaKHIIQOCI/pVPP8l2bkT5dZoDDyoDYFIFad2dkL6cZBSm6zWODYCER0+slAgnmFoQhEH/gjH9yFEAin/YGhx6XyqHFzZqssse9+gXkD9RqL1EshyIyCE1jjMahqZRi69Sw+KgjX09ANqDjnb9o9e9h0QpUCjbyRDdb/RzoWLJcq5qPqPEHw1epdtBj1uLFcrLP6g2BI+xw+oqV5PEV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6916009)(4326008)(8936002)(66946007)(76116006)(5660300002)(52536014)(66476007)(66446008)(64756008)(66556008)(55016003)(8676002)(2906002)(86362001)(122000001)(33656002)(38070700009)(71200400001)(54906003)(26005)(83380400001)(41300700001)(107886003)(7696005)(9686003)(38100700002)(316002)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Kvsxpau32rwnU9YAB6zPyvmv/sIk1Veez/jLcQ2N92GvrgYi37kMFmN7+xx?=
 =?us-ascii?Q?O/NNFoxv5Q7EViJb8z2rwNmJAghGbojxlSxMatLwYLt0iuc4GCJjsE+4KHJy?=
 =?us-ascii?Q?F82U8dwmGvNaWTAriVHLXCv3H6o6gpFe0qi+Un08G1SyrxrKEx3bkakLCbkH?=
 =?us-ascii?Q?9YMf1IPILheG4XbIlGmKcY0dq0cbFh+qL4bEgp0FWEdmwbsTenNLg9dXV7XF?=
 =?us-ascii?Q?zTKu5qe+qb7TcTyWhujiRMFY60csI6SmkYtSVOrP0UUjyOHp0BF9i5mYrAxK?=
 =?us-ascii?Q?KbvrEqJEqpGdBSnLbt6BkjFEPudRAu2+lxMqzsIkGj+311H/+tWE44NJyV3l?=
 =?us-ascii?Q?FipL+f5w4tWUc2jUid5OefH2/EXdA9V/HozVYqRcQuRQ6YpU85JmIT7XZoVa?=
 =?us-ascii?Q?klyxLXgMgtzVC7rW4rSvWQld/dRV8ipW7R8Y9HGPjQn/ZGBnTsftgt3nav8L?=
 =?us-ascii?Q?8mlBac+BpU1ajC9Pl1HQBqLqlIrs1S5DSSr1Qd2sIYVy6dMm6gboMEdXAa0z?=
 =?us-ascii?Q?T/xAsz8lO+qF63O0n6cL3GiaX/hj7GDIk9oF8rGwWwxwP6AzpgKhIk5UvkF+?=
 =?us-ascii?Q?NTBHDnFEK9Wgkgb2Jtj1DmhZUO8KGN6yfzcM3TkOdLlmUKIY8R+LlDCKBCTs?=
 =?us-ascii?Q?OHSVHipjXv7z6vGITBDdnfuxpKjrdFcyY7j0kzCD3+esSUkEGmW/v/+nKmVy?=
 =?us-ascii?Q?PntZCRNeV0VpGNCVb6iOQ+yNVxA7qCG2j4Ifc99GN3lhA3imjCRGqlJsGDBz?=
 =?us-ascii?Q?MEmveX0Jnp83a8hy+36ckCd181gr/04XsVgaeIsWq66iHzyNWxuumAPfpo5h?=
 =?us-ascii?Q?krzSRzhgz+htN9yAzXKxZHcUbMYg8g6mPWP2Y3pAXlRfrLUqo3AnnfSZa0Jp?=
 =?us-ascii?Q?ZYy5WXzXTSiV/1S+4cxQM2SjEt2dy8Kyps3VdkBnoQwiJ9Lr53r6BM6UR3Nw?=
 =?us-ascii?Q?u/0o0FTM+D8vbJLS6ypbg2hwoxXD+uxqONtSyOxCtxziSJYwtyimv3vC0P4l?=
 =?us-ascii?Q?BG+QbIh7lXYqhXGfflLLsD5lhPAkxxeFonGGOUiTILYbyQ+LVukRlyCMSy0P?=
 =?us-ascii?Q?8tPO1dQFH9O8xFvaiiv2UMFbVEN+reiFUsGnO92XHF4sxE4HasdHAS55Kkef?=
 =?us-ascii?Q?Rass54sJ5V7/hrfMz+gf9YxRc46KNj3Kscdx7bMpoK606SfUi4Gol4ivViCo?=
 =?us-ascii?Q?kN6PonALleFGby37ZakQd7NeKMsaaDpByrc9IqhZP57Km9uVltfCjeSstR5C?=
 =?us-ascii?Q?kdWq8FP0SfvaAQp8G3DF1g4z/eksvs0UvfaKslj63//SjC0BonW5Anpy0gQK?=
 =?us-ascii?Q?1EMe9B7mM4tGDFT3gO4bZCLZFmgUlpZIJS24QV2U+H1LmrsTHcraHuNVFdPL?=
 =?us-ascii?Q?Edd1MLG+TYIefFwTQgug3PsBxLNSwgcgMJ3bavGlbmU13XE2C26RDfvII+Vs?=
 =?us-ascii?Q?8TCwb4w5KFymSu8SUwZ8FDKXm5ZyxIhIULq7ZKpBMc7k+X9cXurL/LZe3sIi?=
 =?us-ascii?Q?we6n2EwGUfNyjd6l5ngQHd5wo90bUE7JvvYm2w7k+c3cDO0qMi0zrIFwvChf?=
 =?us-ascii?Q?3Vn+SHZQh4o8Mx+QKvo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b35429-c4e9-4969-ac94-08dc2c89fd1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 11:50:34.7922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyeTgnwG1+++0RTqTXO36ReK18NNbp8iuTS7bLgApaoNjD8PquKtxr2XbqA8Qw2ABC/aTxf6uhYpVPv2SYeqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3885
X-Proofpoint-GUID: PN0iT8SFwl_65nGjajybfTpS-PDi0fWc
X-Proofpoint-ORIG-GUID: PN0iT8SFwl_65nGjajybfTpS-PDi0fWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
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

> Subject: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
> multiplier
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, Feb 12, 2024 at 01:22:33PM +0530, Srujana Challa wrote:
> > Currently, virtio_pci_queue_mem_mult function returns 4K when
> > VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this is not correct when host
> > has page size as 64K.
> > This patch fixes the same.
> >
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
>=20
> You can't tweak guest visible values like this without compat machinery. =
It's
> also going to consume a ton more phys memory - can this break any configs=
?
> Why is this a problem? Just with vdpa?

We are observing the issue with vdpa when host has page size of 64K. We hav=
en't
verified any other backends. I think, any backend that uses below API would=
 fail
if host has page size other than 4K right?
And also as per VIRTIO_PCI_FLAG_PAGE_PER_VQ, it should be equal to
page_size right?

static int virtio_pci_set_host_notifier_mr(DeviceState *d, int n,
                                           MemoryRegion *mr, bool assign)
{
    VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
    int offset;

    if (n >=3D VIRTIO_QUEUE_MAX || !virtio_pci_modern(proxy) ||
        virtio_pci_queue_mem_mult(proxy) !=3D memory_region_size(mr)) {
        return -1;
    }

>=20
> > ---
> >  hw/virtio/virtio-pci.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> > e433879542..028df99991 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -316,12 +316,10 @@ static bool
> virtio_pci_ioeventfd_enabled(DeviceState *d)
> >      return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) !=3D 0;  }
> >
> > -#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
> > -
> >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy
> > *proxy)  {
> >      return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > +        qemu_real_host_page_size()  : 4;
> >  }
> >
> >  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier
> > *notifier,
> > --
> > 2.25.1


