Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720DC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbUV-000877-3U; Tue, 15 Jul 2025 04:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubbU8-0007rz-02
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:58:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubbU6-0000tN-4W
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:57:59 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F2PZ9b016225;
 Tue, 15 Jul 2025 01:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6gJEdRZtS4ubdOSWN4nlvTrot2mV1Q7kOxIofnfRI
 Zk=; b=frp/3/GdvLXOCsQBg9+KX8QyKAvyOzjWv2+CaI/QFL959Ue+/pPVo0Iht
 v4WaTZ3mSQWoZvWfrZB9s9JrpWrme8G7e5NmVSaPd7m/wz4HdfitcIiiFz+vHS6Q
 KnBGslBu9bnvAqPfa+YPUSuQqE5f6RdaP7REnFxrQ69SShZKKdgHmse0QnoMiocv
 8feSnXJ319znMHdq81afcsZa7tCGSFEcCMaVshXGjfEIOyUGUkXnsZYAocFxmTGJ
 +hKWIwQ/2JfP+Sr4EUQgbFbsvMANmGlCysaC3qvJgb2pD2sCMJmyH5EjijM1O89+
 3gMfZPaJXqObBEnOCxtu/Nz/ysLQA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2108.outbound.protection.outlook.com [40.107.243.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq81drpf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 01:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcsnkFxUgxDODWliTeHpVch1V+LjO95/0bbrBo+E6TyYVGMtcrT+MYd5h65i/N5fd/xmJ8+ox61mZcor8XK6PLo4ZV5i8dq/WO4xLzaDICZ4AkjndbDuRYu1Fh/Ik5+hZgR7aJapGkCFA5DQcv9ca5Ku9VZNGXl24kynnSBk3ql7i9B1TLMPEOaOam3J7qQeZW7lHx1N4lpa4mNsAwukrqp0ljfJ9ZBD4lhUCDPtIWOT+tzDsO+5fbzH0IhZft+V+qW8KsbOGx0FpcmJtFPONuybBZs3BpXBNVnIo+k6jB56qPW48f4GtJzR2IsBGJIWuHLz+OZHSYBJWLKKEI3L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gJEdRZtS4ubdOSWN4nlvTrot2mV1Q7kOxIofnfRIZk=;
 b=p+zX2nEIFSS1sFrbN4+9bGhNcQKPUCQeoLKVMrWJatYZrjAwIQ66kzR/03EwSCp4g8Ndhbzwdna0pN5pbznU8wlwemWVBVHCDZEFse5vAKfjSbw+wpsbVXChi3GISy6xixD1A+IMxFg36znHF1kuQWOY5WWGDOyF2YaMTk7vg+FuixCKP1dx/br436cUp6Ub90CQdJjjIkTnyjIWvK12sQa9WGhcepDxPh56iq/mUQECUKmmRp2mn+eJyM1hTPjNrlxAqd8xaonJWtBC/1qzsklHxzarAIYlF77RYrzBWV64g0qlLucVm7DHwfVp00GD//+4vFo2t2uha9m0WC4mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gJEdRZtS4ubdOSWN4nlvTrot2mV1Q7kOxIofnfRIZk=;
 b=AJesIE1BcKr7LUWvREV+ah601lKQYshkA4nPN6uMz9rmfq9r6ibL4oREg5WMqyWfSvt0CB1N3lL8KtkAUaNqO0k1wphqQxJRVvMTDyF7ttxAgNDAhRFHMTZNSZMd6/dRlSvNNBKJ6EWsqecITXrKeeRw9GNGD0AgH4z9Id+blspM0AwIwX1c5lXFE3AbZO+AecTOnU4py+XeIZZl4pc2mjhsjw3na5ZHiAhnTBGbDUNJ894J8WwqfSnuMS9oX0E6d2c15GBNl1IOwWRph34cBTL83s2qwW2rnRfHi/q77XtRfyofM0M676nyZFFTxMWNrX3SWMe6M2anwe+4gC+RcQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB10246.namprd02.prod.outlook.com (2603:10b6:610:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Tue, 15 Jul
 2025 08:57:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:57:54 +0000
Message-ID: <e235a6a1-50ed-41ff-817e-3c1249b7b251@nutanix.com>
Date: Tue, 15 Jul 2025 09:57:50 +0100
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_1/4=5D_hw/vfio-user=3A_add_C=C3=A9dric_?=
 =?UTF-8?Q?Le_Goater_as_a_maintainer?=
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
 <20250715055246.422834-2-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250715055246.422834-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB10246:EE_
X-MS-Office365-Filtering-Correlation-Id: 4327ce6f-29c6-4cb1-8ec9-08ddc37daf7b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THFSbFRETC9tV1FYUkkxMDBtRkxkMXQvTTMydkgxb0NDZDVMZnVLaUJWZThI?=
 =?utf-8?B?blh1NElQaVg3OGF3c0RiL0N1ZU1HYjZCNC82QXh3dkFJbERpa0xJZkdjQVJX?=
 =?utf-8?B?WENJTlM3VFdVUUM5cWpTaE8xZ1pFREVZM3g1eTRyZ05OaWl5VHZtRWJSbENo?=
 =?utf-8?B?WFQzS1k1NU5iMDdIWWI3UUlHREtKbTdRY0JyU3RHWXBNREU1WW5GbFM2UVlJ?=
 =?utf-8?B?RzJ6T0tJVHAyaDE4Q0txbmxhM09XREJyZUFGMlJVMmE4UzluMmNlYk1uM2tH?=
 =?utf-8?B?Rm1kRS9jckIxMTVOVjFJcmNiZkRERlB3UG1IODVUcVZ5bEU3SFN0LzJ6RjRC?=
 =?utf-8?B?bTdCcUhHREV1OHZ3ZCtGQ0VFMVdhR0dxa0RwZmVZR3UzNnVENi9xNnQxZFpE?=
 =?utf-8?B?ZkZpdytxLzU0dVFsVndYVGplanpVY3k5NGpXRHM5eTYwQklCMzc2SnRHMmE1?=
 =?utf-8?B?c0FWMmM5UUxiampraE5ISHhZenFISGduTHFvaVBGR1pzd2NEbzFoUE0vbVgv?=
 =?utf-8?B?RmZscXZUUzBlQU1UTUlMbXBVM2JybVV2QVZ6c0Zwc2ZES0pRaGVUeUN6cytr?=
 =?utf-8?B?T2hJUjV6RkoxYm94cFVPWElnMEtzRzlNZ2Y1cTNrNHI5TXliMjRmbEk2TjQ1?=
 =?utf-8?B?Q1Q1dGxvYzhyYjUrVEJuQWRyQjhnaVBFaTc2QytxNnlHWWxERXY2SVF6YkhB?=
 =?utf-8?B?bk1oZ1lBVnZ3VmxDU2xrTW55THZ0UHR0d25hWVJTTDVsdnc2RUdjQStRQXds?=
 =?utf-8?B?dzZ3NkljKzQ1SUMzZW11U2VtRmZHSEFQMUFqTlM5Q2Q4Q3dtSW5qMFFFNjVR?=
 =?utf-8?B?NjZoa0JxdDloUXF1UmhINWJiREluOExVeE5nUWxWblJ5cm8wYVM5OVdkeHhR?=
 =?utf-8?B?dk5hOGg3SytQT0ZXQ1BiM0poOVlPQjJXZ0UzVkthMUh5SllYTGdQYVFUYjVS?=
 =?utf-8?B?b3RhSHNKWXNiWjMvWWNqNEFIYncrZ3FCU0NBQWxHYVFmbWVJR2NrQ1VhRGVJ?=
 =?utf-8?B?d3hqQ2toN0pEWGI4SVYza3RGSDQ2ZFlMMWxqdDhqNERlNGhqRTZmbHczM3Vw?=
 =?utf-8?B?VVNFNk1MWDROeWx6OFQ4MUpBSlVyRnR0Z2w4RWc4WVlrQVdkb2xYZlF5Vmc2?=
 =?utf-8?B?MnY0cVlIRlptZzh2ZXE0d21yK2JhdStYc05KdnBNSDNCSWdMQVFNa28xMjhU?=
 =?utf-8?B?cDhDdFV2R3RSUHRNc0p3Qjh5dHZuRm9NUFkrSktuVEZLWGI2L1ZTTmdtTUQ0?=
 =?utf-8?B?L0tWM3lvcUpOL0hzRW5uYlZZL3d3a2k3dUNsS3NRUmhJL2ErNlZZRnUwWDRX?=
 =?utf-8?B?dW1KY2lCdU91TzdWa2RiajEyRTFlemRyMDBWeWsvRGNtclVNZGxYM2Jxa1c5?=
 =?utf-8?B?ODM2RjBCc3pMYzNnbzlpVW45TjJRcitHbmdhRHdKYXhZVzJxNUwzZllYWDQx?=
 =?utf-8?B?U0dRZWpkaXlYNDl4eFBBRVlPK09LUWdDdGFQcjV1U0dVU3hLdUNSRWliUDVU?=
 =?utf-8?B?VWVDU0xBajRYb09TNVBjYlRjMzEzMmd3bWl5MTJncGhHVTYrMDUrYzRwb0tt?=
 =?utf-8?B?dW5nd0ZPb3duaXpkV1dSOTRyRVpIKzRkK2MrUkpWY1E0TkQvQWhSQzE2aFh5?=
 =?utf-8?B?MlN4Uit4RW5KWHlWQnpvdWoyMmN5U2ZvNm1hN0hXWGFVYnhiS1lpV0FER3BM?=
 =?utf-8?B?ck1lK0RRczgzbDZxYjNWU3hTTkd3NEFFZm9vYkNWNlo2SFVwNVljMmxXalNP?=
 =?utf-8?B?STBZZ0tObTluS2pjSDMxd1dFRnVBMFhnTVVJcDgvbFlEMU83REJZMFgrTlBv?=
 =?utf-8?B?TGw0UmFRNEZibnhoL0FJR3pkYzJLQ0NFU2p6aldLdVJuUnA2UW1NM2pFTUIw?=
 =?utf-8?B?dnlWdlNHVzVsK0lnUkNhdTc4SGRvNUxncXNUb1hDU3hWTW1LWUdTeFp0WThy?=
 =?utf-8?Q?7T2FunYan8I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlWdTUwcnh5VS8xSHFkS0ZibWN4U3AwUjRDcE1rc1ZqWkIzblBNR2NZQkR0?=
 =?utf-8?B?YkVZWURYWkdMbjNjbHF0TU9jY0FEVnR3c3lOdi8vUUFjUEJrRnFOeWJNSHB1?=
 =?utf-8?B?Z00xams0OWNUZ3pDM0RwbnRZelFmK3QxakxhVGZvTGd2ZDF0NGxPa256WmY1?=
 =?utf-8?B?Yys2dmRqS3BkU2pTUTZwblpKWXFWeHMybDhTTHdFVmhwWG9XaG5LR0o2NFhl?=
 =?utf-8?B?NUVUampNV1VDTDBpWkpKbkoyRnljajhRZ3VJN0VXL1BPN3NFQythcDZrbDU4?=
 =?utf-8?B?M3p1RjlkSzg4c1I0MGVHMnphb3R5SmpiNWN1MXU1cnlQYUdpRzV4cXhHMzJS?=
 =?utf-8?B?Y2FtWU5YbzhHblNqYXVSaFJqa01FcmtBVUU1aUgxUXlXN1ZOUjRiYWtsZ0VS?=
 =?utf-8?B?ejVya3l6NGlicWE4ZnNCejJrQWdtemFSam9FdVBtQm03K0ZmVGVmeno2TS9H?=
 =?utf-8?B?MXdyRTg0VTRINzR5TnN6bWxMaW1zTU5Mayt2cHRpVXFVbVRGRy94bWxTenhk?=
 =?utf-8?B?aDVHRDJrK1MzNnpHd2EyK3RJVFpQN3RUb29JV1YxRFR0eGdpWStxRmhqZjZ3?=
 =?utf-8?B?Qkdnc2NaeVVlZm96WFFmaUZLUEp2OWFnK3BDWFpYMDA4dVdLV0N6UFh1Y1Rx?=
 =?utf-8?B?Z1JSLzNtUTk5MFBHQlhNdHpGTUxIRnNoVmx0YXhZZmZITHo5dEx4a1RWcHBw?=
 =?utf-8?B?ZjhUVTdTSHNnWmduQmdqaGRqNGtYNEI4VGlLcnkvelhGcVV2U3RBY2Z3R0hJ?=
 =?utf-8?B?QmUzYnJ3WGpCeER5Nmt2b0ZzWGk3d3ljN0R4Y3BOVEpYdFBudm5xL2JtcVYr?=
 =?utf-8?B?VDdmazNBaEkrZU9FVnpJVHdhVGxFMy9yN2wyT0x4cFFOa2FHZ29oSWxwM0hh?=
 =?utf-8?B?Z2pMR1ZobTd6YTdGTTJjRHNCSDZBOEhmdXduM01IYmlHOVhLOXJ5bVpLQWRy?=
 =?utf-8?B?SitjdkRMaUVmaVlnTkgzeVlhVXdIODBTdUxYK2MyUmVMYllYeThJcTBQQnZY?=
 =?utf-8?B?a3pXSitzeFFySmVEWEZYa29hMHFiK1FYdXZqTEpaUkVMUm8vTUZCU1hHOXUv?=
 =?utf-8?B?UGlWSDB2TUJCK2gzU3llSk45Uzgwdy9Pdi9sK0o3c3FOcHNiTVlXeXM4ZG12?=
 =?utf-8?B?dzJIdkNLYnB3UldNQVB6OGN2OWhUL1F6amdUc1c5dm54Q0M2M2ZMc3RIUzdq?=
 =?utf-8?B?R09CcXVyNjBQSW9md1M4bzNFQ3g4N0YvS29vSG9WaHBoZGdTQ1hLMHJpTm84?=
 =?utf-8?B?b0cvVjE5NHRUOS9EUVpNSzU1VGF0K1pjdStHVmVhWFJiZExtTXE3NlQ3WVEz?=
 =?utf-8?B?Um4vc1pNUjcwd2FIL2RtNHRVYjZ6V0hRelBmQU9lUTZkcTVrWGR2dzYxVHVP?=
 =?utf-8?B?ZlV6OUpkU2dwTXEzNktLeGpPUGdWeDdEZk9hRG8zVVNFVE9mMXRXdnpQd292?=
 =?utf-8?B?bUl5VlVwOEhHNjNVZ3FWSkc5WXkzRGJyMWJiTG1OTG9GdVFoOW1Uc3JZK3Za?=
 =?utf-8?B?ekE0bWhZUXl6WG4vUUJ0eEhwS1p1VXdqcUhQcjJUWHk5dVpuZHhiK0Z0UnZS?=
 =?utf-8?B?QWFJaklJY0NWUnhiMEdoOTdhYWJQUXFtc3Y3QVhPUGJXRkRjYWVSaXcwUGY3?=
 =?utf-8?B?NFV4Y1hpUS9uZDBHamhJR2ZmNWg3S28ya2lwWm55SXVWQTVUVURqT1dWZVQ0?=
 =?utf-8?B?QXMzY0w2M3J1cUtnWmtQRWlsZ2xsalF4bFZoUTNHcEFOeWYwM0Y3eS9ZditE?=
 =?utf-8?B?Q1lnN2ZlQk5UZ1JxWit6YzZRcW1aNExYWFFHUFZ5VFB4eVBta3Q0Wmh3dTl4?=
 =?utf-8?B?ajlJOHhKYjEwYTdOWlFHSnRabGE3Rnc4Sjc1bEE0eXFuOEZST3Vmb21BWDJH?=
 =?utf-8?B?c0I5R1NFdGsyNnZVRXZoSFBiRjkxN00zQSt4RllmNkhrdmJLbW1oZS8wZlFx?=
 =?utf-8?B?V2ZRajh2T3FLZmFtaFdJWW85L2hEeStjaG5qY1NrRDRTNlZRWWpkK0s3VkxL?=
 =?utf-8?B?NENSVG9ZNWhFQWtrMTFsLzNPY1g0Mm1OR29uRVBiSG1YSENsd05hSjJVYU14?=
 =?utf-8?B?WG5HQWV3ZXoyQ2U5c1VXVzdHYzlFTWk0MVBMZ0FtdmNnS2VZelVidXNpODMw?=
 =?utf-8?B?bFpyL1NCWVcrbWRBYThXREtQRDg0ekgyU2FQZGN0aFdUL2x4T21KRTlWQXU1?=
 =?utf-8?B?QzVINFBCSGQxdkx3VWZHaFRLc2xtUUh3blYwdHNjR1dpYVBML3FWdzdhR3Zq?=
 =?utf-8?B?dUpDbURsa2Rob1QyOWhkSHhVOTl3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4327ce6f-29c6-4cb1-8ec9-08ddc37daf7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:57:54.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFwaEUTXuES6lCGn8TliU/3OW/TlBrqgxqXbK//jI0QhXcl5oEPx/LJSp2Cv1YoB0s/eum/bZXCfIxqS6krXqrwzc5k+FjfkREPNs58/kA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10246
X-Authority-Analysis: v=2.4 cv=bL0WIO+Z c=1 sm=1 tr=0 ts=68761814 cx=c_pps
 a=RqubJsdE8dpkPRvhziTryg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KLPUuaC_9wA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=GAv908kjm1h8E92LiF4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bPG6DvbXlQjYseK6MqbmpzrHzKFeKG3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MSBTYWx0ZWRfX2UeIaKlACkdf
 1pElgMNvLNv7y53G6jqCLrEdtEf/gibeq9qIfVG4n3E38UxhvS/e5WMBG/S+lrGmvoIoWFqjkJC
 PqPZN4noWV+TOl19UsH+ME/yRE+2Gf6ugtAn3UHNbX37kQYY+hJAH4s7yLil7AbMGni2zO0UA3U
 Dcyjt4lU3KCG7iNAtoV2AG7kei4BUKOVOGUeCs5HWnyupYpuI8+IID4Sv8O9xoKfZs3LKJQjm0k
 jh2w/1r1eyErVJ+ZWPlVpdcVmjmDJ7JI5gLuNkIquJc5Od/W5Epe6lUoyYkXoyFZLyx6RGekvTx
 xlC08H8pR7ReFKbcyRkuSAp2qTXPRoHCn5oX960dPiWsmZxOUoG9g6ITveBSSAqtgniQmSGOp5W
 pIrB8zIhigJ45d9Ba0vyyqiAkhnlO3A5TPn5ZqHMwQ7yhgLDcJPmoE3AZQuPf6qPBsZceAdZ
X-Proofpoint-GUID: bPG6DvbXlQjYseK6MqbmpzrHzKFeKG3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 15/07/2025 06:52, John Levon wrote:

> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e88ed2c0a9..30e9b71e6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4287,6 +4287,7 @@ F: tests/functional/test_multiprocess.py
>   VFIO-USER:
>   M: John Levon <john.levon@nutanix.com>
>   M: Thanos Makatos <thanos.makatos@nutanix.com>
> +M: Cédric Le Goater <clg@redhat.com>
>   S: Supported
>   F: docs/interop/vfio-user.rst
>   F: docs/system/devices/vfio-user.rst

Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


