Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F6CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kEF-0006nM-VY; Thu, 25 Sep 2025 07:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDP-0006UG-LO; Thu, 25 Sep 2025 07:32:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDL-0008KR-Pi; Thu, 25 Sep 2025 07:32:47 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAE9Ow1851287; Thu, 25 Sep 2025 04:32:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MzG14bU60mdI2MjlULOY5b90rX2vhHtYUK/yDAVdh
 WM=; b=YE2BerfZ362ctYxLaWce4KwjYn+En+37MMr3TNCLt5ES2wJLYnc2gJPLn
 9XXZ+X0234zw1Wtr8sFaFCcvpjDbJFROnnHfi+mNzNNa6OmduPO1QxeAuW4Mm4QP
 rv6/HIHK+SarRgBnFx4iEuP+ZZKEfmk8SEaY71e12stGgOVF8NN9AHAF7qQ6mN0E
 S8k/vnSC1k4Uz/f2+HpF164cHjWgSf7+X0KARn4+3E90CFIgrGCq0A4qxOejIuuc
 eB8ONr+JNlLRIfskRq4QRwVXGMo/yMAR1EF6u+LCdnkWCkr4OygswcwrLDNjNz24
 qPx9jQ053d6i9sp5erYn2y1k1437w==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021075.outbound.protection.outlook.com [52.101.62.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjave8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/AblN1ujG5r7ZgSoeoCtqMdvKC/oneu/fZhPMbDWNDZ6IGgETQYZvVy5O4iyiIRHVOcsRe2vhZmmbCdjI6hUuT67npM69pzPXPouXl8vU23w1Ap0MsNq1+UV8+ujeLSjBx17SWPqN0yof2jWrIA9oICQXj4PKjnsfxjdFpQ1O0lna83fSg0UCI8MMI3mQBwuO+26XI9ZlnpATDAEBfSTStjBPDhDUFYtgoZwLEaG7Diy2gpcV24OVHVvzBBDigcGEICgyUUuOkzmKTma1QqsPEb+PVDIWjR2IR79Uoy/dTh10GbLWItaPzBL4UnYO7QdPQS0RlJXUqM+2VZX08K1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzG14bU60mdI2MjlULOY5b90rX2vhHtYUK/yDAVdhWM=;
 b=JLtDwatigXtoH9YqNcwyZkMFyT7z5KES1KmO2vfPoCBVLS9dm3QcfUT/eX7qQHZmy7FLQCJoT0hxW3axXAVM9r6d4LC523gjP2z9FWAu5uBROWr7MBWDic68222uvMSTnxI35RzkVRw6AStl2wzbpbUADAyDGKKqBRowSkJHjtfFJNjAZhHd6Djl9gzNIot1srJmpwvRep2ZLLflnlrI7Hd9E5dy/RAElki8diWXuy5geIzjnMWEZqW6pAnqOmvIqtROXmllgzb+c9OOqniG6okOXdyRmANtPyynemO8NLncDlzCyVSeHXfcLDKXG2NnjDBUHkYrpxsXSOnYxxZIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzG14bU60mdI2MjlULOY5b90rX2vhHtYUK/yDAVdhWM=;
 b=pri5T21UxynJZ+xkXciyrb93v/p1T+Hp7HGj2G4SCcvXLHUJ7xkX9c6TYYBBIx729k5AMvS3/Vh6dl7Q6UHJKHqeR+hym14dixJ+f33dAYmK4Y2cv7Gm0z4upU19mIv5e9X7oufL8pF26W3BhhbRu3+4mYLrYrhkNJe/mSKWLqItgseOj61UIGvmHv3f+gpagHxPkCNlEkfl55j60BuKzpDwctQ0PxMZuwPvHq2p55sFA9ujMzALucngQaXNo+zW2jG/9yy7kSiPMQ8Lq99J601eGkZUgXnEBdO7IApbknsypCWaMkOaPLPYWRlkP8m00+9GqIJzimLzYYrz1nMGMw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 08/28] vfio/cpr-iommufd.c: use QOM casts where appropriate
