Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A68C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 18:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc8Ar-0002Ak-QC; Mon, 19 Feb 2024 13:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rc8Aq-0002AX-CN
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:15:28 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rc8Am-0004X0-Pi
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:15:28 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41J94NWX005432; Mon, 19 Feb 2024 10:15:22 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wc41n9gfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 10:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/SvPkFj/Dc6VTRJ38d95JTvWVxjdGR5vazkKlSedwrkKocJw4P1TyszFlx1SL3+S/qqC0typ0wigAC1qWfAvbM9yIMdO3xGPbR7yPPXHv7gilsSOcFptCr/bbWb75gq/3nPdo1wLr+JW0XJYxWk8eqMSksf4tEffzSboVxUxnodqzgrbTd/fsuhOyOs0jyraCp+pks/0XHV2vHP6xQl+nJAy3VYcIgF0uxoxrp0mvohvABwp03qCeUWt1wrjJJW6a8j3f/6QbJY82cB4xGnos71yesqSyxMAjX4/Pz7y1ZmGLgoV+goAGN3z77yWQKud7MUmVFGEabXkYNF5tmU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsWyAAi7j+UdX5tWonhoroj53aY0+7RMQbqOI2W+mNU=;
 b=OmgvVFuFyJuih6iMlSnBQ+CBZqLJy9atYYtXBgvVMU9Gvr5LrxL91tqasOcBKcGenlPhdolhZbBLlkPqWjSWZrdN3lBpKRcDFIEe3PPh5gejXH726ja/A/k23my52qsLEPfOVZlI9KIX1E30Sx+RYtw1jhOUq7uiZ9JFjsE+lXXsYwIA5JCP3MxrIvyssOMQM41cqYl35TthwfWTJQ/SJ7+DMWTecJYaKv+13nsoGVRhsippBj2QKVOrbV83GYv1aHqoJV8DsJmnk/Ooliy7OwjqGDT2E0RVnL1E/OhD1cd+F9+tNsy1S+fceHSMWvVC0C2SuM1tlhVgQ4noTg97Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsWyAAi7j+UdX5tWonhoroj53aY0+7RMQbqOI2W+mNU=;
 b=DfGsDGJwdXolHcKsKGks/qq58oE+bXwuExyiY/FQf70oAZjzSl3GVG9SCE/icdIeSSWURnyEdA45sKa1LdJPUtqY5Xm7PQeo7yNNxlIh80qSXdYyZVE9wFTIzopcgWum9a4++pTcbR57YKPhHMj0yCvPG6Bb64JwYiQ+EE8QQPA=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SA1PR18MB6105.namprd18.prod.outlook.com (2603:10b6:806:3e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 19 Feb
 2024 18:15:19 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b%6]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 18:15:19 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Topic: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Index: AQHaXYh0jRmGyuikgEmPDkiM/Dgp47EIGPYAgAAIAQCAAA1JAIAABSswgAA7DgCACYthIA==
Date: Mon, 19 Feb 2024 18:15:19 +0000
Message-ID: <DS0PR18MB5368D0442EEADCE115C09AE0A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240212075233.1507612-1-schalla@marvell.com>
 <20240213054513-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368A9931C4B4E8E8E866066A04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240213070100-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368152CEB40AAD449E71ECCA04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240213105249-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240213105249-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SA1PR18MB6105:EE_
