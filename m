Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5EEC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfyL3-00022O-GW; Fri, 01 Mar 2024 03:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfyL1-000222-6T; Fri, 01 Mar 2024 03:33:51 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfyKy-0002mV-8L; Fri, 01 Mar 2024 03:33:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5d5k+cO8z4nHaVPGBx2SwKt5vi2vl46W67C+m3nYqCmf3zMOCDZLLe/Rqqh0CHcaPExfWmfwoz+CqqnH85JHNSUCiPAjB0BLmJr7V9tpGh25VkuPIYofyuBW4M3u+zP5XN1L2HGeDqnYyq4rLSr9yuMA2/0UUN0UW94FuaPwrJjfu/DsW1JDS0IAl3YTm60f9cukIUNVA4CJwbiztbbx2X6vp0ARhoXhmIGheuoF9B7PiONerBO8KDBk9/umBk/9e2d32Rdc+OsQqFxIYffWjBWFFPyW6KgMPeDTppFosJhtr9Ga64FrGBVpTTq/GMpFXSg/juspP7MbCt1b2UJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szBOQi5roTBW2AogWBXywwd8JnZxk1B94UevP/Gk8+0=;
 b=PYoVsi13jSMQ/X4A36Dbu30rE7iosFZFFEx6Ms/GR4RELUePvOvfKXH3SPUTrBlnygABm6SmU4f4CgAjtUB+fh0IlqJiqDbMWdcIDONL/uIaifGLBY+ILb3dx/thSeoxO8LHqZilzc10srz9etlWx2BefCLXZdTXSx8qwVzbd8lPPmQvMPZi57G36F+dFTaRg0Re3OtOACmvd1VCdGyxUeTKSKD7kT6+kFTxQTyVLb6cCyt7K6ApfPe2DxIyLvZRDHWmXrBGGc9kaGeE/KX2NbWThmIY1ho2dRSZA4IRDVLyN9f7uhfGAn2yO4afREI9Xg0CmTjLobtlm/IUfhteyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szBOQi5roTBW2AogWBXywwd8JnZxk1B94UevP/Gk8+0=;
 b=k4OR/tqTIpBrB1H8PiVDWUfARYPurtW1PWsSNVyewWiS7te1O1l24Wxwl8Q626hC/sQEKkkDfb3G67D3sWLVBbh3v50fTEEaudelFWyeAhljqDIjZAHASQA9p9MeEI3MhEuTmfEZMlelIWs10XfWCHnQzrMGGGWWrPH8jkLmJEFKH39C1LS/dXbeCyNqlRBnJ7GkLDjA5no3shCtaKsBp4mwbLIc8Yw63sc1TRnHq3DPVzyjFfYe/8rLIxIqRZXhv/vDyz5TzvjpxemJxJ0UGjUWPz1CL99SutJ5o6HPx2INrGlnAcpP8Pipjrr+Kp9GtLYA7ys3rIfgO0ojlyNzJQ==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 08:33:43 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 08:33:43 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaZlXRpHP8fv3NL0CqBnE3t10aOLEfZKrYgABqHwCAACU5hYAAC4X6gAEmMwCAACTghIAAQoMAgAEL7mQ=
Date: Fri, 1 Mar 2024 08:33:42 +0000
Message-ID: <SA1PR12MB71999E1863F1FD4C2505294DB05E2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>	<8734td3uty.fsf@pond.sub.org>
 <20240228135504.00005d12@Huawei.com>	<87bk80vaft.fsf@pond.sub.org>
 <SA1PR12MB7199F868F1C300B1E795CD39B0582@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240229102230.00004277@Huawei.com>
 <SA1PR12MB71993D9D99F4756C17CAE9DBB05F2@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240229163232.0000478d@Huawei.com>
