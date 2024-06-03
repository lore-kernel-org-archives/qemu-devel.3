Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631FCC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jg-0006iv-2m; Mon, 03 Jun 2024 02:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-0006gJ-D2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:58 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jW-00071B-Ax
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394390; x=1748930390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ssYVGgT6YAfemmInJATGdFE5/0e9B+YWWRi3BUUYCtk=;
 b=RGqnhSpQcOk+e7fEyHk6q91/qIf208vCuENO9TOmGQfek/vV6J81Wa35
 kAFlQBgqSCXeQwg2dYLB/LH7gnKh3+LfHxnyvIE4TH04YEZSEbuGe/X0z
 h98uiMY+Tk5j/2EhoWdUUlzhWToXeI6EYyxGGbJuRSL+QPjUHLWwu0ArL
 vHUADef3ih5Pb3eIYr/o8bSUXgK9l0s4XrrRyethxlqaWn0bs0QxLM9Ma
 XMrx/4ce7Kj3hN5tSJgPeDx/aliNxbD9UvM/Hu3qJ0KqRViU8+VfKlLOf
 QQrKGYJSpAa7eNXGPIvKB2jcbsjPkCLnczRjE4Svm8FcvRX/ENBOAllQ+ g==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815873"
X-MGA-submission: =?us-ascii?q?MDHfSbrvnbd48m/Ss7v6xjYUltpWFNnXtgddWs?=
 =?us-ascii?q?ji2kQW0JiSYiVTL32+xwkV34i5rjS4FpeEE/lL2O0yl3W/y3lc+ZBSZU?=
 =?us-ascii?q?ZBHChkbuyMoLCRYe3sY1XjKhQbwOhlU/4z1U9d/p8Xs/oXV8HZRO62fM?=
 =?us-ascii?q?iXK7zw9H2g0DtIGoF1dVzr4A=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6wgPdRBzoxgEDeKxsmq40MCSIMG0psYu26U0v5iMit6ZbAdvxbVNKBkH27xzG4uD3LlQEp4deqOxI6hOuIZ7X64qFPkurzjBlxM/b0DcKXLn1eg9AGjTzaq82TjbHk84C8zqrcT7tbB/bBePVEIAfTn3VlNaurShyNjVqY5ym8eSFOlojR8sZThTN26qrkyFeVCxoeidhjEWcHGp54I2jk0vl5mPeidICTBj13HNT3MToqwlnTiCYwv27HN7KkZIGs50t7Lki2UUK1n8d1dmRBsxBZAmMIr++4q8rtXHs6+b4jFjPKbZ78VUdTLzA8onNUNKdI+GqA4Jx/LhELkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssYVGgT6YAfemmInJATGdFE5/0e9B+YWWRi3BUUYCtk=;
 b=VSFhTvIZHUnXAzqQYlEUkJUnFVToBnLZYX5nLL4xKVyYbPUKXzKzaVHx+OFbq99SAeGVOEDWzXWVEQgw5nnDDuSb/mhGCt0TaphZY0LNByNcX3pFcpee+TnCqc0Z8yKw7u0xVbtxx92IJoBJqLLcfdcuVKGuaqOx0jEAf1WATeCnxLvBrwwdDrJTskF4vZFt8wp/sNQAer9FMgMyC/ulsay8mH7ryTg8//Fl+6M29+drRg5N7W85HwutIDB8T4BkbzpofSYTPRaZR/5ihHYSWzAq56e1ZGU+aa6gdJZgx8xUROTrvLYwbJFIZBPGrAvgxsMhS7gReZEXjZx8iMJUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssYVGgT6YAfemmInJATGdFE5/0e9B+YWWRi3BUUYCtk=;
 b=OgcYkzT3TYUQgW3hlC8YkvcvVVuU2vqxvB+vUDSxLlQFBPoIPhSFfFpIm9bX+XIl7JZcL+dkjlmeq2iTj0UEWXdabU5iqwoCI9Le5Zu8zshjtKJ1+rQTcCkrAV5MBIaRG0NF+sVIBQRL7ZYsvIoF/NSKIL6xc/lUxW+btLG6aPaTBnE0hB5BNTP7dEZIj1R9inJcxCOepW/tnE9NPggurVKzlOh+RDoXFxiyHrueRNN8259sqbyPLCswS1KuJeL1Xea3Aiy40F3Cjovr6nIA998YhrBfhrSgCy8bzsugfeTMkOfKXAbSiRbnLgj2Z0piauHaU0royQx8OlGdmZfJBQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 03/22] intel_iommu: return page walk level even
 when the translation fails
