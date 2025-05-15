Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198D3C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanT-0001eG-NM; Thu, 15 May 2025 11:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam9-0007VL-Av
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalz-0006Rd-Ff
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7nlpt026476;
 Thu, 15 May 2025 08:45:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OmLi7Q79wS1SZfhbKLbxV0E3r3axuBtWF/BaQ0obj
 As=; b=NFdkQHet1gGGveZmFMigh+ovqyVJ8BWlbiII/ryq32kpXDWp/1a56ebBw
 jtWQzAaXpsFQZE8p6RmfgoXzuwSdUIAICThenRBe7JRlyGIg6D32tLi8cnDWDKh+
 piSlPXHok6ljtXP2j/klSkds1Fm0rs1n3JhjyyNsNLnjsE2LxBescrJuSU9AU/66
 JtlLRQovVp8rVzxUmdCKTMAFGtzFMMxv+VR2W03/kNa+XjPigTukC8R84+2LNszK
 mpFRPmocg4QzKPJLjKlFxAoUnATNmUqxJun26casvxbhHb947Xqq9C1Yg1REubDZ
 yCiLrbpk+mbOXJUf7cz/gF5w8WR8Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mjmtvrfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRw8jpWBrUCeuFxD/BOCSJ00hZwtMqnnHrFnFX96kVSkKatafd2NybnJORXo4rXfUC2dI4LUJnKE+7VdOC70SqLIp7kRNjMWW16bINa58B3BnDplyP3oLYLRCHGvslIhs6ChD3V+xBSFtefbtuCykpwTpU5Vhud965wXeSaioRUoOSdZmt3wPUY3otr6WTe3TPiRL5a8NsCbGhB0+efYEqZo0Etx73/bW4hy4FvhCnAax07IaA/DPoQ4sIw/GuZkCekQrcxXHc/9HBoXRJC4YWjBtv2XZhuKdLdLECvg6S5Pw1ojfW1GTHY/1k4fm+NoH9eHzNGY4MW2+lFta3gSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmLi7Q79wS1SZfhbKLbxV0E3r3axuBtWF/BaQ0objAs=;
 b=VrcqJ76WaDhKN//zSqjRD4pWR7XhKHiLY57uGWuMgUU4byNzHvPzmzrWxS+G29NfqhVoJAh17l1KxEOKhcbQRbL7wMnod4TX+eE7XtDG0XFu4xbvTYCnEDQvahTFh2CdeLvJuPgQcb4jr89lAI+2FygURHWV3STBXVp7RHaGcShMcnG2HyLJ8PEO2dLhmyfgKTJZVDV5iRsQZWtKKa/1aD1D+svmtz6//v+rCfLN/St9wJ73OuN240aJdeOVFanpgUK7y3MuL3i+i4x0MNa8/IvxZxHhA8jf1y17Rrya6lL74wuT4IsCF2ODQWOhky1IPY18iKh1ECZUUVVL2RWb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmLi7Q79wS1SZfhbKLbxV0E3r3axuBtWF/BaQ0objAs=;
 b=Ol51c9q0/Eu0iDnHH2XTifcWeOF46aXSmjmsUZP6DvnzhMGTch+yOkbC/RtlbkYaEa2WEks8bRZKzdoKZVluoYQtOqo4zSuGT1NF7gF2g/DOArQHES4keeP3hxEjKMSHEjAXT9u9+eTTExJH7C5tS0h1kfjOTbYkDg4zCBuZ1stwdEUr0YEl/QUgGeVEOWx30o8SG6H61FrbEOhpuKSKDOkOdI6aX8g+JeCm4A6pR/IiCdgKd+bXaLFyxptLP2tPYMW6m6T6H2s8lhMUEcyGEhzUmL7/hnje+izGV7+mKaB1F3hmAo9xuxUWk/439WpzRdjPqEcory0F1XK5ro2kJg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:46 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:46 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 11/27] vfio-user: connect vfio proxy to remote server
