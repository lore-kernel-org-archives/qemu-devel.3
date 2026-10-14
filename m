Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AB9CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGydu-0007WC-HL; Wed, 14 Oct 2026 09:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGydg-0007TM-S9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:03:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGydb-0002cJ-GV
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:03:23 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E8BftW3105948; Wed, 14 Oct 2026 06:03:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qDGlc4KIzab57tfuuVXGckOObyjamYQELX8K6xpSR
 Tc=; b=u13z+ITSShFY5YXw19ij7uj3fnF/axBEpukBlCyrJB9/B34H8T4zzV2r9
 0qbNkiYDFgzJPDUOTJDw5VMVH1HqTQAFess/LnYy/3r0WKEePeRru1DeYDd9WWu0
 /Bf6vCNVfMN7Tvwq3iOgys7CY++ZcvcCibch+7vts+mqPO7TIQs98FHY1q9VyiWW
 aJ950BT9gx01DISk4eZgheA1V3eZpBoVCJidBJ9tAz1T1SCzyf0igqi0+CS/zh3N
 CJfH8j3GYhKENvjiFxogaQIyO5yoS6LSWwC/BnpQnW2VAwojV8OAsD4B3dwUESGe
 8gL31xOFLPAPTKoA+b4w7Nf0Lk+Ow==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022125.outbound.protection.outlook.com [52.101.48.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9nym34su-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 06:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySknHBSwSHeRoj4V+l3Ds4EhQmhxPC4aQUzaV2+qr2abKXZtQ0USip7A5KcvZwGAK4wdJFYCM+BcwgS2qthcEKRZtYc4xIsXWdDt+Wjpn5vNzWOW1asna46jBswU6+rtaP3KXiWRul/hWOo8ngK+kQ2v/zPDeiJlfe14jHUy7J5F+PdPP9oth7OV2Ymi3inRkMC9bzNttsDzI3tQ8lWSgubpHanUB4/Mm7qNHgimVup5My2pYqE9MAYfCmga7LuatPu2PgknsEBepCb8jEdLqpdvunswXZ0jLNUILPviy8Qg4XSiMFmMJIbfDcDalmoEnT7zHCf/sG8OO4qK0Nc9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDGlc4KIzab57tfuuVXGckOObyjamYQELX8K6xpSRTc=;
 b=vAx1Ehmvxp16uZkxUXz1APg/y+IBcUt+K+1CaMZ89yK76U0zqMz23pfi9uQrox4caxZjVLsvcZPidEYPPYVyLj5u+WxB4vHdxZ5Ohwt/qlXuNpLbbV2I/ft9WQXhuLGnt/KU/7/JQJtZOsGqOOzq4hO0JpGvapxz4RQwdn9hkvUfT0xQ2cGYRo2DH9IoRmN+t2OnlZ8nXKHUpXo1WRUQUHcYS9NgpfvdsK3DIxiD/+IhL0c33JnIPYO+dMwyK9nxG63iRFkYCuBjF7B7J8GBUGDPzrcFylhplCmZSfFA+ymOFnue7yYkbo4Mbx+iK6R0vq//ULdZQhpUs60Yp9wvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDGlc4KIzab57tfuuVXGckOObyjamYQELX8K6xpSRTc=;
 b=YXZGSebN/JVJxQe5FUSG7i1JmeeDQLTqAlWS2VlVzlj3tXusbcKU5KfEmKUWW1YEdbV9nIUQruOv10tR6kBvOpx5qlatYjOhEr8ZNccB43A9RitSNWN5lKgPmwl97GiaiVueCEB8zBZUoFL4BI+mRPz+iUn0pGyNnuESENavBALqHYsLpfFA6i1bIBABVTcmKTSlEu+eGHdn2kJ3pfFg1nJfk1kHeFjHOEjHLr9UOZ+9+GvCaLlSwGq7Y7fT70EN8AwE1N86ftUL7VtbsuDAIcoiRa+O+OpIuX6QIuJLSuvG1ADEATADRKJVhxcvdifrJBIprmPxlWF80/YBoltbdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB8990.namprd02.prod.outlook.com (2603:10b6:930:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 13:02:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 13:02:59 +0000
Message-ID: <6ba4cc53-d32b-4b18-af34-f0bcdb8f58a7@nutanix.com>
Date: Wed, 14 Oct 2026 14:02:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] i8259.c: introduce TYPE_I8259_PIC device
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-14-mark.caveayland@nutanix.com>
 <CAFEAcA-FFiWEs3ZLztVwZ72_TGLuhEBbfKnaZ3NFJJ1W-Wd33A@mail.gmail.com>
 <c444a8ed-eb83-4a69-87e5-57c71f3a6d01@nutanix.com>
 <CAFEAcA8v+pcFz+HsgT9M6xb_16qBKK5FOuf8WupP5KuQK+aNcQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA8v+pcFz+HsgT9M6xb_16qBKK5FOuf8WupP5KuQK+aNcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: d4308393-fb3f-46ac-9b8b-08df29f378de
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|22082099003|18002099003|4133799003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZN+RIySVFW8i7GbMof/ZfOWqved2PPoD7wypBQymXTbkaL7604FMcWF+XiZ01yoqP1gFVQ86ty2IyxEK1/7+IZYWtlHMjqhT5GOFmFEksgtUoG4e6JlaJpmTbe5kDGFaSviUNiWZIWJU6/HmgyCebKZGAuYLzNBqnZ47hroHUrAryw7yQA34aVczTSOMBJb4ah+y20ff6TNS9mBWErTmUyO3341TDPF4zPazahfz1rKNjZDAW2LlhL4/r5OYFE90sDMlkAaCw8M2Xv8IAouBF9l2w/HaUGDN4IByuVRt9yJMwkidoFneidR9ZwwKt9pPLzos3hUqqkiKF1SXg9kL26X2+lj/jDA7wc00OjS37/PVJFN/yvSuVzVwVKzuEx3z91gRsgRV44TJP+iyHH6xgdfHukqeiuyMGOboF833YRAGAKTPm5KLi3xzJlbQZAtUFHP9cS9xkJIqUOpgya1GAb97QYLhdmsdRcmUszG4eYEsHD/hT9mEcDb15EulkYh05wsFwRTsYMKjjjZKgI86ZJ6/HYv73bWsUTLGGkKgu5xOWxTAYabJ4Qy3eLrRdSQY+bYzda3FyHjFn7hLhz/aw2BUyGKiBoL10EjJx6/Zm2LQVjFdx4zUkJhq5XgzovBg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(4133799003)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REM0bERCQ0VDZXU0NWt5R1BEVFhtRWtySjJIQVNTaU94ckhmZ29aekM5YU9S?=
 =?utf-8?B?WkJ6MmIxU0JNeDJTSlJTbGNvaFpWWHFITGlyd2ViQVZMOC9MU1JPSGtsbklq?=
 =?utf-8?B?MHMrc1JqMTB4L0lVRDNEaEdvSDBlYldIRDhJQjE2TmIrNUJVSHVwck1hZWN5?=
 =?utf-8?B?VWpFT1c5YW5ROWVNSDRoV2dlSmtDR0MyWFh6V0pMTDVqRnI0KzRaSm9uTmhH?=
 =?utf-8?B?M0xOZWphR2VGYTl6Vmg3RmFIa2xQYjE2R1NPRExlT0NEdzhZN1E2SmhZaGRt?=
 =?utf-8?B?TTdmd1JYbkY1dXJLQUJFbkFBZXNHQjNpYWlVU1d2VGFYZEVSYjhtMWoxVDQz?=
 =?utf-8?B?M1ZYTWk0MHZlRWdUV29Iek9VZnVZY0xpUmxleDQ1c2ZUWnlrVU42UEVnbmE0?=
 =?utf-8?B?SXEwQm5uV2VSVkw5bVNmcWdUWmYzdDlXbnlJb1hZaC9QZkpaT1VEVlBpSFBy?=
 =?utf-8?B?SWJ2bC9CNG9ncWFFQ25wTnBPMHJQVldoMG1ZdTBrZ0ZPM2JqNXZNUW9NNzJn?=
 =?utf-8?B?ZVNtRytLS1lVQjMwSWlzSEE0b01OYUtBcXpUbENTZVdLb2VpWFgxUi9GcE4x?=
 =?utf-8?B?ZjAwT3RtSDVrdDBaUU5ubFJiS3pYRk1MRmVJcVVWUFRUMmFabWE3VUxzRHA5?=
 =?utf-8?B?dVVDVnd2ME15R09pK2xRZ1lsdVJKVy93OUlheStQN21UK1JXZHBQK3g2bG9X?=
 =?utf-8?B?Y2U3djdNb2M1R1lUT2FFNkw5L3V2cFpqa3lJMUdLRzhKR0hhc2duTW9JcTV5?=
 =?utf-8?B?bThNK0VJZlFVR29BNFp6SGlxeDczenB1TG4yUzhWc1h6aUVSQWNIMm5rWjdk?=
 =?utf-8?B?TGNNWTI5MUpMUUl5dVNJdDZ4YzdwVGc4aDhFWDVSV1paaVVNcjJKa0RYSWpZ?=
 =?utf-8?B?QjMva3NTeDhDWXJaL211MjdmTHI0TERLZW1kTTJCS2k4V2xYV3Y2RUtnMmFu?=
 =?utf-8?B?UmtRK3o3ZGtEL1REMTJYNnRhd2xYSGw4czd0aSthbDFqdGhscmtFQTVqY3k4?=
 =?utf-8?B?L3l6YzUvbU95NlJzamlGVkpvSUUwaytSMGhjNHRySWQ2dkpHV1pubDlOeE0w?=
 =?utf-8?B?cEV1cER5bUtmSEkrZUo4Tkd1Zzlpb3V5RkpqNHpQbEJFZ1JkZ3NoMjFxMXFN?=
 =?utf-8?B?WjJSR2ZJbUZNYVN1ditURGpaWVpTYXAxaWcxSVhXaUNaREdpdlRwOU9oN1d5?=
 =?utf-8?B?VEQzRkpXbHZkRU5aWkFOQlIwdFNUQVNseS9tMHU0SlYxVVU0UmZZc212SDds?=
 =?utf-8?B?WVNFNHByc2FLQVMzTzMwNnJFU3dLZGVyRS9qMmRNNTRhcnZ6L3NuQ1Q0K2tQ?=
 =?utf-8?B?ODNwYzRjbDUzN0E5SisyRTBlN3ZTWlZHdzV5SEw1am5obEpPeWdIeWZ6cXhV?=
 =?utf-8?B?RS9VaEdrWmpSWjVXQ2xJYXJHSDhvMURVVUhDYzlNT1lCNFYySjZiU1dHT3FN?=
 =?utf-8?B?OVh4V050U0h5Z0lZZDdyV1RKREdZZExYcmlCTXZ2RlVLRzBQZ1gybXZSaHZ3?=
 =?utf-8?B?R0JQT3BMVEk1eDVYSy83S2NWa1l2Wko0SEZ1VDZGUnJTRE9iZyt3QmVuTE5y?=
 =?utf-8?B?R294bHJmaElRenRkd0JNS3Q4M1NUMTErY21FN05PN3RQRGtWTzBDbFBRYklm?=
 =?utf-8?B?V2VrNng4WjNRakxqM0dtWHMxMVhoMWlyZTZNQVdYTzd4MHc3MzFGR3JaczUw?=
 =?utf-8?B?bjZ6bi9oUU5ueTJuRDMzaWRrUXowblJoNHlNK1FSaWxmM1pzekd4VjlWbW5P?=
 =?utf-8?B?aUVvNlkwaUtSOFlTVWFXMlRsLzh3bi9rbHByWjVUVkY1Z3cwc1c3OWhxZmhl?=
 =?utf-8?B?TWtaNzQ0ME9lUGxnSXZwcTgzTnBUZEg0SndST1JpQkpjTEZBSmsyTnIzZ214?=
 =?utf-8?B?YTlzNzBOQlVtNUgrMy8xZWY1RVUzZ1MwMG1oei9uK3lWUjlMVHFNVmdDa1BY?=
 =?utf-8?B?ek1ZNlNQdWxVVFd3UmlpbHVKMW5iM05QUDJIdnJyRWVqbWtqQSszbVVPM2Q5?=
 =?utf-8?B?d2tlSGowM0lUdmRVOW1MbmYrOWxHL1JuTVhIWTBBZkpMOHMzQjBJNDkvcTdj?=
 =?utf-8?B?eTVsTVBZVjhBQ21LSU5FQUVYSnBJYjA5ZXpLdkVhd2xpNm5HMXhKdTBmeWlF?=
 =?utf-8?B?YzlGSExNSmJ2UjgyUnFrUit1azc3RlVHZnBDMDE1SHdsZWpRWGJNWWttL3dq?=
 =?utf-8?B?QmVJZi82T3R2NWZvTGFwY0hpYjlEYmF2dnNJMS9qVVZFVzRVMGVPWkg1YjRV?=
 =?utf-8?B?Z1Q2ZVRTVlBXeVVJRkV6OHMvQkduN3lWZEJQUkw4YmxZcTJUMVJrRlllQjhV?=
 =?utf-8?B?cnh5dEoySVB4bm5oeXBuZ0xUN0I3MXNpWmcyWWhzODNOY2xiRnVFUWZSUTVl?=
 =?utf-8?Q?ATSfPCxzzxeXMkpQ=3D?=
X-Exchange-RoutingPolicyChecked: e9R+OkF3PBriXHmQQNCm7ZLGCxdF8prQuqbByNmykjaBokaUhoyYGRuOXzWyACYdFdstYgua+Q2bkyor1Or6Pi/oPWxSTwMFh8zogqFSA3QK1BfdyIgNei2UL2hWFPd+Cn86r4pFyveOiRPiFg2l5RfhsOM/31mRFrgyHbfocUrVLY4d1sBUsyQjvRHD5CP+TqVfJEOg8j8+kzuznX+S6H53lgg1f+Zz9Zp1VM6BVig3dxjmFzt0dHPaTedIiH4IY/5AhryJQJ9nTkWH+uvyhI7IYcMB2W2wgZS6Y0WSWp0KMG40MMs1+3zMTT7dG2KF/pCEUGlDwXp820ydNqfLZw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4308393-fb3f-46ac-9b8b-08df29f378de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:02:59.2927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RHBt+GOa8Tl6cFGptCPah/OmwUXy5sStUgWsSAMyeqy/je6ZcydZSlodriOIj9mU7foXFPG7bk/6lDIoaCqVNpgEW5IHazT3mWNTsEymZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8990
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX0ytvvr2/isaJ
 7PZvb0eyPzxqAv3Wjt34MzLpp4KX4gr2SgrvgeXdWwPyHTaoeAGhNhlnDnLoLQ3iACvSeFBEeO5
 XDDD4HB+HZ6LtBAAHDGuHYrMrGxDqe2Qwr7X/gbkfUGxiL7RGYGACirIHXuL2KOFVEWDMPA9qsk
 BYQqtHTUgfTfifRTHYgtwjw5rfCnb9lA6CvmbHMTQZ7MKvo5yLTUZoJchCYihI6jACUOZsLOlUv
 +1BFQCRNhwXmWDGfYHqgCz6d+BI3DhToOgjltAWWuxFRDbF8jwxPn8HEayYs1AvN7khmPhNiC0T
 NmyApAcE3PGEeJ9q1scnX2kSfK9A8p28cq+YrcKfc8E3pduukt2jiCnvEDKEJUTFNKyU4KJ8/j3
 UISoSxQ/EsjCPZkYlpG6hfMVbFKLZA==
X-Proofpoint-ORIG-GUID: 6aE_isPI4W8_4juOeydGyVoMAkX5V_KX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX+7TpWsvdhLN7
 WJQoDJZY0vwup4hVoHqjuKICg0DUDX9JzNGMv7UDafNzRN4i76+xrMxUi6wlCmyQbYmUS+TQAna
 e4qO3A+G2RuzE8heaA4dTmUfHWK9u2E=
X-Proofpoint-GUID: 6aE_isPI4W8_4juOeydGyVoMAkX5V_KX
X-Authority-Analysis: v=2.4 cv=OIuyTiaB c=1 sm=1 tr=0 ts=6acf7d86 cx=c_pps
 a=qTO11YbfUBYfkhAk4rXMnw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=ID6ng7r3AAAA:8 a=UXIAUNObAAAA:8 a=64Cc0HZtAAAA:8 a=vTBCZPzhfYM-r4PNrEoA:9
 a=QEXdDO2ut3YA:10 a=AkheI1RvQwOzcTXhi5f4:22 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/10/2026 13:04, Peter Maydell wrote:

> On Wed, 14 Oct 2026 at 12:09, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 13/10/2026 17:17, Peter Maydell wrote:
>>
>>> On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
>>> <mark.caveayland@nutanix.com> wrote:
>>>> +struct I8259PICState {
>>>> +    DeviceState parent_obj;
>>>> +
>>>> +    qemu_irq pic_out_irq;
>>>> +    qemu_irq pass_irqs[ISA_NUM_IRQS];
>>>> +
>>>> +    ISABus *isabus;
>>>> +    IRQState i8259_primary_out_irq;
>>>> +    I8259CommonState i8259[2];
>>>
>>> This allocates only enough space for the common base class's
>>> instance struct, but later we do an object_initialize_child()
>>> of the child class. If the child class's state struct is
>>> ever bigger than the common class, this will break.
>>
>> That's true. In theory this should be something like I8259State, however
>> I didn't think it was worth adding a specific
>> OBJECT_DECLARE_SIMPLE_TYPE() if there were no extra fields. I did
>> quickly check that if this happens, then the assert() in
>> object_initialize() fires so if this did happen then we'd find out
>> really quickly.
> 
> I think that every QOM class ought to define its own instance
> struct, even if it doesn't contain anything beyond the base
> class. This means that when we do need to add a field in future
> we don't have to go around and find the places which currently
> use the parent-class struct but really want the leaf-class
> struct. (There are places where we don't catch mistakes like
> this -- for instance I think if you don't update the
> .instance_size in a type then that doesn't get noticed:
> we've had a bug or too like that).
> 
> We don't write that down in https://urldefense.proofpoint.com/v2/url?u=https-3A__wiki.qemu.org_Documentation_QOMConventions&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=_sMHrUpIgbF65xjh0xd4r-zuudhThxapWCIXp0orT8OH8CbTHKgmaw4SuUcNTpeW&s=9mPS_zIx9x3FD_6cxEpVK-5JyOlynQ3bsBTf44iWLPk&e=
> but we do have some similar rules about class structs that
> boil down to "either you're a leaf class and provide none
> of these things, or else you should provide them all; don't
> have a halfway-house 'we happen to only need X and Y but
> not Z right now' setup".

Yes, that's fine with me. I have done it that way previously, however 
there are some people on-list still advocating for the approach in this 
series.

If we decide that this is our preferred style then I think it's worth 
documenting in somewhere in 
https://qemu.readthedocs.io/en/master/devel/style.html#qemu-object-model-declarations 
so that we can point people (and LLMs) towards it.
>>>>    static const TypeInfo i8259_type_infos[] = {
>>>>        {
>>>>            .name       = TYPE_I8259,
>>>>            .parent     = TYPE_I8259_COMMON,
>>>>            .class_init = i8259_class_init,
>>>>        },
>>>> +    {
>>>> +        .name          = TYPE_I8259_PIC,
>>>> +        .parent        = TYPE_DEVICE,
>>>
>>> Devices that directly inherit from TYPE_DEVICE are awkward,
>>> because they never get reset. Conviently this device doesn't
>>> currently need a reset method, but still, is this a good idea?
>>
>> In this case I think it's correct, because the PIC device in this case
>> is a container for 2 cascaded i8259s which are connected separately to
>> the ISA bus. Therefore each i8259 will have its reset triggered via a
>> reset of the ISA bus.
>>
>> The container itself can't exist on the ISA bus because it would then
>> appear as a separate device which doesn't make sense in this case.
> 
> OK.

ATB,

Mark.


