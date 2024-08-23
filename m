Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8E2C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 18:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYlO-000199-Mh; Fri, 23 Aug 2024 14:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shYlN-00017H-4l
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 14:11:53 -0400
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shYlK-0005KM-Tk
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 14:11:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFxC58/6kcROY+6rpdvodDD/TBseBaBiBDyvC1nj4htz9kvD4Q13Hklk7tc9C9P199dY0s2hhHo8bab1NIPkK6AaLrM1EuPQ3XN7eIGWR7URULdBojC4h+9lviGVLwFhF3cp7U+nRk9/69nyRXNPq6hM5GJGwCdSbH7TsiXXG2QkXx6Z6K+S5NbDOqQhMERtsxMOzzq2ljyJKnsFprYVqcHN/oC6Tv1xWyl99w+g75jKCPYqnMLRcXuhNJkHyArd+DujTVvK6MWNNth3jF0kB6pZtgPNXMF2NS0Y7go4U+E9Kfp8Wt+OnS7jWT5il2Lu5hsc63sbX6zyxIp3Arb4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PxToU3zcnFJa0jzSOoyeV/WXhX0pF799xM+k8mkB50=;
 b=ekuWxS70H1KALBB6SuNhVPb6qjAbhT20WW1sPhPCAyz8iRdqC/PZQFVxUMGnFbj+FKpJQMelGL0ZHWZw3coWalOX+wUnxDwv+kpfScxpE0LsevaRRDhTXNpnrxRvGrJMSB56VbdlBLsRK0tpCcoHeibZDFeA0h9t0TedoBRlzk14d3743LauK1wwBT+k29rdo4elNjE+hPApPH1EGDaJiRoVjnzUodcv4c3eJGq6qKqGdzbwAH4/Iw07AMdgrsCLEMBL191RH/rBpiUOPumRstvoyw/TL5hdLut7wzdKuNRgYdm0hg6WC5GRrixd5gt+zXBIpN3eVc9Bx3Cut2Ig0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PxToU3zcnFJa0jzSOoyeV/WXhX0pF799xM+k8mkB50=;
 b=yqsAoatYidfwwOoxcQ71LNWe4dYgf7HgqlT1haqbZaUZnun30jioS/XCEa0xat79Q4iSzCZyxZFFrTcD6s3mGJxblVcym9FSK97wsuXCGwi/EnGo8Lfk8jGPXzMMdU169qQ/sf+1LleFvhdODL/06UKWdVxez8fXDKdqoG0+IBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 18:11:45 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 18:11:45 +0000
Date: Fri, 23 Aug 2024 20:11:33 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Doug Brown <doug@schmorgal.com>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] hw/net/can/xlnx-versal-canfd: Handle RX of short FD
 frames
Message-ID: <ZsjQ1UPTPyIesDbJ@xse-figlesia-l2.amd.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
 <20240816163504.789393-6-doug@schmorgal.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816163504.789393-6-doug@schmorgal.com>
