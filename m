Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5253EC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnfD-0003Iw-OQ; Mon, 22 Jul 2024 03:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVnfB-0003BD-87
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:40:53 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVnf9-0005HN-63
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721634051; x=1753170051;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=r0AqjzUQLxorcit0V//bsNjqc8Jycj21RqyXKe4+PjY=;
 b=dPWZSXuLaS0cR04Owejbw1l2aekz6pFR0pREpMleC+rRdYIf/cdII9jJ
 Rnq9Q6OrUd/yPmc0tshaGL+lUY7NAvlZ2MowoHjg/7AhCkT7DTX/KBNuU
 QiFOOmwIM2sa4d0P/QjhftWZIFjhKuvWfwGOUEn31PLhzjMt7+W/BX0YF
 gJ5cIq6iIp3WNbraLa29WwBcanNTddGCeGD3AH24d2ssqNhZ/1UAMihcZ
 JggwDgfLuhbwU2L+/jX5+EFp5qBuuQGOgeT7eOJ/J/AG+i23EfRBjN33m
 B1w88ZGpaaW53f2RMvS6K9YG6szheZIYIXXSHjhcCCppbHn5txl1xSTFF w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="125772041"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="125772041"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 16:40:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOjrh1j7n7x/k1ygnRvEoxZ0yHCZlZDxk1Fu5j5X1ctYJR7YYMR0+qO79W81KoUJ3VeR7P7dtDe9FgsS2yAGBjjGRPS9Gz0AH+4peNDx+4Kp/AJpt1Kpj5u+zK53Yhi7ceKOQHmbzwWOMQH8OJGtxSvrsJGAbO2SirXGK+ehES4jl6VU4VI+NalYn5D4Nb0Z49QKqL16hte6peD5MTlhDekWt+C012184vgpSdpcYYwRWMK3PwOD/QxdEMxUgH2DjNGNcjMMAyK8pLXuB4iIPJDvgWfzyGLIVVOEnUv8xFs++YLbvqPEOqmVIQQVbddJqFVoEt3GmZa92Z87F36cGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0AqjzUQLxorcit0V//bsNjqc8Jycj21RqyXKe4+PjY=;
 b=nJr5QmeeP43yCIPO6+5Tisg1XFSKxHGznycMCSDME5SM/fJmSj73aQ61Sr94d07xKUlixukWVyZvdvLfHnEPHYzyT2oap8pC7VNMdIGJJsPxZ+550Xq7HSZLNRQsbnijgu0LN4HHp9pIu6P9nnmuGhC63i/KJ3eDhDh77R5e+MQiiWrupbs80hwPLNrUzqgS/f57D9RHDddBYpwgHiue3B1bSk7urKi+SzN1ORCRg9Arj0mVykiwIA9EsJa4ib+gdc4v7E0JYpa6gevyckZrCp6IfTQsNT6G6SKBDkRledCqhm0ST4dyzMslk/2GCEaKtOO8v3TKVopQL7Y++Y31VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TY3PR01MB9778.jpnprd01.prod.outlook.com (2603:1096:400:22f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 07:40:45 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 07:40:45 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 00/13] make range overlap check more readable
Thread-Topic: [PATCH 00/13] make range overlap check more readable
Thread-Index: AQHa2+y+M3hJ4iUEQk2slUBuC3LfYrICTOWAgAAAX9CAAA7OAIAAAI/Q
Date: Mon, 22 Jul 2024 07:40:44 +0000
Message-ID: <OSZPR01MB645378FB40C3E46D503182648DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
 <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <3d5d891c-7e8b-4b13-8fe2-c30c5d2223e1@linaro.org>
In-Reply-To: <3d5d891c-7e8b-4b13-8fe2-c30c5d2223e1@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ODM0ZjYwZjktZGYzMS00MzMwLWEwZTktZDBiN2FiOWU5?=
 =?utf-8?B?OWZkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTIyVDA3OjM5OjE3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TY3PR01MB9778:EE_
