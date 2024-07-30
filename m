Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD0C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpIB-0005hg-LJ; Tue, 30 Jul 2024 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYpI8-0005Zz-AN; Tue, 30 Jul 2024 12:01:36 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYpI6-0008Ge-2s; Tue, 30 Jul 2024 12:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722355293; x=1753891293;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tlKg1wkPVhf0tLdmujZFkyt5XvAOVk7PhdpehMq8agY=;
 b=Q7xl1+g2lIaP94+HcHGPr2YJml0nKlIR5qwSyDKV64Xu1siGeT7v18Xc
 +6BIYhvyeGlxL5xDy7fmpcStPW4uqwT6oJzvsnf4q2xN6Nv35+hStIX1h
 clc+5EERMnXCJxc/ORf2udnptPVQPPDTKcTZXhuBOCjHufdylIxjCw8dK M=;
X-CSE-ConnectionGUID: vXxZzFdtRPmlmpIZ9mnraQ==
X-CSE-MsgGUID: ooi0LvzcSEeyL4hcHfgOCg==
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2024 09:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7TnyMtdIeaBiIUKg24rOujcWliSX3CllR2ioDRGGzZE7lP/oTHkP2glgqXyOa2FP/Boxv+Znch88e6KDosx+WGU7GkZeVVMHV78F1/q8fRSMmmhYk1GoRhRpnYXEdg0mLSZjbE/w6muzk+FgaU/NpMISv3IWhUShB3aLyRmKE9N+UJiR5xcaORbolNX7pBqKvC1Aacgx2rXl11NrmvF9c8boXu3lR3VIM01i5jzxuxyWCrCA8f76WPfe2gxO+1AHP1g2BURX3PR0lzryutyId/jakGKDPEjNrlhuATlBHYW01CWD+kHr4jRy54Q4OuYQxOhV7CEoZViGPu3x6DDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlKg1wkPVhf0tLdmujZFkyt5XvAOVk7PhdpehMq8agY=;
 b=sV27aUzRNPGegulpFzMYzb6I2BwuFZvKD6PQalevgXtT9UFqKgJxDtZ2JwqNJQPZdyroVOihalSsRr3AqBwfFS4mvvGsHPyQ5cqX/F/PDNjcbEoqS1gpq2hyaMUhEMpT+5CEo+gMkbsFLYx6qb4+WrP00V4Tl8s2O8lDexnUv07oAAEZMFXDdCDDijNaadOLv93VKIhPApBnOZSnLZO7bQft0WsSVHy6Fm9+duM/A502PlOwXlfArFxXxOYonIrgM2XdY/qe1UM8L6CbL84/Gez0Lr9DCHLdBHkDYmUOnaTd5Myk/MutEbQlH8cG64BI7jTmfVMkAw6W6lmgBjZJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlKg1wkPVhf0tLdmujZFkyt5XvAOVk7PhdpehMq8agY=;
 b=QJ1Rr1soQI1tEsIjTZ+UoVam3hfSt71B/TcBSOcyn+PNuT0Tn4M7tEtCTouMkeI2haUSL3wj2TI17N1KmFdMSmwbpepyXynyn7D3yagJIOP5hP3VKYdYhTzjax7S1HrThrdrHwgobB1NOJwoBHQoIRmSUm61cNlK3MqXeipE9u4=
Received: from LV8PR20MB6853.namprd20.prod.outlook.com (2603:10b6:408:203::21)
 by SA1PR20MB7339.namprd20.prod.outlook.com (2603:10b6:806:3dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Tue, 30 Jul
 2024 16:01:25 +0000
Received: from LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad]) by LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 16:01:25 +0000
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "berrange@redhat.com"
 <berrange@redhat.com>
