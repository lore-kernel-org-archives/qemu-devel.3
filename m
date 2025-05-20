Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD30C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWp-0003NW-Bb; Tue, 20 May 2025 11:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWn-0003MZ-7b
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWk-0002gu-Rt
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:12 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7TJcd016599;
 Tue, 20 May 2025 08:05:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLN
 GY=; b=ufYSsFigOMdP57yhWK+Jw1WxDSqGsetZcqLupUgQ96oEUT6eKufnpxucz
 Ojb/56uor8bntystEKTn9sYk5xHIKoELHcpoJLRKA7XBoJfkV0LgkHiU/eGpR+Bn
 hdjgBXC08aWGkX8tbQuRhXt5Xn+u6IB1SXAGqim04iYeTxDFdIwN64GSrVlfeOd0
 tgGFFvLImlxw5XJGKnXDJpzrJ2gnA9dpBaaCqjfclrYdhAiIWJATpJ5B/YNv9Haf
 mH0ObPRFu3j/PNzKn6EciU3t4Y8+vTjNlQqq724Q9fRlFJqNT0Gtjav1YwZgjlQh
 ovyZJNltYEl37Ce7w+vaI3FV4O6Ng==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheadj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho5zKlMSoVyqJW15JAcWzglVZiZJBnWeQ3AQ5dmPnFtw+wykqvCOLpVEOJiZrd/vTua94nXEj4fA+iLWjbs+WpLnLpWVAUCtVG5nhVYbB3vRUQq7Q0e/0o4m7z7qQxufp4Y57xK7pZwqxASZp3SlQu7BrTgKsAKlVcJgtq+ChxA2cYy8Dme8h2VXGKLZr5qrHwCOcodFZooLxdU7EbSPRKTazkU3bPndst3sHUp5WVfqu4+WQFffrQg7IzxjAZPcck9r9M2epd7XWZMhEzD6ptxEXzhPqp7Q9bTPr8zSGhDioAY32rSCRxpMYPRMzy72IcLB9MqZUfMxXNomhz97qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLNGY=;
 b=Hmzvl/qiTxsQBWZRUICNvV3NzRH4lcoRucYKUdXh0bCZCYlgrcU9TsApNfChcAiHtFbzGxayN5DoaMO9o4JzT9pEhH2i7C/k6UWUBR+/SJWAWZQavX8zhxZFoghQvAc+8ok2vaza+GFOJLoJHw4dtQAlCgywlWbV6sPlL03cOtfSSzIe4mzLKAlYnXGwHS4hLDUNbN08PNayWM+faEYRp8L9FDiwN2TvBDRW/ABmYQL8S2j8allYaiYjdsOGDDf0ZDp18yyLXhAd0SwfBDzl4iVcw6fbcH1Xa3n6hYQMbfwLvI+RNx3MnAV7looOolqlkMT84P8q2NNUqHeezw3wzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLNGY=;
 b=QJhoyvLytTeGfcbD/JHva1uftpd8/Seh/slWI4eq1tFP6BkO2rb1jQQnqCSYGO0PnJlEfAq3AFANACtYOvDY1UXBsKpdV0T9bpkSapeJBRyvrYBK6pAXNxakQqjJhDmSqzpEf0UDMVG5yxxnxE/xEqZKu9JdSWDbe48CnSQWbmd2m8VoqLBfnndpXIajw015Yi1wlh54l9JnBuh9vNeaj7BF7MFDnqWWhVyjVRTFmAD7hSktPj9Nfuatgmf0PaB7CzLHoF6Pu62LH8K2dHiDdXrP1qWeHLtdfEwqeLmQwrBw5yYZhZp0C9/5sK9Fu9xFvNY48KSCV0PSSRNl+5IVzA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 16/29] vfio-user: implement VFIO_USER_DEVICE_GET_INFO
