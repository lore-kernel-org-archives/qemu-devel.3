Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD19C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 22:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsUH-0000tJ-9d; Tue, 29 Jul 2025 18:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqhs-0005yq-Hx; Tue, 29 Jul 2025 16:13:53 -0400
Received: from mail-co1nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2416::629]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqho-0001oU-K4; Tue, 29 Jul 2025 16:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjAmF+GVxj0EeSbiCYElIb37Zf20KifYPMWZVvxInCs2+B6u5inlLEgz8c9GnGAidvGH1Z5GC/4QjVM0a7h/XAhzM9Grm73u9O8vIKm9aJSSVeHUYjNU5kpRm0kf23FllSTa0RMX10N8CoXU0T/q5kBiuNwZjA3hugsfSUIZumrNnaRkKz53NQCCVyDmHcpRYMrUs4lFWfe8GaYVwZGgmrSnytjgpo1PsAZzfvxfzDK1nk8w8Ng2aaEFQzr/ju6y4aK1jFtJux9buRBzHTsTo/7wjQ28gcw36jtZKZSj3M3Y3yYQ7pfZvPWw5a/0lR817efQGxshFxpJ8R6oRbRd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk+1gZhmMr8El6QKI9O3FjZ3P98jTKUs04vJ621LskY=;
 b=VXfjDGhGqkNJO101w5mFhx2udS515aUQZqCjUGMYNPn0k03wnmV7c7hFEwrv9A8bOpfSIaOkRP+mLaaQCNQOVp72Ha2bWEbGm5tHXJQ72x/bb8B12M7ziR4Yg/ov7goDRUnukNr5rki02LO9S3QmvsXXGFkHALABC1E77PxzPyhC9EG0NreThzxTLhedo0FIZ9KsHCQxw3WuYblEnvYySLhnM+xO3vAW2tuV6A5eOhga4I+pAioATgByagtnuHlnKhZtkzqEy6kzUucbBEoVKSQfK0iK52WIIVBdC1ikfti1/Arj8fum4WeTAWKibdRjsgxUwxaDnBbRCQjAy+ubZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk+1gZhmMr8El6QKI9O3FjZ3P98jTKUs04vJ621LskY=;
 b=dan6o85yEXnDKqBk7D3QfyGE4shtWjt5n6sQxYbvN9R8CgXFsaF5oeQ45D4IocjZdyIMLI3CI/PBrNwODIOXwCBdqivC+iJ9BapJDhAIN8PCxeUQW5IbvOOCdpBU8qDyJl6rB/iDctCJ13PEMUWbLpeVqYtGhXvPryKbQy7qNUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 20:13:41 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 20:13:41 +0000
