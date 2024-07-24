Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B061EC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWWyI-0006WH-Gn; Wed, 24 Jul 2024 04:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWWy2-0006Uh-Qi
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:03:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWWxz-0005FR-K4
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:03:22 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O0wnYR019990;
 Wed, 24 Jul 2024 01:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ujLN1kNyY1AYkojUw4CEQPuj43ykOKkppmStkCXIa
 Kg=; b=qcZKyYOBgyC6grjgIxkFKfHckEGdR5YwgkmYx+5gvOZRN7Ljp2qvLrFJ3
 GVDy8/7+lY7f6xx1FC/oHibybWqiefjkLbW5tL9c+usMEz98CdHnNdLtvjT09G/j
 OKFnT5VVGcCrenMhdDqTWdhVsCh1mB2GrP0pGQ/ocwYIan17z2n2k1NyydAGOEm8
 YUg05uvA23SBwf2lG1VHSLqvxYSKJBx8/8Qb+T3uoqCFD4VRSV3yn7X7gyN3dSDs
 rrI4HLTqUMbQuoQiQC92Gl31PA+ndhqyEWbPquGlfYUpKT8owKslwXtLZy+y6IJ9
 YTS/Wof0H4E8cAz/bppg34l6QdvLQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40gbbffp5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 01:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln9N5b1NC3HVnVA49z/u66jPYHIPlx4RFpqtq6G+iGS/6zCAkMtcWqdr+ej6XpoHX4brw17PQ4Xw/DdS0BXhoKaRNvUJSx39gMwX/Gy4EG//YbaV5SGUT2TtW/ei+Xj5YTXs7kj91WDg8msay+V1DV7fs30240+h4gdyXpX1IhnQ+PE9UKuKsKqAPHiaD/7n52139QU6QW8iydS1dcts+TpQFipqQjX7to9sw2iaEwRcj43JxW3693UFeLXhx9aHHmg49l6SWvMig5CeJzjGcAoPFgtMvQhVRfofbgUVsEPnFWo75vBwCQkASgtkHBstZBiKbE6bCTK9O4l9qrT3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujLN1kNyY1AYkojUw4CEQPuj43ykOKkppmStkCXIaKg=;
 b=oVJ2xW0a6Injkj4MpJA3SkjDOs6Lk+X3wBSIAx3p2VzAh4gqy8x2cK+76RFF5eTJQhrHeZPjr9oV3S1zqSrICjSDS+BqDCrls9SqalEHYIC/8zld65+u1WjL5UEF5lna8AQnQBkqL4JXAYRJWA/CtawA6qRMQRRIY7IFZ996RwWJSPlEw2Q3Ok6kLLLyNItfz2vGMI5zFToOXASsTqS7uuCpXLZq0XLL45W7kqi5Y2xyEoVKnPqVRFs+RhQzdP2QPd5BatOX64jje6umCzbra78tvAlvsHldd/l+ehVXIrDpVLaYH5PHWxltXkb7+UuP6FH13kUiDWPR9rqPxLESyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujLN1kNyY1AYkojUw4CEQPuj43ykOKkppmStkCXIaKg=;
 b=PGU5ri65tXh66t7BHY3NP8xBy193LQ0WqSEukB49s3GNYNryK1xo5dw8FxtkkA1Zu93gk3Uunr7fzN+HvjMECFM0IbxzN7GIeVxhBsPz6ERDEWTPDwkh/zlBi0Mr0RquP1n0f96ny6b6Yk4eQRI7WyFSWSFi+La0D7L1ziObMdDq0A322BSpycLDYReFgzj3TfTDCZUX1gWe8k5Fys6VCOcIf52n1bxtyW/kiI606VKlE+6a7NqNthYsLdXtXwIFejX6xE3R0FxXX6uHcQ6lna/hMGc2DbPtBs/SAh8c8cVssSD27sz1di2elDeWBwrkLMTUQZ0Mb7xF611toYh+Uw==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by BL3PR02MB7985.namprd02.prod.outlook.com (2603:10b6:208:354::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 08:03:13 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 08:03:13 +0000
Message-ID: <b72784b1-92d0-4fc0-ba79-9992557afd3e@nutanix.com>
Date: Wed, 24 Jul 2024 13:31:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com,
 john.levon@nutanix.com, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20240722101859.47408-1-manish.mishra@nutanix.com>
 <Zp+9gOESPaUi8ATT@intel.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Zp+9gOESPaUi8ATT@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::28) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|BL3PR02MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 541ddceb-19a0-46db-fac0-08dcabb710c6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFg2ekwzNGZ4SlhpUVhHWWNXWXgvczVCU3NMOUdwNGYrZUtDOHBSeTdCTEVo?=
 =?utf-8?B?cnRsZnJvNEJKWjJKcHZJVXd3TEdXZG5ncS9kcHlMUzFjRnBaS2puSS9NODdt?=
 =?utf-8?B?dUpLb1JLY0FRb2Zibnc2OFp2SG1UWHdHbVI3RnFZcVA2WEtWcjZuYThyOFlZ?=
 =?utf-8?B?SjZEUUM0SWlDamkvMDZwK1BOc1ltNzBPeFIwSjRaQ3hxeHcxZldnaGpCRm5i?=
 =?utf-8?B?MDV1M0V0aEt6eG50WnBLTWg5akRoellTMU1udy9oYldJTjhoSktscDlQRWlX?=
 =?utf-8?B?TEYvQVJTeFRCN1NEZ2VkRmEzTUxvTmoyLzFqeXIvRDhLcExOVGI3akVaZXhh?=
 =?utf-8?B?eitwNFhRS3c1TXk3SzliOWxxcm5ROTllNytndDBkZ044RVcvWStjdXVrWlNv?=
 =?utf-8?B?eTdSSHQ4cUg0UlJ4MWlCSlZsL1VueERMQS8yV3RGUVdhajllTkNaM1F4ZFNG?=
 =?utf-8?B?RE9kYlJlUEFZSU9ZWmVxazFQcFVPaUp5UHR3OXk0YWlyeVZRaHFqZ0YrQjVq?=
 =?utf-8?B?TlErRi9QL2xRekVoUWV0ajVBb29KcFZLTXVaYTA2OVh2ZzNtdHZpMkJhMUVP?=
 =?utf-8?B?cUExa3NQUThFdnhCYTE5dmtOdGJzektsUjdBdVZKOVMxaG5nand0R09ScFB0?=
 =?utf-8?B?WXpYa2ZTMXJoZ21TKzNBb3Q5QmY0R1ZWT0crWEtRaFIyUnVYUGptdmlseEVv?=
 =?utf-8?B?djVlOGU2Y1VwNXpBU0RsUnZ1S1piL3NoMHA1UjdwWmJ4U3VuYXF5ZmdNbkRC?=
 =?utf-8?B?cFFTTTRKVW1zaHJobjEvbkNvaGRBSDg3NjFqR0hLTjh2MjEvWmRtWjMvNWpT?=
 =?utf-8?B?WGJpN0puZkJTTnh1NVo5QjJtZGlUUFlhYzJXR3loSmZVdUpLNWxXTU5QU3U2?=
 =?utf-8?B?MTFRRWZ4RlVrVExkRWViOHFNbnFOMkU0YytuQnJrTCtLL2gybFJITHRkTTR2?=
 =?utf-8?B?NTY4Y3RIS0MvYWdjNXlZdE0vdEI0cnBXa3hTWUROYWRLRjhXWHcyTzl6OUF6?=
 =?utf-8?B?VTFSei9qUEdnUDVaSUNuQUE2NGdjd2pVUzlrSm1NU2EvcU1RZU03WWRQOGUw?=
 =?utf-8?B?WmxpUm1TeTJwajlZT3pRdW1GQ0RaOU9FY1cyS1ZYdzBMWFBOSDhZYm5tSkx6?=
 =?utf-8?B?aE1XNDZSL1VCRVdKeGVkN1cvVlJKaW1IelJaa0hTUVR4OW0zY3h4TGNrK3Q4?=
 =?utf-8?B?M25weXFaTGIwSGs3bHRKZkFmZi9SUHdzRkdIc2htQ1ppY0tqV3BQZ3BzQmJh?=
 =?utf-8?B?N3BHY3VYb3U0a0lsSnRMK3ZXU1NUUDNaaXVhanBhVXl5RXRXYmU4RlRJeWNO?=
 =?utf-8?B?QUN6VkowTkU5RW9oM0FGMVJhSGtHNDE0TTRrZTVQZEhXblkwbFE2MHVPSkdJ?=
 =?utf-8?B?QTVKWGFLL0FXQ1g1U2JaSXdUNXdKeG5EUjRVY3pXUjlFZDQ2Z3JWWEdlc0tH?=
 =?utf-8?B?TmgzczFlVmc5dEtPYTZPcEplcWVkQzhsQzYyZFV6ZDVDWklFRzFyTTZVNTFF?=
 =?utf-8?B?d1ZyaWpFZU5SMGJrQjB5aUExdzhkdTgrS0t5a0FOVmtWRWhHZXNIdDVab2lm?=
 =?utf-8?B?K0FZYWhobDd1Tzh6Y3B1aitUS0hxRGhMZXU2UWRjOUthQ1ZYTWpEY0RISzAv?=
 =?utf-8?B?Q0JqSEIxZGdsb3N0dG10WlgvQlA0emZCeDJBZlNwOWhnZ0Y3bEhJaVNKN0ll?=
 =?utf-8?B?enZnSmQ4QnZiZnl1a0FWc01XTStVM2VwendlaXlkWnlIVC9zYnp6cTJ3dllJ?=
 =?utf-8?Q?GGb+N4NUA3sTQtWuxI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJZemRXYjN4Qmh5eXRyZWJqOUxRdjhlNW1BMWI3d3MwSUdUa00vSStDRGpl?=
 =?utf-8?B?WFp0Tyt2THMva1lGd01pd0NkeTZQNGFVUzJjZ0EvU2tFK0hJU05ZVUtIQVVT?=
 =?utf-8?B?RXBnV1JlQ0g3OEJTZUgvOVUxZEp1Uis4Vms1TXcveWtvVi8rcFdHSUhyTERn?=
 =?utf-8?B?WnU4dHlDQTNueGRTT0ZPSnkyL2JxTTd4bUJLa3RsQmZONko0c3lCS3NxUE9n?=
 =?utf-8?B?b09OT2dwdG9tY1JEZ3g5MGFjKy9nZGNaZlJjNXorTGYrbUh2WjBkVDY1M21h?=
 =?utf-8?B?Wnp6WWR5bnZ2dG9qS3h4M2pRTHl6NXdnb1dCdW5pZUFuLzdGU0VZdlRLc1g0?=
 =?utf-8?B?NW9BSFpBc2lXUnlob0JNRFBFL1dBbVI4aUJ2aXUyOEpZUVF6N2crbWFCMENR?=
 =?utf-8?B?eC81cDZOWkJxc28zS2RNYzRmTGJXanhtR1J6SHZrd1lnSUlPVzU5dm9xSk5H?=
 =?utf-8?B?M2FhRFdLam1PNkxzWTRVbzBNQzNuUDJxdzNOWmIzR3MxWFVlK0lmd2h1ZUdp?=
 =?utf-8?B?TmkzL0ZkQk9oZXM2MDRKUnU2dVVVT3pJNlZXSVJiaTU0aHBlUXBTd0RCRnMz?=
 =?utf-8?B?R2I4bUdDYVdkUytpbWJqYmEvUWxKQ3dEcHpLYXU0MnNVTWJDeEV3ZW02Sjll?=
 =?utf-8?B?czBvUi9weU50Q29POGZlVG9NdzB2RDdMMlA3UzJTUHpadGY0eEJYOHBoSmJV?=
 =?utf-8?B?em1za2FXL2ZOVkgvbWtscDRSbXc3d2prL1hmN0EydDB3eXhhNXdYSVozd3c0?=
 =?utf-8?B?VUNnR1A5cVFwZTAwTUZlbEMrQzVHVDdxL0FIaFVKRlJ5NlEvL08wOG1Ya3RX?=
 =?utf-8?B?cTdLQmpXSG1mSTA5YUN5MHlocksyMmtxL3hMRFVoSW1xVnVMaE95Vml2SnBv?=
 =?utf-8?B?ZCtUU2xmVjNCdjh0SHBqSEh5Q21nRTBWR08xOUkzZng3SFpEVXVrblp5bStN?=
 =?utf-8?B?N0g3a0xtcjFES002ck93YUg1NFRsWGF4ckZvWjBTZThiaTdQR3FwSFVwU24z?=
 =?utf-8?B?ZTJ3QW1Mb3NMRW96K01TWUQyK0pXa0loNE9NQmRuU2wrK1V1NzlNdm1sWGg1?=
 =?utf-8?B?bVd3Tlp3Z3E5Q0UydVNGeWhDdjBLK1I0bWdKYU9qdCtIc2cydlRac2xqbEFV?=
 =?utf-8?B?VVozQnkxSnNqZmxDSUc1Z01VNFBiaHZwMGFCcDRNUVdhUHFvVkhZSFR0M2FP?=
 =?utf-8?B?Z2FuRG1sVm5QV2Z6T2NTS0ROUGlXTFl4ekd6dVAyaXg2anlNWFlZNyt1NTFy?=
 =?utf-8?B?SUQ2aElyVUxGbkpvZnYyRFd4ZlRwMmRrN25wcDQ3VVJqQTc4VSt0eWg4cWIx?=
 =?utf-8?B?NVArbXJUMUQxbk9OMWRkRDRuSFNQaXVTaWJYZWZVNUVXSUF2cGcxWCt3STRY?=
 =?utf-8?B?N0xmNFNpSHNVTi9ZR1FDNVNlc2lMN1UxeHFDRzlsS05MODVjZVptNzUzQjkr?=
 =?utf-8?B?N3RabG1NWnNHSmZSaDBRTGM5aFQxOVJsU1JuVXF5WVpITnByYVFTRlh1cFRN?=
 =?utf-8?B?Z1ZHKzB6NE80UXJ6dm5kWEpMWXErWEo5cHFzTk9yQmFKbG9Xc1VuMjF6UVRz?=
 =?utf-8?B?SUo2ZVlMTEYwTGpXbEo3RHo3VG1HVlFuSkIwSkl5YWl3VU9MQUNBU0piRkQ4?=
 =?utf-8?B?RU1iTzd2aWMrT01xZjBnRms1allBNUgra2pOTWdUdzRtWjlhQ2JidzZjQlIv?=
 =?utf-8?B?ZFRoTVQwVHE2aGJFVHBmMzZRMnd2bHFtcUFqbkNwb084VDMxZloxMm5DalJp?=
 =?utf-8?B?TFlkL2MyVXpTbVZVQTNPQnZicHBjcTZ0bHFhT2NGR0g0eVltSmdaOEV1djR5?=
 =?utf-8?B?RFdIK3FsU1g4dTdtcmd1ekJEUU90QnJQVXFsdWloSVBVbVNMQWpjNUZyQlMy?=
 =?utf-8?B?TG5LclcyeC93dDM2c3daWTVETEljLzYzK1BUUllyS3ExSlk1cktrSXVVUGNi?=
 =?utf-8?B?dnJLcHJ6ak5xQzBpTkVzRlQxTmNTeDdPeUhEdXhYcW9lYkYxcFRGQWFNclFL?=
 =?utf-8?B?cXBVdmtXd0hUYUIwUXgva1daRjdPRGZZajlxa2J3bEdNc2RvRjZmL2ZsQmdU?=
 =?utf-8?B?TnBFSEdHVk1mOG9lN01na3ZIaXNqSWNsTW1GWnp1U2RCcHRqNzdVZW9jby83?=
 =?utf-8?B?TkROY0xyOE1ZTmppckFKMTVMK0ljcGJCbmxxRnF0YzFJeDJobUpET0V3RGhE?=
 =?utf-8?B?eGZzSW9jY1h5dHhxbndLV0FpZnB0QlRlYlF3a2pzZTJMeEdLYkhOblB4cldr?=
 =?utf-8?B?VUhsTjdYVUFiZys0cmpwK21Kb2ZBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541ddceb-19a0-46db-fac0-08dcabb710c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 08:03:13.1302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxJyyXKon8H0nEoLdsZZX/CydXMM9H98WfmgswahNfkKDx2jbvO2zJkq+DuTpUDUbpzVAWtpvdGEOgtv2gOdj3Zyk9XAsTD13B82VtSU0IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7985
