Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4C2D374A8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SIN-0008OR-Gl; Thu, 17 Oct 2024 11:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SIL-0008Mx-1r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:20:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SII-00024o-NH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:20:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBb1V009186;
 Thu, 17 Oct 2024 15:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Yl4CnOjdTGfvfpqcqykq9uww5SA/0nz7l4x07+Mk4/0=; b=
 O24BjrhwxXU+QCaswypBJQ7/V7bKqncLtJUKBi4qsNU9O3SfKzJbQL0W/p0NRtm2
 jGvdHA/OyTIRT6g+Q1zRilWgtxYD7+l5teGsuHEcT3b1hzC/NXSqjbCoan8d0pAR
 s4+ohUtumGwFe/IrYHtNkS2cK4WaI5Gi/ngLnVMLRgr7IL3kN5HomF6089BqTfzs
 A6PlBs3EuzySjVwIrBCMSw/uUFvkAxkF6xPRTShfcy3zIJR7hwfUDUvr8ZGQsGBd
 0jdQysfvWPjqWluDinWMje7gnokYfhqgCgKJnogIEwEsuUZGF82amNz7P8wXQ7Uz
 4Ei2HASuJPKARJgbtI5mWQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7pr0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:19:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HEU3G4014817; Thu, 17 Oct 2024 15:19:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjac2j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2Y3+iA2C82LGyb8q2Lgnn5C/F4m/o7RTYpks2R7DXXnu0EVmjtddvY+Ia7f/VVglNQPYkmYpgL1glkSJGgx/iqTMRPq3OEW1Qsjax/OfrZp/l7OIA/xdJa1IgFvp94ksntOvT2Pm8hcoD+Wn3Qrp2sFBS04rJ0VegAr+/J0SI0NK4e+UJ7LY68ewd1z32iGqDMW19hZ5j7DVvaVk6ODKmkZB3fvWn/N1+L11Rgih7OTQOs2eOQBSwx3yvgNT5tz3yiC+EGGAW7mkgYAzbd3bkRccNPfEEhOvwfPYxaFiWU/D/DN/nCVME/agHTOoz9pEN9b6oJu6TJUYRi4DGnGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl4CnOjdTGfvfpqcqykq9uww5SA/0nz7l4x07+Mk4/0=;
 b=fv7CrhJ4gcs8vi11rcEEbeZYEo+jM22vXms8pE7w4cQ0y2NHSLUHHCt3S9jlL799jRYA03xPZqIvniS0RnvQTuHgRW2igZVXZpv+1934omxCLue/+y6Ncm7lnpdG3n8lfGoMoViiQXY6nhzxnq9cHbkzZ2WTyjVf1wHZ7Ik3dRn0RnQ/CcrrRv9j0MPvPDV+4IFpeoORWlo46ehv3k9/r5hB7pUbF/ZnruaTMoBtIgBviO0I5/4epWXlSLy/phspgFx1PX381ghgS2TgCvP+T2UFAFhEtGSMwCwIT26orhPFnlnXLUbAMHnAAujrzUFZ63rQ4r8pd+K82Zbw+2xy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl4CnOjdTGfvfpqcqykq9uww5SA/0nz7l4x07+Mk4/0=;
 b=UdH9PVXj6B5ZegbBGcrvlXSFJD5sETdXNAksM8e/oIliPHiok+3UhyaHzI9tzPSwVFg9AFlLJWPURzmo6F/csPBhPAMh9lKFP1lNEPjA5lO3spkalmDFD7JFjdAtboYHlz0dUMke0+5m16WvxYT4kRpJwUjAXgSQ/gM0vL5+TLM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 15:19:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:19:54 +0000
