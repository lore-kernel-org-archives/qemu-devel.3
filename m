Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A14C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXp-0007OK-2R; Fri, 11 Jul 2025 05:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXa-0006qZ-B9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXX-0004wN-Ok
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:38 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7b94H032450;
 Fri, 11 Jul 2025 02:59:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vdm/j/mLZzwlkW/qsiazO+2eDHobpNfTJnbg3e9bS
 MI=; b=yxIialGu2FCyUQTLAcNYYhbLeblWq200+1N6QKquK+UFmMjxImjUtclgO
 9N3eW3U21FS9fFz9lecL9qJdnJjb7RrteVUqgodTUg5vinJ2SGXx8iaApTwcMD+p
 /8A5lF1dN7MN9elTBSWtWwI3AvJYFQNyWPOdqtfqOtvQwrGXo7wGer1u7q6mNTz4
 pru/EVFpH+ndVRbvuFZHNxcbZ7sLRt6bnrrRK57azBDpymK6NafCN6uiW4b9E0Ej
 wrp+PWDypTKx2zEVqzMDq3ADJGPefxO5DmRAjD8h9WGx7OaWBMv67iVmydS0itv0
 l7lEofI4eX1Uo3Z4Qx7CqqJSZXRuQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k38m5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0oE67lYMPvWp3UORCpI3JQ8UCOehPpwHCuaRO5jWKrAl638TTPmGsU1v9Tu8p8tXQhweF4mPnoj3clbO1drVpgjghkeo3QT+OIlsx80LifTeiIuf2txmU2B88iHusxCHz8dWbnp4QPwG/v0nux1zOTE6OfSKnWpNwMyRPGt42KQs6+/cODB32TzvE5I/LCZYQzszJy8wOmV/8IB3HUlGfK4fcKPw0+J9ZOEcA7PCdaTa90kHmF9mlxRGvaWmrdLrn+J5phxOzvFegx2nO8wXB/eGHogiZcPwJ+x7lrPuGdYMHhDe/FDvI69uPGhHGhScZTJfMcxR+VUJ2BAmvgE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdm/j/mLZzwlkW/qsiazO+2eDHobpNfTJnbg3e9bSMI=;
 b=BduR1hLI5UwNuhUxBcuETAaTpB8wqna6kiXPKZvpdFRQ9PNyud/SikmFTnV0LuoE8bm4v4H/laKZIMLWAfAFbyM6WV9PJdvemF67uLE29GICym6pUleW2kmlDNku6WCSMggfgAE+npcX336ofPyR+VN0WnSCqM/Z0r+M7QW1sfmukg8EOJLY6AMlrosIHBkET8cuZ4KhDMfeLW7hGw9luviZEFFFmmBdhJF2OdMs4m96t4Bqz8d/JYbrgq36xs13DLtq74z65akhI3HeroipqbnygZItWjKsxR+YB+1BRRnkt6XRuK5apKJrCZLU51Ri968gtOydjjN8JrTf7vELVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdm/j/mLZzwlkW/qsiazO+2eDHobpNfTJnbg3e9bSMI=;
 b=caQVqzVfbj7Q+7t0pXAv4EuSO35ewcIt/HC4wBpgDeaSoupvyUBg5Uxx8YEAGKi8k9QBhcBxS0gcqG1+xWS6u8WRxUtaIBxnIl+xLqfKIYn+Z83sohjMZTOmPiknybWrwsncihY1M/q6EpgHFKiRZIpjZEyi/0wKN6RIhxx+dB2K5qGGDKljpdZrwv1YzPD0k41bcV8t989cusRdVZdO9meNBvh0sAYN0PiEOcYdXg+lX4KGvJbC5Et7vorGnQXhIuDYbewqBu56+VDPemDNue8h5gS8uqJCWMEG5/FqkypEhAxQxBswNYy+A7Rjq/y7LzrSwMqu/8AJKs1sfpYWeA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:59:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:59:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 19/19] hw/i386/isapc.c: replace rom_memory with
 system_memory
