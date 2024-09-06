Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EC7E6FE2D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbHP-00040t-8Q; Fri, 06 Sep 2024 11:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smbHN-0003vR-Qp
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:53:45 -0400
Received: from mail-dm3nam02on2055.outbound.protection.outlook.com
 ([40.107.95.55] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smbHL-00008z-1t
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:53:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHyXRUM5G/0CtOwnxVirbGbGOfkPVYtcrG15FWFY88NG35cM1JEpEEVmBro4KmiQ/UShibxezUUqrvF8yH3+NhtsxCoot/hQX7jd4V2FelDXY3Isun8QSqSdw7NYkEiwrxZw9VlX64W25NMSxl8z9uxljxr43CXTX8JujySGOTLTdWeK7ZUjHUMjbaVMjnbSoLJqrg2winjPnVsyNbadkknfC9Y/3dm3gPS31bbWrkEzBpJ8UQnwsjkU8iVx24VWrmeX8F2Hfu2HsR8apX2QeWImqqlZf3P3wWYXIyxiRZkuwTW8Mkvqwj/gDhLSe5srY1fI/P0DlcUmD65fQt0ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xXH9Fx7DenTzXf2RPt8W5frKpcAHw0y2MW4LSIk8m8=;
 b=CINa0g9RrVi2KJ4O+GkZ3xD6cHlcjqQ2tWa5evD4+hBkdu+0dGcVYDPv8PYhsSMlVTlOP4SF9krfwMxDZzSB0rg4TJml/SZxhQN+qmeYtEbuwH56F1qUsmm86NkgDOMYAweGVUSBQWfo+cG4Yo6jDj4fgXp8Zve36fBQWoDvTBVmpxD3D5uo8x+gnUikOkeXQV5cxDKrSneR0hquCAuX4MdvwscvPzAULvJ+OhXij/vFr/Nlqd8L9bUHjPkawGyOLxdzcC+VVWh55OP0vGagPLw/vQ71lEJtY696DwtW6YmcAocn64KFcG9q07wpjh3OYV4SryFceZGzIsLTAuHxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xXH9Fx7DenTzXf2RPt8W5frKpcAHw0y2MW4LSIk8m8=;
 b=liy18QtSilRdgPxEk/GsiG7vzQYmOr96Nfc37XZf4iTWMMNc/tX7jc9HrPvK6TJ+lcOMwSEOmB/pFBhqIkgYpxks9FCKEEgXK5H60R5jzsvXno5To8rGCAOrq0BbUT2ooI7B/V7mBhNdik678uBXfR5dQ3bPUvW3qLawDHkSTIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 15:48:35 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 15:48:35 +0000
Date: Fri, 6 Sep 2024 17:48:23 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Doug Brown <doug@schmorgal.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 0/7] hw/net/can/xlnx-versal-canfd: Miscellaneous fixes
Message-ID: <ZtskR0bKaZDTcs0o@xse-figlesia-l2.amd.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <CAFEAcA_KEMTT8i8EhnYOgGCeGEEn093N2UF5kiFJ-YZFD3XSLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_KEMTT8i8EhnYOgGCeGEEn093N2UF5kiFJ-YZFD3XSLw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0123.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::20) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: c516f942-50ea-481f-87f2-08dcce8b5e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVVqQkhlRGVpTWlueDBDR0RYS0YvenBRbERJS1U4aXRPWDZQVmZNdUM5OTlo?=
 =?utf-8?B?NXNLT0l3cGUxVkM0NmdBRHUybVd4Qy9Xa0lORmJDTTJnRTcvU29CQjVOaERo?=
 =?utf-8?B?T1JFRlgvcUE3V3M2SjJiSVFnSjVkY0I4UGhJRFRGT21BSWZlSXlHZFl3ZVpy?=
 =?utf-8?B?WkdyUFpXOE1LWHZtSE91SjZPNTdOWkdTQ0FKdU5YejB0cGQraWF4eVpZd2tm?=
 =?utf-8?B?MFZBWHpNZTF2enh3cTNqOEI4bFRYYlFXQ1Y5U1pFejVuZEJTeFRlMGwwTVNt?=
 =?utf-8?B?R29xdXp0dC9uT1I4dVdUUklEbjdVbnNreGdONUhlbFRlQlpaYkFHOGFqaG9S?=
 =?utf-8?B?R0hUR3hYZVNRQVNpRndURDE4L2w2QjZnY0NPQXJTOEttQ3dCMHc0Y0h3ek1L?=
 =?utf-8?B?YTBRakMvcEpKQk1Ob2MvVGtqVVVYZ3RzUUt0cmxwK0F1UXZaaWhuOER6TzFH?=
 =?utf-8?B?V25sOEwrV25Mc2xJa05hK3FNWEVnSi84cDhmM2FkcHBBa21SUks1VEtEN3Y4?=
 =?utf-8?B?RThTblZWdnVMZTJya0JTNXlleUsxSzZtRjdSeUhTcDB2U21pWFF0WmtOb1Zz?=
 =?utf-8?B?cWMvUVRWY1IxTUV4UmFJTG45eFgzTWk0ZTYrR0NqMG5qTXFKek5qaUliNDlI?=
 =?utf-8?B?OWFtY2t4VFJzT3ErT1dmeHhNdlRjKzVGaUlwNnpybzVwZXZTMGxneGRONXVL?=
 =?utf-8?B?M2ZRaHppV0MvL0xRMHphaGsrbDRtNTdYblYzS084NTBUZkhkZnZ1bjhPc2VR?=
 =?utf-8?B?YUM1NnkxSnIxUFRNUmIyb3UxNDdOTElWclRDWTZtbWxPSXNNS2NVaWw2S1Zi?=
 =?utf-8?B?cVFjRXBaNTR1eGRsd2pqQk9UKzhEVDhUdWtmMWUxd1hSN01xRE1SNnFnTER3?=
 =?utf-8?B?ZVlVTjdrdGhPTmRwbXNFUHZVUDVudVhlZFBnQnZGL2NOWnZxdnhFbW92V2ty?=
 =?utf-8?B?dFdXeUxuYnlwUlduUHYwU3RaenZBU3Evd3A4Mk1aMXVBTVhzY0cvMVRYQ3Ay?=
 =?utf-8?B?SHlxZEdaZ2tPQkFmWWF6bTlsQVd2RUlDUm1ZMmV4TWF6S2MweHhUNHVwWFRK?=
 =?utf-8?B?amJaR0h2cWhMQ3lqbThYdWp3b0tEWXFoZU4xd2JldEoyUzVtbjJnQ2JKazZX?=
 =?utf-8?B?c1RkSEpJeGdZTUloVGJ5S3VMcEhNcWFDbTl2VVdPQTBPV0Y4ay95M2N6cHJW?=
 =?utf-8?B?Y3MyaXN0SnhzWlgzQ01jMldXNUFTQ0VsUXZWQ0JXdkcxQks4aVpKYmZ4bk1F?=
 =?utf-8?B?R3FNK1hHZ2FnODhxSUpYMFFzOERQaWhKOW9CVDNDcjJPL0ZETlRsNWE4Kzda?=
 =?utf-8?B?ME03L3hkZUNLd1FoVG5sb0lZNHBCNWlkL0RzMDFqQ1VQS1l2UklvbTN2cm9p?=
 =?utf-8?B?TzFJUXorUzB3TDhSeW5vY2EwbEl0cW92NEc5WVNYRkJLVFZSOUNhVU9XMjdY?=
 =?utf-8?B?aExWY2JnQ3RlNVNEK0dxcFpKaU1pQldhdmVZYnJuVmhta1drU2JvWThuek5j?=
 =?utf-8?B?Q25ScGZmZXNNb2lVaDBQb29rQTJWL25JODBEQ3dXTys0aHlmY3U1UUJaVWtY?=
 =?utf-8?B?UDVtUUNlNTBvaEdlVm91OHM1WnJ4TlNZVnpCSktKWmM2eUJTOUtxRkNkRTZK?=
 =?utf-8?B?STE0UjU0ZnJqSit3TE9yRnZzUk5SdWw2cjBZUnViTGJnUG1uVnZUV2s3Qys0?=
 =?utf-8?B?b0x1UTBJNThNbkRydmdLQzNjZmhYYkxpUklUNTNxNE1VN2wreVdvY2pyZHAw?=
 =?utf-8?B?LzBhNitaQXUyMi8xcmpSOGZ1SlFzVGNZV09YM2l3bHFsUENmRWhEZml0NjRo?=
 =?utf-8?B?QThlNDljRG11eFhSZ2huUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9jN2RiTzB4S1JQMTNBeTRHVHk1NEhEWGpWb0ZYV0lpMDFaOEdpMENyR0oy?=
 =?utf-8?B?UjdxU0RtUjhzUUxBaUZhTjhjK1VUNXJXOTJqVXFmdVlIRVp4dnFrWlFwWTRH?=
 =?utf-8?B?SU11eElqMmhjQVhjczJGZFZTYWJiejd2RFdWK0hmbjhiV1IvMW9HSkZDd0pP?=
 =?utf-8?B?VGRaNEJvWXBtMXh3eGJsY0ZUTENZK3hHZFZ5RDhRVncrb0xIeDRzbjY1dzhs?=
 =?utf-8?B?UTZlcEg1MnNtY0pKN2hnK2JEWUh0K2dtR0RVenRIVTV4ZVMzeU55bG9hUGRP?=
 =?utf-8?B?ckp0MHVQalZlTHMwK0lyc3dlaHQySUpZZVUwalpRQ1hTWHRza3Z6VTg0QXNM?=
 =?utf-8?B?dnJhZlo4OGM2dUErdUd6UVliRWJQNE5vV0JBa1YwU3hiWmdPdzFQeEZoRFlZ?=
 =?utf-8?B?L0ZkTkZDRFUyVi9Qdmp0UjdYVUV6THVtMmFXSEpoOVQza1hMZENRZGtjdXp6?=
 =?utf-8?B?U1NsVWx6bEZmS3IwV3dZNm9KV2NNZ1BnRzFoRkpjemdOT1VXTlVTRXBRVlNR?=
 =?utf-8?B?S0JMTzNrdmFHTVVUSkcyY0RsZWM1bGFqVUszSlpoWDU0aHdGbTlmdGFKS0o2?=
 =?utf-8?B?STM1UTJQRFhWR2JaTVkvc2dUbXZQR2xKUEQxc2svTEZSZzN6UEJmQk5sSldm?=
 =?utf-8?B?a29UOTdEQVE1YjRkalR4enBTcmxMVkJ5L0t4a0FPOVdDWmxWNy9GejE3aWFj?=
 =?utf-8?B?a21HTHJlUE1ZNS94L2MyVHFaTU56dEYzT0N3RHlLUHBnWkhWeG5WL092MUpE?=
 =?utf-8?B?OVJEaVRncmpHNC92c2IrdGZIZ0lMK29OMFVjcmJlQjBTWHpWK3U5RnlqeE9h?=
 =?utf-8?B?VFdXc3pEQXRUNkJJTERjdUw1Vml4YTJQeUNjV3QvTHg3QnQ2MGhPVXdEakF4?=
 =?utf-8?B?TVJyLzFaeXhKN05rYXdTbG01cTNsZkNnUlRuN2o4ODg3UmFITEc4WHpiT1NS?=
 =?utf-8?B?TEFMT0FidlM2ZzYxQ2ZQQ01GZnQya3p0T3dlUWlrOGxqWEp5cUUrTHhGd3BO?=
 =?utf-8?B?enlOT1NxUnQ0TUVkcWhIdmsxZGh5K0FmMzdzanYrL0dzejBnQUd1TXJzWXFt?=
 =?utf-8?B?aldwdzVDMSs1Y3VjOVpzUWdwS01XenVZbGcreWdwcXhoZFcrSm96M1lmcHlT?=
 =?utf-8?B?Y0FPb0ZId0RaYmVaNlNvQlE1MnFpaEJRaWdsakp6K0lDcnQyVTVUUEdDSkU3?=
 =?utf-8?B?VlRZcHU2bzZlZ2JCTDZNYlROQk43MnkwZlZrai9aMFNIZHN0cFJnRzY0SU9V?=
 =?utf-8?B?WlBJTzFSdDNiSUhCZEc3VG8zd0VLT2ZubXMyV2o0SmdYSzZjWWpTZjFzMFd1?=
 =?utf-8?B?bjhwaVRSN2ljQ2E0MHo2dFp4TW5UMGt2Z0o4V1NxMUgxWkpZM0pJcGllN09V?=
 =?utf-8?B?dk4wVFZadUU4NVgxYlNiZXJqQ2tGN2UwL1JYaTdaVWhMQ29xRUFTMlBiTHdO?=
 =?utf-8?B?MkV0RGVEOVg0K2YxVXVBQXJDclZCTTFKN3hXL3VNUU5RclNJZlRXR29SQ2Ns?=
 =?utf-8?B?NVRkd1lwSmQ5TWZMYUE1TnUyZDNiVGFJeGNWUVJxaHZ3KzB1dEQzMTVHbkky?=
 =?utf-8?B?RVp0cnJWeUFMdGVmQXBROWc3RllrWGprM05HWnIzREZKSEZUYndObkU4TGlk?=
 =?utf-8?B?czgyRUpaODhCT1FjU1BIMUU0T1I2K0cwN093NzRkdm1zTnVHUGlBVHZVeE1r?=
 =?utf-8?B?NmhzRGg0WDRocll1QlpqWmpDRGdtSUpaay9JMmdRTzVkTFFzWStMWlVTME1y?=
 =?utf-8?B?M3hxcThsekZtVkR0MmtVSkxrblpPNi9FTHhWUVJnRFVmSkRyR1hxYXhBRytX?=
 =?utf-8?B?djRDVmpHWWhSWWVKSjdiUmVaNkJ2WFlrYW1NMjdZSkh5M01JZ0M4N2dpc1lr?=
 =?utf-8?B?dTNVM2NLenBVdHR2Q3JHSGFuNTFYTTdkVC9HNjVzcE40VU5EcFkzVFRURzNi?=
 =?utf-8?B?MmVIc1JNbFJjd05KQUZQS0crV3lQam1kNVcxWkhOYnFLb0tablRxREVvRUEw?=
 =?utf-8?B?REcvQmJGcDFMV2hlYzZmSTRUWjQ4VUFaenN5d3BYVE9td3A0Sms1RERsb2xy?=
 =?utf-8?B?MkExS3k3Witjb3RzWFRvMG9VYnp5dG41K1VDZWs5bitwQkk2SlQ3cndnSE10?=
 =?utf-8?Q?PWrY4yaHJECrGWwVCvhYDNQWq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c516f942-50ea-481f-87f2-08dcce8b5e07
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 15:48:35.5362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QTix/XpKDPxOguINf3q4iXMuD/WQwEX920vHxqOzSlM6oR3fDhT5AIyLmjCllu+nWe76H5Y9ndoSMI1LDj/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
Received-SPF: permerror client-ip=40.107.95.55;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

