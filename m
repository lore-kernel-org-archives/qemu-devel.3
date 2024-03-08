Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F80C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riaQJ-0004P0-JM; Fri, 08 Mar 2024 08:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1riaQH-0004Oq-Ho
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:38:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1riaQF-0006Ey-Nc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:38:05 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4288PKKQ020901; Fri, 8 Mar 2024 05:38:02 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wqkj5tuvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 05:38:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2hyBwEvU0CIcQT7DZ3zFxy+3ELmcMybQ4g6Cc18290PbEqy4rfPDsUmfhCKb8fTZNEhLIPawcnBrVGavDqALWXuvcu0ShneDWEtAdeUNpZ8AJu1MHUeXYzc3eShRmVZt3HA/ENtkVx3zS42265yHgQpDpPk2u1lomd3EVV/pyYuCkyAR3T8cOT+YF0dxxVwSmHNRIpbR/rE+Z/2Omg74VWWLd+nq6/fR/dra14rG9m0E2I9PC4UiRrkBynWbj58bfybk9GG4NN5i8x9U4kequnxHqXZDL/ZFIfwsZE7pf+Zn9c8A1GGxzB4ggio4u5iJG/qTFzcmfocVq4y+iCx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SGmw+mxe8ae94a49kAJD2aoPIFZ8wFgCALEcayGHvk=;
 b=RTVRSEtlMYT5PTKrMwzEBrvUW1ld50+Ir7UYQDNXvj+V1SGOQe+ND+ArqR593FuWQMyZTwWP8DPKBmbuPNlopkBNBuwQRtHWUeJc6Al8lrOngpQBxOMEc2a2J+ZuK1HY9C6pQ4pjCKv+lDjBBHxecUS9c4Vl62dnaMZDIPhFCTKuCir7TopeutcZcbguMgdv0iA4BHNvAV728BhmrdHOr44iv5PALBVUqrhl1dpV4CYqFxvSacpDLA1uII2YrnYobI1tMFpkc5PHqcLZWDgnqoAvEXQ/X/HiXZASU/1TaQodmRSXoitsUIxHDK17fWAjxjzqo2+2w2Hmql9OdNYLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SGmw+mxe8ae94a49kAJD2aoPIFZ8wFgCALEcayGHvk=;
 b=Xmnm4suG0qKeViKkIKdAtnGm/wTvkk5Cn+z2WqMknphUJtoK59MUgI2SPAa7aKC/evTj4bXAm0a9eAMQl2O1PolM6Ir8t3T2U8SPNSM5WxSusX6YLUctinE4JcCIYPl7Rh79ZF7tL5iKH1aAYubs5xjryBdgS3kfs8eNR3Lk7J4=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SA1PR18MB5965.namprd18.prod.outlook.com (2603:10b6:806:3e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 13:37:59 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 13:37:59 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Jason Wang
 <jasowang@redhat.com>
Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
Thread-Topic: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
Thread-Index: AQHaYxhbwHf1xjJpq0Wux4yyZKaw7bERiJqQgARw4sCAF/RcIA==
Date: Fri, 8 Mar 2024 13:37:58 +0000
Message-ID: <DS0PR18MB53681809B96E8745691192A1A0272@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240102111432.36817-1-schalla@marvell.com>
 <20240219044352-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368BA5DBD8D8CDDE1A68573A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
 <DS0PR18MB536881ACD91AFC00D2E24744A0562@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB536881ACD91AFC00D2E24744A0562@DS0PR18MB5368.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SA1PR18MB5965:EE_
x-ms-office365-filtering-correlation-id: 10dfe74b-21e9-4d25-cfa4-08dc3f74f803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8FDnPB6EYJBiQF3vNZhc5g2Y8Vtf75A6qowW1xCfBpmf6HT79jrDZijYHiOSOT7xJ6iFHJGzjdeo00qEd3ZWIg3MV8MTuRKzxpwcrGGsAKz0fWmOo9s7HCMIkuvfp+8D/xwTsU2lkI4EX/x4GwBX1fW4N9MZE9taRNPFao07P7EJ9liYCMKTDv2+c2SlZ9oEtYOQMAt2qEn52QED/y5u5wOD6xrWQVGR/z2/a68dRHNAJhRpnTv/kj57nTl8ojmT+yG8F/KhIG482uU/LWo7BXKq4C5waoVibeJYsjEUy1D/Y3TKkU9O4TIVw5E5kxMbC6Lq84B0Sk8GehKVdiGRY1DNdm990niTJ1E2io+ruCmuOVfvD8+V9PnnUSP1AEeVWo7lypPhdTsxTpM7qQPPLXHdjDypbaKzIrS4t6RecwzpAX2iWAXpspCu4v2IU+aMG62Afe6gSiNh7ccOlJ+EsgS/jFvjsNkXvE+6hBhhqmIhsp2kfHUka82R4niC0ctFJ4wjPL9EHhF0A6lWAyhUqLq8FKtV8yDS7ha4sMFe54j45K9eV7NxO+wyfNtv5ZiOfCyhTysk1qvVMmJy2YHh4TldEzC1TZetdkAIT7VzfVShWBihZuaI3w4rSqQEs8R6s/3newKpa4x/U3IC4HdggKEb9AXs37RnskeM20rdiGW7VLhTVcBpYXEmXyrlUbHBFB1QukRVFEa1NlBJNmSpwlM1BXU5X0+Op4Qfs+yyPY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJmHW1jujglgDoZ7mubtGr8jSME5AFB+S1q2evhlif7BKvDyYpUyvDO5Tg3J?=
 =?us-ascii?Q?sBD0LNbb4N+s+1Y7zi+TOTVvZMV0OAvdVRmBQNceq+JbQnzvmkJeCYzijK1N?=
 =?us-ascii?Q?pTf3xWtTK8CJV6o3SDcq0z3X2oDcHjrowxgIHc1z3PicDBhdZMkIWMxODOro?=
 =?us-ascii?Q?Zac2QkvDy3dUodUMIS3C645IcYTTdrGyaNLZ9lrh95V94BuxXHmWzHNzcevn?=
 =?us-ascii?Q?y+InA7oH7Vimt8ZHPGupAwQZ0kWYXXpyyt56GbNWLlpB7A5xaRrCJJX+Posr?=
 =?us-ascii?Q?tHjjFNggj5jk/l/DbPO5SFOxR0HEvy7MlgmQy1AEiuuheJppeN7vMZ0SHIPO?=
 =?us-ascii?Q?/vFi58QsMpxY0HVcaP+u480sfU45EMHWcyVpHjnKuQqoq8gdKLgam+aqcM6m?=
 =?us-ascii?Q?DmK5bhK54WEQqBuv63hf38OmPVUNzJZPvRK7Rhmjk41p7F7wJ8tGPwgDg9IT?=
 =?us-ascii?Q?2l+OgqwIGwN+FgLn8t3cYfyMYUkflZWDHnfDioQTTFjxaxGlrID+AGc/OUKm?=
 =?us-ascii?Q?s5Feta4dREDS04Oldm5Jto8x7CmlwL/gSBXewLBSKSyiku8qQOhiwbSKlR4a?=
 =?us-ascii?Q?dZ3V9dR0A8xIlZBG7+a/Dj3lw3a+2jkY1D6rMtQYSjMWrXydonwdVi147+oO?=
 =?us-ascii?Q?1JB7QCIAjdy6fAgsIeVnc+Eq/0JA7iPDWw7+aGHcfj6IWVvvhve6KnAg1E7v?=
 =?us-ascii?Q?LXc+XZAOx1LOFIIsBI+2aj4Hf6hP7wMq/15Ck5vu7k1nkgcjwWRZVixE/ch8?=
 =?us-ascii?Q?XjP3QrNy/m4OmybAksm9c61G5imk+aTMX7vOWwg+81kweNXZEA4GBPI+IBqB?=
 =?us-ascii?Q?ln7Cnzxv8b91/VzqNPh09KJOfXHWlK+Wg/Ht3Ds3xDskw9YuAh2UApPG2tsJ?=
 =?us-ascii?Q?ykZYWoup9QgiHurkK9tFZ9T/fkKZaeCHsoR0Y8L4WmbV6dhI79XqTtBa+dbm?=
 =?us-ascii?Q?Qp5dXIwH2xOFn7/qmkQ/8mqJcEdOfFEOp8QWr4sBxidXOBbbrF19Y+C8s+Tr?=
 =?us-ascii?Q?j6wRzvgROpNC2YhC3mLuowlw4+Bbj1eOeCrQkZo1/Mk7C194KFw/V99PVqre?=
 =?us-ascii?Q?Orjbd27u5W/ev9MC6MdtV8UGOgMxjzcOcYuRW4dAIrYTFargw9I+kAamBG1L?=
 =?us-ascii?Q?4NbR3Z3MqscFc4OZmotX7IP0ALzd2wT5zndcsM7z2+oFfx1NMlnchhMbfhTc?=
 =?us-ascii?Q?e0zK77LWlMhRonTtVn9xWX38WgWNjH9LWJzmoLVsom3LcPTlyK+6zP6kVyvX?=
 =?us-ascii?Q?AOlplof2QPUITgPjiGkiHw/qo3kBO/h0JA9O9Mi+FdsO1fBZWa7eHFmvCe0k?=
 =?us-ascii?Q?0ZlmVNlnO+eRlYNdXi+pL8YdDhY9dHYuH6gOgTz8yrWttzbzN6nsOpaE9OxA?=
 =?us-ascii?Q?H/+91bguf3Ns9xsB8y9G5wzMKaYup5lbFz64ZpdT5jyBjKNvrL26EvDTDqbw?=
 =?us-ascii?Q?2Rss0eDZ/OXa71ARIM32ZHJGHZxUGEWGdq7T8o+QMYMQ0vE1Mbxq5o9L7jhV?=
 =?us-ascii?Q?lKHJ3mBvdhOh9KnujW47RWsOlDGNPLACtN6jNmCfG+A96B25T68XBYeE24ha?=
 =?us-ascii?Q?0KY9ALOzibpPW9fo+34350umUDkmDWua+a/QdE8u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dfe74b-21e9-4d25-cfa4-08dc3f74f803
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 13:37:58.9047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3HiPEFPexem83+10f8Liq9LDCi7GQ9wwW9oJMIxBVutXVYBREAbDTWNzta2lZqervKITyBV5D3AEoND3f7Jvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5965
X-Proofpoint-GUID: UJRyux-IX4PTwoDY_OmrhD9bu_WSG159
X-Proofpoint-ORIG-GUID: UJRyux-IX4PTwoDY_OmrhD9bu_WSG159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.156.173; envelope-from=schalla@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Michael,

VIRTIO_F_NOTIFICATION_DATA needs to be exposed to make Marvell's device wor=
ks
with Qemu. Any other better ways to expose VIRTIO_F_NOTIFICATION_DATA featu=
re
bit for vhost vdpa use case?

Thanks,
Srujana.

> Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> IN_ORDER feature bits to vdpa_feature_bits
>=20
> Ping.
>=20
> > Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > IN_ORDER feature bits to vdpa_feature_bits
> >
> >
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, February 19, 2024 3:15 PM
> > > To: Srujana Challa <schalla@marvell.com>
> > > Cc: qemu-devel@nongnu.org; Vamsi Krishna Attunuru
> > > <vattunuru@marvell.com>; Jerin Jacob <jerinj@marvell.com>; Jason
> > > Wang <jasowang@redhat.com>
> > > Subject: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > > IN_ORDER feature bits to vdpa_feature_bits
> > >
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > -- On Tue, Jan 02, 2024 at 04:44:32PM +0530, Srujana Challa wrote:
> > > > Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER
> feature
> > > bits
> > > > for vhost vdpa backend. Also adds code to consider all feature
> > > > bits supported by vhost net client type for feature negotiation,
> > > > so that vhost backend device supported features can be negotiated w=
ith
> guest.
> > > >
> > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > ---
> > > >  hw/net/vhost_net.c | 10 ++++++++++
> > > >  net/vhost-vdpa.c   |  2 ++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > > > e8e1661646..65ae8bcece 100644
> > > > --- a/hw/net/vhost_net.c
> > > > +++ b/hw/net/vhost_net.c
> > > > @@ -117,6 +117,16 @@ static const int
> > > > *vhost_net_get_feature_bits(struct vhost_net *net)
> > > >
> > > >  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t
> > > > features)  {
> > > > +    const int *bit =3D vhost_net_get_feature_bits(net);
> > > > +
> > > > +    /*
> > > > +     * Consider all feature bits for feature negotiation with vhos=
t backend,
> > > > +     * so that all backend device supported features can be negoti=
ated.
> > > > +     */
> > > > +    while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
> > > > +        features |=3D (1ULL << *bit);
> > > > +        bit++;
> > > > +    }
> > > >      return vhost_get_features(&net->dev,
> vhost_net_get_feature_bits(net),
> > > >              features);
> > > >  }
> > >
> > > I don't think we should do this part. With vdpa QEMU is in control
> > > of which features are exposed and that is intentional since features
> > > are often tied to other behaviour.
> >
> > Vdpa Qemu can negotiate all the features which vdpa backend device
> > supports with the guest right?
> > Guest drivers (it could be userspace or kernel drivers) will negotiate
> > their own features, so that frontend supported features will get the
> > precedence.
> >
> > >
> > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c index
> > > > 3726ee5d67..51334fcfe2 100644
> > > > --- a/net/vhost-vdpa.c
> > > > +++ b/net/vhost-vdpa.c
> > > > @@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
> > > >   */
> > > >  const int vdpa_feature_bits[] =3D {
> > > >      VIRTIO_F_ANY_LAYOUT,
> > > > +    VIRTIO_F_IN_ORDER,
> > > >      VIRTIO_F_IOMMU_PLATFORM,
> > > > +    VIRTIO_F_NOTIFICATION_DATA,
> > > >      VIRTIO_F_NOTIFY_ON_EMPTY,
> > > >      VIRTIO_F_RING_PACKED,
> > > >      VIRTIO_F_RING_RESET,
> > > > --
> > > > 2.25.1