Date: Fri, 11 Jul 2025 10:57:21 +0100
Message-ID: <20250711095812.543857-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4436c679-d04b-49a3-978c-08ddc0619bc2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vGQ2ch9UTBMyXypbujqboW+u20dkAOC1WpgrEsQvUP+3GC7tiFjmKAkRtr6r?=
 =?us-ascii?Q?BzcSfd9QeNdkDTI1ynKBShncf/0uJhXbXORvOiyh/J6UIdUgVl5Kdgsntm/j?=
 =?us-ascii?Q?03S74Ap+iwBTF0kX84YInI9waWPCOTdeY2pHbt3Na38frd63BvVEbK+fdUws?=
 =?us-ascii?Q?3chzUZbuEOq9MpRON1RFDT6WPfgtdgEZYRf3Q5j8DZef/EYGOEBIqmv05ZsK?=
 =?us-ascii?Q?h6OJ86f3Sh6PXyvbwfZP9bYMwwAbxNHwo8+9T3nYf2bmJ0sLPvsAB6mj3I7B?=
 =?us-ascii?Q?VEs6i0EsjYY1PMC0h5qT64at4TH1JFwLyNsGkEwmdJ5twwjtp5NqaiXUjqrD?=
 =?us-ascii?Q?FmMpkyd/bmfVo1RY0huCmVENRolyLXy6CU6lFB2c+VxUgr0cJq0QlbMGGGLV?=
 =?us-ascii?Q?MS2xzMtHv2/i0lMtWbErFuOvxp8SQUjiI7F2GWc+ykL+6ZqRDzmXoE2QKMsX?=
 =?us-ascii?Q?/UL/clG4+tmQbLXLujftWgxcsOoTsHDKG1JJEWP2sfHt7yKsJtmsFumqEOpp?=
 =?us-ascii?Q?vjL5JmV/8J9YqcssPYLaBdOrshBUoMH98J56sh6iflm/8VNdSiryT6B9LWYI?=
 =?us-ascii?Q?syyKcKOP8P1anWPD/mlL1dEcx3jNCY/IxdDVeBHcJCEEisjckPfcwiSX0ds7?=
 =?us-ascii?Q?C29FawiIz3ev8ZgaNcL/77DCl67+feRyOq19LDkbCrTwmxU1MXn8Eh3NU5ik?=
 =?us-ascii?Q?ZppaVtIdd4jNZSXFjJDVR4PxoXx+9U7T+ktLi2Da8JFxeseY1c4kKe9WO/6+?=
 =?us-ascii?Q?Y7aAKzgjDjmZcKWbMaLiJZyynHjXfKbikmIeWIHIKlQg/UaS6mDXiHobUTEL?=
 =?us-ascii?Q?mLdk+1L61JfACbbh//mQVJBb+7C4YU7u/vjXE2kGfwR5/g7h2tiTdAglvzsQ?=
 =?us-ascii?Q?aezoN74bxfwTsWVyNDAXT9ngR6aE/QPIznRNhHm6ZmpaoZIYSSPvJ1XF/hWd?=
 =?us-ascii?Q?DKtpChE02t97TF8fc0kMcXZAmPMBQa3T/Jg034zHhsmlvu5KbU6pDhsldaKc?=
 =?us-ascii?Q?EHlvtTta3AzWeTp1GDsav6Ml520KlyHLNpMte8HwnNEq89mKsNU3zvfWf54w?=
 =?us-ascii?Q?80igZnkp3esbEvfMByfiTNIbrt/9g+wien8y+n1FyxlHlNy4TH1cAaFXZ+yj?=
 =?us-ascii?Q?CRDhS4GZkLpEZZnXrbYN5i9rqPRwKVNpDtW+vXRZHQimgJnmzjkMEYZw8ug/?=
 =?us-ascii?Q?6RoH2IhXomYXTbjE4DX9vEytvpLt93swsmkLJ66YrVm2qaaZSLSUslVg9eNJ?=
 =?us-ascii?Q?U+jqKXGScXFDHl373PLnHQiOmEDStAtM+x3qHIt1662F+IDPf3iEnhASkW1F?=
 =?us-ascii?Q?41RQZ9KNscKZOhNGIDeTkd/+3DLCPX+WnSZSsOb7jMPcla6wA4jke0ZqwVni?=
 =?us-ascii?Q?xREvjxMhK8GlAEAfAKf4xuLDFv++AWn5k3bloDODVbQz/klFCneARtFEn9Dp?=
 =?us-ascii?Q?0JxZ1fmUu7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jWxJvt7cL6AvfOzfFBZb+liuD8wJawkq+yy7uQgEi+cbfeWh/djhBzRY1QS?=
 =?us-ascii?Q?ic/6+dvZ8i0lX4sX3zXD7tHz1AVn7BNCFZ6NqxCcvYs0yYpMcBz0D0yNt4Lg?=
 =?us-ascii?Q?Gp1FUX10Bv8Nlw9lMCUACbYbYztqC044qeLdX2QunWTEcmKPJ9kKBgYRlEM3?=
 =?us-ascii?Q?oIwFKuxPbQdI5HRKIwba9foEDrWOQaD4jD8FCCq3gLgaJ1rnlNTVnFhxynt5?=
 =?us-ascii?Q?3oOTkCsIA7M6rUu0BmEd8T1PvBpShYgEPCR8ok2eU+WBX11muvHxiL8n5ba2?=
 =?us-ascii?Q?cO1lpX48eisKN9Kun8Equ+zD1w7CTMAh0yiAoA5c1mZzlJU6Lgx14durbv4i?=
 =?us-ascii?Q?Aibd71fG78Zv4R+PNL6uEpF+AG5/77j0fjf39wIImuPYnahI+qMjFnr5Pf3+?=
 =?us-ascii?Q?l98NwuANJvR4MsCU8JSRBVXvjC7xL/5LbjFf8VctZWZLxNXEWsGJkL6/Xfx8?=
 =?us-ascii?Q?50zlxdsvho4LuWP7tZfD8fzJX2XYy0FqmW4l+Cy6ZbaqDO5MNvvyAg4v1YSX?=
 =?us-ascii?Q?mUY8+4uk24hG69CTsYrjjUpmOx4Ou5x0a/OcVXYdTJgKmoqIvOnTT05ojZjO?=
 =?us-ascii?Q?C4lyR69atrS0w+bdAMVUYdjfkQsyTZrF+jOHvLAJ0AXKduxxTDilqzEf/FTq?=
 =?us-ascii?Q?xxfYcwYvHxzgzFVivOb/Z3WGwn+3hf/r0dqV5p+0xAwyDW7E/S0Jr2nfhroW?=
 =?us-ascii?Q?a8rKozUht01ICAUcyA/loQhgo8rUQ4e5YfBLNcUEiF+MfDUT7l3QjWKdNJHm?=
 =?us-ascii?Q?9HP8ljJ+KRWnfGMVILUN/8f8xA4WZbHT82TIHkxNw5+Y1ijBvwSLGEACJ4KV?=
 =?us-ascii?Q?vnXt9sTZhLgKBVDM49GHFWegUAFrE/k8+OWNMqyg9pbeA85NJOT8gUALnjZV?=
 =?us-ascii?Q?vXCMVnqbdPa9s006t/W9+zqE+CCz804Zegc+h1Ipf2skj5BMUw6Bl3jG07G+?=
 =?us-ascii?Q?6O3DYQMrhYxPgVYChdGbqZo3tav1UOrkagpJsUgoekXB43A/xaWKSXVC01C1?=
 =?us-ascii?Q?LdMs+S77MsIPBCfUoekRxPGwUZiCr69SLX5qsmCo3r8WbOn6mmJVxLUR/8J2?=
 =?us-ascii?Q?KDkPsEAMliKLedqM9yQS25EktJeCRpQHQCZq8rdZwGDKYfDuYRrh/Sg4N39J?=
 =?us-ascii?Q?3f3JUc+lJobYrQkSXyR8St3SgFmyiMYkacrcbcQ5F/HlA4xdo/OP1MNkkmsd?=
 =?us-ascii?Q?VY5qo1I6GYwIgeC3EIswE/tYlKBg7pS1A/63nNuRMr3TwWR1SfvZxn0fJ5CL?=
 =?us-ascii?Q?+8IRcZKOBg+mlF7TsJ2E2PwNv/ltd9VXhN00DWmGTXbFsGghoCDI0CEdqCp+?=
 =?us-ascii?Q?x8sEsMZGf4qLlaAa89fpz4hiM3VH4+2GRYCi225vP6KU60VNN4ZRxBFeoPJn?=
 =?us-ascii?Q?PjAyYBqlEVALlhF7lQb0v9k7IAePIiACc0YjNBMH4SMb+GYpfn1UC+hOic1C?=
 =?us-ascii?Q?2joMVck+m03GF6oUN938NX5VsBdlYKvNAuVmhiLyjtAkQ2SHUbTdQw7GMU+C?=
 =?us-ascii?Q?lOhsYQ+LWt1d6N3WMjzv6tFPQe+GnwY50or2gcx+bghHIx9rjx0ge9CBTWeZ?=
 =?us-ascii?Q?b86qNi+Yxzu2mbmZYC1yubCAe4yQmVPDPIh5zGf+cHaYgAKbTvsjgiRYyvRd?=
 =?us-ascii?Q?1l42u4oLSq+AlKy7wBICHoZbXwmpLCm2EJAjtGi7LAQad5SHkmwqln5v+va5?=
 =?us-ascii?Q?+t+yVg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4436c679-d04b-49a3-978c-08ddc0619bc2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:59:21.4718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqIBKWcZ+Yw3Wcc+rkOFx9EEHO0ednT2oFL8B+sXZLKzmi5eWC6MGMkf59hQelhuK402bvS+GzK9VEPnR/TP8bOroiMaT6JWu3wGNP1Sick=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6870e07b cx=c_pps
 a=P372saq+MbI0baXGzHkldA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=BKspdhvg69VpFdegezIA:9
