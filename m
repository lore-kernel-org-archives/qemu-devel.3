Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D050C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 07:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOXpD-0002du-47; Tue, 02 Jul 2024 03:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sOXpB-0002df-4y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:21:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sOXp7-0003Uj-HS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:21:12 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46267RWV009606;
 Tue, 2 Jul 2024 00:21:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=proofpoint20171006; bh=ZT
 t2xpegsUYD19qNfxUB6/ss+HaGcpgcoQK8wUai1Bo=; b=1YAtBRuV41M0UgkuQi
 SlDGLyBwlqr9UC87VCcgtszdqK+Kn3v215PonQBhMcTcGa6YSx7m+0qesdXCrbNa
 T5zkTebAtgip/PbhuC3gwNjD16VnK+iYVB3zJxzFtqazusYI+QqlgxB5TDFZLdAc
 ljkTB/biayravl8vUjxuGqhczpq1BvPk8/59fQxpY6VlS+I8rkflD8XUenHtVR6S
 ZWiIzPaI41vi8AsxANK9+gsLyDohCY6aBlNmafMZ/bPd8UKlHzdBM4zXyKlvfDJg
 WsfwUfGWLswy7Lpb+LS4nQHVeRLXertJAc/yT9jttDifyL2+UizVPKsh939iNBvY
 05aw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 402gcfnara-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jul 2024 00:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFngkkeAZxhnzHMpOvqPBPtKvcAYj2y3AAhRqmHaJdfaLPAbpVfMQfzH2BTelYkuYI7L9uX17Hg5/O0Gk/AroKCSdjZLyiVYEriAyK/r2oGwMVt2EdE2rpNFFbBOLBMxiBm74EJ+sbuojUPOS3t0JgfzMOpW51LB+K1PEE8F/fTDQJfsUGMFFjhUbi58WzYV9sCXXmYJzKLy8xLcqNAeidX84lY91jdfX0EyXYpGsBo8W8TyGxhAxy+BwekZh9qag2RAWdlippP1u3kfeWtPQGTnjC2bE2JqB0XEN2HDboxO0JOARwdk1UR9XS2ERJRT9bDOT587/BrBYoJ5Hk4Jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTt2xpegsUYD19qNfxUB6/ss+HaGcpgcoQK8wUai1Bo=;
 b=akw8lM+3dba+7En6vvF4ORVdVzzf8e5ZVvznhrxxHiaIZfNwSBP/Pn0LnXsLw+TALhITMvETwRpUiKa/oPyLJvAeT781VhOoC5nHF8GCUKXr/oHT0ozzR8/VYfPW7FmfxFvzAN74GilS+eNhFQmh1RPaPz2PD8Z+tJ4pvmGnZEacaHIVlCw+uPC/uVU1ZQbYxMM3r/TUlHgduBgJNm8UAnxDYe1lJPXiBqglI+RQMcwnjsbp+Y8F7fuJjciLI0SG0GTTVRk+/4jANa0+1fCLGvbjswDlEWYhCJIfJUXK+/PWikEuNSPJNDcXVwGapMzbOsD9zea4kawzzav2mj9taA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTt2xpegsUYD19qNfxUB6/ss+HaGcpgcoQK8wUai1Bo=;
 b=umrJGgZy/KUKGArtZwj9O+dGYpFWaGqMUlnaDen/he3bUwolOo74OP2jwkVBr4ZPnQd+PIbznGZmAOIrZWAo/HSHA9rtn8tDNDfAYkzJ5V7rzFPwt+8umzyj+RaVxWjHhL9PnprpBSFiwwISSidA41pzlSewlEiJg9zm8Ffqze/NzXSWyBIVcqQCLbfg8YiizWxEuL1RpkyGG+gKyPOOD64OWOgQe7sm/G5rmid6EFpmI4KBdF17Ts7sHSSDYlqCGMhkkv6m8GSpZsx81h+lb5V3vwlBFgNlkX3R0nXXpa44BaNedhPxdOTI7geWsDk+DjyXSSNZo4z7ZFN8XtyaZQ==
