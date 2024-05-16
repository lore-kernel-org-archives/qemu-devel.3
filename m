Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8F7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WKR-00032K-DA; Thu, 16 May 2024 04:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WKQ-00031q-LF
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:19:06 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WKM-0005sw-L8
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:19:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW35+Jz9Hp5ZdU0vT7qcGIv7iIGsKf1EfvluUlVpuDxFwiLH3StBaokLxB1He5iionXpiP/PL9mxePLqasqEBy+Qp0WvR4l9gKnXrbEpF3J0gG5X6ooKSeA9wN/hN4MZx0hsQvKClyR0dTID+J524Y/iUTC3hcA+CWebqecO7vUOGzB78YGy3cqvoc/MxmpPKLXelirLFJQl/OQuWINlu4eOZqYMI/U70PGJlkbsA3TZoqYsBz6fpGHFOQn0TCboJMWfOOwL4gWRykMXUZARYcW+FcfF4kcMpTabBrWZs68ICCAYM/ReNzwkIsSo7FFwJmjnAo6Lv930ok6igxk1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/EQpXvy7Ue+4sbQgeu2s7W2+EOjOJShCsCi5Tyf4cY=;
 b=ThcRS8044hf4gd4Tz6lLW/sCw7URquFggCVhobJmgjH3REiHmT3NO2Y0qEl4qB8b14A6uX6hrGg2bz+r2etSK0GKHGAVi5jv8dZjGC2kSx/GYcDpJg5+ddGm/kxwtPSixy2EgJBT1yNyHIJ4YGWmRv+EXqGTjvjxXdC1lcRQL166N81dnHbZf5Z1iAusctdGqwfJ+UK6gy2mYf/NwX9by+LpMd79bklbIoD2kEeNWAbz9GFd5TOFcEpLbg/ovoSzciP27okCL1xDZH/Op9IN9mNSnNTU2FMEn4tn4b8DDwY39rWqR5Lp/ZSXKa2ZI/2yg9Bi3McR2odRn35fN4i4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/EQpXvy7Ue+4sbQgeu2s7W2+EOjOJShCsCi5Tyf4cY=;
 b=WkXhO4gpNjpFJc9nxLyoZ5k/PXihznBLBYwcS+gzHNg22IclKtpsb83CDcvlTavyG1G75qMP0MA1LKJCaPLSq45g7eS4JeZ6wfWwwjWWoRFUK0Cbf46IIkxl7Q4E9exyaZZT+L1nIy/MjV57tkNkFncOnSxQw/gxJH3ClLeGY4FGGp6tpvZ0dGSHTS949nMQi8zAXpuiWYCkrcSnps5ndcOjoiUG5+qQMV6cRcBF8gj/iFMPsXVikTHC6Cvqq+jWBc7JaGpLSLhBNWaeRK/ChupjIEIhn8SRbgz5LRye4cfNcfjPoJWLASIzwZKLVUvXVBdpWgzYvoaHa2q814Fr/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 08:18:53 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 08:18:53 +0000
