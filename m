Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64C0C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhodt-0001Wg-NG; Wed, 06 Mar 2024 05:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhodr-0001WC-3c; Wed, 06 Mar 2024 05:36:55 -0500
Received: from mail-dm6nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::629]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhodo-0002Ia-GC; Wed, 06 Mar 2024 05:36:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJqVOT8p5DWwesO2bt+Q2XfxH1WTFYpzcAOX1AG//c1SXYqaAxkTzfat8jC93Ru7ThLLgjlOiY5Du7yLa25Vz5kMGuaW/UlWtmzqfddhL0wJ89rMDNOHbdwSnwvDoOqlN4vN9I1PQbEGQ8VbSKFkVWnDjENN1cdR2b3CDfTlH8chI/N1V5CRKTd1Z8zE/te9jCohYdd0xielwgS3Eie/TPqPYKhO89/4gw7fN3DUZhY/0NOm1IooUzB/JR0AlIg2DTm8DVCE+H05naZwlZkOd5+Tv30c0X1nGcJpnHR7/k0xAOCGmo2aXrhUaCgtDAXMm0b0gmpr0SwZQ3hTzxwFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFQeGSGZu4UXXEoM3uYYdZEfvntKxVWWXg9mHPDQHNA=;
 b=e07zFR6wQew0zD1YJp0Zdj2xg/Vp8ykalDxFU3KWhA653TT5XzxvX3Sv2DR+GdaTPTIjfljZKdXxQ2Gs1nD6K4Eug+eTpBCfFQZ3D7RSadye8KlHNtmcMaQYztPk7oxweWnkqglSo8gG7+Xv0+TDdVkxjax23cBv1dNZtijOvVqeNNSXcYIeiaYWvuowRNpmgRDUvz8o9RgreqDYAea5JP4loi2bNt06bR4yYR1H8feF4SJHG2FXJx1D5+FybW+niNB3k9OK1anqd+hK/7aYCjHwv3bEZhaEEQLWMxPdgIH95Uty0qHBJYRv/D04SxOIP3Y6mBlkWrbIydDzAG29Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFQeGSGZu4UXXEoM3uYYdZEfvntKxVWWXg9mHPDQHNA=;
 b=kKCOytDHfLnM+ECJqLWTpzLku0Bz1o0GWJs6JQzN76CdNr+50S0gi+BHQkOgJ0PBWlyaoGA9Q65PeAGbQ+2ACmLz0J75tvCkdQ69qgBDFseookoFeZCKc7IZfVvRSC0d5il4ps6xlWe/G9bN+CXvli0Ak1WWfRt5JkptMOwms+ikx3z4/jmMiETjj0rz4GGST49SDM6xCeE6TDy47HGfAVGKqOlAXVh5h6Fpuy+9Yokfclyg2/LNN+uldNYeJynF8Ov2qTcNwxOsuLCVMaRq5w+OVVFB67pTu1Ax5SlNsCzHt4LcRbt2iSy3YeeYvmtrzx77apD4yZpC8LkPZ6/KSg==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 10:36:47 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Wed, 6 Mar 2024
 10:36:47 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgAvebIGAAP3/AIAA4XGY