In-Reply-To: <20240229163232.0000478d@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|CH3PR12MB7546:EE_
x-ms-office365-filtering-correlation-id: 863bd585-df8d-4f8d-857e-08dc39ca4db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Xw3wKFCb0JN3EwCk5p8rbeh8xGz5Ngd7qC+h/+wBzu/ZCmNfBL0n1xe/bX73INRB5buF/5kENYDMTuzyGkMWMsymqaqhsu0vTS9hvY8zLxNalp6eb6nNfSJN7+M2j+YL8cOQg/QfWLH3NocuW0bpFproM/UC+oPnMl25f2bqK3rfveaw/1G1/4C6dT4oaPYeRI/33ILIMkTnacTE0cMmBUSM9hs5oqOJFZVmrO3sbUf120RkEPkBJZBEDcF2SQYNGWVKHj06nnxKqzanbhLWAILczo9dPTFvZ2tuthS04pLxx6ZBladS1YyqKUXb/yuvnIQ+qBqnbqOddOD/dLa70LIFG4qvHK058v/G8nKc2L7wRXqums4jJ49BhOVz4cjH7XalGcR04HfSY0Nxqi5LOHKcwXNClRyaobRln1VBzXrc2CqbaqtrI8D9nJ+P80E+Nsge+OTanmFq87Mg6HsI7qeq8l6DmKHmLYd3ROVvtfPt/2e9JplZ4UDg9eQI6sRG/tcDyROkx01BhU79SStfCXo/z+F8x7jO1nCThQZZJHZcTAD9DuIhW29xo/H+UehTOC/0M/ZnAYCZVQee98Wh06Ya76x8tjXahwYwcMO33Bs0/j+H4Q8MF+9mZ5TzW72IhUvTbGVWvtuHkX/toQjq+i99gsuyaWbkBb5uLykt/1IivQd2Hax/NeSrbwBMGfcXYCYSMpOp4NR+2NNlxUwRO8ZxHQWjCcPJZs3+0eo+CU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EpX98Vi9ljoMmp2DjrjpGQofB+N3AytrYubN0mkdba+Xbeb3AfHqZYbcJp?=
 =?iso-8859-1?Q?2aQ8H5Fkv1vIMoQEyK1B4+9l2+qY7Tvegrfrsg0tAu1Opw2ZbyyojRyB8T?=
 =?iso-8859-1?Q?K8WfTmoLw1Mry3fEa6a6Z7XVQD5LnaHP1hCgVIbeE+PuXeJ57zYLdNsVYR?=
 =?iso-8859-1?Q?gTzhA6XUOGdc1poSSeHiiHvMiNHuDY59aZk9kYy/G7Nu4cA/jwY4IjuoHF?=
 =?iso-8859-1?Q?VBOoD2BnJEvLSY0r37ZyIunC0xPfDQXb0vUEGhX7SZL4Crh+d7WxuHlkvm?=
 =?iso-8859-1?Q?vHaqTnRLe0qUYI32mZEPMbP2SOwSHCoFmvpwgDCbeeBk7Dk4r5Q58Uid2y?=
 =?iso-8859-1?Q?Ce/FTaIkJLUlB5crhSjqXOecuxQPe9BrKcQWO8exBBDsLGOcElq+kshMOo?=
 =?iso-8859-1?Q?l1eXeEbXU6ZEU75m6vaRJfpxVa7E9qKb/4vyUvFkD4O5KtiFVF17HpVy95?=
 =?iso-8859-1?Q?qSw2u7lpd6YjLIL6k0Lg+MU208jB/7FjPlFgCSSe6WQ8UJrxnmRKXwxGAo?=
 =?iso-8859-1?Q?cVtba/0adesg42wXBk9oa8ZfFf1aVga0ixoNRMt+PoO7M7ZktcR3brytkh?=
 =?iso-8859-1?Q?CwSaITfO6+KS5pRPsv8x0ayJhC0zIM6DPgcCWGUHfCdxFyDUQzj0m2vBdD?=
 =?iso-8859-1?Q?8unsptVcHcMUirhHT//gpD/0L2UlnYAvcWX2QT6fMCnrFNSpLse0YTuBY2?=
 =?iso-8859-1?Q?vSApDmxamu5Qmu2f2mbS4x/bKicnGGCxvxiUhRtjePgwOdd5R31jqiCpPY?=
 =?iso-8859-1?Q?QbrjkrNw9jHt8JTvV4NRuI3Efcdv8YeZrm5YN+QoXbe0/6iILNj9dMPPep?=
 =?iso-8859-1?Q?MB8M22V4sHmaPOW6K1i3A9BVTJ9xzF9MPweOJjAHShqNQzH7b751qGot65?=
 =?iso-8859-1?Q?yC29AoQx6gfIuNvYSodrRvFifgd32oq4M7alygw0hoIpck45xPXw9DZ21w?=
 =?iso-8859-1?Q?0e26xqOu5JOi7Y/V+HUNySUOmHkMHkXYMcj8J0ltQ8DBIhTmIWupKbj35e?=
 =?iso-8859-1?Q?mVFeo9StDVsUUBPPI7cTgRd86DXuonXRh54GGcy8K7x/RkUd7s8GKMs+vE?=
 =?iso-8859-1?Q?nC6fgjtE78R4NIYQIVj1ZjkVGcZ96bZzBkGOyBR3leljCTsUMPB9ex2XH0?=
 =?iso-8859-1?Q?+qRp6fkkuFi0A1sn81AwX5HOlCy9dAwpsEIF5xbW2ky3OMWl1iEE75BSgI?=
 =?iso-8859-1?Q?pkyUhrPmcO5G2mpMauPR08MdHTKDzpdszgPw5hdennzxQC64MAkuzLsohl?=
 =?iso-8859-1?Q?oEFbgWgpvQHiMdpOR9ARaj1/H7ul23l83nhmIMcEKomODVofF8U7XDGiu6?=
 =?iso-8859-1?Q?dwkQ4W3qEsoXKAtTAGJ+wVvebhX7V6jDdckhbpl+rIs4zbQjNlKIl8ColX?=
 =?iso-8859-1?Q?ISogBXWMo7vUGBkJwY5y7KiYJnKv3LAlAbhh4uXfvdTLJuNtZztsZST9G7?=
 =?iso-8859-1?Q?KfVb+Hn5x2MCg2TKKJNvaripwXMi0DwHyrlCdIW78LTV666dMO5tRCIdq/?=
 =?iso-8859-1?Q?VpNdGedD7VNjA0zqYxZX5Zrm5iujprN7QZ6WpS5xmrFEa0zwOIBy302GnX?=
 =?iso-8859-1?Q?bJAjhpU0zwF/9xds97EZWXaxuGXFNaI1joQJqKCd/U+etJG/xiH97JMOd0?=
 =?iso-8859-1?Q?EaA+BVszYV2Vw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863bd585-df8d-4f8d-857e-08dc39ca4db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 08:33:42.9427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXaKq0XqvFEQjecS5GZgjK7xu39qnj8u1A3cmwebCsmknlB56IZUWVWT5O76t8QXgWcfJKc855r0jjh8sw/MwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
Received-SPF: softfail client-ip=2a01:111:f403:200a::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

=0A=
>> As for your suggestion of using acpi-dev as the arg to take both=0A=
>> pci-dev and acpi-dev.. Would that mean sending a pure pci device=0A=
>> (not the corner case you mentioned) through the acpi-dev argument=0A=
>> as well? Not sure if that would appropriate.=0A=
>=0A=
> Ah, looking up my description is unclear. I meant two optional parameters=
=0A=
> pci-dev or acpi-dev - which one was supplied would indicate the type=0A=
> of handle to be used.=0A=
=0A=
Yes, that makes sense. But for now only have pci-dev until we have any=0A=
acpi-dev related code added? IIRC, this is what we discussed earlier.=0A=
=0A=

