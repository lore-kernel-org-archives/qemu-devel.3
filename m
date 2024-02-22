Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5258EC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd3QM-0006Wh-ME; Thu, 22 Feb 2024 02:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rd3QK-0006WW-OK
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:23:16 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rd3QI-0007i1-Ge
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:23:16 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41LN5o2B009000; Wed, 21 Feb 2024 23:23:10 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wd21kfjjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 23:23:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PByRzQLvG+H9qhJ32KGzaFhlUH2o98m3gz8UAOKyLt1/r7Gurc2bTCoJNeuFH+gGSPnpcycYZ+LbMoqD3OtM1LKHeCBaC6LDo6ze2bndyGK7TK/Ot5fWQB5CqOV7cpGAO5l1cbqh9nhOxcebYeddjGcjJiIyID2kNFk1Tww/mw7TLAw55ZBF3HnLIwinYcM9uqKtt+llXRZJJZ/EzZzCeNG7V12UOIHx1qXX0nDyDiqVycKqsur+tHatDar3tWz+uXdR2jtGrfRMtloWhmsyeRGfVX/oK2ZFUfEvvT2Vo7E/QRIJh8itIHWejzdPRxzh9Fzl4DTI5UoqJUs6Mk+oFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDKW9FmLwpqMj1yuFOoNKs3S0QgWnjoivYE7MXp88nY=;
 b=ei67XLK/X9s39yBbaQSvXfh0ZCRprp2Qg8OGPDP+dxpLRS6Zj/KIZb6vIch6HWZ9b9wcdNdB9jLFtUI/I2LrN1sWW1L6O/iyFbE8xTGpVTgayEezq9YYO++aAPFq5pI9mfT8CRsceEIi1ADtHOEZLH3Upq3lLzBLItSprgLp1oRABFloxq21FKodc160oMKUfqjup8FjE9vy/Xrbu0StHQqiH0NjUh9XVnA1+r+ym7AhaGBSBsLD1qygisSvYZkOuiwMGGafhacYkZ+/ogLlxb9fmsinPWZcjK2BBZJFL84D91bJBdV/DVQJvJWmEzQUFERCB9HJFpmGTR72yo05yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDKW9FmLwpqMj1yuFOoNKs3S0QgWnjoivYE7MXp88nY=;
 b=DsR4ZSp6dPf1USJbFjkBsDXKPNefJtYq5j3AM2AUhh1PrO0wVrEkHF4FF8+xXEqBQHLYFP4meFUBB8BZHeb7565nRJDVDvODMJMM5QTRbx4JTRmuSXHChNzhRfGEuXiLv15VMxUM/eVAkIr+7Qj30MTG/SZ6VM59Csa4dH8Bdu4=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by PH0PR18MB4541.namprd18.prod.outlook.com (2603:10b6:510:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 07:23:07 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b%6]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 07:23:07 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Jason Wang
 <jasowang@redhat.com>
Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
Thread-Topic: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
Thread-Index: AQHaYxhbwHf1xjJpq0Wux4yyZKaw7bERiJqQgARw4sA=
Date: Thu, 22 Feb 2024 07:23:07 +0000
Message-ID: <DS0PR18MB536881ACD91AFC00D2E24744A0562@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240102111432.36817-1-schalla@marvell.com>
 <20240219044352-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368BA5DBD8D8CDDE1A68573A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB5368BA5DBD8D8CDDE1A68573A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|PH0PR18MB4541:EE_
