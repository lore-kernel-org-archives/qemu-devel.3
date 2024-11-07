Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E608D43361
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t937b-0006f2-QM; Thu, 07 Nov 2024 09:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t937W-0006eT-SI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:04:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t937Q-0001wO-UC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:04:21 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7D4V7S025100;
 Thu, 7 Nov 2024 14:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=2Lq3kD4/q/CG4ezBQUDnfJWtzXovkFMzLpgqmUL81cs=; b=
 YYyhGk8YbcuaW5yPbe2LfV1ow+Y1nIlUsMq4kpgEcw9+ybZ+xK2vHdt0rKzwKvJG
 fbOqVKjRAWBsIf9iX1iCS/Aw7RQkt/KmrtD05yCyIc433XEAhM+Q77MdlqfdGSnr
 7NKhZkMBC//mjWHrfTc51W9FCcXFLafZ5/reSI6MpXI/aeMSP+zIsmCmjuFVZn17
 z2uKUZDM72PIrqIt7O7uGyLX+ViNTpkb1c+rh/E6t5g4zfXY+Tx9aeGyUR7XCkFt
 Jsa7oOYdOlN7ENfxEXtM84yWgI6tMpJSVIszv9HzhOrbAlU2Rgl1ytymwGNHl7vB
 bjFU8VfG4YaCX7z4zc1+5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap02k3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 14:04:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A7DAqxv009947; Thu, 7 Nov 2024 14:04:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahgce83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 14:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzSvT4pg0XsJT07GUbsF33paEMspFlA2kQnSrzZZamHJkAsX4oF26qkKcIGray2Si6V6G1e4wtY6Chx9he3JJ2+9Y9TD1Npcms3l0BPlkdEFHbhG0RPeKyUMgacBdqWzzLg3uMaQM5JS4CdmtjIaivGmqc2vFPYDmyKhuOVDMLaeb4SAA75Ox0uUQuieFp6ztSoDDdj/rEs/ksSCmMPuMihYT4D/DYryQ648L0bUIouDtOsBEcaucndUMDxwij/UM3L/zuPA2p+zpjDOyeA9fVqL7NsQSepR48aNgGicalt6UgIAgaww0jhzH9Hs6YmXBY98An8kbhDa1641WL/2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Lq3kD4/q/CG4ezBQUDnfJWtzXovkFMzLpgqmUL81cs=;
 b=v09VfEiQ9Px0JYNuLy8AJRh/4WFgxe76F8B8RXAWemc31Eun1ZxWm6XU6PAwT8hkIFHFBewbx5wWEBr600RB9OypAKNh8x2FD+XznALvF+t/bDrQxTgeHKJsSi58OAePY9fLxEBB36y4lDUYmof4MQ/WWfo/KTtQOEHqQf4OXMsLL4RzEq7B/Zpa4jb5cU+oJ2gA9YfLRemeDx4pyWWqAB4uqCPwD8lsoIi5/j4SP2EZPOlCk2To0PtCdqq1VDW4jMUh8hOOSnbkel58rO4qfums9DZuA00U9Ffkx+AD/E3bILoR1N7MlaBgBh0N0q0TGmUw97Qb7t2A2aBcepWbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Lq3kD4/q/CG4ezBQUDnfJWtzXovkFMzLpgqmUL81cs=;
 b=g9eyObDdCiicStnseaYOYjZ0VUGtcxC2cY4jX8o8lqQ6XGL13bSA4EIcztEUAHkmwG0apnpo2dbimPrOA52gZYLRqBFIjWLUmqie6tlm41YG64Yn9IOPsulajeqz9Dqngw6A4ZchEIANDCiXXoUcqOGTTMXG7p7AWKHf7FNgCyw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 14:04:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:04:03 +0000
