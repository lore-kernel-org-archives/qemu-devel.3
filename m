Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD7D0D152
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXof-0005dQ-Nf; Wed, 07 Jan 2026 12:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vdXob-0005bz-0z
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:59:25 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vdXoY-0000MX-JH
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:59:24 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 607DNNIL2521337; Wed, 7 Jan 2026 09:59:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=L1tU9V71zs2L8kRPwCg5VcDZ6iZiT/DJYTtLUzH3Q
 Ig=; b=XPsQQ7JgD8aPQ6MgIkqNb7FkwFsTVnRCvCMyaFeusDoAnBZb1hH30BlxF
 +n1RRFhbfMQW8WacnzIjhEudCDvQqYDb0sFxeo+i4W5UNpC3Q77QD43a/MdhJyLt
 EVT6Dfr1QL0/Yt89eGtZKDYdapjPPAkYQos94vlacEDl3tUuk51xGL2pjWJXYKs9
 JFndVY7ic2dgTBmTiBhoXAPE+mrJiDlmB8ql5U+ci6TB3z5hOmqhOpFSiNl4xYu1
 8bppqGgCjmMdSqJoCbGyPQDUXrHP8K/AWZG938iWxPLof7ndrWewl6OtW5Cv6WRB
 rW2kkrOiZmkq+6xGUw96IO9DV8e+g==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022075.outbound.protection.outlook.com
 [40.107.200.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4bh5u8k72t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 09:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD3aTGaSoLnZ8v3Z+ZxEq7GxPv9DjmJfYM4WZSBO6IM56GtRD8+Dyxwkp7Bj7bEsWiFrmn0GeNPumFs3P307CQJPHq89fq3jkIvvHbBDJrdJm7eWpFIbfwcXLDSN4kmCC4/2ORMmRuPSDF4B3ZtgKCZ+9yzSku+vDlyHFbfLVNgnSkWU/M4xMopuhpf8hL6v+CcVo4JwQugklh/Y3hxKuZeEvE7quiDb8Vpm1ZFY5YmF8vERf7jbRoo8jpbFvKgiNrhQFbrtlGgW7vMkKOdwdVtadA6IsxGS7kwM0g62Ebzg/pCzERV4ZT/WbI9VxhIgVb5AwnpyOKR9r0licpJXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1tU9V71zs2L8kRPwCg5VcDZ6iZiT/DJYTtLUzH3QIg=;
 b=mrNwKFq8oTTsYQjCJIljYYYvZGokZvztX3K6ZmdBuqRsgcdZY3nGHzmJ8xL0vkjQX8KnlV5Zp+xmYMKChWFk6fNXeH0wg8tooAXFHmmhq99R0NWcYFQZE/sT2b4ki05V3CcpUJ7BiFyrkRYsmrmNcvh5cYWOxg4Lnyg8n3S4AL0fzqm7qWTWiFoVqbOSvMTjIN5lpltGtFkOIF+kWsJfOmabD2alt1ximlac8zLusoKFIZ8KI3jZVmoyL/y7Eiisc+eWCBV10IiSleWUby29BsyOCYCBBYKIJ7B5/xjEdqKLgd8RsxHRr+jXrnARFqPCASEkQ4Efydkti8ljOxr8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1tU9V71zs2L8kRPwCg5VcDZ6iZiT/DJYTtLUzH3QIg=;
 b=tFYsmhagJsYvpvMCu66eKmQS5c+RS+pAXubOI+KzCLz43mbHIF5O/D2s88CB5ypSWbpxOAYTgfq6PMZ1nmG2Fdh7/KWkKSvbsnMT33olOV3K2bH3Eeh0fTCXaFv333LEbpJZm89brcJF2psnOnZq0h7nji56YURhgt5UNWqlLUPuQPCjVME+QlHK9mA3igdrmkCsrKYsQNF6VVaXvbbR9tdw8NPeD58LIob6IL0JFtnf/ESq+oRsHI9N1kSPobwPF2nftmZW03+7So3viYq4GZ3UyA6zT/UdH5w+A3AFPdcFf2fBoDJL+3dSq0aETh0v9StXNEOKUMiq4FtATronmw==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by DS1PR02MB10466.namprd02.prod.outlook.com (2603:10b6:8:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 17:58:59 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8%4]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 17:58:59 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: Corey Minyard <corey@minyard.net>
CC: "philmd@linaro.org" <philmd@linaro.org>, "minyard@acm.org"
 <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, Jonathan Davies <jond@nutanix.com>
Subject: Re: Re: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Topic: Re: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Index: AQHcflvnhI83B+K27EGlWAg0SVR8l7VD9QYAgAMMfAA=
Date: Wed, 7 Jan 2026 17:58:59 +0000
Message-ID: <20260107175747.2632041-1-yunpeng.yang@nutanix.com>
References: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
 <aVwP3MZtoHoEa3p1@mail.minyard.net>
In-Reply-To: <aVwP3MZtoHoEa3p1@mail.minyard.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|DS1PR02MB10466:EE_
x-ms-office365-filtering-correlation-id: c2ab08b0-c7d0-466b-2330-08de4e166f07
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SVR6a1RYOXdQZ0NmcDR5KzVlTUJNeGU0ZlAyWHF2bzhPWWJpdDB0bGVwTzVp?=
 =?utf-8?B?QnBYNC9pK3JScHk2bU52OHlWa01GZ2kva1MrZ2RobzZFenRCd3RETWRWMkc1?=
 =?utf-8?B?V3Zmc21LNlFzYml0enI2WkJlR0lZMGZhZHIzekd2L1FZZGZ5eE81RXp5Y0lM?=
 =?utf-8?B?RVJ0UGQ2eFBpVFcyT1dTQU5weW1ValI5YnRlWUxpeDFTbFlTbThsWWViYThp?=
 =?utf-8?B?NG1PNng5aTEyY2FNbXpGeHFNQWRJVDJDNEVxdzM1clNnUGVyeWQ4VGFSN2ZE?=
 =?utf-8?B?VzlZZUZRUjFRZ1h6cDZBY25SeEhZUGlOVGRCUUxXRm9yYVFXMXN0NHNpelE3?=
 =?utf-8?B?QnFXdEJKSGt3S3NyZTFIek9Pamh4YWFFenQ2M3o2ZldxSlJDTWhCQ1oyOFpv?=
 =?utf-8?B?dUQ5SXp3MzJ4dTcvZFd2cEtYK0ZraUlqOUY0M0Q2NTFyQlp3dkY4bWR5Rzdq?=
 =?utf-8?B?ZEdMZW9ZVkliTmhLcXJTWEx6Q0l4d01KdTZRSlladjBjbjk4L2pMdDB3bG9B?=
 =?utf-8?B?S1BmbnNZeW1EbjJITGZ6SkdUQXYxRGFqYW9kNHdsSHBtMk5oQWVkQkRUckdm?=
 =?utf-8?B?M09OUmhDaWJUTHh0ZmdaN25sLy9pT2dVaUhFZm9hRis2S29IQVpNRS9yVk1h?=
 =?utf-8?B?UjFzSWs3c0pyZkdNdVpGc1Q4aGJ3RlZnaXlzTEtnYXJkWkRiejBOcG50U2pQ?=
 =?utf-8?B?ajBuVE12MVdUWGkwYzZ0N1lyNFJWcUlLb2JzRFBFYjRGS2g5TVZlQUwxQ0xj?=
 =?utf-8?B?bU1GZE9ZcnJSZTM3cEt4akNST0FDejhEU2hJWm9yWGUzT3FuSlRsMnVQeXcy?=
 =?utf-8?B?L3JLVlplZVZDRzNJa0I0c3ZraVZaNk4xUjhBM0ZiZ0ZBaUZqQVZ3QUp4SCtG?=
 =?utf-8?B?L0UrV0hPeVpCdWlGVGs3UkliQlBPN1NaQjJSMHV3TTdPcjJXWWVsaC9OUGw5?=
 =?utf-8?B?dUExR09BZDAxaEZLWTVuOHFBZUJyd2J2UEw2d2x4TkE4VklQRFRWeEZWWEp0?=
 =?utf-8?B?TElrOHQ4cW5LNldWcFZ5ME9lbTE5ZGFWTGlIbUtjZjZRQjF1R25PM2dEVHpP?=
 =?utf-8?B?VXBOTWwreWkySjRra29wMDM0NFBSdkxvVGZrYVZzK2lIby9iQ04weWF1T0I1?=
 =?utf-8?B?NUJxWVlTRnRjSWd5V25WTG0vbWI3dGNORmxRSWpsTHZjdndON09jaUx5ZERs?=
 =?utf-8?B?d011QjFtQWxuMmRacDJiYm9WbWNDL2E2WDJZcC8vZi9BR1VKczJVTHFSTWVh?=
 =?utf-8?B?RzdtSnNGeENCVE5IOUV3cFRLV0Z0c2hqUExtZEJMT3Y5MGZUeE1uSVEvRWJ6?=
 =?utf-8?B?ZXMyOTdNZEF1VU1ZNThucERpdkEwZStYZk0wK1JyUW5NQ3ROQlo3bkhrZHdE?=
 =?utf-8?B?L09OVmVwZFdnTmM2UGJXbkZlN3JJcTdBNkdYM0RjUFB2TjRwMjFWZllDYWs4?=
 =?utf-8?B?MjI1MHFaUlRTQnZybkswR0JFNDdKUG9BdVZ0UTRVbSs0OUpLUmNpRHpRcHlh?=
 =?utf-8?B?aDVjNWFMM3U5dXo2K2tqbmZVdWNIcVdFQldtblpDVTl1MnRnazZQanBlS0gx?=
 =?utf-8?B?QlE0bHhZSXQ3MTU4eEZLeS9LRnRqZWYzWWtWeHZPQ1pBeUc5K2hDL0pYTW5W?=
 =?utf-8?B?b2pjV3Rta3BxVml1R1oyanNqb1FuVXcwWFpKQnhJbUlqVk9lWC92QzR4UjN1?=
 =?utf-8?B?d3R6d3ZONVl2dm1aK2Z3eTBIeFBqOFdadk50RHhIQlBnNHZUTnFTOHRDRm1t?=
 =?utf-8?B?U1VlMWp0ZFZ1T1B1citNR3FUb3QrZ2hNQktmNmY2NnZKMDFPN25rSE1LSmp1?=
 =?utf-8?B?Nk5vVlhqclNCOW5mMzBzejRVQThUSnI3N3ZUTGtzWHR2dVBZaGVKbjVaQm9W?=
 =?utf-8?B?Y2Y3MUpQb0NlZllmMExFUlZ5KzRpV0t5QzFJT2huSlpiNzBRQkZZM3RoOFRT?=
 =?utf-8?B?RGZhZ3YzbUd2MTc0ZkMrdy85Q2NQN09XTjlBd1VHR0NKWTRnZVhWY2dhQ25i?=
 =?utf-8?B?cnJKU2hYV0hNb01hRHlYY1h1TjViNjJhVTNpbW5ZQk5HMzRDUUlmRFlhRXdK?=
 =?utf-8?Q?UWzn3P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTFwMTM4L2F5dzFvMXVXaEhSbWdyVUhxb0dwYmphU2lHWTVKYkJvQkhZZzBa?=
 =?utf-8?B?WTFmcGl3MzdlRS9iY3RsbUVZODFKbkdaTURRS1FCN25VU2NkY2wyZFlMblZl?=
 =?utf-8?B?NytLK3YxM2ZhcTlXU3A0WGp6dFlXcVdFNWc3Z2FyTHV2UGdXNHV0T0JzZUpL?=
 =?utf-8?B?VHNsbUVPTWdpWVh3ZnJKYTFBaVZnOGdaRjNLSDZ3R0ozTnFkSS9VdTNLa1NC?=
 =?utf-8?B?cjV5cHBGcU9ZVDNJSktTUUZmMUg1dFFxcnIzcVNmUHJ0NmV2ZTdnZXE5bGw5?=
 =?utf-8?B?NnhJR3k5Q1k5eUt4QUp0ZG43TGRiOXlpWEkwczRpK0d2bHZyN3NBb2JnVS9p?=
 =?utf-8?B?dHVWZFZDeFA3bWY5cVNlL25zMUhaMU43SmNKaGMxWEoveGVqb2h4MUNjUVdo?=
 =?utf-8?B?RmRBVjlOaUJCamtJUVduQmpwbVh1NzczNWFJQ2pUdDdqV2s4cE1UNXpJUDNB?=
 =?utf-8?B?NDhVZUg2MGM2WFcwQkhJcC9kTXpUaUdNaWovL3NKa21vNVVvSTYxeTJ2YnRZ?=
 =?utf-8?B?QmVBakdrOFc0VE1lMkNGcktGVXRjMVBucFNENFZtTkJKSnY5VEtIWHJodDVR?=
 =?utf-8?B?SnRyek01RUlYZC9DczI5YWVFb2pNT1pxM0o1UXRqaXNuNnAva1VqQjh6a1Zu?=
 =?utf-8?B?VDVLb3dzT0tPLzZaOVc3N2NWQjJQU2RWYW56a1RweGg4V1ZOekJmOElBZURM?=
 =?utf-8?B?cjFLUHVrcUlZeWx6TW9WM2c3NVhNMVZjVVVvRjM4WGNvUVU3WGl2ZmtUUnV2?=
 =?utf-8?B?L3QyMzN4TUg3QmphTnhiUG41N1dpTmxEMDlDL1ZJQ05oUk1TN3Q0cVFWUFRv?=
 =?utf-8?B?bHQ0V3pXODFSVVpHUVhCUjR4dVQzczhOR01VTFRka2Q3MGRabVVRR3NJc3Rz?=
 =?utf-8?B?SExyR0xKU2wrZHVaOFpRTElPU0ZsWnNnNEU2b29uRzJqUFBFQzlNVEoydk9D?=
 =?utf-8?B?QUtEWFVHM3l6VHJxMjA1NWMwWXpDTVExWmlUSGlLQUJJcjY0VTBCMWRaSFRv?=
 =?utf-8?B?d1BhWHFSMFpBSzF1bGpOaTBCZjZCYjhDZ2JHdzJsRWR4MWJBSU1UUXFzVHpO?=
 =?utf-8?B?MTFSZnYvaFM2ZzFRbkY4amdtQllmOHl0WUl1ZFRxc1BZMDRnQnBJdkwreGY4?=
 =?utf-8?B?QVplZGgvUEZqTjRXdC9NZmhpMVJsM1FwNkVMeTdKd2ZVeDRUVHorRjZkMDN1?=
 =?utf-8?B?OGpnK09uYldveGxPWVhuNVNTT1g5cUxMekRPMTZjR0kxQkE5YVNFdFJhd2ky?=
 =?utf-8?B?TWw5aGhyb2t3UHZScGtOZElHMHZLQUljeVc3Nm1lQkZMT3FLOGZxZ1Y5Z3FO?=
 =?utf-8?B?QlBZSTYrL0xFV1hXUGtGQXMrbUExMUdJVVN4WnFjS1RYVTZMQ3l3RXNYeUEr?=
 =?utf-8?B?T1dWRkVwYVUwMlhpbndTRTUzN296UVhVeng5cXphVUUvSGRXTGU4RGg1Qm51?=
 =?utf-8?B?ZXozaS9Sa1RJOVJSRWFLUisram1mZmhhWU5mZEQxSmFOZ3ZkTGRlZTF3UEZt?=
 =?utf-8?B?SkUwaDRXMmpWblJGV2ZoR3R0QXk5MGVxaXFYTEJPaVV5cFp2SFRURHdUZXFx?=
 =?utf-8?B?WmFLU2dIS2dCVitJbjhSam03dTVJeTRlS0xucXY5V0ZuRmQ1cUNMcCtXMnhl?=
 =?utf-8?B?UDdvbDJCbjl2ZG44Z3l5SGN6c0F2OHNBUUxMOUxLRWtpbUhlNTlUUXJYa0VO?=
 =?utf-8?B?QjlFb0Z4cWFORDlEWU9MVThBNGgyL1k3eHNqZ1VmOVNIVFAwWW5adUlVQ0Qz?=
 =?utf-8?B?VmExVTZORnQ1OEVsZmNXbGVLTjRXZVl2ODFhMUdranVML2o3YnJjL2QrOUpz?=
 =?utf-8?B?TWlTTllieDFHVmJMdHBxcExYL2svUFpPajhEMWVaT0NMOHVVZkJJdmN6Ri9t?=
 =?utf-8?B?bzlGcDczSFZnTUM2MCtUSDhlN2hRN2hST3l2QWQyWGdQdXZaSHJLaU9Ecmdn?=
 =?utf-8?B?RitMTWJZZVkva1ZRTFkybk5NeWtlYUZzZTJRWk85R2gzdHNnc3VSWVkzQ1JT?=
 =?utf-8?B?WVYwdXJESWljNkoyLzEwQStnZjZZUmR0bHNDN1NUaWVaM0Vkd2d2Rm90clhr?=
 =?utf-8?B?MUxheXJtRUNpL1ZUYVhnQ2xOem1OTGg2V0JoNGgrd3VjTkdpUFpUczVjWEpD?=
 =?utf-8?B?KzdGYWJtZW5tNFdqaVZMb1NvNytqc1hGaVdqd21SVGhtN3VyVlg3YldkSW80?=
 =?utf-8?B?WnQ3N2twZlZDZ2ZPWmk4MC9udUZXNXFCVWhpSlpjTlZzekwyTEJpUFZjSzJn?=
 =?utf-8?B?d3hFRGNieGFmbW9LbUhraTYxODAyZFdtVXhFcjVuR2VtNTd0dTcrNm94aWpi?=
 =?utf-8?B?Tnk1OXNtMFZXSXN0QnJ2eEtSVFNMZGQ5S3ZYZ29jd05zOXBiY20xcVY0L3JL?=
 =?utf-8?Q?Md+TpcT6uH9jgFM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4535BCEF98BC428D8C5A93412370BF@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ab08b0-c7d0-466b-2330-08de4e166f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:58:59.1785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hq05j2ZPkUF0H+T/ehF1017C0GS8h+68MO/mnJl2K1oaZ0RC63eUyO1BUgpDCGfQL47WzTUbuiOKqNC2U7hABoCepf4rggnCl1t3NYJrcuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10466
X-Proofpoint-GUID: CVmr8Lgx5qpPTbHOKJzqjgrZTIC_Rqdz
X-Authority-Analysis: v=2.4 cv=DaMaa/tW c=1 sm=1 tr=0 ts=695e9ee8 cx=c_pps
 a=5czeKszRpWsvzRcawb/TzA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=usQuSVvc5d8xPwxDXMcA:9 a=QEXdDO2ut3YA:10
 a=GtYHaO1xT9IA:10 a=VxR06f_1COkA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CVmr8Lgx5qpPTbHOKJzqjgrZTIC_Rqdz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0MiBTYWx0ZWRfX7I7oikWBg+Ak
 8cPgm9YiDS739gIN5IIadsqRkWf9gHczSyIOIjs+wILdpJpYJc2XmAQ3czRQrmEXebLuATWTVIB
 LHyFxo4rdKfvCDfe10sM7bp1O7s3Z0KVjNMPbKxTf5NJSIggsGt65H+S0ecYEc4lYNKK78sDna/
 cDg1iVawir1q9Vnzwfsvy/FyLpL9PhLynIx9MSqM1Eclk+YHsLesjf2fM4X40wTFEifv1GApXwy
 knd+qvbFJFnbiQ+isb07jdt0sk5IhAtgkUXhYR0rpw9UuUe6t05crXFr83CttE7QV5U5Ba8WL7f
 FR45kBiP6+Eks5/6+/PwQkf5G0SO+T/zMrkDTu2O3WFqDP6wwLfB8QcVNKHyGYTPo/0i8GoQwG/
 41kB8oCbMX8bs+je5+4o5rJiyO6OwlBWd07gEC0Y4UR8CsJ8XOc5cOh8ynpuzv1f1WjSFiAkLEC
 aeS44BQ7xfBEzjHaVZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGkgQ29yZXksCgpUaGFuayB5b3UgZm9yIHJldmlld2luZyEKCktpbmQgcmVnYXJkcywKWXVucGVu
ZwoKPj4gSGkgUGhpbGlwcGUsCj4+Cj4+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cy4KPj4g
SSd2ZSBtb2RpZmllZCBteSBwYXRjaGVzIGFjY29yZGluZyB0byB5b3VyIGFkdmljZS4KPj4KPj4g
S2luZCByZWdhcmRzLAo+PiBZdW5wZW5nCj4+Cj4+Cj4+IHYxLi4udjI6Cj4+IC0tLQo+PiAxLiBg
aXNfdmFsaWRfbmV0bWFza2AgaXMgcmVuYW1lZCB0byBgaXNfaXB2NF9uZXRtYXNrX3ZhbGlkYCwg
YW5kIGlzIG5vdwo+PiAgICBpbXBsZW1lbnRlZCB1c2luZyBgbGRsX2JlX3BgLCBgY2xvMzJgLCBh
bmQgYGN0ejMyYC4gSXQgc3RpbGwgZW5zdXJlcwo+PiAgICB0aGUgbmV0bWFzayBpcyBub3QgYDAu
MC4wLjBgLgo+PiAgICBJIGRpZG4ndCBmaW5kIGFueSByZWxhdGVkIGhlbHBlciBmdW5jdGlvbnMg
aW4gYGluY2x1ZGUvYC4KPgo+SSBjb3VsZG4ndCBmaW5kIGFueXRoaW5nLCBlaXRoZXIuCj4KPj4g
Mi4gTm93IHRoZSBgSVBNSUxhbmAgc3RydWN0dXJlIGhhcyBpdHMgb3duIGBWTVN0YXRlRGVzY3Jp
cHRpb25gLiBJdCdzCj4+ICAgIGxpbmtlZCB0byB0aGUgcGFyZW50IGBWTVN0YXRlRGVzY3JpcHRp
b25gIHVzaW5nIGBWTVNUQVRFX1NUUlVDVGAuCj4+IC0tLQo+Pgo+Cj5UaGlzIGxvb2tzIGdvb2Qg
dG8gbWUsIEknbGwgcHVsbCB0aGlzIGluIHRvIG15IHRyZWUgYW5kIHBhc3MgaXQgb24uCj4KPi1j
b3JleQo+Cj4+Cj4+IExpbmtzOgo+PiAqIHZlcnNpb24gMSBwYXRjaGVzOgo+PiAgIGh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI1LTEwL21zZzA3NTA1Lmh0
bWwKPj4gKiBjb21tZW50cyBmcm9tIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz46Cj4+ICAgaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMjUtMTIvbXNnMDAxMTcuaHRtbAo+Pgo+Pgo+PiBZdW5wZW5nIFlhbmcgKDIpOgo+PiAg
IGh3L2lwbWkvaXBtaV9ibWNfc2ltOiBTdXBwb3J0IGdldHRpbmcgZmFrZSBMQU4gY2hhbm5lbCBj
b25maWcKPj4gICBody9pcG1pL2lwbWlfYm1jX3NpbTogU3VwcG9ydCBzZXR0aW5nIGZha2UgTEFO
IGNoYW5uZWwgY29uZmlnCj4+Cj4+ICBody9pcG1pL2lwbWlfYm1jX3NpbS5jICAgICAgfCA0MTIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+ICBpbmNsdWRlL2h3L2lwbWkv
aXBtaS5oICAgICAgfCAgIDEgKwo+PiAgcWVtdS1vcHRpb25zLmh4ICAgICAgICAgICAgIHwgIDI2
ICsrKwo+PiAgdGVzdHMvcXRlc3QvaXBtaS1rY3MtdGVzdC5jIHwgMTQzICsrKysrKysrKysrKysK
Pj4gIDQgZmlsZXMgY2hhbmdlZCwgNTcyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+
Pgo+PiAtLQo+PiAyLjQzLjcKPj4K

