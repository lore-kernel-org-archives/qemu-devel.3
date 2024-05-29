Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B97C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCN8T-000555-9t; Wed, 29 May 2024 13:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN8R-00054o-Hf
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:30:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN8K-00007N-Hc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:30:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TGY6o1010307; Wed, 29 May 2024 17:30:30 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DV11antr3Oiz6oQQhv9Q/BYuws+2sncTrwCRTq6EUoV4=3D;_b?=
 =?UTF-8?Q?=3Ddsz48fBuBqWtaC3pjxdMSQvmFOtltNIrpsyv1W2+yZ5EplCwTREyEfQ+mCjl?=
 =?UTF-8?Q?gP7cvqPx_I2yw9JcEpqcbZKK+nJrDmPjIFm72Fn9UPhqXnMoG7a+kQCZLphL7Iw?=
 =?UTF-8?Q?07fpFsPMy9YVvj_vdEtMkNVFqZcb6bzBh8Q4xuUblGPKGbfyX/+AQnGN6kBVqGq?=
 =?UTF-8?Q?ZZrnuCjtym9ZGPVaNMs+_P3lzb4+P5GFaaAcvq2C7y4ZsEKXkfZeX6ByP8w1fVg?=
 =?UTF-8?Q?63hsM++L0/qtiRNJ1b1shjuo1H_/C5VMWTg4qefpZ9ShYGUhJyuato4VuPPDMza?=
 =?UTF-8?Q?1gmJ0RXvgmZbVI2QHMp/6uZSacPmETIP_mQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fcf8fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:30:30 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44TH86Em016232; Wed, 29 May 2024 17:30:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc50rgnjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+doLYoxhk2ptuYjcC4ynGpyhoIrAqRIuN7U1O0OdW2NmWHrXkUjGlDqv384+rN7aIKY3NEsdcMaop8A+rF7W9pZxgWQYvB1vG7ZWxm6ptGWh2rBjL98Ag07y/qnv631KYntAsXmgVtGnvOGyrbWJYJ1roeAwMqKzUhrIKmVFCAUKotRby0VLP7suvUB8Numzuk6mma/r2TV1xKn29kKoqJGz9DlqkRq23BH9gXkdO52xy57oMnL8WMpldbpxesG0JX2LaFDqT9PARjtfATpO2yUD4yPECIt7SWYhAVWOw02RQHyD8mzjB5bw3/uK4z464hi8pR7nP9LYRoGrfKrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V11antr3Oiz6oQQhv9Q/BYuws+2sncTrwCRTq6EUoV4=;
 b=NIPomITJgVry7LT39+LIGXmm6u8Fk9iyk4kmuJGRWc1GtCvQXQlIqXWt7L+sLxhs+0i3FkS4MIG+2FxinzruEod+vpgWu5TE7uJy8nuTM3Ka71Uvbot0zTG2Ri/niEwxwllJZIFL1aQWi09ydf0tr+C+rf8OjZpN/ZHIKyB3S3x5+c9hpMa0HRinwxe6h8up2rrDSQ1huPVRkT8O7gAIOOiiGkQAvtyzqR3XfB8523k1Ue9delxsso/Q7iP8n9ER0pKyseDRC2+PckwMVB2qZBZS7vtGxnt7tIm7VYLCQovJjUND0fNCl1B7cIRlFVpCaggq6SCqMM0f/YjnWjXrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V11antr3Oiz6oQQhv9Q/BYuws+2sncTrwCRTq6EUoV4=;
 b=M9ZMDjiCFM320A/pjWdASCEXoFUOlA0u5z0cgNC9QAleBjgG1UMkUb86Lk0v01IM8q/uxvM96O1hePWuybK5K9ZxrFwlKO5HWza9uNW4MaBnAEfBdshoCZfU8nDPknixQbdo+qgjUhOieWO5DhwKL5WFpPv3mbXONnZbqYVx014=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:30:25 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 17:30:25 +0000
