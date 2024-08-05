Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF384C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 19:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb32j-00041a-5a; Mon, 05 Aug 2024 15:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sb32h-00040u-8J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 15:06:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sb32e-0006VK-RW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 15:06:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475GtWZB003473;
 Mon, 5 Aug 2024 19:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=G3XCJWO+ehSqdVkeVHLykRboipJButU6MgNM6Vtr+2o=; b=
 NCGeOQjmc0/aG8n8p0A0bxamoEQkBe3Q9nJDi9z+A0ZvH4tNXAqO5DYKbqWUFJNv
 QPU8wjGXViT4vvhS/bD0tSUfYNNPbomsVAY5QME3FiipqLDREZ5nOUKZymD2kIGe
 cIFWACC2X5SBah1sAzc2P5mnXxjWsbgZ3J6xb/GgKQu69GTew0skmzY88LifipaY
 Al1yKopCGw5XQpssWpZ7rOaBzTYF/q6ZC8dmd716olzzfCoISnfz+sovYwkM/lQ7
 xTPdNjlPm1HWnf7vnNXDvRopRzrmAPklca9lRFSzjfcJlKRUB/x5Nt7B0nfDkiJC
 KLxOO/3Yi9pdhmwgrJYynw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce93d2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Aug 2024 19:06:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 475J091G004634; Mon, 5 Aug 2024 19:06:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40sb0dq2x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Aug 2024 19:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljZ+8/wi2W4fmecD0KPh/iExmAUiixK/Y4a4XXceka9+OhfIQGctAcOvAPd2aH800EZjcpBZJNQPr0yZ9v6rBjm7ZQj8FosuB5DnBJU40A5Y6WaNqkU6KXWa43gziWQ3cfHc3EUrh5A23+jGq7NvWDo6iP2NNT0/AcTCYNAzM9XyCN4vN7e6w6sCYaJz1ZPBwgLbBEtrmKkupVZtzjPSveHjCyZGPb58qJgZ0su1SKrCgGt4bTPTBYWK4J2H6wa948SwGEa58/W+rtQ2Zk4cRdx2cXfJgQ9HhR3mDs5qGcuwtcsmZ8fN9nujBuVVdvkzBg9FOAuOfSfyyY0ln7VlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3XCJWO+ehSqdVkeVHLykRboipJButU6MgNM6Vtr+2o=;
 b=is/2COohu/cw8iU4HLV5MzQPjg0Nzo2oeHUpo1XxFt82cD54ShI2GG3QFmTuyG8xlvW6ExQ+jXQhDDKFsJB4Ca1o7yced7AAmpOCG48WiC5Eg/criN0QI/vESKE93xz4rvTDbpHc8FRXZ7VvomJaxno60S5fpXq7EhokWxFfGRqJah2dHUZ6ZjvYCOmFY5UF44QDO5WsLVtYprFJd7qiSafvZRXLtnh3GtGnVHjspwkJIFJQjP3DGuTz9H3oqNloPJuupREXwKjC6dvMeGk3pe74htPc5s5qetoWk9rq7qRRQnX05nRQOaCKqvSZ9DQbct6gyQm1duS+8cpOxX11iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3XCJWO+ehSqdVkeVHLykRboipJButU6MgNM6Vtr+2o=;
 b=mcAjyE+TNEhKOQbEEJHMngRYpEAzAd+qiZGrc6Wp9n/VWBLYGNYZX8wQ4/XWERI9ETXm8l5xdh4MoOwjJOf1R3AsbjSRgtyjGYE9Z3HKNd7xEcTYS/SgrtBwWGnqk+nx6VAvXblPLGqBhJ5Om7Qoxw3ycF0PpLQOxL1rASpG19A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6732.namprd10.prod.outlook.com (2603:10b6:930:97::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 19:06:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 19:06:38 +0000
Message-ID: <ab6a71f8-3bd6-4bc5-b597-8a2f4835ee0c@oracle.com>
Date: Mon, 5 Aug 2024 15:06:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 1/6] migration: SCM_RIGHTS for QEMUFile
To: Euan Turner <euan.turner@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-2-git-send-email-steven.sistare@oracle.com>
 <bdd13555-29ec-4d72-8abd-b6b634033df6@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <bdd13555-29ec-4d72-8abd-b6b634033df6@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:208:2be::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 28522bc8-9724-4648-7319-08dcb581bbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnA4MlhtOGhTL2RuOXozRlR1QnE5U3FtUGNBMnQrbGZVakhyOGN4VE1hWDlp?=
 =?utf-8?B?TURWRlMrSnRtTGg2Yy9RZ1QvK2lncnU3UjBSUmVqeTRXTFZPVUl4QldLWGJW?=
 =?utf-8?B?azlNVk9oL2ZxcVpqdjdiUy9BV2wxdk95TmRuNGVVN0xuWngrS2F2bWpMY3Fw?=
 =?utf-8?B?K3lsQkZvS2pvZ2w0Y2p6RkJTQVExc0tGWCtJSEtQQkhxWUJBSytMU3NoSWxF?=
 =?utf-8?B?dlFxZDEwanFaUmRaTEFHd2ZFTzBIcWRYTm91ZXZMcVlaaE5vMW4ybUdhSHZi?=
 =?utf-8?B?VXJ2OVFDb3JOODYvanhUS1ZrVmtCNGRxMDF3eWROQUJEanRtYjh5T1pnLzR5?=
 =?utf-8?B?cVlsOTNwbGczaEkwT1dwQnNqM1cvNndJSGNWRVpvakZjSlNCdXMya21SbXBa?=
 =?utf-8?B?MksrdHV4NVlsbDg1MWpCRnFpb1FtbzBFNThqRWI3OVU0V1hUeVNVQzVoSlpT?=
 =?utf-8?B?MUkyamdHeWNNRkVJcWVMcHJlMW9NYzZwNkh0clRNck0zSGRNVmJmT0IzWGUr?=
 =?utf-8?B?VEYxNGdqQ1dpai9FdmNNYXZDSWJpQ0Zvclo0UVJMM2JadzdzZ1R3UEtqS3FO?=
 =?utf-8?B?ZVlYbWpUblQ5My9lNEV1TldiOERNSmNMWldXaHN2am53bXA4N2lFMmtJS2Jk?=
 =?utf-8?B?VUoyVlRGK1NnTWVwZzAwMTJZRjdzRkwrVWhkcjNtakQ1eHVoZ2h4Qll4VXhB?=
 =?utf-8?B?RjNsc28ydThJNS82YjVxenMvc0k3c3FIUXBWTXViS1ZiUDh0Y2VBNEE4WFZw?=
 =?utf-8?B?ZTlYZ05rdTRHQTB5R0RjQVJIRWxWKzIyck14U3FPTXRmcnV4bzE5aDBjNmIw?=
 =?utf-8?B?VS9yN1U2c0VDbWM2blhjUnhHNW1iZVg3c3pWNEE1Tlc5THhocnBFd3dxT0oz?=
 =?utf-8?B?eDZnN1Y0WXNYMHlkbnpVUU5HODkrQS9pWUlQUHlNSXE4R0pQYTh4T1FFakpN?=
 =?utf-8?B?Ti9IOUE0bEd5RkJtQ2tsTExtSTVIZXJmS3NGUHVJU3hPV2dnMmJObjJiSXhi?=
 =?utf-8?B?RE4zV3FrcytEM2pIL3UraitxTEFVbzh1L2lJVlk2KzFtTXROdm92Z3ZXc2Ix?=
 =?utf-8?B?eXJkdG5mWHVmNzNmOTBlRUgyV0lNZjZqMGw0RVhaZGNlNGJwQlUyYUpUUWFK?=
 =?utf-8?B?OWd6dEUvWFptUEhLekU1NGVhYjcrVHNsUDY3Zm8zZ2VxeURjSk1pMlhjcnI4?=
 =?utf-8?B?TFh1MU5aUFpDQStweVA1blZyQ3FXYVM0VGR2bHZLVWNGZlpkdEM4RlZveDMv?=
 =?utf-8?B?MFFVdnJuNW5GdENZdnc4T2R4QTVMcHMyRmJyalZBcEk5a2pwU2FzTGRtMjRy?=
 =?utf-8?B?MVo4VWRFa0tFWTVGWk1zSWRIcjUvV1VyekJSSUYrYVFFQnIvQVRHa01QVWRi?=
 =?utf-8?B?b043SHljMnlxRjZ6TVRCQndoUTVjWEdJd0svVnhYV2lkaVlqb29pUFoyK09Q?=
 =?utf-8?B?WG1sM3lzRTl3c2F3NS9kam54RW5JM2pPYzZldStXd3lpS095b3MySkhUTXRU?=
 =?utf-8?B?N0k5OUtnaXVLVjZnd3lORUxweHZTOWxocVBoeGh3aHFMdDRzd1hPQVdOVi9t?=
 =?utf-8?B?cEFHY2pFcXVNNkhrVUd3UmMwTzNLMlRidTg1M2cyY1h3NEp6cDcwendiblRy?=
 =?utf-8?B?YlVRRm1wa3RjOEFDUkt5M0VCZm1PZC9HcXE2ejhPcG5QYlphbU56eE9VUWs3?=
 =?utf-8?B?Q2RVQXJIdHMyQ3hBWkVvZVV5aTVqNk83REZDUW5iWUtyU3ZuUmhKeWpZenEz?=
 =?utf-8?B?QVJXZUtHNFR2RHd3b3ZJZlhLbTNGVWRpUEs3T0kxU0VIQkJuTERCM0ZKd3Ix?=
 =?utf-8?B?c2V3bGdoaFZMbzlsMFRWUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lTdmZBUGJ6bFhHTGUyc0pMVjBveDFBdkpZODRQOXBsV0VTVUFtc3JlYytL?=
 =?utf-8?B?dnlDWm81QmthOHkyVkJGTTJha1UxNHZTeVBJcm10SC9jQ3NNVmpGUTFTWmFs?=
 =?utf-8?B?ZWtTS21RR0hDVld4bjVGRVU0UmJzeVA5MExZRHJKMGZwb0dNQkl6TEtiNEVX?=
 =?utf-8?B?QzBtQVUzNFJ2TWUrYUVSUjlRY3dMWU5OOWJadVV5Qk9PTXZRUlhsV3A2RWE4?=
 =?utf-8?B?VCt2MWR2dXI2YTVzWkJERVluQzQybDRRdGI1dVhyK3BNdVpoOUxmR0VSYTJm?=
 =?utf-8?B?RythV1VFeDduckMwWVpKbDd2M1R5WWN6MUNpUVVYMVNpcnBmTHB0clZIWDAx?=
 =?utf-8?B?eXQwUGx5amQ4S0oxc0dMRTJoUU1SYVNleC8ydElUV1hWRGYycGpoNk9La1lD?=
 =?utf-8?B?QmxiRHY2SVB2NU0wNFUzdUJkOWZYUkxQb1JHQUlTTFg2c3hSYWxvOW5PWmQ2?=
 =?utf-8?B?ZVF6RVJLc3lUVUdUVmo5cTBNKytPSm83WjM2WnlaNzJhWXR0UVZtdGhvNmto?=
 =?utf-8?B?SXYwaDJsZ2dNOXhTM2FEbGs1MjByWGhCWEJGSzZIT25pZi9xNWx5emNHeWZN?=
 =?utf-8?B?eXNKL0d5V3E3dEU4bW94UEg1dnQwcmFHQld1d1JvR3V5MXdqOVhLaFY5R2p6?=
 =?utf-8?B?V010Wlc3bEU2aFdYa1hTRXNzeURtcXNwT0hXVzFBR01mWk1IY0JueXdYSDZ2?=
 =?utf-8?B?d3NncTJUY0FrT0VCa0hmR1hoQkFMMUs4MWtYeTBmMHdTcUNodkcwMCtubmFE?=
 =?utf-8?B?Z09tc1NrVG1zcUIzbU56OXo0dmxTdEoyVGxRUXNZUDJySXZObW5uaDdTb0Ez?=
 =?utf-8?B?aHhVSHdlTmJEd3ZpQ0EzZXRVRXhlQktHcmhCaStVcW9rczlhcEU2T2k0dm44?=
 =?utf-8?B?UFFwSXNvcDBheXY0SmkwejZwamk3QVBibXZzck5BSFQ2RFBKU242dWZEZTZ5?=
 =?utf-8?B?M2lxQ1lKZGN5ZTN6cHpjV2hSQ3FyMVJZT0hiNFR6NjZrVktlYzA1MDVEYk1S?=
 =?utf-8?B?ZjRBSG1WTG9nUUJ1VjQ2aHl5b2hKTFFocmhTeTF3MUhyTDI5NUlncmk0R1gy?=
 =?utf-8?B?cmt0UGl4bHlMay9IVklDZkhJbDZHdGJmQXZpNER5RmZsTHlsMVdub1RVaWRl?=
 =?utf-8?B?U0tDM3NwNk9CdmVibVFHN21YaWZ4RGpwOHM1bzc4UTY0MmQ2Kzh0N21sajJj?=
 =?utf-8?B?cUdTQkdCaGQxam1XQ1ZVQk05MU1KblRnSW5aNmJjS1Brb3JzTzFUWm55NGM2?=
 =?utf-8?B?RFZuRGtoQzBFUWVBR3FhMHRYcFowWW5QNE81YlU5d0hsL0JFaWlxZ1ZONUNj?=
 =?utf-8?B?ei9iazFSMUMzY1p6VHEvSjRMZGxKbkt2K2xQMnVzTDNaM3V0VlNsVm05NHB3?=
 =?utf-8?B?N3EzM3Q4eTFWZG13Q2phNk8wa2pmdTB0OVNMNnFIMTdkYXAxeS9PdjB5R1FK?=
 =?utf-8?B?bmhxbG1QTUJKMjdkVG5mMlhZcmV6TlVGK09yVGFGSExYZlhvRUNxcVJvbUUr?=
 =?utf-8?B?U1BOR3dMeGlWdEo1T2pKZmtubS9DZW4xSUp0SXhFaGxzRzJ1WDJIeUM1Qjln?=
 =?utf-8?B?OEhSdGs1M3Z3Rm1tRU1oM21sblVQaElvU3VhWS9rNzRzdW9RT3k3SnJWTmtF?=
 =?utf-8?B?cGkxMmQwN3B0VmZaTjdkbFQrTEpjT1c0eGNLMnVxSjZYVVZ3Nk9jUytVZGFT?=
 =?utf-8?B?bUp4L2NQZ2Qvd0NZWVBoS2pUaXBLc1VTSGFQNnkzZG51aFJoTDE3QmtVbjZK?=
 =?utf-8?B?VXZSdGs2Vjh5ZEdTcS9EOFMrRkQvYTB0OUlaOXM2a29MWlNGZFNmbWRxc1Mz?=
 =?utf-8?B?a2JiVXJhS0E0UnBkYXBrL0xuQ3NuSTdDUE5POE5UM3ZubFRwRVJZT3ZpQXAx?=
 =?utf-8?B?ZCtjY1NzSGZmQmlxMWlSTmZJeWdpaDlnY21kYzNSL0U1QmcrYW54VXVlUVBV?=
 =?utf-8?B?d0oyVVlhZDlpamE1cE4wMTF5Z3c4bXRtZTdhVnk1TS9kUG5JamU5UmErOHR0?=
 =?utf-8?B?TjlONjNScCthcytSMmY3bDJDT0dINDk2d2VXK1BERWFTOEpLajVHRTJrV3Zm?=
 =?utf-8?B?cUFRNDhUeTQweGNraVBDWi8zb0tsNkpQbkdkQnVUUGxOSnlxY3VxU08ybU44?=
 =?utf-8?B?ZU9uOUtVL0t5U0ZKSVV0WUsvb1hYU3hZYXk0UVpWL1RTT2JjOENITEd6QkxB?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Oc1ikddehoHD+8P5HrZGed+FhhuRS4oRtsgMpkewNi9yvlCKUwXeaxQfXuJkKicic/QsWzpzSDFele4KQUAHiP9pHiZylUUdtxyfXJ/ctni5JCAXTQSudJIerPei0bKeynzo6Y7tY9OmoV2AeiLPxHIq6l0+K8Q1KFWZOOTLoxRAsLnfMf7DGnvnzuenYCUA1mQaJEptLvO1x4yVsL7Dnlr7nleo+cj6yg7Y6XxP6/dqnCFd5tpa+57YPPYAl8I/TCtrY6dIZQihJaD9neoOA72q5tnG26UDpTJo40wwTwbmHNNQM3GZmCZU6KrqzugU6Asz8NnHI8qFHxHcxXFB6f7Y55/9Ou3eMjmjVw3gKc+FAf3dfx5X9396Ywhha7j9rU34B/PWEqSNAuiIgba3kBxgYh8aZDjblf+YriILYcitDL90LVdjwHPGfWoWMK65TIgSSQKmSYOh5h7bdntu6LIhlQfyxOKCKZ3au1cXEmhX1vYX2Q7JA0csd+COjszbsjFP33c0/KaX+nNRmRl7RkHE1SHetWWQ/U271UibffaOEfF5qzXVoSFc38Hdn0Nk0q0xQngzHl7cWMjYQjtklF12oRfHZ1Qhhf4lejS6N5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28522bc8-9724-4648-7319-08dcb581bbb3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 19:06:38.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxbnwIuR6QPcUGPLahPZE+xmJ7IDGHFB+POULGjdCM2H/vBViy0gHlLFSGr5EhJJfPi1FLk0cyQwwLPUVAw4Ye7woaF91Dr+NvQH1jf1BoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_07,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050137