Date: Thu, 15 May 2025 16:43:56 +0100
Message-ID: <20250515154413.210315-12-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: c364b451-9db3-4ede-8517-08dd93c76b0c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTRsZ3J0SXpWdWRxaVVyenQ4UjNGNTF5R0NHckJtWU15MkxiZGFxVnBNQmZH?=
 =?utf-8?B?bnM4c1V3WUlSK0VZUHlQaUpkekVHMGZkbnc4alBMWXQxQ1MyREV0cHAvTXJ5?=
 =?utf-8?B?VFYrNkFOTTJkUm9wN3htSS9OSFREM0kwd3Q0WTJOcy9HSmxiRnltUWRadjBs?=
 =?utf-8?B?M0RqWU5QaTMra3F0Tzk5NkxXWkdNK1pWd3hPc0Z3ck1BWXBucnlCWFM5aTBx?=
 =?utf-8?B?VmR2QTdKM3BvK0ZZeEtmMXVKRS9zVjU5bWR1cE5Md0oyeVIyM2Z3cmNpdGtQ?=
 =?utf-8?B?WVNoYTJwYzdISkVUU2VJMTE4UDgybFlBVjc1RjliK1habkZzVkg3dXowcFM4?=
 =?utf-8?B?dE1WMWh2L0o1OHhkbUFCcDJYTWU4ZEYycG95MWV5by9kVTlaVzFVbDFZOUNV?=
 =?utf-8?B?Q0dmOUl3NGlybXpSc3p2Z2NINElFY1NnclVZR0UrZmRBZU9lMGk4NUVkemxQ?=
 =?utf-8?B?dk1qOXc2b2tLaTk5aEwvY0g4WEIwNXlXOFZmNmZSeVlCUUlUTWR5czZlOVVX?=
 =?utf-8?B?bnI2M1VuS0x6bVdxZGhvZm5ENk1DTXNhcEl5NnlhWi9qQjZqTWdudS9PTk95?=
 =?utf-8?B?a1JEL0ZMK3ZaTmxXdGpZc1ZFUmtYcDJrbHE0dGo1bXh4RVBpNERLWDlRZ25o?=
 =?utf-8?B?RUswVUx3Q0xoOXV6RDNXWWpKZGU0V0M2M2FzSGI2dVhMQS96VU1ySzROMnpz?=
 =?utf-8?B?QjhweFhMUGt5YVV4QXd5MEJwUHhOVDhmT2NjRnE5VjVKUStGVUh0OWkrWDE0?=
 =?utf-8?B?QXhrb0pkWmNQK3NDUmd2NGhXc2hQOGxIMHFudEVnZ3ErYlljbzNCM01LRmkx?=
 =?utf-8?B?R1diQTVwTHc4L0QvV3Q5aVY1clJicjh0aUZCc2VESFFoNVJCQURPUHJIWVJF?=
 =?utf-8?B?VGtaQk9Mb1g1ay9vd0J2Mkp2aTJmMm9NbE9WQXFLcjJqS3d5dWNhWkx2UmFt?=
 =?utf-8?B?ZWVyUStNOXFyQXh4ZTkrUVlUZEwyUzk5OUlkSmNWdjZkR0o0dWdzUFpSVkVo?=
 =?utf-8?B?ZGpPdnBMU1VwZ0hidE5ZVGR4V3BmQ0JvbDVDd25qeVRDVWNZQ2ZlYU9oZHJu?=
 =?utf-8?B?M21SR2ZKM3kvRnRiQis4YkpzVVBodWZvNlZiY3lRRDRCUmQyK3BFYWpRNkMz?=
 =?utf-8?B?L3lOam15QjA1MTM4MnJ0UGZBSHZXNHBIUWVuR1Awd0VROW5TZWc2VTJHSnV5?=
 =?utf-8?B?SUJvT0x5dHg2dFp2RzJ6aXdxa0dVTFBKRnpCdm9HY3h4alVsSWxEVmdjejRP?=
 =?utf-8?B?SnJDaWRQZHJaTEgyL0RoR2ZJNXFaYTNKOExzY0d4aEI0R1VEK1dSRmxvMmpk?=
 =?utf-8?B?bWo1aU5CNElGNlJvcUtNcWk3eDB3MlhRZElPcTlZcm5QTFZheGh2Q3FscjMr?=
 =?utf-8?B?SmJ5REtuc1c2WjZGdFg1SmVUYnEzS2VGaHVvNEFoM1FKL0RraDYySGp3eWNJ?=
 =?utf-8?B?Q1lHYXhVMTJNNXV6UklIa0lJa1IxY1BkcWZVeVkwbmE5NDdFNFEwU2xkMUVU?=
 =?utf-8?B?a2xxSXlzOW9yQVUzNHU4dmZKUkJsd285Ym14WUljZ1dhTysybjZFanE2WElW?=
 =?utf-8?B?NmUxbUxHT2lnaWRTSUd5THBmOFg5VG1uZkEzWTM3alNFcENaY2FpVC9OYzB4?=
 =?utf-8?B?MVZDVHdRRlNkNC9tY2NnNnlhOWQ0eTB6SkJueHpSNFF6cjViSU8zRFB0SUhZ?=
 =?utf-8?B?V0ZQQWQyWU9mSUt2ZVYwbmhaTGcxeG1XbkdjZXpmb2Q0RHpVb2ZkQVp6Y05j?=
 =?utf-8?B?anJmcEFpU2FLU01FTjNia0oyRU5vMi83MkxXd1F3TEx4Uk9RUDByVXB5R1J6?=
 =?utf-8?B?eWhRbEdFbXhnVU1zazYzbVd3Nm16K0o0SHJSOUV6U0JkK09PaFlrOWt2TUpi?=
 =?utf-8?B?MDdSQmk2a2lEUUtHQVJVdVFmWllkcURwd0l3UUpSUEN1aXE4ZHk4ekkwaHRy?=
 =?utf-8?Q?Md1cfIQAZbw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpCazZxa2FYZld3K01aUEQ3dEh4WmxPanFXNGZNK0daT2NPNHZnTmo2N1l6?=
 =?utf-8?B?cExnUzhyRDBtcVJMdGNkTUt5Nzh5aFEyWmh2RThPMjY0Q3pidkhEaWNSaWhr?=
 =?utf-8?B?a0EvbTIrRlZUWkFzNTdTSFl4Z21PNjd4aGJPTTlGaHY1SndwNGQzMjVpWUF6?=
 =?utf-8?B?MG5OdGhkQXlsK1M1YnlTQlZJSWYvKzd4T2F0RGhyajdwNHJWek9hWDRVbkds?=
 =?utf-8?B?VlBwMlFGNFlTcUwrOXRuU0RFK0Q1c1JDM2haMVY5UGtkNkxYdW8zS1FEQ3Jh?=
 =?utf-8?B?bTk0MVJMeUZWaTNLTXE5aGIzU2R5anpxTFdNWldmYVBmVm9PS2FOUnRFWEdU?=
 =?utf-8?B?SG1BYUdWcVRUVmdJTEYvVEFJTU5nQ3QyS2Q2WkQ0RnZ2MEhSNDNPZUpqMGow?=
 =?utf-8?B?U2p2bExNZ3d1RGZYa1UvSHZ6RVZtUXBXWEU1dFFlS3ZnZEV6cDUzcE54S1hR?=
 =?utf-8?B?OWlLVmFqb0NLRVQ2aXlGNnJPVS9yUUxQZFR6akJZSU45b0dQb0FaZStOdHAw?=
 =?utf-8?B?d3ZPcVlIcnp3RjNYeXdZa1lleE96QVJOK3hxTjdJQjlXY3J4clZjYko2NUZP?=
 =?utf-8?B?eDVUMzM5dmZsZE9uSUlyYVNyL3FRUHJqazhhKyt4S0VsczBSWVRHdkZQOG5P?=
 =?utf-8?B?VkdQYkNGY2VZMHlKNDVkQ1IrWHhycFJkaUpWQk9tQ2Ruc0dtSnlDbWVDcWJq?=
 =?utf-8?B?blllTUtJZjJxajVmSnpEQjBVQ0xKK2hpQzRYV29sbmVhRFVFbXVoR3Jrc2Va?=
 =?utf-8?B?K1Z4MFFqbGtoOHp4Zkw5MEM1QStkdmNKMVpMbE1IWVh4ZkRHaTcxS3BoZUVs?=
 =?utf-8?B?VmRETkM4ZTg1eDRCeGVLUitMMklQdXpRK0s5bDV0NXl4U3k3MDJJeXRUQ09Y?=
 =?utf-8?B?bFo5aFBIR3BYU0YxNlNvN21mYVpiUWhHZjg5YzlUTmkyalBMZjNYQXpLSlBT?=
 =?utf-8?B?NnNpU2poYnl4cHQzZ3ZqOW8vNmd3MWpCWkRZb2pUcktIelJkWCsyNVVYM3Vp?=
 =?utf-8?B?VTcwZHBwZzlQZEx2Mmp3cEt5NHB2Rm9ac3hxZFBIbGQrbng5cjhyZUhEbkln?=
 =?utf-8?B?ODJQNzJTYm5oUVVpWFlEUm5wRlFxNFpzeC8rZlA5SUtQVFZ0eGtybnNBdWEv?=
 =?utf-8?B?Si9rQVNzVlNaWUJHRDFDeVd0a1BOc2JwaDNFMUFxb0VwK3ZTUDhWazBkQU1T?=
 =?utf-8?B?Z2hZTVZ4b3ZlencyUm52QUFadWdKRmtlS09rOWs2WUhzbk5ERGlsY2VoWDlF?=
 =?utf-8?B?ZUVQdm9vMVIvbm5ZbXJGVjFZcE4vUHpSbG1ldVZycnk0STVaMXF3NVM0eW5S?=
 =?utf-8?B?TUY0QmFpanlhVWFvQUlBT0JIeHRjRjBZbW9SQjJrNTVrdTd6MUJhK2hRVEpC?=
 =?utf-8?B?RnNWcnE4VUg3TEhrQ3M0eXBaUFIvWVNmU3dSdUQ5VHk2dFRIeG1Ga09DUXlH?=
 =?utf-8?B?aFdRaFdsd0JoNThvNk84bS9ucHB4RUtnSkwzUmplUngwN000M1ZTZ1VGcTF5?=
 =?utf-8?B?eVVsVDNyUjF4MTBDY2NZdk9pdmRQMUs5d1o1a1I2NEdqUnNEa3k0ZlRGQVZQ?=
 =?utf-8?B?VWhFbzBscVNrRUdJc1I2V0ZuWFNGOG5raEkrSFJXWTRqT0xwWXoySjhhQzFi?=
 =?utf-8?B?V3NzTU45OTFCSEJSczROamFJdktSYVU4MTJFSVVMdDBzbmtud1BQcUoyM3Qz?=
 =?utf-8?B?VVB3RU10SGs1b1lxNXdvZEd4NUVWdW1TVzNTQm9vdm1IT3NDMit2TEU4MDdJ?=
 =?utf-8?B?emNTRVlWSzdEdDBMdk1OM1BhcmlNUmtBbHpWWUNMcU9paW1DbWs5Z0NtVUZm?=
 =?utf-8?B?N0lHdm01OGVvdENuWWFPZkZzcDQ0bGVSY21QRE9zSW00bUZBU3hXL1RONnhx?=
 =?utf-8?B?bTRpQnlSbEF5Tk1ZZFZ1RXY4R0F1dGNsZ0NYa1lEazZVeXdQcG8wZTd3U0pE?=
 =?utf-8?B?Q2hGQlYxUjc4T05ZWjFqdFY2bTk5ZFFxNmdKWHJjT1RpdXlsU205WkVweXdT?=
 =?utf-8?B?M0lMcWQ1SmFKanppaHhRbWZqOTFGQlZxY1lTdldLdEozL0dsTE5GeEdPOFJ2?=
 =?utf-8?B?dVFXeGlHME10eUUvUDdHZU1DOTJKU3IzVXFyR3IvZ1QxSlRMbHRtZ01CZ09R?=
 =?utf-8?Q?j8SE5/gLrTN8P7jppWO/OYD03?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c364b451-9db3-4ede-8517-08dd93c76b0c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:46.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxLnGEfXoDeokMdqiNlI/aOQ1flzxWgQovErCdxbFLhYLQrCJQs71GDUmQWGB9v6/CFanDyoCi9ktgV+o7s+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=TauWtQQh c=1 sm=1 tr=0 ts=68260c0b cx=c_pps
 a=kylQlKNaLH8A8Uw3zR316Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=vhHEnE-nI2wpHcbFAcgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xKk5kh8_U5xbTubRh9sdd0FiMhnXAmwh
