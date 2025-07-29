Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B639C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 22:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsRM-0005ba-6G; Tue, 29 Jul 2025 18:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqYp-0004H7-1A; Tue, 29 Jul 2025 16:04:38 -0400
Received: from mail-dm6nam10on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqYm-0000AO-JN; Tue, 29 Jul 2025 16:04:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmZ5Rc8uPPci8q7f7E9El/NkJgf4vWwz0uEhEITE8e+mWB1go4N86LZWgfrMIv8JH+nzNyyvjanWEZQU0Yz0FHSKfRzxtdvXJ3S0RPNwnX+3GCnVYxYTb0slnqVzOdYjo15ynl9lVPlp4sb4mRxEOqSQxK7e6klra/REQBQGUvkgRVgLD5k2DL6M2yhXk+kIGDICRKifrvwPu0yPzAgZISbOtRZLvTfido5I5PA/GluCePE4RHluy4CZv0bFczEZVO6OMfiMhg2iBlV+LWabgipyw6ehVe+yILHT/BW1eifP5wd4mgozrt9DQWZ9sLQ/XNBcyTahcKebysd7K8hqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfkRgqLjXS0uKzjWghVXXOFdbhqHDSQbG3RUukLT/Do=;
 b=LOiN2aCxU9hnF/nSS4CYG/sMUzV61gmygPbw0MALcnD8YYuvgdfD/I1tjpIhKoiefHLi2mFGYYSQzKadzzkfC0pXJITiv1FmPIjp+38HhUiHmLjF6WhN1rs98yig5rNnLsQ5imYIp8pShfzFdZyOaj+QyOLFKQJ/uenYtFU7hONnLAO0Sh2tIrinHMdPsXW9U1f7Jk2QML7Y6abBv7SSCdO7Qo3qGzMSHqy3bPK3GY5ScOn+bVnCZRMNkzyayG6ho8HkSoHZo0GdNIDOxP3DEwLx0U8vPVF/2wCaSMY+l2NzrZXDJLcvF1FQAXbzR9Cdv88PUjw8uT9Nv76PN3t/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfkRgqLjXS0uKzjWghVXXOFdbhqHDSQbG3RUukLT/Do=;
 b=Fe0m+r8ZoS088DJjFXvbFQ3yVC2qhsRXCk+/5NPtulBcHZBccWYg1o5bh6LAkZ86Hsp+3pdXP/dPN6/m3G9RzbBFnweNx6GDzyMknnXFEzkO0LVvRLovlmLduyrszDfsyNjhwtZq4CwLSoqbjOi2jrdZLEBzKximtvK3BLk629s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 20:04:23 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 20:04:23 +0000
