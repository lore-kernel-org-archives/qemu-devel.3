Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D12C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 11:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTJVD-0001BD-KC; Mon, 15 Jul 2024 07:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1sTJV4-00018S-DA; Mon, 15 Jul 2024 07:04:10 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1sTJUy-0004IV-7O; Mon, 15 Jul 2024 07:04:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiN62S2G2bTTD0wADcAKN9jl97yWCipPWjYoUSUUG0WY9Sdw46OYdJuBfJHMHGJKgkAwtmTtZM9XfvccX1y5Tn8fbI2t7uSXbhtImRPu/jw88hVR7EgVIO8POsX3tTkgtej5FpPG1QYZLePdC3grFNL5MaTF030JSG5JOoNVp6JIPWYHFqWsBbOVL1skXB3P5E0kvUtjlV24OmwK/ENYWz2qTcxA6kmA0aR/gUjkqPQisHQQs0DgHCqo2usQmNNxgEuyj9tcDvczomkr+NCo1kcoLlurzgXeC6AYzdr2lS4G2aQZLiaVO6Qs0djuTErE/3h/NiHo/iZn/wh4uG8NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HndJQPoFmSdaoH/js/VsDhthlK/ByR7ms3ZhV7Ed1hA=;
 b=CCdP/EX1Dm32yTvj7b8bLYk/GTM01oTjH0lGGzP3Ub1wyEWDIxbCepNwtUBQLdhoIovjUPmUeXT6CNwF3kijEAEd0SSW+TYaNCDeLiIBl/1o7wiZHSiFj0s2EMoojAeDxBzsqnY7NCo1paLR3eaaemkPI2C5NN4UyZzUFq/WWqKg94Ubxl4EjDTxdhrLRiJK0f859OxnCl2WaZIcvomfYQ5lFcqMfebNtJST5lIZtktzi0R892fgBZvq3+TyOb6SWYXunTAtUUPQOuRxHs4Ybe0pV6JUJDOCQ//iR0ScpFyiHGIoxwoCmF9PfrrNNQLum7VJJ9SJS29KSUesBZPJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HndJQPoFmSdaoH/js/VsDhthlK/ByR7ms3ZhV7Ed1hA=;
 b=OY3OPyKvOv2/9tFz1E5A/1NmyUQKJwJ/xlJ9mP+FRA7hxox7As1rQH335toFimbTGl2c51Fq0/KJSJoKSC3EbAhO/U7adSxYIDMhdGNIyjSr4iMmSjdp3zKjZXUbTQFUIn/2MuDC8LkFxTQh5ji0xj6olVds1huxen5pcm/fatk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB7142.prod.exchangelabs.com (2603:10b6:8:1::11) by
 DM4PR01MB7620.prod.exchangelabs.com (2603:10b6:8:63::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Mon, 15 Jul 2024 11:03:57 +0000
Received: from DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::df6c:2a28:4d6a:3198]) by DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::df6c:2a28:4d6a:3198%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 11:03:57 +0000
Content-Type: multipart/alternative;
 boundary="------------e1bIfHUA54VjFANW6pbjI5J7"
Message-ID: <e17e28ac-28c7-496f-b212-2c9b552dbf63@amperemail.onmicrosoft.com>
Date: Mon, 15 Jul 2024 16:33:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, npiggin@gmail.com,
 harshpb@linux.ibm.com, linuxarm@huawei.com
