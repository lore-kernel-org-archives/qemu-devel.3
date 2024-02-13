Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F35AC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZs2i-0000gv-Ri; Tue, 13 Feb 2024 07:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rZs2i-0000gn-8b
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:37:44 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rZs2g-0000xw-BK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:37:44 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41DAnF3M022306; Tue, 13 Feb 2024 04:37:40 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w67cpg9ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 04:37:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNUDvfaGBGMJoXW1KVhoGXzOh7nphY5N3JfJU6Qy0C7s8b4qlsZHvA3eHKAm1bMcpjdfA+IvWYCX2OE/YDu6pV1qy5mqAzePojpvoITC3TAG15yVhJ4fvC1+IKH8d72KYldvsOtLMJ2BJCfIyxsBHLrTfU/nVuaRGobPEEri8nvkbV+LrKK9VFxIhgt81oK7AnMjXObrmhBssyCWYBfDSI/R0oTVQVrSbPh+UgTCbjzKnmA6imlTIK7kmdlEh+bp7NLrWk0IY6tou8PW+NvHE/qzPHz+k/w/boG5FuHQTJEDffps8GfmMG+og/TEpYySic2XvrZgSFQFyaVIcgdukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6ldC+IVvwl/91ysz5ssGdOaVNIQ48jW2aiHTva+m/A=;
 b=UKDYFJnvw//QAx1d5Q/jYbUrB91k3besYfLnkDIi+YPPeMDHR78sFU9oiln2fMaEioYMbxxV5lKUlkp20Fa7AHx+I0+bvvQiAE9y2hQqfJbOtq+HFNzgvAvMKYWko3GZDvUAjjHHzAa0+3rPa/dvXTFIfv/TU8U7wS8ye8DqGrjkpel5BrZZCuLf8vmqxCGTNTgN5Tfxc2ixh/CWpynkBodbKA5ab8RFMIRVbQgK6uwpWtqbQLXW/lICStSoY0xvje+xk7ZlxXluZYvC7rEWTTg5/kdYXnBky4QRQOU0J0i1Olt4xuxJ8VwpqxUDvmzXffZNbzYkZrl+oOU4WLd7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ldC+IVvwl/91ysz5ssGdOaVNIQ48jW2aiHTva+m/A=;
 b=RaJt6nDgThPNF5fx5xJxEQBO736fP6jJ+juV8BcxbK5wQKw1MdTeIy/PODdWtfVKKlR5S8rVgdbNQ2CPElkSuv8+kAc+fQ2sqDGrXRLGRRcka+rEwYZHmrmPfJegAjTePXdhM+IBvUS+icjmwD3FCh4xVqxudIuA4a0lIDfOh3s=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by DM6PR18MB3618.namprd18.prod.outlook.com (2603:10b6:5:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 12:37:37 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::aa61:cd94:ca26:14af]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::aa61:cd94:ca26:14af%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 12:37:37 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Topic: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Index: AQHaXYh0jRmGyuikgEmPDkiM/Dgp47EIGPYAgAAIAQCAAA1JAIAABSsw
Date: Tue, 13 Feb 2024 12:37:36 +0000
Message-ID: <DS0PR18MB5368152CEB40AAD449E71ECCA04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240212075233.1507612-1-schalla@marvell.com>
 <20240213054513-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368A9931C4B4E8E8E866066A04F2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240213070100-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240213070100-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|DM6PR18MB3618:EE_
