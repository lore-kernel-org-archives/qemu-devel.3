Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89234E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNUG0-0008FD-Ax; Tue, 17 Dec 2024 04:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNUFl-0008Eb-Iu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:52:35 -0500
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com
 ([40.107.244.43] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNUFj-0007ss-CY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:52:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXSbUxXn5/r33a0dbedfz+lYEKipJlVPyN+wBle3bSZcogS9NiHa0WwKe/dxox7oTmeEOVaJzBs28lQAp/CzZ8brSs5MqGpTQPAW2adjmV31+kgHXEBg3OMFrgMS9TO6OfaD/bLh1RMYPAp6zgq69YCuAVTKvxN5ZPrdG4h0ushxTZlCvUAXfcyzJtdiq46N9qRTivhMS0SV8pZdtsSUHjf18iPZmyqpChIY2nQnYvZO/G2YCkru0q1mldI0qc4FSNrv0p1bTrrtACH3FYYuKaftQHdsq9uwDbNIa2XfPu9eXhwa/UW6QJd/q3LVL9qDh/msrhXIn23y3ivdZNO7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhJ+spN8Q5Nm9es2/S/fU0jzlHpGNIIH+9VF5Bu7lsQ=;
 b=pNKRzjs1b4Ty7Gjk4rwpcXq99s6SCNQfP5dtgOZgp4x7ZVvONjyRMLKCgYn1kBmA+BukttEoN072VV/LxccYoXBDminJlnHGHDCNqfRVp+ldbGE3sxOjV/pNADE9U7qljasgtXXw/9Y3uGgrohxvRoxfjkOyeb3HkBffHsTa3pAZfqUr9jbLGXMHWrQ9KYkdukMuoW5t6JMvkVmQ4x5wVIG295gP6OMGz6/HibRy+mdoSlWjOH58zbGNGbjxodtxnB46jD4s+LAqQXFmnzgJf/71MS33ZILAMsWITrtcUQZyHafaMQiIGB5xWlZJQ9hLzbxpKiFFjqB8foNm5eFC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhJ+spN8Q5Nm9es2/S/fU0jzlHpGNIIH+9VF5Bu7lsQ=;
 b=BTyhQLXtivl+aicb3QujytcOG6T8vD1FO888enDb7whqEtjsp/FeXjr0yqu7z/rI/Kt91da/37X2RkJsOq+Uh9uYS1eSOqRJ8RkApEOtPIi7+5PvLAoSQ3vqAhaX9+O+LAtuzZ9Ch9qzGKOi6at/4mZI6nQXqZ/ATzCNuVH04AhsMcFnm48hPKg7RcKUThc5/VE5qxBQkcyw0TUXCIulCz4FCj++G5XyPziGlNoEujivLqvzutWz5tMDdR/crIZAhqm6IwUf9lgzO1uhAOOBxqTryI3cMNER8L8KKgwnOPXjeVR/a5V8qDzhZownnQycpflQiysA9MHWmzsFz0OgbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 09:47:24 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:47:23 +0000
Message-ID: <61d32bea-b6fd-4fdb-9c89-65aba23477c3@nvidia.com>
Date: Tue, 17 Dec 2024 11:47:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] system/dirtylimit: Don't use migration_is_active()
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-8-avihaih@nvidia.com>
 <CAK9dgmYowKNMD=5-PXGTL71K=sa22tuusZZPojkRQeMbaHyd3w@mail.gmail.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <CAK9dgmYowKNMD=5-PXGTL71K=sa22tuusZZPojkRQeMbaHyd3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccf0cde-b893-492c-c17d-08dd1e7fcecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUpDNGlna21QSU1BMjU1NEZtTUJ2VWV2TjBjUG41SElpaUpzbUVZZlovMFpB?=
 =?utf-8?B?OXhpZmcxYW1Cd05uSmRsc1BvZmQ5N0UzY1I1czgyekY0akdzcUdSZ1dxN3Rv?=
 =?utf-8?B?Ujg4L0wzeWJ5ZTlma21kRkNkM0lWTTFOanE1bDBqSEVweXVueVdlZll1dGVm?=
 =?utf-8?B?V1ZicG5BU0IydXdCdGZCeFMxbjVoY3pnSjN3c1R5RjNrSU5TUzhSMzNYUjBr?=
 =?utf-8?B?RG92bzVSak9abDUvWk4xUmJ6OXg0YnIxaUIyL2kzWVhQM084WUNTYlhielNG?=
 =?utf-8?B?alc4MTFuUzUxUm5vNkRyQ3Q4TXNVclZSbWJybG94alhabS9acVBuLzdxbXIr?=
 =?utf-8?B?VkdSUlRwUFlvbXl3Mm1ETGFITytHamNXWmovYmhLUkNXckFncXdVem00Qndj?=
 =?utf-8?B?NVNwMWE3NG4yVkUwSmFsZ1dNelN6MEpUNFJwR0RqZnE3TlorMlAzd2o1RXlj?=
 =?utf-8?B?b0g0Snd3UU5aWno0WWRDTVhWbklFNkxHdFE5dWl5WWVXMXNpd09HOXpTZHU5?=
 =?utf-8?B?TCtYWHBwYXRXeklsUklSQ1c1aktqYXp2SS9OTWZNMnVGbVhWaUVZTDdsaTd6?=
 =?utf-8?B?T08vZ1FlTFI1UEs2RGY1M1V4QXJGSXF5cVppc0pkbWRZSVRGaEpoSzlEODdq?=
 =?utf-8?B?cUhGbDY2b2xsODFyMTRqa1R4aFNZeG1IeDlUaXpxVDRKZU05Tkc4SEx2YXZu?=
 =?utf-8?B?dkMraFhwSUMxSHJvazJXQjU2a3hUbk8veWROUnRldzNPL1RqdjZ0ck9ubE5o?=
 =?utf-8?B?VEFiS1cwUkV3aVJqWXJxa0tKcVRNNTZqN1ZPZmpvWHd2VUc5NzlmNkNLZEF2?=
 =?utf-8?B?VjRXbWpKbUlzWHpFWklKOXdMekZOMUhyNWd0ZVUrOEZZTlUzdUs4cDdidGtz?=
 =?utf-8?B?Y0F1MXBhYkF1Q2haU0s3aCtMSkVjOGNBVVE3TDhDQUtIVjdOeFRDUDVUQlRy?=
 =?utf-8?B?NEl5emtJZlhiUDN5MkFzUUVyTVdiaE1uS0pydlJsc3ZML2ZvN3JiN0ZzNmNL?=
 =?utf-8?B?VktoUjIxWUIyVlJxaW1NMFo2R1V1cWxMTjU3T0pyTTl4OHo0Nk9INW00Mk1Z?=
 =?utf-8?B?ZnJqRldNVThMQ1VJREd3aTNnYzdONUFMNGlURHpSSHFNNDYraVhzaE5wclVn?=
 =?utf-8?B?cGxWQW8rQzREQXJUbWxSVUZjYlBiakpRTjB6QUgvelpLVEhmOE85RTU1VlU1?=
 =?utf-8?B?YkhnZTVjcXhLVGhqSVNzSmxQNDZJMEllQU1KKzRjbW0vZXVCUEx2aW9OYXFV?=
 =?utf-8?B?WjlCRlF6WFlBRmpnZ1VuWVJkK01KakltZmUrckFQRFVIMkcwb242U0pkbnFC?=
 =?utf-8?B?VzJFcHFvN05pbENPcGdNSlZrOWc1ZEtLQUhqaExRMENBMWhEVmpMYTRBSjVM?=
 =?utf-8?B?MXdWSzFsUFhnWDZmSzNmL3ZkNHhqeTRvWWJORzdWSFpZTkF0VkV1Nk5haFN4?=
 =?utf-8?B?TTl3dmhQTjFnL25QNi9WckFWRUhQRFJUVEJkN0ZReW5qb3BsTXBKTnIwOHI3?=
 =?utf-8?B?WDllR1FMenc1eWhBOE52QUZsQ1pPU05ONzVCM24weWcxSnB4Uzdac0NKemJG?=
 =?utf-8?B?VE84YVVYV0dQZENhZy94OWR2UkZVUHVkSXhvTkg3Snl2R0FRekVlUVpyOHQ2?=
 =?utf-8?B?R0hiR2pubExMTmJsTXVsUmloNU5DOEF4cGJUNWZPak52YUllRjQxR2pmNjJ4?=
 =?utf-8?B?OStqVWZUdXdYalVBYUgrVVJzVnpYMHFkUlNjNEFDcmRsQVpBaEJUN3JvM1Vi?=
 =?utf-8?B?NFNYS0czTXZmeEFJamMzWFV4b2RJcGZCSWcwZU4yN0dmVnRuYnNKUFdQZU12?=
 =?utf-8?B?aE1nUi9lUml4a010eGFmc3RjVklKVzY4SUVCQ0tkcVpJOWkxaURwNVNTY2pP?=
 =?utf-8?Q?yVUqNo3Z7P0ni?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjlPWUtEdTNvOHFhZEpzZmJadE9SYXpxNENKNDh0VXdHNDFoSkpySGUvblNv?=
 =?utf-8?B?VTJyN3Z1ck9mQWVsY1JlaUZlVW1OR1BldFhOV1pKRVlCbnNvcHk3cExhRSta?=
 =?utf-8?B?OG1DQnUrZCt0WStIWHFweFVaWUZ2VzhOM2I3V2UxaTNIN2syNmlCTUVXK0I1?=
 =?utf-8?B?KzcyQk02anNFTzQ3TWpQY1NPcG1rM0x5dzB5YjZSQVUzS1l6NVkwTlJEdEIw?=
 =?utf-8?B?T2xiTVk5Q1FXYldHQnRva3JkVmo5V3dQV3h6M2VzVUlXY1VrY1B3WUFvdWxP?=
 =?utf-8?B?YVZjUmlOM0ZaZnpLM0dTMDJvdENtM2NKVUtTbGFBUXZRVUhnendlSVNuU1k0?=
 =?utf-8?B?bWNqQmFFQmtGc01BMDZ4UmVTVlpsZC9kWTJoR2xQaWhRRnJVclNKNjc4Mnc3?=
 =?utf-8?B?dG5xNTJSejExajM1eHFjY3A4c2wzWWpZQmRqY2FRTURDZXpwcTBXZ0JZTUgz?=
 =?utf-8?B?eStuZDRPOGhpNjJ0VU1KUUE5bXcxOThJVXdDdm9BZjVXQUxZL0NaRXdOdXFp?=
 =?utf-8?B?ellvMFdXOFNRbTFSeXQ1NUdCUXYwbysrcTN5UmNsaSs3QnYxZms3QVREUUZU?=
 =?utf-8?B?bC9nRnBzVitkUTIwN0g3WmR1MjRNcml5aXF2T1VpV3VVcC9iN3BheGJKVEpL?=
 =?utf-8?B?a1NVc2ZGM0lkMVZyQUFNWkplQ0dSZ1J2eHNQTWZjUFBkYjI5SFNXdmJ4Y3ZK?=
 =?utf-8?B?cWw0RGc3ZU5kUXVBeFhQa3dIajg2RmxmMGF0L21kOHNnTmppR2VKMGhWcmRs?=
 =?utf-8?B?L2FnN2VSZmpKbUcyd25xWVlzNnNJb3J5cmwrS3c1WUdNbjd5N0ZJMEMvQ2dE?=
 =?utf-8?B?YXM3a1UvTThNbk43VDdHWW9Ed3FqMUFTeUNxM3F0QjIvbnZaZW9weXhydUl2?=
 =?utf-8?B?ZURyaVM0RDB4VTZsbGRxMzRQeXZJbFFwNWZsWEhoZzJXbE1reU9jZzF1QXAv?=
 =?utf-8?B?QVhIL2VtSWZPNGVWREhwa2ZWOExSUCtkWFBreWhrZG5yUGNuUzVKRXdjdi96?=
 =?utf-8?B?VmNmMGZsNmNFRXVQaktoaDhmcWJFdGErMThBVE50b3ZSMUh6ZnFtOENGTk1v?=
 =?utf-8?B?ZlJKdTh0TU5RM3hNbzNhK3J5Z3M2bkV2S1hnWmluRTJ2Tk5WQTZCcFVYTW1t?=
 =?utf-8?B?UTlrclMvSjd0WGZnZXZadmJ2M0tHUWljR2Y3dFp2c2lNK3VtUUZtdFI1ZWRH?=
 =?utf-8?B?NWNoeHh1ZG9JRG5Od3BaTDZiTjNVZ21xZzZ2UzZsOG5lSDl6Y2pTSmVjTGxX?=
 =?utf-8?B?N1NRbVZ5WnkzU2ZBcGhtbkVSeWxHWk82YUZCa3BlUWs3TFV1OExkaXgrZGVD?=
 =?utf-8?B?cTNMYkFXTWYyVWx6dGd2a3V2RVFlN3VFSDlaU1ZOd3p0MElBV1ZEQm1JZENj?=
 =?utf-8?B?VC9EYWZtQ3kyMHMrczlRQk5LK2pITWFzWUJoV2k3SEFkeThRQS9BVllEeUlo?=
 =?utf-8?B?Y0dSckhaMTkrUVp4Wk9YREtscXo1eEI3WU1xQVVIMnc2dktpQUdWV2VuYkRR?=
 =?utf-8?B?RGl1Y1dVcGpyT3Fta1NEckt2Vk12V1JZUGtNamxiZkI3M3AzMnRmS0JQRnR3?=
 =?utf-8?B?ajVBeWR3OXFEN1dUWTJuUms1QldVb3RLdzFId2ZXb3dpODVDTzNZbk5TSm5O?=
 =?utf-8?B?bVZBOU93eldwTDN3SS90aTNybVZpMGlOZFBhTDhWcUl0cVZ4S25DZ2plKzNr?=
 =?utf-8?B?SnZjeHBBK2RhNTBxSHVTTkdVaGpKRXVIeWpZZzJ5a2FtWWRHdERWMU4xSU85?=
 =?utf-8?B?dFZFN2w2eUlhT0YzSjErbUJKejRKdUhKUjc2eDQ1SE00QUZ2NDJHQUxraTUw?=
 =?utf-8?B?UHo1K1BYdGExdU5HRE12aWZITjVRejJRTDdWd3hMeE9rdExCU3F2N21RQTlI?=
 =?utf-8?B?NGFVOHAxVk42b0FSOXdPS2RJR0FLZnpEYnBBRm9qcmRpM0tsNWROdDUvaStw?=
 =?utf-8?B?eURSbkxieFlYbHVhSnhxV2tRbnZ1VmFLRkZ1bVZsU0szYm5kdUFTSG1PSFlh?=
 =?utf-8?B?Z0NHOFFmYURJclZUdmY4SkxiMjBLWG1xVVBTb21BcjhaMEVHcXJnNkRxYTRQ?=
 =?utf-8?B?WU50ajdvTWVTeWdtcTNXYk5UVkNHRGowZGZiNUEvd1QyODJSQ05LTXZCRE5R?=
 =?utf-8?Q?7YIF/sNBhYn1Vuefiex0yYjMR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccf0cde-b893-492c-c17d-08dd1e7fcecc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:47:23.8447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQMrwx0JOH/+zih02wddiin3irV7lBPXLqGCprqalxub/LoPwvl5iXUbFzTPZBB387pQqIARHxW3kzfy5jJHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Received-SPF: softfail client-ip=40.107.244.43;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 17/12/2024 5:01, Yong Huang wrote:
