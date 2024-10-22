Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F96DD1CDA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37KT-0001ON-Rx; Tue, 22 Oct 2024 01:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t37KS-0001Ne-7L
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:21:12 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t37KQ-0003uF-JA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1729574470; x=1761110470;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5US313yc1FZqFbl/BK/YlVAeJezkSy+rl7Iq7FhQ458=;
 b=HaMiKI+bzGO5VlZw2GZCD9SjrwORj/3Qmjy6t76cwPjkVCIC8dgWFjXF
 rlEoHT4vXXd4a7shdx8JpjFgykAhhAZXEnEmRDf6WYzkBXKpMOlwY8x1U
 knPEqbdU36vv60Fn1QYFz3+eVaILbgLSCv+jXcn29F2Ko9xhXb1fAqFPB
 2OrVPEY7LLWpH8zR0bcwIi4k+lUERuHzCs73Cqzh8MtXeo1qyfj2rQ4+k
 9bLFEqYUpH7lxayoxjvwPN7HzSX2D6J2vo2QEoenHeuMSAGmo3NzSQ9h9
 Qt2KpJhBj9lRBEtze7/mqf2CamMAPRV2lboAMoNb2246hB8sjXcXNZtpd A==;
X-IronPort-AV: E=Sophos;i="6.11,222,1725314400"; d="scan'208";a="22784183"
X-MGA-submission: =?us-ascii?q?MDHFMIVSOo4bm5z+57BtRYNtcjX7wp3LHchWfs?=
 =?us-ascii?q?ztDX/pLP3Il7whXWaRzvu7iRyMJpMJlgP+xeIAKwseyYpRzxZQlriCQE?=
 =?us-ascii?q?gYhFne/1aEJBJrrDGXwdHpRXI4WZhwE3juAQiYr1IbKBJSRvAf1UT7+a?=
 =?us-ascii?q?J7xPdhTAsHEMf/Glu7Q7XnfA=3D=3D?=
Received: from mail-dbaeur03lp2172.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.172])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 07:21:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1pN0aawZ5x0IzVY/7nTmKCZiYulDgD2RPRPwlGhwISQugje275PwelEt6n71+DmavcBI6wjHRUBAu3RtPWZm0EqG39+PFLzPsrPaG82VHS6rSBW7gh6b7swcL2D2Eapk1za1kh5EAeAVwVfRD1tBa/0DCRcUYONheAfgjBe1NaLASU3UMdeOf2InrM2QczVpKshr1apUtcNJ1EZgwGp3QISuVEyaxaWLSqo0CUxaX6B8XrYempQrrBXjMa2/zY+3x08fPyWrpG+W+CZvkWnowaK/P2fIOA0QwtmzhEBn58Chkrz2/GPJcXSxNLrS1kLJzN/yosDXoy6zfb7hFlNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5US313yc1FZqFbl/BK/YlVAeJezkSy+rl7Iq7FhQ458=;
 b=qq9q3BO5GWZNEq2wHtWTbFdcP3jFXIQe6675EqEdciXk6hAhkOWfHrm894jgJL2al6eywL/GTrQiYtSdlBCNWOH/uHUSNMP3gAv7WIoMWfQ6akB1QexubOU7sf8MUr6mVNwVMQKyq/9qRJtduvxJJe1RrlNnPTqPUDQo5CYpE4HT8NhDMQ/j/jcZc1aWJM7GluPbQ4jV5GN43H+O8ZQ29jd4K5785l/mbGgipeOgpfIose1xnFe0ZC65l3qMRHrfbTBNGSM3xmuEVhFTu/M+QtTGMHzr7Cku72bk83dKhQYpQYKC4BFl3bYbbwh3kgEoJwvqoaqZCjdgdUcqEgLXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5US313yc1FZqFbl/BK/YlVAeJezkSy+rl7Iq7FhQ458=;
 b=ZkuRM4tlIlKtfmFZYJXzgTiEl1Y1nftrPgAe1AVXZApcZ+Lr9t49pKMhxV9BXpT40ns0/Z/LHp87/fEnIPpDo4sivqIjoRxpU/IXN92eXT7B1tsEy7SP+YT2GCY+tRfB/SytPvP4JeemUysFJyUUs/RwNf164FXxhnCnFwaI4zB3Bq2bm3JWCXp4EJPpxxydWG7JDg0DA4VBzjmWYgoQ+fKfNyLgq+RtLUesq24L2I3AUDCln13JjWa0WTfxkUx9xQoPEYt1G9vX0lTbQa5nz3BUUuljq+31H0doUnQ9ySO0ZiPRU/bROd3YbvqM900Tuhco4pWDGNT+TL6L5Tq5oA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV2PR07MB8986.eurprd07.prod.outlook.com (2603:10a6:150:b1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 05:21:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:21:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Roman Penyaev <r.peniaev@gmail.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/8] chardev/chardev-internal: remove unused `max_size`
 struct member
