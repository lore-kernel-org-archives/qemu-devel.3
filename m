Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1E1D2F333
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 15:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfgF9-0004kD-Ik; Tue, 13 Jan 2026 10:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfgEm-0004ZJ-Lm; Tue, 13 Jan 2026 10:23:17 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfgEk-0006Nl-03; Tue, 13 Jan 2026 10:23:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geTYC8/BK8qSVrslG5DRPBoVB6RdQbIjeB2ejLqfTX165opeP7lSm/V+HQT7jdL/4U4zVMqslP8HyxaZ/R3BqCFz2z61zXA6KIly2z9ftshHfNYIyaOXGt61NIc2a7g+85rCmFp7j1/rVMmbstUUaT1p358WTdYmMJSRyx4meeaTW0bE3Nysk5O0WU7OXPDPz4sV+M4+TawgsOanNXkMW1z5bUTNAQItMa5KaVzjFIV+dKyn/RePysVDkpD0jm2KMsVPDdAT22ORpJgViF05+8l28hJuyz2dQDNEQV7DaCDo8llzcLhMD9E2vztS60remaUOwgsaP9mgQDbKK6TYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9VAQJcWmEYmycSo6BZTRP5gzsck+/cwaUECaC4ehq8=;
 b=jVSp5wGiBTacS4rjD+71tlN7t96FTydn6pPACifaSdb4+ccp4erhTldtFKSxl6tBisi3o8qBDnceZna6fY6tggod+LixmXp17nRVfmYFf/5BRxw1/y+kwmg1CdCJOsZeGrAgzqvVaOjmYS9VxlLLQBWdh/QPziU2HgmgsPPA9hvtlqjmEvImkoVhUdb6FFrJuoXlJMpHoXX1+q5xta9rChaWL1Y/ILlWCELnhn8ndH/rWg/AysZphgtg/sWnruE0vs06THH7vS4S1uVNacLxYTBZZo8iyetZXlMLSegNEnpgWEgJsKcYMdis6koJBmtyg//3t3ww0SpQdfpXzKW5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9VAQJcWmEYmycSo6BZTRP5gzsck+/cwaUECaC4ehq8=;
 b=P6R4MFf921uGHgs/WozxO1z9NAchTFGBHaNZApCY5rqgasImgjcaUGKdvSJukEhGQxbHaKgrAyZCWRwE9IQx+xwiPdzdN4NDGUvulXCEQupU2XhqJzJ+na4Zmmg+VWbdmN4/QeYLgQ14Eywy3/bl/HZqzgVXPggMPQeWFhZSsMg/iP5f1tepX8e+oHCv7oRM1idgQOg8Kk5iSdNmnSPPp9R3Q2aeVVEFz0wDshGxEAaPJdbH5L53MuU/dO+6md6CbBo14uLXFDqBheMTMZ7wXPlGeLjlng5+tkSq525WRmbxci8AFsNpHziegBgki2L0DaHvuoBOutUZzN+DGFDiyA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 15:23:04 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 15:23:04 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Thread-Topic: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Thread-Index: AQHcadocqMzkFAhYTU6WU1M92/lWQLVO4OQAgAGIbEA=
