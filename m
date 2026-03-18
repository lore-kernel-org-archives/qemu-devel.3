Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2093010854DF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nYr-0006sl-Mg; Wed, 18 Mar 2026 05:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2nYl-0006oC-U9; Wed, 18 Mar 2026 05:51:30 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2nYj-0008JN-V8; Wed, 18 Mar 2026 05:51:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ1S7DZfETcFD3UIq4cS7axsS9+uol3GhKDqwHZm2dbPIW0f5bbOyCs0DxOFv7whOIErM00/eG+mz6Pmw8tqnJTJe8C3V6E+HeLWCSLSMbkTn39hoWY1RrgD2q1MAN4hc3xiMbvy9FCGJnyOa/SPPb5lUzOW/b28eL8T9YwZpY6F/GZ5tPpW/PQ5rgsBcRA/+R0CfZaCQQ3iZ6l1/BJSrG+/EezJvRLodmmGhcqmVDqWJkzbDadptW7ejDUjBS52QYlLe1ZxFmwNGKVcFZoN/J8no2IKse9aVA2hwoF68KW3z1wjJ6VZ6r2otj3yn/6fmaxUrfQpIOYwxFfaio3ZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e45tOubEV1Nm3ciW1PyqLWvGd5stQHFAWx1VUL5gJks=;
 b=uHjyfI536rpzvOr0x8d2SIDQYHoRnnv2fF6r9VY8mYKj/0PXpvS28D7uzSHuZrM6Qh8LjUtYlVYglpYgt24meOMMcRfSz3p9B5Ql4ZXh0Vfq4op588Z2kVP1eskHKT9Na5UW/cVqpO4IP4a81BIyjQJ1qiB3DspWt+qV5+/WLAwfhnkViugEKtnwXgt7suqE/41O6Nrice9GCJCS51b6SN/qcK6O43Yq/MjZO9X5I5XpGk/h1NnQE+QPI58+kDFsuaC0bhl8HbQOkPTHZo2CknEvwjL6LjzDMsOjr/5nFx+IXymGsVsSlifLgi614aWbaE/dsunq3LUsvLKbkV5vDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e45tOubEV1Nm3ciW1PyqLWvGd5stQHFAWx1VUL5gJks=;
 b=erKfbNxq7i7wKSsTnwd8bVL+Rsv3NTamo5hXNE97o1v6zLSyafq9OgJ7x/GhyYilIhLsgIole3mQ7iwNzh1hvs1nXi1NtSdQl3ENJjE/FnoB1iLKP+QLDjZOIl8gHCHA2VC4xpXgfr2vP3f+tp+beMNIq4MYSRj7HGQuma6lXB72Y0fSONDB69vEQcor7XA/szikG0KKMX+tXi6XBUUKCUBQEC5e1c8yoH0qLPK+BcHkdyISBYo+Nk/xtEMa3EB4CnEDQbYcsSgnk6DrnqcmoE6ZJvK1RSeBHpGvMkR06WWYomCo4K7Rh3tooDF6QKPEShhpiwHrtLut8E/rA63kag==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:51:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 09:51:19 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
Thread-Topic: [PATCH v3 7/8] hw/arm/smmuv3-accel: Change OAS property to
 OasMode
