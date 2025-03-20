Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA71BC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvIDe-0001ab-Pl; Thu, 20 Mar 2025 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtatulea@nvidia.com>)
 id 1tvIDY-0001ZA-G8
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:54:00 -0400
Received: from mail-bn8nam04on2072.outbound.protection.outlook.com
 ([40.107.100.72] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtatulea@nvidia.com>)
 id 1tvIDR-0001YL-3d
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:54:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzKoKsWqyJaef7VAKggRMa0sI8bbl6CH5hgtOZ7MuWbZW5J2PxVlkCkGuiH5sdnSZf1OkNy9gLm1wOf7UPcEJ4WgrXiZ4ftZjmxOphGqqHuAc+/NqdNm28ydJh1OFzYxwq0wCa8SvvkXvb3ckRozWXq8hNLq+b0hq5bzgR6zbmhG7R9BnNRQfRYMffm077B7nVsXFBrsScuCbiFfLbNEVVyUpBWBQR7DgIoH7FyMfLvACRUQJ49ZUT9MOrjSTjx5tvR9k6kMJwEULbpX6E+7BrAeJcqodY6btn5WvcnuLrhIY3FqLkmdLHIMkTt//68OnsWj2KbLilrgbEiv3BW14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Ief3LKGGCnyYE0TBbbQrU7NSbl7dOypO+E0dNkAts=;
 b=KGbHtjnfccL+ck7Al0HB+cFMfBlzFPvD/6258zP5Y4O6FahSyDLSzI4TBbbEzQDwK4s3rocr4haWqxAwPez3neDhbtGHD6h2zbkWUFfmHIXg2aCwOKe0QohSysqGkK/ET3s+oUlegRWTY1VGTcgBcW19+FMD/HO6guqjJfIiogsCYG0N8CnssG1smo7GyKC2eMJHw/wUlYanYAEfDwl81oqxkPH24/dBHqxM2lI00nw3IkDgopLSS3oLhyYtAmqO8A6oQQBtGjiBMDxR26w9ijapMYz9Qm5PL+fTprL5dJZKNusqe2JISCcZA/6JqkP/vHQ0x0aweIm8Vr/qd4AKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Ief3LKGGCnyYE0TBbbQrU7NSbl7dOypO+E0dNkAts=;
 b=lqNQXbeI1vRLqtEBLt5PMGIAyW2K7bO7PjSDnU9rdwTNTrm45dgTv+0A9CPZr/bFC44VthHM6osE9RkTG+v4w0k8ADmNQCC2oOk5NPWLtzk19rWx+XE1UX/CEnaJ3N2RagbMGSptaOJ3wWcBgtVdk5Fumfunn3RrKCLdpZ7nTSDXOB/D29cPD4WkwM7R/ShsrtXWIJV/YLZUomD8PGNLz1aXzEEnSy1uRfduzzRSXdzNqrjNbeshj8FJnPVCp3uRrzRJt8hM08iRZ5Frq8BKm4f3ktG0kAEc8UvPZtNryuNukCVDreTUkS+jkeZT62nWX4Uv/ufdzXHhwUBSMcEVTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 15:48:41 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 15:48:41 +0000
Date: Thu, 20 Mar 2025 15:48:36 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, jasowant@redhat.com, lvivier@redhat.com, leiyan@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, lingshan.zhu@intel.com, 
 boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 0/7] Move memory listener register to vhost_vdpa_init