Message-ID: <18f8bba1-b687-43ba-9f2c-4cfafe005ac1@oracle.com>
Date: Wed, 29 May 2024 13:30:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 07/26] migration: VMStateId
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
 <ZlTO9fVYG50r3XL9@x1n> <7119f070-57ea-4495-bd8a-1337555fac22@oracle.com>
 <ZlYX4BWLU19f1vaI@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlYX4BWLU19f1vaI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e294cbf-31ac-4882-949b-08dc80050648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmRyMkVicm5qUnQzU05IamZGaU9KNnVMZlVpbG55VWpBWENncnQweXpyRlZJ?=
 =?utf-8?B?R2RqaTZsQmtwM0N0KzVqeXhBUElBYnI0ME1CT05KbGVSS0FRaU9oR01VeHNJ?=
 =?utf-8?B?UjVnUCtzT0JxcXZJK3BiLzVuaTJYWnZScTAyeVpmYzljckNrYkYwQVFBUVR4?=
 =?utf-8?B?aVR3eEFiQnN3UE9iWW9qd09RajVWbGJsTk5MT0p1QThtUlJiYW4rOVptVDQ2?=
 =?utf-8?B?SnFJeW04Z0gzckI4RDRZY1dlaXFVZHZCUnFZc3lJTHJTWU9sZ2ViRVA4a2kx?=
 =?utf-8?B?dlovbjV5cEVJMk5XeHBVaDVTWWZhb1JnV2RwK0FjVlBoSGZvaFEvVnZRcUZO?=
 =?utf-8?B?SnUzdElPbUJQTmF1U1k0WmN5Q2RsaWxUNUF6anptTHpoUmQ2dzFOVmI3OTBV?=
 =?utf-8?B?bTBnbUc0dVhuKzVURStzNWsvR0NhVncxMFo1STlJNk9QNlFJTGZKeS9UeUhX?=
 =?utf-8?B?NWdkVVRkcHVJSDUydVJiWG9jNEdUSDZJaUdmL29BR2dnU1ppTWpyWlpZWGFv?=
 =?utf-8?B?MlozT0tWcjNqemVKd1ZhL0szemJCSFRRMXdmTW1ieTBrbDVWYk1ZeE5KSWY5?=
 =?utf-8?B?OXhMRk5wTjgzNUNRSVRMUjFXZUdzTjVOcXg5eWhSQTVpaW5IQ2VZcElZLzJ6?=
 =?utf-8?B?eUYzV2pYdjZGS09PdmJIbFlwY1AzbWgrcFFZNTlUMmVsN01qT1NrSDhHUlh1?=
 =?utf-8?B?UVFpaEIycTB5cGpaZFltVzRNT1pmWC85OHcrNG8xb3I0ekhjVFpZcGl0YzlB?=
 =?utf-8?B?bGxVTSt6dDlHWUpnaHZOTHdFSFR4Z2o1OW9NckxKdzVMMGtHellhcUg1Umsz?=
 =?utf-8?B?QksxT0h5UGdqd25RcnNuMTl0QXVhSWQrcEtWVmdVRllKQW1PM3BpMGNRNGVI?=
 =?utf-8?B?dHdxTVl2cUp3V0VUb0laSWhlZEZrYjF2alhmSWw0dklwdklSL2hOWDUvQnZz?=
 =?utf-8?B?SEFXMFpKUW5WYWplN2RQOUJ1RG1sNFFTRVhuTlBUVnZvRUxvL1hPUG8vd1RR?=
 =?utf-8?B?MVgyaE9tN3ZWWTJIM0NoY1Jna3MxQkpYUmJZczFoak1OcUJJcm9kZWZpZGFP?=
 =?utf-8?B?K2J0N05tN2MxMGZRRExkaGtDOURLS3dycUdWNm1YSWRIeCt4eWJlK0lUUUV5?=
 =?utf-8?B?NitBNFBXZWRJVk53RjQwdkhiMTRjWXdUUVBxeGlUc0FxdUpIM1ZVYW82VVJK?=
 =?utf-8?B?YWtIUmx4NzQzc0h3bE9vTWR4MWpQZ2U5clJrdG9WSCtmeFArbTJGVGVodzMy?=
 =?utf-8?B?Q3h0T0Z3SlBaaldoa1JJZzhpWW5hWFkwWis4STRFOE4rY0R6ZzFPcEQ5MjFo?=
 =?utf-8?B?dGZXaGJqSU1aTER5bldQUVk0cFJORm5Icmd4aC9MWUZFbVBwQmVONUhBSjM2?=
 =?utf-8?B?dk5zQkRHSWYyTE5tajNic0xGdVg0NUxKcVdKWDlpTXpUS3lkQ0VYOTQvSmxX?=
 =?utf-8?B?b0VpSDlnUkg0M1dKZ0ZISGlrN0xiL2ozV2RyNHVDV3lJa1BORWZZcE1qQU02?=
 =?utf-8?B?SXVnUkNucnNtTFdNYmprTFBiVXpwc29uRWw1MjZBUFpDTE0xK1VtYTBCM0ha?=
 =?utf-8?B?QnlHNG4vdUhnRGlRdHA4ejJ6UnZURzRneS9xN1BCYzZHQmMxb3ZHWlpzcTcy?=
 =?utf-8?B?dVNRankyUlIydlNNdDRrcEZteG4xSXIyeVU2a2x1S0EwMEFNQ2RkU3ZwaXBk?=
 =?utf-8?B?bDY1a2h2Yko2eFNpa2kyRy9VNTM0TzdPYlVyZ0lCY0RRTTBDOGVnN2lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZndzNZM0MxdUpyUlY0US9VUjh3OWNPSXVjbzVYVVg5NnpmeFVVU21KVEFQ?=
 =?utf-8?B?MEszRGEvL2NFRkwzTFBVc2xnQzFZNTQwMERzTWh4TFpnUzMwdDdncERyYVpB?=
 =?utf-8?B?T2N3b2g4d3VKckRvT3lkeXBMTE1ZejNlbHBkanJZNjNPMllhQVJXQmZCRVpB?=
 =?utf-8?B?T0pkdXZ5dG5VVzM0YTBvditSQldTU2ZkV1d3aTZOREtsTXNxRDN4Qnp4dkZI?=
 =?utf-8?B?aE92R2FPUjJOVjFybGdzRVNsREpMYlVUbS9nZGZEN3hzUWVuQXhjamUxNGR4?=
 =?utf-8?B?TkNSZ1JnaWx2NnFQdjF2VmNiTUVSWW11SktjT09FblltSUlldHJ6V1Q1L1dO?=
 =?utf-8?B?RmYvYWowVzZES3JVWVREYVNXMlFzZGR2TTg2TXFoOEVjelkvdXJ6ZlNxdXhi?=
 =?utf-8?B?d2JIVVZRejIwOE5GYWhSelAvbHNHZ3R3T0ovOFpiNjg4OENUQms0NVdkVzZO?=
 =?utf-8?B?dThrNVNxTVZVSU5FNVF0dzRHS2ZwNnV4dFRhME5BWjV0TXB6aStDd0lIZHQx?=
 =?utf-8?B?MzJlUmpiMmlxeGxmWXpOMWxpTHVPYnRPdXVvZXEzbGJnamVEUFZweGdMcCtw?=
 =?utf-8?B?VllBalR6NGZZd1FJQlhZcCtTR3E3OTBQT0tKVnNSeFJHR09NOTNZY2Q4cFFR?=
 =?utf-8?B?RnpGbi9pRXdodmFWMHNnODFBS3BOUThKa1VSTHkva0xwbE9ZU0FyYmJjcGQ5?=
 =?utf-8?B?bnpCZ2RBS0JxV2VBVHBqWUF0MklmMHM4SDBQeHB4MVZDSFZYcks0VnAyTzNU?=
 =?utf-8?B?WE8xaER2OXh6ZE9VWkpaaWczNTlvRFo1TDNGc0dkMmNmeW1Qb2t4a0JhKzVy?=
 =?utf-8?B?SmUxNDFUMXVtTUsrWC9EOEtLeWdaZnp3ZUxldTg1ei9nTXMrTFdycy9KTUph?=
 =?utf-8?B?Z0FjYVU5aHg2ZlNhMnc1ZWE5UGs5SCtINGlLaklWVkVTWnExYmFaaFBWYkpa?=
 =?utf-8?B?b0N4RnY2SEk4VFdBWUxscmxTNmFaVFVCSXZiRCtibTdnMjZMTGNsakJpaHRp?=
 =?utf-8?B?MTlESEdoZXZ2YTZkMEZCUEIzTHhLSWlFTFR6eDYvSVhady9oV1N2VklSN3pU?=
 =?utf-8?B?cllMb0t4dFNqOUlFd2Y5TFpDUFVGZDkvYWtGcm0yQzVGb2VRZFJCcTZsMzNL?=
 =?utf-8?B?ZGorTTlXUUlvcE5jU0dKajVVRE9KbFo4ZzBhK2N3UTRhMEJVa0JSSUpFYXJz?=
 =?utf-8?B?bERqUlJSaGxzQ3IrL1JKc2h1ekhpdEtESXd3OVUxMU9EQ1EyQWNVK01EdG5E?=
 =?utf-8?B?QTR0Vnp1V3hGRHdLUW91eUhUUEJrWVRiRkJteGZKdXhmYnhqMHk4RGtGdTBm?=
 =?utf-8?B?WU9IUE5MSHIzQzR2bVZUeG96Q2NOdHVtcjNKL3N0VHcyYlI4RGhtZXBiZDZ4?=
 =?utf-8?B?ejg2a1NOdlFtaFBneXVBQW5lbllvYXdUeFdHUExjMjBhczg5TXBMMkZqcHBY?=
 =?utf-8?B?Ui91cHNrTkQ3cVQ4eHA0Q0kwVlg2bGZFd2ZSWFhBMzVtd0ZaN2ZjWEk1QnRK?=
 =?utf-8?B?dlJ6TWhvL0wwTUtHaVpwY05QVElFZ2VpVlNLRnVHUHVjVUE0RTRYY2lKVXNz?=
 =?utf-8?B?b095NGpFQjhtZTd3YXo3YU5nbjlKcDN3ZGFzakh1VkpITmtCTCsxeFpObzNG?=
 =?utf-8?B?aXBWUlQ2V2dDM1hsSi9aOTdOTlc3anVRK0tFYXBGRUVvWE5DcFZQREtPeFFG?=
 =?utf-8?B?REZwSUJGUkk1RGpZT3kzNk9pbWs3ZmFHRnRTQ0t4dWxEbDJ4c1R4TW5zVW1R?=
 =?utf-8?B?bXBtSzlwUkc4ZW41RnhVWHgxN3dSdkw4Z3pzWHl5TzlWRXJPVHhXZmEzdjcx?=
 =?utf-8?B?MEw4aWxqc0xvRDZTLyt4WDRCdGhxckxHNzdNVk42a2tqSjB1a053SVkwdFd3?=
 =?utf-8?B?ZXBXN2EwYUMxK0pJMGxSMHNwYm1TRXM3WnpvcjNPeGxBS2tjUGxwQmpOK1o4?=
 =?utf-8?B?TzBxdjRibVpjRXhnWHVIY3NGMFlWNWZ1a1hyY2pXRktZdTVVVHQ0YmVqMXVu?=
 =?utf-8?B?Q0JRWWV1MEpaMnh2YUlxb2hYV2lUcG5GbUd4aW56S0xvV00wZ2o2UUkzQzVv?=
 =?utf-8?B?L0UzYnJicWYweVV5V0tQQzZiQkUxVlhPYTFGMDY2SnBtVHdUMzhIaC9aRTVV?=
 =?utf-8?B?ZVFQd0h6Mm5UWmsremd3YTFYK0g0QXBUL21yMlN3ODdUNHFSOEdseVBlYnZC?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UxiYmOZobgEZBuqWVSFt1i72xqbRGOhS0unSVCt985xMZUdfIJH/U0KlgGcpFmefLTqu3wNcX5+TbXX5Tp5vZBS55wlsVsbZ2GXMlbHpzF05SXYw5M7PKRS5QC4rLr4cik45/MWurkTY4v2UeuAvJerm2I0IeLMrS/g6d8/uMKhJ6PLPSTlzmAmn6nPbxxSQQlEGz3YfdTOhTdqh8Yy2ZXxo2WHNiB7Xgb9lpE4Kntg9Sr3n2Bh3MnadIZJ8IWw4HdQZC8yde20045svz/fsWzJ2xeNVOs7+bqJesdj0VfsV74v2wizZf/1eRRtd7svp8tDhyMlJMAx15tRju7QhYU3b9rDvMOWIIyJ7GVhOFY/MWvR2tM5qbjFx2G3Cm1R5GcwdiqkaSw5+pDFehO5Cg9yPz+JQkZshJED96Q5mx7z7E90Y7xHEZEkyiJB746NwQbipE0aCy7qEDMkl2IdCT7Jswb2pugYZQWbok7gLmKpsm+7bE3YsmfMqHbR9HFIpDA2i22Rg0eG5PuLU9zxxdF8YfAJ+O6w8z8pS2eeQS19kVvLlkN5WB/HYmNxH15zMKtO3ExEtOaZHnxcKsNI+DUNAD7MzecvUVLCtujudtxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e294cbf-31ac-4882-949b-08dc80050648
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:30:24.9699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9WcrPDLzEad/V0fV365APlPd/n36DAogyCuEKij+M/q30bK7ETHbBMYzW9Pc/DMidFNS83Hk3qkLFX1+lf3poX54xr7wtmAqfxlv218NxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290122
X-Proofpoint-GUID: jWCGOvQvgjJN2zF-yP5j5-II13YR62tz
X-Proofpoint-ORIG-GUID: jWCGOvQvgjJN2zF-yP5j5-II13YR62tz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/28/2024 1:44 PM, Peter Xu wrote:
> On Tue, May 28, 2024 at 11:10:03AM -0400, Steven Sistare via wrote:
>> On 5/27/2024 2:20 PM, Peter Xu wrote:
>>> On Mon, Apr 29, 2024 at 08:55:16AM -0700, Steve Sistare wrote:
>>>> Define a type for the 256 byte id string to guarantee the same length is
>>>> used and enforced everywhere.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/exec/ramblock.h     | 3 ++-
>>>>    include/migration/vmstate.h | 2 ++
>>>>    migration/savevm.c          | 8 ++++----
>>>>    migration/vmstate.c         | 3 ++-
>>>>    4 files changed, 10 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
>>>> index 0babd10..61deefe 100644
>>>> --- a/include/exec/ramblock.h
>>>> +++ b/include/exec/ramblock.h
>>>> @@ -23,6 +23,7 @@
>>>>    #include "cpu-common.h"
>>>>    #include "qemu/rcu.h"
>>>>    #include "exec/ramlist.h"
>>>> +#include "migration/vmstate.h"
>>>>    struct RAMBlock {
>>>>        struct rcu_head rcu;
>>>> @@ -35,7 +36,7 @@ struct RAMBlock {
>>>>        void (*resized)(const char*, uint64_t length, void *host);
>>>>        uint32_t flags;
>>>>        /* Protected by the BQL.  */
>>>> -    char idstr[256];
>>>> +    VMStateId idstr;
>>>>        /* RCU-enabled, writes protected by the ramlist lock */
>>>>        QLIST_ENTRY(RAMBlock) next;
>>>>        QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
>>>
>>> Hmm.. Don't look like a good idea to include a migration header in
>>> ramblock.h?  Is this ramblock change needed for this work?
>>
>> Well, entities that are migrated include migration headers, and now that
>> includes RAMBlock.  There is precedent:
>>
>> 0 include/exec/ramblock.h   26 #include "migration/vmstate.h"
>> 1 include/hw/acpi/ich9_tco. 14 #include "migration/vmstate.h"
>> 2 include/hw/display/ramfb.  4 #include "migration/vmstate.h"
>> 3 include/hw/hyperv/vmbus.h 16 #include "migration/vmstate.h"
>> 4 include/hw/input/pl050.h  14 #include "migration/vmstate.h"
>> 5 include/hw/pci/shpc.h      7 #include "migration/vmstate.h"
>> 6 include/hw/virtio/virtio. 20 #include "migration/vmstate.h"
>> 7 include/migration/cpu.h    8 #include "migration/vmstate.h"
>>
>> Granted, only some of the C files that include ramblock.h need all of vmstate.h.
>> I could define VMStateId in a smaller file such as migration/misc.h, or a
>> new file migration/vmstateid.h, and include that in ramblock.h.
>> Any preference?
> 
> One issue here is currently the idstr[] of ramblock is a verbose name of
> the ramblock, and logically it doesn't need to have anything to do with
> vmstate.
> 
> I'll continue to read to see why we need VMStateID here for a ramblock.  So
> if it is necessary, maybe the name VMStateID to be used here is misleading?
> It'll also be nice to separate the changes, as ramblock.h doesn't belong to
> migration subsystem but memory api.

cpr requires migrating vmstate for ramblock.  See the physmem patches for
why. vmstate requires a unique id, and ramblock already defines a unique
id which is used to identify the block and dirty bitmap in the migration
stream.

How about a more general name for the type:

migration/misc.h
     typedef char (MigrationId)[256];

exec/ramblock.h
     struct RAMBlock {
         MigrationId idstr;

migration/savevm.c
     typedef struct CompatEntry {
         MigrationId idstr;

     typedef struct SaveStateEntry {
         MigrationId idstr;


- Steve

