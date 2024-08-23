Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EAFC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shXmI-0003By-DD; Fri, 23 Aug 2024 13:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shXmG-0003BG-Rf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:08:44 -0400
Received: from mail-bn8nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2418::607]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shXmD-00045k-6C
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsHPtNruav7BIBF4JPaY+iYnDscFr4/7dSohw+R7CXUhMOc1RbVGsoFT8GsNb4YOkaxQdRkjnWntIN2L/MV2mfy42uybEt6EIRoO0tAu3sXFZASYGktTAAnw5DBhMm6E7u/tCxgNziUknrWzxn2/qFHLfBUy43gH4PORJxSGb2n1Me4dpcz7DhqP1lK4PjMw7j0J/WyZj3Dwds6uHy/Ap5yc3QlYBQjCT9ckbb8mtuLVjAgVzq5eAQ2F0d8C0FKlt2563enfSMadg5tgLnta6oU2gTh/67IqiuHZ82ZaKb+F6zEipyUBbSh5IilLsI7jenZ9BZoIKiDF2n5tNCfOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZQ7FWeaBn8ZN7Ji0AAz2RvuNk/mOxF6z7mwdBwAiIw=;
 b=e6y+fnSkRtk2kn55RlOZPQqH4XhNw9wjm+tcjpNfwyPbKyfVR2BeA/lSGxpJA9dTX6fMVpmr6bzZAkfoKG9HXzXexOjOvh+xi6aIvZZnt6ig20OL4ku2KpFiKQ3s7spj7YFT6T6yBVWlAuGOyslqwwC6IXuoGekDHf3Ih1EhAeiyCmfMoMFZpm3MCPgmVkjcizk9gZZKDmONyFljsoNH0ScpclRR39EOeH4TlTMdxC1fT3E9M1L96mRz7ABbkpOqEoojljUjkWm3yzWhZFW12rOF6pejYmBL1qb2Frc4yKr5JgH+lpaPS3yphB/GTt71TYf/5hTm4wuiGFIetNpjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZQ7FWeaBn8ZN7Ji0AAz2RvuNk/mOxF6z7mwdBwAiIw=;
 b=a4BJREla1XZx8c1wWOTEhbsBWdx8OjsWSE5EBGVwueTD6hjudtccuaEdfKAwoqkNh/5K96dQzqbqsjgw3bT2OYkkwy/pfms/Js3YqQJbqXDKQg26bvurMJw3iVI+ku4yZhl20x5WCiJVHcA2PvE/hPsEoq+Qk+5cxIIwEDdN/w8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 17:08:33 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 17:08:32 +0000
Date: Fri, 23 Aug 2024 19:08:20 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Doug Brown <doug@schmorgal.com>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] hw/net/can/xlnx-versal-canfd: Translate CAN ID
 registers