x-ms-office365-filtering-correlation-id: b80115e4-a0d3-4055-ca8a-08dc2c908f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0kGudtDF8lA0KN5T7edfaFcQeDToti13StJVcdXf/76YPFJ2KA4qKRuo7ABINDKYEpvCBhnQVRRa+DE6Z8BILQq0c3Jfausw9+5xt2OgbmZb/9ivFRdbAayP9UjDgk8uoRdCd+MGn/08zFppBnN7G/O9VOyGNrRE3kQgjEIzm25qQgGo0zqCrPco8KSRX7ngKdUI3vKaaRxMsoeMP5dhZ7cBzYkmGtV0emZcZIh14HBq1Q/mxTGqfql32yBcPdBb4+yf9zmAzQCykRSFS62fyWQFcXGovfq/uFqo1qlqVaFGkZT920OgRAUWQ6Z4bfNU8tThLEsiZz0vpDbT9NSNfq7F/N+I3jVSPBsoED+yPrBnqxgCLYsYCoOo+HUgUi3ti7BNyMCnKSzi5u7R2NNQQ40R76EpG66hr1TSsLn7Y0ReawAb3rtynpWGSbmiudfST2rHZ9kEK0gDiHv5nCNUzYX39bC8fPtgnBBgBw9BzobcuHdUww9VI25AegS94awDSC/ukrDAlWN4cSTXaxQeqDqyMw+qWDw0+I2iCLv9nh/TGJsj4aHjNgLix+ujMh7+2I/yFhkohY4WK4vFCXF5LwHypmjtjngZa8BvMD371ZtQU6oae+qRdjQ5g0HHPg6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39850400004)(366004)(346002)(396003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(122000001)(33656002)(86362001)(54906003)(52536014)(71200400001)(316002)(9686003)(2906002)(7696005)(5660300002)(6506007)(478600001)(8676002)(6916009)(8936002)(4326008)(66476007)(76116006)(66446008)(66946007)(66556008)(107886003)(64756008)(41300700001)(83380400001)(26005)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ntvHDaENmymf85AdKRQif3ai82IwnVmKDoi9IbNVlE2pxAMebURtmMqNQEzD?=
 =?us-ascii?Q?yrUe63zoEDRnS5C4Q/BcCXMx9Ap52sJypfEAPnf9uMT4wieKYF5jujPfTl4k?=
 =?us-ascii?Q?V4m1H80RWAdNg2XE/7MU37MXaeU0c91KzQn3D9erRxQXOSPS1skNJoYrCChF?=
 =?us-ascii?Q?HjD1Mmn4g61miAUpwZbkUIpCKJsh1R8XRCOuACVjScYQbMEuq7AIk28N5UFc?=
 =?us-ascii?Q?dxQaqehmqxYUDGWtq/kyV9k7vzM+PhhX5fQPrYt8+5n/6ErYehPJ5pRbamXX?=
 =?us-ascii?Q?YRHFeuS1iKgYxzCCjKBq5E/iAaND8HfZ+EXRqLRtQwrJSXP6ola1GDlHz0EU?=
 =?us-ascii?Q?saops+GfNiumNStr6OvbQ8U99tcl/NhOU1Mc+KF97ZgmeX2ktE+K6pO55hxo?=
 =?us-ascii?Q?YSA5w+JnhIZZlnThRwq0MAE7cpDU/WZiuqqvKtasY3M2QLc2pJ73GAB9Foh6?=
 =?us-ascii?Q?zZBOJR3J6GG8ht/JbmUAibMHFxI9ht78VLc43sScgrp6nScTDpQ1AAB5bAt5?=
 =?us-ascii?Q?qklV8Kh82NljtxbgQeJvQQUtXLyIT1dAcUkj3bbAqSADHpRQ7bLIHfr289xt?=
 =?us-ascii?Q?v4WpnTEvugoGmxEHbBZDlPlUIhcjv0ZMmscniU9dlElCoCHDO8c3eZyN2saS?=
 =?us-ascii?Q?WLs8HrRBeseCtBlbvsqtiqMmFu7cejpxHfGgUkXF9UnXCAYuZbDkRP6Hgh8h?=
 =?us-ascii?Q?0hSFJ/Ag92rVVQtcKYcmErzIy4wEBirWfFGVNH5YbcSk9mXdEQprzVQBjuEn?=
 =?us-ascii?Q?XXr/7wT/jATt0ZUSfXOCvZL+luvufo6i/N4xZQJC7aPxOEmLImtlYG4XOiBq?=
 =?us-ascii?Q?bWohvGfqr94tV1CBIhoV7TqB/FYDnzkterRxIHn4YltYbbiL4l5jgwAEX6qJ?=
 =?us-ascii?Q?8zvO2BnIjQak5V6fPli4MY9PNoYysfysSbFUFeB1YzVHA+dCMoc+ohFO02a+?=
 =?us-ascii?Q?df/qLrK/So3SJYx8bVWf5RaB+3zo5zTvXN/L2PQVjGTNei2VmPI9dg+r3tC4?=
 =?us-ascii?Q?cbTZ0Tvsiy1nPLmox5DqwUMdEvaAW8FgIhWXHIDN+MumpjGWgQ2ezvE/KO5y?=
 =?us-ascii?Q?gNK4yV/wjpjoBfiwZWom2ITIqojgh0KJVts2LNFBq3nydy28B/ssRyG5VxTL?=
 =?us-ascii?Q?E2h+OSHWm33WU+GmyoxpZUDpgYltL0c/MVJvQI+fRngoLEzM6XFIKWWtxIcQ?=
 =?us-ascii?Q?5/jo3minrqzkNYaElsRafptTbY5NzLHAjz6ujxlJoIOdukPhuekeC6xxCrJq?=
 =?us-ascii?Q?Qt3ip0wuJtRTjZqG3lpGBG5bry2EPD0Tq52DMQHOAtxWogYssCxASXx1pstG?=
 =?us-ascii?Q?fo3PHUvnD4njWaxvXDjHQLqWNOA0QRyjVvJhmbMWG9KeUMp5SLGVpSYZvdnA?=
 =?us-ascii?Q?Bzq9ow87+XIQ/+IyasGdTbeYDbw+4aa7TAbhUljm8GnLtvYrjbrrAFZNFZRC?=
 =?us-ascii?Q?6mSux4b//4n74IYLfkt3OCUaoDp7Zow4XQw6A/Nn/vlZeGpjNSFCYcDhC2Qe?=
 =?us-ascii?Q?fCRowtTGx57z8bejbNy4QtgAH6QwbJIj9EQYbNn1+p9Zeev6wfbzbBCHWFXJ?=
 =?us-ascii?Q?zagF8+uzbmesom1dYQKuWN1vtgn8sRDxHwmArS+y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80115e4-a0d3-4055-ca8a-08dc2c908f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 12:37:37.0154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhfRsHs41AKvDRJKbnFlRlK+HDe1gbe8qXj+f8stLI8FlyOd6M1z9x9JW/eFmHZxHVlTwdsC6+/ZK2PlqwDYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3618
X-Proofpoint-GUID: BesIqtxjVTuyvhbE0H905mlPPeZNDZkN
X-Proofpoint-ORIG-GUID: BesIqtxjVTuyvhbE0H905mlPPeZNDZkN
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

> Subject: Re: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci queue=
 mem
> multiplier
>=20
> On Tue, Feb 13, 2024 at 11:50:34AM +0000, Srujana Challa wrote:
> > > Subject: [EXT] Re: [PATCH] virtio-pci: correctly set virtio pci
> > > queue mem multiplier
> > >
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > -- On Mon, Feb 12, 2024 at 01:22:33PM +0530, Srujana Challa wrote:
> > > > Currently, virtio_pci_queue_mem_mult function returns 4K when
> > > > VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this is not correct when
> > > > host has page size as 64K.
> > > > This patch fixes the same.
> > > >
> > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > >
> > > You can't tweak guest visible values like this without compat
> > > machinery. It's also going to consume a ton more phys memory - can th=
is
> break any configs?
> > > Why is this a problem? Just with vdpa?
> >
> > We are observing the issue with vdpa when host has page size of 64K.
> > We haven't verified any other backends. I think, any backend that uses
> > below API would fail if host has page size other than 4K right?
> > And also as per VIRTIO_PCI_FLAG_PAGE_PER_VQ, it should be equal to
> > page_size right?
> >
> > static int virtio_pci_set_host_notifier_mr(DeviceState *d, int n,
> >                                            MemoryRegion *mr, bool
> > assign) {
> >     VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
> >     int offset;
> >
> >     if (n >=3D VIRTIO_QUEUE_MAX || !virtio_pci_modern(proxy) ||
> >         virtio_pci_queue_mem_mult(proxy) !=3D memory_region_size(mr)) {
> >         return -1;
> >     }
>=20
> Yes but not everyone uses that right? Plain virtio in software with no tr=
icks
> doesn't care?
Yes,  any other better ways to address this issue.?

>=20
>=20
> > >
> > > > ---
> > > >  hw/virtio/virtio-pci.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> > > > e433879542..028df99991 100644
> > > > --- a/hw/virtio/virtio-pci.c
> > > > +++ b/hw/virtio/virtio-pci.c
> > > > @@ -316,12 +316,10 @@ static bool
> > > virtio_pci_ioeventfd_enabled(DeviceState *d)
> > > >      return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) !=3D 0;
> > > > }
> > > >
> > > > -#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
> > > > -
> > > >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy
> > > > *proxy)  {
> > > >      return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > > > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > > > +        qemu_real_host_page_size()  : 4;
> > > >  }
> > > >
> > > >  static int virtio_pci_ioeventfd_assign(DeviceState *d,
> > > > EventNotifier *notifier,
> > > > --
> > > > 2.25.1