Message-ID: <dc729ce1-275e-4889-a7a7-7d945ee310bd@nvidia.com>
Date: Thu, 16 May 2024 11:18:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/migration: Add an Error** argument to
 vfio_migration_set_state()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-5-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240514153130.394307-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: f563ee9c-dcc2-493d-490b-08dc7580d231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXdCWE9meHFkUnZmV0dOVzdqQWZCS3g4ek9idnpkbUw5bzgvNjRyRnVWekxv?=
 =?utf-8?B?VG51UjRyZ1B1MWNxWGF6YUJBajFtZkdpWklCZUdTR0tjemUrc0xXOFZhaVV1?=
 =?utf-8?B?ZVVaS2c5WEJRTkZRVGtQYkFnVFNQUG4wTlc2U1VUTkRzaXRNNjMrVk9pa3F4?=
 =?utf-8?B?YktOSFdaVFdRY2FZWHN3WGFxbnRDanViZGlXUERnNy83bkhqSjRuTHdPcWNl?=
 =?utf-8?B?N2VrTng2RHJXUk9sUlR6cVdWTlJZODZ4cHkwQU9NNmh0QTk2M1hZUXAra1Rr?=
 =?utf-8?B?QkVqU1BTdk9IbEluWGgrWS9xc200Rm85NmJjeVA2bWRxVnhPNS9FVFpGRFhT?=
 =?utf-8?B?Z3laL1J4QWhMZ2lVeTRYQ3VyMmJIZlRWVjgyK2lILytZanc4OFBlNWdkNVpN?=
 =?utf-8?B?Q2Nua05CN2ZZVEEzSmtmUmdGUDNVOFJBMXRrNmVuTUpKRkhHK2psTndUZ1lV?=
 =?utf-8?B?b3V4bHQ0MThiZ0lHV0xWUUhiRFhPblg1T0YxNHpYWXg3Vlkxc3c0SHFFcjE4?=
 =?utf-8?B?VkZkTlJ3Sm55RGFNU2oyWnFaUUpkbi9tV0l0U0RZQ0JxeFFYbVlKeC9ZSEJX?=
 =?utf-8?B?M0Y5dkZsdG9mczU2UG9OWDJDaE9IYjRzaFZWUVhPV3pRYm04RjJnQy9lMmRl?=
 =?utf-8?B?Wk1hUm1Ham1Ld2l1NGFkNmp6Z2NrQVo4OVNQOHBEZFVFUkx2YVg3QUVNRnJE?=
 =?utf-8?B?cytqZlByS1VRM3d3b1oveWZLL1NMbEs3YTNkZFg3ZmhBMlMvNjJmZ29BM3VH?=
 =?utf-8?B?MFY4OTFQTFRybXNOZFVUNG82V2M4bHJmc0NIbXBVUHFyMGNZcFpxL0xLSGRM?=
 =?utf-8?B?dG5HdmQ5ZkdtVFh6djBPbFNhdnpieThjWnJiLzdFbVlUTzJlVkR1WVU4Y3Q1?=
 =?utf-8?B?WU1FaE83SS9hWGlqdTRHZGgzT1VOcmtsL2EyT1dqbU1oVHhXaGladmM3WVRE?=
 =?utf-8?B?Vk9BMjA0QWlUTkRqUVQ1bU1GblQ4VHMwZjcxRU15dWRXZEV2bWRLS1FIYzIx?=
 =?utf-8?B?UnN5MFFFQkJOWTJhUnNIY1ZqTXU1Vm1VV0pHd3JBeGVUSVdmNk9oY1k4TTNU?=
 =?utf-8?B?SFh1OWhYSnVGb3NJWXNrVTBHZkYyL0dUKzd6ajBDWUdKUFpIQWczaGN3VElS?=
 =?utf-8?B?VTkzRThCOC9tZ3RUQ2VoeEFwVWdtNEZpMi96ckxqbUJBcmFaUVAwZGpkNXUr?=
 =?utf-8?B?Wk9DZmJNSi9iek4yS2JQaHd4KzlibGVUdFB2SnJaTHFudVl5Z0pKck9ES2FK?=
 =?utf-8?B?ZUFnenMwZ0Y4TDhIZWZCWnVINVVGR21JRGdpZk8yVEh6czhlbTY5TVRVTUpS?=
 =?utf-8?B?aTJBWERmVGZhV3o0U2FJYllheFd3MHFtbzhaSE5Pbi80RmlCZ0ZrZWNHMHNu?=
 =?utf-8?B?L2pURVJSTXd6VTFoMk1xSTJSMFdobzJEejhxMGZndWxEZFNhYWZ4NFVCU3Jq?=
 =?utf-8?B?Mm5KSFYyK0tkQXN3MzhPb3o5dDQ4YnZSS2twTHRFdGhwVER5YjJQMTQ3cDNX?=
 =?utf-8?B?L2NieERiRWJpdTB6Mlg1d3J3QUhZWHdFMmRpTlAyOFFrMmlCMDVnWERzQU83?=
 =?utf-8?B?NHlmRTMrc0s3R2hrSzNkTGYyd1Z4NWlteThLOUFNb0Y4MUlxM28zVk0wb3Fz?=
 =?utf-8?B?S1ZTSlJ3UTVtVUtGZ2pqV01zbmV5RFRpWk42Y0ZKMXhqQmNKVFdBdFdaeWxw?=
 =?utf-8?B?VVFIRVlMYytNbTFLdDZzKzB6YWxoaUxpcDgwWmNkOGJnU1NhTlVvc09BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpSSFpaSGhCTlRFRStPWjlYMmw1WHNKbjQybUQ2SnFWZ2cvcTh6Y3VndVJt?=
 =?utf-8?B?Q0kvb2dpUE4vUnJzQ0k3M3czWnEwM21ZYzhGYWd3dGZDRm9KeE0yWTIwektM?=
 =?utf-8?B?eWlpSmNCQ29QaXRobUlrZytSMFQycThCOFBhSUI0bHlhYXZ5THMwWnpkcWJt?=
 =?utf-8?B?dHJid2dOTVpLYVBHa0E3Wm4rdFNhMEFGeWRpREZBdTRGRDhPeWt0dnplV3FD?=
 =?utf-8?B?Q1ZGN2N2S3lzZFZ2MjdXK1gzTzdQdEFQMUw2S1NKZXRNZ3dMU0YzOUM5RWE0?=
 =?utf-8?B?eGllc2Q1OEJGUDFidUZZcmR6YVZxWjVHZjZjY3dJTFVuVFRBM1dyVVJuTzJE?=
 =?utf-8?B?V29rY1pZYTVMQ1ExejRrMU10VjRlWk93RVh6MzRNMWk4c0ZUaHgyZ0dBYUlX?=
 =?utf-8?B?aWpnY2Y3UmxyUWtodHh0ek1lQStGVTFBQXdRcmE4L1FKMDl0MFJ3N1ZIcUdz?=
 =?utf-8?B?T0ZVQml3dHVUc0Z4UlQ0UTcxQ29OTDZLUWp4WHhGdFlKR0NmblpiOS9kVkRv?=
 =?utf-8?B?RlR0MndCVUpSQWh5ZDA2MkFkZi9PSG43TkxUUGd1bDBZZHRlZ05yeDlNQ0Jz?=
 =?utf-8?B?eVExQ1d6U1FRektEWmN1WnZ3d0lvNW1Td3J4RkpYTVIyZjc3dFVtajNMYlJM?=
 =?utf-8?B?ekkxbGM5Tk1sVlhFeFBzdkFTWG5GYWNtNVZ5ckdLMThTTHFGa0FiR2xBNWln?=
 =?utf-8?B?YVpUWEdhaUgrSEFiQWloNDNSTE1OZ3N2TThwdnpvL0lwRk1tanJUZzkwK2xD?=
 =?utf-8?B?RktTM05leno5ZjhPWXVSUmkvT1MrUzdQa1R6NDFxQU9mazFKVjNOdVpBZ1dV?=
 =?utf-8?B?TU5hNHVYcmlLdng3eVZFOUhqUCt1ZlRyQTlkUXNJUGJvS3I4M1RmRmozQ1BO?=
 =?utf-8?B?aFZ0U29SSmtxZG1LQStmNjRFVnhZT0YrbUxycHRicTBiQ0dQQ2laRkpKeXBj?=
 =?utf-8?B?OE1WWi80OGdzYWh0OERiUDlWZWRDYUdVbkdqM3p0c1FGV3padE01KzZ0VUtO?=
 =?utf-8?B?R3ZKTW1kbHVORmdscDl4dXJKbTY1NWFtRldpRmVsZWg3NC95TnZtcmdHc1hO?=
 =?utf-8?B?RUFZQUdZUGRKMDZ6bTB1eGhid2lUeS9KOU5qbmRGaU5aTnVMeVdiV0xZb2gr?=
 =?utf-8?B?ZHJ6TjhkVVhBZTZDdnlLRmplVUZxOWZ2MEZsUERjVDlxTU9MTDJwSWZUUFdy?=
 =?utf-8?B?K29GQjIwLzZPcFFTZU9jaXlWSVFOOUJKYVJJWVVnbmoyeVBkbWxLTUJBS1lI?=
 =?utf-8?B?cTJCZzR4dzV5ZDdOa2VxK3VnZFl6Y3ZlUFdLOXFMNnkrcnhnMlRNU0hZckdL?=
 =?utf-8?B?aVhLNmtoVnVJcnM1SkdlY2lVZFNxMVR0Wjhua2c0dms0STVTRTRSd0ltTGFH?=
 =?utf-8?B?bW9mNmZxSDA4V1A1TjVRZ2prSDhDa1pHOWtZOG1RbER2anYzTStjaGR5aUhP?=
 =?utf-8?B?MVJUUFplTEdVR0ZsWlJSbEZ1Qm9yNjhVTGxuekNDa0JQRDBpT3hUSnlKdE8z?=
 =?utf-8?B?ZDVqdGxlcVpDbmJNL1FWeDkzRkRQSGdzdU1pSkhFeTZPWVRML285M3lZY1h0?=
 =?utf-8?B?TnNKR1B1SnJ6K0x0N25uV0o2M1J6Vmx4bit0NE5vakt4S0NVNitXWE5pTDBY?=
 =?utf-8?B?RUhYS3owUlBYODBxWStvb3JDYnM4cXAwaW9UcDNyRWJMQVR3REp0YlhvbjQw?=
 =?utf-8?B?bklkckEvQVBmeGlJRERWbWJrWStvSkFaYlJadWdzWmtmaGFTakNpWXFOVjky?=
 =?utf-8?B?eFNicEgvSHV1OWdhNklYQTRtVEhodnJqWmU1c2V5TWplVkRUQ01uMUgwQXlu?=
 =?utf-8?B?KzN0czBDRWRHcURVL2ZaeGVzNk9TYnNLNkxCU09rUk5WVkxIbUdDUm0wUXcy?=
 =?utf-8?B?TVpYS1lhLzhiY1Fra3pCL2dXNm9YdUVpRkVKdnIvR1lPc0R2Q2Q2RThjZlJF?=
 =?utf-8?B?Qk55aWh6dnJtQkUyZ0dGSnFEUUVyU2tXT2N0am15NTNwVlZKNzFtMFI1OWVM?=
 =?utf-8?B?YjdoS3JneXh1Z1FXa0hoL0ZQYUUwdDdhZnQza1B2bFZnOURGZW1Kd3ZPbk1x?=
 =?utf-8?B?eFJ5b2xoYStlMko5d2JWd3FNNWtMdHIzc2tVNXdod1Axbi9hY0w4UnA5VlJp?=
 =?utf-8?Q?3niUh5kU16o0HLDerfsXViIRQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f563ee9c-dcc2-493d-490b-08dc7580d231
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:18:52.5033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPwZVOQqgALBgGUNsE9N0ZWnwRLrtH1jrUwUPZY3g2yajrCVs8xbIGhA32cs0J7AdscgyRPzhjJgYUws49lGwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 14/05/2024 18:31, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Add an Error** argument to vfio_migration_set_state() and adjust
> callers, including vfio_save_setup(). The error will be propagated up
> to qemu_savevm_state_setup() where the save_setup() handler is
> executed.
>
> Modify vfio_vmstate_change_prepare() and vfio_vmstate_change() to
> store a reported error under the migration stream if a migration is in
> progress.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

