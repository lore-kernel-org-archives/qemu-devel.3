Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFEDD29FB0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vREW9-0007N2-5x; Thu, 04 Dec 2025 13:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vREW5-0007Li-EU; Thu, 04 Dec 2025 13:57:25 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vREW3-00070H-Mt; Thu, 04 Dec 2025 13:57:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ6eeLF/Pmr061qQ+7J+N0zHaFa9ZTaR4Ec0/DOzT2CbV4+QpggqClKzyrQarZARB2Ny7IX6EDq/AdzvWC3b7t1eAX+e3NSIxBUS4GE7H8qgTkT/p2xBi88db/Zf3+gj8kv5k8xA4UHTw28Yi9riTK9iDRNyqGllKyQ31NW/qZTt1zxqH7wEKIiIG0D2TpTncDAw5Y5JytRV1hhNcjqGMB4kYUs2aoXfeaXX2ogPAaVj/7aQrzpdTvwH07jvMXbgCGbPZyXz7mnheHvNnNIIYduLnLoN8iU3ZGMXpMBfBgWM+Pq0SZkLjgm3TTg/mSWSzZAKUGCCG+4FjknsSBR0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDz1tPlm1cqt3oHbckczQabSTxw15TXQ6A4T8e5wHW4=;
 b=quC7S/J8/a8DihQqfnBtg7UXAIrhJcOC4An4yIkq+fcbmk4DykpAebPSHfOHeCK8tA6L+USH0+k5moS+PqdnBsndROE2D+jMYSrJB28er2cwizW5uEJxIxcuo6AcUz4mhCc8rmeAWiiVfoOD+XwnN8PkTFsNYuAkm1kkQhdWCxBhj7SbnZvuaRGI3QR/k7Znf6ksxh99lrz//yN08NBiaNCQFQOrbg9YVVP+1c7+Z4i6+zbGh352AWePmgFeG/5WhMe7ZwocnSFCl+iqD1bYhDSDnDteYF4l322yY9GGX763swsZu78r38T65FZihgrKfMnry+eraZQ8JuC2X/Wv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDz1tPlm1cqt3oHbckczQabSTxw15TXQ6A4T8e5wHW4=;
 b=pu9JpGbvlRWZj6LZqQtgd7lQlqaTdR0Go4kAxW8NRptKabArH/K4rOB8Q9+xPOcnFnbHmBy1hSHTnboL87+krucnOCSQ6U0z8BA02ZHnoKYSeYBefIORKoKG6PEvVBLJA+TKq/GW+YRzp/9yoPfVrbGZanPkubnkslgZDXDeTSasD1RZGaQIisEOKfv6RhQFDhyDYLj1OhFGkrbvOqrSbIP6eQsGXu3WrMAviA4VI59TrVgCyb74/23lg6dSb8MgSR50cbGgEd/xGbg+2PNtSGzpswZx+PfJlbHNfJ51P9IkjV1CgrkbtN26icGJBE7zIR0wwlv94Gz1gUTqQY16Zg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 18:57:10 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 18:57:07 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v6 16/33] hw/pci/pci: Introduce a callback to retrieve the
 MSI doorbell GPA directly
Thread-Topic: [PATCH v6 16/33] hw/pci/pci: Introduce a callback to retrieve
 the MSI doorbell GPA directly
Thread-Index: AQHcWiF5eHByUvStR0WJp3MS9tJy9LURxJUAgAAd/9A=
Date: Thu, 4 Dec 2025 18:57:07 +0000
Message-ID: <CH3PR12MB754847D3EC2A35D54F0317EAABA6A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-17-skolothumtho@nvidia.com>
 <377d4c92-bfb0-4743-94d4-c4bf8dcb2934@redhat.com>