X-Proofpoint-GUID: 9oCuV8gfDB2bwwIEgpcFJkasER5voYJb
X-Proofpoint-ORIG-GUID: 9oCuV8gfDB2bwwIEgpcFJkasER5voYJb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/2/2024 4:20 AM, Euan Turner wrote:
> On 30/06/2024 20:44, Steve Sistare wrote:
>> Define functions to put/get file descriptors to/from a QEMUFile, for qio
>> channels that support SCM_RIGHTS.  Maintain ordering such that
>>    put(A), put(fd), put(B)
>> followed by
>>    get(A), get(fd), get(B)
>> always succeeds.  Other get orderings may succeed but are not guaranteed.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
>>   migration/qemu-file.h  |  2 ++
>>   migration/trace-events |  2 ++
>>   3 files changed, 83 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index b6d2f58..424c27d 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -37,6 +37,11 @@
>>   #define IO_BUF_SIZE 32768
>>   #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>> +typedef struct FdEntry {
>> +    QTAILQ_ENTRY(FdEntry) entry;
>> +    int fd;
>> +} FdEntry;
>> +
>>   struct QEMUFile {
>>       QIOChannel *ioc;
>>       bool is_writable;
>> @@ -51,6 +56,9 @@ struct QEMUFile {
>>       int last_error;
>>       Error *last_error_obj;
>> +
>> +    bool fd_pass;
>> +    QTAILQ_HEAD(, FdEntry) fds;
>>   };
>>   /*
>> @@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
>>       object_ref(ioc);
>>       f->ioc = ioc;
>>       f->is_writable = is_writable;
>> +    f->fd_pass = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
>> +    QTAILQ_INIT(&f->fds);
>>       return f;
>>   }
>> @@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>>       int len;
>>       int pending;
>>       Error *local_error = NULL;
>> +    g_autofree int *fds = NULL;
>> +    size_t nfd = 0;
>> +    int **pfds = f->fd_pass ? &fds : NULL;
>> +    size_t *pnfd = f->fd_pass ? &nfd : NULL;
>>       assert(!qemu_file_is_writable(f));
>> @@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>>       }
>>       do {
>> -        len = qio_channel_read(f->ioc,
>> -                               (char *)f->buf + pending,
>> -                               IO_BUF_SIZE - pending,
>> -                               &local_error);
>> +        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
>> +        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
>> +                                     &local_error);
>>           if (len == QIO_CHANNEL_ERR_BLOCK) {
>>               if (qemu_in_coroutine()) {
>>                   qio_channel_yield(f->ioc, G_IO_IN);
>> @@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>>           qemu_file_set_error_obj(f, len, local_error);
>>       }
>> +    for (int i = 0; i < nfd; i++) {
>> +        FdEntry *fde = g_new0(FdEntry, 1);
>> +        fde->fd = fds[i];
>> +        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
>> +    }
>> +
>>       return len;
>>   }
>> +int qemu_file_put_fd(QEMUFile *f, int fd)
>> +{
>> +    int ret = 0;
>> +    QIOChannel *ioc = qemu_file_get_ioc(f);
>> +    Error *err = NULL;
>> +    struct iovec iov = { (void *)" ", 1 };
>> +
>> +    /*
>> +     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
>> +     * fail with a len=0 error.  Flush first to maintain ordering wrt other
>> +     * data.
>> +     */
>> +
>> +    qemu_fflush(f);
>> +    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
>> +        error_report_err(error_copy(err));
>> +        qemu_file_set_error_obj(f, -EIO, err);
>> +        ret = -1;
>> +    }
>> +    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
>> +    return 0;
> I think you intended return ret?

Yes, thanks - steve