X-Proofpoint-GUID: xKk5kh8_U5xbTubRh9sdd0FiMhnXAmwh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX/VKoUMEf8oyh
 3REYnDMSwL9AoxuR/OQj0n/62f5GYa74rUZZKJaJSmor9WOb/nOoMYlS9MMTD6+LHvEiXMZYglq
 4M7hq4hGr36u8bcyZ0HVToBlccjFTa4oQbbQ88Naly7KyRYf7+IpimuArCiB/RHfHcJvsrTF4ge
 MvP2ZltM6GhXvYU3K6n37WiPH+Jwhs0YlP9aPVnYkhsCyT+meQPxdOK9AELUHudHSbY1IRKa4O8
 BDs7oAzqwoYccH9DIY4a6B6uUYl3deTPZsdISxO9x2ngbm/xrNyB6EFzY4wMAvNk4ro8iw4ZQ6b
 P+m4ALDPPIBi6J0YQXphKLZrQ3Munxjeh5Hvu1hN6D0e9JjKRb6Z7/UmUgGYoDoJXaj6vNS+prq
 TdbJK5bHodi10T70g1rnJi8EDbwor76Bjeo2CLHWIBKC7ynFGSCk+vfK7kCxOEVRJAwseo1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce the vfio-user "proxy": this is the client code responsible for