Message-ID: <ZsjCBJ+GcLaLsATb@xse-figlesia-l2.amd.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
 <20240816163504.789393-4-doug@schmorgal.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816163504.789393-4-doug@schmorgal.com>
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 906c7db6-e944-4360-0622-08dcc396374c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THJ1VUxJSU1IVWozL2g5bDMxendocFJuME1GMjhXcExLTHlyR3d0TmlaRUdH?=
 =?utf-8?B?akFtVU1RVHhMcFhTUm5yd2JpdEwzMzdUOE1RQkxlbmJMSGJYM29uNGs2cFB2?=
 =?utf-8?B?V20xSlFZVW1VV2h4cTRRQ1lzZlVFNXcvVnp2L0c2ODNGdXQySm9lQW92cS9U?=
 =?utf-8?B?SmgrMjFnbVdqRm5oOE5vWEZiR0VRdDF3WjYxUnlOazFmQnlNbktheUJBZFBM?=
 =?utf-8?B?Y3lMc25aMUk0RTlRN0RmdmRld0pmVVZPRkNmZUZIWFRUaDhTdGNZV3BYamlX?=
 =?utf-8?B?NHhMeHBQUDdSYlJZZWkyanEwb28xMHZoYjR5d0ZNVUx0ZGdvYzBwRTBKZWZi?=
 =?utf-8?B?UmxGL2M1RHNLWGZ4dUZUeEFmTUhkSWh0V25EVXY3eFNaWWdHb29heUd6UmxI?=
 =?utf-8?B?SXc4d3hja3ZhVDNVODJ2blFtUlkybkIreDZDYllEN3BlQU5aQlhIQ3lSc0JY?=
 =?utf-8?B?NGE3Z1B4U1lXOE9va3lYWkNCaFJLdHlJdE9ZeWhwZzR3d2hmTUJjVFNWR1Vq?=
 =?utf-8?B?TkdySHJPMCtCeFVtWEt2cW82UzBrcFoyanhFNnI4b3JBUWxkWGVKREdtcGNT?=
 =?utf-8?B?ckJEUG9UQmFoaERVTkRBUUY1Q0VqMjQ5Vlk4L3Q0ZTNVL2pQRHhtek44MHpM?=
 =?utf-8?B?aS9yci9sQy9IMU9zcy94dGtCY2tVK0NzZ09nTFh1R0hHS0UxdlVsWTNEeFdq?=
 =?utf-8?B?aDdTbnBFdW13c1dzNXJzUGxzaWIrV21kMExUVnNaamd0YkxCTStjM0hwNXBL?=
 =?utf-8?B?eGlOTVNtMG5nbVdtM3pWMEtVTSthQkhlZmF3MkJ5VHJkZFdqUnMvdEk5RjBH?=
 =?utf-8?B?dUFlWnlmaEkzUmYvOTNOVlJiTWpoM0phTHE2TExXRkVyS3lNdkVaN25zVGk3?=
 =?utf-8?B?akJCZGt1cGw4cTRadTZLVXAva3VTZUpYOEFHTVd1OWpCTkFLUXNzTXdmMCtK?=
 =?utf-8?B?cHlVaVU5anlZdXVRUkRBaDhnclpxN0svb2IwUVl5emRKSlEraEtiTVRGcUU5?=
 =?utf-8?B?TmJGOHdiZ3p1c2ZDUFpxVnNOU2U0bWJJZnlVYTBieWlZVG8zeDNFem5PeG4v?=
 =?utf-8?B?eUNlK0VnTWZDMFJ1SHExMkdsQUlZM0F2eXNYdm1ibGgwaWdMNzdtdEdiWFd6?=
 =?utf-8?B?aTUvenJZb1UzVU5DUUdJQjEyWEx0SjZwbWg5QzdvOE9FOFpramF1K2ZyREFL?=
 =?utf-8?B?cFlMVFJpZWxSc0xhakxCYlQ4Z1UyYmhpWVFDU1BxTWhwTzhMVGFBUTJFVTY2?=
 =?utf-8?B?QUZZZVZ6QTI4TkorKzd1aG84ejhkY1FZcGJDM0JRZVFOQzA0dFhyd0VOcnFV?=
 =?utf-8?B?YTJ3cnBPMlZNb0JCakZhQUFNa0NvWGNsbmtvbFdUOXVFM3B5TTBOYzFLRDhR?=
 =?utf-8?B?RnU0TnZVWFdKRGZwMFhWaUtoaFdseDZldEVSbnBRcjUxUGhkaDVUWE5rbEww?=
 =?utf-8?B?eXI1Skpac0VQVXRucWIyRHoxUzdzNkM4Yjc0V2ZiOXFwcUJBTEJoQmFnVk5s?=
 =?utf-8?B?N1p0NkprVXQxZXAyd3RNL01WOHNaZUkyclNYUG13ajdBWkxRWk4rVXdzOEtT?=
 =?utf-8?B?UHlFWHN3em11d3JkQlFVbzhlajdGQ3IwQjZKTkdwb1duSXk1RmRhQ0V2bjZI?=
 =?utf-8?B?WmUwWXRwdDU1cjh5Z0h4c2Z0dWEzajkyZ3Q4TUdsOWplRGRaL1lJemQ5TUpl?=
 =?utf-8?B?N2NSeHV0MVhLVVhyenMrUWVIb0cydzFQQXRma0lMdjJrMjJ0UVo0LzZ2b29U?=
 =?utf-8?B?dXQ3UUFSZmxSQjI1azFaNUQwYXMxeklCV1VQY082SDliZmw2dEpYWVZLemJG?=
 =?utf-8?B?QXkzc0FiV1JEYUlUSCtlQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBZS2s0M3FPRmlobU5XMFg3anpyNXh6OCtiSTJ2Mk41NUxJT3FoWXoxMC9O?=
 =?utf-8?B?TFdMaWVrRTBLdlppZlhvQzV1NTVSNGpUL0pna0gxdmY3ZzFkRVpkYlMxMG5o?=
 =?utf-8?B?K1p4a2pZaitrSkp0dEM1UE1sSzBUN1FBNkNVMnVJMzRtUkk5NXEvMTh4dzJa?=
 =?utf-8?B?YTlnd0ltT1dUQU5ES3ZBOW43WjFwMUNUT05lMWpIc2RZcGtCYVd2WXBvODNK?=
 =?utf-8?B?WW5MTzE5bnRqdVl1eGN2Ry9ZdDZDU1lKQnRnVzhQblc2Uks1SDN1RXZSbTI3?=
 =?utf-8?B?Sy9DZG41S09nd3pPZU15dHNOeHJYOEd6SnFsdm5pVEU2TnlYSkk2cENkTXNm?=
 =?utf-8?B?c2tpQ0lxNE5GWUhwTWo4eVZDaXRHdHdHb3ZmUGZkZ0RmTjVsZzJDeGFJVklh?=
 =?utf-8?B?bDRKY09LNUxHVkYzVldTRkU0MXVJSExFUFVsb0thT2tYUzVvQTBaaGNnSE5u?=
 =?utf-8?B?UVYvdXljK2JvTktVVmVIcFVBKzdXZ3dEMTZzMHkrSnZZeGVHaVpkQmkranRj?=
 =?utf-8?B?d003dzk1UjF1SGNEN2E2bDF4L0svTjU0VTJsWnptVUNPWXJkWFdxNnpFNU9B?=
 =?utf-8?B?N1loQXhCb3NmbkdEUjEzT2FpNC9IQk0zYVlNV1ZVaVBQYno2cUdQUzNwTGlm?=
 =?utf-8?B?aEVxUU5nSitEVWpvZjRwd3paWXJwamxsZlIxTHVvNnZsbmtkekJwamJKa3M0?=
 =?utf-8?B?QzhWZU1RMDBKKzVheDllRHZxd1VHTW84VTY4MWlCOUY5R1dZQXFKTnZwbFJv?=
 =?utf-8?B?QUVSdmJBdUpYTVpJd3NKK2k4bTVyMHVpbG1sQW5BTkZ6SlRHVEdHWUFnZG42?=
 =?utf-8?B?aWhlMXY1QndJMWdxT0VzQkN5dVlqb2ZqSFJLT2N3R1dSczh4NDRKdDVlNU1Z?=
 =?utf-8?B?MTRudDhqN2tuS1N6MldSOXU4WU9aOWtKcUExcjdodmYrSHcwanB4cUNETVl2?=
 =?utf-8?B?Wmo2WDFsbHNKZVpXWGJSL0wxSlNUWG9jYS9KbGM5M0ptYmU4N1JUTmszS0VR?=
 =?utf-8?B?R2pVVUx6R0NISEJ3QjcrUnhrL1h3SVNwUkZ3WjZwTUErMlNCRjEwTEI4UVZV?=
 =?utf-8?B?TmZtTmd3eWhtbEo0RFN4Rkt3bE9yQlNYWmtodThzc3B5djBJOEovNjA0WStj?=
 =?utf-8?B?b3hEMjJKT1lMSkNDY0l5MzVoQ1JNVzkyVFNpTW4zSTFlSWdaVUV1YkRqWDF6?=
 =?utf-8?B?K1NiV0kwcjVpR21RalhNQkZncXA2b21NemppeWJtTWpHSSt4UDlwRzlKcEtL?=
 =?utf-8?B?eWdiRENBSndHN05SdkNUN2NGcnlmTFVrekg0aTFVRERiMU5TQjZsSFhGZXFV?=
 =?utf-8?B?enNvOC9rdDU5djI4SXk5TGpxRzBUOWt4amZyd2hLc0RKa0l1VG51MXQ0eVM4?=
 =?utf-8?B?c0FjNzF3VzhlY3hIVnNZOTRGNlh6THVwU2NMbEYwVkc3bFQwNjEyRG9QVGFH?=
 =?utf-8?B?dmxFeGdIT0ZHUDlyV1NESnZIUGwvTWdDSkdUUHJYM1dUN1ZTU2Ewbk5pWURq?=
 =?utf-8?B?TjRRQ21lZG9PTC9Ha3NiQXVOaXNMZU9WRkczR1g1TmFwQlh0eGorY3RLV1dZ?=
 =?utf-8?B?aWRQSWRxb2pXcTN6cTY4a0h5MGl0Zyt1dS92TkJ2MnlpaGs4cDBnUTBBSEk0?=
 =?utf-8?B?b0ZEVzM3S2I5cVNWaUlaYmtkRy9BcWJldm5lbEZOaTFsL2Q4M2lldVVFYlBt?=
 =?utf-8?B?b1ZWckYzTmhDeGEvQlpRdGs2M1RZYVFaazRkd251TXprSWUybWIxeDdyMzdq?=
 =?utf-8?B?RXR3UUI5SXM5Wkt4cERFRUFNYUpORFFDb1lTSjE3eDAyVzcxUWh3UGVmQjFx?=
 =?utf-8?B?Wk1udGk1b2pHU2FBZUZsR3BaekZxOUtZRWFzOFhJQlRWRmc2RWdPNmhVOEd6?=
 =?utf-8?B?QnY2WGlDVTFxck1VSmIzdGhTbUtPQzRGMll4L2paWlM1L21lRTNGR0pNaHRF?=
 =?utf-8?B?Mm5qSzkzeVlIQVBLRFpXQWNFeDgwWVcwcUQ2MWJqTkJ2cmc5WWFienJCa3pk?=
 =?utf-8?B?YjBXRm1WOFF4a2UwaUt4ZUdXZDB3bzY0dUFwVlFqT2N5bnlZcFJ5VzY0M3FK?=
 =?utf-8?B?QmI3WnFVT0c5cC9tekpTQ1UvSTZlWTlmSVJnbnBNK3g0dmRWK09TVjBiK3A1?=
 =?utf-8?Q?eJLvGZ+EaG6PYL4sMI5P6rRX2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906c7db6-e944-4360-0622-08dcc396374c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 17:08:32.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKXgMn57MJUyVJ9AyQNg7G1zCa3WXlP8sAcQaN9qsBAXqXigdmgoQap+9RFguPmoRVx/GNfc/OBH5ehAtFLbdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
