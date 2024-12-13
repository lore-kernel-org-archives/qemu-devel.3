Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87041E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8ju-0006P8-Af; Fri, 13 Dec 2024 11:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tM8jr-0006O4-VO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:42:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tM8jp-00076l-57
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:42:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDk9JQ004485;
 Fri, 13 Dec 2024 16:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=VbgYBqlXRWOr+4enqXeGlmhINwoTlphvZqObjkkUIPY=; b=
 nxY+sQYf1sRF3ylAqb9oLDzkCbeWiucEl0g6lHV6YiqR8fsQUTXYdtg3AlMN8+Jq
 +M4ZYd7i+uNLRmofkbzLB8OQaUs2ZgZhJORgpmHEk5kq3C7A6vXD7r9Wiv7R9FL3
 hB1H8hRnmo8pszkAdPwcdB9wyzLii+zl3O4V7NFxH3A7x+WTt0uIHe77cPIQEdhr
 PNq1RKlis8BIHKUA7Px0NxUPNkwSsbnCd+VykOYdgYG0raMWCRyYIgs2n9Sczgtz
 /MVQvxVcexy0C6hpmgeY9mFqKwqcaWbSYnQrwlUoOudAatNy5Unmnp4vT8xWEJqi
 vChPLlHZvDHCuXtuBd5CqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyt5pbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 16:41:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BDErALQ035082; Fri, 13 Dec 2024 16:41:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43cctm6xxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 16:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyOmg4LMXRbMmPQPL/FuCSumQIONs22406cXf+ysRzMHlNXAF7mY0dQSHuEJrr3jKefLj02+d3FIZCmMOl4m8UxdWfQJt1T3GK6uC5QIo7yNZvob7+6v65azOBi2qDtqajuXqvcgAMLOmGCMwwIH92Di7j+K0lIrvjTh8IK03s7dS4WDW/1c5kz5YjX2FOd20alKvC18m2CYTSsp9dwYA5u0/ZsOQce3cGrfXu6arlZfJbvL/YXFDr3oIgOA+zmuU4l5wVDuiv8nICWSdsR6hioURFznxGk0VJC8kPJRq/At1I+TOewPy3Ipihm4KOd0ICEduVDQJxHdQMtNAiryWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbgYBqlXRWOr+4enqXeGlmhINwoTlphvZqObjkkUIPY=;
 b=aZZrY7nRtJX3J+uanxO4CZeQ0VVBBFY7H4428/N3mxfaVP7AKtRZ+Ok4dWdO/QAh7kChEpNtMKxorYshE8hckAmBQCa/f66xO3C9a6h/BuC0YFKafqvmWuX4RXbsvUxl4roRypcz45IyC3PHMRlM2XHRnwjHftuyeievi90NYZbkBP1W4sL7gAzPMNa8ogUEKU+DZKZEvhJp0fU2E2qOHnbaKYFTQ2nB7MOxDGml+WSsKYHedFbxzOOR2xB2QqqD7mOTWThbnzQB0ZYHJIC4klxIysRbgEeH/lPKOADE+tJwPag9x1FGQb41RsuWRZN+vC6IeORzCaIRLgjbncdy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbgYBqlXRWOr+4enqXeGlmhINwoTlphvZqObjkkUIPY=;
 b=bO5/Qd0R2NCP1lRuMKeOGSA7DLOd/MQnuc52+QU3ek5ONdmcRKmN1IUhRKQNSHzHuq+yb5HibNH6QlPmfYYJ4pPk5b1W61QB8Yck+LRVDqAxEf8hb12TT4SvazdKs20Q4r5wh74ZOAaTAMrLKAz1BFigLhdODOllU6Ev21f3XBQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB6984.namprd10.prod.outlook.com (2603:10b6:510:288::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 16:41:51 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:41:50 +0000
Message-ID: <bf0e7550-54a0-42ff-a281-6a65cb1ba7b5@oracle.com>
Date: Fri, 13 Dec 2024 11:41:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/19] physmem: fd-based shared memory
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
 <Z1dIEUcSrI1aROSp@x1n> <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
 <Z1tUBUcpf1XcVRhG@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z1tUBUcpf1XcVRhG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a97348c-5201-4982-fd8d-08dd1b950b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWJWSEdIbHpkclp0dzgwZmFNc3dzcmU4NlJZVmFQSVRaazdjNVBPSGw0T3BY?=
 =?utf-8?B?Y3IyaWwrREFrUzVpVXhub2ltV2J3L0hybG9wb2E4Ky8wcEJ3dFpZR0NEeGJO?=
 =?utf-8?B?UGhZMzJEYzQxRXR0QnltdVM4R1R5OWtnaDlpQzlsTVRaSEdISmdYYm9BVnln?=
 =?utf-8?B?UUdVSFJFTEZLTHM2VVRwNGIrbFl3ZU4zL2QyVnp6YmtzMkFMeko1czRRTGZm?=
 =?utf-8?B?eFZjWWF0Y2JUdWVaM0haZ1FHT0ljWjFxbzJ0WUg2cGdxa1Zpb2x0MURrMTZk?=
 =?utf-8?B?Y0FmeDh0TTlpTEMwRmZGd3o3a0taZnc5QjVXNnhTcitqSXk0bkNGVitldzVh?=
 =?utf-8?B?QnJlTExkdGZaYjA2NEFmV3NuQ3M3MCsrdmdoYndoa3lzVWtCemhaS0tnam92?=
 =?utf-8?B?S2M1R2J2MTBlRlJ4NWRsdEVBOElDZHhsTVo0bzRCa0lNY29Ea2RtSHBRamFj?=
 =?utf-8?B?NHIrcW02alJhNHZwMzlmMGdTdUFHa1pSVnd0c21YWTgyYWZDSC96b21ZQXY1?=
 =?utf-8?B?eFBqSDR6cTY3VHp0RHA0MGh2Y2NiODZNcDJqaldwa045NlVvWFY2RlB4Vkx0?=
 =?utf-8?B?N1N1N3daM0J2dFZhOHMzTyttdTNmTTlvQVNUajFQNTF2eWVacDhwUDl3NlFt?=
 =?utf-8?B?RDJZcE8wQjBsVlUwTnBaZ2I0dTBBWFQ5ME9QS3IwQ0ZOd041RjBZamMvcVBv?=
 =?utf-8?B?RERoUTZuVUw0OE04dUhJYVBXR1F5UWsxbW1oNG5leFBpWmZTOVdMT1NZdjNL?=
 =?utf-8?B?N2llbG9kcHRJd05HU0MwSlI1SFA0b05BckhhZXowUHBhSWZ3K0grZlNjeXFG?=
 =?utf-8?B?eHFEZ0dMOUZSSWUrL2FHSmV6Rm43ZmJ1cHZRNFNmK2xETTl3V1VzR3Rra3F5?=
 =?utf-8?B?am45RTJOUDZKMEVwNU5IWWFmMytNNE16NjI0YkxjZVN0NDlhWjNpY1ZYamM3?=
 =?utf-8?B?N3JTZFllL0NCTEN5bEIvbXloTUM0U3dBQ0l4S1pONWNjTkJ3azlaVEkzL0Vs?=
 =?utf-8?B?QUE2ZVIwYWtsdFRLa002ZmlVSko4bHN4YUVGL1BsWk5OV09nNStaYm9SWGlq?=
 =?utf-8?B?ZGtrQ2c5UHF2ZzdvZmFET1F4UVBOcTNIM1NFZDJEVGRGRnUxWEhMZ2wvdVpX?=
 =?utf-8?B?dGJINDRwUTRrbHhsVnNlM2lXZW9wVzRsN2kwUjM4elZVMzY3VmJwTC9WeHJi?=
 =?utf-8?B?dDk3clFPbmVMc3NsZ2NtTGJwS3JUNmVqWDFPQjlrTURzK2FXMkdCRHRQYkR0?=
 =?utf-8?B?VnFHOFlURWgweW8vem1TQ0hqRTV3SnB4K3VCRGhWQ0huUk9iMTllaVRKbGxU?=
 =?utf-8?B?a2JRcE1Gd2pMWEdUNEw3WWhHZFB2Q0hEOVVlT0NUbXovc2lNQzJ2TExNQlFH?=
 =?utf-8?B?QUIrUlV2alRPMklqUFlFWktLWUFzNHBRNGFoMmlrNEtGZ2FSK2RXSnZpM1hO?=
 =?utf-8?B?VkNFdElGQjBWVWwybUpkd3JscGxwZVFraExmR3NoTjRyK3Zkb0xrUnFtc0F0?=
 =?utf-8?B?K21saUttNDVtNDZocWFXSXVuczlhSzhVWWVwTXpZeDNzREg3UDBFK2xpRFJT?=
 =?utf-8?B?WWtPWmNUN1Q3YmVkWC9jUmdXRTJDMmN6RDNLZXAvcTZxc2ppcFpqSUwrdTNH?=
 =?utf-8?B?WXcrQzNab1JUVjlRblR6Z1dEUUphR0Q4enhSU0kxU09wYk4raUd2bzl2MUp4?=
 =?utf-8?B?TTl5VjRCVUdLNmtKUlFmZ284YjlMRnhkV0JKbFpsL2hKcXlPc3Fsak5oNGpk?=
 =?utf-8?B?cFJmZzZGb1dpNjFtakxoZ3BhaHNOOUdGVlBMRXpZK3lMd3ZkbldNRVpONmY0?=
 =?utf-8?B?UVNPdFZwenVkeUZVU1hOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZlZjV4eDcwOGs4cWZhY0thWEFFTGp0SUJLd0duTktDcEczSUNhSHI0cnEv?=
 =?utf-8?B?VlkxR3FKVVV1MlZoYWZEZ2ZtV3pXSm5vQkdwUEl2bEtQbXFSQ0tYYjZQZGl2?=
 =?utf-8?B?NHkvNU5DTzFONmJOVE1OMVlQVFNhcXlIWDFhNldvT2JTdk1KdzBRTzdNSHhT?=
 =?utf-8?B?dFI0eGhOTkdGRGorQzBhMGcxR0JNUGM3azQrSkVsK1JSN2dwNFhQMGkvbUhI?=
 =?utf-8?B?NGNKQVNRUFpSRXp1TjJTc1ZZNGNoODBQSFY0WE1jTWZOTW82MWpCVWp4QVZG?=
 =?utf-8?B?eWxYTUtjK3ZaUXhjTHVjVG9ZUXFBWHlhNTJlMUJKYWkzY1p4enhZOWc2bUtL?=
 =?utf-8?B?VkVEMmVuMlZGVXJYOUVLOUw4QU9PSkV3ejljdCszM2FFSCtNMU5RbWNTZ2JI?=
 =?utf-8?B?UWo1TGF5eDdoQ3VyRWZrOWEzUzdYMGJZbkVqblgvUWp4MUNnbk5qQ0w4Z3pK?=
 =?utf-8?B?RUdCMis3aitDUFJwLzVZSFczaTQ1a0NKb0hVWWRlZ24xRnN2NjBuSHMyWjNM?=
 =?utf-8?B?TXBmTHpKQnJKNmZwaEZ0M09tTHgvbmpkZGhFak1HWU50UnNlaSsvYStYOWl0?=
 =?utf-8?B?Zjh3aW9yRjMxdHpuTTloU1ZqdzdjTnVTMlhGUlpxa3ZyWmNTTEpnRXFwazc5?=
 =?utf-8?B?UFMzWnI5Q3VTQWxMVjNLR2drQWF5S0prMjBPZ3JsTWVMTmI3L1RzK0JXTEkr?=
 =?utf-8?B?TTcxeVB3ai9RQzBaTVNyUklUc1ZqSFlyOHhUZU1vZERNVmlIQXJ4c3pqSGFp?=
 =?utf-8?B?b2tCZUFabk5iQlYzNGFXYklkVk5mVHJ5TWJDUXdwdkh6a1h3bHByWlBSQ3Jt?=
 =?utf-8?B?WmRGcThOdHJiV21OQmVvdkYxTGhPUXBhTklYa2p5WTZvM004RUxhUmlqWVlM?=
 =?utf-8?B?Nk9yOTdUak5RbkU5elBXUTE0ajNDQTljNy9jVVRnTVBEcDR1QlliM0JmaEJ6?=
 =?utf-8?B?NjhQUDg0c3FZcDhRVzRjN28zSmdBbVp4UHA0cDhJVHh4UnVSTFNkeWdMQ0lu?=
 =?utf-8?B?MHVwQ1ZwVWpCdnRUbVBicmN4Q1FXSlJEQlBuS3ZkVlM0d1I2a2hwMVFhVk8v?=
 =?utf-8?B?UzEvUHQ4N09vdFdLTjZHQlFHN2N2OEhyVWNqSnRrcE5odWZibXFKUkovR3hy?=
 =?utf-8?B?UkdGN3pJODN2U2lrc0R6SS9SVytqOFhxd05yYWh3N2xHM1VYa2J4RnBmUHVP?=
 =?utf-8?B?VUFFU2txRUUwWU90SEN1aTRUWVdYdHFSckxoQjZrSWpIbEJQdjJ6bnpJMFJC?=
 =?utf-8?B?ZnNDeXZqVXMrYlpuTzY4clFDOXVJK2xSQmtMY2JzNE1tcC96emFVWjJUdWZs?=
 =?utf-8?B?ckxLUmVVZWgvbjFJZlNCZGtMTlg3NTJhUjlUVmUrMXVXcEJDS0pTa1dqNTJB?=
 =?utf-8?B?MmtXUmRQZGppTHY5Q1ExVVBQWDFtQmZWdFJWckQ3N0xqalV4b3ByZGNHanFU?=
 =?utf-8?B?aEY5R0FqNjFacVJOZm81dlM4ZlVGODBhdDhJVXl0a3BKa1lMQ3AzNitqa3NS?=
 =?utf-8?B?SGFlQWFjdng2R2xVcVBBSGJvcVdtbCtQRzF3eDlZYjhVQ0NXekMwSEkvd0Vq?=
 =?utf-8?B?d1BpMGJjT0s1YjdVRmlUNTZvN3JmeE5wR3lJZTFrQUx0NHNYZEkxN0lWYS91?=
 =?utf-8?B?cTU1Zkt0Q1NyVTRQQzZ5dit6L3dMVVlSWUJOUzdvM3p3Vy9SSXp4dDhkT0dx?=
 =?utf-8?B?M0EydHRRbW5LL2ExUDljcUhkMnVudWRLd3Nqbjk2WXlMWnZlZ0MxbW5CR1li?=
 =?utf-8?B?enVjUlNkTURZeG5ic0Z0SWMwMWpUcWhoL0lOZEV2d0hEQ3dGZlF2TWJxYm1w?=
 =?utf-8?B?ZFNzck44QXVmRW9HNjkzZ3lOTzc1NWljTXBkalMxdk5sUVBKOGlaZ2k0VG1E?=
 =?utf-8?B?Y1BGS05mVTR4MTdBejB2NThlczQxbU1WU285K2RTRnZQVVNmWHViNTB6ZkM2?=
 =?utf-8?B?WnVVanUxaEJ5aS81c2VOQlYzZ1F6VmlCZFk1TGNkTkszMGdtdzdZM1lRbmw2?=
 =?utf-8?B?dmZiTlNiR3haUE1IYmc1NUllM3VQS2djNnNYSktzbkVVOFdZNGFaWWpzYlh6?=
 =?utf-8?B?cm1UVXZ3MGNKQVFtSmFwQXNvazZIS2IvcjB5ellVQVBqVno3MzNpalhVS3dB?=
 =?utf-8?B?aE5HdGNOSjMyMDRJQ2J3VkM0Y3VwZkdqNy9mcW55cUNoL2RabmkzWS9UU1o5?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ypayLIil+DxAE0LK57LmtcwoEXV52YkPHCmK+rTqz8rRnA4Td7qnwXDxfQwEjfqL2pdJBvKeCdJRs4T7l9GCL/Ojmts1esui2vlVizfI6xpl4+onoRLPDMrs3y+cyYl/ee/ewtRN01PJ8mHhmUzfE1lpv4kTUI8nzE7IDLKbiMZJqtMLxcYJ//C+qQxl92cE7ibMb2EhtpVnAPrBaPDKz+a5PxQl6Hl9OhyKH7ibdMbYY5KQ0fGLSBkHsg6NjWqVOx+c/hCy0wEUzg2opcGmsSXO/UTNbeyOftmrkXqdgZ3+PC5NTe7DWPyWrWAUDya4QXKDdiumVHWwc+UOqfGX4Kmw9r90EiedJwC6v2ooa6RZBXFZyfU8T9akivXULjRFNwK9Lkt/0lSgOTQPncCOs363z8MOfbzgk4xDeLxYXLGvigXLhT8CJgBaVf35JR3PXNfDMfzKXxZSMBB0x2rq005QTS6iFEMvgz9mx24faNuFwaNYBM2OqaoIsEQS8XOorywjBYLMdqmdU036cwdERD9pqMxyrlI0MuzlHrzGimosMf4q1PBsFyXGchUyyQQ5kx6N90CIs2p9oRy53Z87VWrRhTC2e32RLVxsC72svNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a97348c-5201-4982-fd8d-08dd1b950b0a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:41:50.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9JtOeUuS09+c4hplgvsTP38azRE2bg1AcyNgMwGhpPIRoW+EGMpMpcdpaNtBydAyLE0LbKybA3YJcZxVzQ7zVGC+sYvNjiys8Y3mAcVRJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_06,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130117