sending and receiving vfio-user messages across the control socket.

The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
managing the proxy; initialize the proxy during realization of the
VFIOUserPCIDevice instance.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h          |  82 +++++++++++++++++
 include/hw/vfio/vfio-device.h |   2 +
 hw/vfio-user/pci.c            |  17 ++++
 hw/vfio-user/proxy.c          | 165 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/meson.build      |   1 +
 5 files changed, 267 insertions(+)
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/proxy.c

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
new file mode 100644
index 0000000000..60fe3e0b6d
--- /dev/null
+++ b/hw/vfio-user/proxy.h
@@ -0,0 +1,82 @@
+#ifndef VFIO_USER_PROXY_H
+#define VFIO_USER_PROXY_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "io/channel.h"
+#include "io/channel-socket.h"
+
+typedef struct {
+    int send_fds;
+    int recv_fds;
+    int *fds;
+} VFIOUserFDs;
+
+enum msg_type {
+    VFIO_MSG_NONE,
+    VFIO_MSG_ASYNC,
+    VFIO_MSG_WAIT,
+    VFIO_MSG_NOWAIT,
+    VFIO_MSG_REQ,
+};
+
+typedef struct VFIOUserMsg {
+    QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserFDs *fds;
+    uint32_t rsize;
+    uint32_t id;
+    QemuCond cv;
+    bool complete;
+    enum msg_type type;
+} VFIOUserMsg;
+
+
+enum proxy_state {
+    VFIO_PROXY_CONNECTED = 1,
+    VFIO_PROXY_ERROR = 2,
+    VFIO_PROXY_CLOSING = 3,
+    VFIO_PROXY_CLOSED = 4,
+};
+
+typedef QTAILQ_HEAD(VFIOUserMsgQ, VFIOUserMsg) VFIOUserMsgQ;
+
+typedef struct VFIOUserProxy {
+    QLIST_ENTRY(VFIOUserProxy) next;
+    char *sockname;
+    struct QIOChannel *ioc;
+    void (*request)(void *opaque, VFIOUserMsg *msg);
+    void *req_arg;
+    int flags;
+    QemuCond close_cv;
+    AioContext *ctx;
+    QEMUBH *req_bh;
+
+    /*
+     * above only changed when BQL is held
+     * below are protected by per-proxy lock
+     */
+    QemuMutex lock;
+    VFIOUserMsgQ free;
+    VFIOUserMsgQ pending;
+    VFIOUserMsgQ incoming;
+    VFIOUserMsgQ outgoing;
+    VFIOUserMsg *last_nowait;
+    enum proxy_state state;
+} VFIOUserProxy;
+
+/* VFIOProxy flags */
+#define VFIO_PROXY_CLIENT        0x1
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+void vfio_user_disconnect(VFIOUserProxy *proxy);
+
+#endif /* VFIO_USER_PROXY_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index a23ef4ea13..09f1a21bf8 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -46,6 +46,7 @@ typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -86,6 +87,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
     int *region_fds;
