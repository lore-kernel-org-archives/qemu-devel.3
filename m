Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F20CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFB-00089i-80; Thu, 25 Sep 2025 07:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDs-0006aO-Gq; Thu, 25 Sep 2025 07:33:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDn-0008Oi-5D; Thu, 25 Sep 2025 07:33:14 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P7dCfm3782006; Thu, 25 Sep 2025 04:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Mu/g4bcmwg/bDc6oFJSPsZtRZAK0aWPP5+XxKhvdV
 34=; b=mK+zOCw14B/BZ4APhn185zTsrkSUKNe21h3ec1q+L9c46y7SY1+yWCU9x
 ytb/6Guc+Y4dMNjTu+j7ol5ZYH1GT1a0QFOWoZUeYeuKhL3eTuzsDkcpDkCi3TbV
 Wkxdrbme1eYAZ0Jp0FAH8xmaRqemdYCDP/P4fOHuzkH415jIjrS9uKMj5PzAEB3v
 A+gP0SF0/3NiitiSUOdFyd9MVuqmghU7yLgEySQ6A9QWcuy1+6z1+B+RBmllEzwj
 25/3lOzxzTENRrSgV5FAc+I7IDtsftzaHyVZNMJbustJQV96QrU0mBs4dIQk/zdA
 bczp2ayrQ7TUNmdnNdWxVw4FEK7yA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023143.outbound.protection.outlook.com
 [40.107.201.143])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1hn0fmn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqahNlifJhJNjhyi3nZLwso4lWszD584+tfYyvXtyq1h5CxZOn9gXYVu94yi7BCk+tcSiAABnF+8atB4r8XHPmWb2q5YLOwdggs1JzUYeJYOsLcWl9N/v+k7VbQqJUwC96A7svazW1HhIXhIdcGKdasjJPTbjuh31iGMy7AseqainWIOYjR5w0rB6MUMzPm+5p4xGEqZhsp9Fxsc0hXGpZX4XcRkclbtX1hIbLlmpz1Nk11EjIWfNMu92gRpUcN9+JqTItQlu0WD9+R+akGbqMCWxQhWw66p2RNT+hAoH1gZQdtzQETzU0RjB7/8hg39LDKdaUNJd+/vcZtAHe3iCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu/g4bcmwg/bDc6oFJSPsZtRZAK0aWPP5+XxKhvdV34=;
 b=uqNG91Z7ohKqAMnj5B8aTCE//SZMHn4RPvBbVhWGLzkv0vhmnBVMosiUmc/TMtYUSFiJQPMf98+nUQ0Yi+hRxDnvffdugjWI47UYiYjcFD02dP/JZUzS3cm/yGr61dq90b48hpn9Eq4WbQB6ecnZ7OwpifkALsoY2L+dRrgN1Mq/6pxwmDMGM5h8BIt+uHZx2cU1mOfjkLUUw41PBW2RBaBvcj8BT9jihJ0IM3MN5huMDy0obKD9BNkzL25D8l4a8QnkOSQEEU2M6ou1PWJT0ot8aOXQfBn9fT+KWc4OVo4t+xIPsc0VReAtyQBkGrqBy0P6d/QMm5Tlfdnc9xEOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu/g4bcmwg/bDc6oFJSPsZtRZAK0aWPP5+XxKhvdV34=;
 b=nhy1QJ3g0F2GcOKb1Gx3hiXvot4E+WHk57dWnZuhY5CKsHzjSUtuoNI7Ik6BXsB8kY1z171xtrPpVf8YEzXnk7ACIXr7pj+MEO2VhgoJLArPzrR1HyYcV8sVB/NtL+wFNJvb23v/3aE01wMS4hlCWgx6VJeoox2De4fL7cl0xpydH3kHQFyopqVolLKMKStq7Fds3/hAjltJ8YcFRGpNpbAWinsSs/Qh0PQWHSWAZABDhTLzawMmctAx16v3/Oq5RbI1ClJUYymz7c0/Xxp2qo2o7EALG1cSzj6Z9qrebdjgTu6lMqMKuwT0MG9Ng/cHvt4c2J/7DAc9DlF8KOnsOQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:32:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 16/28] hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to
 TYPE_VFIO_PCI_DEVICE