Received: from IA1PR02MB9017.namprd02.prod.outlook.com (2603:10b6:208:3ab::12)
 by DM8PR02MB8037.namprd02.prod.outlook.com (2603:10b6:8:16::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Tue, 2 Jul
 2024 07:20:58 +0000
Received: from IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616]) by IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616%3]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 07:20:58 +0000
From: Sandesh Patel <sandesh.patel@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, Rob Scheepens
 <rob.scheepens@nutanix.com>, Prerna Saxena <confluence@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: More than 255 vcpus Windows VM setup without viommu ?
Thread-Topic: More than 255 vcpus Windows VM setup without viommu ?
Thread-Index: AQHazFBiZqEUa3wJsEqYSvPq7Q2M2A==
Date: Tue, 2 Jul 2024 07:20:58 +0000
Message-ID: <676EF3A7-3521-4AF6-BB1B-04E21097A70D@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB9017:EE_|DM8PR02MB8037:EE_
x-ms-office365-filtering-correlation-id: a1c501d5-da70-4b78-68b5-08dc9a6784d7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WnVVVFdjSS9mN0NzOGxVbUFtblFtV0pGc3N2RnIxeEh1bHYvTndJQ3dpa3hv?=
 =?utf-8?B?TFhTb1lZZWJMb1d2aHZnNkEzNmphanhQS0hUaGJoamZiZk1MOEZHMUFXcjYy?=
 =?utf-8?B?RmRyMFFDU3BOVlRaN0xMTTd6amp4VDJHdldDaFUxOTRZeUwzc2d3aTh4NVNv?=
 =?utf-8?B?QmpQVXdITVNuOWV6QnBDM0tLMHNWQWxici9lZStMWnJmazEwSHpoNHIyeTlk?=
 =?utf-8?B?ejJVd1J6QjhkQWlxczk3dDIzK2Fwd2g1MXFmTnBHUDU4ZlVkYVB3dkZXbjdl?=
 =?utf-8?B?U3BKVm9GaUpaV1RLYU9DWWkzTXdvRlhEMWxmcGtPb2orMjZNdStwcWVmVUo3?=
 =?utf-8?B?Zk92bDRMRDZjVUtmVldkenY2RkRMU2xkdk5aMmM2NE5BZGpIc0ZSa1pnd3Vm?=
 =?utf-8?B?MVg4aDB2SGVkeDI0eEprVEFZR01MalBuMjh5dUxPYTF5THFHZVptcDZoQmxr?=
 =?utf-8?B?enpnSWJpT0VDYkg2UHNsUXcvdWl1djJ0TFNkVWNaWGd1ak5wdG1kNWdveGQ4?=
 =?utf-8?B?aXRsMkF1SlphQlVrL0UrVlZPdHdBSEJudGh0VVN6R1N4N1Z2VjRYSnZuMzJa?=
 =?utf-8?B?bU5NWXJucTdKTGlzK3MwL2VMNGNsa0pkSmhNOGhyRDk3TWsxNGlSTW84QzF1?=
 =?utf-8?B?Y0hCZ292amhJL0FROXI1YzNDUmNZUDdSRFltQXR6YW1xQVlFaWJkWk9tcnps?=
 =?utf-8?B?a3ZUWVRRZWR2Y3FlNnZ1a2Foby9XUllkb2VYaWhqZEVxd2tkUytoc3owai84?=
 =?utf-8?B?YldIQklRT3d5UXJpbEhxQU1WcnM0cVdkd1RBOStJWFprQVI0eTFwNVNBRC9y?=
 =?utf-8?B?UlJmTWFTcU1OcHZOL1FQcmhSOUs4SzgvYnVFVURlUVg5aFNFLzRjSzVwZVlL?=
 =?utf-8?B?Tm1GWjdxOGhwSjcrU0ZRMElHU042SHpVMnpPUlZscUdtZHhMbldQT20yRkFu?=
 =?utf-8?B?TUE4ZWY5WlZaYXhnNUFuZm1CTzdnNEdEcEJpVndYdHBMQ0htdWJpYUJ6dit2?=
 =?utf-8?B?RWhkV3NwN1VlNkErTis5Ujlsak9DNzRvV25ERmphcURiUTFXblJubjRERjQ2?=
 =?utf-8?B?c2VqQjFkOEo5ak9KZW9yamFFZjZqemR5dUJWWGlzclVVcDkzR2JabDJWdERF?=
 =?utf-8?B?MUZFTjE1M01zZmhDQzNCRWtCek1QV01rSXRzOFhsK0dLT1M1ejU3N1c0V3hT?=
 =?utf-8?B?ZHNQT3lBUGJrUFpjbFA4S2lHV1RjaGFIT0RGVUxVQVNVV3E2RWV3VTZPajkr?=
 =?utf-8?B?OWt4QUozaTdmaGNMdElPVE9BWmtNaStDUytJNVpPOUlsWG44THY1RkRPV0cz?=
 =?utf-8?B?dy81eWxjU1llblAxcXRKZE1YSWJKR1h2YlJCQU14cjBBM1VmdWVOdktwc0Mr?=
 =?utf-8?B?dlJybkRHYU83NENCd1IzNWY5ejNaUExWam45UmdXcmpOSmRGZ1JpeXNGYUhk?=
 =?utf-8?B?eHRPS0J4TG9Dd0U2eDc4Y0pST3FjUUxyOVp6djkxNEw2RHp0Yk1nMDJ5TDNS?=
 =?utf-8?B?a2x4Mkt1Z0NnTEFTbzVYMWl5aVloREdwREcrWnlQVU02eTVPT3NOSFRFek9F?=
 =?utf-8?B?Z1orL0pBZzJqV3A1ZFF3Z0Z0bEpWQWNLR2dVTWQxZEVIRXpmWmhLbzc3b3VY?=
 =?utf-8?B?MmErbm1uZ202Q0dqMUdXNEROeUU0NktITlZ6WVBuem1SZEppS09OL3l6VjF2?=
 =?utf-8?B?c1R4OWMxeWx2YW9tNlRiNEtDMEhJdzcwZkIvYlhERmcwVDJBelZtZ1RRbjIv?=
 =?utf-8?B?cWF5b0l3V0NIdHdraitDMWhHN1Z3YmdlRk5WS0hXUXZJL1VrQjRaOWJRSkdp?=
 =?utf-8?Q?XQ0VYNGxer8AZ3h2dpLJ+IJN+1FT/ViCcqEkE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR02MB9017.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUF1dnJuWTg4YzB3L1BwL094ckNkWEMwVWlGS1BWUS9YRGhmOWM4dllZTi9r?=
 =?utf-8?B?ZUVhZm9yWWhqbkNRaTA1aWxiU045R0Jmcy80Wk1IdGRsTW5XbmZ5azI0UjBn?=
 =?utf-8?B?TnRNekVDcFNMVHJKVjNxWkVZbFFPcHBCMlFuOXNrcHZ2WGNUWHNxcDFNQzVK?=
 =?utf-8?B?L0xTdDRwQlVLdm5IMkYwdnBBWjZOVFZWbHE4NThQUkQrTzZuL2FqV0QyaTdZ?=
 =?utf-8?B?K2s5NnJCdVBLZnhrUEFTV1RYODFpcWNtWTg0N1I5bEhST29XR2Y2SXJVOVNJ?=
 =?utf-8?B?Y0ZzNTF2YlZndXZZYVhtb1dhaDEvTTRMZU51Z0FGSmVsWWxINXdxSGM1UGor?=
 =?utf-8?B?Qk5hQ0VYYlh6N1Rob1pvQjA5Wk16R3BKdXk2RnIzcm91VUZPR0RiNVB5ZTlM?=
 =?utf-8?B?SnVnQUVCRU5rVERsakpqcFI1NmExN3NYcGxKeXhicnBMdkpMeC9NL2RmZEpm?=
 =?utf-8?B?bHo1WHlSWU9pUDFsWkFid1o4WStsV213Y25qbG9lcnFJQjJiTm5XL0FieGE2?=
 =?utf-8?B?eFNPaUJudllOaFVXWWlHL0tINnpNbnBEMTBmcHpEOVhJalhoVmxkbUh1bmZ4?=
 =?utf-8?B?VnN5c2U4MlFmMnlFbjlqY0YrMHRJQ243WDRHbXl4am1NRGZNRlEwbzFFWm8x?=
 =?utf-8?B?ckNDMXgwQllTVEpFczN6bHRJZXBzR1ZQd2x6ejhUN3diUU9mcTU3eno5bWlU?=
 =?utf-8?B?Zmp5VVBkSFNmbHMwdkdKTEJYaTByYUFnTC9vLzVaNXFSYmUzTVNyS0hZcUlr?=
 =?utf-8?B?V0hFUEpOYndHbW43ZDdHcjVyNUNyS0N0QTNMSlRFYjI2T0Y3NUhiczBPSHhL?=
 =?utf-8?B?Q3NQOTB0L01ndHA5L1k4S2hPQWN2N2NQQ0F6eS82ajlzQ1VaUDlIRVBXb2x4?=
 =?utf-8?B?cU5zcHBVMlB1UlFRWnUyeUtTaUxYQXg4MkprR2Y1M21DVGd3TVhFenFsMjVt?=
 =?utf-8?B?WWZqRnQvOFNvdnFzZFhEbWVFdkVwZWF6eWh6Qk9mLy8wMmtscEVrS2lVbzhL?=
 =?utf-8?B?bk81dktyNGN3RnRoYk0vdzcrK1NzS3pjSmRLQ3ZrdTJHdVlkSHNMZ0J1MGxm?=
 =?utf-8?B?U3RheVRubWNFUUFpbnB0TlRrT1h5ZXJRS2JDbDhYa3J5VXpDd0pEeUgvUXcw?=
 =?utf-8?B?enNZRFh0VzhIZU40RFNoS0svN3FYK1hIcG5aNVc4VXpQNzFVVHJCVUVySk1y?=
 =?utf-8?B?enVBWEVCclBQK0hUZjlHOTYrVzhNUW9iR25PMGlaSGZNUk9aSzl1bzZDVmh6?=
 =?utf-8?B?UDNqKy91RGhnSTk0ZTc3ZmtZQ1BVb2hEeWxIMG1MUEtKQkk3bCtRUTdvLzJa?=
 =?utf-8?B?cnZ3Vk1hb1VuWkpMbkhWYTJKTGFpNXI3dFZFbzc5L2Y0RFNUU3piVkx2d1ZL?=
 =?utf-8?B?SWI4T0YzOVZTeC90V0xhRmRGS1JVS1VtRmdBeit1MWJXRlV4VW1XN0Qzb3k1?=
 =?utf-8?B?NVpVR3JRNXZBWnptOG5hWVZWbEd4b1hNdlY2bUk4bW0xSzY4SEJHZ00wSkJC?=
 =?utf-8?B?TjlCZkt6anhaaitHL0lIWUdPemJDYWdMRnBBcEtKaFVReGFCUzh3dksrbFpr?=
 =?utf-8?B?WUdyeGZEZ0szU21QZFU5RXpjaGlnc1RnMGprVmRPNG9TcW1RcUpHWVZpbVlB?=
 =?utf-8?B?aGRpVnh0R3lKMjZWWXNiV3dYUkhLZE9tSjVzWGJrV1hCb1ZrNElCWmxDWDJJ?=
 =?utf-8?B?NXVHaklSUnZ3Y0tuc0JkZGdqOUNpd2c0eUN4YTZ0T3ducGZFMy81RUh6MnZV?=
 =?utf-8?B?T2RUZkU4M29FUGhZWkZpcUdRMGp3L0tvYlNNVmFIaTRzV2EzV2lGQ1U3aFN6?=
 =?utf-8?B?UmNhc1JTcFdwMVAzVmt1cGQ2UU1Wdjcwc0YvSi9EUUdGNkg5dk9vV21zc0dw?=
 =?utf-8?B?WU5nYWg0SWNJeGg2bWNSVVNXcGM2V0M0N256L1AwSURlUmZwOWpIRnExbVpn?=
 =?utf-8?B?ODFoT0RFc3BFU0JMbi8rMnFXV1F4NUFmaXVUZnVXRDlBbVZvTFBQbzQzOVNK?=
 =?utf-8?B?VWJqVm1iekVCdmdhMVBaS0hBQ3ZIREV0SG9FOXpvaEtkM0gvcVkxTjN5VG4x?=
 =?utf-8?B?UnNEQWU4OFhPQldEcDFEbHB1c3YyU2FxdTBSWmJHMy9TUHVQRlpINnpCWXN1?=
 =?utf-8?B?RzgyR2FUVmRPY2UvbE5MQlpkRnU4Sm82ejIyeDdBUGtYUk1WaVdRWHdZQXE2?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE2A06060EAD8042A706B06F4935998A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB9017.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c501d5-da70-4b78-68b5-08dc9a6784d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 07:20:58.0707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKtocvDN6GZ9PWosk9ZW24rVqI2adxCQeI/1NCf5JkbMMYR9s7NhlX9RiIk1JsUb/4ADKXGXClvgIFBoNnBeotlddAMm+qXLek8ThgjzuIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8037