Message-ID: <e7a02200-b68e-4375-9689-5bd4b0e2a8a0@oracle.com>
Date: Thu, 17 Oct 2024 11:19:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 00/14] precreate phase
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:180::42) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7ba5df-67b4-4f32-0b53-08dceebf275f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czBvS3ZFRlVRTkZQQkhQM2ROdkg4Ri9JU3FETUVNdnoyZzBpT2MyQ0pMQnBN?=
 =?utf-8?B?WllrNHh0S2dJOGhHZjBXaXl3cVVoRmdHMERIQ2FkbVMvU1VmWlczeVVBYlFN?=
 =?utf-8?B?WXVubWFwY1U2aVVQblNMWFhVZ1RndmxvbXV1SFU1bmVNdzY5aTI1SWdxQXAr?=
 =?utf-8?B?NmRyTVd6bFF6RmhJS1JTSnNVVEl6Njl2RzhyaksrT25pQU1UNXVzUDRXdktD?=
 =?utf-8?B?QjNMd0NTQUx2cS9yTjFSNGZpWDhVNXFVY0cxMC9vY2lGTEU0eFErYTdsZG40?=
 =?utf-8?B?VUJpNEpZK29IY0FyRFRHeHR6SjBTd3VoZjdiWmdBTVhWUWVGMzJOaVlSK0h3?=
 =?utf-8?B?VnY1YWRXTnQvWHdScTR0TysrREZBcDdUK2FhdFZ6MTVqRjVQRWhxUkRpSTN4?=
 =?utf-8?B?RGpudURldVc0VDRScThJNCs0UXBiK3RTRDZCN21XdC9lbTdCRWY2S2s3N0Vi?=
 =?utf-8?B?OU53c3dqblR2aU9uM0NSbHhsN2pnTUN3enRaOEFmU2hIaUJvdy9oOFVUOFVB?=
 =?utf-8?B?dnFXTUhjTWwwOFQ1a2VhR2pnT2FHYUcyVW1HRmtmNXVDbUpISUlnQnlJckEz?=
 =?utf-8?B?R3NjVHRNcWFZZ3N4anYxQ3pFa0syMXkvMGFLRitiOFhFK2xCQmxBTml0MFdw?=
 =?utf-8?B?SnBXbm5DZHVQN0dhWjNlQnl5WlVtMk5NTFJFTUZwTDhGZ3hBMmxCbXRTaDJi?=
 =?utf-8?B?V3JTYjNxVmU4U1dYNW16V2h6U29RT1cxY2ltQXkxT25zTVhudEtjQVBqVGtM?=
 =?utf-8?B?bDRyVlY2V1Nqc1dEMzdEZWZDT0p5YWpBRlRKU1UwdjZrQ3J1M1EwZ2pEeWdo?=
 =?utf-8?B?MWNxTkhUUVFhek53WnF5cmh0Y3gwaTkzMjQ2azhKMzdmRlZRVGZ5UVRrVWFR?=
 =?utf-8?B?SllDUW9vbnMzVlVjR1JnRDR5U1I1VXZDbE5pUmNzRkdKZzBxVUJLb0lSbzhl?=
 =?utf-8?B?OFVPMDlWd3N0NDRvZzVFVmMzbDNvaEVkSnUzc0NKMTVFajN0ZGJNTUtRaUFS?=
 =?utf-8?B?Q3BqVm95YmVaUnUxcjNZRnNmYWF1bTN4M2tyWEdBdzVCdVh1SzdXVzFrQmhi?=
 =?utf-8?B?UjlkdHRvb1E3RjVZTUdQbVJHRmdJOGFjZTJVOE5kR3ZDektZVHRsaEg3ZTJp?=
 =?utf-8?B?SHRjOUpacXhzY2IyZGllQjNDQ2ZoWUx0cjhRaWJ0WEgzU1FUNHIzVnl1MGp2?=
 =?utf-8?B?T2M4OStrNmY2YjJENFRCOGE2cTFoaWVkbStJTzE3ZjBuUi91cERuMFRrN3Fq?=
 =?utf-8?B?YTYvckczR1dmL2p0Qzg1VTU2c3dKL3VmRkNoZEdFejB2cDJwK0RKMXlGMm1J?=
 =?utf-8?B?eVRtMG1wdFFWSVBaUGdjcGhVbkUwdjErT0NnZ1ZtZm5yTHVxamduM3BpbCs4?=
 =?utf-8?B?S0xFa0ptdEZCQkVibllKVVU2UGNmNWNKVm01YU1MR1dySkNHb2l3SEdaNUxG?=
 =?utf-8?B?Z0lNUklkRWRIVTd2d0haR1hkS3o4cGdDR2prcVVGaEpQNXJ3QndnOEpZY2Za?=
 =?utf-8?B?SkVFRXlBRkk1TkRWNGM5VDdhVEFJNDFiRVdRcGRGYno0bEM1cE0zKzdrbGpX?=
 =?utf-8?B?UnZwVFdSZHdtTkIxeG50b1p5OUxaVzZsQk5ZaG8vNy9aMFNYQ0NBOG1takQr?=
 =?utf-8?B?Z3BXWUtFcHYzeUo1MktyQ1NrWFpBT1hreGYycEpEdy9mKys0Y21KY2dtaUJH?=
 =?utf-8?B?a2pXWmY3QjIvWlBZQks4eXJ1bGUzendSSHEwVytnbWEzYUFIQUJLQ1JqUkZI?=
 =?utf-8?Q?iuI8rpIxNdnQLmJqQo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0QwOUNhanc4cjUxQ00zUk1BVU5La3lJUWdqcUJtdDZIT3A1STZ1UnBVRkF2?=
 =?utf-8?B?bzNTV2xJVk42ZDZFTmVjRGpsYkxCK3VxdDhtdi9zWGFIYnBBeEYzSWNGcHRW?=
 =?utf-8?B?Z1JBRGd0RTB2bS9ZMTl4NG4xRkxyK0FVYlhMcVVwYXlPTEFsNGpHZzc4S01K?=
 =?utf-8?B?RDZucUJ5bG9tWVByTG43b3RONmlIbnV0c2o1aTdGWTRpOTQwaVpUUEF6Uk1m?=
 =?utf-8?B?bFkvREpMN0w5UXFiMW1vOTQ2Qk5pSWhNUVFMbDUyTjdqL0prSllueUpXb3hn?=
 =?utf-8?B?TjllNWt5U1l5eiszTFN3dk4zY3hnSkMzRU95TEVJdHd4QlBTQlNCNW0yQUI3?=
 =?utf-8?B?aWlRQkFWWDhBNjFNclNTdjFRcXMzNEVWVTJTNnc0VEtHemdyZEFZMStNb3BK?=
 =?utf-8?B?aWNkNXcxdlErK0JwZnVoZFRpZ0M4Zis0Z0h6RzVSNXlFR3FNNXI5aHdYM0cy?=
 =?utf-8?B?ZXR6RTlndndOdHJZRS9wb05wcUNCR3hRYk0rdEdNOXdjcEtEaWc1Q2JTcGVs?=
 =?utf-8?B?eUJoZUMraERYMFZvMWR4VjZHM2hZME5iNktybEZ3ejA3Z0dJQWl3ZzJqeGlp?=
 =?utf-8?B?cUljdWRjZ05yZVpnQkZSZlFmamlZOFhNdG1HR1Y5Tk5pMzZBdk1XK1luTjc0?=
 =?utf-8?B?RVM1dzRiRWIvRWkrU0d6SlVmQjZZNmY5ZVJEOU45UEEybnpDMFBONmRDWjFM?=
 =?utf-8?B?eHlnemhKcUhrZlo2eXhUR1lvOUFZb1FsS3hSVzVvNi9RekpYNUVSQ1AzeXh5?=
 =?utf-8?B?QnY1a2Y2RWNRNTlrYUkraFFDeHVxWGtHNEtoRVVQaFJ3UE5jL2M3dStRSCts?=
 =?utf-8?B?ZWRSeENrZGpqMHg1eWszeDE2Q0ZjWnZJOGVIY0YvckdVcEkrc09qanMwOHFO?=
 =?utf-8?B?bHNzSEU5ZUtaUFFuMXdrQ1RkS0UvRmx1UGlmNzgvTVNiMU82ZDVJRm9CK29U?=
 =?utf-8?B?ZmJ4NmxDc0NqMklYenhnV0h0a2NHb2habHgzc3dKQkUrSXZ5VjVmYkgwR0Y4?=
 =?utf-8?B?K1pDaVN5aFByVnVleUU2cktHenBHaVc3dHFialhmN3daMmRpcUdIYlIzMXQ5?=
 =?utf-8?B?eUozaEZoWTV3QWxzYitqaDV6Z09VaVd0UmQ4b2NJbUJIOTBGQ2xpYWY1aTFU?=
 =?utf-8?B?NVpoSTNlc3hBd0M1YlY0VnJHd0V6M1BoVlh4bklhYUdYUnU1WVdQVmV3Uk9h?=
 =?utf-8?B?VGI1cmVKcVNBQnhTcEdYUTdkNy9teWh5Qks5dVdIMkZMSnpBWGJpbFdzaE1S?=
 =?utf-8?B?ZGFhTXMwcmNHM1BxSks5NXVvbi9nSW9ReTJiOW1rWHNFRFdEV1lMR1crV2R1?=
 =?utf-8?B?aHFEdUFFL1c3VjlQYkRvMFVEV3dIaFR1MGxubEdTYmdtSGZGdVVrSEM5NzVr?=
 =?utf-8?B?RVhJV1RJYXpaQVdyazh2aFAyaUFmZlBmZ0N4bkkwM3dMZTdNM01YNGtqWmJD?=
 =?utf-8?B?VDU0NkNwbFRRckxWVGZxcG5Jc20yVGMzbmx3S2VRR1g1VUJrWkNjZU52RUVm?=
 =?utf-8?B?czRFb2dFU0Fhek9FMTdGOXRFNW9hSHdULzJUNVVnd3JFWHdwWTduYkp6R2FX?=
 =?utf-8?B?SXV2SDV1RlVjQmkweFNrbmxDR3g5Z3dGdExoMmJVdks1L3hKM2lySjdoQ01x?=
 =?utf-8?B?U2kzZDJhV2xoVXVSc21BOHdNUjdsbTlCbEovMjVmeGF5V01JdUxhQ2pQbVRZ?=
 =?utf-8?B?SlRqU095UDZvZzdodmxRVnkzVTFPbDhheldpVmt5WFc0THFkTWV0eU9VT3Zs?=
 =?utf-8?B?VnlXWFdJL0tycldxYVIvSWtaMCtMTXFrSi9CL3RHMXl6K1ViU3NoMHdWT1c4?=
 =?utf-8?B?cnlTbFhVYW96aDU1a1haL1lmeENtdmdRaVI1WXl5bW1tLzF3eFI1NzRLbmds?=
 =?utf-8?B?RG40dFk1QU0rMGt3THQxaWNRVUViL2dPTTRTeS9lUStRZjBEWnBjak5CYTE3?=
 =?utf-8?B?bFBOQ1lFa2hYMk1XcisxTVlDNU5kb0xZOFFGYlZjRDB0NUlydUZYaEZLUWhQ?=
 =?utf-8?B?akpzZlIzaDkrMjJXeS9Vd0grb2M5WUFGQnVTKzQraHA4S3ZoRHhSK2hhQm82?=
 =?utf-8?B?VlVPWDB0dVl4SkZwVHJva2RmM1NlOVBZb2tJWlA1NWFKU3orMVAxaERsRjVX?=
 =?utf-8?B?bU5TNnJuN3RwZS9mL1pxMjBXQjhJejU5bjkwenM1MERXWHp5MTU0L0lFTWlv?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BeJ1CN2pydImPL3pK1AY7u8+OP/djYJNuDyACvvu12qUDYwE3jfh7AbkK4JGisLwOmPnkWfYuDHDB+iOulX1YV63tKZDUtYG/D5mW3weFG6B4Sm8GzOb31slwTI1aVzBM6DVV49P6QCMvTSXCy8ZiDT0Jl0yirtpjzJGmirQYLEQDWwAIKA6roz56YUXsgG5H0dm3JUw0A6Oi+vT584Eb26qKTN3w1dLnzjSoTK+KvYiFLGZ4L00WpZvj8K4S6fPFrX90lSI2pssVQKx846jZ93vZIitzHGR5KcpvKtVBlQ1VxvOR5xX0Kg3Z2d270jQjKyKyAjMnWavePCN7iBJgxY+HIu/+eeNeJ/S7M/pj16xeI9sCxduGxK4Uf+ma6fZfi1ZZvn5jrGtZkRA6JCVKJJCKpjeBi/YMDjh5jl5CRlbVRDtGBiauJzgo1z6heoUOEiJF3fq2w9/NFqLbGxeAFk+PBzF7ZRsuT0haWUbqliRXclcWWJNN9trkpT4Ileaq9gYqZF4mO+77ICawdt/w6iebAsjbCXLFyOz/gDICLawEEZIkKBJwt0MJ5O/lIIQbJoDrMphS9y5s3OFnFOxtXN62V4WCBj/MO+NjwWfB8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ba5df-67b4-4f32-0b53-08dceebf275f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:19:54.7991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+ds+pZK3v3hgwAn1pNuuhBSvTS/D8fyav/cEuMKlFgcfpDDlVPsbXCGpHFsZVb0CEBn24MkOAR4qSO8b9QMd9y+ldwEm5TUfmcofK7MDqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170105
