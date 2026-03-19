Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF51C1075274
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38VB-0002w9-7T; Thu, 19 Mar 2026 04:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38V9-0002vv-1f; Thu, 19 Mar 2026 04:13:07 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38V7-0003xx-Da; Thu, 19 Mar 2026 04:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OE61w3U/cNy78OQJTNAjUGbH98zgcsoiMDsmx9QuxCb49efHp8GcPhKu6dPUszX5ZGqEHVKAqHe+ueK5V+yVOGJlz5RIBmKAelgFh0h8JCnFeC7pd0Mco9BXnGcrO+Hyv19+YuLMizeyrQKa5AWoMfH8fXB9k5rrq+HWpDAxITadqCF2gz5UPTzVeeJ3V8DlD1u9bdV08fQz2gbgOK1aIaZFVygU1wwfrj0hRB1fvuSENSVSHrc5yFEdtx2uX9J0ue212clWjioHs3Ot3ZKJQn5d23IIxQGIg1wFD/KRt1j2hVgUX39pBe/jr6XLVQLxTUHeVQdVY9nBzYT9pGK9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYNK329Eeoe7RkionsC6tcH3wx9IgdLryCRWBklwiPE=;
 b=IJOz/W/N2fORsLxRTqERXUpy6cr8blmMDJAbFT0o/5czupzH2Cz9IAxGEPY5sn9ywdFu4mZ3egH0yQYLzCjUALiqnD3qHfEJwsR8POmMhyk6N8y4zHQ5P3UI1v4IEREWjHe8RsGIL9vSQegloo81kz9FBj7UxYY1pMz5jJiMAQO4MLSGhAnMlCNU96wEgCp+VbV0ebswAoMXSYC2Ax7UCoergbCCjlNvReWWuZhsJb8tlfYvZYYCfQSC/0klXOjY8u4tVhk+b1yZWNnXhZmlSZ+nExXDMycJEqNbJ+psU4TVsINdyikyg7ZBqVRjwvA6PSLNuEpbliC4XKt+/ZFgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYNK329Eeoe7RkionsC6tcH3wx9IgdLryCRWBklwiPE=;
 b=rgKFHVAw03kVzb1QmL9w6cja4Yb36SqwBPHbZDM2Ioo0wucikE/DTs2yAsZ5spipiNr569gWa5j1YG7BiepOt89+ocI3KYqyQW0GUgMGBor9rdjXlLxvLazYSIMSYpeeJxEwbRzdBQXnApHqApkuqX/6LdEu2Ne2R6Ktms7HZFhBckL14ND4mdNwzuOxTefM6r4BB3Clz5TMMSwObQoVHdjnB3hpK/hZ6MGP2FIUFd+epEKmEOgD/jvyyL9eYysKz+khVAWlB/D3VRTXVoTxNu1jwyX/wiE0M7pMo9wfiOt57F4qtZxDq95WzI1PeZ7cjYOuKFMthxFFZNmLKRk+4g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 08:12:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:12:59 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 3/8] hw/arm/smmuv3-accel: Change RIL property to
 OnOffAuto
Thread-Topic: [PATCH v4 3/8] hw/arm/smmuv3-accel: Change RIL property to
 OnOffAuto