Date: Tue, 29 Jul 2025 22:13:34 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 21/48] hw/arm/xlnx-versal: refactor CPU cluster creation
Message-ID: <aIkrbm7WMXei5JRp@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-22-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-22-luc.michel@amd.com>
X-ClientProxiedBy: LO2P265CA0174.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: dd131d25-11d9-4c8e-4ed9-08ddcedc6932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M24vTlNwSWMzUExHMjhXN05PSXo2K3lndlRyMG1FWGhEaFdjVm1YTk9YNThn?=
 =?utf-8?B?WG1JRjJLTi9SRVd5dXcyYWlKc1EzdTArMGRSY2dTVEVVRk1zUGhTL1dEWnRE?=
 =?utf-8?B?TWxkTm01T3VCYXFvNVhTdCtGMWhocTBBZ2FpTEhqazR0UkJKaDV0aEszT1JV?=
 =?utf-8?B?NkJPc3RjWGtxcHRtMXo3WHJRMEZ0Y0F0ckVwVEVGbk4yZGNOQzd3RlRsQysz?=
 =?utf-8?B?RU93SlZKbHN3Q0xWS1BHWW1pSlVpUnFpLzNuZk91MWRJT202ZEpCallpY1RD?=
 =?utf-8?B?N3hQRitDd3A0SDdRbHVRK24zK2I0a2kyMnErWm1HS2lMU1Z4NTBFc1NDTFNj?=
 =?utf-8?B?azkvSkF4amY3OGdTUEVMZ29SSEp5Q1dPRkVjdTBIT1VpR0FaaStDQ1ZqQUFP?=
 =?utf-8?B?aXgrblBmNkt1N3g4U0ZSQTVFNWlTNTl0cWNvQVF1dW1yVE82dlExZmh6RnBn?=
 =?utf-8?B?dFRQUjdLRzEvOW0yUkEwb3RoQnM0U3pvWDJTUUFUL1I0a1VJb2g0U0M5YUxP?=
 =?utf-8?B?VlhwUnJ2OHJ4b28vdnB4aW5tVjVUSHRQV21ZeDNsVXZVODZ6Y2JFV2lMc2RC?=
 =?utf-8?B?S1Y1R09Zcm5ROWU4cldpUmdpWkd6SDRLM2tYY3ZuMWl2Q1oyUXFzRzVSZGEy?=
 =?utf-8?B?ZU4rTlV3enVncW1UR0lVaU9HNHpza05EK20wTWU3dUdabTJJcWYwUXBmM1lI?=
 =?utf-8?B?Zkd2WTgyQTA5bjRIbExUVjJlanAxREhIbm5VK2xHbWpDWDl5VnY2TUZlZXlP?=
 =?utf-8?B?TW1LZG9lTGdvWGtCV3V3ZElWVUp2WDFndHIwd0ZaTXhqQVppczVkaVJ5ck5P?=
 =?utf-8?B?eUZPTVF2VHdlejRTalhSL21paTQ4eFJ3YlN1cFNpYlRlUk9RUzJwOWlIL2Jj?=
 =?utf-8?B?R1N6U1dYVnRvc0JPcUtlSjhtbWJiK28yT1BNVTdJbUQ1SDV5eFd2ZFBRSWxB?=
 =?utf-8?B?NnRlZExOTGhveklPOG9ySWtVaEZwdGI0TlQzSTJSZ0JPVDhaRnZsM1JBL2pG?=
 =?utf-8?B?QjFHQjBlSU5sRmJsY2x1WEdjb2pHRkRtNVBnZmpkZUVNbW5FdUtiZkxOaU5P?=
 =?utf-8?B?M1NmdWs2d1RKcVhQZGN3SUMvUFdNZWVVTTNvTWtOdlJxR1Rwb3lSRER0Vyto?=
 =?utf-8?B?SFZrcS9INEtRSXB4dnlCN3FwblhmTGdIR3NueGlJOVFRRDBtYTRrcWJkNVVz?=
 =?utf-8?B?eUdrRnpMMUhlOXZ0RlNkUU5QSGxMSkpJRU1XWW5KQ09OQ0Exc3Rwa1ZKbndO?=
 =?utf-8?B?VDBJUkwrS3Axb0tsOHg3bVZIUXpLbzEwYS9UbDhYQ21DZGx6eW1xQWtQeWZs?=
 =?utf-8?B?QzlTUVJkU05DV3NYcTRkWXVMRjFKSmNpd1BrSmlUUmtmbE44ZWphWlFwUzll?=
 =?utf-8?B?UWdodk4vVS9obENQVWpPdnhKMUg1WDVNNnBaM3VuRGhwbEJDUXJrYUd1ZC9h?=
 =?utf-8?B?UVhjOC81OFh6dUpOOE9KTUVkb3pjRjlPRXZFUzVId3FKd1pQUlNxQjMzUjFX?=
 =?utf-8?B?Yy9LSTJKRXlMRVJza1pvNElHK1FWM0hNK0lGeWRneU9MdjF3OVdIeStFV1Bt?=
 =?utf-8?B?RDdwKy8xMUxCQ0tucHZ3dDQ4elBrRGcyazF0QWtTU25xN1VxcDE3anU1RGY0?=
 =?utf-8?B?ZCt5ZlF0UGlqVllPV0s0UmQ0QlNlZHJ1SGxzNEh3S2JvU1preDNma1UzbVhR?=
 =?utf-8?B?RUVDQXE0VE1BS1cya3kreXdwdUc4WXhHeFdkYzlmMGEwMmJHYmtpbkdhalpy?=
 =?utf-8?B?N3ZXMXc1TUlEK3Z4dS9iekltVzhqT3lTL25qNnphcUVoTDVpdXVxTEIyR21Z?=
 =?utf-8?B?RnJEZ3lwY2VCUUE5RDZpQjdJTDNFdVBSOUsxTmQ2M2xYYUNLdjZFL1ZjbFFI?=
 =?utf-8?B?V2lEMXlUbHNTd2xHKzV4ZXUwTjRweEQ3QVR0ejlWVEFpS05aSGVrcTFHWFE3?=
 =?utf-8?Q?Tjhidy6iLAo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZVZXdhOE9CazJ6OWE3UG40UVBMTk5KTTNRckdTZHk0SzBjMUdJWU5JclBS?=
 =?utf-8?B?NnUraDBjU2dVV3NjVGlLZ3Nwc0pCbFoxTW52c1AxK01VaFBSOStiRUxlYmZP?=
 =?utf-8?B?MW85R0pkaTVjRk5mcm1CVUZVWENHY0tkcGJETkxMMm1YdVU4bUdPc045Rjk3?=
 =?utf-8?B?SVJ3S0l6UDBkZWtQR2ozZXdvVUg3cXM5NE11dDJXbFgzenBzYS95djJiN3px?=
 =?utf-8?B?Q0JYT0pBQ2tXM0l4Z2NEZSt4R2xNeGdTeWtqU01qSlhSaFN6NjFXZ0J0aU5C?=
 =?utf-8?B?MUdUMngzUWtLKytzSWxxWE5SdC9pS2x3U3gwMlN2VlZ2cXdQTjB4Vjc0K3FU?=
 =?utf-8?B?akNNR2ZWMG9kN0hiU1RmRFQ1cmVraEhWcVZyTzI0ZTEwY3lKOHBiVzV5aTMr?=
 =?utf-8?B?VjA5M1hXS3gwR1lZOGgrWncxNHF4VHoxSVh3OHFQZGN3b2hUKzRPdTNVVHU5?=
 =?utf-8?B?NU5YS0MxdG83Qzh6QjRuRUVZYjFEKzQ3MEVOK2lpU2x2Y0k2QUlWUnV5dHNs?=
 =?utf-8?B?OFhaUFhhaE0zenNMYzBGNlF5QzlzVE5YYXcxTyswS0RUcUwxZVd0b2VlZXJm?=
 =?utf-8?B?THk2eEVOZEtJd05Kenp2N1c0UWF2MXY2M0xYRGsvNjlRN0hLQ2czSm84U3lm?=
 =?utf-8?B?NFRRZjhUZTVMaFlYcVovUnFJcjF4dzl3cXpaU0lLS2RWSHBIaFh3TjNObTQr?=
 =?utf-8?B?UVpOcFc5Z3lMQ25nY1RaczN5MGFRYit2ek1XYXlKUFNLL2hsdDFoZ0ZGWEF4?=
 =?utf-8?B?YjR3V2cxMWJQeHUvSXNhRC9LSjRMbDMwWHR3clBEeXZqa0ZDVzRMaTJEY1hN?=
 =?utf-8?B?VHArRkpCcTNld25DWmR5bHNIMk9GR0hYbnc4eEx2QUpFUW5Vd2ZmZk1kQUlj?=
 =?utf-8?B?MjNaSXFFMGZ1dDh0NXF2MW5DTDJzU2krQ0lFcFcxOUxkbUM0MUhuMTZMRUxq?=
 =?utf-8?B?MnNCOW50eXM1cGMvNlJZTU45dEFhNlYwNkdRU0srOFpybnFuWEhLZk11L0xO?=
 =?utf-8?B?UGlCUlBPZnhxV0hxRzBocW9QT0JKdWNFd2NVMytsNWExSFh6REpuQVRxVjBS?=
 =?utf-8?B?U0V4bXg4SWJWSnZTcDJyY2V5Tk5uLzYvcUZrMDk4T0xHdHpEckpDeTdFOWlD?=
 =?utf-8?B?ZWwyem1KUTBHWURqSndUTEFOa1RRVnZDSlBvUUxLVXluV0RPMldOOHc0MUZ1?=
 =?utf-8?B?ejJWd3ZHWVllMDdhQk9XYjd0ekp1R21YSXZ3d3lyZmRNSnZIekNUeHFGY0Fh?=
 =?utf-8?B?Vko2b3kzRndveXVDeWxPeUkrMnJmYjZwMmJGeUZvcnNnZzRMZ250c1JYT252?=
 =?utf-8?B?TG5CbkpSRWNZQTF3TW1yZHZ1RWMwcUo5NUtSWDlxSzI5UFErVEgxT2ZaNGJ0?=
 =?utf-8?B?MmRYbFM0UlduLzB2VzFkOEladWlJSHFhdmhycGVJN2VkVUp2OG9IelRiUHMr?=
 =?utf-8?B?S3hMY3U0VU8xaU1lYkc1VFV0OGRtQ2tGeXdnQmNVRDFLbGlZdDVJSWJrY1NH?=
 =?utf-8?B?SnpGWW4yMHpiTlJjeUIzdDdQVU9uMkFaUnFqR0xaRFd5elBEcUtQQ3hYa3Q3?=
 =?utf-8?B?OEZSRGF6TXpJdnllTWlDVGRndU5BNG5hNVRKTENhNXZpbS9kRnVRQXZJaUhN?=
 =?utf-8?B?dkJvQS9KdXR6amZSRU44UGFISVcvTnVPcnllZGZDYzkwQVR3ZHFaaDVTL1JQ?=
 =?utf-8?B?WXpxTU0zK0RZRCs0V0xRL2VLRmVtcGpOSWZJVU9ITHRVOFV5dlRIY1VHd3FG?=
 =?utf-8?B?UWU5QkYxM1lsdGZxMk9ULzJiRm9lZFh5U2dYZkgvb3p5a0QwMnhxWDVUZ2Iz?=
 =?utf-8?B?WEZCemtvdW1qZ0tGTk5ERFRGM2NGcDI1Z3hkZnJnb1g5R0dpMEpTTGI1ZHo2?=
 =?utf-8?B?VndxSGJWOTA2NXN3VjhuMmhseS9KYldFK2tRdnpOSTM2ZUIzWEhGd2V0ZzMw?=
 =?utf-8?B?REQ2dXhKbEpENm1JR21IclhTbk9zQzRHbVI3dGpHbDczRmFoWlRrMlBOS1lQ?=
 =?utf-8?B?MExhVjlYekRUTWlGRzZGUGpEM2NMbldkY05LTnBhL3pKNTJFd3BkdE5RTlA1?=
 =?utf-8?B?SnhHSTRlRkQwcFdndDlVak1NLysrNGRCMThHTUZPRmRHS3lFVVoyMEsrR1Vz?=
 =?utf-8?Q?FcSmL0dn+7KxVn0M3Sw4rmK/n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd131d25-11d9-4c8e-4ed9-08ddcedc6932
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 20:13:41.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYg5A6QDyCpc7c+DsWG3kX3DbWwp6W3uAWU1/TdYlLc5k0Od9SkIWfn1cV13+ZL4AH+3uk+v4gzHKq096xr2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
Received-SPF: permerror client-ip=2a01:111:f403:2416::629;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:03AM +0200, Luc Michel wrote:
> Refactor the CPU cluster creation using the VersalMap structure. There
> is no functional change. The clusters properties are now described in
> the VersalMap structure. For now only the APU is converted. The RPU will
> be taken care of by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  11 +-
>  hw/arm/xlnx-versal-virt.c    |  80 +-------
>  hw/arm/xlnx-versal.c         | 346 ++++++++++++++++++++++++++---------
>  3 files changed, 269 insertions(+), 168 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index af47acb288f..ba5719d80f5 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -13,11 +13,10 @@
>  #ifndef XLNX_VERSAL_H
>  #define XLNX_VERSAL_H
>  
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
> -#include "hw/intc/arm_gicv3.h"
>  #include "qom/object.h"
>  #include "net/can_emu.h"
>  #include "target/arm/cpu.h"
>  #include "hw/arm/xlnx-versal-version.h"
>  
> @@ -41,19 +40,10 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>  struct Versal {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
> -    struct {
> -        struct {
> -            MemoryRegion mr;
> -            CPUClusterState cluster;
> -            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
> -            GICv3State gic;
> -        } apu;
> -    } fpd;
> -
>      MemoryRegion mr_ps;
>  
>      struct {
>          /* 4 ranges to access DDR.  */
>          MemoryRegion mr_ddr_ranges[4];
> @@ -73,10 +63,11 @@ struct Versal {
>      } lpd;
>  
>      struct {
>          uint32_t clk_25mhz;
>          uint32_t clk_125mhz;
> +        uint32_t gic;
>      } phandle;
>  
>      struct {
>          MemoryRegion *mr_ddr;
>          CanBusState **canbus;
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index a776ee87088..55159536ceb 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -36,11 +36,10 @@ struct VersalVirt {
>      Versal soc;
>  
>      void *fdt;
>      int fdt_size;
>      struct {
> -        uint32_t gic;
>          uint32_t clk_125Mhz;
>          uint32_t clk_25Mhz;
>      } phandle;
>      struct arm_boot_info binfo;
>  
> @@ -61,22 +60,18 @@ static void fdt_create(VersalVirt *s)
>          error_report("create_device_tree() failed");
>          exit(1);
>      }
>  
>      /* Allocate all phandles.  */
> -    s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
>  
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
>      qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
> -    qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
> -    qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
> -    qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
>      qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
>      qemu_fdt_setprop_string(s->fdt, "/", "compatible", "xlnx-versal-virt");
>  }
>  
>  static void fdt_add_clk_node(VersalVirt *s, const char *name,
> @@ -88,71 +83,10 @@ static void fdt_add_clk_node(VersalVirt *s, const char *name,
>      qemu_fdt_setprop_cell(s->fdt, name, "#clock-cells", 0x0);
>      qemu_fdt_setprop_string(s->fdt, name, "compatible", "fixed-clock");
>      qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
>  }
>  
> -static void fdt_add_cpu_nodes(VersalVirt *s, uint32_t psci_conduit)
> -{
> -    int i;
> -
> -    qemu_fdt_add_subnode(s->fdt, "/cpus");
> -    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#size-cells", 0x0);
> -    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#address-cells", 1);
> -
> -    for (i = XLNX_VERSAL_NR_ACPUS - 1; i >= 0; i--) {
> -        char *name = g_strdup_printf("/cpus/cpu@%d", i);
> -        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
> -
> -        qemu_fdt_add_subnode(s->fdt, name);
> -        qemu_fdt_setprop_cell(s->fdt, name, "reg",
> -                              arm_cpu_mp_affinity(armcpu));
> -        if (psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
> -            qemu_fdt_setprop_string(s->fdt, name, "enable-method", "psci");
> -        }
> -        qemu_fdt_setprop_string(s->fdt, name, "device_type", "cpu");
> -        qemu_fdt_setprop_string(s->fdt, name, "compatible",
> -                                armcpu->dtb_compatible);
> -        g_free(name);
> -    }
> -}
> -
> -static void fdt_add_gic_nodes(VersalVirt *s)
> -{
> -    char *nodename;
> -
> -    nodename = g_strdup_printf("/gic@%x", MM_GIC_APU_DIST_MAIN);
> -    qemu_fdt_add_subnode(s->fdt, nodename);
> -    qemu_fdt_setprop_cell(s->fdt, nodename, "phandle", s->phandle.gic);
> -    qemu_fdt_setprop_cells(s->fdt, nodename, "interrupts",
> -                           GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
> -                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -    qemu_fdt_setprop(s->fdt, nodename, "interrupt-controller", NULL, 0);
> -    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
> -                                 2, MM_GIC_APU_DIST_MAIN,
> -                                 2, MM_GIC_APU_DIST_MAIN_SIZE,
> -                                 2, MM_GIC_APU_REDIST_0,
> -                                 2, MM_GIC_APU_REDIST_0_SIZE);
> -    qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
> -    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");
> -    g_free(nodename);
> -}
> -
> -static void fdt_add_timer_nodes(VersalVirt *s)
> -{
> -    const char compat[] = "arm,armv8-timer";
> -    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
> -
> -    qemu_fdt_add_subnode(s->fdt, "/timer");
> -    qemu_fdt_setprop_cells(s->fdt, "/timer", "interrupts",
> -            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ, irqflags,
> -            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ, irqflags,
> -            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ, irqflags,
> -            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
> -    qemu_fdt_setprop(s->fdt, "/timer", "compatible",
> -                     compat, sizeof(compat));
> -}
> -
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
>      char **node_path;
>      int n = 0;
> @@ -391,23 +325,21 @@ static void versal_virt_init(MachineState *machine)
>                                   &error_abort);
>      }
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
> -    fdt_add_gic_nodes(s);
> -    fdt_add_timer_nodes(s);
> -    fdt_add_cpu_nodes(s, psci_conduit);
>      fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
>      fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
>  
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>      create_virtio_regions(s);
>  
> -    /* Make the APU cpu address space visible to virtio and other
> -     * modules unaware of multiple address-spaces.  */
> -    memory_region_add_subregion_overlap(get_system_memory(),
> -                                        0, &s->soc.fpd.apu.mr, 0);
> +    /*
> +     * Map the SoC address space onto system memory. This will allow virtio and
> +     * other modules unaware of multiple address-spaces to work.
> +     */
> +    memory_region_add_subregion(get_system_memory(), 0, &s->soc.mr_ps);
>  
>      /* Attach bbram backend, if given */
>      bbram_attach_drive(s);
>  
>      /* Attach efuse backend, if given */
> @@ -427,11 +359,11 @@ static void versal_virt_init(MachineState *machine)
>          /* Some boot-loaders (e.g u-boot) don't like blobs at address 0 (NULL).
>           * Offset things by 4K.  */
>          s->binfo.loader_start = 0x1000;
>          s->binfo.dtb_limit = 0x1000000;
>      }
> -    arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
> +    arm_load_kernel(ARM_CPU(qemu_get_cpu(0)), machine, &s->binfo);
>  
>      for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
>          ObjectClass *flash_klass;
>          DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
>          BlockBackend *blk;
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index fe2c789a557..5a08ad07b28 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -41,10 +41,11 @@
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "hw/or-irq.h"
>  #include "hw/misc/xlnx-versal-crl.h"
> +#include "hw/intc/arm_gicv3_common.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -65,11 +66,38 @@ FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
>  typedef struct VersalSimplePeriphMap {
>      uint64_t addr;
>      int irq;
>  } VersalSimplePeriphMap;
>  
> +typedef struct VersalGicMap {
> +    int version;
> +    uint64_t dist;
> +    uint64_t redist;
> +    size_t num_irq;
> +} VersalGicMap;
> +
> +enum StartPoweredOffMode {
> +    SPO_SECONDARIES,
> +    SPO_ALL,
> +};
> +
> +typedef struct VersalCpuClusterMap {
> +    VersalGicMap gic;
> +
> +    const char *name;
> +    const char *cpu_model;
> +    size_t num_core;
> +    size_t num_cluster;
> +    uint32_t qemu_cluster_id;
> +    bool dtb_expose;
> +
> +    enum StartPoweredOffMode start_powered_off;
> +} VersalCpuClusterMap;
> +
>  typedef struct VersalMap {
> +    VersalCpuClusterMap apu;
> +
>      VersalSimplePeriphMap uart[2];
>      size_t num_uart;
>  
>      VersalSimplePeriphMap canfd[4];
>      size_t num_canfd;
> @@ -162,10 +190,26 @@ typedef struct VersalMap {
>          int irq_num;
>      } reserved;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
> +    .apu = {
> +        .name = "apu",
> +        .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
> +        .num_cluster = 1,
> +        .num_core = 2,
> +        .qemu_cluster_id = 0,
> +        .start_powered_off = SPO_SECONDARIES,
> +        .dtb_expose = true,
> +        .gic = {
> +            .version = 3,
> +            .dist = 0xf9000000,
> +            .redist = 0xf9080000,
> +            .num_irq = 192,
> +        },
> +    },
> +
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
>      .num_uart = 2,
>  
>      .canfd[0] = { 0xff060000, 20 },
> @@ -292,14 +336,16 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
>  
>  static qemu_irq versal_get_irq(Versal *s, int irq_idx)
>  {
>      qemu_irq irq;
>      bool ored;
> +    DeviceState *gic;
>  
>      ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
>  
> -    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
> +    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
> +    irq = qdev_get_gpio_in(gic, irq_idx);
>  
>      if (ored) {
>          irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
>      }
>  
> @@ -372,111 +418,243 @@ static inline DeviceState *create_or_gate(Versal *s, Object *parent,
>      versal_qdev_connect_gpio_out(s, or, 0, irq_idx);
>  
>      return or;
>  }
>  
> -static void versal_create_apu_cpus(Versal *s)
> +static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
> +                                   const VersalCpuClusterMap *map)
>  {
> -    int i;
> +    MemoryRegion *mr, *root_alias;
> +    char *name;
>  
> -    object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
> -                            TYPE_CPU_CLUSTER);
> -    qdev_prop_set_uint32(DEVICE(&s->fpd.apu.cluster), "cluster-id", 0);
> +    mr = g_new(MemoryRegion, 1);
> +    name = g_strdup_printf("%s-mr", map->name);
> +    memory_region_init(mr, OBJECT(cluster), name, UINT64_MAX);
> +    g_free(name);
>  
> -    for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
> -        Object *obj;
> +    root_alias = g_new(MemoryRegion, 1);
> +    name = g_strdup_printf("ps-alias-for-%s", map->name);
> +    memory_region_init_alias(root_alias, OBJECT(cluster), name,
> +                             &s->mr_ps, 0, UINT64_MAX);
> +    g_free(name);
> +    memory_region_add_subregion(mr, 0, root_alias);
>  
> -        object_initialize_child(OBJECT(&s->fpd.apu.cluster),
> -                                "apu-cpu[*]", &s->fpd.apu.cpu[i],
> -                                XLNX_VERSAL_ACPU_TYPE);
> -        obj = OBJECT(&s->fpd.apu.cpu[i]);
> -        if (i) {
> -            /* Secondary CPUs start in powered-down state */
> -            object_property_set_bool(obj, "start-powered-off", true,
> -                                     &error_abort);
> -        }
> -
> -        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->fpd.apu.cpu),
> -                                &error_abort);
> -        object_property_set_link(obj, "memory", OBJECT(&s->fpd.apu.mr),
> -                                 &error_abort);
> -        qdev_realize(DEVICE(obj), NULL, &error_fatal);
> -    }
> -
> -    qdev_realize(DEVICE(&s->fpd.apu.cluster), NULL, &error_fatal);
> +    return mr;
>  }
>  
> -static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
> +static DeviceState *versal_create_gic(Versal *s,
> +                                      const VersalCpuClusterMap *map,
> +                                      MemoryRegion *mr,
> +                                      size_t num_cpu)
>  {
> -    static const uint64_t addrs[] = {
> -        MM_GIC_APU_DIST_MAIN,
> -        MM_GIC_APU_REDIST_0
> -    };
> -    SysBusDevice *gicbusdev;
> -    DeviceState *gicdev;
> +    DeviceState *dev;
> +    SysBusDevice *sbd;
>      QList *redist_region_count;
> -    int nr_apu_cpus = ARRAY_SIZE(s->fpd.apu.cpu);
> -    int i;
> +    g_autofree char *node = NULL;
> +    g_autofree char *name = NULL;
> +    const char compatible[] = "arm,gic-v3";
>  
> -    object_initialize_child(OBJECT(s), "apu-gic", &s->fpd.apu.gic,
> -                            gicv3_class_name());
> -    gicbusdev = SYS_BUS_DEVICE(&s->fpd.apu.gic);
> -    gicdev = DEVICE(&s->fpd.apu.gic);
> -    qdev_prop_set_uint32(gicdev, "revision", 3);
> -    qdev_prop_set_uint32(gicdev, "num-cpu", nr_apu_cpus);
> -    qdev_prop_set_uint32(gicdev, "num-irq", XLNX_VERSAL_NR_IRQS + 32);
> +    dev = qdev_new(gicv3_class_name());
> +    name = g_strdup_printf("%s-gic[*]", map->name);
> +    object_property_add_child(OBJECT(s), name, OBJECT(dev));
> +    sbd = SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_uint32(dev, "revision", 3);
> +    qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
> +    qdev_prop_set_uint32(dev, "num-irq", map->gic.num_irq + 32);
>  
>      redist_region_count = qlist_new();
> -    qlist_append_int(redist_region_count, nr_apu_cpus);
> -    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
> +    qlist_append_int(redist_region_count, num_cpu);
> +    qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
>  
> -    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
> +    qdev_prop_set_bit(dev, "has-security-extensions", true);
> +    object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
>  
> -    sysbus_realize(SYS_BUS_DEVICE(&s->fpd.apu.gic), &error_fatal);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
>  
> -    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
> -        MemoryRegion *mr;
> +    memory_region_add_subregion(mr, map->gic.dist,
> +                                sysbus_mmio_get_region(sbd, 0));
> +    memory_region_add_subregion(mr, map->gic.redist,
> +                                sysbus_mmio_get_region(sbd, 1));
>  
> -        mr = sysbus_mmio_get_region(gicbusdev, i);
> -        memory_region_add_subregion(&s->fpd.apu.mr, addrs[i], mr);
> +    if (map->dtb_expose) {
> +        node = versal_fdt_add_subnode(s, "/gic", map->gic.dist, compatible,
> +                                      sizeof(compatible));
> +        qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
> +        qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
> +        qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
> +                                     2, map->gic.dist,
> +                                     2, 0x10000,
> +                                     2, map->gic.redist,
> +                                     2, GICV3_REDIST_SIZE * num_cpu);
> +        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
>      }
>  
> -    for (i = 0; i < nr_apu_cpus; i++) {
> -        DeviceState *cpudev = DEVICE(&s->fpd.apu.cpu[i]);
> -        int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
> -        qemu_irq maint_irq;
> -        int ti;
> -        /* Mapping from the output timer irq lines from the CPU to the
> -         * GIC PPI inputs.
> -         */
> -        const int timer_irq[] = {
> -            [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
> -            [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
> -            [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
> -            [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
> -        };
> +    return dev;
> +}
>  
> +static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
> +                               DeviceState *gic, DeviceState *cpu, size_t idx,
> +                               size_t num_cpu)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(gic);
> +    int ppibase = map->gic.num_irq + idx * GIC_INTERNAL + GIC_NR_SGIS;
> +    int ti;
> +    bool has_gtimer;
> +    /*
> +     * Mapping from the output timer irq lines from the CPU to the
> +     * GIC PPI inputs.
> +     */
> +    const int timer_irq[] = {
> +        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
> +        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
> +        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
> +        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
> +    };
> +
> +    has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
> +
> +    if (has_gtimer) {
>          for (ti = 0; ti < ARRAY_SIZE(timer_irq); ti++) {
> -            qdev_connect_gpio_out(cpudev, ti,
> -                                  qdev_get_gpio_in(gicdev,
> +            qdev_connect_gpio_out(cpu, ti,
> +                                  qdev_get_gpio_in(gic,
>                                                     ppibase + timer_irq[ti]));
>          }
> -        maint_irq = qdev_get_gpio_in(gicdev,
> -                                        ppibase + VERSAL_GIC_MAINT_IRQ);
> -        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
> +    }
> +
> +    if (map->gic.version == 3) {
> +        qemu_irq maint_irq;
> +
> +        maint_irq = qdev_get_gpio_in(gic,
> +                                     ppibase + VERSAL_GIC_MAINT_IRQ);
> +        qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
>                                      0, maint_irq);
> -        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> -        sysbus_connect_irq(gicbusdev, i + nr_apu_cpus,
> -                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> -        sysbus_connect_irq(gicbusdev, i + 2 * nr_apu_cpus,
> -                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> -        sysbus_connect_irq(gicbusdev, i + 3 * nr_apu_cpus,
> -                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>      }
>  
> -    for (i = 0; i < XLNX_VERSAL_NR_IRQS; i++) {
> -        pic[i] = qdev_get_gpio_in(gicdev, i);
> +    sysbus_connect_irq(sbd, idx, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
> +    sysbus_connect_irq(sbd, idx + num_cpu,
> +                       qdev_get_gpio_in(cpu, ARM_CPU_FIQ));
> +    sysbus_connect_irq(sbd, idx + 2 * num_cpu,
> +                       qdev_get_gpio_in(cpu, ARM_CPU_VIRQ));
> +    sysbus_connect_irq(sbd, idx + 3 * num_cpu,
> +                       qdev_get_gpio_in(cpu, ARM_CPU_VFIQ));
> +}
> +
> +static inline void versal_create_and_connect_gic(Versal *s,
> +                                                 const VersalCpuClusterMap *map,
> +                                                 MemoryRegion *mr,
> +                                                 DeviceState **cpus,
> +                                                 size_t num_cpu)
> +{
> +    DeviceState *gic;
> +    size_t i;
> +
> +    gic = versal_create_gic(s, map, mr, num_cpu);
> +
> +    for (i = 0; i < num_cpu; i++) {
> +        connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
> +    }
> +}
> +
> +static DeviceState *versal_create_cpu(Versal *s,
> +                                      const VersalCpuClusterMap *map,
> +                                      DeviceState *qemu_cluster,
> +                                      MemoryRegion *cpu_mr,
> +                                      size_t cluster_idx,
> +                                      size_t core_idx)
> +{
> +    DeviceState *cpu = qdev_new(map->cpu_model);
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    Object *obj = OBJECT(cpu);
> +    bool start_off;
> +    size_t idx = cluster_idx * map->num_core + core_idx;
> +    g_autofree char *name;
> +    g_autofree char *node = NULL;
> +
> +    start_off = map->start_powered_off == SPO_ALL
> +        || ((map->start_powered_off == SPO_SECONDARIES)
> +            && (cluster_idx || core_idx));
> +
> +    name = g_strdup_printf("%s[*]", map->name);
> +    object_property_add_child(OBJECT(qemu_cluster), name, obj);
> +    object_property_set_bool(obj, "start-powered-off", start_off,
> +                             &error_abort);
> +    qdev_prop_set_int32(cpu, "core-count",  map->num_core);
> +    object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
> +    qdev_realize_and_unref(cpu, NULL, &error_fatal);
> +
> +    if (!map->dtb_expose) {
> +        return cpu;
> +    }
> +
> +    node = versal_fdt_add_subnode(s, "/cpus/cpu", idx,
> +                                  arm_cpu->dtb_compatible,
> +                                  strlen(arm_cpu->dtb_compatible) + 1);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "reg",
> +                          arm_cpu_mp_affinity(arm_cpu) & ARM64_AFFINITY_MASK);
> +    qemu_fdt_setprop_string(s->cfg.fdt, node, "device_type", "cpu");
> +    qemu_fdt_setprop_string(s->cfg.fdt, node, "enable-method", "psci");
> +
> +    return cpu;
> +}
> +
> +static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
> +{
> +    size_t i, j;
> +    DeviceState *cluster;
> +    MemoryRegion *mr;
> +    char *name;
> +    g_autofree DeviceState **cpus;
> +    const char compatible[] = "arm,armv8-timer";
> +    bool has_gtimer;
> +
> +    cluster = qdev_new(TYPE_CPU_CLUSTER);
> +    name = g_strdup_printf("%s-cluster", map->name);
> +    object_property_add_child(OBJECT(s), name, OBJECT(cluster));
> +    g_free(name);
> +    qdev_prop_set_uint32(cluster, "cluster-id", map->qemu_cluster_id);
> +
> +    mr = create_cpu_mr(s, cluster, map);
> +
> +    cpus = g_new(DeviceState *, map->num_cluster * map->num_core);
> +
> +    if (map->dtb_expose) {
> +        qemu_fdt_add_subnode(s->cfg.fdt, "/cpus");
> +        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#size-cells", 0);
> +        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#address-cells", 1);
> +    }
> +
> +    for (i = 0; i < map->num_cluster; i++) {
> +        for (j = 0; j < map->num_core; j++) {
> +            DeviceState *cpu = versal_create_cpu(s, map, cluster, mr, i, j);
> +
> +            cpus[i * map->num_core + j] = cpu;
> +        }
> +
> +    }
> +
> +    qdev_realize_and_unref(cluster, NULL, &error_fatal);
> +
> +    versal_create_and_connect_gic(s, map, mr, cpus,
> +                                  map->num_cluster * map->num_core);
> +
> +    has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
> +    if (map->dtb_expose && has_gtimer) {
> +        qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
> +        qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
> +                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> +                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> +                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> +                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
> +                         compatible, sizeof(compatible));
>      }
>  }
>  
>  static void versal_create_rpu_cpus(Versal *s)
>  {
> @@ -1277,11 +1455,10 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>  
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
>      DeviceState *slcr, *ospi;
> -    qemu_irq pic[XLNX_VERSAL_NR_IRQS];
>      Object *container;
>      const VersalMap *map = versal_get_map(s);
>      size_t i;
>  
>      if (s->cfg.fdt == NULL) {
> @@ -1290,18 +1467,21 @@ static void versal_realize(DeviceState *dev, Error **errp)
>          s->cfg.fdt = create_device_tree(&fdt_size);
>      }
>  
>      s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
>      s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
> -
> -    versal_create_apu_cpus(s);
> -    versal_create_apu_gic(s, pic);
> +    s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
>  
>      container = object_new(TYPE_CONTAINER);
>      object_property_add_child(OBJECT(s), "irq-or-gates", container);
>      object_unref(container);
>  
> +    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
> +
> +    versal_create_cpu_cluster(s, &map->apu);
>      versal_create_rpu_cpus(s);
>  
>      for (i = 0; i < map->num_uart; i++) {
>          versal_create_uart(s, &map->uart[i], i);
>      }
> @@ -1348,11 +1528,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      /* Create the On Chip Memory (OCM).  */
>      memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
>                             MM_OCM_SIZE, &error_fatal);
>  
>      memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
> -    memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
>      memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
>                                          &s->lpd.rpu.mr_ps_alias, 0);
>  }
>  
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
> @@ -1456,11 +1635,10 @@ int versal_get_num_sdhci(VersalVersion version)
>  static void versal_base_init(Object *obj)
>  {
>      Versal *s = XLNX_VERSAL_BASE(obj);
>      size_t i, num_can;
>  
> -    memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
>      memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
>      memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
>      memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
>                               "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
>  
> -- 
> 2.50.0
> 

