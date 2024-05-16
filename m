Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD152C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WNc-0006C0-NB; Thu, 16 May 2024 04:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WNb-0006AZ-0L
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:22:23 -0400
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WNY-00088q-RB
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2O+Mp0NHUiqitGwD5VUzRfoHBZoGPiGuTyP/tiNuZSyyYlPXLBNaRh/ijFmPnTlxxg8zK2HiQyOQOntiae+D9FwqjwHejaf21mlF7UkO80GPc13zOH+BE8lj4y4uHMYVBaf0tebPgIfOaj6CqTfWueyjCc1uBNcr9Q6WxK77wkB0JTrU6zCKp2l1BukXatnaMlxHZR7T+3x4xvcPK482EyBSAHWd5QeaPIg12a0ugt7MZsIGU6TaYP4x34vCNnATXSsd0XRmbgEMkkVewV9s8wYRmwtW+6zx+YSzkDNNDHHBgrsQCg1Dq91xC6oALk9Ug4B8I4GuUTE27Nn+mCHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWjLTpEj57kbPcIVAcPiWJr85+YVbHrmEk7RzAsSiqQ=;
 b=LoTWSdVtlcdEcPqrcR9uGQzgLdZ95KIo7FItKwMI8UwjoQ6HI8vy1F/sAzOvMuxGeuStC+hF/S+yizdVwVTZQUnXYo8qspvjXFbWxNs1BtmWR7JY7XSSL/VkxJCMVotHGDUc/uYH+DbEZK//jcEup4kyKKTTVQRcKTZEa404KXuUcQZM14ugoHmgrJNjdQT+9B24T2O+5BFs4WlUkBowJZmoNeJuKWOvX+pr4o0WYAMoNXXT9DJTKL72wbFMSSskWZRMdWtJMoI3xjFNbYxvcjyk9+oJf7aBwq9eCWnjVejM/iE3dQCh63gfldSV9e/Z77ei/ChjlWbPhS+w2K8Zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWjLTpEj57kbPcIVAcPiWJr85+YVbHrmEk7RzAsSiqQ=;
 b=VcBYvYr7CoZOJHBo/5KpTUfTrfDZfOqL74VMou6EnAlZFRFNNYsdyPx4QK1/SYP20oenMPYJMOsFcRJJfYkS3p9/eGHrwThvF/G2J+F0lHVYaNFqvMVSROdgko90q9YsYjlKWgD422teXGO+E6w7FohREi2IWqBLh0NbSvtLdu5zpc//S4EjzPu/1+81ysAKkf9ASwEnPWwuER2aKUw6vttg8OdAQhpL0N3hy4fXrx/XH6qdUdMp5ppY5D/KZyM/IvauTZgksHN/av9+0kDU9R1t262xVtYF8rI0MkggtvCTLDyBJlX79OjZ7Bf2SVH0cmdn9+ceTFWXlPNG730RIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 08:22:15 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 08:22:15 +0000
