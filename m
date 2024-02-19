Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1B8C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc23d-0002jC-8x; Mon, 19 Feb 2024 06:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rc23b-0002ij-0v
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:43:35 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1rc23Y-0002S6-W2
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:43:34 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41J94REe005454; Mon, 19 Feb 2024 03:43:30 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wc41n8c3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 03:43:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBHJBl8l62Lke9WzcBu02WXH5pzNawn60/A8teYxvWwEXkkdRY0maM4QrUhnV1GdxGgbLlIhr/Z1TLpXhU0vCKwuoZENW6F93ZmWXBKhSUbPleKIsWi17DwikRFkLsS9ZGivQaxLhymTc3Gz8n9sGgK5cpKWLDp7sjFqC0g524F5PEU+7OaUW93ytHUXrdlIG7LRw+2y0zGO4tCIMUBQwN+VTNjCzU5mXMsQ9IPVrTgPv43x/eoN+wCyLT/fNIOM9fF8qwSfH86KwaqTso/+6wlRboMUikfivqpqQBz3ezsYxAmGBGzM4oRNLQYum08vHsusp8lvmdcQgHbWwQgMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yszoP1HfMzFGfSM2WzvS1mrpxjnTxLzxSkf9uS1YK8g=;
 b=hUmqLVbDKN9y71227MRJLEEAyAarbveG8Y2rFVdzC5wb46JFFJjWxPCGnHiFffaHwZtnRVyxXU++NV5YOSTsYqHPvunEkuffMh/xHWh1ZAzulhpFanE++zCLeP11on510TqPpwMm3diAHTCqpUvbBjwATKNraEh7FtxKbrZNmP1whXoAHSG8Kvpk0BoLsNTarhy6+JI7Ny5NgD+36XT7w1n7KmVDOyfZJW/0gGr4pQetw+eoFWOpPDOU8cUgNdIhgu1fFYfA6VnnDCPNz3juDuDh7pvPU/IpZGFTtJky6DVaOYIbPOeR8UPbR/7aaMPSG6xKsQX5Sc1oVFbm2b0ojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yszoP1HfMzFGfSM2WzvS1mrpxjnTxLzxSkf9uS1YK8g=;
 b=HZDTd5lw/TJGjp8fjhDxGJSYAo1CGXG+dWCJvwOlmQTDPyQ4syYrIecPsqB4lHRYYI2Ri1egeMC4iO0ct7b1vUV6rNv5gOgwMKwcleMW3zQn6KUXUgGqpSEOip3NJymph09xisydplFraZohvM7C4FZ8C4xsZKJBb0Uj/1wnH4U=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by PH0PR18MB4457.namprd18.prod.outlook.com (2603:10b6:510:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 11:43:26 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::f51f:bab0:175:23b%6]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 11:43:26 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Jason Wang
 <jasowang@redhat.com>
Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
Thread-Topic: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
Thread-Index: AQHaYxhbwHf1xjJpq0Wux4yyZKaw7bERiJqQ
Date: Mon, 19 Feb 2024 11:43:25 +0000
Message-ID: <DS0PR18MB5368BA5DBD8D8CDDE1A68573A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240102111432.36817-1-schalla@marvell.com>
 <20240219044352-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240219044352-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|PH0PR18MB4457:EE_