Date: Thu, 25 Sep 2025 12:31:24 +0100
Message-ID: <20250925113159.1760317-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d45114c-3411-49c3-5d30-08ddfc274730
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R296U1kyQUlFOFpON0lCMzIrZ1YyM3VQMVNSQjYvZjdYb2Vzbm9JQ1AydCt2?=
 =?utf-8?B?eFgrTFNMZ0Uxek1pdEZaejk1Q0FqUkdlemtkZ0dFSVdCdzF5S1FOSDRzT2lo?=
 =?utf-8?B?NTNvNlYrUnkzYmJmQkxxdXkrVWFkdVZ4ZTlsWG1Fc2RRcTkzUmpSWGQyT3RM?=
 =?utf-8?B?L3dXTnF1SUdoaUJobUZ2K0VHTDlqZlpVQ3ZRdjZwMnE5UVMzSHlVbE1TTVE3?=
 =?utf-8?B?MjZtZWsrT1ZKajZWcDFCTk85ZVVMOExkNW5kZWRVZGM0citVeGVMUmMzMVYx?=
 =?utf-8?B?SDNqQ0M4dkpaUDI0RUNWeUNBYXZNeFo4Vi9jdkdhcHZXazJtRXZQWWJNeVlC?=
 =?utf-8?B?SHl2cVhUY3loOUtjd1RDbmQyRXI5Vk96SWg2MnVhekk1aURYdEgyRzE2d1RK?=
 =?utf-8?B?NElSczI4RXRhNTVmUWJQUE92alBlY1NCZ044Qmh6Z2grRjNhc0JtMis3Z2pK?=
 =?utf-8?B?WFFmTDY4NjJycCtKUVhJSHR4V0JLa1pKZWE3Z2tybGlLb3dna0xjTjBHL0E5?=
 =?utf-8?B?RDRmbXlaL2FUME9OZ3R6VkdzMURqMzd4Ykt3bUdwaUZIM2VncWkzd1dtN0k2?=
 =?utf-8?B?MXRibDMyK3lpUEhGdG9keHpPcGxrcTFsZnY0YWpmdmVlU0NkSW5RbmhHMlpp?=
 =?utf-8?B?WjE4L0RqeXhzZ2N3aEg5R1dING53YWxlWnYzQzZwZFJCSnNwMk4yN1pEcWh1?=
 =?utf-8?B?UWdVV0hTWlQxR20wNlo2SDJ4dkRVQnZGWUx2WHNIeXM3M0NlRFYrR0ZzK3JL?=
 =?utf-8?B?WVp6dmpDdUdhVFAvZlhRTS9DWG5VaXFLZ2I3OWlsRklQZWNrRzRxMkQzNEZT?=
 =?utf-8?B?TmdIdmdKYllCT01vWWZvRUlPZGtNRjB2bWFBUXB2L0djVjBPSVJOeDhIN25x?=
 =?utf-8?B?ODBnV3U5WEVCeUV6YURjYSt1UGpjd3JHakdxcnJhcVYzdlJNcDlqQXM5WVZF?=
 =?utf-8?B?REZJcnYrbGZveFVOeTRRYTFTeEI5MnVKYnBOTkM1dERXcFdlWDBJN3EzVUxI?=
 =?utf-8?B?cmhrSTFWcEo4cVh5MnhCZHh3eHg2UkwyTktVSE1CVnpGNlR3NUhiVkpQQXhw?=
 =?utf-8?B?b1dyU3dUckxSOXQ2Qll0RlZYYXcra2lnbWRjRzZNUnRya3hxWVdLaU55d2Nz?=
 =?utf-8?B?YzRzNno4am5TY1ZZc2VvM3hTT0RtenZnMlVDN0tZRWFCeExGWC9KcHo0dHpN?=
 =?utf-8?B?ek83R09TamNIMHF6OXAvbDByZ3k4cVdDVXluUkVKdTdEN2dYWXZUemM2WDRB?=
 =?utf-8?B?cFVMMDN5WDVqVFhFUi9jRzc1VXVQMyt5NkR3RXlqNExUKytON3VvWitLTzVH?=
 =?utf-8?B?OWZHQk1XZGxpQTdETjF3bWFlakl2SFBJSXI2TmYySEdNTTVQRHpHTUs4L3pk?=
 =?utf-8?B?SjZMV1ZNTEV2eTJOeWtrSjY1SHoyVWx4dXAzeDlLcjI3QU4rQ3VLL0F6RTN2?=
 =?utf-8?B?VTBVKzE1YmVpTUQwaWFwb2lJN04wZUZQMVpJeWc0Zjk0SzlLRVRNVmNYWDBl?=
 =?utf-8?B?dHVONVhxZVlZdUV1Z3FqQVVMcy9hZGgxcC9UZ0xRYjMyV28yYTJXeGE4WDV0?=
 =?utf-8?B?UDJIM1Q1RXdOSDBUVDdJM1V6THkzS2Vic2RqcE1FdzZ1NkhtUnZCZ2lUMXZY?=
 =?utf-8?B?VE9wLzhrejJJZThkdmhTNWF2TW1hem04b2dmQityMTB5aWU4ci9yUmR0SWFs?=
 =?utf-8?B?KzdZZDByWVE1MnllQXpsTlU4MjJBT0N2dGkrNUQ2cHRIM0ZCRU1PcTV2OU9k?=
 =?utf-8?B?dGJSa3l5WnBnN2VjYUplNlpNZDNXbFVjWFg3Tk9ZTWN4bzJRTm9iNVFHc0VC?=
 =?utf-8?B?eW85TW9LcU4xRUl0akthVGtZaCtkeFFEMk5aaEw0QTVObkduMjVOMDhiZWVp?=
 =?utf-8?B?alM1dm5NL0owc013UXBGdmlFRGpvOG8xdFpZS3VrU0p3bUV3R3dTekVMcWRT?=
 =?utf-8?B?VDFkVDV5MW1Ya1Uzb2xFcWFLL2Ixd2lDL1BJMU84cFQrZXNaQ2Z2b0JzNWJp?=
 =?utf-8?Q?24H54L0C3M+hGY5DiBRaJBJH9uwcOU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0pzZEZEMTRWQlZONXR6MmhENHVOSDVKV0NxV01jOUI1alp6TVdKS3BKdjBv?=
 =?utf-8?B?eUx2Z2ZrcXozU0hmbzFwdGNVcWwwQzhyVnFYSmppdzVrRGZ2SDJUVDd3Y3lm?=
 =?utf-8?B?WnA2NndzVDZsOWlpOUtHVTd3ZnJSWS9QV1A4c2ljKy96YkhvZUltdFlzREJX?=
 =?utf-8?B?MU55NUtIbVhtdXl0dWR4bmphNk53T3ZqZFZ1UkxYZ2xuRlp2NGVBWkdYVFJs?=
 =?utf-8?B?MDVSeG5mNXJHZWNtcmJTd0FieVJ1MDBod3JyYnJza3VhRCtzV3k2TDVTWDRh?=
 =?utf-8?B?ZDM1R0xpbzkyUkkzcEpWWFpvTnVUNkFra3BSUXMrbXN5Vjg4ZFlPelF4N3Fu?=
 =?utf-8?B?TWJaa3YzditCaWRVZjRRTEtsUDF3K25jU1NPNE5UaGMvcnJXYzR4bzdDVlhE?=
 =?utf-8?B?eWkxQ3lFNUd0RHRPNWxlVjhCOUdyM0N1ZUNNWW1oY2kzakt1Z1dHYlVTS3c0?=
 =?utf-8?B?K1B4UVZydmZkQk40dE11Mm5HODhNOG14cC9MNWJNMlRkbldhaGNTQnM1OTc3?=
 =?utf-8?B?RnJlY0U2azRNODlCbkx3MUk2V0JmR2JuSktjcEJIcnlQNWRVbkdtMlJEUW1S?=
 =?utf-8?B?c25BNGI4OVh5VnlsVWdOQStUYTdRMEpGZDJrZytpUVg3MmJMTno3dzJpWU5R?=
 =?utf-8?B?UzBFcVhJM3pmQmlPMENzTGk2aHlOUHJNTi9taGFNdFZiT2tHbjlZbEROMXJz?=
 =?utf-8?B?R3RXQ2FYSGRJQUwwTWk5d1djMGw3cEVTdUQydWZ4NVVadkdnbzRUSmFzTHlZ?=
 =?utf-8?B?YVZmSFNPdHJwMUJKQ244dGNDTGdZcFJZZWpLeldrRXhGdDRiZ1kzN1dZVlRr?=
 =?utf-8?B?bmZUelh4MmFsMjlzMC9LVjlxL0NoeG1mQjQ0Z2NFRlFCbjFrTlBIam95ZlFR?=
 =?utf-8?B?b2IvRGVSSXN4ZGorSWY1S2tlNHkvTzJvTXF6U09Fc1N4VVVOeTNGZWFyeUYy?=
 =?utf-8?B?QnNXYXBwL3pUaUZlWlZOZlZaWXV3T3BxdlR2aE9KMWlOTnoyZ3lSdmxTWkhy?=
 =?utf-8?B?TnN2K05uUGZDUEw0V1FmNHVFam5qWWJwVklqbnIwdW04a0JjOGxYb3IybkQ2?=
 =?utf-8?B?YU1iUnJQcFZaZmNSTkhKMVNmYkw5NERDSzNudHVmTDFvbWR0RjlSMDVjZ01C?=
 =?utf-8?B?TVQxY1pkZEFCS2I0QjZPSWNhSHpLd1BTRDVvZHFhWlJpMWEvSHNVc3JnQVB5?=
 =?utf-8?B?N2dPbEpueG1ic3ZocVBxaC9SZUUzd1BWckpCWURmejJNaEtrQ2FMYmJEVUkz?=
 =?utf-8?B?V0RseTlmRUxJT0hyS2lXc2NIWUQ2Tmh5dXZBS2dHcXFQV21uYWsvQXdRR3I1?=
 =?utf-8?B?UHZia1ZTTnl3Z1NGZGJnSjBPWUJoMHpGZ2cvRkNMdUtsTjVUNHhhNkFpUDUw?=
 =?utf-8?B?UzdKY0dBbjV0MzJIMzVsVWxPTlBZQnh5dFpaOGVLaDcrQW11ZDhIanJZaVF4?=
 =?utf-8?B?b1FUYUtjbThZUEpnTmtPS0RHUzcwV1pMN3M1WndIUzBkWldDbDJCeGhqNzJ0?=
 =?utf-8?B?aWMrZi9XVi9UWkpLS0tyS3dmRFFBZWo2TU1Ma081eWxKbmNFVFVQUlJCMGxj?=
 =?utf-8?B?a001WVV5VXAzOVNDbXc1WXBHYWJXQmIvYm50NlJKRE1Zb0ZrcExlcFJlOWxq?=
 =?utf-8?B?dVcvS0ZpTTlyalhjN21WOGlGSUVmOW5naWN1K09kMnpqVkdwcTQ0djlxQzdx?=
 =?utf-8?B?cU5FS0xyNmNUTXFvcGxSNWljMHd3UnZxUnp0U3lBWVdXalNIVVcxY21ZMGkx?=
 =?utf-8?B?NVU2RFJrVlJyQWs0U215MXRLYUFsc0poTEkzTmt5ejRVd2FnYVlwRThmbzFr?=
 =?utf-8?B?cG1iZSt4OW96ZHFwM1M3RVZ2Kzg2SlJiNDZZeVJpckUvSjgwSlFlU1JQb014?=
 =?utf-8?B?SjhMNnhCdlVsaFZGZUNCbWo4R3IwWXVFOG5wd0d4Z0lpOGJPNFo3WnR1aWJE?=
 =?utf-8?B?a2c5aTduaVB4ckFxRmQ2N0U4bXc0bUF4czlTQjhJUjJVcFBFc09WdnpTeHQr?=
 =?utf-8?B?VGZaeHI2NzF4QnU4RjhDZ05IWVNkTUhXMTRndm5vMkVlNU9uSVRKNkZDY0hE?=
 =?utf-8?B?UUtDM1VsM1hLWVBuM2Y3VXZrb0lFOEVyNXdRSlp4UE91b3hsVWNjQklxSVd6?=
 =?utf-8?B?WWhXTThWSTZOR0hxS2FnRU1RMTZoL2xkQ0g1WXZVL2ZnS0IwVUd5U1RPVlJW?=
 =?utf-8?B?alRJVndOZDc3ZFZMc1ZPZFBxTitRcWgxOUozSlZwRDhOUGIxZXNRN1JiaWI5?=
 =?utf-8?B?SFhyS2EzbzlTYlN4WjNjMHpMY0FRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d45114c-3411-49c3-5d30-08ddfc274730
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:58.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3FBqMb73kbDzJwvZlsMejoxCr6Qu9ax1ypv1Wn5RhBik4fotXd9M6HSmUHAL7B5s9OND+9mVaPoC1alvQZCnd8+crd3uHVQpcLTVYHMbzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-GUID: 94qWw8i1N11kgl90ofgkhNlgAd2DB1sC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX9SAXceKU7/DA
 N4nUKtSi2s2J7b0mAjTb81ejsu9GnmnaQzxgDN+djark2gJbWIaVx0y9LA7L+i06UlzPbwBa3lo
 yslbRMcf9WYpPU2uNmH9AemXen7IkmjgCQmc0gHVrD2e1LNTNTA9TqsWzcuKULQDpIeI3EKemw6
 4jnNFNpNMel6eUNcA/ObUYqm+OYqP1IZfJ+lAV+wtPeCHPW/imYCeeLFK394C5WkGRX2OvjkBWo
 NU6YCzExKOg3N8qJH8qqFWyMix1ORQsx3rUQXUQB+IzAPugXT2f9NlOqIAdmdNVRygTMfEs3m4W
 0a02qUv2YNX2uw2IJ/Ty4gN8vARorHnQdoiWc/xraj/m0coptRIfwvVMVsTi68=