Date: Tue, 20 May 2025 16:04:05 +0100
Message-ID: <20250520150419.2172078-17-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d93259-3e56-4f01-9444-08dd97afb3b9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWdsdkl0U21IcTNXS3IrMXJoZDYrYVhBbk1QUVozeTVEQmR4TlFYdjY3eW5M?=
 =?utf-8?B?N2p4a2V6WVJHY3IvYURWYTJ2WGtUdGtVOEZpbFQ2RithNFRmYjVndHBRcVdw?=
 =?utf-8?B?RXZFbUZidkR4TVg4d2pTMjN0MGxCVXJCRXo3YklydmU2bzRRUURWcWo1dURG?=
 =?utf-8?B?ZU55N241L0FUVDR3bWpBSWlYOUIxRVhJMjJJUzg4Y1JxVXhEeTFRZ0UzSyt2?=
 =?utf-8?B?TnN0QXN5VlhPUmZpWFErcFlhd0d3N0V6Z0RQUUpGWkJraHZ0K1MzWlJXSjhP?=
 =?utf-8?B?ZFExRldqNXYrTVRmSUN5SE1ROW5ESHk2RGwwUGFUVVZEb05kOEZkVHZlNzFJ?=
 =?utf-8?B?MisvbXRSbnVRTURVbFdaVy8xZFY5VC8rM3EyV1hpT0xsWERLOEVmOGF2aGlB?=
 =?utf-8?B?VHl5bGI0Vm05TldpSURZYjVJcmxWdzJvOGlrVFNFSXdvcDF2OWxIZyt5eS8z?=
 =?utf-8?B?WjRlSWZLQmhsbXpxb24wWlUwSUJsNEdNMmp5NjJFU21NeUcvWGdmRFRyeSt5?=
 =?utf-8?B?blhhVW5GUXBId2tPUVFheDFMenFGV0ZMOWcwK2RkNjhOOXpSS29FWDF2d2NY?=
 =?utf-8?B?R09CdW92UW11OWNzR3NaY21WWE0vRGUvT1I2LytWaFNreXU1QllrdjJLeWZZ?=
 =?utf-8?B?MDZ4MHpKNWk0MXl2N1I4TTFsZmFwckFPb1drSHY0OFlwRFJib3NreUxjVXdT?=
 =?utf-8?B?ZzFkNVlDc1Q0OTIxN201Q2U1UWZtY3ovVEVDQit6aGFCcWtxdmxUb1pQNExR?=
 =?utf-8?B?TFpkcDlJbVdyNU1MYmV6WDZNNW1LTXFjMzB2ZUNBeStjd3BGOGd3NmJxbkhx?=
 =?utf-8?B?UmNMSExjdXZkKzlWTnB1SC9NOFFyQm1VTHNOeXp4K2EwWG1GNmlHVlY0S1Jr?=
 =?utf-8?B?TDBnNGRjWWI4TERDNUlBaWt5OEdPSEt2VVlKdWNjSS9pUWlNandTSUd4R0JO?=
 =?utf-8?B?M1VXNDJ3cUMvTVlyc0c4eWh3bGE5VjdtZlhxcTNXclFZUmZpSmltb1JXUlEy?=
 =?utf-8?B?NVJDSUNtdjBBejAwcGJRbllrbnRoSHcyR1ZidUNJUThYUzRkaU10UzAzWGJD?=
 =?utf-8?B?azV4K1NKNmlhVGVzZ3VwNEw2SlROM015QlFML0IvVjBFRVJ1dUVqV1BybnpX?=
 =?utf-8?B?Sjh2RjNLMnp6NVljekNyamJqRzlhYUhpYjBtSC9CbUJPUUZ4Z3FHQ1lza3hG?=
 =?utf-8?B?K3c5dEp1T3JwTlh1cFVXbUJJV0JMQVcxWFZEcGQvdzRZSm9XRHdReUZQdWFM?=
 =?utf-8?B?YWZPamZRdTlmczN0QlBzY0dzSkoyMUVONXBGanBUeE8wb09YS1RWVGFpZURn?=
 =?utf-8?B?aXJWbVZvTUp2TGdBc3VoWkpzUGM3TGI3aG9RdWU3K1ZaazFQVDdxTVlDMFZx?=
 =?utf-8?B?OXdyY0xtTXN2WHMrKzR4OGZvOHRtalk3VW9ZU3d6STRBQjV0ZStzNGpTcjBt?=
 =?utf-8?B?SE9tYm54Y0hBeGlZc0ZUZlA2VFBnM1RsaW9RSml6dUhIQnIwVWtOYlhnMmla?=
 =?utf-8?B?N3ZlNkM3RWtRZnVaNERIQ0xIS0ZvSjJMeXYzL0Fwd1NJZHVEWng5bDVtYS9T?=
 =?utf-8?B?ZGxJcEhHdHp2VTdXa2VMSTY5U2xrdDZiS244a0ExMnN5RzdJeTNWejIwanlF?=
 =?utf-8?B?Ym91aDRUd3BQRFJQM01XY0cwN2x3VkUwaDVmM3QxU3g1QnhCVjJNTmdLNmpN?=
 =?utf-8?B?QkZVS0NlUm9kcUFLT21KWmtDU2xIcWhMaEhTUFhFZURkeENEMDBWS1dTcXFj?=
 =?utf-8?B?MC9sVUFHcWpHUzJGQXZmWUdyS0IyRTlHV1VMZmpobFZrNUd3WHNmUUxPMWxr?=
 =?utf-8?B?V2YwZURZMFlkVWRVcUgrYzludUVRT2dIcVloS0YwdUZsZ1lmd0pJZ2dQK0dO?=
 =?utf-8?B?Uk5MaGxhUFNYcVhHRWd2cUg4M1AwclNNQkhxOVNEUW04V1YvVjNyVUdtVCt1?=
 =?utf-8?Q?HB5rNlpv16k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGllTkhvM0tDR25Ta2tud2VUK3didVV2TDg4UFJGZ2tkbmh6WnYzR2hxcm9N?=
 =?utf-8?B?bDhaaTBMUm5IZ3JZekRHQjdwaWdWV3FLbHRwdmpBZ0ZVTTdNd1pRRENKMFpG?=
 =?utf-8?B?SnYwYitNdk52bjBiZXE0OG1IWUhIN3FadmFSMU9zMXdzUG1ISllycnROa0Rs?=
 =?utf-8?B?Wnc1VjZaeG9nOVhzVkN1MDl3enJ1bGFramVFdGlwb2ErcWZqY2pXOWp1cGxI?=
 =?utf-8?B?ZkpNTXBDRzR3YkJ0V3NYTkhKMUo3NzJ0WnU1Y0hQdWlDK0RPbWU5dk5BeU5v?=
 =?utf-8?B?cVk4SHhSditOM2VZOWZBZFlDOTB4aE4wenVkcHRKQitJaVl6ZGF6OHV0bjhY?=
 =?utf-8?B?RXBIK05xQ3l2UG5CNlkybkQyT0JVQVhXem5IRWZ2bVQwemg2dHNXVFhUb0hD?=
 =?utf-8?B?aU1jcmVjdXExSWwwbnVMNHFWV2txV3Zic29aVVJ5eWtPbjJOZUR1RW0wcyt5?=
 =?utf-8?B?QnhzWDlKeVp5d2drV2FWU2NJblhhamdUMHQ1eGxmKzhjdDFFeGxPK0ttV3lr?=
 =?utf-8?B?WStqcDFDRkRpeDlZVXJ3WVYzUVYwMmZEMWY1dHhyRUFCT0UwVFBIU3ZMa0dh?=
 =?utf-8?B?YS9uc3ZJbEwwZmtkWVhVTHRDSDkxeDVVL0VqUWNGWVhzRUVrbkhEQ2l3dTFC?=
 =?utf-8?B?WlYzdExVWW9jUUVqTUZhWUxCSUhSUUNwU3dLTkpJV3dUZ25QS1FjT3hnWDVl?=
 =?utf-8?B?aTdoM0lFY3lxQUVJQksvbmFMVFhjRGcxcng2T3VGZ0RZM1d6NGRxRHdPK3JT?=
 =?utf-8?B?OEFtRlZ3QjVrUXVCRSs5R1kyUm0xUGhqMkJmUTl4LzdoaWprM3Zrb3U2M3Ez?=
 =?utf-8?B?VEtJeWQzWUNQVWNHT0hFY2ttTkdrdWFjeG9sQUxmNlAyM1ZZQmorR050NGF4?=
 =?utf-8?B?Z09tVXlab1hPYVZTazVwRElTa1p3TkEwS2dzTzR1Y0IxVkRHakc0SExCUmhW?=
 =?utf-8?B?UUFrWEk0ZVlSNDE5MzJQTmtTbjBuYkM4UXBNelZPeWtMc1NyUWR5RUx2NnEv?=
 =?utf-8?B?bWUzdXpPUDAxejIxTEMwRnFqZjJxNFM3RHdjY3MvMnVGb1ZNc0d2SVRGWkdl?=
 =?utf-8?B?ZE9jWS8vR1hubFlsb2NDY3RyeWtEMnJ3U0pPT0JybzVsVVNPWmpibHJkQTNs?=
 =?utf-8?B?SEZKS1p4c3FPQmlvbzR0VUVpVC96U29IbTNMRkRIb0ZEaXRqOUluSTRReGs1?=
 =?utf-8?B?TkRDdkh2aHJ0ekdCdGZQS1VMOGdqQVFYbzJHbEJEeHpaeHdqS1ZHRHQrTEtT?=
 =?utf-8?B?dWRCenNTL3JCb2NHRTBmaEM3cWpWdzNPdGNhRGJVU2NVZFB6ZlRhbVoxcnZm?=
 =?utf-8?B?aXZpL3BuVFZPV00rMnV3SDYydkpENXE4RVp3QTBpT1B4MmR0SEgwWVRaM09L?=
 =?utf-8?B?NnVxd1pSZ2pFQ3dFZ2RiNmJHUzQxZ1ZpbnN6Q2p0RGEybnRZQ0tycnJuNVh3?=
 =?utf-8?B?NzF2UU1sU1dWekZxZXlyR29RL2JNUDR5TjJoWXpXam9CWlJKMkRFK1FaVHlo?=
 =?utf-8?B?U24wMml1Um9SdVdRN3dBblplYkZXYVdOWlpieDdiazBhVUNKemgwNzYzS0lW?=
 =?utf-8?B?VVNwcGpvYVVlWDYvQllhczdqT0ZYT2s2c2FmZDZEb3AxNDlhSWd1aC82Q0RD?=
 =?utf-8?B?ZkM4V1MzZFpEY3U3WGxYcmFNNDJTSEJCemJBeVpYRHhKa3l3YTVpYjR0UnQv?=
 =?utf-8?B?SzNUcG5Zc24zUlNDenQ4S2ZGQTVVejFJN1BEODJhTEwvK2hzSDZzcVFJWmZm?=
 =?utf-8?B?dHByRko5SFpObVdHV0hzNVVqNE11V2tOOWo4K1dYTXNmL3lBT1MzNVVFNk1i?=
 =?utf-8?B?MFdRVGJDN0Iyb3Vyb1JNTlc3b1F2bUFscVZ3R3lMbmFGRW81bVBQNHFNczdI?=
 =?utf-8?B?bFpxSEQwdmFUa0NaaUdIekxwMllOTlNCVk8zb0hJTjQ0bkJwSzdBMmlEMVhV?=
 =?utf-8?B?dXUyZlRQTmRyYWMvMTRqOGE1c3pGTXkzaC9UQVl5TFNFbVZIVjE3eTVvRytF?=
 =?utf-8?B?Zk1hOHg4N2JmeGRNQmUwcFJQQW9OeFpUVEE4Z21sc3Z3cnFiSi9nZ2xzY244?=
 =?utf-8?B?SERnQ1BZUHZ1ZWxJblNnWktZVXV3enFxRkdaWkorUEhBa201WVdDd1JGWHVa?=
 =?utf-8?Q?uyS4DjXR/K5wFD3uRW4cCljlg?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d93259-3e56-4f01-9444-08dd97afb3b9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:04.8205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWHkvQ5eD3vMvtfInPLTuydw+PdL/9Qvi27LywEbMtk9BpO/uk8OKWLKwZQCBmOrD8+Z0beR/1DEiW6es1pT8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfXwu1Ury6ye3AZ
 57UJfQg7NrDSxxeIhFqHm29myJMT/I4YJT7hnWIeDbZGyrvpXVoJyWYRQPh5OrimCUikaS6iYnB
 4ai+2TXCoT58Y81QyehKay3vHLYGzHprTRxP/HqW+bfDV+HzgCGM1edYj9JXkyvdYolwkxRB7ZR
 6LL7yMFn+CmUPIUQemLGC90ho9AMpCMBlBJWiUBoQnanp/OkARTH1pD+SaXOxaY66XiXjkI3GTv
 1cL3L1J1g8BNIhQuoRtksZxT6fbH3INelN64JtQUTBs/QKE0ZZDP5L0rHkcTHtMIIbzOjSxEcUY
 mQzyLwGFDZ1SV9I6duWckwvF7FtlyordUaHup5PyVOb04w22STwcmYZX9xpd6JoBZjyZdOc3iYB
 BisniFJEfBT/EJhDD1GECRh6UAmY+PSn8JXZF2dZ0KVJS3EmWdBUZd5DtrJwYyRGXnihzUQR
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a22 cx=c_pps
 a=6L7f6dt9FWfToKUQdDsCmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=9e9T-0rTUHAn1w8HAtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NZmconDRMKRa3dBSC8rma82KxkOp_ja3