Thread-Index: AQHctwf50PVyy9d/CkiILWEdR/PJZ7W1gkKQ
Date: Thu, 19 Mar 2026 08:12:59 +0000
Message-ID: <CH3PR12MB754845A4E34DE70EFC027DC2AB4FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-4-nathanc@nvidia.com>
In-Reply-To: <20260318184907.4060030-4-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4069:EE_
x-ms-office365-filtering-correlation-id: 583ee7f0-a2c2-4b80-63c7-08de858f55b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|7053199007|56012099003;
x-microsoft-antispam-message-info: jziwZLZ7ADJwJNyL8mfItJ+GEBQ5DxjEotyxHk3hD4eZVQN2s1Bsl+ZGNGWykjToJXmHb/f2btFZAc/xNeE9LTE0oQBN1xtFTL7N4TvXAC/YNiG840ovC2yO6aTVdLeWqh9uNOMFuk7/3bWv1Wwgc6EPGr6cU4bMLDMrMwnptPL8TqfgpNUM3C0I0HyLMsatgEPxb6HoZGapW74QqaNK8cX4RiM4zTKTglMC4V8aUc4Eq+rQ4HLXyZ4qseMx+UowcnMu/7CPW53tD6yFAjOnbXAblReY8J/JkfdrFK42eFRq6SdsNt0PBvLw8HCkkrMhHnaox4A53mvwRpoMwgIXajaMG8WYikF6DF0+Hvv0OReZa7/bCBIcdflOnu3d5XpDx27/edeJcPb+TRvLImmyfrlcz42gFLJvNhzlHpaiYaXX0gPOnb6MDBNN5zsunbiQ0y54fGhE8dA0T/65vIjReQrt30o0ga1wReXXuyQEN57F55/ahTnciz6LVKNWQC5wXPOxM8f4e+pB403iNyRMo9zvO5rOAAIAXsfbOeBZNzxIGoqNOdk93HgFAUkBElL2EPyvqNWxn3PdRtHZj5Zskx9/T1UwnV5qDZ/Z2uo4Fg1rYmnFz3RHRi5FAocl+ujvt37pL+9XOR/YIuw4OWd6LFl/V1eFjszd5vsZPRwgR5znfjtTeSo/wTtlFi07TwASgGkvp7SMa7SaHlg9PJGPjeiWivbsgq9bEcN6BfFp+9AZaBFx9Sm2muVGQlEulFTuIvWBZ+ctSctAtuFQKYFf28Z3AcUk4Sxr6Hbe81csgZs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(7053199007)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I5R3dXn/rBgVWGQ6un3zuPKqzQ7W9U5UHylBLhuJE3Awt670+IpUVaOyuT?=
 =?iso-8859-1?Q?gtRyp/nhcYa/T7C0ZTq0Nbse+xWU8r48fPiANhwFgWqViyEqvaWHfbjAcy?=
 =?iso-8859-1?Q?2DHVpMxZG/vLPNPg1gt7739g5lmwc8qKenZrZrbG0LXJ4wcGFSca/Bbnzx?=
 =?iso-8859-1?Q?t+50DGVAyc3ZQWOVVJTh2FxCVoGexv4VYatYlv/+JmOmhDfxjrK51G56fm?=
 =?iso-8859-1?Q?23gIlKz51+euW8+xDL8RmQ+YOEscCDoJIXgi0qXNnzhqr0R2RGIAIrXRIO?=
 =?iso-8859-1?Q?bENs42BZgyyqunNc5EHElpMYbqzF5Vn1E13vk165saTPFsq2/bXFzhavfh?=
 =?iso-8859-1?Q?KinIi1S+Z+Zgw1iYm0Wlk8CRd2plQOfPxC4FLJGdDpD5ajHw7O3jfF2FLz?=
 =?iso-8859-1?Q?F7VaXlFXVslL3LHgjadFdHEYWzVJKeHqG1U0DWFWy4ocXVQjJaxc3eLJz5?=
 =?iso-8859-1?Q?wJXKzIbgAlNer8E4pz9BLMLiMC0ZXbjrdwP/W4gjpFvzQ8Z6yYFo0Dw1JE?=
 =?iso-8859-1?Q?wb2MB6Vyk/PKsckXHSRCDKNMbBahfy3y2FziT/YFpXsjIFpchW28VZ0DRx?=
 =?iso-8859-1?Q?prEzRfaoZjZb22yDyVXfkKUWta0pS8v6eVXR3v979nhcmj55WvDbsGFqIX?=
 =?iso-8859-1?Q?q83Dd5589zQL9sOxRHG5VA3Au5oM8TTqh2fNGdnJNE3wuOCkt7vZsLAwWi?=
 =?iso-8859-1?Q?r9n9RXs8/A7PrEaUutjf9+qBx4Ndd816FzyZeFv8cVF3W0d+ZFymX8+WKj?=
 =?iso-8859-1?Q?4iyFIFW6w68uMlgxmYjanXRUIXXtYP8odWJ5kWsMfRKRc4Q5Rnho42gBu2?=
 =?iso-8859-1?Q?kTFU5JLfkAyIkPqJ2QWSylWTdu1n5bBl4+U8oIqFOz9WoCvABAgux/5Quf?=
 =?iso-8859-1?Q?MrfbF1yPshhvFiQfIQtAHLgAT1R3efhzZo7Fh9vpjWLtxrKzzIZdTCI/Kn?=
 =?iso-8859-1?Q?jv81RigSUfUxVinvqCtSSSY4jZxQGhARI0wUi9o6Bf5prXS6xFDkZn1bv1?=
 =?iso-8859-1?Q?JyzqBMCrJRSAIbvTp2VVuajAHzqGYZZ+h0m1hFp2jKd7z9N9IPcpBaqK9H?=
 =?iso-8859-1?Q?qTH/LW6CcHKICcmqq21BaAHfj3oHnpoVMNW6fbjK76BZve1booz4uD1WFx?=
 =?iso-8859-1?Q?wTsR/BAnce3zSF5gp/P59gXLduxyXRIXfQbMsSJA9Y4cGpvZfD9Ier29f8?=
 =?iso-8859-1?Q?xdI65E5aW9uhKWphVAfpIUBczZjL/xYfkeOT2jhOslEjLaBIU6e8X7WFTZ?=
 =?iso-8859-1?Q?R84+tADfw5lk+bLE/auK7e8LWFlfYPnhc/NUY3hx4ySv/hD8AFUFR4vBmp?=
 =?iso-8859-1?Q?8DEH0YeczvmXP8jeUe1x89jbiQJnxg0OCEoczJ4byVQjX+UKXMpK7/oBzq?=
 =?iso-8859-1?Q?5EXGK32hqLXVRXW7AkMFFUofjhtYLD1+oqxbcJfQ6ytxwr2URyMPD2xmYG?=
 =?iso-8859-1?Q?pwC8yuYT03vIvq6evyeTa1aELsdEEH0jSoByV5hZbQQJzHo+Bv7UVmEj9A?=
 =?iso-8859-1?Q?LgxEM+mj7a2TxX554Ie8C0VDuncIwLWprNdzAqe21ofn9rc68hqiMMQbrz?=
 =?iso-8859-1?Q?eFPzKZVkOuMILhImJSQ1oaTjcJT3xCRKG4cs9xUNLapo31hna1Ie2222aP?=
 =?iso-8859-1?Q?yL6Chxb+KFFCeGAVpELp/nnGDEBz/KK2n9EYUqKyA4Wh35zHooASlUv8kI?=
 =?iso-8859-1?Q?bFdsOiy+GnQycqjpPCpV5B3Ukbjj+w0IfzFjgXr65hZciJCa4fPCuSbfT+?=
 =?iso-8859-1?Q?60CXkZ+v2+ji43+ubpMqG0zYojIV2bAar74gc6iFn6j2mNZfiSCrX41yYM?=
 =?iso-8859-1?Q?k/hegLSoBQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583ee7f0-a2c2-4b80-63c7-08de858f55b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:12:59.6859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHuRK8IlHqNbN1++cAJHFTqAq/7eYbhYHz0QkDNld5osQOXS6JTohOBCD6oXWhJ8J2Q5RiKkj0CAjSpZUO8Kxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> Sent: 18 March 2026 18:49
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Michael S . Tsirkin <mst@redhat.com>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>;
> Shannon Zhao <shannon.zhaosl@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v4 3/8] hw/arm/smmuv3-accel: Change RIL property to
> OnOffAuto
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 RIL property from bool to OnOffAuto. The 'auto'
> value is not implemented, as this commit is meant to set the property
> to the correct type and avoid breaking JSON/QMP when the auto mode is
> introduced. A future patch will implement resolution of the 'auto'
> value to match the host SMMUv3 RIL support.
>=20
> Fixes: bd715ff5bda9 ("hw/arm/smmuv3-accel: Add a property to specify RIL
> support")
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

