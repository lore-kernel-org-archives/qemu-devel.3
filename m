Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5787ECAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kDw-0006Zt-In; Thu, 25 Sep 2025 07:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDN-0006So-8J; Thu, 25 Sep 2025 07:32:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDD-0008Jw-S4; Thu, 25 Sep 2025 07:32:44 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P8WZu8157258; Thu, 25 Sep 2025 04:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0FFrWX8eFq54xnmQZQNYM8XniONI4szNt20t1Bm0Y
 ek=; b=xVJLrElI+cAhYmVtYJX2DUrMGkqwBxEvi55DRGI9Jfvmp30j6fGa9v2QB
 xMih65JXq9+2zOvpCCRoHPgbR/B/uIX0P88dP11mRQeuCxpSSUL2LIwz9vCJeiS1
 w2OXfwZm701S/NuYyuqKxBwbsVO7vO3VBRg8oq+WQ+X+xK9qCnrGIKmdvdsj7FBD
 wDZJzZH3Mo++zxr/GPg5Bdtkdbf4nG2shwaYT0g8OHccPZe677WNTO4UPYruLJgB
 uQdLHd3v4HOqGuSM2dZOM04AfrocS0Wva+lXgmkBmKexLIAWGx2p9L9hWsi14W5p
 pcG9kg1ELCeR6yVvzQif1k1i9sW0Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021112.outbound.protection.outlook.com [52.101.62.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49d2aprcdf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYu5hOb1Y4uY8m4AO+qnoHsNrkEou8xJ/C4CF3n7CCYVnGDd0SEnFGSCLocsDhY+6GTylkVdN/IL6BN6mcGvkOdkuTFnTBC32g52dOEppdSmna5ygCeR6A/gpnSHBW+g4L2t59jE9hRlI+qmoGeXGCFoMxVUvs8R10Vi9y1wbSRKFgkpz7HDcWiFvGkkaJvYkTcduHSQ1Y5dawxwgCrxwg4lw3hNQ2zB/OGjEsY9u31PKB5iaYHFCOzqF/jGpGb9rCpCEjnpqlt8nWkwKkMeUUuf+pdrF7cTOPB+YgPPaIHcC56WEsFTL6roowzezruQhZFUHg6W3pBJn5zH3fVRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FFrWX8eFq54xnmQZQNYM8XniONI4szNt20t1Bm0Yek=;
 b=DYxc7IHcyA3g/X3Y/4GdZRLKmOq0o5pDXnFmsbCBF+xz/9ygTw8Owdxo5BrxTgT5OWvfw/NE+JG8FUKWAaDuombn2kLzHaFYDKMb0tCLkkRBhjyBVYnjxIuzka9BHxcpLHFdU29cgoJskB98PCP1HJIJ1m+Rgf7zkniykAE7zEdAIOPZw5bjsqhAobSM1oJy5rUw3VmLOyh9qYmKO7QT4p/5TM9YLCr5t4RS1i32ebS0SXnIaA0OtRooof5tWMV+dKUqG4WQ8Lj9K1VRasfHnrIBAyOV0WsgYujLqx5IOe6n6uO5U/tpmsMUrBwfuQGSYwizsXTrSocvSr2sCTEBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FFrWX8eFq54xnmQZQNYM8XniONI4szNt20t1Bm0Yek=;
 b=vxNL6V3r5TitY4qjwtADa8GckMyNmOGfcAIM4HgwSUAy0RUqiXe0t5etadLah/4hF3S1zcwYqaoVA6xERVx8eyKh3Dl9GZ/stn3eoHnmK91ffCHNVaQXUeYt9fH8YYGMUudBy5hKFLh6wNWgDtWUfqR6d4iOMwl7ELruKsEUl730uvK4hijlN0JRwGUnJWdin8nbL81vOMmFduxrsBjZ/D/GYiOyChmxOQ7f3mDanZ/JpY3xlCIuP4ZOjQfYbcL0zcmnJTQrZ3YMG8O+aAVougpEUOFPvi+5Q7hEyD/K7XEWmDvcQNSVu2zmjCCn9Z+zXGVriC2PRqwLFsO9oaGPAg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 07/28] vfio/iommufd.c: use QOM casts where appropriate
