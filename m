Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5217AC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 01:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHuPm-0000lG-Of; Wed, 21 May 2025 21:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uHuPj-0000kz-8o
 for qemu-devel@nongnu.org; Wed, 21 May 2025 21:08:03 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uHuPg-0000GJ-N8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 21:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1747876081; x=1779412081;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ADYMIfILrncMeS8vOXsy6L6kJgxuVqWBRQB/gUz4XFw=;
 b=hnDZTqD9R5fqY5m8rKBI/kwD8UVnaVSMb5QS67Y9g2GzkfW6235bQ/CP
 LxW7bueXLr0JX+diA0925I+a7ShPuUykQenMfvkCWTFZ7zQLEXkyFEwbR
 QNVXL+9ITm1y1kv6sWfpFy9RwG+k7Bunj61X+kecGIt6Y9tAXBn21pU29
 JXxPHULa3q56qKd9sh01wv/z9DCEgRbtQPnkpzsu/7BKDifhUcEglCkZX
 M99Ji5jUnFMp16NaxLbeTxVAGMvFyeuINHRty8zpQ+XEDMo5+dtNiKvQD
 gzSXzJOt+LWx8Gw+YTt6iVzZu0P29T3kevddhkaldQPcUwaYwKCNWHjeA Q==;
X-CSE-ConnectionGUID: gDK9hwMbQR6lkK0tGpvJyA==
X-CSE-MsgGUID: tKV/YDALSlS3ZFJzWA/gwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="155629413"
X-IronPort-AV: E=Sophos;i="6.15,304,1739804400"; d="scan'208";a="155629413"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 10:07:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndxmgzXiOc0132a5Q+i7hLJ9xJoSneubAPcmUZqb46a3uP44YGrsm8TyItyMU+4ncEZJjd8KbGZOCeJHZPsM5amIJqywvWMuJGqtPMa3H+POY5tYLnYG+/GeAZt/M1Xgw9Xxb4hoc8mTW9qZ1Xiijs2gENBJsZ5nCC2wDpjdj9Sfqrgg83wD5Od1/civMKR1+ps0LonQGxtR/wCb99IzCuCmPKRBu+1utAxy8aIzTnueTTz3l6yNmNTYj6VJnyLrYMTaQkIcncj0D8IOY8StC1gNvuASbW3LPWSbcRwJNZY96wbINs5DgLXAhMmdRf2WjbIG0cSHxdrCq8nE+hsjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADYMIfILrncMeS8vOXsy6L6kJgxuVqWBRQB/gUz4XFw=;
 b=x+7DGWYXJ3c9fFvG7sp1yU/SYclfGujYPitwL+Ec+Fm+dq+MqnPHhu+nZoWaRAO8nlH+/QwBR1bvXoQNy7fRvf0o/7ED4eUARRpIQ0a0tfTd7RummRYMVAPEIXkBhHpiZE0lzICwp1AOGJAayjulXe626Lm/xqntc56SVLdrMHteMcxjKW0e/Ny1/rQD9R2MyYfyIU4EMtM54JNEe1HE0HRDYRjPMnkql3JwEYTP7OmVsJg6OBVWoLabVv2Z7ytyZaYNqbnqGk9reXqZuLXnb29bHHScbPldnBHr+8oy/2+eZLOco1ULFTqcnOhyP60FcjoL7hDWzDaVogQmk4Uijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYYPR01MB13487.jpnprd01.prod.outlook.com (2603:1096:405:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 01:07:53 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 01:07:53 +0000
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Thread-Topic: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Thread-Index: AQHbxQs15uH9M22qoU2fNrKRAYHbDrPczskAgABZVQCAALmtAA==
Date: Thu, 22 May 2025 01:07:52 +0000
Message-ID: <1e22d96a-6ea3-49e5-b759-c1cd5b39cc34@fujitsu.com>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
 <aC3dJvwXK9eW1YO6@x1.local>
In-Reply-To: <aC3dJvwXK9eW1YO6@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYYPR01MB13487:EE_
x-ms-office365-filtering-correlation-id: 6a68ced1-034a-4681-776c-08dd98cd142b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cTRGR01LUnVtbURzNFU2QmVFSFFiNCtaVU53WHBDZkN6NjhkYjZTRHYwSEpO?=
 =?utf-8?B?RW4vcExXZjE4SFVvL29ONmVKM3ZrZFA5SGhiZm9UZU5uM0JiYk51Uko0WTJk?=
 =?utf-8?B?bm5pMkFHV2I0ZmkxNm9odFVkTkxHUG8zZ1FMREI3OWRxbkdCKy8xYzFaOHNO?=
 =?utf-8?B?YW9vWk1xb3M3YWplZmQwSUs0TjdCUXo1SkJrYmU0UmJKNlVLUW9kM3hNclox?=
 =?utf-8?B?b2V1VWFHWDNEWU9IakJJTS9yWlNka3l1M3g0dUFMYXY0V25PblRIS3RmQUhY?=
 =?utf-8?B?N2dqZEFRU3p6VTZNbmZFb0RsZGF2VUNJT1ViUlgrUUpKSlQ5VlVGZHdBdm0v?=
 =?utf-8?B?V1pHUXVkelJodnpOUkFYdU1weWMyVXhrMzVUd1IwZWNheGNQdzJDRWJMWDc5?=
 =?utf-8?B?NWhlS1ZYbWRYNVJXN256MDlscmphOUFzTkx4a2RnVHZjaHNBZHhqUzZQMXc1?=
 =?utf-8?B?TjQ4N041RW1uazFJQkFGMi9iQXhEMzZCKzdERFhGbWp6OEtWWEdJakxXbFls?=
 =?utf-8?B?THRyWk55dGszLzBram1vNVd2dGQ1dmNjWHBkWVRYZlNoWFA3R0ZEaCtHNkw1?=
 =?utf-8?B?V3l1Mmo2VnR3djBGSklQZFdrY25SZnhhS3dVOUFYSGtaOEl4b014R1JwSG1i?=
 =?utf-8?B?MUUzdjhyNzh0RDA1ZmJxUFRUbGZxVm5memo1TUhrSkwwWDB5a29BZVhtL09O?=
 =?utf-8?B?MTNvZkx5ZUh1T0ptb3N6TWMyWXo2dmJhem5MTTV0L3RydmJxTTBxbVpFZU9L?=
 =?utf-8?B?Z1FGS1UzV1VJTWVFdzJtRmtQY0hVRXZkbkRkQ2xaZXJ0U05PQjNSaGdlWXls?=
 =?utf-8?B?L2FrTndueGFXTllDVXVEMTBTYjlXQ2g1Ny96cjAyQTR4QlRidXBJN1MyQ1Jv?=
 =?utf-8?B?ZXpqTFgwdVUvZUUzL0FvR2t0eHNwdFJqbGpnRVpmUWo1dkxVNkdCMkhsaG1w?=
 =?utf-8?B?bW9XU2pTcUI2QzNZS2dhQ014WVdDNWtXdHN0VzhnaHU0MHdSNW1MRTJSa1d2?=
 =?utf-8?B?M0lwcWJjRXJrRWtBSzI3MzNvUXFTWkNmS0s2aXVjUEtDU2xBb2J2RGFmRVZF?=
 =?utf-8?B?N0tvZVV1ZDhKQlhLM3BmWWhIb2lZaVEwUFpwRVNjZUo4TjdlaXdYdDJ1ZStV?=
 =?utf-8?B?OFVITHZXOE9oQm12ZmsyWk9XUVc4L29QREIrNDg1eXZ3dlczREw1bE1CVlli?=
 =?utf-8?B?V3hwZU5pdU1GRnlUT3A4OWFTNUhQeGR5aHc2WjV6V0lFbGV3QjNsQis3SDZG?=
 =?utf-8?B?dDF6SG4yRUE0eXA0eTJtQk1veTRxODh4VzM5cGdQM3RmUUt1cU43Z2trU29a?=
 =?utf-8?B?cHk5dTUvRVAwUHNyMDNPVitaZmo3bkdDYVUyM1hEaERoL0MrTmg4eTdnUlBy?=
 =?utf-8?B?Vk8rK2FwZG5kTDdUNjBHNmRuQVNMWlJWRHhwaTVTVlhjM21QbnVIQlY0bGhS?=
 =?utf-8?B?V21jTytPczI5TzU2bEwxZHR3aFlvNk1YcFNwWDM4RzU0eVBzRmliV0VLNlZP?=
 =?utf-8?B?YWZIS3c5aGF1MTJTM3hNMnJGSDRxSUdjQ2xCbW9nNkFkWjBQMnBEeGVZbnlq?=
 =?utf-8?B?YnJZbDRkNUVKRkdabmZZREpGNkxyR0JFb1d0MStWZWl5Yk5icHEwK2UzSnBJ?=
 =?utf-8?B?dmZLT0owbkxXcy9vTGtFcWx1dVArd3cxQWNMUCswVm8vUm5La21uRjVESVpU?=
 =?utf-8?B?aWZlb2ZkWk80aC9OaWVPQnJJSUxZbnNRMStKSFBvZWt2c3JnRElBRUFZTEhx?=
 =?utf-8?B?SDNIQ1VnTnJLczN5TW5nRXpONkdjSVJWcElianQ5M1Y5eWZnKytDTVJRY3VP?=
 =?utf-8?B?NXhjYW9PWUdWcHlUdUIxRlM4TnVvcTdQSHAzbDVZa3YrTjF5eXcwc0ZIRm1q?=
 =?utf-8?B?UnliWVlHd3JiZVA0ZDZGL2NyZzdHZis5aWFEdC9PbWxSeGZJTUp3aDBMZ0tC?=
 =?utf-8?Q?4WlIwIP0bfHVJEb5t+DjSZW04ubHegIb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkZsaWczQlpNZ0p6MW81WWprQ2VML1RLQ3IwNmtXd0lEZkxleXNlQXNjQWdl?=
 =?utf-8?B?VDk4bFpEWmJudEFXTk8yWU1PNXp4SmtremRmWGUzSEN4aGlSc3hDcUViOHNt?=
 =?utf-8?B?cjE3S3Z4QmxrVGdCWVd5Rk8ydkNQRE1iQU9ZTFpvOVI5TEhad1JXb2M5ZzRO?=
 =?utf-8?B?REFrRUdQeENJbW5oVCtHNld6QnBEaWY0QVAydDlzcGtLK1BEQjhMQll4RnZ4?=
 =?utf-8?B?YVAwV2JaT2JCdkY1bC9QMlh5TEdQWjRoTEh5ejJGdkQ0dElTWFpua3RnMWRW?=
 =?utf-8?B?b2FwRFJ3TWExTTRKVkZ0cnZja05QQmhsQXlGYVFmTjF5SmFwdFcyV05rV1VE?=
 =?utf-8?B?bmozc1VnUDRlRkEvemRtK2dkQXZ6d3hNY2xaQWJUd29ua0xOWGRkckNSR0JV?=
 =?utf-8?B?eXZ2RWw3N2lRRDc0STBkNFE4NU9IQVpDMWdYTkdEc0g4dys4b0FEOVY4Ym5t?=
 =?utf-8?B?blUrZ2hDQ0RuT1FRdlJvRzVaMCswVS9uTjluZEhPNUFqTVdGU210OVRrTmFs?=
 =?utf-8?B?d1BGQ29maU5mYytTMVdSZCtmSlVjUVZvUlZZdFlhMGIxMHBpZmF4NnNFRmVO?=
 =?utf-8?B?TzBUbGxzRHV2VWVEUU80NE1tRE4vNHBRWm15a1Jzank5SkxqYnpyVVU0SWwy?=
 =?utf-8?B?SkNlNElCcCtpdVBmM29DNFZqZWpzYUlSMWdCTDJnSTFyYUt3VTFnSUszbm5r?=
 =?utf-8?B?YzA5OWNmcXl2a0JZS3l3ZG5Sb0dsS2JRVlc4U3ZkbjRETUpKVXRleE1pc1p2?=
 =?utf-8?B?ZFp0WFFNYnZYMXFHU2cwcDZiMlZ0YlpVeFNVZ1VPQndIWEdEZlFWVEFIM2tP?=
 =?utf-8?B?a01oWGlCZTdyaXVjMkxDK0trWVVDL3BuaEp0bm5Zb3R5K0pnTlFjVFdDbzBk?=
 =?utf-8?B?Q3NFRXB6WUJVWHJPdHZJWVlsR28yVS9lUTkvYmgrZVpQckVIenBQUS9PczVS?=
 =?utf-8?B?TW1wdHFSN1BlM2VMdm5haE5BZWN3SWdWWjBVeDdnbFRPRW9rTzRaNEJoSnRJ?=
 =?utf-8?B?YVRYRTZhUW5UZlZmVVM3emt1WWg0c295MVJ6MVdPNDFkUGVRM1Z0WHhEWUNI?=
 =?utf-8?B?dEUyS2NZbmFBUjNMTjdFblRLY3ZUUWlFWU1TemZQVnA0RTdnZzd2eVBzR3Nh?=
 =?utf-8?B?QWN6Y1hxTGFBbUd2RUNMYksvV1orcHNYVGlQbUZiVGNYc01CK29HQWh4UWda?=
 =?utf-8?B?NzJ4OWhSR00wNWdEek45dGd3T1oxWXhlL1EzQmVyOWJwUmRkU2RmRUR5WUVQ?=
 =?utf-8?B?LzAxU0FZYnZoUXArSGJFMmdiYnBJTVBkSDJHRzRNdnRQUWFBNGY4a3VyUjRK?=
 =?utf-8?B?V1JkY0JvQXJXVU5MU1dCTjB4UlRyOS9MajE5SUhRZ2g3ZmEycjZNeGc0N0VR?=
 =?utf-8?B?VUdJdWp5bXFqYkhBUUhwdmhWbEgvWHhYY1Zsd1hZZzhrbW51SUdmclE1MGhj?=
 =?utf-8?B?UmxtU2pvSEZDM1QzM0t1SGJWOEVvRDZ3Z2RLRW4rL1lPOE1ScXZPODVBQ2Vl?=
 =?utf-8?B?UFZQZG5TcWxhYVlUcG9NeUIrN0REaDJEeFdGRFdWUUYrMmJlc3gwelFObzJH?=
 =?utf-8?B?dlowUVdLS3RpVEgwaVNocDRFbGhiSEhhQzNtK2oxc0wxOFpkR2N2ODNHRFNv?=
 =?utf-8?B?NzVlbkdEOUo1Q0pqTmxVN0Q1cTBpL2hzeC9pWTIvQVYvYzVOcWxIQ0xkSlo3?=
 =?utf-8?B?WmtjK3JIVjhMZjcyZmV0a0d5cVh2QnhTdXVWOHhxekNEb3hSQjh2Uis5UjVP?=
 =?utf-8?B?b0Q2OWE5VlN4RWFqNWpoT0tHOC91WkhQQXowNUJyWkhKbzFiT0JNcHlObjdS?=
 =?utf-8?B?V3Y0N2JGYW4zbFk1SlZCbFRIeXBnUVNBV2svMEpjc1hNTENHRVFKR2Vleklm?=
 =?utf-8?B?MkpEYmtoR29rKzc2SUVzVytvTXgwSFgwREdhN3lReFVxcWhOaWVPWlFVUGFx?=
 =?utf-8?B?RWpDSHpCazBrTmh2aktBSlorT2RHQ3daQ1ZZb0pQS0N5U1lIL1VoRjRnQWNa?=
 =?utf-8?B?MlZlczhmR0JMUzZ6ajQrNjRYSTZJS084YXdyZWNIeWFzY0Y4RG5YNUlKS2F5?=
 =?utf-8?B?OW1lcldqNTRGVmNvMExJazZhMC9qQkdXTnMzL25Pak5lM0xtYVRRblJNQ0Iv?=
 =?utf-8?B?SmhjalM2eVk5NGRYbS96QWVoS3ZyNUV6Q3U5Z1FvdE9JaUVrNjlmZ013VU4x?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C36D0521EAC4834180C2D6AE0A27A90D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /S6+X3mT4YSitBTt3KzRCoGaKw9Rn8jUWT/AEm14de5yqrHOnEgI//NvgPWXEbJ1DHUe2ogDSIY8lQO+SNVEIz5qX0WRqXhxfDrPpMS2BQ2rgNeSbZMfowc+MiHHOJx8teTjxppY4tZe7C3/sepjiTiX+iD2FFjF25vBlYYE2llaVFuR+OLHFR/+zeY57+oNzQAdy24Llv5xSFSi5pymIdfJCE9CzVXdlLWxRwy8h5+N5Ge7AoEQQIZLkrUb2ESOdQydA3jNUqCnqGpV/6h42wAeDHATt3n4iqLKo+FTc/LXe/D7oDpayFnZcd4l8Wu7mJCVFL0onVWnteXHac61y7r0bCpBgoXlTdPG2xToRCiwftPEFmod7nacW1qrZtB8MR1dpaRpv4EMWJr/bWxpHOHIZyJ1ZQVrH67MJhDisnMXEAQj8IjiaHb+Ea4tyQjHg0pRthfIW66PjQ0/Zlu+WGupAT3KDuyQAn1s4trpSyi+UNwBBsNTmYHP9KgF9lViFemIsw9xw+hVzDLTXSo0UKzUl4gy3kHobJ9l09rSIjLgai7Ro/ak4f1sv0jRjl1yz5snPji5t/ZOTu6sxSYGMDc+B3dyLWqHq+sdv4gCFYbDjmTzti3jAKJcbFZG81Mp
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a68ced1-034a-4681-776c-08dd98cd142b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 01:07:53.0304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0X0r2bRO7Dcbu12cUEIWgeAc0uQFj5hlOfZc1yWdS2JqkFPdl3CimyE8hxzqGeO98sfe8A3i/Djdj5XAJ+iPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13487
Received-SPF: pass client-ip=216.71.158.62; envelope-from=lizhijian@fujitsu.com;
 helo=esa19.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDIxLzA1LzIwMjUgMjI6MDMsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBXZWQsIE1heSAy
MSwgMjAyNSBhdCAwODo0MzozN0FNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToN
Cj4gWy4uLl0NCj4+PiBBZnRlciB0aGlzIGNoYW5nZSwgc2FtcGxlIG91dHB1dCAoZGVmYXVsdCwg
bm8gIi1hIiBzcGVjaWZpZWQpOg0KPj4+DQo+Pj4gICAgIFN0YXR1czogcG9zdGNvcHktYWN0aXZl
DQo+Pj4gICAgIFRpbWUgKG1zKTogdG90YWw9NDA1MDQsIHNldHVwPTE0LCBkb3duPTE0NQ0KPj4+
ICAgICBSQU0gaW5mbzoNCj4+PiAgICAgICBCYW5kd2lkdGggKG1icHMpOiA2MTAyLjY1DQo+Pj4g
ICAgICAgU2l6ZXMgKEtCKTogcHNpemU9NCwgdG90YWw9MTY3Nzc5OTINCj4+PiAgICAgICAgIHRy
YW5zZmVycmVkPTM3NjczMDE5LCByZW1haW49MjEzNjQwNCwNCj4+PiAgICAgICAgIHByZWNvcHk9
MywgbXVsdGlmZD0yNjEwODc4MCwgcG9zdGNvcHk9MTE1NjM4NTUNCj4+PiAgICAgICBQYWdlczog
bm9ybWFsPTkzOTQyODgsIHplcm89NjAwNjcyLCByYXRlX3Blcl9zZWM9MTg1ODc1DQo+Pj4gICAg
ICAgT3RoZXJzOiBkaXJ0eV9zeW5jcz0zLCBkaXJ0eV9wYWdlc19yYXRlPTI3ODM3OCwgcG9zdGNv
cHlfcmVxPTQwNzgNCj4+DQo+PiAoRmVlbCBmcmVlIHRvIGlnbm9yZSBteSBjb21tZW50IGlmIHlv
dSBoYXZlIHJlYWNoZWQgYSBjb25zZW5zdXMuKQ0KPj4NCj4+IFB1dHRpbmcgbXVsdGlwbGUgZmll
bGRzIGluIG9uZSBsaW5lIGlzIGEgdHJ1ZSBuZWVkIGZvciBodW1hbiByZWFkaW5nPw0KPiANCj4g
SXQgZGVmaW5pdGVseSBoZWxwcyBtZSBidXQgSSBhZ3JlZSB0aGF0IGNhbiBiZSBzdWJqZWN0aXZl
LiAgU28gSSdtIGhhcHB5IHRvDQo+IGNvbGxlY3Qgb3BpbmlvbnMuDQo+IA0KPiBTbyBteSBhYm92
ZSBsYXlvdXQgd2FzIHRyeWluZyB0byBsZXZlcmFnZSBtb3JlIG9uIHNjcmVlbnMgd2hlcmUgd2lk
dGggaXMNCj4gYmlnZ2VyIHRoYW4gdGhlIGhlaWdodCAod2hpY2ggaXMgcHJldHR5IG11Y2ggdGhl
IGRlZmF1bHQpLg0KPiANCj4+IEkgZG9uJ3QgaGF2ZSBjb25maWRlbnQgdG8gcmVvcmcgdGhlbSBz
byBJIGZlZWQgdGhpcyByZXF1ZXN0IHRvIHRoZSBBSSwNCj4+IGhlIHN1Z2dlc3RlZCBzb21ldGhp
bmcgbGlrZSB0aGlzOg0KPj4NCj4+IE1pZ3JhdGlvbiBTdGF0dXM6DQo+PiAgICAgU3RhdHVzOiBj
b21wbGV0ZWQNCj4+DQo+PiBUaW1lIFN0YXRpc3RpY3M6DQo+PiAgICAgU2V0dXA6IDE1IG1zDQo+
PiAgICAgRG93bnRpbWU6IDc2IG1zDQo+PiAgICAgVG90YWw6IDEyMjk1MiBtcw0KPj4gUkFNIFRy
YW5zZmVyOg0KPj4gICAgIFRocm91Z2hwdXQ6IDg3MTcuNjggbWJwcw0KPj4gICAgIFBhZ2UgU2l6
ZTogNCBLQg0KPj4gICAgIFRyYW5zZmVycmVkOg0KPj4gICAgICAgVG90YWw6IDEzMDgyNTkyMyBL
Qg0KPj4gICAgICAgUHJlY29waWVkOiAxNSBLQg0KPj4gICAgICAgUG9zdGNvcGllZDogMTM2OTEx
NTEgS0INCj4+ICAgICAgIE11bHRpZmQ6IDExNzEzNDI2MCBLQg0KPj4gICAgIFJlbWFpbmluZzog
MCBLQg0KPj4gICAgIFRvdGFsIFJBTTogMTY3Nzc5OTIgS0INCj4+IFBhZ2UgU3RhdGlzdGljczoN
Cj4+ICAgICBOb3JtYWwgUGFnZXM6IDMyNjIyMjI1DQo+PiAgICAgWmVybyBQYWdlczogMA0KPj4g
ICAgIER1cGxpY2F0ZSBQYWdlczogOTk3MjYzDQo+PiAgICAgVHJhbnNmZXIgUGFnZSBSYXRlOiAx
Njk0MzENCj4+ICAgICBEaXJ0eSBQYWdlIFJhdGU6IDEyMzQNCj4+ICAgICBEaXJ0eSBTeW5jczog
MTANCj4gDQo+IEkgd291bGQgdHJ1c3QgeW91IG1vcmUgdGhhbiB0aGUgQUksIHNvIGZlZWwgZnJl
ZSB0byBzaGFyZSB5b3VyIG9waW5pb24gbmV4dA0KPiB0aW1lICh3aGljaCB3b24ndCBodXJ0IGlm
IGl0IHdhcyBhIHJlc3VsdCBvZiBBSSBkaXNjdXNzaW9ucywgYnV0IG9ubHkgd2hpY2gNCj4geW91
IGFncmVlZCBvbiA6KS4NCg0KVGhhbmsgeW91Lg0KDQpBY3R1YWxseSB0aGUgQUkgZG9lcyBtdWNo
IGJldHRlciB0aGFuIG1lIGluIGFueSBhc3BlY3RzLg0KSSBoYXZlIGRlY2lkZWQgdG8gc3VycmVu
ZGVyIHRvIEFJOikgaHR0cHM6Ly9zeWFyby5pby8xa3N1Lw0KDQo+IA0KPiBJdCdzIGFscmVhZHkg
aW4gYSBwdWxsLCBsZXQncyByZXZpc2l0IHdoZW5ldmVyIG5lY2Vzc2FyeS4gIFRoYW5rcyBmb3Ig
dGhlDQo+IGlucHV0IQ0KDQpTb3VuZHMgZ29vZC4gTGV04oCZcyBwcm9jZWVkIHdpdGggdGhlIHRo
aXMgYW5kIG9ic2VydmUgZmVlZGJhY2sgZnJvbSB0aGUgZW5kLXVlcnMuLg0KDQpUaGFua3MNClpo
aWppYW4=