Date: Tue, 29 Jul 2025 22:04:17 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 20/48] hw/arm/xlnx-versal-virt: virtio: refactor creation
Message-ID: <aIkpQTrWcaAUpKmN@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-21-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-21-luc.michel@amd.com>
X-ClientProxiedBy: LO6P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::11) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e5b844-8362-4277-c78b-08ddcedb1cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlA5eC95QmxIMlBXTmkzOW42OXc1c3oxRHFaNUVDdkxnZnJWNUxaQW4rclJN?=
 =?utf-8?B?NG9Wc3Y1cVBvb2tvdFY2YUpMNm9lSE9iOU9SWW1xNUhING9RUGdUQVEycTBq?=
 =?utf-8?B?VEJZTlI1SUd3RXFheWhiZXI0dkNwUXVJemxobnFlQlhZdCs1c1FtSjN1OTg3?=
 =?utf-8?B?SjZ4SVBPZmV5Y3JDZGtseVk3cDNHREhNUG8yNGpjVi8zVmlsL1lMUnUxQkpC?=
 =?utf-8?B?UmpYdk1QRXhLem5VbVV0d2VqQTBaTjN2OC9ycWpNd2h6WStHc0diWVJ2a3lY?=
 =?utf-8?B?Uk01NHV1V3RJNWVRWlNGaCt5ejJWNVRMQUtZQ1dZVWtNekpwbk5vcTZxNVA1?=
 =?utf-8?B?TmNlTE1CUlhuR1pHckE0ampUK3NxeDQyR0NFZzEra0NzQ3FDcHV6ZmdXcm5G?=
 =?utf-8?B?UjFMZjZrZ2treDE4T01tVm1nZ1RRTytObG1LNVZyQ3NaVTZoYVFpWkoxSDBl?=
 =?utf-8?B?NlV0RThGZEx6ZTlmMzlJYVdxSVFRdTl5SFJad05tMmRqUTlkZ1lKcWVHTndu?=
 =?utf-8?B?MFdpTXBaeFZvZXozTEFoaXZmaXFtTk4yMUdLWk1YVEhLVU1lSDUyL1RlSFR4?=
 =?utf-8?B?a1hNS3c1aDNpYWdRdHp0ZzJ3VlBLZEh2WFdTeE9wOU9jZ2tVRS91ZXBnQ0h2?=
 =?utf-8?B?QUltY25RclVVd0dzNVRGVDIrNjAvRmpUai9kMVFVQ2g5MndXUVFjcWVXSUEw?=
 =?utf-8?B?V3M5MDdmcUdSR3NhL0FMNnN6UzNtYWlUdWVQbG54eDBDL0gxdk9YQmFKdWFJ?=
 =?utf-8?B?NzBwdDRLRVM2T2krZjZYTlRpejNxQnJvaVpjMHVDU1k3ZUd2VFlFRExlUnAr?=
 =?utf-8?B?SURFRzFLbTJXSXhtMGtJVSt4cndMdzA4dEk1QXBjY0M5TlBkMGRTNE4xQ3hw?=
 =?utf-8?B?TDQrajIwWFNLemtVUHQ0MS9YWmtoalhpUGVuQWtoZXhmSWV1M2RUcVFCWDFK?=
 =?utf-8?B?YUhpaVV0SzlheWtFNS9WUFZ0b1dCd0RsUGFsbm9kTUVUTFNaUlJqNTNSZHpO?=
 =?utf-8?B?WlJEZVNFSTRBMXZscXgzKzBBZm5Xaml6S3c1ZUtFay9QQ0wrcFhoVU1YeVJD?=
 =?utf-8?B?QVdsUGN2Y044NjNiM0ZRNko5UGdEMnI5aW1oRzE3THJ2M1JGUzNQZjVWOWox?=
 =?utf-8?B?RVBCd2txdEovUjVuQWdIUENaa3RhRkdUOExhOFBzSWExbTNzTTl2ckhrTWw3?=
 =?utf-8?B?SjJyNWV0TjFWRVgvZGwvczY1TjhoOVdjUHRhemNXeXJQSzJURUV5MkFWTHZR?=
 =?utf-8?B?cHVYRE5UYkJGNy93M24xdWhjWlNoZy9DYTBodnMwYXd2NFJQUVA2cE5rQTBW?=
 =?utf-8?B?aVZWZlZROUJnaTVRYjAwRnYvUGx6SnlvS3I5YzNuanhtL2pZWFg0STVOM3B0?=
 =?utf-8?B?K3pnaDMzbmpuREhvVmhMWHVHTDFDWVpmY2tjRnZkb0dDamxzd1NIODJmWDlM?=
 =?utf-8?B?SkF0T2VpVFhQdklBV1Y0KzUrRGVoNEZkRXRQQzMyemh6RnlzdG5kejdYeFIr?=
 =?utf-8?B?NzM2d1lCaTFWMnp4YXVBQnltdHVxeFZONlc4RDhIK0FkQzF4UC9tWFdpamNF?=
 =?utf-8?B?bFo5L3RXQzBRMDlHeTNGbkFaU0hyd2RDNVJJRVlYMFRhUFBGWGkvR2hKeHhY?=
 =?utf-8?B?RmM3Q0Jmd0hQSzlUS1FpcEhVdEZwQnA5RlVFTkZ6RnhpRlNvYXJGTU9xbU9r?=
 =?utf-8?B?YlFLVmoySHQzbXVWb0d0L0NPMzkxd2IzaGgzUkJEVVErbklQQjdwdXFrTjlv?=
 =?utf-8?B?VGdOcFBZMDh6U1U2UUUvZ3VqVGlVeGovSmRHT3Z6Z3ZwNXNGOWZQN0o3a3NS?=
 =?utf-8?B?MWFsZkpNamlnZU1oNlhvN3J0aDZwR1ViYjU2Ri9GdHByd1ptdXUvd3V3Nmsz?=
 =?utf-8?B?dkZ1WmFVREhiSWd4TWU5SUEzb3NVVW9sanZsMnJLZ2dyTU9vcUNTNFR5alFW?=
 =?utf-8?Q?VgvptckWDVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJkYUIzbnBySm9FWGNhRENhaXFPLzFCdWFNQmUxQ2d5dUZFNW5GdkpBU1k5?=
 =?utf-8?B?YnhQL0k5eHdvcVV5ZllwTmVTcUk0ZmFvZG93UjVjczNEVGh3YnR2L3o4eFFZ?=
 =?utf-8?B?WUl6RklkcGNGTlZUSldGeXhvRkRIUzZtYnkyVmJGdGsvU3pmN0lhakMvalBL?=
 =?utf-8?B?VG9YanE3aUtOamZCY2wyYWY5OXBSVFd6clFzUjJXVEp2THF6aTZwZ2FOMU9H?=
 =?utf-8?B?aTJpOXY1SkgzL0MwbnZqblJDcmNhL3A1MmhtZU9OVWdRWC9hbE1xS1hXMHRI?=
 =?utf-8?B?R0tEQTRjbGQrZnlzZEU5NjNVZFFBaE84UHM4NmNZTXFBRXpodExHZmhWbjVh?=
 =?utf-8?B?bGxnV3lTS2JRTSs3VTBqTWhzcW9HRzdNR0FaWFlhaGx1OHNxRnEyVHdBVllX?=
 =?utf-8?B?RkZBb1dkRVhYUm5NZVhqZ1JicWZLQ2M0eDhKSkp5MmprSkNaaDNoWWlZRzRB?=
 =?utf-8?B?cG8wWG5PZUlCdWJ3bXZpUkUrbHlUUFVabitwbXk5YVhscVhmemRKUDV5TUxy?=
 =?utf-8?B?bVFxWWoyblFvbTNIVW9sTDdRdE4yTVhyUnpIUzFyanltd3prYzhFUlY0aGM0?=
 =?utf-8?B?djBZaFdqVnZjb0wwd0ROWVVnaDF1OEdhWC9MbXExQUZJc3FvNDBmSzJDVFVI?=
 =?utf-8?B?TnNhSVFuNUJNVFkzQS9SbVYyL2RvcjV0RmU3MjBqV0IrVVg0eHNYZWQ0aDE3?=
 =?utf-8?B?dHFtMDRSNXplRUFydWluanRNN08xS3BHU1FzN2NqbmJ2TW5udzgwWSsvZy8w?=
 =?utf-8?B?VGdoUlYvRkdnYXhucjJyemo5RnpwaldFa3QyT25PcnN0OVc1R3hWTFZmL1lv?=
 =?utf-8?B?VUEwRSswM1E5Wm9zQ1ZzMDUvMy8wcTY1QjFSSEhJUVBXUm1JSWZucEgybjVr?=
 =?utf-8?B?Rm9ucWRaNDQ4QU5VcDRNVzQ5elNTY2UxbnhycXloRTJieURmbTNKRjV2RDRC?=
 =?utf-8?B?dE4zOHFBaUlXcUoyRnpFWGI1cW56dkpNVzVMQmZDT2F6UWRDdzV0azltUGRi?=
 =?utf-8?B?Y1Z3SWhLcWJDYS95bFR4elpybktXUGFneDRGcEF4OVBWbHpvWE9TN281Nyto?=
 =?utf-8?B?M2gwTHBkZ0FUaTBDOEZ0WENzR1pvSkppM242UkRaWUNUaWRDWWZrazNKNWdC?=
 =?utf-8?B?SzJyc0FlUkYrdkhWemlHM0ZRTzgzNnRXZTBVRWtCTm1zS3hPQktJTnZxbXlW?=
 =?utf-8?B?TEZzWERUQThMUnlTZWJTajZDVk5DMFZkdnR1eFUxd0RKTVJNSkNvWVpudlVx?=
 =?utf-8?B?SEVUS3VUdmhpV1V3Yjd4SERZT0pIeWY0b0M4ZEZVRzgvVVdia1BPS09tUGU4?=
 =?utf-8?B?RkVhNmY5amVqY242bjBidzFuSk5nWk5wY000WWI5MEdITjBYc3YrOWtTWHhB?=
 =?utf-8?B?alF3UTlOMVlEZ3JwQmd3VDdXY25lYldlNk9FOXV2RnRnck45eTVLbzRobi8z?=
 =?utf-8?B?dEJDYnlqNUl4d2ZkR2RiQXVvUVY1aTQ2Y0hlUHo1SVUxNFRQOE12MkNsR3ZI?=
 =?utf-8?B?a2ZjWjk2UFVyODkzU1lEYllRZlRwcUU1RExhWjBicmxPQTJBZlpOVjRxQzli?=
 =?utf-8?B?V3BxL1J5UEtPUU5qZVQzY0ROb3NaQ0ExcG0ydlJsRUNrUXp2SWZoeHhPaUJQ?=
 =?utf-8?B?QUpYR2t5UTBDME9aSzlHRkNDY0JuOTdxcUZoMUFIYmo0cTRKeHlOeGFhL1Ez?=
 =?utf-8?B?RUV5YXZVRFNWRmdJNTRHTnVuR1VYSHZMSmNFenorOEVFcThQandLdlF6N3BO?=
 =?utf-8?B?SU5Ma3N4WG9ZditzbXBEclNPQ1ZubDZXR01WRHpNKzU0b3d0LzEyaU9jdDR1?=
 =?utf-8?B?NmFsOCt3Y245VGJYZ29YZGN4VFNpTXRCOUgvRzFNd2c1dE4raFBQZkxMUWox?=
 =?utf-8?B?TGR4c0JabTAyZWNQZE5LVkYwdXFabGlWdS8zb1FvejM0NGw3ZFpIMWlvR0pm?=
 =?utf-8?B?emJRZjc4NHZlM0R1bWpJaXhJT0Fuand6Q011azJPZW5DbXhycWQzbStoN1Az?=
 =?utf-8?B?Z0I1aDd4SUVlZkpSaEtQZHR4UHZpb0xQWmRmUU90Qk5GRUlrZWF5U3dVOFdS?=
 =?utf-8?B?elJTSHoxTWhDc3M1ZnNnY2RxUTdGU1o1S1BFdkxJaEU3R2hKa2tCc0tRUlZw?=
 =?utf-8?Q?E4SoE7EldjbffssVvhPwSqeoL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e5b844-8362-4277-c78b-08ddcedb1cdb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 20:04:23.6850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6bNgNGrUy/z19E9Dfe0KXHTDuJMPkD/ayEXV1K91XI99vyD8NqV6awJDsWwwjBm881pgZ/DPrfD2DjfA/Axzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