+    VFIOUserProxy *proxy;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 0525becb33..593104d15e 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -14,6 +14,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
@@ -46,6 +47,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     AddressSpace *as;
+    SocketAddress addr;
+    VFIOUserProxy *proxy;
 
     /*
      * TODO: make option parser understand SocketAddress
@@ -58,6 +61,15 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    memset(&addr, 0, sizeof(addr));
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = udev->sock_name;
+    proxy = vfio_user_connect_dev(&addr, errp);
+    if (!proxy) {
+        return;
+    }
+    vbasedev->proxy = proxy;
+
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
     /*
@@ -103,8 +115,13 @@ static void vfio_user_instance_init(Object *obj)
 static void vfio_user_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_put_device(vdev);
+
+    if (vbasedev->proxy != NULL) {
+        vfio_user_disconnect(vbasedev->proxy);
+    }
 }
 
 static const Property vfio_user_pci_dev_properties[] = {
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
new file mode 100644
index 0000000000..ac481553ba
--- /dev/null
+++ b/hw/vfio-user/proxy.c
@@ -0,0 +1,165 @@
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio-user/proxy.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "system/iothread.h"
+
+static IOThread *vfio_user_iothread;
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy);
+
+
+/*
+ * Functions called by main, CPU, or iothread threads
+ */
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy)
+{
+    qio_channel_shutdown(proxy->ioc, QIO_CHANNEL_SHUTDOWN_READ, NULL);
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx, NULL,
+                                   proxy->ctx, NULL, NULL);
+}
+
+/*
+ * Functions only called by iothread
+ */
+
+static void vfio_user_cb(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    proxy->state = VFIO_PROXY_CLOSED;
+    qemu_cond_signal(&proxy->close_cv);
+}
+
+
+/*
+ * Functions called by main or CPU threads
+ */
+
+static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
+    QLIST_HEAD_INITIALIZER(vfio_user_sockets);
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+{
+    VFIOUserProxy *proxy;
+    QIOChannelSocket *sioc;
+    QIOChannel *ioc;
+    char *sockname;
+
+    if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "vfio_user_connect - bad address family");
+        return NULL;
+    }
+    sockname = addr->u.q_unix.path;
+
+    sioc = qio_channel_socket_new();
+    ioc = QIO_CHANNEL(sioc);
+    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+        object_unref(OBJECT(ioc));
+        return NULL;
+    }
+    qio_channel_set_blocking(ioc, false, NULL);
+
+    proxy = g_malloc0(sizeof(VFIOUserProxy));
+    proxy->sockname = g_strdup_printf("unix:%s", sockname);
+    proxy->ioc = ioc;
+    proxy->flags = VFIO_PROXY_CLIENT;
+    proxy->state = VFIO_PROXY_CONNECTED;
+
+    qemu_mutex_init(&proxy->lock);
+    qemu_cond_init(&proxy->close_cv);
+
+    if (vfio_user_iothread == NULL) {
+        vfio_user_iothread = iothread_create("VFIO user", errp);
+    }
+
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+
+    QTAILQ_INIT(&proxy->outgoing);
+    QTAILQ_INIT(&proxy->incoming);
+    QTAILQ_INIT(&proxy->free);
+    QTAILQ_INIT(&proxy->pending);
+    QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
+
+    return proxy;
+}
+
+void vfio_user_disconnect(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *r1, *r2;
+
+    qemu_mutex_lock(&proxy->lock);
+
+    /* our side is quitting */
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        vfio_user_shutdown(proxy);
+        if (!QTAILQ_EMPTY(&proxy->pending)) {
+            error_printf("vfio_user_disconnect: outstanding requests\n");
+        }
+    }
+    object_unref(OBJECT(proxy->ioc));
+    proxy->ioc = NULL;
+
+    proxy->state = VFIO_PROXY_CLOSING;
+    QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->outgoing, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->incoming, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->incoming, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->pending, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->pending, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->free, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->free, r1, next);
+        g_free(r1);
+    }
+
+    /*
+     * Make sure the iothread isn't blocking anywhere
+     * with a ref to this proxy by waiting for a BH
+     * handler to run after the proxy fd handlers were
+     * deleted above.
+     */
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
+    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+
+    /* we now hold the only ref to proxy */
+    qemu_mutex_unlock(&proxy->lock);
+    qemu_cond_destroy(&proxy->close_cv);
+    qemu_mutex_destroy(&proxy->lock);
+
+    QLIST_REMOVE(proxy, next);
+    if (QLIST_EMPTY(&vfio_user_sockets)) {
+        iothread_destroy(vfio_user_iothread);
+        vfio_user_iothread = NULL;
+    }
+
+    g_free(proxy->sockname);
+    g_free(proxy);
+}
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index f1fee70c85..695b341547 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -2,6 +2,7 @@ vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
   'pci.c',
+  'proxy.c',
 ))
 
 if get_option('vfio_user_client').enabled()
-- 
2.43.0