Date: Thu, 25 Sep 2025 12:31:15 +0100
Message-ID: <20250925113159.1760317-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b390f0-ffbd-47e5-2b12-08ddfc273477
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTR5ZWw5UDArYWZGNThURzJzREdqRWo4UDlhNXQ3ZE1lK3ZnNzYxZFlNMlVu?=
 =?utf-8?B?c3pyc2dhSTc2dDZ6MkZ3dGViU3JUU0NmU0hPY2NLN3AzdENKdjBpTk9yNnhX?=
 =?utf-8?B?blRvc3NXQ2tWMG1ucFV4dG9Ua3RuUU01QTJSaUhKdGJKbGtJaHh2N3cvb01B?=
 =?utf-8?B?MUkvVVkrcHZiVEkraCtndDJqdFBIR1ZHTzA2YXp5cUlWbjlQOU9qOHFDWlF6?=
 =?utf-8?B?L3pZajRJTlIzWGY2eE5Bc05abEpTRmlTMmlwbEw5OFVvVlBlTVp1QnRaWTNE?=
 =?utf-8?B?MVRncktFNzMwOTFGNFpNL2x1L3A5TXVoMWdtS3FLaFpEZjcxQkxPOFlXQm16?=
 =?utf-8?B?ajh1L2pNd3VhRTk5UU1PMklVaDNKbm5jd3locUl3NlhnT3lENFpLVm1NQVBv?=
 =?utf-8?B?NktSSU5uVWJLa2Q4VnArckVUNHZ0VVJVaWhXVWFDS3pvdXkwTVBDVDRWTllU?=
 =?utf-8?B?MnhqS0dpOTJSbnQ2R1QrKzk1dWZQenBma3hzZDQ5a0ZtMkpZS1RnVGNYekdq?=
 =?utf-8?B?SllHblUvVW5NYzltSjhNQmVucVp4V0VsT0xTTFlKRHZQQ0NMT3RqQTNET28v?=
 =?utf-8?B?a0d4OU84YUNxSmpEN1lvRXpNQVhnRUhMbENFOXpTTDNETzcrVEs3K0xYZE9G?=
 =?utf-8?B?aWNHd25rTHBpUkxMcVBEcG42S1lRdzA2WlZHZlVYdTdRU0RLOVNNa2gwOEh0?=
 =?utf-8?B?RnkwWUwwVTI0UG9oWnNIYmNkQTFCNERyV1BqQmNId1VNZDRwWW40NTFUck1E?=
 =?utf-8?B?Y0QzS1hjbzJhU2swSGdxdXJZM0wxcFBwZHJuN0ZPRW04V21BK2NHNEFiZi9k?=
 =?utf-8?B?NUtDYlRYL1NoNTJoUjA2bHBoQkR1ajZkSVh5ZlU0TTlwUHRPdC81NCtzQXRi?=
 =?utf-8?B?NDdOajNqZU5ZYnlsQkVlYXJVMU5HLzZHUU9jV0xIUkdBdzk3Y0xiSFBuNVhX?=
 =?utf-8?B?aFBTblVKdFczcmxKK3hXRjFNTXd4TlNMazc1RFRqZ1ZmWmVtUU1DRmU5MnZG?=
 =?utf-8?B?K2FHdjJwK3ZvbjdzcEM2UGJQbU5jTzdzM3lPc0pNWGxSVDh4WEJWeEhsSDMy?=
 =?utf-8?B?aVNvR0N3dzFPOHAxNWRUMjBxaEVwdEMvUEhjd3puUnVHUmp1Q1dHaDZlUS9N?=
 =?utf-8?B?MmNBc0lIY2xRdHA2RVgyZzJrMmpjZ2JhY1ZlWEkwQ3N1RkVpanhwUmZqVUJL?=
 =?utf-8?B?YklBWmdGdkJRaGdoazJlUjMwdG10VzhkZ3Rzd2Q0U2hXS3RPWkNUZVhoU2Yv?=
 =?utf-8?B?NHY4MGtVRDFvZERkUG1hNGx3ZGdDT1kyVmNmUzdoQi9pMzVqRHQ0THBQdGlK?=
 =?utf-8?B?VTl1anJHSGg4YnJSNjRQYko5c1U3ak1EMmFBTG1FbWVrTUp0cGRmVk1OV0Ev?=
 =?utf-8?B?b1BTK1UwV3pyL1dtK1lLS3VqMGdkanpmZXNLY2JwNW5HQVFFN1A4Z1htRGMw?=
 =?utf-8?B?b0p1dU5DUXZlRTNDY0hRV1ZrbUk1VktDbHpxbkwvcW9pSnlEU1lacWNyMkRh?=
 =?utf-8?B?WGpwN05TVnZwb09ZZXFJeFlmdXlqbGlNTGRESFVxdkNIL2pndlhSNmlLd2s3?=
 =?utf-8?B?b1l0MmhPZ3pLc0pRMGlpaUNFekM5RjhRaWVrQy8wc1ZwVUlwSjZNb1QxSVls?=
 =?utf-8?B?RjNkMFpBdjM0a0RMR1g3K0lNUGROM3pGa2RFcWdIZVNMelNZZUF5Q1E5bTZx?=
 =?utf-8?B?OWtBdGJEK3h4RnRkUTZRakdUWVRBYjZ1dFNLU3VNZENSbG5MaUhHV2pCME1S?=
 =?utf-8?B?eGp5WUp0aDRsRlIrZXJDMUhId3JCcisxenpMNUo4UDVKdnFpWVZ5ZXNlNDQr?=
 =?utf-8?B?Y2pkTDdZVVlJUHJIZ3JvTFIraHg3WGlBN0I4a2lxbGIvQUhWbGk1UWR5cG1n?=
 =?utf-8?B?TkNRQTFjWElCeUlzMDZ4OW5OR3F2SHIwdnNTdHc3SGZYSHNoK0lDZEFLUTdl?=
 =?utf-8?B?Q0V4T05KR2FRc0o5eEtFREY3S2lGMGRhZi9YelZ2SzBTalNNYUoxeDN3VUwy?=
 =?utf-8?B?YkdkRXNrZ0V3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1hxSk5sQWNRTlF3UUdMNk9LazVJL3lIVExrdi9TYVM3YkZFZnpNVHJpMVQ4?=
 =?utf-8?B?TjhvbGY5K3FzT2hyZm9yRTA4TVlzbG5nODdBVDRMeHdvdUpkTFNpd1dINXpq?=
 =?utf-8?B?VzhzMjhUYXhzd0cvVEszUGMvZnhYREkzblBhWFkzN1o1NW1zSWhVZDVaWkJs?=
 =?utf-8?B?d0x5ZnRGVlNzV1c5NUZKOE9nd1RSQmRFOXBhOERHaE80ZmRYcERrSVN3K3Mz?=
 =?utf-8?B?UmUzUU8zYk1NRHo2OHJBNmp4dHJDeFNDQmNlTW80ZE5rWnZ6TS85ek1SbE44?=
 =?utf-8?B?bXNZNjVES2ZUUTBvVkd3bXdNWEdDenYvM3h6RWltMHhmTTFEMU9UVWc1b1Fw?=
 =?utf-8?B?WUNzczN0RU1sbFpYNGZFazczZHdBREpFUUN5MkVBcjg0T1Q5eUVhYmxBRVY1?=
 =?utf-8?B?U2VsL012L2JOb29mMm4xamVmRzJRdFhiaTFGVHpkQVdIT21kMFRaWk1vbS9R?=
 =?utf-8?B?Q0cxY0c2Z1BKa1N6alBtT3NwcmRoV1JrOE1rWFJmcWFPMExuZ1FNQkhYOFZq?=
 =?utf-8?B?M3NQZ2Q3dnVCUEN4dlRrZE13d2dlWGFJOUNmbWRDcVhHTjRLOUVqN3VPQVpX?=
 =?utf-8?B?aHE3dzhXV2hKUkU4UDBkWFdzYUxRQm9nQ0V2MVlIOC9XR0xXcE52clNLbi9m?=
 =?utf-8?B?ODRYekNpV1ZuTzFIbG9UVk92NEtlM0QzTWFwVy9wNzBmRFJJUWFkYUN0aGZy?=
 =?utf-8?B?RGdKVTNrKzRrMStZM0lFd3FwTUZyWStQV2dTRXdYbldQUGp5Qlp1RU9xdTNx?=
 =?utf-8?B?b3NzbFVKQUdsL2FWNjN5TEZja1ozZjMzWVlJTzNEczIzQ1BuNm1LMnFOVWpu?=
 =?utf-8?B?M1RTS3d4Z2lxTzJET01EM0tUeU9oK0g0bFJ2MEJnV2VFM1hncmdnL1VzWkVw?=
 =?utf-8?B?NnhvTFhCQVJpWmpvMFFlQlZ3cE00ZmRHbzVCdnA2MmFEalhRdkhSV3NpYWhl?=
 =?utf-8?B?alM0MkhBNHJBdyt1SnZqOXZrOGJMZVBEVEFEUFhXMm1KeEhWRVlZbDlGaUFt?=
 =?utf-8?B?RllmcnB4dU1BV3phUlYvUTdkRVBsSHlBQThRM1hQZ1Axa3laVVpWMUd2NExY?=
 =?utf-8?B?MkMxNk0vWkZzdW0wYm11eGh6VjVTNlJUR3hZQjQwMHgxeTMrSWpzTDFYR1I5?=
 =?utf-8?B?WDE5UDN3UUhFeEs1UnNZblpTcEw3cWhLQnowWjh3Wk44UlA1SzhuZUI0VWt4?=
 =?utf-8?B?SkdBanNOUE9JOStQNUhmOVliL3FnWHVBa1VGeDYvWDI1dlduWWFxUVZnTTJZ?=
 =?utf-8?B?RVBBc3FLQzF3ZjZqV2FpcFQwOGhmaG5nR1Jkbk9IcWZEV3VIeTc1SFpLQ21D?=
 =?utf-8?B?VWRhZUZCOGhTTzl0aDZVZitQM3lEY3V1YlVRVCtDVlg3RmVHM3FEK0hNVm5R?=
 =?utf-8?B?akFGMDNjK2ZSaFdVSlhROENjeWd2Y0JhOWxaYXlkQkNBQzBJckwxM3RBYkVO?=
 =?utf-8?B?QU01Nzh0Y0t2WTkvK3g0eEcwWkdSV2MxU0VpdDU5R1NqT2JTMFBYRjRHZzFY?=
 =?utf-8?B?OThtWnczTVBmL1lDUmJRV0o5V1Jud1dWc3RqYVkwVGpHN1A5bkJ3cFpRbDh2?=
 =?utf-8?B?YUdaTG1YdDQveWNQMldvakxDdmU0Z3U0ZjNEVFBVS2NkNTFWTzc4SXRjRFMr?=
 =?utf-8?B?VUozdjZ1UjVQZnlkUUZ3OXlub1lxNlVMazdIRTlza0hHaDN2RkFxMkQrR3Fy?=
 =?utf-8?B?VmROZktqL0hzMXIzYWhkVTVBZzBPZXdML3o3WTkwRzY0bTE0ZTdqdGJTQnpY?=
 =?utf-8?B?eGwySlVBRFZyZ3FWZXVBYTVLRTh5SzhueU1vSWp2clhlT1lVekRSVzh3Q3V1?=
 =?utf-8?B?RmZQN0k5WENqbndvU1NaVFQzZFRoVW9jd0IyWGZPNjljS2NBUU1kZXUzOWNS?=
 =?utf-8?B?WVJvS2RxMVFueTRJNWduZ2txWStER01MMExiaW9UQ0hhSnA5SUYxQTNQK3Z1?=
 =?utf-8?B?UlhneC9icVF1eUQ0cVBvRUpaNFJyY3V2cW52ZWtmaUIwOEo0NDFHenpudzI0?=
 =?utf-8?B?QWVadXFPaHoyWC92cHJVbitDQ09wN3Z2SFlzelZENGxaTzZTaDJRTUtTYTgw?=
 =?utf-8?B?cjlrK3NQLy9wRkJPQ3pMd09ySHFGUUxxN2dkeW1rdVVQQjdWdE5ycW1ZaHRV?=
 =?utf-8?B?b0toQnRwZmhlQXRVNm43amJSSjdWZ050dFBDTWFJQTdyZU5VQXVvc1JURkZ3?=
 =?utf-8?B?TU1UOTJLeWZMN25zNEVwRHZWSHV2UTFCT1NvbUN3ZkJ2SXVJNTR6bzVvSGJE?=
 =?utf-8?B?eDVnUGQzUHJ5WTE4eXR0QlpFbUFBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b390f0-ffbd-47e5-2b12-08ddfc273477
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:27.2829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyZvxyPrKNWrcxGuzSDS8gmRlShPxj4G8dUw1utU/LP3prRbl+95yUfubVHY8D5/dz9+PRVuzmNQIeJ9Sa8Ij3pmit1M427nn50jKA/mnLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX+hqO1x0+yB1H
 4kAcvoiEYv0WnI0aXCYRPE2cSzkCXH5IsYEESfC8Yv93ndwQ4fvEcukuCLNsando1KpZtdtcNmw
 ufg+BcKe9tTaWbZRZZoc+992P97U30EEKV0SrPmdT2wIBo5YL/4DfPdKtEcKOVNofAFBBlsyQLp
 cibzxIrHYu5BAgd0YhY/rnoV+5J/Yav9PiKVDj/F0xk8onnBo52Yw9NPvKelb0k1EQGWX0iCIt8
 yk6dLPUqO0ri42oE+W7M/RArQ6HwCsVsk7q1BuZkSaZSTzhdc57AuoloFdtkHuDdvx0rw1H+yTi
 RytQWZIu99l4bYgX4W0Bn+iAVpeRyPP5OpvlB+sSMrtzgb7Msv1ZdMs3nRZETY=