Thread-Index: AQHctj1H5Tr6dpomt02YpwDXaaDf6LW0DOTg
Date: Wed, 18 Mar 2026 09:51:19 +0000
Message-ID: <CH3PR12MB75483F53015873AA0497F3DFAB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-8-nathanc@nvidia.com>
In-Reply-To: <20260317183755.3721625-8-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV2PR12MB5944:EE_
x-ms-office365-filtering-correlation-id: d6def2e5-8bc5-46fa-e5e9-08de84d3e794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|7053199007|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: WXM2vki4Wf5PBDaImehTOudM7hD3fIgkjpBY8SAlgQSo1iBUUTjh6umnqZ1wVjdW6fzxWEQRgF5fdU5HMl7jaQ3299fgxg3RtD8Ii6sSCkCO4JkEeet/JDUMoswQ3dAX5+WkyMsXFWNd210S8PNZpyWyczhcpRfXGZ0knbaK12UC7ndehhk1apF+g8XO80m0aNYxCz+N9Ym0NAegpTpDOmX6AjBqYIIP4w1YtXGQ0+Edu4BxzwF7PEtZLgk0vPB476wahEV/gT940wutJpX3vnBOwv35lu9y1hVwWEFA4YQ9pE6ijgE1Pvyc6AXeVjwz99QKYJtDBmTsgVvRxP+kiCmLtRzhZGQfscNAy8YyCvH/UYwe0EowEXPXtkJCuCnIkxm5SOvp/VR56+GpN/F/3XH+CQ5YC72eutHKnZ+CC4ucY7z8T5urbMZPwvjN4zol+7clxWZTEpstCdSYrg3ICrC0xPs18G/Y/l94SBOJNWsj3bilAlhJnT9eMtdBx6O5eMsy+bFG3KFPM0l0RSsqiMLajX3giYPbhpuhNIusrS3aVeEgeWNYASQkZN58I8GYX2gJ0J9dIA0PM3k+X0MXfWyb7zbrdQRG+F/a0UcpKbewLhwsYS2t2bgt3fa16n5mCiUat3GFJcbM6VNymMpByVQFZIxST9H1poINuSM6a0zv306G+JomUYrgJbVxPsSQmQCKR4h+ykD8YUYLEJI/9xe7xXon0yYWBOU9j6hpRY2cwCPvfl2M1EiLbaB3YdEU9ZeDt8cCrm4hKLAFIHjqPkrDcTEjIZ8wLPUGa116meE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3QlDGb3ohmv3iTwhtChf6ob9sRcjcPhJpuGEbgjTDZiTtaYoZ1ZGpuc/0P?=
 =?iso-8859-1?Q?iaC7PDe4OTWkmEAa0sGvcZ324SsG4EjkC/uDMy/U6uNLuRDbYN0F9AYLx3?=
 =?iso-8859-1?Q?fUPlTSaysMOcejzJNkTw5fWFIAHrQUcVu7zQXib9fy7+sk426IhE4CPEsN?=
 =?iso-8859-1?Q?EwtK7bCk9OLa63ZYXe3sz+DsWgsg9V63qZ5hVbJsNxWqzoKiGUsHblfJeG?=
 =?iso-8859-1?Q?2BRDhIuBKano2WjZNcH/r8MQ5F5Jhccs3+aCjXwq28qs0596LoJsNd9ZEJ?=
 =?iso-8859-1?Q?+5HPEYuCoa4VH790WXTUY/w1ZsFnxWCFxmza7sjMPBDWyvMe98vqao8h6y?=
 =?iso-8859-1?Q?OSOzS/YirsOV4hCXUfHBDUDXbBQ2P7p+9TtiYpf8ILuLGN+BN/88McQWOE?=
 =?iso-8859-1?Q?IPcqPkWyJJhGif8J5r9JgFlM38YRJWPm0hTWSXFcqol7XpliV0sHIKzORJ?=
 =?iso-8859-1?Q?9PQ9pHO/0WEivdWhcLT8IxvZbF+F7xMZ99z8RTkJuk7fXASrhlOUNdOr5j?=
 =?iso-8859-1?Q?oiU2KfYQZebz09rPtFOLCZ3xz+32WHIYat9tNYyxx7W8W1I8NBFHa+8iYX?=
 =?iso-8859-1?Q?lUtFEL6X7lBh/omYT+EiyrKcJNiLKnk7Yxa8BxZo/1FfYut9pJuIxIPcbZ?=
 =?iso-8859-1?Q?FP3ES8fegs5hBRED7k14ZdGrv0BYgcWT4KKCXKu70sWyr/Zr5aVdUwAw/i?=
 =?iso-8859-1?Q?OGxqMZoAnH1OfY5mbfxwlFmvGVCA+DQV5asrZ1sWAC807VZNm+mN6Kt/xd?=
 =?iso-8859-1?Q?u1vLQG4JlhVJqfVTuPVlgSXk9UVxevYSmAOWfDoj91CPJt2drGKhV24Kh1?=
 =?iso-8859-1?Q?VNsJoppBd8v1PcFGKU1++1+a4vyP85mFLqwW8lmPylPUUnM2ZOPPEIcLIM?=
 =?iso-8859-1?Q?HMOFbrE5Fnpcx6F3r0MQ6RMecvP/J2A2aWfo/EOjT+ZUHTgxUacBF31anY?=
 =?iso-8859-1?Q?avZC8SkWOIcjvsljPDeinwEyagqa1hovP7OtkEaUYBfwR/mQ+tTzOjfmkc?=
 =?iso-8859-1?Q?MKlLg5DfkIxtFDU1U9FPtNiRED8lVVqRcy95i5k/mp2gV8RzRpmeLXG/f2?=
 =?iso-8859-1?Q?/nhUePPY7mpdPVQPxXVXrdzZuMalI4TJEt4vJsjpqLqZG/GJRlmxeZPu1A?=
 =?iso-8859-1?Q?lK2Qaj+Ey5lxI1XLZHZzwdt2l/ngxmXFGdvdtKFUcv2uz5a9+9zEXRxjBS?=
 =?iso-8859-1?Q?dhPr8X0u0fT1jezB76zdBkD+C6sngkMYlTrGkhcUQ4fmZJdCHj6tAqLy+b?=
 =?iso-8859-1?Q?vW1B5RmH0jwCHh6cTTTfsaJ22PjZh5/u/fTW+iFYCm15evdmSw0O+RRAt/?=
 =?iso-8859-1?Q?5vizYpejRKuoNUaA6XxKEUvWLo8NAvrlMn/UEWJyDybo0wImBUeAGFy+5/?=
 =?iso-8859-1?Q?u8p2ej4dTYtP4c2To/QMX6TLPe4eDDHIbKJgWlVxnuz52yYzP7M69pdee6?=
 =?iso-8859-1?Q?DaU367aIfXBuooyrqEyYwluPnoS1CiJIYtTHw90JkdqCscWCMySk/X3XAA?=
 =?iso-8859-1?Q?tL+bN45FPSet9bdM7jZnYKLpfYjPBrDHLl0BBQfeQgHv6gi8VrTVfr7DWZ?=
 =?iso-8859-1?Q?pDS/G6fX0+I/dMNANEtcsHj4gb3tlbKoKdRhnBwgEK6ukxFDcbktXgjMtV?=
 =?iso-8859-1?Q?m6aZ08YkJRaK3QZoUb3SBnf0y58UkRDqZVr7ZUfWp/SVAX4iQa5plN5qPl?=
 =?iso-8859-1?Q?sWbYzL5bGbuoKwO6xTNBQx0dytD/qDeIyaEUZAGlHoXry3zi5AvI4Mn0bJ?=
 =?iso-8859-1?Q?ZIfKSI7z1p1fJsz9p3KB5Lf2EYhKpPv37lVTVhwRikhA0YO3zUDJar1A/V?=
 =?iso-8859-1?Q?IsMhcUDPqw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6def2e5-8bc5-46fa-e5e9-08de84d3e794
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 09:51:19.0995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXN4Tpp76S5udT6v+1K3TlgX2JPB68CY9RwgmeQTFwI3zv/+hRLkgdLsmPCAr4FWEHzQUtJ0STpKx4Lc9vH/DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 17 March 2026 18:38
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Shannon Zhao <shannon.zhaosl@gmail.com>;
> Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
> <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v3 7/8] hw/arm/smmuv3-accel: Change OAS property to
> OasMode
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 OAS property from uint8_t to OasMode. The
> 'auto' value is not implemented, as this commit is meant to
> set the property to the correct type and avoid breaking JSON/QMP
> when the auto mode is introduced. A future patch will implement
> resolution of 'auto' value to match the host SMMUv3 OAS value.
>=20
> Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS
> bits")
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 2 +-
>  hw/arm/smmuv3.c         | 6 +++---
>  include/hw/arm/smmuv3.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index c90fa9f5bb..08a4e2a1c8 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      }
>=20
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits).=
 */