X-Proofpoint-ORIG-GUID: 94qWw8i1N11kgl90ofgkhNlgAd2DB1sC
X-Authority-Analysis: v=2.4 cv=D6FHKuRj c=1 sm=1 tr=0 ts=68d5286d cx=c_pps
 a=TDYc4WexHdh/ivIjU2umhQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=kqlIrpWXdM3z53z3dXEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This brings the QOM type name in line with the underlying VFIOPCIDevice structure.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h            |  2 +-
 hw/vfio/types.h          |  4 ++--
 hw/s390x/s390-pci-vfio.c | 14 +++++++-------
 hw/vfio-user/pci.c       | 13 +++++++------
 hw/vfio/device.c         |  2 +-
 hw/vfio/pci.c            | 28 ++++++++++++++--------------
 6 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index e0aef82a89..0f78cf9cdb 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -120,7 +120,7 @@ typedef struct VFIOMSIXInfo {
     MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_DEVICE)
 
 struct VFIOPCIDevice {
     PCIDevice parent_obj;
diff --git a/hw/vfio/types.h b/hw/vfio/types.h
index c19334ff25..5482d90808 100644
--- a/hw/vfio/types.h
+++ b/hw/vfio/types.h
@@ -9,11 +9,11 @@
 #define HW_VFIO_VFIO_TYPES_H
 
 /*
- * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * TYPE_VFIO_PCI_DEVICE is an abstract type used to share code
  * between VFIO implementations that use a kernel driver
  * with those that use user sockets.
  */
-#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+#define TYPE_VFIO_PCI_DEVICE "vfio-pci-device"
 
 #define TYPE_VFIO_PCI "vfio-pci"
 /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7760780aff..9e31029d7a 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -62,7 +62,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 {
     S390PCIDMACount *cnt;
     uint32_t avail;
-    VFIOPCIDevice *vpdev = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
     int id;
 
     assert(vpdev);
@@ -108,7 +108,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
     uint64_t vfio_size;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
@@ -162,7 +162,7 @@ static bool get_host_fh(S390PCIBusDevice *pbdev, struct vfio_device_info *info,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
 
@@ -185,7 +185,7 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
     struct vfio_device_info_cap_zpci_group *cap;
     S390pciState *s = s390_get_phb();
     ClpRspQueryPciGrp *resgrp;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
     uint8_t start_gid = pbdev->zpci_fn.pfgid;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
@@ -264,7 +264,7 @@ static void s390_pci_read_util(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_util *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
 
@@ -291,7 +291,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_pfip *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
 
@@ -314,7 +314,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 
 static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
 {
-    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     return vfio_get_device_info(vfio_pci->vbasedev.fd);
 }
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e2c309784f..efceae69de 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -234,9 +234,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     const char *sock_name;
+
     AddressSpace *as;
     SocketAddress addr;
     VFIOUserProxy *proxy;
@@ -346,7 +347,7 @@ error:
 static void vfio_user_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -371,7 +372,7 @@ static void vfio_user_instance_init(Object *obj)
 
 static void vfio_user_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     if (vdev->msix != NULL) {
@@ -387,7 +388,7 @@ static void vfio_user_instance_finalize(Object *obj)
 
 static void vfio_user_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_pre_reset(vdev);
@@ -421,7 +422,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
     bool success;
 
-    if (VFIO_PCI_BASE(udev)->vbasedev.proxy) {
+    if (VFIO_PCI_DEVICE(udev)->vbasedev.proxy) {
         error_setg(errp, "Proxy is connected");
         return;
     }
@@ -464,7 +465,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_user_pci_dev_info = {
     .name = TYPE_VFIO_USER_PCI,
-    .parent = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
     .class_init = vfio_user_pci_dev_class_init,
     .instance_init = vfio_user_instance_init,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 963cefc053..64f8750389 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -423,7 +423,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI_BASE(obj)->vbasedev;
+        return &VFIO_PCI_DEVICE(obj)->vbasedev;
     } else {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 479def72c5..aa9d3e0354 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -305,7 +305,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -660,7 +660,7 @@ void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -755,7 +755,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1346,7 +1346,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1392,7 +1392,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
@@ -1426,7 +1426,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
     int ret;
@@ -3392,7 +3392,7 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
     char uuid[UUID_STR_LEN];
@@ -3552,14 +3552,14 @@ error:
 
 static void vfio_pci_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
 
     vfio_pci_put_device(vdev);
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3583,7 +3583,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
 
     /* Do not reset the device during qemu_system_reset prior to cpr load */
     if (cpr_is_incoming()) {
@@ -3628,7 +3628,7 @@ post_reset:
 static void vfio_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3669,7 +3669,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo vfio_pci_base_dev_info = {
-    .name = TYPE_VFIO_PCI_BASE,
+    .name = TYPE_VFIO_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
@@ -3758,7 +3758,7 @@ static const Property vfio_pci_dev_properties[] = {
 #ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
 #endif
@@ -3914,7 +3914,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_pci_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_VFIO_PCI_DEVICE,
     .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
-- 
2.43.0


