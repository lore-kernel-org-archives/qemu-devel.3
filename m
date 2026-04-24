Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E71FE51F4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCyW-0007mn-5V; Fri, 24 Apr 2026 05:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wGCyO-0007mR-7F; Fri, 24 Apr 2026 05:37:20 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wGCyM-0004XO-M6; Fri, 24 Apr 2026 05:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEJU+R6nu9vu2zf4grwqNB3kW570/HIOFQiGJ7H5nkyO3yygliYXpdGc4B4cmJ+vEr4RJBJlKP2GHNLBOxry1xK1xUFBkXmQ5MHqcGW2lAbCLnve8FAepYK+qBe/yLKHxw2CiqT+qB6+KlzHfjQz8y7857t7iCRUwUkvIds5FjDU5DBm5XbQpf3Edj8E9eJBiaoL4/hSnAByl/HHL/6E0V+un38kKwyYdgYa8OzYS4K1kOAQ7tAVywX9WEaX8qbvLcAf45Ht0jrEbeb1k29BNHG1IqpnixMXunxNAxdqk9QIdaFflterfPwouRUVSysKmeL3Lq2/rRsiWmQN+cSGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q57+JOqLfLv40Z1DTf1tn91/GyvFrm1QGxULx7pXOKs=;
 b=PIQPiauJNy+ZHkZ4gKE0mh8KygE6tfy894HHi8O0AOHnNScUZ3Pgo1qD2djHvbg6KQn3EDREltycGr0jqjuiSu9a2M+OQm2xxiQZ3Y0jv2Rv2rG2NnL/uq9XO63OYJx/GucrdPN9Lt4FvdrvSVwS2YQWVB8Nij+SydkX3XOzDd406NrWkK5wy3cIOk7wMdOYiwb6bmLP29vn7/MaUHEWAsRC3Fmi/g9ojxZ7v7QTYGQ4zvuD6OeelKvYSRIFnDbJu7cIM38qvI7hn/915edZhDKgYmVmxS8omeS0pKqdcC1hfPxVkYll+cV5TtGJRFqKFbogyiQI9/nIqcO5Cr3wNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q57+JOqLfLv40Z1DTf1tn91/GyvFrm1QGxULx7pXOKs=;
 b=bnHuP+QpdqpF5zofDW1lraFqOHeUyi4VeHYqyODDCWcSn72pOiUHUKYUIJYQFUg9ew5YtqAdfbpuAhmQ5skpLdhjDB9TmMnE8/Uvx0LuW0CD5gXhBlPpO75k7dJRfj44eYY6I3g+Acpvk18JmsX59z0ob7Ax+uyXqHT1iRU+oEF0zECX/jEOMwC+VQHJB+bjwL216bOLN/038VCDbz46ThESQkqbZ28jygRp+MGRgHH+godzbIiN4T4/EP6qWZkJtwbY2YZHJZF5oxLULGUhB/77fD0tQw7heM7NitVaEpVDDNsbMbI1MjwAd/6Yyh/YPvJ0yUwW8kpta5ZKh1gOkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by IA1PR18MB5516.namprd18.prod.outlook.com (2603:10b6:208:451::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Fri, 24 Apr
 2026 09:37:14 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:37:14 +0000
Message-ID: <efd82233-83f9-4871-982c-8cc8dac6f577@axiado.com>
Date: Fri, 24 Apr 2026 17:37:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 alistair@alistair23.me
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
 <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
 <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
 <CAFEAcA8mC4TkicLy9bcS8NYMDNcSUjsataGGmkMpViw4wBvmCA@mail.gmail.com>
 <CAJy5ezqTAMr=A3uAfmuWLepK66AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com>
 <CAJy5ezogVjNxHLFVBp9wd332kwyR8peBHMEjoALg6pYfVk1q8g@mail.gmail.com>
 <cba7059c-9472-45f1-8fb2-06b26036f958@axiado.com>
 <CAFEAcA_jAyW5a2uyF7r=FBsw1dx3CCoVkU3hkxqQzAgxThYJEQ@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA_jAyW5a2uyF7r=FBsw1dx3CCoVkU3hkxqQzAgxThYJEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0041.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::7)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|IA1PR18MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 1400db19-8b89-4c07-ab11-08dea1e510d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: LyWT7YCHXOZrvQqrwRgTY52tIjVP67uzsuDPde+dQe3AChkcFZEeCFs/f7LIYSjkG54KTVqHJc/Aiit693PXLAnq5NAc1FWHAcY3EmnwcO8msdcGPPsvEZeHzgR1Ys3D9atQKRXQdIOzCnRBWSJcUpJv8IHglxQ1baYDgkg3W4xQ0SNJE/4ZGn+JRdpuQL6pD+/qbsr1tnEnQzEsTb7FFX/ale4C3HqL/jEEI6UBFHT3pbpa9hkWb3TYbC7wJqfQtSjoZIU3UDYjvmyvfZVk+0LxqLwxT+xcsC1h+WtP7kGw+KKAro6wPwD4bc5ogamKy+0mwUy0r+KrEQHTknWb7yXa3IgobTv8mQVVLp27gRRj510L6IN20Zt8+UMWTIzAIwCcPIKDTG7/4YOD/DoebcB7b7p2TGZswCDq/p8BnJ1FV59PXDI5XcaixiMqaDbUQqYnvL/mzhHD1rqjbCsq3LW+ASmYCCl5AijUDwyAyphigI8W9n6KEbrNpzyyuSiUR4C+81KzRCszyouXZM10oy4gDdotg922MtAYY5MeIQ4CM8Gn6u+EMUuP/LFXOEGQuqY7RGtqbDXyAf6371oMRUlqA3VIx4p4QXV/qmLFHZmR6PsC2VJ7JIqQ5Cpue4bpISJBWJ82qr0mQrzhvPJHoA8gAl25Uc2dtMtwSA3j8nBMegQgoRdcsMTHvugxonndCDwitd8vWkRQOju9x6yoFbAkqgN1qYpB3E6NUNu2LjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTR0dmU3TlFEVFVxa0I4SGF1Z25OLzBYODlQT3UwV3ZUcVpQb3prK1o1NExS?=
 =?utf-8?B?MWRhTmhrN1VNNTlDVnMreXNqQXVLR1VWdjNTVmlINVVWajAvNGVhdTBEdWJF?=
 =?utf-8?B?a05NV2plRVB0Y3VMcGJZSmQxQ003cTNyLzRNaTNwbCtCWEVZZFF2dW5ES3N3?=
 =?utf-8?B?N01IZngxTlhHSnUxVHJyYXpYMnExc25RMUYxTGh2ai9vVnkxYTJTRE1sSXJB?=
 =?utf-8?B?bDZoZkd0NEFNWHdueUFtZ2U5eHVhVW00bXlQeXNXbXdzMzU4MGZOK0tPNUU5?=
 =?utf-8?B?YWZLd3N4RjRZSml2eXBKeXVYTGdoL3lZYy9WU3VJSk8zaTU2SlBRdzBVRVVz?=
 =?utf-8?B?ZEV1MWVDRGswUE1pcFk4Vy9aakpDb3BzeVQ4TU9IajlvbE9CZjVmQy9RcTN5?=
 =?utf-8?B?a09uZVB1SmQ1bFJJT2lCbDZHeUFkZ0RzY3JLc3N5dzRGZHg4VkZNMFNEbHB4?=
 =?utf-8?B?R0RsYkNJQTNNSHIwS2FOaWQ5L2tHVmRSdW1NeUJJSGJGSmtTaUJFTVdhaEp2?=
 =?utf-8?B?NzROTFN5NnJwREcwWFc0RUovZlJvREpnOGtmSWoyajRqZTY4cUgwQmVMaStZ?=
 =?utf-8?B?b1Nmcmo1dWd6dFNmMDlwcFlsdmFSRFUwcWMyd2pwTmNoRzBpb1ErRWtTVlZs?=
 =?utf-8?B?ZVdRa25aeURmS0tkTmJYTVZxSG45S0w1dEpsNU1ZV095NjN2dDhBWEtLK1Nt?=
 =?utf-8?B?V3czbnhHL0xiN2FySFZlVnBSZGw3bmtCNDNkeWtxVVlFaTJEcXlmRUllc3dl?=
 =?utf-8?B?WkdBUCtTZVVvVGhmaGVWRHZRSFFybmJkYzVrVy9qcmhpbXpNd1Y3cHBWRTJI?=
 =?utf-8?B?ZWtpbUdHOFNPeW80enRNd0Q1U2xrOFMybEZaSTZEbjBJZHMxT1dBZzQvVURu?=
 =?utf-8?B?Rk1ZV1BKZzIrb0xEbkJVWFpTVUhtVUlpN0dHcnM1ZVJ2T21LemZlQlpsMDRN?=
 =?utf-8?B?R1lXMG1hZUwvYnI2T3gzUzZsTUFMVmZVY2tHeWZFa1U3aThDWmw0VkxESkRu?=
 =?utf-8?B?Vk91cjRSbnpMWDUxZGtqRXNja205Z2I1MC84L2NzM1NYQ3pHQW5ZSFc1bWtN?=
 =?utf-8?B?WHFEa0xrNXNzS29wMmlPbDM5Um9XTmFJaGJPY0pDRkpqQTJNbEFnaFJLUklS?=
 =?utf-8?B?djFYTXN1OXJmVkVZZVJnSHdMSk1pVGgydjl4Mk9TWndISW5sdnpKVjRGaHkw?=
 =?utf-8?B?N3M2Y2xzWlBLRFpJbm9tak11UzlHSkFhaU5FTHpEaXRrR1lNdkRMaVoveWZJ?=
 =?utf-8?B?MXY5ZFpyR21UVGd6eE8wcW1UejlEeDN0aWNBeDFpOS9NOGgweWhWa3lmR2Vq?=
 =?utf-8?B?cllrQTVHTkt2U3hJVlllQ2s2L3lFUlE0ZGtYYjZ4WWV3aWJJTFFhUURjYzl1?=
 =?utf-8?B?YXlUT2hWYk9pdFUwdGRVdUFVbmNEV213cjg3MmMwVEpmeFc3RXBKUHZPR2lO?=
 =?utf-8?B?VUpFZTBCZjZJYVk2dDkyNmFOY290RHp1UThFUXZ3MVlGOEt1aC9wSSs0M0Nm?=
 =?utf-8?B?OUg5aTdOdlRNdHVHbWUzd1BFY0c3clVGaTBrOXl3STZmanZNL3JkSHIxOElQ?=
 =?utf-8?B?L0xPRDVIK2dqODRYd3VGQUx6TWNteHJPL3RJRTJPSTdVK0gyUTZ1bUhDMWdI?=
 =?utf-8?B?MGswb2M2disxZ0tOUlUvdzMrOWJxd0lKRkQ4VCtaU1ZkektHNUhSc2NET2p3?=
 =?utf-8?B?dmdqdVo1cjhQczN4dlFyakhzWGdtWWVtRFBlREpGeTg0ci9nVGVZQ2FHSHll?=
 =?utf-8?B?RzJsSDBZUkRwT3NiSzVQQ3lEcjdxNHA2aEpCZm81OGpSYTRJYjF0aS8vL3JE?=
 =?utf-8?B?NmZiejhyMEhHRGdveGdQTW1UdG90L2NWUzRWaVhHWGRHYzRWTkxNMEszL0pJ?=
 =?utf-8?B?RkFnZnprT2ZjZTMxYkRRdms3TEdHbXA2SGw1ankzK0Q4blhOL3pWcmd6QU0r?=
 =?utf-8?B?cmVUclI5ai83akgxclZLL0hmNDlMYWFRSElUTm9VUExCT3E4VmRTNnplTHlS?=
 =?utf-8?B?Z0cwYzVBcVJQc3JkaHFXdkVjT2YvamNrR2xzQWZ2VW16NFZUSEFGMDdkZWNE?=
 =?utf-8?B?TnFjWElXV3pvYUdnYTBrN2UxQml1ODUrQ3UrMFVKaUptYnJIS0NBNnFhQ3pF?=
 =?utf-8?B?WUJ2NE9sMlF5TDhwRWVkRGducDlZSno5d3p4SC9ITytSQnFZRlRHTWhWRjFC?=
 =?utf-8?B?L1c4cSs3Q0s4YVkrdFcwK1dpR29IVVRETWRISEhFdFRlMnBBVXZOZHZmWmZ3?=
 =?utf-8?B?d1llYWNqTUxGeXZENHRZampjTVQxWjI2R0tDbytpYVZxYnRJWVlyVmtkVko5?=
 =?utf-8?B?Mk1rR2U1bUtXVzN5b0xPN1dVRmlNVURaVlRYZjRqUnNkakZRZEhNZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1400db19-8b89-4c07-ab11-08dea1e510d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:37:13.7498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q89maaOC5ghtkzMHjf8HngMW6ggcfHkOuWRiezwLBS/HABfbN18oygC+PDmNyJdRwsQFl063bgLLzKO0dyaJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5516
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=kchiu@axiado.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Edgar

Could you send me more document about the new version of Cadence UART 
device?
I am not familiar with zynqmp so I don't know if anything missing except 
for BXRS register

B.R.

Howard

Peter Maydell 於 2026/4/24 下午 04:16 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Fri, 24 Apr 2026 at 04:08, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> Hi
>>
>> Do I need to take further action on this patch?
> It sounds from what Edgar says that there are multiple
> versions of this hardware device, which suggests that
> we ought to have the device have a "version" property
> or something similar so we can select the right
> behaviour for zynq and zynqmp.
>
> Checking whether there's anything else missing in the
> new version of the device might also be a good idea.
>
> -- PMM

