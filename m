Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8674C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4K6V-0005lF-U4; Tue, 07 May 2024 08:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1s4K6T-0005hh-Et; Tue, 07 May 2024 08:39:29 -0400
Received: from mail-dm6nam12on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2417::700]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1s4K6Q-0004ey-Kf; Tue, 07 May 2024 08:39:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcBLtdBK0uvJ9lHH66c+6Dk6U/riBNF4RJFhD9/KXaby6H2uuMTVNgbFySMG1BG/5YcdUmYZk2DEwtKBcjmE8K7Rcn2S95NzeyhZJcApNf5aEYw3dh4lPVI32Crr+uhUSn19dFhtApAiCB5wbed2KwgPW/Ml1Q8rukPkxx0DL4yZe9jjnD0uDJktfqyXGGj4YAyOfWbCFjdJmAdXEyJ1ShCIPAEh63LfUxd+J1GPW8mSnUSH02tfn+nPU/Tb14s+CDqF0rn4RYSfBhaSRrl/pJ2PIO84vql1dbVCvTHDAzEjC4Tyt+lte17fpGCZm3j9ZTu+o4ltXUtZzOPz4+Jflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGaRZb/6gf0wvDizhltQBCdxMb03+yf0jina19f+vPA=;
 b=aYFdE3LBT4evJG0X/dDhwx2feE974ywCNIBzPcvdVhbJe4cOpbzv64rihF/sdDGb/+m1GnA3bohXOwTX7kXJ514nCBpt/+lSRTxrgYRk/d1Ay1zKoylFXpor5+sSRgVn0L0HT5wcZ71wZHBCgEBlVq2Yj4rwiW/hLbx8WrNcpp141uNeL3d/0m1djyJOxDesVtA06Ee4240pbc53jW3Y77mZHiHd+4chb23yLTBmcgO48eiCZ+u5QqPT4P5zY8QXivZjNQWg6sxJRhd7uXPYyvryTZ+moknMDLJDtrSK5Pk6I33xi3CmLFMkIpYdMVV+DTHO+Hs7LawldPqCjPgafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGaRZb/6gf0wvDizhltQBCdxMb03+yf0jina19f+vPA=;
 b=gAOP8JQIvXOqZpVIuxhBvBPRWf4yEagxcrltE7tWKBdjCIWDBzPKY+8FAa/v0MrOuSBl9YXELAwncjW6IaH/vPQ3UBy5Hz8F6UiWgg33KCMbjDBxa0RziNjcKW66NEEQKZOeNUrwNwfelsaZJr5rmoW0sqJ0kYQU6NoqvfdRQhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB7142.prod.exchangelabs.com (2603:10b6:8:1::11) by
 SJ2PR01MB8618.prod.exchangelabs.com (2603:10b6:a03:53b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Tue, 7 May 2024 12:39:21 +0000
Received: from DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1]) by DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 12:39:20 +0000
Content-Type: multipart/alternative;
 boundary="------------Dq8GqpnKmeDU7e0OAIBYpjyX"
Message-ID: <696a08f4-1d67-48e4-8c58-57dc33d43ffa@amperemail.onmicrosoft.com>
Date: Tue, 7 May 2024 18:09:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-2-salil.mehta@huawei.com>
 <565ba0ac-a070-4784-a882-2eeab9c91541@amperemail.onmicrosoft.com>
 <8a1fc3ee6a5d4f8fb8ffb9993c90c1b9@huawei.com>