Received-SPF: permerror client-ip=2a01:111:f403:2413::61b;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 16, 2025 at 11:54:02AM +0200, Luc Michel wrote:
> Refactor the creation of virtio devices. Use the accessors provided by
> the Versal SoC to retrieve the reserved MMIO and IRQ space. Those are
> defined in the VersalMap structure.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  3 +++
>  hw/arm/xlnx-versal-virt.c    | 31 ++++++++++++-------------------
>  hw/arm/xlnx-versal.c         | 26 ++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index d3ce13e69de..af47acb288f 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -100,10 +100,13 @@ void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
>  void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
>  void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
>  void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
>                                BlockBackend *blk);
>  
> +qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
> +hwaddr versal_get_reserved_mmio_addr(Versal *s);
> +
>  int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
>  
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 01c230491df..a776ee87088 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -269,41 +269,34 @@ static void create_virtio_regions(VersalVirt *s)
>  {
>      int virtio_mmio_size = 0x200;
>      int i;
>  
>      for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
> -        char *name = g_strdup_printf("virtio%d", i);
> -        hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
> -        int irq = VERSAL_RSVD_IRQ_FIRST + i;
> +        hwaddr base = versal_get_reserved_mmio_addr(&s->soc)
> +            + i * virtio_mmio_size;
> +        g_autofree char *node = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
> +        int dtb_irq;
>          MemoryRegion *mr;
>          DeviceState *dev;
>          qemu_irq pic_irq;
>  
> -        pic_irq = qdev_get_gpio_in(DEVICE(&s->soc.fpd.apu.gic), irq);
> +        pic_irq = versal_get_reserved_irq(&s->soc, i, &dtb_irq);
>          dev = qdev_new("virtio-mmio");
> -        object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev));
> +        object_property_add_child(OBJECT(s), "virtio-mmio[*]", OBJECT(dev));
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
>          mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->soc.mr_ps, base, mr);
> -        g_free(name);
> -    }
>  
> -    for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
> -        hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
> -        int irq = VERSAL_RSVD_IRQ_FIRST + i;
> -        char *name = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
> -
> -        qemu_fdt_add_subnode(s->fdt, name);
> -        qemu_fdt_setprop(s->fdt, name, "dma-coherent", NULL, 0);
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, irq,
> +        qemu_fdt_add_subnode(s->fdt, node);
> +        qemu_fdt_setprop(s->fdt, node, "dma-coherent", NULL, 0);
> +        qemu_fdt_setprop_cells(s->fdt, node, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_SPI, dtb_irq,
>                                 GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +        qemu_fdt_setprop_sized_cells(s->fdt, node, "reg",
>                                       2, base, 2, virtio_mmio_size);
> -        qemu_fdt_setprop_string(s->fdt, name, "compatible", "virtio,mmio");
> -        g_free(name);
> +        qemu_fdt_setprop_string(s->fdt, node, "compatible", "virtio,mmio");
>      }
>  }
>  
>  static void bbram_attach_drive(VersalVirt *s)
>  {
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index ff55ec62301..fe2c789a557 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -152,10 +152,17 @@ typedef struct VersalMap {
>              uint32_t blktype_frames[7];
>          } cframe_cfg[15];
>      } cfu;
>  
>      VersalSimplePeriphMap crl;
> +
> +    /* reserved MMIO/IRQ space that can safely be used for virtio devices */
> +    struct VersalReserved {
> +        uint64_t mmio_start;
> +        int irq_start;
> +        int irq_num;
> +    } reserved;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -218,10 +225,12 @@ static const VersalMap VERSAL_MAP = {
>              { { 38498, 3841, 15361, 13, 7, 3, 1 } },
>          },
>      },
>  
>      .crl = { 0xff5e0000, 10 },
> +
> +    .reserved = { 0xa0000000, 111, 8 },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -1411,10 +1420,27 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
>  
>      sysbus_connect_irq(SYS_BUS_DEVICE(ospi),
>                         flash_idx + 1, cs_line);
>  }
>  
> +qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx)
> +{
> +    const VersalMap *map = versal_get_map(s);
> +
> +    g_assert(idx < map->reserved.irq_num);
> +
> +    *dtb_idx = map->reserved.irq_start + idx;
> +    return versal_get_irq(s, *dtb_idx);
> +}
> +
> +hwaddr versal_get_reserved_mmio_addr(Versal *s)
> +{
> +    const VersalMap *map = versal_get_map(s);
> +
> +    return map->reserved.mmio_start;
> +}
> +
>  int versal_get_num_can(VersalVersion version)
>  {
>      const VersalMap *map = VERSION_TO_MAP[version];
>  
>      return map->num_canfd;
> -- 
> 2.50.0
> 