X-Proofpoint-ORIG-GUID: mf4ZiSIV8jvFnOpLe6XKl7P1C9tRsGSw
X-Proofpoint-GUID: mf4ZiSIV8jvFnOpLe6XKl7P1C9tRsGSw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/12/2024 4:22 PM, Peter Xu wrote:
> On Thu, Dec 12, 2024 at 03:38:00PM -0500, Steven Sistare wrote:
>> On 12/9/2024 2:42 PM, Peter Xu wrote:
>>> On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
>>>> @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>>>        new_block->page_size = qemu_real_host_page_size();
>>>>        new_block->host = host;
>>>>        new_block->flags = ram_flags;
>>>> +
>>>> +    if (!host && !xen_enabled()) {
>>>
>>> Adding one more xen check is unnecessary.  This patch needed it could mean
>>> that the patch can be refactored.. because we have xen checks in both
>>> ram_block_add() and also in the fd allocation path.
>>>
>>> At the meantime, see:
>>>
>>> qemu_ram_alloc_from_fd():
>>>       if (kvm_enabled() && !kvm_has_sync_mmu()) {
>>>           error_setg(errp,
>>>                      "host lacks kvm mmu notifiers, -mem-path unsupported");
>>>           return NULL;
>>>       }
>>>
>>> I don't think any decent kernel could hit this, but that could be another
>>> sign that this patch duplicated some file allocations.
>>>
>>>> +        if ((new_block->flags & RAM_SHARED) &&
>>>> +            !qemu_ram_alloc_shared(new_block, &local_err)) {
>>>> +            goto err;
>>>> +        }
>>>> +    }
>>>> +
>>>>        ram_block_add(new_block, &local_err);
>>>> -    if (local_err) {
>>>> -        g_free(new_block);
>>>> -        error_propagate(errp, local_err);
>>>> -        return NULL;
>>>> +    if (!local_err) {
>>>> +        return new_block;
>>>>        }
>>>> -    return new_block;
>>>> +
>>>> +err:
>>>> +    g_free(new_block);
>>>> +    error_propagate(errp, local_err);
>>>> +    return NULL;
>>>>    }
>>>
>>> IIUC we only need to conditionally convert an anon-allocation into an
>>> fd-allocation, and then we don't need to mostly duplicate
>>> qemu_ram_alloc_from_fd(), instead we reuse it.
>>>
>>> I do have a few other comments elsewhere, but when I was trying to comment.
>>> E.g., we either shouldn't need to bother caching qemu_memfd_check()
>>> results, or do it in qemu_memfd_check() directly.. and some more.
>>
>> Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
>> and qemu_memfd_check will be called more often.  I'll cache the result inside
>> qemu_memfd_check for the special case of flags=0.
> 
> OK.
> 
>>
>>> Then I think it's easier I provide a patch, and also show that it can be
>>> also smaller changes to do the same thing, with everything fixed up
>>> (e.g. addressing above mmu notifier missing issue).  What do you think as
>>> below?
>>
>> The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
>> which buys the xen and kvm checks for free.  Sounds good, I will do that in the
>> context of my patch.
>>
>> Here are some other changes in your patch, and my responses:
>>
>> I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.
>>
>> However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.
> 
> I guess no huge deal on these, however since we're talking..  Is that
> QEMU_VMALLOC_ALIGN from qemu_anon_ram_alloc()?
> 
> A quick dig tells me that it was used to be for anon THPs..
> 
>      commit 36b586284e678da28df3af9fd0907d2b16f9311c
>      Author: Avi Kivity <avi@redhat.com>
>      Date:   Mon Sep 5 11:07:05 2011 +0300
> 
>      qemu_vmalloc: align properly for transparent hugepages and KVM
> 
> And I'm guessing if at that time was also majorly for guest ram.
> 
> Considering that this path won't make an effect until the new aux mem
> option is on, I'd think it better to stick without anything special like
> QEMU_VMALLOC_ALIGN, until it's justified to be worthwhile.  E.g., Avi used
> to explicitly mention this in that commit message:
> 
>      Adjust qemu_vmalloc() to honor that requirement.  Ignore it for small regions
>      to avoid fragmentation.
> 
> And this is exactly mostly small regions when it's AUX.. probably except
> VGA, but it'll be SHARED on top of shmem not PRIVATE on anon anyway... so
> it'll be totally different things.
> 
> So I won't worry on that 2M alignment, and I will try to not carry over
> that, because then trying to remove it will be harder.. even when we want.

