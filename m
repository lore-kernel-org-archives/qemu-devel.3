Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80221CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 08:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvXEx-0000EU-RS; Mon, 08 Sep 2025 04:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvXEf-0000Bb-KX; Mon, 08 Sep 2025 04:28:27 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com
 ([40.107.237.54] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvXEU-0002kd-Tf; Mon, 08 Sep 2025 04:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4mTtavPNidM0so0Kj6cRdhGsIzipsvvXPObAsSUz+ADroxHPSvFQ9BRlR7GX2FAevogJ7YhLKsFF3qnBXApr9lVgBmaCyOownD5+/XOWAXA1ctHPpZmerJx6skV54axMkmJlzdtSU3XrEcaHBGWhfQrsBd//SZ/TnV/PVELCQYY6/a4NTxFRgExs/ekEAI9dm1nbehqk9Na7fCUuE3UBW/VXtfK59uxE5kLvnoLemnYxsKA9zrsnUESj0ItWsusd8ZBddyPemFV+XrE6t4jG9FxvfJmHB3iE5Yswqs6rlxbd4YVrUpfyyqxIlPkx9aqVRzsvVkRUEJSqomhXzlNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYFnuWKkkL3ZfWkgD55e3ui5wKkWPiWxtHj2iBacdok=;
 b=EurDghu5JCtFy9/IDOCT6XKlIYjGCDSIgzayJAs2/E6zAfYsa5S6e7kuobqUTW2fIGn2+fpsHMA791CuXKOceWz0k285xDUCarMCrVh+lVcSVqDcVVYCT1DRJwmXVLM7rFN7UaI4G5+GZA6Rsng9W9Gb6x0dRVrHYJY3QKNR5HQFaXwNC0QdwNSvjv90qlf8yNAk/mcpAiVxOuNUO9+9OohSz2mHwks5I8sGTf6FTEldf9I6MKqRkYhJcpVW/G93qkiXRi+S22VYP4MZjOc5PrQUrfpfR8eNVGglF+t+719BeOy7awEMNDuTPA/UFaRWljIqwLZ78Hzbq4eAtUzkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYFnuWKkkL3ZfWkgD55e3ui5wKkWPiWxtHj2iBacdok=;
 b=Sa59sFa6NrrI9JeG8CzFUCn+EtiL6+UzMlgWnNlgIGmZlezsxUwlK2v68Rh7xuKBwZ5yOVCN9R75eyusE0LfftiM4BsjsRrzC+hyBDKIUBi6mAFGvkT+i1/6UO2jWaA29imekaRyDF0xntIyAPRGNYnAoLYpAcYRf/23IiIWHM/yCU0DCxr/4vf8NhO+pd1tNAMWp6CR9nrzN8FvOYu2XJsVNTusCV38fPdJ4Y56MzORazaP84gzAiGFygpwBQZFyIrMm2WM7y91lAIOOrpxskFxb7xwaosABYZyAbytlKa9cj58wqi7A1yo2srA66ojdd6tjvfmuRZmJlMZI6RQ4Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:23:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 08:23:00 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 07/15] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Thread-Topic: [RFC PATCH v3 07/15] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Thread-Index: AQHcHkIGJdaK2pygT0qGqEPj+pzqJrSI84uA
Date: Mon, 8 Sep 2025 08:22:59 +0000
Message-ID: <CH3PR12MB75482B0418C01770FAEFF56CAB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-8-shameerali.kolothum.thodi@huawei.com>
 <b13d3596-1498-462d-ab2c-1a626f050dbe@redhat.com>
