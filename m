Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B226CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 07:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvWVc-0001RH-8u; Mon, 08 Sep 2025 03:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvWVV-0001Pw-KP; Mon, 08 Sep 2025 03:41:46 -0400
Received: from mail-dm6nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2413::616]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvWVF-0004pY-Ds; Mon, 08 Sep 2025 03:41:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWt/meylPa3sccsBahnMi5PjLYkuaf541m8+YUJyeH/joX8TLHYE6ch0AMQLVFmKzyE+VW8lVM/QAPXOLyoGD3WN+vwtik+Rzxl3M7GvuUt70Ho62ek6y3JQheF8L74vk+kzbGR75awR7g3lIcysctvUqnPtLXstnJclMuPt9kPe8smqyy32eDBNCrz20eaGL4WnSFPx7sHsUi/p9JAHFWxQ7lfD6q2ZezQ2QwTXqqFrk7ggy33XoeJrSw5zcSfFO4nX3BBJSWT7S97eYwRcgytjv3nh/NC8a/22a8I7JA4urFJQFqapKpa4gecH3y8c/PB+cKG90+SulgYnEeOcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl5+ftKpOtSeAo04ydCH7YC+sd19tPv8doWKdCPgiJQ=;
 b=bNFprPUvhp+a2mxx0+zeg3CUJ/opNKq8G1AQaOwGLi+TgB31htmpCGEGgqVpxhAzL6nCzuNBeXR9I1UuRitOO2GWSYR6UOzNJvz+UDNeXoWKKMJ0ewAVRoV+DDA4RINNqit/AIGxDbXJjYfaPDfdek8humhFfpdAip4B0ZDH3TB6jlBAmH427yDczHzUIWJcqBWJ7uo6zEouMNcb6GXFQ3q6VlDoD2xT/gapcNwzpYj5nzQFomGmd8X/fYgdZBvD3ZwfrX2mIWgjPITR+wl5UIu6BcpySkes1DbsGc1fRJ0yRxnrEjK8IlkMBZubLP+e9EacsLQjxSJ0JjXYh6/VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl5+ftKpOtSeAo04ydCH7YC+sd19tPv8doWKdCPgiJQ=;
 b=CluO9FbkqMet47STGJLGltgExcY9GAEboKpYt+hRFNcVRJHfrCtgZ341tnQxTmS59Eqaybhqim9DGvrYPuneV6B3PrMP7uGoSZ1p7xlp9Ak+NjThzAXrsHVtmBgw3F2pNBRX8KTIY3FsY6tOqep4Ui991fifueY9EoX/q5NakZVxLhd8drkm/xab7/rk1g3Tdzei7+XqIppodfqU//HNL8M+R2/8x//WLZ796hJr+w8nNQwQ10JN8jCST+HUQTR+zX7K8/l3QDtvScIWdjASqvJMTgxDXIG/Jxa/xipdt75Sx7CDmG1fj+bZwgRutYinveeUxibfA/tH/yiNaTAq9g==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:41:09 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 07:41:09 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcHj0uyZvN/mVpTUewNZT1jGrd9rSI5Z+A
