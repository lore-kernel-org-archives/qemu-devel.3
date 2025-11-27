Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBB0CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObx1-0003vd-GE; Thu, 27 Nov 2025 08:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vObwy-0003mh-Ug
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:22:22 -0500
Received: from mail-norwayeastazon11023089.outbound.protection.outlook.com
 ([40.107.159.89] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vObww-0002Lz-Ng
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:22:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF7q6KNYaM3d0aznXuSFc0+tfksyM0bq22N+WKEaZxACqYAmpVzdCVwUbYiXP2IaE1O3lqphrACp9fIeD0EB3CvQycWVk1Erb24rDO/AT/L3l61TfcRBZ1+OcixgoXD14ryqQjYpVSe2iB6W9jzQ6Ahh3Qu8bm6JrzQk2W42Cs9SL8P4fB2jx0mfOfgkr7VoGOtRGkM8gThyo6Zrp2DKdl/ToFH2odgRxukP7oiszX70xONqXEqGyCZJsA549oSenx3Bgl+Lh6g8VNau1sQSofPO38OX+Elud+0IGmo3eSoiTFMAD8R8jH/jMoEuiesexWTmurTmzSy75Ih4Vt4waQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKfTPvSsRgiV8nH9hCbfYK5GTCzNFcqFvYvXehnyXuI=;
 b=isek6POfXuCS8UkH5vldHCHffebByN0ybUEkvS6fBW/4Lz8pXEilCW/M6QnQdtyHz1cqyfWicvd/XgBAwaHad0oiM3vSkMGJFK4+ocbQ+tURPTmSnYybOcc3Zp4dhdlSs9MfRlwQYFYoCiopLn7+9vMqRHS+p+ZgLG1WaTLEzk2Dsxn1vCYHQ15HkTLq782NJ7X/hT6fgdjqzrU0el2UqNA22+VsZ2qlkPK+M1C6+1W91MP8WUtHDd4LJl7VhstWSZ4JI6lyflHLJh/v4OclPRBI0EaImwjVTFQryMIiH0aPlUpFkM9ddOBm19AaXhuP6YSQ6kqqhEUpzNoCaxhzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKfTPvSsRgiV8nH9hCbfYK5GTCzNFcqFvYvXehnyXuI=;
 b=GMg8xIejej/C2uPnA8hSjz2kMwxKYPC4rGIs6zIKA1Yjy+aGswxE6dBRgzVEXEFzKQqgvt8PwwTkbOD03Ioxjls4duhYxYFL3jVGJb+x9m1WJfS67XXT4YEPmlQvXBpbxhAhwFibV3WKaKEW0AK3VBPH4YH1ZILvyCvoU6DB532i6WEEFZx+caVUZjWQmbYZFubpH1ySw+8zblG7t3KTfJDpYkVJr/Bw/XxcRDH5UuPG7V78s0ajH+SPLdoD7Ik2cPajUSIUpOw/QSIR9xNb6A8u1cm/EfhPCiev1anvklf1qz1dFjonJX4iEed34SGcA9o4cDccxmLw3zDy1QBfZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9588.eurprd08.prod.outlook.com
 (2603:10a6:10:45e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 13:17:11 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 13:17:11 +0000
Message-ID: <d5e75db3-5c5c-43d5-844c-b13a69c21d51@virtuozzo.com>
Date: Thu, 27 Nov 2025 15:14:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <20251126205857.GA595594@fedora>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20251126205857.GA595594@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a25a1c-e857-4567-0ced-08de2db745db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2UrYVcyWDFVN0x2dS9FZnFhdHowamtSU2ZnVmo0UUNHWklsMm01R3pwSGdY?=
 =?utf-8?B?YVNVMitaNGhSc0g5djVyMkgrV0R3YjJPYTYrQWxid0N5VHVUTmozeHNubko2?=
 =?utf-8?B?VXpROVNHZmpxSldEbndJVktYV3ZyNHhKY2VMeWNYV2R6UlMzNDdBL3l1c2hV?=
 =?utf-8?B?TTZUMDBaK1ZRNW5Xdk13TGdOYnJiZG1xMVIzc0hMQ3NkbWdyZmJNRnRBTC8v?=
 =?utf-8?B?N3lWU0VIc3ZXc0hnODFxZmFvQVVaUzZhckNzQzN2cFRIWHZJcG4yb0Z2Z0tR?=
 =?utf-8?B?VVBVV0VxbWEwejBvZXhLdU9kWGs5N1dCaXBkT1BIazdpelRsSTc0Ly9hZ3VM?=
 =?utf-8?B?VDNrc1FFWWZ2WHBIUDh3TFU3Tm45dk5wQkNYTnpZak4vRnZ5UE02b00yN2l2?=
 =?utf-8?B?cmxmMy82VmgwdGlXc0dQQXJSaHdXL3NvNEFNaUhHL0JIWmlmTk9NMll0cUcv?=
 =?utf-8?B?Yi9GcDFOc2IvMXRyMHkzUnJ6Y1UrV0YvZUFKbXVyTkNYaUtTRmtoSjBxMFc2?=
 =?utf-8?B?bmRIbHZtL3czOTY4OEJ3VHVNS2J5YnR0RXRKZmVWU3hQT1dmNE1CaDY0V20r?=
 =?utf-8?B?SHFHTmxWMmFOdzVSQXFjeWRGYWtmcWdkVldpTVJmRWZ5UlhBZlNBYmZoYU54?=
 =?utf-8?B?QXVMbmorRjBLQkdFUVN5NGZXekpLRGhOZFNJV3B5RXozVW51L2gvYSszMzNu?=
 =?utf-8?B?aEI2c0o1Nld4L0J1elNzQjNyT3Z5dnBQalAvRVJtckxKMkhFMHV5SmxzUkhJ?=
 =?utf-8?B?SG93Q0pIY3dPR2E0NXZGc2ZZRy9hTUxucVkvZzI4czJTd1l3S1BocjVZMm9P?=
 =?utf-8?B?cHludm1uUFZSaGNUUVZVNmMyUHU0UVIvR3ZRS05ObjJXOGVqRm5tY2p2L3Y1?=
 =?utf-8?B?QTFhanVqUnhLQXJDWlVGZTA4Y1VVR2tCTUdNbE1mZlpiZ2g2NWFsaXhFRnNz?=
 =?utf-8?B?L0JQQVZ0T2JBTGRnV1lzSDIxb3ZGbmd2ZHFoT0ZQcHBraUk5OTNvbXJEWU9G?=
 =?utf-8?B?bGRJamR5QU9tN01FK3p0Sk5vMHFvWnlCa0lMUDZMWldBUDZzMUhWMGEwWVhh?=
 =?utf-8?B?T2FQdkF0dkdTdnFNQ3JiV1lWUDZSck5oWEQ0RnMzSmlRK20wRkcxUHMybDkx?=
 =?utf-8?B?Ykp6LzMwVTQ5OVhxSGVLWmRva0VDV1lPQ05hSTgyamd3Y0VoUmJIRFp2ZWtv?=
 =?utf-8?B?QUVaNW5sekpvckwxaWhSTldzcXhwa25HSGZpQmdkd0ZzL3F5aUY0bmx6cWwx?=
 =?utf-8?B?dFR5VTFOR2dtR0l4WWtha2dTY3B6OWhscFBTNWd4RFJKS3F2NDZmeWZmbTBr?=
 =?utf-8?B?TGloOEIxWDdpM1JnTUQwN0dCS2Jmc2ZhYTN5U3ZCSjFmcUxhdjJCK1hwS2Zn?=
 =?utf-8?B?azBIdXNpbEJLWitWYWw3cG1PQmxET2ZqNWpXU1lsdWNZMkxzMWQ2Z3luRGVx?=
 =?utf-8?B?aTJ0cEY3dDJCWVVJaU5ZeTRNbEZlNnU5VHp5T2dJRThqcDQxT1lwb0tMdXln?=
 =?utf-8?B?ampTa2RjWGtoNjZOc3pIQW9sTjJsODdUNUczdzd0S0hvczhlZUcxUHIwQk1Y?=
 =?utf-8?B?MGpTRnNLV256N1V6Ym95MjRraXR4eVJiamhtc3RxWGI5b2w4WVJNZFBqa0Zk?=
 =?utf-8?B?dFBwZ2FIcmNTRFZZZ0s4QUhIVG85MWRxdFd5T0tPVndqbFZnbGIrZGVqYXdR?=
 =?utf-8?B?U3d5eHR5RjBuYmtwbkhTaytLWE9QcUV5Y0NiWUZiUWxTOGVDQkdVQ08rcHZI?=
 =?utf-8?B?UUpVK2M4WnVRSjBLVjZYZW9ReFJWaDFieDNtMzN4MyttT0lCeEllTjJ3OExG?=
 =?utf-8?B?ekdpRWNLbkdvNEt3blBNVXpXam5PempjQjU2QjNOc3p2UFRtTEpRWFBwUkh2?=
 =?utf-8?B?OEI4U3dMWE9yR3pZZUltaTAvVnNUTXFtaDRyZW51Y1gwcURjcXMxR0ZuYVFC?=
 =?utf-8?Q?FWjAAb2Najc9+GzPcqNT08F4MEp/IlBD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJMZVQ0VTdXWmdrcG9vOUVUbkJGTmJIc0xlcW95SGxta01lck5NMG5rZGZR?=
 =?utf-8?B?NE9sN2ZBbmZQaXRSKytxRUZHTWozTVkwdjREdkJFVDZnQk5GWnF6bkpqK1Nt?=
 =?utf-8?B?dVpCNWFPYStYMmpEWCsrdTUvdXZLSFNzRGR4R1RvdjJ2MjQ2WU84elhQdWdm?=
 =?utf-8?B?N2s3MXhJQjBhRHd3Z3dCSlB5NFprY3BKejhKSVdlVnByQUFUOHpWTVhsSVVJ?=
 =?utf-8?B?ZS85MSt0UE9BcVVSL0k2RDVKTmtkV1pSekdtQ0NSa3hMc2pYY1NiaEYvSy9X?=
 =?utf-8?B?QVZqZTJWL3NVZkxNMXphbkJWMm5kS2praE5McUFjQUpualBRU3ZheFhPNDZL?=
 =?utf-8?B?ZWF1dWJLUHFHQkV5V2JFOExBVWo4bHVZcmRTbUlSZWpTNmM3MHhtaFBHUk9K?=
 =?utf-8?B?eHQvNXlNZC9QMlV4cVlLSE92OE9nSGNNWjlYSFg2QnJUb056WUhvNGM4QWZp?=
 =?utf-8?B?aFRHbmpjTEpGWE9MNkhqbWc0OGJYdWVNbXFyNnRpd1VQeURsZUdqaGcrTXp2?=
 =?utf-8?B?cmlaVGFCL2d1aVNkSk9EMTJXcHgwdWl5SkV1ZkRNanRkWG4zYlNabDdqZDFS?=
 =?utf-8?B?eE5CNXFrQzV0Z1l5NFV2ODZ2KzZSMUl1a1p5SlBES0F0a3AycHZQMFZkdlZH?=
 =?utf-8?B?eXVoNmpJcVRnT1o1OENXRmIwUnBxYklpUzIzVnZQTDlYS3dqUDdDQURhSC9C?=
 =?utf-8?B?aW1ZTDUvZjRwNlZ3TCtRRVFYZ1liMWpKQzJUR3VEQWlXaEdCVFlaZGtTdHFk?=
 =?utf-8?B?cGh5Q3NhbXhzckJJYUFMYnRWL3VFK1ZQSHhOdGIzRHdYT1JqcUowaUxGTnpr?=
 =?utf-8?B?d0tMdWM3ZHBDcFZMWGd2cGd3em1IWkZiVWZMckEvVDFPYnh6MFBzVWxBSGVl?=
 =?utf-8?B?VWQyVUs2Q24yaEdiTGRkSy9XL3doZFFraEFCMDgzejFjaElvbHNDNi8wYVJS?=
 =?utf-8?B?dlJxZ3JmRUpaYU5pa0xxd2w0clRJMDNNMmY1ZUh5bzZaTWJRN3VxY0x1NDk5?=
 =?utf-8?B?TlBXWFpTYXRrT1RjN0lVekJuZ3FEbGpmNjhZSDZTUEREcmdTR2xIL2VYNlhJ?=
 =?utf-8?B?U0owR25vZGpmRWVmMFhtNUlNb0NYMU1vZldRbU5rMHB5M3ZvT01WRzVxRzRH?=
 =?utf-8?B?R2RValYxakkzc05LdllIclUrczJIczF2TjdFSFdvNFRFK1V1YjBPMnd0Z3Zo?=
 =?utf-8?B?U04vMEZQRFFLU3RmT3p1Z0RTN2xqdzVTRlk4OHBBY3hwYy9GZEU0TFRUOVdD?=
 =?utf-8?B?akY5SnI4RmhKb3RVZ1E1VnVIbDgyK3B4QnIzUTVGNFRWWXhnNzlXRUcvK0lm?=
 =?utf-8?B?azVlVVdGS1daMkpGQ2V6OUtZMVBSU3BuMzBEK0MzdjRxL2JtZTVDUnJkUnFP?=
 =?utf-8?B?U1Q2amdQekI0bUp6K0ZZR2xtRG5DTzRneTE4U2lKVUVWbURxSXVrMFdEN2ZW?=
 =?utf-8?B?MzRpTG5keldGNGExTmY0K1FjZWo0dmtkUWsvZjVIVVBkeU1wQXE2UWV1U1g2?=
 =?utf-8?B?S2hnU0o5Y2dXVHYyVFNka3NzQXFzWksyMHhlamtZMHFSS0ZES0Nldm83dkti?=
 =?utf-8?B?KyttK0xpNXpmVlRhQ21IemNiZWNrL25JNlk5RllKcmJOMjFUR01YRUZxaFZF?=
 =?utf-8?B?dGhma1dJSnFkOWxQVUlNTGRnMFJRdm85THluRGJBSUFVMFJ4NmxRMFdTeWJp?=
 =?utf-8?B?RkYrc2UyNnZZbDhBZEpQOExMdlNGTkNXTmFlZkhSVGt0MDk2SlFGYzczdzV5?=
 =?utf-8?B?bkRVZVQwaEVRVUhPeUFrM2tvMXh3eksvY1dic2NrRTAzVWZkM3lSTWhwV3Rs?=
 =?utf-8?B?N3I3WHJOZVB4Mm45OXYyQ2htc1dCc1VRZHUrRCtKVGFTWExuTHpHaUxXN3Za?=
 =?utf-8?B?aFFETHJLZ2tpaHh6S1lpQ1FnVkZTR1ROd2J1TjN0ZEJhdkd1eEQwRmc5TkRK?=
 =?utf-8?B?dTMvWkVFcmk3Y2tCL1l3WFhDc1pUTVV5MWlXRWY1RFZ2bjFwL05aZGxibDNB?=
 =?utf-8?B?VW5aVHN0VStCNUxxL0EwL0VzdjBIYjNjcTNBbUNWRmQzQzhiUEpzbGhET25q?=
 =?utf-8?B?T0EwOWpQbGcwNnM2UlVtYkJTcWFlNVVNNFhQWElDb3M1WWVWRnpFSEdIdExm?=
 =?utf-8?B?YXo3RG55b05oaGphdTdPZnd5MXJaRld3a05PZjNFRXhNbCsyME14SU9zR3BU?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a25a1c-e857-4567-0ced-08de2db745db
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 13:17:10.9983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTWs2pwbG6zK83JaFqbVMFP9N1e83AjLyWjt+zX0e4ex8yCwJS06pv3+4JA9kM58lDgaeyWqoUTegvsIR1W5ODE1ShBNk2D5PVMgHeaU9x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9588
Received-SPF: pass client-ip=40.107.159.89;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 11/26/25 10:58 PM, Stefan Hajnoczi wrote:
> On Tue, Nov 25, 2025 at 04:21:05PM +0200, andrey.drobyshev@virtuozzo.com wrote:
>> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>
>> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
>> coredumps") introduced coroutine traces in coredumps using raw stack
>> unwinding.  While this works, this approach does not allow to view the
>> function arguments in the corresponding stack frames.
>>
>> As an alternative, we can obtain saved registers from the coroutine's
>> jmpbuf, copy the original coredump file into a temporary file, patch the
>> saved registers into the tmp coredump's struct elf_prstatus and execute
>> another gdb subprocess to get backtrace from the patched temporary coredump.
>>
>> While providing more detailed info, this alternative approach, however, is
>> quite heavyweight as it takes significantly more time and disk space.
>> So, instead of making it a new default, let's keep raw unwind the default
>> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
>> command which would enforce the new behaviour.
> 
> Wow, that's a big hack around GDB limitations but I don't see any harm
> in offering this as an option.
> 
>>
>> That's how this looks:
>>
>>   (gdb) qemu coroutine 0x7fda9335a508
>>   #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/coroutine-ucontext.c:321
>>   #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/qemu-coroutine.c:293
>>   #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:547
>>   #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
>>   #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
>>   #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
>>   #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
>>   #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thread-posix.c:393
>>
>>   (gdb) qemu coroutine 0x7fda9335a508 --detailed
>>   patching core file /tmp/tmpq4hmk2qc
>>   found "CORE" at 0x10c48
>>   assume pt_regs at 0x10cbc
>>   write r15 at 0x10cbc
>>   write r14 at 0x10cc4
>>   write r13 at 0x10ccc
>>   write r12 at 0x10cd4
>>   write rbp at 0x10cdc
>>   write rbx at 0x10ce4
>>   write rip at 0x10d3c
>>   write rsp at 0x10d54
>>
>>   #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=0x7fda9335a508, to_=0x7fda8400c280, action=COROUTINE_ENTER) at ../util/coroutine-ucontext.c:321
>>   #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=0x5602bf7147c0, co=0x7fda8400c280) at ../util/qemu-coroutine.c:293
>>   #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=0x5602bf7147c0) at ../util/async.c:547
>>   #3  0x00005602bdb3b518 in aio_bh_call (bh=0x5602bf714a40) at ../util/async.c:172
>>   #4  0x00005602bdb3b79a in aio_bh_poll (ctx=0x5602bf7147c0) at ../util/async.c:219
>>   #5  0x00005602bdb10f22 in aio_poll (ctx=0x5602bf7147c0, blocking=true) at ../util/aio-posix.c:719
>>   #6  0x00005602bd8fb1ac in iothread_run (opaque=0x5602bf42b100) at ../iothread.c:63
>>   #7  0x00005602bdb18a24 in qemu_thread_start (args=0x5602bf7164a0) at ../util/qemu-thread-posix.c:393
>>   #8  0x00007fda9e89f7f2 in start_thread (arg=<optimized out>) at pthread_create.c:443
>>   #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: Peter Xu <peterx@redhat.com>
>> Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  scripts/qemugdb/coroutine.py | 126 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 115 insertions(+), 11 deletions(-)
>>
>> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
>> index e98fc48a4b..b1c7f96af5 100644
>> --- a/scripts/qemugdb/coroutine.py
>> +++ b/scripts/qemugdb/coroutine.py
>> @@ -10,6 +10,13 @@
>>  # or later.  See the COPYING file in the top-level directory.
>>  
>>  import gdb
>> +import os
>> +import re
>> +import struct
>> +import shutil
>> +import subprocess
>> +import tempfile
>> +import textwrap
>>  
>>  VOID_PTR = gdb.lookup_type('void').pointer()
>>  
>> @@ -77,6 +84,65 @@ def symbol_lookup(addr):
>>  
>>      return f"{func_str} at {path}:{line}"
>>  
>> +def write_regs_to_coredump(corefile, set_regs):
>> +    # asm/ptrace.h
>> +    pt_regs = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10',
>> +               'r9', 'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax',
>> +               'rip', 'cs', 'eflags', 'rsp', 'ss']
>> +
>> +    with open(corefile, 'r+b') as f:
>> +        gdb.write(f'patching core file {corefile}\n')
>> +
>> +        while f.read(4) != b'CORE':
>> +            pass
>> +        gdb.write(f'found "CORE" at 0x{f.tell():x}\n')
>> +
>> +        # Looking for struct elf_prstatus and pr_reg field in it (an array
>> +        # of general purpose registers).  See sys/procfs.h
>> +
>> +        # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
>> +        f.seek(4, 1)
>> +        # lseek(f.fileno(), 112, SEEK_CUR): offsetof(struct elf_prstatus, pr_reg)
>> +        f.seek(112, 1)
>> +
>> +        gdb.write(f'assume pt_regs at 0x{f.tell():x}\n')
>> +        for reg in pt_regs:
>> +            if reg in set_regs:
>> +                gdb.write(f'write {reg} at 0x{f.tell():x}\n')
>> +                f.write(struct.pack('q', set_regs[reg]))
>> +            else:
>> +                # lseek(f.fileno(), 8, SEEK_CUR): go to the next reg
>> +                f.seek(8, 1)
>> +
>> +def clone_coredump(source, target, set_regs):
>> +    shutil.copyfile(source, target)
>> +    write_regs_to_coredump(target, set_regs)
>> +
>> +def dump_backtrace_patched(regs):
>> +    files = gdb.execute('info files', False, True).split('\n')
>> +    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
>> +    dump = re.search("`(.*)'", files[2]).group(1)
>> +
>> +    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
>> +        tmpcore = f.name
>> +
>> +    clone_coredump(dump, tmpcore, regs)
>> +
>> +    cmd = ['script', '-qec',
>> +           'gdb -batch ' +
>> +           '-ex "set complaints 0" ' +
>> +           '-ex "set verbose off" ' +
>> +           '-ex "set style enabled on" ' +
>> +           '-ex "python print(\'----split----\')" ' +
>> +           f'-ex bt {executable} {tmpcore}',
>> +           '/dev/null']
>> +    out = subprocess.check_output(cmd, stderr=subprocess.DEVNULL)
> 
> Is script(1) necessary or just something you used for debugging?
> 
> On Fedora 43 the script(1) utility isn't installed by default. Due to
> its generic name it's also a little hard to find the package name
> online. It would be nice to print a help message pointing to the
> packages. From what I can tell, script(1) is available in
> util-linux-script on Red Hat-based distros, bsdutils on Debian-based
> distros, and util-linux on Arch.
> 
> [...]
My sole purpose for using script(1) was to make GDB subprocess produce
colored stack trace output, just like what we get when calling 'bt' in a
regular GDB session.  I just find it easier to read.  So, unless there's
an easier way to achieve that same result, I'd prefer to keep using
script(1).

But your point is of course valid -- I didn't think of the case when
script(1) program might not be installed.  Since we're just decorating
the output here, instead of failing with a help message I'd suggest
simply checking whether script(1) binary is present in the system with
smth like shutil.which(), and only using it if it is.  I'll update the
patch accordingly, if there're no objections.

Andrey

