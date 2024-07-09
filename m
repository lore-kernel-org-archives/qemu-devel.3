Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269BDC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRE6Q-0000c2-6A; Tue, 09 Jul 2024 12:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRE6N-0000aA-ON
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:54:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRE6L-00066e-Hj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:54:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FtUwd003188;
 Tue, 9 Jul 2024 16:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=YxMTq3+8/aOXZScwyvqULqHFxWexEIe8bfSvblkiFBw=; b=
 OTIW9ex64QirfmqjaChCToXGLwNQyqEPqIib57wXzxOmXH/31iozT5QKgj04hmPM
 vXeyAaxvoIUozC0DqV5h2LLTb5ZCgT7F73+Jh6ATUXPchQ2h/lJddAiGs4ivCys4
 2QEv6YaFZxmUW1/QLXQpOFsXHcdjQXpIAAWg8OTcVP+5kh+YuJwZCI4xFLAMO2eC
 ZeLtQFWlXeYR/8Uld974GXTT/V6td+RdDv7JphH4+DhOk5JWumWAMl0aLRtnwqkO
 tlh6hNt8N0JTLAKQ0gVlPV6dAYrWTGhyexDkqxJgF2UALhdPRvNPTG0jFUXT+XGe
 u5fq/Bgurqd0LwMqIkJMow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknnft3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 16:53:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469G5eIb007191; Tue, 9 Jul 2024 16:53:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu3h30v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 16:53:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsliUBURMf069WvIWlNnWNOq13HV5f1jSVuGRktcQb87DRQUi68M5liRZfcBc4BJfsSRbPhilhiouhxctcSQeU1dDLHhHb15dxUhoxgKLzGZ2w52xUMEsfHxPh6TYRdwf0USYe/iSXyGsZX9RMFJ+uOuO5KZ0q+lHsqngGzsf6b2YrrXk4ShFycrU5yyOYOaSjJuCOdlRJnrZIXMhWVBc4/SajoZuIv42zhkZ4UjgYTLpygTm1DLhTgOmXXdYgrUEvBzu1NTpPDFGuhlkWQkvFN54XkiFbfG0aM2Tr7UBrkjRZcWHFNzUHSeF+P6jBU82Txaq3+QNFlxt9z2sNWaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxMTq3+8/aOXZScwyvqULqHFxWexEIe8bfSvblkiFBw=;
 b=MiH7iIj1VaVoZ3CQCR+DjPPY2Wig3iwuuRYGKxUuVCOKAOGyaSiY+eiLG9Al4tx6df2kg0Ff0FLJLoZcQ6lQCYwoRsQS7EbHw69Lmb9SColDfEKe7accyGuGoHM/7Y5YIfsYgQsfqEwww9vM1V1macs98VjDH/AQm+PbFeQKjikLEgwA9wr5PZVJGqiqLG7XsL9NDg3Qo2vcf8acglVJpzrpGHQWw/SiVBCxIN/CVp+HCkETjT3+6C/GXlzmlM4ldGIGgrGxnOHeiTAJkS5mLbXLt9VJEEXIqbhFt8JF4Q+Froo6fl7Q+WZITCRniaZSNrguTbbn7Gob7TBvGcPBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxMTq3+8/aOXZScwyvqULqHFxWexEIe8bfSvblkiFBw=;
 b=LWDzwzsjXGGRxByn8WcXGt7jBrPYGLOH10h0vEx8G6GKVSaiZwJl9u6VXO40NbF+aQKqDdzH6DdwYr9rUk7fClaB8fsyWJhax9W8jgDQTUbgssk4Vf80JmV6IWgawUdsb3W4O0uvggEPARWIOQieJF/oJgcfJUDe2zPv84nO/x8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4782.namprd10.prod.outlook.com (2603:10b6:a03:2dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 16:53:52 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 16:53:52 +0000
Message-ID: <4e85db04-fbaa-4a6b-b133-59170c471e24@oracle.com>
Date: Tue, 9 Jul 2024 17:53:44 +0100
Subject: Re: [PATCH v3 05/10] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-6-joao.m.martins@oracle.com>
 <a3f22b3b-e3bc-4dd6-b6fb-cfb726addfbe@redhat.com>
 <ce8515ae-2fd6-417e-9f2c-43bfb8b605c9@oracle.com>
 <71f35047-d456-441e-9276-d8b952b0c609@oracle.com>
Content-Language: en-US
In-Reply-To: <71f35047-d456-441e-9276-d8b952b0c609@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0164.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::33) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: cb045fb9-83d9-4654-b0f2-08dca037b61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVg5cENQTmNFUnJUazdkTnFFbHFxRFlYNG82b1dXQVJrOHUvekt2dEtvMFdm?=
 =?utf-8?B?UTJpWmk4L2h0WlF1b0wrNTN1SkNETTluaVcybTNLbDBzanN5NDhXa0FmU2tu?=
 =?utf-8?B?N1dQc0t4cmhkZlJHWW1SdmdEWkdlN3VQOUNYUEE4b2dJdlVFMnkwK1o5eXov?=
 =?utf-8?B?aXRzRzc2ZDk0Yk84dEVUUHhtV3dVd1JSeHVkQkpQR0xYbU40SWEyUjg2YS9o?=
 =?utf-8?B?TFBGakJrSjgvRGRNczZoWHduTFR1empQUUpYWUxGTEYrZVZCazNTMVdsNVZI?=
 =?utf-8?B?b0xMTmUvQUE5QWdKV1pDZUhtRVY0eFg4TjZSU2FrQi93OVh0WTB4b0pEeXds?=
 =?utf-8?B?cklPV3dIT1NtemFYWmprZnZxVzYrcXlDcDV2b2l2MzNlY1JhUW4vT3dGb2VS?=
 =?utf-8?B?VHVhd2FuMFNVbUh0UXRraHM1akw4MFhBZUMwcWlCdkh0aFhVOXBGVzdiNlZZ?=
 =?utf-8?B?aDQ4RHJHdEJ6Z1JxcFp1NFNQTThLRTVOd3NXUzQ1eEtVUnIwYnhuYkFId0Ru?=
 =?utf-8?B?b0xmNDhET3Erd09NS3o5S291U2JpYkI5eERPK3kvSExVS1VqNFJzakR5dWgz?=
 =?utf-8?B?YlUyYjYrMWgrdE8yemUydVQ1bXdtRDN3WlN5UUJLc3JEREtSdXgvY0gzMEpY?=
 =?utf-8?B?YllpbHV2cTB5MFVvaUpoNnY2enBRc3J1Q25zUVBucnYzV1oyUzBVSzRER0Rv?=
 =?utf-8?B?Si8wVXZoRjVmUW1TejhPZ0dCR1RkSDhNZ0tJZHNHblkxNERURXlzNGQ1N0Zn?=
 =?utf-8?B?c2hVSWQxcVhoZUtoY2F3TVR3TlZpTUQ0cDlIRUViRE5Idi92a3dpZlU0OWtY?=
 =?utf-8?B?a0xOWnBlWktKTSt2OHBYcHp1UWxPRUxweGgvV1BiMlpzeXBwdDM4dWhKUUsv?=
 =?utf-8?B?cnFtRVVpREtWc3RmOWUzTWRJSmlRR3hSbWVkUFJoT2JSVHRCbCt5L0xRRW9a?=
 =?utf-8?B?VXByVElOTGlqQWxMVDFmZmJWZFB4REFFc3NPTWo3cWpRN3AvT0pzNGI1K0Z3?=
 =?utf-8?B?TEVmcVVldXByTldkTFRwaDlZaUZUZ0N3NzlDYVI1Y283eUZFeCswdXQ1TXE4?=
 =?utf-8?B?OU1RWlhVSUlDdm10TVIrbzZLTVA4WTZ6SlBEREVDM3FUdldUVjNMRi9SMGln?=
 =?utf-8?B?SWFlbW5GZ25sSEErOEJEaUQzc0N3cDluenRXU2FrNXFHanFsN0RPT3Z3UE1H?=
 =?utf-8?B?bW82QzFHekp6cDI5aEIrTTZOZzhZUUdCUXE2RDk0QjdjWTQ4QmJ1STV4VXp2?=
 =?utf-8?B?cXFuSlhFVnQ2U1FjNU5vUFltWUtXQXZHdG1OSW5oS2NnVXU3QUw3blRMY1Ar?=
 =?utf-8?B?djBvK0NUcURSUDhuUlFNSHVZNFY2MHg1em5xaEhDcENNWFpOdGFWZjdscU40?=
 =?utf-8?B?bjlLL1o4SUZRTE1iVC9kVjZSQXYvRldvbGlqZ2RveEZnclNxMWZNYTNBYlpK?=
 =?utf-8?B?S2kzYTlSbzl4SmZSMUpmMHlkS3JFMnJjMkdzR0hHa2dIbG0veWJYU1o4VzZ2?=
 =?utf-8?B?RTlqTnduWFNMV0ppellNSWNMckVJUTV5SUZGbk1nSkZzMENINkpnaHpZb2hL?=
 =?utf-8?B?RHV1UlY1a0dta1NiQm1qbnlXbEIzVk1UaklDQmNIR0VMcDJndHdxU1RBS0Vw?=
 =?utf-8?B?RXMzMm5teFo2aWlGR2h5UlYwN0ZpTk9FOHBCMk5sNG9WSlQ1YklsVERBaExo?=
 =?utf-8?B?M21XWFBHblo5VUdoZHFtOFNvNWxMSFk4akJpdEFFZVA2N09IQ281blVEdXJC?=
 =?utf-8?B?UnpucnRoemI3aTBTTnVIeFNKN3pwYk9kLzFmQXB2V1ZybGdzV1dvZDlQTk1j?=
 =?utf-8?B?Mjl1OFp0eHdRUXBjUWthZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGRqVGdibmpaNjA5ZE5sSURuRERuOEZRUi8vay95cjZWQVI4cTZJT1dMS0FB?=
 =?utf-8?B?WVEwcUpwM2laalZ0a21EOEtEQkY1bkFWWmVUVXg0RktUUlRJRURjZlUrckNs?=
 =?utf-8?B?Q1NMRFR3YzUyRjE2Z0VESEE5ei9vWUVCMmxQN1pwVm56WVgwMFdOeUFacFg0?=
 =?utf-8?B?UzY4b3c3U2ZQK0sweTRtVTRFbVBNRmVaTFpzUXZyVDZvYnVJR3Z0andEZnFX?=
 =?utf-8?B?OHVQTjNBTXE3MDN4TnNpV1B5K1RwT0RlS1l2RllQbnhWV1RtUE9xRHYrYW1O?=
 =?utf-8?B?VDFyYXVDdkpGZktEZ2tPMUxQZWU5dTNEMEtzd3BySnN3ZTQ4YUh0NkNIN1NO?=
 =?utf-8?B?TXRCUUppYlR5ZGtVNk5HUUE1QS91N2J6TE4zVzhldnNnSjQycUdWTW1CUTNT?=
 =?utf-8?B?aDZmeWJEa1RydThmUnQxL21Va2gyUEpndUlDSi9qYzRYV2MwcnE2dUxISGxK?=
 =?utf-8?B?R0hDL0VmT3hGWEEzRC9veGkyb0RsMXdZajlNSnZOUHZjUDhCSndNcU9KZk9L?=
 =?utf-8?B?MFF2eGs0dnBCWlJkY09tYWdTUTMzM01XbjlWSTllMVptWTAyMEFGZUphN3BI?=
 =?utf-8?B?SW4vblFDTDlya2FzZ3EzZE56NERkdE5id0ttZ3MxUVRTeldrTXp0NmRyYW5N?=
 =?utf-8?B?NHJTeE5Rc0RHaHJJcjhtb29pSVRtQmVNLzRSYmZmSEtmRDVHS29ZNHF1T2hX?=
 =?utf-8?B?alBkbVpYVjdKdzd1YjNYblg3bzRpeVFuSG80bWY1cUpTaVlZTnVYRFJ4ZC9U?=
 =?utf-8?B?cnowRHNGTkc3dXlPTW9HcHQzQWlEaC9BZGw4Yy9qMDRpWVJsdHpFZUM3RDFj?=
 =?utf-8?B?SE9yTzBhb0VUajhxMmwyVndvWE40M01qTHBDNjgwVGFnWTRDcG9ESFFVd3hM?=
 =?utf-8?B?L3lIZDUxcFUweFBZRTBIdzR1RUJNOXllQkIvYW0zQkRBd0ZwYkFqNXZYVEND?=
 =?utf-8?B?em02ZUZkbkJhSEpCZzhhK1FibE1HdHVON2JrbG5WYU9HZGpld2lKczM5RDBN?=
 =?utf-8?B?ZlJoOWNhTTJMcW92Ryt6UEh0QkljRFZET1ZkVFpaVWNDZnBjK1NqTmJYYmtU?=
 =?utf-8?B?dGZkTEtQaXloVnRibG9hMGlIWmRUSXBBVDBqQzBUQmFNNzBobkJoUGs4RlZY?=
 =?utf-8?B?cEw5MFlFaGd6TXVOdkJRblJ4SGtRM1B2NGFhd09tclUvM0VZUU5MMlprdkQ1?=
 =?utf-8?B?a0ppNWlMRkZRM1MzSnNVVHZJMGhJRzVRTnUvelZXMkc0S3lGSzI5TVpuRUp3?=
 =?utf-8?B?cU5iRHR6M0M1N081b09Pd01mM0J6QUxqL0NjU2FjUXU4aTFVU0N4TlFnZ1Vh?=
 =?utf-8?B?SnluTXdMUkgwSGJPMXBtamFmbG1IWFM3TUxiZ2hqZlpqRWIvblE1QXVYaWFQ?=
 =?utf-8?B?djY3UmpVd0xQckI4K0s5ZWZwdHBWaGwrdDNwMDJkV0hYQkczTGppeGRDV1NS?=
 =?utf-8?B?c0k2MEdWRkdSR1NFdUQ3bFJiZndHUndNN2p3SjNRczhRY3NUVUxuRUFMWWts?=
 =?utf-8?B?a095emJFdTlmcUJYQzN1cm93cGpSQlhxcnNRUExIUWRmb3FJNCtkSWI5SFV4?=
 =?utf-8?B?c29UNzEzZ3JMMUozWkozeW5rcGlMTngxVEt5TEVOdHlrNDdvN1E4Z0dKUDEx?=
 =?utf-8?B?L0QwSUh1Y1FzcUFqWG8yUUZaeXI5cW44ZXNNREtzUTBmYVFvOXNtWmw2eFBL?=
 =?utf-8?B?aW9zdkZWdStOMnVHQy9kRGJDL0pselBTKzNzcnZGeWt6MkU1ajd2Q0k0c21x?=
 =?utf-8?B?T2JiUy9nUmh6NGFJcStxZjdNaGd4cDA5OTB1aXo3dmtwVmF5VGNkamFqWk8x?=
 =?utf-8?B?UGkzRjd6RHFjSlhTMXEraU1rOElNTWc3bTZzUk5Tb3JOMU9xb3lEcWIySHVa?=
 =?utf-8?B?dmkwZUI3ellydndoWVdpbmhLdWlvQUFhNnhTclg5L2FDT21BK1FrdEJ0M1Jv?=
 =?utf-8?B?czZRNmpESFN3aWFqaDJTVjBraU9TbnJnL3dYTEVlZHUyV1k5bkcvK3B3WnJi?=
 =?utf-8?B?cjNQTC9YYTYrdFVoUys4aGJMMmpMNEY0c3lCZkxBY252UFJHWUliWUlSLzZa?=
 =?utf-8?B?dDBUMlo4N2Q1RDB2WjBtV1VDOGQvY2x2NGxDQmp1N3R6QzlIdjQzZ21qTjkx?=
 =?utf-8?B?NHhYaDJzclVHaEpMSEcyWGpTcU54UkhrbFk3WGE4djVIcE5KMlZiZElkTjZN?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z50zDtD1vS14/thhlWaVApIdie/EnT9MWEqH6l5stWdhC6TtiBJU0RT39wHemSRoGC6mMxN9ritzcnOMboXpSfQ/+t9aD/GUmYAlaKDGtW2v3M3uxbK2P5kzB0+P2cg2jzc50e/A8014u4OiV8vNnTfRRqBC+5tPCjFiA9SNINrdCwXdTMMLa3GmKMsz7TJZ1pWdEIWMUhA3AMlHhOS3ND5ZlZkWNghOReWPFkfRKEoLUIA23XWvUb0ytyoyX3TVFhNid2IJsg8knKgp0snBpCdFKNNAKXX/BkN7hvhVlTbePKkl4fGpxbqvNmZEBkxoezN5eANzjZmHAh0zftlZ25aKfoITI5byBxODJJRg2UPbIGowHZeeDIN0/RHEuG5qLSn6y0VL2KEKH3tvLVzO1gSuT07De3NcJEtQ39TMMdEC9BFna9yKPAAMtpEY3PCaxTf2PnZEct7g4f0UeJR9xRdDSrXRiXdmeD8lx6eHnz6WFt8V9FcKU9VPKQS5S5rpk5/YG/8JBEMIugGTQ9mcaO3HEUraGWC5yU9h18A0B5hV1Ur2osEbkGLhzf2JGZpOUiLNN/YACZQ5IZY+L/KVf+U13VpQoUlSzmjfRP6Y49c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb045fb9-83d9-4654-b0f2-08dca037b61e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 16:53:52.2531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h3AoAR9jLc1T/GhhXKKfLuNFHW1XEHURnFs1RhQOEzS2ArMLkrSYj/Qb9sU0bmMZVRzleTwL2Xg45Ecmp2RqnEPjWUyiGpuMbNKeXkH72A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090112