X-Proofpoint-ORIG-GUID: DNfh3KjKD94AkaOwflOIxBbRwNkRrSb4
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=68d5284d cx=c_pps
 a=D81verZRVWLMjAELYjey2g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=_4X0v5D6KZ3sM8ZCYpYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DNfh3KjKD94AkaOwflOIxBbRwNkRrSb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Use QOM casts to convert between VFIOIOMMUFDContainer and VFIOContainer instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7f2243d9d1..f0ffe23591 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -38,8 +38,7 @@ static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     return iommufd_backend_map_dma(container->be,
                                    container->ioas_id,
@@ -50,8 +49,7 @@ static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  int fd, unsigned long start, bool readonly)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     return iommufd_backend_map_file_dma(container->be,
                                         container->ioas_id,
@@ -62,8 +60,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     /* unmap in halves */
     if (unmap_all) {
@@ -162,8 +159,7 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
 static int iommufd_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                            bool start, Error **errp)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     VFIOIOASHwpt *hwpt;
 
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
@@ -194,9 +190,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
                                       hwaddr size, Error **errp)
 {
-    VFIOIOMMUFDContainer *container = container_of(bcontainer,
-                                                   VFIOIOMMUFDContainer,
-                                                   bcontainer);
+    VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     unsigned long page_size = qemu_real_host_page_size();
     VFIOIOASHwpt *hwpt;
 
@@ -324,6 +318,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 {
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     uint32_t type, flags = 0;
     uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
@@ -408,9 +403,9 @@ skip_alloc:
     vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
-    container->bcontainer.dirty_pages_supported |=
+    bcontainer->dirty_pages_supported |=
                                 vbasedev->iommu_dirty_tracking;
-    if (container->bcontainer.dirty_pages_supported &&
+    if (bcontainer->dirty_pages_supported &&
         !vbasedev->iommu_dirty_tracking) {
         warn_report("IOMMU instance for device %s doesn't support dirty tracking",
                     vbasedev->name);
@@ -464,7 +459,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 
 static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
@@ -486,7 +481,7 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
 static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                              uint32_t ioas_id, Error **errp)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
     struct iommu_iova_range *iova_ranges;
     int sz, fd = container->be->fd;
@@ -559,7 +554,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
-        container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+        container = VFIO_IOMMU_IOMMUFD(bcontainer);
         if (VFIO_IOMMU_GET_CLASS(bcontainer) != iommufd_vioc ||
             vbasedev->iommufd != container->be) {
             continue;
@@ -609,7 +604,7 @@ skip_ioas_alloc:
     QLIST_INIT(&container->hwpt_list);
     vbasedev->cpr.ioas_id = ioas_id;
 
-    bcontainer = &container->bcontainer;
+    bcontainer = VFIO_IOMMU(container);
     vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
@@ -689,9 +684,8 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
 {
     VFIOContainer *bcontainer = vbasedev->bcontainer;
     VFIOAddressSpace *space = bcontainer->space;
-    VFIOIOMMUFDContainer *container = container_of(bcontainer,
-                                                   VFIOIOMMUFDContainer,
-                                                   bcontainer);
+    VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
+
     vfio_device_unprepare(vbasedev);
 
     if (!vbasedev->ram_block_discard_allowed) {
-- 
2.43.0