X-Proofpoint-GUID: t65ELgOueHuOSqhB4nPGzCrKRkfbi6W1
X-Proofpoint-ORIG-GUID: t65ELgOueHuOSqhB4nPGzCrKRkfbi6W1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_05,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Thanks Zhao for quick review. I have sent v1 for this. 
https://patchwork.ozlabs.org/project/qemu-devel/patch/20240724075226.212882-1-manish.mishra@nutanix.com/.

On 23/07/24 7:56 pm, Zhao Liu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> (+Xiaoyao, whose TDX work may also be related with this.)
>
> Hi Manish,
>
> Thanks for your patch! Some comments below.
>
> On Mon, Jul 22, 2024 at 10:18:59AM +0000, manish.mishra wrote:
>> Date: Mon, 22 Jul 2024 10:18:59 +0000
>> From: "manish.mishra" <manish.mishra@nutanix.com>
>> Subject: [PATCH] target/i386: Always set leaf 0x1f
>> X-Mailer: git-send-email 2.22.3
>>
>> QEMU does not set 0x1f in case VM does not have extended CPU topology
>> and expects guests to fallback to 0xb. Some versions of windows i.e.
>> windows 10, 11 does not like this behavior and expects this leaf to be
>> populated. This is observed with windows VMs with secure boot, uefi
>> and HyperV role enabled.
>>
>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
>> to 0xb by default and workaround windows issue. This change adds a
>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
>> case extended CPU topology is not present and behave as before otherwise.
>> ---
>>   hw/i386/pc.c          |  1 +
>>   target/i386/cpu.c     | 71 +++++++++++++++++++++++++++----------------
>>   target/i386/cpu.h     |  5 +++
>>   target/i386/kvm/kvm.c |  4 ++-
>>   4 files changed, 53 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index c74931d577..4cab04e443 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] = {
>>       { TYPE_X86_CPU, "guest-phys-bits", "0" },
>>       { "sev-guest", "legacy-vm-type", "on" },
>>       { TYPE_X86_CPU, "legacy-multi-node", "on" },
>> +    { TYPE_X86_CPU, "cpuid-0x1f-enforce", "false" },
>>   };
>>   const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
> Yes, this is needed, but the 9.1 soft freeze is coming close soon, so
> you may have to add pc_compat_9_1[] if it doesn't get accepted before
> the soft freeze.
Sure, i will update it if required.
>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 4688d140c2..f89b2ef335 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -416,6 +416,43 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>>       assert(!(*eax & ~0x1f));
>>   }
>>   
>> +static void encode_topo_cpuid_b(CPUX86State *env, uint32_t count,
>> +                                X86CPUTopoInfo *topo_info,
>> +                                uint32_t threads_per_pkg,
>> +                                uint32_t *eax, uint32_t *ebx,
>> +                                uint32_t *ecx, uint32_t *edx)
>> +{
>> +    X86CPU *cpu = env_archcpu(env);
>> +
>> +    if (!cpu->enable_cpuid_0xb) {
>> +        *eax = *ebx = *ecx = *edx = 0;
>> +        return;
>> +    }
>> +
>> +    *ecx = count & 0xff;
>> +    *edx = cpu->apic_id;
>> +
>> +    switch (count) {
>> +        case 0:
>> +            *eax = apicid_core_offset(topo_info);
>> +            *ebx = topo_info->threads_per_core;
>> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
>> +            break;
>> +        case 1:
>> +            *eax = apicid_pkg_offset(topo_info);
>> +            *ebx = threads_per_pkg;
>> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
>> +            break;
>> +        default:
>> +            *eax = 0;
>> +            *ebx = 0;
>> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
>> +    }
>> +
>> +    assert(!(*eax & ~0x1f));
>> +    *ebx &= 0xffff; /* The count doesn't need to be reliable. */
>> +}
>> +
>>   /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
>>   static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
>>   {
>> @@ -6601,33 +6638,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>           break;
>>       case 0xB:
>>           /* Extended Topology Enumeration Leaf */
>> -        if (!cpu->enable_cpuid_0xb) {
>> -                *eax = *ebx = *ecx = *edx = 0;
>> -                break;
>> -        }
>> -
>> -        *ecx = count & 0xff;
>> -        *edx = cpu->apic_id;
>> -
>> -        switch (count) {
>> -        case 0:
>> -            *eax = apicid_core_offset(&topo_info);
>> -            *ebx = topo_info.threads_per_core;
>> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
>> -            break;
>> -        case 1:
>> -            *eax = apicid_pkg_offset(&topo_info);
>> -            *ebx = threads_per_pkg;
>> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
>> -            break;
>> -        default:
>> -            *eax = 0;
>> -            *ebx = 0;
>> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
>> -        }
>> -
>> -        assert(!(*eax & ~0x1f));
>> -        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
>> +        encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
>> +                            eax, ebx, ecx, edx);
>>           break;
>>       case 0x1C:
>>           if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
>> @@ -6639,6 +6651,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>           /* V2 Extended Topology Enumeration Leaf */
>>           if (!x86_has_extended_topo(env->avail_cpu_topo)) {
>>               *eax = *ebx = *ecx = *edx = 0;
>> +            if (cpu->enable_cpuid_0x1f_enforce) {
>> +                encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
>> +                                    eax, ebx, ecx, edx);
>> +            }
> encode_topo_cpuid_b() is not necessary since encode_topo_cpuid1f() could
> encode SMT/core levels with the same type code as 0x0b.
>
> So here we just need tweak the encoding condition:
Done
>
> -        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +        if (!x86_has_extended_topo(env->avail_cpu_topo) &&
> +            !cpu->enable_cpuid_0x1f_enforce) {
>               *eax = *ebx = *ecx = *edx = 0;
>               break;
>           }
>
>           encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
>           break;
>
> Then wrapping encode_topo_cpuid_b() could also be omitted, which keeps the
> code changes as minor as possible.
Done
>
>>               break;
>>           }
>>   
>> @@ -8316,6 +8332,7 @@ static Property x86_cpu_properties[] = {
>>       DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>>       DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>>       DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
>> +    DEFINE_PROP_BOOL("cpuid-0x1f-enforce", X86CPU, enable_cpuid_0x1f_enforce, true),
>>       DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>>       DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>>       DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 1e121acef5..718b9f2b0b 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -2102,6 +2102,11 @@ struct ArchCPU {
>>       /* Compatibility bits for old machine types: */
>>       bool enable_cpuid_0xb;
>>   
>> +    /* Always return values for 0x1f leaf. In cases where extended CPU topology
>> +     * is not supported, return values equivalent of leaf 0xb.
> s/is not supported/is not configured/

Done

>
>> +     */
>> +    bool enable_cpuid_0x1f_enforce;
>> +
>>       /* Enable auto level-increase for all CPUID leaves */
>>       bool full_cpuid_auto_level;
>>   
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index becca2efa5..a9c6f02900 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>>       uint32_t limit, i, j;
>>       uint32_t unused;
>>       struct kvm_cpuid_entry2 *c;
>> +    X86CPU *cpu = env_archcpu(env);
>>   
>>       cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
>>   
>> @@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>>               break;
>>           }
>>           case 0x1f:
>> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
>> +            if (!x86_has_extended_topo(env->avail_cpu_topo) &&
>> +                !cpu->enable_cpuid_0x1f_enforce) {
>>                   cpuid_i--;
>>                   break;
>>               }
> In addition to the above changes, we need to adjust the min_level of the
> CPUID to ensure that 0x1f can be encoded:
>
> @@ -7466,7 +7466,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>            * cpu->vendor_cpuid_only has been unset for compatibility with older
>            * machine types.
>            */
> -        if (x86_has_extended_topo(env->avail_cpu_topo) &&
> +        if ((x86_has_extended_topo(env->avail_cpu_topo) ||
> +            cpu->enable_cpuid_0x1f_enforce) &&
>               (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
>               x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
>           }


Done

>
> Thanks,
> Zhao
>
Thanks

Manish Mishra


