Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74872C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 07:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgfr6-00016D-P9; Wed, 21 Aug 2024 03:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sgfr4-00015d-WB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:34:07 -0400
Received: from mail-mw2nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2412::614]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sgfr0-0004es-N8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pam6MU1jBIBRiZrTClcOrX4OmDHakPkE/yULimNhAXg+0FVofJkwewP1qzpDzxPWugXPnWujXo3UkWTdqhwNrgFNCsMUdmX4Tmn7g4t6Onb1YgJJN9UkKiYXVi1F3DkgVRDOpgjb2vJGjZQfNAWUxu8a2I7L2kGYRpBu4SMhZYPt5zdFOvVvwsTfqfs1cj4PsWaU9+9h0z5VemMVcFl9ItseHbFeNBn2/bxYy97untSNSR+LSayJO1qidYmptv8ZCqnDXA/Yc8aotgXBlkh6ozh0eIg9xgm2ulHTIZgu33F6Q5U+266fijz637ULhr1+7MSXLCfh/PKwDQ7wFDSSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMzDPxAHCRC/lwRG2fB/XGKcvbL1rDnJotZwNQcMbUY=;
 b=nVOqVYTEmyExF0OssbTgfOVjuRWW0v4ogAhDsx5+mAwi87x1HXe/TbnEY7XmC6F37odcSB07hx8ddd7/DJoCoouKMDmtEbHyHBXXr96TZFXCRlMsZ+p/dK4bHhBNlM6F2Q4p9gpPwxJtxfiXY9A/5caVqoL9rKzUj6s3Lbz4tw8EIVRHdoR6YgbdDyJJj59AjeSlrYzkuokEKNKIrUnQ4hEa8su3s+ILkzEKW0GPeDgca3nn7oGP7HlkpZdROBIXB86msajWE8Dto+XpFxXSxe2m+JxMIARWCB8BvQueQElI9PnglBMgH4S+KKYKvWk11/XWNhrJ0aqOGFhs4SwsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMzDPxAHCRC/lwRG2fB/XGKcvbL1rDnJotZwNQcMbUY=;
 b=13EWHiAQHRCYbSibljc3/QZ3D6KeJkjwSpPtBOOD1dHRxt1oNEM/W+Duzt4veijHEbxEf5Ddwvu0nW1YdGSQpT06XuzwvFw0Oul0dCSXZFz7W8H7kBN6NfYhl2o1mt1CJEJdo1SxZXieUDbHW/BkZvKNW6TWYdpmxqsFmed/Czw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 07:33:18 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:33:18 +0000