Message-ID: <ecda1834-2d37-409c-ba96-480a79039660@nvidia.com>
Date: Thu, 16 May 2024 11:22:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] vfio/migration: Add Error** argument to
 .vfio_save_config() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-6-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240514153130.394307-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 11532760-4672-452d-34e1-08dc75814b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFNDamdhcU9DZ3U5ZW5vR00xOHlyWGZreGNZTkxrQWs0VG5ITGd3aVptNU53?=
 =?utf-8?B?elhQNHlCUk4yU0E4ZHJYMXYrREs1RWdiRDRNcEZ1NVRVZGp1TFNRdVAvUmxa?=
 =?utf-8?B?UnVGVllFTmM3U09UbklEaEs4Zm5WUktDVGxMWjB0aEtJa1U2SGR1V0lPdGlr?=
 =?utf-8?B?MjhEYlNOT0owcFR4U0RBUGNyN2o1Y293anRrRm9QR0Zud3JXY3RUYmJIYzA4?=
 =?utf-8?B?V1FqZ0N4aFJNZllZWGxrU1hsa1VySTJkR2kzL0ZSQ1JLK0pkQ3FqKy9LVVEv?=
 =?utf-8?B?SUpZbEdJajNEdk1qWnRaaUR6U2ZNYzdkTmd4ZHBIdWZxM1o2RktKWGEyNEdE?=
 =?utf-8?B?UDFmSzEvRGhraG5FWTBoMWhYL3BkZVpTZXJvVTNoMjZCbWF2cWdYSU9LQTIw?=
 =?utf-8?B?K01OWE56eUYwR25zSFlYVFVneTU5aUNHVnVYQ3BLT0s0cnB6L1F1MjdoL25w?=
 =?utf-8?B?c2VWMmRJdDRMUlduWFcvaG5Xd05TS0FGN0lCTExOZlU2VS9ER1RrVE1WUmpl?=
 =?utf-8?B?MHVtZUllSGlMSTRHOHovLzdPOStMaEYyZ2RUSks0b3lSVTYrTkF0bVFLbWhW?=
 =?utf-8?B?blZTc0k1SmNLUko3TkpBNG91UmRWV2UxV2ZzYUNOeXNpUlM3Y0RiTEYxR3Fp?=
 =?utf-8?B?RE05RndmbnVBOTRXdkNoQ1ZVajRnVVU1VjFrQTBwNTJBMzR6ejI4clhRTTJu?=
 =?utf-8?B?cHZPVGh2VVRSa3NZUmpoZTc4ditnWHJRN0ZiTkpTWFEyOGJyY2JyMnQ5Mmpv?=
 =?utf-8?B?VmQ3ZUNwY25hMUNvQkFsT24yL0xYSE11MElLeGxoQlNRa2JiY0dmd1BwRUlU?=
 =?utf-8?B?UVpheEk4VE9md2hrdmlSOWw3WStrTDllUlVVQTFHNUJxMzRhWFVZR2o5R204?=
 =?utf-8?B?L3hIcnZiUWtINVRsWTFEVVE0QXRyRHdpTTFoRmtaQTc3eVJFK2ZzWUlGMG5Y?=
 =?utf-8?B?dzNySmFvcGJ6dTBwTG1YaHhFS0RQQUtpb2o5QkZkSTlvL3FSWTBDcXcxQjJx?=
 =?utf-8?B?MkJReVRKWXArSHI2YjFZeHR5WjhUck84YUhvRnRmY1MxTFlkQnV3RHB0NExi?=
 =?utf-8?B?dVA5YnQ4aWhkZ2tiVWNyeHE1N3c2d0FselUyN1ZJV3dZYVoyYU85eU5xMGgv?=
 =?utf-8?B?dU9PUU42OWFzR3A3NTRrMFJLby9IS0lzNnRxZW45amNoYkU0VmFCNWNWc3pi?=
 =?utf-8?B?NXdEclE5TzJ5MXJsQWk0cEdLQVlmaWJDcTNxMCt2eWF5UlVZaklIT3JZRzVK?=
 =?utf-8?B?OW81SkVOcklIWEoxL3RjZVBIUzZiemhjeC82VXJIeExSZWVhOC9tYWV2bFlS?=
 =?utf-8?B?TTl6S3h3dFpPbzhsR3FVaXEvTEdmSWQycExmdzVjYmdXQ3htQ1dqbFRlSi9r?=
 =?utf-8?B?eTNSaGo2SHBhVTFFazV2aDJSNUR6MUE5SHRmRit1ZE0ycVBuZUdUM1l0WlpF?=
 =?utf-8?B?bU9WOWY0b0xsRXEvL0FITGRRTExmcTFkVjdMUGRBUUNSanZsRG5Cb0JMM09L?=
 =?utf-8?B?YWVZV0c0UnV3VHNaNDdlUTZ2eUMwNjBOR050Rnh6RXZMdjFWeEorZHQzVUJy?=
 =?utf-8?B?a2docVlFVlF1L2k3andvTWNFVGZjQXZPY0JkOVBlT0ROZEk4Zkx0WFFmNXFk?=
 =?utf-8?B?MXVhcWJjMGJxN0FLZjRtZ3RkOXA2WVZiSzRkYTBKK0JtS2lacG0vZUwrN05Y?=
 =?utf-8?B?S0puc0VCU281bkFZR2IxeDY4dHRlRnFpTWxsaUFkRVdTZkJ2YWFaeEdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V281WjM4cGhpS2JQdE1sVnl1Zkp4ZXRKTmhLZmhzWi92VFg5NEs0WUNob0kx?=
 =?utf-8?B?L1l0aFlBa0VLelZTWGovVFhTU0VBc0MxUC9qcEw4bnlpQWU1NUdwYkJoblZP?=
 =?utf-8?B?M2ZvZVduKzFnZDhlVlp2bVpIRGUrNnFRdWNQRDlNWUloMDRleHhwTmlsSzVp?=
 =?utf-8?B?dFNVcUlsYk9VTC9sUTY0RUpqR2lhcnBtK29qTHZ6MUkrS0tVQlY0alhCNkdO?=
 =?utf-8?B?M3NMWmdGREVwclI0QkgrMEpENFhEUG0yRjVxbjRBSWptZ0RXV2pvK2QwMGZ2?=
 =?utf-8?B?emtFRHFTc2p1NkQ3aC9WemNDUFArSlNscXMvaU9XY2ZwZ3REV0hoSFlsVGdS?=
 =?utf-8?B?bVFnSlRkcUJCcDRlVDVYLzRiZmFqN2lyM1c0eVJHcmFXSzlsV01ML0NpTm9O?=
 =?utf-8?B?Q0UxNGQ0dk9oQW9Qa2Y2NXJJaE1FRGJtUWpGNGoxSmdoczhTdkZ1dmM5MVUv?=
 =?utf-8?B?QzZ5VWFPU0ZFNHdhQWI4V2tkbU40Q1p6ZG9wU3gwSVJNdXFzNUJzdUM5TGZu?=
 =?utf-8?B?bEprWDZYVGh0akwwclZhL01kZGgwVDY1WUM1OGdZd3B6VkRQT2VjWTA1eDha?=
 =?utf-8?B?LzY4amlYa1lreE5mdnJnYzVsRXhMOGwrMWU2dHd4bHVaaHFMTG01NXJDUmtm?=
 =?utf-8?B?WTNpR3JYMDVSV1dkV0ZORWJDei9VYU1ROWlNZGtTWVFFdDhXVkd0R2h5TXdG?=
 =?utf-8?B?azlEYXFtbTNNczhBMG1OVmF1WXZ2a1lPa045cC9KZ25oYXpHZEc3ckJYTnJF?=
 =?utf-8?B?SVlCT3JEejFkVSsyWGZwYmRiZVVraGduOEpVUFl5eFExYWhQWjNLL3lnSnBI?=
 =?utf-8?B?RmtWaDZjbnJKK2FRQUtUTmtKaE1IVk45cWdSc3hIS1FEYTN0K3FTalNhK0NO?=
 =?utf-8?B?d2FjZVJtY1cweHkxVXQ3eE5xUmw4Vmp6RWpvUHBkNFE5NnNCam9sS2RIandW?=
 =?utf-8?B?SUxzaUIvYlErR0E1ZGdON0psTWVVRGdTS0FGcGg4N3o2TDYvOXoySVVERmUz?=
 =?utf-8?B?Z002MnlFTVFCa0ZiM01RcDJHSjRqWWRzTHlnckQwVXVIUWZpblE4ZnpqQjdy?=
 =?utf-8?B?TDk5L0Nrbm9wMnF6N2cvdG53bTFwSjZSUXNQY1hSaTVBdk12MDRzOSsxNURt?=
 =?utf-8?B?UWw0WHRFR0dLazZ4aWVURzlGbzlXUExVZm0vTFN3cHcrdnUxSkgzQkNMaWo1?=
 =?utf-8?B?cWtKcUFYcWZHWnJzVnNWWjFTbEVpbW9oMGRnY0pXK3lUTVBUSExzZlJMZmU2?=
 =?utf-8?B?RWl2cnQ3bVJQOVB4T3ppNEZ3SnEvTXhRamdoRkdjWUR5MENxUlM3WVlDY0x6?=
 =?utf-8?B?bTlRQjdQbVlPRWVVY21FWmdFZEJtUUJLZ0Y0M25HdEs0OGFjUW1mKzhwY00x?=
 =?utf-8?B?aTJmVDNtam9kQkZBby9yUFNoT3lJVmRZQTZzUktlODFoRWZGZFRrY1RLRkJU?=
 =?utf-8?B?Nmo3NkJ2MjRYUDN0YVdqUmkrcEZSMGl1WDBYRFBRaDJVVGlGMWl6RFlFN3Rz?=
 =?utf-8?B?T05iTG0raFhLWXB2a0pGL0tMNy9nemtQWE1HWFBwc0dnbFRvY081bGxWYk9M?=
 =?utf-8?B?S3pMMEJVaUtYSlRJNVFIdDVXSXhKN2R2MmxyODZtRWZTanBob3BVV1N0aEY4?=
 =?utf-8?B?bEM1Z0p6ak5HcXU4NzJKaFhESkNZSVQzd244U3NhV2tRN2VDSUp3REp1RlR4?=
 =?utf-8?B?dENycm1WcFc0ZVRVakhYVlMzbVFVQjVQTDJtdkVrZXBHZW1TZndCMGhyVWk3?=
 =?utf-8?B?ODdSZlhoMEVsalFFSlptYjNSWmpGNzZORTZ6bHJ5ODdUVGFja2xJN2VPb00x?=
 =?utf-8?B?ZjRXZkVabFhWUk8xd0Jia3M0Mko3c0tZdlgyNFZjR3ZodmprSWZRZUEwekN6?=
 =?utf-8?B?MWVJSmlnZDY1WDQvcWpoYTBWclI2RVEybnovckNMZ2Q4QnMzelhXbXlhN3Z5?=
 =?utf-8?B?ZmcxbWhuZUUyOEhSQ2FqN0xqYk0xbVJZVnhLdS9lNTJpRVZsN2t0MTJlRzMr?=
 =?utf-8?B?L1lWQWFQa3JDRC9xVmx5YnV4RTN4VTVCeEppVEtmbTVOdmNmYnpJNjA2SFRy?=
 =?utf-8?B?Q0tiNkJxVXMzeWw5VjlFWStjZml2Wk4zdUpJb3l0M1doSjhIdEZtV3Z4V2JG?=
 =?utf-8?Q?26UGiXbpQgBKAPv2hVyyRWol8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11532760-4672-452d-34e1-08dc75814b26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:22:15.4005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUDOR4qZhwhKoVsCjZbBLO/WtKvFrZWg1jR7hfy9Ku8jk73ZJTGKh586e6e888ON2kg+1pk66wcxuyhdrmSbag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
