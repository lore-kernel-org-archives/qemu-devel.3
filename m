Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741D8C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 22:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsWI-0004Db-EP; Tue, 29 Jul 2025 18:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqku-000176-LR; Tue, 29 Jul 2025 16:17:02 -0400
Received: from mail-dm6nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2415::61b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqks-0002PU-9W; Tue, 29 Jul 2025 16:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovH0/7Vj2zXz2TbZcvzdNh9wsFmqmsFphewSNNZIydHWUyfodFmccfK0aS7Y9I2AmiUz6EIhND1jy8oGxycxUNufphYJ9fqJikFqiD9IX2Ux0TV1K/g1vzqlN9zVMwFHBgSu0NW3t5rs1jivP0NJyiWyYEAFgir+y2XPVZHDJfmgReDvei72HjWod/SVe6qyqvDLSu6rQcgstMoZCQUBb9bQL/ULLLGO3YKH9YD+I9F1nlaVQZ73izA51ZDMMfsmbWQKF4HP3gvDW4cesKG5ZbIUKWgzMxNlE1rZDgovKa7smUJuo4+kuuDiInVQqTq6Qr24DeUD/Cmu6kaFALCdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2u0By/TW3D4wz71T0bHT8QfRudONA1Vba9MmGXVL1w=;
 b=UxLgGqzVqFgApvSq+NTn6E8hZLqKa6hK0auIQscZOEpYjppZnNPDhnL5ClBI5czLudgTpPYS682FKxcohgRye7qlOF6Z+JB9oDA3sxQ6WoRhUr/gr0m4uPkAfQxw58Ev8jSrs42lPmO46pkacbkLCkFFLIcMtd/vDK5ZiXBx5p3x/cKACvP2bKdBy1o7tROcKmBcmwiCYjdN9Trvt6wGRRNwE43fqhEWUDxJDbr/Gv3esMzfZJcwLH5ENtkm5ptXkd9mRN4UqqUTUdpDMhTzuVbqyU7Vo76QPE3jY5UY9P86d3B8JY7sIpsxfdevAiCUN78GfjOj7yypuQEFlK5WJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2u0By/TW3D4wz71T0bHT8QfRudONA1Vba9MmGXVL1w=;
 b=qfmuiOateJXr9T2FNyemH08grq3Qo7WCgZrFA0q/5jemeivw0fxSbh5DcD8FSIYxV+E4cHzP6ZPTkRybgWY+WiLSI6oMHgPABgAYjk0Ae5lqBoCameH9jOdKxJRzAsCjJ5AZXQzmMu9L3RYVtD6fGZ+TzUGSI7OOEeHzG8kOnNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 20:16:52 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 20:16:52 +0000
Date: Tue, 29 Jul 2025 22:16:46 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 23/48] hw/arm/xlnx-versal: instantiate the GIC ITS in the
 APU