Date: Mon, 8 Sep 2025 07:41:09 +0000
Message-ID: <IA0PR12MB7555BC2CAE15B3D7DF216196AB0CA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f0b2123a-f7cb-42bf-a7b0-ba326149fcf4@redhat.com>
In-Reply-To: <f0b2123a-f7cb-42bf-a7b0-ba326149fcf4@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DS5PPF4ACC15C0E:EE_
x-ms-office365-filtering-correlation-id: 606e8b87-c376-40f0-9d33-08ddeeab138a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bG9PNWFsRFRlcGIvNGIxQzYwVTQyaDJEVS9CQ0xEaXdlVmhQbmkzcERkK3Ix?=
 =?utf-8?B?emsvR0cwekNlUjJGbXlzOVVWVHhiUTVpNFA2TmpsVVZNUkJHSU0xZExWelN5?=
 =?utf-8?B?MlY0bGtPdnZBaUFyQ0N3ejJjMnhCc0VvZnpSRHR6bmF0V2ZmWmVXRldNempi?=
 =?utf-8?B?aDA3bEhUbmxqWWVQQkhKRzJhbDZmc0xOQTFJaWtwR3FMUlM3VWJzVlM0QnZZ?=
 =?utf-8?B?aEs3ZUxmQ2J2Y2lYdVRxS0tYOWFvUmIyWXZMNERpMXk4RlRPVjBTVEI2SFF1?=
 =?utf-8?B?V2RUWGdPRVp0V0hkdDdUZytFdTdtSFdJTjFqbmVRZ1JaNGxCbGFVZEV3VTRY?=
 =?utf-8?B?NjlvcjNpR1Q2ZVVoU3JWZTFTcWs2ZDBPcHllT0U4K3NYQmszdFFXV3psOTlW?=
 =?utf-8?B?K0FYWGJaUFVVM29QOU5WZTBmYmN0Ny9FZDJ2UXo4WkcydzlZaEg5QkNhNjdp?=
 =?utf-8?B?bWliMXJtM0FzOCt2aVVFdHNiYmFyd3B6TW5mTEJzbXVtNE1Uak9RR3N0c1Ft?=
 =?utf-8?B?NHpVUzRKUlhvNUxCQjZkenNoSDNSQ3ROUkpVeHh4djlsMVJlMDBlR1hBVGVZ?=
 =?utf-8?B?NXFTOGZGOVVmUWdleWloRWxtTEZOazVhd1RXcllBcGljY3BRT3plVHlucERR?=
 =?utf-8?B?VmFpSDJ4WExRRFBDb1htRG1LeDhSRnFXSDRCZHA3bDl5QmZPTDQvdFJLc2s3?=
 =?utf-8?B?bnd5SnpNNngzMzNQME05Sm15V0VEWWlHd2JydWI5SE40Lzh3ZlBsZmVBalA4?=
 =?utf-8?B?dmNOVHJ3czFvdW1ZMlNyK04rdUladUpOWWROU1YzOGxwYXNLUnBBdHRYVnZr?=
 =?utf-8?B?S1VkQnVsRHEwaTBRcDFWUW51OXNWUXBhYk4xSWlycCtUTzgveWxnNUcwN3hx?=
 =?utf-8?B?aUJNcm8rc05WNC9FRFpsSzRjUlYrV2xndDk5VDg0UDBwdkw2ZnY1SUR5dzRE?=
 =?utf-8?B?MjlnbzFldk04VlhQQ3pBVXh1TVdYTVFOUFc1TlJuWEllRjJVRUVUdmR5bFhp?=
 =?utf-8?B?cHRtdm1PTy9iVXhPdmV1ejRqbW9Ca21hQ0VXNTNVTzdNUE0vWTBlR2JFTlJj?=
 =?utf-8?B?WjFqUFNHbzhaT3VLTC8zWW1uQlFDb05SamlXWlpCWjgyQnI2YWVZQkZUdnp6?=
 =?utf-8?B?WjJHb2ZxV3JHa283T0xoYWpGdytwTGtabFlBQ2MyYUZKRnh5VzhJUWo1dGww?=
 =?utf-8?B?UnBBSTB0cit1bk0xanBTTTFSMGtnZmhWVGVCZTgrWWVqT3RzZ21pZFNJUVdZ?=
 =?utf-8?B?RmJjNjc1NUMya3oxNUk4OTZ0ajlUVGdEcTVkajZtV3dCaGdIM2dJV09pUlIy?=
 =?utf-8?B?YjN3Qlk5QmgvK0FIY1pRZGF2Slk3RDJFRnc1QWFiYzFoaTlheGtzM3hoNFds?=
 =?utf-8?B?Q0dTV0dWZjR1UVhjUjZaamVXcXVJOHZzQ2lteFZWMXM1UGZ5Q2V0eDRtZFNT?=
 =?utf-8?B?YXRsTzQxd084R0QyYytLSUV3UmhqZDFuNzFkL0trRmw2MXJ3RGx3UThWNzVW?=
 =?utf-8?B?QzhhbG1Hd0Zrc3pwN2NjbDBPNWgycmNtNis1RWdjMS94ZVNFUjdJdzVQbFQ2?=
 =?utf-8?B?cml6blUyTW9Qb09oUURLQ1RMdHFOWkxSYkpUM1luN2tKN2tTVkRveTNFQU1B?=
 =?utf-8?B?REhCUk9SNVBuNTREYmd5eWZJelI0UWVvcFk3dGtuVStDOU43Tm0xT0RmajdU?=
 =?utf-8?B?WVl4MXdsWWFDMHE4dVI3WjA4MWZPYVVGSkhQTkhHTE5QMG5vWnNOaDl3MkMz?=
 =?utf-8?B?TUFRbW9HWUFlQWpoWDdoWTNRMm5hbG1DWE1RWFh0Y2czdnRUV01obHdRYUxW?=
 =?utf-8?B?UEY0cW9BRnFzOUFheUNYVll3NnduL2NjaFRMNWF4d2tmSkJGQ2hZZld2TXRv?=
 =?utf-8?B?WmpERzJTMnU4d2UvVU91UTZDNGlzSG9sUHQrbWlyMkhXUVNJK0l6T1RWWjlw?=
 =?utf-8?B?VnhkeHFsWFV2cDlEUzlpZDExOGF1K2pFU2JmSkh3R2VoVS9SNU1FVXVSTjg2?=
 =?utf-8?B?K212eEM5eHBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9SWWZJSmlsZHhjR2tUOWZpYUtFd1V4Rlc3OVB4aERNSWEydjM1cEFIdlpJ?=
 =?utf-8?B?NXk5VkZ4VE91YUlaZW9KeHQ1WmM2SUhOY29LZzBia3lpT2Ixck11MWNqaTFk?=
 =?utf-8?B?Slh0Mm52WFYwdGZOL1VjSXkwSGlLVUowVUc4RXNKNnYzWksyVXkvNkNmK3lk?=
 =?utf-8?B?M0RONVhDcXhVTlhja09qSlgvcDloeTVTdVdFdzVrdDEwUExrQ3dSVHQxZTZr?=
 =?utf-8?B?d1k2c1JoVnpUK3dqZThtYzZiYkhMSCtUOXZTWUxnNFlzbFNpRzNLRTZEbGlv?=
 =?utf-8?B?OXhuM29sVjg0MWx2Q0J4K3hVcEZzQkswWnlNN2I1aWV3VGhiNDc3SHRJVFJL?=
 =?utf-8?B?ekNyYjZwR3B0emFEbWEzQjBhLzFZbmEza2xzSUtUd3dlNnM2TEZCVWpuSUpZ?=
 =?utf-8?B?alR2ckZ1a0FHNFRYMWtOM3Q3dU1JSWMyUFhkVU1qNVZjK0xmZjRZa0xjczZl?=
 =?utf-8?B?c3FlWXo0NE1qT0FRaXVDbmtmWklKa2lwU1JlSmZLYmhxNko0dDJab1luWFlp?=
 =?utf-8?B?WmdIWkUyVGJXOGlSd0pCQ2ZIZ0ExNVpBZTFsY2NCeVV5OC9Eb3d4QXd2WU9k?=
 =?utf-8?B?ZEVRQ21Yem5TTHh5QkVDaDVLNUMyWUZpdnRVdDF3UjNDc0dLL3pjMWdDVWNl?=
 =?utf-8?B?OTFVUUxWczQxcWFhSFc2L1ljWmJwUXhQYk5FSVJTM2tjL1IvQit3bjU1a0xi?=
 =?utf-8?B?c0JUeVZHeXU5SmhONDc1bmFoQjN4bFhnb3pkdUl0eTZCSmd0d3pnWVRTdjdC?=
 =?utf-8?B?eWYzZjBub2dISWI3OU1vMzkwMmdkdFM3VkRFbWo4NWVRVTlkanhXN2Q5Qnc4?=
 =?utf-8?B?ZGlXdHNBeVNydkVjcEtDS2pNQWVLK1BRMVVpRTRyWjI3dlhycVZGbjRGaWFK?=
 =?utf-8?B?Qy9CTUJ6M2ttMWVXM1J3S0dYT1FYbHBsTkRnZmpvN3IzWVptRm94TGNVOVBQ?=
 =?utf-8?B?WHlXKzVvSGZxQ3kvUmFyRCtFQWpiUzhHbCtZa3dqTWd5OFl3VUFYWGlmVHI0?=
 =?utf-8?B?VElJRE4yYmswZGNlZTd5Mkt1aU1wblFhZG41elp3NTV5dGpJVlZzY3BiRUlX?=
 =?utf-8?B?c09EcmZ4cXA3dGRmZHJ5L2xHWjhTWHF2VlFidWVVVmpDcUkwTWVjUk9BS1Fi?=
 =?utf-8?B?VkdabSt5Q0NmQS9ZK3puYnp0SzhkT1RJY3htZGxqY2lUWC84eWVPRnB0Q0ta?=
 =?utf-8?B?NHFSWnl1eTIwQWFEM0FmeU9LeGFwdUxrUG5MK2xGVHRCT3RMZzBJcWljK1hJ?=
 =?utf-8?B?c0tTWDBCYmVuSzNIZ3k0ZVo5bnJBNXdPM1owYWhGbElLbXY3bG9GbkJDd09a?=
 =?utf-8?B?Um1yRklqRWlaL1QzOXN6ZDVzU2hsMDZYQ1JuZ1c3Q0ptVGgzWGNFUzdUbUI4?=
 =?utf-8?B?Y25CelVGMHNpb1RDdDVXYnBQdkNRbEVaS0xyalBnbTZtZ1NaN0ErZzhGcDE2?=
 =?utf-8?B?SzE1L25TOUpjYkpNdnRKZFZrOFp4N2VFYk4va3BBMWQvNGpielQ2M3l4Z0VF?=
 =?utf-8?B?T1g5clRoNWU1aEcwd1p6ck5ncTRHNGpsTFIrekk0UkFFZVZUSGZhdTBKbnB5?=
 =?utf-8?B?a2RuNVZqTkVmRUJwajQwb2N2WVpYb1FqL013bFBhdnA5ei9NM1BPdTU5Mko1?=
 =?utf-8?B?MXZZVnllY3dsbytLQUcyYmxVdm80Zjg1Y1dlZ08yZElLby9wdUFkV1UyMUtz?=
 =?utf-8?B?RGVjWm9uZjhwalRLV1UwMk9SVWk3Yk01QVBQYVVvNlpFQlpMVlZWZ3NCT2o0?=
 =?utf-8?B?MDc4d3VURkt1Qll1cDEzaUdNMzhYYWsvdXZhSjVjUEdYQUxtcTZDZUl4L1pi?=
 =?utf-8?B?dFBzQ3dPd0RhQ3dCS3oySHovZ292dVNRZHJzQ1RmN3g2YTNwRUJkcVNPV1FH?=
 =?utf-8?B?Q0kvS2xxTlg3a2l5VDQ4aVhYL0JXYlNlYnVBbjVqaGlSdXFRTyt0bkNLSjRB?=
 =?utf-8?B?YW45a1BQYTVlNzZQK0I3a2xqUWJGdjZsVGFldENmUnBKSmowMnpBME5acmpq?=
 =?utf-8?B?YlVhUHB0N3dlc05wYjRjbFhRYUJyNU92RmJObng4d0pYc0RIUDZCU3NKaTUr?=
 =?utf-8?B?dUoxOE8vTkgvcnlJU3F6UXR5aFRnelFMSldCZTg3MGFwcDk0cGIvMFRzM3hs?=
 =?utf-8?Q?ByfRptotSHvDwVYd+bNUQ0ODn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606e8b87-c376-40f0-9d33-08ddeeab138a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 07:41:09.0792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmBxiiR6a808u719O7F60LpeOF14EIJXV0TA9QE8REuNDXPOZQtse8rtIx+LJhWi8FGRJnuQj5hY1FGGYzSFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
