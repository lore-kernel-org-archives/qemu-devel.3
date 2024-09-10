Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51887EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzVK-00056d-Ey; Tue, 10 Sep 2024 07:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1snzVH-0004tw-MP; Tue, 10 Sep 2024 07:57:51 -0400
Received: from mail-southcentralusazlp170120000.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1snzVF-0007cD-Qj; Tue, 10 Sep 2024 07:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/Df0borkUFDLCTgh+kYb19TpEjuVjvxQeLSjnNEBXXmgsath8iUHMLjrDpuJiKhg+rB7JV8IOacEXL/5PCJaGdC9C1bkowIhYuB9PnwW7M6PEhTU1cneczOitgp7Ru9JzI2JNxUHmB7g9/5+FuhRMvzllWeKs6zqdG4AZzAyLt4a0NjO2kC8G2PA2c63RWabcrjSJZLEwjLGaoptS5vV1nXyAQbrqoE26WkQBKBJ4rLOd7LH7WuSwhIcLiN4TU/bQd6aTp7JczQ5H03R5Pd1BD/uw3d3BWLqRXJ7iVONILn1iUqvAxq5X0SV+A8UAsf1Gnqfh86HSikmBtvSBhcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo68Pn2l/esMH6pijcrsIzXi9KUHYORFO08IdUBPYf4=;
 b=PeacOs6zuxebPIKgrVNP2QgE6GN6XaZpap9YSfneY4LoJovk/R123Vg1J+QALCfApsRKJfbLfnz0XSFsxCaB/5fl4b6siHkNW6BPJMiCtQrsyu7FR9bvJWnJdVGOdqdTUWwyitjgCj0aOdKJaaDJvV5faIDUEF3J46QN2yiiUxONWaSSlk2LCVj/sYYcTzgw4vL6d6vARI1kNE4sOiQQErHQHJ9OI+Sq4ArWJ+ahZqwsAg52i/edALNTqIFUWcNx0a6ZOC30ppnfr8/p6KQif6FE2B5m6QLqb0dek59l01Mghiz5g+61R+iyFkJuokJtLYGvckQ5LAsATgFYsnxCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo68Pn2l/esMH6pijcrsIzXi9KUHYORFO08IdUBPYf4=;
 b=jfm4aRfRKsgo8VemcSipIA0o68IGxHd8DcRjitmehtsvtz91FZG3onDMnp7kKPyr4wbWGkmUOnhlfSsKbxob+F0eFMfVhRJnOc2sjgUH29BRLRMC2eit+RZOgLWDeV0WO7syA/2K3bODlsi57b1crNXPtqJbAA98dgiXduZyo6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ0PR01MB7447.prod.exchangelabs.com (2603:10b6:a03:3dc::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Tue, 10 Sep 2024 11:57:39 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 11:57:39 +0000
Message-ID: <0b5764d4-fd63-4779-a22a-8e10ebafbcc7@os.amperecomputing.com>
Date: Tue, 10 Sep 2024 17:27:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 darren@os.amperecomputing.com
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::16) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ0PR01MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: a855be5d-49f2-44f9-e20f-08dcd18fc4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmMxdnE5Rm93V1RPUmVBV09TY3dQZ3dETmZGVWJmMHpYU2ZlMmhlY2pQR29s?=
 =?utf-8?B?UG94Rmpna0x4L1BhWUp2cmhvR0NSNWlVaUxzMWR0ZXFvTktaWUdQNityampu?=
 =?utf-8?B?cWF3dm56SmJrRjg5WGQzMWVIUEt0Qm83TzBMYjU4ZzZyQmdJL3E5TnhRNFRZ?=
 =?utf-8?B?cU1NMDRrQVBrV1Fsa1laR2MyeUwwTWtZMjRQNHpxdGR4ZlltUVBQUGVMTmNu?=
 =?utf-8?B?Z2MybnFNSTNDcjN1YkcvWEtBWkZmYkV4MGpEWGt4RHBOeHNGamFpU2VZcXlp?=
 =?utf-8?B?OTdtbXlHUERic1JzTGlLdnZYd1FVSWViN3dFZ3hSdkxOYWprdXRDZm00K2kz?=
 =?utf-8?B?RVVpYm5MdCtHVTk0a2ViOWFTUnFMTnJxMUs3dGtweWdFMVl2MzMwL0JFbTdl?=
 =?utf-8?B?L1VIWHFEeTVpQyttR01weXZ0U1ByRUxST3BYMmc0OUZiRk8wclZlMGhGWTJl?=
 =?utf-8?B?RVRrb1NkdnBFbUs5QWwxcVJPYi8rbWFVcDZGMnZIQXlubGZkTzRuVjdoYXZC?=
 =?utf-8?B?Y1pEZUY3cC9ZVnRKTFRaUEFobUk4TERaaXM0M0d1cVB6N1orenMxMTFVVVg4?=
 =?utf-8?B?QUx4Mm5KNGR2MlMzVnVtZm5GbDh0S3R6TGFWSVgzQXZaK0RINnpBbm43TXYv?=
 =?utf-8?B?MHlMZVd5OEZscTg3MDdYS1JKRmtXVmQ2NlBVbGRiZllkUGV4V2dDTG1YM29R?=
 =?utf-8?B?NlNYN0J3V0F3L2J3RDNsZ3BnQUNsZzJhVjJ6eWpjWXlRWnZwd0ZITXdEbDJo?=
 =?utf-8?B?ZGQ3L2NGRWh5elVqTzlOcjNqMFJ6NXhNUXB5S0dxRzJqWEYzZzd4OWcrbFRR?=
 =?utf-8?B?bDVNMU1mZGUzTXVQcjB0b09JUlMwUzZ5SjJGRFBremFRK3JoZG9ad3RHbHlM?=
 =?utf-8?B?NTFrbUFiVzFhdXQrZWhuY3o2OE9hSHJMRWcrTGk0YWZPSzlMTmdxWTYvNWtM?=
 =?utf-8?B?SVlaTG5yTFEya1ZQVjFoOXY1aVQ1UXJkNXFQQ2g4SVZOUk9KRFo4bHlESDhP?=
 =?utf-8?B?ak5hbDRFVzh4U0ZGQktnTVdVUVJBN25maUFoMjRnSHJ3TUZ3c1ZIZXNjWnF6?=
 =?utf-8?B?ZzJIR1lad3VOWWxJNGJmUGI4eGJuSjEzVUhheStEOFc2Q20zSlFOSXJ5Z2du?=
 =?utf-8?B?Sjd5cnc1cjNtQk56UnFPb1Y1bmJtR2xhY1pUZFFyNGNkcTdlYm1uUG1kRito?=
 =?utf-8?B?dHp2VE9SQVN2Q3RVSjNSeEY4RTcvT2pEVVNSQ3ZMR1AwUkdRajFMYWlNSDFM?=
 =?utf-8?B?SzNZVFllaFlQQS9mNjNQdUpSUElVK2tPcm5KU3dlbDdXNitNOFR0NDFNbFFN?=
 =?utf-8?B?cjRncXk1ekg1L0ZrWnZsRjB6YTg0SmlCSTFFRUxiQ0pGQ21kZVJiK01xUDlY?=
 =?utf-8?B?QXNSUTFTNmhnUkxWOG5FYVp1Z2FwOG9qQzZ1eFk0a0FlQzBuK0I3bGFFOVJ1?=
 =?utf-8?B?YUxkRWVFczdCeFg5SDRMYzdtR1Jaem9QQnlqa3dtMFpwWTFnWVplQnZXbXBy?=
 =?utf-8?B?TjdpY2ErWDZlNHpCV2QrTCt0SU1pWXJuVG9DSTc2Uk9xK3ZBcW1CNmZqM25P?=
 =?utf-8?B?NTJETWRiZGpPbzhURzZtQ2hUZnZkRHh3TlRXV2puRWYyTkVXWDRTY2ZjMUZt?=
 =?utf-8?B?Q29rZVZqcHdNUXdlWDd2M215RWFhYzIrZkxZMUwwbEZONE5OMzlNQ05mS2sy?=
 =?utf-8?B?dm9SQ1plSEtjT1FiYVVWblVGTGxjS0M4b0hnZy85S0JUSDB0QkJ1a2hoUDhj?=
 =?utf-8?B?S1Jqb3I5dzN5bGdNSEZhVEZqdHRINFhSSGRXeGgvNDIxSVBZYXEwWFJHWWIz?=
 =?utf-8?B?ZGp2OThlVFY4dWFDQ0xuUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1I1VlIxK3pUdDlwSit4UHk1OW5OTTBUeGJHSzJYVnFkWlBFSEo3NWlKSXcy?=
 =?utf-8?B?WkgzbmFadHF3SklTenJBMU5OMUJUZmFTUVd0N1hoaXA1V1lHd1VYN1RMWDY5?=
 =?utf-8?B?RkFoS0plNU1MSE1JQ2NOS0dESmdXWm93c29YUlljbHhFOStRU1NuM0FBVlBo?=
 =?utf-8?B?c05xZzBMM202QUxaTVVxaUdnTDFJWlFRMEJmVDdyYVVqZmZoNlMzKzlEY25o?=
 =?utf-8?B?REM3UkZSU0Y3aHpzZnBCN1FuR25tTjhNZERJbTRGMmhiaXdjWFhma254a3JW?=
 =?utf-8?B?TWlGMlMzRHJRZnZYZklrOUlBQlM1cmF2NHRDbWI4T0lBeU9qWFlpMzhtOFZ5?=
 =?utf-8?B?U29IYi95VkJhQVE1VXF1RmhETE1PdVRDUHpWTm1UeHNYWW5rdUw5QUV0N2V3?=
 =?utf-8?B?V1pqb2dPRWVPNzVGSnMrelVtTThzL0YxQTVzMXk5S29VdTFjcjJMc3I3Sndu?=
 =?utf-8?B?T28rSnRSdGlFY3lBZ2U5cFI3QXlOb3lHYzBPTG82ellRajJYbkllMzBBNGdT?=
 =?utf-8?B?SEw1VXBoTW5tUjlSNUdFamZHdmQrZEFhczVLZ0R0cGxKRTBzbld3YlcyMkhO?=
 =?utf-8?B?Vk5CWWMzNnB4dURxQmptdGNYd0JnaTZoYmpIU1EwUzI2MWUzWTMrVHY2d1dX?=
 =?utf-8?B?cXJLQVJMOFF4czRMUU93QmpjTzFPamJrNzJZQ0ZrTnB1MFFoYmZHT1VqdGZy?=
 =?utf-8?B?WXoxY1ZCVjZOTmw5QkxJOG1vT1JPSFc3Y0tJdGlkcUhQQjIrS2ZZWXFKNHAz?=
 =?utf-8?B?TGF6dnZsTEZsVlZoL0laU1lNTm9MT2tlY0pKQ25ienBKSER5ZkRhakdCTGlT?=
 =?utf-8?B?bmNUMm5RTVV2MVBuMVlHQjZlc1g0cjhiOUFmOWdqK0kzYXY1cmFMcTYzZTZa?=
 =?utf-8?B?ZkFhZmFtbnd4QU9HQ1ZjNERWNGRjV1VXeGRqYmJqNUwrbWRrM2ZQelJ0VXho?=
 =?utf-8?B?OGRwL0JRTHNOTXlzczV6cXB4eXZ1VkszUXhOT2taSFJHbWZZZm1pSGFVSitY?=
 =?utf-8?B?Q2FiSm12dnNnQzZ3RkplVG53bnVnc2FranFFSkM2Q3RuakduZXIrSXBVd25h?=
 =?utf-8?B?OUpmbTRkdmwrVUIyK0JUQXhWa2doTUZXbGltVFIvaVdxSVpKNkhpYUM5WFpJ?=
 =?utf-8?B?TVlhZFAxNWNjMkhyZVZmNUlZcnNBbXZFcHVuRlA0Uzk1bGVZMkYvVnUvaHlN?=
 =?utf-8?B?VFovcDBJTi9tcGRrK0Q2dXlyK29DckN1dlpFVzZkRFVIeGtYVVZ4VGNhbFFw?=
 =?utf-8?B?c1FJSlJjTWpQbnE5aXhGZmdFQXVGOGZObmYzUWxKVU0vRXBVek1LYnh4VzZI?=
 =?utf-8?B?aU1SMWIxR1lWT3ZXc2ZFQ1lPSzk4Z2Ziek92VXpiVkE4d2dSUWdOcVZ2Wjg4?=
 =?utf-8?B?YlNPclFLRGxKNloxNEtuL2ZpL04xM1dnVWdwRktVOVJBYTdFaFV3RXl3V0tJ?=
 =?utf-8?B?YklhK3pkdUNlRWQ1eTlaRkV6SGErcE1GdWNxcHA0dldBNE9LZTJZYnZ5K1dy?=
 =?utf-8?B?c21KaU9JalBEcm1oRklUS2dxcFlJRUU1NmZFSUYrcmVWNXErcWJZUDNJR1Qx?=
 =?utf-8?B?ZzhLclZETVVvWXNWcEtPQzMybjVoY255N1NCLzVlU3lrMVV3c0FPY2RhTXpv?=
 =?utf-8?B?RGlUSVV3NTVyVE9JcVBqRzBsSi8yL1dNczFuL0svQUxkK2pzdENKaGl2N0t1?=
 =?utf-8?B?ZWNEa2RvblNWNjF0SytVZk96ZHhLaG12OUhBQ0xsUGxjNlQwNkIweHNKd1NV?=
 =?utf-8?B?cThqNlUzVXZicWdCRzlIdkpsaE5qd0k5ZTIzY1ZUOWx4bkVmOTF2RXgvenNp?=
 =?utf-8?B?MHM3OUtadXNJbDBsUGNwWUY4VS9ONGY3QmFYWEplQ3MyODdHL3MvMWdIbWla?=
 =?utf-8?B?ZUNXUllLVmdHdXhHT3B1OUljNWFDaUJBWUhFOTJaTllQWC9jbkt2TWUxSlRM?=
 =?utf-8?B?TjlGbDBEbXZmbTUyZzZOODRrUEdmcVVybkllK3J2YVdHS09OeVpKOUZKMi9l?=
 =?utf-8?B?STErSWthbFk4ai9jN1pFaDhMLzBYcHpHRjRIV2lHcld5Y2QzSkZrTVBjeFBw?=
 =?utf-8?B?NmY4QytwVWZBbXVxTmpPYXNyQVcvU2tvaTFmY0c3QU5TV2ZpNm9ob1R2V3k0?=
 =?utf-8?B?VHRSL0s0Ty9SZXk1TTNuNGR4VmNWeENzNzBmbEV4S0VpaGoya3hOK2J1UTBR?=
 =?utf-8?Q?6uzSR9zMbIqOx9KS7Q3Cj+M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a855be5d-49f2-44f9-e20f-08dcd18fc4a6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 11:57:39.0732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TesyZ0c2Xm4SM1eNyEw+6XygtCZNae1bwWgegJs5bTlZf0oHGQlQsxpUsgBUXKVgahDsi+qkxs/ZzttQaFAn1yuSjYJmG+DnarO3BYS6xvKj1qrMGPKgCvNr6hrY434+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7447