X-Proofpoint-ORIG-GUID: H9R5g-iEfpctZyhg-tGsizZUv8Ck3ZbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX5ALKVMs3L8tw
 WC6CdIjXQbSVAPJJNXcC1nhmv96Ece+f28fcyEFogo255rGxJkVWqCxyAoxj3hOBSfhple/d4Q4
 GHaZTN2cTLBRqevIB6c0oGBz3mJWPP1eQqgo2ep1B0iBjBo0rQ+dYZ+I4X/90bg9dXtEsbiFAOT
 5lsl63uNA4fIdzTHoXKLOVvxiVOC8NRJ+8XT4qC52CZlGenyG/5sW6bPvBWj4WSM1jvaTLSuDXx
 Gp/ztyCFK9eLpEUNz+8NmaB+cC6J7ykDiqw4A+kUMnAfHuzB35viG0Fjsbnd3MnP5lTwp/FA6D9
 LkXUv7avMr7UMfaF+s1ykQ2roMIV0Uu51PLA9k1UDhnZ4MfoZGiXW2WISym+aN9dJUSZUsryBow
 LLwEPQNcgnXAbW/yq9VZGSKQ/vOcZoPZWF9LTsYAFMliNxY9+keZ3nkMGqIAeLG7Zj3V+6BX
X-Proofpoint-GUID: H9R5g-iEfpctZyhg-tGsizZUv8Ck3ZbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that we can guarantee the isapc machine will never have a PCI bus, any
instances of rom_memory can be replaced by system_memory and rom_memory
removed completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/isapc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index b24cbf41ea..abf648706e 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -36,7 +36,6 @@ static void pc_init_isa(MachineState *machine)
     ISABus *isa_bus;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     uint32_t irq;
     int i;
@@ -75,7 +74,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
+        pc_memory_init(pcms, system_memory, system_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