X-Proofpoint-GUID: ShsojDBaaX29Z7nHyZexA2hbYQ-vg-lB
X-Proofpoint-ORIG-GUID: ShsojDBaaX29Z7nHyZexA2hbYQ-vg-lB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/07/2024 13:47, Joao Martins wrote:
> On 09/07/2024 10:04, Joao Martins wrote:
>> On 09/07/2024 07:28, Cédric Le Goater wrote:
>>> On 7/8/24 4:34 PM, Joao Martins wrote:
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 2ca9a32cc7b6..1b5b46d28ed6 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -212,6 +212,20 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice
>>>> *vbasedev, Error **errp)
>>>>       return true;
>>>>   }
>>>>   +static bool iommufd_device_dirty_tracking(IOMMUFDBackend *iommufd,
>>>> +                                          VFIODevice *vbasedev)
>>>> +{
>>>> +    enum iommu_hw_info_type type;
>>>> +    uint64_t caps;
>>>> +
>>>> +    if (!iommufd_backend_get_device_info(iommufd, vbasedev->devid, &type,
>>>> +                                         NULL, 0, &caps, NULL)) {
>>>
>>> I think we should report the error and not ignore it.
>>>
>>> That said, since we are probing the hw features of the host IOMMU device,
>>> could we use the data cached in the HostIOMMUDevice struct instead ?
>>> This means would need to move the ->realize() call doing the probing
>>> before attaching the device in vfio_attach_device(). That way we would
>>> catch probing errors in one place. Does this make sense ?
>>
>> Yeap. It also helps centralizing cap checking in addition.
>>
>> This stanadlone use of iommufd_backend_get_device_info() was also annoying me a
>> little, and there doesn't seem to have a reason not to move the initialization
>> of caps earlier. I'll do that
> 
> Maybe I was a little too early into this. I had the snip below, but I forgot
> that vbasedev::devid / vbasedev::iommufd are used by hiod realize() and that is
> done in the very beginning of ->attach_device() of iommufd backend. Not enterily
> sure how to unravel that hmmm
> 

Here's what I came up with (below). Does it matches what you expected?

One thing I wasn't quite clear is what you and Zhenzhong purpose with
HostIOMMUDevice. It looks quite geared towards IOMMUFD with 'enough'
compatiblity for legacy backend:

 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint8_t aw_bits;
+     struct {
+         void *hw_data;
+         uint64_t hw_data_len;
+         uint64_t hw_caps;
+     } iommufd;
 } HostIOMMUDeviceCaps;

So I namespaced the new data we get from ioctl with iommufd, but maybe it wasn't
needed and this doesn't match the style? Let me know your thoughts

--------------->8----------------

From: Joao Martins <joao.m.martins@oracle.com>
Date: Tue, 9 Jul 2024 11:56:18 +0000
Subject: [PATCH] vfio/common: Initialize HostIOMMUDeviceCaps during
 attach_device()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fetch IOMMU hw raw caps behind the device and thus move part of what
happens in  HostIOMMUDevice::realize() to be done during the attach
of the device. It allows us to cache the information obtained from
IOMMU_GET_HW_INFO from iommufd and then serialize to external agents.

This is in preparation to fetch parse hw capabilities and understand
if dirty tracking is supported by device backing IOMMU without
necessarily duplicating the amount of calls we do to IOMMU_GET_HW_INFO.

Suggested-by: Cédric Le Goater <clg@redhat.com
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/sysemu/host_iommu_device.h |  5 ++++
 backends/host_iommu_device.c       |  3 +++
 hw/vfio/common.c                   |  7 ++++--
 hw/vfio/iommufd.c                  | 39 +++++++++++++++++++++---------
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index ee6c813c8b22..9f5f368d97f0 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -25,6 +25,11 @@
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint8_t aw_bits;
+    struct {
+        void *hw_data;
+        uint64_t hw_data_len;
+        uint64_t hw_caps;
+    } iommufd;
 } HostIOMMUDeviceCaps;

 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