Received-SPF: pass client-ip=2a01:111:f403:c10d::;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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


Hi Peter,

On 16-07-2024 09:15 pm, Peter Maydell wrote:
> 
> In target/arm/cpu.c:arm_cpu_realizefn() there is this code:
> 
>      if (cpu_isar_feature(aa64_mte, cpu)) {
>          /*
>           * The architectural range of GM blocksize is 2-6, however qemu
>           * doesn't support blocksize of 2 (see HELPER(ldgm)).
>           */
>          if (tcg_enabled()) {
>              assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
>          }
> 
> #ifndef CONFIG_USER_ONLY
>          /*
>           * If we do not have tag-memory provided by the machine,
>           * reduce MTE support to instructions enabled at EL0.
>           * This matches Cortex-A710 BROADCASTMTE input being LOW.
>           */
>          if (cpu->tag_memory == NULL) {
>              cpu->isar.id_aa64pfr1 =
>                  FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>          }
> #endif
>      }
> 
> With this patch, for KVM we will end up going through the
> "squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
> set cpu->tag_memory and this is still using that as its check.
> 
> More generally, how does the enabling of the MTE KVM cap
> interact with the ID_AA64PFR1_EL1 value that we read from
> the host in kvm_arm_get_host_cpu_features() ? We care that we

Linux kernel masks the MTE bits of register id_aa64pfr1 until unless the 
MTE is enabled for that VM. I have modified to enable 
MTE(KVM_CAP_ARM_MTE) before we read the register id_aa64pfr1 in 
kvm_arm_get_host_cpu_features to make sure we get the unmasked/actual 
MTE bits. I will post this change in the V2 patchset.

> have the right ID register values because we use ID field
> checks to determine whether the vcpu has a feature or not,
> even in the KVM case.
> 
> Since Cornelia first wrote the patch this is based on, we've
> landed gdbstub support for MTE (so gdb can find out which
> addresses in the memory map have tags and read and write
> those tags). So I think the KVM MTE support now also needs to
> handle that. (See aarch64_cpu_register_gdb_commands() in
> target/arm/gdbstub64.c.)

I looked at this code and it looks like, complete code is under
ifdef CONFIG_USER_ONLY and for kvm(target aarch64-softmmu) this is not 
getting enabled. Are you asking to remove these ifdef and make
mte-gdbstub commands available for the KVM mode as well?


-- 
Thanks,
Ganapat/GK