x-ms-office365-filtering-correlation-id: e2fc9c40-9311-4338-23c4-08dc3176bb2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSZt39DWsn0dnwxfIci4QJrO3jSRnmNSgp1gp8i/PlHVsAiF0oOMxxe4/7CsQLPhfBSOKUwiiju3odleOrgjhZbJ/Lols2p9a5uR8sV2vrTcpfJyb6phW3Y8zD2COrq0CEDNLI1AYmYrTujggd2NnVmgSPLv+juG4P5Kh4+t8bT9ecdj/Idow3EtpE3MQERR36Hj4C8+aZzf9OZ02Ts1XmkMGTvaA3Mac0YLFe3GGtDicpdycki/c4MZXx8HC+vj0CwFdx9GoCj082ZJPjaaJgRHA7BqaQAWoLpM1EalWmAeeTnhD2+lYnIXHB+PIOBTG+7urQqkpumOUAvheOmKDJ3mmO3nA2/3lWGH7Z0pxvmNwdZKTSRiwDKj2BuBFlqLK0Jkho8A83m+sKcETLYnOhflylu5qHcH+oc7Yb5HYGKDUWIjmy7HRLQUhy/H2T07q3SpJnVdzyVJrjDX2R9F2q1v0mhF1iU4f0td2QnCfKDYPLNvrLwsjeDH9kf72lHcsh5gBD3OV+7rf8JkQ5bmXAZ2kHkFaIowspqQRI0HWDt8m0+1iEd31IGuWbWR76seoW55WkYBkqPk8alYjOIuzuBtKsDw7sjQPi55ZIXBdz2pf/p4qMqmGBhmjseedm2o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DhG6HcL6GLPmDbJqAfvbH21GpBLvDPWhfSZOhX5wVQsud5/CsNf0T5H++Wb4?=
 =?us-ascii?Q?z5eZYqZGkuiyqAy1KsnA1lZqMYxCl+yn3jGRRQ2yjpRXzfba1RsV+y7VTjWq?=
 =?us-ascii?Q?xW4V/LhCiaPW+Jyj0a7bHyLWxqX5CtSq38Jor+zSpzHv2nMZ8YW+08zqAz7C?=
 =?us-ascii?Q?Ge9Qrbp2aL0a1tjwnhqKVmUNQlhvzQNYLZF+DEhopOnFYanIZv8YdSZXQw3L?=
 =?us-ascii?Q?OuA53JUEGbRd4uHIpy9szLlRn4y811tOSMCdCjYCWsw7ezUEmilohFB3MmnL?=
 =?us-ascii?Q?duF1onm3Aiir62BY33WX05jhPHhxpY9sTga2WlBaRUTj1gj16zKU8Fp7Gn5p?=
 =?us-ascii?Q?/3RfItiqpS+6Bw/ECMVJRiiU29W7E1T/b6m2fdoux1lXW1G1HmQrsloXm1qA?=
 =?us-ascii?Q?jttBKF1eDF9qD5ArYYquSrWyIt0yoMMQ1l9DBo70vv6T5syuK7X2nI9wLYha?=
 =?us-ascii?Q?wA1RbnZuk7HaTmXYUdhjz/lgqDucogc5QgGZlxTPTQp3yubJdpHhQnctxjeZ?=
 =?us-ascii?Q?vwpKfKM5vYwuU+t7BXWbgT2FIfTSy28VDsE5+2IfTjyKUFFmjlS9NsopXMg2?=
 =?us-ascii?Q?bqd+RMEYYmYxvJbau0gRmAcmKF99GmcURaHvAhwdr3IDgMlf1emdhAPsB3Yg?=
 =?us-ascii?Q?CfEUL9Bp5xV/YhINExnixLg2NklrHDXTjc8mk0gJIFmq33K8QO621oEGpKt0?=
 =?us-ascii?Q?rKThzFTSQMwuMoRuJoW5gah7lrEjcCiXyegn2qvC7nuAb7TgjQ/iiLleZNmv?=
 =?us-ascii?Q?TphiDYRL8/Dy3H85cRlJnsaf4GtFkI+EAE5MWkFhYUIHhANluFElQyvLrpAd?=
 =?us-ascii?Q?Iz+h8l4vUyZ3B7M1RErpRsVGl7a8Sa6Hm4P8A3LrKXNZdCeiQ840y++AYY0A?=
 =?us-ascii?Q?W10Vm5rpdgTvb4lzZ8IJ4gnKpkV17tfvy0kk2HKKjcza37jva0uJo1cAwmT8?=
 =?us-ascii?Q?K0Kz1GlplFGtSZUB7X9wzq0v1pbQxyDjfpucwibe1bHkoDEOgMdO+vqoaL+x?=
 =?us-ascii?Q?p24lCGkyVXfFsuqL1Q6Aue7QvUz/XEo6wMw73a0T0nXuFw4bg+pDp2mdXb7I?=
 =?us-ascii?Q?P9VdQ9zvuOrDD4JzkbOvqiYGrYtn/fwvlVsCnqusWjlgfJwfanuP2ct03FU5?=
 =?us-ascii?Q?4jkhDDS8MdiPSonpcGx6sefTIzljHiklESbrpQW8oPN9v6Kmt12NPR1XVKLB?=
 =?us-ascii?Q?VELkbYFnOiwfPr8dSxm1BGpnQuDR8cOvNAkT3sGe+ncADFs4Z5BdlzakIL+F?=
 =?us-ascii?Q?QqzWoZi1/ao1dsXVVMuf5NSjePwT/uO3Rb8H1wIksg7FdLjaLLZdK+M7tDcq?=
 =?us-ascii?Q?Up8J9LIgo0sdRKxGQOsqai44Gk8F9dOf3A7Se+EtPnICh1+VxKRvDBxQU4aB?=
 =?us-ascii?Q?pDNM+RYRS9FaX+1OMvJinvmy+iTXqh+TfqQoArhdHLRvFPaN2NaodvEESUy7?=
 =?us-ascii?Q?hbTfm9uqVhuNCFR8kV9lohzlbXKUBjjfY+mUTXjMHTaWmIVjk0E/Gk4HGEvM?=
 =?us-ascii?Q?OeoFGEUsSY64rDOvj0SaXTGoJmFrRN+d598HyTil5Ikxv2oTbVWRcHzpPdCD?=
 =?us-ascii?Q?JvbHU5d2XsNS7waEUQOTrlpw+qPyJPYk29l5Ka1O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc9c40-9311-4338-23c4-08dc3176bb2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 18:15:19.5561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHgEe7wrrW/CCoDW+ROP6fxlhEahNr6bPBYpLP2mEunlmoBGOWTrCGWIwpRb/6xCYcJgCXX9vUUTCANjO10New==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6105
