Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABEFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnFp-0006J8-Dc; Mon, 11 Mar 2024 17:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnFg-0006IU-DE
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:32:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnFd-0007u1-KV
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:32:08 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BERhuv012926; Mon, 11 Mar 2024 14:32:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=zQQccVInWNTaZWkx16QwD3YMdUz6R6+SO3jYmvXWK
 i4=; b=MdoxFD6vIxHj3oMhHBRtc8GHbgrvXPYdG4aqazwXYVLciKz4e+V118rV9
 XFdnSN1xqVbxk/VjRShbrj0iqj5O3/kbey3HkdfrLQsAUaDSVEIruygDt274hepZ
 ZU3kbQqV3Rouv3ix4foSce2LUrx4qq3f171cWL8lSELWhB51Rt0a+UwnURpFIDHm
 Ph0UXHZlBXkmBB1q9bnmGD4JJf/ry9JMYREym8LR6cGnaMK8W1CEgr8o+O/Mg6qR
 l4vuvh1iPG4trUPadnTYX2JGTN2MGY1mfH0A/yCpNiPt+sxpelrd41riUdHKGNWs
 Tdg30slxqYtv0hMJkSUwHPAA9IILA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63max6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9sUCdYrR1O1iCtlWmTgba3kNL1PB4UQqzP5yP4jFZ38a2CeOQppK0a6PH6ujr18iXV4ItLLslmO7+a00jcSbgVE9JKc3RjQBxZVLVyFS/RNQ5LPQMcdXD0Y4XIl1pWrgknaFFP6QHdf7kZofGN3zA1SJpT61Q/T1dpCDeKH8V9VCFSDgaNeOtCvGPUgScrHf1ZjeZWpABdj2lkD5ITDa4tL8GbDaDz0GYKl/0A0bbU4ElKzSklAzR7QVwxqsu51EfKQPbD0zUM5rQZRaUYgf9Zb/Le6/uVqUKILtv8JBKi8sQRn7DnPUevtfvm8rUqg2AMwkx3FI0GVNgRHvvBgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQQccVInWNTaZWkx16QwD3YMdUz6R6+SO3jYmvXWKi4=;
 b=W+58Dbv1yS7fG99WZSG+/a0DkUD5qoe8NWpzFE5M8wtkusN05ig6Qr/sDMEdGgAz+3MZfPtyx/kA11ATk92zvRwSn8WflwQapOd3wxeLEffIzi84eh+ZOd1jTCFFjKIK4WY5pNi7Rwa9CuOMFDnhdJrFSKYkmITvJUbGfRk/GdYtHO4Vho2MIHFVCV+HGX64L5GSG0fgW0Hh2RkFs54E+Af9giGGFauw02BRVcJ0Q2a9bRvVHG/OUV/+2OoTY0ePGVP9QlGAHXbJnfCL7TPZOP8VbXnnZROUu4r2cVnRrcSHQmf819Wosl+2kOP89jiXpgynnhjOTOLKIMqsXX9t7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQQccVInWNTaZWkx16QwD3YMdUz6R6+SO3jYmvXWKi4=;
 b=uiGHdGVNjH/IRbxVxsghLMmV6FWxI2EtVvwS6BaXB3Y8+aDDUH4R2hvHX+SG0UavY+zkFO3h1qXicfok59nPmAnpVNuuUGwtkQHlRRLgXPxrKulTlHGaE1gdhnCARUcTQ6xEV7DdeQoXmGthzxexZFtQM4bUCxvbcmqkC+Am/pFQ5TRf3V1Rs2DxjC0piS0I7Acu/+yWHRSwUxIV9mjvO2SI0Y0ixYWbHl0iyzAKnEFuNDVtLaq6Lc4Dox/2v1yHJa1zQFV1PlCA/GcqhHAF3qVTZ4lksxI4ERHmXb9d4QSZ+w1+/Yz2Rm2GeGmwBzzyvUfrlGe+XG49IT1vf49TlA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA1PR02MB8654.namprd02.prod.outlook.com (2603:10b6:806:1fd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:31:58 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:31:58 +0000
Message-ID: <66416dbd-9038-4762-b39a-9395b778ea56@nutanix.com>
Date: Tue, 12 Mar 2024 03:01:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <1db9b780-a83d-4794-8ddd-1547615cdd9b@nutanix.com> <Ze920doZYn99aLCn@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <Ze920doZYn99aLCn@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::6) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA1PR02MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3251df78-b67b-4fc1-32df-08dc4212ae50
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQWdxGpneT8sY/s0OVwJt0T86EVUNLZFnJshl0fynxDZ97rYQ8UyVMhpwjcRhj9h/VtBgEpJoiKeB6a8UAaVNE7NRfDyV26Q80AziTIX7PV0Lv2emgpRf8fUGU05Snf/Zyt63hblOhIOj4JlK62Ga4yFO0Aj3Yu2oIA1FdUqq42s5E6xyO2q1sSOtYJvDa015GEZODYcv755PKMwKdhALm4/FC+0lGAacBubC74lYmV+n3MAkW3XWcbCwUcjDCbvTbifI4CNLzVO6hydMHkLFUZOM7pOoBdGr6wLDdSloCHgl5XvHM2erweES9pTrf5u0ZohMuOV7tpnBFo2hcWd98Ik40wqPsVFjnnLFbkyE8xf2rhHnY5gi+GH1O4z3LFf2181m/kXrjUDpQUykmgXUH6k1tdfcFYx6Hn1r+GdD4CdfKX5UYq0C5n8oQaXbrPWT8zY5QrAegNzYTwmqQBVkWQDaNulsc0bjW+sO58ME0Nbaf4dMNG10HG1uaIwJA7T0tl51JiTMVa++xNKE1V6YbgIdXbF1nWdM3OsbSoLpcVqDqIAsIHbbyg6ppXkYr9KEci9kggVUoH8SmTFMjUx7sQZ8vjkoz54A7eKcKGp3Qg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlg4bkJDZkZ6R2QyM09xaEY2eHgwMzl1TnB0TlpmSWZmdEllQ2ZmOXhNUHFK?=
 =?utf-8?B?OTR2OHZqZzBTbzkvZHVFMlFUdzMyMFRIWEtXZHZRQmRTVHJoN0lwemNmNGNo?=
 =?utf-8?B?MFF3NmE1UUg4SGp3d3FUZHNZcnpzd1VldjgwRkhndTl4cXlKeFRvL0FzbFo2?=
 =?utf-8?B?NXM4a284ZW56dko2WFEwYUxNZkZSSzlQeW5BN1JwUUN3bUI4WG1IbzBrU25v?=
 =?utf-8?B?NEpFUGk3S2I4bUV6RWtBWjl3N0Urei8rUzNYVmlNbUk3MDQzbDI4cVc0ZGJE?=
 =?utf-8?B?M0dmSE5JbVFVQmRxRytSRUp2ZWt2UEZkNktYUXZrQWtwWHNmS1Y4dndNaktZ?=
 =?utf-8?B?Y0hXVzVuWC8rRm10ZFVhS3RRYkRGQlc1UXk1S1g5NjVFZVF6KytCQk1aWTNV?=
 =?utf-8?B?MXBmUEpBVmJIbkhNVFF1U0t3L1hyeUxHOEMwYlRWY1VBSXRZSXprdTZJYldx?=
 =?utf-8?B?NDJzTkNkajJkeFo5UDFMaWpON3R6Ujl1RkZDak1mdDFRK05laS93RDhURzYv?=
 =?utf-8?B?V0tpUVBrUFJtWkFDak01UnkwdGM3LzBla1FIZ05sU3lYQ0lzZjdSOU8xWW13?=
 =?utf-8?B?TVFJVGZSa0tIL2MyREdZNXJJZ3JURkt1eWcxejJEL1FnbzhvNU1GTlAvaW43?=
 =?utf-8?B?WUE4YlFBVWg5MEo5bTVqU3BqT3B3ZjRhd2VPR0NtcjhDbU94OUpoL3lMU20r?=
 =?utf-8?B?SmVUdEpNWnlCTm5xZmVGN1RkS0hnWWZjWDcrTjR4bG9OazZnRk9wTGhpNG5X?=
 =?utf-8?B?bmE2Rk4wTWMzUFhDZWtiTEhscDhpRm9qcGNDUFUyWDlDeEsvQk1WRnZPZTBB?=
 =?utf-8?B?aHZsWUUwVWczT08yUXdGa2dqUkZ0TDBlOW5ySHZZNE1XK0ExR0o1ZTYzVGJM?=
 =?utf-8?B?VUNSeDV6Z0o4M2ZVb0pvSG5CV20yazIrU2JNMG1WVVZ3bFlVU3M3dU52UHc3?=
 =?utf-8?B?THlxemFlWFcyc3o2d1hncWk4eFludVJQbzZPNUk0VjBhb294QmNuT0ZUQUpv?=
 =?utf-8?B?bkx2M1B6aW9VS3dPNThUMnRCV0ovNFdNdUp2VFVBbHJyeVdXMlZUWGxCWG1K?=
 =?utf-8?B?ZkxxcjBXOW5vR1V5QSs1dWorNzVMeStnVlMxQjAxTTNHaU5QRHpibDJNWGox?=
 =?utf-8?B?bTRFR011bDRMREYrSVpxTlIzR1RFdHpQUElKUi91WmNxOHVMUmE1ZlRjVk0y?=
 =?utf-8?B?bVpscVVVbjlySlRhTjFGb2hQWExFR2dDRTY1T2I5VXRDbVdFNVQxNzFqOG5p?=
 =?utf-8?B?dEJKSkVqbWFjby9qU1hRdzdZcDRId1ZZN3lPYmJBVnlEcHA5NkpxWmVqVEdY?=
 =?utf-8?B?Y0NKQUliSWVnaklSM0dYWkMrUE1VRXM4bWVwU0ZmdEhnYytvc1ZOT1Q0dmtt?=
 =?utf-8?B?WWNJK0RtTkJXKzBLWlIzRUd1M2F0b1FJWWtEeUZ2ZW42ZkpsVUVvcGJaQWZU?=
 =?utf-8?B?MWQwWnVIc2VocGJWTmtoWitTTG0yOUdDaTFMcHI1Q3JlS3A4aW9aSlByNHAw?=
 =?utf-8?B?QU8vOEV0RGFPa3ptVmpKdytpNUg0ZzRiYmh6VzRieEVaeUZsdHBaeDhYTlNq?=
 =?utf-8?B?OUdnMVc5bTFKdWZ0cW1CZTVra3VMVmJ1MWhGVXNIbVNBS3JGT1VpZ0Yva01T?=
 =?utf-8?B?N00xY3k5NTJxdUhWcHp1eGxSZUlMK0tRb1AxZ1htMHRnYWIranBvZ1pvLzIx?=
 =?utf-8?B?cXF1S0dMblJheHNzSGtWRGdneUFpUGJNZmRkdWZ5MGx6bjRBeXFISWQyZHo3?=
 =?utf-8?B?WG1vaDVCZnhmSHlxNFBkdWd5UytVTGYwQTdjRWJMcFpxNXdaaHBlWlJvTFhC?=
 =?utf-8?B?ZnIraGJWdWNCS2s3YmNCNFRZdVBoMHRoVmk5OUM3SlNnOGxQbFMyMldmWXZI?=
 =?utf-8?B?YklueVh6eXNpV25xejN6QmtWajBpdlVpWGFndUF1TjkyUHp3V2xKY28xemFi?=
 =?utf-8?B?cnJqSDd4ZlRjN2pzamlXeFZjbnA1T2J3aWZMUy9aMGRkMGl0eGNZWHdoS0RF?=
 =?utf-8?B?N3RBaWxXMmRLbnJzYUprNlhxY2ZNalpmR2FwSkUvL2NvQXh6eG5UYzIzZEZa?=
 =?utf-8?B?QlQ1VFM1SVhtcTc2RDZxa3hYRmp5d0VuS2NpNml5V2VvOUZKVENnb1VYM0Nv?=
 =?utf-8?Q?wH+lCZOj3xJ+7JY0nZJmiAeBl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3251df78-b67b-4fc1-32df-08dc4212ae50
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:31:58.3873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC/UlNSv1ZbK+XQnxdWw6M1s8vlPJLzVyAdEXxTScz2D4MjsZQdh5r2d2TwjQZfBRWTkuEcIMR6k8Fa7sS23/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8654
X-Proofpoint-GUID: LQj1upyE9tDvlEvG6Aq2AdJYNCSdi5Xl
X-Proofpoint-ORIG-GUID: LQj1upyE9tDvlEvG6Aq2AdJYNCSdi5Xl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 12/03/24 2:55 am, Peter Xu wrote:
> On Sat, Mar 09, 2024 at 01:11:45PM +0530, Het Gala wrote:
>> Can find the reference to the githab pipeline (before patchset) :
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207185095&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&s=vZRNX33_DuLO1TsfTpYR_s9bf_EMFm3oHHH_eg57zE0&e=
>>
>> Can find the reference to the githab pipeline (after patchset) :
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207183673&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&s=C73ka3k3ouAuRJYNVLPIBQiWx3jDFDDvVYDiEYqfE04&e=
> Het,
>
> Please still copy me for any migration patches.  In this case Fabiano is
> looking it'll be all fine, but it will still help me on marking the emails.
>
> Thanks,
So sorry about that Peter. I am aware that you and Fabiano are the go to 
migration
maintainers. I thought I emailed or cc'd all the stakeholders that 
should be involved
for this patchset series. Even in earlier series of this patchset, you 
were cc'ed,
but somehow I just forgot to cc you for this patchset. Sure, will take 
care from next
time. Again apologies for the mixup :)

Regards,
Het Gala