Date: Wed, 6 Mar 2024 10:36:47 +0000
Message-ID: <SA1PR12MB7199C9CF71F6C46131346B52B0212@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240305140630.5a3dd69b.alex.williamson@redhat.com>
In-Reply-To: <20240305140630.5a3dd69b.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MW4PR12MB6997:EE_
x-ms-office365-filtering-correlation-id: 865c03d7-d8b4-47cb-271c-08dc3dc9531b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RfI1jXXeFVBaTJ68NhQJH6U43y0PN7Cd+tYJNg4FJF9aFVASfgY0s+vHVSYUuxvkln30Y8TwLgze7F4PvhejhUnR+WteEYt4xPOoZfkD2BNEzd4l0TwsQ9iVpQwBz09dKIxEV7+XyP25T7qSvV9a+SpD0Lkdnvr8G8he1IJKjk1IyyEtG7R9BrscsxR7fmd6VzXjLCz+hHfc/WF571dQGj/85CkY6Ie7Ax6+7ALG2Z/tiUSX48hCTK0hGt8cyRq3HtIEDp4leTpxUEnhUWjOQvIPNRteK730cTysFBCQUAq5QQXmZmCsjgWuiZv9NEi8tDjhbyZGpn5ybjAQYc3Ase+te/6ch7hY6MHovKIBxm4GW4IO2vqr0XN7d1sfVAAO0D5yZ+CEFhFgHeOtiDZDuOT1hae3gZ4xY5EY0dvfweOSqmEbDD2WEqUtksQ/XFz6dhLso/0TuYr69rzEL51RN5UgcailP5ljmnkzO8gWFQdISMCLAVUa7v/1WeVR1a8eUw1PbmT0AIXHE/gBXSNm+OXbPtmAMr4j/hbW7esWgz9uFvlqNhYsZzZDsvhyrQTEb5uyTHsPafMqSB6S0KHxtXjm7PKDC88j5dyCuIpg8VxaAuzOKSl0dkEiVwydD3hI+t1s6GQUe3xX0b1v/FxTxlcK53bJF5Qp0uOyWOGEAf98Q18lUmTnVRYFgwiJ6IktLSCqZTu8cKrw8utmobqELA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OabUUYOnBcWmowUZ7C68lzE5RnvA96SlsE1HV0I6EVRmuWMUt5hn/l3YjR?=
 =?iso-8859-1?Q?Wx0YoHGQ5Fyl/NBfM009ithZPTpv2rZIK0cD1HkVxfk9vGYRlTjy+lC4sm?=
 =?iso-8859-1?Q?CZgB2X6i/qzM5mAcMcvskQH9IiBSNYbW4Rdql3iRjjk6c9c+cG55lH7+wv?=
 =?iso-8859-1?Q?nbvKOVKMV8ogSslwbKIX1t8mmFGFN70ztoBQr+TW/iOyQ7tW2tD8y40KBD?=
 =?iso-8859-1?Q?s2gnoQsEwX2GUi3MeYLhl/TRacNWv69og0j/WUGHkttZ/WCkTX+p5dhAGX?=
 =?iso-8859-1?Q?rDjEQC8I7Z6kEFU9ZXGfbEQ8mf0XCa5+g6fTAEPsauiMOr1ITwJLjSFjmc?=
 =?iso-8859-1?Q?+jHmGfjixWD/xzUvTGw8taVrXAwjkDJNi3fnVEFLUbgE3Ukf/7TeyWqVNp?=
 =?iso-8859-1?Q?MakAAVYjdbmGEwhlqj1hM+tZrAZQIqk/ZR+PeKBfGkcxm7lLODd8EBgWIk?=
 =?iso-8859-1?Q?SItRyc18H5cXKcjqm62L7TyqLy49S/FwSVle8Dcd1HZxFRnV9rW/GjeWz/?=
 =?iso-8859-1?Q?RvoxDJ6H6TWsXhNA2ncvXt+Nm55pB5v6H9Ajf/pmwu+MSVY2cM0+TKFoSW?=
 =?iso-8859-1?Q?qevojjBqUKk04JxqQT6AEVzQhfuVHiM7sfRiGWV6a3D1Mxt17OXkE1cAoI?=
 =?iso-8859-1?Q?XkihFOnFyIffLR680rx2tk68JWt7+B8F9FfyjV6Y2Wy9exQ15WQCXdSFUR?=
 =?iso-8859-1?Q?2jVzFX0rWV080FHNWxVbdY/x+Ar5z5B5WITh4em3GXHzqKGHdJrFe2dRUf?=
 =?iso-8859-1?Q?Xc7R0l7eKy5GEDFjakZiSgsj+5xX5g/yQGFJWdp2JPXnZ5wZVgFyvkezqX?=
 =?iso-8859-1?Q?PVLCCcRxfnDAaOl/ICVowYvwb336hldc16IE98UsurxfaGvv52COxHxYAu?=
 =?iso-8859-1?Q?Zw5DYfWgrQLhEbuxzCQIVROq65Ep6Nw2TrB+2VnHhUHKkH9h+67+YJHGOx?=
 =?iso-8859-1?Q?L8HS9KJAboXzJQoybvuOqA5MSgWjvPQFAAcGlUtnEzSdl1zgfIdV0I1BNl?=
 =?iso-8859-1?Q?4V4gQVVfT9D6rQRmo7s34o8f1apjCEdyGGInP0THguznVQEnu2SqOcUVPH?=
 =?iso-8859-1?Q?QKfgDTCBZTv87x89zigNUqr0y9ogLndlMuWAMm5zhIz9HK9fOYhRpLhYZv?=
 =?iso-8859-1?Q?XS0qMYc22Hk2/5+JwmodcjPHWWU+1GAkcFqe9LGBvCc52MBsiQULQ2FcJh?=
 =?iso-8859-1?Q?+CjWHuFknoJfCDRsWmiPoxlylkgPHbBBI8U+Aqs837t59lRWQ1M+vntSwk?=
 =?iso-8859-1?Q?GcKtusVpOoWeqypq44lymLyJO0Fdr/gQF0ytBX1hmEWi00WnbcFvQVo0df?=
 =?iso-8859-1?Q?WppxqYXbQEr1ux4L6NWe/O39fV+eBkGqcLOi1re+mUrBF0lhLXvVGoLLH5?=
 =?iso-8859-1?Q?wM8uCb3iMHz6t9mP9BciLnHMYRkVCBHlbXfDPWDge5lNtDl+QIB/WcHJAr?=
 =?iso-8859-1?Q?+1RJXeXsG5STUcL6exwj2EFmAAIe8IFwDEWtsZwpQlx4fGot0l7i7YajPg?=
 =?iso-8859-1?Q?ck08d+ZYLns/8RZow4PSfvmEjyc4NfXO6+xbwAq4ekzZ3JPqlgXBbRYLdH?=
 =?iso-8859-1?Q?G+LaC4MmGckw0Aae/Rj4bFp7aHyKO7vtrc9bxokCtZxgPyePvkJsEFY9E8?=
 =?iso-8859-1?Q?MOgA873VlRYYM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865c03d7-d8b4-47cb-271c-08dc3dc9531b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 10:36:47.1027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6omIjJcvRGezpN56N8fCjKi52o6a5Gc1sfnyYIbOd/Uh8BRht+l4AZImSTTlJk0+wNIzx4Vq5G7lsvAKElonaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
Received-SPF: softfail client-ip=2a01:111:f400:7e88::629;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>>=0A=
>> Jonathan, Alex, do you know how we may add tests that is dependent=0A=
>> on the vfio-pci device?=0A=
>>=0A=
>=0A=
> As Jonathan notes, we've decoupled this from vfio-pci, the pci-dev=3D arg=
=0A=
> can point to any PCI device.=A0 For example, any emulated PCI NIC could=
=0A=
> be a stand-in for the vfio-pci device used in practice.=A0 Thanks,=0A=
=0A=
Yeah, -device virtio-rng-pci could be used as suggested by Jonathan.=