Received-SPF: permerror client-ip=2a01:111:f403:2418::607;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Fri, Aug 16, 2024 at 09:35:03AM -0700, Doug Brown wrote:
> Previously the emulated CAN ID register was being set to the exact same
> value stored in qemu_can_frame.can_id. This doesn't work correctly
> because the Xilinx IP core uses a different bit arrangement than
> qemu_can_frame for all of its ID registers. Correct this problem for
> both RX and TX, including RX filtering.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/xlnx-versal-canfd.c | 53 ++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 8968672b84..1704b558d0 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -869,6 +869,8 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
>      uint32_t val = 0;
>      uint32_t dlc_reg_val = 0;
>      uint32_t dlc_value = 0;
> +    uint32_t id_reg_val = 0;
> +    bool is_rtr = false;
>  
>      /* Check that reg_num should be within TX register space. */
>      assert(reg_num <= R_TB_ID_REGISTER + (NUM_REGS_PER_MSG_SPACE *
> @@ -877,7 +879,20 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
>      dlc_reg_val = s->regs[reg_num + 1];
>      dlc_value = FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, DLC);
>  
> -    frame->can_id = s->regs[reg_num];
> +    id_reg_val = s->regs[reg_num];
> +    if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, IDE)) {
> +        frame->can_id = (FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID) << 18) |
> +                        (FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID_EXT)) |
> +                        QEMU_CAN_EFF_FLAG;
> +        if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, RTR_RRS)) {
> +            is_rtr = true;
> +        }
> +    } else {
> +        frame->can_id = FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID);
> +        if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, SRR_RTR_RRS)) {
> +            is_rtr = true;
> +        }
> +    }
>  
>      if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, FDF)) {
>          /*
> @@ -923,6 +938,10 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
>          } else {
>              frame->can_dlc = dlc_value;
>          }
> +
> +        if (is_rtr) {
> +            frame->can_id |= QEMU_CAN_RTR_FLAG;
> +        }
>      }
>  
>      for (j = 0; j < frame->can_dlc; j++) {
> @@ -948,6 +967,33 @@ static void process_cancellation_requests(XlnxVersalCANFDState *s)
>      canfd_update_irq(s);
>  }
>  
> +static uint32_t frame_to_reg_id(const qemu_can_frame *frame)
> +{
> +    uint32_t id_reg_val = 0;
> +    const bool is_canfd_frame = frame->flags & QEMU_CAN_FRMF_TYPE_FD;
> +    const bool is_rtr = !is_canfd_frame && (frame->can_id & QEMU_CAN_RTR_FLAG);
> +
> +    if (frame->can_id & QEMU_CAN_EFF_FLAG) {
> +        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID,
> +                                 (frame->can_id & QEMU_CAN_EFF_MASK) >> 18);
> +        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID_EXT,
> +                                 frame->can_id & QEMU_CAN_EFF_MASK);
> +        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, IDE, 1);
> +        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, SRR_RTR_RRS, 1);
> +        if (is_rtr) {
> +            id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, RTR_RRS, 1);
> +        }
> +    } else {
> +        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID,
> +                                 frame->can_id & QEMU_CAN_SFF_MASK);
> +        if (is_rtr) {
> +            id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, SRR_RTR_RRS, 1);
> +        }
> +    }
> +
> +    return id_reg_val;
> +}
> +
>  static void store_rx_sequential(XlnxVersalCANFDState *s,
>                                  const qemu_can_frame *frame,
>                                  uint32_t fill_level, uint32_t read_index,
> @@ -999,7 +1045,7 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
>                                                      NUM_REGS_PER_MSG_SPACE));
>          }
>  
> -        s->regs[store_location] = frame->can_id;
> +        s->regs[store_location] = frame_to_reg_id(frame);
>  
>          dlc = frame->can_dlc;
>  
> @@ -1090,11 +1136,12 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
>      if (s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER]) {
>          uint32_t acceptance_filter_status =
>                                  s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER];
> +        const uint32_t reg_id = frame_to_reg_id(frame);
>  
>          for (i = 0; i < 32; i++) {
>              if (acceptance_filter_status & 0x1) {
>                  uint32_t msg_id_masked = s->regs[R_AFMR_REGISTER + 2 * i] &
> -                                         frame->can_id;
> +                                         reg_id;
>                  uint32_t afir_id_masked = s->regs[R_AFIR_REGISTER + 2 * i] &
>                                            s->regs[R_AFMR_REGISTER + 2 * i];
>                  uint16_t std_msg_id_masked = FIELD_EX32(msg_id_masked,
> -- 
> 2.34.1
> 

