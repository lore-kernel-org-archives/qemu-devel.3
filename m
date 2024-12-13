Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF38E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM91b-0001pt-FE; Fri, 13 Dec 2024 12:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tM91M-0001lQ-SD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:00:09 -0500
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com
 ([40.107.93.73] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tM91K-00029o-4m
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:00:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfGN7Pf3D58T5tftJJQ4Xlwl3HHwKck4JudpWr/4fXGNoB1tEWPwh8/8vlLN/Oem6RY6k/NfzCdmuETgkDJLSzoA+jaodvIK/VJlMYT0SDFUYQeSlkMLF3HMYEdIfI3hCY6nShjr63jUR6ZqpQT6L2bcqpb8AWyx+8z4Bss0E+48oyBhYMvfrqcsrLh67QloSijKikMM/jw5AU3Q5E0PHliEVSGBn5nT/bzW6skNHjKUByI+alcI8jw6wpNVFqmeTEnW6QsOG2tEhxeFUYTdIi977wC5q5zaALL6Qe8kU+aMusbYuwBLDvUPOmGQ03h4axgOIB4KRJ5kByIAHi0UEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ognMkzgm5Eo3xNG8WPA2UuQt3zSnlcTvfv9uLaY0Kvk=;
 b=WypoWTpjcIeOOi0Tp8bx2dNm1/UPmABteXGPSHzvfSDCuXQ1sZGVd4pFC2fwCLBnM0jzXD6QfC+U7tnL5ZgmjLw9OX5ogWxdCS3MONb2Yh3zX8p+eI8b2tEvuQknxu7JTixIPkvsvPoBhS1trm5cvQ7KOuhETV8WeILUZ/eceeVXmhET8C+uzOvO0O6RM8Mq7j/DNzXJvJzJ4lKxWiN7C383ZgG9RDvT2Qe2RJZDr+XZg6lpxTWcpcrTbqzi9nCzRzJd3xSY9dnd9P49QoIq+8+0J/B+Rs51ims4MpO2RMKzalX6ba+drlfHjdBY9x61ySy+KJ2OC/G11wfhMpuhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ognMkzgm5Eo3xNG8WPA2UuQt3zSnlcTvfv9uLaY0Kvk=;
 b=xj3lwZY4vbNJneywO3O2p7O/Hq89faoNtqhWDy4EjJsbcJPRVxqPa5dsq3QZ0QegFQ8YRIVdNDkZ66QjZzcg0cyDxv1FaiVWSbXsOH8jYkv9srQZooaQasH27LYq/RJE5cgwG3+dZ6UlBJoqCesfX6+YtqxaZ37NXaKj2RzRYX4=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Fri, 13 Dec
 2024 16:54:59 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:54:59 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH] hostmem-file: add the 'hmem' option
Thread-Topic: [PATCH] hostmem-file: add the 'hmem' option
Thread-Index: AQHbRm+T08edT93tD0m94+3Dx5+wM7LZAIAAgAB6QhCABPYygIABblGQgAAOkYCAABsxEIAACFCAgARgqvA=
Date: Fri, 13 Dec 2024 16:54:59 +0000
Message-ID: <BL1PR12MB5317F8D25F4E299B124E02E1F1382@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
 <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ab889035-afa2-4a32-8a13-b8bd21b69fc7@redhat.com>
 <BL1PR12MB5317B47F9AF0068760239C8BF13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
 <cbe5a04e-caac-4ddc-a7a4-6c6bf5b0fac8@redhat.com>
 <BL1PR12MB5317EAF52CFCABB96E05D538F13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
 <7e9298da-79e2-43b6-a616-b1e1e1e1a883@redhat.com>