Received-SPF: permerror client-ip=2a01:111:f403:2413::616;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=2.131,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA1IFNlcHRlbWJlciAyMDI1IDA5
OjE1DQo+IFRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IE5p
Y29saW4gQ2hlbg0KPiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IFNoYW1lZXIgS29sb3RodW0gPHNr
b2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1k
ZXZlbEBub25nbnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRo
b3JwZSA8amdnQG52aWRpYS5jb20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJl
ZGhhdC5jb207IE5hdGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMg
PG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyBsaW51eGFybUBodWF3
ZWkuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNv
bTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9y
Zzsgc2hhbWVlcmtvbG90aHVtQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2
MyAwNi8xNV0gaHcvYXJtL3NtbXV2My1hY2NlbDogUmVzdHJpY3QgYWNjZWxlcmF0ZWQNCj4gU01N
VXYzIHRvIHZmaW8tcGNpIGVuZHBvaW50cyB3aXRoIGlvbW11ZmQNCj4gDQoNClsuLl0NCj4gPj4+
PiBzdGF0aWMgQWRkcmVzc1NwYWNlICpzbW11djNfYWNjZWxfZmluZF9hZGRfYXMoUENJQnVzICpi
dXMsIHZvaWQNCj4gPj4+PiAqb3BhcXVlLA0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2Zm4pDQo+ID4+Pj4gew0KPiA+Pj4+ICsgICAg
UENJRGV2aWNlICpwZGV2ID0gcGNpX2ZpbmRfZGV2aWNlKGJ1cywgcGNpX2J1c19udW0oYnVzKSwg
ZGV2Zm4pOw0KPiA+Pj4+ICAgICBTTU1VU3RhdGUgKmJzID0gb3BhcXVlOw0KPiA+Pj4+ICsgICAg
Ym9vbCB2ZmlvX3BjaSA9IGZhbHNlOw0KPiA+Pj4+ICAgICBTTU1VUGNpQnVzICpzYnVzOw0KPiA+
Pj4+ICAgICBTTU1VdjNBY2NlbERldmljZSAqYWNjZWxfZGV2Ow0KPiA+Pj4+ICAgICBTTU1VRGV2
aWNlICpzZGV2Ow0KPiA+Pj4+DQo+ID4+Pj4gKyAgICBpZiAocGRldiAmJiAhc21tdXYzX2FjY2Vs
X3BkZXZfYWxsb3dlZChwZGV2LCAmdmZpb19wY2kpKSB7DQo+ID4+Pj4gKyAgICAgICAgZXJyb3Jf
cmVwb3J0KCJEZXZpY2UoJXMpIG5vdCBhbGxvd2VkLiBPbmx5IFBDSWUgcm9vdCBjb21wbGV4DQo+
ID4+Pj4gZGV2aWNlcyAiDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICJvciBQQ0kgYnJp
ZGdlIGRldmljZXMgb3IgdmZpby1wY2kgZW5kcG9pbnQNCj4gPj4gZGV2aWNlcw0KPiA+Pj4+IHdp
dGggIg0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAiaW9tbXVmZCBhcyBiYWNrZW5kIGlz
IGFsbG93ZWQgd2l0aA0KPiA+Pj4+IGFybS1zbW11djMsYWNjZWw9b24iLA0KPiA+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICBwZGV2LT5uYW1lKTsNCj4gPj4+PiArICAgICAgICBleGl0KDEpOw0K
PiA+Pj4gU2VlbXMgYWdncmVzc2l2ZSBmb3IgYSBob3RwbHVnLCBjb3VsZCB3ZSBmYWlsIGhvdHBs
dWcgaW5zdGVhZCBvZiBraWxsDQo+IFFFTVU/DQo+ID4+IEhvdHBsdWcgd2lsbCB1bmxpa2VseSBi
ZSBzdXBwb3J0ZWQgd2VsbCwgYXMgaXQgd291bGQgaW50cm9kdWNlDQo+ID4+IHRvbyBtdWNoIGNv
bXBsaWNhdGlvbi4NCj4gPj4NCj4gPj4gV2l0aCBpb21tdWZkLCBhIHZJT01NVSBvYmplY3QgaXMg
YWxsb2NhdGVkIHBlciBkZXZpY2UgKHZmaW8pLiBJZg0KPiA+PiB0aGUgZGV2aWNlIGZkIChjZGV2
KSBpcyBub3QgeWV0IGdpdmVuIHRvIHRoZSBRRU1VLiBJdCBpc24ndCBhYmxlDQo+ID4+IHRvIGFs
bG9jYXRlIGEgdklPTU1VIG9iamVjdCB3aGVuIGNyZWF0aW5nIGEgVk0uDQo+ID4+DQo+ID4+IFdo
aWxlIGEgdklPTU1VIG9iamVjdCBjYW4gYmUgYWxsb2NhdGVkIGF0IGEgbGF0ZXIgc3RhZ2Ugb25j
ZSB0aGUNCj4gPj4gZGV2aWNlIGlzIGhvdHBsdWdnZWQuIEJ1dCB0aGluZ3MgbGlrZSBJT1JUIG1h
cHBpbmdzIGFyZW4ndCBhYmxlDQo+ID4+IHRvIGdldCByZWZyZXNoZWQgc2luY2UgdGhlIE9TIGlz
IGxpa2VseSBhbHJlYWR5IGJvb3RlZC4gRXZlbiBhbg0KPiA+PiBJT01NVSBjYXBhYmlsaXR5IHN5
bmMgdmlhIHRoZSBod19pbmZvIGlvY3RsIHdpbGwgYmUgZGlmZmljdWx0IHRvDQo+ID4+IGRvIGF0
IHRoZSBydW50aW1lIHBvc3QgdGhlIGd1ZXN0IGlvbW11IGRyaXZlcidzIGluaXRpYWxpemF0aW9u
Lg0KPiA+Pg0KPiA+PiBJIGFtIG5vdCAxMDAlIHN1cmUuIEJ1dCBJIHRoaW5rIEludGVsIG1vZGVs
IGNvdWxkIGhhdmUgYSBzaW1pbGFyDQo+ID4+IHByb2JsZW0gaWYgdGhlIGd1ZXN0IGJvb3RzIHdp
dGggemVybyBjb2xkLXBsdWdnZWQgZGV2aWNlIGFuZCB0aGVuDQo+ID4+IGhvdC1wbHVncyBhIFBB
U0lELWNhcGFibGUgZGV2aWNlIGF0IHRoZSBydW50aW1lLCB3aGVuIHRoZSBndWVzdC0NCj4gPj4g
bGV2ZWwgSU9NTVUgZHJpdmVyIGlzIGFscmVhZHkgaW5pdGVkPw0KPiA+IEZvciB2dGQgd2UgZGVm
aW5lIGEgcHJvcGVydHkgZm9yIGVhY2ggY2FwYWJpbGl0eSB3ZSBjYXJlIGFib3V0Lg0KPiA+IFdo
ZW4gaG90cGx1ZyBhIGRldmljZSwgd2UgZ2V0IGh3X2luZm8gdGhyb3VnaCBpb2N0bCBhbmQgY29t
cGFyZQ0KPiA+IGhvc3QncyBjYXBhYmlsaXR5IHdpdGggdmlydHVhbCB2dGQncyBwcm9wZXJ0eSBz
ZXR0aW5nLCBpZiBpbmNvbXBhdGlibGUsDQo+ID4gd2UgZmFpbCB0aGUgaG90cGx1Zy4NCj4gPg0K
PiA+IEluIG9sZCBpbXBsZW1lbnRhdGlvbiB3ZSBzeW5jIGhvc3QgaW9tbXUgY2FwcyBpbnRvIHZp
cnR1YWwgdnRkJ3MgY2FwLA0KPiA+IGJ1dCB0aGF0J3MgTmFrZWQgYnkgbWFpbnRhaW5lci4gVGhl
IHN1Z2dlc3RlZCB3YXkgaXMgdG8gZGVmaW5lIHByb3BlcnR5DQo+ID4gZm9yIGVhY2ggY2FwYWJp
bGl0eSB3ZSBjYXJlIGFuZCBkbyBjb21wYXRpYmlsaXR5IGNoZWNrLg0KPiA+DQo+ID4gVGhlcmUg
aXMgYSAicGFzaWQiIHByb3BlcnR5IGluIHZpcnR1YWwgdnRkLCBvbmx5IHdoZW4gaXQncyB0cnVl
LCB0aGUgUEFTSUQtDQo+IGNhcGFibGUNCj4gPiBkZXZpY2UgY2FuIHdvcmsgd2l0aCBwYXNpZC4N
Cj4gPg0KPiA+IFpoZW56aG9uZw0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIGFuIG9wdGlv
biBub3QgdG8gc3VwcG9ydCBob3RwbHVnLiBJIGFncmVlIHdpdGgNCj4gWmhlbnpob25nLCB3ZSBz
aGFsbCB0cnkgdG8gYWxpZ24gd2l0aCB0aGUgd2F5IGl0IGlzIGRvbmUgb24gaW50ZWwtaW9tbXUN
Cj4gYW5kIHN0dWR5IHdoZXRoZXIgaXQgYWxzbyBmaXRzIHRoZSBuZWVkcyBmb3IgYWNjZWxlcmF0
ZWQgc21tdS4NCg0KSG90cGx1ZyBpcyBzdXBwb3J0ZWQuIFRoZSBvbmx5IGN1cnJlbnQgcmVxdWly
ZW1lbnQgaXMgdGhhdCB3ZSBuZWVkIGF0IGxlYXN0DQpvbmUgY29sZC1wbHVnZ2VkIGRldmljZSB0
byByZXRyaWV2ZSB0aGUgaG9zdCBTTU1VdjMgZmVhdHVyZXMuIFRoZXNlIGFyZQ0KdGhlbiB1c2Vk
IHRvIHVwZGF0ZSB0aGUgdlNNTVV2MyBmZWF0dXJlcyBkdXJpbmcgdGhlIHJlc2V0IHBoYXNlIHNv
IHRoYXQNCnRoZSBHdWVzdCBjYW4gcHJvYmUgdGhlbSBhdCBib290Lg0KDQpCYXNlZCBvbiB0aGUg
ZGlzY3Vzc2lvbnMgaW4gdGhpcyBzZXJpZXMsIHdlIHBsYW4gdG8gcmVtb3ZlIHRoYXQgZGVwZW5k
ZW5jeQ0KZ29pbmcgZm9yd2FyZC4gSW5zdGVhZCwgdGhlIGFjY2VsZXJhdGVkIHZTTU1VdjMgd2ls
bCBiZSBpbml0aWFsaXplZCBiYXNlZA0Kb24gdGhlIGN1cnJlbnQgZW11bGF0ZWQgU01NVXYzIGZl
YXR1cmVzLCBwbHVzIGFueSBhZGRpdGlvbmFsIGZlYXR1cmVzDQpzcGVjaWZpZWQgYnkgdGhlIHVz
ZXIgb24gdGhlIGNvbW1hbmQgbGluZS4NCg0KRHVyaW5nIGV2ZXJ5IGRldmljZSBhdHRhY2htZW50
IHRvIHRoZSBhY2NlbGVyYXRlZCBTTU1VdjMsIHdlIHdpbGwNCmNyb3NzLWNoZWNrIGZvciBhbnkg
ZGlzcGFyaXRpZXMgYW5kIGFsbG93IG9yIGRpc2FsbG93IHRoZSBhdHRhY2htZW50DQphY2NvcmRp
bmdseS4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBzZWUgYW55IGRyYXdiYWNrcyB3aXRo
IHRoaXMgYXBwcm9hY2guDQoNClRoYW5rcywNClNoYW1lZXINCgkNCg0KDQoNCg==