Message-ID: <hgrt7shqvqsv2am7x2e3tlzxarsyfbr43izz7cfiteb3gxeizs@fpb77yzhmthi>
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
 <CAPpAL=wMpNHMjGJuZQTVxDkdH_tCKP18OzdrUZpXL_N2e=JJ=A@mail.gmail.com>
 <CACGkMEu6pNCJsd0BFcC4B0W68yMvaA3K-mv0KxTqbVdfS7-x8Q@mail.gmail.com>
 <CAPpAL=zj-XgHO0VC46dHMZ0=nXegX3bMhC5UEN_8rAGRwPqXYw@mail.gmail.com>
 <fbf1cda7-8be3-472e-afc0-1a1aabf8d7cd@oracle.com>
 <CAPpAL=w0hUxnDwNmrcqdpNokEwdpmOmO_DHA=7cGLX1+3k6H0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpAL=w0hUxnDwNmrcqdpNokEwdpmOmO_DHA=7cGLX1+3k6H0g@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ed087b-e849-4f9a-fe4e-08dd67c6afc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGhUY05pbjdwVjhvZm15N3VjdWIrdHFvNnpnVmlMTm5sRkZNOG1NcWh3a2Nw?=
 =?utf-8?B?enhYVlI2TlEwcVY0ODZDcmZ2aFczWlBzQ0gyZHA5KzdZdmdFMElBc1AvZGx1?=
 =?utf-8?B?SUY1UlhmbmNiMjNYWU8wRS9QSXgyUzNwTnhmRjJRWXlPNjk0OTRDQ2FqM2Fl?=
 =?utf-8?B?ODd1dEFHVjlZOU5oQ2M2cklXd3c3ano2ZG1UeDFub1pWc3kySnBVdmxHNkU5?=
 =?utf-8?B?YW40UTh4SGo3RW8yRXhzcEhKYkNWbE9qK3JTVk1HVHYvN0t3dHlRMHBPT2U2?=
 =?utf-8?B?cjlnMTZVSHpkTnU2V0VTZXQ4SWd5WG5PVFFCMml1MGc1RWQ2RXZ6a2JVZHV3?=
 =?utf-8?B?aUxEZTJQeUpabWgwNDNhRkQ3UjFxTkJFRWJjRnpPZkh3dHhQWjQzN3RoVU9m?=
 =?utf-8?B?NWZpVzhSdmQ5N2MzdnNPRGdYem84NjkxS0N4enBTdGsvL2NnREJFU0M0Qjhv?=
 =?utf-8?B?aEd0STVhY2psOERQNXhTUXZ0SVMxZkk0aFpNS0doR1Q0VWZMYjJ0ZXA1VStP?=
 =?utf-8?B?NUM1SVZuTzN1Wk5OQmN2a205bjMzT1JxOWdOaG0xclVmcUcxSUowbnBvYmZx?=
 =?utf-8?B?N3gwUFRhMXg1R2oraXg0T3RxUFlWZmRCdDNGU1cvR1o3U3o2QkFSRVo0K3V5?=
 =?utf-8?B?ajdoSFRKM210SGZVWTZWWnpIaWpySWt0SVRvM1VBaGphM2xGY2NpSWZXTjdL?=
 =?utf-8?B?dUJlbHpGRXNRd2l0S0UzN0kzNjNlaXF3VXZCUXFuM0NCUytEVWNxcXNXUUFz?=
 =?utf-8?B?K3RVOCtQcTB3UzVVL2pwQW85MTQ5Q01hTjNwSEwrNkN0b3Btc0VBcFBsUGhj?=
 =?utf-8?B?MjRzenJHdGpSaUJvR3ZXaHZMWTVKNTRrVldkMFZFalNVcXRWc0hHWVZQQlF3?=
 =?utf-8?B?a2JqbFhVUmRldEpOYWVZQ1RJV2REcjcxdkN1alVEV3Yvbkl2b1o5dXNTeUNP?=
 =?utf-8?B?andtSmRlcGM2ZW5ZR21uSldsaDR6MHNZdjRyVXpUM3V6NENVdVJ4UnAyaEhN?=
 =?utf-8?B?UFdnYmU3ellWRC9aY2Vtd29VRVNwTFI2TFRXZmhydDBXeHY1TmZ0TGRCbWcx?=
 =?utf-8?B?SkpMcXNhdkFzTTlQaDBsdkJDUWVmODRTRm81dHlmTVE1ajZ5ZS9DRFV6NWI1?=
 =?utf-8?B?bHRtZ1hoc3M3WG5ycWdVSU11cnlIckVjdkI3aC9OWEFWRHdZdUdvalV1L2s4?=
 =?utf-8?B?c2dBcjRBbVhGa1JyQlVOeUtRRHNmelB3eUFDWHpXdjVmZzd2Z21kRW1MY3k5?=
 =?utf-8?B?RmVjeE1sdmNzTEQybUhOSjdLcUxjNElhbmJPaE1HcEtmUWZFcjlueUNOMnQ5?=
 =?utf-8?B?SjRNMyttUWZGZDNsbXFKZWZQS3VuVzZnNHU4MXE1enhKaHV6VmhCek1PMDVJ?=
 =?utf-8?B?SFVGc1JPbmhmVWZrdi85WkwvVWlscFR5MEtjS1pmWjRZanMyS29SZExzS2V1?=
 =?utf-8?B?WmFCRGNTVHArMHgzcTk2NEJPUytMQ0lHMmN1WXhqYmxUNGRvcURVdEJ2R2dX?=
 =?utf-8?B?dDFBV3F4Y1dPZnNJUjBwanlNQ1hxY1BGM2YzWkJBYlpqc2YzS0ZUYnNwKzIv?=
 =?utf-8?B?MzRBZUdCSTE4Q2xGR0JLZmhqYXdkV0tDY3RxQ2FCYjNwbEZpblNiU2dMWW4w?=
 =?utf-8?B?QmJ4cHYyMTdtVm5KRDRQUC9Hb2pRQy9TbXcwcktKeGpUYUZ4eHVacUw3dEgx?=
 =?utf-8?B?Y1VnZ3p1cTFBSG1rZThldlRPOE5USTZ4UCszTmZXeEpTMXBYUFViditJMy8r?=
 =?utf-8?B?R1M0N1oxV1RhbVhob0Q5UFpxdVNIaHJldkxEZVFWS1A1MG91TGRjbFZuTFkx?=
 =?utf-8?B?cit0Rll2OE1KeXJSM0tTNTB3VUZRRm1nbSszZTZKUXhFQW5EbXZ1UkxvbFpQ?=
 =?utf-8?Q?0Mwwbvn3TcEnQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9031.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVI4OXExUzErOVpmTWxWc0JIUG05YkhvcVE0SUM0SmJkd3NxbkMyU1BzaVBp?=
 =?utf-8?B?TWY1Lzk4aUNDMFlYNkdsWGdTa245SjV1SWs1TTBxRGp6aVFQaUpacy83bFBl?=
 =?utf-8?B?dHZVUlhMOGVEcDczOTFTS2p0UTJ0dnV0cTdBTUFBaDVrMVN2R2xwM1Y2eitx?=
 =?utf-8?B?NjFEaVk0QkdPSXVJQzMzRTZLZWp2cXp3bWFiMmRHQmVlRjJ0bklOcmIxS25a?=
 =?utf-8?B?Y1JCN0ZMTS9sZVk5VkZjQXFRT2tRNGFpRVpocUFtdjZ3VzhYcDM1cHg2MXFQ?=
 =?utf-8?B?aUdkOUZQWlJTaVg0a1k3V2dJV2dvTjIzQTVkZnZQQ1dHMVlpZDRJbUorN0t0?=
 =?utf-8?B?Qm1LWEM3MVkvVSt3SkF1MEFMckgzR2V2RS9wRHpSUnJLM01yNWxmWHQvNVBL?=
 =?utf-8?B?MDBFZlJ1bGZhK3M4L3VBS0ZzSG1VOUpNckQxLzJKRjVFZ1lyRVlNck5SaGxH?=
 =?utf-8?B?MWtPVGhzb2tnNmgxNUFxeEwyVzF3UnVUbDdpT3cwWHJtVVkrcXFteHdyUFUv?=
 =?utf-8?B?bFQ5cTVTbGN3SDhoZHU5aDFnK1FpTUJGU2hHOElzN01DVzJKZHVqblJ0bWYr?=
 =?utf-8?B?T0JuTTZvUVlKKzhlM2d4TS9pb1dyajlQKzE4YUF0b0R1UDdkU1djd2kxY0RG?=
 =?utf-8?B?ZW14UVdOYkpqY2lxbkZ4c2VLWG9DMXJaVFZsZllod3RWS1VoNjYyMEdnNVlO?=
 =?utf-8?B?d0pabGEzcnlwbWFZZlM2UXpMSVhjT1N6eC9pa0s2TG5wbW9mYzR0VDZzeUpG?=
 =?utf-8?B?MmFSOUVsc3NGTWwySXVpdHJWTDFmR3lnT2JCVUtXNC9JWWFXYXN2Q3FwVHB6?=
 =?utf-8?B?a2NhdHNwbE9xcUZJRHViajNPSzdYK0gxVkhBK0p6S0ViYkxnRGpPVGNWdnB0?=
 =?utf-8?B?K2E2MktTSjVpWkhadUFNeE1sMk0ya29RejlMK2p3ekVtdzJQeFdRdzFqWFh5?=
 =?utf-8?B?Z00vREw5THd6T1lHZXBzVG1lWThPV2xSdkN3SnU1SkRKcUt0R2JtK1BWMFJh?=
 =?utf-8?B?VVlMeEJzYjZkYlQxWkFwVEVXT3daNlRhQyt2SS85dE01R09ZL1FCZm9qVTVH?=
 =?utf-8?B?dlZyZkwyMENTZDBmRFdsZktMUWgvRU5MU01INVlTUVplcm9JU1M2Q3VtL2ti?=
 =?utf-8?B?V0ZIRktwRlFxYWpvVjFoSmV3VWNBaHZMUHJwVHBoN0F6RzNoRndXKzNtejJQ?=
 =?utf-8?B?WHlReERsb0Z6S1c1ZUY3RzNEOU5zUUNKNENSZ1NpajdrVHdpZlR2WWtsTDkr?=
 =?utf-8?B?MnJtS0dSTDNqMEtuTzBOWkUrUThsL0J6NnVRaVhnZW1GNUV2Wkc5c0dSZ2w0?=
 =?utf-8?B?L2xYbzBKSmZGRWFpZlZCZ1plYmtxd2hqUHoreXJhd21DRGhQU2NhSkV4WmNh?=
 =?utf-8?B?Uk02eStCMTJaZHlUbXVVSkVpVUYwOUIrS3RwMjU4MUs2N3hUK2hBUnBOelcv?=
 =?utf-8?B?c0M0ZUdKTW9aVWlqeWtLWmdtbWJrMGZxNzlFeFJsMkdQWUNnZTQraWM2VEZZ?=
 =?utf-8?B?Z3dOdFVTQ2Q4WE1ndGF1b1E0cmJkVmpuNzhWd0E4Yk5RdDN3VWJEei9OTzg5?=
 =?utf-8?B?Y2I2dlMvWTRvWllKNnA3WURuWFcrYUgyQWN1eXlzUDd1ejZyYUdha2NqdnNx?=
 =?utf-8?B?QlM1bUR2dUhxai9YejczK3k4TWZzdGI4YmtvMStPZWM4RHJYeHZYY3lPc3Y3?=
 =?utf-8?B?ZVRoTmRhejlpeWVpY3k4Z1V0Sysxdmg0dG9SWHMwUTBGVEV2MXBBOGErb2lm?=
 =?utf-8?B?YUJ6dFBCRXJ0MjkzTENmczFlQ1NkcGEwN0VvdnNadGtwczhzWkVWL2Y5Tzlp?=
 =?utf-8?B?ZTFtSVZ3a0NDU3BJZFkrTU5aVTY3RXF5THc1bEVOTmQwTXY1SERkRU1PU2to?=
 =?utf-8?B?eFJ6R0JpVFZOTlRqWEduOWlnbDNXaW05MjNwWldCdlNWNHBwNEhLc2k2eXll?=
 =?utf-8?B?dng0WGx4TURnbEJNWXBBLzc5ZnhPeFp2YWlNYkUzNVJ6RnN4d2xnaTlqL3pV?=
 =?utf-8?B?ZmRuZE42VzFiaEs2M00vWWVGY2NCeTF0ZzJteUxLSys5emtIRHA3by9kMjVz?=
 =?utf-8?B?VEZGdkVFekpFQ2pSU2lTREJMZ3ViNjZTNWl1YTVFWCtpY0RIcnF4dWdlakov?=
 =?utf-8?Q?6CaUyb9vVWnDNB5I6kcOeVpR4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ed087b-e849-4f9a-fe4e-08dd67c6afc5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:48:40.9457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMhPVe+j8Hj2fr1AAP4gY4ZI72+r79Ca/HqFBg2jYf9AT3p/psUNURoe20tDYUOxdqvxNn8UJvxGtNYzZ5Qp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
