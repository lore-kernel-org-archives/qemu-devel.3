Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62740C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 09:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc06y-0008Im-Fj; Mon, 19 Feb 2024 04:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rc06w-0008IV-NV
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:38:54 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rc06u-0005mt-AD
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:38:54 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41INFLfM020210; Mon, 19 Feb 2024 01:38:49 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3waw6juta8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 01:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjviK0azinhdDgncLROz05y4ui3gD4wOjDav2RzBkW1EnkVgZYHf8KL5Plg50seN2sS8fi1KzZ+OyPTIIyeGrHrwqEUpJbN65flJMchUV70gQQ2+9NLl3dQIdIzHQ2I0nP5b3QdYi45Rh6HRLKmj2zypM3mMocQrd0KfXqUC6XNyDGwojv5RJ4fTnSp5Md6/O9pgN5SezX13/JXjZEy9HuuWYsg9+7tR6gTq4WbH/LbUvZw/EqWs5TgHxy9LYqdDTDWpRUPsUKY/dQ1QnTCHBQjqhOXrnRiuScDCuEOYSjzF8jvEK+ZObWTtKP1oszmucS4UE6hzPH07XAg/kgEcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+Y1UtnqC5CgxFeirrHm4uduXFh1DvklnqeOHfDMYHM=;
 b=R5/qyGEvStEZbV87Nu8TR6C/092D1Grww5x/+SdhaEU86jbOE9xEVrLCJSMM7Md7g/elQlu8Onbi1FQrhkpiKjNIhedQeC7eCC3+biDmEVvGXsd/P02sAZpkqEdss24Ejk381Zegdy4OBJFWdIKq4MxBoLpUOiWPvFVTUxZ4XwChZ5/ySps3N7+oE0dTODBjoLO6fid2vYS+zSmWBv7y2ULECjc6CX7rOF6+o5+ITyufhLwP6iF3auyvxs2WdrnWWkWyRxgGHk1tSvv6diyCjsk95o/t6P5vB+L1rCtsa81wwGfIDhTC1/9XnEX9iGo72EnDJAc1Wr2K90oVmfD9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Y1UtnqC5CgxFeirrHm4uduXFh1DvklnqeOHfDMYHM=;
 b=EJlUR+cRH7HUVJgoYuG9pAiqXshOENS+P2inbPt3xWmwuEAH/3w7FNtRopjrumdsLERzVpBObvbG7UuHZF7IwsO9kDnV4qlh9Xe7Xlaq+DTogVLWqeUdhonm9KfoIGchQKOOSB+1WaTWiC25X2PG+ayrNwUga1Q7KK9zbdB+SbU=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by CH3PR18MB5860.namprd18.prod.outlook.com (2603:10b6:610:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 09:38:47 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b%6]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 09:38:46 +0000
From: Srujana Challa <schalla@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
CC: Jerin Jacob <jerinj@marvell.com>
Subject: RE: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER feature
 bits to vdpa_feature_bits
Thread-Topic: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER feature
 bits to vdpa_feature_bits
Thread-Index: AQHaPWzhCeCIsh6mEUaoV/wN3aQr2LDzp43wgB4MQHA=
Date: Mon, 19 Feb 2024 09:38:46 +0000
Message-ID: <DS0PR18MB53687B6AEF7B64E24EE25911A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240102111432.36817-1-schalla@marvell.com>
 <SJ0PR18MB52465C8395C6DE0A1BF557E4A67C2@SJ0PR18MB5246.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB52465C8395C6DE0A1BF557E4A67C2@SJ0PR18MB5246.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|CH3PR18MB5860:EE_