In-Reply-To: <b13d3596-1498-462d-ab2c-1a626f050dbe@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ1PR12MB6195:EE_
x-ms-office365-filtering-correlation-id: dee13bc3-b60c-4099-1cb0-08ddeeb0ec20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dUVoNEVTNU13UXJKRTNyaG8waDNqY29tMWQwY0lOeWJPOE9wQTRabXFnZVpa?=
 =?utf-8?B?SG4ydmN4Zkx5NXNXUG0ybGRJWUZTajlPaUYySkpsbTMzTUJacWNIa3ZnMWcx?=
 =?utf-8?B?MlljblRPYmd5YzNuT2RVeXlybGxXZkhlR2gwT0Fyc2U2cnJMTTI2RWpMcVdt?=
 =?utf-8?B?K2JlWVJJdWt0bzVDTkZwU0pwY0U3dmZFWXMxY08rTWtXcE1yTVVBV2VjMEhu?=
 =?utf-8?B?WHUvUkdQV1RoSS9YU0hueDNVcGFMZE1jeUN6YzcrVzFsVUVkZ3MrZjlIczdM?=
 =?utf-8?B?YkVPS0NJM2FkT1BQeTYrbDkxU2VQUk5oc2ZlelJBQVRxM0xuaXBFRmlhdDVY?=
 =?utf-8?B?dDNOOHowc05GWlNuWS9WTUxpL1NNRlovR1hJcEltSmNlSHVQdlNUeXFtbEFJ?=
 =?utf-8?B?ODZHeTJNTlpiemRlTDdJRTZueU5URGVMaDcxNnFQYkRtZkFnUFlTWlJlQWdv?=
 =?utf-8?B?bXhTaXdsWm5vUnROcHlYa2hXNzV5Ui9yUkFMeGo0aVJmaXlHUmdDanZ6T3JM?=
 =?utf-8?B?V1BZamlTdW9PakVLdWIwSEpOLzQ4ZFBMQ3hpNTZVVkZUWGdPc2RhUkplZ2cz?=
 =?utf-8?B?THpPaEd2RFBzcWdJQVFOVmZNdzZlV08ya09UZ01oYjYxNVRrN203cExXck5E?=
 =?utf-8?B?RmVWZHJNRjNKYS9EUGgrNlBqMERDTFFMeTBIWkxtWmd0bnFtc2wvb1lUcE5Z?=
 =?utf-8?B?djBrb0xiZ0NISWFRTzVZdGdveDduTzJqclFGaVJKM3lIUmFPL1kxRXVwcndr?=
 =?utf-8?B?TWJ0Q0V3NTNrdmRsRHo2RkpHYXkvT0IxWis5cnBFUVUvVndCQ1lVOVZRek5V?=
 =?utf-8?B?c3RBbE5Jcm9HbFA2VVUyejJ1VEJ3ZFZ0ZjFSNWUrTmdTNVVUNDMvZ1B3RzVM?=
 =?utf-8?B?WkFKeTlaSlF2bURCZG8zU05MYlZOcUZHbFNkSTlzcit5ZWFUd1pQeW1ZdzE3?=
 =?utf-8?B?SHFUOWVrNWttZXM0akM2ak9KZFgzQ2o1UEh3QWUrN2RBWnVjVzVHaUVRRWtC?=
 =?utf-8?B?ODgyMDFPQ3JJU1M3TmRJanRUeFpHN0VWRWJ3N0xwblZaNUtNaWNEaXJaTlRY?=
 =?utf-8?B?UFFXSHVuOHNwekE0L2ltblFRTDFwaGtsZFVONGZMTE9ZT0hrekJHdFlSYjEz?=
 =?utf-8?B?bGxGSHJ2UENXbkkrZ2NjTldzRFJDeTVoeW9mMVNucFF3b0s1RzRLOEZockk1?=
 =?utf-8?B?Tk10bXpFeWFyeUFCMjNySXVJazN5MmdJSjkzUkhsR2ZyY0F1ckFTdUZpWXVo?=
 =?utf-8?B?N05WdkhQQTJ0SUE5emFQZFM0cEpmcTFtUUNMeEtEbk9aUTlucHdNTkxvTzB0?=
 =?utf-8?B?eGp5bjl0bjdlek8yR3ZWbjJpNzF0UE1uSjRkZ20xczFiTzI5MlVTZmlhQSt0?=
 =?utf-8?B?bjZ2bzBRMHA3bkZWNDF0TVYrRWprQlMrd2dZTm9jc0VpR1pNb2Evbyt1aGU1?=
 =?utf-8?B?NUNMVmdLV0JXVnVGY3pmYS9JdGlzTmdqVVZLUUkyNHhOaHNYeGR2ZlZIU0JT?=
 =?utf-8?B?NFhxNjdQMDRlSFBxaDVtcnVESWFPcjJkcXplSnNvaklsR2hic2cwc2w1aDlw?=
 =?utf-8?B?TCt0N1ZlUUxZMmVNUjhtbENlUHVQemtsUyt1Q2p5YkJ3N2N2c0xHZEtMV3hu?=
 =?utf-8?B?elp2QVVRbUpEOG95NVV2K2hhbSt0am03aTRabjFrZkEvVVppUzNwZ1JPZ09O?=
 =?utf-8?B?MzdSbzgyb1JqWVlwUkhEZmRIVnRkd3RsMmFvK2lrM1JnQ3lzblZ2V0NmQjRG?=
 =?utf-8?B?TzdpMXZtTXJnVHo5QU9mSmtVMXc2dEtuMWVYaldnWWJLODdFVEFibitldEZn?=
 =?utf-8?B?MEJlbGg2WFVBY3ozMHVrTFZxS092cGJoZGdEdHFkTCt4WjhFdTU1Yk9XWUhV?=
 =?utf-8?B?ekg4K0l4ejZsN2VGdU9wMjhZZmNFSnh1SE8zMy81V0JMS0RiMkM0SEZOcXFs?=
 =?utf-8?B?TnBuRUFqUFdiOXpvUGRWSU1BNnNBQ0FBVkM2aU81OG5MRTAzT2JzK0NPRHJB?=
 =?utf-8?Q?+b3OmDN3RaMVanUOwNI80w1OsK+FDs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTltcUw4SVBtV215Q2FIWGs0aUppNWd3dEpGYmZCNGJtMUx6QnZlUnV2bDlu?=
 =?utf-8?B?QTVJMVJ4Y3ZNSlNYaWlUTkRZUDVGKy9lVzBMWGFvMHRXZ240L3BDcUh3cjRi?=
 =?utf-8?B?L2F1d0VsNEd1ZDVKSmVlS3RQdGcrVndsbjg3cHhudlAzM0J1RUg3cGVMYm1K?=
 =?utf-8?B?ekFVZ0orOVd4VFl6YXFBd1kyLy9FbTRVUktldTY3aG5uNWo4OUNSbCsxL1gv?=
 =?utf-8?B?SXlvWm9RcCtaL1lYRzhLTFc5UzFsZFUxV3cyc01NRGl4OFR6dWl0VmNQT3pC?=
 =?utf-8?B?V1BTQ1M3ZUVyeGpKU2RaMStRemN5UFQ2NUpGTFFmdFI5YW9PQ0RGdUs5UEgx?=
 =?utf-8?B?RTNmMndYQ0M3L01XMFpCeEk3SE1kV3V5MUJWRDNzRFZLWTE4RDlPT2dUa3M2?=
 =?utf-8?B?UFBjbVZsMzBQM1dvdEhNS1U3YTIyc1c2c29PSXEzSStnbHdiYWVGYWJ6NjJR?=
 =?utf-8?B?SDBaczFSanJxaXp2U0tJUjU2YXZyRnVhZnpvS2d4RWZpZGR2MUZ0M2xYN2dW?=
 =?utf-8?B?aW1wWWQzZ01CaHVYWGZKR2Y3RjhjMlF5UmhkSmVPM2c1OTc0MlFWU3llNXBz?=
 =?utf-8?B?TnhnQnRiekhhSC9NNVRKc0xLSFVYSzlBZWQ4eUdVRy8wcWdMTzJFWWEyQ0g4?=
 =?utf-8?B?b3ppY2I4SXNxNjVESnlPMmxFS1FCWld5RE9lKzM2Y0JmWDJOWUxBaVFCVVVt?=
 =?utf-8?B?R1JQTkNTNitzM2Z3SmpmRmpvYnpUTU80N2ppREhhSWZHYVdydUNiYm4ySmkx?=
 =?utf-8?B?YmdpaGRCUjI0emZCdHM0eW5YWjFVc1YrUnpnTnFIN3VEUGluZTRMSGZXVk9P?=
 =?utf-8?B?RlFlT3ZuNlZXdW5YKzFOM3VaYm44V1V0S0J5NUZpSWxuRnFaUmZsd1RVZEZj?=
 =?utf-8?B?WkpwckllcmwyV3BTSzFiZ1lUMzd4bkY1UVdUcDZYUEVyTXB4Y3ZzeFMwenJ5?=
 =?utf-8?B?Ny91U2E5czNUSWcrN3pDRUtEOFB4SURWTFdjdXNjUSsvcndHc0hiV09sU2sr?=
 =?utf-8?B?OWNSM1Rkb2owK3NENkdyV2dtTjFTR1VlNDE0alhkR2lpQTcvcDJxUHhET2Q2?=
 =?utf-8?B?U0NyWitHeFB6Wm1GUlB3djQwaitEZFY3blp6SkNzRUVMM2lsdEVzNWtyVlBq?=
 =?utf-8?B?TFdvWXppNFBxOVFveWxtNDZIenNJUjJZY2dHdytTUVE5MDFrYlBVUUNzS1Nn?=
 =?utf-8?B?ZlNRVnJyR0w0WkRtUXozZ1RDNlVlekdmai9lZmN3azlUcDQvdEhDdEphclBa?=
 =?utf-8?B?NVhsYm5qVGo1OTFUNlFqc2NZZEl3OC9udjNIVVUyazl4MTlPQUpuNkJUcGV5?=
 =?utf-8?B?bmFuczQ3YlY2Z3ovTUt2d0cyVHhRTTRKSmJyOWhIc1Brb3QrTnlmQWx3RnRQ?=
 =?utf-8?B?aGJFbUZCeVFTc2F2SVFHbFQ2V1czZzdlRmxqMU9FaUgzSzRKaWpyZHNURlM4?=
 =?utf-8?B?REFheXhseit1SU9rWWRyTnc5K2ZZUzBNN1hLNFJaOHZ2TmZ0RlRFRzlRQkJj?=
 =?utf-8?B?RStoUWYxOWVwaGpNbG5qK3dxQXV4UEprbTZ6YW5wb21OUXBwbGd2TGhGQzFx?=
 =?utf-8?B?VHVocXdySUs3bGd2akhDNDQyblNNaWRQbFVINTczcnplTm1YdEc0cVJQVVlQ?=
 =?utf-8?B?N0FMVnNCMGVvTmJkUVYvSjM5YkRxU05wd1VNd0VsTzNrQ0hod2NjUC9qY3lT?=
 =?utf-8?B?WDduZW5UNGdweWxNRmdQdldGeEZQb0dIVUpzVmdVdWJVTEltQTN4YlVoSkF4?=
 =?utf-8?B?eUhTTzNxeE1IL1d5TmxxU2o2UXBEdTI2dVhUbjZQejFBZ3pKWTMrVDV3Vnpy?=
 =?utf-8?B?SFdNbS9CcENjZGQ4VW05M1JtOS9tYk55ZlU5Yi82WENJbnArTU5NeS9EY0lr?=
 =?utf-8?B?RUNRNEZScXA0Q0k0RWxNNXFwRkhLdFJ2U2xDOXR4RXprWEV4c0FHR0krUGRH?=
 =?utf-8?B?SlV4aFFaSHpxdytCb21qM25oSlQwMFVUaUFGcnN0UFRtc1VrVDRhanI1cE9M?=
 =?utf-8?B?QVpGWVg3TjZVOTlzdlEwRmVzdGphQVBPVnh1UngvbXowZkQ4YzAzZVljNUZZ?=
 =?utf-8?B?cVdjUTk4TU9IYS91MUxDa0szSlBVSkJZVlJZOHN2NGlZYjduUzlMZmFTTjRh?=
 =?utf-8?Q?YMwo0ko7IhuwG8DITNDgGSF+y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee13bc3-b60c-4099-1cb0-08ddeeb0ec20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 08:22:59.9048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wP5uZdw2qE3hHfz3bf4tEPcKZSkXURAAI8QELhYIp9EDtUMrXT+QwBP6sw3XHOmi8Ulh17Yk6SJemAW2oK6tmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