Content-Language: en-US
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <8a1fc3ee6a5d4f8fb8ffb9993c90c1b9@huawei.com>
X-ClientProxiedBy: CH2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:610:60::28) To DM8PR01MB7142.prod.exchangelabs.com
 (2603:10b6:8:1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB7142:EE_|SJ2PR01MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b12bc8b-4e88-4f64-1856-08dc6e92b7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUxWZnhidUgxdktJVkx4Rkt3U1ZtazVxbVBCTHVCcDk3U2RSYTduQnVvME1T?=
 =?utf-8?B?Mmc2OU1Dazc2Zjd5ZVUwQ2UrZmJUclFSZUxGWVhqRGxsWFpHdkE0bFpuRGI4?=
 =?utf-8?B?Q3REcE5aemtuWkVEMTZnVzIyZnVsdW1OTUxyY3Rmd3ZTUFJ2a1RFdysyMVVj?=
 =?utf-8?B?SkJxWHdvREZqNGJlQlp1d0lsbnBHdnhMMURBWEFYZ3NacG9GcWw5UGJxL0d1?=
 =?utf-8?B?WWtDeWVPSW5iNjA2QlI1QkwvQnJUaDdpODFyTG43ZThuNForTUM2Z1ZXQ3Nm?=
 =?utf-8?B?UkJ6VTdXdUZTMVdDMUEzRjc4YzY1UFBxb3JJcytaWnp2QXB5QlNuQmdJdnBs?=
 =?utf-8?B?cUVJQXlWNFRXdGg5Y05kbTk3bnFIRVN1OFo3YUJhcHdMUGpwdWJNTVhBVzBs?=
 =?utf-8?B?ZWlJWitNMjI4cHpsNFZES0Qrckl1U3Fod3FaU2ozRTRQMHB3T29TSnlzV1BX?=
 =?utf-8?B?NHo0bXVLSWY4KzFic2MrNmIvdURUUVZhdEszY3RSaXhMTk5LZW9PK0d2b0h0?=
 =?utf-8?B?WDBiMUNtbXZjUHZLR0tGbXlZVzJrelZTZDd5Um9ZWmNaZWFrT0JoNTkyMnpN?=
 =?utf-8?B?TG1Ia0dmWEZGWGNqZlpmRTlnaGVaZ1B3bDR2RnJTdzN3a0dQWXlFcXRmc2x6?=
 =?utf-8?B?ZEtBaXpvWlBaTUZ3MGpqVkVJMGU3a1Z5ZmdNVVRFdlRSSjQvVHJlMFdhTlp6?=
 =?utf-8?B?em9HK0ZzN3JiL3cxLzNrMy8wVS91bE1FMWJVSk9sbzN2ZjFNbmxyUU1NQ1dO?=
 =?utf-8?B?SXBoSFhzTitNY1lOaExsalpxTW5hY25Jdm9mSCtOam1aRnNuSkZHU05kTkl3?=
 =?utf-8?B?UFd3YjU5d3FUL0FDVnE4N3hkYWt6dFBiRHZmUzdXK3F5S1JHbVJ6QWUrUEJF?=
 =?utf-8?B?TTRzZW9PM05FREJ5bmYvbHJhSlZxL2JIcmQzMktlNi80QWIrRFdFQnEyYjNy?=
 =?utf-8?B?cG5SbkRmWCt2UENoZkVKSkd6SDZCd3dGWmczR0JZUGdQRlp2OCtnTVBjSDhl?=
 =?utf-8?B?dzNoblFXZTNOZGZXajVHaXJYMmdzenk0ZVJzT3dmb3NDcGhteklyclc0RURY?=
 =?utf-8?B?SHFUZFk2WW5PcGp4dUZBQW9WVXNtUmt6T2lFNEo0N1daZmJSMUVvdUttTUFM?=
 =?utf-8?B?OGJmMFhnT2FNbXBCdDd5SGNIZGl5MjNCUmhNOS9La2pTMk8yZ21lYWRvNElx?=
 =?utf-8?B?TEZCRDVuSkNOYTU5cW14MWd0NlhqUFR4SE13L29DL1RBRFZwdWtncW12Vy9p?=
 =?utf-8?B?NWlXTGc1OGxJTXUrWFNnTnpJZGJkczZCQW9DcHgwSG9GNEttNDVjRE5oVmRF?=
 =?utf-8?B?SGtGMVBVa1B6dXJMeS9sRFZsd0hSSnBQQjBaek5PY1NMNEhWUGRtNUFia3NY?=
 =?utf-8?B?cStVSU5JcXBONWp5dldQM0ZBY1ljRkQ5a3RXaUV4QVhaUkxKNEhyRjZhMU5i?=
 =?utf-8?B?MEhUQ0ErVE01TUpkUzZhWHpVTWVwR3hrTFpFZFdaYWxzWGorVUtiYTF4UTQ5?=
 =?utf-8?B?MXZrdHpCVDlnOEtyRGc0Rk1GRXBkU0RLZW1hY0QwWVltdEFqUHc3QVZDd1hG?=
 =?utf-8?B?c3ZmSU5SVmY4Z2ZBUUVjTUZrenE2MkNISWt2MUVBVnpocWtaMVY4aGRLK0Nr?=
 =?utf-8?B?blBBMTVqVkhhUlFLMmJjY1k2Q0RGQTAxVDUvZHBWR21NWnd5dVFMZW1Ob2xp?=
 =?utf-8?B?OXRiaTU2SHRiTU45UE9SY2NFMzdXRTY0ZUNnWEUrWm1uSDdQVTZ4L2NBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB7142.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NvYlN5MndZMHFSYThtemZuTWhzeHJNZHpMcy9taU9RaEEyMXc0UjlvVlIz?=
 =?utf-8?B?Qnoya2llMzJHajFxRFdFb1lBZnlMQ3N0RmRsQjNwamZMbkNmZUYxblQzbnFM?=
 =?utf-8?B?enJncjZMSklHdFFRc3dmYWRGay9hT2lCV1BObzNwb0pzN2phaW9qcmsyQ252?=
 =?utf-8?B?RGw4S3U1MEswYlg2Szl4QjBab3NDQStMYzlEMy85MDU5WHJPOXJqd2k3dnMx?=
 =?utf-8?B?TENVaEQ3VDhnUVFyK0Z6VHczc3FBSlp5VGFYVWFBSUdua3JsWmdPU2ZjYXk4?=
 =?utf-8?B?RGpIV3hsOVdFdStXb1VTbWZKVlNjNDFVTHhKVWJaNEQ5T1ZFdjVBT0sveTBR?=
 =?utf-8?B?RnpoQVBvdnMwNmwrUTAzMmtrelpIa3UzaUJMK2gxNVUvQXZyYURRNXkwNCtV?=
 =?utf-8?B?ZUVGOGNMS3JTRmJLaE1oV293bVVCVlQvdFJLeXZLT2dwOXd3SVVCT1VOKy9F?=
 =?utf-8?B?bFkzVkNpclpZQzA2NHFFWmFSMW5JTWlQNTBJc0lWRlBha1JlNG9CMStIeTZF?=
 =?utf-8?B?bG9pVnh3UzlJc0Juam13SGNFc3ZmdWd0VW9SMXh3ZWpGbjd2TXBIbG94enJz?=
 =?utf-8?B?T3VYODJFVmc3WVM0NUJ4ZUU3c2Q4U2F3dEFsVlBMeXFveVdTYURkRmFGS0hV?=
 =?utf-8?B?dXpuUG1SNExDZWRwY2g5dnJMMU9xbTBZSDJtR0VZaUhzK2tVakxSWGR1SjhZ?=
 =?utf-8?B?cjY3aHFOMjNTWkxJQTFraUE1bWw5eWtBZnlsaHdLV1MzeWo0R245YXVzVG1i?=
 =?utf-8?B?Q2hFVjZpWHBOblVwaFlvR1BRQnJHVTgwalh0eElsWWl1RjFWd0lqeU11ZzVF?=
 =?utf-8?B?RDE4K3dDc2xveFVpTUs4dThGMVdXYy8wUjZjWVNlajVRNVl1YXZqMzF0UWNp?=
 =?utf-8?B?c2JCT1kzaXJ4T01uMWpwaC9oQ2ZzbXdISEZjNkYzZ29VK0xlZlgyZkNYRDlC?=
 =?utf-8?B?aU82RWRubjMveHRhOTNEWFI5MVoyTThMT2N5YWtERlBRQjZVU2NiQmEzY3JH?=
 =?utf-8?B?V0NJM0MrUms3MjNRRFVRRjhicVVoZG9ibUF3OHpPelE0UzVQZlg2TkZIU3BJ?=
 =?utf-8?B?UkVvQlplcm0zQnpTV2ZOK2dhaFNaK0RoUmFZRVN1LzBuT0YraTN1d1hmZWZy?=
 =?utf-8?B?dnp6dUlnVWxCVUM3SVVTN0VLYXpycEJPZk93cnJEcEVBYmdibmhBSXJBNVpG?=
 =?utf-8?B?QTJndVU4UktYSm91endTcmFlNno5WEVscEtCTEgwVFdoM1NXZ2NlYnlISDdx?=
 =?utf-8?B?NWl0OWJQTWM3d3Rvb3QvZmVWVWdqcGlONE94ajNzbEdXWVJFL1JkTktqbDN3?=
 =?utf-8?B?anR1Y3RzWE9td24ydnBUZUU3QXc4MVExdmEyZ2s5WU5Ba1dNRC9zcmxJRlZV?=
 =?utf-8?B?WlRLMm9PODdxTE4wcFU1dnJiTEdjUEE0amRKYk5jTkY5ME4yWTlrMjFrRW9i?=
 =?utf-8?B?bi9FdU5yRC9VTGF4YmwxbWloMTBFenRWalQ3VkpYRGlGbGdZNjdZYmlLQSs2?=
 =?utf-8?B?Rkp3SnpkaTJpd0xWWC9iZFZhWm1WNU1qRDkwZDc5YUsyQUlua2h2eUpDaXRW?=
 =?utf-8?B?cGhBT0NTTGZPK0g3Sm5JNGVRV2ZzZ01lOGEwT2R5Z1RwRmRVVVBqZmNXNUN1?=
 =?utf-8?B?S3NqSkZGd3NSNlg4NlIrRm9MM2I5NHdKVUpQanliS3YwNlJ0WWE5ZUk4d3FX?=
 =?utf-8?B?SFpLU284ZUNTUmdaZk9CeTNyamFPVU9sQjFEc09CUWxPcEdsRStpVUNoV3Ny?=
 =?utf-8?B?VWZMZGczQVk1SnNBcmo4MlZSQ0VaWjVnc3Z4RzhoT1N2bjF6VitNTmRzTHhn?=
 =?utf-8?B?NUJ6WjlQdWdUQWFCdGVqOVVwNWcxdTB5dmU2RWxXS2k1VGdBdnBYYUtKOHBQ?=
 =?utf-8?B?VDkwdUFEQ0owcHNWRFE5ZmlvUUI3MndwckgrMmxjblZwU25nTGVQeGU3Z2tV?=
 =?utf-8?B?N1d5WHlNU2FLTDF6bjZMZWpsL2hKMmhuTUdMcElSQkpIZnpzZFNGVTh4ZWpU?=
 =?utf-8?B?aGFQZHo5bU5qOFdDcU5KUVJkY1p5dklNdWtadEMzbVRhQXpoRVVwbG5GS2Ey?=
 =?utf-8?B?eUl6Q2ZaTTl6L2luNWc4bGl5V2pVQTZNV3A0MHNNaEFwVlpGV1AxSmZUWStD?=
 =?utf-8?B?WEdmMFQyeW84UVVFM09KYVdsVHo2eFVpNkJQV0dRMFFpbDVNcXM5a3NQNFkv?=
 =?utf-8?Q?tn4GGimn7nWZy1xMoHp9IbU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b12bc8b-4e88-4f64-1856-08dc6e92b7a0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB7142.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 12:39:20.7828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC8Tp3Jxv2IZQ89f5tRVZiPcTQiG0BlJnYaZeiKe9rDJ1ZGt5wPZ4UDRocaVjS4PM2ej+CPBs0AfuRAUwMNjovwl5sPtdPVYEzswQhNa0BmUXe3kGM3E3QeO/DwHoWxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8618
Received-SPF: pass client-ip=2a01:111:f403:2417::700;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--------------Dq8GqpnKmeDU7e0OAIBYpjyX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Salil,

On 03-05-2024 21:53, Salil Mehta wrote:
> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>
>
> Hi Vishnu,
>
>>   From: Vishnu Pajjuri<vishnu@amperemail.onmicrosoft.com>
>>   Sent: Thursday, April 4, 2024 3:00 PM
>>   Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU {creation,parking} code
>>
>>   Hi Salil,
>>>   On 12-03-2024 07:29, Salil Mehta wrote:
>>>   KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
>>>   is spawned. This is common to all the architectures as of now.
>>>
>>>   Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
>>>   corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
>>>   support vCPU removal. Therefore, its representative KVM vCPU object/context in
>>>   Qemu is parked.
>>>
>>>   Refactor architecture common logic so that some APIs could be reused by vCPU
>>>   Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
>>>   with trace events instead of DPRINTF. No functional change is intended here.
>>>
>>>   Signed-off-by: Salil Mehtamailto:salil.mehta@huawei.com
>>>   Reviewed-by: Gavin Shanmailto:gshan@redhat.com
>>>   Tested-by: Vishnu Pajjurimailto:vishnu@os.amperecomputing.com
>>>   Reviewed-by: Jonathan Cameronmailto:Jonathan.Cameron@huawei.com
>>>   Tested-by: Xianglai Limailto:lixianglai@loongson.cn
>>>   Tested-by: Miguel Luismailto:miguel.luis@oracle.com
>>>   Reviewed-by: Shaoqin Huangmailto:shahuang@redhat.com
>>>   ---
>>>    accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
>>>    accel/kvm/trace-events |  5 +++-
>>>    include/sysemu/kvm.h   | 16 +++++++++++
>>>    3 files changed, 69 insertions(+), 16 deletions(-)
>>>
>>>   diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>   index a8cecd040e..3bc3207bda 100644
>>>   --- a/accel/kvm/kvm-all.c
>>>   +++ b/accel/kvm/kvm-all.c
>>>   @@ -126,6 +126,7 @@ static QemuMutex kml_slots_lock;
>>>    #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>>>
>>>    static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
>>>   +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>>>
>>>    static inline void kvm_resample_fd_remove(int gsi)
>>>    {
>>>   @@ -314,14 +315,53 @@ err:
>>>   return ret;
>>>    }
>>>
>>>   +void kvm_park_vcpu(CPUState *cpu)
>>>   +{
>>>   +    struct KVMParkedVcpu *vcpu;
>>>   +
>>>   +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   It's good if we add kvm_fd to trace.
>>   It will be useful to cross verify kvm_get_vcpu()'s kvm_fd with parked vcpu.
>
> Agreed. But this is currently called in context to create and destroy vCPU
> where the trace already exists with the info you are seeking. Having
> trace here might duplicate the info and end up increasing the noise.
>
> Let me know if you think otherwise or have something else to add.

This is to provide additional information to the racing only.

The intention here is to trace mapping of vcpu_id<-->kvm_fd while parking

and fetching vcpu. This way we can easily trace what is parked 
(kvm_park_vcpu()) vs fetched (kvm_get_vcpu())

using pair of information.

>
> Thanks
>
>
>>>   +
>>>   +    vcpu = g_malloc0(sizeof(*vcpu));
>>>   +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>>   +    vcpu->kvm_fd = cpu->kvm_fd;
>>>   +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>>>   +}
>>>   +
>>>   +int kvm_create_vcpu(CPUState *cpu)
>>>   +{
>>>   +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
>>>   +    KVMState *s = kvm_state;
>>>   +    int kvm_fd;
>>>   +
>>>   +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   vcpu_id can be used instead of kvm_arch_vcpu_id(cpu).
>
> KVM arch VCPU Id ensures that ID being traced is meaningful for that
> architecture. The way CPU ID gets calculated in on different architectures
> could be different. Hence, its value might be quite different.

vcpu_id is already being calculated just above trace call.

I don't think vcpu_id value gets differ by the time of tracing.

>
>>>   +
>>>   +    /* check if the KVM vCPU already exist but is parked */
>>>   +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
>>>   +    if (kvm_fd < 0) {
>>>   +>   /* vCPU not parked: create a new KVM vCPU */
>>>   +>   kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
>>>   +>   if (kvm_fd < 0) {
>>>   +>       error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
>>>   +>       return kvm_fd;
>>>   +>   }
>>>   +    }
>>>   +
>>>   +    cpu->kvm_fd = kvm_fd;
>>>   +    cpu->kvm_state = s;
>>>   +    cpu->vcpu_dirty = true;
>>>   +    cpu->dirty_pages = 0;
>>>   +    cpu->throttle_us_per_full = 0;
>>>   +
>>>   +    return 0;
>>>   +}
>>>   +
>>>    static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>    {
>>>        KVMState *s = kvm_state;
>>>        long mmap_size;
>>>   -    struct KVMParkedVcpu *vcpu = NULL;
>>>        int ret = 0;
>>>
>>>   -    trace_kvm_destroy_vcpu();
>>>   +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>>
>>>        ret = kvm_arch_destroy_vcpu(cpu);
>>>        if (ret < 0) {
>>>   @@ -347,10 +387,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>   >    }
>>>        }
>>>
>>>   -    vcpu = g_malloc0(sizeof(*vcpu));
>>>   -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>>   -    vcpu->kvm_fd = cpu->kvm_fd;
>>>   -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>>>   +    kvm_park_vcpu(cpu);
>>>    err:
>>>        return ret;
>>>    }
>>>   @@ -371,6 +408,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>>>   >    if (cpu->vcpu_id == vcpu_id) {
>>>   >        int kvm_fd;
>>>
>>>   +>       trace_kvm_get_vcpu(vcpu_id);
>>   It's good if we add kvm_fd to trace.
>>   It will be useful to cross verify kvm_get_vcpu's kvm_fd with parked vcpu.
>
> I can but I'm wondering why you've raised this? Perhaps, I'm not aware of the
> interface you are using to configure the VMs and how traces across diferent
> VMs get reflected. Please help in my understanding.

This is to provide additional information only not specific to any 
interface to configure VMs.

_Regards_,

-Vishnu

>
>>>   +
>>>   >        QLIST_REMOVE(cpu, node);
>>>   >        kvm_fd = cpu->kvm_fd;
>>>   >        g_free(cpu);
>>>   @@ -378,7 +417,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>>>   >    }
>>>        }
>>>
>>>   -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>>>   +    return -ENOENT;
>>>    }
>>>
>>>    int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>>   @@ -389,19 +428,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>>
>>>        trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>>
>>>   -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>>>   +    ret = kvm_create_vcpu(cpu);
>>>        if (ret < 0) {
>>>   -   error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
>>>   +   error_setg_errno(errp, -ret,
>>>   +          "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>>              kvm_arch_vcpu_id(cpu));
>>>       goto err;
>>>        }
>>>
>>>   -    cpu->kvm_fd = ret;
>>>   -    cpu->kvm_state = s;
>>>   -    cpu->vcpu_dirty = true;
>>>   -    cpu->dirty_pages = 0;
>>>   -    cpu->throttle_us_per_full = 0;
>>>   -
>>>        mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>>>        if (mmap_size < 0) {
>>>       ret = mmap_size;
>>>   diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
>>>   index a25902597b..5558cff0dc 100644
>>>   --- a/accel/kvm/trace-events
>>>   +++ b/accel/kvm/trace-events
>>>   @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>>>    kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>>>    kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>>>    kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>>>   +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>>>   +kvm_get_vcpu(unsigned long arch_cpu_id) "id: %lu"
>>>   +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>>>   +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>>>    kvm_irqchip_commit_routes(void) ""
>>>    kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>>>    kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>>>   @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>>>    kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
>>>    kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>>>    kvm_dirty_ring_flush(int finished) "%d"
>>>   -kvm_destroy_vcpu(void) ""
>>>    kvm_failed_get_vcpu_mmap_size(void) ""
>>>    kvm_cpu_exec(void) ""
>>>    kvm_interrupt_exit_request(void) ""
>>>   diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>>>   index fad9a7e8ff..2ed928aa71 100644
>>>   --- a/include/sysemu/kvm.h
>>>   +++ b/include/sysemu/kvm.h
>>>   @@ -435,6 +435,22 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>>>    int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>>>   >  >  >  >  >       hwaddr *phys_addr);
>>>
>>>   +/**
>>>   + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
>>>   + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
>>>   + *
>>>   + * @returns: 0 when success, errno (<0) when failed.
>>>   + */
>>>   +int kvm_create_vcpu(CPUState *cpu);
>>>   +
>>>   +/**
>>>   + * kvm_park_vcpu - Park QEMU KVM vCPU context
>>>   + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
>>>   + *
>>>   + * @returns: none
>>>   + */
>>>   +void kvm_park_vcpu(CPUState *cpu);
>>>   +
>>>    #endif /* NEED_CPU_H */
>>>
>>>    void kvm_cpu_synchronize_state(CPUState *cpu);
>>   Otherwise, Looks good to me.  Feel free to add
>>   Reviewed-by: "Vishnu Pajjuri"mailto:vishnu@os.amperecomputing.com
>>   Thanks,
> Thanks.
> Salil
>
>
>
>>   -Vishnu
--------------Dq8GqpnKmeDU7e0OAIBYpjyX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Salil,<br>
    </p>
    <div class="moz-cite-prefix">On 03-05-2024 21:53, Salil Mehta wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8a1fc3ee6a5d4f8fb8ffb9993c90c1b9@huawei.com">
      <pre class="moz-quote-pre" wrap="">[EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]


Hi Vishnu,

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> From: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@amperemail.onmicrosoft.com">&lt;vishnu@amperemail.onmicrosoft.com&gt;</a>
 Sent: Thursday, April 4, 2024 3:00 PM
 Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU {creation,parking} code

 Hi Salil,
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> On 12-03-2024 07:29, Salil Mehta wrote:
 KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
 is spawned. This is common to all the architectures as of now.

 Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
 corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
 support vCPU removal. Therefore, its representative KVM vCPU object/context in
 Qemu is parked.

 Refactor architecture common logic so that some APIs could be reused by vCPU
 Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
 with trace events instead of DPRINTF. No functional change is intended here.

 Signed-off-by: Salil Mehta <a class="moz-txt-link-freetext" href="mailto:salil.mehta@huawei.com">mailto:salil.mehta@huawei.com</a>
 Reviewed-by: Gavin Shan <a class="moz-txt-link-freetext" href="mailto:gshan@redhat.com">mailto:gshan@redhat.com</a>
 Tested-by: Vishnu Pajjuri <a class="moz-txt-link-freetext" href="mailto:vishnu@os.amperecomputing.com">mailto:vishnu@os.amperecomputing.com</a>
 Reviewed-by: Jonathan Cameron <a class="moz-txt-link-freetext" href="mailto:Jonathan.Cameron@huawei.com">mailto:Jonathan.Cameron@huawei.com</a>
 Tested-by: Xianglai Li <a class="moz-txt-link-freetext" href="mailto:lixianglai@loongson.cn">mailto:lixianglai@loongson.cn</a>
 Tested-by: Miguel Luis <a class="moz-txt-link-freetext" href="mailto:miguel.luis@oracle.com">mailto:miguel.luis@oracle.com</a>
 Reviewed-by: Shaoqin Huang <a class="moz-txt-link-freetext" href="mailto:shahuang@redhat.com">mailto:shahuang@redhat.com</a>
 ---
  accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
  accel/kvm/trace-events |  5 +++-
  include/sysemu/kvm.h   | 16 +++++++++++
  3 files changed, 69 insertions(+), 16 deletions(-)

 diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
 index a8cecd040e..3bc3207bda 100644
 --- a/accel/kvm/kvm-all.c
 +++ b/accel/kvm/kvm-all.c
 @@ -126,6 +126,7 @@ static QemuMutex kml_slots_lock;
  #define kvm_slots_unlock()  qemu_mutex_unlock(&amp;kml_slots_lock)

  static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
 +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);

  static inline void kvm_resample_fd_remove(int gsi)
  {
 @@ -314,14 +315,53 @@ err:
 return ret;
  }

 +void kvm_park_vcpu(CPUState *cpu)
 +{
 +    struct KVMParkedVcpu *vcpu;
 +
 +    trace_kvm_park_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""> It's good if we add kvm_fd to trace.
 It will be useful to cross verify kvm_get_vcpu()'s kvm_fd with parked vcpu.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

Agreed. But this is currently called in context to create and destroy vCPU
where the trace already exists with the info you are seeking. Having
trace here might duplicate the info and end up increasing the noise.

Let me know if you think otherwise or have something else to add.</pre>
    </blockquote>
    <p>This is to provide additional information to the racing only.<br>
    </p>
    <p>The intention here is to trace mapping of vcpu_id&lt;--&gt;kvm_fd
      while parking</p>
    <p>and fetching vcpu. This way we can easily trace what is parked&nbsp;
      (kvm_park_vcpu()) vs fetched (kvm_get_vcpu())</p>
    <p>using pair of information.<br>
    </p>
    <blockquote type="cite" cite="mid:8a1fc3ee6a5d4f8fb8ffb9993c90c1b9@huawei.com">
      <pre class="moz-quote-pre" wrap="">

Thanks


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> +
 +    vcpu = g_malloc0(sizeof(*vcpu));
 +    vcpu-&gt;vcpu_id = kvm_arch_vcpu_id(cpu);
 +    vcpu-&gt;kvm_fd = cpu-&gt;kvm_fd;
 +    QLIST_INSERT_HEAD(&amp;kvm_state-&gt;kvm_parked_vcpus, vcpu, node);
 +}
 +
 +int kvm_create_vcpu(CPUState *cpu)
 +{
 +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
 +    KVMState *s = kvm_state;
 +    int kvm_fd;
 +
 +    trace_kvm_create_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""> vcpu_id can be used instead of kvm_arch_vcpu_id(cpu).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

KVM arch VCPU Id ensures that ID being traced is meaningful for that
architecture. The way CPU ID gets calculated in on different architectures
could be different. Hence, its value might be quite different.
</pre>
    </blockquote>
    <p>vcpu_id is already being calculated just above trace call.&nbsp;</p>
    <p>I don't think vcpu_id value gets differ by the time of tracing.</p>
    <blockquote type="cite" cite="mid:8a1fc3ee6a5d4f8fb8ffb9993c90c1b9@huawei.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> +
 +    /* check if the KVM vCPU already exist but is parked */
 +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
 +    if (kvm_fd &lt; 0) {
 +&gt;   /* vCPU not parked: create a new KVM vCPU */
 +&gt;   kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
 +&gt;   if (kvm_fd &lt; 0) {
 +&gt;       error_report(&quot;KVM_CREATE_VCPU IOCTL failed for vCPU %lu&quot;, vcpu_id);
 +&gt;       return kvm_fd;
 +&gt;   }
 +    }
 +
 +    cpu-&gt;kvm_fd = kvm_fd;
 +    cpu-&gt;kvm_state = s;
 +    cpu-&gt;vcpu_dirty = true;
 +    cpu-&gt;dirty_pages = 0;
 +    cpu-&gt;throttle_us_per_full = 0;
 +
 +    return 0;
 +}
 +
  static int do_kvm_destroy_vcpu(CPUState *cpu)
  {
      KVMState *s = kvm_state;
      long mmap_size;
 -    struct KVMParkedVcpu *vcpu = NULL;
      int ret = 0;

 -    trace_kvm_destroy_vcpu();
 +    trace_kvm_destroy_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));

      ret = kvm_arch_destroy_vcpu(cpu);
      if (ret &lt; 0) {
 @@ -347,10 +387,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
 &gt;    }
      }

 -    vcpu = g_malloc0(sizeof(*vcpu));
 -    vcpu-&gt;vcpu_id = kvm_arch_vcpu_id(cpu);
 -    vcpu-&gt;kvm_fd = cpu-&gt;kvm_fd;
 -    QLIST_INSERT_HEAD(&amp;kvm_state-&gt;kvm_parked_vcpus, vcpu, node);
 +    kvm_park_vcpu(cpu);
  err:
      return ret;
  }
 @@ -371,6 +408,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
 &gt;    if (cpu-&gt;vcpu_id == vcpu_id) {
 &gt;        int kvm_fd;

 +&gt;       trace_kvm_get_vcpu(vcpu_id);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""> It's good if we add kvm_fd to trace.
 It will be useful to cross verify kvm_get_vcpu's kvm_fd with parked vcpu.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

I can but I'm wondering why you've raised this? Perhaps, I'm not aware of the
interface you are using to configure the VMs and how traces across diferent
VMs get reflected. Please help in my understanding.
</pre>
    </blockquote>
    <p>This is to provide additional information only not specific to
      any interface to configure VMs.</p>
    <p><u>Regards</u>,</p>
    <p>-Vishnu<br>
    </p>
    <blockquote type="cite" cite="mid:8a1fc3ee6a5d4f8fb8ffb9993c90c1b9@huawei.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> +
 &gt;        QLIST_REMOVE(cpu, node);
 &gt;        kvm_fd = cpu-&gt;kvm_fd;
 &gt;        g_free(cpu);
 @@ -378,7 +417,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
 &gt;    }
      }

 -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
 +    return -ENOENT;
  }

  int kvm_init_vcpu(CPUState *cpu, Error **errp)
 @@ -389,19 +428,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)

      trace_kvm_init_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));

 -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
 +    ret = kvm_create_vcpu(cpu);
      if (ret &lt; 0) {
 -   error_setg_errno(errp, -ret, &quot;kvm_init_vcpu: kvm_get_vcpu failed (%lu)&quot;,
 +   error_setg_errno(errp, -ret,
 +          &quot;kvm_init_vcpu: kvm_create_vcpu failed (%lu)&quot;,
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">            kvm_arch_vcpu_id(cpu));
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">     goto err;
      }

 -    cpu-&gt;kvm_fd = ret;
 -    cpu-&gt;kvm_state = s;
 -    cpu-&gt;vcpu_dirty = true;
 -    cpu-&gt;dirty_pages = 0;
 -    cpu-&gt;throttle_us_per_full = 0;
 -
      mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
      if (mmap_size &lt; 0) {
     ret = mmap_size;
 diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
 index a25902597b..5558cff0dc 100644
 --- a/accel/kvm/trace-events
 +++ b/accel/kvm/trace-events
 @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) &quot;dev fd %d, type 0x%x, arg %p&quot;
  kvm_failed_reg_get(uint64_t id, const char *msg) &quot;Warning: Unable to retrieve ONEREG %&quot; PRIu64 &quot; from KVM: %s&quot;
  kvm_failed_reg_set(uint64_t id, const char *msg) &quot;Warning: Unable to set ONEREG %&quot; PRIu64 &quot; to KVM: %s&quot;
  kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
 +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
 +kvm_get_vcpu(unsigned long arch_cpu_id) &quot;id: %lu&quot;
 +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
 +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) &quot;index: %d id: %lu&quot;
  kvm_irqchip_commit_routes(void) &quot;&quot;
  kvm_irqchip_add_msi_route(char *name, int vector, int virq) &quot;dev %s vector %d virq %d&quot;
  kvm_irqchip_update_msi_route(int virq) &quot;Updating MSI route virq=%d&quot;
 @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) &quot;%s&quot;
  kvm_dirty_ring_reap(uint64_t count, int64_t t) &quot;reaped %&quot;PRIu64&quot; pages (took %&quot;PRIi64&quot; us)&quot;
  kvm_dirty_ring_reaper_kick(const char *reason) &quot;%s&quot;
  kvm_dirty_ring_flush(int finished) &quot;%d&quot;
 -kvm_destroy_vcpu(void) &quot;&quot;
  kvm_failed_get_vcpu_mmap_size(void) &quot;&quot;
  kvm_cpu_exec(void) &quot;&quot;
  kvm_interrupt_exit_request(void) &quot;&quot;
 diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
 index fad9a7e8ff..2ed928aa71 100644
 --- a/include/sysemu/kvm.h
 +++ b/include/sysemu/kvm.h
 @@ -435,6 +435,22 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
  int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
 &gt;  &gt;  &gt;  &gt;  &gt;       hwaddr *phys_addr);

 +/**
 + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
 + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
 + *
 + * @returns: 0 when success, errno (&lt;0) when failed.
 + */
 +int kvm_create_vcpu(CPUState *cpu);
 +
 +/**
 + * kvm_park_vcpu - Park QEMU KVM vCPU context
 + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
 + *
 + * @returns: none
 + */
 +void kvm_park_vcpu(CPUState *cpu);
 +
  #endif /* NEED_CPU_H */

  void kvm_cpu_synchronize_state(CPUState *cpu);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""> Otherwise, Looks good to me.  Feel free to add
 Reviewed-by: &quot;Vishnu Pajjuri&quot; <a class="moz-txt-link-freetext" href="mailto:vishnu@os.amperecomputing.com">mailto:vishnu@os.amperecomputing.com</a>
 Thanks,
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Thanks.
Salil



</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> -Vishnu
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------Dq8GqpnKmeDU7e0OAIBYpjyX--

