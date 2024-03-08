Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F93C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZxq-0000Br-HO; Fri, 08 Mar 2024 08:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1riZxp-0000BZ-2D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:08:41 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schalla@marvell.com>)
 id 1riZxn-0006Aj-4V
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:08:40 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4288gVrG020919; Fri, 8 Mar 2024 05:08:36 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wqkj5ts6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 05:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faSho3WeLH0XW/zvgnngG9CIZxgmy6+1FaOEJBsuEyKxPDzCMyQTrWzjmNxKxrbFlt3RL269XdAGYh6pqpfeLiBm2H+eft6r4W4BRfGMRy6cAPT5EKZm83H9CpqaY39YVaJflyhTbfjUknXf/fIWKOB6gk9lBtBB5JTWcYDu71/9w5SFNchkYo271II5rYkP1jGE66QEOjhF7s62Zgm/1X78+w3BbMTZHp6TShR1OVJCFmHKSzook8tRPTy+pLJGs2AtGm7ZVFProYynHkS88LSI41d5+uHubtuiCxPZpo+4OZ0rpnU35cih1L6Mve+CJTMBz6wNkztsANKoL07M0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XzrSMaJi5pghUHQJKBIvp4pI0AuXAHKaFg6HyvQyfY=;
 b=PToEDqljnRTjXSFIVJui1QamjPmqC1NkQsrQPljxgy+BQywQ9oEg0Su70KVlp0K4PIXUAw+fI0DwOGGqbmieFwHyyasKFGYcgGEeZTtZhjx/ArZqQdhaNdLIqb+HLeLMcH0JqeDR85BgMxcWUn8ZZrT1ky/PvnccTAsuvcBq/+1Vp0Y+1x+BVHWYQ0D7AUIK4lNgEYWiA1Mqcglv9AAfPFUXDm/VIrHBg6bKdMyfUs6SkFehE0w827rX/x8bnNJnTEQ4WAdNkGvuohyUu+TuavXKr9SWV/W5SAw5sZS/QFpKZttD5t71RJF7wZ0zrzCnEFdtZiwSZwaCfW5cTwRXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XzrSMaJi5pghUHQJKBIvp4pI0AuXAHKaFg6HyvQyfY=;
 b=U1TiSfIh0zk1DErmNKSqmyjHoViVPQQtWsgW46KBeyGYPdktHsjZVeMEfigjUP21EQNlr8Yb4oXgtXBDlzxFbw/DBWDaudcHb/XOLEeCO04Cv0Xc4lVSxR26To09dUx1wL8lI68yFAqXpgx99jmqTCVM0DyIR9hQpq7FRw6ODDg=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by MW3PR18MB3484.namprd18.prod.outlook.com (2603:10b6:303:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 8 Mar
 2024 13:08:32 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 13:08:32 +0000
From: Srujana Challa <schalla@marvell.com>
To: Srujana Challa <schalla@marvell.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [PATCH v4] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Topic: [PATCH v4] virtio-pci: correctly set virtio pci queue mem
 multiplier
Thread-Index: AQHaatqPnZXe+2W8vE6BG6MindQo6rEt3Z4A
Date: Fri, 8 Mar 2024 13:08:32 +0000
Message-ID: <DS0PR18MB5368803B59C5B6A45047BE20A0272@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240229064302.2183241-1-schalla@marvell.com>
In-Reply-To: <20240229064302.2183241-1-schalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|MW3PR18MB3484:EE_
x-ms-office365-filtering-correlation-id: f9893723-4c47-47a0-70e7-08dc3f70db10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1PB2IIplKnGyCURoDQYA1H9aEQy1DDCVIQaB0aLp2BAHpeJAhe/0X8LJkuDDan6W2KQtbMgyj4Y+DkLR6JapVSGs6GZ09T0ddTZ7zIy3y8gN+C229JtBz+Ce2nxwROWxOarJSr/zHPhn/S8RugxuraBb6vVgyrnciHoWX/WFObbBvkt7XXxHbyWrQHFED1lGTmFt2xT25KH1AknfzYE9d8cdIOCoZliaH8ByOKkXjMWwkTxbnuQA4XO6febxWXUzjeJbbr49XCzTu5FAgHH8RjH5xYbe4gI3uFVA0R/QEGJOtZqtaOuRxPYGuXoyjzSIBaPrt7KznCVOGoeQPHJGsMpgySJuzK6IH9uZvAifKFkrhmUO9VzT25PY2Nvs78si5hW66zCDH5WJEINEXkJOaFdDFl8GCQ4xraf1qIUoq+AVpkjbSJOuvAjfCB2GaO7Ei62yeEMAhmR1gm46E3BRTFHqiTR5kYGYoFVBDGthaosBDwi6cQx4JDpxWYiZyFgPRFM2B92vmty79oeNLMrw4GknfAyn7vSqJb3w1Lvw5uxwVItm+WYsoV/wQaGfcHSr1MnvDFvXwBiqfCHXT3Qr9AvryQISd42eQyxs0u67kueOAS4qWq0SGvqM1yAEOh8lo0JK8+/WoZSaqNHvIx+NYyC7miLwEQkFsEEPy2u+zIKSXvQX5h/ljx1WIkEqEGK3CpzFA4GeOeJKXXRrwqi1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5368.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hS57JyG7nlld80zzjpr2BDOLeidcM7xbO3r2g0uFF19yPKIAiT4dlqU+odc1?=
 =?us-ascii?Q?+88fD+011O1nNwplbWhVJRKx+Q44E9WhCFsQYYWUQcHtN+W1KURlOgEEkr7z?=
 =?us-ascii?Q?WJ/tkYn6CUK3uzvSWVe2D4QrttSzR/BaOg/NQxZZi6hmqu+rflWlJ8xDu3mI?=
 =?us-ascii?Q?laXEdVVYMgJiR8FFcq8Fo+EWVysU8jmazpwD5ZIgTPWotqzbhCJ/w9HilEmo?=
 =?us-ascii?Q?43VVGBSQo4a7erNLxENtkVp51bqerRs9DHGbfbsKEY8Ps0h6Ryvc4ijEZH6U?=
 =?us-ascii?Q?KtM1aF7AmvML7Qm35wQr9qPsVWeE8z3HZ2cuALgTkz7nEX6ODBBUZDtxcnFF?=
 =?us-ascii?Q?KAb032S9mjm51yilmC65AWd6ONUNpa0AzKGPykNefpZEyNSlXvzXNlKQgNwU?=
 =?us-ascii?Q?aptkPXTXxVX5GlvmJOw03R+fhOIe8OnGKQIqjkQqTdbqDFIA82hwsJgeWlQ4?=
 =?us-ascii?Q?328DlawBgpiaiNVszTQICjSIo57uiTqF+8bV+9Vfxbw0jrKO4+CXhihgIoVF?=
 =?us-ascii?Q?xSjLN+SSQ3B5U1yzN9ug04RczY4Onh1/Vc3l6rVZPURkfMykiQ9HoFrSt+Cg?=
 =?us-ascii?Q?TJwB7ze1yp+zPjioKIOC8BFj4Zn8PJS7n/uJnlspq22fERVaKeY+gzOxKZIe?=
 =?us-ascii?Q?nqWquBF4n2bbn0tePGRf1PGBMco0AG/N2jENE7pKOwrzL7AAvSKCv8rkP01M?=
 =?us-ascii?Q?RpYGCt5Nh1P38neOQVh3/1tiLmvhgrZI7BEzKNgBlXX8LXVxhM5JXjD8uItn?=
 =?us-ascii?Q?itR3p1TFFvv+a/oWKS9x5HsY2tGl8wImLybdL0fMm1XwPijaBpsP4joJxLAI?=
 =?us-ascii?Q?u9FKkniOHvmSERUDCV1SQSiDgLzG3zuxAuB/5s3Lff/47xWt5n6K6+lVntlN?=
 =?us-ascii?Q?nCm7q6V6bsgsd3bqvSs9HmXexZUGVPgbKsOJRS3l2FGe0d1spI0V9zkeP7lL?=
 =?us-ascii?Q?6h7wEo+tNT2dg5R9bgDIOTOujk8b30TLmUdc7xsdk6J0YCUnCbBSJtgI6u5P?=
 =?us-ascii?Q?9CvDJuogJ9T1spnCgvkuguAhzXrL0uICpCHfAiRJQCVgQt6PzNbOwh6NLnWS?=
 =?us-ascii?Q?oqYJCTpU2k0cPbTyE8+1wbgBm3sTGfF0fFxBGy9ZHSCDuXgIhI56EGezkf/T?=
 =?us-ascii?Q?47w4wkSwf9pi8AciVsnM4AGseFqDJKzXsS0f1Fdgt34+mCxcU2PqXRj9lYsx?=
 =?us-ascii?Q?OWG2gKX+zn56bq1k/Z1WMFE9oMMd0TZIPWliFI3AhN3JYK9SMjtqh/45xLyx?=
 =?us-ascii?Q?mRgIYppwOflWhQ+pcrcOcVLA9rvKaRjVa3ieuzv64+295kXQ1gDwl8vg/13n?=
 =?us-ascii?Q?Bxn+ztfnPg32i+vZlm6eYLVhoghKTLzA2jmexreJICiC/b8KQOIPWUqqd/KK?=
 =?us-ascii?Q?GV1JJByAcAy6eaybx4sf+jg0GHzdhQTVj2Nh6zyWqGDkbmfShZeLA328TWOW?=
 =?us-ascii?Q?Ud7bvV/lhnSNczC/QlxEGzmo8Dozwh62JVDKN8PPnraA/H5sQBFqPf30/sKX?=
 =?us-ascii?Q?ZtHp87pfB1E+vEXv6lae1TyZKeRhK+Jv2Hse5RCody4+pv8SjdpBXBGQb6J4?=
 =?us-ascii?Q?I9TJHwyJZa+h5i3OgSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9893723-4c47-47a0-70e7-08dc3f70db10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 13:08:32.3922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OI5TjOOqbI6eRDzwp/MS7YdEvRZzMENmDMBPU95wtYp8uDf9oG/NEf5aDLnE1PP/DUDPjenso2uznd2/qmyuQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3484
X-Proofpoint-GUID: cy1IWGI60wotsi2dESqhxWVqL0WLARp8
X-Proofpoint-ORIG-GUID: cy1IWGI60wotsi2dESqhxWVqL0WLARp8
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

Ping.

> -----Original Message-----
> From: Srujana Challa <schalla@marvell.com>
> Sent: Thursday, February 29, 2024 12:13 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; jasowang@redhat.com; Vamsi Krishna Attunuru
> <vattunuru@marvell.com>; Jerin Jacob <jerinj@marvell.com>; Srujana Challa
> <schalla@marvell.com>
> Subject: [PATCH v4] virtio-pci: correctly set virtio pci queue mem multip=
lier
>=20
> Currently, virtio_pci_queue_mem_mult function always returns 4K when
> VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't work for vhost vdpa
> when host has page size other than 4K.
> This patch introduces a new property(page-per-vdpa-vq) for vdpa use case =
to
> fix the same.
>=20
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
> v3->v4:
> - Return failure if both page_per_vq and host_page_per_vq are set.
>=20
> v2->v3:
> - Modified property name, page-per-vdpa-vq to host-page-per-vq.
>=20
> v1->v2:
> - Introduced a new property to get virtqueue mem multiplier for
>   vdpa use case.
>=20
>  hw/virtio/virtio-pci.c         | 18 ++++++++++++++++--
>  include/hw/virtio/virtio-pci.h |  5 +++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c index
> 1a7039fb0c..4e31169c6f 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -320,8 +320,12 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState
> *d)
>=20
>  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy=
)  {
> -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> +    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
> +        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
> +    else if (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
> +        return qemu_real_host_page_size();
> +    else
> +        return 4;
>  }
>=20
>  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *no=
tifier,
> @@ -2108,6 +2112,14 @@ static void virtio_pci_realize(PCIDevice *pci_dev,
> Error **errp)
>          proxy->flags &=3D ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
>      }
>=20
> +    if ((proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) &&
> +        (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)) {
> +        error_setg(errp, "device cannot work with both page-per-vq and"
> +                   " host-page-per-vq at the same time");
> +        error_append_hint(errp, "Set either page-per-vq or host-page-per=
-
> vq\n");
> +        return;
> +    }
> +
>      /*
>       * virtio pci bar layout used by default.
>       * subclasses can re-arrange things if needed.
> @@ -2301,6 +2313,8 @@ static Property virtio_pci_properties[] =3D {
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_AER_BIT, false),
> +    DEFINE_PROP_BIT("host-page-per-vq", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pc=
i.h index
> 59d88018c1..81b6de4291 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -43,6 +43,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>      VIRTIO_PCI_FLAG_AER_BIT,
>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> +    VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT,
>  };
>=20
>  /* Need to activate work-arounds for buggy guests at vmstate load. */ @@=
 -
> 89,6 +90,10 @@ enum {  #define VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
>    (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
>=20
> +/* page per vdpa vq flag to be used for vhost vdpa backends */ #define
> +VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ \
> +    (1 << VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ_BIT)
> +
>  typedef struct {
>      MSIMessage msg;
>      int virq;
> --
> 2.25.1