Thread-Topic: [PATCH v2 2/8] chardev/chardev-internal: remove unused
 `max_size` struct member
Thread-Index: AQHbHk2cV0FeZnuiVkOWmWAkmiOp0bKSR8SA
Date: Tue, 22 Oct 2024 05:21:04 +0000
Message-ID: <1d2638b2-0439-4632-9e2c-83aec2488e73@eviden.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
 <20241014152408.427700-3-r.peniaev@gmail.com>
In-Reply-To: <20241014152408.427700-3-r.peniaev@gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV2PR07MB8986:EE_
x-ms-office365-filtering-correlation-id: 222e0d41-65dd-4426-3ded-08dcf25953a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QUlldnpHNnVyVnV0aGlhWGdsNHpkbzM3Z1pHMlhOdEpHNjdCQ3dhYTNEMXVk?=
 =?utf-8?B?Ly93Z2JxanY5MjlqdU9QSUFzUGtiS2ZiS1hRbHRERjE5VjBxbHlDNi9JbnAv?=
 =?utf-8?B?cEJWZDk5dFJ6SEo3TEtnNWpCd002THNSQUIzVDczNkVRTWNjbHFPM1dvVHBM?=
 =?utf-8?B?cTdaQXBTSk01Sy9lTjdaMGtsT2FGeVJzWDRTemNpRmNURm5GZ3lGTXZFOXpS?=
 =?utf-8?B?MG1VMlJzenF0czZvdk5SVVBNSCtYWmNYclc2UHhQSGl4eng4K3UrcEZJQTdQ?=
 =?utf-8?B?NlVMRTMyQVZ3NjF6eFUrT1VnVXJUWU5TSk1ISzFDNVFKVGd5NS9EK0c4VDVV?=
 =?utf-8?B?azA3WStaVVFZYXhoajlOQmlHNnZGVnl5ajJUdWFIRlh1WGpDWndHc3dHVHVy?=
 =?utf-8?B?UEhZMklIaGNiS3lyNFpWcEZBL3NZSXZyWW9wMlNXQWJkNGpBRkg3ZklZRTdH?=
 =?utf-8?B?SDljdFlvb2pTVUlwVkt3ZHFIcVlBUUdlbWFnalJIdWZoY2NtNTBmVVQ1ZVdj?=
 =?utf-8?B?UVZmZlYreWx1Y2ovU0R5dUxhS1lTOVVJU0JKTjdiRU9xa2lDa2p3NDlJaDlz?=
 =?utf-8?B?N0owSUxlZUwrQXE5R0VhcVVnNTdBVXlseHBmcm9rMWl3ZlRYaWlNM05xTVY3?=
 =?utf-8?B?alUzVzU4RElIMWNOcUFaT0FkdkdDQmQrUmlCcFg0UU00UjY0Y0JTeVE4Y096?=
 =?utf-8?B?Wmx0U2djN2hmNUVkL2Q0cjBJbHMwZFBlZmJzY1FmdzVlK3V3Y3V4cFFuWThT?=
 =?utf-8?B?M2V2R3Rub0dKSmVUaTFzaDdISW10Y3UrUHJCWFFCZkwwVXNSNmtoVWF6Sy9S?=
 =?utf-8?B?T1htNjFGbDRmVVZBbWdMYTdOOEF6SFdRaGhOUUpaVUdEOEQ4UFV6T2NkNGV4?=
 =?utf-8?B?NHA4R2taVE1zUlJ1N0ZHeDVqMXRKNnYvNEdoczdaSGVTU2E2eGVsNzdaSjVz?=
 =?utf-8?B?OFN5UmJqNXN4OXp2dkNPS3d5UTIybFZWNFg3eWlXK1JjcmlmTnNPcldEVXpR?=
 =?utf-8?B?ZmRBalFHbUtwbFFhM0xaSDhqZS83Um4zQ3VvY3VHYlBwNFpTZzZzTzNXamN4?=
 =?utf-8?B?OEg4QlBXUmg3U1YyYmJoZEh4U0tnVU0xZVl1NmcreWMrUVRXWlBhMXU0SEdR?=
 =?utf-8?B?amhhNGcya1FMd3QrVGNMUm5JenE5MzFNNldDTFpMdDg1R2xxdVdURUJlK1Zi?=
 =?utf-8?B?UjBQRHRSVllrQlRZOGV3MGZwK0RPUEZORGxvR2RoMXZJcWFQYlFZM2x4N0Jm?=
 =?utf-8?B?WnUyY245R2tJbDFIUGF1NjlNZFB5VTlmTnpOV3p5WUY1cVQ3SUJlbVRtQXZs?=
 =?utf-8?B?VHgzNWtUZ3liR2hvQ0JHcWtKdm4vZVFpSTBWS3h0cE94SUVFc25NKzRzY0JL?=
 =?utf-8?B?bEcwV2YyYlM0S1dab1dYc0F0VTRvS1phalBiSHJFNWNrRTQ3dkxhMGQwMGxF?=
 =?utf-8?B?L1p4QWdrUkVlb3NHOU1lSVNTZnI0UXY5cy90TXhLSEJwRWNnbzJYVzloS2Rs?=
 =?utf-8?B?SXNpQmdVMWRMcWx2aVBhUWs5eW40MHJQMWtYSHVtSys4dDlwRk1sc01RSVo5?=
 =?utf-8?B?N3JDZnYveVFuR2Q4bkNleWpxNmk3MmtVdmVMV0ZMaVVBYzc4YTgydXl0R0lu?=
 =?utf-8?B?Z2FkK2xSbDJSb3l4LzBoaHVFaE5FRnczRGdxbjd3a0t2SzNHWjJrakRlSTEx?=
 =?utf-8?B?R2NaUHZ5amkvS0FuV2xRei9wUzkxenVhejhXRGNGUlFjRWJjakhQallUWmc1?=
 =?utf-8?B?d0h1NkQ3UGhsai9hNUtGbUNMNS9zT1VHanVxR3lZdFFvbXp4R0ZnUkNVdUFF?=
 =?utf-8?Q?uskdW4NPxAnHwqAyBosLG8BRMoMYXyUChbBNo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0gybjJXSEJSNmsyNkcrQUJoRzE2bDNOejd6RSs4d1pxQ3E3UWd4bXZnVzVU?=
 =?utf-8?B?eWJ1eTc3c2tZNHUzbGx2NlV4aEV2UTNRRmV4MHFiSGNQMXJ1SVk4ZXkxVEpI?=
 =?utf-8?B?REhGbFFFa21hQU9VS2w3cGNoWllUK3NCSVdndWZ3eXVjdnFXY3huUzkyMTlH?=
 =?utf-8?B?Y0J2bCtIRWR0Ni9WVHpMbkFtaWZhK3lMWlVJejZLSVAwQUdEZU1QcmdtMXA3?=
 =?utf-8?B?cTNTRGlsVStkVjJHS095R2cxdkNUa09lcjBMZ3JXR2ZZZmxTZ3haUlE4a00v?=
 =?utf-8?B?MDdWd21LYzNneHk4YWVST0N1Rm1vUkFOYmE1dGlSWWo3Sk5KT0EvZ1U5NzFh?=
 =?utf-8?B?MmlrRjVhLzhzOHhrYlFWU0JxaUluVzlUa1IvTktNaGJUemhUQ3RsYVZoRUxQ?=
 =?utf-8?B?eXdUZlpTcFVMSVFhRXJ4VnpxTUh0c3dFL2J5TmJVdDR0dVlweFYwQXFsN0Y5?=
 =?utf-8?B?Q2QwaEZqOUNnL29pZFdyaDRzTHppNlRVYlM0c3RyK0ZFYU1UN1RYM0M5WVpQ?=
 =?utf-8?B?TzBNajIrRkxSRjRhRnI1T1d3andKTXk4VkVvcitacFNOa1AwZ0VadXNqeE9l?=
 =?utf-8?B?cnZ1UTl4SmtxdUdNSGdUckhsQzUrSlc2STliSS8zNmZvSlI4SWgrU1duTk9Q?=
 =?utf-8?B?dHdtK2pScDJFOFNUREdzS2tXcWlyV3pnZkptU01wV1VRRkdMVDZCWmk3dGlW?=
 =?utf-8?B?SUYrc0NLSVk4OC9KQkVsb05EU0dOcDdNWXFqdHYwY3hEZWVqVTV5Z0MxdWRl?=
 =?utf-8?B?WUpsem1RTVlYQ3lSTU9vbnR6aUNiKzlFWmZnblRJcjdvcEhtcTJBaE51bnhC?=
 =?utf-8?B?T0sxOFR0TzFCYjIxb2lEd0c4clBZdllXMXBNZUVtL1hMZG9DdE81Wk1WaTAv?=
 =?utf-8?B?a2VWeGhvd09Va3FLUlNsK21sc0ZYVWRjUlNtN3hGSmQ5cVU4dVh6bEJTdXZW?=
 =?utf-8?B?ZFRUY0QzZGw0K0NXRHk1aDJFUWVWWFg2QXRLUVFOZkJKck1xL0VQRC9jK0l4?=
 =?utf-8?B?RWhNWVUzYU81aTYzcHAveUdSbmRsczltWUd5RHVJUjV3QUxuVi9RQko2TGJt?=
 =?utf-8?B?VkJSaVBLWVhKQktFUUZVbDI0UE1ZZGtiYVRSV2tNdC9WcVRCNmdNU3c0Qlor?=
 =?utf-8?B?NWpuRy9wMjlOWW1RVWg3Mm9CRzJSeDJWQTVhWit6eXNCcUdQWTB3NUsxbTcr?=
 =?utf-8?B?aDFJajgwS3ZDcTViS05GVU8yTDFhOGlLbkZBMDNHWEg0ZzdhUWxIeWx5MnRY?=
 =?utf-8?B?bDdkMzFuU3U5T1JxT0Z5L3VNbzBlbFg0RFJVZFBRTjV2cCs5RzRHQnF2cnN5?=
 =?utf-8?B?L1U4QUlLckl5RW4ySjdTUGIyVmhubFU4d2pITStOZUw4L05ieUI1Z256QVVm?=
 =?utf-8?B?emRaMUo3S2dKNXdONks5elJTRFA1b3JkWlhneElzNWNoNEpKMVFRZlRxTFBG?=
 =?utf-8?B?MkRITGVhVnVTZkJoZkF3R3VvWFBGeXQxZHJNdng0YklGNEJTZWJiMWxXMmJL?=
 =?utf-8?B?eHp4Q29HVDdIS3EyUlFhdUM2MUl5UG43aEFnY2tVYkFtblRJSlcxbWVYeUJS?=
 =?utf-8?B?MU1VbkRwcEkrMStFNm5ZTEQwcXF3Umkzc1NQcDJRdlZoN2xuQnU0dTdsbG4z?=
 =?utf-8?B?dllBOTJKYlpOTTcyMGhQYm1NZDJxVjlnTktZZG5oU0VqK2Q2NnF3bDI1aHNs?=
 =?utf-8?B?TXE4UXZLUWt0ZHNHU3JGMGd1OTJKQ3JpU0lLZkJ5cVcydlIyUFJpMnVpU082?=
 =?utf-8?B?SEJwcmtBK0ZJQ3hOSGZQNmdESkFDYTlEVkNtbkYzWWl6bUNxRTE0UmhEcGda?=
 =?utf-8?B?ajgzS2RPbnZPU1dXbzBMdHA1MWYycS9RbWpYQ1hmbHFkTWJXa2lVM3V2REJv?=
 =?utf-8?B?VWxzR1pMTXdKKzFuWk1kQnVjYnI1SElWeGdDUG80U0ZyS3ZEYXZKT2xQUUFx?=
 =?utf-8?B?dGJRbkpBM2lMWmEwZHJNNlNpbk01N0VqSzZEMFFpRU13STNER0gxVHJoVkQr?=
 =?utf-8?B?MlpBR2dQd3p3Zjh1UEVvU1B2U0hJZit2dk5Dck1WQ2ZpVzhndWRuZzJmVmdJ?=
 =?utf-8?B?bHJlYTRnWTRiejNvMnlDbTlJK0Y3TGNza2ZhbmFEQVVQbHB4V25PQnI0WTR4?=
 =?utf-8?B?bFhiUGhCQm9VV1Rmd3ZtZWFhcmFiaXlneklVdXRsVDhFMStYZlV4dmFZdzNB?=
 =?utf-8?Q?UnuLUBwoV6f/7USxDeEHw8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D55B672F2214E40AAA135C922EB6E38@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222e0d41-65dd-4426-3ded-08dcf25953a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 05:21:04.9222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jeLLwq/YZCfXbP8Quw6+Aajy/6LXmhdurxqytLTXuTHGi/5pBKMWen2csqDX1NrKV4wVjGXpjtrd7S7lx7/xhFJLe2yT9x5XqayktRN1rxjr7K/bKHTt41M6RFzlyZc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB8986
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJp
ZkBldmlkZW4uY29tPg0KDQoNCk9uIDE0LzEwLzIwMjQgMTc6MjQsIFJvbWFuIFBlbnlhZXYgd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gQ2xlYW4gdXAgZm9y
Z290dGVuIGxlZnRvdmVycy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogUm9tYW4gUGVueWFldiA8ci5w
ZW5pYWV2QGdtYWlsLmNvbT4NCj4gQ2M6ICJNYXJjLUFuZHLDqSBMdXJlYXUiIDxtYXJjYW5kcmUu
bHVyZWF1QHJlZGhhdC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gLS0tDQo+
ICAgY2hhcmRldi9jaGFyZGV2LWludGVybmFsLmggfCAxIC0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvY2hhcmRldi9jaGFyZGV2LWludGVybmFs
LmggYi9jaGFyZGV2L2NoYXJkZXYtaW50ZXJuYWwuaA0KPiBpbmRleCA0ZTAzYWYzMTQ3NmMuLmMz
MDI0YjUxZmRkYSAxMDA2NDQNCj4gLS0tIGEvY2hhcmRldi9jaGFyZGV2LWludGVybmFsLmgNCj4g
KysrIGIvY2hhcmRldi9jaGFyZGV2LWludGVybmFsLmgNCj4gQEAgLTQwLDcgKzQwLDYgQEAgc3Ry
dWN0IE11eENoYXJkZXYgew0KPiAgICAgICBpbnQgZm9jdXM7DQo+ICAgICAgIGludCBtdXhfY250
Ow0KPiAgICAgICBpbnQgdGVybV9nb3RfZXNjYXBlOw0KPiAtICAgIGludCBtYXhfc2l6ZTsNCj4g
ICAgICAgLyogSW50ZXJtZWRpYXRlIGlucHV0IGJ1ZmZlciBjYXRjaGVzIGVzY2FwZSBzZXF1ZW5j
ZXMgZXZlbiBpZiB0aGUNCj4gICAgICAgICAgY3VycmVudGx5IGFjdGl2ZSBkZXZpY2UgaXMgbm90
IGFjY2VwdGluZyBhbnkgaW5wdXQgLSBidXQgb25seSB1bnRpbCBpdA0KPiAgICAgICAgICBpcyBm
dWxsIGFzIHdlbGwuICovDQo+IC0tDQo+IDIuMzQuMQ0KPg0KPg0K

