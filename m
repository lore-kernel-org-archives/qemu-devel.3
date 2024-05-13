Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B15C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VVa-0005Vi-S9; Mon, 13 May 2024 09:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6VVY-0005VK-5d
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:14:24 -0400
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2405::601]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6VVW-00036w-0g
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neFmpxuSLOti9sh92YMXkzupNs3LNBsFLNAZYNSQ6Ffs00oX3wjYiC1JJikcPVZcLQTZVFKm3XfgIs4Y4SL4458wSfCFRhcuRZJOwCe3HMZzkeMtYUK5eAXqRYog3geMutAz6lUGrbTbOOR4TDEMZLNBTjQ94whZ6KNCJtuQ4ucn9hWJa7S3b2h38tB8ZcOJ0eSPDfZl6Y2uOx0FEMIXr53RKPns8fUN0i0amW0BuuCKUsKrOSVL9poLgp3A/vdLwNFRL37lPJnlYctrG9nPXZ37+1+JdSs8plY1jIQ/mqXVXB2HbMR9lxwOXnSEYMt3u+k5YJxL7t7KKdI0yCrGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbvlgKivwUlPTzptQEoGcESSzKqTYYNhmHgAFK7pYpU=;
 b=OB6slrUAs0KcqruHXDuDKggnTxfJsuuuwoWyD6lGizGur/Aps/JSmO3wyZLQXDNvew7PQsPsdTi4o53I2fEAG2afl5av5z9eJEEq2FWGeNCEfFiJo3g+aJ9qiAU+452A++dHvPAJ/AG5CXs7XA9DVLzk+GY38ZpeTs7UoKKP79W/I5cLCSa6o+8iPdFKrkOFgtsCaDUom8eLl5UwUP9BwWo5aFsdDyMuZxiaCj8D00rDAdVjvLny4zU3Nz7MMSkiZ1T5mHCkAwc0bsU9ojt0x748Q70O0QY4HdamRB6KNYUyG0pqGWUVERZMwJF5F20g5B5iXawlXa6dcfrj7B1Jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbvlgKivwUlPTzptQEoGcESSzKqTYYNhmHgAFK7pYpU=;
 b=aVLFFRmeRC9KTFtnJb5GKpMDQKHBLqkpho+oI10fQjGCgPTaWkkgO7kDIC5eePIW3Jqcp7FFlG5DnCiD0pjwgv0CcE95HJcFApDEYU0P7erMTTAe6NV/yQ5yTK459i2EumaotJ4eOX08kYqc71mahC2WpLpNofd420oI4YFo/pX14I7415wrWiKL/Sf8FJvqZzyMM6AAfy+PZB+kNrn77T7Nu/2gM80maVENMJwAK0BCHM/7QZtakIKof1axfiiQY3Buw2GXiMnGyo2vN/QbJXrZPlq0nhmKsVDCHXLfPUnkU3V5qSt1AsSTpTsh4SHqkh1b78Mh6u96quWlC3DZhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:14:13 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:14:13 +0000
