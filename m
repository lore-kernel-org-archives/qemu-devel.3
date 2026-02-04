Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F34E9537D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnae0-0002FF-Q4; Wed, 04 Feb 2026 06:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnadz-0002CW-2M
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:01:59 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnadx-00037t-5n
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:01:58 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145iGg21749218; Wed, 4 Feb 2026 03:01:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Qwc9glEAy2ewN6M3G8aceiUN3TS5tcjVecaEDUA6M
 mE=; b=1T4TNcn9ue6a55iWnIYNEilnKJZt2BBkH28ZWNBjczvw5njaoXoAVchWV
 0zPwWejIOyP5DvSP0C6KhzUr1NKs3ZGs0ZCDYwT16n6a6Fy/Yd8x2gYD7xkbp/tV
 lE411nMN09xP0tBnVWr6zZYRZy6BeL672zfRwIpO+iu+Ete+62jsMJP+RnNib5Ne
 rKqWpcZ48cenQGvUAkC6H0WGJMdJ8f8e4hCYyGCUWLMsFVdxzirDG4ex4VCmyNRw
 o7wywXZVgynLJJSH/nI4X06jLrs6ELUNSYP85mhUMXtH+znl8h/hZOgBTDo08dZL
 DshtDXo/uZ4g9wacoEVTmN0cMwASQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022117.outbound.protection.outlook.com
 [40.107.200.117])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c2ympwa7d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:01:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn8D1BG8ZVI57lHvph69fguNJrtVq3sto+wFeGz+UtLrl7avTQqVTKQuFz1INdMhuDgAXZmKXP5sgGDVZSq484r3BJwnzoNg0AZGle2pxil4xLHvA3vaciZal0D/7q0zkUqm48L8fxlOzpDrwLiaFxCgJOzyxbho7jx8OTssrTfFGP+3Ee+6ShKY9O38NsNT6Fy50UxpQjlbdGlUXY3JvZ6u/Cq5devarl0QzZ9XoTGx2xpcFKt9beVJh98BiLyKBOEsKD9j5eZZvMLZF8poRjDXJcKczIHceYMEZMhHr8Btxgfbz3NZ5bBU0rTf2lB+SlL4LJFZu2qAQOm63U85sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qwc9glEAy2ewN6M3G8aceiUN3TS5tcjVecaEDUA6MmE=;
 b=C9BmhhrzC1g+fmBpaPyZ9eEydZtvuPewQokHKYV3waMPkSbTeV34VLkw5BAmDL1yWnPvifIWGF/8SBgUK2XGEka6JYmovfnY+2CV/JdwyZoplidQHkJRpSHUKSGIQY8FYxKPP6w1IT2vED4kIVVihdhEygqGDpFt4TDEf+wFCvE5tw5BC/PKG0qUUw0tD4oaLdK8Bu4aDYYan5FeT5sauOzYFj0w6/Xat+vU3RDmVOVOEJuPjfru6lnAOOVDvjKnkXab0O2iGc5brruPsp6eJFVENVrIiP/i1Af2IHqWFAzJCMxieLkpbVo8RxhE8u+dzwdHuppTMNytUHIqqQh2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwc9glEAy2ewN6M3G8aceiUN3TS5tcjVecaEDUA6MmE=;
 b=FWfbw/4g640sm0dN11FbI6Ig7ibFs4ARznEJ+JJD85dKYPku08SyTbPHedR/UbTwWwmKUnpEvYljAqSB8CNwXDjC6pGALkk3KBudpK7i0+LtNhfwiFBo8W98APBi3FBWIGNkXYoqoebI1nn2CPFXcMyHfu7+7IiVL+0WPsmoxOYohcjxLlSi5+P+cv4eBNwxn22Th3ksPgvOkM31+IR+XwRNCLxbPc5MU1DveiZkAybkYkSmcGIsYuiolGu7Fx0V2lE5u23ROXnK0Kpeq+p7gFJq4CdaT7Yb4Xoy+PARiBH6wwiba/8pHt2h2UJFX7d9PLHQ/4dLgdKyYurIeA8YhQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB9021.namprd02.prod.outlook.com (2603:10b6:8:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:01:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:01:46 +0000
Message-ID: <864e542e-b969-41d9-b211-eaf892fc57ee@nutanix.com>
Date: Wed, 4 Feb 2026 11:01:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/37] audio: simplify audio_init()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-20-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d22308a-4235-450d-1aca-08de63dcc9f4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0szcFNKN0NCWngzMUdNOWluSzJOczZRSzZpWXM1QUJ6TTBDMTBuSndXdEsy?=
 =?utf-8?B?aVVrb0ZZb1N6eXZ4UTJlQ3RHOVJJR0lOcE5IYWwyaTQ1dDdkcUxjNFlJQUcy?=
 =?utf-8?B?VElmRnhVODZXYnZCMS9BRnVxWFhsd0N1dEhQd3FzU2U5V01JRTlrZm1KMHZL?=
 =?utf-8?B?WVI2bnBqNDg2TWgwcXhVVi9oRGliVGVVZFFGakZJVk51NkxFSGprRzFDTmJ2?=
 =?utf-8?B?cDB1cS9pZEVXOGxPYXhWWTFJeDhXeXBJNTYvc2dVQUZJUEhBLzVrVjNVRTR5?=
 =?utf-8?B?ZnArdWprblpNWHYyWGVzbndSQWFkaUpoNWlTbGx0NitiSHpWc3l4N2E2UXAv?=
 =?utf-8?B?MG9RdjlneUZVMm9kamF6V2lFZTB6R3BsTTJxbFZMRzVybkJEVWpUZ1lHaHNJ?=
 =?utf-8?B?dGJ4eGZMclp4N0d5QzFYQ1RsWXNiaWdTZE05WGsvZ3VHMllFTXJJQ05mcUgw?=
 =?utf-8?B?VFIzc1pnQVhiMUVjR3RQQS9NUlI5bGVrazc4Q3p5aFh0TXhEWGhLU3hIa2h6?=
 =?utf-8?B?Y3dxbWgzSzQwUVp4eFVkZjVVMHRSdXI5Q0E5czVLTDdDdm5JZzY2YjBHeVFy?=
 =?utf-8?B?eDl4VC9lbE9oOTdReGFHMkVrWHpadTVScU9IdW1Ua0tJSDNtSmhGeFhvZ3RI?=
 =?utf-8?B?aDBtNlJWTm51RmRQY091SlA4Sy9DSVBkbXJNZEhXNi9FTWV3c1IzbnNSUUw0?=
 =?utf-8?B?aVdMNFA0T0hXejJBYThkYkNzSWt5Um5rYjBnREdjRndYbm5UWWZXckpZVlEy?=
 =?utf-8?B?V1pqcjZDL3FGTFM4TlpOWmc1RVhINmZUdDRBUXBjbXA3SmkzK3BTQ2ZBK2Nr?=
 =?utf-8?B?TmkzVE84ZUJvdThWeGZKZkRxUlB2bU1CMmZoNU95bW90c1hwYWNEUXIzRTRs?=
 =?utf-8?B?T01lK1AxNzJZUGhvVEtrN3d3SWIzV2JqR1NoRDA3ZU9iVlVtMXR0TzRrUFlr?=
 =?utf-8?B?L2pxbTZ5V2dEY1RVbkNVUURtbjRxdmk4a0xXU1hYTjZ6TzZEcmI5QS84T0U2?=
 =?utf-8?B?OEFJcVVZalYyWlVxcGJiUmpYODhqTkZrY1lIeXVmcGU3MDk1TjVWT3V4NVRn?=
 =?utf-8?B?S1lVVTU4SHlaeUd2M3BsSFhWendXNVBJeFVud1FyazRXS3FGeTYweU1nMll1?=
 =?utf-8?B?aGxMekpqNlp6bUZkS1dpaG5xZVRHTFpMcFJCYXEzSjA0OHMwUll2R2ZlSlU5?=
 =?utf-8?B?cXlyZ1JvTGhmT1FTN0dEbWhBTEhNbm8xd2htU0orb3U2NENEQnNXamYzcEpU?=
 =?utf-8?B?OTJZdEl6L0VxdzlNaGgvT2k0bDZ2aUJnbWo0UWpBVDFvQlhERjhoUDA5Y3Uw?=
 =?utf-8?B?c0VtYmxvb1FKajBQVFVydng5cnJmUkFqYmdsN2wrTHF6RlphZjRUR0pXSGVB?=
 =?utf-8?B?QVdZTzU3VTdNc1JsdkQvQ3ZaN202VVNtRG1Za1VScUdEZkZvL3dkY0JidWhx?=
 =?utf-8?B?ampDcFVhTHhmZ3NGOVU3U0gwbThwSDNXVEc2T3ZxOVd3OXZaWk5wUURHcERL?=
 =?utf-8?B?WmFlVzlyc2RyRVVSaFlmWmd2WHdjaUZnSzhrSmJjOGFWd0Y2WGE0M3ZjVHky?=
 =?utf-8?B?TFhlUGYxK3ZBTmp5bk4zUVJVUDNYNlB5V09UQk9KMjZLbnBlYWsweWxOUlBX?=
 =?utf-8?B?Ym5LUFJFUTZGclJRcWhuOGxDd251bzBRQ21yMWRtbFNxMjhmU0NGSTFRQS80?=
 =?utf-8?B?empiWUVPY3hNUlFlVEN2N3pmR3M2bnlaNU9rOU9QS2dZckFGYmhhL2J5dE1o?=
 =?utf-8?B?M20xUnNsMUxpMWx6MHBIazllS0kvSlJwVXhzTi94cGxzeVRrMmlTSzRTTzA0?=
 =?utf-8?B?YzJsQWFrbHBYM1RHVGl2L0xxTURCeXRRZ1l4dEZpZktRL2FoRjFnMDVPeGJZ?=
 =?utf-8?B?QzRIOEJhV29TRDE3TWRobzM1dWZmZXhMOGlTcUJXUnU0djAyb1Q0VG5OQ1Az?=
 =?utf-8?B?YUtydFRxekV5K0kzM21SOXIrNVliMUlkWU1aNDZHcUk1UkVSMjZiSlpYOW9Q?=
 =?utf-8?B?UUlKamo1bExjdmtQWEpoOXREMkZQMmVDTTdJMkZ0eXpheGNHb202RmszNkZn?=
 =?utf-8?B?Sm00REJ6UXR6RGRpVVloVUIyYXVUYm4yZUlqdDRHZE9nRlRSNHJqTmlyVTBV?=
 =?utf-8?Q?/LoM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBFTDd1R3ZSSzBJVXN0T3UydW5DdWJRTzVaR0xnUmk4MUdLdFpTclhMaVlL?=
 =?utf-8?B?dFUwVGIyRTBRYkFJdmZLdTJiNC9sYUUvYzRWNjZxeU53dmdZWmZ0akp1U3Qz?=
 =?utf-8?B?TlJBUjI4R0RwS1BFdzZpNENYdDR4MlpnOTNzZGhPaXk2T3puWGhQTUxKdk1l?=
 =?utf-8?B?SnYzdjhlSWpTcFNXRG1GNCt3MWpVeDlwWUZwK1ZjU3dzeURhSUwwZlFmclJ4?=
 =?utf-8?B?ZWdhL0VIUXFIRm9aNXBmRVdsaXBXclFhZzJNUU9RaFRUT29YSDhaelJFREx5?=
 =?utf-8?B?Q28xRGJuZGpUa2JwTXMzWFU2QVZlVGxXZGZKVkhsZ2RSaXEyQlhjUFRKcVZH?=
 =?utf-8?B?cVdYd2E4RnkydHgxS25GbFlPVkJUaGo2S0dlRldjdDMyVDhiVWlvQUF5QmVR?=
 =?utf-8?B?ZFVBdkJ3WmxTcGNGWUtxeEYvOTI4MlBDb2RkRENjMmpOL0xKQWc4blVPVERu?=
 =?utf-8?B?S256ZHEyME5hRkRseVJBbGVZYXFENWUvRm1WNmZZS3NpZHVJU282MlliNTNQ?=
 =?utf-8?B?ZG4yNWMrM2hTdW5VcDdqNGlhTkUzZ0ZadVBTVG5pb0V0bzFBVHZJK0EvNUhB?=
 =?utf-8?B?V2xTTEFjSmt4aFlvSEtnV0drWU9Dd1JJd2ZidHlZOE4rMit5SU82YWtsWmVU?=
 =?utf-8?B?RDBUSzZyNTRkaEdtd1FaK1doYVE1d1hNdWZsdUJXWi82eGpnRlEvM1lpOTdi?=
 =?utf-8?B?TmtZK1I0QWRBMThYUis4UWxEaHFiRFgyby84UTlHaTVrNVlaQmVubitmQVRZ?=
 =?utf-8?B?MlNGbEJKUlY2T3NlSXFyTmVpUmZFVlJWSzJPWlpVVUtSTzlmN0JIM01WYms5?=
 =?utf-8?B?VUhPREFQcFIyZHpaaVYwNE0rbVlab01saERwSGl5K0FKUWlSUWozcnBuTGdh?=
 =?utf-8?B?ZENJa3QvSjRtRjB6U2I3RG1nQ3RRemdGUHRzRXlCSmxUNWsrRXFKT1hjTk1t?=
 =?utf-8?B?QWpHQkgvVGNZSy9aN1FUTzI0cHFMVGJPZkFvZzBIeDNQTWxXLysxSWdtVXZF?=
 =?utf-8?B?OFZtZ0oyY2h4RHo0aERlamxia3czOHlRbG9UaFk1ajlZOUVwSS9IdUlnY1NI?=
 =?utf-8?B?R25manBsTDA0dmdjTThLUVh3RUZOaitmS0R6VnlGYTNkUFZ4SmhjMGVzbi9E?=
 =?utf-8?B?N1lsTUVqK1QzNUwzR08yVFVxdEk1NVlLN0QrOUsvSEhsdkxoMHRjSGxMdkFK?=
 =?utf-8?B?aVFHdVhjck5rcUxyZ212Y29PY3J5dUxzTnkvVG8ycVFWalZacnA2YmZIVlJv?=
 =?utf-8?B?Nzk0UklTT0NHUndSR1pQa3BqbjVkQngxODk2d01SZE9SSmZzd3V6WWo1dHBq?=
 =?utf-8?B?L3ZYMnBLdnp2L1RFNldTeXZxYlAzMmhYU3NvUDVzVUhiMTNmUjdYc1hERHdR?=
 =?utf-8?B?cGZVZTAvV0N6djc4SXd5L0diY1NNTE5OMVlKVWRJaTNTc3RMRUNuVHhJd3lE?=
 =?utf-8?B?dnI5RXc1amN5WGdVSHozTGtXUnQ1R2YvQ1cxYytpbTY1dW5udU1JaW9uVEFU?=
 =?utf-8?B?K3ppN0ZlcktONEYxd0lqNjR2MmJSdVB4ZXNhQy9zMXhsbC9xQzhHcVVyZjhr?=
 =?utf-8?B?YVp3bGtsbGRWNFk4MTlveXg4QjBpQldMMlNwcXBKbS9MTTQyZEk5N1JmR3RC?=
 =?utf-8?B?bUw5Q1JpNVdqZUlHRG1LdjJOcFVSd01ndU01eEFLc3hnYWpFeFhDdFNTYUFY?=
 =?utf-8?B?TWJBbER2TDF6NVFzVWJnZHpFUVppZkRCL0JPTHRGVzI0U1RlaWhHSXp4YWlR?=
 =?utf-8?B?cGprWndMM2dmWnR0NHZKSURmMmNzSlQ5WlFCcHU0dHlUMlpoTU5xQTN1Qmhl?=
 =?utf-8?B?ZURGSU5ibG9XekZzVmh5S3VQb3pQS2lWYXhlOTRzV3FFNjhKOUhVcFo3aHBm?=
 =?utf-8?B?Y2pWaHBCMkduQzc0SVg1RENobHR4eDdmQVhTUEVDT3h4R0RqcUNoL1VCMnlR?=
 =?utf-8?B?NHhMTUhTdkNnN0pKUmdSR1hQd2R2MGl2WTFEaE5QdlZCV3lvYWgwb1ZEMm1C?=
 =?utf-8?B?eUY4SG5DQkxCTmY0c1NRL2FvZktOdzBxb1J0K1NXR25jd3huaWpHVG44Tktm?=
 =?utf-8?B?VXc3dGUwQjFnM1NnT2JBcVloS21hdlliQU5KdXB5OFVjRHNndXZnTVcwWFd0?=
 =?utf-8?B?bGZxTTNLWlpxN0RtUENKR0x2Zy96RVBSZnRjcXB2b3dSTkZHT0h5L1dWN202?=
 =?utf-8?B?VTlZeVdUT2FqSWpMUUErV1B5TE5OU21XNjZTSzlhMjJROENBZkhyQktEOStx?=
 =?utf-8?B?UVlMV25QaXE2RE93ZWtlUzZESzdoRmRmQWs4bjE5cXJneUh4VGEzdERxRm1a?=
 =?utf-8?B?OXk1Um9VRmVtK0pBTjltc014M09HYUJTRFd6bHBoL0M0L0pMR0Nvd0RqeTN2?=
 =?utf-8?Q?2c+mBl4cobWWuvtU=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d22308a-4235-450d-1aca-08de63dcc9f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:01:46.7282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6ejlld3XTnWmg+miyFQsAH5t3GGIVTuQ6trmLqmYBkiEoJwalD1GUwVQHgiC5/RwP+Muig4jDrYqEoChSGlREmfAsVTAvcPiY3SzQRC/WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9021
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4MyBTYWx0ZWRfX/HAljM4XENhS
 ROF9UJa3BCRl8UkxtAyeIFC5r1hUIxJ1n32jT34YX0ZoOJ0HZNCx6nJMmVwtBq8PtJO7qVH1YTz
 KP3dVS++zIv+p3dN0yWG3V168OgBvdDndEspLIKbCJSlA/on6kwRJ3RatVB416Ne090HudwZLK2
 +7OUT0LLmLMCa4hQuMsadH+IhNRX9PeArR7bY2/u8hcxa9o3zzUzZPgic+lgn7T4do3Bp06E6XM
 UTc6Q2NfUHLjNpYjokwy/TNvtuef/q5scZDpxoz/F8Knw6ZzN7RPJ/LH5HE0mUqmz2j7Mu/gACt
 MxJYQ6u3hRi5jZcdbfefjdSpDrq7JzFC7+REvGPa2WU8ncDRwoLfqxFpZXyLZGKqM9s69m6r8r0
 z8UbfP1r6JP9gS0szAH50UZtDWszutWaNoCicRQH7SizN980tfe6ZRohMG/0BJPdCvs6BGaslQ+
 1MjsWYO0kaH4IhiLYKw==
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=6983271d cx=c_pps
 a=P+x04lzWRrkL6x5keHLAXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=z8fgyJHpsrFjsAOaPFcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SB2LF4oftr5G3r7EM0HS-6_siFMG05y5