x-ms-office365-filtering-correlation-id: 2e79fa55-f7e8-4202-929d-08dc33771dc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gs/VkQU+eG2Nmzi7q8A4KglJCE3BcBbnz8XI1+a8GlcuuUUvjnRz2fL7jzhkh/VX/N0A1UvgOB7siYk5489oVHFZryAnrf/Q2KoTj7d5LVEmBVMUKPYmkhPTDxGXu5JDHeItkjo1rj/k95Uxp4F1m25LWvHWe8rj2LCm/2uM20UGvOvYWQD8NR++A9WlTrDlntdhCZ3sGzkvY0trHciyJE73mvOd3tLowwXb4ZVK6nso5ZrM57zt4cDbG/cfjcCyYwBohaedmDYOmuuzx41UCTsA3dCf962sfSiWj0bSXz7iGY/dZC5QwONHB9+WuNNb794c94Ebmo7ulg0asu/MD+CAkl/tTekJk1WqFu82joeR9p8Xc7Y9DWEUsLxiAX4PHnYiL2djNzCwdNl0P2EAMVz48lcIBCZnKP8nmFXf0DO4uY99AHyIoMRvMt0K+FDbrzA4Q5M5QOdPdz7SgKHLQeudgztWkklOFosJQ0863Zh8DwvtMZs4LWXs3YeNPauPg539o+BSx6Bqw4fSF2zrvDCW+Nt3O6AWPsxfkZtWsRUd/uSnELb5qGxtbWLZ5ejG2JwifcN4yH+HU9c+cOD9jk+olzBRkqIcnBNO0g9pkk4LCCBSjPkc88zFUYqqtkwM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nURXHQosQncMvYA1BL5DxeLA1o9+QnOmagpXX36opjS9GmrlH4hf761PyvTO?=
 =?us-ascii?Q?HoYxw6h837sbaaGU2HsPg6R7Ml83Di1VsGe9hjrEMvpVwfJlRuEbBmVzFNgT?=
 =?us-ascii?Q?HxDPXDmPmSwepWFdWD7xqNekqIdlaQ4Ld/mTolddo0yyg0cOJ5277QnZDBwG?=
 =?us-ascii?Q?o1SzJev5K+d53PZXEXe/Pf1w//jp5iEAXtzrLCrPJfkEOZdiD4JHYznXefK6?=
 =?us-ascii?Q?TDu9SS7zc8/dJtl6DHiR0ocwlDElG/7VHBjdXzToMYI2Di3qVsl8OZD/BoO/?=
 =?us-ascii?Q?7zpBaG/Lp2cz/mTlX254++48ecbd8jX12rE5zuSm0ip/3wRUI9KtZJq2smPM?=
 =?us-ascii?Q?cPKU5bN5gfF+Mr8g4JBamKNIL6JnIJjN8Nne4ImLpbs4motOM+Y+j2HIrC4d?=
 =?us-ascii?Q?/83Nm8ouLoqudrIxBAqQ5H7i1oV46lnFnj0j1e/q0Xi0YhVakIX9dYHYNimf?=
 =?us-ascii?Q?BllS42nfgefZl5gRYVaKhK7iQmQA/wBIXQkHQOJFtHupCA9xZSzAGMPZqV/i?=
 =?us-ascii?Q?gNXtYNbMPCbW4QcKZd9JkecjJTkzD0bi56HPvsQDNfCw+vm2U9TZNMfofuwn?=
 =?us-ascii?Q?0wP4X6Ef2PI3YI6ifbFWxBniRZAMWQ3d6et0BdUOZExppU3N9rxc8o+wudRv?=
 =?us-ascii?Q?RwwRm/VevXIcXpZ2becSz7C4+tSbp44aqLlt9qEaK7vJB1FlSSaVNByOkOOf?=
 =?us-ascii?Q?Gz5nkzgMj3KnDH/yBon+zKKgXxI6TmNTlFIskKOQk1n4VTE8eVzjsl6xPLCp?=
 =?us-ascii?Q?P/b7KdIXFyS/MyY0cD1mgSC4Ep/tQY4B4rZmKh7SZ49xudD5z+Mq2LhjDdjk?=
 =?us-ascii?Q?zAQD2xwvTsRuCcTRnwtr8jxFUT/06n8rkxichfiEMczCf1nYhbA/W2m0kMyp?=
 =?us-ascii?Q?GsYUc5gfyvsG267BGyB4SMiFS+YDe8eT0EOhIVq+g+sCjXRvxchv8ElUAK9c?=
 =?us-ascii?Q?eqgi/ojsS8rDQCZ00IeQ6fZTdd72I1hAKnS2bLA0q9Hv4k3DHUzRC4GX7+nR?=
 =?us-ascii?Q?fBLH9flyOBXz9AExpT3aXXhQzFo7A3IZja0BLSwjCWKqXV68qoZN+prhi0sM?=
 =?us-ascii?Q?lB3P8CeLC1iNvcgewXhIHaJ9vJdgXQc1hDAV7pjc5JmeIF7y+ZutWzWtIEwP?=
 =?us-ascii?Q?nIzOc2uMdVvcAzvfHvJ2G1PoGpIwhLARTDRIY8tqmWmSMyW8Mlq5e3wQ1fdj?=
 =?us-ascii?Q?ZJfi2lfAaLfW6st/BuU6DO10+1bh2E4ZY2fCVHnZNN9Y59ZEqStELvu6Y8ID?=
 =?us-ascii?Q?LEvkEEfzSJBwEoUFjDNJLXWFRiYkXDIlWOP+epn1CRDm8fMje3jYavOFahM1?=
 =?us-ascii?Q?/PHzbzWQcGUGe6F23OKZfKol5cCvRplFmUWjZim2Dze2nZ1DmhFkoEFEP7e9?=
 =?us-ascii?Q?sNN8ONolwExudb2JkaKzpLm68nMJyJRQS6pjsVy5dlf0GDTu5hDu6ouB37mj?=
 =?us-ascii?Q?dI7pKSCiUb8pdmZOZaZUbJ/fEq+qy8SVJnzRD+qUpuTYN7wVkK7Xk7TGYq+F?=
 =?us-ascii?Q?DoSluGUVEr/Umcq9qviJfPgegFef+Ho8uQfeov/HygDAtgf3kmYCAjsS94QJ?=
 =?us-ascii?Q?7+32L6l4tUJxNysYKzVFvcZMESRz5e3TuRwuFgHE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e79fa55-f7e8-4202-929d-08dc33771dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 07:23:07.2732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jlw90nYId+Ud++aw428xN/el9eICYRVvuhkBsNdHKWFhLXYIs3BN4PICHmBsqUbnTRdCJRquZY8cxvS0Nsq5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4541
