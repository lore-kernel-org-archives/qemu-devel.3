Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A64C5320D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seyeK-0003k3-TN; Fri, 16 Aug 2024 11:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seyeJ-0003jW-Oq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:13:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seyeI-0007aZ-4a
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:13:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GC8t2V004054;
 Fri, 16 Aug 2024 15:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=dzmVFLG/1acoHC78BTYhL4PhlEzfmZyRZGZFtp8VkIg=; b=
 llcUj9gX9CVib354sCwWTLCEgX391BoTW+FUCG011FwcHk8cwUa3dLiIFyR16tST
 L+xwra8Iwuqrj71hMSRncdPsmU68LE075OBnKZ2Yhg1YmVyfxoZFYWqDjTFN7tQW
 X07YZNg2zq3IxZFnMfUyIUpHOKfN6hsx1gJr+MgFdUUNkNLHu1Af5lONXikSAguu
 GEDvbRqsMVr9Vej0N187+DFN3q+ZXDgqqsut4JYGykWevPtYlJX1fWHThAJq/+wm
 EzFxRHVJi+6KqCSgJ1fvKLHz3ZozZKmDAbvFSILpKxxmg6eMkEABtQTVhv9Mgt1/
 /bU2IOYotlaeO5oIO4cFwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtvryd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:13:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GDUuF7003324; Fri, 16 Aug 2024 15:13:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnccx8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvRk2fbfK5rCwpJcRonNuGsqq1BdOUlqno7u6liKJ0i3wPxFFYpvEHXjOA0uRERbnw19Hzy1MTHwORoUxH+M5+rT/yB4H6SfdG7p2d39xu9K1R7CELO4V6BtOPFOqeFgEq9PRawh2G8vHlqmFMGurpM5aLhXm5yRwkSteYOdnEi4+31f8MMCU/DfsoswV/5nlOJX8gUnh5OL49pieVNM1nK1ozWZYTn+F9oOZTPn5sXUHgIVJq7vOWMXKHUy1LwnxXZCoRL9iEKbaWcsz8Sz4bZcRo4S8lkKYESLMo+vt81sBRiZwzH7WTc9XDxAKkmzYvzKERvASysuyFzPcCqnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzmVFLG/1acoHC78BTYhL4PhlEzfmZyRZGZFtp8VkIg=;
 b=o2ohF1iBVWbFObc9Ztru0l0Nwv7BmZygN1rb9X0LwCtCe0IUGgMhN4Duswt/inEtM0c2k5QGEGK00Hw0AIIYKRPtMzQad8FA14lQZPP1b9ikNzoeMcBa82umgvVSMmvCYa3IqfTvc+O4V2gZ5cqE4L3JbyyTwCEYt1xm5I3Sc94PGCLVrfarNu+NforiQS/8uCIqB652o84XAa/9VJlmYPlEruC+MNqjSBmjLNQKqD2MeTx5LPl8f+2mO+Jo2aRUBGRsatJmZyJgL4C5ghejUUWetL8ORvejeKD5TLwLYGyKQMwIIxTrBBcrDIQpbXE9v/8KKK4jMoK4nporgz+uJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzmVFLG/1acoHC78BTYhL4PhlEzfmZyRZGZFtp8VkIg=;
 b=ceu9LmUfAfHL5vUCfYYh3dzhyxOI0YHs/WYC21I2H9HuIQU+0axpcg3qfFFRmZkif9OXlqm+F8KHceCtNifJHOvryfoMeBNF22WAF2ZTNdIv2fqwprEsPiWyCjbIJSa3zKEPstmM/ybm1QcEDnvsLd5j96asfVZz+yMfY7brOLw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5667.namprd10.prod.outlook.com (2603:10b6:303:19c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 15:13:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 15:13:48 +0000
Message-ID: <080a81ed-67f5-4444-8cbd-5516a4beb6bc@oracle.com>
Date: Fri, 16 Aug 2024 11:13:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 4/6] migration: cpr-uri parameter
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-5-git-send-email-steven.sistare@oracle.com>
 <Zr5pL4vPTi0sSFgU@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr5pL4vPTi0sSFgU@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0977.namprd03.prod.outlook.com
 (2603:10b6:408:109::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e243e40-1b79-4f21-0ea9-08dcbe0607b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elViRktaUXVpd2U1R2VnK09zeHJuYjVhMXF5bzRtVFhLSUNLeDcxZTFlWmU3?=
 =?utf-8?B?R3BtaDdKZzdwQUxNenczYTFaYjJ3YXh4ZGlrUzV5b21BRmpjRGR3cm4yRjlx?=
 =?utf-8?B?aVVibDBSU2FvUjlVdGR0cHdUUWlUVzNYcjQwcmVEMnlLUWV1cTJ6SXp6MDcv?=
 =?utf-8?B?L1RvTVB3QU5pWEpoN1pxZHFSb2lTYml0cDZSdjNKMnQ5RWYrbHdvK09jaTBo?=
 =?utf-8?B?THl3MjVxc24yVldUclpyRE1pZFUrakxwT25OOXhyYzR4Y0UzWUdQTlpTK0lQ?=
 =?utf-8?B?Mlc5dEhWdlpCSnZmMlhtZUE5SUNUbHBEdnZxdXhEaDJtMnEwT25tL1RkalNq?=
 =?utf-8?B?WDEybHlyc3A1SzN5blJyRXMvcjI2WUNIbUwrL1dRb0M4SmZydG5aYmtIdHRT?=
 =?utf-8?B?R1dqVHJRTk9oaFpxRUxDQlJJbXFMVHJTeDNWN3ZIdWlMNFBJOVV5aVZCLy8z?=
 =?utf-8?B?d2kvdjNsYUxHZ3dQRklseEpYRXRMTmQyS1BpYzhadGJCR1lRaEppWWFzeUxH?=
 =?utf-8?B?Y1BRTVRtRDNkMEx4aXhpeHBjUnI5MGdIOVRjekJ2UEVHNEU3QmNhUDVodU9z?=
 =?utf-8?B?MFFjSXJFb1ltLzVVUFVlRnROTDJJbE95Q3NmR0NWV1pDak9EM0pxU0tYQ3Zy?=
 =?utf-8?B?ZlBuYzUzNjd5bUd0djNVdzR3djJqUC9RNkdSVEorUGtqZk8yM2s2RU9pSGF5?=
 =?utf-8?B?K25mWGpVOTdTR1NzWDVYNW5uNERtK3BpaUtZYk1pQndIZEVTU2haWTF3Z25Y?=
 =?utf-8?B?a1ZmYzBLR2ZXVnNZblhFMnYxYTF3VDNOMEFiaERhazVrMTlzL1c2NENKT0ox?=
 =?utf-8?B?RisySGZoQU5pMjNVQW9leVM0bTlETWh1STN1RkZZNW1XUGxNb3ZLZXplN1ZF?=
 =?utf-8?B?NzRwbmhnZlB2U2FOMGFlc01sZFRoakQxU3JPQkZLQzYyb3lHbCt5UEZKMVJB?=
 =?utf-8?B?dUorVnQxSW03YlJpbWxNSld4T2V3SXppZEc0Rk1aS1dnUkp4ZVVxY2FWcWxL?=
 =?utf-8?B?QlpLclk3NkRqaGNKb1E1R3FwR2dLeGh3eG1KYlBNVzQzTkpPSnYwN20yVkFK?=
 =?utf-8?B?S01iOEFKR3BlRTg1bXJPR2N3NkxZMkNtcjRuOEM4c0ExTkFvRW5Na3lkbFVa?=
 =?utf-8?B?ditzR0dpaTlhNzhEV3FmVHBwN0JlV3kyNU5FZXFnMnhJbnZRTzRmOFBOQmVT?=
 =?utf-8?B?WFVlMkxMWUowa1AwT0lXRTFpYkVUZDVoQnZqTGI0aFdtQUVCYU1EL3dFQkZ2?=
 =?utf-8?B?ZXBJVmNrYTVWam1RODFhekhMZEgrZGFBbTFmYW9BN3ROV0ZqOW9WZXVtYXZI?=
 =?utf-8?B?MXRtaFdWNWxSZ1BkUlhMZmVCYXpldS8wQ1NxOS9iY3gxWkQ3M2Y0N0xxVlJr?=
 =?utf-8?B?QXpFd05ZbjB1T0JwUVVPVi90dVgvd0JqSEhNQWxxUnJyNjQxSysvRUFrMjhx?=
 =?utf-8?B?eGxpZ3hVa3RBOFVIcTVtck1XRDkwdjVITlllQll1cGhTNHdNN2JjY2RFUFhy?=
 =?utf-8?B?eFhlQXAxbTRPTUtYaFJDRlFHd3p6RW5VUFdSM2dhUHI4WlpEdW1EK1gzOHpD?=
 =?utf-8?B?YzhtMHlWTjRCUnhsN0FGbDFMUUxWMm1NT29kWjB3Z05HTHVJL3FIZG5JK0Ey?=
 =?utf-8?B?YTNjMmpBZ3p0TWZsdDE0QU5GSUNiVm8zSGZFczRpWXpKb3BEQlIyNGdtVmRH?=
 =?utf-8?B?MWoybytmTDBIdjNmS0dIVmkwa2NnRnVuby9yOXJpblA4dUorLyt5WmVFemVH?=
 =?utf-8?B?YXdYQnFZajdsbnFGZ1R3cWdZK1Vwcytob09FaitZVmpCNzhTQVNkU3MycDJ3?=
 =?utf-8?B?d2lPQUVHd3BjV1hZdklGZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05FYUJBcW8xSUVTYTFReGsyV0N0QXpYNmYwR1FEeTRQSFE4TjQ1RVVvYnRO?=
 =?utf-8?B?a2xjU0V1MTRvMXR4Y2pNdHlqU0M0dUlGWW5GbHp5N09CYTBkUlQzdklXYnFl?=
 =?utf-8?B?eit4bWJHOGE1RGJPNkxyTmhmRzBhTVE3U0R2NFp0aGpnYnpXNkJ3Z08zMGpp?=
 =?utf-8?B?QjlnNmtiNTY1R0IyUnlzSGQ3d0ZFQ1pXQ1o5RlMrUjNxaGUxZ0RpRE9obzZI?=
 =?utf-8?B?a0QvOExQbGljdm0zUmFrVlhaZG43enRYZHJ5V2VlNW43bzEyenAwOERqWjJZ?=
 =?utf-8?B?VkJ3TjMrTndITW93ak1WTFhybzNDdkVETGdBb05YT0JJVHhVaWZtY3lmYjZN?=
 =?utf-8?B?L2VSaFJTbVp3T1FUVkZrUmhGVXJSNzBoczArczlTbGlHVmN6SmorNnVFcUhW?=
 =?utf-8?B?TjZOeXlscXdaaHZsN0dqZGM1VGJvNThFYlZ1bEZLS0JyU2FraUZvZjRRSjdU?=
 =?utf-8?B?R0ZmdjVHb2lTcnk3aFptU3hzMkJzRHFGNkN2WWRLeWE1YWNNa0lVeUoxemdD?=
 =?utf-8?B?L3hXUkI0cDlhdSt3Umh5a1E4UUNTYTdURjFlQmtuOHVpaXI4WndpQXBBbmYz?=
 =?utf-8?B?aDljZUlYVjg3akxzb0RCaFZiNThJRlk5M29CU05XYVlNLzVETEFNTFVYTmdM?=
 =?utf-8?B?MXVwTFQzY2NtWElRY1RnTW9HVExTNzFVV0pHOXhxcURTTVZ4OThJZTZPcDdE?=
 =?utf-8?B?L3F3cmYwTDQ1RVdtNnpra25TdkIrZWdXRTRBcnczTHF3M2NhZXpjRENObkRy?=
 =?utf-8?B?aTdOS2d2QTZabkZJbGU5b2xlcHl6Z21xQkkwejkweUJBUVo2ZFZ4Tms0cnRM?=
 =?utf-8?B?R0c1U2xiV1RjSzh0aEc0Z25VOHdvbWpkMHRxUkd4ZFVxQnE2VVZTVkhrZDlG?=
 =?utf-8?B?ZXU2Y1BxSUxjRmkvNk1BaFB1VDVQSUUwSGo5cFQ3bXFad3JkQTFXcnRYYUNv?=
 =?utf-8?B?b25ldWhjM05wZk9VSjIxQXV4eVQ5ZWRRNW80U29JRGJ3ZitMdEZEQ29lRVln?=
 =?utf-8?B?SFluOTY3SStkaEd3RGYvdGIweG52eHBNZkJqeWdLSFdJNWx0bEpYZGhMY0xJ?=
 =?utf-8?B?Uyt6UWpTR0FSbnIzRCswa1drQy9RdERWenQ5TXEyR1FVTmpSKzBPbTJxUFVJ?=
 =?utf-8?B?MmpoamFNMW5ua2ZacWtVb3hNTjd4VGh3VCt2VzB4V3FKa1M1M1JsdDlnbTNn?=
 =?utf-8?B?TWVleWU4SkdIZmFPYmZ0K1c2YzQvZUMwaEUxcERMc0RieW45djZrNkRpangx?=
 =?utf-8?B?QWRWanFISVlIcC9xZGtENkRENXdNK3lyTy9kS25OcmhwUHVLZFZEaDA4cTN1?=
 =?utf-8?B?Z2t6Ykp4aGxHVEJmZGxHQ1k4bnlPa3dPNWMyMHJnQzNYc3FxZGIrNTFvNTI3?=
 =?utf-8?B?ZFIxM2wzSzdXa0NiRVkxZm9ibzJHdUtLZzk5bk1qUUtHRWlXdnVJai90bm95?=
 =?utf-8?B?RmlLbFNTUlZTOUs5R3FXdFdETlEwM2RsOXhkdHFqMGdWck9hYjRZSFB1T1Nn?=
 =?utf-8?B?emtwUVBLOWNmdnNPVnhHOHNaMGhXZ1BwY3J6aEpBeFJHTjdKUStCZlNxbWhZ?=
 =?utf-8?B?RTFHY2JMTXRQSVBucWZqZkZjOC9wTUpJUURYNzNrS1JHOHZ5bDFkOEVwQ0Iy?=
 =?utf-8?B?cEQ3dXduLzZaZlNXRWVzMmRPQ1JLWnRudDE0a3pvd1JlYXhUK2hqQmtOU0hR?=
 =?utf-8?B?UFJPdm01Y3Rpd0RodTN4NVNQZmkxdnNhWHRKamxNbjFmTDAzM21WSXRvZGo5?=
 =?utf-8?B?TU5tb3o5d3pMR3Rkd0RjcitQMWE2bEo4MXpZQUdWK09BK0RxSUQvbnBqaitQ?=
 =?utf-8?B?ZkdkUHVpK2dGbGlNMGovaUpjbmI0MzRpV3pPTHFKQTZxN1Bab081eS9VckJB?=
 =?utf-8?B?QmMvL0UvUVIyUDN5U1hmRmVyOC8xRzlzbXpZbHRxdHpBY3RXNjBVbkZCMlNL?=
 =?utf-8?B?b1VvNG5ha1JTZlFvWU85b2dtWXJtYWhXUWJpS21sWklGV3llYTgxdzRvV0VC?=
 =?utf-8?B?d1FzeHc0N2hOaXJaRW0xQmF3TFpLVjBtSE9BczdDRjhUYWwvRFA5WGE1K1g3?=
 =?utf-8?B?NWxWamF3dUk2Rk96QlJKNW1UVUNieE96VGdOYVZDRS85U2VyTFZzRXF2VWJi?=
 =?utf-8?B?cEpEeWxLTmhSSWF2KzgxWFk1VGI2OS9pWkNGN3BFdnI5YVZTM3AzZ2tOTSs3?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LYCZeQBRX1cgxr924QiKGryYRr462PwR1eTE4x0H+DZYfRGmL7p3YaKu/F+v+ekUDKr2j74kc0X86EC30WA75pskuLZYf7YdXs4SCtqeE4VsWyVGSf1BLqltpMkrSm5IIJ5s4nsf5cEe4uCGstVZKRsb4vZc/kIme8BFBlk/7R16r/9bQKA/X+NTOeT0ceKSA/1CvNeAycoPrekCCZYleQQdLoSfjSQgLsUhJ5w6VKLPly7kv+RLQccK1aapOa7kSgqOKEFq50qvqmvSAc+r9hPscKSbnrtUTvyVuhwrz6hWBnA7q30VYagQ6UfQyQzVjKAb5UBh20s50sSHlwuizFa6n8tPJhutbG/CebsythA2FKfGYNBSqLIjETuAU8OAzbhu2Sw09Nf/nY58kzKADoDXyy/OPn4XrOXxq/lknoR/5Udcz/1JHz7Cj5XpryWSrYvyLe3LVB14mfRocxpnHXPD6kKdWaOzVn6eI+QhEzIsRJRx+cNoTq3i3tfDoWJ9k1gycCO8FHPQcV+V0dkQEHUMAwAE3hDYY9yFupzvEuCZiGwMYoC0r1gcKTSC5h2bJptJ3/NMxr1T0fGNdpgEZwGmt3Rr3fB/vbQt0TjJKqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e243e40-1b79-4f21-0ea9-08dcbe0607b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:13:48.8765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irLd/1fyBYQz5kLD4tu6zPaEsxnR0c2TrZx0F2F92ZY24QXspLOI9hnfL7FTvpxlAis62dIpcR+GLofljVM5jh+boRLPoPSdWDpfTFoAzTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408160110
X-Proofpoint-ORIG-GUID: py4A7KGVG7IMRgb26YtwZ0cRXSo6r4r-
X-Proofpoint-GUID: py4A7KGVG7IMRgb26YtwZ0cRXSo6r4r-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/15/2024 4:46 PM, Peter Xu wrote:
> On Sun, Jun 30, 2024 at 12:44:06PM -0700, Steve Sistare wrote:
>> Define the cpr-uri migration parameter to specify the URI to which
>> CPR vmstate is saved for cpr-transfer mode.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> So I left the idea in my reply to the cover letter to reuse "-cpr-uri" in
> qemu cmdline on dst node, and I wonder if it'll also save this one on src
> with the same idea.
> 
> In general, with cpr-transfer we always stick with unix socket, and only
> one pair of it.
> 
> When migration starts, cpr_state_save() dumps things and cpr_state_load()
> loads things.  Then the socket gets reused on both sides to be the
> migration channel.
> 
> IIUC we can already reuse QMP command URI on src so we don't need anything
> new.  On dst, we may need "-incoming-cpr" to tell QEMU we need to kick off
> CPR early loads; it's a pity we don't have way to specify migration mode
> there, otherwise IIUC we can even save "-incoming-cpr" but reuse "-incoming".

I also considered using the existing migration URI on both the source and target,
and accepting it twice, by defining an -incoming-mode parameter.  But, I still
think it would be a dis-service to our users to eliminate all flexibility for the
URI type.

- Steve