Date: Thu, 25 Sep 2025 12:31:16 +0100
Message-ID: <20250925113159.1760317-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0636.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0cbca4-232e-43b2-04f1-08ddfc27365f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2wxS0p6Rm0vUnVoZmNEc1h3RURMdDdtWnZZbU1vUGJpeFlFdmw2dDJhbXRt?=
 =?utf-8?B?V0EzUVhqbFZlUlpwZFlyVzVNL3ZralV3TFFwQ0YrZ3dYTVFJWEdqRmNTWWwr?=
 =?utf-8?B?ak9heHBGR0cvdUVPWnZaRTBKMWhra1ZuUjdaNk5WbFR3SDNzM2tCbFJqYzBn?=
 =?utf-8?B?aEhsa29FUGRSTkp6WEMrY0JKZmx5OXRvM2lOREh4THBoOFp1c2RXYWFqc1dX?=
 =?utf-8?B?WjIwM05qbXlDNHVNc0JyUnpPNW9EQ1p0MlZ1NlFDSG80cU5DSUNwUERQb1Vx?=
 =?utf-8?B?QlZUYVo5cEdJVmdSRkNIRHpzM3FhRmNzcDE5cnIrK2M0TXlFcXFSME9Vd2J6?=
 =?utf-8?B?VjVtQWdnR3hQbzl5MUVaU2xPYytvcFFvVjVjTDQ0U1RzU01FbFlzQjJibkdY?=
 =?utf-8?B?TE9MeHZGejg2bklPa1VlbkpEeVArNC9IREhITXZZMmNSUGlvaWFZd0UzeHlH?=
 =?utf-8?B?ZlJpWElrNWdYbXJlYW9pVWorSnNNeU5VRklPU2hpSUVHa0xCSytxL25LWFBI?=
 =?utf-8?B?NHFlUExiNisvWklaT0p0OTdSeHY2ZDNYemZWS1krSXk2ZXVyd3VkY1dnSHNy?=
 =?utf-8?B?YnhnVHpEMkxxQW1NdEJJbE96VW94K0NHRHE0eDB2RDQ4MVM3K29tRUxUdm5U?=
 =?utf-8?B?QnA2SVk2d3VrVDJVTjRRYmxiRnVFR0NwT201YWtKbCtnaG1JcFR6SE9pNWJz?=
 =?utf-8?B?YjY3UHFCN0ZKcGxpdVBvbHlQVFhLbUxKTG9GUlQ1dkVWc0l2QUdFZmhob1BB?=
 =?utf-8?B?RlpMVE1zNTZEK3doYUFjaXhzMGZ3SjdsOXk3NWFIUzh1ZTJmbS9EQk9PT0hD?=
 =?utf-8?B?RHRQa01uQWFFTGRsa2g5a2t5WXZGYWxCSWhYMWFMbUdRbDBYZS9uYXZTMTdv?=
 =?utf-8?B?UVhYeTQrYXFIV0l2NlRMVjJsQnZxVmVaMUloTlU5TWh2YTZTOXBBd2xTenMr?=
 =?utf-8?B?U21KbGJWZ1FzN3dmVzhQME5pTWRhcDZaTDdFZUljdE0veFZ5bVFVRWFqbUky?=
 =?utf-8?B?NU9URUdxVHUwb1hyckFtam1jczMxL1RzVGJtb05VNHV2OTZ5YTYwMDlpVmdu?=
 =?utf-8?B?MFJKSnNtQ1lxWTlZMkRBZk1wNC93VHBNUXRTZ0RNeVZrbjJueFdmZld4b1hx?=
 =?utf-8?B?OEhndXdXbEhmQjV0ODBrTWxaL3hWQVVWRmVQRm9Fc0JVZXRPMTd5dlUwSWVJ?=
 =?utf-8?B?ekVWVWc2bGs1U2VCek45VEE5aEgwZm83Ui80Yk1BK3NhUTh4bTRpM1FzMWNu?=
 =?utf-8?B?Tlk5VjE1TUlrb3p1WjM3eHIzK3VuZ2F3bTVxTFZVT1RRL0ZSZXhnWFI5RGxK?=
 =?utf-8?B?TWNhUnBnTjIrWUpZWFJBMWh3aFkwMVdHcitLNHA2UFFjWTZTV3dnd3NHOENw?=
 =?utf-8?B?U2xja3NJb0VYZjdZbmpIbFBiRzJlV0Qwemw0cE9wYnViQXFEZVlKU3Uwc0kz?=
 =?utf-8?B?WUpBWjlwcHo5TnpyaWNNemxZeTVBb2wxeWtrRktJYkVUaFBQODVLL0xZRnZs?=
 =?utf-8?B?ekh3SUxoczl2TTI0RUdsRmRaRm9EM1pCczZnS3hQamhSQW1KY0o2TnYxWDZY?=
 =?utf-8?B?ZDJtWUQ0T0JYaENmOGdJbmk1NTBXNWJwSFJQSC9hSHY3Rzh4KzZTV1JYOWVj?=
 =?utf-8?B?WDVYNk9TSkx3MUNBVnljS3JTTEhKaWR4Ui80djNYY2c3VllTRFhtcDJxbWV3?=
 =?utf-8?B?VjF1QlNFZVlOZkRHZ01XTFB6QkVXbXduYTNsdnhRemFEL0MrYWlDMGphY1lz?=
 =?utf-8?B?NnRSVzlSRThkc3NVay9hUGROS3U5NHNadjBIblpsWTBYekMzZ2x1Z1VzQkdB?=
 =?utf-8?B?WnFvWjNCVnczMTlheEVVa09xc3BYSVNXNjRHUGdBODdNOGdxbUNlamRoa2pS?=
 =?utf-8?B?N0pZRHM3aHJqcS9RRHJxdnVweEFnNkc1UWI0V2NKcGxPcUVMeERVajNnYUhm?=
 =?utf-8?B?WDVOZkppVlJQQXVaMzI3Y2tlRDJPNEtZS0FYTVNpcEZjVlFobHJMTlB5VmZH?=
 =?utf-8?B?eVllTHk4VG1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRXcmlObkcyWXlHSEx0K3JZZUFmZElrUWNDRFdQUGtkL29MVUx2cUhpTHlI?=
 =?utf-8?B?UmZzYmFsU2d3RW5UUmhQVzFSOTVpbmpvUXZqRmU2VFBoaGxMOHJXK3d1SDNz?=
 =?utf-8?B?NnlPbERCRDc5QWxjVFpxeUZ2TS8xanZoWXM0WTFzSjNlRmJEUnd4SGFpNG5u?=
 =?utf-8?B?dTJaNWRHMVF1SU9Ha28ydkp0TlhLVS9RaGdmbkExaVc2dTk0THhmbkNORmE5?=
 =?utf-8?B?dkhoclBwWGFwQURER21Rc0JCNU43Wll4cVVJNyt0V2VuTmlMT3l1MEI0K29J?=
 =?utf-8?B?MjI4SlIvZHhRSzh1RkM4dWY0VFBScWtQek10bHlEUFd0djJRcVQ5K1VpUnFq?=
 =?utf-8?B?OWZrN0JXdWNoaDc2U2tXMGQ5YllaYks4TGMrTkZGMVU2YlJmcFVhbHg2Nks2?=
 =?utf-8?B?OHJhK3NQNWFrcUEzcFlIeTdXdGhPcENxUE5Ja2pyTGZYZjRjcS9nc2cxUnBD?=
 =?utf-8?B?MHlqZ0dZYXIrYzFoY2MvUVlaUWRLeTc5dEt2bU1wWTlMK3JERWpsRzhqZnJn?=
 =?utf-8?B?RkZxdU02ejRMenZ3d0tqcUR1bTUrOGRlSlR5dGJVYzUwLzl1ZktMVk5MREM2?=
 =?utf-8?B?WTViSWRld0YwR1MxYkRIUEZyU2paU0VvMTE0aVNiZjJnWWlyMHRvR2RjTEtW?=
 =?utf-8?B?T1BJaGV3ZG9INlJtdHRwbFEwNnhwZGhaZHBrSWgwUm4vWlliODlCVStLNzFG?=
 =?utf-8?B?S3dDUEM4YnBFa245WU1FRVdYNitXK2dLZStnSGViZHVCZUxLSklvdFRZcmU0?=
 =?utf-8?B?anZqNU4yMFdHc3RCeVJYZ3pEMk5CbWpMUWE5UHBSeFJDSnZtUDhYQ3pMSzlN?=
 =?utf-8?B?d2JTdXAyeHlrT3dzLzcyNzBpbkt3RXBhbStuS3d1RTB5Z2RvNm9mZTAvdjRs?=
 =?utf-8?B?QzNBaHpuL0NhOEtXbXJzTHNDTTg5OUxCNlJrRTE1elFHS1JWbWxVWFVvbHpO?=
 =?utf-8?B?SXdqZlZ5RjBGSEFONm9pNDFHd0ZLdG5KVkRGendQeHBaYzFzbks5NlI3Q0lL?=
 =?utf-8?B?YkNPbmJGbzF2UzcyNjdRQURzaXUwQWtGSHg1OVVLUXU1Z21yNFlzTTVNNTRL?=
 =?utf-8?B?MU91eXJOdmZkQXZkYUV5ajdrY2kyUXpQOGY4K2IzK2ZJTW1rQ3VydVhDbm9K?=
 =?utf-8?B?RnVaZUl5eFJRTWdUcHlsS1ZaelVFRkVicmUzYitWQVhtcllWZVRZYTExQzUv?=
 =?utf-8?B?R0FOaXNwQU1TVnFQYkxqc3RNSG1FT1ZCRjMweklBdHg1eDNEcmlVV01tV2Yx?=
 =?utf-8?B?dDZJeGQwelZuTTVtRW9NQmdVenlsUkM5bWtnaHZZdXVsMEJjN1FzK1BRdEZx?=
 =?utf-8?B?R2JGa1d2MWwydXJSdndZWjZkbENtcmpTdzV1TWNJYWFRZHQwUUVYTlMzVS9I?=
 =?utf-8?B?SHNkN1JBV055c0lFZktPVzR6OGllejVOcE5WNkIwQTV6VGFlcEc5R2NJeWIw?=
 =?utf-8?B?eHV5MTQzaHNOVEN4bzdhRm9scHRMa2VLcEE5Z0M3ZnlKcUpLNEdSRU1QZWdD?=
 =?utf-8?B?ODNRVUxVZUZNSUNQenh2YkpyVlliK3o3dDlPK3k5Qmk5c1N2NE1KYWtTdllJ?=
 =?utf-8?B?VmxPYlQ0TUxqclVsb3NNdW5Zek01RjkrT094ZkRNQXU2ek9UMUIzWjBxNFZK?=
 =?utf-8?B?djQwY3AvNGoxVzE2M3h0WlV5Vk91Z3BtbldNVlJscS96ZlJpTldFQm1JbWRs?=
 =?utf-8?B?SFpSMyt1dUVvV3dmQWswemF4L2NlQTI5dzlZQXBacktWdjF4amY2VE5zbWFz?=
 =?utf-8?B?a1d0QWFkV0piWVd5R0FHUnFNdTRtUGVnNlIzVmcrYi93RDEvLzBPcUp4M2NB?=
 =?utf-8?B?VnVHR08zSzFBdk5uVWxJR2ZTcklXeEpmVnc2aEJ4Y2swa2oycUtGb1BXZ29L?=
 =?utf-8?B?d2VmbHBBOTlxQUFZdFBmdzJGK0pHcVZVVDkzY1BQMWpjL0dJSFI1cUd5bE5R?=
 =?utf-8?B?czYyMnIxajRmUXpQOEkzbS84ZGJxZ0tDbzBhL1V5TUdCcnREM244aE9XdjZr?=
 =?utf-8?B?SE9sRVRUbCtPd2psQXIvY0lyVGl0UVZRRmhqcHVZbWZPbTlZT0E2bjIrdzB0?=
 =?utf-8?B?ckpHVEdNSDB6MWxtdlJnODltUDlSNkpaaDBNM3ZuQkViNjBCa0wvWTRqZTd3?=
 =?utf-8?B?cTJ6RFh4YXdWdUtJbVd4Mlh6cFdPNlNwUGNoc3JISVdHK0NzK2YvbnRVV0hn?=
 =?utf-8?B?blFSMUN4dXdyb1F4Vk43VFd0QXVOU3NoRFg5bTl2WE1FellIaHZMaHpwNHh0?=
 =?utf-8?B?Q1JrS3R3YUh6SlA3cUJycjlmMm1nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0cbca4-232e-43b2-04f1-08ddfc27365f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:30.3472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aru5z8V7pmHRPvJaBoOnOboCYonOSUvcdpnQUkUzKNlnZzZVuNXUabkodBHG/Oo2RqAuafmlJMUeIi46K87ohN/t3LDJMCKvi2XS0PXmA0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfXybsP/BACDiSm
 mLDbrq9H6S4aa9sFr6Tf61fTaFU6M8MfoPa07lUZMuT9LvUPX3cnIXOwBWOtUX5lVKfp5M1s3eK
 DnRCt4I/0Sh2RNTUGoZjwLp8AaVF1k8PYdb2SEkRHy8RBr05PXltFoupIZhCNdcDeNFpJuZOHVW
 X/M1LFruWmIf3rtVuEGmRW3ugaaikMwzMPiOTh2g9qdHbUthSSdPVNpt8MzZq26RRocSJYA2TaV
 Zm7wEOnrJrT9NtPOswdDd+sM+A1cs9shMx/Hy5/DRVNZEwkq1S38ZljGuudrl1JqWq8T3+iMVtv
 sUXwOrJBatQ4Unsi+RsOAkJYi+cRSNaQYehx6xum+flZGuThbc48BHHaD2/6W8=
X-Proofpoint-ORIG-GUID: 3TXfO2_dwZ279V1NHTQFpbyvzik6Eqx5
X-Proofpoint-GUID: 3TXfO2_dwZ279V1NHTQFpbyvzik6Eqx5
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d5284f cx=c_pps
 a=APgIdIbuBBIe7PXa++EYhg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=BBQWohTTSvez9n_Z4ggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
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

Use QOM casts to convert between VFIOIOMMUFDContainer and VFIOContainer instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr-iommufd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 6aaf6f77a2..1d70c87996 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -176,7 +176,7 @@ void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
 bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
@@ -189,7 +189,7 @@ bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
 
 void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
-- 
2.43.0