Message-ID: <ddce202a-9d98-460d-acd8-e89aeaf61b6f@nvidia.com>
Date: Mon, 13 May 2024 16:14:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] vfio: Extend migration_file_set_error() with
 Error** argument
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-4-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: fca2be0c-bed5-440a-803a-08dc734e94f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDc2dUxpTzhOUHY5L2JVS0s3OEVhdGdTNHY2NjkwekMyVWttYU5scEhFNWlI?=
 =?utf-8?B?SEwyT3llc0hON0srN0NGdWZaUDl2TXB1WDdFM1BydkRseng1SjZScWJEL2RO?=
 =?utf-8?B?eWZXK3ZkWm1INWRBVnlvVitwNHNHY3Z1eXJWTDI0b3BxZXBQNkFpdU94YXgx?=
 =?utf-8?B?OGtia3VYK05melNBWmV2S3VOTU5TeGxhcXJNZi9vZjU2dm52NHowT1BTRkI5?=
 =?utf-8?B?UW1FTlJRclMyU1pFZVNFcVFvTXRDMUY5K3MxVHFVeGVBaXhTbWRQNmcwN2hN?=
 =?utf-8?B?SUpWems4NEgrUXhTRWtkZHpMaW1yNWUxRGRudDlsOFlIZkZ4akd4ZHJlS2lG?=
 =?utf-8?B?b1BUOSs1S2hHQ29QaHI2M2J6RXVPK2o3OWI5RXA3dlFHUWNaa2J2RXZQelBC?=
 =?utf-8?B?Q0F0MXZ6Mmp2RjFNZGx4eTl3cUR6TjVQNm40UUZiSjRkV1k4d2poUXlxcWVS?=
 =?utf-8?B?aXMvdlEwaUdzdjZxamJjTSs0VkpxN2t0N2s5enB6WXBVMThIb1lpZzIvZHpH?=
 =?utf-8?B?R0ZTZ2owSHM1OUJQOVRUekJvNlVNblBHcURhYXQ5b3FrWW5NV29IeWdsRURl?=
 =?utf-8?B?VFhicEJsSlVyMHMwamcyVWx6RmwxdGZ3N1B2dDFUY2dlZkR3Y20xUkxXdXU3?=
 =?utf-8?B?Rkt4NmtpN1JLZzYzckcxMFlGS2NwRnAzN1N0dFJOUEdqMEJnMGc2UWxsMkFW?=
 =?utf-8?B?WVoyZmkvTk9WRThIUG4vZjh1MTE1NHBZaHc0c0FLSmUybHRUcXhvOVgxUmtz?=
 =?utf-8?B?OW1RMVh1bGpzc2tmSnQzcjZPbDlrTG5mNVU0di9XYlcxS1ZVd2wvSzVOSmJm?=
 =?utf-8?B?VDhudzBtM1VjNk1BZXN3bFNEODdEQkFvNUVlQ0VYOGlyUUt2VEU1K2NvdE9N?=
 =?utf-8?B?MUtXL0srdVJPNVo0Nk5JUlBhdmlPNUhIY0RIKys2dnFtejdaVDdoS2lRYzIz?=
 =?utf-8?B?VnBPdTB5WmgrK3FHMm9aYlZlMDVUaGI4NklCaFplTWhERkJlK1A3RmhuOFl0?=
 =?utf-8?B?ZVMrcU1vcVFyNW5TNTBOZUkxNGJkNmMwNFJMVXFzS2lTY0pmRWovWDhGWmNh?=
 =?utf-8?B?bVhrdlkyRUEzRDZWTE13MGdScmJaRjg2WW4rdFNMYjJJREFoYTdNdStDVG8r?=
 =?utf-8?B?NWdiT0lXbTdibSszOTlScFQ2WWxPOGJ1TkdoYlA1R1RyVUtIeVluN3JjVEJ5?=
 =?utf-8?B?UVRIWmt6RGhCNkZWZWtwK0tyYnljMUpnbUJJb0pkRmk4RDh2c0N0MGF6Y1V2?=
 =?utf-8?B?S25yN3hjUmVuNzQ2emhHTGd3TDl5eXF1VlY3SStVb25VeEhGMzdUT2lRZ0ZR?=
 =?utf-8?B?ZWlIMEFqQVY5bGZkWEhXbnlITHlLdmJueVl1ZE9qZEk5UFpvOHZKdDNmSmVu?=
 =?utf-8?B?MFl5SjdjWHNoQjFxN1pYZVE4TmpGa3pXMm5lc0tVL3laRmJvTTRNbFFSeGZ0?=
 =?utf-8?B?YXNIZmxoNm1SZG1SMWdwTkJOU2tUZG5MbktreE81ekQxMy95R2dJLzA4TVdu?=
 =?utf-8?B?U3JDZm1pZ2VjV1RwOW4wYnhKanNrQncyY0dSQ0pLZzlvdkJkWjk3cXFTT3JB?=
 =?utf-8?B?VDdvSTRWV3hROFR0S2xWN0NzbEpGejRqRlhTc1VuWFZhQVRldi9WMTg1RjVX?=
 =?utf-8?B?enBKRDRyTU5qakVmTnZlQXZNeS9abU8wemphMXc0ZCtkUkFDc2g2ZXEwaEZj?=
 =?utf-8?B?enB1YUdxY2dJbi9nVnpNdThBQ3AwdFpubGQrMk5OUlV6RmRpWU1xTG5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW42VjFtV0swNllnalNJVUQxTFV1QmZQUHpzeGlta2pIZVRNZmdJSlkxRWY0?=
 =?utf-8?B?RDZVQ09Cb2tmOWo5M3RicGV3Zmtyc3kreVdmb25QNXllZ01FbEdudUJ6dEI4?=
 =?utf-8?B?TlhoWUZHQm13N1dXSXZWZUFKYlpYeHR6ZFh1ZFc4MGhOc1ZBSDc4ek85a3pt?=
 =?utf-8?B?TUo2TWhlOVIxelVQak1obzVSWXFaOGZ4REFSMWxrcDhoa3grSnhOOUVHck55?=
 =?utf-8?B?U0h2cmkxQUdkdHBpNmVlSkEweGI2cUJzanpudTNTb0szWnJzcG1YbEJFbHpD?=
 =?utf-8?B?K0RMRFptOHFhSk5jcS9nWkI2YUR1eHU2b1EzanRKL1M5YW1IMEVwMk1QZWpu?=
 =?utf-8?B?WDI4dHBTMmpmUlYxQXRrZ1Z6WDFhQ2tueXJ0N0sxMXl3VDNpRnVoM3BvQnhT?=
 =?utf-8?B?Um1QbDVSaWpDVWxoMTRvbzdpRVRHMnkzZ3RPbk11RXc1S0RhYWx4b1VqdDJZ?=
 =?utf-8?B?MUJDbm9DY251d09jMTVMeW5SZi9RYWozN1d6NmtteCtmTmx0STVraFRYUGQ2?=
 =?utf-8?B?a0c2Mlg2bTZWNHQrM2xvTEpwbFZQSmNjNzQ3VWMrM1JLWUJRUEliMGF5Z25m?=
 =?utf-8?B?Q1NHZ2xiTXZWUGVBeXVvdzhkeHRLT3VYdGJZN0pwOGhSR0FvTWpZdGNhMktN?=
 =?utf-8?B?eXlKYUVDd1hvMTk1d1h6Nzd6MWJ6Vit4ZXh2eW5uOFdjTmIzU3BXL3lGWkpj?=
 =?utf-8?B?WTVjUHRTWEN2MjZiNDhBNUt2NkFyNzZjckRsZzNrZzF5UlFOaGNqdjkyRWZx?=
 =?utf-8?B?ZDdGd2l5bVl2NGJmMDlIcStVbFFkQlNIekpUOWNSbG1sZXdNUGpSVGU2WGZV?=
 =?utf-8?B?WnMrM001Rlp5UW5OckhtaDBxS0hNcVVTcldFa2Vud1p2N3NHS2ZPcDhCdnFw?=
 =?utf-8?B?cVgxWjZ3NnNJeTdJYzdDaEtYaklaWDBBbnRMOUdNUmFSU2hVZ1VNL2JZMkxN?=
 =?utf-8?B?KzgvNUxCMHBFbnhwdDFERkVQMTk3ZFR2WjAzMXZ3UCs2dUtQWGpZYzlwYlZS?=
 =?utf-8?B?TEgrMlJOTjNiSlM2dmx4cG42bzFJbUppLzk2S25oUmg3b1k4KyszNEZ5ZHl1?=
 =?utf-8?B?ZVFFeHNDb2QxMFZlV3M0V3RBZHU2UUt0dExWY3I3UCtseHdhemhGL1E1RXFX?=
 =?utf-8?B?YnZRQm9DZisxSkphME5oWHArNzAxTEI3cW5pdnVyMGt2UmUvUzk2MDFyZ0hH?=
 =?utf-8?B?QUlyUVdJa0lxL21QcmU4cFBpN0xrdWdIcTh2aXZpVEpyanhONjh1Uk5uMjBL?=
 =?utf-8?B?R0xEOXk4V3VSTHU2RXpENmhQaENUeDFrRUUvRGJqR2ZOai9xdHdObUNqRklQ?=
 =?utf-8?B?elB3cDZkTCtldGFIZzQvVzJkVm91clRnOEFVU3hZTHo3dTRVL1V0b3lXQzlQ?=
 =?utf-8?B?ckp6OUpoRXEzSzg4a2N5NC9ZQTNySmNwa2Z3WEppcUNVeSt5RUliZEhBVmhB?=
 =?utf-8?B?NFU1dzNDRFJGcUNLZlpTaG1vdGVQUlJuUnl4VlZPYVBLQW1IOHpOenA0bXZx?=
 =?utf-8?B?SVRHc1FJVjFKYW1sb2ovNUo1NzJmUmNRSVFoQWJydGVrSFVQR1VQcml6cU9B?=
 =?utf-8?B?UEhvZHdHNmxSZEx1ZFZoeE93RUxySnEzVVFKYXV6T09DdEJobWNpSFZ6eGNr?=
 =?utf-8?B?TzFtMTVLV1FYSk9jN1hrVk5Jb0RGeEJ1VmU2TmxKc05kNXE4NVhJeC9FZmgv?=
 =?utf-8?B?NVlnN1V1TGFBM0lEUHozVE9NYWQ3bXYrWG82MTZjUDc0Q3hlMldMSjhIUDdG?=
 =?utf-8?B?MWNveHp4U0xOZ3FUcHYwbmNRM3dWQ1hWTHRHK1NFbVc5QXo5eGIvS2x1TU04?=
 =?utf-8?B?MG1OWkFqZ2N6V0UwRkU0RU0ybHJNRFJ3YUJSVWE1aHE2SHlQOUY5UTAyTmhY?=
 =?utf-8?B?ak9HdC9IbDZJcG1SSUtaSHdWQTN6NlJ4ZU0wUXhaUEN2ZENPckVUZFgwZXJw?=
 =?utf-8?B?Q1ZtREtSU2o2WDllUEZESTZkQkpMUE43Ry9ZWTBDVHJXM0s2eWNHMkZDak0y?=
 =?utf-8?B?di92Z2xIYkNaZk9tM01lLy9CTmViTTk0emFINzFMOGx0WmJtT0FhamhkTk9B?=
 =?utf-8?B?LzJhSFJxbVFEdG1namZhd1c1R3VGd1ZkVndnbDQrcWp0OTZQT2ZqRFlKVEQr?=
 =?utf-8?Q?3Og/PTSr/1ZNmPfGHuRWN8qYy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca2be0c-bed5-440a-803a-08dc734e94f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:14:13.0393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tp98hnJMn34PiB6wdZem8M+2M2TdZpWflpTX5CJ3KMbB2rVE+DhogHpNrSjmeyZpGaiN2TBCpwz2keL3xRn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