> -    if (s->oas =3D=3D SMMU_OAS_48BIT) {
> +    if (s->oas =3D=3D OAS_MODE_48) {
>          s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48)=
;
>      }
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e7fec7a69e..5b85247606 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1981,7 +1981,7 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ats can only be enabled if accel=3Don");
>              return false;
>          }
> -        if (s->oas !=3D SMMU_OAS_44BIT) {
> +        if (s->oas > OAS_MODE_44) {
>              error_setg(errp, "OAS must be 44 bits when accel=3Doff");
>              return false;
>          }
> @@ -2014,7 +2014,7 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>=20
> -    if (s->oas !=3D SMMU_OAS_44BIT && s->oas !=3D SMMU_OAS_48BIT) {
> +    if (s->oas !=3D OAS_MODE_44 && s->oas !=3D OAS_MODE_48) {

Same here. We can get rid of SMMU_OAS_44BIT/_48BIT defines.

Thanks,
Shameer

>          error_setg(errp, "OAS can only be set to 44 or 48 bits");
>          return false;
>      }
> @@ -2145,7 +2145,7 @@ static const Property smmuv3_properties[] =3D {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril,
> ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
> ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_0),
>  };
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ddf472493d..82f18eb090 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -72,7 +72,7 @@ struct SMMUv3State {
>      Error *migration_blocker;
>      OnOffAuto ril;
>      OnOffAuto ats;
> -    uint8_t oas;
> +    OasMode oas;
>      SsidSizeMode ssidsize;
>  };
>=20
> --
> 2.43.0