X-Proofpoint-GUID: cWN9yfCNRXQQ74jXZJeLJwqzSLRsi6uY
X-Proofpoint-ORIG-GUID: cWN9yfCNRXQQ74jXZJeLJwqzSLRsi6uY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_02,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=sandesh.patel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQWxsLA0KSXMgaXQgcG9zc2libGUgdG8gc2V0dXAgYSBsYXJnZSBXaW5kb3dzIFZNIChzYXkg
NTEyIHZjcHVzKSB3aXRob3V0IGFkZGluZyB2aW9tbXUgKEVJTT1vbiwgSVI9b24pPw0KV2hlbiBJ
IHRyeSB0byBwb3dlciBzdWNoIFZNLCB0aGUgcWVtdSBwcm9jZXNzIGNyYXNoZXMgd2l0aCBlcnJv
ci0NCmBgYA0KcWVtdS1rdm06IC4uL2FjY2VsL2t2bS9rdm0tYWxsLmM6MTgzNzoga3ZtX2lycWNo
aXBfY29tbWl0X3JvdXRlczogQXNzZXJ0aW9uIGByZXQgPT0gMOKAmSBmYWlsZWQNCg0KYGBgDQpT
dGFjayB0cmFjZS0NCg0KYGBgDQojMSAgMHgwMDAwN2Y0ODRiYzIxZWE1IGFib3J0IChsaWJjLnNv
LjYpDQojMiAgMHgwMDAwN2Y0ODRiYzIxZDc5IF9fYXNzZXJ0X2ZhaWxfYmFzZS5jb2xkLjAgKGxp
YmMuc28uNikNCiMzICAweDAwMDA3ZjQ4NGJjNDc0MjYgX19hc3NlcnRfZmFpbCAobGliYy5zby42
KQ0KIzQgIDB4MDAwMDU1YjcyMTU2MzRkMyBrdm1faXJxY2hpcF9jb21taXRfcm91dGVzIChxZW11
LWt2bSkNCiM1ICAweDAwMDA1NWI3MjEzYmZjN2Uga3ZtX3ZpcnRpb19wY2lfdmVjdG9yX3VzZV9v
bmUgKHFlbXUta3ZtKQ0KIzYgIDB4MDAwMDU1YjcyMTNjMDJjZiB2aXJ0aW9fcGNpX3NldF9ndWVz
dF9ub3RpZmllcnMgKHFlbXUta3ZtKQ0KIzcgIDB4MDAwMDU1YjcyMTRkZDg0OCB2aG9zdF9zY3Np
X2NvbW1vbl9zdGFydCAocWVtdS1rdm0pDQojOCAgMHgwMDAwNTViNzIxMzliOTM2IHZob3N0X3Vz
ZXJfc2NzaV9zdGFydCAocWVtdS1rdm0pDQojOSAgMHgwMDAwNTViNzIxMzliYTY0IHZob3N0X3Vz
ZXJfc2NzaV9zZXRfc3RhdHVzIChxZW11LWt2bSkNCiMxMCAweDAwMDA1NWI3MjE0Zjg2NWEgdmly
dGlvX3NldF9zdGF0dXMgKHFlbXUta3ZtKQ0KIzExIDB4MDAwMDU1YjcyMTNiZGMzZiB2aXJ0aW9f
cGNpX2NvbW1vbl93cml0ZSAocWVtdS1rdm0pDQojMTIgMHgwMDAwNTViNzIxNTE0ZTY4IG1lbW9y
eV9yZWdpb25fd3JpdGVfYWNjZXNzb3IgKHFlbXUta3ZtKQ0KIzEzIDB4MDAwMDU1YjcyMTUxNDg5
ZSBhY2Nlc3Nfd2l0aF9hZGp1c3RlZF9zaXplIChxZW11LWt2bSkNCiMxNCAweDAwMDA1NWI3MjE1
MTRiODkgbWVtb3J5X3JlZ2lvbl9kaXNwYXRjaF93cml0ZSAocWVtdS1rdm0pDQojMTUgMHgwMDAw
NTViNzIxNTFlM2ZjIGZsYXR2aWV3X3dyaXRlX2NvbnRpbnVlIChxZW11LWt2bSkNCiMxNiAweDAw
MDA1NWI3MjE1MWU1NTMgZmxhdHZpZXdfd3JpdGUgKHFlbXUta3ZtKQ0KIzE3IDB4MDAwMDU1Yjcy
MTUxZWU3NiBhZGRyZXNzX3NwYWNlX3dyaXRlIChxZW11LWt2bSkNCiMxOCAweDAwMDA1NWI3MjE1
NjU1MjYga3ZtX2NwdV9leGVjIChxZW11LWt2bSkNCiMxOSAweDAwMDA1NWI3MjE1NjYzNGQga3Zt
X3ZjcHVfdGhyZWFkX2ZuIChxZW11LWt2bSkNCiMyMCAweDAwMDA1NWI3MjE3NTAyMjQgcWVtdV90
aHJlYWRfc3RhcnQgKHFlbXUta3ZtKQ0KIzIxIDB4MDAwMDdmNDg0YzAwODFjYSBzdGFydF90aHJl
YWQgKGxpYnB0aHJlYWQuc28uMCkNCiMyMiAweDAwMDA3ZjQ4NGJjMzllNzMgDQpgYGANCg0KVGhl
IGVycm9yIGlzIGR1ZSB0byBpbnZhbGlkIE1TSVggcm91dGluZyBlbnRyeSBwYXNzZWQgdG8gS1ZN
Lg0KDQpUaGUgVk0gYm9vdHMgZmluZSBpZiB3ZSBhdHRhY2ggYSB2SU9NTVUgYnV0IGFkZGluZyBh
IHZJT01NVSBjYW4gcG90ZW50aWFsbHkgcmVzdWx0IGluIElPIHBlcmZvcm1hbmNlIGxvc3MgaW4g
Z3Vlc3QuDQpJIHdhcyBpbnRlcmVzdGVkIHRvIGtub3cgaWYgc29tZW9uZSBjb3VsZCBib290IGEg
bGFyZ2UgV2luZG93cyBWTSBieSBzb21lIG90aGVyIG1lYW5zIGxpa2Uga3ZtLW1zaS1leHQtZGVz
dC1pZC4NCg0KT3ZlcmhlYWRzIG9mIHZpb21tdSBoYXZlIGJlZW4gc2hvd24gZm9yIGV4YW1wbGUg
aW4gLSBodHRwczovL3N0YXRpYy5zY2hlZC5jb20vaG9zdGVkX2ZpbGVzL2t2bWZvcnVtMjAyMS9k
YS92SU9NTVUlMjBLVk0lMjBGb3J1bSUyMDIwMjElMjAtJTIwdjQucGRmDQoNClRoYW5rcyBhbmQg
cmVnYXJkcywNClNhbmRlc2g=