Received-SPF: softfail client-ip=2a01:111:f403:2405::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments

Change commit title:

vfio: Extend migration_file_set_error() with Error** argument

to:

migration: Extend migration_file_set_error() with Error* argument

?

Other than that,
Reviewed-by: Avihai Horon <avihaih@nvidia.com>

>
> Use it to update the current error of the migration stream if
> available and if not, simply print out the error. Next changes will
> update with an error to report.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/migration/misc.h | 2 +-
>   hw/vfio/common.c         | 2 +-
>   hw/vfio/migration.c      | 4 ++--
>   migration/migration.c    | 6 ++++--
>   4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index c9e200f4eb8f8a8ab2c8b8d0e0dbf871817b94fc..8da2f6454d82046c449f034eb978e1247a9be682 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -103,7 +103,7 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
>
>   void migration_remove_notifier(NotifierWithReturn *notify);
>   bool migration_is_running(void);
> -void migration_file_set_error(int err);
> +void migration_file_set_error(int ret, Error *err);
>
>   /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>   bool migration_in_incoming_postcopy(void);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b5102f54a6474a50c6366e8fbce23812d55e384e..ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -150,7 +150,7 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>   static void vfio_set_migration_error(int err)
>   {
>       if (migration_is_setup_or_active()) {
> -        migration_file_set_error(err);
> +        migration_file_set_error(err, NULL);
>       }
>   }
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 06ae40969b6c19037e190008e14f28be646278cd..bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -726,7 +726,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
> -        migration_file_set_error(ret);
> +        migration_file_set_error(ret, NULL);
>       }
>
>       trace_vfio_vmstate_change_prepare(vbasedev->name, running,
> @@ -756,7 +756,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
> -        migration_file_set_error(ret);
> +        migration_file_set_error(ret, NULL);
>       }
>
>       trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> diff --git a/migration/migration.c b/migration/migration.c
> index b5af6b5105d58f358f6d4d31694e21debd8eb81d..9c648f5ba1c0104088e37baf90d9f94fbdc21570 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3033,13 +3033,15 @@ static MigThrError postcopy_pause(MigrationState *s)
>       }
>   }
>
> -void migration_file_set_error(int err)
> +void migration_file_set_error(int ret, Error *err)
>   {
>       MigrationState *s = current_migration;
>
>       WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>           if (s->to_dst_file) {
> -            qemu_file_set_error(s->to_dst_file, err);
> +            qemu_file_set_error_obj(s->to_dst_file, ret, err);
> +        } else if (err) {
> +            error_report_err(err);
>           }
>       }
>   }
> --
> 2.45.0
>