References: <20240713182516.1457-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <20240713182516.1457-1-salil.mehta@huawei.com>
X-ClientProxiedBy: MA0PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::16) To DM8PR01MB7142.prod.exchangelabs.com
 (2603:10b6:8:1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB7142:EE_|DM4PR01MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f025a44-d37a-493b-102a-08dca4bdd2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elZjeCt6cGRod0dSNTdkV3RXLzd5cGp3OC9iUnNtZWgxT0pZejMrak9vQzFo?=
 =?utf-8?B?c2s0Z0d6VHJVUVNpb3BMSjR2U3FFajBOZFo3L3ZLM1RXYUNZNjZQa0NkemZr?=
 =?utf-8?B?K2F2RTlrWG1hNHBZTFpISDJQbFRlUjJSQ2p5bXYrU1pnWmEyRGV1VGoxSWs5?=
 =?utf-8?B?SGd1R1I4dDAvNCtYQ21Lc2hWWTl3STdQbUNlaUlDRGJNY0pvcytNV2k2SGdo?=
 =?utf-8?B?VEtxMnZkVXZod1laaU5nblNzQVByOUFycXNrcFZjU0p4T3VWOFpCd3VMZ2ZC?=
 =?utf-8?B?MytEV3BVQVF2TFNOVGRHWlI4bCt4ZFE5M01USkR4U0RzdUFYbkpqTzRkR3Qy?=
 =?utf-8?B?SUMyNWdXV0dKUXdhbkMvWEtTZWF3ckdlb2ZSb0RPRlVpSHo4eTBmZFZlaUF3?=
 =?utf-8?B?UlN1dWE0U2ZNSXM5b05DamJBTXU1elU4TVRacXN0UE5SNXViTndjRmUyTjF3?=
 =?utf-8?B?cWh2QXlnT0lJNVowalplM2xyTGNFR3lMNG1SVG9uZFE3bEh1eTAwSkRHclYw?=
 =?utf-8?B?aDl6SjRQRmVYc2R4VEdqVUZEUCtzZU5SM1BSc1pjRjVoKzZGQko1d1R3VGlR?=
 =?utf-8?B?bXVSaUh5N05IdU84eS9iZUdIa292a0ptZXJNWldNeStHOEZmdVpyQWZHZGdz?=
 =?utf-8?B?TDdDU1VTNEV3WVFhaWRhMFhTbFRrZkFYRkZIdHhJb2lXcXI4eDVSUjRMZkQ5?=
 =?utf-8?B?ZlN2R2J3OUJmRlRaWTJKczZISDZpempWL20zcDMxeTZnNHhyNExrQzRhOEJS?=
 =?utf-8?B?ZTVtUkh1S2RqSmRuLzdKdlFHSGFWZUJqOWI1Yk1LTWZ5b3BXbUtNdFk1Qkp2?=
 =?utf-8?B?NVRQYVRnWGtJL1N6NlJ3bjcrNUJsQWg4VGdpcXVuVXVJbHFFY3VqckJCYmVY?=
 =?utf-8?B?ckJqaSsxRzk3Qk0zRXpSdTViR2Q5Z2JVWGQrcGd6T1F5SVRobWZoZmxaSWk1?=
 =?utf-8?B?eitzU1RSY3NGdmVLd2RoelFpVG1tejhyVC9SNlNwUk00cEpRbHRmM3dKU3E3?=
 =?utf-8?B?d0dFVkxSMkdjYnJ2cTU1cjFXVk5FZW44ZW02VTR3Z0gzZzZOSHdiajZweVNN?=
 =?utf-8?B?WWxSekxPeHE3YUU3clphZ0FPT2EyeUpoa01XNFJhaTZsaFd1R2FaRUFtOEFN?=
 =?utf-8?B?MWlQRGpYS3dZakxvdUhHZkZUY1JuRDBHWlc0TFJlcmFPOXFXbVpvK05xcVI3?=
 =?utf-8?B?cG90N1AxU0JGV09SS2NZSGlQOHA3TlFhdXRzOHJ2NS8wSXUrRkhSNVp4MU9I?=
 =?utf-8?B?d3dBZVVTZnZxTi9TeW44TzN5L01tYi9tU1U0SmpNWTNOL1FHTXFmNzFOTXZW?=
 =?utf-8?B?bjZQbytlTEJHTVExbm9mUFd0M2JQQ1d3Q053K2ZaQ2plM1g1bUJXbjJya0Ix?=
 =?utf-8?B?ZzUyNlg4Y2NrMFpFZnZCMGNxRkZkU3YwVWV3eGVGZXZVSVVhN3dMdldJanZM?=
 =?utf-8?B?N0RZVEpzakx3VEtCbDFGbXlDTnFFUW9XZDJvQlFCTUxIaUt5R0tXcUNDWHZm?=
 =?utf-8?B?elJzTnpJS0dMMGpnUnViQW9TK2tOVXQzcG5keHM0NVVaUXpLVDV2WWJWNk5o?=
 =?utf-8?B?ZGpnREhiRC9ZUnpVOXhQNkFxR05UQit2V2tNVW8ydE5MYXdoNUJLMXJEUmxj?=
 =?utf-8?B?bXBiRzNyODBwM092M2RkZG1XWDhPQ2hZTkRJdTE0ZTQ4TWFnMHI3c0RzWklH?=
 =?utf-8?B?VXFXRnlQai9NcTNIVmwvSTh1YzQ5WWVUdlpSbEpVUHc4c2N5K2dIM05rbWQ1?=
 =?utf-8?Q?j9u6YfTwG0Sgm/bwLE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB7142.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBRVWluQXd0MFZLdGw5czNMSHRJODZTV3MyamJRQi9QcTlMQUkvY2VrV21F?=
 =?utf-8?B?ZzR0anRjd0tuZDVHT3BoclhldnRvSThkazM1dXJoaGZZSjFaWkNxcWF0aldx?=
 =?utf-8?B?ME9mVXFtM2dBcWFBQjBZOC93VWxvZmUrS3F0alVCUDZMaWViZk4xdCs5Ly8z?=
 =?utf-8?B?dWlkN29Va3hPcThiVFhwcVhra2JlK2U5UzF4MTM2TlRBSkwvYnkvWGRKMG1V?=
 =?utf-8?B?ZFlNRzhjVGZ5YzhGdWQ5dlhVQ01GMjBEeTEyV3JjRVoyQjg4eXlndlYzT3Qr?=
 =?utf-8?B?UDR4RzNJMGJJSVpGQmFxTVN4RG1pWXIzM3E2UXNOTG5kbmdQc1c0Qk9hbXJv?=
 =?utf-8?B?NlJPTmYwbXFpQ2hjWFRUaVk2R1JLb1ZQNC85TXBBU09IOHpRbldLN3RNQ050?=
 =?utf-8?B?QVh0cWtuSWR6aVRiUk91dDNzcTVvNGNmeWlMQzQzZWlBV2NnSGNqTUMyNGlY?=
 =?utf-8?B?c3Q5S3RBTkJla0hZaDdtSU9UM2hnZjhyZGc4dFE1NXRpY1JGTWwycjlYY1lR?=
 =?utf-8?B?ODNqYW12Qlo1YVRhOEVvU3FqenpJcVhZVGFuNHlSMjh0MFVTd1dvSTEyZ1My?=
 =?utf-8?B?RmNnbTRUVHZNRFUrdnd5UEoxRUNqV0ZxQmJTQXVYclJqVmJldm1OVnRLTUcz?=
 =?utf-8?B?ZDl1djhhT3VPUG1oMWN1aWs1NStsMTU2VnVsQytPYVowOW5HNnhoM2tJSHcx?=
 =?utf-8?B?cFpTUmtsT21DWXF4aVJ2cGdZZXB5MDBYcmFBV2xZWENpTytlUWV0SUUzdytj?=
 =?utf-8?B?S2hhcFA2VE91SDdaZWlXeE9CcXJ2aENjWDk5UCt6b3FCVGo1VnZjVVJ5Y3ZD?=
 =?utf-8?B?RFJ4ZXN5ZFY4bTM2RlNEdHBCS0ZtU3FsLzYzcVpNTGF2MkJRZzNXbmpXMVYr?=
 =?utf-8?B?L1BsVnNvblJaNjc3eStkSUtnalFhWHR6clFIaVhBTGg2dmNaSm9taG0zTTNx?=
 =?utf-8?B?cTZ5dmRLUzJwZmlCKzNQaEhqazJTYnJpTHNTQU1iWWR2WHN3UGEvK3l5Z2hB?=
 =?utf-8?B?NlZUdnJiWTViR2ZVNmp1cFBpZWEzUnNlWjNuV09aalA5ZHFONERqb0ZtdW9w?=
 =?utf-8?B?L0VqWnM5UU9vWnNjYk94ZGhuUk8rTDBYeHNkL2I4LzN1SnpjbUFZM21zdEwy?=
 =?utf-8?B?TzFPOElpRWthU2xaaWhHVVZNZXIyUTNWOUxtMEloS3Nmd0ZMRnhzbXc3dkZB?=
 =?utf-8?B?Q0dkeXFjckFHTjhUZ1IybUV2bjNEVXNTdmVtMDFjd0xMWEtYK3FNQTF5bWQ3?=
 =?utf-8?B?Z0VEdDNjMVZmdGJxQmRRK1pQRXBWT1FSdmNSQTBMMmwzbkppci8weHRmQ1g3?=
 =?utf-8?B?YVBNTXdEZ1RBeXJTSS9VcnFZdDFKa1o3MTFid3M3dXZzOTZ2czE5eUxEYzNP?=
 =?utf-8?B?eUdiTklNbjY1THhMeHhYVC9aVmhuL1d5dGxvTTlIOURXSGRhZGVZWkVWMkVy?=
 =?utf-8?B?RFlseER0bGpGSWpwaXB6RVNTTVUyR1dCejdMSnRKSlh3SmJkaUZCQTRQeFRm?=
 =?utf-8?B?MmZwM3pSTHRoSGVsZ0FJT1RFWFdSRWZoM216bkdnc2tQSHJ2YXhOaTArQTF3?=
 =?utf-8?B?c2VmaGdPZUorb1ZISEpRRVUzazFzaGpRNjY3OU1LL0l6SmkrQjZYYkt6UENU?=
 =?utf-8?B?MFZWNnlQZ28yL1p1S2pyWm11RFdxaXVKY2phTG53Q1QraVY0WGJvVFBiZVAw?=
 =?utf-8?B?UVhhbFo1VElLMjJLRTI2Ny9QTWdGUEliVFRBNjN6cThRaVJWMG9tbEVZMk0v?=
 =?utf-8?B?UzQ5NndGVWtHaXQvbnVDeGNRQ3FVVTJmemZPS2lPTnJqMlFOVXovcENaNklw?=
 =?utf-8?B?SmNoN2ZMQURUd293ODM1aXdBWll2MjFRSXM5SXRDUzJTWXdTM0dzelhnazB4?=
 =?utf-8?B?VzVJcVRIVFRjSjNSNlZXUkVCeDlhNmV2Z3VPN3Ftd0FxWkRFWVIvT1hJWUt5?=
 =?utf-8?B?emxHdUpJRFp6ZW5wRVVldXpzTC9jQUR0dkVEdmVrcklXMzdUQXdlU2hQYTQ1?=
 =?utf-8?B?U0lBMTJXNjcvK2tpbmNIdmxHcEVMS1J2WDVNWm9IcVdjaVNWRk50QlBaV3BP?=
 =?utf-8?B?T0dteld1Tlcvb2ppNmR4cGNnUnZNeG5jbExqUC9HT2JKNnJ6a3pnWUpwUHlZ?=
 =?utf-8?B?MXRES3Z0REpxMUlqVmY2MGl0Mndxc3RVNEU4U1E1a1BJNjZzNzNGSzYyOHdn?=
 =?utf-8?Q?WXB9Y9r6bdsuN00UUsHqd74=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f025a44-d37a-493b-102a-08dca4bdd2aa
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB7142.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 11:03:57.3537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reqX/oYspU3U++z8qnXHTup9wwoWMd1om3ZEoXe0H7HKKFSt7CSJBTtFx3NvZ20dXOHykfDPawOjJir4F+dffrt/yEcVXmNOO/0iqYRNZT8wVRtnOcOmV/42+r9TDeq3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7620
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=2.8, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 KHOP_HELO_FCRDNS=0.259, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--------------e1bIfHUA54VjFANW6pbjI5J7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Salil,

On 13-07-2024 23:55, Salil Mehta wrote:
> [Note: References are present at the last after the revision history]
>
> Virtual CPU hotplug support is being added across various architectures [1][3].
> This series adds various code bits common across all architectures:
>
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
> 3. ACPI CPUs AML code change [Patch 4,5]
> 4. Helper functions to support unrealization of CPU objects [Patch 6,7]
>
> Repository:
>
> [*] Architecture *Agnostic* Patch-set (This series)
>     V14:https://github.com/salil-mehta/qemu.git  virt-cpuhp-armv8/rfc-v3.arch.agnostic.v15
>
>     NOTE: This series is meant to work in conjunction with the architecture-specific
>     patch-set. For ARM, a combined patch-set (architecture agnostic + specific) was
>     earlier pushed as RFC V2 [1]. Later, RFC V2 was split into the ARM Architecture
>     specific patch-set RFC V3 [4] (a subset of RFC V2) and the architecture agnostic
>     patch-set. Patch-set V14 is the latest version in that series. This series
>     works in conjunction with RFC V4-rc2, present at the following link.
>
> [*] ARM Architecture *Specific* Patch-set
>     RFC V3 [4]:https://github.com/salil-mehta/qemu.git  virt-cpuhp-armv8/rfc-v3
>     RFC V4-rc2:https://github.com/salil-mehta/qemu.git  virt-cpuhp-armv8/rfc-v4-rc2 (combined)
>
>
> Revision History:
>
> Patch-set V14 -> V15
> 1. Addressed commnet from Igor Mammedov's on [PATCH V14 4/7]
>     - Removed ACPI_CPU_SCAN_METHOD
>     - Introduced AML_GED_EVT_CPU_SCAN_METHOD ("\\_SB.GED.CPSCN") macro
> 2. Fix the stray change of "assert (" in "PATCH V14 3/7"
> Link:https://lore.kernel.org/qemu-devel/20240712134201.214699-4-salil.mehta@huawei.com/

I tried following test cases with rfc-v4-rc2 and kernel patches v10, and 
it looks good on Ampere platforms.

  * Regular hotplug and hot unplug tests
  * Save/restore  VM, suspend/resume VM with and with out hot-plugging
    vcpus tests
  * Live migration with and with out hot-plugging vcpus tests

Please feel free to add,
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>

_Regards_,

-Vishnu.
> Patch-set V13 -> V14
> 1. Addressed Igor Mammedov's following review comments
>     - Mentioned abput new external APIs in the header note of [PATCH 1/7]
>     - Merged Doc [PATCH V13 8/8] with [PATCH V14 3/7]
>     - Introduced GED realize function for various CPU Hotplug regions initializations
>     - Added back event handler method to indirectly expose \\_SB.CPUS.CSCN to GED
>       _EVT. Like for ARM, it would be through \\_SB.GED.CSCN event handler method
>     - Collected the Ack given for [Patch V13 6/8]
>     - Added back the gfree'ing of GDB regs in common finalize and made it conditional
>     - Updated the header notes of [PATCH V13 3/8,4/8,5/8] to reflect the changes
>
> Patch-set  V12 -> V13
> 1. Added Reviewed-by Tag of Harsh Prateek Bora's (IBM) [PATCH V12 1/8]
> 2. Moved the kvm_{create,park,unpark}_vcpu prototypes from accel/kvm/kvm-cpus.h
>     to include/sysemu/kvm.h. These can later be exported through AccelOps.
> Link:https://lore.kernel.org/qemu-devel/62f55169-1796-4d8e-a35d-7f003a172750@linux.ibm.com/
>
> Patch-set  V11 -> V12
> 1. Addressed Harsh Prateek Bora's (IBM) comment
>     - Changed @cpu to @vcpu_id in the kvm_unpark_vcpu protoype header/
> 2. Added Zhao Liu's (Intel) Tested-by for whole series
>     - Qtest does not breaks on Intel platforms now.
> 3. Added Zhao Liu's (Intel) Reviewed-by for [PATCH V11 {1/8 - 3/8}]
> Link:https://lore.kernel.org/qemu-devel/ZlRSPuJGBgyEUW6w@intel.com/
> Link:https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-e3e78fa5edee@linux.ibm.com/
>
> Patch-set  V10 -> V11
> 1. Addressed Nicholas Piggin's (IBM) comment
>     - moved the traces in kvm_unpark_vcpu and kvm_create_vcpu at the end
>     - Added the Reviewed-by Tag for [PATCH V10 1/8]
> 2.  Addressed Alex Bennée's (Linaro) comments
>     - Added a note explaining dependency of the [PATCH V10 7/8] on Arch specific patch-set
> Link:https://lore.kernel.org/qemu-devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.com/  
> Link:https://lore.kernel.org/qemu-devel/87frubi402.fsf@draig.linaro.org/
>
> Patch-set  V9 -> V10
> 1. Addressed Nicholas Piggin's (IBM) & Philippe Mathieu-Daudé (Linaro) comments
>     - carved out kvm_unpark_vcpu and added its trace
>     - Widened the scope of the kvm_unpark_vcpu so that it can be used by generic framework
>       being thought out
> Link:https://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.mehta@huawei.com/
> Link:https://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-08382a36b63a@linaro.org/
>
> Patch-set  V8 -> V9
> 1. Addressed Vishnu Pajjuri's (Ampere) comments
>     - Added kvm_fd to trace in kvm_create_vcpu
>     - Some clean ups: arch vcpu-id and sbd variable
>     - Added the missed initialization of cpu->gdb_num_regs
> 2. Addressed the commnet from Zhao Liu (Intel)
>     - Make initialization of CPU Hotplug state conditional (possible_cpu_arch_ids!=NULL)
> Link:https://lore.kernel.org/qemu-devel/20240312020000.12992-1-salil.mehta@huawei.com/
>
> Patch-set V7 -> V8
> 1. Rebased and Fixed the conflicts
>
> Patch-set  V6 -> V7
> 1. Addressed Alex Bennée's comments
>     - Updated the docs
> 2. Addressed Igor Mammedov's comments
>     - Merged patches [Patch V6 3/9] & [Patch V6 7/9] with [Patch V6 4/9]
>     - Updated commit-log of [Patch V6 1/9] and [Patch V6 5/9]
> 3. Added Shaoqin Huang's Reviewed-by tags for whole series.
> Link:https://lore.kernel.org/qemu-devel/20231013105129.25648-1-salil.mehta@huawei.com/
>
> Patch-set  V5 -> V6
> 1. Addressed Gavin Shan's comments
>     - Fixed the assert() ranges of address spaces
>     - Rebased the patch-set to latest changes in the qemu.git
>     - Added Reviewed-by tags for patches {8,9}
> 2. Addressed Jonathan Cameron's comments
>     - Updated commit-log for [Patch V5 1/9] with mention of trace events
>     - Added Reviewed-by tags for patches {1,5}
> 3. Added Tested-by tags from Xianglai Li
> 4. Fixed checkpatch.pl error "Qemu -> QEMU" in [Patch V5 1/9]
> Link:https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.mehta@huawei.com/
>
> Patch-set  V4 -> V5
> 1. Addressed Gavin Shan's comments
>     - Fixed the trace events print string for kvm_{create,get,park,destroy}_vcpu
>     - Added Reviewed-by tag for patch {1}
> 2. Added Shaoqin Huang's Reviewed-by tags for Patches {2,3}
> 3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set
> 4. Dropped the ARM specific [Patch V4 10/10]
> Link:https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/
>
> Patch-set  V3 -> V4
> 1. Addressed David Hilderbrand's comments
>     - Fixed the wrong doc comment of kvm_park_vcpu API prototype
>     - Added Reviewed-by tags for patches {2,4}
> Link:https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/
>
> Patch-set  V2 -> V3
> 1. Addressed Jonathan Cameron's comments
>     - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'integer'
>     - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
>     - Updated [Patch V2 3/10] commit-log with details of ACPI_CPU_SCAN_METHOD macro
>     - Updated [Patch V2 5/10] commit-log with details of conditional event handler method
>     - Added Reviewed-by tags for patches {2,3,4,6,7}
> 2. Addressed Gavin Shan's comments
>     - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
>     - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
>     - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_all
>     - Fixed the kvm_{create,park}_vcpu prototypes docs
>     - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
> 3. Addressed one earlier missed comment by Alex Bennée in RFC V1
>     - Added traces instead of DPRINTF in the newly added and some existing functions
> Link:https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/
>
> Patch-set V1 -> V2
> 1. Addressed Alex Bennée's comments
>     - Refactored the kvm_create_vcpu logic to get rid of goto
>     - Added the docs for kvm_{create,park}_vcpu prototypes
>     - Splitted the gdbstub and AddressSpace destruction change into separate patches
>     - Added Reviewed-by tags for patches {2,10}
> Link:https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/
>
> References:
>
> [1]https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/
> [2]https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [3]https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/
> [4]https://lore.kernel.org/qemu-devel/20240613233639.202896-2-salil.mehta@huawei.com/
>
> Salil Mehta (7):
>    accel/kvm: Extract common KVM vCPU {creation,parking} code
>    hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
>    hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>    hw/acpi: Update GED _EVT method AML with CPU scan
>    hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>    physmem: Add helper function to destroy CPU AddressSpace
>    gdbstub: Add helper function to unregister GDB register space
>
>   accel/kvm/kvm-all.c                    | 95 +++++++++++++++++---------
>   accel/kvm/kvm-cpus.h                   |  1 -
>   accel/kvm/trace-events                 |  5 +-
>   docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
>   gdbstub/gdbstub.c                      | 13 ++++
>   hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++
>   hw/acpi/cpu.c                          | 18 +++--
>   hw/acpi/generic_event_device.c         | 27 ++++++++
>   hw/core/cpu-common.c                   |  4 +-
>   hw/i386/acpi-build.c                   |  3 +-
>   include/exec/cpu-common.h              |  8 +++
>   include/exec/gdbstub.h                 |  6 ++
>   include/hw/acpi/cpu.h                  |  7 +-
>   include/hw/acpi/generic_event_device.h |  5 ++
>   include/hw/core/cpu.h                  |  1 +
>   include/sysemu/kvm.h                   | 25 +++++++
>   system/physmem.c                       | 29 ++++++++
>   17 files changed, 212 insertions(+), 44 deletions(-)
>
--------------e1bIfHUA54VjFANW6pbjI5J7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Salil,<br>
    </p>
    <div class="moz-cite-prefix">On 13-07-2024 23:55, Salil Mehta wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240713182516.1457-1-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">[Note: References are present at the last after the revision history]

Virtual CPU hotplug support is being added across various architectures [1][3].
This series adds various code bits common across all architectures:

1. vCPU creation and Parking code refactor [Patch 1]
2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
3. ACPI CPUs AML code change [Patch 4,5]
4. Helper functions to support unrealization of CPU objects [Patch 6,7]

Repository:

[*] Architecture *Agnostic* Patch-set (This series)
   V14: <a class="moz-txt-link-freetext" href="https://github.com/salil-mehta/qemu.git">https://github.com/salil-mehta/qemu.git</a> virt-cpuhp-armv8/rfc-v3.arch.agnostic.v15

   NOTE: This series is meant to work in conjunction with the architecture-specific
   patch-set. For ARM, a combined patch-set (architecture agnostic + specific) was
   earlier pushed as RFC V2 [1]. Later, RFC V2 was split into the ARM Architecture
   specific patch-set RFC V3 [4] (a subset of RFC V2) and the architecture agnostic
   patch-set. Patch-set V14 is the latest version in that series. This series
   works in conjunction with RFC V4-rc2, present at the following link.

[*] ARM Architecture *Specific* Patch-set
   RFC V3 [4]: <a class="moz-txt-link-freetext" href="https://github.com/salil-mehta/qemu.git">https://github.com/salil-mehta/qemu.git</a> virt-cpuhp-armv8/rfc-v3
   RFC V4-rc2: <a class="moz-txt-link-freetext" href="https://github.com/salil-mehta/qemu.git">https://github.com/salil-mehta/qemu.git</a> virt-cpuhp-armv8/rfc-v4-rc2 (combined)


Revision History:

Patch-set V14 -&gt; V15
1. Addressed commnet from Igor Mammedov's on [PATCH V14 4/7]
   - Removed ACPI_CPU_SCAN_METHOD
   - Introduced AML_GED_EVT_CPU_SCAN_METHOD (&quot;\\_SB.GED.CPSCN&quot;) macro
2. Fix the stray change of &quot;assert (&quot; in &quot;PATCH V14 3/7&quot;
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20240712134201.214699-4-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20240712134201.214699-4-salil.mehta@huawei.com/</a>
</pre>
    </blockquote>
    <p>I tried following test cases with rfc-v4-rc2 and kernel patches
      v10, and it looks good on Ampere platforms.</p>
    <ul>
      <li>Regular hotplug and hot unplug tests</li>
      <li>Save/restore&nbsp; VM, suspend/resume VM with and with out
        hot-plugging vcpus tests</li>
      <li>Live migration with and with out hot-plugging vcpus tests</li>
    </ul>
    <p> Please feel free to add,<br>
      Tested-by: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a><br>
    </p>
    <p><u>Regards</u>,</p>
    -Vishnu.
    <blockquote type="cite" cite="mid:20240713182516.1457-1-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
Patch-set V13 -&gt; V14
1. Addressed Igor Mammedov's following review comments
   - Mentioned abput new external APIs in the header note of [PATCH 1/7]
   - Merged Doc [PATCH V13 8/8] with [PATCH V14 3/7]
   - Introduced GED realize function for various CPU Hotplug regions initializations
   - Added back event handler method to indirectly expose \\_SB.CPUS.CSCN to GED
     _EVT. Like for ARM, it would be through \\_SB.GED.CSCN event handler method
   - Collected the Ack given for [Patch V13 6/8]
   - Added back the gfree'ing of GDB regs in common finalize and made it conditional
   - Updated the header notes of [PATCH V13 3/8,4/8,5/8] to reflect the changes

Patch-set  V12 -&gt; V13
1. Added Reviewed-by Tag of Harsh Prateek Bora's (IBM) [PATCH V12 1/8]
2. Moved the kvm_{create,park,unpark}_vcpu prototypes from accel/kvm/kvm-cpus.h
   to include/sysemu/kvm.h. These can later be exported through AccelOps.
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/62f55169-1796-4d8e-a35d-7f003a172750@linux.ibm.com/">https://lore.kernel.org/qemu-devel/62f55169-1796-4d8e-a35d-7f003a172750@linux.ibm.com/</a>

Patch-set  V11 -&gt; V12
1. Addressed Harsh Prateek Bora's (IBM) comment
   - Changed @cpu to @vcpu_id in the kvm_unpark_vcpu protoype header/
2. Added Zhao Liu's (Intel) Tested-by for whole series
   - Qtest does not breaks on Intel platforms now.
3. Added Zhao Liu's (Intel) Reviewed-by for [PATCH V11 {1/8 - 3/8}]
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/ZlRSPuJGBgyEUW6w@intel.com/">https://lore.kernel.org/qemu-devel/ZlRSPuJGBgyEUW6w@intel.com/</a>
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-e3e78fa5edee@linux.ibm.com/">https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-e3e78fa5edee@linux.ibm.com/</a>

Patch-set  V10 -&gt; V11
1. Addressed Nicholas Piggin's (IBM) comment
   - moved the traces in kvm_unpark_vcpu and kvm_create_vcpu at the end
   - Added the Reviewed-by Tag for [PATCH V10 1/8]
2.  Addressed Alex Bennée's (Linaro) comments
   - Added a note explaining dependency of the [PATCH V10 7/8] on Arch specific patch-set
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.com/">https://lore.kernel.org/qemu-devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.com/</a> 
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/87frubi402.fsf@draig.linaro.org/">https://lore.kernel.org/qemu-devel/87frubi402.fsf@draig.linaro.org/</a>

Patch-set  V9 -&gt; V10
1. Addressed Nicholas Piggin's (IBM) &amp; Philippe Mathieu-Daudé (Linaro) comments
   - carved out kvm_unpark_vcpu and added its trace
   - Widened the scope of the kvm_unpark_vcpu so that it can be used by generic framework
     being thought out
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.mehta@huawei.com/</a>
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-08382a36b63a@linaro.org/">https://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-08382a36b63a@linaro.org/</a>

Patch-set  V8 -&gt; V9
1. Addressed Vishnu Pajjuri's (Ampere) comments
   - Added kvm_fd to trace in kvm_create_vcpu
   - Some clean ups: arch vcpu-id and sbd variable
   - Added the missed initialization of cpu-&gt;gdb_num_regs
2. Addressed the commnet from Zhao Liu (Intel)
   - Make initialization of CPU Hotplug state conditional (possible_cpu_arch_ids!=NULL)
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20240312020000.12992-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20240312020000.12992-1-salil.mehta@huawei.com/</a>

Patch-set V7 -&gt; V8
1. Rebased and Fixed the conflicts

Patch-set  V6 -&gt; V7
1. Addressed Alex Bennée's comments
   - Updated the docs
2. Addressed Igor Mammedov's comments
   - Merged patches [Patch V6 3/9] &amp; [Patch V6 7/9] with [Patch V6 4/9]
   - Updated commit-log of [Patch V6 1/9] and [Patch V6 5/9]     
3. Added Shaoqin Huang's Reviewed-by tags for whole series.
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20231013105129.25648-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20231013105129.25648-1-salil.mehta@huawei.com/</a>

Patch-set  V5 -&gt; V6
1. Addressed Gavin Shan's comments
   - Fixed the assert() ranges of address spaces
   - Rebased the patch-set to latest changes in the qemu.git
   - Added Reviewed-by tags for patches {8,9}
2. Addressed Jonathan Cameron's comments
   - Updated commit-log for [Patch V5 1/9] with mention of trace events
   - Added Reviewed-by tags for patches {1,5}
3. Added Tested-by tags from Xianglai Li
4. Fixed checkpatch.pl error &quot;Qemu -&gt; QEMU&quot; in [Patch V5 1/9] 
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.mehta@huawei.com/</a>

Patch-set  V4 -&gt; V5
1. Addressed Gavin Shan's comments
   - Fixed the trace events print string for kvm_{create,get,park,destroy}_vcpu
   - Added Reviewed-by tag for patch {1}
2. Added Shaoqin Huang's Reviewed-by tags for Patches {2,3}
3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set
4. Dropped the ARM specific [Patch V4 10/10]
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/</a>

Patch-set  V3 -&gt; V4
1. Addressed David Hilderbrand's comments
   - Fixed the wrong doc comment of kvm_park_vcpu API prototype
   - Added Reviewed-by tags for patches {2,4}
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/</a>

Patch-set  V2 -&gt; V3
1. Addressed Jonathan Cameron's comments
   - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'integer'
   - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
   - Updated [Patch V2 3/10] commit-log with details of ACPI_CPU_SCAN_METHOD macro
   - Updated [Patch V2 5/10] commit-log with details of conditional event handler method
   - Added Reviewed-by tags for patches {2,3,4,6,7}
2. Addressed Gavin Shan's comments
   - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
   - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
   - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_all
   - Fixed the kvm_{create,park}_vcpu prototypes docs
   - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
3. Addressed one earlier missed comment by Alex Bennée in RFC V1
   - Added traces instead of DPRINTF in the newly added and some existing functions
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/</a>

Patch-set V1 -&gt; V2
1. Addressed Alex Bennée's comments
   - Refactored the kvm_create_vcpu logic to get rid of goto
   - Added the docs for kvm_{create,park}_vcpu prototypes
   - Splitted the gdbstub and AddressSpace destruction change into separate patches
   - Added Reviewed-by tags for patches {2,10}
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/</a>

References:

[1] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/</a>
[2] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/">https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/</a>
[3] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/">https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/</a>
[4] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20240613233639.202896-2-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20240613233639.202896-2-salil.mehta@huawei.com/</a>

Salil Mehta (7):
  accel/kvm: Extract common KVM vCPU {creation,parking} code
  hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
  hw/acpi: Update ACPI GED framework to support vCPU Hotplug
  hw/acpi: Update GED _EVT method AML with CPU scan
  hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
  physmem: Add helper function to destroy CPU AddressSpace
  gdbstub: Add helper function to unregister GDB register space

 accel/kvm/kvm-all.c                    | 95 +++++++++++++++++---------
 accel/kvm/kvm-cpus.h                   |  1 -
 accel/kvm/trace-events                 |  5 +-
 docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
 gdbstub/gdbstub.c                      | 13 ++++
 hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++
 hw/acpi/cpu.c                          | 18 +++--
 hw/acpi/generic_event_device.c         | 27 ++++++++
 hw/core/cpu-common.c                   |  4 +-
 hw/i386/acpi-build.c                   |  3 +-
 include/exec/cpu-common.h              |  8 +++
 include/exec/gdbstub.h                 |  6 ++
 include/hw/acpi/cpu.h                  |  7 +-
 include/hw/acpi/generic_event_device.h |  5 ++
 include/hw/core/cpu.h                  |  1 +
 include/sysemu/kvm.h                   | 25 +++++++
 system/physmem.c                       | 29 ++++++++
 17 files changed, 212 insertions(+), 44 deletions(-)

</pre>
    </blockquote>
  </body>
</html>

--------------e1bIfHUA54VjFANW6pbjI5J7--