In-Reply-To: <7e9298da-79e2-43b6-a616-b1e1e1e1a883@redhat.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2c8b8012-b9fb-4adb-bd89-32cb23d31e5b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-13T16:52:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|LV2PR12MB5869:EE_
x-ms-office365-filtering-correlation-id: c815cbfe-d78a-483a-ed64-08dd1b96e151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFZMeWFqcHdWWndXT2g2c1B2emZVbGxRUXVwd2F0NDE1TVFmZUpZNCtTclJU?=
 =?utf-8?B?aFZKZWhqTVZaYWJzNHp6RlpoNWZEcW8wRkJlMjVFWmRJZk9KRmJJWk13RVZl?=
 =?utf-8?B?SHd2Y215bU1JaDVVUHRRaVJnMDJYTjcwcmZRb2pqUnVvZGE0amxvSmd6aTBP?=
 =?utf-8?B?akhreDRFcGFKdlBWaDVMQzhKUGN2ME1yN0NJZnovN3ZiclVwV1M1Y3BMczZZ?=
 =?utf-8?B?OFhzVnBVb0NtdFJLUEdKaFVWM3kvblFWRWNCVmJnc1ZZOE5CbzJ5TXpGNEps?=
 =?utf-8?B?V29lRmlKL0ZvNGp5QzZ3ZzFVZnZ0VyszQWpvY3Q1THY0UXJGazU1Z2Fsc0FI?=
 =?utf-8?B?a3FMRzBlU2NNa2ZMelI0NWtoLzZxSjVoYUx1YzBvT2IzUTVZTzlacWZpTGdQ?=
 =?utf-8?B?YzJQMTRacm85ZG1jcjM1bmlJVTVYaGx1cU95NzhxNXUzRDF3THlSdDNxNXFP?=
 =?utf-8?B?RndaKzFzRkVEVUdOTnVBUGNDeFFjMi9GbEVJYlV3NmNXbm51QVh6dCtlQnUx?=
 =?utf-8?B?elVvajl1YmJZanFMc2ZNcEFzelJwZUZYaytGV1dhbHQ0ckFBQXJDOFB0SnY0?=
 =?utf-8?B?STRRTUk1ZWpPSkswZWhlWnBibGY2SDBacDhvK0tYTURnNDBHUFZ4MnJuWHdL?=
 =?utf-8?B?V3lWNzN0ZVVad2NBaDU1UkJ2bXRGelZLd2hCWjJxSHBwemJGSENHRWhURmY1?=
 =?utf-8?B?ZWNUbzN5Mi9MQktPcWpmeXFJbmNURGZuMkorNm5ieVM3ZkJUS1Q5TkxVL3FR?=
 =?utf-8?B?b1ZJTmRJdVZ5KzJVSUlzQVJwTjVLQy9oVVhlUU1TT0dhZkpWcmwzaVdRNDd0?=
 =?utf-8?B?VHlHWEFkck1qekFYQkpKbFVvK3ZJOVVMSjJJREc2KzBJQVU1Uk5PdUd2NWJ6?=
 =?utf-8?B?eVlhTXpTRzJqV0hiR0FOZmgzNnBpRGxPN0tzRFQ4a2pJbU00elZWZ1lSNktE?=
 =?utf-8?B?UFNHZTA4dE0xY1VUZXB5VkllRXRhc285SzE3dUM0aUNqNllSWlBCSEJvMjdG?=
 =?utf-8?B?NzhmdDdrS3doTE1VcEtuaTNVQUU1Zzh0empCTXp2TFJpVURJdEwzeWtWTXpG?=
 =?utf-8?B?VGlWSGc1YlRXTkxyaXpaTklkT0Jqb1dQZCs1VHNZSHJsNHNoVWxIRUlQcUEy?=
 =?utf-8?B?YzJ6TEtmN001NU9EcjhWVXVXa1lkaGVSVzN3V2FLL1BMUnNVeHMxcUVYU29V?=
 =?utf-8?B?S0J3WXRxVGtJUlhXVHhXVkhhWCtHYkFtc3V0SCtYNll3cTF6K25BM1dpcCti?=
 =?utf-8?B?MVlBaW9GZkk3bXdnVkNPVE1JS2tSOFlZb3JFT201UWJEKzFGTC9peEVDd0c2?=
 =?utf-8?B?L0s0UU1reTBCMEcydzhzWE1zWEUzazg5WnBnK0Y1Y0xwMXRUUWRrMWNkREJk?=
 =?utf-8?B?T1Joa0lDSTljZTV2dXJkWmJoT1o2YWx5WWF1NHYxU0Qvajc0b3hpb0hha2hJ?=
 =?utf-8?B?Rzh3MDdYS2QyeFVkcnROaHlHZHVvU3VId2hnRGQ2MWtnaUM5aW5kS2tWRjRC?=
 =?utf-8?B?N0QyTHdnQlNUUVhzRGxDWVM3c2Z4aHp3MFhxTFphQ08vRmlIL253cnNBVWZr?=
 =?utf-8?B?ZE8yOWF3bERhdThkZEV3N0xYaWkzNENsVmRwcktCeWFhRkdISTh4Zms4K1Fz?=
 =?utf-8?B?YVhCKzN2NW4xcEdEWTdzWWRrdHNDOXBGMkczTDd0alU2WGRZN2Nmd0Y1Z29m?=
 =?utf-8?B?RG12TG5kb0xFcmdjc2RkZmxlc0YrSTh0THJ6UWI5WnVCbnJzU3lXWU1TUitt?=
 =?utf-8?B?azhVM3p6dExtYW04YitnU0VGZHQ4SFJnSSsvL0V5NUtCRGNLVnFnM29OVTBm?=
 =?utf-8?B?YVJPN3lKVFdOaXZ1Y01PYXZBRjlqVHNMZEFNU2dibVVreXVPRUdnT3ZOZFJO?=
 =?utf-8?B?c0tjV1hzRCs2WXRBUjZKQ0d3bVVHT0VvSjNKQVdjREVEWkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3l2dUhEZEpJZHo4OUZUU0Y5Uzh3a0FUMzNUbUtwZzdUcGQvYW8rS3ZWbGp4?=
 =?utf-8?B?bVQyaDF2QkJ4MFF6dlZTeXhSNmpEN0M4M2lYbXNLRU9vdHpFN2svY0JtWHF4?=
 =?utf-8?B?cytDcWtaejFFejh1WFlVOHhIbm5DMi9BRFA4MDI2eW1KMTdEWGp3SDNiWXhv?=
 =?utf-8?B?TjZxK0YwTzA3UmpnSGxtZ0dzSEVpbFBRRkVFNnRRbkZYdkxBQjIzN3MySy8v?=
 =?utf-8?B?VFlHcFdiWjM1TU5sY0J4WUpSWnROb0todk9vWkxMS1NVTlJWS1VQQjByaS9a?=
 =?utf-8?B?eWpJa2p1cnZvaDVPYnJRRlZwcEcxeUdsOW5zSElMcURXWDFvZWkvYXVIbVB4?=
 =?utf-8?B?Q0F1MnRYNk82WDFVcWJXNmZzblR1WTEyUU0yb0FLdEdBeEEwbWQxM0l3b1kw?=
 =?utf-8?B?MFpmcHRabThqZWRKc0RScXYyRlp2UUZaK1F4QzZGdHNmeG1MRUh5dWR5eWkx?=
 =?utf-8?B?QUVoWUpFRU5IeklmVzkxNGFJUEo0Q1dvZExyaUNJVTNUL2lRVUZaWDI0VVFG?=
 =?utf-8?B?NlVwOEFoNGRhVVFUMVBNYlR6WldwTTk1NEtCWm12N1pVeDhWaHVOT2o1STZu?=
 =?utf-8?B?R25tNE1nZStLTCt0bllsYWh3anVNN0E4amdzUGI0TFl2WkYxRjRiZndSbHZj?=
 =?utf-8?B?TXR4MlJvY3RBekNhSGdkaU9lamcyMzhHcGE0bDdsZ1ZxdDBuK1Q0OEt5dndN?=
 =?utf-8?B?ZEJzazlpUkhxQk1UQ0xwNWRzUDNYa3IyRDFlT0hQTVJLeDc5ZkVIUDc2bms4?=
 =?utf-8?B?V01OVWsyakRINGRFVU81RFhsY0lSZFd6MDJzZlR6bGRVaGNRbm5oWUVkcE5V?=
 =?utf-8?B?Q2ZvRW96QXMrZ0kveFlralpJTjdWTXY4RXVHaHU0YzFkY3A2VSs5RjN1bEZy?=
 =?utf-8?B?Ny9Uei8raCs0SkZIMDRJMXA0Sk1JSkFUaDh3UmxhUEdLQURsN1lIWDdxekkz?=
 =?utf-8?B?MEVDSTRvUkJEMVgzY2hlbHlNVnIyTW1iM3FSMHROdEtGZ2huajBJd3ZtdEd6?=
 =?utf-8?B?alo3dWU0UWZ2QVhsWW1Ld1hRZFBsUm1xbk9ERUovTjJra2w1bUhuaDA2VWNy?=
 =?utf-8?B?T2NWVVRZUldxckN6VHNmNmQ4cTMycXpOWXFBK1hHREp4UTlsUE5KSHY2cU5Q?=
 =?utf-8?B?T2RaNjc4ZkxucTcxbVNMSHpLeEtXVTFyK0VWWW9TRTRpTER4TkhZZ0U3K3VM?=
 =?utf-8?B?ZEZkNkNUZmNmWVBSUjNUbWhhTVBDekFBZ0RYQkFNb0pUVkJHMStXS1o2OXJU?=
 =?utf-8?B?M293ZTRhZlIrQ1pQZU80TUw1MnV4bVl4N3QxamRpQVhDTW1XcmF6YkZ4bWdH?=
 =?utf-8?B?QXpUditMek9xT2Zzbk9ydWVCZXRPNmRUZHVnM1lTR0FyTVRRbkhlUVRUaHdV?=
 =?utf-8?B?d2R1MGZFam9IMHRnZGlQbzVPQmYwN0ZiN2djSjhsRDhVOXJ2VmlRK2Fad25D?=
 =?utf-8?B?Q3ZWQ0ZCNGxDeXNVdVVLQ2Z1clJILzhzT1hyaTZEQTN1RXRZd2NiN2R3OUVk?=
 =?utf-8?B?SlJZTE5iZFpMaWg3ajRrbnp3UThPL21TWEo1SnRRb1dLbVhXbXFac0Y0dnA1?=
 =?utf-8?B?a25iVndMMVZseURRK3dKN1VYMGhxcHowQ1BCSWh4TlVoWTFDQnhEMStZQUxz?=
 =?utf-8?B?RUt1NTkwT1RmWDNTcHBTUmxqQTBmaC9XTCtwZHNnRFdTK3hjREFjQW5rRU9G?=
 =?utf-8?B?UzZyQi9qS3lCTGwzQ2x2THI3RTVqamMzT1FNeXpMNFNEWHZwK0pCaCs3dXFL?=
 =?utf-8?B?M0lSQ2lHQlMrbFVveksxcTVTMXRmSFFrREtEZ3Yxa2RDQ2xnQlhkS2k2czAz?=
 =?utf-8?B?RXBUME5kOHdiRS9Mek5YVDJGdVVCZTVoTFppQ2x2cDdIeHRTaVRndUtHS3ZO?=
 =?utf-8?B?MXBEVVN0ZlhFamZVMWVGUkNYZ2kvUjk5VmN3RkhBRkVzSzFKazdqLzdXaVVa?=
 =?utf-8?B?ZzBwcGpFYzBaaWJ0NHh0WUV3REpVS21NUWJDQnJPMjhRRTg2LzZwckg4UlF3?=
 =?utf-8?B?UmpDSWptTkZaYStPQTdpT1JIV1VXKzRGOHRuV05hOFQxYXVqNytMc0lEWmNL?=
 =?utf-8?B?cUlGZDBjYXIzdkh2dnpSZTR3TUxSVzFuNWtWV25lRnFldFlnNGJHOGpvSDVk?=
 =?utf-8?Q?+i18=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c815cbfe-d78a-483a-ed64-08dd1b96e151
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 16:54:59.5161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpo3B2N+Htz/BBlhj8hDWY6IbmYfImTKantVmL+jjobep48GfjrGAyW53RWjJTej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
Received-SPF: permerror client-ip=40.107.93.73;
 envelope-from=Zhigang.Luo@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgSm9uYXRoYW4sDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIGNvbW1lbnRz