X-Proofpoint-GUID: UgzCiSyWULKr2N1mpecI8wlZ5fOQFyTd
X-Proofpoint-ORIG-GUID: UgzCiSyWULKr2N1mpecI8wlZ5fOQFyTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_05,2024-02-22_01,2023-05-22_02
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

Ping.

> Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> IN_ORDER feature bits to vdpa_feature_bits
>=20
>=20
>=20
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, February 19, 2024 3:15 PM
> > To: Srujana Challa <schalla@marvell.com>
> > Cc: qemu-devel@nongnu.org; Vamsi Krishna Attunuru
> > <vattunuru@marvell.com>; Jerin Jacob <jerinj@marvell.com>; Jason Wang
> > <jasowang@redhat.com>
> > Subject: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > IN_ORDER feature bits to vdpa_feature_bits
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> > On Tue, Jan 02, 2024 at 04:44:32PM +0530, Srujana Challa wrote:
> > > Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER feature
> > bits
> > > for vhost vdpa backend. Also adds code to consider all feature bits
> > > supported by vhost net client type for feature negotiation, so that
> > > vhost backend device supported features can be negotiated with guest.
> > >
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > ---
> > >  hw/net/vhost_net.c | 10 ++++++++++
> > >  net/vhost-vdpa.c   |  2 ++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > > e8e1661646..65ae8bcece 100644
> > > --- a/hw/net/vhost_net.c
> > > +++ b/hw/net/vhost_net.c
> > > @@ -117,6 +117,16 @@ static const int
> > > *vhost_net_get_feature_bits(struct vhost_net *net)
> > >
> > >  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t
> > > features)  {
> > > +    const int *bit =3D vhost_net_get_feature_bits(net);
> > > +
> > > +    /*
> > > +     * Consider all feature bits for feature negotiation with vhost =
backend,
> > > +     * so that all backend device supported features can be negotiat=
ed.
> > > +     */
> > > +    while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
> > > +        features |=3D (1ULL << *bit);
> > > +        bit++;
> > > +    }
> > >      return vhost_get_features(&net->dev, vhost_net_get_feature_bits(=
net),
> > >              features);
> > >  }
> >
> > I don't think we should do this part. With vdpa QEMU is in control of
> > which features are exposed and that is intentional since features are
> > often tied to other behaviour.
>=20
> Vdpa Qemu can negotiate all the features which vdpa backend device suppor=
ts
> with the guest right?
> Guest drivers (it could be userspace or kernel drivers) will negotiate th=
eir own
> features, so that
> frontend supported features will get the precedence.
>=20
> >
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c index
> > > 3726ee5d67..51334fcfe2 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
> > >   */
> > >  const int vdpa_feature_bits[] =3D {
> > >      VIRTIO_F_ANY_LAYOUT,
> > > +    VIRTIO_F_IN_ORDER,
> > >      VIRTIO_F_IOMMU_PLATFORM,
> > > +    VIRTIO_F_NOTIFICATION_DATA,
> > >      VIRTIO_F_NOTIFY_ON_EMPTY,
> > >      VIRTIO_F_RING_PACKED,
> > >      VIRTIO_F_RING_RESET,
> > > --
> > > 2.25.1