Received-SPF: permerror client-ip=40.107.237.54;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.131, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBTZXB0ZW1iZXIgMjAyNSAwOTo1MA0KPiBU
bzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBTaGFtZWVyIEtv
bG90aHVtDQo+IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IGxpbnV4YXJtQGh1
YXdlaS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWku
Y29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8u
b3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5j
b20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDcvMTVdIGh3L2FybS9zbW11djM6IElt
cGxlbWVudA0KPiBnZXRfdmlvbW11X2NhcCgpIGNhbGxiYWNrDQo+IA0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9u
IDcvMTQvMjUgNTo1OSBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGb3IgYWNjZWxl
cmF0ZWQgU01NVXYzLCB3ZSBuZWVkIG5lc3RlZCBwYXJlbnQgZG9tYWluIGNyZWF0aW9uLiBBZGQg
dGhlDQo+ID4gY2FsbGJhY2sgc3VwcG9ydCBzbyB0aGF0IFZGSU8gY2FuIGNyZWF0ZSBhIG5lc3Rl
ZCBwYXJlbnQuDQo+ID4NCj4gPiBTaW5jZSAnYWNjZWw9b24nIGZvciBTTU1VdjMgcmVxdWlyZXMg
dGhlIGd1ZXN0IFNNTVV2MyB0byBiZSBjb25maWd1cmVkDQo+ID4gaW4gU3RhZ2UgMSBtb2RlLCBl
bnN1cmUgdGhhdCB0aGUgJ3N0YWdlJyBwcm9wZXJ0eSBpcyBleHBsaWNpdGx5IHNldCB0bw0KPiA+
IFN0YWdlIDEuDQo+IG5pdDogc3RyaWN0bHkgc3BlYWtpbmcgY291bGRuJ3Qgd2UgaGF2ZSBhIHN0
YWdlMiBiZWluZyB1c2VkIGF0IGd1ZXN0DQo+IGxldmVsIGltcGxlbWVudGVkIGJ5IGEgc3RhZ2Ux
IGF0IHBoeXNpY2FsIGxldmVsPw0KPiBidXQgaXQgaXMgdG90YWxseSBmYWlyIHRvIHJlc3RyaWN0
IHRoZSBzdXBwb3J0Lg0KDQpZZWFoIGl0IGlzIHBvc3NpYmxlIEkgZ3Vlc3MuIEJ1dCB0aGVuIHdl
IGhhdmUgdG8gdXNlIHRoZSBTMlRUQiB0byBjb25maWd1cmUNCkhvc3QgU01NVXYzIFMxIGluc3Rl
YWQgb2YgUzFDb250ZXh0UHRyIHdoaWNoIGlzIHVzZWQgbm93LiBJIGhhdmUgbm90IA0KdHJpZWQg
dGhhdCB5ZXQuIFNpbmNlIFMyIHN0YWdlIGlzIG1vcmUgcmVzdHJpY3RpdmUgaW4gbmF0dXJlKGVn
OiBObyBQQVNJRA0KcG9zc2libGUpIGRvbuKAmXQgdGhpbmsgd2Ugc2hvdWxkIHN1cHBvcnQgdGhh
dCBmb3IgYWNjZWwgY2FzZS4NCg0KSSB3aWxsIGNoYW5nZSB0aGUgY29tbWl0IGxvZyBhY2NvcmRp
bmdseS4NCiAgDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxz
aGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2Fy
bS9zbW11djMtYWNjZWwuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICBody9hcm0vdmlydC5j
ICAgICAgICAgfCAxMiArKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jIGIv
aHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gaW5kZXggMGIwZGRiMDNlMi4uNjZjZDRmNWVjZSAx
MDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiArKysgYi9ody9hcm0v
c21tdXYzLWFjY2VsLmMNCj4gPiBAQCAtMTAsNiArMTAsNyBAQA0KPiA+ICAjaW5jbHVkZSAicWVt
dS9lcnJvci1yZXBvcnQuaCINCj4gPg0KPiA+ICAjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My5oIg0K
PiA+ICsjaW5jbHVkZSAiaHcvaW9tbXUuaCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2lfYnJp
ZGdlLmgiDQo+ID4gICNpbmNsdWRlICJody9wY2ktaG9zdC9ncGV4LmgiDQo+ID4gICNpbmNsdWRl
ICJody92ZmlvL3BjaS5oIg0KPiA+IEBAIC04MSw4ICs4MiwyMiBAQCBzdGF0aWMgQWRkcmVzc1Nw
YWNlDQo+ICpzbW11djNfYWNjZWxfZmluZF9hZGRfYXMoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1
ZSwNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB1aW50NjRfdCBzbW11djNf
YWNjZWxfZ2V0X3Zpb21tdV9jYXAodm9pZCAqb3BhcXVlKQ0KPiA+ICt7DQo+ID4gKyAgICAvKg0K
PiA+ICsgICAgICogQWNjZWxlcmF0ZWQgc21tdXYzIHN1cHBvcnQgb25seSBhbGxvd2VzIEd1ZXN0
IFMxDQo+ID4gKyAgICAgKiBjb25maWd1cmF0aW9uLiBIZW5jZSByZXBvcnQgVklPTU1VX0NBUF9T
VEFHRTENCj4gPiArICAgICAqIHNvIHRoYXQgVkZJTyBjYW4gY3JlYXRlIG5lc3RlZCBwYXJlbnQg
ZG9tYWluLg0KPiA+ICsgICAgICogVGhlIHJlYWwgbmVzdGVkIHN1cHBvcnQgc2hvdWxkIGJlIHJl
cG9ydGVkIGZyb20gaG9zdA0KPiB0aGUgYWN0dWFsIG5lc3RlZCBzdXBwb3J0IGF0IGhvc3QgbGV2
ZWwgd2lsbCBiZSBxdWVyaWVkIGZyb20gdGhlIGhvc3QNCj4gbGF0ZXIgb24/DQoNClllcy4gSXQg
aXMgaGFuZGxlZCBieSB2ZmlvL2lvbW11ZmQuICBTZWUgdGhpcywNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTA4MjIwNjQxMDEuMTIzNTI2LTYtemhlbnpob25nLmR1YW5A
aW50ZWwuY29tLw0KDQo+ID4gKyAgICAgKiBTTU1VdjMgYW5kIGlmIGl0IGRvZXNuJ3QsIHRoZSBu
ZXN0ZWQgcGFyZW50IGFsbG9jYXRpb24NCj4gPiArICAgICAqIHdpbGwgZmFpbCBhbnl3YXkuDQo+
ID4gKyAgICAgKi8NCj4gPiArICAgIHJldHVybiBWSU9NTVVfQ0FQX1NUQUdFMTsNCj4gPiArfQ0K
PiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IFBDSUlPTU1VT3BzIHNtbXV2M19hY2NlbF9vcHMgPSB7
DQo+ID4gICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSBzbW11djNfYWNjZWxfZmluZF9hZGRfYXMs
DQo+ID4gKyAgICAuZ2V0X3Zpb21tdV9jYXAgPSBzbW11djNfYWNjZWxfZ2V0X3Zpb21tdV9jYXAs
DQo+ID4gIH07DQo+ID4NCj4gPiAgdm9pZCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNTdGF0ZSAq
cykNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMNCj4gPiBp
bmRleCAyMjM5M2NmMzllLi5mZGI0N2VkYTZhIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0
LmMNCj4gPiArKysgYi9ody9hcm0vdmlydC5jDQo+ID4gQEAgLTMwNTMsNiArMzA1MywxOCBAQCBz
dGF0aWMgdm9pZA0KPiB2aXJ0X21hY2hpbmVfZGV2aWNlX3BsdWdfY2IoSG90cGx1Z0hhbmRsZXIg
KmhvdHBsdWdfZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgICAg
ICAgICB9DQo+ID4NCj4gPiArICAgICAgICAgICAgaWYgKG9iamVjdF9wcm9wZXJ0eV9nZXRfYm9v
bChPQkpFQ1QoZGV2KSwgImFjY2VsIiwgJmVycm9yX2Fib3J0KSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgY2hhciAqc3RhZ2U7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgc3RhZ2UgPSBv
YmplY3RfcHJvcGVydHlfZ2V0X3N0cihPQkpFQ1QoZGV2KSwgInN0YWdlIiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2ZhdGFsKTsN
Cj4gPiArICAgICAgICAgICAgICAgIGlmICgqc3RhZ2UgJiYgc3RyY21wKCIxIiwgc3RhZ2UpKSB7
DQo+IEkgYW0gbm90IHN1cmUgeW91IG5lZWQgdG8gY2hlY2sgKnN0YWdlDQoNCk9rLiBJIHdpbGwg
ZG91YmxlIGNoZWNrIHRoYXQuDQoNClRoYW5rcywNClNoYW1lZXINCg0K