Date: Wed, 21 Aug 2024 09:33:12 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Doug Brown <doug@schmorgal.com>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
Message-ID: <ZsWYOGfAO+gKXhS3@xse-figlesia-l2.amd.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
 <20240816163504.789393-3-doug@schmorgal.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816163504.789393-3-doug@schmorgal.com>
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: f23e8384-e325-4b33-be6f-08dcc1b386f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sis0c3R0dmc1T3V6cW5Mak5DaGFlcEdwOUFKdzc1aUFRZXNkdGFMK2dLWUlj?=
 =?utf-8?B?aGdlTVI5bVBZMmF5d2JEY2tqbVRNaVVpVmhNbUh6R29XaXZCTnlKT2lpNzR2?=
 =?utf-8?B?QVZPWHBsZ1phbHF1RDhsVWI5amNvRGxyVWo3cVk0eTc3YmNHM0kzSFZlcTVw?=
 =?utf-8?B?V1BUNm85YVJ1RnBYWlRwQVN3bXlxVTVEOGxON3FUZWdiUE9yQVByekRIL2Nw?=
 =?utf-8?B?SkNJV2VjNkVLa0hhdWpSQThaYzBpcys5N3doRkY3ZEhjUFhWY0ljM0hVZXBk?=
 =?utf-8?B?eitzaVRQOVB1c09GaXVncDNYL014R2FKM2FzNmhyQkxoclVaQ1RjZVEvdXBH?=
 =?utf-8?B?aENzVmNibkFIOEpSN096WHFlaFBYcjgwQjNyczExYTIzRkpDbnM3Q250RHln?=
 =?utf-8?B?TnBFVENwT3lQZUl0YWN4UHBkK09EUEptOUZhaENoRVVoSE93eVZOcm0yVEtk?=
 =?utf-8?B?MXR0ZHZjNDBoKzIwemVwREVPWnkxWmd1Z1JiVUZwSldSWDlnWjM5YWl0ZC9E?=
 =?utf-8?B?K0VTR3MzNWk2Vng3dGlBWjhBMlptNTAyS0xGVVo4Y2JrWUJQZ1Z4eHBjZmQ3?=
 =?utf-8?B?MHNoQWFWQnp4RGJYVStDZEROR093TUF4dEJDa0hmOHNkWm1ISzJ1RDR0dEkw?=
 =?utf-8?B?YlU3dE1MZytSaExQcFdrMFJLTFJOS0JDR1JSTDNDM2FlOWRWL2t3YzZYNDR3?=
 =?utf-8?B?cHZTUERodmpRYU84TFluNm0yb2RnaERuejRJaGpGMVNvUnYwYmFjcm96NmRP?=
 =?utf-8?B?cUpVVnI1VFk3enN3a28yREpFSkY5RFMzSE9sZXo2MFFxc0thS2xvUUYzVk9N?=
 =?utf-8?B?VXRrakxKaUJLV0V0aVFRRGttdzVsRkFvUmc1TXkzTG5BbmJLUDl0V1ZQQmMw?=
 =?utf-8?B?TXpQTGh6SFZXTlh4ZjlyOURXM0NWUTNUNHNSZVN3M0ZlRUUyRkxST25PdXY1?=
 =?utf-8?B?LzNiUE05WVUyc3JuY2tYdTljeUNnQlllTVpGMFFEMG9NUlRwQmZaYUNsMGdT?=
 =?utf-8?B?YVRJcEkvckdtWVQxRjRLNjJyLzFPdW10dGRFU2RKblRtdTlaWXg3V1FyTTdK?=
 =?utf-8?B?VjBFbG0wazBGemhXazcrUi9SUmswTlpJdFdWNExKd3NIc2RFSHgzV2FNUmJj?=
 =?utf-8?B?cFRxWFRSVDNmT1p2c0hSNWZuMzMrenRLbHN6UzVJWWRsTkg5NnY0RkFnVjBQ?=
 =?utf-8?B?cWJvQ0IvUGlERXk2TFVsaTRMZHdTQVVjKzd3ZHlxUmF3VU82SXBqK3JqQkx6?=
 =?utf-8?B?enFJcEYzYXZyVW5ZU3FwaDVjY0EvQ3VtNE9UQVZJR3JzVWl1V1ltM2VlNXlt?=
 =?utf-8?B?YTRHS3ROb1RtNFNCeTNOM040WGZTcVduZHJHK01ENzlPTkdRSnNxV1hOSFhi?=
 =?utf-8?B?SnQ4L3JuMC9zQlVYZWlEZ0lzSjBHeGJxYVVlSmFjdFJhOEFyQW9DQ1NMZVFr?=
 =?utf-8?B?WCsxckZTcTFHMFNrUjgrM2tlZHJrMzdzaGJEeFVKTjh0MGYrQTF3djdoekND?=
 =?utf-8?B?MGpGQUI0Q1REZEJhZFFZay90MWxKWnhPMURCcklGb1N3a3g0SW1OVERQeDJM?=
 =?utf-8?B?T2pmSjNPbVZ3MmFIRGFwcDd1S0JXV1R2SFJGVmhyYVdFQmdxRFNTVXpKOFhI?=
 =?utf-8?B?RWlJUTdBc0pSNGN5Q1Nxa2NMWVBjeUhyRkFtdDR2UTRpcXVETEM5UnNRS2Fx?=
 =?utf-8?B?UTBYakZoVGh3cnR3VzVCT0ppWHhMOElCUFVhbEVnRXFIM1R6T2JTL09odW5C?=
 =?utf-8?B?bG4vUitBcVI5UXI2VEF2MUtWd0VubHNIc2pOMUhyajl4QjlvRmhycnBIR2c1?=
 =?utf-8?B?UHlnVUFaQ3dYNU80WUQwQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhkVHk3anBsaFNBUWtPejl0MDczb05QMmFoTWNJcWJ2YVN0YVEySS9DS1ho?=
 =?utf-8?B?cURVV2ppY2Rzd0NLZVJHRTdSKzJQMmRFaXlSQjJWTTY2dTBjSksyZlppSjRG?=
 =?utf-8?B?cGowU1hORnpyMG05TEdSVnMrMzF2RVZFSFFSUjNOaHJRVk8xdWwvcGFrcDhH?=
 =?utf-8?B?MkZoUXFNaDg2QTZia0RkUi9jcmJBa3JVc1VZTndpUXBpYjZaQnVZZ2M5VUkr?=
 =?utf-8?B?SnpvMmp2eVZvZVFPc0pNRXBnSjJSSldGWDkyd3hyc3o4OUZDcnJyeUZEZm9Q?=
 =?utf-8?B?eGRxQ2d3cUU3MXNHMU9rT0lpYlhrYjI2aThkL0svZVBpQjdtcW5vbGo5bGR0?=
 =?utf-8?B?a3IzQit0WTFGYUY5bmcyNXNxeG5Nb1dsYXFpZCs2Qy8yT3d3YmFrL041RGlH?=
 =?utf-8?B?VUpKWXhDOG9rcTRGR3prR1BRSUw3cHN5UXJyWDJBaDgxWkVON3U3RnhIZktl?=
 =?utf-8?B?UCtyVHhMK2pveW9MQkxaNm1FcDVMVjYvYk1nQWdzZG9COHA4eWE5MDBwbHNy?=
 =?utf-8?B?ZkFNV3ZrR1ZFanlIelNYTWlmT0lyTEUxVVpHbDB3ZW15NGh0V3FVM0Ura2lz?=
 =?utf-8?B?RU53U2FQakVXWFNCU1pOem9JTURhMW1iVStqc1JpK1JVcEJPb29NNEYyM0hX?=
 =?utf-8?B?MWlJSy9CTm1FWGY0SCtwakh4dmZvNGhZVjdnTG5UUkdod2JuQjlrZHN4cnI4?=
 =?utf-8?B?aHdLYVZrclJLeHBndklZK09TYnJrMmUvSWpNZkk3cmVUVWVFVmc3Sng1dmF3?=
 =?utf-8?B?aWh3OFhkVU1LbHFCOUpiSXR0dDhOdDc0YTNPWGNzNEZubm9EMFByR2NaV2Y2?=
 =?utf-8?B?ZWh0OURhRk51MURsa05idGdHb24rb3M1V2w1KzdsNXJnQ00ycmpvZW9MOXBD?=
 =?utf-8?B?ZU9ucWVqTDJGaHJpc3BBZ3NpdXRLeWhaSEhHTC81NU0yYVlWMVJxSXQ1SjJ1?=
 =?utf-8?B?WkQ1MnVoMy9SeC9KbkZENmxLUG5BYlkwVzlEVTF4cnNIV2F4VldaaWRTQ3Zm?=
 =?utf-8?B?T0RYSHdQQVBYUGpLb1NXOTUwbXVsenpJRm1wYlJXUWFTMTVqNXhJM1JJVTEv?=
 =?utf-8?B?NFlTeFVCa0NTYUdvb1dBL0dvOGcxNk41TVN2TjFOVEFTSlpady9OTEJ2Qk5P?=
 =?utf-8?B?MllVR296ZS9MZG5NU01HOXdNanFBUldNYWdGZFQ3R1M4WUlpajQraGZ6MXN4?=
 =?utf-8?B?a1ZLL1hXS1hKL2pkbDdlSFpHeFNLWDMrU3JQcnl3SFVVZWxYTFY4QjhJZkcw?=
 =?utf-8?B?SHBZSDFCYnM4dWpndWt1U00zTDlPYVUreTFzZFh5MC9JSkRZLzVzSUJHUnp5?=
 =?utf-8?B?Qi9vOU56dmg4bjlnOTNXQTFzbnFMRlMxMVJ3REp5NDZDQ2h5Y2crR1p5cTQv?=
 =?utf-8?B?KzQrSUVqZG1jK0J3TVYwb3Fob1dOLy83Qjc1M242WE9YUFBvakplVEJXYkg2?=
 =?utf-8?B?cTJ0RGFjRE9UWkgydmgvekFXVlpTU2w4cXdSWnRRcVQveUNPSkZUTVZtaktk?=
 =?utf-8?B?dVJscTdTTDZWZlhkbTEvakVENFlXdjZiUWdqbDhQWlZMVkpPVys1cWU1U3BY?=
 =?utf-8?B?b0hWcU53dHp3THBMVUJVaEp5VmN1Z05aWFkwYUNnekhDYjhoVU5YVlJlcVZI?=
 =?utf-8?B?Z1k4ZTZkYXF3dkhRU29XNktqRzFCamdIYlhYUVJ5THBBNGVtYUFEaEJBN2lH?=
 =?utf-8?B?TEdTUGFack5xN3U2ZnNuaVdSa1laNDhCM1NGQkZkRmMyQkMrV1B3c0paVW93?=
 =?utf-8?B?MnovdFRVOEZXeXhNdHZOY3VTclUwUjlWK1puTndQcEhrYi9RWEpiaFl6MmN2?=
 =?utf-8?B?ZXkxa0pPM2VybkFDV2VFd2hsK1l3NlJOQTlMM0UzOXNZdVpucHlId1R0MGU1?=
 =?utf-8?B?RlRZaUthcnJlNjNEQlNKUDRsMEhlL0Y2dHJIWUswelFnSGZxNktZMjdFQzBX?=
 =?utf-8?B?b3lscWpyUlpoblBHdk9sVEZwYkhXTllGTVA2N0FTTTY1dTlOVE1ua0dnUlpn?=
 =?utf-8?B?RTJ1SVNFNGZkZHZDSUZKek1CZ3JtYVZRTWpWVy8wSnRYTEdHbVQ1ZjQzZFlC?=
 =?utf-8?B?blhQbyt5STVkOGpVWVlZbG16dXovaWhReDI5dzROR1kwdUEzcUVVbGtFOTA5?=
 =?utf-8?Q?F6pTDQAvymfZfJVg+clxMjqf7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23e8384-e325-4b33-be6f-08dcc1b386f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:33:18.7923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0//IXrS0FrXNpcRlhw+S3myuEdQEtoOzVXzZ5tGxgx4/G61OvV/BnSZjr4oOTL40nZXESs2x+JbpZYA4Z7uLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
Received-SPF: permerror client-ip=2a01:111:f403:2412::614;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Fri, Aug 16, 2024 at 09:35:02AM -0700, Doug Brown wrote:
> When checking the QEMU_CAN_FRMF_TYPE_FD flag, we need to ignore other
> potentially set flags. Before this change, received CAN FD frames from
> SocketCAN weren't being recognized as CAN FD.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/net/can/xlnx-versal-canfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index ad0c4da3c8..8968672b84 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1003,7 +1003,7 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
>  
>          dlc = frame->can_dlc;
>  
> -        if (frame->flags == QEMU_CAN_FRMF_TYPE_FD) {
> +        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
>              is_canfd_frame = true;
>  
>              /* Store dlc value in Xilinx specific format. */
> -- 
> 2.34.1
> 