Thread-Topic: [PATCH ats_vtd v5 03/22] intel_iommu: return page walk level
 even when the translation fails
Thread-Index: AQHatXs6q1IKL+LfFkqNMBSZnISegw==
Date: Mon, 3 Jun 2024 05:59:42 +0000
Message-ID: <20240603055917.18735-4-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 9c6b18b7-aef4-4151-add5-08dc83925cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?c2UwTFpzNjZaM0lOQ3Z3STRUdzQzd0RZUjJVU3BIdUlZOU1XaGNtMmtpSktF?=
 =?utf-8?B?RkFWNStwN2szeHJhZUxIdmJaYzNMTDBWVnhsalAyM0dKVlJjb0RoMVhKaUE0?=
 =?utf-8?B?YmtnajhZTDhTSmhIMkMwWkdEdk91UkxXaTBJbTgvTXNkTnJKREllRGhiN3Fx?=
 =?utf-8?B?NFIyYTZtRHJKVHNpZm5sbnBRbWJtbzV2aWdvYUU0Sk1UOVdxbGtSMXFsRkw0?=
 =?utf-8?B?SnlkZWJZZ0U1Yy9JVEVEVnpCYXB1ZDdxbjJhdU43MlRpYzJ0MmJBeGNtVm00?=
 =?utf-8?B?SjRsV01RT3poUVFKbkM4S1NpdkdWNEduc0VQcVg0QS9SUDlZUWwyRDQ3RGdU?=
 =?utf-8?B?K3R1MWJUQ3ZoYnBwVmtvUmVqOEplMFBabHVSYUF3U2dvcnU3b0YreEEzOFZO?=
 =?utf-8?B?WEo1Q2ZKbERJL2hrNkNjNFNaUjliYVpvR0FmV0F4TjhVa1dyQ2xyeVpmQmQz?=
 =?utf-8?B?NittcktDMDZTRjBCMHY0dTFOYnhNckZzbCs1MHVhL3pQK25OaDRhU2xOZTd1?=
 =?utf-8?B?VFp0MEhzUFVKUlpBVGNVVHpIdi96K040dDhJZ2dUZkltQU9kTWpUWk9rcFpu?=
 =?utf-8?B?aWNWbFYxOVNUQ2VWdVJ3YWFKbnB3NjM4MTZwQnRwVTBBMHFXdnBsdEhKM2ty?=
 =?utf-8?B?aCtyb1pySzRKcWRueG03VDFaY1M4a3dzdVkrZ21jNE1sbm5aNjZ3ZWE3UXVs?=
 =?utf-8?B?MHNyUjJ0REt3N3dMY1l2OGJrZkxXM0VkNXErNmhodXNjTUF2akJVaFJ0Ry9U?=
 =?utf-8?B?NEp3L2wrTWEya1lqMWlWSHNpVlBpZFZ1WnFRZFZyczJDOWpZSFFTaFBHMTVp?=
 =?utf-8?B?dmlsUXlldmZIbWxYR29ieEpud214YjdnZGsxV3ZyaFZkY05Ed01UNW1BckRj?=
 =?utf-8?B?bEIyYWVxRmd5bEdnU1FCdXFzcEFLSm00TE11ZG9iVllkOXJvOTlTcUFaL3I4?=
 =?utf-8?B?Sy9TaGpKcTd5cURyUlRWVU42Qnp2MmxOY215ekdtUWk0ZUtUdlVrUnRwVkdK?=
 =?utf-8?B?c3IvQ1dpVXR2b3djU0pDbXRHREU2UWxlQXhSbC82Y1RqYTM0Rk9meVZDV1Va?=
 =?utf-8?B?V1FObjlTQkRRRHBLNU14RFpCcHRIK2FpSGNRam5oa3R6b3pRaDVnTkpLM0M2?=
 =?utf-8?B?OVNNeDgrbmI0bWk1VUJWN2ZrbkRhUFFmbmNZeDROQ1hJMEpSb1YwbUptZGk0?=
 =?utf-8?B?cHpjL3luTjhpV2svbmJiSnNiY2EzR3dHS1diSDFjTCs4SzlCbHpuK2NmZzRs?=
 =?utf-8?B?MVAxUzdXSnh1eFlHaURSaDNTcENlRU5BNkZiNmkzdzNFT1VFdWk2UXFnTzIz?=
 =?utf-8?B?NlpnMEFwdHVVQ2JGWTlSRVozMzgxenBKMUpkYXY4TmpGOVltVGhkYTJkdjhw?=
 =?utf-8?B?M0d6eUtYaEg1aTQ0cm5KZWFiNSs5YkZJRnNiMVN4WXgwVGtPZk11UzNSZUNl?=
 =?utf-8?B?R0UvR0dqNE9Pbnd6bnRBemZnNE8ydmdZcHlrZXlFbHZSMWNBRTU3NWQvWXVC?=
 =?utf-8?B?ait6K1ZmVlNNeC8vV0xoVHY5NVhJZjhaUmlGWWtocUpGeVNrZVB5TGYxakVO?=
 =?utf-8?B?WUZEekpXLzBRWmQyWGFWM2R2VFBWdGQ3TmhHTDdLajFlUkFhajBRaXVmNTNC?=
 =?utf-8?B?WjZKK0VZK3JMcXE2bjVqaHpNSmMwOEZNQzN0WUdORkpSdVFWOUkzZ2lXS1BL?=
 =?utf-8?B?ZkNlNFR3enFxMDBacWFPU243MEVDcjVyclBKOHRTb3lrRnJ3S2RXdXpSK3Qr?=
 =?utf-8?B?VVVvTkJqZmVYOVRjNzNBTFovRkNiNHFZRnF6ek1TRFBuR1VqcWtjWUE0c01r?=
 =?utf-8?B?a3FtSDhDdm9pUGt3S21Edz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djFIeGVnbHUyZUdHMWlUTHR6QWx4YnpJUnZMK0o5dWVjS1psZ3h4bUVLMUc5?=
 =?utf-8?B?NWFzeGVWdHFKcnM2cko3NlNJeTJCb2FNT041K3UvcGRzMjZqelJlQkVNTzFw?=
 =?utf-8?B?aXN5anpRREtqY3B1YmJLa1VaSEphcFJGRXlJOHRSVGE0MkNSTU1zWEowMXV4?=
 =?utf-8?B?cTBSZ1JQRUJkQVdJOHEyN293ZHpmdFdSQkJsUUowSzVWaDgxWE1HYVZPdkJP?=
 =?utf-8?B?U1E3cmdTWkZ4Z3B0bFNNSXJ3M2R6V1pCT3VUMGFJNW1NV3l4VGtPZHRxK2dB?=
 =?utf-8?B?d0xWUXdaS2lKN2hGZUFSWWpLd0t0YnRubDVPZ21McDNuRlNWWWRpaGkzQWhH?=
 =?utf-8?B?SjdKMWRJMUx3YlpGeU14eFhzZXZUSnhqbVpzMTBGcmZDRTdkeGJKTTNKL2Uz?=
 =?utf-8?B?b2pDSTdQSHVmRk9aczR1RndEeUZNN3kxRnYxTEcyTzUxTml0Vm5pV3k2OXZl?=
 =?utf-8?B?Z2FKcmRMaHI5aXpvUWxrRk95R3prc1llcXJFT3ZDZm1lT3N2S3poMFBlNEwx?=
 =?utf-8?B?M25YRlRPb2Q2LzByall5SXlkTVY0MEl3L3lHazJpVy9oZkt2UmtNc08zYXVS?=
 =?utf-8?B?dDE2bUdXV0QxclkxbVZrZUM3ZTBJR3EvUUxqRzB6ZDFtTGZsZktsUUg3ek9n?=
 =?utf-8?B?QnFVQlFjbVVCKzQyWUdJNmV1eEhMd0dVY1RJbExkWE9iU1hWRzVzOFR1aFNz?=
 =?utf-8?B?WlY3eUV0VVpra214L0VxenQ2bEtQVW9XaENLTUNpWHhtZkFwRmVta0V5ZHVj?=
 =?utf-8?B?OVJqcHNPZ2Z3NjRpT2JxVU5hUmNSYU5ES2FsNDB2dEtNSWlPR2RpanNqRGh3?=
 =?utf-8?B?Z0VScmdwbWlwUFZBeTZYUGR6MjY4U0FyMHNsNjVJNWdNT3lkUmlndS9XV3Bi?=
 =?utf-8?B?T2JhMHRoenlDYWNsOWpXMlg0N1ljR3lpcTZ2YVd1VWxDL1lOaXJNQlFNRzJY?=
 =?utf-8?B?N2s4N3k5cVU3ems4d3NMUjh2cEwwblVudGdycE14UnNaejJQTXhWU284L3Ew?=
 =?utf-8?B?QWtNa29hTGNIa3BmZXZ0dTdWUnFoNk5FU0sybTlGZVlkVGlnZU41WG9ObmxH?=
 =?utf-8?B?ODNMSEJzRW9RNTF6eE5pOGgzUmRpS1N1TzVFTlhCYkFMS2RacnVOT05hR1RH?=
 =?utf-8?B?SWZGY3l0NitVQUZZNTFiMUdvRGp5Ly8vQis3VUY2K3VCNXV2WWFINThxcGRi?=
 =?utf-8?B?bjkwNFhKT1NjSVhXbzhwSkdBbkVJMFZjRlBIVlQ0VnFvd1ZWd1dBMCtGbzZG?=
 =?utf-8?B?emtjaEtxNXVFRTBhQk5hdUhueHhtLzN1UlM1bVlqbVQ5eXdpVFBib0NPejg4?=
 =?utf-8?B?aENIbzFKZ2RTVjR3WnRKYStpSHJDUnZaNW9HUHJGczRvMytYZHhWNjlMVjFt?=
 =?utf-8?B?QmYrZEk2dG9Cbm5jSkxSUWcrN3dOTXZOeW1BbDhwTHljZEpUWTA4UzRRUG41?=
 =?utf-8?B?NTE0cGdDc1pEMEdlYVhsa0JIT3FRdFJ1SDA2YVgrcWtwWXhRSkxEWkpWMEJj?=
 =?utf-8?B?UVc0TjZDQWVOZU0xOUZPc0VIWGdVVlZ0eWJEZXVaQVBHaFdFcHUzamZsemw0?=
 =?utf-8?B?Y1h5S2tQTDJ2cGpYQ0NlVW1wdFNlLzJNQ2VWd3JjZUJIU09kM0lxZUx1bUto?=
 =?utf-8?B?QXVYa3RnN1lsQURIZ0RVd2tnK3ViMXVsWUcwUHlNR3B1bERiZUk1NDNMYmJh?=
 =?utf-8?B?RnVyN29BaUI2U2FYVGlQTnRiSmVuVStzV0srTlJPUzRXcFB6bnRuMVJpd2xJ?=
 =?utf-8?B?L1htY3BtWHU0TVpPUDg2TzF0TlVRU2ZySEJEamw1NnFWYjUyc0ZkT3U0cVM2?=
 =?utf-8?B?aU9ic1lIM3B2eitHZDJTUHdjQmNDQVRRMEZmTjkrZE1HcHZBUVhRaUgzdEE0?=
 =?utf-8?B?YzkxZC9HWUpuMGkzVVZSVEZnQituMy9sc2lXTDI4N1h4Rno1cVFPSGY4RWJ6?=
 =?utf-8?B?bHlVN0gveFBBSWUrSFAvdU5BWmdxaVl1V21IZjZ0d0JEN29tUTIxUGdDNlhu?=
 =?utf-8?B?Q0RmWkxHNUtaN29GUzl0MVV6QXZ0MkdGL3VIckJvbTFjbU16bHJJWDRRcllR?=
 =?utf-8?B?dFYwdzYzTmNjeHZkMDlJekFDemlOeW1tZDAyNDd1ZlV2aklLTGJKRytHVkwz?=
 =?utf-8?B?eks1RWFVSnBmR09iZ1ljY0ZObDZTRVhneDZPOW5Kem1ra1dCVno5dnNLenp5?=
 =?utf-8?Q?XUZPwndcJDLT9S8VPBMf8ac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4924BB57B0700C42A4271F75288EE2AB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6b18b7-aef4-4151-add5-08dc83925cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:42.2675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsG1U/Jt6YJ2Du8zFivDMbk7SyFPJG4VylDmW03X5mCWi88xNPJ29XedPSanEaL042rTSN2ZURJN5Ra7Kb8g/L9EUMx5Ik4Tizx2i+CttXlKHQbTMQTY/Xnf85KVXX4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCldlIHVzZSB0aGlzIGluZm9ybWF0aW9uIGluIHZ0ZF9kb19pb21tdV90cmFuc2xh