Received-SPF: permerror client-ip=40.107.100.72;
 envelope-from=dtatulea@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi Lei,

On 03/20, Lei Yang wrote:
> Hi Dragos, Si-Wei
> 
> 1.  I applied [0] [1] [2] to the downstream kernel then tested
> hotplug/unplug, this bug still exists.
> 
> [0] 35025963326e ("vdpa/mlx5: Fix suboptimal range on iotlb iteration")
> [1] 29ce8b8a4fa7 ("vdpa/mlx5: Fix PA offset with unaligned starting iotlb map")
> [2] a6097e0a54a5 ("vdpa/mlx5: Fix oversized null mkey longer than 32bit")
> 
> 2. Si-Wei mentioned two patches [1] [2] have been merged into qemu
> master branch, so based on the test result it can not help fix this
> bug.
> [1] db0d4017f9b9 ("net: parameterize the removing client from nc list")
> [2] e7891c575fb2 ("net: move backend cleanup to NIC cleanup")
> 
> 3. I found triggers for the unhealthy report from firmware step is
> just boot up guest when using the current patches qemu. The host dmesg
> will print  unhealthy info immediately after booting up the guest.
> 
Did you set the locked memory to ulimite before (ulimit -l unlimited)?
This could also be the cause for the FW issue.

Thanks,
Dragos