Message-ID: <aIksLh05woUDIsng@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-24-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-24-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 924a4446-8eff-4bec-5ac9-08ddcedcdb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y25XcjdGWUh0YXRiOCt4Qk9WNDBYWU8zSUxEN1NvMWM5c0t0cnpEa0dydG95?=
 =?utf-8?B?Q0txM2RueXdQbVFadHhYY090K1lzTkdJc3RLNUFFbjdIcVJTWFoxeVIyTW1q?=
 =?utf-8?B?VzBkWlpJdFhNazR5M0hGU1dDR3lNRmtJR3NPRFZsQ1N2S2c3VVQwc2kyc3Iv?=
 =?utf-8?B?bGhINjBCb3d6aDYrTElGbjBqYUNGeXNWb09oRU1INnZ3cG93SFMrTkpTOGJj?=
 =?utf-8?B?V1pCUGcwYzZ4UXVDU1VvbHVoZURrY1Vxdm96WHJ4VW9FYjg0ZTE5VDBOeGha?=
 =?utf-8?B?dFFlZTV5ZnlUdE91OHVpZzVVb1NDYmRrMkhBVlJMcklXWFJNM1ZxckFCLzYw?=
 =?utf-8?B?UVpIY2FsMGd3S0JFUG5HTmJkVzF1L1BGVURrRXBmeWZXM2dycmt3MTNzSmRZ?=
 =?utf-8?B?d21pdjdTOG9iZnJXeDIwSE9IbUVtZjRkdnE3aHhhWGR0SVNwd29GL251WWsw?=
 =?utf-8?B?NlpVajM5NXNhL3pUQ3ZTYzY4a2RvdDFxYU9nbndwdE1ZeW1HQVlDS2lHc0w3?=
 =?utf-8?B?NHFLbHBpUkRjR0drT0czN2VWeU5RZ2F1L1ZBZ2FOSHpWNTNsL3g2S1hMNGUz?=
 =?utf-8?B?KzNRMHRNWkdUcm1sWDVnOGJhdDZMT1BoWjdVMWc1cGVRWUd6MVdibTM5dnVC?=
 =?utf-8?B?M3QwNVZMSTI0aE1mNVZOb2xRU015RVgyZDNYL2RScmRVeVVhNWpGYnVIWm01?=
 =?utf-8?B?VzJNS2RqYS9WU29KK2tJUUpYcHJKRHo5b1lmQUlFYkdNN2RQS3pSUTJhS0RC?=
 =?utf-8?B?YVR0dnh0NVRDcTNDaytnVGM3ZGxXWkY0NEJTbVdzL3hTKzVxelJhNUtwOTBJ?=
 =?utf-8?B?OWw4K3NEckZrc3pXMkFrVE0rK0tuKzVZTkl3VTUydnRJSWNnRmtmTDU3QVdq?=
 =?utf-8?B?QmpLMGhUZEYwSjhXQWhGbjZsZndlMmFNcXZMNkFvU2QvdTVidTIwWTJNV0VQ?=
 =?utf-8?B?VHlrMjhQbUlmN1hGcmt4Wm9lanZaR2VXaXU3aXl0SjlReXlRcTZveWMvajJR?=
 =?utf-8?B?eHllMldWejRsVzNTci9sR0gyRGFvR0JxaXlvc1NCZUxBTjJzZlorSk9NeEd4?=
 =?utf-8?B?bldiTW5tckVaZkNGbTlYQjA1ME04RkdYSWVTN0V6U2s4Vm5HTEJIY05nR3Ft?=
 =?utf-8?B?SzEzNldMQXNIM3d3NEFNUDdyd2FoV1JyQmlGV1JoamRiWmlkLzZsWEl0NzVm?=
 =?utf-8?B?aFpUZWc4RUpVVHpzblRWSlZJMFo1VTBaTTk1SXFFQ1ZQd0dYUEN6UnFmazFW?=
 =?utf-8?B?dDkwMlZxRFo2eWd1UE9YQjNjdjlhcnBTT2dWQkdlTW8rcU1ybWdZUjJjY3BD?=
 =?utf-8?B?MUVjWlZuajFUVk5LbmRNVUZHT1cvOHZaYmJZM3h6N3o1RmpxeC9wQ1FVRjJI?=
 =?utf-8?B?Ym02cEtJUktvRTlaY2VZZlMwWTl1dWZ3eXFtRDVwcUVuOEJJelVjSUlEM3hl?=
 =?utf-8?B?Y25SSzMyak9yVTdMUS9CSUs1c3RNMnEwbm00T3U4VitWNDhTMTErL0sybkg0?=
 =?utf-8?B?V2N3d1h5U1lMaFBxRXpSOXJubUNPRDNuZElvdHBBREtzUlltakllWDBXVC83?=
 =?utf-8?B?YkFZem02NUljUCs1QjlWZ3JoQ0kxT1h0M3p0WUJ1dVYxNmRibkhMQlFFRG9S?=
 =?utf-8?B?MnJnU0ZvQjFNb2pPNUVUa0wwL3hrTmI0MTdGVWdINWt3K0ZGYndzTXpEY0Fs?=
 =?utf-8?B?eTVtRVMvWWV2K0pxckE2VVdIVmdmQVVGWXRkbExiVm9OdUJpdDBrMDRpRktT?=
 =?utf-8?B?RUdOYVhscnRsd1RocEpWM0Z4T0gvTE9PL0p3ZEU2ay9QdzU0clNCR0c1a2py?=
 =?utf-8?B?Y3htaDJpcnZtVkltRlEwTFlIb2tBcU1BeXVrRmJndUo5UkYwOUh4WDliWm52?=
 =?utf-8?B?eHdIUnhJVlhPaFZSK0pqc0hwdEt0Z2V0UTg2WEJaUjBUd1l0MzJOVW8vbDhQ?=
 =?utf-8?Q?lWJ3w1fuWbM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFpVGJqYmx6NkE1RzRqcFA2SzAvLzNEeWc2blZnckllVGVKdTlqMytabUto?=
 =?utf-8?B?OVMzMDdCSHJtR04zMVdpWnJLRVBGUThPcUtuQUlnZnRrcE5MZEt4R08wd3Ez?=
 =?utf-8?B?UmZObk1lUFY3eHZaWlVsT1kwNlVNWi9WVlBWQlY3d2sycFY4Q0s4WTJ1RTZ4?=
 =?utf-8?B?OVM5RTRRcU9ZaE1jaVZ6RnF1US9sM29ZVXE4MXQzOFhXeTZkTDlBYW5pQkFG?=
 =?utf-8?B?VGh2YS8zZHhJWk5LdlM1WDZVR3VYMjZXOWdLUHp2ZElQLzN0a2d2NHpFcmFi?=
 =?utf-8?B?dGhrSEZpOGxMczhxdGZEUTFUV0p2VEdSMVFmdVJOSzAxMkJzVlB5bGV1L2Y3?=
 =?utf-8?B?L3U5WktMUnRhNWFubzZkN2dkUElhbUdyQzg2dzEveU40dENkZThRTTRuWC9P?=
 =?utf-8?B?VEVvUklxd3dPNUhFSUdJa3ZuOVN6emRadnFqUVU3enlMU05IdExLOUxVa0s4?=
 =?utf-8?B?cjRaVzZ3Q1JHYklHTm5SNnZnZjZJV1A4QkZYeWF2eE1CN1NqLzJSSDA5eU0z?=
 =?utf-8?B?K1hIcFArMFcwUHhFZEF3Z3RtYUkxYVNEeWtHWEZWZk5NdG5WS2NyS0FRV3B3?=
 =?utf-8?B?dFUzUnBISGdWaDJNVU9XbjZhRm4yNnZSMDM0YzZjQWd5cG0rMXJYL1MwTGpt?=
 =?utf-8?B?VUtQTlpJeWpWekFPRFkwRmV0aGh1SnJCaG54anJ4Sis4aTFOdTBDVmlVMXN3?=
 =?utf-8?B?UUNOU2tsQkdPTFc4Y1FYMXpCbTZubzk0OHRSbXYzZkhQY0lyeWdOVnJVcHhZ?=
 =?utf-8?B?bFBLMVB6WXVWMjNhaXMwUmxqZTJUdHJoNTFtU1RZVWFqL0o4RDUydXFmajNL?=
 =?utf-8?B?WUs1UUU0NklJZ3FMK0RHdWs3UmhyU29lanVia1prNVRad1dsZEVTQmVvWExx?=
 =?utf-8?B?K1lpK2VVcjFQbmxQSkp4aXZieUtpMnlXOHRsVURHMURVUEJZR1JvWjlydjkw?=
 =?utf-8?B?clV1c2FyVFJ3a05xM3duL2Y5eEhUUG82S3V0bDA0V3M3OThvZzFRQnJKR2lU?=
 =?utf-8?B?cVlYRUpWUmxLOWZoUEdPZGFzN3BuRmJLQVZac1BNK1EySXNZVUxUYjUzNnFp?=
 =?utf-8?B?VFVZN1JHMjA2cy9sbzYvWlk3TVNsK0czMzIyeSt4MzBqaG5JYjBPNXBWNDRT?=
 =?utf-8?B?cHBwTmJaSHRGaWgvemlURmJ1UmhQNVp0VENMVmdWLzB1UUlXdkNLcnpKYTRE?=
 =?utf-8?B?K09xRHFzT2RhUnEvMUlHQ2h2dXhRWFRlQWFiTWhsNDB1aXJydVAvUDB5bzVn?=
 =?utf-8?B?d1hxYVNzdi82ZlhqQlZXcHh0YlZIR0dFdW5QUVV3ZkpIUHRoUm04NDRncWRq?=
 =?utf-8?B?WFpNQ3RSUHlwSEFtaGtUSXdScm1vZVVENERSUVplM1dkaS85Sit6ai9QT090?=
 =?utf-8?B?TDBuNDRxRXBlUGw3YUl0LzdjeWhaWkpESG9nS3IwVldLakRVNzFxdmJIMEZI?=
 =?utf-8?B?K1JKT3VtTHJnMDBNekJnRFdmQU1yRUpVTE1wTTZ0LzI2bWo2d2NERHM3WVY4?=
 =?utf-8?B?K093eFNwSzU5Y0dGUnhNWjVpQWs0S1IvTFd6aEE4V0NOL3VlZU1XcU05ajBl?=
 =?utf-8?B?ZjJzeER2NS82ZmRteTh0aXlJNmdVTTl0OXFyMnJzNWp4Qk91V21wQ3FjVVpC?=
 =?utf-8?B?ckgvQk1rSFUyajN2Q0Z2STBrVUlxeXhMTGpBSms2R1JkUVNKM05PL25ycWFG?=
 =?utf-8?B?VUtBQXYrMFpYbnpiYVVsSEorcno0cFZNNEVra29sSHl2U2lFV1NBYVFQLzEr?=
 =?utf-8?B?V2JNTHNtSTlUbWRPVXBLQUt4bEIydW9sTlpJK1hTMHNVR2NvWU5KWU5Hdmto?=
 =?utf-8?B?U2EyV29KVFdhRmx2aXV3YnNVeU9NcFZhaTRjV0RoRmhQOU51R1NPR0hCT0hE?=
 =?utf-8?B?VTdxVXhOMGxadHl3ZlhKdVBjOVJoUnJiTlIrQjF4dG1idWJUTDhua084b3VQ?=
 =?utf-8?B?dzNjTzhMM2JNWk5KS29yZGtVMmR0OXFQUDZrNnpJa0VKUGRNMnU3ZGtHYVVR?=
 =?utf-8?B?ZU5RNWtWajFmZEhTRUl2UHdQeUUxKzF2aVFrRXRmNW80S01Qa2JvOTVkTGsx?=
 =?utf-8?B?cDM5YW9KazJ1MHhtNXEwSDliVUhJbGtXVnZnaDh2dUxKM3ozUGJ6ZlZNQjB1?=
 =?utf-8?Q?mqJ1t2N2ICSIA0hP/YfHYfHlE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a4446-8eff-4bec-5ac9-08ddcedcdb53
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 20:16:52.7704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uUmuj2t9QquF/dmOXtQcP0K3vua6QtP5vgYmbORajZP13Emdsv8CmSeOs/eannGZ+abmeLFsGKderO48hWVLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
Received-SPF: permerror client-ip=2a01:111:f403:2415::61b;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 16, 2025 at 11:54:05AM +0200, Luc Michel wrote:
> Add the instance of the GIC ITS in the APU.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/arm/xlnx-versal.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 35c32de0159..ba8c69bd435 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -42,10 +42,11 @@
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "hw/or-irq.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/intc/arm_gicv3_common.h"
> +#include "hw/intc/arm_gicv3_its_common.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -70,11 +71,13 @@ typedef struct VersalSimplePeriphMap {
>  
>  typedef struct VersalGicMap {
>      int version;
>      uint64_t dist;
>      uint64_t redist;
> +    uint64_t its;
>      size_t num_irq;
> +    bool has_its;
>  } VersalGicMap;
>  
>  enum StartPoweredOffMode {
>      SPO_SECONDARIES,
>      SPO_ALL,
> @@ -216,10 +219,12 @@ static const VersalMap VERSAL_MAP = {
>          .gic = {
>              .version = 3,
>              .dist = 0xf9000000,
>              .redist = 0xf9080000,
>              .num_irq = 192,
> +            .has_its = true,
> +            .its = 0xf9020000,
>          },
>      },
>  
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -452,10 +457,52 @@ static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
>      memory_region_add_subregion(mr, 0, root_alias);
>  
>      return mr;
>  }
>  
> +static void versal_create_gic_its(Versal *s,
> +                                  const VersalCpuClusterMap *map,
> +                                  DeviceState *gic,
> +                                  MemoryRegion *mr,
> +                                  char *gic_node)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *sbd;
> +    g_autofree char *node_pat = NULL, *node = NULL;
> +    const char compatible[] = "arm,gic-v3-its";
> +
> +    if (!map->gic.has_its) {
> +        return;
> +    }
> +
> +    dev = qdev_new(TYPE_ARM_GICV3_ITS);
> +    sbd = SYS_BUS_DEVICE(dev);
> +
> +    object_property_add_child(OBJECT(gic), "its", OBJECT(dev));
> +    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(gic),
> +                             &error_abort);
> +
> +    sysbus_realize_and_unref(sbd, &error_abort);
> +
> +    memory_region_add_subregion(mr, map->gic.its,
> +                                sysbus_mmio_get_region(sbd, 0));
> +
> +    if (!map->dtb_expose) {
> +        return;
> +    }
> +
> +    qemu_fdt_setprop(s->cfg.fdt, gic_node, "ranges", NULL, 0);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#address-cells", 2);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#size-cells", 2);
> +
> +    node_pat = g_strdup_printf("%s/its", gic_node);
> +    node = versal_fdt_add_simple_subnode(s, node_pat, map->gic.its, 0x20000,
> +                                         compatible, sizeof(compatible));
> +    qemu_fdt_setprop(s->cfg.fdt, node, "msi-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#msi-cells", 1);
> +}
> +
>  static DeviceState *versal_create_gic(Versal *s,
>                                        const VersalCpuClusterMap *map,
>                                        MemoryRegion *mr,
>                                        size_t num_cpu)
>  {
> @@ -477,10 +524,11 @@ static DeviceState *versal_create_gic(Versal *s,
>      redist_region_count = qlist_new();
>      qlist_append_int(redist_region_count, num_cpu);
>      qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
>  
>      qdev_prop_set_bit(dev, "has-security-extensions", true);
> +    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
>      object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
>  
>      sysbus_realize_and_unref(sbd, &error_fatal);
>  
>      memory_region_add_subregion(mr, map->gic.dist,
> @@ -502,10 +550,12 @@ static DeviceState *versal_create_gic(Versal *s,
>                                 GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
>                                 GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>          qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
>      }
>  
> +    versal_create_gic_its(s, map, dev, mr, node);
> +
>      return dev;
>  }
>  
>  static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
>                                 DeviceState *gic, DeviceState *cpu, size_t idx,
> -- 
> 2.50.0
> 