Yes, currently the aux allocations get QEMU_VMALLOC_ALIGN alignment in
qemu_anon_ram_alloc.  I do the same for the shared fd mappings to guarantee
no performance regression, as some of them are larger than 2M and would
benefit from using huge pages.  The VA fragmentation is trivial for this small
number of aux blocks in a 64-bit address space, and is no different than it was
for qemu_anon_ram_alloc.

> For the 2nd.. Any quick answer on why explicit qemu_set_cloexec() needed?

qemu sets cloexec for all descriptors it opens to prevent them from accidentally
being leaked to another process via fork+exec.

> For 3rd, tracepoint would definitely be fine whenever you feel necessary.
> 
>> Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
>> and not fall back, because something unexpected went wrong.  David said the same.
> 
> Why?  I was trying to rely on such fallback to make it work on e.g. Xen.
> In that case, Xen fails there and fallback to xen_ram_alloc() inside the
> later call to ram_block_add(), no?

Why -- because something went wrong that should have worked, and we should report the
first fault so its cause can be fixed and cpr can be used.

However, to do the above, but still quietly fallback if qemu_ram_alloc_from_fd
fails because of xen or kvm, I would need to return different error codes from
qemu_ram_alloc_from_fd.  Doable, but requires tweaks to all occurrences of
qemu_ram_alloc_from_fd.

And BTW, qemu_ram_alloc_from_fd is defined for CONFIG_POSIX only.  I need
to modify the call site in the patch accordingly.

Overall, I am not convinced that using qemu_ram_alloc_from_fd in this patch
is better/simpler than my V4 patch using file_ram_alloc, plus adding xen and
kvm_has_sync_mmu checks in qemu_ram_alloc_internal.

- Steve