X-Proofpoint-ORIG-GUID: NZmconDRMKRa3dBSC8rma82KxkOp_ja3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Add support for getting basic device information.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     | 23 ++++++++++++++++++
 hw/vfio-user/protocol.h   | 12 ++++++++++
 hw/vfio-user/proxy.h      |  7 ++++++
 hw/vfio-user/container.c  | 10 +++++++-
 hw/vfio-user/device.c     | 50 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c      | 12 ++++------
 hw/vfio-user/meson.build  |  1 +
 hw/vfio-user/trace-events |  1 +
 8 files changed, 107 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/device.c

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
new file mode 100644
index 0000000000..f27f26b479
--- /dev/null
+++ b/hw/vfio-user/device.h
@@ -0,0 +1,23 @@
+#ifndef VFIO_USER_DEVICE_H
+#define VFIO_USER_DEVICE_H
+
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "linux/vfio.h"
+
+#include "hw/vfio-user/proxy.h"
+
+int vfio_user_get_device_info(VFIOUserProxy *proxy,
+                              struct vfio_device_info *info);
+
+#endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 74ea2a94e6..648badff46 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -115,4 +115,16 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DEVICE_GET_INFO
+ * imported from struct vfio_device_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t num_regions;
+    uint32_t num_irqs;
+} VFIOUserDeviceInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 33e8a4d83b..9c6b2cdf35 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,7 +15,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/queue.h"
 #include "qemu/sockets.h"