Subject: RE: [PATCH v2 2/2] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Thread-Topic: [PATCH v2 2/2] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Thread-Index: AQHa4enbvOxZS34yIUCjiaHsUo+eeLIPGgAAgABSDJA=
Date: Tue, 30 Jul 2024 16:01:25 +0000
Message-ID: <LV8PR20MB6853062C5F0569DE8FCED30AEFB02@LV8PR20MB6853.namprd20.prod.outlook.com>
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
 <20240729190035.3419649-3-alejandro.zeise@seagate.com>
 <71d5b310-c2ba-49a3-8d95-5949f912dd76@kaod.org>
In-Reply-To: <71d5b310-c2ba-49a3-8d95-5949f912dd76@kaod.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ActionId=affb32a9-3a91-4cc9-a693-98992875dc29;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=true;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2024-07-30T15:49:13Z;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR20MB6853:EE_|SA1PR20MB7339:EE_
x-ms-office365-filtering-correlation-id: 7a977739-afba-4120-a3e5-08dcb0b0dd80
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?blkvUVpKYjBZRitDTmQrdmlnNlF4SGxtWXZoSlYzaVpEUC9lSEVIMXdMSllm?=
 =?utf-8?B?VUdvZ0JucEcwQUFrZTBLdzgxTDUxaVhzTnVvSk1aYm5reXVyNkpEd25ueC8v?=
 =?utf-8?B?NTFOanhWVS9zaE9XTWFDRUpiL0xoOGNPZVRNSzlmQ294a1NxZi9hSmFEYnM4?=
 =?utf-8?B?bmJHUDR2d2xGZzVySjB6K3pEVGd2RUszQzVyc1EzT0pNSkgvZHQ0cXJrYXhu?=
 =?utf-8?B?RUZWS0NVM1NYcFVLdkdtOVNLY2t4Q1FLM3cvMFJwRm5PMjIrckVCWDB4a1Zr?=
 =?utf-8?B?d3BDWVdJWUY3elVwWWVEUVVRZlYzdzB0d0Z2c21PN0VFOVczREszNEdEUVJt?=
 =?utf-8?B?bVNWemY5UHJwMHpEOGJjdGl4bDJnWHNWbC8yV1RoU0diNVBicVpjMXk3ZHJY?=
 =?utf-8?B?MUR0dFJzTTVOblRWM2tlTUg1QUVtTlVOZytNS1hteHV3NU0xQnhFRjJneEc3?=
 =?utf-8?B?VTduVkNrUXJidDRlck9sMUN6STdHTnJJV0RUOXRIVjZqaVhjNUJsaXdVKzZj?=
 =?utf-8?B?RTE5VWtoZ21CS2dBYm5hMHg4aHlUSnFTTlYzYVF0aVp3azQ2WjZ3VnhLMDY4?=
 =?utf-8?B?MExqWFo0MjhjaWhKZVdSSE9XbjU0Q2NzRVFrTThYcGdmaklKOEhSdnY0cDlB?=
 =?utf-8?B?VnNSN0IveEd0b041SXZmSVY2SHFqai9nNXAzcGVqNGxCSHhFSjRnZXpNbXNZ?=
 =?utf-8?B?TzJwWElPQW1aSTNxaEV5N212c2Y5WFFhdzRQa2ErWC9kenREQVdBbDNQeU02?=
 =?utf-8?B?U1ZFclFqMHN1ZFo1aXNEQ1hGbVRaREFsYXoxTkdYTmxCdkdYcjBGNlZ1Y1lj?=
 =?utf-8?B?azhxbWp1dmJod3ROK1JTMjBndndvNjM2TmNZR2Z5MjhxVmY5cldqb0ZVWWhZ?=
 =?utf-8?B?emh6UDl5VGVHdVFhSzkyaGNUakxYTDN4LzJjRHhKWWRNdFpUbkFHRDA1QXMz?=
 =?utf-8?B?eEdQUUtSOWp0L1pvU3NZRVVidlRLY0NmMi95TjA1b25RUW5adWxUR0JMSkR2?=
 =?utf-8?B?NFRwdmpQanRHUUx3UTFMMzZtZmdnSXFDWGVxVUVMczdkQ29FVC9FQkdqVVBH?=
 =?utf-8?B?bzR2SFNSUkpMaFdHVzJvNWNHM0dDTTViYlZ3V1l2cFd1bTlBWHMwbUlqYWkr?=
 =?utf-8?B?bktkQjdSSUJwWkJPT0JLTkFkTmNRK1plc280RDNIb2FHbksxL1ovMVlKeVFO?=
 =?utf-8?B?ZGI4YVZLd244Z1JZa3JXRE5XVjB3WTVEN3BDQTA1NitiZVByV2J0ZEJ6Slkr?=
 =?utf-8?B?b09EMFJxcFFEWVJZcEpJRzdzMXUveHhZSk90MGVnaEJNSmc5WGNITTFQSms5?=
 =?utf-8?B?NTdxb0pyY2FFeXpEd2xNampNNExHcWRQL0QzQWc5c28vbGQ0cXk4UlpGVnBh?=
 =?utf-8?B?Z0psKzA4WGtsc2JJOWlTR3dXVWN1V3ZMRnFmc0l1NFg5S2lxY0ZmNnl6eGJH?=
 =?utf-8?B?N3RIbHQxb1ZoK1M4L3htdWxhZWt5ZXpVYWxPUy9iMGxoQlMvbnZLWDV0cWRJ?=
 =?utf-8?B?MG5NSzhkTDh3aFJEMUFEYWxucHdubWE4VERnSXNITFozL3Jla1AxWWpiallO?=
 =?utf-8?B?dG1TR29FZ1JFN3AvbkhsRUdkN2hjMm5PdmNybml0cEdHZFdkZGwvbHhvRGN3?=
 =?utf-8?B?VWdCNWtwNTk0RjgwbzFDMFQrOE5PbTBMUThTcmI2VlJBTU90UDFLWk9wRitn?=
 =?utf-8?B?RmVaa1RtRFhjS2E1YURRYi9hWlVxUmVibVpVV1A2ZS95VFRJd3l3OUpxdS9W?=
 =?utf-8?B?cU1zUzlRRkEwSHUrWVBZM2hGOWo3SjZRcmQ0MUYxdWYvMTB0NERuZUQ1RkJV?=
 =?utf-8?Q?KUD+gyjXaDcd/cBlPQQmwgacmtt4hhrgyUYlw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR20MB6853.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2pQYkg0TWNBL3NmNHIxdGovVTBrY2VhYzRNSURkUndFMmIwNW9TTHVtS0d3?=
 =?utf-8?B?OWUreTg2Vmk3Tk1PQkkvWEd1V0NLVldPdlB6NnFROEhZbUd0VEhmMlc2UCtN?=
 =?utf-8?B?YkR3MUt1KzFJRlUrYUthT1JwU2ZJWm9GQjZRc3V6YXdLd3J4THFqMk5aa3dN?=
 =?utf-8?B?ekJySExCWHl5OG14SWVHdVUxQ1RDcFdCOU1GS1QyQ0JBOHFhWUZFeWVRczVG?=
 =?utf-8?B?b0cveFZ4akxGWjlKZ2RCRjhxNlpiV21RUTJPalJYLzViamNBblRCVkVkRW5r?=
 =?utf-8?B?eVd4Rlp0WG5SRDVZcXpVcHZISGZHTzhZL3dreHhCREk1Y1F6VVptd3lIczNG?=
 =?utf-8?B?a0NvTzA2c25ESGgxZVFhZkl5bC9KbkVHaTg3cWtGVmJjd2FVc01sdVNjZ3RI?=
 =?utf-8?B?ZVVXQU9kUG5weGQ3cWdud2wwbFZDaFBOL2s4d2N6WWFwZkduRkorb0ZOU29R?=
 =?utf-8?B?UUQ5dm9wYm9TMXdrQ1pUUnNDSEYvQzUwTDBDQUo3Rjl1UXJwaUwrbk85Y3hn?=
 =?utf-8?B?L3p5TnV0SHhGSGtTdGs4VkVLU1Fkckc1S1krZHc0ZFIveFZUNk5FcDhrYmJq?=
 =?utf-8?B?aXdMSDdtQUdiY2pFTGEwZXBKWXRJWmFxdUdwZzJNSWVnTWRSOXdkYTZDSmlo?=
 =?utf-8?B?QXphTzlkaDJnRCtRajY5RzlwY0RtZmFTL3AxY1VUNmlGRWU2alNsN3Vkblpt?=
 =?utf-8?B?M093MmdOR1cvKzAxa0kySDdVRWVldUpNamtHeDdZa1FBUlBhMWkxZGVzdVY5?=
 =?utf-8?B?OU9ocE9nelU1dWgwOGNBdm5Talg4S1E4UWdPNm5zQUZWN2lqYWR4aVZQSVhL?=
 =?utf-8?B?RTV5K1hWVUR0TWY4V0lRV05MOEM1aUwrZ2pZK2tEQ2JheEhDdHF5c0RRejZs?=
 =?utf-8?B?Tm5nRkgrMjZhNXhRQW5xbGFycG9VU04rMUJaellSR0JTVmt4NWJVSWlpOGhr?=
 =?utf-8?B?NTU4b3dVeVhTejFsRFJLL0poWERMRTExOEhNbElSTGdIc1AyeWxERGFtQnhv?=
 =?utf-8?B?Nko1b0VTZXZlV2ltNUV2VWN6UkVRMUZwZlQxK25yK2V0Q2EzbkJXVjhMVURQ?=
 =?utf-8?B?OVZFYWJWNjQ5RjNoTWF1Wmd3N0dia1RrUDQzMWRmSkVNMzZEWitBTmVmVzQr?=
 =?utf-8?B?ekZySFZidUNrZGxTeDhYWlBOalA5NkdRSEYvUnpYVmR0eC9uSXBTaHl0RW1V?=
 =?utf-8?B?ZG5yZ1IrVGpIcTY2UzMzc1RMcGpsUEtSN3ZRYXpCMG9IbE1SV1FybDF4NnBz?=
 =?utf-8?B?elRYSXZhVXJmcFQ2Z0loNXY2NEVBTWJEMzg5VjllRFBmaVRBaitIZWNsanpV?=
 =?utf-8?B?L0xyUloraVZmSHRWMXRQbVJDTnAzQmhXMCtMWG93YVZKSW9IbFBKb0lqTWlI?=
 =?utf-8?B?dHZ5VEJ4Z0FnQkljSE9EZ2k3dFdqUHNzNkFNNGxsZDBPU2NHd3ROdStvMUFv?=
 =?utf-8?B?SzQvZmV1cEVLWERwQmJtbUpyQzVSdWRDY3k2R2Yxc3QrUFRJUklLM25RY0dM?=
 =?utf-8?B?Q24xbVJBaUxLYXpkdnZqTEQwN01iUmo3VWdXUUh1ejZFZm9NWTlEYWZHMnN4?=
 =?utf-8?B?K1QyRWp0QXRWWFVSSXNjeFZ6SFZoUkhuY3V0T1pLL3BjSDFUSDZOblRZdXhD?=
 =?utf-8?B?UzZTd2R0MUtQeVlTYllZZTZySEU4cnR2ZHV1WEhjY3pubEI5VzNYcFBHYjhE?=
 =?utf-8?B?Tld1dElXU2UvTDF4R1c5Ny84Q0tybUE4UlJWa2lvV1B4eGVST1hYR0ozSkFi?=
 =?utf-8?B?UVQySTJmM2FCODB0VnhmWmFDTGNNSkR4Yk5BbXp2SUlLT213N3d4YkZ4UTZl?=
 =?utf-8?B?Q2Fka3pvWEtLNWszT20rYW9xdmpxOUFEcXRGNkJhM1lQRnVrSTR2eTJxVnd3?=
 =?utf-8?B?dXZqOXhaTWtGSThqc1lQWXIyaytvZ0VzUDVNTVJCaFU1bXc0czhmQmxHUHJJ?=
 =?utf-8?B?Qk5Cd0p4M3JTK3JzU2p4QktuTlBTT1NMSC9LbjFkUFdWdXQzdnhnRUMrYUND?=
 =?utf-8?B?QU13TWhEakU2REdtQUhFT2lWcVFCZi9rRVVSdW5mTFJWSnovNktsODEyM0Vy?=
 =?utf-8?B?eUs5OWtxN1lhZDlKUHluenJueWcvUVdEV0daYVdmWGl5S2hJcWFzY0pBM2JO?=
 =?utf-8?B?NVNsMlJrNFpUVDFFOVlkYUtPK2craTcvRDdvZ0VBeFFJNmkzdlFXOXBkdGsx?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CThB6jXku5rO0vb7JzhJGnCMbWriMIgffwK5F7cz9057iVSjODpNAmhfW3wsY5M2deiQi0OQMOClyLamYrXicVfkwKQQdp/z4xcHVeh6UZ5C57bw2AHNANz5v5NidfwKvcFpmyHwxdFmMM0onS89IuPwl7YVKKQ0h7wWf/lxzLRIoHDPCT7IukLOilMG6YL6xLLWib3jQ7tP5+S/uTyKVJSIuyntcnIGDhhSNyBaGhgGcj0eFf08SUTavgPhe9CApTZ5eQE0ernwCoGTmyHLm/ZX6OIMIbmv0ZK43QrsyBo3meWcclN80g6S3bmbUzhuto2q9Diq/BqcrQobJ55VEnMQGqXXqwgLM28g3+S17EI6h/eD4rV+JXAGT/+3Uj9ApkR5EFTjnmZw4GmzUaCbqUIZpnWtMgnOHcKTizThmQcay8YCHAbLqZBJRa9sUlIarPYkL9An16zTK8fVT+8Tih6BHa8pT2AjSyeXHM+/d9UoGo5/Q3ZvyRholcULzuHVuH9b0s3m4MKWVFHOYYUZStckwe+fJSQYIRlrkXtc+SoJ2Vv/il+BZsssgDu6S79pexDnSMXCfBx9i0uynLS/4LNYUcBRFhpvU10Vgl4RYOk3WKAfXNfnaF7tiq962j8h
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR20MB6853.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a977739-afba-4120-a3e5-08dcb0b0dd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 16:01:25.6276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiCvXJR1bflUh9lj8avj8XI1Vankiru/oqkgLLumExXBJ/bPYSsirDw/MttHs2UeXIlHQlOvL6D9gVmPgruMyjc5w/ipyABP8r3/CEEWxII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7339
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGVsbG8gQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPiANCj4gU2VudDogVHVlc2RheSwgSnVseSAz
MCwgMjAyNCA1OjU1IEFNDQo+IFRvOiBBbGVqYW5kcm8gWmVpc2UgPGFsZWphbmRyby56ZWlzZUBz
ZWFnYXRlLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmcNCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBiZXJyYW5nZUByZWRoYXQuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBody9taXNjL2FzcGVlZF9oYWNlOiBGaXggU0cgQWNj
dW11bGF0aXZlIGhhc2hpbmcNCg0KDQo+IFRoaXMgbWVzc2FnZSBoYXMgb3JpZ2luYXRlZCBmcm9t
IGFuIEV4dGVybmFsIFNvdXJjZS4gUGxlYXNlIHVzZSBwcm9wZXIganVkZ21lbnQgYW5kIGNhdXRp
b24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
ZyB0byB0aGlzIGVtYWlsLg0KDQoNCj4gSGVsbG8gQWxlamFuZHJvLA0KDQo+IE9uIDcvMjkvMjQg
MjE6MDAsIEFsZWphbmRybyBaZWlzZSB3cm90ZToNCj4+IE1ha2UgdGhlIEFzcGVlZCBIQUNFIG1v
ZHVsZSB1c2UgdGhlIG5ldyBxY3J5cHRvIGFjY3VtdWxhdGl2ZSBoYXNoaW5nIA0KPj4gZnVuY3Rp
b25zIHdoZW4gaW4gc2NhdHRlci1nYXRoZXIgYWNjdW11bGF0aXZlIG1vZGUuIEEgaGFzaCBjb250
ZXh0IA0KPj4gd2lsbCBtYWludGFpbiBhICJydW5uaW5nLWhhc2giIGFzIGVhY2ggc2NhdHRlci1n
YXRoZXIgY2h1bmsgaXMgcmVjZWl2ZWQuDQo+Pg0KPj4gUHJldmlvdXNseSBlYWNoIHNjYXR0ZXIt
Z2F0aGVyICJjaHVuayIgd2FzIGNhY2hlZCBzbyB0aGUgaGFzaCBjb3VsZCBiZSANCj4+IGNvbXB1
dGVkIG9uY2UgdGhlIGZpbmFsIGNodW5rIHdhcyByZWNlaXZlZC4NCj4+IEhvd2V2ZXIsIHRoZSBj
YWNoZSB3YXMgYSBzaGFsbG93IGNvcHksIHNvIG9uY2UgdGhlIGd1ZXN0IG92ZXJ3cm90ZSB0aGUg
DQo+PiBtZW1vcnkgcHJvdmlkZWQgdG8gSEFDRSB0aGUgZmluYWwgaGFzaCB3b3VsZCBub3QgYmUg
Y29ycmVjdC4NCj4+DQo+PiBQb3NzaWJseSByZWxhdGVkIHRvOiANCj4+IGh0dHBzOi8vc2VjdXJl
LXdlYi5jaXNjby5jb20vMW0xWjJZQ3JWMnZob2NEZnRhdXU5MlplT2VncWVaZklSRlVBSkp3VmsN
Cj4+IEY5Zkk1Q0VtcTlxOE0wb1lZVEtMSUJFN0g3QW5jOVc4UEcyaVljSzlMMXV6WGRnODBxTnR5
Nlp1MVg2UU43clF2VjM5Y0ENCj4+IHFTOEFvV2NzWU1hQnpWbzZnR0tZMnVwTTZfOGVKbWlPeTJN
N3ZyR21FYWFVRS1Tblc2ekNEMWJiSDNldDZuRXJXZ0dmZ3MNCj4+IFRJeHVpUnpnd3ZFN3dyVFBl
d0E2aXNEeE9zV2VFY2xkQ0t1S2JtWUgyc1NuUTNqcGRaTUttcGdYOXRWWmZJQ0kzbndod2INCj4+
IHd6OFJZQmdfNE9ILThrbDlFQ0VXNmdyS0RQUGk4WTBuaTN6TzhIUHl3cjM2bndraEF1WW1LOGhD
Mjd2QmJmN3FmbG9NdTUNCj4+IHR6UkdKQlVQUWNkU2pXZUtfNE10cnhRQ29JcFVGRUtQTXFmLWll
bFZNc0NUc3VZaDBBQmhCOXVyODRmY1Fwblh0VEZ1aWINCj4+IFd2UlU2eC1BUUdXMVdtWnpneFVB
ck5uN19IYV9LZjBQa25JMmI5TEpJS2FTQ3VOYTR5Mzd4MGFRcE9fQllMMExCYVFFS0ENCj4+IGNV
ZWRiYXhCLVEvaHR0cHMlM0ElMkYlMkZnaXRsYWIuY29tJTJGcWVtdS1wcm9qZWN0JTJGcWVtdSUy
Ri0lMkZpc3N1ZXMNCj4+ICUyRjExMjENCj4+IEJ1Z2xpbms6IA0KPj4gaHR0cHM6Ly9zZWN1cmUt
d2ViLmNpc2NvLmNvbS8xb2ZpWUZlMVNOUWd6UlEzRTNQUzlMSVRNaFVzREpaSVZXdU9vZ19Wag0K
Pj4gdGduVGFieFg5TnFXNUxZcjRFUEZyVkN6UHRNZi1oQXg4N3FJa1Vpckw2d01ibkt5aGdDZW9i
VUxVbTB3QllpOWJvdGZTbw0KPj4gREtGWGE2dkJPNkdnTmRWQkFiR01TQ08xSWdtb2dCWV9RMzNs
TTZNN09GYk1pcHh4c0dEaElCSk1lWW5lYXFncjVRYXRkYw0KPj4gZ2NtQ2dqdThiMnY2MHEtZjd4
eFRKRnREaWhPRDlyZkN6UGtzcHc5eTlNY1p5elVxVk9iLUZpbi1TWVFFYUM5c0VON3BGQw0KPj4g
WnU1OWRqYVdvY0NJUkl1ZEdTVlB1Yk5DeVY2LUFmVU5sQUw2QmZoLWU5OV9Wb0RwQ012NktDWkdW
b29SamNkQ3ZVVzR1Sg0KPj4gX3FoVmE3VlFLSk1RYkhKRUUtUXExaGRPbFBiUjJBZTVkUW9pekVh
dENsSDA1SlpMRTFsamd1Mkp0QUlyaW9aN0p5Zm1Nbg0KPj4gai13OC1DaERER1lQZHRWTkxLazBf
VHJoejRaOVd2dmxDLWdBV2lyeF9hRXd6QVlGN0ZSQzhJX29xQVpVb0REeEpSY1NZZA0KPj4gWXY0
WGpDY3FHQS9odHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20lMkZvcGVuYm1jJTJGcWVtdSUyRmlzc3Vl
cyUyRjM2DQoNCg0KPiBUaGFua3MgZm9yIHRoZXNlIGNoYW5nZXMuDQoNCj4gSG93ZXZlciwgdGhp
cyBpbnRyb2R1Y2VzIGEgcmVncmVzc2lvbiB3aGVuIGNvbXBpbGluZyBRRU1VIHdpdGggLS1kaXNh
YmxlLWdjcnlwdC4gSXQgY2FuIGJlIHJlcHJvZHVjZWQgd2l0aCA6DQoNCiAgID4gbWFrZSBjaGVj
ay1hdm9jYWRvIEFWT0NBRE9fVEFHUz1tYWNoaW5lOmFzdDEwMzAtZXZiDQoNCj4gb3IgZG93bmxv
YWQgOg0KDQo+ICAgIGh0dHBzOi8vc2VjdXJlLXdlYi5jaXNjby5jb20vMXVtYkJnNUZodEhmQnJF
RXY4aUlteUE2OU5jdnpnTHd1dFJZS1BWaG05VWpEM3UxRVREVXJFTWZuTlU1MHpKVkQ3MFEyUVV1
ZWJ4Nkl1VFJiUmVGLXcyM2JWNWZyNnlId083MklkWEJ4WlNyUHVMRlpULXNQaUl6M3VpT0J5ekxs
V0w2bVU0SVAxZFo2bnhmVHFHWTJRVGVndjUzTThkcU5pVWkzRF9TdGZjTElDNTZfYmNnWnIyTFRX
ODZGQUpLeTdqQUNhSnNrOEF5dlllU3JDLS1ZWmVfYnB6UDdUWTJlaWdCZTRRZ19CSFVjSVdEVFIw
YVh5cnhRWmpJZ3h4MDViWFEwbHE5dFF1UVVZRjdkOUxvVHNGaUoyMnhyWF9nS1U3bVRjR2JjMUkx
VzRuSjFLRzY5VURCbHRqbmpnUENpbXFLeDB6V2hrUW5jQzNDcFN3VXJoTm9kYnVKZ01GS3luNThx
N1dBZEw3ajBQeURxOWtIdDlkcm5haV80bE5EMm1ZaElGaFFIZmVHUjZxd1RSeGgxcC1pOEVNQVJU
SGhNS3N0N1h1Mzd3dnpvRlZ0MVBySHd6aHNPRF94VHI5cTJyNkRHSzJ6UFh3cDVXejEzMHFNYzV3
L2h0dHBzJTNBJTJGJTJGZ2l0aHViLmNvbSUyRkFzcGVlZFRlY2gtQk1DJTJGemVwaHlyJTJGcmVs
ZWFzZXMlMkZkb3dubG9hZCUyRnYwMC4wMS4wNyUyRmFzdDEwMzAtZXZiLWRlbW8uemlwDQoNCj4g
dW56aXAgYW5kIHJ1biA6DQoNCj4gICAgcGF0aC90by9xZW11LXN5c3RlbS1hcm0gLU0gYXN0MTAz
MC1ldmIgLWtlcm5lbCAuL3plcGh5ci5iaW4gLW5vZ3JhcGhpYw0KDQo+IHRoZW4sIG9uIHRoZSBj
b25zb2xlIDoNCg0KPiAgICB1YXJ0On4kIGhhc2ggdGVzdA0KPiAgICBzaGEyNTZfdGVzdA0KPiAg
ICB0dlswXTpQQVNTDQo+ICAgIHR2WzFdOlBBU1MNCj4gICAgdHZbMl06UEFTUw0KPiAgICB0dlsz
XTpQQVNTDQo+ICAgIHR2WzRdOlBBU1MNCj4gICAgc2hhMzg0X3Rlc3QNCj4gICAgdHZbMF06aGFz
aF9maW5hbCBlcnJvcg0KPiAgICBzaGE1MTJfdGVzdA0KPiAgICB0dlswXTpTZWdtZW50YXRpb24g
ZmF1bHQgKGNvcmUgZHVtcGVkKQ0KDQo+ICBJIGJlbGlldmUgdGhpcyBpcyBkdWUgdG8gdGhlIGNo
YW5nZSB3aGljaCBub3cgYXNzaWducyBzLT50b3RhbF9yZXFfbGVuIHdoZW4gYWNjdW11bGF0aW9u
IG1vZGUgaXMgZGVzaXJlZC4gSWYgdGhlIGNyeXB0byBjb250ZXh0IGZhaWxzIHRvIGFsbG9jYXRl
IA0KPiAgKG5vIGdjcnlwdCksIHN0YXRlcyBhcmUgbm90IGNsZWFyZWQgaW4gdGhlIG1vZGVsIGFu
ZCBwcmV2aW91cyB2YWx1ZXMgYXJlIHVzZWQgYnkgdGhlIG1vZGVsIHdoZW4gdGhlIE9TIHJ1bnMg
dGhlIG5leHQgdGVzdCBhbmQgUUVNVSBzZWd2cyBpbiANCj4gaGFzX3BhZGRpbmcoKS4NCg0KPiBU
byBmaXgsIEkgdGhpbmsgd2UgY291bGQgbW92ZSA6DQoNCj4gICAgICAgICAgaWYgKHMtPnFjcnlw
dG9faGFzaF9jb250ZXh0ID09IE5VTEwgJiYNCj4gICAgICAgICAgICAgIHFjcnlwdG9faGFzaF9h
Y2N1bXVsYXRlX25ld19jdHgoYWxnbywgJnMtPnFjcnlwdG9faGFzaF9jb250ZXh0LCBOVUxMKSkg
ew0KPiAgICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICIlczogcWNyeXB0byBmYWlsZWQgdG8gY3JlYXRlIGhhc2gg
Y29udGV4dFxuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPiAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgICB9DQoNCj4gIGF0IHRoZSBiZWdpbm5pbmcg
b2YgZG9faGFzaF9vcGVyYXRpb24oKSA/DQoNCj4gIEMuDQoNCkdvb2QgY2F0Y2guIE1vdmluZyB0
aGUgY29udGV4dCBhbGxvY2F0aW9uIHRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9uIGRv
ZXMgYXBwZWFyIHRvIGZpeCB0aGUgaXNzdWUuDQpJIHdpbGwgc3VibWl0IGEgbmV3IHBhdGNoIHNl
cmllcyB3aXRoIHRoYXQgY2hhbmdlIGltcGxlbWVudGVkLg0KDQpUaGFua3MsDQpBbGVqYW5kcm8N
Cg0K

