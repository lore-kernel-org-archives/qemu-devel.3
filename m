Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE55CA1016
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttxX-0003WV-GU; Wed, 03 Sep 2025 16:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxT-0003VD-QW
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxJ-0005F2-Rk
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:50 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 583HHfa93727350; Wed, 3 Sep 2025 13:19:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=UslbHmlroWY7v
 CI2+rFp4UtAk0vvv4IYWmmuqhe+uVY=; b=yw9KjEUyWGWzSg6dl90CIwYPGEytL
 5Eh7zKxllr4jMebfHLEayERTXwPszPS/69MI9Rk2SYGrOCMOTb9BqoVeCUAbBVvy
 BPnoEzyIKeulltuY9pn1urC8f28Xbz77bP39h84T1qAY811583TOPMOehwu8d1zJ
 wG8b5Db4ortkADXIVcz+KPiP2RbbWdKef9Fbrz5DuZAcL3QPlZS1kkiqrVuOzS9z
 /rvuSj18fttjmqvNkU627rNJV+cDvLaLYnYb0DRgb6AkhVnFKI3KAbiyFrTMtnts
 0OMAdG3R28WRhjwB5QgaOW2qqdTfsAXsP5cHzy55woNPY+akhAS7TVHow==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2138.outbound.protection.outlook.com [40.107.237.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48xmw4s6ad-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 13:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWR6ttLEg+EFjzJOl25ItOYJdbQIm/TUwXPPdjCHyv/+ovZjeSDe1jEaKMv/Otb4wwDoU/NshirFtiim/nfu7BefQACikapf9nbz11tkvrRi8TR3pi5tAMGDdXxNLA+EeoHTHS47ipxznIqXqUc86+KQzCQGO3SysVzrT+ab96lDvvJesPTmAxzp11/1nCNN7TnhM628ApTw5putWXtZbp0ET0q/gSrBUjGQ8vF6/ToKIlFUNgFUddwFjQuGlLdLpX73m1Hi89etLHRI8P02XoAYLA/8h3ABhIuyEx/Ytq5AJUwqQjExlCG7EjzVU0TnQ/F3XMqcal33gYzqb2nmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UslbHmlroWY7vCI2+rFp4UtAk0vvv4IYWmmuqhe+uVY=;
 b=yjASaJ9oPOSQhY7WXTffRVuSgI8Ao9XUCEsXj6gaC+p8N6Ta6nfkONQ/F8QrCUTjfY7QcWe1qtzv1Em5ELxk2En6rfDm8xI24Hr8IHuTcoH4La+b5ExpurQ5+xldlKA5+g4rCqXirzsY7srYTOiq45QmavzC2RJ6GvjKQCzAf1WcsgL+TtCcu2TKAViOrvUH/CtXg9/5TQXigRx41MI7rg8GxNUWrtyjpcsGo9JcQtpqdgbQb7LCah0I40Tz2aYfBEAQddN2fx9bdJCS609RYUIQwsrDke+rjMq8Asi5mtd17HQxrdtqUibIiTWpJPuNdRoo+F/9MT6aKAjt8sofxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UslbHmlroWY7vCI2+rFp4UtAk0vvv4IYWmmuqhe+uVY=;
 b=WaA+bXAeO4AS5LDpMnxxCsbsx9ps6GWYGLYlgtGI6KNWespetlEOzSV5ErLnyCUsEOFkZsLykHneHYD92epHy5JDakfloMtqAUGVqzvbTtMHLQKs9mvxl0u6eb7Iz8rfTcsIEFNJuCqH5NTYIa3l2JclGQq+mjOdouszq5g/yRCxz+wcHZDwlysCuww+V95p13KWhcdwatrchReLL7VW9Vjy8CgN5tduf+lOU76lU6/qHgwQkNPj6Ea1tw+YjPdHMt6WJXI/vehNeX8NTJ8Fmn2rBUHfjbb48AbJyqJRXB2YLHq15LyoBGVVDn8WxOwSvoHVfw3gVLW3bD0XsUKuvA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH0PR02MB8133.namprd02.prod.outlook.com (2603:10b6:610:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 20:19:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 20:19:36 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 0/3] vfio-user client functional test
Date: Wed,  3 Sep 2025 22:19:28 +0200
Message-ID: <20250903201931.168317-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH0PR02MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 932c9e59-f40c-4e7c-069f-08ddeb27339f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czNyUHRWWGwyQWk4WUZZeGcvWm1VRTZNNXg3eHNuN3lhWDFQNVgrckZLZkxw?=
 =?utf-8?B?K2tOaVRJaEdMN2ZWTHNPeDNDV3VUcjduTFdJY3dyRy95enBBZXIyT0NHTG5C?=
 =?utf-8?B?WFZBTjE3d0VjaW53MnVwczBDWGp5VGVJTGVoSHpNOUJualJPQ0dadmQzTWxT?=
 =?utf-8?B?ckRBeW9zUld0a3NZM0daQkJKNTJLbDBXcTViUmpjVUZGQnFZSjc0WlNDK09L?=
 =?utf-8?B?MEN2NmlzalI0TzRIWWdzeXliMVJzbmlsRnNUa2kvVlZ1NnVXK2xDMmFnL29Q?=
 =?utf-8?B?bTV4OTdjVHdrdHVmNG1NNEFSZFZlMzFxbU5NRUxQRG1ia1Arei9yQndFcmln?=
 =?utf-8?B?RHRiYnl4YVlhNGwzdHJZYlpqM0dZRm8ySXBLU1pkSTBhTDRwSlVndmo1SVZ6?=
 =?utf-8?B?MlFZWFJDa2NRQjlnb2xKdDNIRFpYZDV6dlVGd1YzZEJUY1RSZm5CKytXazVZ?=
 =?utf-8?B?MjdQT25RKzFRV1hQcUhwekpacUxsVEFKM0JrQkljc0RmdFpHUE5OVDBJMGZV?=
 =?utf-8?B?b2FvQkRGbU9DQnRPb3YzZzIzakh6RkcveitvYVJYUTV5YWpOYkM1KzFXdXBx?=
 =?utf-8?B?RkswaDcra1RHeEg2ZE1FL1NldjFQL2Eva3JFTjh0MlFFTXliZkgySFEwd2s5?=
 =?utf-8?B?QVVjLzFZOU1meGoxVkRZTExzS1I4a01lbkJRQmNLWERmaXM1Z1A2U0JINWNy?=
 =?utf-8?B?b1BYNXl5S0RBejRQUGNZRS9ySmpYU0dTSkphdUd1OWhBMUE0WFF6Q3FxcXp4?=
 =?utf-8?B?NjFDUkExUXNHR0dINDNsd1RUeXR1SXZDY012cDRuZjJUMUxsdC8xVkxTODZD?=
 =?utf-8?B?RVJFd3FmYm9ZZnlTM0NYSXYzVk1YL2wydmlyY1l1Y1JVeVhJYjgyRkJYbWFD?=
 =?utf-8?B?UXNxNGlkaHh5OUl0WGZjWXJUL25aekF6bjR0WEFubXpzemFlNUREMVBwTEhU?=
 =?utf-8?B?M2gxSzVKYStwY2NqZVNsYW45c3NYM0lsaTNBeWZwQlNuMzNDUnlldzcwcW9r?=
 =?utf-8?B?eXFWdHhmcS91MWN1UXlqNTJuU2czTExIUzNrbUg5dzljclRaUDJKKzkzMEln?=
 =?utf-8?B?by9MQi9VZU8ySUpSeEpnbFdkMUl6RUNBU1hKa2J0MDNtcm85cDB4STdXMmE1?=
 =?utf-8?B?VDl4SUlnZ1laemJjME5SeSsraUduZ250TlR6bW5xejBPTDh5TmFHZDRmVTBE?=
 =?utf-8?B?OENzYWRzYTJOQkkzQzhHQmpCUEtPT3V4UXdxMW5mVHowS2FiYThON2pDd3hm?=
 =?utf-8?B?ekw4eE1rWDdHcGUyQk40em9tbEJHOU9LdjhUMGhvLzVzZFRjWVpvdE1sZUF0?=
 =?utf-8?B?bHVLVC84OVRqaXB6S0dDU0g0SS93YU9WV2NTRmYzRjhLTjZRMjZLem1nQ2Fo?=
 =?utf-8?B?YnNUTlMrTytuZ25QNHhiVnBWSTRkRk56anNaRUl4NmhTbmZJbWRtR3I1QXV3?=
 =?utf-8?B?VnZqRXNtT2YrS3p3aFEvenlDOEI3M3JvTnhBV3hjZTl4Rlc5OXU5UVk4ZDNr?=
 =?utf-8?B?a01aUjFreGI1NFRIdVJRSW94OGVyNmdlcW1kNUk4Rlo3K1RWbVlqOE9TY1R2?=
 =?utf-8?B?ZElOM0VWNUtXSFFLdkxlMWhlR1VKSnpzVUd4Q1NPemY0dS90T0hOdW8rbHBP?=
 =?utf-8?B?NlFpdE41L0pJM01mV3ZYYVNIUWtYRnUxRSttYUhwcW1HL1M4MnpHZlJMb3lH?=
 =?utf-8?B?b2hOWjhLak5WSktmUWlMcG9oSWw3NHZEdDhtUzNaa0orbjBWRVVxNWg2cTJw?=
 =?utf-8?B?Z1NFdDBOQVRLTFlsYmVBZkpHVFUwZDJOZ2M3ZHpmVi93K1RzR21ML0ttUEhT?=
 =?utf-8?B?Y01jTFhSNVQyaDhueU0zRVlCMHk0cng2dnVwTFA4YWQzTkZXdE1ySFhMaTJL?=
 =?utf-8?B?TXFlMzhjTEtnN2dLMDhqdDhiYWwraEtnV0lsd1ZONG8xS2dVT2Z1Z0JRMHh5?=
 =?utf-8?Q?BvTuaiZZS/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2IyaS9GWXEvbFY0TFlLYWo2cExDME9VcUNHb08xcDVHTXQ1bVdjUW9ySmho?=
 =?utf-8?B?L1g4OFYvNFZ6L2ptYnV2T0llUyt5b29wVTRBTThDcFlZbnNsaVJzbGlFZjlU?=
 =?utf-8?B?M3Y2cWREWFMybG5UQkNDdXZOaUNNdkJndHl3N3U3bmF1WUpVdk91MGxGS0xi?=
 =?utf-8?B?UzFVbkVsYXNCTTdrK2FobFlFZ0dDK25INmhhckY3aFpxTXk3bVdaenduUmxq?=
 =?utf-8?B?aEtvNUljanl4WGpxSlRkUk1NWmVjSlJzTndTNlhHU2F5OUVHUTJuQkg4RWl4?=
 =?utf-8?B?elQzV3Q4bWtXQktGZFZIZEFOVVFaVVpkc29KTkMwN1BOUDgxTVZVd2ZxU2dD?=
 =?utf-8?B?Tko5UW9TNCtZNkRMRTUwbmQ4bEFQMVloem8zaXRVVGx5TjMxRzlGejN0aXBK?=
 =?utf-8?B?OXhtQUQvOUV1OWlkYlIydldTd3B1K1hSK0o5NTMzUnJKNS9DdDY5QjkrbEls?=
 =?utf-8?B?N1c4ZVhNUVRWTk16NmlOWFIxcTBYc3RFRm41KzV2d3h2dlFXSEJsTlRXYisx?=
 =?utf-8?B?czAyRWcvRlNvR3VpRThrTE5FZTEvbTIxODNSRDdpSFY1dllhTnZnM2xjZWU2?=
 =?utf-8?B?TFFoUVE4aW5xZ3Q3UkZ5ZjhVSmtTVmNIVkNNYW80YW1hT2R0c2VlbTJMcHJO?=
 =?utf-8?B?dnl3dHJWOGVMUTY1Nk1QOFRxTDRNSk9Dbk9ibFc2SjhzSkhrdm5PUjAzNEZ3?=
 =?utf-8?B?TTdBbGovOSsyRldoOHZMWm9ER1FmNWF0MHhreHVQVlBBZnAzcjdFR2dqUlJu?=
 =?utf-8?B?eVdDeXdrOVJWQkVWbThtTm1YdUpUWS9LZFJ0WFdJK1J6YTNYM08wRkNMS3N1?=
 =?utf-8?B?dmFwb0ErRGJSOVU1czAyTFBQZkZXQlFXTWY5Rjd6TWVmNnBqcDRVSFJ2dytH?=
 =?utf-8?B?Qmp1bHVBUHQ5TzRxQ1FjREdoVFdHWDlnUjNQRlB2eFBmMGRIZHZVVC9uSC9I?=
 =?utf-8?B?MU5jWkRDRTI0TVhPa0FEZEZRSm9sTlJXZTZaOWJ3emJ3OTBQVERwZUhXZlBR?=
 =?utf-8?B?eDc3SGlWT043WlAya1hRMWlITW1nUko3OG40cHNZK3NQYkVQRkJOQU9uN1FT?=
 =?utf-8?B?MjZjWTJWdGZEaFRHT1J2SXN3czl3dE82WlAvdDdTZ3l4SnBYckgzcG1IYXl2?=
 =?utf-8?B?ODhqcW43VDdiSG1mQlpnWGxKRi9nWkFUQzdZZ1c5S2huOGxsTzdsQUp5M0to?=
 =?utf-8?B?QlhkSjVEbDk5OUl1a3pvQ0lFS1hVdFJlcmg2c1licEJSaHI2eE5xaklSOUpy?=
 =?utf-8?B?MFRQU3dxeXcrWGFkWHhKRE55MmRVVmdCa3Q2cUJ2Q1hyZGZkNUdTVDZNM0dh?=
 =?utf-8?B?SCtPL3lwNXAyQm5JM0hJdCtJT2lYTDNQbHVMTzhlejI5eU5seFFnMmI1VHBG?=
 =?utf-8?B?WDJ1cXU1bSt5TXVob1RXMEU3QjNJOGJGQXdQU1ZsdVZOSUZRZ3BKWGlTaFlX?=
 =?utf-8?B?MHF1MVladUxld0EvZW5ldzBCNit5TFVMaFVPOFhtYmp0ZDVub1dHeFdhMUNz?=
 =?utf-8?B?MVlQNldCV3RrRmx2ZWFIZGw0dHZ0UHROdDFhejFWeU9zZzFUSy8yb1FHVUwz?=
 =?utf-8?B?K053eEoxcEdOTFNXV3RTTzdIUkxUMSs0TERTbmtFVStGZnNKRTFiQjQ0ekk3?=
 =?utf-8?B?Yy9qT0ZIT1J6NVJFQXBnTGJqSHFXdGlUMk0zeDg5Rnl6dWVtZ3BGeHZiQU9F?=
 =?utf-8?B?OHhLWU14RE9NL1dpbHRTQjY1NklxTWN3MEluT1hxZFRJM2xGMnVDSFpWRlVW?=
 =?utf-8?B?OWlsTHdtRThNT0Q3WjVpZHpzd2pTSC9EMTJYelNHemxqVkRYYlJiZSsvZUF5?=
 =?utf-8?B?SGNZbVppNWlPVWdUczdyUW5QZWlPSnAydk4vNG1DUHJtanVkUlJEekxTMm1z?=
 =?utf-8?B?NXpYNlAwTEdiSlhia1haNjJOc0pscUZhaTdCa21UQnh4Q0FtdTRnbTVBd3Nw?=
 =?utf-8?B?b29xZTlZUlp4b1VVeGlWdjhOUWZuUVAxMnNTbnV5MTMvK2tPMlBWZDVZY3ha?=
 =?utf-8?B?T3RiSHZvb3JjTUtLTGtMQkJieTR5dW5YSDlGSHBLeU1DdDM5RHRwTmJONUlm?=
 =?utf-8?B?bjNsUHhqQUx1OStGakh6SnJSclJJY2E0NjdoZnU5QUxxWWhlbEtFWHFpZ25n?=
 =?utf-8?Q?B3R87g5zuH1Ppc/L0Cwojhaxo?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932c9e59-f40c-4e7c-069f-08ddeb27339f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:19:36.3564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfeXL8R4PV0pSvJc5egCVwkOxs6vsEwW8OqCM/gqZuj/6qhXWge+qiFw1UgvriL0YIexCKQDgA/xD2HQ7LIT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8133
X-Authority-Analysis: v=2.4 cv=O4M5vA9W c=1 sm=1 tr=0 ts=68b8a2da cx=c_pps
 a=JXmqnGAylZzlMSZfVbpSnA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=plkC6irEooDNg33354wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: c1Cj8AWgPHAHezNDxCCdXy4kTRb4x1Dg
X-Proofpoint-ORIG-GUID: c1Cj8AWgPHAHezNDxCCdXy4kTRb4x1Dg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIwNCBTYWx0ZWRfX/zTM0p14XHy9
 H+k+zbKpbi1yKgNaRV6SMGwBTdUVFCyXfPvvPxKM/TKko5b4enWDsXx2VbHnYF62gyJ1LgSayeS
 Gkrg1wDt5qgkL7UTVH7FtiUqEg8ZEPi1ovbVm/ETKG6Fachh1XARHCPllUr8OHVAoXnDXZ/bX0G
 x6wSnegofI2n1/NIrfgyYKfiu8fN3xZBIWWMqahAGbW160NvtvvrA7kj4mm5mpL7VLN9asjJNla
 VHOKS5hGwuBzJjYd9XU6ONYTkaJLyrcXoskGvaWARlrCmxaIM2+RFFZENpzqBBxwTq8ye8JZ6Pe
 MC30I3K7ElLqMDzi1DOWL3+LO3UDQD4/qg4sZkw/dO+pzsCYMQNNvs70A9dHR0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Add a basic functional test for the vfio-user client, along with a couple of
test framework extensions to support it.

v4: generalize the test so it's less sensitive to build/environment

John Levon (2):
  tests/functional: return output from cmd.py helpers
  tests/functional: add vm param to cmd.py helpers

Mark Cave-Ayland (1):
  tests/functional: add a vfio-user smoke test

 MAINTAINERS                                   |   1 +
 tests/functional/qemu_test/cmd.py             |  65 +++++-
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vfio_user_client.py           | 207 ++++++++++++++++++
 4 files changed, 262 insertions(+), 12 deletions(-)
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py

-- 
2.43.0