index 8f2dda1beb9b..df74b740f8fe 100644
--- a/backends/host_iommu_device.c
+++ b/backends/host_iommu_device.c
@@ -29,5 +29,8 @@ static void host_iommu_device_finalize(Object *obj)
 {
     HostIOMMUDevice *hiod = HOST_IOMMU_DEVICE(obj);

+    g_free(hiod->caps.iommufd.hw_data);
+    hiod->caps.iommufd.hw_data_len = 0;
+
     g_free(hiod->name);
 }
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7cdb969fd396..f3e7fb550788 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1552,17 +1552,20 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,

     assert(ops);

+
+    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+    vbasedev->hiod = hiod;
+
     if (!ops->attach_device(name, vbasedev, as, errp)) {
         return false;
     }

-    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
     if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
         object_unref(hiod);
         ops->detach_device(vbasedev);
+        vbasedev->hiod = NULL;
         return false;
     }
-    vbasedev->hiod = hiod;

     return true;
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 69a13d240811..87c2d2f07d0a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -381,6 +381,29 @@ error:
     return false;
 }

+static bool iommufd_cdev_hiod_caps_init(VFIODevice *vbasedev, Error **errp)
+{
+    HostIOMMUDeviceCaps *caps;
+    union {
+        struct iommu_hw_info_vtd vtd;
+    } hw_data;
+
+    g_assert(vbasedev->hiod);
+
+    /* Cache IOMMU hardware information ahead of HostIOMMUDevice::realize() */
+    caps = &vbasedev->hiod->caps;
+    caps->iommufd.hw_data = g_malloc0(sizeof(hw_data));
+    caps->iommufd.hw_data_len = sizeof(hw_data);
+    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
+                                         &caps->type, &caps->iommufd.hw_data,
+                                         caps->iommufd.hw_data_len,
+                                         &caps->iommufd.hw_caps, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
                                 AddressSpace *as, Error **errp)
 {
@@ -410,6 +433,10 @@ static bool iommufd_cdev_attach(const char *name,
VFIODevice *vbasedev,

     space = vfio_get_address_space(as);

+    if (!iommufd_cdev_hiod_caps_init(vbasedev, errp)) {
+        goto err_alloc_ioas;
+    }
+
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
@@ -715,11 +742,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice
*hiod, void *opaque,
 {
     VFIODevice *vdev = opaque;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
-    enum iommu_hw_info_type type;
-    union {
-        struct iommu_hw_info_vtd vtd;
-    } data;
-    uint64_t hw_caps;

     hiod->agent = opaque;

@@ -727,14 +749,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice
*hiod, void *opaque,
         return true;
     }

-    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
-                                         &type, &data, sizeof(data),
-                                         &hw_caps, errp)) {
-        return false;
-    }
-
     hiod->name = g_strdup(vdev->name);
-    caps->type = type;
     caps->aw_bits = vfio_device_get_aw_bits(vdev);

     return true;
--
2.17.2