> Thanks
> Lei
> 
> 
> On Wed, Mar 19, 2025 at 8:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >
> > Hi Lei,
> >
> > On 3/18/2025 7:06 AM, Lei Yang wrote:
> > > On Tue, Mar 18, 2025 at 10:15 AM Jason Wang <jasowang@redhat.com> wrote:
> > >> On Tue, Mar 18, 2025 at 9:55 AM Lei Yang <leiyang@redhat.com> wrote:
> > >>> Hi Jonah
> > >>>
> > >>> I tested this series with the vhost_vdpa device based on mellanox
> > >>> ConnectX-6 DX nic and hit the host kernel crash. This problem can be
> > >>> easier to reproduce under the hotplug/unplug device scenario.
> > >>> For the core dump messages please review the attachment.
> > >>> FW version:
> > >>> #  flint -d 0000:0d:00.0 q |grep Version
> > >>> FW Version:            22.44.1036
> > >>> Product Version:       22.44.1036
> > >> The trace looks more like a mlx5e driver bug other than vDPA?
> > >>
> > >> [ 3256.256707] Call Trace:
> > >> [ 3256.256708]  <IRQ>
> > >> [ 3256.256709]  ? show_trace_log_lvl+0x1c4/0x2df
> > >> [ 3256.256714]  ? show_trace_log_lvl+0x1c4/0x2df
> > >> [ 3256.256715]  ? __build_skb+0x4a/0x60
> > >> [ 3256.256719]  ? __die_body.cold+0x8/0xd
> > >> [ 3256.256720]  ? die_addr+0x39/0x60
> > >> [ 3256.256725]  ? exc_general_protection+0x1ec/0x420
> > >> [ 3256.256729]  ? asm_exc_general_protection+0x22/0x30
> > >> [ 3256.256736]  ? __build_skb_around+0x8c/0xf0
> > >> [ 3256.256738]  __build_skb+0x4a/0x60
> > >> [ 3256.256740]  build_skb+0x11/0xa0
> > >> [ 3256.256743]  mlx5e_skb_from_cqe_mpwrq_linear+0x156/0x280 [mlx5_core]
> > >> [ 3256.256872]  mlx5e_handle_rx_cqe_mpwrq_rep+0xcb/0x1e0 [mlx5_core]
> > >> [ 3256.256964]  mlx5e_rx_cq_process_basic_cqe_comp+0x39f/0x3c0 [mlx5_core]
> > >> [ 3256.257053]  mlx5e_poll_rx_cq+0x3a/0xc0 [mlx5_core]
> > >> [ 3256.257139]  mlx5e_napi_poll+0xe2/0x710 [mlx5_core]
> > >> [ 3256.257226]  __napi_poll+0x29/0x170
> > >> [ 3256.257229]  net_rx_action+0x29c/0x370
> > >> [ 3256.257231]  handle_softirqs+0xce/0x270
> > >> [ 3256.257236]  __irq_exit_rcu+0xa3/0xc0
> > >> [ 3256.257238]  common_interrupt+0x80/0xa0
> > >>
> > > Hi Jason
> > >
> > >> Which kernel tree did you use? Can you please try net.git?
> > > I used the latest 9.6 downstream kernel and upstream qemu (applied
> > > this series of patches) to test this scenario.
> > > First based on my test result this bug is related to this series of
> > > patches, the conclusions are based on the following test results(All
> > > test results are based on the above mentioned nic driver):
> > > Case 1: downstream kernel + downstream qemu-kvm  -  pass
> > > Case 2: downstream kernel + upstream qemu (doesn't included this
> > > series of patches)  -  pass
> > > Case 3: downstream kernel + upstream qemu (included this series of
> > > patches)  - failed, reproduce ratio 100%
> > Just as Dragos replied earlier, the firmware was already in a bogus
> > state before the panic that I also suspect it has something to do with
> > various bugs in the downstream kernel. You have to apply the 3 patches
> > to the downstream kernel before you may kick of the relevant tests
> > again. Please pay special attention to which specific command or step
> > that triggers the unhealthy report from firmware, and let us know if you
> > still run into any of them.
> >
> > In addition, as you seem to be testing the device hot plug and unplug
> > use cases, for which the latest qemu should have related fixes
> > below[1][2], but in case they are missed somehow it might also end up
> > with bad firmware state to some extend. Just fyi.
> >
> > [1] db0d4017f9b9 ("net: parameterize the removing client from nc list")
> > [2] e7891c575fb2 ("net: move backend cleanup to NIC cleanup")
> >
> > Thanks,
> > -Siwei
> > >
> > > Then I also tried to test it with the net.git tree, but it will hit
> > > the host kernel panic after compiling when rebooting the host. For the
> > > call trace info please review following messages:
> > > [    9.902851] No filesystem could mount root, tried:
> > > [    9.902851]
> > > [    9.909248] Kernel panic - not syncing: VFS: Unable to mount root
> > > fs on "/dev/mapper/rhel_dell--per760--12-root" or unknown-block(0,0)
> > > [    9.921335] CPU: 16 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6+ #3
> > > [    9.928398] Hardware name: Dell Inc. PowerEdge R760/0NH8MJ, BIOS
> > > 1.3.2 03/28/2023
> > > [    9.935876] Call Trace:
> > > [    9.938332]  <TASK>
> > > [    9.940436]  panic+0x356/0x380
> > > [    9.943513]  mount_root_generic+0x2e7/0x300
> > > [    9.947717]  prepare_namespace+0x65/0x270
> > > [    9.951731]  kernel_init_freeable+0x2e2/0x310
> > > [    9.956105]  ? __pfx_kernel_init+0x10/0x10
> > > [    9.960221]  kernel_init+0x16/0x1d0
> > > [    9.963715]  ret_from_fork+0x2d/0x50
> > > [    9.967303]  ? __pfx_kernel_init+0x10/0x10
> > > [    9.971404]  ret_from_fork_asm+0x1a/0x30
> > > [    9.975348]  </TASK>
> > > [    9.977555] Kernel Offset: 0xc00000 from 0xffffffff81000000
> > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > [   10.101881] ---[ end Kernel panic - not syncing: VFS: Unable to
> > > mount root fs on "/dev/mapper/rhel_dell--per760--12-root" or
> > > unknown-block(0,0) ]---
> > >
> > > # git log -1
> > > commit 4003c9e78778e93188a09d6043a74f7154449d43 (HEAD -> main,
> > > origin/main, origin/HEAD)
> > > Merge: 8f7617f45009 2409fa66e29a
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Thu Mar 13 07:58:48 2025 -1000
> > >
> > >      Merge tag 'net-6.14-rc7' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > >
> > >
> > > Thanks
> > >
> > > Lei
> > >> Thanks
> > >>
> > >>> Best Regards
> > >>> Lei
> > >>>
> > >>> On Fri, Mar 14, 2025 at 9:04 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
> > >>>> Current memory operations like pinning may take a lot of time at the
> > >>>> destination.  Currently they are done after the source of the migration is
> > >>>> stopped, and before the workload is resumed at the destination.  This is a
> > >>>> period where neigher traffic can flow, nor the VM workload can continue
> > >>>> (downtime).
> > >>>>
> > >>>> We can do better as we know the memory layout of the guest RAM at the
> > >>>> destination from the moment that all devices are initializaed.  So
> > >>>> moving that operation allows QEMU to communicate the kernel the maps
> > >>>> while the workload is still running in the source, so Linux can start
> > >>>> mapping them.
> > >>>>
> > >>>> As a small drawback, there is a time in the initialization where QEMU
> > >>>> cannot respond to QMP etc.  By some testing, this time is about
> > >>>> 0.2seconds.  This may be further reduced (or increased) depending on the
> > >>>> vdpa driver and the platform hardware, and it is dominated by the cost
> > >>>> of memory pinning.
> > >>>>
> > >>>> This matches the time that we move out of the called downtime window.
> > >>>> The downtime is measured as checking the trace timestamp from the moment
> > >>>> the source suspend the device to the moment the destination starts the
> > >>>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> > >>>> secs to 2.0949.
> > >>>>
> > >>>> Future directions on top of this series may include to move more things ahead
> > >>>> of the migration time, like set DRIVER_OK or perform actual iterative migration
> > >>>> of virtio-net devices.
> > >>>>
> > >>>> Comments are welcome.
> > >>>>
> > >>>> This series is a different approach of series [1]. As the title does not
> > >>>> reflect the changes anymore, please refer to the previous one to know the
> > >>>> series history.
> > >>>>
> > >>>> This series is based on [2], it must be applied after it.
> > >>>>
> > >>>> [Jonah Palmer]
> > >>>> This series was rebased after [3] was pulled in, as [3] was a prerequisite
> > >>>> fix for this series.
> > >>>>
> > >>>> v3:
> > >>>> ---
> > >>>> * Rebase
> > >>>>
> > >>>> v2:
> > >>>> ---
> > >>>> * Move the memory listener registration to vhost_vdpa_set_owner function.
> > >>>> * Move the iova_tree allocation to net_vhost_vdpa_init.
> > >>>>
> > >>>> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.
> > >>>>
> > >>>> [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
> > >>>> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
> > >>>> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/
> > >>>>
> > >>>> Eugenio Pérez (7):
> > >>>>    vdpa: check for iova tree initialized at net_client_start
> > >>>>    vdpa: reorder vhost_vdpa_set_backend_cap
> > >>>>    vdpa: set backend capabilities at vhost_vdpa_init
> > >>>>    vdpa: add listener_registered
> > >>>>    vdpa: reorder listener assignment
> > >>>>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
> > >>>>    vdpa: move memory listener register to vhost_vdpa_init
> > >>>>
> > >>>>   hw/virtio/vhost-vdpa.c         | 98 ++++++++++++++++++++++------------
> > >>>>   include/hw/virtio/vhost-vdpa.h | 22 +++++++-
> > >>>>   net/vhost-vdpa.c               | 34 ++----------
> > >>>>   3 files changed, 88 insertions(+), 66 deletions(-)
> > >>>>
> > >>>> --
> > >>>> 2.43.5
> > >>>>
> > >>>>
> >
> 