dGUgdG8gcG9wdWxhdGUgdGhlDQpJT01NVVRMQkVudHJ5IGFuZCBpbmRpY2F0ZSB0aGUgY29ycmVj
dCBwYWdlIG1hc2suIFRoaXMgcHJldmVudHMgQVRTDQpkZXZpY2VzIGZyb20gc2VuZGluZyBtYW55
IHVzZWxlc3MgdHJhbnNsYXRpb24gcmVxdWVzdHMgd2hlbiBhIG1lZ2FwYWdlDQpvciBnaWdhcGFn
ZSBpb3ZhIGlzIG5vdCBtYXBwZWQgdG8gYSBwaHlzaWNhbCBhZGRyZXNzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDExICsrKysrLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXgg
OTA4NDg2Yzk1My4uNzcyYjFjZWE4OCAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMjA3OCw5ICsyMDc4LDkgQEAgc3Rh
dGljIGludCB2dGRfaW92YV90b19mbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRF
bnRyeSAqY2UsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCkN
CiB7DQogICAgIGRtYV9hZGRyX3QgYWRkciA9IHZ0ZF9nZXRfaW92YV9wZ3RibF9iYXNlKHMsIGNl
LCBwYXNpZCk7DQotICAgIHVpbnQzMl90IGxldmVsID0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNl
LCBwYXNpZCk7DQogICAgIHVpbnQzMl90IG9mZnNldDsNCiAgICAgdWludDY0X3QgZmxwdGU7DQor
ICAgICpmbHB0ZV9sZXZlbCA9IHZ0ZF9nZXRfaW92YV9sZXZlbChzLCBjZSwgcGFzaWQpOw0KIA0K
ICAgICBpZiAoIXZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbChzLCBpb3ZhLCBjZSwgcGFzaWQp
KSB7DQogICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGRldGVjdGVkIG5vbiBjYW5vbmlj
YWwgSU9WQSAoaW92YT0weCUiIFBSSXg2NCAiLCINCkBAIC0yMDg5LDEwICsyMDg5LDEwIEBAIHN0
YXRpYyBpbnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0
RW50cnkgKmNlLA0KICAgICB9DQogDQogICAgIHdoaWxlICh0cnVlKSB7DQotICAgICAgICBvZmZz
ZXQgPSB2dGRfaW92YV9mbF9sZXZlbF9vZmZzZXQoaW92YSwgbGV2ZWwpOw0KKyAgICAgICAgb2Zm
c2V0ID0gdnRkX2lvdmFfZmxfbGV2ZWxfb2Zmc2V0KGlvdmEsICpmbHB0ZV9sZXZlbCk7DQogICAg
ICAgICBmbHB0ZSA9IHZ0ZF9nZXRfZmxwdGUoYWRkciwgb2Zmc2V0KTsNCiAgICAgICAgIGlmIChm
bHB0ZSA9PSAodWludDY0X3QpLTEpIHsNCi0gICAgICAgICAgICBpZiAobGV2ZWwgPT0gdnRkX2dl
dF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCkpIHsNCisgICAgICAgICAgICBpZiAoKmZscHRlX2xl
dmVsID09IHZ0ZF9nZXRfaW92YV9sZXZlbChzLCBjZSwgcGFzaWQpKSB7DQogICAgICAgICAgICAg
ICAgIC8qIEludmFsaWQgcHJvZ3JhbW1pbmcgb2YgY29udGV4dC1lbnRyeSAqLw0KICAgICAgICAg
ICAgICAgICByZXR1cm4gLVZURF9GUl9DT05URVhUX0VOVFJZX0lOVjsNCiAgICAgICAgICAgICB9
IGVsc2Ugew0KQEAgLTIxMTcsMTkgKzIxMTcsMTggQEAgc3RhdGljIGludCB2dGRfaW92YV90b19m
bHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQogICAgICAgICAg
ICAgcmV0dXJuIC1WVERfRlJfRlNfQklUX1VQREFURV9GQUlMRUQ7DQogICAgICAgICB9DQogDQot
ICAgICAgICBpZiAodnRkX2lzX2xhc3RfZmxwdGUoZmxwdGUsIGxldmVsKSkgew0KKyAgICAgICAg
aWYgKHZ0ZF9pc19sYXN0X2ZscHRlKGZscHRlLCAqZmxwdGVfbGV2ZWwpKSB7DQogICAgICAgICAg
ICAgaWYgKGlzX3dyaXRlICYmDQogICAgICAgICAgICAgICAgICh2dGRfc2V0X2ZsYWdfaW5fcHRl
KGFkZHIsIG9mZnNldCwgZmxwdGUsIFZURF9GTF9QVEVfRCkgIT0NCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FTVRY
X09LKSkgew0KICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfRlNfQklUX1VQREFU
RV9GQUlMRUQ7DQogICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICpmbHB0ZXAgPSBmbHB0ZTsN
Ci0gICAgICAgICAgICAqZmxwdGVfbGV2ZWwgPSBsZXZlbDsNCiAgICAgICAgICAgICByZXR1cm4g
MDsNCiAgICAgICAgIH0NCiANCiAgICAgICAgIGFkZHIgPSB2dGRfZ2V0X2ZscHRlX2FkZHIoZmxw
dGUsIGF3X2JpdHMpOw0KLSAgICAgICAgbGV2ZWwtLTsNCisgICAgICAgICgqZmxwdGVfbGV2ZWwp
LS07DQogICAgIH0NCiB9DQogDQotLSANCjIuNDUuMQ0K

