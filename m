Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FD5C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1resxz-0004bJ-PD; Tue, 27 Feb 2024 03:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1resxu-0004a5-NY; Tue, 27 Feb 2024 03:37:31 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1resxr-0006vV-KP; Tue, 27 Feb 2024 03:37:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLMD+idzaL+fOlkZ9xGCvF40zNJtaW7ba91E6k8HvWFptrwmKMny2LYJvGCy3EUdHE+u4PbjxnPwquERe2qHdvIpLEKxbAk1hEE1KUXS7lfEU2CVJjucOZ+UibB6yRtAeZKsGlnmsuUEuWq8WTLlSfO/+Ac7B4TuLHYj7C5wzYBXLkChJHTqLVsOlmzNf86Kq7OcgDC9pNF4HTZSUdj7tPX4APaSdADtYIlt1IiBaZmTvkqyKOf3fj845tI07RgeSlxNnXGjzDdoFGXLYLHdKxH/UK2m6dt0rTOeKgEr6wb6Ls7kBO24+QjKkUuEIzn+KFeM7IGg7rXlHe9rMXFQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVy1l7pi/+qm0y9OkUzhIhTGiPS3UldBqIIzrzlK6S0=;
 b=knl7Bh1uroILJxZX2t+6dmYF5JirZc1OH6zI7XKlG9qS87WGtguMoxJBJSlWoi3ptAFKyZVYgKBbsunVd59uny9/IsVphglLwB4R32rxJwSOZ4Gtr1TCKgHWopCqlcYxiMdtQ4jugl9SdiAqKxnsx/xp9NpCPxyY72xJP/Br+82RIasDWrrQRtWkYD6/8haYqwH59U2QXBo7Jo2/ErfowOHJLwh0Exv3gi9z52ppg4fA8qqX7GshQ7g7JDx3/9rgsYOn6suida3hUQArI0gYbAkCjnUsfgXwzQMSvHMy3uILE9ujG6KXRqyt76hFtZW7txzc9HPI3rARRHyRNT9UCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVy1l7pi/+qm0y9OkUzhIhTGiPS3UldBqIIzrzlK6S0=;
 b=d4hHweTasQW6jxqiinMVjxfUsMhdPyhcaW9iWpqjV1Mh3WPSTA34g/F41wB/Yqp0OXq0GdbKbRkkp0RQykmpepiCrgLR+1bjeG3/prAEpFDPuWgCnXe+tOdXOTrPvkXWEZR8xkFkxI5QOSrGdh/Wil1sBL0YR4VtsFSypm2ngElNpW5RN7Kqcgw4SIFmpX60FD2Pw9Zo48pV6sL8HFmQiu4h/5kE7e82xh7nZed9BT2t+bIAANLRHnvS1UFZGwHPmTimTEH4P1wEgk3AM38bHFrVgyo98O1j04e1IZf9shEFXrulQNK5tGZo+Nr97eiCMQ/9Xo3nP5YlO26BTD/O5A==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 08:37:16 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Tue, 27 Feb 2024
 08:37:15 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
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
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgAEKOgg=
Date: Tue, 27 Feb 2024 08:37:15 +0000
Message-ID: <SA1PR12MB71992ECFBF9FA3EE3C350EA8B0592@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
In-Reply-To: <20240226164229.00001536@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|DS7PR12MB6071:EE_
x-ms-office365-filtering-correlation-id: 53ccadfd-ea0b-46ac-e2db-08dc376f4d0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcoGYQoV0U8ODHsfAtapxcfIS1DdhS8ricPJeIFiEHCT/LH7BPYmzHS5nAbLoZi9Cyk21RmcqSIEg6yrabfwL1OvnnbM7SYtq92TZXpLaCaSZ2osDwBgQSvXthKpdpmERB6kP/Y+UXMxmgk4tJGwqiv+HLpdJEGImwqRXbIG+sm1cbSyhGY56GpiKxnlfMcEDd7zgLKEs4bJPCuGCulYSfgkiOcPVhztX8tORJq/u4sbSkNHHEiw96uM+KtTJokA9SOrZZBXF5002INne+4ii+O5bEmUK7/dAybyVyCTSO3QJG8w9Sj3nqSehpnZNuSy9yJJX6MJ3CaHuMth8kNModbQswKz1yGgbUNv7LG0w0Rt4H68/crRS0nn5MKnffQgr52eaLrUURWU/zxDogvJyvwveOgiz7sRo2Ua3ThEHpbAR4WjNG3fvS8ewyUcCQpLY2vTZFonX/JbUJnD3YY7I/m+kRF/qFlKbz+al7f9XVWxDEdjRAPEGVaCDuOFmpiP8rXr83Gj7nYjzct4IEz5qOWpKpwiejhmyk4FGiemoqWgkhf9nkWilgSAtiS8HUBOq4VB5U1Gbvcx0uakAEOKhyTYFGPHzA43APoHKCIrs7FfM9Kb8kv7vgzIkabL517vEJ0he05DrMXCYvfXZTcIGbwX0c0gp+IcJjqwVHcQKDsFRqD7Pv9zzVlV3EBC+KmAgkUkc+zhARiHFXGT5EHD9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Ugk09pmQGkuy0thp/3zzYOBBaTFgF+cqRzsTHu1EPoipJ5xmuejuo/g5?=
 =?Windows-1252?Q?OeBw/f+XLbepFUJf2VbC8NMNcVIk8r+HOmQwxcr3fVEyX+idSLXVBCza?=
 =?Windows-1252?Q?ahM2Hg1eajy3RKkofkedy+Jx8yu0IgLb0cy/YqIolWqqCgAgbAC/I8jZ?=
 =?Windows-1252?Q?FrQvPFMhZ2mVgOCUebkCUHO/SBmzesrX53daA+3iPaKJ7uY6qRKqzV9o?=
 =?Windows-1252?Q?7y1OpA/9LXGNyWs7/2akzha7EGHfUN1B3qp848agUuYlv2nVER9S7kAn?=
 =?Windows-1252?Q?Zy40lx2/n8PiqjRyle5j9Slnllctu0ZSYBdtWPHJYyckoORxcdOSyh/Q?=
 =?Windows-1252?Q?lmDbi4yWuAt40CK5EtCg/hZZH5AfONKY1/qR25lIiWkoa5ZJXfB8Pap0?=
 =?Windows-1252?Q?cOFe+4gLO5fTrk3xw+dN229kDQ+sEwMIDE+k+w5bUP7/092NR8VSIv/T?=
 =?Windows-1252?Q?biL7iOG5FSmkDjhS3nI6S/OLFxnruI79eXoVbL9XLjxHbOhLQxjElYep?=
 =?Windows-1252?Q?3IDjIBdTha3qrvQfrKNZvVkN0DoxU/1GHrTCXGHkYUcK73uS/hFAmYuI?=
 =?Windows-1252?Q?c0qbJ095PuVcl97d82cuoavrnUaw36DweuGrPY4Tny7n1MuNWnX7o0uj?=
 =?Windows-1252?Q?7uC8e3FQvxlq4pGYQ/LsL4HlTL07/bzysoOhCdZkRwNONk+FbGgbNVwU?=
 =?Windows-1252?Q?+m00F8F4Ov4U+UcjSXTTiW7rbVBmf5bWU8AC1sXult3EotUte8TrgkWI?=
 =?Windows-1252?Q?BndFkvA7Q8DxmvuSiH/59VFEYc7fe+A9dNaE4MqLAZkymEYf7FlVl576?=
 =?Windows-1252?Q?nJ9u4xaFghOjB721Qf8U1rTr3Fo1m24ufKS2fLAC45VODXxqFm45dSfc?=
 =?Windows-1252?Q?/V+7D0XVkUL0JT7iHQqnfCzp/bdYwTRoqf83DoQ9IpzqeEUSXSJhswj8?=
 =?Windows-1252?Q?0WeN0PXzlC70yFFHmjb/PyWDyBY4ZnLLdxYhfQXlxDaK8GMIupobQXSy?=
 =?Windows-1252?Q?Jv8UHOJUgxtR0fd2VdhKav6sVoXue3dfach4qBfIpiAuYtC8lItUeM9U?=
 =?Windows-1252?Q?GTgsFN9CVfJQAQEjEBpvODmDF2ioND5aP/PKrDEU8LtDFn+K52v1q08I?=
 =?Windows-1252?Q?Qlob7qvD/bnXh+pf3izf1m5ltWYlaxbn1pWK8AVK+Y8dHnlKMsFQOgkI?=
 =?Windows-1252?Q?tWwnP4JbzBlbzupV1KPpNdjEKoqzCz6xyrQEflYapSsMy1xiSJp3sAaN?=
 =?Windows-1252?Q?FiRT3/xOP3PaMObzNG16ACoERGWU8qysTFyZy6OUaVml6FIR+EThhV2T?=
 =?Windows-1252?Q?pi1Nl+GxgoT2I/5DHytGB2DTBsbX5OwbrwVRkPBL9IdmRYEGGK8EVpn0?=
 =?Windows-1252?Q?PnX05mYmhyC4zJhTZNbjSeZWGZ5+RIF6BzSaNUJibk5EBADEo4fKlJEa?=
 =?Windows-1252?Q?my6aeqVzyiMNOZ/yEKDZbalTl6i9q0BfGIgsKccqFE+OamWIypelKNM4?=
 =?Windows-1252?Q?EmEwbbQRgrL72GiOlqZTJdLNPEhBIw+pd9yrjJdy246Dljoqex7nNRx/?=
 =?Windows-1252?Q?4f37f/43d2BxevDSw1aC9KB8F7XId9+5S0iIVkakNxUroqOYZPMYaZxW?=
 =?Windows-1252?Q?AU7RNIr5kTgowAisHu2dUpOfiGLIjAbfD9pb1/1oQenKPtnpa6gzwuhL?=
 =?Windows-1252?Q?s8dJOb6sLlE=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ccadfd-ea0b-46ac-e2db-08dc376f4d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 08:37:15.2745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39I5dch+Gvi5cM3NOl87FeFsPGY9WV8mxa1iDnJ8bPdZqcOK1QL/vYfTuG2mGZ2Ra1FltCV8nvccg2EPPj820Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