X-Proofpoint-ORIG-GUID: _cg2jv6_jVU_aBQjKYHP6utdw9GcOpZi
X-Proofpoint-GUID: _cg2jv6_jVU_aBQjKYHP6utdw9GcOpZi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/17/2024 11:14 AM, Steve Sistare wrote:
> Define a new qemu initialization phase called 'precreate' which occurs
> before most backends or devices have been created.  The only exception
> is monitor and qtest devices and their associated chardevs.
> 
> QEMU runs in the main loop during this phase.  Monitor connections are
> active and can receive migration configuration commands.  QEMU starts
> listening on the normal migration URI during this phase, which can come
> from either the QEMU command line or from a migrate_incoming command.
> Thus the user can issue query-migrate to get the socket-address for
> dynamically allocated port numbers during precreate.
> 
> In this series QEMU passes through and does not linger in the precreate
> phase, and the user sees no change in behavior.  The cpr-transfer series
> will linger in the phase for an incoming CPR operation, and exit the phase
> when the migrate command is send to source QEMU and causes destination QEMU
> to read CPR state.

Hi Peter, I rebased the cpr-transfer series on precreate.  The
cpr-transfer migration-test now works.  Do you want to see cpr-transfer
V3 now, or wait until we get feedback on precreate?  The only significant
change is that I deleted the HUP synchronization, and I post an async
listen for the incoming cpr-uri connection.

- Steve