x-ms-office365-filtering-correlation-id: 10815bee-1b51-47ef-7cee-08dcaa219896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?SE1lQXhDUW1oakkrRmErY0lBQ2FpaWxCdXZDVC9mUEQ0clpkYUdxRUdWaEpn?=
 =?utf-8?B?SXFOTHN2NlVMNHVQTzZ0NHZHOWJtZWw1UGJuYU5oVVRGWm9BOHV3T3JoN2t3?=
 =?utf-8?B?dElWNUNPeFpsWEd3VVI0bTZyM3lBd1JEc1g5cmF4bjVlUEFIQ1hJWC9FNDRW?=
 =?utf-8?B?a3hSbEVxWTVwK0dMZGt0aFJEK1ZwR3c3aUZqc1V0Y0lZNE5BOHVlRkhIZk8x?=
 =?utf-8?B?UG1rVnV6T3JEV2YxY2daUTRFYTBSQ3c1ejRCREhmWGg2TUsyOXJDNE5EWUFI?=
 =?utf-8?B?bkV6VEV5NkQvVVhkL3lsTndaUHNYOFJoNldvL1Jhb2wrZGVxSjFaRW9aYjhT?=
 =?utf-8?B?U3RxNk9XVlQ0OStlaGcrdTg4TUs2bHgvajg2OS9lMmVNRmJzWktWQTdKaytQ?=
 =?utf-8?B?ei83ZnZRRHIyYXhLQXhJbkkzd2pFRGZwUkN4R2IxZWFxUU5zUUw2d1ZDZkRp?=
 =?utf-8?B?SzFyZy8zL3BkMmdEMFl5WTJkK3dmOEM0Z0lKVjZpMkRyVDBiMWlZa2xmWVVG?=
 =?utf-8?B?c0pVV01sSzFWeVlWdG5DZmppQVhXUmJCaU12Uy9PWVlueG1vQVVhNDl4QUlP?=
 =?utf-8?B?dzAxVjVMWlBzd1NOcDFwZGFJMVp1N0tvekRIbHgyb1piWVRwSmdaUVM4Q00w?=
 =?utf-8?B?Y1hGckw1NFptcUZvblBEbVNSZ3hzNUF4Tm9aL2tneC82UUhwVXZrYXF3Zk9K?=
 =?utf-8?B?UjQ0K3J1YzdOb0RFTWIrcHJzMEZYWEt6WkZCK2U4VkxVb2YxbDdJTjBURCtK?=
 =?utf-8?B?cUJ3UStPbFIvaDUySStVbXFxOGsyMU1pWDhvZW1TQmdtdWlOK2NKUVpJUkxa?=
 =?utf-8?B?enVZNm42MmJTd0xYZTdzOTBkTXhsdUdpT1RueTVtKzBNK1VlQzhtVSt6VjVq?=
 =?utf-8?B?TXpBaktwdnRNNU91L2gvbmZjemxZcHVGVHp0SUxSNVZvZkkydkxTWm1MN3F6?=
 =?utf-8?B?QWFKNzhqOHp6Nnp1cTR6L3lBWkE1UjJLekg0MUpLTUU1QjJtZVpieXdJTkMy?=
 =?utf-8?B?NW1FT05ObkxCNDRvZ0JlVWJvS0VOOFliT2JYVjJwVm5KbHJCRVRjTGkvOHNH?=
 =?utf-8?B?aXdCeTA2aFdHbVVNNDBqSkMzTHVBa3RRVGliZlNCQWE1cWtSS1dNS0J0cjln?=
 =?utf-8?B?T1ZQQ1lraXZhWFRvM29wUi9vdkdkVmdId0VuRWYzR3ByUWdrZlQ2MUdaNmlR?=
 =?utf-8?B?K3NyMkgvK2NFenliNHIwVGlYQ3dtTVRSSVBiLzg3NEJLOWtXRDIxcWRiN2RQ?=
 =?utf-8?B?ZXJsVHFJc3lMazJYK05xZ1dCYlZHY3VDWWxnbk94MEhrKzhzR0dDcVQ1Kzlr?=
 =?utf-8?B?S2tGUWVBVWFuSUZYZGZPNmxhWXN0aVBpZ2VCb0s4OVdYQjR4cUlPbHNsTGU5?=
 =?utf-8?B?RmZqb1ozNFdUeWZwSk5ZaUNjUEg0T3JnR0Y2Z2lWT2pBU3ltWEhkTm5IdlNN?=
 =?utf-8?B?U3ZaVkx1dG5TM2xoMldjNEJvcEwrQW1iZElJZmJXNElnN2N1RjMzYWVtcTA2?=
 =?utf-8?B?Rm1mMVdPS0dFZ1lNdlVSQ25SRWRrRHFWcXQ2bUh6NTRoVldlM0RyV0RLc1h4?=
 =?utf-8?B?UEloNXJRL25KOHQrbWhuUDExR21vbXZPV2NZNVhWNk5YOXllV29yTzlCcmc4?=
 =?utf-8?B?bGpXWlNWNmZWUjZnN3JGM0xpcHQxK1FBZjhVSDYxTFRBKzM5OUJUL1JzY0N4?=
 =?utf-8?B?bTVsZFBHNmlvUVJkSW9kM2x5Z0ZVZ3pBY05qUmIrdFZsQ2pLbHUxRDk4SlVS?=
 =?utf-8?B?OVpuTDhhaFJXNVNqcVJYb1BWZmx4aGtLUkwyWGNCWmk5emg0eEFQNWJrVGtM?=
 =?utf-8?B?VVdSVjBBTnE5QmtyVGFhbzh2ME1vNmVrL2QxVDQ0OWh5UjRQY0hIQkQvZ1VW?=
 =?utf-8?B?cmRFYitJYmpVbGJpeDJQMU1GODlXTFlXQk9rY2VHWDJmVE9LdG1GOXR3OHVO?=
 =?utf-8?Q?Dvag7uf35IY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2VOMnFON1BncjNZd0FHTGFYWVlteHJBTmpYQS8xRU05WXlETkdQMXJscmQ5?=
 =?utf-8?B?b1JHOHloajlQaTR6UUdONzM3VVg3MHBHSzFEeG1qUmdKNkR5Y2JOVjV1TjA5?=
 =?utf-8?B?TFl3UVBISml1RktGcW1mVmFBYlVFdWxvU3Q2TFBrK2x2QlB5Wm1EYmVJQmx1?=
 =?utf-8?B?Y0V0d0hhYmNFcEt1ZUR0RjhBWk1NUElDU2pHWTRWSFp6RnVFZ0JRbjZrSWJr?=
 =?utf-8?B?UkZKdUJuWkdTdjd2OWxzNlp2RE81M2wzdklJL1Y3UTVOQ1pKVUpKVkI1WmVl?=
 =?utf-8?B?eDlTU0Z1VllLVjVBYTQ5bTR3dXRYWit6M01NT1p5d2NDMEJnNEFhT2xqT0ht?=
 =?utf-8?B?bVdyR2pUZ2Fta0x3ZDJnbzlSNGVlMjUxOXQ3Q2E1WmowcU1ZQzhxWnlHNUhp?=
 =?utf-8?B?aGl3cEZHT2IxUENXUjdDTXZvemZ0SHdwcE1XUklMWWlHYm1mVVlCOUFpNVNV?=
 =?utf-8?B?d3ZUakZ4RDF5R3R4OVJHa3V4cXlHaXJGK0cvK3hUZ25lbytiSUo5aFcvZ1BU?=
 =?utf-8?B?WHI5ZHlydjJyM0EvUnFKWG50QTVKczF2VlpuQVdvblZMMmpZcEI4UURROUJm?=
 =?utf-8?B?VFJCTGZDTUFkYStoV1BBaHU1YTBoeVBBeHE0YllERmMzNFZyNjE3Wkc3d3BL?=
 =?utf-8?B?VFhXU0dYc1BIL2FYeHNDWTJMRXpqUHdOL2ozak9Qdi9MS0kzaEU3cTJHMmdh?=
 =?utf-8?B?aHJ1QTRnY2YzanBMUUlWV00zTlpGeWdPNld6UzNCcGs3VStWS3NDS2Mvb2w3?=
 =?utf-8?B?bFhSV3huM01qekdxZlQ0NlF4NmY5aDhHZTlVVjhmUkxxeVhrYUVseE4vbVpM?=
 =?utf-8?B?WjhnSEV1TG1JMncySEUzUW1OdlNxWVpaRDNWMi83K0o1MVB2S05aUUtJSHdi?=
 =?utf-8?B?bldtUXdIM3B5RkVFYkZ2UExMbkVhTWdMWmYwMllRdHc5RmphVnJSZTVQUVFV?=
 =?utf-8?B?NFlndjJDRHJJbVd2TWs0cWozWVBnNU02SG5PVmRRS3FaTmlTZmNOUFQ3bmZ2?=
 =?utf-8?B?VG1QZThtdVVFenNHc1h2K2lOZGVLYjhmNmxzb2JTRnhOWFFJbU1MamF0QXpW?=
 =?utf-8?B?SXpuVnFHbUNaUy9vVjZMejhFeVVjVUtqSnc4Q1JNTFpjYjNXeDU0U1IvRGhV?=
 =?utf-8?B?SVdVL3l0UmZkSEhoOGpqajhzVXVLbkhEVm1QT2V5SmtJR3hTbVdNSExIY1B2?=
 =?utf-8?B?bk9MT05kRU1yVm1WSXlRb3R5S0UySmZFbzRUTnIzWU5Sb3pkL2duL3czaitS?=
 =?utf-8?B?U2ZUajNMU3JCNHpLMTBuWVlrckUwaVFOUlJlYmxvd29hdEI1eTRvTDNab3Rq?=
 =?utf-8?B?S21ybWlxajBFMit4dmZWZEs0Z0h0Q094cjVsQjdFMHZrS0FwcU90L2FQMlJT?=
 =?utf-8?B?VlhXL0l5VFZ6b09USFJIVzFoRm5rbXZLV1VONitiWFFsRlJiTUVhWmpCR2l4?=
 =?utf-8?B?VWpQaDNuRVdFRFpEYTdCVktYc0REb3Z1dTBzTGJRcVVQWnkvcXFCTGJ6SXpJ?=
 =?utf-8?B?T240ZEZSUkhzc1d2M0RHNXhTaStuZFBnU1VZUzdWSW5hRUZzVzZaYXZwUnY2?=
 =?utf-8?B?UlFNZE5jTnl4MFQ1c1FVYXMyNzdIcEdvYnltcmVLMEZPdkNzSEZEZGo5TlYw?=
 =?utf-8?B?aUdaQWV5TFhzUE9JR3huNWRVTmpOSXg3czI2VktZQWNsa1pmQy91L2lKTTJF?=
 =?utf-8?B?bmpCR29xdERzdzVHeXJVZmxRZnc4Zlp4RjBGYitGQklMS3BXWkRxOVR4OE84?=
 =?utf-8?B?VHVvTzZpUGpiaHNOSnhWOFRyV3poOVBpZ1VTaFVtaXBuWmtvTmZSTG5qTEJt?=
 =?utf-8?B?OGE4d0ErZThnRzlMSzArcjJ3VCtwS3ZwRWtlSjkrWE8zWVlnbVNMTjIyaGtt?=
 =?utf-8?B?S2NibUVzMlk3cWNaZ3pocmJEckVZRUIyb25uMDZpVDYxUldhaEJ6eEt2Z0dj?=
 =?utf-8?B?YmpDVXdKQnBha1IxWm9STHZEcHVIR0VFMTZnaVZrRk9QaHpYZmdCWVA4dFNs?=
 =?utf-8?B?emsyY2VWNVRLOXFxVmRnMzdXdTlpNmV5UWd5dTBieHFidHZKc2hFVEVsclkr?=
 =?utf-8?B?WDNhNmprZStiL1JCM1VaS1dXS0xNSjBkbUFINU1tWVVEUXJlbFpvN3JXZG5J?=
 =?utf-8?Q?8GDf6V2NvE2eVrVgrWexyMoRh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ahyS31yjwR8hoEiFRdvj1keEAzviDDqvSXzQ8r2lel8W7pjGgkZWPGo8ufqSlsufM04tSdbfWF7lKZbY2WJE4SOx2wsRdCPdzk03oLecRYLfF7VqWQ1c7zZ+4APkMUt1Jmv0LH7cnLgwN9oaFgeg4e7Qzt/tszovSeaYDscrv/PtnlI1s7hbzbN5IqwiWG5wK+k/0gKG2HoU82FJGZ1z5ep4k+Su8CMDGVxUoO/8nC2m8IejmlPWui57dbsvhMkirTCTBPDflcDMTwAK/2ib0AS9e/fLLLmjqraIdnvXsDJ+tsvMGD4IL0C0ayeLSljmiz//AhAoCSZ6gNKQgW8K0Lasf1ryKR1rKuzAI6SgYC4zV7WkLG/wRMnB0CR6kezDbTjMGZxjnXtD6q5kqa4hMe40a0gJIZpp9qS7tc/M00xjljQgCIoTDuqI6I1R1VWtcNcwaV10HLY2DCrB1PnStaipYf+fm2Tlt51adNwgtlfHWpKb/p70/zrDw7E/im8bEFPNYYq/EAYusQiQtKmZV/lyYTuZ5SymkCWasfpjmcBGP3w4IWYIMraYUzTSNbdwIXk7WmDo7wflUHi970tnKPNCmwtSUgr2yvyX6FZECBuEjwmC6+Mu7ueInmoHntpv
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10815bee-1b51-47ef-7cee-08dcaa219896
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 07:40:44.9966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHMZis/E89OD6QDLBmjeU3wbFQLJ41AqSLNZMzx4HtIDse4bT/oMBFnVpiUU9tytkgRh2M+xK7Y4hI7UshZ6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9778
Received-SPF: pass client-ip=68.232.159.87;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMjIsIDIw
MjQgMzozNyBQTQ0KPiBUbzogWWFvLCBYaW5ndGFvL+WnmiDlubjmtpsgPHlhb3h0LmZuc3RAZnVq
aXRzdS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
MC8xM10gbWFrZSByYW5nZSBvdmVybGFwIGNoZWNrIG1vcmUgcmVhZGFibGUNCj4gDQo+IE9uIDIy
LzcvMjQgMDg6NTksIFhpbmd0YW8gWWFvIChGdWppdHN1KSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogTW9uZGF5LCBKdWx5IDIyLCAy
MDI0IDI6NDMgUE0NCj4gPj4gVG86IFlhbywgWGluZ3Rhby/lp5og5bm45rabIDx5YW94dC5mbnN0
QGZ1aml0c3UuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMDAvMTNdIG1ha2UgcmFuZ2Ugb3ZlcmxhcCBjaGVjayBtb3JlIHJlYWRhYmxlDQo+ID4+
DQo+ID4+IEhpIFlhbywNCj4gPj4NCj4gPj4gT24gMjIvNy8yNCAwNjowNywgWWFvIFhpbmd0YW8g
dmlhIHdyb3RlOg0KPiA+Pj4gQ3VycmVudGx5LCBzb21lIGNvbXBvbmVudHMgc3RpbGwgb3Blbi1j
b2RpbmcgdGhlIHJhbmdlIG92ZXJsYXAgY2hlY2suDQo+ID4+PiBTb21ldGltZXMgdGhpcyBjaGVj
ayBtYXkgYmUgZmFpbCBiZWNhdXNlIHNvbWUgcGF0dGVybnMgYXJlIG1pc3NlZC4NCj4gPj4NCj4g
Pj4gSG93IGRpZCB5b3UgY2F0Y2ggYWxsIHRoZXNlIHVzZSBjYXNlcz8NCj4gPiBJIHVzZWQgdGhl
IENvY2NpbmVsbGUgdG8gbWF0Y2ggdGhlc2UgdXNlIGNhc2VzLCB0aGUgcGF0dGVybiBpcyBiZWxv
dw0KPiA+IHJhbmdlX292ZXJsYXAuY29jY2k6DQo+ID4NCj4gPiAvLyB1c2UgcmFuZ2VzX292ZXJs
YXAoKSBpbnN0ZWFkIG9mIG9wZW4tY29kaW5nIHRoZSBvdmVybGFwIGNoZWNrDQo+ID4gQEANCj4g
PiBleHByZXNzaW9uIEUxLCBFMiwgRTMsIEU0Ow0KPiA+IEBADQo+ID4gKA0KPiA+IC0gRTIgPD0g
RTMgfHwgRTEgPj0gRTQNCj4gPiArICFyYW5nZXNfb3ZlcmxhcChFMSwgRTIsIEUzLCBFNCkNCj4g
PiB8DQo+ID4NCj4gPiAtIChFMiA8PSBFMykgfHwgKEUxID49IEU0KQ0KPiA+ICsgIXJhbmdlc19v
dmVybGFwKEUxLCBFMiwgRTMsIEU0KQ0KPiA+IHwNCj4gPg0KPiA+IC0gRTEgPCBFNCAmJiBFMiA+
IEUzDQo+ID4gKyByYW5nZXNfb3ZlcmxhcChFMSwgRTIsIEUzLCBFNCkNCj4gPiB8DQo+ID4NCj4g
PiAtIChFMSA8IEU0KSAmJiAoRTIgPiBFMykNCj4gPiArIHJhbmdlc19vdmVybGFwKEUxLCBFMiwg
RTMsIEU0KQ0KPiA+IHwNCj4gPg0KPiA+IC0gKEUxID49IEUzICYmIEUxIDwgRTQpIHx8IChFMiA+
IEUzICYmIEUyIDw9IEU0KQ0KPiA+ICsgcmFuZ2VzX292ZXJsYXAoRTEsIEUyLCBFMywgRTQpDQo+
ID4NCj4gPiB8DQo+ID4gLSAoKEUxID49IEUzKSAmJiAoRTEgPCBFNCkpIHx8ICgoRTIgPiBFMykg
JiYgKEUyIDw9IEU0KSkNCj4gPiArIHJhbmdlc19vdmVybGFwKEUxLCBFMiwgRTMsIEU0KQ0KPiA+
ICkNCj4gDQo+IFBsZWFzZSBhZGQgdG8gc2NyaXB0cy9jb2NjaW5lbGxlL3JhbmdlLmNvY2NpLg0K
T0ssIEkgd2lsbCBhZGQgdGhpcyBmaWxlIGluIG5leHQgcmV2aXNpb24uDQoNCj4gDQo+ID4NCj4g
PiB0aGVuIGV4ZWN1dGUgdGhlIGNvbW1hbmQ6DQo+ID4gIyBzcGF0Y2ggLS1tYWNyby1maWxlIHNj
cmlwdHMvY29jY2ktbWFjcm8tZmlsZS5oIC0tc3AtZmlsZSByYW5nZV9vdmVybGFwLmNvY2NpDQo+
IC0ta2VlcC1jb21tZW50cyAtLWluLXBsYWNlIC0tdXNlLWdpdGdyZXAgLS1kaXIgLg0KPiA+DQo+
ID4gYnV0IHNvbWUgb2YgdGhlIG1hdGNoZWQgY2FzZXMgYXJlIG5vdCB2YWxpZCBhbmQgbmVlZCB0
byBiZQ0KPiA+IG1hbnVhbGx5IGp1ZGdlZC4NCj4gPg0KPiA+IHRoZXJlIG1heSBiZSBjYXNlcyB0
aGF0IGhhdmUgbm90IGJlZW4gbWF0Y2hlZCB5ZXQuDQoNCg==