Thanks Jonathan for reviewing the change.=0A=
=0A=
Comments inline.=0A=
=0A=
>> The structure needs a PCI device handle [2] that consists of the device =
BDF.=0A=
>> The vfio-pci device corresponding to the acpi-generic-initiator object i=
s=0A=
>> located to determine the BDF.=0A=
>>=0A=
>> [1] ACPI Spec 6.3, Section 5.2.16.6=0A=
>> [2] ACPI Spec 6.3, Table 5.80=0A=
>>=0A=
>> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>=0A=
>Hi Ankit,=0A=
>=0A=
> As the code stands the use of a list seems overkill.=0A=
=0A=
Yeah, I will try out your suggestion.=0A=
=0A=
> Otherwise looks good to me.=A0 I need Generic Ports support for CXL=0A=
> stuff so will copy your approach for that as it's ended up nice=0A=
> and simple.=0A=
> =0A=
> Jonathan=0A=
=0A=
Nice, would be good to have uniform implementations.=0A=
=0A=
>> +/*=0A=
>> + * Identify Generic Initiator objects and link them into the list which=
 is=0A=
>> + * returned to the caller.=0A=
>> + *=0A=
>> + * Note: it is the caller's responsibility to free the list to avoid=0A=
>> + * memory leak.=0A=
>> + */=0A=
>> +static GSList *acpi_generic_initiator_get_list(void)=0A=
>> +{=0A=
>> +=A0=A0=A0 GSList *list =3D NULL;=0A=
>> +=0A=
>> +=A0=A0=A0 object_child_foreach(object_get_root(),=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 acpi_generic_initiator_list, &list);=0A=
>=0A=
> I think you can use object_child_foreach_recursive() and skip the manual=
=0A=
> calling above?=0A=
=0A=
Great suggestion, will give that a try.=0A=
=0A=
>> + * ACPI 6.3:=0A=
>> + * Table 5-78 Generic Initiator Affinity Structure=0A=
>> + */=0A=
>> +static void=0A=
>> +build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCIDeviceHandle *han=
dle)=0A=
>> +{=0A=
>> +=A0=A0=A0 uint8_t index;=0A=
>> +=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 5, 1);=A0 /* Type */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 32, 1); /* Length */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 0, 1);=A0 /* Reserved *=
/=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 1, 1);=A0 /* Device Han=
dle Type: PCI */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, node, 4);=A0 /* Proximi=
ty Domain */=0A=
>> +=0A=
>> +=A0=A0=A0 /* Device Handle - PCI */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, handle->segment, 2);=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, handle->bdf, 2);=0A=
>> +=A0=A0=A0 for (index =3D 0; index < 12; index++) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 build_append_int_noprefix(table_data, 0, 1);=0A=
>> +=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4=
); /* Flags */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 0, 4);=A0=A0=A0=A0 /* R=
eserved */=0A=
>> +}=0A=
>> +=0A=
>> +void build_srat_generic_pci_initiator(GArray *table_data)=0A=
>> +{=0A=
>> +=A0=A0=A0 GSList *gi_list, *list =3D acpi_generic_initiator_get_list();=
=0A=
>=0A=
>=0A=
> Did you consider just have the functional called in the scan do this?=0A=
> Not sure you need anything as a parameter beyond the GArray *table_data=
=0A=
>=0A=
> Something like...=0A=
>=0A=
> static int acpi_generic_initiator_list(Object *obj, void *opaque)=0A=
> {=0A=
>=A0=A0=A0 uint8_t index;=0A=
>=A0=A0=A0 AcpiGenericInitiator *gi;=0A=
>=A0=A0=A0 GArray *table_data =3D opaque;=0A=
>=A0=A0=A0 PCIDeviceHandle dev_handle;=0A=
>=A0=A0=A0 PCIDevice *pci_dev;=0A=
>=A0=A0=A0 Object *o;=0A=
>=0A=
>=A0=A0=A0 if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>=A0=A0=A0 }=0A=
>=0A=
>=A0=A0=A0 gi =3D ACPI_GENERIC_INITIATOR(obj);=0A=
>=A0=A0=A0 o =3D object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NUL=
L);=0A=
>=A0=A0=A0 if (!o) {=0A=
>=A0=A0=A0=A0=A0=A0=A0 error_setg(&error_abort, "GI: Specified device must =
be a PCI device.\n")=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 1;=0A=
>=A0=A0=A0 }=0A=
>=A0=A0=A0 pci_dev =3D PCI_DEVICE(o);=0A=
>=0A=
>=A0=A0=A0 dev_handle.segment =3D 0;=0A=
>=A0=A0=A0 dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev=
)),=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dev-=
>devfn);=0A=
>=A0=A0=A0 build_srat_generic_pci_initiator_affinity(table_data,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gi->node, &=
dev_handle);=0A=
> }=0A=
>=0A=
> + a call to.=0A=
>=A0=A0=A0 object_child_foreach_recursive(object_get_root(),=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 acpi_generic_srat, table_data);=0A=
>=0A=
=0A=
Thanks. That does seem better.=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 pci_dev =3D PCI_DEVICE(o);=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 dev_handle.segment =3D 0;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_=
get_bus(pci_dev)),=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 pci_dev->devfn);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 build_srat_generic_pci_initiator_affinity(table_d=
ata,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 gi->node, &dev_handle);=0A=
> Should we check for consistency of gi->node and=0A=
> -numa node,id=3DX entries?=0A=
>=0A=
> Maybe just check less than numa_state->num_nodes as that's the variable=
=0A=
> used to walk the other structures when building srat.=0A=
=0A=
Ack, will add a check to compare against numa_state->num_nodes.=0A=
=0A=
>> +/*=0A=
>> + * ACPI 6.3:=0A=
>> + * Table 5-81 Flags =96 Generic Initiator Affinity Structure=0A=
>> + */=0A=
>> +typedef enum {=0A=
>> +=A0=A0=A0 GEN_AFFINITY_ENABLED =3D (1 << 0), /*=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If clear, the OSPM ignores the=
 contents=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * of the Generic Initiator/Port =
Affinity=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Structure. This allows system =
firmware=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * to populate the SRAT with a st=
atic=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * number of structures, but only=
 enable=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * them as necessary.=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> I'd put the comment above the definition to avoid wrapping so much!=0A=
=0A=
Yeah, it does look kind of silly. Will fix it.=0A=
=0A=
>> +} GenericAffinityFlags;=0A=
>> +=