Pw0KDQpUaGFua3MsDQpaaGlnYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIERlY2VtYmVyIDEwLCAyMDI0IDU6MDIgUE0NCj4gVG86IEx1bywgWmhpZ2FuZyA8WmhpZ2Fu
Zy5MdW9AYW1kLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzoga3JheGVsQHJlZGhh
dC5jb207IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+OyBKb25hdGhhbg0KPiBD
YW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGhvc3RtZW0tZmlsZTogYWRkIHRoZSAnaG1lbScgb3B0aW9uDQo+DQo+IE9uIDEwLjEyLjI0
IDIyOjUxLCBMdW8sIFpoaWdhbmcgd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAt
IEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTAsIDIwMjQgMjo1NSBQTQ0KPiA+
PiBUbzogTHVvLCBaaGlnYW5nIDxaaGlnYW5nLkx1b0BhbWQuY29tPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnDQo+ID4+IENjOiBrcmF4ZWxAcmVkaGF0LmNvbTsgSWdvciBNYW1tZWRvdiA8aW1hbW1l
ZG9AcmVkaGF0LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaG9zdG1lbS1maWxlOiBh
ZGQgdGhlICdobWVtJyBvcHRpb24NCj4gPj4NCj4gPj4gT24gMTAuMTIuMjQgMjA6MzIsIEx1bywg
WmhpZ2FuZyB3cm90ZToNCj4gPj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJu
YWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4+Pg0KPiA+Pj4gSGkgRGF2aWQsDQo+ID4+Pg0KPiA+
Pg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhhbmtzIGZvciB5b3VyIGNvbW1l
bnRzLg0KPiA+Pj4+PiBMZXQgbWUgZ2l2ZSB5b3Ugc29tZSBiYWNrZ3JvdW5kIGZvciB0aGlzIHBh
dGNoLg0KPiA+Pj4+PiBJIGFtIGN1cnJlbnRseSBlbmdhZ2VkIGluIGEgcHJvamVjdCB0aGF0IHJl
cXVpcmVzIHRvIHBhc3MgdGhlDQo+ID4+Pj4+IEVGSV9NRU1PUllfU1ANCj4gPj4+PiAoU3BlY2lh
bCBQdXJwb3NlIE1lbW9yeSkgdHlwZSBtZW1vcnkgZnJvbSBob3N0IHRvIGEgdmlydHVhbCBtYWNo
aW5lDQo+ID4+Pj4gd2l0aGluIFFFTVUuIFRoaXMgbWVtb3J5IG5lZWRzIHRvIGJlIEVGSV9NRU1P
UllfU1AgdHlwZSBpbiB0aGUNCj4gPj4+PiB2aXJ0dWFsIG1hY2hpbmUgYXMgd2VsbC4NCj4gPj4+
Pj4gVGhpcyBwYXJ0aWN1bGFyIG1lbW9yeSB0eXBlIGlzIGVzc2VudGlhbCBmb3IgdGhlIGZ1bmN0
aW9uYWxpdHkgb2YgbXkgcHJvamVjdC4NCj4gPj4+Pg0KPiA+Pj4+IFdoaWNoIGV4YWN0IGd1ZXN0
IG1lbW9yeSB3aWxsIGJlIGJhY2tlZCBieSB0aGlzIG1lbW9yeT8gQWxsIGd1ZXN0LW1lbW9yeT8N
Cj4gPj4+IFtMdW8sIFpoaWdhbmddIG5vdCBhbGwgZ3Vlc3QtbWVtb3J5LiBPbmx5IHRoZSBtZW1v
cnkgcmVzZXJ2ZWQgZm9yDQo+ID4+PiBzcGVjaWZpYw0KPiA+PiBkZXZpY2UuDQo+ID4+DQo+ID4+
IENhbiB5b3Ugc2hvdyBtZSBhbiBleGFtcGxlIFFFTVUgY21kbGluZSwgYW5kIGhvdyB5b3Ugd291
bGQgcGFzcyB0aGF0DQo+ID4+IGhvc3RtZW0tZmlsZSBvYmplY3QgdG8gdGhlIGRldmljZT8NCj4g
Pj4NCj4gPiBbTHVvLCBaaGlnYW5nXSB0aGUgZm9sbG93aW5nIGlzIGFuIGV4YW1wbGUuIG0xIGlz
IHRoZSByZXNlcnZlZCBtZW1vcnkgZm9yIHBjaQ0KPiBkZXZpY2UgIjAwMDA6MDM6MDAuMCIuIGJv
dGggdGhlIG1lbW9yeSBhbmQgcGNpIGRldmljZSBhcmUgc2V0IHRvIHNhbWUgbnVtYSBub2RlLg0K
PiA+DQo+ID4gLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0sc2l6ZT04RyxpZD1tMCBcIC1vYmpl
Y3QNCj4gPiBtZW1vcnktYmFja2VuZC1maWxlLHNpemU9MTZHLGlkPW0xLG1lbS1wYXRoPS9kZXYv
ZGF4MC4wLHByZWFsbG9jPW9uLGFsDQo+ID4gaWduPTFHLGhtZW09b24gXCAtbnVtYSBub2RlLG5v
ZGVpZD0wLG1lbWRldj1tMCAtbnVtYQ0KPiA+IG5vZGUsbm9kZWlkPTEsbWVtZGV2PW0xIFwNCj4N
Cj4gT2theSwgc28geW91IGV4cG9zZSB0aGlzIG1lbW9yeSBhcyBhIHNlY29uZCBudW1hIG5vZGUs
IGFuZCB3YW50IHRoZSBndWVzdCB0bw0KPiBpZGVudGlmeSB0aGUgc2Vjb25kIG51bWEgbm9kZSBh
cyBTUCB0byBub3QgdXNlIGl0IGR1cmluZyBib290Lg0KPg0KPiBMZXQgbWUgQ0MgSm9uYXRoYW4s
IEkgYW0gcHJldHR5IHN1cmUgaGUgaGFzIGFuIGlkZWEgd2hhdCB0byBkbyBoZXJlLg0KPg0KPiA+
IC1kZXZpY2UgcHhiLXBjaWUsaWQ9cGNpZS4xLG51bWFfbm9kZT0xLGJ1c19ucj0yLGJ1cz1wY2ll
LjAgXCAtZGV2aWNlDQo+ID4gaW9oMzQyMCxpZD1wY2llX3BvcnQxLGJ1cz1wY2llLjEsY2hhc3Np
cz0xIFwgLWRldmljZQ0KPiA+IHZmaW8tcGNpLGhvc3Q9MDAwMDowMzowMC4wLGlkPWhvc3RkZXYw
LGJ1cz1wY2llX3BvcnQxDQo+ID4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBBbmQsIHdoYXQgaXMg
dGhlIGd1ZXN0IE9TIGdvaW5nIHRvIGRvIHdpdGggdGhpcyBtZW1vcnk/DQo+ID4+PiBbTHVvLCBa
aGlnYW5nXSB0aGUgZGV2aWNlIGRyaXZlciBpbiBndWVzdCB3aWxsIHVzZSB0aGlzIHJlc2VydmVk
IG1lbW9yeS4NCj4gPj4NCj4gPj4gT2theSwgc28ganVzdCBsaWtlIENYTCBtZW1vcnkuDQo+ID4+
DQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4gVXN1YWxseSwgdGhpcyBTUCBtZW1vcnkgKGRheCwgY3hs
LCAuLi4pIGlzIG5vdCB1c2VkIGFzIGJvb3QgbWVtb3J5Lg0KPiA+Pj4+IExpa2Ugb24gYSBiYXJl
IG1ldGFsIHN5c3RlbSwgb25lIHdvdWxkIGV4cGVjdCB0aGF0IG9ubHkgQ1hMIG1lbW9yeQ0KPiA+
Pj4+IHdpbGwgYmUgbWFya2VkIGFzIHNwZWNpYWwgYW5kIHB1dCBhc2lkZSB0byB0aGUgY3hsIGRy
aXZlciwgc3VjaA0KPiA+Pj4+IHRoYXQgdGhlIE9TIGNhbiBib290IG9uIG9yZGluYXJ5IERJTU1z
LCBzdWNoIHRoYXQgY3hsIGNhbiBvbmxpbmUgaXQgZXRjLg0KPiA+Pj4+DQo+ID4+Pj4gU28gbWF5
YmUgeW91IHdvdWxkIHdhbnQgdG8gZXhwb3NlIHRoaXMgbWVtb3J5IHVzaW5nIENYTC1tZW0gZGV2
aWNlDQo+ID4+Pj4gdG8gdGhlIFZNPyBPciBhIERJTU0/DQo+ID4+Pj4NCj4gPj4+PiBJIGFzc3Vt
ZSB0aGUgYWx0ZXJuYXRpdmUgaXMgdG8gdGVsbCB0aGUgVk0gb24gdGhlIExpbnV4IGtlcm5lbA0K
PiA+Pj4+IGNtZGxpbmUgdG8gc2V0IEVGSV9NRU1PUllfU1Agb24gdGhpcyBtZW1vcnkuIEkgcmVj
YWxsIHRoYXQgdGhlcmUgaXMNCj4gPj4+PiBhIHdheSB0bw0KPiA+PiBhY2hpZXZlIHRoYXQuDQo+
ID4+Pj4NCj4gPj4+IFtMdW8sIFpoaWdhbmddIEkga25vdyB0aGlzIG9wdGlvbi4gYnV0IGl0IHJl
cXVpcmVzIHRoZSBlbmQgdXNlciB0bw0KPiA+Pj4ga25vdyB3aGVyZSBpcyB0aGUNCj4gPj4gbWVt
b3J5IGxvY2F0aW9uIGluIGd1ZXN0IHNpZGUoc3RhcnQgYWRkcmVzcywgc2l6ZSkuDQo+ID4+DQo+
ID4+IFJpZ2h0Lg0KPiA+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4+IEluIExpbnV4LCB0aGUgU1BN
IG1lbW9yeSB3aWxsIGJlIGNsYWltZWQgYnkgaG1lbS1kYXggZHJpdmVyIGJ5DQo+ID4+Pj4+IGRl
ZmF1bHQuIFdpdGgNCj4gPj4+PiB0aGlzIHBhdGNoIEkgY2FuIHVzZSB0aGUgZm9sbG93aW5nIGNv
bmZpZyB0byBwYXNzIHRoZSBTUE0gbWVtb3J5IHRvIGd1ZXN0IFZNLg0KPiA+Pj4+PiAtb2JqZWN0
DQo+ID4+Pj4+IG1lbW9yeS1iYWNrZW5kLWZpbGUsc2l6ZT0zMEcsaWQ9bTEsbWVtLXBhdGg9L2Rl
di9kYXgwLjAscHJlYWxsb2M9bw0KPiA+Pj4+PiBuLA0KPiA+Pj4+PiBhbA0KPiA+Pj4+PiBpZ249
MUcsaG1lbT1vbg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIHdhcyB0aGlua2luZyB0byBjaGFuZ2UgdGhl
IG9wdGlvbiBuYW1lIGZyb20gImhtZW0iIHRvICJzcG0iIHRvDQo+ID4+Pj4+IGF2b2lkDQo+ID4+
Pj4gY29uZnVzaW9uLg0KPiA+Pj4+DQo+ID4+Pj4gTGlrZWx5IGl0IHNob3VsZCBiZSBzcGVjaWZp
ZWQgZWxzZXdoZXJlLCB0aGF0IHlvdSB3YW50IHNwZWNpZmljDQo+ID4+Pj4gZ3Vlc3QgUkFNIHJh
bmdlcyB0byBiZSBFRklfTUVNT1JZX1NQLiBGb3IgYSBESU1NLCBpdCBjb3VsZCBiZSBhDQo+ID4+
Pj4gcHJvcGVydHksIHNpbWlsYXJseSBtYXliZSBmb3IgQ1hMLSBtZW0gZGV2aWNlcyAobm8gZXhw
ZXJ0IG9uIHRoYXQpLg0KPiA+Pj4+DQo+ID4+Pj4gRm9yIGJvb3QgbWVtb3J5IC8gbWFjaGluZSBt
ZW1vcnkgaXQgY291bGQgYmUgYSBtYWNoaW5lIHByb3BlcnR5Lg0KPiA+Pj4+IEJ1dCBJJ2xsIGZp
cnN0IGhhdmUgdG8gbGVhcm4gd2hpY2ggcmFuZ2VzIHlvdSBhY3R1YWxseSB3YW50IHRvDQo+ID4+
Pj4gZXhwb3NlIHRoYXQgd2F5LCBhbmQgd2hhdCB0aGUgVk0gd2lsbCBkbyB3aXRoIHRoYXQgaW5m
b3JtYXRpb24uDQo+ID4+PiBbTHVvLCBaaGlnYW5nXSB3ZSB3YW50IHRvIGV4cG9zZSB0aGUgU1BN
IG1lbW9yeSByZXNlcnZlZCBmb3Igc3BlY2lmaWMNCj4gZGV2aWNlLg0KPiA+PiBBbmQgd2Ugd2ls
bCBwYXNzIHRoZSBTUE0gbWVtb3J5IGFuZCB0aGUgZGV2aWNlIHRvIGd1ZXN0LiBUaGVuIHRoZQ0K
PiA+PiBkZXZpY2UgZHJpdmVyIGNhbiB1c2UgdGhlIFNQTSBtZW1vcnkgaW4gZ3Vlc3Qgc2lkZS4N
Cj4gPj4NCj4gPj4gVGhlbiB0aGUgZGV2aWNlIGRyaXZlciBzaG91bGQgbGlrZWx5IGhhdmUgYSB3
YXkgdG8gY29uZmlndXJlIHRoYXQsDQo+ID4+IG5vdCB0aGUgbWVtb3J5IGJhY2tlbmQuDQo+ID4+
DQo+ID4+IEFmdGVyIGFsbCwgdGhlIGRldmljZSBkcml2ZXIgd2lsbCBtYXAgaXQgc29tZWhvdyBp
bnRvIGd1ZXN0IHBoeXNpY2FsDQo+ID4+IGFkZHJlc3Mgc3BhY2UgKGhvdz8pLg0KPiA+Pg0KPiA+
IFtMdW8sIFpoaWdhbmddIGZyb20gZ3Vlc3QgdmlldywgaXQncyBzdGlsbCBzeXN0ZW0gbWVtb3J5
LCBidXQgbWFya2VkIGFzIFNQTS4gU28sDQo+IHFlbXUgd2lsbCBtYXAgdGhlIG1lbW9yeSB0byBn
dWVzdCBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlLg0KPiA+IFRoZSBkZXZpY2UgZHJpdmVyIGp1c3Qg
Y2xhaW1zIHRvIHVzZSB0aGUgU1BNIG1lbW9yeSBpbiBndWVzdCBzaWRlLg0KPiA+DQo+ID4+Pg0K
PiA+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyB0byBh
Y2hpZXZlIHRoaXMgbW9yZSByZWFzb25hYmxlPw0KPiA+Pj4+DQo+ID4+Pj4gVGhlIHByb2JsZW0g
d2l0aCBxZW11X3JhbV9mb3JlYWNoX2Jsb2NrKCkgaXMgdGhhdCB5b3Ugd291bGQNCj4gPj4+PiBp
bmRpY2F0ZSBhbHNvIERJTU1zLCB2aXJ0aW8tbWVtLCAuLi4gYW5kIGV2ZW4gUkFNQmxvY2tzIHRo
YXQgYXJlDQo+ID4+Pj4gbm90IGV2ZW4gdXNlZCBmb3IgYmFja2luZyBhbnl0aGluZyB0byB0aGUg
Vk0gYXMgRUZJX01FTU9SWV9TUCwgd2hpY2ggaXMNCj4gd3JvbmcuDQo+ID4+PiBbTHVvLCBaaGln
YW5nXSBxZW11X3JhbV9mb3JlYWNoX2Jsb2NrKCkgd2lsbCBsaXN0IGFsbCBtZW1vcnkgYmxvY2ss
DQo+ID4+PiBidXQgaW4NCj4gPj4gcGNfdXBkYXRlX2htZW1fbWVtb3J5KCksIG9ubHkgdGhlIG1l
bW9yeSBibG9jayB3aXRoICJobWVtIiBmbGFnIHdpbGwNCj4gPj4gYmUgdXBkYXRlZCB0byBTUE0g
bWVtb3J5Lg0KPiA+Pg0KPiA+PiBZZXMsIGJ1dCBpbWFnaW5lIGEgdXNlciBwYXNzaW5nIHN1Y2gg
YSBtZW1vcnkgYmFja2VuZCB0byBhDQo+ID4+IERJTU0vdmlydGlvLW1lbS9ib290IG1lbW9yeSBl
dGMuIEl0IHdpbGwgaGF2ZSB2ZXJ5IHVuZGVzaXJlZCBzaWRlIGVmZmVjdHMuDQo+ID4+DQo+ID4g
W0x1bywgWmhpZ2FuZ10gdGhlIHVzZXIgc2hvdWxkIGtub3cgd2hhdCBoZS9zaGUgaXMgZG9pbmcg
d2hlbiBoZS9zaGUgc2V0IHRoZSBmbGFnDQo+IGZvciB0aGUgbWVtb3J5IHJlZ2lvbi4NCj4NCj4g
Tm8sIHdlIG11c3Qgbm90IGFsbG93IHRvIGNyZWF0ZSBpbnNhbmUgY29uZmlndXJhdGlvbnMgdGhh
dCBkb24ndCBtYWtlIGFueSBzZW5zZS4NCj4NCj4gU3VmZmljaWVudCB0byBhZGQ6DQo+DQo+IC1v
YmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxzaXplPTE2RyxpZD11bnVzZWQsbWVtLXBhdGg9d2hh
dGV2ZXIsaG1lbT1vbg0KPg0KPiB0byB0aGUgY21kbGluZSB0byBjYXVzZSBhIG1lc3MuDQo+DQo+
DQo+IE1heWJlIGl0IHNob3VsZCBiZSBhICJudW1hIiBub2RlIGNvbmZpZ3VyYXRpb24gbGlrZQ0K
Pg0KPiAtbnVtYSBub2RlLG5vZGVpZD0xLG1lbWRldj1tMSxzcD1vbg0KPg0KPiBCdXQgSSByZWNh
bGwgdGhhdCB3ZSBkaXNjdXNzZWQgc29tZXRoaW5nIHJlbGF0ZWQgd2l0aCBKb25hdGhhbiwgc28g
SSdtIGhvcGluZyB3ZQ0KPiBjYW4gZ2V0IGhpcyBpbnB1dC4NCj4NCj4gLS0NCj4gQ2hlZXJzLA0K
Pg0KPiBEYXZpZCAvIGRoaWxkZW5iDQoNCg==

