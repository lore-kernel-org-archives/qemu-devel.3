Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E960AC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 08:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tztCp-0003FS-K3; Wed, 02 Apr 2025 04:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tztCg-0003Ey-6I
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 04:12:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tztCd-00054P-A9
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 04:12:05 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5324w82C026344;
 Wed, 2 Apr 2025 01:11:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9Gad9/jjpkcqAg88YSmbQ3RdnbYkc4W06aCMAA0Hl
 3w=; b=UTmoGbFZf7tN7zBSRzuYgJH1Z+wdJ9zrVn4kU7s7BbT03UyoKBxWaMi2P
 pyJy1Kz1NRMRKBtc1tyaXzITqqnmDMLOLhPT7cE9UNwHET/b5bEkVvkgj10MpIlj
 Q95kEC54LAVnsJ3A++8gCoLb4J0AfMxe+rNe1lo8MHSHYiAeSM1GiYtiaa2dQERQ
 YH4Rp8X2roWQb/JVdYtgSDTLv747M86QuOcIQ5RlnN0KArANXelHVMNiRp/XwGz8
 inW1Xl6QKCzNkRboKCIeluO4MKZlZaupk+VEXCdsDc3pO63BkWYpSuxUp5xe4H4f
 1OvQw6ghW4MgEtl6DLZd57iheLMzA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011024.outbound.protection.outlook.com
 [40.93.14.24])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45peyhr71r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 01:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEvRw+T9lB1x15j5GStckPVP3QGDiMrIPcNr2Q0qDJxa45FuLQfn/bfyFa+SbR9xHY52bUvFB0icrUURwleKyrFeLpRiNObW9KKMfx1KyGululIH07u536kTlvjHqynsP2LqbT3eZ2gIdZDMV2PCrN4DW24Q7NfU8tDY8F6DazaBvrSPiOXYVer2UNbQnYceJKqgAeEUlJKjAEyYhh7/E5Ecbes9MfE7wO6Kp1Rk7lFqQO4DvMvL2AImYbz5aaU/CpUNyViwv+kXZwY8rcLGlOQqrbUl+mlCH6640xP5moSG1H9KGQ2L9ZW6qXEWH2uvWQMljUifgOrLY9IwRIKWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Gad9/jjpkcqAg88YSmbQ3RdnbYkc4W06aCMAA0Hl3w=;
 b=CYBothBcgs4ARDgwAEZQRSoWKX76aI1+GKbcfe9rELwEm/MPzzywIodurnlvF7HptQZEBkaioI+AAPf62i/n9xXocG4S55vBiiuwn8sfbrlasmSxlSem9IRuWFx5skFhYhf0R/+hQp9T+0QepHcFkGr4ODzNsv8Mt85x6/KtN1sLOm2hOGgr+Hpq5sbB94/Y3gnleOX2Ue4pp3Kgt8pZryAdxD0C17e2rJULks5RK4LxxoYK2nB3WF3N+J5Wf+Q5onuBQ9goyGDt7yYTA1w/qgtAypTPQry+DCtKT660m44gaXqGlp6iPG1y24Zl4zc5IbVL9A1C+OorBPykAZpK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Gad9/jjpkcqAg88YSmbQ3RdnbYkc4W06aCMAA0Hl3w=;
 b=ZcjP6liLLYEIGITZRfobq5Ukr5YhHvJYVJowekoqAxOB4Jv/gynyka+ujq1bq/EIflhme3mwhut3OLQyhi5NzcFddA8lboY/b8/k105TJA9pKEsgDZpR+a+f8ROpsHsjSOOQNWTkGnscrQ2pfaIR2YbMTDoOXIkqjTDV99Encm5ho9votw/7DDvrzdkfRzTl/0BgQR8IUInf/yLJNb/wItPqtMnlbuv7qWZD/ZsWPC6yoif+UkYMWU5DP2vhdJSrp5B3NyUlZmQwokL9tSSlcgicrxAHJjbojhFM/dDt+z2Xnqa2OJdcl8+5kH/pNef0u9TjuZD5IzHXIQVZz55vpw==
