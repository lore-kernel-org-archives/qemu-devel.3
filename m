Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565FE7DEEF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmut6-0002B3-PY; Mon, 02 Feb 2026 09:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vmut4-00028S-Ug
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:26:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vmut3-0004su-8F
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:26:46 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 612ADn1K3224308; Mon, 2 Feb 2026 06:26:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Iw7LPNpSii4+VqIuAB/xd8JTRfpwWFEszkNq4UO4h
 rc=; b=zlBvrqI8iYrjjQ4R3aM2HNtmeKJI8vLqUwVFzlO/LiYt1J7o9Y1PaYs9P
 as3Pwd7hpPMh2sy5D2pVj32o8cXrUrBd/34lv8DQ3JK9Lv8jAopZVmf1GVx6T0Di
 6neP/b0cZDuXGb8weCjBmUFT7N0jwWa4i20dybWB0BPQZKZOyl5tVPuNAxfH1gvL
 zUpZHMe3amGZflZ7WIigdrXPF7cjr7Kr9tyhCIhbWNFFe0YP/qtejHtu7qm4fMF3
 fhGwn7RZgmaYS3gW/izfmeK35f6oCE4NH4B6bl5GDFFHps+TVK4QSqtNIoqnYGJh
 fQNFcmgzybY6aSsYQ0L+WG3/sdqrA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020087.outbound.protection.outlook.com [52.101.61.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1j50krf1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 06:26:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz6+SIA6Nvp9lP2MGxzRWDLdkHRCYowNGi9Z5q7UZk3/UpS1NXQ8ssV7vgTprg9CHFYy5HhRfJycrauj0dcSlf1+Y5F1uo/YDU+lDL70VRYpIOh8cYy9IFIj/KxB6cbY5ILgoI75R9uGCQR5Hd1PSJJL4/naQj6oMEjRlIhiovJLxp0H0TK/9fY5eF8k6kXnnEGaClbLO9iLErX6aC2YIMbapMkEuNrf67q23M3sKV8AwrbxuVnHjjWFiK5Ks7meCkDwaYcEpzJUkt9JM8roe8dgL4j+M5YgFWTXTPMXUy+X3jSmjbjKqtTFrwzkpPi08+jf26ABvmjBQ7YHIzbdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw7LPNpSii4+VqIuAB/xd8JTRfpwWFEszkNq4UO4hrc=;
 b=hj7a+dXITMmUUbYSXpJiSJFiikHu9/qrZj+64mmANQn+5253xxrVXc4p0zhJmJto8R+5xokBNB/zKgVHVo6SsnDfnxtjP9RCDC9y/2xjMZaKi5X5Lf6V8QvBr50sU7U3GwPv/1vJuJ3rQLy1y26u4RqjA/tl3+QKuzdaFU5ILnlMrf8zDzpe+lRSvXpasi7Sq6j5BxDgtrgByPwYSTk0OV08L4V05qhBBLGh7Jm9dAcFpkrZL5USPebbso1EKBHeCuRAXF5KmCL2ygePdenuSdso6REzJ4pCJeHdEYrxsnuPSBKXFg3VFpKuBkaE/e5x5+oNSGF2tKoupXYhtjTrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw7LPNpSii4+VqIuAB/xd8JTRfpwWFEszkNq4UO4hrc=;
 b=lsHJIykiE7XhliyllhLhoXhMcQ+Frk9FtfxfpQkqxbBN/0LR/7Je7SYyxS1zORMSCc7wzS2kaVBLrX5IwkGgK1weUnmahHw3zJjWZKmUlXC3EhITsWVC6hM2zorjwTGl7dRkdy5140EMZxg9ueXhMlGUG5I7JAqbEStf6wJPy+oGpwIIYo1kHpW71i3DHVtZbpnXFESgmidM22uirvmzLa/+PRVvj7Wn/mMwUeNTEBEurMF4RORq2dwaz048pomcjl4arS8qaITr2yDA/hz18ET8F1yuQcBN5xIvTGyhrxDSwAVuSl0Bg0FXPjJ4w1fInEfn8GfyGhgVK+fDJViHSg==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by CH3PR02MB10415.namprd02.prod.outlook.com (2603:10b6:610:20b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Mon, 2 Feb
 2026 14:26:38 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:26:38 +0000
Message-ID: <d4131a65-48a3-4da4-bd8d-c3a5991a2dae@nutanix.com>
Date: Mon, 2 Feb 2026 14:26:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Support for Hyper-V's
 HvExtCallGetBootZeroedMemory()
Content-Language: en-GB
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260112113139.3762156-1-flosch@nutanix.com>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <20260112113139.3762156-1-flosch@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::12) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|CH3PR02MB10415:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f88ea30-f475-4f75-3e79-08de6267139d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzBkR1l4RjF3dnYvalhyaHJKOWtlcmFjNm00VjdRMVoyOUJMaitrUlhLSHRx?=
 =?utf-8?B?QzVydGcyazRjNGVOZzFiR1kwYWRWVzBncWdIQmwzT2lybDRLdHdIVlgwRGFQ?=
 =?utf-8?B?dThzUndxQVJmLy9EeUNnQmh1dHBUV3FoNHV0RnhDSnpJSVBuQlJ1cE1TdUJE?=
 =?utf-8?B?MjRFSk43OFZnNk40OUZkQmtBbkI1eVlKWExzVkVZNXNZTnF5Z0hobEgyL3Yw?=
 =?utf-8?B?a29CUzJ3WGpwQ3F4dmVKUjJFVTdPM2Q2K20yRHJ1WTBYcnl3b2hFUk1FQ1VH?=
 =?utf-8?B?T1hTcTVWTUUrOEplMkZ2OVJqcVRBelVFU3R0ZVBCMy9RTEQrM2xIUTVWUkF2?=
 =?utf-8?B?d3daaERNeVZvdkJNTE5jL0hYRDRseGxlM1ZtbncrNVNwa3dpNUc3Q00vYmRG?=
 =?utf-8?B?QnNmTlFTK09yTlRZa1RlZ0lrSENLMC93UVZzM0svZWVCV0kxQWZidjVvaTJD?=
 =?utf-8?B?c2lLbytDRU9ERng0VkJoUzYraUI0QW1xWGJxdVhoOW9XZDNuQkNoMURDcGJ3?=
 =?utf-8?B?UE5TdXlzL1V1VmJ4Skg1NlBNYTdRU2haMHdzN2ExNjRyV2M0cG02RXNmVlVI?=
 =?utf-8?B?RFBsWUdESW1SNC80SlFPR0t3WUNpNm5GUEx3Q2pVRy9UMXlzK0UxaG9VcVFk?=
 =?utf-8?B?Q1NnYzMxOWp4bVdKaWM5emhjWTQ4cjdtYjlTL3pyMlYvL1lJY3VGYk5RdmJi?=
 =?utf-8?B?TCtkZW9ZaURHOVNVVm53OWljSGhBR1J2YWZ4K2lIKzM4enVDMXBkblF0U2ZI?=
 =?utf-8?B?QVl3N0FwbUJKNjhrT2VjckxTRzZ3N3RVVG41QzY5SWFKNGVoNDRGVzlNRG10?=
 =?utf-8?B?OUFOOHp5YVBGUmY4L1NJSjAzVjM1T3BqaDhuaDEyYS9WV09jczFRZnROS1Ro?=
 =?utf-8?B?ZDBMTDlja2ozV2I5cHRVa2dzU0xDSmVzbDdXODA5VTZSOHFsRWpqSVI0dDFG?=
 =?utf-8?B?UHpMeDUrd1p3NFZEdkVseHJTWWVRQTRtQm4xeXdKRnNVMDNMVFBiQ3VoTXRL?=
 =?utf-8?B?R0VraWEwRFFTVzlZYlhoZEpLc2hNeHRldDhmeTdGZlFTZE1QVHByd0JqQjZx?=
 =?utf-8?B?R3RGZ2Nxai9ZU3ZVMDlrRUxlZ280a0pFaWdNdlNGUlNXdEEwSjRJeWUwTFVS?=
 =?utf-8?B?OGFOUldtQk1DZjRwNEFURzBWeFZHejlwL29RS3pIb2FrVWk2aTFDTk5Va3lL?=
 =?utf-8?B?VUw2TnJnWTJKZnUrNTRUUmRFUEdCYWo0QTlqbFppaVFEbGVFUnordmRIMWY4?=
 =?utf-8?B?V3dhRVZmUUZ1b3hyQS8vU2J4Q2N5cEdadkhtT25MU00ydFlPeTNBOVJORkRm?=
 =?utf-8?B?ZWlObUZhUzYyekJmUTFBV1RBUDdEc0J5K3UrVEJuMnZ1b1VuQWlTamM1bmFp?=
 =?utf-8?B?T0J1SVoxUnloWHpHUVZlVnZzMXNyZ1lFSGxmbXRxbkx1aGw5aEtPTHRaakNH?=
 =?utf-8?B?UXNGVTVwTWwrR3pZSGdQU2lqb3dlMUxVcWdQU2ltM2JXSW0yMXdYL1JCaURD?=
 =?utf-8?B?OTM1cTgwVEtxaGpHYVd4U3NGaWR2bWVQQXBFY2VyVzIvR1UyY3MzY2dGT3d2?=
 =?utf-8?B?SXZZOUZrZlh2MlhtSFhCNzFpUmQ5WXdYcXlBek54WE9HZnRXODZrQmNkQmY0?=
 =?utf-8?B?UU1DU2wxQTh1YzVzR3psT3lzS0RneDdoWERaSXNZak5xVkRMNU16Tm4wT3Jw?=
 =?utf-8?B?eDBaZk5HcDJxWEEzTjg2b2NSZFcrTmNORndTbVd1UDM3MXJjUXFvZ2lKSXpq?=
 =?utf-8?B?aFpuaDhEVXd2VTF4Vk1FUndoRVdUbGpBWFJCS0RNZTQ3cnhoczFuUlVjemNZ?=
 =?utf-8?B?eU1DcWtSRVlCc01LSmRsWUVaUENvbFVlaU1Ucjk5VTBPYnpvTkVlSmVaRnFk?=
 =?utf-8?B?NDZmbUg4S0drMkVycnNkN0llSzU2dVV6UU5aaSs3OGswTVUwbVNDNzVKQXZB?=
 =?utf-8?B?bStMREpLNUdCOUwyeERkMERvNFVxMmpoSVZKLzQvbit4cVlMdlI1cStjYnVG?=
 =?utf-8?B?WktOeXRISytXZlFRWGpTbDljREszNktOYXVtdm4raUtsYjZnL3Y1ZFVxUnJm?=
 =?utf-8?B?OGJNd24vOUJCUC82YUJOK01HaHBvZElxbU5NVFNLK0xmTVpwaXNDOXB6SnZq?=
 =?utf-8?Q?NzTc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9992.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpiN2ZUY0dhWHhFeEIvaWpRMnRyRTFtVkI5dE9weWxsRDZNbkJzZnRubUU0?=
 =?utf-8?B?SmlsYmNYUjlEV0w3T2NBejdFYmp5T0VndHVrd2hJQXhjWmN4MDZCYnBtUHlR?=
 =?utf-8?B?aE1rWjJKTHEzSjZUeFc0UVgxdVJBb2FwNDIzWGkwZXJhQmNNNHdocU4zb2xk?=
 =?utf-8?B?NDIwOVVJMGkxK2RUcDdSQk05bE8rYXdXNENDY2tnOGR1c2gwK3l0cU1lSFhQ?=
 =?utf-8?B?M3cxeFlLVE1WM3ZYcnV0U3Nib3kxajU4bXkrNFl3MmFiYktNRDI3UFZ0dVl2?=
 =?utf-8?B?TVREYkZiVXN6ejh0eG81bVYvdmwzR0V6K2YvSjhzVnlyN0JXWjRreTZnL2Ix?=
 =?utf-8?B?WUJRVFZsdnQ1c2d3M2R0U3RSQWp6TWF1WnBxUnJMUUpYbG5CRUY5VGVueWs2?=
 =?utf-8?B?a0N5dGE5aXBONUVCK0pzUGJKS2thSUtaNEN0S3Z5T2FQT1g5WDVSY0tMd25h?=
 =?utf-8?B?eDBaamNEM2NEWG5zR2lJQWVPM2E0OHlKUDFqSEorK3AzQkVGUlVFbkhtN2po?=
 =?utf-8?B?Q1pQbzV4Nm5HTythTTJSeGVMTVBkMEl5NXZsZ2dkMnJZRFNQN1pqT3EyK1o0?=
 =?utf-8?B?SGovWElocWFTbDl2M3R5bjlNeVllcGg4L1FwMGliczRpVjAyVVZlTEd5L1N1?=
 =?utf-8?B?Z25NOXArMzV2SGNMK0FuYVcwa1QrdndUNG1kZ3YxVTFWdlhXd3FzRzd1bTJ4?=
 =?utf-8?B?ZmwxN2FGdGtOT3NzZXY2azRHSE53K1lscUVUVlZ6RlNadndBV3VjS05wZVZk?=
 =?utf-8?B?ckRsdnVUc0grWkVpNWxIZW9PNEFsM3FBMk1XemxhNXNOdEhEcnI0WHhRYlYw?=
 =?utf-8?B?QmRZTCtvMEFaZUd1NEdqcWdubENTSytpdkdtc0d1OVp5ZnZicmIxU3g3U1Nl?=
 =?utf-8?B?Q3UrS3dPeFRPczRPbW45ZkFEQ0c1R2xRamc4WjZicjByeHR3ei9Ya3NURkRQ?=
 =?utf-8?B?UG1pT1BkQWErNnZFM2sxb2dFMmorS0JhZGZyUlB0UTZGZTk3cU9WUVI1cXdD?=
 =?utf-8?B?VE9vMGdlOHZNWTNKQ1hvNDE5cVhwZUp2MDN0NENnWVU3ekpsZjA1ODh1ZlJ1?=
 =?utf-8?B?SjlqNm9uYUZYNnc3NklNZ2tRd3NzOTF6cHdJVHFZSlZicWQ5aVhJUVNyZzcz?=
 =?utf-8?B?SEx3MXlsWmJwUFZ4a1A1TVB2aHp0SUJKQm9xRkhvWk1ucGU2aUVwWTZEUjhE?=
 =?utf-8?B?ak5hay80OWFlWmtHUDJKTWdWaXpYMzFoMVppdU5udmdIakRUeXNBeXZWMjIv?=
 =?utf-8?B?VDBmUlpXUzBibjh2QnNBYXVzY1FkQW9HbkZ6OEc0MVFMZHBFYlE5Z0k3OVhv?=
 =?utf-8?B?MmpTd0JXdnBVSlZDRXpZSWJGOHBlSTRUZUNyTHAyV3FNWmpETk5jT0NNWHV0?=
 =?utf-8?B?aEs5aWZjZld2bHNPMFpwWGdwKy9HRTZlak90R1R1YXVOZXNPTW5XQnNvZkl4?=
 =?utf-8?B?dytrc1NtdjhFYmlVQnVZMXpjNUJ5emVmT0N3ZXhjZnZ5cjFlYXloZXU5SzQ4?=
 =?utf-8?B?ZkNvZGxLT011K051RXlCaXU5SlBmOWJmRllQZTAvV1E5cXN5UmU2VjJ3c2Ey?=
 =?utf-8?B?ZFF6T3dVdDdIdDBIWm55eVlSYXpkSmp6bWhZZXBHT3pEWUxocFpFNjcxOFha?=
 =?utf-8?B?bVl1aXIyc0hqc3k3UmgvUTBIeXdacm91SWdreUNpc1htTEV0QkFBb2E0U0Qy?=
 =?utf-8?B?R3dkTHdKSmlZaGU4SWF6MFpZMHZDcFZmMGY2VmgralRsVmdvQzNTa3hUZEpT?=
 =?utf-8?B?MTlwdE1KY2pid042Y3YzTlUreG8rbmtuMy9GSXVCQWVFNWJac3ZFblNuYmtW?=
 =?utf-8?B?N0NnMWpmV0s3eERUOGFsMVlYUlJ5ZGZJOG43ZldBNzI0RmR1QUF2dE8xNGZs?=
 =?utf-8?B?Vk1RTmdiN3dGZUVybnpIT1R1Q0MzN3Rrc2xrbWFRZENiZ2Y3dmNWYkVYNHVp?=
 =?utf-8?B?MTI0cGRYK0hPYlFCLzlOalpYVkhqdzZXMElsbTdCK2FhcXpzTXhaWjRyZXh4?=
 =?utf-8?B?Mmp0cVdqQjd2ZTZycHkvd2VTNzhyV2tZOXRub0pMYVdRM0N6TC9rM2hQU2RB?=
 =?utf-8?B?YjIvZGJsQXRaVVFiR083dXdDUTFYUVhCUkR4U3NOLzNhODg2UDF0RURueGNw?=
 =?utf-8?B?Z1FDdFJVeDJsTHhiZXVQQmM1VVF2M1drUEI2S0RyaHFLVVNPYnluNG9ZRURk?=
 =?utf-8?B?OFNoM0Zxa2d3elZCZjZ4YU1vdFZXV1dNbzc2cnlJZnhUNENSb0RjU1BReFRx?=
 =?utf-8?B?RlNDYlJYNjZRd3Jib3k5cU5YK2NSamFTZXYxcVhXWUpYeW1qYlFjTHdPQVc3?=
 =?utf-8?B?R2tFY3l1VmRtMUE4eUQ3Njhna2wrNTdxbkE3RTFXQlNMaHVOTUdiV2NUbkRN?=
 =?utf-8?Q?88LCN/gQI4adAk3M=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88ea30-f475-4f75-3e79-08de6267139d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:26:38.6275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li8XJJ337ur1RbA3PjV90h931eyxsPgLHNYjl0zdvq2umBe2gJ9F9Ous/VU/uAn3J7if4hcwxYsTNfFp7zf7a05KgxB1pUYPwghlc5gb+Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10415
X-Proofpoint-ORIG-GUID: gWO2EFFDYvfroG2EZVBDYH5KRfQRuJau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExMyBTYWx0ZWRfX2vCy00OKBrGW
 F266l0NOBd5Qwd7nPsJGTsHI7IVE6wIBuBqF/RTcMhJcF5ThGwlxlHsbCvybdICaFvyg8OVMSOm
 tgHUMyhJhMrh9TluI+LVTwvfsqArMpcFLJGnTHtVawgcZ9Yz1j4x1wkaIB7oOol6gxkxuyxEG0P
 zAh5jn/t5X27eg59tSBigRREMuFbZO5CG0RgmTvB9T5GDy2sPaOyXIkLW0UKcRCTGG86ATR+tE6
 sQSyAzM4X63FkbblrZSKdPjKeb3tbfvXNhBnAP5+D+Y96Gj7DqXg2oH49xw2heCe4pEP1LUynQo
 okcIALr1eV8So31E9GMkltclSSM37J3gyGNFJu/ENdai33oCvQiZ/gjN/pBSKZLVQAd58wCKG+R
 gXsEFWUr/eau117hfajyQ0gLcsTm74pTdtuloQ0KdBhkS1CdnSzAvJ2hjBM3FTjkmxR+sWbGXWa
 nm2O2mY6n8TMWZ7Dvuw==
X-Authority-Analysis: v=2.4 cv=FNMWBuos c=1 sm=1 tr=0 ts=6980b420 cx=c_pps
 a=uUOONCeAppmmVOxUvBiRog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7ssW_hcC1_-JNJbK2J0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gWO2EFFDYvfroG2EZVBDYH5KRfQRuJau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=flosch@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2026-01-12 11:31, Florian Schmidt wrote:
> This patch series implements two new Hyper-V hypercalls. 

Friendly ping on this. Any concerns, any suggestions about open 
questions such as these below?

> Note that this is still an RFC series. There are a number of open questions,
> most importantly, which memory areas to send back to the guest as
> pre-zeroed.

> I also wonder whether HvExtCallQueryCapabilities() should have a prop bit,

Thanks,
Florian