+#include "qemu/thread.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
@@ -99,4 +101,9 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags);
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 2892845b4f..6f0eb86a75 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/vfio-user/container.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
@@ -144,7 +145,14 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 static bool vfio_user_device_get(VFIOUserContainer *container,
                                  VFIODevice *vbasedev, Error **errp)
 {
-    struct vfio_device_info info = { 0 };
+    struct vfio_device_info info = { .argsz = sizeof(info) };
+    int ret;
+
+    ret = vfio_user_get_device_info(vbasedev->proxy, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "get info failure");
+        return ret;
+    }
 
     vbasedev->fd = -1;
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
new file mode 100644
index 0000000000..e081033ff1
--- /dev/null
+++ b/hw/vfio-user/device.c
@@ -0,0 +1,50 @@
+/*
+ * vfio protocol over a UNIX socket device handling.
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
+
+#include "hw/vfio-user/device.h"
+#include "hw/vfio-user/trace.h"
+
+/*
+ * These are to defend against a malign server trying
+ * to force us to run out of memory.
+ */
+#define VFIO_USER_MAX_REGIONS   100
+#define VFIO_USER_MAX_IRQS      50
+
+int vfio_user_get_device_info(VFIOUserProxy *proxy,
+                              struct vfio_device_info *info)
+{
+    VFIOUserDeviceInfo msg;
+    uint32_t argsz = sizeof(msg) - sizeof(msg.hdr);
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_INFO, sizeof(msg), 0);
+    msg.argsz = argsz;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_info(msg.num_regions, msg.num_irqs);
+
+    memcpy(info, &msg.argsz, argsz);
+
+    /* defend against a malicious server */
+    if (info->num_regions > VFIO_USER_MAX_REGIONS ||
+        info->num_irqs > VFIO_USER_MAX_IRQS) {
+        error_printf("%s: invalid reply\n", __func__);
+        return -EINVAL;
+    }
+
+    return 0;
+}
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0bc12da865..34df9bba7b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -42,10 +42,6 @@ static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize);
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -613,8 +609,8 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize)
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -785,8 +781,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy);
 }
 
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags)
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags)
 {
     static uint16_t next_id;
 
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index 695b341547..19bdee688c 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -1,6 +1,7 @@
 vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
+  'device.c',
   'pci.c',
   'proxy.c',
 ))
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7a3645024f..6b06a3ed82 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -6,3 +6,4 @@ vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-- 
2.43.0