Message-ID: <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com>
Date: Thu, 7 Nov 2024 09:04:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com> <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
 <7fb32744-0512-46e2-b58d-2990f742b897@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <7fb32744-0512-46e2-b58d-2990f742b897@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0935260b-8272-4d48-31df-08dcff350917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bThnUXBhd0VmYnJXRnppZTlyLys0RFlzanJUR2VGWXBhM1NWYlQrOGZlWmFx?=
 =?utf-8?B?elNaVFJvRVZST1Nlamh1eFM5d0VDSGs4SWV3dW01bGtFVTBJR3VVcnFmKzIr?=
 =?utf-8?B?ZnVLdkFDekNLaXpwSkt2WWFxQjZtMDBtNHpUclhUSU9Vd1ZsVFBQTlhIZUwv?=
 =?utf-8?B?NzhZdE9QeTAzaTNpQlVZaHJuM25rcEZwUDR3Qmc3QUlpWDNoYzhOSXNScXds?=
 =?utf-8?B?eTdnbTRBQ2NJT3dOSWNmZTg3dWw5Q2JRQmJFR0pPd2xuUzh6cTFnRHMvRTg5?=
 =?utf-8?B?QlVjaG8wMDFFdzFMci9uYTdDaUR5Q1pGbzhPNFIwR2R5UkhuUDhXbXZGQTZ6?=
 =?utf-8?B?NlNpTDhXcDJxenh2aFk2MjY0NXBCdDFIWDhuUE1BU0dnRzUxbm1hdmpNSWJo?=
 =?utf-8?B?Rm9iUTVUV015VTlXMkFUWkYrRGZORkV3VVViZTkzUG1Wd2loTExkQ25ubit3?=
 =?utf-8?B?REc2NFU5OXpkZXRDMStQV1B1b2h5b1FSd0VSWjQxek9MYTlGaTc1cUVJWlFC?=
 =?utf-8?B?aStRTms2Y3ppeWxmdnUxNTdOWFNacVQxRVJ2Q2lFR25GWEVId2dTb2ROMHl1?=
 =?utf-8?B?SHNaMVFpVmRwVFJCV2dVaU1sOStnV1BBSmdwZU9ONUJWV0hxUTFYdWg2Sit1?=
 =?utf-8?B?ejBlaGVpeldQZ2w4dTlNNjZPQm9WemNvY3BhSGwyU2ZnMFdYT2czajBUS3Jx?=
 =?utf-8?B?akl1OHpKRVdUOTJyR3luNGtBUUg3OCtKTVllYlZBSG5IQlhQWUNpd3FnNlJs?=
 =?utf-8?B?VStnZUprMGV0Ukdja3hvV0pleFV4enB0aFlIV2xQTWtvMEgzdEg0QVIzRUdo?=
 =?utf-8?B?bjlPRVA1SS9OWFlGalRsNXB2UTJNL0VZbEE3a1FZU296M2VxdVo5UUVMZFdI?=
 =?utf-8?B?T1hFdGtjbmJtVXVvYmRpZTJOSHd1ZHVVRXo1WlFwd2piQ0hud3JKVGZMK3RY?=
 =?utf-8?B?WCsvSEpqN1d4TWVHNjgzWDZrbVpldmtvTlVUcmJjT29OdGxYdndvdFUvaStZ?=
 =?utf-8?B?REcxaFo2TytHM1B1MnJMWEw3L0lpcHZiVnVKSkU3dlFRRVo0WjlUbXd0Y3Vs?=
 =?utf-8?B?UjVHY2VHV1dJNTlyRHcyOUcxbWVhTVoxczNLYzN1MmVZUnI1UndvVHFzTGpr?=
 =?utf-8?B?NVkyZkg2b2J5bHg4dm9VcHp5OFZ3U01qbjlWQ2xzNDlWVXVtQXVzdEJpT1pF?=
 =?utf-8?B?TDE4d3BoV2lPckJkUzRJekplQmtlUUdseGxDOENjSDVLNEpUV3hNQnN5d2dC?=
 =?utf-8?B?M2NTMWNPUG5oand5UGRLT1dBeWVEWUVVeU1ZZHNLcmg3L1hNWk9YWDlrVEU0?=
 =?utf-8?B?L2lUWmo0YW9NQ3hBU254MXByWEM2QURnWjVFMVBGaVphYU9DdS80eC9MQzBX?=
 =?utf-8?B?YVdjUWFINkFMWWErVFNod1NuVyswbmtZQ2NBQ25STThuZ3lod216NzdpQWZn?=
 =?utf-8?B?UXhwSllqS1JJZTJJYkZmQStaaUNkMjYrdml4bXIzV01Qa2M3WWtEKytVSnNQ?=
 =?utf-8?B?U0FXVDdjWjl5eVpJR1RJbDIyblRsbWhZS0NzR3NhODJ2SGJNcTUxK1FoSkll?=
 =?utf-8?B?aEozbHBKdlJVdmJiclVZL2R6ODlmVkZFZjZmQjEzRXZRdG40WFRsZGE5Zmph?=
 =?utf-8?B?QUFmTGN4dkM1Vk52eWJTY2RiUjhHY3k4VURSWmxvaUxBWTQ3L1ZuSG9wV3ZQ?=
 =?utf-8?B?Z25ka3o1S1plTktnMzVGZ3FCNlAwZW04WWZvY2tnUHNtQk54aG9LMWNIVlNR?=
 =?utf-8?Q?/B8eAQO8aTcgm/RJK7sqM3wmUv66dkIqaXnflUR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpRRU9uM0dDc2pLOHQrc005L0o0d0lHZGFkS2dwbFk3TDhYTTdEaWZ1Yjhj?=
 =?utf-8?B?bFFqWDdrNVJHdlBpRzFYcGdGQzVKeWJSeUQzYS80RllWWFpiRGVPTFplMWRF?=
 =?utf-8?B?cDZRNGI5aEh2K2lQaVlTSGV3a2V6dTNiNEMvVU5PN3JUUGhyMVFwZWUvL0Q4?=
 =?utf-8?B?a1J1WVViUFEweVRidVhwNUdQb3k4ZTFmakJyOXFKQXFCMDdXT0NLNElqc3p2?=
 =?utf-8?B?RXp5MENiYmlINllJU2NDcGcrZFF3d1ZLaUh0NEIzVXpoRzNIb1A2dlJQUHNv?=
 =?utf-8?B?YjYyTU5ySEszazhCVDA4UURsYTF5WThZY3ZPQlVxQStvaklXTnhJK3NBcTRS?=
 =?utf-8?B?TStMWXhPVXJnZzMvOXVvaE1HRjZWa3pPZVdVK3JlY2NlK1FlZnRBU2JQZFMv?=
 =?utf-8?B?WFlLczQvQ2RPMTJTV0g1aU9WVGpZdnNRN0FtdHIvT3dIWWFtMDh6QnRxRTdp?=
 =?utf-8?B?TThhMnBhSGhGY2VSUFVaZVpBSitsbU0zMjFsZkpzL3cvS3pndDZwQjJhemxt?=
 =?utf-8?B?UlNVdDhiL0dwUDltU3BFT2Y1eFA5RjVtMkl5Ymd4TnozZXVUSmN5LzFnS0Q0?=
 =?utf-8?B?SnBiMUdCcWdSNUlhZlNLNlh5dFkwMEFTSG1tSms3Rm55NEpUUldJZlNUc3pj?=
 =?utf-8?B?S3FRek5mcUFIWG1adW5qcm9lSTBEWkliZmVoQVF6dHU3Z25wanRLVG5Za1JF?=
 =?utf-8?B?VlJtUWZXamg0VXRLUnBYaWd0SVFrUE56UkRkVWxhUVd0RVRzbjRPMDZYUHZV?=
 =?utf-8?B?UXNzNFd2Z3M4cGoxM3AyaFVVN1lwTVlBQXc5VUhITkE3U2xFcFMrNk5UMVNv?=
 =?utf-8?B?WjlNUlRDclRsU1E5bUFQRHVpUThNdWdwK1BiVHZrNm5aSnhrbGUwRDQzOUNk?=
 =?utf-8?B?eHFrMUVUQ1BBQzJxUmQzbmt2ekhVb3hpT0g4ZTN1Nm5IcWhlaml3c3l6bDhT?=
 =?utf-8?B?Zm9HVVl4N0tERWNKU2FCbTVmSzA5TUdTbWxKTVFSdlZmTlc4dkFqL0sxekV2?=
 =?utf-8?B?V0NOdHc4bldJL0tsVnRpM0EyVVN2L0k3ZG1IaGpNUnRnWndGU2RJRWRJYzFR?=
 =?utf-8?B?anppTklSWDNrQ0oydEltN2o4ZlhLYTlxazBpcitodE90ZWw0UXRPcDF4NFBT?=
 =?utf-8?B?Tlh6eGRlb01yUmV6MVF5VGNXM25ZWkxEYW4zTnBGZElZeSt0T3Zuby96dWtu?=
 =?utf-8?B?ZnFWRGFHTFRiaXd6bFdWUUlUR3VTcmZ5NnQ4QjI1M0twa2JwcWt3MDhyZktz?=
 =?utf-8?B?ZytYK3lTdVoyV2pZUTlOdkJjZGVjdHYzaFR1MlVXSTF6ZnpuaWR4Ty9yL3Rq?=
 =?utf-8?B?eXZ2SzRLbjliK2lRbyttSDBJMDkxU0tPTDRCTVhpV1RFYTBicWtCS1U2eFpi?=
 =?utf-8?B?RXZ3YUFqMU5oS1RMTjM1c2phanczU1F3VVpqVlViRWNoajV6QUh4VnRyS3Ni?=
 =?utf-8?B?Yk1YcjV1VmpsRXdwMWx4U2NwM2xDVGNyMVV5eW1VTTFYWTJIQVdaT1RMTEVJ?=
 =?utf-8?B?aWRuQWNtUmQ1a055QjB5blZPemp4TWtGUGRPUm54ZVhLK2RvS1h0VVFzbVFO?=
 =?utf-8?B?K0RUN3RCeDVBcndhcTRpK2hZT2JqOW5OK3JnYnZwOEJHWTNMWDlOSldHNFBn?=
 =?utf-8?B?Y1hRbHdVa2FwNEo4TUZ3am5Rc1VqSEczTnFuMlJNdWFMcFRjVDZDZFhRV2Rv?=
 =?utf-8?B?Q25nQXRlK3pMelUxb3M5SFUvczNaa1hRVDB1Z1lRMklBMlRHWjR3NDVqcVB6?=
 =?utf-8?B?YnI3M05lVER1czFVTWNScmVJV1cwM2Jpdm9qSHFJUGxWL2k4blM1Z0hJdXNM?=
 =?utf-8?B?NGU1ZXQ4SFFGenBsbDBYcHQyaEljNzJuenRIbXJ2b09tV2JQOWE5Zm4yK0s1?=
 =?utf-8?B?dHE4a1N0Tmh1WUM5Vy9qVVZ5clRmeCtiR2Q2UnpUbVdveFVJMi9Od2pTMGJK?=
 =?utf-8?B?b1U2a1pXN1NJWVRnb3hvZzBlRXF0NDB3ZGlnckM3T2syRlZOMTFmRXA5ME14?=
 =?utf-8?B?eC82VXNGbTM4UG1LQWUwK21ScWZab1JwWTVxREZRTFQxZXd6SUo1MXY4WmF6?=
 =?utf-8?B?cHNEdWFqNWpOQTByZGZHOVZ6NnVvWCttdCtwdHBKRlV1SXQ1NmVjc0hvazRt?=
 =?utf-8?B?T1EyVUVKalh4dk5SaHBraGRWQ0Ntd29HZUlHcU5VQVRYcEpiRk81OGdvWEhi?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iizx5Y1qe08/WRush20JXhdFoYa87QOlA6pqk5bVTHp8yV+BAIVgSZkBZ5rHxKxB3OcOZjpb2X4982oQpfVHvdbktG8ru4kYb4JcNMsPzVKLIxROikqWjeWgscx5Vm4PTUGbWBvRPL6m7U6Nz2LiUaelcvdvuUCUiE+iNclyQsi5Dy2Q5UYuI387IkmoAWJ8hp5+zSxpxS8rjvYs7Ao6jB32FmQN87zA8s+vpFuWuDxj3Oo7lT9j+pKH53ijTZI5cJjIcUzAJLUVBdDASd/wztzvkQsIdDhmeONNeenvIzp3jIuq0f15hOt9TClupfV2DD3FR1LlEXFNLVaKENlGwu9Up8ACzNwSoI8sbEJBM6+GMwz+QrF0Jl0CAPl1a61h+lSKNi23QaTtxFS1+1C3C9Fc7Rr202EzxEXY0exQEBTBn5GTn7hL9k2xef/ZS+qYFwUSO/6ZzjXkKda3LAJ6u62r0VsnQJwOTuyQrft+/2y+ycwWxKw8t/JsGTAzcmO0E5R4QDv+lsrD1Eeb9QlpoLwVI6iK0Czfftr85zv/xxhzXmUwEu8Fx2l0oR3CLedMREYogNaJJGp8u5bP6FSO8kJ9rLtBPVLnkEoIt/SbK5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0935260b-8272-4d48-31df-08dcff350917
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:04:03.2418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Uh7bYeBslmYgZyBNmTzcWgMOd0soC0FnTstKK9sxZaoCsClsBRlPUJzciJ37GkIrRXZmDJKOqP4wuhzEa7uXfJ2DGLLd5LhXWjQcYI/NHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_05,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070110
X-Proofpoint-ORIG-GUID: cHYfzM5tQ_xOhGZc0-vPAiGAEzhQIZCN
X-Proofpoint-GUID: cHYfzM5tQ_xOhGZc0-vPAiGAEzhQIZCN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/7/2024 8:05 AM, David Hildenbrand wrote:
> On 06.11.24 21:59, Steven Sistare wrote:
>> On 11/6/2024 3:41 PM, Peter Xu wrote:
>>> On Wed, Nov 06, 2024 at 03:12:20PM -0500, Steven Sistare wrote:
>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>
>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>
>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>
>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>> details. See below.
>>>>>>>>>
>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>
>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>
>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>
>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>
>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>
>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>
>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>
>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>
>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>> -- memfd if available and fallback to shm_open.
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>
>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>
>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>
>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>> of options and words to describe them.
>>>>>
>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>
>>>> Hi David and Peter,
>>>>
>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>> for simplicity.
>>>
>>> I'm ok with either shm or memfd, as this feature only applies to Linux
>>> anyway.  I'll leave that part to you and David to decide.
>>>
>>>>
>>>> Any comments before I submit a complete patch?
>>>>
>>>> ----
>>>> qemu-options.hx:
>>>>       ``aux-ram-share=on|off``
>>>>           Allocate auxiliary guest RAM as an anonymous file that is
>>>>           shareable with an external process.  This option applies to
>>>>           memory allocated as a side effect of creating various devices.
>>>>           It does not apply to memory-backend-objects, whether explicitly
>>>>           specified on the command line, or implicitly created by the -m
>>>>           command line option.
>>>>
>>>>           Some migration modes require aux-ram-share=on.
>>>>
>>>> qapi/migration.json:
>>>>       @cpr-transfer:
>>>>            ...
>>>>            Memory-backend objects must have the share=on attribute, but
>>>>            memory-backend-epc is not supported.  The VM must be started
>>>>            with the '-machine aux-ram-share=on' option.
>>>>
>>>> Define RAM_PRIVATE
>>>>
>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>
>>>> ram_backend_memory_alloc()
>>>>       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>       memory_region_init_ram_flags_nomigrate(ram_flags)
>>>
>>> Looks all good until here.
>>>
>>>>
>>>> qemu_ram_alloc_internal()
>>>>       ...
>>>>       if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>
>>> Nitpick: could rely on flags-only, rather than testing "!host", AFAICT
>>> that's equal to RAM_PREALLOC.
>>
>> IMO testing host is clearer and more future proof, regardless of how flags
>> are currently used.  If the caller passes host, then we should not allocate
>> memory here, full stop.
>>
>>> Meanwhile I slightly prefer we don't touch
>>> anything if SHARED|PRIVATE is set.
>>
>> OK, if SHARED is already set I will not set it again.
> 
> We only have to make sure that stuff like qemu_ram_is_shared() will continue working as expected.
> 
> What I think we should do:
> 
> We should probably assert that nobody passes in SHARED|PRIVATE. And we can use PRIVATE only as a parameter to the function, but never actually set it on the ramblock.
> 
> If someone passes in PRIVATE, we don't include it in block->flags. (RMA_SHARED remains cleared)
> 
> If someone passes in SHARED, we do set it in block->flags.
> If someone passes PRIVATE|SHARED, we assert.
> 
> If someone passes in nothing: we set block->flags to SHARED with aux_ram_share=on. Otherwise, we do nothing (RAM_SHARED remains cleared)
> 
> If that's also what you had in mind, great.

Yes, my patch does that, but it also sets RAM_PRIVATE on the ramblock.
I will undo the latter.

Do you plan to submit the part of your "tmp" patch that refactors
shm_backend_memory_alloc and defines qemu_shm_alloc?  If you want,
I could include it in my series, with your Signed-off-by.

Do you have any comments on my proposed name aux-ram-share, or my proposed text
for qemu-options.hx and migration.json?  Speaking now would prevent more version
churn later.

- Steve



