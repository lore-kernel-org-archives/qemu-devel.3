Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C5AC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Neq-0006V4-1H; Tue, 07 May 2024 12:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4Nej-0006QI-Ci
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:27:06 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com
 ([40.107.220.72] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4Nef-0003dq-QB
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:27:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MENzVCOC5pUlSCs2KbkFLxfDN94aDyxdejDv/D7zSiSiXnStxtg1ANWK00TI0LtnMLVzerwD/Jf8WpOopkT+KAlEyUsrMAd67rOIvGutcqjfKJeN+kCSGXNM2wPpRDNbE4M/VDvvZuXqMM4yzNv/Y9Fgr+fEHfDQdSXWEWH3ihhVSEYBW8/QomcIjMrKFBIJGrzpPUU4DBxoyM8OhR3yNdp5ZHdqPaZEbNX9wVjCzPNyAhQKoi1D6Fulb2ngE6b2hL2xQ5JUD+gTmT2yZ8q8nIvq4qCSWGcXieWQ0pau4sQUzb4iDZsbJEgDS5KNWe9dt6RDxMUiEMLT/TIuU3ee7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz1omBFVZ1j4kNtlG92FQXU353Plc0aIU/u3Tsw2mM4=;
 b=evdJ2nvnHvLgzeuk5tiT1TAIVdNR+nGf4MSvvZ7Vy5xpbbbAVAkC7r2hpB5YxokCj5v+IR+mjciiTKAoBWmBZJD6KVnGbZcsuc+fpZtpfeG1wkxX4oqLgW/veSG8Tdf6FvAdSHiUgGV7z0XaHOFIuuiwWFttzhXd3Vs8+1vL7MPWuAVIied/CXySYrj4C1zElxpTq5y2ctycygUS1xXMnwoDrI/SgQvyQgm/N7VJtXDepuEBgBLGA7ebK6e0Ih3pLySYUX948WgNFdKn89HCzMpkmekW9WW+0+sOPW5zBLBx3wx2NRleKEliQNNlfAK7MYAcF5qzI5KNWVsLNo36og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz1omBFVZ1j4kNtlG92FQXU353Plc0aIU/u3Tsw2mM4=;
 b=jqexnnswus43ShIngqwialPQYyKU1dgjkRZjgS8GFvHvuGcAl9MucM/LAtr6Aa6gliK4h11NX/q9ZdoqUghmZ91K2P7WlB6jqTEJ8vQONJoJvhEducPpQElZq+Esw9uuTdUyh8SKrWr5zd7JAk+pDTmvFDJaVnfi54MrVAQnpGJvkj9UXx2k/9mWBNOxluXVKjkB70yZc4XqondF3HMQPpf0NC5xe0EZbx1s0lCsgsabAzA76JxDfkRWYDt6EoKrhkXVIK1PqrHM9Ta/DOPM/qLNY1sAn8rzBnLu5yVXXaeC/+J9FYquffXaWybqwJhFn+dY1VwSj7KDvtlZ0ofNGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:21:52 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:21:49 +0000
Message-ID: <c19fb398-8b14-4856-aec9-fe596183b19b@nvidia.com>
Date: Tue, 7 May 2024 19:21:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, qemu-devel@nongnu.org
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
 <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
 <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com>
 <87pltzsfl3.fsf@pond.sub.org> <87ikzrm2ev.fsf@suse.de> <ZjjyPESK-YC-XtFO@x1n>
 <23edb44a-7147-443e-b0e3-2a832aff5aa4@nvidia.com> <ZjpOAm3kXE-7Rg6G@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZjpOAm3kXE-7Rg6G@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::18) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5752e7dd-10a8-4cd1-1df4-08dc6eb1cbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODNHR0lEREdLaFBZRktsTll1ZEd2dWtMZkZGTzVxVGlqdVpRNjM4ekZaTWpz?=
 =?utf-8?B?WFU5d28zKzQrZUZobGw5eGZ5RlVZWTRqYnZGSEhNck5HK1pZWmVDeTU3MEpo?=
 =?utf-8?B?czRaUnY4SGRPL29QWW10cUdpZmhFek1HWUlvaTJFNlRaQ1hEdEZqbFM0bnky?=
 =?utf-8?B?dG9rR3IwVHRCMk90U3RRNlM1bkxnQ3Z4TzQxK0ptNzdZNkRWQzZCbHl3MXFv?=
 =?utf-8?B?ZElvYkNicURxOHN3L0JqRkI0RTdjUUgyRnF4U1Z1Sm1PRGFWd3M3RkcvWitl?=
 =?utf-8?B?VlZkNmVwbjJpemlwemhydEJiZFBaM0hBUUFyVW8zbTdwT2cyUXN0ZUM4cDVO?=
 =?utf-8?B?Qm5oZDJ3RVJmSE5tVjdNN1lmcHpJa2x5aHZwS3JxRnYwbitURW9HemRacmdB?=
 =?utf-8?B?d3EwRFJmbkxWdTd4ejEwdHlLaHV2ZHpqbHNlNFdkZjhsK0pCNTRidHdoUmla?=
 =?utf-8?B?WE5tSVk4RHpJNGhQbmhGZFRESG84alBnUUViVVZnRDJ0MFl5RmVNL2tDT3Zr?=
 =?utf-8?B?ZjNYVVFmeFZQMXN1SnNZYkkxSTJwL1p4bVdubXhWMnEwRndqSDBFUXUySnF4?=
 =?utf-8?B?OEZ6NFVocU1MdU9NMGljSithU2NzVEl5cldYZjNFWEZGeFJIUkdVVVJaTVIv?=
 =?utf-8?B?ek9IUE1KN05scTRxVUVDK1ZRaDlQTVRMNnZ3MjYwVVo1eG9FaG9JVWZKTFpa?=
 =?utf-8?B?K3ZhM1lTMFAyWlpOczBJMitSQlFtZmlLL1lnVFg4bG9CQnpyNmptOWlsTENu?=
 =?utf-8?B?S3FkR3VWd2h6NUNnL3N4dXVFZXVXRC9YeE1EMWNENURFVlBMRHZ3K0dIL2wz?=
 =?utf-8?B?THBZemN2UU5RSkpTd2xRTzh4bmxKZU1oRDl0UjlSdHRDajM2eDNZTVp4NTYw?=
 =?utf-8?B?c2FwbnFiUHAra3pBSUU0WDhsUEtRdHVEWm1yZ0JyMWlCMlZTNEhPalBMS2oz?=
 =?utf-8?B?cGZuNU4xdktEMjhSWk9BSmZsakZPckZra2VrUXZkNlVBeGZPdTcrS25QTW56?=
 =?utf-8?B?bWMxZzdjbFU4MTFSSFRMdHNyNVBmNnhENmVJMzhSYnlQajZFTWVqWjk2bkJX?=
 =?utf-8?B?ZllDSVdhNGlHN05SbElHaUErVXdEWDRUVVo4ay8zMmp3cXlZY01JdytVWG9J?=
 =?utf-8?B?YnM5eXptZ3gzOU9Hd1FYcENlMzVZQ0ZaZ2lOTVhzZlFIeWx2SytycUtLQzll?=
 =?utf-8?B?cTBnRWxxWGN4cWd2bEJHYW5wbmVlRXkrTnB1WVJwdjFmaHEzTjFtUVAzYU5W?=
 =?utf-8?B?YXJUMjN4aHAxRUJocG1XVHMxdFRYb2hTT2ROZ3JLcjkvVkRkMWFEaXVlS21Z?=
 =?utf-8?B?ZWpqeGpjd2Z4cjFRRG01OUI1a0dKK25peW9kV1dJSllNdm9FcVFVbVMwZkNM?=
 =?utf-8?B?SFhKWGEvY2RwVkZBNTR4cmlPM0JOUTkzb2NWcDJxcWNPR1BaZEJuM1JoSDda?=
 =?utf-8?B?dkVHVXo5d2hGUnllQzhCSEJUL3dBdytkQmJjYTZZZVVnUldITXhESCt2SjFM?=
 =?utf-8?B?RTFWWUtPSmV4cHZ1N3cxRzFvMEFjRHBtODl2Q3d3U2N3d2orQ2xhbmpyM0hB?=
 =?utf-8?B?elBjWDZDeXNpWXU0RlBTN043cUF3TlEzV21DOU51VFRmSXRSb0wzbDRZYWRD?=
 =?utf-8?B?cnBQZE9SSzB4bm5ma0JleDBaQ0hGSVhiZTB0dHhRSjBudmJNRmtOZ3lPWk9u?=
 =?utf-8?B?RExyQzg1R3I1K2VOZFlYbVN4U0xzdy9qejVIQzJlVlRlMDBHMGcySWV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdMK2JTWEcvM0FuUUVXamdUMzNWUUg3VFJPcWt0clRaQkVYUmtSSStpWWhG?=
 =?utf-8?B?c0t0S1lRdk9UY1UwRy9PV1N4VnJiZjNZVWZqd1lDRVRNMGFFdkxpZVl4bllI?=
 =?utf-8?B?Ky8wM2VDWVNUa3hHT2Jvckt2NHplNnFZdHlHdTBrL09hTmVBM3dnNVhpa1VS?=
 =?utf-8?B?L285SXNUVnBSd3pBSnRYb2kyUi83VTFFNENUeUpwZHUwV05uSXFQR1BIbGlO?=
 =?utf-8?B?WTJIeFYxSENLMnIvS0RLcklWSStNdmhGUEZaUjFXUVkzcWdNMUNZOVoxS1B3?=
 =?utf-8?B?eU9ycmFlL3NwQ1pNbzk5OURCZ1JWbHlvUk5oV0xFYlBKQlZHNmJiVm5JSU9n?=
 =?utf-8?B?VjAweVJpZXlhNm1TV3dYdGhkNTRQRWNUUUI1R2MvTlZPeHk1RFVYcmZtUXZ1?=
 =?utf-8?B?Q3NUa0FzcnVTeUZ4MDdGQWpLVENDb3Z3WVIxRStMQ3J2T1puUlZmbDNqRDQw?=
 =?utf-8?B?QkdSc041Vm5YYmV0eFdFZm5QVDY2Q3c1SnZvd1lqQ2pMZ2s3TXArVzBtT0VH?=
 =?utf-8?B?cFdsYzFSK21pYTZQbG1jKzA1b0pPdDR4MFVuTldsOWNuaU9rQXQ4NmJENXBq?=
 =?utf-8?B?NjMwNWErTklDMERYQkl2djhvcHcvSEFWbVNvL0Q3TEhWZVlNc0N0MDBuRjhi?=
 =?utf-8?B?U1hDenVkczhSeVFDZEdlaHlyd1ZlaEhsekxmOEFhVHVPNnJ1VVJucTFXeGF3?=
 =?utf-8?B?SjJuditXSjIza2lDeVBpbldnVDZmWnVqTHRmTGovcVIzWGJVMytDaVBJbHZl?=
 =?utf-8?B?MktsbFhNOGo0cmhkTVFHMGs5eUc3TEZKNVAxMGlMUVJrNy90SVhnNHlCL2hD?=
 =?utf-8?B?bHhoSFhIRzFxMUxCUTBzZEJ1VGxMTTBTWEQxZnRXNTVqR0c2blE3Ym44b2Ix?=
 =?utf-8?B?dlMyYmdSZjBKTDVOSUZCdGlTWnJuSEsyM3RwVTZVTTRWVVRQOUx3SHY4YXVt?=
 =?utf-8?B?cVBzeEhZZm5DZks2QUVDRXVKaVRXck5TTWJtL3FNTnNsYWlTVVlYdmRYbnJ4?=
 =?utf-8?B?NzlSbTdzMUxKa1pBY3VTYm4rNG04N3h3c3dPMXhUZWFpczd5c1VSVzJRZVdN?=
 =?utf-8?B?bXdaeDlNNllGNEg4MHRaS3pqdnJ2VDVQUmV2WGJ4K1Ryc0JZTmZ1bFp4TnZ2?=
 =?utf-8?B?M2FFc09iSGxmSXRRRitwdmdSbjh1cHF2WkRsTXk1SlpMVTh6bG9EYjZhYlJw?=
 =?utf-8?B?Rkk4UkViWWRFV3lMelUrQ0M1ZytObEJuYlFsdHJMMS8yN3lDY3FUYVZqV3l0?=
 =?utf-8?B?Wml1VUVKK1lzMHl6NkZ3L2c3dUNjSXFvc0RoMnZleE5sYkx6N1drMjBTRkFB?=
 =?utf-8?B?dnpGOXowSVRaMHV6QUQ2S3VUWEZtKzh3VWwwZzlqdnpZbjM1dERaTytDYlcz?=
 =?utf-8?B?ZUtsanAvc1VUSDlsWXU2NThXOTlDV2hIVFpseWhKeEVwZExPZDM2QW85TXZr?=
 =?utf-8?B?WnR4dVpLVUs3UW5oRXdCOTdHVVB4cGY5M1lQN1BmWUFSM09JU3M4TCtINk9r?=
 =?utf-8?B?RmpCSXkyOUJpbWIxMTJpUlNWTUFWZFNBNytQeWZYbnErd0gxMVk5T0VrS0FN?=
 =?utf-8?B?K3BBTmFmLytOMWZQSitRK1NtUzJ3eE41NVFmMFhjWUlOelplNjVTbkJBS1ZM?=
 =?utf-8?B?bkg1Wmt6R3VzYUxub1JpYjVDSGdyRXNhZ2s3WkVJVm9JSUQvN01KNmloZGNP?=
 =?utf-8?B?ZWZuRmdmOUU1UWtBUGx0c0ZxNGpsdWRLOExYRkJnMTlpMTIzdkY4ZS9TRU5i?=
 =?utf-8?B?VTZOTHNEVU1qTzRjT1FQNDROZnVFcmNEZ3BkaVk4RFVKSkFKK0IrTjZXRUt1?=
 =?utf-8?B?V0FTcmtBajRYNE03YTd1VFFqMndLNjBZVFJRMUJ0VWMwSFEyWFFTTzJGMEVi?=
 =?utf-8?B?UlhlUjRTTWhoSnY3dVM3UER6MVU4SU5PM3ZhaEx5TDlwa2tSaU82VTFvU3N6?=
 =?utf-8?B?L2srZmt1R1g2QmRLeDd4S2NZeDRqVk00Z0d4ZkF4cUNVU1grZCt1K1dvMHYx?=
 =?utf-8?B?RXRkT1ppNlY4d3FPUDIrTE1Ha1dBQ0phS3Zya1pSMHRjN3VSV0ZERzFmVUJO?=
 =?utf-8?B?QXlpYkFyMks4bEx6THJFNFhQUjlxWTFPUEdpbzM2VXl3Z2tIeVlDWHg1ZXBj?=
 =?utf-8?Q?O/FbymnCYDNf6SMRugP0KsN4w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5752e7dd-10a8-4cd1-1df4-08dc6eb1cbc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:21:49.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3cHedorIbud9xvK++xxXPAK1fCt+5Ay65699+9rmN0HZ1N0LLsRwPcYGq11BpxvNbBNPPFTkNWi3XGsZsveHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