X-Proofpoint-GUID: Ns9qn5Dh9CpTCuIxJCO0m2kIY2LT8sQD
X-Proofpoint-ORIG-GUID: Ns9qn5Dh9CpTCuIxJCO0m2kIY2LT8sQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_15,2024-02-19_01,2023-05-22_02
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



> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 13, 2024 9:23 PM
> To: Srujana Challa <schalla@marvell.com>
> Cc: qemu-devel@nongnu.org; Vamsi Krishna Attunuru
> <vattunuru@marvell.com>; Jerin Jacob <jerinj@marvell.com>
> Subject: Re: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue=
 mem
> multiplier
>=20
> On Tue, Feb 13, 2024 at 12:37:36PM +0000, Srujana Challa wrote:
> > > Subject: Re: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci
> > > queue mem multiplier
> > >
> > > On Tue, Feb 13, 2024 at 11:50:34AM +0000, Srujana Challa wrote:
> > > > > Subject: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci
> > > > > queue mem multiplier
> > > > >
> > > > > External Email
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > ----
> > > > > -- On Mon, Feb 12, 2024 at 01:22:33PM +0530, Srujana Challa wrote=
:
> > > > > > Currently, virtio_pci_queue_mem_mult function returns 4K when
> > > > > > VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this is not correct
> > > > > > when host has page size as 64K.
> > > > > > This patch fixes the same.
> > > > > >
> > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > >
> > > > > You can't tweak guest visible values like this without compat
> > > > > machinery. It's also going to consume a ton more phys memory -
> > > > > can this
> > > break any configs?
> > > > > Why is this a problem? Just with vdpa?
> > > >
> > > > We are observing the issue with vdpa when host has page size of 64K=
.
> > > > We haven't verified any other backends. I think, any backend that
> > > > uses below API would fail if host has page size other than 4K right=
?
> > > > And also as per VIRTIO_PCI_FLAG_PAGE_PER_VQ, it should be equal to
> > > > page_size right?
> > > >
> > > > static int virtio_pci_set_host_notifier_mr(DeviceState *d, int n,
> > > >                                            MemoryRegion *mr, bool
> > > > assign) {
> > > >     VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
> > > >     int offset;
> > > >
> > > >     if (n >=3D VIRTIO_QUEUE_MAX || !virtio_pci_modern(proxy) ||
> > > >         virtio_pci_queue_mem_mult(proxy) !=3D memory_region_size(mr=
)) {
> > > >         return -1;
> > > >     }
> > >
> > > Yes but not everyone uses that right? Plain virtio in software with
> > > no tricks doesn't care?
> > Yes,  any other better ways to address this issue.?
>=20
> Add a property that vdpa can set?
I think, as per VIRTIO_PCI_FLAG_PAGE_PER_VQ flag, it should be equal to
host Page_size. May be for software use, we can introduce one more flag, th=
at
could be irrespective of host page_size?

>=20
>=20
> > >
> > >
> > > > >
> > > > > > ---
> > > > > >  hw/virtio/virtio-pci.c | 4 +---
> > > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > > index
> > > > > > e433879542..028df99991 100644
> > > > > > --- a/hw/virtio/virtio-pci.c
> > > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > > @@ -316,12 +316,10 @@ static bool
> > > > > virtio_pci_ioeventfd_enabled(DeviceState *d)
> > > > > >      return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) !=3D
> > > > > > 0; }
> > > > > >
> > > > > > -#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
> > > > > > -
> > > > > >  static inline int virtio_pci_queue_mem_mult(struct
> > > > > > VirtIOPCIProxy
> > > > > > *proxy)  {
> > > > > >      return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > > > > > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > > > > > +        qemu_real_host_page_size()  : 4;
> > > > > >  }
> > > > > >
> > > > > >  static int virtio_pci_ioeventfd_assign(DeviceState *d,
> > > > > > EventNotifier *notifier,
> > > > > > --
> > > > > > 2.25.1