With/without Eric's suggestion:
Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Two nits below though (if you respin or want to amend inline).

> ---
>
>   Changes in v6:
>
>   - Commit log improvements (Avihai)
>   - vfio_migration_set_state() : Dropped the error_setg_errno() change
>     when setting device in recover state fails (Avihai)
>   - vfio_migration_state_notifier() : report local error (Avihai)
>
>   Changes in v5:
>
>   - Replaced error_setg() by error_setg_errno() in vfio_migration_set_state()
>   - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
>
>   hw/vfio/migration.c | 77 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 48 insertions(+), 29 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4..bf11135167ebb162dd41415656bdacfa0e1ca550 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -82,7 +82,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>
>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                       enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state)
> +                                    enum vfio_device_mig_state recover_state,
> +                                    Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -102,18 +103,19 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           ret = -errno;
>
>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
> -            error_report("%s: Failed setting device state to %s, err: %s. "
> -                         "Recover state is ERROR. Resetting device",
> -                         vbasedev->name, mig_state_to_str(new_state),
> -                         strerror(errno));
> +            error_setg_errno(errp, errno,
> +                             "%s: Failed setting device state to %s. "
> +                             "Recover state is ERROR. Resetting device",
> +                             vbasedev->name, mig_state_to_str(new_state));
>
>               goto reset_device;
>           }
>
> -        error_report(
> -            "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
> -                     vbasedev->name, mig_state_to_str(new_state),
> -                     strerror(errno), mig_state_to_str(recover_state));
> +        error_setg_errno(errp, errno,
> +                         "%s: Failed setting device state to %s. "
> +                         "Setting device in recover state %s",
> +                         vbasedev->name, mig_state_to_str(new_state),
> +                         mig_state_to_str(recover_state));
>
>           mig_state->device_state = recover_state;
>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> @@ -137,7 +139,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>                * This can happen if the device is asynchronously reset and
>                * terminates a data transfer.
>                */
> -            error_report("%s: data_fd out of sync", vbasedev->name);
> +            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
>               close(mig_state->data_fd);
>
>               return -EBADF;
> @@ -168,10 +170,11 @@ reset_device:
>    */
>   static int
>   vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
> -                                  enum vfio_device_mig_state new_state)
> +                                  enum vfio_device_mig_state new_state,
> +                                  Error **errp)
>   {
>       return vfio_migration_set_state(vbasedev, new_state,
> -                                    VFIO_DEVICE_STATE_ERROR);
> +                                    VFIO_DEVICE_STATE_ERROR, errp);
>   }
>
>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
> @@ -399,10 +402,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
> -                                           VFIO_DEVICE_STATE_RUNNING);
> +                                           VFIO_DEVICE_STATE_RUNNING, errp);
>               if (ret) {
> -                error_setg(errp, "%s: Failed to set new PRE_COPY state",
> -                           vbasedev->name);
>                   return ret;
>               }
>
> @@ -435,13 +436,20 @@ static void vfio_save_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> +    Error *local_err = NULL;
> +    int ret;
>
>       /*
>        * Changing device state from STOP_COPY to STOP can take time. Do it here,
>        * after migration has completed, so it won't increase downtime.
>        */
>       if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
> +        ret = vfio_migration_set_state_or_reset(vbasedev,
> +                                                VFIO_DEVICE_STATE_STOP,
> +                                                &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +        }
>       }
>
>       g_free(migration->data_buffer);
> @@ -549,11 +557,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       VFIODevice *vbasedev = opaque;
>       ssize_t data_size;
>       int ret;
> +    Error *local_err = NULL;
>
>       /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP);
> +                                   VFIO_DEVICE_STATE_STOP, &local_err);
>       if (ret) {
> +        error_report_err(local_err);
>           return ret;
>       }
>
> @@ -591,14 +601,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> -    int ret;
>
> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                   vbasedev->migration->device_state);
> -    if (ret) {
> -        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
> -    }
> -    return ret;
> +    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> +                                    vbasedev->migration->device_state, errp);
>   }
>
>   static int vfio_load_cleanup(void *opaque)
> @@ -714,19 +719,20 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>       int ret;
>
>       new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
>                       VFIO_DEVICE_STATE_PRE_COPY_P2P :
>                       VFIO_DEVICE_STATE_RUNNING_P2P;
>
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
> -        migration_file_set_error(ret, NULL);
> +        migration_file_set_error(ret, local_err);
>       }
>
>       trace_vfio_vmstate_change_prepare(vbasedev->name, running,
> @@ -738,6 +744,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>   {
>       VFIODevice *vbasedev = opaque;
>       enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>       int ret;
>
>       if (running) {
> @@ -750,13 +757,13 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>                   VFIO_DEVICE_STATE_STOP;
>       }
>
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
> -        migration_file_set_error(ret, NULL);
> +        migration_file_set_error(ret, local_err);
>       }
>
>       trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> @@ -769,11 +776,23 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
>       VFIOMigration *migration = container_of(notifier, VFIOMigration,
>                                               migration_state);
>       VFIODevice *vbasedev = migration->vbasedev;
> +    Error *local_err = NULL;
> +    int ret = 0;

Nit: No need to set ret to 0.

>
>       trace_vfio_migration_state_notifier(vbasedev->name, e->type);
>
>       if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        /*
> +         * MigrationNotifyFunc may return an error code and an Error
> +         * object only for MIG_EVENT_PRECOPY_SETUP. Hence, report the
> +         * error locally and ignore the errp argument.
> +         */

Nit: maybe rephrase to the following:

"MigrationNotifyFunc may not return an error code and an Error object 
for MIG_EVENT_PRECOPY_FAILED. Hence ..."

(This way, this comment will not become stale if new MIG_EVENTs that are 
allowed to return error are added)

Thanks.

> +        ret = vfio_migration_set_state_or_reset(vbasedev,
> +                                                VFIO_DEVICE_STATE_RUNNING,
> +                                                &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +        }
>       }
>       return 0;
>   }
> --
> 2.45.0
>