Received-SPF: softfail client-ip=40.107.220.72;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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


On 07/05/2024 18:51, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, May 07, 2024 at 10:47:13AM +0300, Avihai Horon wrote:
>>> While at it, another trivial comment is maybe it's nice to have a helper to
>>> both update the vfio migration state, plus emitting events when necessary.
>> I think vfio_migration_set_state() does exactly that, no?
> Ah yes, looks so.  It's just that I saw some common patterns, like:
>
> ===8<===
> @@ -126,11 +167,13 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           }
>
>           migration->device_state = recover_state;
> +        vfio_migration_send_state_change_event(vbasedev);
>
>           return ret;
>       }
>
>       migration->device_state = new_state;
> +    vfio_migration_send_state_change_event(vbasedev);
>       if (mig_state->data_fd != -1) {
>           if (migration->data_fd != -1) {
>               /*
> @@ -157,6 +200,7 @@ reset_device:
>       }
>
>       migration->device_state = VFIO_DEVICE_STATE_RUNNING;
> +    vfio_migration_send_state_change_event(vbasedev);
>
>       return ret;
>   }
> ===8<===
>
> So maybe some more internal helpers?  It doesn't look like to cover all
> updates to device_state, but I really didn't read into it.  Not a huge deal
> really, feel free to keep it as-is if maintainers are happy.

Oh, I see what you mean.

Cedric, would you like me to add the following?

===8<===

--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -122,6 +122,14 @@ static void vfio_migration_send_event(VFIODevice 
*vbasedev)
          dev->id, qom_path, 
mig_state_to_qapi_state(migration->device_state));
  }

+static void set_state(VFIODevice *vbasedev, enum vfio_device_mig_state 
state)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    migration->device_state = state;
+    vfio_migration_send_event(vbasedev);
+}
+
  static int vfio_migration_set_state(VFIODevice *vbasedev,
                                      enum vfio_device_mig_state new_state,
                                      enum vfio_device_mig_state 
recover_state)
@@ -171,14 +179,12 @@ static int vfio_migration_set_state(VFIODevice 
*vbasedev,
              goto reset_device;
          }

-        migration->device_state = recover_state;
-        vfio_migration_send_event(vbasedev);
+        set_state(vbasedev, recover_state);

          return ret;
      }

-    migration->device_state = new_state;
-    vfio_migration_send_event(vbasedev);
+    set_state(vbasedev, new_state);
      if (mig_state->data_fd != -1) {
          if (migration->data_fd != -1) {
              /*
@@ -204,8 +210,7 @@ reset_device:
                   strerror(errno));
      }

-    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
-    vfio_migration_send_event(vbasedev);
+    set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);

      return ret;
  }

===8<===