Received-SPF: softfail client-ip=2a01:111:f403:240a::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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
> Use vmstate_save_state_with_err() to improve error reporting in the
> callers and store a reported error under the migration stream. Add
> documentation while at it.
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

> ---
>
>   Changes in v6:
>
>   - Modified title (Avihai)
>   - vfio_save_device_config_state() : Set errp if the migration stream
>     is in error (Avihai)
>   - vfio_save_state() : Changed error prefix  (Avihai)
>
>   include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
>   hw/vfio/migration.c           | 25 ++++++++++++++++++-------
>   hw/vfio/pci.c                 |  5 +++--
>   3 files changed, 45 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,7 +133,30 @@ struct VFIODeviceOps {
>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>       void (*vfio_eoi)(VFIODevice *vdev);
>       Object *(*vfio_get_object)(VFIODevice *vdev);
> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +
> +    /**
> +     * @vfio_save_config
> +     *
> +     * Save device config state
> +     *
> +     * @vdev: #VFIODevice for which to save the config
> +     * @f: #QEMUFile where to send the data
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
> +
> +    /**
> +     * @vfio_load_config
> +     *
> +     * Load device config state
> +     *
> +     * @vdev: #VFIODevice for which to load the config
> +     * @f: #QEMUFile where to get the data
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>   };
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bf11135167ebb162dd41415656bdacfa0e1ca550..d089fa9b937e725307c1a56755495d5b8fae2065 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -189,21 +189,30 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> +                                         Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> +    int ret;
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>
>       if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> -        vbasedev->ops->vfio_save_config(vbasedev, f);
> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
> +        if (ret) {
> +            return ret;
> +        }
>       }
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>
>       trace_vfio_save_device_config_state(vbasedev->name);
>
> -    return qemu_file_get_error(f);
> +    ret = qemu_file_get_error(f);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to save state");
> +    }
> +    return ret;
>   }
>
>   static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> @@ -588,13 +597,15 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   static void vfio_save_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    Error *local_err = NULL;
>       int ret;
>
> -    ret = vfio_save_device_config_state(f, opaque);
> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
> -        error_report("%s: Failed to save device config space",
> -                     vbasedev->name);
> -        qemu_file_set_error(f, ret);
> +        error_prepend(&local_err,
> +                      "vfio: Failed to save device config space of %s - ",
> +                      vbasedev->name);
> +        qemu_file_set_error_obj(f, ret, local_err);
>       }
>   }
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b793345c8e8996fe6b7987059ce831c11..fc6e54e871508bb0e2a3ac9079a195c086531f21 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2586,11 +2586,12 @@ static const VMStateDescription vmstate_vfio_pci_config = {
>       }
>   };
>
> -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>
> -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
> +                                       errp);
>   }
>
>   static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> --
> 2.45.0
>