Received: from SA0PR02MB7386.namprd02.prod.outlook.com (2603:10b6:806:d9::19)
 by DS1PR02MB10586.namprd02.prod.outlook.com (2603:10b6:8:215::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Wed, 2 Apr
 2025 08:11:57 +0000
Received: from SA0PR02MB7386.namprd02.prod.outlook.com
 ([fe80::4c36:8bda:38b:e564]) by SA0PR02MB7386.namprd02.prod.outlook.com
 ([fe80::4c36:8bda:38b:e564%2]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 08:11:56 +0000
Message-ID: <c7a86623-db04-459f-afd5-6a318475bb92@nutanix.com>
Date: Wed, 2 Apr 2025 13:41:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] QIOChannelSocket: Flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Content-Language: en-GB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de
References: <20250317015231.241141-1-manish.mishra@nutanix.com>
 <Z92JrM6pF-dhyCGd@redhat.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Z92JrM6pF-dhyCGd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To SA0PR02MB7386.namprd02.prod.outlook.com
 (2603:10b6:806:d9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR02MB7386:EE_|DS1PR02MB10586:EE_
X-MS-Office365-Filtering-Correlation-Id: 1155fb34-5941-4388-1f07-08dd71be08f9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|52116014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M09rRnFRVFFraXFGVjJ0cDhEaG4rK0xmZVNGbzNyWGs0cE5LN3dRaVZWc1p2?=
 =?utf-8?B?d2lXTHNNR2FMS1lGazRWaW9kTDQwUWs2VXlQS1hISkZlYVVKT01rZHJRblJ4?=
 =?utf-8?B?SlZLZkJwbUQvaUJkblY2RzdBS2ZhN2FHdW93ZXVzbjRYQ2pPcjFFRWE1bTVX?=
 =?utf-8?B?cGFmajRmb0pEdEFZaUNxbEtzZUpiUzRnT3JrQ3RYNnNHeGFRV3FNUjhBdmxF?=
 =?utf-8?B?OGhMVHpEODJtem0xWTd0MWRXK3RFYmJQU1g4OTNiaXRkcWp6RlJMd1FHMFE0?=
 =?utf-8?B?Q1VMalNGVXFIVmV3WlRZMm5XOHR0R2lTNkxrWlQvazZ1YWI5bDQ3Q1YwZDlo?=
 =?utf-8?B?MUNIYklNcHMrVnB1VkJBNnVTVWlnNHhINkE1YUdaVW1SZTdaOWVvWGc4V1ZX?=
 =?utf-8?B?ekYzVFBlemh4N1J5UHNOb2dPNVlOUDJvTWh4YmpGTWRGUG1DeUlhY2g4ZllG?=
 =?utf-8?B?eXdIbEFkUHpwWFEvU2RDcUlFWm5qc3dYMlZXWU9YcDl6dU42SysrOUlGZ1FV?=
 =?utf-8?B?WG9SbXI4Vk4xQkVBT2lOdGVMQjRMd041azNSUUZuUkQ2d29NTWN3NVkzamxS?=
 =?utf-8?B?cStUZVNvWFkrS2FXMHJ1N252Z29nR3dKMnEwSGtZU3k5QU80TTcwMEJ0OFFF?=
 =?utf-8?B?SG5xbWNDMTdGamV3dzB3ZWFMVlFlUU9TN3hWZlg2SWlSRjN1ZTVCNG9DOXlF?=
 =?utf-8?B?czBPSE9LZytydFdLUjQ0YkVwTnhWOEg2ZEk0dzUvdjBkbzBsOS81d3U0WjBI?=
 =?utf-8?B?bm9ZTG9CYm1pYnRMdlR6TkNCMittMG9qSDJyUjVtUTlHZUs4Y0RCanBZQmM2?=
 =?utf-8?B?ckFKQ3k0anR6YnYxa2w5di82QitDQ0Vtc2NmZjdEL1ZFZjBOK1Qrb0JyNnU5?=
 =?utf-8?B?ak9sazJvd1FpMmhnc2liMWdjb29CcHFiTmwvK0Z3THlZOFltMTkzMGZqUUdN?=
 =?utf-8?B?b3phQjcxd04zeCtwWWJPb2gxNFpoaWFGeG15WjhUQlQrekxzdmdmWndET2JR?=
 =?utf-8?B?SjB2KzVNci9jaWtrTWRCK1dnNkxTNWZZNURxQUpWTXkvVHJYRWVyNVlsNDJ4?=
 =?utf-8?B?REljTzB1cmg0WlhQTzh2bERwQ3djcmVKeXBRQURhZTYwZG5LMU9MUzc5dlZn?=
 =?utf-8?B?T0dGL21USWREcmFoM3hZT2VIR3lhKysyQS9vd0NrTUpvcjRKSm9BbDRFTmhu?=
 =?utf-8?B?cVBMVmFkVUE5WC9PS0pwSlFlYk16TGdET1FIdDhiTVlxSEZqQVBmS1NrYzJF?=
 =?utf-8?B?ZFFBU0dyVnpVRFVwRUo0cUlZdFZkVG9JYUpkaUNtNkduYUg1ZC9GVHZyUDJ4?=
 =?utf-8?B?Q2VzMlRCU3UyT21Wd21iMENsMVRqa1NsdlZobk9adnFDT0puN1N0THFWTk96?=
 =?utf-8?B?bUhiV1E3cEZMWC9rbG9PcXRqYVgxTlkraWNIdW56dDN4NXVVdkJjYS9kaklQ?=
 =?utf-8?B?TWdaSnkvL1pPT2hKd21NRUthYlRIcVBZRDI0V3dKK212RmlwRGZDckNYSWh0?=
 =?utf-8?B?Sk1CUWM2L3gyWExjcTFMNzFCUlNKZGcyS29sMkQwdjE3WFFxQ0ZleW5QVFE1?=
 =?utf-8?B?RkE2RXhkekJIbGoyU3FQQUhNa2traFZiYkY3akFpSDBNQUVBNk43U25tWTRB?=
 =?utf-8?B?K1V2S3lRY0draWF1bG03aENsTkExUERzbEtlc0k3ZGVldXhTNTF2S3lDK0lV?=
 =?utf-8?B?NVdlQzh6dEZTdmhDUlNOSWpWUjBrdjBuaElUMzFTaGs5SHZiVmpyYXVCbGhF?=
 =?utf-8?B?ZjN4Tkd2ektucXhDU2Q5OFRKUHNwL2w3WmtDN2JVWnJSM0lDU0pYOVJoQVE0?=
 =?utf-8?B?aGttRjVGOE9jd2Q4cW5OdmsvVkRPWkVaNWl6M3BSNHNEZlpZNkk5UEpGUTlH?=
 =?utf-8?Q?EpkSXa47BRlPl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR02MB7386.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(52116014)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2llTkMvZG5Rb0xGaG54SHpSczRXZ2Y3S2I0NnhZYnkzOUp1OStIK2tsM1R5?=
 =?utf-8?B?aElDbHUvQ2NNVjJENk1wRmE2V0JWTlJBcU9hZnQ4clVwUW91Z3BBNWxJQzlp?=
 =?utf-8?B?MFE5TDhTa0xia1p5b25GUVY2TVJ2MW9NblNGclpVekcvRjZjSktUaURselFC?=
 =?utf-8?B?aG1uTzJza3FoNnAyV0VPL1ZLMGgyRm5vdVhTZVpIQ1QrTTd5dlRtNVRvZzB6?=
 =?utf-8?B?WEMxMmhrZU9NeVZlZGdCK1p3MWZrUk93N2ZlMC9yQS9qRFM1VEVCV010TE9Q?=
 =?utf-8?B?WCtrN1lhRUxmOERIM1lzcm5SUWtSR2hwVHNaczBmR1NZb1I4QjFLQ1RHWDRp?=
 =?utf-8?B?SExhd0dNV1VJVDUyTGZOc0w0WW8wdzREbWcwK2tyNTZpZnFDYXBTRU9uY0FU?=
 =?utf-8?B?cTRseFJCT0NiUVdYcGJhNENHZmMvUHZrQXJjMUJEMU5xZC9QYjJYNGI3RDR2?=
 =?utf-8?B?VmJsOXVDQ2hQeUxReVM0TjZ6Q3NWa004NnJ2dE5HbEZGSGJ0VFNHeWtHZXdq?=
 =?utf-8?B?bTRJdFZCTzJMZWluOUdwZ0NOWlJ0cU50NEl5M3RnU2NycmNCWSszQ0RKTUNj?=
 =?utf-8?B?YTFWa290OFc1WU9yVXRmM0JRdEpyMHh3MWRaOTcrL0hnOTNud1Vwa01Ecnkx?=
 =?utf-8?B?OTJaaXcwVk8rKzJnZUF5bGQyZ0dGSUxBZGRKUVovZVFRcVVtNVNxZ0g0Wjcw?=
 =?utf-8?B?TzlNWFdZTVVvQ1RBeUVSeEhGVlJycWpIWUs2eUhqeGdFUzJYcGZyMklxWVdR?=
 =?utf-8?B?ZFV3MWJnN1REM041blM3Q0s2VkRZeGxVRFlqaVJiY01LbFZBYWk3WmU5dC9N?=
 =?utf-8?B?cmlmWmZqYndKMWJnMDF1OUJzcFRJTjFXTEMybGQ3KzF5ZlZTOUE2TGRCSVdE?=
 =?utf-8?B?ODdSai9RRG9xUVExbjEzUDFpUkJ4dXNXYzlKK0plSHVqaUUzOWYrZ0ZWcWtW?=
 =?utf-8?B?OXFheUxyN3lRZW1WdTRXUFBGb2lndjBJelpOazBQQ3V2aDBJM3ZBbURhSVJr?=
 =?utf-8?B?UmRuaWZzalZocnpFRVlIdVJRQnhoUHBqZDMxcktqOVUrUnpUUDZNRDdUb1Fi?=
 =?utf-8?B?RkQ2OEd5YlZIYmhod0NCUlpwS25UVTFCNW90N3hQUmJiZ2FEZXZ4Zk5KRGsw?=
 =?utf-8?B?K21aNEowNlJrc3hjdjlRd2NaeE1mQXF0c0R4aVlJNUVvWHpyakVEOUhLc0ZW?=
 =?utf-8?B?Ti81Y1ZzUzNvYU4yK24xNDFEa1BnaHR1WmhWM21hZ3VUWFpYbVFSRXl4a093?=
 =?utf-8?B?ZlhRUnBnYlZHNnZOR2RUYUxKMlFqcktKNWZHY1MrSlpyLytQeUJLZHE2QWQv?=
 =?utf-8?B?WEFwek9USlRCd0pQY2xzNUk1aFVQTElZMVU3dENWUDZvci9JdWkxbGhGMlZE?=
 =?utf-8?B?blN3VS85b2J1L0cyZWs0RFRBVVBNQVRGaFczNVBrcnJxRGMyanJmWFlSWmlJ?=
 =?utf-8?B?MEpxNVEycDJadzB5bHprNDVBcjUzODJFQUJ6cGN2Q0JJZGpMVGloNlo4S1RU?=
 =?utf-8?B?NnBrVlJoUHhQYXBEeEJIWGQ5c3pabFZtSHkrVHdjQXhOQnVzYktlbmtUbEVB?=
 =?utf-8?B?NWFmVGJrZ3hXVDc3YkYvVFpDNG5SWmxjNkg0ZnVPRkI3QStDaDJSQjErR1kx?=
 =?utf-8?B?TkJJclpYREdmb0FNRWZaQ2NseHdNS0pROU42a1NXTFQvUUYwTkpZOEJCWW4y?=
 =?utf-8?B?RGxQWkRzcXhxVGNnYXVlYXBkdVdTS25nV09ZK08zOG1MbVRvTGx4aXcvdEhx?=
 =?utf-8?B?MGsrM29YcHpuNlBBcmRuTzVVUS9OY095TlpVOWcva2lDd21pcDkxNDlhVkR0?=
 =?utf-8?B?NzVxNFJiOUJFZlJUcHFBLzhhYTByV0FIOUIva0Z0NlphRjBScUl3bVlZeldq?=
 =?utf-8?B?cDFIT2k3c1gwNUdOeTVMdldLekFnUk9GY0ZSTEgwbXlNb3M3Yml3VEhyRlpq?=
 =?utf-8?B?bytvSHA5UXJBaTRwWVVDZ21uMG95TkErU1FrTzU0S3BwVzlmQUlLNE01SEQx?=
 =?utf-8?B?QWEvNmdkSnRkUGJ5dGZQVHpYUVdXanFBQ1AwaEJ4MHVnczFoUlFjRnVUYlFP?=
 =?utf-8?B?K3ArNlF4azRaZ3RTRmpqUzZ4UGtIVVpLRnRHbFlnakxnNitQajN1VGRIWFNk?=
 =?utf-8?B?QWk1Q0s2dkFBL1Q0QUtzdi9WOVBFU0hQb0tsblN1eXM4V3gyZW5hQTNDaTZ3?=
 =?utf-8?B?ckxTcHFPVlM2Qk0wYk51T05zRjg5ZnpFRUpzN0RITWt1c1pXKzRGY0wyY1lG?=
 =?utf-8?B?MFczcng5WlM5VDF4QkNyZ2h3OEFBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1155fb34-5941-4388-1f07-08dd71be08f9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:11:56.9224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VSEK4+2Tx0efbtlI/kmy0dwEakk+KflNoVlchSYqC51z7k2oDLOk24RbczcZ/PwFC6qwG9zN662iAfAdD1gxmN6yNxquSJhKN615A8yixg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10586
X-Proofpoint-GUID: 0pILFzhwi20FAVel5Qvx-lb2zJOUW9mG
X-Proofpoint-ORIG-GUID: 0pILFzhwi20FAVel5Qvx-lb2zJOUW9mG
X-Authority-Analysis: v=2.4 cv=EsXSrTcA c=1 sm=1 tr=0 ts=67ecf14f cx=c_pps
 a=xXkjqwxm0/s1VBTWak6WHw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=FbYyvjo7L_R3UwzLoWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 21/03/25 9:15 pm, Daniel P. Berrangé wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Sun, Mar 16, 2025 at 09:52:31PM -0400, Manish Mishra wrote:
>> We allocate extra metadata SKBs in case of a zerocopy send. This metadata
>> memory is accounted for in the OPTMEM limit. If there is any error while
>> sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
>> queued in the socket error queue. This error queue is freed when userspace
>> reads it.
>>
>> Usually, if there are continuous failures, we merge the metadata into a single
>> SKB and free another one. As a result, it never exceeds the OPTMEM limit.
>> However, if there is any out-of-order processing or intermittent zerocopy
>> failures, this error chain can grow significantly, exhausting the OPTMEM limit.
>> As a result, all new sendmsg requests fail to allocate any new SKB, leading to
>> an ENOBUF error. Depending on the amount of data queued before the flush
>> (i.e., large live migration iterations), even large OPTMEM limits are prone to
>> failure.
>>
>> To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
>> we flush the error queue and retry once more.
>>
>> V2:
>>    1. Removed the dirty_sync_missed_zero_copy migration stat.
>>    2. Made the call to qio_channel_socket_flush_internal() from
>>       qio_channel_socket_writev() non-blocking.
>>
>> V3:
>>    1. Add the dirty_sync_missed_zero_copy migration stat again.
> These notes about changes each version should always be below
> the '---' line, because they shouldn't remain in the commit message
> when merged.
>
>> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
>> ---
>>   include/io/channel-socket.h |  5 +++
>>   io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
>>   2 files changed, 65 insertions(+), 14 deletions(-)
>>
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 608bcf066e..604ca9890d 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -37,6 +37,12 @@
>>   
>>   #define SOCKET_MAX_FDS 16
>>   
>> +#ifdef QEMU_MSG_ZEROCOPY
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             bool block,
>> +                                             Error **errp);
>> +#endif
>> +
>>   SocketAddress *
>>   qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>                                        Error **errp)
>> @@ -65,6 +71,7 @@ qio_channel_socket_new(void)
>>       sioc->fd = -1;
>>       sioc->zero_copy_queued = 0;
>>       sioc->zero_copy_sent = 0;
>> +    sioc->new_zero_copy_sent_success = FALSE;
>>   
>>       ioc = QIO_CHANNEL(sioc);
>>       qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
>> @@ -566,6 +573,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>       size_t fdsize = sizeof(int) * nfds;
>>       struct cmsghdr *cmsg;
>>       int sflags = 0;
>> +    bool zero_copy_flush_pending = TRUE;
>>   
>>       memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>>   
>> @@ -612,9 +620,25 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>               goto retry;
>>           case ENOBUFS:
>>               if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
>> -                error_setg_errno(errp, errno,
>> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
>> -                return -1;
>> +                /**
>> +                 * Socket error queueing may exhaust the OPTMEM limit. Try
>> +                 * flushing the error queue once.
>> +                 */
>> +                if (zero_copy_flush_pending) {
>> +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
> Hardcoding block==false isn't right.  The socket may be in either
> blocking or non-blocking mode, and that needs to be taken into
> account, otherwise we'll get spurious failures in blocking mode
> if "flush" would otherwise want to block.

Daniel, i did not understand what kind of failures are possible. In this 
case our purpose is to be able to free some space from error queue so 
that we can proceed with new request. It need not be completely flushed 
for all data in the queue. Also currently we do not store any 
information about blocking/non-blocking socket, if you want it to be 
conditional, will storing it makes sense?

>
>> +                    if (ret < 0) {
>> +                        error_setg_errno(errp, errno,
>> +                                         "Zerocopy flush failed");
>> +                        return -1;
>> +                    }
>> +                    zero_copy_flush_pending = FALSE;
>> +                    goto retry;
>> +                } else {
>> +                    error_setg_errno(errp, errno,
>> +                                     "Process can't lock enough memory for "
>> +                                     "using MSG_ZEROCOPY");
>> +                    return -1;
>> +                }
>>               }
>>               break;
>>           }
>> @@ -725,8 +749,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>   
>>   
>>   #ifdef QEMU_MSG_ZEROCOPY
>> -static int qio_channel_socket_flush(QIOChannel *ioc,
>> -                                    Error **errp)
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             bool block,
>> +                                             Error **errp)
>>   {
>>       QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>>       struct msghdr msg = {};
>> @@ -734,7 +759,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>       struct cmsghdr *cm;
>>       char control[CMSG_SPACE(sizeof(*serr))];
>>       int received;
>> -    int ret;
>>   
>>       if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>>           return 0;
>> @@ -744,16 +768,19 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>       msg.msg_controllen = sizeof(control);
>>       memset(control, 0, sizeof(control));
>>   
>> -    ret = 1;
>> -
>>       while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
>>           received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
>>           if (received < 0) {
>>               switch (errno) {
>>               case EAGAIN:
>> -                /* Nothing on errqueue, wait until something is available */
>> -                qio_channel_wait(ioc, G_IO_ERR);
>> -                continue;
>> +                if (block) {
>> +                    /* Nothing on errqueue, wait until something is
>> +                     * available.
>> +                     */
>> +                    qio_channel_wait(ioc, G_IO_ERR);
>> +                    continue;
>> +                }
>> +                return 0;
>>               case EINTR:
>>                   continue;
>>               default:
>> @@ -791,13 +818,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>           /* No errors, count successfully finished sendmsg()*/
>>           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>>   
>> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
>> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>>           if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
>> -            ret = 0;
>> +            sioc->new_zero_copy_sent_success = TRUE;
>>           }
>>       }
>>   
>> -    return ret;
>> +    return 0;
>> +}
>
>
>> +
>> +static int qio_channel_socket_flush(QIOChannel *ioc,
>> +                                    Error **errp)
>> +{
>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>> +    int ret;
>> +
>> +    ret = qio_channel_socket_flush_internal(ioc, true, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (sioc->new_zero_copy_sent_success) {
>> +        sioc->new_zero_copy_sent_success = FALSE;
>> +        return 0;
>> +    }
>> +
>> +    return 1;
>>   }
>>   
>>   #endif /* QEMU_MSG_ZEROCOPY */
>> -- 
>> 2.43.0
>>
> With regards,
> Daniel


Thanks

Manish Mishra