Date: Tue, 13 Jan 2026 15:23:03 +0000
Message-ID: <CH3PR12MB75481CDC73FEE7996941E992AB8EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <2a68c364-a046-4c5d-a2d1-2f02b1b89abf@redhat.com>
In-Reply-To: <2a68c364-a046-4c5d-a2d1-2f02b1b89abf@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM6PR12MB4217:EE_
x-ms-office365-filtering-correlation-id: b2f46404-dba2-473a-213a-08de52b7a562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NEJVS2hFTWU5dWhWU2JhNC91QTR2SEJVQ3M1QVhZMDVVVjdxMHR4ODdFR3N5?=
 =?utf-8?B?bmJwSUVZRldMRUpESFRBekQxUnZsMGlhV3MrWEpzVmkydzZyd0pJMTNYeXF3?=
 =?utf-8?B?QSsxUWVzUVhVYjUrejdTMzdBMmFmRGVYeVNnaWR5Vyt5RldRSFBmdVNwYjZt?=
 =?utf-8?B?eTV5M0RHZ2cvY1hyOG45NGdna3NjY2lkalNPYzJGL3duVDBtblU4anl1ajU3?=
 =?utf-8?B?ZVIrTXlsSTVLZUplVE13QThBbnl4YWR3Vk9iSmRHd3dNd1h1Z1F1ZzBnSE53?=
 =?utf-8?B?TTlCM1p6eWZ1OW5wQkRwdlpKd21SZStwSGg3eGUrNEhIaGtBNlBjV2NRTkU2?=
 =?utf-8?B?UVhmOUtqSWtWR3YvZXVwcnU1M1VBZGV3dUxHbmptbXdsbWJZTUQwQzh0eHcz?=
 =?utf-8?B?UHUxY1FlemFRQWk3UFZUL1ZYNXZ1ZWVXVS9WT01WbkhRNmNVTGRqVnFUOHNh?=
 =?utf-8?B?MnZRcS9kY3ZFLzBUSmxYMUhzdHYxS3VWVVZ0OStiempKc05FRU43UGpPcnhr?=
 =?utf-8?B?WWNaSTNMMFJvZFh2ZExsT3o1R2dnWk9wZ0t6bENSOTNtdmwreGNPZ0lCQk5x?=
 =?utf-8?B?VzA1U0ZneUxyaUI3NEtwMGZCanJ1SkN3WFlYc3pDRHBHZmFPZlVEczBWVndX?=
 =?utf-8?B?elFUaXRDRkxuZjZldDE1Vmg0SWgrZVFKbkNQM3RmMFdFc2pLT29CanNhY2JN?=
 =?utf-8?B?NmdYRG14UjhSbVFjSGU5RW5XS1o2bVJuTG5GaHBBVU91eDVqZG5rd0hXRUFT?=
 =?utf-8?B?NDFxa3huYStZaW5BRnV0VHhybjVBZ3pKVnJiR1BndEVWTXE5UngxTjhWR21Q?=
 =?utf-8?B?MFprM1BRVlRWb0NOYlFPZUh0cG1SQktBT3VVbnQ3bEFtSmRFRTdLa3ZIMFRL?=
 =?utf-8?B?bVNCV2FRUTdIcko5V2JzUGZIUFFHN0dIQzZEZ0lwVEtDaVRaaVdpUjVGaTFD?=
 =?utf-8?B?aE9kVS91bnZoZkt6cUg0UGkvZGdTUWdNOC9xbSs1SDBxVHNSV09JNTgrdlNH?=
 =?utf-8?B?cVJGTGNBNGU1QWNSN3g5N0IzM1FlOUczT0liL0xud2E3SFRRcHZ1VE4walZC?=
 =?utf-8?B?T1YzZ0ZTR0Q4YUJGOFRyYVdhSEJMSU5Qc01KbmlMeFJYeXgvR0llV1lYWUpq?=
 =?utf-8?B?NkxzMjExd0RqUjJxazVVSWJyRGZGYjRLUThpazdWRWRaeTB5MU9wbjJDY1BM?=
 =?utf-8?B?TzhiVzQ2MTRFR0piTHdjNnVXT0VBQVJMVUJDMFBQVlYvajBkVnM4dDVGdC9O?=
 =?utf-8?B?OXJBaXZaUzlKekFYUTNmWXFpRVBEZHc4NVVSZFphdmNET3RWVzFBdnpmclpw?=
 =?utf-8?B?eDFEU2xmTGRyaHdHWktNajByRWRXSHQwb3lCK1Q3cHp0eS9TWlV6WDdLMTRF?=
 =?utf-8?B?T3hNRk8zYU5sQUxBYUhheHRiZGZYK1FxdlkxdmhyVjhKd01UZWVDVHJwVi9G?=
 =?utf-8?B?bVJDR3BEdUVQOFhnQ0EwT1lMWXRId0JVRnhRUHlQcExERisvcndiR3FtNncz?=
 =?utf-8?B?ZFh6aEFackR2c1pHczczWW1zVEZ6WVlCQUFMRGZUUXVhcWNQNzI5M2NaTDVw?=
 =?utf-8?B?MEZTQ0JSRWhvL0JOcUJxQUZ3ekZHZlFXYmxSNUE5MTBZYmRaYllIck9wZktU?=
 =?utf-8?B?bXg0MC8rVHc0Wm5ZajdSdUFBL3BKSk1Ec1ZjUlJ3UmNIOXI2WjFQVUk5YThy?=
 =?utf-8?B?ekVLTHY1dnpBdE5wS2Rod045RmJieVZBNzBLTVVVb0NTb3QwVHJYSFNsY1JP?=
 =?utf-8?B?YmZ0Z1EweW5XdEowVjh1eURhQ29kS0lZUTNuWndYSTc3eTVpdFhlSFRTR0ha?=
 =?utf-8?B?MkxadnRWNGRQQW9HcUlvODFiNmRtVGZtazhNMk1IWjBSRWxBMFZyZHhKZFhS?=
 =?utf-8?B?Rk5WUkNBdUFQUzJFV1VSTjd1NXRVK2hqcHdyUG5QQ0YvaWs4Z1d0WEgzVUF1?=
 =?utf-8?B?M28zRGlZNE93Rjh5aVV4TFlSNEtqRVUyUWloVXdiV0kvdGhHTk9pSUNqS2dq?=
 =?utf-8?B?UGhPWVlaekEwUkJPWlQ0TVkrdytyVFVXODgrM1hna3hTOEtsQUgvaXpXNFBx?=
 =?utf-8?Q?vWs1mZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGNqZWF1N2ZLZ0RqMmxWV0U0MTE5MlFXOWFDdXFkc3VTQ1d3eUhaNXdBeWl2?=
 =?utf-8?B?L1JPQXNFQ0c0Y0tMYnplcHVEMzlqa0phalhkT3p4b0M0Y2lKbnJVcWNoTUp0?=
 =?utf-8?B?NGVINEFNamZ6VnF1b21Pa2s0NHpVM1ZwNk5PTSs2R0lyczljQWd5ZVllVm41?=
 =?utf-8?B?bGVYemorSUUrM1JsRzJuejdsT0hwV3V0UUpRZHVxbTJiQkVCd2VaMHdEWHI2?=
 =?utf-8?B?cG5IdjF5UHlNZDAvbTlDMXUrUEIrN0E4cnFXZHpxaWdvVEV3U0lWc2thNk1O?=
 =?utf-8?B?L1RSYkZ2U0h1ajlyaUFPZWEzVjl1bEpwbFQzSzVvR0FqZ3NtalhoSWdOWjVQ?=
 =?utf-8?B?V2k2QVBLYUd1NCtTajNQRk0vbUhiR01ENlY0elVTTUF3VG0wWk9taU40emVJ?=
 =?utf-8?B?RlRoYlpGUnJpUUpKRjd4M01xVGJaSWY3QjlaQzZLLzhJLzRDRGE2UVNuL0pw?=
 =?utf-8?B?eGVvM0pmVGZ6TEprcVNsNVdIQ1pYbjQzZis0ZTFYZkZKT0dNRGQyTXVJYW9P?=
 =?utf-8?B?eUtpVDhheXRBWjNGcGQrYy80SlhhOEN5dzBHN042azBZaWF1ckQrbnZEOE5Q?=
 =?utf-8?B?OTFMV2dJSFFZVWNpa0RBV2F3RmtaL05ROE5mN0NNcXR0cWJNSmxpT0xqM04z?=
 =?utf-8?B?ZitxK2c1Rzh5NEtGWTNNOHRSdHoyc0crR0UwNHJVc0djUjVMdUNjd29RRkth?=
 =?utf-8?B?M2VqSSs2SUQ0eGRWV0Y4c0dKTGhaTlcvRDdFcTRWU3FyNmg5dHpySjlqY2Nq?=
 =?utf-8?B?cDJmY1hhOEovakhDdVVLNHh1bUIvWnFUT1BGeXl0UjdRM0xyeFFxeUprUTd2?=
 =?utf-8?B?dTFnUTMvZHIrTEREcVBRWGVLT1NuMU9tekdUMnlncHA5Y3JEeTF4OGVzUWRY?=
 =?utf-8?B?amQwaWdhVVhEanJVT0xIeWg4d0RQbnJ0Y2cybVUvbGdvUFJBM3l0QmxrK1R6?=
 =?utf-8?B?dGNMMmkrd0NlMEkxbDBTS0JvY0FlQ25iN2VJMElIaCtpWEdlb0p4dDZVUlha?=
 =?utf-8?B?VkxHOXlhMDBSYUtIcmVCK3p1TXVKeVFqY3JGWjFWbUdncHcvWFJ0L2VHaUFM?=
 =?utf-8?B?UVdCK25FY0s3VWdKckNlWkUzTmlydUx2YmRaR0FWM0s0REtEaU9iVEcxZUl3?=
 =?utf-8?B?WlJLdDBxWUJCZHgxWTdZVU5hcTh2c0kyRVJrRnRzQ0ZxMGZyNktRNElvdlQw?=
 =?utf-8?B?QStXZVZ4RXJpQUExWW9rQjVubG5sSzR3WkVoSEdOUnFHMzFNUkxCbnUrWUUz?=
 =?utf-8?B?cEdEblBLcDBOSm81WmtzeURTbkFWNnV1WEFYVHBiWnZjUWROeVZPem9MZmc5?=
 =?utf-8?B?VDFJMkxFczRSK2NQc1JIcGdENVJaNC9sVzBEYlpYR29YLzZ4THY5TEZUVWdj?=
 =?utf-8?B?SDdTclhMRlVpZ1BOSi9aVThmb05ORHNLT1Qxb3UvdWRQMnhTT213OU53Y2dJ?=
 =?utf-8?B?cVcvSEZxdFRxNEZSSHRpNGJzM2toai9xTWFKTER1SmF4MnI0T0xOTm5lczBY?=
 =?utf-8?B?LzAzVDk1R1Vab2V6KzVER3E5N1lnTC8wVldhNHpJUWV3bmpCQmZHOXJxcDFN?=
 =?utf-8?B?T0FQejhOQzN3dkNIMjJuRElvOWk5VWtmVDZJQWN1UGFINTMrbWZRRSsya1Fn?=
 =?utf-8?B?UU9CZG1yYmJaZDVQZEp2ajRnR2d5WU1YdjJ2TnA5WTBLWlllYy8rdG9oS0Yz?=
 =?utf-8?B?SVk2Y2VoRGFPck5rNXA5elpJZlg5T0VVQW94OGpGTEZuWGQwSWtBR005Nlox?=
 =?utf-8?B?aklrTzBrbHlkMzFIY0xNRU9GS2hzU0pBUkRJSlVkTHhYRTFOV0xuMmZ0YVlR?=
 =?utf-8?B?V05QRUF4cTRXLzhQakNpMTk1VHRuZ0dkVmNwNU9iL0x0cERKM3kwZlBJUDk0?=
 =?utf-8?B?MlJocmh1dXQ4K1ZuVmdtK3RBTk94T0I4SHZRU2JaK01SY3hxZTM4ZEYyc0ZN?=
 =?utf-8?B?MzF3eTJ0c2hjM2wzVDlseUpQbDBvdzBrVUJvZHFSdTdCMDkwQjhvK1puVnJv?=
 =?utf-8?B?bnZ6UWJKeXRaejIxaFhEaEdHNktLRVA1OGtYdlNySlFqcTZoaXkxSzZsZmdW?=
 =?utf-8?B?WFdhK1g2QkdBRlJXV0IwdVVmMlFkcWt3MlhRN0szczJUcnFsbEdXR3pzWkhh?=
 =?utf-8?B?RjFiRk1YZVdQZkE5ZDdkOURqMW04dmRvNGduWmxkODE5MVpUZDhoWDZ5d1dN?=
 =?utf-8?B?NlEwQUJ0YnBvdzlXM2pjZjk5aXpnaUhPTHd3N1A3b2QwQTR4RjQ5MDhETmFu?=
 =?utf-8?B?UjRTTmpGeEIvcVpuT3V1N1JnQy9jam12UjZvNjZrMTNIQmVBckdWdFFoMHZG?=
 =?utf-8?B?dkgwWHVLRUhWZE1RRzA5VGxBdnFsYlB0MHRqZHJFeE5NTy9iN0lSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f46404-dba2-473a-213a-08de52b7a562
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 15:23:03.5318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHaHhMMDIdw0k4KEZMX1keMXtxYzLBvpN5DZdnMjRqwVCOgvvrmud5nIohc7AoLhFIZkreu+UUzszqyH03v63w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBKYW51YXJ5IDIwMjYgMTU6NDQNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4NCj4g
Q2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsg
SmFzb24NCj4gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFuLmNhbWVyb25AaHVh
d2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtSRkMgUEFUQ0ggMDAvMTZdIGh3L2FybTogSW50cm9kdWNlIFRlZ3JhMjQxIENNRFFWIHN1
cHBvcnQNCj4gZm9yIGFjY2VsZXJhdGVkIFNNTVV2Mw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAxMi8x
MC8yNSAyOjM3IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4g
VGhpcyBSRkMgc2VyaWVzIGFkZHMgaW5pdGlhbCBzdXBwb3J0IGZvciBOVklESUEgVGVncmEyNDEg
Q01EUVYNCj4gPiAoQ29tbWFuZCBRdWV1ZSBWaXJ0dWFsaXNhdGlvbiksIGFuIGV4dGVuc2lvbiB0
byBBUk0gU01NVXYzIHRoYXQNCj4gPiBwcm92aWRlcyBoYXJkd2FyZSBhY2NlbGVyYXRlZCB2aXJ0
dWFsIGNvbW1hbmQgcXVldWVzIChWQ01EUXMpIGZvcg0KPiA+IGd1ZXN0cy4gQ01EUVYgYWxsb3dz
IGd1ZXN0cyB0byBpc3N1ZSBTTU1VIGludmFsaWRhdGlvbiBjb21tYW5kcw0KPiA+IGRpcmVjdGx5
IHRvIGhhcmR3YXJlIHdpdGhvdXQgVk0gZXhpdHMsIHNpZ25pZmljYW50bHkgcmVkdWNpbmcgVExC
SQ0KPiA+IG92ZXJoZWFkLg0KPiA+DQo+ID4gVGhhbmtzIHRvIE5pY29saW4gZm9yIHRoZSBpbml0
aWFsIHBhdGNoZXMgYW5kIHRlc3Rpbmcgb24gd2hpY2ggdGhpcyBSRkMNCj4gPiBpcyBiYXNlZC4N
Cj4gPg0KPiA+IFRoaXMgaXMgYmFzZWQgb24gdjZbMF0gb2YgdGhlIFNNTVV2MyBhY2NlbCBzZXJp
ZXMsIHdoaWNoIGlzIHN0aWxsIHVuZGVyDQo+ID4gcmV2aWV3LCB0aG91Z2ggbmVhcmluZyBjb252
ZXJnZW5jZS4gIFRoaXMgaXMgc2VudCBhcyBhbiBSRkMsIHdpdGggdGhlIGdvYWwNCj4gPiBvZiBn
YXRoZXJpbmcgZWFybHkgZmVlZGJhY2sgb24gdGhlIENNRFFWIGRlc2lnbiBhbmQgaXRzIGludGVn
cmF0aW9uIHdpdGgNCj4gPiB0aGUgU01NVXYzIGFjY2VsZXJhdGlvbiBwYXRoLg0KPiA+DQo+ID4g
QmFja2dyb3VuZDoNCj4gPg0KPiA+IFRlZ3JhMjQxIENNRFFWIGV4dGVuZHMgU01NVXYzIGJ5IGFs
bG9jYXRpbmcgcGVyLVZNICJ2aXJ0dWFsDQo+IGludGVyZmFjZXMiDQo+ID4gKFZJTlRGcyksIGVh
Y2ggaG9zdGluZyB1cCB0byAxMjggVkNNRFFzLg0KPiBDYW4geW91IGFkZCBhIHJlZmVyZW5jZSB0
byBzb21lIHNwZWNpZmljYXRpb24gZG9jdW1ldCBwbGVhc2U/DQo+ID4NCj4gPiBFYWNoIFZJTlRG
IGV4cG9zZXMgdHdvIDY0S0IgTU1JTyBwYWdlczoNCj4gPiAgLSBQYWdlMCDigJMgZ3Vlc3Qgb3du
ZWQgY29udHJvbCBhbmQgc3RhdHVzIHJlZ2lzdGVycyAoZGlyZWN0bHkgbWFwcGVkDQo+ID4gICAg
ICAgICAgICBpbnRvIHRoZSBWTSkNCj4gPiAgLSBQYWdlMSDigJMgcXVldWUgY29uZmlndXJhdGlv
biByZWdpc3RlcnMgKHRyYXBwZWQvZW11bGF0ZWQgYnkgUUVNVSkNCj4gPg0KPiA+IFVubGlrZSB0
aGUgc3RhbmRhcmQgU01NVSBDTURRLCBhIGd1ZXN0IG93bmVkIFRlZ3JhMjQxIFZDTURRIGRvZXMN
Cj4gbm90DQo+ID4gc3VwcG9ydCB0aGUgZnVsbCBjb21tYW5kIHNldC4gT25seSBhIHN1YnNldCwg
cHJpbWFyaWx5IGludmFsaWRhdGlvbg0KPiA+IHJlbGF0ZWQgY29tbWFuZHMsIGlzIGFjY2VwdGVk
IGJ5IHRoZSBDTURRViBoYXJkd2FyZS4gRm9yIHRoaXMgcmVhc29uLA0KPiA+IGEgZGlzdGluY3Qg
Q01EUVYgZGV2aWNlIG11c3QgYmUgZXhwb3NlZCB0byB0aGUgZ3Vlc3QsIGFuZCB0aGUgZ3Vlc3Qg
T1MNCj4gPiBtdXN0IGluY2x1ZGUgYSBUZWdyYTI0MSBDTURRViBhd2FyZSBkcml2ZXIgdG8gdGFr
ZSBhZHZhbnRhZ2Ugb2YgdGhlDQo+ID4gaGFyZHdhcmUgYWNjZWxlcmF0aW9uLg0KPiBEbyBJIHVu
ZGVyc3RhbmQgY29ycmVjdGx5IHRoYXQgdGhpcyBUZWdyYTI0MSBDTURRViBhd2FyZSBkcml2ZXJp
cw0KPiBlbmFibGVkIGJ5IHRoZSBDT05GSUdfVEVHUkEyNDFfQ01EUVYgb24gZ3Vlc3Q/IElzIGl0
IGZ1bGx5IHN1cHBvcnRlZA0KPiB1cHN0cmVhbT8NCg0KWWVzLiBXaXRoIENPTkZJR19URUdSQTI0
MV9DTURRViBlbmFibGVkLCBpdCBzaG91bGQgd29yay4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