In-Reply-To: <377d4c92-bfb0-4743-94d4-c4bf8dcb2934@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA3PR12MB7830:EE_
x-ms-office365-filtering-correlation-id: b03009df-2482-432e-c74a-08de3366ebf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?L2M5VU13ekxyY1BUaTkvaCtIemVEbkVUTEwweDZSWUtRSDdyckJwa1hwc1ZG?=
 =?utf-8?B?YXBoY0dYVkxZWktic2k3MHBtUEtqaWNLdWREbHBCUUVDM3QyM2gzOXBWYmxX?=
 =?utf-8?B?SGlqc0VwZ2dNV3hobnhQbUlVdjl5ZTVGQXBnUmgxSHp4Z0oxWGd1Nm1lOU9x?=
 =?utf-8?B?YzNnSksva1NRaHpSVm5kNUN2Q2lDcVBtdFB0N1UyL05UWTZjVHQyNVU1VkhQ?=
 =?utf-8?B?dkN2a0hsVnlEL1g2U2tKdkVDNTBsLzF3RGRWOTVNazl5eW0wbjE4dVN5QllD?=
 =?utf-8?B?eS9aMS8wTk1UTWEvdmF6dXprTTR5ZkVwM1hPaTlra3RnSVY0NjhxZDU4MmFm?=
 =?utf-8?B?MjFtbmUyUDJ6ZXZidTlVYUpmaVRldEloMzZ4SGwzeTVDWFM5RndyQnlScWll?=
 =?utf-8?B?amJKSjRPajQ5V0VIYVpXek96QWJVeEpwWHJvZzl6ejV5S2d1TWVvUENXRHBK?=
 =?utf-8?B?Nk1IMjcvWW1nbnNxSE9mcGN4QkRja21kaXdPSkRLUy83NTZkek92THJMSTcr?=
 =?utf-8?B?ZXZXSVNUN3FHRWUvdnB1YWpsY0UrZkhhTHpmRDQ1YzMyajkzQ2twUWtRVWR1?=
 =?utf-8?B?WjBYKytyV3c1cnZwT1Z5VU83TTJ5THhBNkJQY0VKUUVUSjBmRkRnS3hmbzhU?=
 =?utf-8?B?ZkxGQUtZaHpmbzhiVHpZcHEwTE9uTU1sYUtCMFA4enJsUEhYUkJ2N2xmY2pV?=
 =?utf-8?B?N3pjaXQwRnp0bVFQZk9QaGhUNjYyVDNRYmdxelNxck9RaEVIZG5jZjFLTXpY?=
 =?utf-8?B?QXNjdVY1bUVKLzMwRlZ3WldJOW5nVHNhNFpTZzlTcXhoaUdvcC92WmU3NHB2?=
 =?utf-8?B?YVNOZ2FjNGlRZHBVQ0lxaHh6S2lpdVByencvTEpjWW5GSGpoRjFqd21PVWYw?=
 =?utf-8?B?MXZqM1dOWEVnRkJUdXE3NTFQYWZmKzRtdHZjL3NKM3RlZ3NoSzR2UXFoenVs?=
 =?utf-8?B?WHRSTTFYOFBDV2FicW9UWmFFZEk5N0gvK0xVRm1nWlN0L09EaHhtN01ZRENy?=
 =?utf-8?B?Z3hyUWFPUjRwcUcybTZpeWpReGhiRGJWQTBOanZiUzVKT3k3SWt1Mk9veGpW?=
 =?utf-8?B?c3VCeWhlTE9rVy9zZ2ZjbjZsdUdWVjl4aHc4OE1JRUdEY1IwTlFBVGk4SHhx?=
 =?utf-8?B?TVpyTUVLRUJuckpEUGNhcXZNNTlrcTJ6MkNBN09FNGVPM1E0cGFpNWZqOHB0?=
 =?utf-8?B?Y3B3eG5lREY2RkRmbFJzejRjaFlHbStqT3Z3bHlnUkdjMFJISFBtK01yaGVL?=
 =?utf-8?B?RnJHdEFpU2tUMXlaZE41Y2JqODhKTEQxNURLbjlnVEZoS0dqU3VzeEVoTXBE?=
 =?utf-8?B?enBDQ0J1TncxdU9lMmh6b3duamt1L0h5V0dzZlA4MGhHUDBhVWptUldPbTF1?=
 =?utf-8?B?ekhIeEVzeURlSC9wV3VUSTQrM0hLTGNuVHdrZGtZbUdraDlqUGoyUUdwUWYr?=
 =?utf-8?B?R1Rka0JHcE9QaEpHSGhvQkovUnA4SHZkVzNrc3BkdG4rbGhzd0hxZERYSGNu?=
 =?utf-8?B?d2pBcHVRd0RsbmRLdE1vekV0V1l3b2tTdkZ3WUpNMnR2bUhWL2RGTkdCRUMv?=
 =?utf-8?B?WnlxK3hJSlE1MkluUDNZN1pxVnhsc0hjN3ZEZFNQWlFabDZFS0xVYnI4VzJB?=
 =?utf-8?B?bVBRMFY4dWZvblZBbkNBcUtrOEtvb1NIN3NuMXFITGxMT3dhaTlWaXdZUzE3?=
 =?utf-8?B?RFNpMTRGM3FGN1MvdFZ2QkhvcUpnYi9NdXFMNXZBem5TdmpkUFpueWlUQXNm?=
 =?utf-8?B?TEYzNGtvbStidjU0SEh3SEhacEd6KzNON1p3TVY0QjZabmJWTmV1SmFJQ1JX?=
 =?utf-8?B?eldTRmpYRHhUaWVIZ1ZnUnA2MVQwd0JPWG1VTmJ5OWNUZy91UUIwRTNMbTdD?=
 =?utf-8?B?Rm02bldCSEN5Skp4ZzIyd3JucGxUTUswa0xhcFdtRnBNd0E2QVVvSXByTENn?=
 =?utf-8?B?a2lFWmR2T1B6YmJha21VTHNxUTdjUWhEWEgvMGZDVlVQV1ZyK09BRmZFVHVP?=
 =?utf-8?B?SllqcStqNmhCeUlkaGd2Ynd1RjlFaEl0OUNXYjVzbUhtdC9KY1k2RkNIY3Vk?=
 =?utf-8?Q?fKeVVe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUZSSzh1UDEwdlpXaGxmRWpORjZQa0JINGk2RDJ2UTZkOWdEQVZzQk5mdmE1?=
 =?utf-8?B?R2NWNWxPaE1uWWtrdjIvVVM3NHYrMXJ1YlJNNWdJOUhndGgzT0hQT0VFVjMz?=
 =?utf-8?B?V2hsenJiaTJiVFFOUy9Mb2VQSXpNd2luemQ0QTlNeUIzZ0RJNi90Qm5KRzNN?=
 =?utf-8?B?SWM1Njh3aFMyb3JDR01VOGxFbUE2aWRFTFVlNytzUGtBTGtRak5aNGtrRnR0?=
 =?utf-8?B?OXByZTJibmdIbm1rOW1XbUZZSW9qTVRXaUp3Ymx1SnpUaUl4MVVBL09SZ0NE?=
 =?utf-8?B?OVZkQ0g3SHZud0RLRDZML3ZpRjdxa0h0SWNUR3JEMm15YnNUbWUyUjk4VWhB?=
 =?utf-8?B?bWMzRTRDREhuUVd6TTE1Z2FmcE1ReVJ4U0tmaVV4YlYrTjRkb0xndzBFUGdl?=
 =?utf-8?B?L0dIWkxsUGFQdDNqY0JaMlB0MGhXR3dsQ005ZG9qS1pVOHdrOEczbUk1VEVm?=
 =?utf-8?B?cUx0c3B5TDZOUDROMGl4RllsVXFIeWdRQnpZQzBiWkZRWEpKY1FMTG1Pd25M?=
 =?utf-8?B?T3BCTU51M1BKMUUvdGpqNUYzdFB6T09NZVdrZUkzbWRNNmVGbzNtS3FEOGFY?=
 =?utf-8?B?blkvS1pibHBpVjRFM2c0TzQyS2Y3T0NnZVlPbVlFWTJET3d1Qi9lNTd6QVVJ?=
 =?utf-8?B?K2ZIVlA0WUVxRERwZ2x3Z0V2b2JiclVIWFZQRUxiWWRnV1dFK1l5UDEzYmxj?=
 =?utf-8?B?TjVjUEtMRlo2bEJPNWxXUnRzYmQzWFd2TWNxTTN4M3lXN0NmNC8rTkxMMEd1?=
 =?utf-8?B?eHZnZzF2RVY5S1BmWFhTSmRWWkh6NjRXcGlrQlI3LytsYUg1bDYrbHpCckc2?=
 =?utf-8?B?anEzZCtqRG5xK0JpcGZEVDIwa21TQnNZRFBiZ1psa0FyS2xIZXpnckJWQk9s?=
 =?utf-8?B?dVFDcnc5cWVOTDEwMWFPOXcvcUlqMmdQc0VvNFdLK0dGT3pER1NTQkQ2L240?=
 =?utf-8?B?dW1zRGJSSlVTekNzQVFrWTZIRUlaWW9WYlgwYzFyTDU5N2FPeC9XNncxbW1B?=
 =?utf-8?B?Mk5zNTZJVXZQZjg2RUVnV1hVdmsyNzdoNTV3ZlBlc2orZU5FbGZjNWZocWRF?=
 =?utf-8?B?cG9KL3dsU3lHbEVDQ1FjWTdvQW9sS01FMkNDQUJiODdvaU44VkFLc0xRaUJy?=
 =?utf-8?B?K1Jpb2oyRWpCK1cwWWIwcERBdHNSWHcwN0RYbEpLcGFxZlVBT2VKSmtkOXdX?=
 =?utf-8?B?SnI1TnhDSDZyZGN4UXBOQzVzR2liS2ZmRXFjbVRSTFNqTnBKSWZlMzIzNkMx?=
 =?utf-8?B?ZVRST1BFYVBFdWRCeGNTY2V3ejZYd05OUGVLK3dqUzltTXRpaHh5UGVvNDRk?=
 =?utf-8?B?SXZLQWFrTjM4Um9mVWtESlVpNXNDelQvVHZ6TTZnSzNpU2p2YlRRZk8wNlEr?=
 =?utf-8?B?R0lzQVRFNlhmYTE1TlV3cFZpZjhPUm15TEw2aVUyaHhvOEFQTFoyYXNJRGdB?=
 =?utf-8?B?VHVjUHBFWW5aN2RrT0ZoTVlvazBpQ3ZNZzNtWERuaE5RRXczR3Nvbk1UN2c0?=
 =?utf-8?B?dDJrOTU2djNvaWViTFF5K3l4MkhvRlVLdW1nbFE2ejFpU1hEYVlGUWFrRFBP?=
 =?utf-8?B?enlvNU1TU0R6RVFqdEErTzhzc3MrNzRZaUtCNW5CZmFUcEQzMGNqV1p3dXVY?=
 =?utf-8?B?R0FqT0w5RE9zakdhTEZidDFTb1huaDJmNTgvOEhUTjFQaWxuRlhRRURHc3NW?=
 =?utf-8?B?YXVjVTJWR3A2WlhRaVMwRDRzM3l0T2dhVlRudDJrSlVkVGVPTUFvTXhvcDJq?=
 =?utf-8?B?d0E4bWNGNlNrNHZmd2FzbWpwMUpDUXZSd1ZkNnVlUlArY3hLcjhvTk1LN3lR?=
 =?utf-8?B?MDNEYUdyOERmT2Z5Snc3akxUS1V2bWV5UnVkeXFYNUxMU21YRTZhOHhMV1B4?=
 =?utf-8?B?WStXc3QrMmZ4ZDl6ZEJNdytFZWV6aHpnR1VoQnR1YWxiaHlhZzEwQU1UTWFF?=
 =?utf-8?B?LzIyM0Zsb09CaC9TcGJJVkNwa25WNitEbDdGZmhMWGRKaElJU09ZYUJGUVlI?=
 =?utf-8?B?MEk4V0owT3BjTllmTU95SlpiL3RsclpYNFR4QmFGd2JadGtvY1VsVDVYOUg1?=
 =?utf-8?B?VlpXSHkxZkx2RmcwZXprYlRuZDNsUU9sUERIMkYyZ3hoS3Y2Nm9HSzRNT0FF?=
 =?utf-8?Q?5Wpbvn9ugiNZvCSWbZXqaGPPG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03009df-2482-432e-c74a-08de3366ebf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 18:57:07.1401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3avAdOSFOHeH5KuMyrKVHh8+VfGJi42FRQvhFR6wKNxdOjoMUbjVru1/Zh2H0S3tEkrua8QnLKJEUyPk7dqvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA0IERlY2VtYmVyIDIwMjUgMTY6
MzkNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVt
dS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmlj
b2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBi
ZXJyYW5nZUByZWRoYXQuY29tOw0KPiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsg
TWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2Fu
Z3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBLcmlzaG5ha2FudCBKYWp1
IDxramFqdUBudmlkaWEuY29tPjsgTWljaGFlbCBTIC4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTYvMzNdIGh3L3BjaS9wY2k6IEludHJvZHVjZSBh
IGNhbGxiYWNrIHRvIHJldHJpZXZlIHRoZQ0KPiBNU0kgZG9vcmJlbGwgR1BBIGRpcmVjdGx5DQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KDQouLi4NCiANCj4gPiAtLS0gYS90YXJnZXQvYXJtL2t2bS5jDQo+ID4gKysrIGIvdGFy
Z2V0L2FybS9rdm0uYw0KPiA+IEBAIC0xNjIwLDI2ICsxNjIwLDQyIEBAIGludCBrdm1fYXJjaF9m
aXh1cF9tc2lfcm91dGUoc3RydWN0DQo+IGt2bV9pcnFfcm91dGluZ19lbnRyeSAqcm91dGUsDQo+
ID4gICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAgIC8qDQo+ID4g
KyAgICAgKiBXZSBkbyBoYXZlIGFuIElPTU1VIGFkZHJlc3Mgc3BhY2UsIGJ1dCBmb3Igc29tZSB2
SU9NTVUNCj4gaW1wbGVtZW50YXRpb25zDQo+ID4gKyAgICAgKiAoZS5nLiBhY2NlbGVyYXRlZCBT
TU1VdjMpIHRoZSB0cmFuc2xhdGlvbiB0YWJsZXMgYXJlIHByb2dyYW1tZWQgaW50bw0KPiA+ICsg
ICAgICogdGhlIHBoeXNpY2FsIFNNTVV2MyBpbiB0aGUgaG9zdCAobmVzdGVkIFMxPWd1ZXN0LCBT
Mj1ob3N0KS4gUUVNVQ0KPiBjYW5ub3QNCj4gPiArICAgICAqIHdhbGsgdGhlc2UgdGFibGVzIGlu
IGEgc2FmZSB3YXksIHNvIGluIHRoYXQgY2FzZSB3ZSBvYnRhaW4gdGhlIE1TSQ0KPiA+ICsgICAg
ICogZG9vcmJlbGwgR1BBIGRpcmVjdGx5IGZyb20gdGhlIHZJT01NVSBiYWNrZW5kIGFuZCBpZ25v
cmUgdGhlDQo+IGdJT1ZBDQo+ID4gKyAgICAgKiBAYWRkcmVzcy4NCj4gPiArICAgICAqLw0KPiA+
ICsgICAgaWYgKHBjaV9kZXZpY2VfaW9tbXVfbXNpX2RpcmVjdF9ncGEoZGV2LCAmZG9vcmJlbGxf
Z3BhKSkgew0KPiA+ICsgICAgICAgIGdvdG8gc2V0X2Rvb3JiZWxsOw0KPiA+ICsgICAgfQ0KPiA+
ICsNCj4gPiAgICAgIC8qIE1TSSBkb29yYmVsbCBhZGRyZXNzIGlzIHRyYW5zbGF0ZWQgYnkgYW4g
SU9NTVUgKi8NCj4gPg0KPiA+IC0gICAgUkNVX1JFQURfTE9DS19HVUFSRCgpOw0KPiA+ICsgICAg
cmN1X3JlYWRfbG9jaygpOw0KPiB3aGF0IGlzIHRoZSByYXRpb25hbGUgYmVoaW5kIHRoZSBSQ1Ug
Y2hhbmdlcz8NCj4gDQoNCk90aGVyd2lzZSwgaXQgd2lsbCBjcmFzaCBpZiB0aGlzIGZuIHJldHVy
bnMgdmlhIHRoZSBnb3RvIHNldF9kb29yYmVsbCBwYXRoDQp3aXRoLA0KDQppbmNsdWRlL3FlbXUv
cmN1Lmg6MTAxOiByY3VfcmVhZF91bmxvY2s6IEFzc2VydGlvbiBgcF9yY3VfcmVhZGVyLT5kZXB0
aCAhPSAwJyBmYWlsZWQNCg0KZ290byBzZXRfZG9vcmJlbGwgcGF0aCBza2lwcyBvdmVyIHRoZSBz
Y29wZSB3aGVyZSBSQ1VfUkVBRF9MT0NLX0dVQVJEKCkgDQppcyBhY3RpdmUuIFdoZW4gdGhlIGZ1
bmN0aW9uIGxhdGVyIHJlYWNoZXMgcmN1X3JlYWRfdW5sb2NrKCkgaW1wbGljaXRseSB2aWENCmRl
c3RydWN0b3IsICB0aGUgZ3VhcmQgd2FzIG5ldmVyIGVudGVyZWQsIHNvIHdlIGhpdCBhYm92ZS4N
Cg0KQW4gYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8gd3JhcCB0aGUgdHJhbnNsYXRpb24gbG9naWMg
aW4gaXRzIG93biBibG9jaywgbGlrZQ0KDQogICAgaWYgKHBjaV9kZXZpY2VfaW9tbXVfbXNpX2Rp
cmVjdF9ncGEoZGV2LCAmZG9vcmJlbGxfZ3BhKSkgew0KICAgICAgICAgZ290byBzZXRfZG9vcmJl
bGw7DQogICAgfQ0KDQogICAgew0KICAgICAgICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7DQogICAg
ICAgLyogTVNJIHRyYW5zbGF0aW9uIGxvZ2ljICovDQogICAgfQ0KDQpzZXRfZG9vcmJlbGw6DQog
ICAgcm91dGUtPnUubXNpLmFkZHJlc3NfbG8gPSBkb29yYmVsbF9ncGE7DQogICAgcm91dGUtPnUu
bXNpLmFkZHJlc3NfaGkgPSBkb29yYmVsbF9ncGEgPj4gMzI7DQogICAgcmV0dXJuIDA7DQoNCk9y
IGNvdWxkIGRvOg0KDQppZiAoIXBjaV9kZXZpY2VfaW9tbXVfbXNpX2RpcmVjdF9ncGEoZGV2LCAm
ZG9vcmJlbGxfZ3BhKSkgew0KICAgIFJDVV9SRUFEX0xPQ0tfR1VBUkQoKTsNCiAgICAvKiB0cmFu
c2xhdGlvbiBsb2dpYyAqLw0KfQ0Kcm91dGUtPnUubXNpLmFkZHJlc3NfbG8gPSBkb29yYmVsbF9n
cGE7DQpyb3V0ZS0+dS5tc2kuYWRkcmVzc19oaSA9IGRvb3JiZWxsX2dwYSA+PiAzMjsNCnJldHVy
biAwOw0KDQpCb3RoIGFwcHJvYWNoZXMgd29yaywgYnV0IEkgZmluZCB0aGUgZXhwbGljaXQgbG9j
ay91bmxvY2sgdmFyaWFudCBlYXNpZXINCnRvIGZvbGxvdy4gUGxlYXNlIGxldCBtZSBrbm93IGlm
IHRoZXJlIGlzIGEgYmV0dGVyIHdheS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

