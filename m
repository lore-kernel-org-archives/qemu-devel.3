Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D138ECCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fb1-0000B7-G0; Tue, 14 Oct 2025 10:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8fay-0000AR-KW
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:01:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8fal-0004XM-00
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:01:44 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59E7Gklp2974023; Tue, 14 Oct 2025 07:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ehoGWREo8w9bf/RcBCHeXN9yL/QnnIqhAGxVgMuiD
 lE=; b=LOyMK/VZyrESlmQHF3k75cXlU3WmhxuFkaVu2ZcDpnKWbIDm0j7+05a3W
 XjChjqh+hU5VUZkNJ669YCwBA+l5amMn4e6XgaEY7WETcArrrmI8Fkrc8Cvc+hdE
 43N3OHQxLJYm4aaIM8m8ZHPNl/biIh3tDFstm5F11hekMlgQlJ2+q/AvTOh/STlH
 WlOwdYt6PxybijDX7DEANUuRHdp1AA/SLFO3oUBqIixkXK+v1LVp7Nb7UGDdwOCE
 cpeeF07HctyyNmYOgWXJYQ1yJ77kpOgNOVtlZimrEO/vsow9fmaWQwhYs35G9TqI
 729XEnNwfisPXuwPaWZ/4/VNrjf2Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021113.outbound.protection.outlook.com [40.107.208.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49s6b4t8uy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 07:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm7U4ySzVWG+HRVEf59bRubVOz7Wk6/TLdSnNZaFEvG6Ze2Cq8oWMAwbXfoec8AUbVlXvTLDKKqIvqR88kFIUfnKBuJQlsacWtG1+uSzS3sWvnJwIphHDxHbrDAYbtTlc5CAbhpqK1j7upPBAqIu94EHWzMm3hdZI/+70+E3KLI/wLueD3YaKU6P43BFHyTEc6C86f8prfTJ0x5RWWMf6BLlPyz8I5W+PPWq3Zf4bWOpXWq1XhoEfXNr3IS9+gx+ZpN9tpXLY9eNZxrB49FO1RogfMqRSafy684oS0uAeymsTZRHguGlOt9GPORKYeOcxYn6xshRP17FRUzkbwKmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZtCtKe3cd8J2brVL4XRcQ0miZLOAHLYKNL8GQGe7HA=;
 b=jY06lapmcWc0KzqmTOl8ABmzkdAe5KERey5VhXzqh2tWtIVCw0y8ZGnutM6/n+giyLQLhL8v/xSekWH+gdhw0zlhi5OjZx7b3lujk5ToCuzs0TzhkVlfHygbPunQIoMc3+mI0zOgN0Cz4z1i3SEid/W6C9Z7S9XtVQSwnwYty+Hkz+CzYVjg59o87XPcvR8eEPjmIhyvUuhfXSn7Eq8Ln0AkfihlKLdZLM8B/xketOF3zbfAkGnxCebGjf9bM1bBvX7FV8Rp96RQ48BwZxXZx+sMbQPNTQcaT6OCskd+fSK5q1uuscmi0B4sZ0KDoITSlXINqzf++J9uYh23m3xOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZtCtKe3cd8J2brVL4XRcQ0miZLOAHLYKNL8GQGe7HA=;
 b=m4Xw8P5iqxva0KXsFk330CUm7mQU14Tz7lcXCAa4Eeis6KiJDmoDzGog9KUXjcavxSZqBx4hjJjRgAlHdbItiPZpSWVQHv1R/i5u9DzSKqG01EUaTPDXhD++Vl8fgRc9oWNreMDsjRPMcApbiJTsnbiGomVQmM4jPgc1Zgqbei5rjnTRQX5RKcDTO73+UWxADolkDpc6HhdlQ5ODPOVQluF9Dfn/pEJtrUc4C+I8dWCJ0q/O+W6KfL0mv/0GCOqcmyzlrKoImL1FN7/JeHbet/0okVc/0/AkIM/c7IMem7ihOb+cLBxJBTsAoT61xqhiPxohPPhzk+OEASc+Jh2ACQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MN2PR02MB6640.namprd02.prod.outlook.com (2603:10b6:208:1d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 14 Oct
 2025 14:01:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 14:01:22 +0000
Date: Tue, 14 Oct 2025 16:01:19 +0200
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 25/28] vfio: add region info cache
Message-ID: <aO5Xr3n-Ck8Wyc4L@lent>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
 <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com>
 <aO5RAIX6WI0MerI-@lent>
 <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
 <c20591f7-d743-4380-ab89-0efe254acfb2@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c20591f7-d743-4380-ab89-0efe254acfb2@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MN2PR02MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 4213352a-da5e-42de-222e-08de0b2a2834
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?IFwvRPvAKEZ2vinf9eR1QrveFRAPWU9TOlEorMmvnIYz20PeLZbreHsMaB?=
 =?iso-8859-1?Q?zp5CdLrJF52oCq/UiCDLMCwWptsMzOT4S/fZhzoiSmmMuGJD0ECMNscIZC?=
 =?iso-8859-1?Q?B2W+oYNf61WmAVcYRkti5raf0IQSXn6+7EJmLwUl7VCjUFsDHSMbX9mRt5?=
 =?iso-8859-1?Q?ZAFDJiAWQ4yO6b7wm/ZomC08C0pLmjf0PeA6YiW9mybenCuNp2IcLC84D0?=
 =?iso-8859-1?Q?gdPJHX1M8Fh877WGlMU4Z5FXGYTtDIAl/ni1ydeSlsXB8RSJHqZg+Unp7O?=
 =?iso-8859-1?Q?c2+1ezYBVob3OVrnt44ZpLRMSVrh2NOE4CSnmyI0AXmNcKHQXmU81wtdQo?=
 =?iso-8859-1?Q?8BLxcb/9S3dpMrDPctVqmBiJmYOUmEGIfA7s+vzlgDYl2f/ltD3+PSQVgo?=
 =?iso-8859-1?Q?F8kCNUXR3K6G0jlqbK3KmXvqnN8k+QU7/39sBPX6+55mBPRvrfbnvUMXwr?=
 =?iso-8859-1?Q?igm8xMQHQUosh1itmy/8oHqZBa4sXZ+VLF91DnWmUWlZf38lHkTJLy+HSG?=
 =?iso-8859-1?Q?rGomGg8/SJUidSHbC1iC4aaaiKB/tl7Pc59eupp4wtXdbPrs0qPKp1TjMx?=
 =?iso-8859-1?Q?OeK0s7KOEHH5R6UJeDhl7xoImChgReJC7TJVim34hVq5e5wanP2RkUdZEJ?=
 =?iso-8859-1?Q?4fxBJJKm6v/luPHGERTrxYyx4rff3RgU0wGQ7Ragj7+q0FlbGtYWEXsaaF?=
 =?iso-8859-1?Q?UGnl4RJmWvU6+OIpegYhRAafk8+LQUr57gFEHTCq4zwIQdHUopMdwYteup?=
 =?iso-8859-1?Q?WZxz0zRT1LgdmVmq9y1Cus+meGkYae6VBZvPRRcfZ49Rg4DQRHesjAxPZE?=
 =?iso-8859-1?Q?4NYbUiOaO3tTWqlxpfw1XHzk6gyeuIYxqMY4mrprxc4VgQ6y596C0DIa2+?=
 =?iso-8859-1?Q?PExoClGTwxbLanAo79wN2P9DI8n5KrM5vQ8+Q+iNlt/saPEfb89oNa39hm?=
 =?iso-8859-1?Q?tgx5jYJNjcdtTh+AeAkMH8YFz8seDDbM+cw70of7K587+iKn4gG/4fMs2m?=
 =?iso-8859-1?Q?W9d89c/D8rUOp6w/iEDR2CQkuhUqlhcec9nhSAohkWonLU2+w8x6kSrBVa?=
 =?iso-8859-1?Q?iHYVmqNe9dtAbAWj7Gk0SMVfZDNjz35KDX6O4HOGSAoFMcPZMrkvvQA01+?=
 =?iso-8859-1?Q?DIwp4CWHnbE9LJGEz/qV5edTttIKrZyowyfTmSDwyg4yd7p6DVFMXfs8+a?=
 =?iso-8859-1?Q?Rn1CotHp9zs6XJSTmpcBcdKvwBHb5XAi3uX1N2Sln5pdTwoAlNNF5mD9Z6?=
 =?iso-8859-1?Q?nm0e+8OoCtnY6Do7AOf9ANPk5Q98ij3BwXABuYf3Kk/+04JfDxMRQDY+M4?=
 =?iso-8859-1?Q?orXXK4qc1cPD01eLCs58XzW69zTCbhzvpsl/YXdCuolHrhWlGmCAaH1r4l?=
 =?iso-8859-1?Q?RcoSmPg691VyyoNAu7M/CtR2jr/GAwXJNo7VSBYhJGZT8IXckWNARGxjFf?=
 =?iso-8859-1?Q?Lg2fCa69FVUqNjZe4LkAPTHEFHQuUxqDYarvFkVTGNUatxvFEbgX1Ej0HZ?=
 =?iso-8859-1?Q?gZSqsD6t1Z0ATAom385NRV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o1k6oVYFKEfszs9HghmrQ3gE3Q2Pqlfs0WmF27XzBf72lMJRJtOUX69q2a?=
 =?iso-8859-1?Q?NxgXCGgXaEmqTaVcarjT+JE5QsquWrY4880SmAsFrLA9RnPt0Ujh7B0LIj?=
 =?iso-8859-1?Q?78uH8HUeh7h5FScXS6/lHWm/vHQntu5gmxUT2ml64AukxsjqipfUAVR1NG?=
 =?iso-8859-1?Q?Z+Sw9XaTajmfJRF7jwlMy+nMnLfw1UPhmsAe53fugqY+TUi9a0xwvze2XU?=
 =?iso-8859-1?Q?8HFNwDruaUHw+76mP7oFeOtgdihpvILJHDanPJZoPLD11xQInO5E1bKl7d?=
 =?iso-8859-1?Q?5zfRO6+6aNwPd8hJNLbIYOg1V9lV6aKOBwxU2ucGBpCuQNRRPTbPYb7ytt?=
 =?iso-8859-1?Q?UrkZqEazTHF8dW5hia2fFPwrr7tj3E400E0cbImbtDUBc2ZNx1SD/7s7lZ?=
 =?iso-8859-1?Q?8vYDxtBK3cMf9Clg9xohW7jxdGi6zy62o3lr4q46c3PtWE9+LXREOJi46M?=
 =?iso-8859-1?Q?YtDzy9aaetr4IxNygJwcHZKqruYNqQMYDk4TgFYTLHI2HYB+bH4MN6+EOV?=
 =?iso-8859-1?Q?NLmMn/aHGUfDDPTB4JnvbeL4/bS5idA4o9ltuZ5XvXUvpxhvJTAKsikx3q?=
 =?iso-8859-1?Q?q4j84RYnVBcCZcMrFAGO3A1WzP5wgmJqTwiJ19jzKktkXHjE32xCDPnZWc?=
 =?iso-8859-1?Q?eLCOKCFe0C58V5Dk8qlGnC6hI38cQvP33k6svmNaohBQgNj0wr4mp5Ozd7?=
 =?iso-8859-1?Q?fAWECD1NPOZw0AH/MTc4qu34Zh4PvGbUmo/fmN3aw9mOhDfvgrh/KaK9QQ?=
 =?iso-8859-1?Q?6AkJ2rSmUWKSsAlLjK7z97RDzijfuYtVijqTEFVwl1z5yO+gi7UuU2u1Oo?=
 =?iso-8859-1?Q?tTOo9cIOv8M/xRse5fOtsJOekcSexApCzcJb/jx3NB8SrumhvUyyfDRcGh?=
 =?iso-8859-1?Q?W4QA2xJRiEtnwgsQVYq5valrayuhwGqH31/h7zHeR+jRFeUtO3Isnm45Rb?=
 =?iso-8859-1?Q?B4fGsOctvyxi/ISg6S8foNHSqLLUP0zKfzkX7JBWR3k2HFiZbhRQzpbqWO?=
 =?iso-8859-1?Q?MKFvE21+bob/Fk7KUcgHVmAZUubMf0VH8JJApiC+e5pxZ8Akw4wADmeixW?=
 =?iso-8859-1?Q?3Z30LcsquGnObgWzA/7pwJsivbTMAhUJNXTQ52X70fjp1uD7bXbjkRIxPR?=
 =?iso-8859-1?Q?g2yE7Mfg6q9/gMilamP9A8M0p15RC7lnJti2gPYW4pGhcLOSCEip68i7dR?=
 =?iso-8859-1?Q?Q9HfXryVsErbKjhMbmX81mc9HsIA6/vHlkitarq+ug/ylNsc2ucoygubKz?=
 =?iso-8859-1?Q?NKX4psRsEYbRPeyedcnmHo6Jty9pBdYUMKe60GmK4Jfo67HB0LT/ecaJZ2?=
 =?iso-8859-1?Q?IHx3uFFm7GrLrEgn3Mh1xNXLrGlmqoSe1vbfssMnBMa0/FrWXFBYH6+HFs?=
 =?iso-8859-1?Q?1Q8h4GomBGsOm+vhO7yWdLRdZjIFwq9avKTc7h83Q0HtTiGEtcPUgzmzHS?=
 =?iso-8859-1?Q?jMfgq6TsLEDcFLM87RM3L9YTNkPQw6tFqu4/DTxVPCVvSrZ0iCRF3d+/sy?=
 =?iso-8859-1?Q?YjBe2vnCIGAFoA5RLZsj/jqG3a2EwY0KxEDW5qSEfeu7MgGDdOOZysdR9S?=
 =?iso-8859-1?Q?CTYwAT/34zojLol5LzbaCRHBiKoSwTVn5y4zfpKrfWMZZgmcsXnDZIif6B?=
 =?iso-8859-1?Q?Gao3IP0s7yVOhunTYdwGfWInZXI8KNJ+dC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4213352a-da5e-42de-222e-08de0b2a2834
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:01:22.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZRoODnt0xvY4srBKDaO9LCcYbjQjfEVZFNG3Th/rmUhM+qTYWG5vA//oN+Cs9tR0+t6KY7CpnvGPVBgSGReaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6640
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEwNyBTYWx0ZWRfXxMRBBID3uaHv
 RW0oQtxm9mUEEygnUwnJ/tjTBC8O1ehslEJrNGQi3YgeNCfE7GftyAcedfGgcox5f24k9Tw63d7
 2XjPFRKucMmU5vRFgX8NWaPuPTpVamEvcMIUmbDRBkj0evu2DHEVQKEgP5EqxyW4ubz9Ryi1Pg4
 qbqRQiWp3SCMKikvTnVPCQJswJPF8cSh9gnbbtJz+lw6mDs8mqWx8QYX27u77oyezWgDrYqegKL
 P96rNc0cti75eBdI4R8plFPjqQLW+uwpvKTpivUz3wuRSDm5d/TuGArfminF3nV7rtcR6et/3y5
 HHknKEnqFKa+wQTxQF0gp/Da8W1SaxbEhgS3iwl/3QcrlSJiJ/cFOphKMAbrwNenCLhyJpM9Dtx
 j+6CztA0GKxKDIa/TkBf9fP2xceLmw==
X-Proofpoint-GUID: jq7yvYaE9VrHRC3PUGk6EsTIY--t8PnS
X-Proofpoint-ORIG-GUID: jq7yvYaE9VrHRC3PUGk6EsTIY--t8PnS
X-Authority-Analysis: v=2.4 cv=aJL9aL9m c=1 sm=1 tr=0 ts=68ee57b5 cx=c_pps
 a=f+3zdzEv7nFEBFh6qWwLEA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_Eh3n3qZZcu1jyPUs-wA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
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

On Tue, Oct 14, 2025 at 03:58:02PM +0200, Cédric Le Goater wrote:

> We should then improve the VFIO region cache handling by reallocating
> the reginfo array on demand.

That would render it more or less pointless as that'd be a round-trip socket
message every time for vfio-user.

regards
john