x-ms-office365-filtering-correlation-id: e48bd736-db33-4025-9d07-08dc313ffbf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pqckl7P8tf5HhCEUrCdOzNDcU4iEVM5QGfe/ckvFKhX2IndFFWk4Og+P46Ct96TAQskEMfwTIF+82MIvx37BlotRHLDUK/CDK4mPUmuyjNfERm9dJ5p2/ov54HwbmX2d0hgayw18rqL3MAXPqF5fhKB6OooBUzQ4fl/LzPqYgUI7d16sDuU7164HgsAlg2B9OSdZRqc4mWFIdNHCjOV9cA6UImrBoSOtcqKjHyiWCh4MF3lKN6GsjZQQL/f3PMSwMImhdiw8CEN/+28gQ9rFEtzG0TXZt2Tz1dZXQ+DIiNLAMfWxcg0rdWiUMbjKJSStD58prmGeYQgaSzYbnMzYntYFNU2j0+Oi6GYD1kkrcLw8ahEy0fNqq233qj3bsV/tVIscDl2HZN1/QHigO21RWJeDZmmmPJkFUgunTnODt+S843TPZMb/Aph34OyuZWe8JyU8xwLAulJwjolYKplenD9lGEfSN+w5kLMsCr2NJhp1F7CmydhYMxjBmcsxhjE5/cllu06ZPm5G0HiJJcRAuK/j2mvi3ElV0/R8+Xe9bGV1rVtpbbXlbRhuTP9xCPtcsVnO5AJv17BjterOBiAriijYJOyxrDv1rBE8tB12q9C+36vsDMM4LnlvBAMb604m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HUTEj2WHYnjuZoAiKCU6vme+DRvDrxVa3uc1kqzAJ54rUWLTjHouwOKEC/kz?=
 =?us-ascii?Q?fMhWU8TAdSBBpGA1ODPilgvlybmDS7D6GrbguMr/5mvOy7PxEITZOPvv70e9?=
 =?us-ascii?Q?GQnu8QrFOxR8j+NLNN9oflbxx79MnWtmTkO2KH+WxIxzuOOyuK94VPFIgeLF?=
 =?us-ascii?Q?uVMxTilGkGPJTbZC7yegIxYC6lONBrQPm0oigVRWqxbCyqHhzi2K+sx0MENW?=
 =?us-ascii?Q?Zhiy5gGFCoMH5l2WK8Lv0+6tE28FjSZy7Yh/KrO0f48Qvk64p9ev+Iizz6ep?=
 =?us-ascii?Q?7aCCc2HsIm7OalEds7QfzI5LNZiPlIxct41RGpXxgL+fqcUq+MgbEHlkLUSU?=
 =?us-ascii?Q?Iebu0FBTEIhoJlfKy3nJ8ozsPUJ5LJK8d7KX4hhF5SqjL6HjiK9f1XRtsZZE?=
 =?us-ascii?Q?H3SKsp94i6EJTv+ICAsHhExycf5srCraiBR/R2wWqlyxkqsXwW0Yzml5VibM?=
 =?us-ascii?Q?yN5KXAl0VqcjtUR8db084qWuhDxCK6BaUIGWp5GhlTgNGICkR+GOUuqgmMg/?=
 =?us-ascii?Q?BBJZnN3viqoD4FqWYnyPpIR5taNR2+1kb+B9yb5L8QfJ35OoF+NxifMzhSCH?=
 =?us-ascii?Q?Q56/MiNv/u9dYa1nWJ2578ylfNI7WIUk8OKKD9JfKqQywEyhz8woSK5aEsMA?=
 =?us-ascii?Q?JbLtJq6msUEwSqslFkNxldzcppRd32/U5fgK2HpG3SxMszLqzM+sU5hEs9Wj?=
 =?us-ascii?Q?zNpjgGQM+EYazNbGZcioDbbQFXFjhkMD3mKCiOdrmBbykKL2Dshsr5seo3tD?=
 =?us-ascii?Q?6WGQonUsVe2pz/rwMH2Byr6/0PbgKde6XhuJESzTqNaVQevgQ0+AI1v964py?=
 =?us-ascii?Q?55eoGWz1Gs5h2qVK76tf1NjW7acH3lMawhYU52w4q2zL4QHp1s7Fw1JgxA9S?=
 =?us-ascii?Q?57BpVg7rTNncYN26TVSgyvBACBfoHUYnhTDuaIvBIo/nJqOY2BXsC74CeZft?=
 =?us-ascii?Q?y+kIp9/Tu2w2enIrCWm/oGvwl67qFDTpBaNGbUmfmaEnCtBO8ga0YGwFUbcD?=
 =?us-ascii?Q?wUhHrNBUEIrOcVdVy6VAvp7idcNWXl+qhY03Kj2YLpCF0gG51rd1Zrc2ErdA?=
 =?us-ascii?Q?MtGhEfcuVh6wVWcrW/xjQd3b7qw5s8TSf/IPoQ0FmcPh+Heb2LCJ9TIkOOTu?=
 =?us-ascii?Q?PwEPRaIrNeA7Z1t4i8UEH8+4LBPb2XZqb1qWRiRNn2OiPSnmFo3WpT3ZDMjv?=
 =?us-ascii?Q?b8Bo+j3jWw0AjfJP3q92eu11MG/28BlZaSztp/Eb7vLgnjld4p15rAAFIfaa?=
 =?us-ascii?Q?XG3jrut8Y1IkWR1oI/5f+JMiAEH+hEKVRhwXWZ1nKs/IcCnwejIhNY4d2tQ4?=
 =?us-ascii?Q?t+2EItjFeYpPq1QBvrJGaLYy49fhAnTDnTX8iaLcPiq1ysCm3WqHFoxPSUgc?=
 =?us-ascii?Q?UCTMoWi7D7zgjMv49wpvqsF74euyeTGg4E6F1uuZvoxSklywS6iO9RaXJ74t?=
 =?us-ascii?Q?4NZ/KRoaX/TTBn5CKBzrg+5d6b6TMbYHrCH46a4zXP/KNku1Jn5CLarhccTQ?=
 =?us-ascii?Q?57+hdMX25lPYk+S9EbJAQ/OU+iz8YflT06XKrhVUOE3wOCGMopjTTKf1wFTL?=
 =?us-ascii?Q?kAWDANG9+dXpu0BYLAaAxSRNQdHxLG1Q7GNk8x4i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48bd736-db33-4025-9d07-08dc313ffbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 11:43:25.9146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etIpfaXH4FaGGp8O26WGP0Rs2ngYmUVP2vPDa6rx5ygvVAqArL5EAidAaErcG2FuAXEs/AYilwzGa+pCiLzV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4457
X-Proofpoint-GUID: YI_XELwuLZUXRfhWCoSFnFH2v5GgInSt
X-Proofpoint-ORIG-GUID: YI_XELwuLZUXRfhWCoSFnFH2v5GgInSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-19_01,2023-05-22_02
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
> Sent: Monday, February 19, 2024 3:15 PM
> To: Srujana Challa <schalla@marvell.com>
> Cc: qemu-devel@nongnu.org; Vamsi Krishna Attunuru
> <vattunuru@marvell.com>; Jerin Jacob <jerinj@marvell.com>; Jason Wang
> <jasowang@redhat.com>
> Subject: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> IN_ORDER feature bits to vdpa_feature_bits
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Tue, Jan 02, 2024 at 04:44:32PM +0530, Srujana Challa wrote:
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
> > *vhost_net_get_feature_bits(struct vhost_net *net)
> >
> >  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t
> > features)  {
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
>=20
> I don't think we should do this part. With vdpa QEMU is in control of whi=
ch
> features are exposed and that is intentional since features are often tie=
d to
> other behaviour.

Vdpa Qemu can negotiate all the features which vdpa backend device supports=
 with the guest right?
Guest drivers (it could be userspace or kernel drivers) will negotiate thei=
r own features, so that
frontend supported features will get the precedence.  =20

>=20
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