> *External email: Use caution opening links or attachments*
>
>
>
>
> On Mon, Dec 16, 2024 at 5:47 PM Avihai Horon <avihaih@nvidia.com> wrote:
>
>     vcpu_dirty_rate_stat_collect() uses migration_is_active() to detect
>     whether migration is running or not, in order to get the correct dirty
>     rate period value.
>
>     However, recently there has been an effort to simplify the migration
>     status API and reduce it to a single migration_is_running() function.
>
>
> Could you post the related links?

Sure, it's here: 
https://lore.kernel.org/qemu-devel/20241024213056.1395400-1-peterx@redhat.com/

Peter took only patches 1-5 of this series.

Thanks.

>
>     To accommodate this, and since the same functionality can be achieved
>     with migration_is_running(), use it instead of migration_is_active().
>
>     Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>     ---
>      system/dirtylimit.c | 3 +--
>      1 file changed, 1 insertion(+), 2 deletions(-)
>
>     diff --git a/system/dirtylimit.c b/system/dirtylimit.c
>     index ab20da34bb..d7a855c603 100644
>     --- a/system/dirtylimit.c
>     +++ b/system/dirtylimit.c
>     @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
>          int i = 0;
>          int64_t period = DIRTYLIMIT_CALC_TIME_MS;
>
>     -    if (migrate_dirty_limit() &&
>     -        migration_is_active()) {
>     +    if (migrate_dirty_limit() && migration_is_running()) {
>              period = migrate_vcpu_dirty_limit_period();
>          }
>
>     -- 
>     2.40.1
>
>
>
> -- 
> Best regards