X-ClientProxiedBy: FR0P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::20) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a24259b-261d-476b-20ca-08dcc39f0c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmhZbWpLaTc2RlU3d05kZEhxTHoyV0RHRVZqTUJ0aEJrRXRQQW9nMGtJZjho?=
 =?utf-8?B?a0Z6bHB4MDlERE82N3gwSDFmV0hRMTkwUUVKUmJ6SjdubW9kYU5meXhScGVk?=
 =?utf-8?B?WTR6eXVrVTdWRmR4YzBQNTA1b3NRRDA0UktTTWlNZVJwOFFFN0Q1Q2JJbFkr?=
 =?utf-8?B?QnNMeHZkdEN0VXlzTHZldnMxNkpDaGlpR01BS1FBRWJGWkZDTy9GMG9kcFVD?=
 =?utf-8?B?YkdnNkliZzQraE9JelU0S0R6Tm9aeFJnNzZiZHNQdDNhUXdpR3BnLzRYanBN?=
 =?utf-8?B?TVVKWmpHdEZOaGJsOVQvcVN3T2t4SnR3eWV1YkdEaFBwNkwzMjNDUnlwZ2tZ?=
 =?utf-8?B?Ukd6Skc3VkMzcG9wSHhvMldiYWdXbGp4N0NPR0FZK01XQU9PSXhLc09qY0ZT?=
 =?utf-8?B?OUk2TmxvMEdvNGN3SFVMR25ZVHM0bWlZWVVjY2M4eC9UdWtOUFJvMXJtTDdh?=
 =?utf-8?B?RFl1UVZzMjBiRWY3NnhOLythbHViS3hDYWxWbXMyNW9tMzVUSUtrRFhTalUv?=
 =?utf-8?B?Q2xGVWFET3VtZHR4M1dhRUk5WE1ldFNTazQ1RDhnR09iODBGSkZRTXBJMzhM?=
 =?utf-8?B?QzQ3YUV1TWJQaUxlaXVVK2RJVVlXV2NWWUErSzRmYUpQZFJBOTJZUW9JT1JU?=
 =?utf-8?B?Q2hYOW5ZODBKNFYwZmZ1bmNGbzRqMlFNa3YyYU80aXR4RGx3US9yQ0JzWWhE?=
 =?utf-8?B?blljKzY2TUJzYXIrK1ZKd3JCN1RLOGpZRHlnWndEVjB1cDByZGRkMDRwSkZy?=
 =?utf-8?B?L09TakFGamtrbTJXcUQ0MDM0alJFWVU0cnJlc1JqWkpMTUtHOURYVDc3azVL?=
 =?utf-8?B?d3RldlBEcHR5azdxSGVIZkJhaDlQZkUvMEZ4TWZPSVVaY0tkNURkTTZQUnBO?=
 =?utf-8?B?WWwybmRRTzF5ZlNvdUtPWWhxTzh4cnpuU3JNdjNSd3NtSzBka1RyZDErMTJk?=
 =?utf-8?B?dWJITUY4aW5vbnRqM2RDNnZWNFNvdmkzcEtmV3pPUERpNGRYRUZ5M0hoQW9m?=
 =?utf-8?B?b014Z1JFL0xDVmY1YVRONm94SS9VMGxLUmVUN0ltZWQwdzFNU0lINE9PYXBp?=
 =?utf-8?B?bFJPeGlFMm5LcU5vejNQbFkrZWJvYVltY1dqc000QTZ2K1R6VWprWm5EaWc3?=
 =?utf-8?B?SktaRjRyNUI0WDVqakRCM3Q3WkJjc2ZTWnpOczhnTjk0UjRiN0tEUjNtYmIz?=
 =?utf-8?B?Qmp5U3NPTFBiUkNPa0hJbktIMGZtWXlMcE0zRC91djZXbjBNYmRnZFdQMUVR?=
 =?utf-8?B?bnNJcmpjZ2FqM2I2NDNxbFZHS2UwdGszdVEwdWJqaXJOQ2M3OURmN3lXc2o0?=
 =?utf-8?B?MGMrY2xER3pzTk54K0JtU3F1SzVuaW1xUEZJMHdWUU9EU2xrUVpvaUc3UTNZ?=
 =?utf-8?B?RzZzajZuV3hIWTNSQU0yQTBTREV1R3hPUHJXSnZvR2pkWXppZWovVm8rZlFl?=
 =?utf-8?B?anR3QmdadjFpWFFscDNiOStxUXVQejMrTWNiZnhJS1VXZHVERTNKN3FlVG5u?=
 =?utf-8?B?ckczamM2NXlZa0MxMEU0eDU0Ryt3bnlvT3BmdUF4N3gzRlJjQmNKTTc4UUFj?=
 =?utf-8?B?RTNpSjlVWkpFSFkrRVczbnRRZFJIZkZLdmZ4bm94TWJGYldXTU9DdXNSTDBx?=
 =?utf-8?B?c1NlM2d5dGhLcXlTSHg2bGRreDUwOGFNeGVSeTFXM0dTa04yalRuMldHWE5M?=
 =?utf-8?B?Q2lMSEJyelFRVW1ESWplM3EvYjVaWVUvTjNEeXVBbmVlSEk3bXBROWFqVU9p?=
 =?utf-8?B?WHA2d0xPTS9sZEVhWC9aZ3YyV1hMaFA0ZHhLSkJZcHgzZEp3dGxvbi9JVFVH?=
 =?utf-8?B?Ri9oYnV0dzBFbHhMcjQydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGphaGNHTlpQWmpFWUpPSFlwUXVLUDQ1R2lNOFg2WEVRb0RhUWsrRUVyTEZn?=
 =?utf-8?B?a3MxUlUzdlROUjk0TGhTWTh1Z1VaRDQyM1YrNjlGVXFTQjNSOVBrUXh0UzhE?=
 =?utf-8?B?SW5CZkRoTlhjTUowY1RJK0J3SjBiQnYrZ01PZGwzb29XMFRubVhFTEtZVXdU?=
 =?utf-8?B?cS9mWmZDM0E3VVhIVXFSWGpDS3BrQVdqdXNjNHZraGsvb0FQcFpUcU5ySWEx?=
 =?utf-8?B?V0VnUHRMSzR2SEl4emVRSnRpVUo4LzVTUXZrS3RBeERJa2NMczNsL0xHODdp?=
 =?utf-8?B?QStWMFdianVURS9TcDJXK2RPWlYwc0lsUnQvSkdLbVh0elpYQUg4ZTJQRUkx?=
 =?utf-8?B?TmxzbVpQNXdEcko4ZlIrSWR5eGgvWUJpbThhemtZeUVjQ3d2WWUvYlo3MERT?=
 =?utf-8?B?cDNDMnIvNEFJTWhsUno5Z0JyK3FPUFFDZGFhMnlucnYxRzlFR0lhNENpcnZD?=
 =?utf-8?B?d0VxMTBiUGNBZ0g1VlhEa2w4L09qNkdKMCsyU0JYMWJNL3JLclFNaTQ4QzhV?=
 =?utf-8?B?czNkV0NPMStKWCtlZjVCK1d0T2Mra3JIaFVDaVBHUndOekF3NFdnVEtvOUQ3?=
 =?utf-8?B?c0NiUnhVdVJxTHo5aGZObmtKbTV0a0VIUmcyQWdteVNmYk9jV0E1SzZFK3dE?=
 =?utf-8?B?MUlEMGgwWDVjbTk2VEhoNm1HbmhlMzU4bmNnUTljZks1MlJ1eGp2OEhGZ0Q5?=
 =?utf-8?B?emQ0YnBlMVIyMFlYMU9xQjVJd1hTdlF5aWpUYXZwMFZ3ODJSbWh5QmtGcTUy?=
 =?utf-8?B?YnhELzlaTzBNMU5adE00bnU3M3hxcXZkcjMwMy9NYjAxZ1J3cFFtR0RJa3h1?=
 =?utf-8?B?VEZ0cnlqTUNkczYvWUF5US9sQVJ1VW5KWjM0aHZQMGRnNkxNd1pnd2JjTG1h?=
 =?utf-8?B?UisrU1dBR3J4WjZHOCtxNWc3NzhDSmtTb0lLMzBWV2JyM2h6M1NpRjdsVWFI?=
 =?utf-8?B?VlFPVHZxMUtGd2l6YWF1MWdwcUlWVDd4bm91c2ZuUllOdWF5VzY1VEt2bHV6?=
 =?utf-8?B?a2hUdXVCVFo1bWhKQmxjVzh6Q21HMFVKeWU5MGFNRmtsM3ZhZXJyVTlHdjl2?=
 =?utf-8?B?b1pNeEdSWjRjSDZ0aHdYczR3blhYdVJjdkUxb3lEdGtid2RWNGRvNG92UURk?=
 =?utf-8?B?dWVyWUpObGc0UWMrNHJITks3T1U4U0NmVVV2YVRDQUwrYVFTQWZNYkJRazlv?=
 =?utf-8?B?cThYYTR3ZlFOcHh4OEhBZE9odkMzRnZRRi84YWNaamRybkdINXV1MzF5bkxz?=
 =?utf-8?B?MFFnaFhJa0t2NktoL2w0L2ZQQlZlamVRVExjb2dsYVd0anhnUHBOR01nSFpR?=
 =?utf-8?B?QzRRT2RXekp1S1EzamcvVURGS2xsbnR4TENHYWFKK0hWaGdGcHVORk5XbUFi?=
 =?utf-8?B?UG5UWmM4d1kzUkxGUDN0dEkwMlhZb21XOS9iK3pZQlVsNnVFeGJ0Uk5qdFVv?=
 =?utf-8?B?RXZnUWhndlhWU1grRjNTQk4yZGF5cWcrTDJqdmdjZVZnbUNXbmNjSXJ3R3pJ?=
 =?utf-8?B?bHd2ZTBlOW9XWkYyZzluanp2SE1Gcm1QTktHekNsaTVzTjl4KzV6a3lncUlm?=
 =?utf-8?B?K3Z5MVhhMHBXc2hvT2Y2T2ZwOXdPSjl1aU1zYXdGOFRxVEE2cW5kT0lNU05t?=
 =?utf-8?B?R1Nza1hUTEE2RHJad0lNeWlVZFczM2E0RGZPSURaSWdLa1pWUWpZd0pZRTJN?=
 =?utf-8?B?eGQzdmdVL2FkWXRqZ3B6dlM2dk9GUjBjTkJmaTB6OWdKTC9xN2dXSEJCL2l0?=
 =?utf-8?B?dW5rR3J5TVRldGlZeVQ5amMzZm9HMTVCQ2xWT3VzRjFKNHB1clpNUGF2eGxV?=
 =?utf-8?B?NkRkL3NhOFh3aXVkeTJqekpreWdiV29vbGtXbTlqd0lzUTlMYVlFbG95WXRl?=
 =?utf-8?B?ZDdmYUh4cWRMOU1Nd1ZSb3RuSVY4b21LOHJyM1ZJVmF4MHovUzVNUENEWmVG?=
 =?utf-8?B?M1lnQW10d3lCWUZOZWI4Q0gyUncyd1lkRmx4cXBkTk56U0VUbnRBWklldFlH?=
 =?utf-8?B?U1pqVUtoNit4ZjhuT3dOSVpRK2RLOG1rcGNlOVErUE83UDZUZXlMM3ZIRkdD?=
 =?utf-8?B?R0pFbEcvck9aekw5c0V4aFZZdXJRNFdSRE52cVc0Q1dsbjNaUHp4VnBHdXhT?=
 =?utf-8?Q?bV3CXZhZXSrNg4aFh01mYAn1w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a24259b-261d-476b-20ca-08dcc39f0c05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 18:11:45.1506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za1JDU+yz9UnCNCfVY5rQbLKmbLRFdsueYfVgDJd180b2SFg2d89j4jHhq3PI0Z1vYQr5EydXyHacyC7FI0f9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
Received-SPF: permerror client-ip=2a01:111:f403:2417::62b;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 16, 2024 at 09:35:05AM -0700, Doug Brown wrote:
> There was no case for handling received CAN FD frames with a DLC of 0-8.
> This was already handled properly with TX. Add similar code for RX.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/xlnx-versal-canfd.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index fda1e7016a..ce68dab46a 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1052,10 +1052,15 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
>          if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
>              is_canfd_frame = true;
>  
> -            /* Store dlc value in Xilinx specific format. */
> -            for (i = 0; i < ARRAY_SIZE(canfd_dlc_array); i++) {
> -                if (canfd_dlc_array[i] == frame->can_dlc) {
> -                    dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, 8 + i);
> +            if (dlc <= 8) {
> +                dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, dlc);
> +            } else {
> +                /* Store dlc value in Xilinx specific format. */
> +                for (i = 0; i < ARRAY_SIZE(canfd_dlc_array); i++) {
> +                    if (canfd_dlc_array[i] == frame->can_dlc) {
> +                        dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC,
> +                                                 8 + i);
> +                    }
>                  }
>              }
>          } else {
> -- 
> 2.34.1
> 

