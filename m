Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD1BCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Bto-0005Bf-Vw; Fri, 10 Oct 2025 08:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v7Btm-0005BT-9q
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:07:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v7BtY-0001ns-Qe
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:07:01 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59A6J1PK506337; Fri, 10 Oct 2025 05:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KY3G6aR7MU8yr96PR2lEg+Nwwr9YzG73HYs6dlWgg
 vo=; b=sopVuQuPbNOhcby4GRJjAYEpTA7c0OluZ52seXYiVjpc5tZatPL0nmePX
 kJeCPZHQNk8GVJPkOTpp+WbSqAEmPPHzYPivbQrYQe5WEizrUAVs+amyoz8DgNdc
 T3aahY90q/v7kS0Y2BhGQR/q6ZsrvJCw/z+1MsTxPfyO0jxWZ9013LTjJw/ZHCLW
 tLyJrGIkdi1acy72Y/JXteuJ/aHmwgzPhaFDFnAVeneyEkd2KoZTAVFZ+Ndz8uBM
 hUJCWiQIuoBk+CawebZYZtLH3ZZ0qiNbAcHSGX5G/6gGwAiud8a7FSswWIWEvMP9
 /6quwRlH/2HltZm3tr1I4lWWRaiNg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021111.outbound.protection.outlook.com [40.107.208.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1yms3f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 05:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izPmD0jGwCNajb5w9DjZoVhYDwfIjvjjHsNZCt7G6Rigoq07FdgDTg76/8Iy+FYyKHU6KDvZyQ7srnYkK5+oYM3uVWikI/3t6DvkVyrzfIsyXV5aH9Mplo/deiyYvRLEckQ5SAIcfG81dSQ6ipQsWVuE8F8mKphJvypWjkuVtuzNVv15ISFwjYkO8UKcYZZJyR8iFQ2DOMfjJDjF3/fNmk3S2dHiD1Pfa/shEcieZJF72BZEmOMJzi/GnhvyBym0VyYtv0kXCwGgiJurrLcTKN9Uh9T2Ol4UHiPYNo60NosglJC9QzZ9DBo2N4ILK1MRlNl0IpinkM7T93fBFqRjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY3G6aR7MU8yr96PR2lEg+Nwwr9YzG73HYs6dlWggvo=;
 b=cT0S2yvCn8vltHwAO1BJTMDuMqdL9C59ltDCV2qhrAKL/Y36c6BirEJgJCp5e2Tx1ooPeFWhNjLFZo3No861pZxVWPVJgbVPzTUm4Dta+bmuXZrP5i4TzwMONOsp+QQ/M4pTl7L5NTbVzDV1tjnpF9O0YQviOJsXeB7rTYoYxibbIW10YKjzSAZ41lOOk9U0p/Ey1/mvORepZ3idJYLQC9RD/xWs6IeaDs/i7BdXq9aB/ZLuCVz1kKeLyfvSVM1uwXkWvolzPr8SRGqUBsT+tND2XXGobgKsERVns4nwenTBip5Tb5nJguRKn8DMhl+08kYbo1qbyiwUpmBP0+Q95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY3G6aR7MU8yr96PR2lEg+Nwwr9YzG73HYs6dlWggvo=;
 b=gt59bJ9spLQ2WgQi/OH9jEb65k6kQjwWCQJk166LGxR9J2lzUwEKjY/aPSCmnxWGDAnHgjcXzAVwE6W317VR+e/7Nr5M/CSGi5JtcrU0vWpnDfhoTwJ7zHUQ9mQXsRWaJE3z7hb/GMKJH11qFUMlYGZE/rG5sKzfvwDBXH5+8IWuAW9rbgAgbi02g1wMU/tPidcLMZYQU8bL+dBwvkHmTYkkfmbL8ueJ7sX8uGog9y4V9BB7TCik7+YvyZ6UdWbDH/ZoLLkX1zkm+nXJmu2wcfWXdn1xkL2lccuq5bJ2H2M20GD0F66fRlyI8AlZEwr15EvTZhcxFVpaE+hMN4MTbA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by CH2PR02MB6537.namprd02.prod.outlook.com (2603:10b6:610:69::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:06:35 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:06:34 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Manish Mishra
 <manish.mishra@nutanix.com>
Subject: Re: [PATCH v5 3/3] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Topic: [PATCH v5 3/3] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Index: AQHcOQWMmM6WUvnnZU6cl8ObCt65OrS5ngeAgAAVTQCAAEk1gIABTXuA
Date: Fri, 10 Oct 2025 12:06:34 +0000
Message-ID: <EF0BC894-DF14-490B-82D4-00695C533AD4@nutanix.com>
References: <20251009101420.3048487-1-tejus.gk@nutanix.com>
 <20251009101420.3048487-4-tejus.gk@nutanix.com> <aOePR-Jd5UX5DXAA@redhat.com>
 <16F108E5-79A7-4940-B3AB-BDB34EC4CA93@nutanix.com>
 <aOfejwB5ZjSv444I@redhat.com>
In-Reply-To: <aOfejwB5ZjSv444I@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|CH2PR02MB6537:EE_
x-ms-office365-filtering-correlation-id: 828299fa-a0fc-490e-12e2-08de07f57529
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N01aZm5SSVJreUwwT2UzcHVyZnQzcXdIWlRsdW1ueGhMakZJMTNrZ1haOCto?=
 =?utf-8?B?YTcrOEN6MWdBK0Y1aGQxdlNqeVlLUjRFaGFhbSt2cnh0eWpsd3pTcURCN1hz?=
 =?utf-8?B?MWxBbGVHUlFtSDdxUzY5VzZHVTd4ZmNiaXhPQTZFMkU1ajRLbmlBRWY2SVdS?=
 =?utf-8?B?and5V1UvVFpPVnNRM1hXZTdqbURBTjVGQUFPVUtiK0tIMWJCcTF1cTZDcUk1?=
 =?utf-8?B?c3Y3c0pHOHZGbm5odVRoSDZsc09haldiT0p1dENXTE5PTWQ3a3JRR2g3Z3Fj?=
 =?utf-8?B?c05PVTRpbzFyckpwbk00eENjcnExNGVDSjljekRSZGNaN05xQTRrTXJsZUxN?=
 =?utf-8?B?SGlzdElaRHdtR2hnOG9rWTBMS3ZFZzJzZUhnL1NTVHRvbFZueVord0JSSUk5?=
 =?utf-8?B?b0tUaXdqUHh1RGtQS2h3Yk15NUlMSnZMOTV0UGNLZThSVWNvNkpsUGhlTFNy?=
 =?utf-8?B?ajc4R0pYd0NZMzQ5WWUvdnVvaFZhWkJBeW1BZEFmQzVSdElQWEd5aDVhbFpz?=
 =?utf-8?B?YXlHREpGRTRUS0xram1ZTnl6K29RMGxsNjFZL0lsTVdxYk53OFZUZ0Y0SDdE?=
 =?utf-8?B?SDVWckhUTFJXOGhYOUtWeWYySWZyMllseE9BZXpoUm9qRjFrckFCTEptcmlC?=
 =?utf-8?B?RGJTeGl5Si95SUIrRVJzaEs1TnBhQlUwUGtnbFdjSlpUbXp2Z3pQVzllNWhj?=
 =?utf-8?B?bXNQNVZOWjlQWFVIR1dJVUdPN2lGdzRkRGtwSlpTemN5emtyKytBcFBJMWll?=
 =?utf-8?B?YVF0aFNBZmlwYkdnaUc2UUlETUVkVXY1UURkODZhQk5GT2hremlDTVNqeFB6?=
 =?utf-8?B?c1RlVHB6YmhKSHc3SHN5WlllTXpnWTN6aXdsLzFKMnJqYmFqbnltQ2g2aEd2?=
 =?utf-8?B?Uit5YUlva2ZwcWRmZ3dnb3YzQ0RyS3FVbXRZdDQyMDVZSVRVTTdYTzN6bzJK?=
 =?utf-8?B?TUFTalBHYnpoajZ3YUNMTFlINVMzSFhLQ1FxM29iMzIzZStlK09aMHk1VlNR?=
 =?utf-8?B?OERrR2RUUmlJSzdqOXgycnJMN1o5QTZoMUh5U0J5eDQ5WnpTMFRkRG5KNmxL?=
 =?utf-8?B?VG9oRGpTQUtRSVVPencvMHlnQUk0UVB0amJ4OWF6ZHMxeEN3TmhJNSt4bFBB?=
 =?utf-8?B?cGQrbjdQV2RqYkZKYTFsYm9ENisxS1R5alF1RUU5bVFtcU55SWQ4VXFUU1Vj?=
 =?utf-8?B?aTJuL1hzK1JzM3FuYjVJTjVWTW5XMi9UK0Vob3BxN2NvTVNtZDFncGkzNnp2?=
 =?utf-8?B?dytwVzh5TG8zc3Z6ZW1vbzRFRk5FRnRUVEJ6Y1cyRndNWlZocWt5ZDJvL1pJ?=
 =?utf-8?B?dGllRE5pSGlwdDkraU43RVI1NHNaNGVEQ05iekRCZDR0aThWZ1Z0Zm1xLy85?=
 =?utf-8?B?MjlhSDR5SVBDUkFwa3NoeXdOUVlUQU92ZXVUcVh0MFJSUmIzM0owYm52SGlD?=
 =?utf-8?B?TXB5NFhSNUZWaElHTVdIWlRoRHdsNnBCbzBMUlk2U1RNN2FUNW5SdVEvL3F2?=
 =?utf-8?B?NTRQNmJDbzdkU0Q5WXYrSDVWcklQUFdoYnE1bGZlanpTdWt1WDhTQWl6SVE0?=
 =?utf-8?B?V2dvMURWWkNPZS90cEFTY3VSTDlMZmJ5TjdEL3pLdC94UnJnMGdFcjZCMXN6?=
 =?utf-8?B?Y0pidzl0K3doR08zbGJkRlp2UTB1MU1OU0h5Q2UwczJkQkMrU2swT3V1c0xp?=
 =?utf-8?B?K1cxbWk5STAzY25vZnpmNUltSGhsWWJDMFgvQmJPMWIwQkJ5dXoxdFhoRnNY?=
 =?utf-8?B?SjE3dU9HdEwybjhPZVVlaS85NEhaUHp1VW9KempFWHV6Q3E2MEdtZDh3ZGJD?=
 =?utf-8?B?bld6S3pleGhGc2Q0WjF6VjFvUGRqR0hvb1ZMVWZWdHNzU3A1M0d3TnFGYmRE?=
 =?utf-8?B?dUVmNWgraHBucWxWWngzL21MUmQxRzhQcmFoZkltVHRnL0hPUGxXRlN5Tmxr?=
 =?utf-8?B?enN5NGJNV0RuV3JuUWRXckJrK0tzOFB0cUZHUHpINnlTWTR3ZXBic0Q1VUNE?=
 =?utf-8?B?VzV5Q1dlREhhMzRMbVpsMVovOGFORzdUR3kzSWZjbEs4bHZIQWxsdDNmTmtu?=
 =?utf-8?Q?uqo8qw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXBoLzkybDROMmZZOHFlenlqeXV6MXhhcU52MHlNNk41K3gyalRmTG1KNWJj?=
 =?utf-8?B?YnkyaU1lS3oxQ3NwU3JzREpUL2pyMnFlREQwMmg1TzdJZGFWRGYzdlBuMkNx?=
 =?utf-8?B?ODMyN3RzMHBnRTFBSU9mc0d4S21Lc3dDYXY3MUtoSStkR1F5OG40YWtGQmQ3?=
 =?utf-8?B?NXhiVWVCUGdiSHdCdFVjaUpqbXMyWTlLRE9DcS9Nb250cVUySmFOcTh6SXlz?=
 =?utf-8?B?TkJnaE9PanJMZlVtWnptdmFFM2c5OG9UUzNSQUtjUlNIN2gwSzgvaDVjMW84?=
 =?utf-8?B?TWlEVlZuS3owcVNPUGFjejRsYXNCWTR2MVYxamJINUNpSFVUOEFtSHBYZ0dN?=
 =?utf-8?B?UTBFNkozWWZlMVp1RFZ0V3JQNG1pdjNmaGJaK094VjV0WkM4bU1aZEU5ODE3?=
 =?utf-8?B?U3N2dnF3NTFYMmhoZVRPVnh2OTU1YUtpMjhoK2RSbXpMVEE5WmJCZkNjUEht?=
 =?utf-8?B?OVVpc1hvcE04UUk0ZHlzeDZDNjdkRDdKTUsxSWlOQ01ZSk5hQUJwdlc0WnJC?=
 =?utf-8?B?N1VXVHBxS1c1d0tVUWhUazJnbXorNkJDdDlySXljZkFXanRMQ01CVEQ3aldz?=
 =?utf-8?B?NnN4L2xQQkMyNmFXa2tXRHVXTzB2UnRZUmh4bWV2Qmhyb3VCbFF5TlpBVzdr?=
 =?utf-8?B?VUhOcUdLbXJ5VWdWQjkxbWlrOUpHMDAxaUZneW5UVmg3cUxJZVZPckppeGVC?=
 =?utf-8?B?UnJwYzZQRW56MG5xOXZaVElwWnFFKzZqV2pDUHdvNXNFcFpwRkFnUlBYNWhR?=
 =?utf-8?B?Y1N6eVRWNFNISmFMNDRkazZadGRscEhDUXJWNm56ZmtIUGt2Uks4aFE0M1NB?=
 =?utf-8?B?NzRaTVBXOGVlUm5JWHNNakp2K2xjclNLRG9ZOUpIVzhrdmJMU1JUK1gvZmJZ?=
 =?utf-8?B?UUJpY2VOeXJISm81UFhPMElGSWpaT0N5WlJvSVV4U1ZPcjhaQldxNkVYcHQ2?=
 =?utf-8?B?eXRpL2lzQUJDSFJqejhrTW44OWJYZTE1TkgvZnpGVytpK3dJK2xZcnNpYy9Z?=
 =?utf-8?B?NUdEVFNnLzIxL3dvNG1DMmtpRFBqby9VSnpjSVhvNEh1dEtaVEdzSEZCbnF0?=
 =?utf-8?B?UE1oMXVpNUNhZGMvVW1GdGNDY3o3ZXFZQkVsN1hLeVFBNlo2TjArUkNWZ0JG?=
 =?utf-8?B?cllsNTJXd2lyaDNVSEFSMlcxMS8zem44aDVxbmZ4MmhxU2hXTDJpVUswZnJ4?=
 =?utf-8?B?QmNadVhkMEQxT29wY2kyTHBzWFI3M3lUOUNKQ1VrZnB2OWl3QWJwZTE1MFF4?=
 =?utf-8?B?RTVFRCtIZmo1ZUpEL3JYQjE0NFlxWUZrWUJTeTl1STJpQy9EMXUzUmhHNkcv?=
 =?utf-8?B?cU9FSkk3MUhNcm90VW0zUmtkUzdZeGNkRWVhRFVsdDVaaW1jS0JoRHhESnpL?=
 =?utf-8?B?dTRIT3E0bVdVSDlzRCtjM25vd09yeTN1YXNlejhBTzBUQnNJeE0zcDJmRGFz?=
 =?utf-8?B?SVhLendwaUZSSG5TYjE3OTk5MWgrd3hFSUtJdEU3cXBYeDFDZEkxNURJUC9t?=
 =?utf-8?B?TlptTkJkYkM1c2NnRDQ0Uk14Um4zTU1RaGZwTWpoNGduODdBMmpCeXNqeFYr?=
 =?utf-8?B?S0ZyM1pFYnZtYTZRSHN0cFcyOTQyemNPZ21TMHR0SXJKS3ZaQ3lVc3FucnlH?=
 =?utf-8?B?Z21Pc2R3eGNIN29MZDV4dzQxckdiNkQrb3k1eVBVb3U3dzdaVnBrRjY2UXBH?=
 =?utf-8?B?MjJrV2dTeFhUeDErc0tKSVp4YkNvZ29ZdXprd2IrNy91UHE0ZFI4cUtsczRr?=
 =?utf-8?B?ZGZHb0pabi93dWs5OXVjUCt2Nkw2U0FwTWdXOS9WZ3lINVk4b1N5dE1tdGph?=
 =?utf-8?B?ZURyUFNaeGxYWTBTajZsREZOejI4cTh2SVFuSXUzVWd3NGxWc2JwOXZLZFp6?=
 =?utf-8?B?K2lOUXowMXpzaitYZlg5WWxnc1EvNGhrNnk4N2VGQS9mVGVoYXNlcGdCeVJr?=
 =?utf-8?B?akh1Nm0yNDdMMVpIZlM2K1VnTngzVTVncFlOcDZ4cUFsdEo1R3dXYzg1VHdp?=
 =?utf-8?B?ZVZUeU9pcDg1Sy9GZzRIelArZ0JZT1RHLy9Sbmh2OVZERG8zNmZrd2dyd3cy?=
 =?utf-8?B?T0Y1dTlDOXVxdis3V3NnSjlNZzFpZldjSUFHQ1Frd254NXlPSnBicXc2T3pE?=
 =?utf-8?B?TExINUwvUzU5YlBJQnQyaEpjbnlzM29mYUtxaDA0SDZlQUhmSGtXTUsvT3FE?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF84B91AACE51E40BCA46D245C073F13@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828299fa-a0fc-490e-12e2-08de07f57529
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 12:06:34.6070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VXBsCm2F2ytla9W7+LacDRpS59y8nNFWlzgGlrPv4r6xAgaMzAhMuYgnEv5PFuDzbewSsNhnK43Zfl+gLgWnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6537
X-Proofpoint-ORIG-GUID: hpjiKcSAhKMhSF6_Hy24V4zlc4VwgH51
X-Authority-Analysis: v=2.4 cv=BKu+bVQG c=1 sm=1 tr=0 ts=68e8f6cd cx=c_pps
 a=1ZUOSWNADGb7hvfJlxUA6A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=GiXRVs26oT8-BDYofWYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hpjiKcSAhKMhSF6_Hy24V4zlc4VwgH51
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA2OSBTYWx0ZWRfXy7v7lfQCwaat
 8wdapShBJSEbx+e3OJvUKcW+X0rJO3MQKvUq5mSQXaLwpoUoZJFIwY98JL6KM3v1/z9FL+8iSdk
 qCgJu+eLFeB5jqCWkpQlw0WlUSQxBwCJvBtGJsULA3CvTXGSy0XHL2I7AHjQJMnjsCQL6U+bg0j
 qT2whncSLfV1FkozwSoGXAySugR0EJU6ZcvmnLDH6EhUYVhO2crksPR9eY6zY3fef9+BmuK3Sxi
 2ArlhYJGEHBqbfD1n8ZUXY9gy0TAMXJIYxJZWaRpNidP50DQXinF+1CgmDEd831NS9f544NEZmZ
 8sRadln08dzh5/dttbavzVpux5ZIK6wFvS+X6R8xBddMFf0lblT+eUnfySKQF0+czvTJxUufbdC
 EF1fooAiAqWAHAbmb6KJd/TT/VYBTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gOSBPY3QgMjAyNSwgYXQgOTo0MOKAr1BNLCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxi
ZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElP
TjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gVGh1LCBPY3Qg
MDksIDIwMjUgYXQgMTE6NTE6NTFBTSArMDAwMCwgVGVqdXMgR0sgd3JvdGU6DQo+PiANCj4+IA0K
Pj4+IE9uIDkgT2N0IDIwMjUsIGF0IDQ6MDLigK9QTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVy
cmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+Pj4gQ0FV
VElPTjogRXh0ZXJuYWwgRW1haWwNCj4+PiANCj4+PiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4+PiANCj4+PiBP
biBUaHUsIE9jdCAwOSwgMjAyNSBhdCAxMDoxNDoxOEFNICswMDAwLCBUZWp1cyBHSyB3cm90ZToN
Cj4+Pj4gRnJvbTogTWFuaXNoIE1pc2hyYSA8bWFuaXNoLm1pc2hyYUBudXRhbml4LmNvbT4NCj4+
Pj4gDQo+Pj4+IFRoZSBrZXJuZWwgYWxsb2NhdGVzIGV4dHJhIG1ldGFkYXRhIFNLQnMgaW4gY2Fz
ZSBvZiBhIHplcm9jb3B5IHNlbmQsDQo+Pj4+IGV2ZW50dWFsbHkgdXNlZCBmb3IgemVyb2NvcHkn
cyBub3RpZmljYXRpb24gbWVjaGFuaXNtLiBUaGlzIG1ldGFkYXRhDQo+Pj4+IG1lbW9yeSBpcyBh
Y2NvdW50ZWQgZm9yIGluIHRoZSBPUFRNRU0gbGltaXQuIFRoZSBrZXJuZWwgcXVldWVzDQo+Pj4+
IGNvbXBsZXRpb24gbm90aWZpY2F0aW9ucyBvbiB0aGUgc29ja2V0IGVycm9yIHF1ZXVlIGFuZCB0
aGlzIGVycm9yIHF1ZXVlDQo+Pj4+IGlzIGZyZWVkIHdoZW4gdXNlcnNwYWNlIHJlYWRzIGl0Lg0K
Pj4+PiANCj4+Pj4gVXN1YWxseSwgaW4gdGhlIGNhc2Ugb2YgaW4tb3JkZXIgcHJvY2Vzc2luZywg
dGhlIGtlcm5lbCB3aWxsIGJhdGNoIHRoZQ0KPj4+PiBub3RpZmljYXRpb25zIGFuZCBtZXJnZSB0
aGUgbWV0YWRhdGEgaW50byBhIHNpbmdsZSBTS0IgYW5kIGZyZWUgdGhlDQo+Pj4+IHJlc3QuIEFz
IGEgcmVzdWx0LCBpdCBuZXZlciBleGNlZWRzIHRoZSBPUFRNRU0gbGltaXQuIEhvd2V2ZXIsIGlm
IHRoZXJlDQo+Pj4+IGlzIGFueSBvdXQtb2Ytb3JkZXIgcHJvY2Vzc2luZyBvciBpbnRlcm1pdHRl
bnQgemVyb2NvcHkgZmFpbHVyZXMsIHRoaXMNCj4+Pj4gZXJyb3IgY2hhaW4gY2FuIGdyb3cgc2ln
bmlmaWNhbnRseSwgZXhoYXVzdGluZyB0aGUgT1BUTUVNIGxpbWl0LiBBcyBhDQo+Pj4+IHJlc3Vs
dCwgYWxsIG5ldyBzZW5kbXNnIHJlcXVlc3RzIGZhaWwgdG8gYWxsb2NhdGUgYW55IG5ldyBTS0Is
IGxlYWRpbmcNCj4+Pj4gdG8gYW4gRU5PQlVGIGVycm9yLiBEZXBlbmRpbmcgb24gdGhlIGFtb3Vu
dCBvZiBkYXRhIHF1ZXVlZCBiZWZvcmUgdGhlDQo+Pj4+IGZsdXNoIChpLmUuLCBsYXJnZSBsaXZl
IG1pZ3JhdGlvbiBpdGVyYXRpb25zKSwgZXZlbiBsYXJnZSBPUFRNRU0gbGltaXRzDQo+Pj4+IGFy
ZSBwcm9uZSB0byBmYWlsdXJlLg0KPj4+PiANCj4+Pj4gVG8gd29yayBhcm91bmQgdGhpcywgaWYg
d2UgZW5jb3VudGVyIGFuIEVOT0JVRiBlcnJvciB3aXRoIGEgemVyb2NvcHkNCj4+Pj4gc2VuZG1z
ZywgZmx1c2ggdGhlIGVycm9yIHF1ZXVlIGFuZCByZXRyeSBvbmNlIG1vcmUuDQo+Pj4+IA0KPj4+
PiBDby1hdXRob3JlZC1ieTogTWFuaXNoIE1pc2hyYSA8bWFuaXNoLm1pc2hyYUBudXRhbml4LmNv
bT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVGVqdXMgR0sgPHRlanVzLmdrQG51dGFuaXguY29tPg0K
Pj4+PiAtLS0NCj4+Pj4gaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5oIHwgIDUgKysrDQo+Pj4+
IGlvL2NoYW5uZWwtc29ja2V0LmMgICAgICAgICB8IDc4ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0NCj4+Pj4gbWlncmF0aW9uL211bHRpZmQtbm9jb21wLmMgIHwgIDMgKy0N
Cj4+Pj4gbWlncmF0aW9uL211bHRpZmQuYyAgICAgICAgIHwgIDMgKy0NCj4+Pj4gNCBmaWxlcyBj
aGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4+Pj4gDQo+Pj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2lvL2NoYW5uZWwtc29ja2V0LmggYi9pbmNsdWRlL2lvL2NoYW5u
ZWwtc29ja2V0LmgNCj4+Pj4gaW5kZXggMjYzMTlmYTk4Yi4uZmNmZDQ4OWM2YyAxMDA2NDQNCj4+
Pj4gLS0tIGEvaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUv
aW8vY2hhbm5lbC1zb2NrZXQuaA0KPj4+PiBAQCAtNTAsNiArNTAsMTEgQEAgc3RydWN0IFFJT0No
YW5uZWxTb2NrZXQgew0KPj4+PiAgICBzc2l6ZV90IHplcm9fY29weV9xdWV1ZWQ7DQo+Pj4+ICAg
IHNzaXplX3QgemVyb19jb3B5X3NlbnQ7DQo+Pj4+ICAgIGJvb2wgYmxvY2tpbmc7DQo+Pj4+ICsg
ICAgLyoqDQo+Pj4+ICsgICAgICogVGhpcyBmbGFnIGluZGljYXRlcyB3aGV0aGVyIGFueSBuZXcg
ZGF0YSB3YXMgc3VjY2Vzc2Z1bGx5IHNlbnQgd2l0aA0KPj4+PiArICAgICAqIHplcm9jb3B5IHNp
bmNlIHRoZSBsYXN0IHFpb19jaGFubmVsX3NvY2tldF9mbHVzaCgpIGNhbGwuDQo+Pj4+ICsgICAg
ICovDQo+Pj4+ICsgICAgYm9vbCBuZXdfemVyb19jb3B5X3NlbnRfc3VjY2VzczsNCj4+Pj4gfTsN
Cj4+Pj4gDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvaW8vY2hhbm5lbC1zb2NrZXQuYyBiL2lv
L2NoYW5uZWwtc29ja2V0LmMNCj4+Pj4gaW5kZXggOGIzMGQ1YjdmNy4uMjJkNTljZDNjZiAxMDA2
NDQNCj4+Pj4gLS0tIGEvaW8vY2hhbm5lbC1zb2NrZXQuYw0KPj4+PiArKysgYi9pby9jaGFubmVs
LXNvY2tldC5jDQo+Pj4+IEBAIC0zNyw2ICszNywxMiBAQA0KPj4+PiANCj4+Pj4gI2RlZmluZSBT
T0NLRVRfTUFYX0ZEUyAxNg0KPj4+PiANCj4+Pj4gKyNpZmRlZiBRRU1VX01TR19aRVJPQ09QWQ0K
Pj4+PiArc3RhdGljIGludCBxaW9fY2hhbm5lbF9zb2NrZXRfZmx1c2hfaW50ZXJuYWwoUUlPQ2hh
bm5lbCAqaW9jLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBibG9jaywNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+Pj4+ICsjZW5kaWYNCj4+Pj4gKw0KPj4+PiBT
b2NrZXRBZGRyZXNzICoNCj4+Pj4gcWlvX2NoYW5uZWxfc29ja2V0X2dldF9sb2NhbF9hZGRyZXNz
KFFJT0NoYW5uZWxTb2NrZXQgKmlvYywNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+PiBAQCAtNjYsNiArNzIsNyBAQCBxaW9fY2hhbm5l
bF9zb2NrZXRfbmV3KHZvaWQpDQo+Pj4+ICAgIHNpb2MtPnplcm9fY29weV9xdWV1ZWQgPSAwOw0K
Pj4+PiAgICBzaW9jLT56ZXJvX2NvcHlfc2VudCA9IDA7DQo+Pj4+ICAgIHNpb2MtPmJsb2NraW5n
ID0gZmFsc2U7DQo+Pj4+ICsgICAgc2lvYy0+bmV3X3plcm9fY29weV9zZW50X3N1Y2Nlc3MgPSBG
QUxTRTsNCj4+Pj4gDQo+Pj4+ICAgIGlvYyA9IFFJT19DSEFOTkVMKHNpb2MpOw0KPj4+PiAgICBx
aW9fY2hhbm5lbF9zZXRfZmVhdHVyZShpb2MsIFFJT19DSEFOTkVMX0ZFQVRVUkVfU0hVVERPV04p
Ow0KPj4+PiBAQCAtNjE4LDYgKzYyNSw4IEBAIHN0YXRpYyBzc2l6ZV90IHFpb19jaGFubmVsX3Nv
Y2tldF93cml0ZXYoUUlPQ2hhbm5lbCAqaW9jLA0KPj4+PiAgICBzaXplX3QgZmRzaXplID0gc2l6
ZW9mKGludCkgKiBuZmRzOw0KPj4+PiAgICBzdHJ1Y3QgY21zZ2hkciAqY21zZzsNCj4+Pj4gICAg
aW50IHNmbGFncyA9IDA7DQo+Pj4+ICsgICAgYm9vbCBibG9ja2luZyA9IHNpb2MtPmJsb2NraW5n
Ow0KPj4+PiArICAgIGJvb2wgemVyb2NvcHlfZmx1c2hlZF9vbmNlID0gZmFsc2U7DQo+Pj4+IA0K
Pj4+PiAgICBtZW1zZXQoY29udHJvbCwgMCwgQ01TR19TUEFDRShzaXplb2YoaW50KSAqIFNPQ0tF
VF9NQVhfRkRTKSk7DQo+Pj4+IA0KPj4+PiBAQCAtNjYzLDEwICs2NzIsMjYgQEAgc3RhdGljIHNz
aXplX3QgcWlvX2NoYW5uZWxfc29ja2V0X3dyaXRldihRSU9DaGFubmVsICppb2MsDQo+Pj4+ICAg
ICAgICBjYXNlIEVJTlRSOg0KPj4+PiAgICAgICAgICAgIGdvdG8gcmV0cnk7DQo+Pj4+ICAgICAg
ICBjYXNlIEVOT0JVRlM6DQo+Pj4+IC0gICAgICAgICAgICBpZiAoZmxhZ3MgJiBRSU9fQ0hBTk5F
TF9XUklURV9GTEFHX1pFUk9fQ09QWSkgew0KPj4+PiAtICAgICAgICAgICAgICAgIGVycm9yX3Nl
dGdfZXJybm8oZXJycCwgZXJybm8sDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiUHJvY2VzcyBjYW4ndCBsb2NrIGVub3VnaCBtZW1vcnkgZm9yIHVzaW5nIE1TR19aRVJP
Q09QWSIpOw0KPj4+PiAtICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4+Pj4gKyAgICAgICAg
ICAgIGlmIChmbGFncyAmIChRSU9fQ0hBTk5FTF9XUklURV9GTEFHX1pFUk9fQ09QWSB8DQo+Pj4+
ICsgICAgICAgICAgICAgICAgUUlPX0NIQU5ORUxfV1JJVEVfRkxBR19aRVJPX0NPUFlfRkxVU0hf
T05DRSkpIHsNCj4+PiANCj4+PiANCj4+PiBUaGVyZSBhcmUgb25seSB0d28gY2FsbGVycyB3aGVy
ZSB0aGlzIHBhdGNoIGhhcyBhZGRlZCB1c2Ugb2YNCj4+PiBRSU9fQ0hBTk5FTF9XUklURV9GTEFH
X1pFUk9fQ09QWV9GTFVTSF9PTkNFLg0KPj4+IA0KPj4+IEJvdGggb2YgdGhlbSBhbHJlYWR5IHNl
dHQgUUlPX0NIQU5ORUxfV1JJVEVfRkxBR19aRVJPX0NPUFksIHNvDQo+Pj4gdGhpcyBjb2RlIGJy
YW5jaCB3YXMgYWxyZWFkeSBiZWluZyB0YWtlbg0KPj4+IA0KPj4+IElPVywgdGhpcyBuZXcgUUlP
X0NIQU5ORUxfV1JJVEVfRkxBR19aRVJPX0NPUFlfRkxVU0hfT05DRSBsb29rcw0KPj4+IHBvaW50
bGVzcy4NCj4+IA0KPj4gVGhlIGludGVudGlvbiBvbiBhZGRpbmcgUUlPX0NIQU5ORUxfV1JJVEVf
RkxBR19aRVJPX0NPUFlfRkxVU0hfT05DRQ0KPj4gd2FzIHRvIGxldCBjYWxsZXJzIGRlY2lkZSBp
ZiB0aGV5IHdhbnQgUUVNVSB0byBzaWxlbnRseSBmbHVzaA0KPj4gYW5kIG5vdCB0aHJvdyBhbiBF
Tk9CVUZTLg0KPiANCj4gVGhpcyBkb2Vzbid0IG1ha2UgYW55IHNlbnNlLiBzZW5kbXNnIG1hbiBw
YWdlIHNheXMgdGhhdCBFTk9CVUZTDQo+IGlzIG5ldmVyIHJldHVybmVkIG9uIExpbnV4IG9yZGlu
YXJpbHkuIFNvIEFGQUlDVCwgdGhlIG9ubHkgdGltZQ0KPiB3ZSdsbCBzZWUgRU5PQlVGUyBpcyBp
ZiB3ZSB1c2VkIE1TR19aRVJPQ09QWSBpbiB0aGUgc2VuZG1zZw0KPiBpbnB1dC4gVGhlIE1TR19a
RVJPQ09QWSBmbGFnIGZvciBzZW5kbXNnIGlzIG9ubHkgc2V0IGlmIHdlIGhhdmUNCj4gUUlPX0NI
QU5ORUxfV1JJVEVfRkxBR19aRVJPX0NPUFkgZmxhZyBzZXQgaW4gdGhlIHFpb19jaGFubmVsX3dy
aXRlDQo+IGNhbGwuIFNvIGFnYWluIFFJT19DSEFOTkVMX1dSSVRFX0ZMQUdfWkVST19DT1BZX0ZM
VVNIX09OQ0UgYXBwZWFycw0KPiB0byBzZXJ2ZSBubyBmdW5jdGlvbmFsIHB1cnBvc2UuDQo+IA0K
Pj4gUmlnaHQgbm93IGl0IGZpdHMgZm9yIHRoZSBtaWdyYXRpb24gdXNlLWNhc2UsIHNpbmNlIG1p
Z3JhdGlvbiBpcw0KPj4gdGhlIG9ubHkgY2FsbGVyIHVzaW5nIE1TR19aRVJPQ09QWSBpbiB0aGUg
Zmlyc3QgcGxhY2UsIGJ1dCBpbiBjYXNlDQo+PiBzb21lb25lIGVsc2UgZGVjaWRlcyB0byB1c2Ug
TVNHX1pFUk9DT1BZLCBhbmQgd2FudHMgdGhlIHJlZ3VsYXINCj4+IHNlbWFudGljcyBvZiBhIHdy
aXRlLCBpLmUsIGV4cGVjdGluZyBhbiBFTk9CVUZTIG9uIGEgc29ja2V0IGVycm9yDQo+PiBxdWV1
ZSBwaWxldXAsIHRoZXkgbWF5IGNob29zZSBub3QgdG8gcGFzcyB0aGUgZmxhZywgcmF0aGVyIHRo
YW4NCj4+IGxldHRpbmcgUUVNVSBkb2luZyBpdCB1bmNvbmRpdGlvbmFsbHkuDQo+IA0KPiBUaGlz
IHBhdGNoIHdhcyBwcmV2aW91c2x5IGFkZHJlc3NpbmcgYSBmdW5jdGlvbmFsIGJ1ZyBpbiB0aGUg
Y3VycmVudA0KPiBjb2RlLiAgU2F0aXNmeWluZyBhbnkgbmV3IHVzZSBjYXNlIHNob3VsZCBiZSBh
IGNvbXBsZXRseSBzZXBhcmF0ZQ0KPiBwYXRjaCB3aXRoIGp1c3RpZmljYXRpb24gaW4gdGhlIGNv
bW1pdCBtZXNzYWdlLCBhcyBhbnkgc2luZ2xlIGNvbW1pdA0KPiBzaG91bGQgb25seSBhZGRyZXNz
IDEgcHJvYmxlbSBhdCBhIHRpbWUuDQoNCkFjaywgSSBzaGFsbCBkcm9wIHRoZSBmbGFnIGluIHRo
ZSBuZXh0IHJldmlzaW9uLiANCg0KDQpyZWdhcmRzLA0KdGVqdXMNCg0K