x-ms-office365-filtering-correlation-id: befe5132-edb7-4697-5f46-08dc312e91ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jE2c6RDw9EimEOBv+FXZd3MaK7tVQ09T+qEXFu8YxOLga2kYXkoyz1cwcPUK4IvWVIGykM95R00C0moSGmJVFZau0Km9BORgUXDrV7ruq7WBZEXi+LBAVB2ignUen9iVA1eR1dcG4ffnNbJLTzkRevBWHI/puHu5hLZuAB+fOPPf4TCbpM1tTyICHo+NyXEinUAOFkuyktU9akU1/6oirIBKwnXjxafS4L6MVqoniUXvS7Pg9zSt9lEmTVYnz226ZYghmCyQrIqkYiS83AIQH2KILnph5oLJ25Pp8Bg2S0zPC3vdhU6mqRKsvM95Jez/k33ecDCoX47Nu/pL1EPIdls2/GoimLbX5GenQC6M+5o9LL0Em4uUhYUxz4+R0X4yYSfu+xCavh5mqxRWxA2zEuJkSxE0zP2NMxAooeWCytREMhqkMnwKTBqYK359iSK7K2yLys5znXTC88scLKqdG2GU/GX5WcjX8090KgFDGk4BWCCO4hGiIF0vxi/0/mJxVzPzEKortAfBYS6ms1mTtvEpZ44OcpPKQYX8IlMB2JKe/cKYPGbb+OQR8lUGTfjUl4SAXiEJPlO5kFbgNK0XvWdF+MkSOvJHL+eVfIApc/8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(86362001)(26005)(41300700001)(107886003)(316002)(110136005)(83380400001)(53546011)(9686003)(7696005)(6506007)(478600001)(71200400001)(966005)(38070700009)(5660300002)(15650500001)(52536014)(8676002)(4326008)(8936002)(64756008)(33656002)(66556008)(66446008)(66476007)(76116006)(66946007)(122000001)(38100700002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R5aqwMDmmyrxk92x4RdxSfsyj9O3dzogAD9WI6F1cAlRb7+WfCnjfMKvp16l?=
 =?us-ascii?Q?xNUt3Xq/I6ddyGpMGc2TuKznwKNraHXbuVIGA4Xq5ATLb4cV0FSOfnN1O0QH?=
 =?us-ascii?Q?Lk1Dy/UbZlRKuQ5XEqWNb4Y1eJLt3tIXZLvxBd2eZ5R7JvRIlyQ0seoel8YG?=
 =?us-ascii?Q?xpNLApDDmPiU4EDg48GC2TNZVzdnIiXY1VtVjLyZasAsypH3zee+/jC5rOiZ?=
 =?us-ascii?Q?+bPSMHIq4kOsgu46tJrVfFtbmjV+ubMlUGN6On5Jpb4j2NwRnDEXj6WPNx2n?=
 =?us-ascii?Q?MHn3Z+/mvzqGCxjwggjVQsPMU+KNJZnl8gpRgjkGFH5Qo2rC4oXokwyBUX9q?=
 =?us-ascii?Q?AChIFkDyTZn3JhCNAJN/JVXGSExDThJzWEPS7qFCNApFwzhRz4h5z1K6ND36?=
 =?us-ascii?Q?za6t9NNEAUwcNnvO7ytToSUeQuGBV47AmnrDgZM0dNDTw7ley3nYkLln5UK0?=
 =?us-ascii?Q?JXBEXydflLCeMDQK/H7GwZwZfAR8JQTFXjhzmuLVkOQdX6H7QySUPyXEwGsw?=
 =?us-ascii?Q?lDeIqip9cIXSCftoQpt8e+z5JfRraYr41H+f2sEahmLs5rk2kSNzlREW/fgI?=
 =?us-ascii?Q?zO0YG0ahTO24JnUYqf/jnPWTm4SyQDxuBFKyFp6/KuT3JwP5YjjuKAfCUw7Y?=
 =?us-ascii?Q?CUDumFk4JydbcyUegcSAlwSYv9hJy2MRsIZ7h9LpgwCsW1xFJ0nVo3D8Pp4C?=
 =?us-ascii?Q?gipeZxC8RTlm2EWyV3rdeTeivnef/gtR1kYPwiIyX6LobWCdqquFn6nPJWTX?=
 =?us-ascii?Q?j9Eh55Tt8W7RgthYtW8gq7TNO/NK0j0sTivd3fW5anOjuvidAnpenk6uHoai?=
 =?us-ascii?Q?NMLctE7uJIFnU9Pc9V0rtnVauGQQVADqS2AUgFmiesdtz5UN5SksZk9h+7/t?=
 =?us-ascii?Q?M7ier2xKS5Xsf+GoTKw/K4/OIqk2wIb+iFCULyv0CBALcHerMS24D/Mip700?=
 =?us-ascii?Q?d1D8JxYHnOAz9gHVXjQypzK2IEFeJyeMYffn77WqLV8cIQIN05K06nqStAx0?=
 =?us-ascii?Q?sM8dPSZKmNfqkNmt8AejUPDew8YmwYjP8J32vXbalXuY4g7KUIU+zNxTuFKZ?=
 =?us-ascii?Q?kZJLW8xUrtm3tGmUfvDB0s3EqPbSX+EGBakDsoFAXqLYKPHL1eeqcUCUVyUl?=
 =?us-ascii?Q?WJ291RWL0LlzetHydTiynOToEOFDJjk3wDOhxWwMIr1BGwdyI0ptoX/wopcT?=
 =?us-ascii?Q?T8VLj9Ja/g3dWBaXWk5PtrwFUTxl2EUd+IahVDlkWCh529N/oLyvxWqNflji?=
 =?us-ascii?Q?6siyUeIKHaKKJHHW0WSPx5OrhG0IKrRNZiGWEHJbA5sR/4dGKLZayT+1Rkgj?=
 =?us-ascii?Q?FRz7JWnoc2t1SzI6n191NT9gSp5TcDRCYWstQommXD+EkWbV1CRK+vbCi2Ol?=
 =?us-ascii?Q?IGU0CRDzQCVUd4+0pgMot+qInTWIQ7aiumAiPpJlVzwpFvdfhqnOefe1N/95?=
 =?us-ascii?Q?j7NkpsqzBiJs51h0F4g4WJglIR0oo/efgCdr8MkZOSCJUPjizA8hQcSYCem4?=
 =?us-ascii?Q?re7ix2ESCMHZDnhrFjafA36+01w1I1zvHAR3xo9cw2/OcA5d1iACYFLtYviC?=
 =?us-ascii?Q?BlodwrpUjwWOaGtqQhr1aPNkCNjZCNzpd69K047r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befe5132-edb7-4697-5f46-08dc312e91ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 09:38:46.1929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYriqiluGN7bTjE5MLvdXMnpfX5p2ALv7HHcOWyhAMyre5ftajKEC9ZjAa0nNkvu8Axno5VzbJxnmHmctVT0hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5860
X-Proofpoint-GUID: tb8j5doooDDj1vIB0h6DRe0-jux8IdwU
X-Proofpoint-ORIG-GUID: tb8j5doooDDj1vIB0h6DRe0-jux8IdwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_06,2024-02-16_01,2023-05-22_02
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

> Subject: RE: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
> feature bits to vdpa_feature_bits
>=20
> Hi Michael,
>=20
> Can you review this feature support patch, appreciate your review and
> comments.
>=20
> Patch considers all feature bits supported by vhost net client type as pa=
rt of
> feature negotiation to address the concerns raised in below thread.
> https://patchew.org/QEMU/1533833677-27512-1-git-send-email-
> i.maximets@samsung.com/
>=20
> Regards
> Vamsi
>=20
> > -----Original Message-----
> > From: Srujana Challa <schalla@marvell.com>
> > Sent: Tuesday, January 2, 2024 4:45 PM
> > To: qemu-devel@nongnu.org
> > Cc: mst@redhat.com; Vamsi Krishna Attunuru <vattunuru@marvell.com>;
> > Jerin Jacob Kollanukkaran <jerinj@marvell.com>
> > Subject: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
> feature
> > bits to vdpa_feature_bits
> >
> > Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER feature
> bits
> > for vhost vdpa backend. Also adds code to consider all feature bits
> > supported by vhost net client type for feature negotiation, so that
> > vhost backend device supported features can be negotiated with guest.
> >
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > ---
> >  hw/net/vhost_net.c | 10 ++++++++++
> >  net/vhost-vdpa.c   |  2 ++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > e8e1661646..65ae8bcece 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -117,6 +117,16 @@ static const int
> > *vhost_net_get_feature_bits(struct
> > vhost_net *net)
> >
> >  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t
> > features) {
> > +    const int *bit =3D vhost_net_get_feature_bits(net);
> > +
> > +    /*
> > +     * Consider all feature bits for feature negotiation with vhost ba=
ckend,
> > +     * so that all backend device supported features can be negotiated=
.
> > +     */
> > +    while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
> > +        features |=3D (1ULL << *bit);
> > +        bit++;
> > +    }
> >      return vhost_get_features(&net->dev, vhost_net_get_feature_bits(ne=
t),
> >              features);
> >  }
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c index
> > 3726ee5d67..51334fcfe2 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
> >   */
> >  const int vdpa_feature_bits[] =3D {
> >      VIRTIO_F_ANY_LAYOUT,
> > +    VIRTIO_F_IN_ORDER,
> >      VIRTIO_F_IOMMU_PLATFORM,
> > +    VIRTIO_F_NOTIFICATION_DATA,
> >      VIRTIO_F_NOTIFY_ON_EMPTY,
> >      VIRTIO_F_RING_PACKED,
> >      VIRTIO_F_RING_RESET,
> > --
> > 2.25.1


