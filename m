Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496E5C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitS2-0003JR-Bv; Mon, 04 Aug 2025 07:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1uitRb-0002po-F0; Mon, 04 Aug 2025 07:33:40 -0400
Received: from outbound-ip191a.ess.barracuda.com ([209.222.82.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1uitRW-00086Z-5y; Mon, 04 Aug 2025 07:33:28 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2104.outbound.protection.outlook.com [40.107.101.104]) by
 mx-outbound41-210.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 04 Aug 2025 11:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcHReiS6pulYy8zaBin2zJnb2q8DnHUAKtfXfCSWR7GJeoGzF0/USLMDPSf92V4iF4FmRrLj/Bx2biQpIgG3zDasDOCzlP5JZ0SqI78S3gXCRy12/rluoAXqjtR0OyJofYbud7wtK5vnLw6le5H9BGD/TACWuGfvHZHeys+HPeyLHcF++tN/PXQBofxiPXkBB4d1x/u8SLfMxBiU5jwqnxbl1c83WJt/TGrTyMu5Ycr1vJMoo1Imd8iR5VBtN/g90x4RdxpJXU3m46tZFrpOK321tznsVwV7LQ99vaMgQ/bVeAA9BQpRiyA3E7iXZUQd0LYGJnn3bpMMeyCESV6fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voR2EnMCx5dDCfc9ip2nlYS8rs/ERymO/zWhmt6wmsU=;
 b=nm+jHpOb9ZXEm7lGBdkdL5ixks71CWX4DfEHnu+Uxu8bWIK9EghN4kDbN3YBwWe21KnHyF/tXnlFdPPe1J9V59Bu0lJQL9Bf/hCFHeJY3+uDNYRJtwknsDWrDvFMlH0t0Yl23OUY93pM6xMoolbpSJ76IXGlOz3cFBYVFibigoPhPIN7UE38Oam4UVpY7mYav3t7Z3WIhiugUp3mJ4gN+xZjMAXKY0oqDtdC9u7+WtIOcBfMmm1FEVv9W1cYIYvLwoMest2trNclwFfr3RG1unTH/2HnPuQLylZDqnLokaOJxF3OjxpSbNKBs/KZ0PohO6jYJY9waEvGYVzrUHlsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voR2EnMCx5dDCfc9ip2nlYS8rs/ERymO/zWhmt6wmsU=;
 b=pFvP0qjnx1U6lus/SmuGHpj3urDHECI9EWpvGPcdL6npXpoSM054AJoasTJr4OiRzCystj8r50UPqnldQQ2UnJLTusEwmCAM0/NqUJgpQRNsmh5aF/rzwTLsxE73UyV+mKZH+Mqf46V102OIeNhUE4dejHa8YKcdB1OmC4flE80=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BL4PR19MB8901.namprd19.prod.outlook.com (2603:10b6:208:5aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.12; Mon, 4 Aug
 2025 11:33:13 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.9009.003; Mon, 4 Aug 2025
 11:33:13 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Brian Song <hibriansong@gmail.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
CC: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
Thread-Topic: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
Thread-Index: AQHcAv6033ZujoIkg0aZu5zlVFY7rbRRmBoAgADJCIA=
Date: Mon, 4 Aug 2025 11:33:13 +0000
Message-ID: <577bf373-92cb-4160-a49e-e29d3615a308@ddn.com>
References: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
 <dc326a4b-f6fa-435a-b614-208e03f61556@gmail.com>
In-Reply-To: <dc326a4b-f6fa-435a-b614-208e03f61556@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|BL4PR19MB8901:EE_
x-ms-office365-filtering-correlation-id: 813afcd7-6b2c-4a70-de3e-08ddd34ab2a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eVRSeWVvR000YlUyZ1BUTzBtVTRMazgxc0JJTmppcUtSWko0aTRuYzlEOXU2?=
 =?utf-8?B?anFqY1NFT2V2UlJhb0k0aE14SzZrVXhZY1huUDNPdlV4RXpaSWRLU0RPRVF6?=
 =?utf-8?B?QXZRTzN6ZGdlTVRUTU5nV3Q5UDhYYzlicHIvbzMyV0t1RDQycmM5NndVeW9H?=
 =?utf-8?B?S2MzT0hyeVJmemtESjBhVHpOTVIrazc5NXRDODRrSjNXK3VYZm4yTjA4cEpL?=
 =?utf-8?B?cUJpVEErZktuVWc1WDAza0dUK3JJQ3NrTHJlTlRyUUJyNWNMM3lGbms2VXJG?=
 =?utf-8?B?Q21EMUliOXB5NHUyS2E1OVExaGwwSmE4ZWp5N2tHV3RhUjYwRmd2d09WWlhN?=
 =?utf-8?B?dGpJd2dTYkpncnkzakR6ODRJdVdlVFAvRkx5NVhhSXVKemxtSUdSK3FVdWVJ?=
 =?utf-8?B?TFNCQVJRTW1kc3JYdXJ6Z1BFbCtHNHhkNmtkY3gwQ0NFOUZ2R2J6b2hmbkxq?=
 =?utf-8?B?UXJneEZTMjlOU1hKRUZ0QUYyNTFFd0FnWlNZaGNRNkl0K0tCY1ZSNXdtK2Z5?=
 =?utf-8?B?cUZCTzNUWFBDMjJhcGNuczlnZE9jOUZwQnZwY2pnNi8zOHhsOS9OMkErZ2V1?=
 =?utf-8?B?WmROdTA1OVdNQVQwSWV2eG1KWm13QnFmZE52K2N6NUpVamtIZXZRS2tVZ25P?=
 =?utf-8?B?aVV3ZmFWSkNqT1g5Nzk3Zm9MQ0Q5TlA2MDlaUFdMRmhKWm5nQW1tWFJab3o0?=
 =?utf-8?B?N1BZSHdrM3Frbkl0WGZFL0t3bXFuY1N1U1U4cGYyZk1iY1U0QitSSm9EcUts?=
 =?utf-8?B?dHpvTmlxRjJHcDNmZkR2VDVkZXR4Uno1VS9jNkYrK1lsZ3JRWHRJT0JJVlJ5?=
 =?utf-8?B?Z0xyNFpUS2s1am1paGJkQSswclZYR1J4U3FMOHZzQWdDRUkvQjdZakp3a29O?=
 =?utf-8?B?T05QaUt4eFIreDBJYjR2aWRSV0tneTVCWXJUZUVlZHpFSE0za0ZYMFVyRHAy?=
 =?utf-8?B?citXYjRYeWVXT3NQeUNYeUswYU9yL2E3NzkzRnhIVEtFRGZDQy8xbHYyeWxX?=
 =?utf-8?B?N0NkeGhhUit2L2lNckdhbGFYWWVDT0JiN3RXRlEvSGp3T0dpK1dlaEJlWS9m?=
 =?utf-8?B?YjBvdGtIVG0xQjdRSkl4U3JIcVNVWGdKanpncGp0WlY0dGRWZWpiU1pFQlR6?=
 =?utf-8?B?c1o1Ly83VnJWRExlZkFLVzVzbHIrZ1ZoQWVkTGh4cElSRFAwSXloRmhIMjZD?=
 =?utf-8?B?NlZ3bkZ0cjMxV01rKzNmaGlHcHRucE5VTEhqM001Y2VsdGc1ak8vaExnQmxq?=
 =?utf-8?B?blRJdFp1aEZKSTJic0tpMCthSXBVVk5HTUhuV05kWjVrTXYwZEpROWlZRlNO?=
 =?utf-8?B?ZjBNMVVieUpFckt2aTBkaHM2T25YMmRTUlM5Tm41UDF3QlRWcDNTYVFmSWZM?=
 =?utf-8?B?ZWVLY1h3ZGpRVWJNWVVaR1ozeEdxYytlWFBuWmRhcitwNW8zVmhhZzBneXZV?=
 =?utf-8?B?K2ZoaUlCRjE3dVFCSFZvQ3k4d3g1eVpBVW01Q1VQYy9UR3BiRFM3U2ZPZFhU?=
 =?utf-8?B?SzlFaWZFcU9MTGtvRFhGNHcwbWJGeVo5MkhzRkJJSU9HK3hJRXN2N09xWVBu?=
 =?utf-8?B?bjdxNGRDdE9rUFJOUGw0RTVWZnp2STNXY3YyYi91cUZMYnRkaFpIM0wxVndD?=
 =?utf-8?B?MnBWcWZoVDJqUFJQUmFnMVVmYTdtcVpIbncwUUozMEtYMWRRTDRZZzVIQStz?=
 =?utf-8?B?UGhBTnh3MG1GcTBNUkdBcnozdUZ6cUJUbDl4UktoblhWVnl0ZFRUSHlHVnNy?=
 =?utf-8?B?ZmRuak9VOVFWTE5UOVlzRjBtVVkvaTZiMkdSR2VpWk5sOHZMMVh3TGJrd3dJ?=
 =?utf-8?B?NTd5U2V6RFN3UTRYdk55RmFkU1A4dDNVRkFmd0kzK3FKNEJTckpmVnRiWm9r?=
 =?utf-8?B?bGZEcUorRUpjYUFBSjJCaldEdlhNcmpRb0l3SVJiK0RUOHY2YXl2YlhZMlVI?=
 =?utf-8?B?a2hKVXlLUkMyVzZSM2p2K25sYU1tZURQTEVVMVlMRVEzQnZTOUxucitSZWNa?=
 =?utf-8?B?K0RrS1ZGU1lRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR19MB3864.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjRGdXJ5MWd5RjlhYk8rMCt5V3dhRzNPWTVaenBOZ0VWd09peUtiRDQrdTND?=
 =?utf-8?B?Vkh2TlhzVHo1TUJxQ1JUWm9scko0SkdOQnhHS2VKaUtOT013eFpjeTVjNktH?=
 =?utf-8?B?RVRjQXFOTzBnSHJnRnp2VzVqKzFpYldmdHJkZkxNTWZWOG1XNFE1UExzKzg1?=
 =?utf-8?B?ZVVwSWhNdnNIZ1N6T0EwZFR5T1lJbVVJQlRiTDV4UHdQdEg2UFMzQXNOUE5u?=
 =?utf-8?B?UTlPLzRSaTAyZzA0YlYvR3ZlaVF6L3N6V3p5N0orZXN0V2FIb0p6WTlveWlR?=
 =?utf-8?B?dDBWa3FEV254WFdnMFlidHl5K0taMnRHaHFHcG5uVzBBWDZEWDQyK21Tem1S?=
 =?utf-8?B?K1JPSlhWdS83b1ZvUVkxNm1oeVJQK2RONXFoWXh0b2psK0RnanltSDhlZzQz?=
 =?utf-8?B?TFZCbUwwNHYyYTFLNjdFK3lSWTJhcitoWS9saWgyVmhONzNUVTdIUnBRREtE?=
 =?utf-8?B?cEU4YkZ1Qk1IUUtiWTdNTlRkZlNzWHorZmlMakJINElZMUNnTVh2V24yajli?=
 =?utf-8?B?Nk5rWGhXcE11aTdkblRuWUwrbnltMUI2UnYxMjhWZUxpaXdUbEk5Qjh4ekRD?=
 =?utf-8?B?cnhqOTdTZzRCUlpRWi8rV0RsREQvMmRIYTRDUmxYeENpaVcwK29ITW1YdXNP?=
 =?utf-8?B?aFRvWHNTNkpqS21SVmF6OGJuM2xIQnNHUStlZ2lVUlBMRExuQWVRTFoxb2Jo?=
 =?utf-8?B?Z0FXdlJYblZBbVZYSXVmWk5WbDZEbTlzTEJJZ1d3cXh4dlNKU0VjdE5WSEtl?=
 =?utf-8?B?S3JUOHk3dmp4czNDeisvY05nc3BseVVSU2ExZmYvMGFadm5WL3AzQmhoUjFO?=
 =?utf-8?B?K2lQNkcyTytiWVNWMWlVM01hbTdpcHZ3RUtianExc0g2bWw2bTM2S3N6Y0cv?=
 =?utf-8?B?cEErSUdrOXZwOWFOZXVYbU1EL0ZPVmFWL1Vla3hxSWNWN3UrcHUvazVyd2c2?=
 =?utf-8?B?R2lFcktReExCcTU2MG5xQmtGS2krZElvZW1DVXZYcUlsTDRrdytKcXh0WDFn?=
 =?utf-8?B?cU80eSt1cUZXL0RyRERHNUZxbnNUWGNnK1lvUENSdUhVUnJOajg1ZVNicW1Q?=
 =?utf-8?B?ZzZWSzNIanlsV2JCVHkwVk5CQ1VsMERWcEV2Myt4YUZwUnpUdWNSTG9HRkV6?=
 =?utf-8?B?SEJxSmRrMWZLcDl0c0VLWGk2QmpEZ1V1ZlVmTGJwZ0t4OEhVano2U1crYUtM?=
 =?utf-8?B?ZUJxSmVRRUQ5S01QdStIbGRUZnZjdTBsaXBmemNXTitzTEdIYTRIb2czSFVC?=
 =?utf-8?B?bVdSMjkxRjR3STBnc1c1akQwU1FLakJjQ1BzTkwzcUFTTkhTYy9wWkM0eE5m?=
 =?utf-8?B?M3FROFRjWE4zeTEzWStvWUhySHVmb0ptUHlFYkI5WElhVksrY05KSkZDSjdp?=
 =?utf-8?B?WnBRMmtRTE9vSU5NbFNOV011YmwzOHR4QWR2TkdHNlVzbEE5SzBwRVgzWnJ6?=
 =?utf-8?B?YVhCNXdkNzM3R0JqdytPMURZdkF6K2F1NEV5SEo1eDg0NE4rbjdLaEtzYkxT?=
 =?utf-8?B?Y0J6YlBydjNSZzd3TkJwMGx5ZDZobjBybmZERzJXUmU0K2k0TklKbXpxQXp4?=
 =?utf-8?B?dHlLRlRyNFNNMHVVZVJFNFVoK3lvTWJacE1yeGE0TEpQalk2aFJUNWJab1lm?=
 =?utf-8?B?eVlBd1k3T2lpbHpsOU9CWlRFNGxrK0Vnb3dYZk54S1hHbnk3TEVJdWRtUjlE?=
 =?utf-8?B?ZzAvWFNxcFJKUXBabjVGdEo5OGphd1RiaHlQU0VYNnRGbDM3QW03TTNYb3lY?=
 =?utf-8?B?QjVTK1BzazRiaVlzQWdBSThkRlNMYXo2dGFkRTBSWTNHalFMc3RiejBwMVFN?=
 =?utf-8?B?L0YzSGhJalJTWFdUREx3bkMxSnpmRVVNYUV0UDNoWVphaFFST3doQnhYSS9U?=
 =?utf-8?B?cWVPZEphSHlrYmM1RDlBYVpEdFExMmFLUTJxUkw3dW1yZDhNeTd2QzRBQ2py?=
 =?utf-8?B?T3BjQ3V5ZFZrVmkzN2E4TGl2b0FUTm1ESW5yTkxieUE1cHREamFEWWN1VXlU?=
 =?utf-8?B?NUZqcUpJQlhsUDlHV1Mwd2lWQ1VsRkxCZ25hSy9ScjM5T3k0c1c1R3Rvdzhz?=
 =?utf-8?B?ekg1YjUwY1hTV3pxdjRMalJ4SmtZeDN6YzhRSzhGek1MVFFyZk16UVU5bkxU?=
 =?utf-8?Q?GUm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2553408E1E204345B97931546D3FBA54@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z7720pYDGUEEGF4wa7+KRL509al8/o9QfhZ57P44OA6yKkl++Uixhvh48mWwWPq9Y7lnKLQDdZotpRMy1GeitlCZSAmH2KtCK7ghPmrDrCr5FuQksh+sHgKRTFj3q1EEZHlMEWSddMQP/fgxH6Oezlvjns6syKvbmkbYsG3vKn7/qUGCVit23hnwQeVRWU3HFKeMxIQOrevcLvf62JsmgfSK+E/rRXoZ+PAM9OfsZHtjm9MhYPWSE6jLks1e3cY3go0M/Djqv8/woghDE226bj1FYcurV5sbOvGf3NFzUO1WzS8xzEiCfNEf/RI0/Ebui24EQDK8p+AADk3rynN45MM52jFmkbOwJ5CwWJcBIcjKne8uTJyVOlLLWTy3UGEgsjOcJAxsPZdMVyk7Swq0kfhD5t6czEeCLfySsGy+zWgEdc9bzXZBNhVBgdVJkrc93VYYAvaZqmFCOu0VrhXfWkV+q0GoP76GlRfjpdMJV76MicCJsBCt6EXZYCkGWCDDYOAB9kf+tq2RJmzSsY7/jtPK/ngJ94mF9x5Ehc0rtdYbtiysse2TEIpymg8EIChzGfxzBGhTuPpGlUzKumeG6+5GQHfB9ApZL3I4LMIHeH8otVvCvuTUh5AWu4kwoSfjqV5dQkRNWmTPVob3PbsgTg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813afcd7-6b2c-4a70-de3e-08ddd34ab2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 11:33:13.4453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sP2RA2AJgQFSST3Cti4p2Ese+Cay4/NLxgqL+XGNzS1QjnnpK0w5HjDKQ1/wkDRjIrfMP4wgG9qFqbFfWdOuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR19MB8901
X-BESS-ID: 1754307197-110706-7617-999-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.101.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaWBsZAVgZQMMnAONXC3DjZPN
 UszcTY1DItOSktzdLS0NgyNTnNOMVYqTYWANHWQYRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.266535 [from 
 cloudscan18-247.us-east-2b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Received-SPF: pass client-ip=209.222.82.58; envelope-from=bschubert@ddn.com;
 helo=outbound-ip191a.ess.barracuda.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgQnJpYW4sDQoNCnNvcnJ5IGZvciBteSBsYXRlIHJlcGx5LCBqdXN0IGJhY2sgZnJvbSB2YWNh
dGlvbiBhbmQgZmlnaHRpbmcgdGhyb3VnaA0KbXkgbWFpbHMuDQoNCk9uIDgvNC8yNSAwMTozMywg
QnJpYW4gU29uZyB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDI1LTA4LTAxIDEyOjA5IHAubS4sIEJy
aWFuIFNvbmcgd3JvdGU6DQo+PiBIaSBCZXJuZCwNCj4+DQo+PiBXZSBhcmUgY3VycmVudGx5IHdv
cmtpbmcgb24gaW1wbGVtZW50aW5nIHRlcm1pbmF0aW9uIHN1cHBvcnQgZm9yIGZ1c2UtIA0KPj4g
b3Zlci1pb191cmluZyBpbiBRRU1VLCBhbmQgcmlnaHQgbm93IHdlIGFyZSBmb2N1c2luZyBvbiBo
b3cgdG8gY2xlYW4gdXAgDQo+PiBpbi1mbGlnaHQgU1FFcyBwcm9wZXJseS4gT3VyIG1haW4gcXVl
c3Rpb24gaXMgYWJvdXQgaG93IHdlbGwgdGhlIGtlcm5lbCANCj4+IHN1cHBvcnRzIHJvYnVzdCBj
YW5jZWxsYXRpb24gZm9yIHRoZXNlIGZ1c2Utb3Zlci1pb191cmluZyBTUUVzLiBEb2VzIGl0IA0K
Pj4gYWN0dWFsbHkgaW1wbGVtZW50IGNhbmNlbGxhdGlvbiBiZXlvbmQgZGVzdHJveWluZyB0aGUg
aW9fdXJpbmcgcXVldWU/DQo+Pg0KPj4gSW4gUUVNVSBGVVNFIGV4cG9ydCwgd2UgbmVlZCBhIHdh
eSB0byBxdWlja2x5IGFuZCBjbGVhbmx5IGRldGFjaCBmcm9tIA0KPj4gdGhlIGV2ZW50IGxvb3Ag
YW5kIGNhbmNlbCBhbnkgcGVuZGluZyBTUUVzIHdoZW4gYW4gZXhwb3J0IGlzIG5vIGxvbmdlciAN
Cj4+IGluIHVzZS4gSWRlYWxseSwgd2Ugd2FudCB0byBhdm9pZCB0aGUgbW9yZSBkcmFzdGljIG1l
YXN1cmUgb2YgaGF2aW5nIHRvIA0KPj4gY2xvc2UgdGhlIGVudGlyZSAvZGV2L2Z1c2UgZmQganVz
dCB0byBncmFjZWZ1bGx5IHRlcm1pbmF0ZSBvdXRzdGFuZGluZyANCj4+IG9wZXJhdGlvbnMuDQo+
Pg0KPj4gV2UgYXJlIG5vdCBzdXJlIGlmIHRoZXJlJ3MgYW4gZXhpc3RpbmcgY29kZSBwYXRoIHRo
YXQgc3VwcG9ydHMgYXN5bmMgDQo+PiBjYW5jZWwgZm9yIHRoZXNlIGluLWZsaWdodCBTUUVzIGlu
IHRoZSBmdXNlLW92ZXItaW9fdXJpbmcgc2V0dXAsIG9yIGlmIA0KPj4gYWRkaXRpb25hbCBjYWxs
YmFja3MgbWlnaHQgYmUgbmVlZGVkIHRvIGZ1bGx5IGludGVncmF0ZSB3aXRoIHRoZSANCj4+IGtl
cm5lbCdzIGFzeW5jIGNhbmNlbCBtZWNoYW5pc20uIFdlIGFsc28gcmVhbGl6ZWQgbGliZnVzZSBt
YW5hZ2VzIA0KPj4gc2h1dGRvd25zIGRpZmZlcmVudGx5LCB0eXBpY2FsbHkgYnkgc2lnbmFsaW5n
IGEgdGhyZWFkIHZpYSBldmVudGZkIA0KPj4gcmF0aGVyIHRoYW4gcmVseWluZyBvbiBhc3luYyBj
YW5jZWwuDQo+Pg0KPj4gV291bGQgbG92ZSB0byBoZWFyIHlvdXIgdGhvdWdodHMgb3Igc3VnZ2Vz
dGlvbnMgb24gdGhpcyENCj4+DQo+PiBUaGFua3MsDQo+PiBCcmlhbg0KPiANCj4gSSBsb29rZWQg
aW50byB0aGUga2VybmVsIGNvZGViYXNlIGFuZCBjYW1lIHVwIHdpdGggc29tZSBpbml0aWFsIGlk
ZWFzLCANCj4gd2hpY2ggbWlnaHQgbm90IGJlIGVudGlyZWx5IGFjY3VyYXRlOg0KPiANCj4gVGhl
IElPUklOR19PUF9BU1lOQ19DQU5DRUwgb3BlcmF0aW9uIGNhbiBvbmx5IGNhbmNlbCBpb191cmlu
ZyByaW5nIA0KPiByZXNvdXJjZXMgYW5kIGEgbGltaXRlZCBzZXQgb2YgcmVxdWVzdCB0eXBlcy4g
SXQgZG9lcyBub3QgY2xlYW4gdXAgDQo+IHJlc291cmNlcyByZWxhdGVkIHRvIGZ1c2Utb3Zlci1p
b191cmluZywgc3VjaCBhcyBpbi11c2UgZW50cmllcy4NCj4gSU9SSU5HX09QX0FTWU5DX0NBTkNF
TA0KPiAtPiBzdWJtaXQvZW50ZXINCj4gLT4gaW9fdXJpbmcvb3BkZWYuYzo6IC5pc3N1ZSA9IGlv
X2FzeW5jX2NhbmNlbCwNCj4gCS0+IF9faW9fYXN5bmNfY2FuY2VsDQo+IAkJLT4gaW9fdHJ5X2Nh
bmNlbCA9PT4gQ2FuIG9ubHkgY2FuY2VsIGZldyB0eXBlcyBvZiByZXF1ZXN0cw0KPiANCj4gDQo+
IEN1cnJlbnRseSwgZnVsbCBjbGVhbnVwIG9mIGJvdGggaW9fdXJpbmcgYW5kIEZVU0UgZGF0YSBz
dHJ1Y3R1cmVzIGZvciANCj4gZnVzZS1vdmVyLWlvX3VyaW5nIG9ubHkgaGFwcGVucyBpbiB0d28g
Y2FzZXM6ICBbc2luY2Ugd2UgaGF2ZSBtYXJrIHRoZXNlIA0KPiBTUUVzIGNhbmNlbGFibGUgd2hl
biB3ZSBjb21taXRfYW5kX2ZldGNoIGV2ZXJ5dGltZShtZW50aW9uZWQgYmVsb3cpXQ0KPiAxLldo
ZW4gdGhlIEZVU0UgZGFlbW9uIGV4aXRzIChleGl0IHN5c2NhbGwpDQo+IDIuRHVyaW5nIGV4ZWN2
ZSwgd2hpY2ggdHJpZ2dlcnMgdGhlIGtlcm5lbCBwYXRoOg0KPiANCj4gaW9fdXJpbmdfZmlsZXNf
Y2FuY2VsID0+DQo+IGlvX3VyaW5nX3RyeV9jYW5jZWxfdXJpbmdfY21kID0+DQo+IGZpbGUtPmZf
b3AtPnVyaW5nX2NtZChjbWQsIElPX1VSSU5HX0ZfQ0FOQ0VMIHwgSU9fVVJJTkdfRl9DT01QTEVU
RV9ERUZFUikNCj4gDQo+IA0KPiANCj4gQmVsb3cgaXMgYSBzdGF0ZSBkaWFncmFtIChtZXJtYWlk
IGdyYXBoKSBvZiBhIGZ1c2VfdXJpbmcgZW50cnkgaW5zaWRlIA0KPiB0aGUga2VybmVsOg0KPiAN
Cj4gZ3JhcGggVEQNCj4gICAgICBBWyJVc2Vyc3BhY2UgZGFlbW9uIl0gLS0+IA0KPiBCWyJGVVNF
X0lPX1VSSU5HX0NNRF9SRUdJU1RFUjxici8+UmVnaXN0ZXIgYnVmZmVyIl0NCj4gICAgICBCIC0t
PiBDWyJDcmVhdGUgZnVzZV9yaW5nX2VudCJdDQo+ICAgICAgQyAtLT4gRFsiU3RhdGU6IEZSUlNf
QVZBSUxBQkxFPGJyLz5BZGRlZCB0byBlbnRfYXZhaWxfcXVldWUiXQ0KPiANCj4gICAgICBFWyJG
VVNFIGZpbGVzeXN0ZW0gb3BlcmF0aW9uIl0gLS0+IEZbIkdlbmVyYXRlIEZVU0UgcmVxdWVzdCJd
DQo+ICAgICAgRiAtLT4gR1siZnVzZV91cmluZ19xdWV1ZV9mdXNlX3JlcSgpIl0NCj4gICAgICBH
IC0tPiBIeyJDaGVjayBlbnRfYXZhaWxfcXVldWUifQ0KPiANCj4gICAgICBIIC0tPnxFbnRyeSBh
dmFpbGFibGV8IElbIlRha2UgZW50cnkgZnJvbSBxdWV1ZTxici8+QXNzaWduIHRvIEZVU0UgDQo+
IHJlcXVlc3QiXQ0KPiAgICAgIEggLS0+fE5vIGVudHJ5IGF2YWlsYWJsZXwgSlsiUmVxdWVzdCBn
b2VzIHRvIGZ1c2VfcmVxX3F1ZXVlIGFuZCB3YWl0cyJdDQo+IA0KPiAgICAgIEkgLS0+IEtbImZ1
c2VfdXJpbmdfZGlzcGF0Y2hfZW50KCkiXQ0KPiAgICAgIEsgLS0+IExbIlN0YXRlOiBGUlJTX1VT
RVJTUEFDRTxici8+TW92ZSB0byBlbnRfaW5fdXNlcnNwYWNlIl0NCj4gICAgICBMIC0tPiBNWyJO
b3RpZnkgdXNlcnNwYWNlIHRvIHByb2Nlc3MiXQ0KPiANCj4gICAgICBOWyJQcm9jZXNzIGV4aXQg
LyBkYWVtb24gdGVybWluYXRpb24iXSAtLT4gDQo+IE9bImlvX3VyaW5nX3RyeV9jYW5jZWxfdXJp
bmdfY21kKCkgPGJyLz4gPj4gTk9URSBTaW5jZSB3ZSBtYXJrZWQgdGhlIA0KPiBlbnRyeSBJT1JJ
TkdfVVJJTkdfQ01EX0NBTkNFTEFCTEUgPGJyLz4gaW4gdGhlIHByZXZpb3VzIGZ1c2VfdXJpbmdf
Y21kICwgDQo+IHRyeV9jYW5jZWxfdXJpbmdfY21kIHdpbGwgY2FsbCA8YnIvPiBmdXNlX3VyaW5n
X2NtZCB0byAnZGVsZXRlJyBpdCA8PCJdDQo+ICAgICAgTyAtLT4gUFsiZnVzZV91cmluZ19jYW5j
ZWwoKSJdDQo+ICAgICAgUCAtLT4gUXsiSXMgZW50cnkgc3RhdGUgQVZBSUxBQkxFPyJ9DQo+IA0K
PiAgICAgIFEgLS0+fFllc3wgUlsiPj4gZXF1aXZhbGVudCB0byAnZGVsZXRlJyA8PCBEaXJlY3Rs
eSBjaGFuZ2UgdG8gDQo+IFVTRVJTUEFDRTxici8+TW92ZSB0byBlbnRfaW5fdXNlcnNwYWNlIl0N
Cj4gICAgICBRIC0tPnxOb3wgU1siRG8gbm90aGluZyJdDQo+IA0KPiAgICAgIFIgLS0+IFRbImlv
X3VyaW5nX2NtZF9kb25lKC1FTk9UQ09OTikiXQ0KPiAgICAgIFQgLS0+IFVbIkVudHJ5IGlzICdk
aXNndWlzZWQnIGFzIGNvbXBsZXRlZDxici8+V2lsbCBubyBsb25nZXIgDQo+IGhhbmRsZSBuZXcg
RlVTRSByZXF1ZXN0cyJdDQo+IA0KPiAgICAgIFZbIlByYWN0aWNhbCBlZmZlY3RzIG9mIGNhbmNl
bGxhdGlvbjoiXSAtLT4gV1siMS4gUHJldmVudCBuZXcgRlVTRSANCj4gcmVxdWVzdHMgZnJvbSB1
c2luZyB0aGlzIGVudHJ5PGJyLz4yLiBSZWxlYXNlIGlvX3VyaW5nIGNvbW1hbmQgDQo+IHJlc291
cmNlczxici8+My4gRG9lcyBub3QgYWZmZWN0IGFscmVhZHkgYXNzaWduZWQgRlVTRSByZXF1ZXN0
cyJdDQo+IA0KPiANCj4gDQo+IFdoZW4gdGhlIGtlcm5lbCBpcyB3YWl0aW5nIGZvciBWRlMgcmVx
dWVzdHMgYW5kIHRoZSBjb3JyZXNwb25kaW5nIGVudHJ5IA0KPiBpcyBpZGxlLCBpdHMgc3RhdGUg
aXMgRlJSU19BVkFJTEFCTEUuIE9uY2UgYSByZXF1ZXN0IGlzIGhhbmRlZCBvZmYgdG8gDQo+IHRo
ZSB1c2Vyc3BhY2UgZGFlbW9uLCB0aGUgZW50cnkncyBzdGF0ZSB0cmFuc2l0aW9ucyB0byBGUlJT
X1VTRVJTUEFDRS4NCj4gDQo+IFRoZSBmdXNlX3VyaW5nX2NtZCBmdW5jdGlvbiBoYW5kbGVzIHRo
ZSBDT01NSVRfQU5EX0ZFVENIIG9wZXJhdGlvbi4gSWYgYSANCj4gY21kIGNhbGwgY2FycmllcyB0
aGUgSU9fVVJJTkdfRl9DQU5DRUwgZmxhZywgZnVzZV91cmluZ19jYW5jZWwgaXMgDQo+IGludm9r
ZWQgdG8gbWFyayB0aGUgZW50cnkgc3RhdGUgYXMgRlJSU19VU0VSU1BBQ0UsIG1ha2luZyBpdCB1
bmF2YWlsYWJsZSANCj4gZm9yIGZ1dHVyZSByZXF1ZXN0cyBmcm9tIHRoZSBWRlMuDQo+IA0KPiBJ
ZiB0aGUgSU9SSU5HX1VSSU5HX0NNRF9DQU5DRUxBQkxFIGZsYWcgaXMgbm90IHNldCwgYmVmb3Jl
IGNvbW1pdHRpbmcgDQo+IGFuZCBmZXRjaGluZywgd2UgZmlyc3QgY2FsbCBmdXNlX3VyaW5nX3By
ZXBhcmVfY2FuY2VsIHRvIG1hcmsgdGhlIGVudHJ5IA0KPiBhcyBJT1JJTkdfVVJJTkdfQ01EX0NB
TkNFTEFCTEUuIFRoaXMgaW5kaWNhdGVzIHRoYXQgaWYgdGhlIGRhZW1vbiBleGl0cyANCj4gb3Ig
YW4gZXhlY3ZlIGhhcHBlbnMgZHVyaW5nIGZldGNoLCB0aGUga2VybmVsIGNhbiBjYWxsIA0KPiBp
b191cmluZ190cnlfY2FuY2VsX3VyaW5nX2NtZCB0byBzYWZlbHkgY2xlYW4gdXAgdGhlc2UgU1FF
cy9DUUVzIGFuZCANCj4gcmVsYXRlZCBmdXNlIHJlc291cmNlLg0KPiANCj4gQmFjayB0byBvdXIg
cHJldmlvdXMgaXNzdWUsIHdoZW4gZGVsZXRpbmcgYSBGVVNFIGV4cG9ydCBpbiBRRU1VLCB3ZSBo
aXQgDQo+IGEgY3Jhc2ggZHVlIHRvIGFuIGludmFsaWQgQ1FFIGhhbmRsZXIuIFRoaXMgaGFwcGVu
ZWQgYmVjYXVzZSB0aGUgU1FFcyB3ZSANCj4gcHJldmlvdXNseSBzdWJtaXR0ZWQgaGFkbid0IHJl
dHVybmVkIHlldCBieSB0aGUgdGltZSB3ZSBzaHV0IGRvd24gYW5kIA0KPiBkZWxldGVkIHRoZSBl
eHBvcnQuDQo+IA0KPiBUbyBhdm9pZCB0aGlzLCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0IG5vIGZ1
cnRoZXIgQ1FFcyBhcmUgcmV0dXJuZWQgYW5kIA0KPiBubyBDUUUgaGFuZGxlciBpcyB0cmlnZ2Vy
ZWQuIFdlIG5lZWQgdG8gZWl0aGVyOg0KPiANCj4gKiBQcmV2ZW50IGFueSBmdXJ0aGVyIHVzZXIg
b3BlcmF0aW9ucyBiZWZvcmUgY2FsbGluZyBibGtfZXhwX2Nsb3NlX2FsbA0KPiANCj4gb3INCj4g
DQo+ICogUmVxdWlyZSB0aGUgdXNlcnNwYWNlIHRvIHRyaWdnZXIgZmV3IHNwZWNpZmljIG9wZXJh
dGlvbnMgdGhhdCBjYXVzZXMgDQo+IHRoZSBrZXJuZWwgdG8gcmV0dXJuIGFsbCBvdXRzdGFuZGlu
ZyBDUUVzLCBhbmQgdGhlbiB0aGUgZGFlbW9uIGNhbiBzZW5kIA0KPiBpb191cmluZ19jbWQgd2l0
aCB0aGUgSU9fVVJJTkdfRl9DQU5DRUwgZmxhZyB0byBtYXJrIGFsbCBlbnRyaWVzIGFzIA0KPiB1
bmF2YWlsYWJsZSAoRlJSU19VU0VSU1BBQ0UpICJkZWxldGUgb3BlcmF0aW9uIiwgZW5zdXJpbmcg
dGhlIGtlcm5lbCANCj4gd29uJ3QgYXNzaWduIHRoZW0gdG8gZnV0dXJlIFZGUyByZXF1ZXN0cy4N
Cj4gDQo+IA0KPiANCg0KSSBoYXZlIHRvIGFkbWl0IHRoYXQgSSdtIGNvbmZ1c2VkIHdoeSB5b3Ug
Y2FuJ3QgdXNlIHVtb3VudCwgaXNuJ3QgdGhhdA0KdGhlIG1vc3QgZ3JhY2VmdWwgd2F5IHRvIHNo
dXRkb3duIGEgY29ubmVjdGlvbj8NCg0KSWYgeW91IG5lZWQgYW5vdGhlciBjdXN0b20gd2F5IGZv
ciBzb21lIHJlYXNvbnMsIHdlIHByb2JhYmx5IG5lZWQNCnRvIGFkZCBpdC4NCg0KDQpUaGFua3Ms
DQpCZXJuZA0K