On Fri, Sep 06, 2024 at 03:36:10PM +0100, Peter Maydell wrote:
> On Tue, 27 Aug 2024 at 04:51, Doug Brown <doug@schmorgal.com> wrote:
> >
> > This series fixes several problems I ran into while trying to simulate
> > the AMD/Xilinx Versal CANFD controller in the xlnx-versal-virt machine
> > using Xilinx's v6.6_LTS_2024.1 kernel. With all of these patches
> > applied, everything works correctly alongside actual CAN devices.
> 
> Couple of Qs for the Xilinx/AMD folks:
>  (1) do you intend to review patch 7 of this series? That's
>      the one unreviewed one and it could use a look from
>      somebody familiar with how the versal canfd h/w works.
>      If you don't I propose to apply this series as-is next week.

I've started reviewing it (but got interrupted), I'll comeback later today.

>  (2) it sounds like Vikram Garhwal's AMD email is bouncing --
>      do you want to nominate somebody else to take his place
>      as co-maintainer/reviewer of CAN bus stuff?
>      If not, we can just drop his lines from MAINTAINERS.

I can take Vikram's place, I'll post a patch with the update.

Best regards,
Francisco

> 
> > - IRQs were accidentally not being delivered due to having a level other
> >   than 1. The IRQ count in /proc/interrupts in Linux was stuck at 0.
> > - Incoming CAN FD frames were being treated as non-FD.
> > - The CAN IDs were garbled in both RX and TX directions.
> > - The ESI and BRS flags were not being handled.
> > - The byte ordering was wrong in the data in both directions.
> > - Incoming CAN FD frames with DLC = 1-7 weren't handled correctly.
> > - The FIFO read_index and store_index wrapping logic was incorrect.
> >
> > I don't have any actual Versal hardware to compare behavior against, but
> > with these changes, it plays nicely with SocketCAN on the host system.
> >
> > Changes in v2:
> > - Added handling of ESI and BRS flags, ensured frame->flags is initialized
> > - Switched to use common can_dlc2len() and can_len2dlc() functions
> > - Added fix for FIFO wrapping problems I observed during stress testing
> >
> > Doug Brown (7):
> >   hw/net/can/xlnx-versal-canfd: Fix interrupt level
> >   hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
> >   hw/net/can/xlnx-versal-canfd: Translate CAN ID registers
> >   hw/net/can/xlnx-versal-canfd: Handle flags correctly
> >   hw/net/can/xlnx-versal-canfd: Fix byte ordering
> >   hw/net/can/xlnx-versal-canfd: Simplify DLC conversions
> >   hw/net/can/xlnx-versal-canfd: Fix FIFO issues
> >
> >  hw/net/can/xlnx-versal-canfd.c | 173 ++++++++++++++-------------------
> >  1 file changed, 72 insertions(+), 101 deletions(-)
> 
> thanks
> -- PMM