X-Proofpoint-ORIG-GUID: SB2LF4oftr5G3r7EM0HS-6_siFMG05y5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Factorize looking up the driver in audio_driver_init()
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c | 66 ++++++++++++++++++++++-----------------------------
>   1 file changed, 29 insertions(+), 37 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 1c83dd4ce6d..2a067075b0c 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1561,11 +1561,18 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
>       return total;
>   }
>   
> -static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_driver *drv,
> -                                 Audiodev *dev, Error **errp)
> +static bool audio_driver_do_init(AudioMixengBackend *d, Error **errp)
>   {
> -    s->drv_opaque = drv->init(dev, errp);
> -    if (!s->drv_opaque) {
> +    const char *drvname = AudiodevDriver_str(d->dev->driver);
> +    struct audio_driver *drv = audio_driver_lookup(drvname);
> +
> +    if (!drv) {
> +        error_setg(errp, "Unknown audio driver `%s'", drvname);
> +        return false;
> +    }
> +
> +    d->drv_opaque = drv->init(d->dev, errp);
> +    if (!d->drv_opaque) {
>           return false;
>       }
>   
> @@ -1578,14 +1585,14 @@ static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_driver *drv
>           drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
>       }
>   
> -    audio_init_nb_voices_out(s, drv, 1);
> -    audio_init_nb_voices_in(s, drv, 0);
> -    s->drv = drv;
> +    audio_init_nb_voices_out(d, drv, 1);
> +    audio_init_nb_voices_in(d, drv, 0);
> +    d->drv = drv;
>   
> -    if (dev->timer_period <= 0) {
> -        s->period_ticks = 1;
> +    if (d->dev->timer_period <= 0) {
> +        d->period_ticks = 1;
>       } else {
> -        s->period_ticks = dev->timer_period * (int64_t)SCALE_US;
> +        d->period_ticks = d->dev->timer_period * (int64_t)SCALE_US;
>       }
>   
>       return true;
> @@ -1785,24 +1792,12 @@ void audio_create_default_audiodevs(void)
>    */
>   static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>   {
> -    int done = 0;
> -    const char *drvname;
> -    AudioMixengBackend *s;
> -    struct audio_driver *driver;
> +    AudioMixengBackend *d;
>   
> -    s = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
> -
> -    if (dev) {
> -        /* -audiodev option */
> -        s->dev = dev;
> -        drvname = AudiodevDriver_str(dev->driver);
> -        driver = audio_driver_lookup(drvname);
> -        if (driver) {
> -            done = audio_driver_do_init(s, driver, dev, errp);
> -        } else {
> -            error_setg(errp, "Unknown audio driver `%s'", drvname);
> -        }
> -        if (!done) {
> +    d = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
> +    d->dev = dev;
> +    if (d->dev) {
> +        if (!audio_driver_do_init(d, errp)) {
>               goto out;
>           }
>       } else {
> @@ -1813,27 +1808,24 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>                   error_setg(errp, "no default audio driver available");
>                   goto out;
>               }
> -            s->dev = dev = e->dev;
> +            d->dev = e->dev;
>               QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
>               g_free(e);
> -            drvname = AudiodevDriver_str(dev->driver);
> -            driver = audio_driver_lookup(drvname);
> -            if (audio_driver_do_init(s, driver, dev, NULL)) {
> +            if (audio_driver_do_init(d, NULL)) {
>                   break;
>               }
> -            qapi_free_Audiodev(dev);
> -            s->dev = NULL;
>           }
>       }
>   
> -    if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {
> +    if (!object_property_try_add_child(get_audiodevs_root(),
> +                                       d->dev->id, OBJECT(d), errp)) {
>           goto out;
>       }
> -    object_unref(s);
> -    return AUDIO_BACKEND(s);
> +    object_unref(d);
> +    return AUDIO_BACKEND(d);
>   
>   out:
> -    object_unref(s);
> +    object_unref(d);
>       return NULL;
>   }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


