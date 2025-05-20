Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB814C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWj-0003Jh-BX; Tue, 20 May 2025 11:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWi-0003JQ-Mj
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWf-0002eq-Kt
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:08 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7UjtJ019012;
 Tue, 20 May 2025 08:05:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=x1RAiF5oWjlW3doYblZCC83ximlzoogokIoaTE5L9
 zo=; b=vVPgISheB2qsYQIMEDzdEkH7VlBCgZruRgFCpTl/YsxTP92J33wD4cHRo
 s1g4SxS/E3oUk5dV12jmbQjGUF9dur7djaQCwpZeSnOuml0qVyQF+9RcrYOwJyNw
 fqBXQ+FWh/Iy5z4XFy3V+HuAwHDZQU9APQvnY498AtAASzGA9DAWFN8KYGBrfTgZ
 SITkasQGNQbaLyeSuiijn0SCg7YBlUVfBSvpdRUeNdJJ9ETiTAkqw57c9XZhLTjw
 KDB6OgkqoQ+wBoS9CQH+WUApont3Pen9/ei0kxvUn1KPDzrxquoLBss5B/eDpYOr
 zk+PPEDKd+aeKvE56Je/93zJdyoHg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhebwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rInFvmYfAKHt5bS3ztQbdn9rQDr4fXyPJ9ZVmBBsJayKLtmfXwFpS0eYYRVxGxXVIpyCFRc/+dvWk3cOYEnB/cesd5MP1/7RWt39dnz+YlrwxF+GNCSoBLIxgNpBdY6dS+gnyBofAbbq0mlaIFGOf7SgfGp540T8kRyUa4NP+C4ogf91KpB0l8/x5KUO7NgNCUEl4RbhOl5NzETySKr4nYKIkGMTSPL625sPzzqkNNrStAYHE9CAEqwJ2f316EqGZOsX6fMXl927RjhbLhXDCaMuF7rhXXGGu2bZmPj24hH1x1DAptcRQTEVfnqs8CVbBsB2C+dXPoIoncDROJDyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1RAiF5oWjlW3doYblZCC83ximlzoogokIoaTE5L9zo=;
 b=ozLISRPguzYFYISv9/ArI+UjbcmNwODG5Srt7PSml549HkrOujM430VkyU4hIcAZaRyyZatQVJwKeskrNywfhb6ij+Z0kxfUAriwVaRIGY9r47cNRFaVJE2l1oajH9RluQ6jD0pGwLxXG167knHLhZCyOMUdBa1gAJnij4RwpCwXljkrJ02JCcr6v7bwokcgoJe+uZKTS5zgU1ipc3K8ht65EQsTXM7g8fkcRU7p77ksWuzPWm2tQlzpAGRAdJgsMN/aeCgB7iJw/r0oCne+coOEJUPaCkJ4IH0+UOjxASrkDdVWEaLJv4Qf4AQ1QCCP/yGQhVrf5mj3sryPFMQEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1RAiF5oWjlW3doYblZCC83ximlzoogokIoaTE5L9zo=;
 b=PxraEfNeH1F9SYQ1YehE7/ixznfNQHi7WTiCcpCPPdPenjupa+IDUKJPzX1bwOzeKS4xdvmIMzrkDwtTWmAC84fg/BVG2151IfhJEQIDb4Z4gbpnaf6q+hH7Bu/58zAyg6UOmv1E8orLEcTEofPKF1T7g9nrQlxrZzm3KZI5FoDlOWZfTidAbCHDAIobttHM+SDSJm3BvHbi7Ls0joIG5qBb9aHODH2cEe2qltPGAohBqcgJQ+ms4QAVWj/+xqcAolIoZhVoIDl5DgvQQ74Ox46oN+n9wLzdM8AFwO90Fo1RL7T88hYeJtncjtlWqPexaN9k7GyOia4POBmGNvicXA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:59 +0000
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
Subject: [PATCH v2 14/29] vfio-user: implement message receive infrastructure
Date: Tue, 20 May 2025 16:04:03 +0100
Message-ID: <20250520150419.2172078-15-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 991c8e53-8ff9-4107-7f9d-08dd97afb07b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjdQYjBVS0J5S3Nmc2dhaCs0bHRaRWozRUxzWW5TMmh0ZmNBUEpPek00QkpT?=
 =?utf-8?B?QTBlV093cXVvaGIwQjFLRzVaSmsxanFCUVAwNWdYY2ZCdVZTNEptQ3JvSktz?=
 =?utf-8?B?VGlIZDNzSkdWOTFTTkVZaTNNTnRldklKS2hoRUhKaTIyRkxITlNsTE1JWGk4?=
 =?utf-8?B?Y1AzYnZMWTVpVWhmT1F5UEJscjBCQ0E3RGF5dUVMVGJWZXQxQjZwQ0tZRENU?=
 =?utf-8?B?OWZSSW8xWjJFY1ZuMDR0aEcyZmMvQ2tzQUtKRE8yRzh3SHZQYzBlcUZZampj?=
 =?utf-8?B?c2ZjY1picnlsYUxrNTNhcmxXTnpiNEFiNVJQVDIvK3Z0U0tHaEp4WEg1VVBh?=
 =?utf-8?B?cVluZjkzUlY4ZmZ3eUkzMnlheG5Qd2ZEYXBzMks2bU16aUh4WXl5UVRSTlN3?=
 =?utf-8?B?a2N5Z2hCcHE1WUVubGdwOUtLdGk5eWlJOVZqK3ZOVW1pd2JUZmJQVDh3bnpK?=
 =?utf-8?B?ZVhpQytaZE12TWU3N0NOL0xIbWNWbno4MEhIQVRZcHo1SGh3ZzZNM1Rqb0cx?=
 =?utf-8?B?YllyNUwrWkpZcFZaeUlPb0dJYzF3WnRHdXB5c1lYRUJkMXlJbEFtSGZ3UmpJ?=
 =?utf-8?B?T0VlRWlsdjB2am9tS2RLalNMZ0NBLzFoajlBQ2FzQjA4OVZPZmw5dFMwdGMv?=
 =?utf-8?B?Y3hzQkNqMHN3VVFzbjUrTThpeVM3MHk5YVg0ZUhkL214WVllaStWaE5paGM5?=
 =?utf-8?B?VXBSOGt2NDkwNmg2eWRNVDU2TmhUaHVOWUl1UW5pMjhPTjVGWmhCSWs0WVFr?=
 =?utf-8?B?Ti9NR1dublAzeWVUWVpGSUtVOGZVNzZ4VmxIUnJ1QnFUcHpndU55cmlJSHZ0?=
 =?utf-8?B?L0YzOUwyMmNVTkZ3UVlNRnZHdy9ob2xLOXRDRHVueXdySEpRTzlrWmNHVUtV?=
 =?utf-8?B?ejV0V00yNXV4WXBQM1I3ck0xYzNjZTUwYnNGKy9WSnI0N29WUWVKOVFVL0xo?=
 =?utf-8?B?YXR3dzBtU3hNSGs1K0NuVGRoNUMxMG52bTZEZVZmQ1owNnlwWmpXWFNSQmEz?=
 =?utf-8?B?WDRuK1VZOWRzSDJVcVhXUDhERUVIaCtTbEN3RFp1bVNicnJyZm9rZ0ZvLzVM?=
 =?utf-8?B?U3pTNnBZYU13QXYzbng3aWJNSURrS0xwL3pyWFpDYVVicWFmbWc3T28wTTNk?=
 =?utf-8?B?YnJ1WFZyZDdVaDhXVEx5TjFiMm1wVXVFa1lQZXRCZlpPNlZKd0paQ3B0Y29m?=
 =?utf-8?B?NlEvaTNzSGJRSHNHOEc4ZTdiVUVRLzQwY3E3a0NaMEE3NCtCSEJLdWpuMWtR?=
 =?utf-8?B?TjE5d2ZlSk5VR1g3WFhUd1FOUjZiSnMyc0RpZHZ1YlgrU0JHQm5XYnhxZW01?=
 =?utf-8?B?WUlZdC80dm9jQUV2Qi84TzU1MkZ0QjRBTUlLcFZld2ovT1YvU21oNStMSCtj?=
 =?utf-8?B?SHBzd3dDR2tJQVVoUS9WTnFEVzZURkNHU3FheWxhcVNsQUhBajRoajR4eno4?=
 =?utf-8?B?Sy9yQ3ZvQ0tCemFEbUVlY0pxckVTS3lpVENRSkQrRjE1Q1U5cGtXYnZGdXh2?=
 =?utf-8?B?ZG5kMWJGT1JzQUJ3bitWNnRlQWhhb1pUeWNQS2s5c2NKMUNjVS93elFsclJ0?=
 =?utf-8?B?YUMza0pNOEZzdFVaNjc0Ulc0bUhjNU1uRGg2ZEx2MTh3TDJydHc2N2dyNDNE?=
 =?utf-8?B?Wm9FV1NuaFJzSmlnRU9nTFVOdmkyR1pCV0lvV1A2aVRJc2ZKYkExWXErTks3?=
 =?utf-8?B?dDBCaXFOQ2dnSGQ2NWRFOEE4NmJKQTByb1V4Y0xXbkhXci9WQS8wNVlYMXJK?=
 =?utf-8?B?N0dDUEhWdGd0UU16eW4yRXVTeGpQZTY3am5mTGxOcVREeU9xVVB6WC95b3pq?=
 =?utf-8?B?QnN2V0pncUdhNFBBN1R0VUQ1V0NmczJMMkU4Y3BaeFBBTkRVV3RjUHgvek4z?=
 =?utf-8?B?SzNRUmdpbkluRTVxOFNFWXdpNHBxeENTdVFzL0IzbnNkTHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OSt3OUhDUFNDOXd3dU8wbVN0dm81N2txeSt3RlV2QjhFQVA0VkgrT01qRGxU?=
 =?utf-8?B?VmhnalVkSHp4a1dCaXgwbVhVZlpTMFAra05OVVF2amFzOW9nblJkdGJNWEg4?=
 =?utf-8?B?dkZCd3NXSExHZDhpVGd3ZjVKcjFhVEJIcTZpcW5qV0dJNEs1NVc3eGkzVkJh?=
 =?utf-8?B?R3NLR1hPUkltclZoM3ZRRGZsOU94SVNZYlpJOHZ5T2o1K2NPK3FweHJzc1BW?=
 =?utf-8?B?R0MvVEprT0hSU2c1L2dDbExVYytYR00wZEFXUGpjSWZuSFIwRGNXajlXbkJa?=
 =?utf-8?B?NjhCN2lkeUdMZDIwc2pqTm9aZFJlOGVBVXRISVRVQ2JOR1NTVGVLK25RemNE?=
 =?utf-8?B?VUJ4bzQ0UVJmQStYWndaT2U5Q2o3MlVBU1NKRzdjRFNtUUdIVG9SVE5FN1px?=
 =?utf-8?B?eEJUUUgxQXNZVWZxSlg1MGZUSEdnZ1lvSXczbkU0Y0s2amc0WERnbTV5WERn?=
 =?utf-8?B?VjVYWkVzV2IybEw5cWIxaHQ2aVdWOHZucUZlQjJCZ0h2YkJwRUNwTGU4bUwy?=
 =?utf-8?B?OC80SlBVcnhKQXNnaVBNcVRJM1V1ZlhEeWxGa3BKWkdEOGI1amRoaWFTaTRO?=
 =?utf-8?B?QU9QU2ZzN1JjY2JGY01pNmhON0FQVjJTczNLR3Bic0JRVUdQRzRqbGU3M3FQ?=
 =?utf-8?B?TU9SMWx2WWE3d3c2TTU2Q0Z3YjJaVll5VjB6ekJBaG14ekNBZ3MvOGM2Q1lN?=
 =?utf-8?B?YzJRZW1mZzluYXc5VW1xdzhDMlRTdjFTaGZyTUQ4SjhjT3p4a09tcGtnTFIv?=
 =?utf-8?B?dUYxVnl6RHR6b25RamhFTCtGZFdOOWdlZ2d4dHlnWHEreFRTSjlRQTBuTkIy?=
 =?utf-8?B?ZUh4OFRpM0lRWTRUNVlhMWh6TU8vNzI5dVlSdVpGT3hJbnFzUk9OcDhSaElh?=
 =?utf-8?B?MkVwME05ek1hS0taSWd6MERqd2QzUU1ENDJRWHBhTWQ1SFo0NEZTWkYrNEU1?=
 =?utf-8?B?WXZuODJ3VENuTXJlMUNoQ0g4b1gvRlpuUDVKZmdBV2plRWlybU5NNzQ2eS9C?=
 =?utf-8?B?bEtRREpESytOcGtQeEtXekJ5b290UkJ0NVJCWHN5K0JPYzVscVk5V3V5TGFS?=
 =?utf-8?B?SWZ3bWxkZmRidm5wR0RVc29GOXh1bTcvOXhab0JVOFBTUWlkNGpPNUx2M3pp?=
 =?utf-8?B?aEJ5Mkk2emNzaGFlYjJCQTF4OTRZdFZrN2dBOTBMVG9lYWRGYmJzY3E2Zm9u?=
 =?utf-8?B?MEV4VmZUWVlTSGh4bEZkYXBqTlBqMlVLU0dQenZQcUFWKzY1cWdzL0dHYlhU?=
 =?utf-8?B?WlZQY05ZcnlKNnNWc29PUkZZOHBHbmQ5OXNzNm43emppdmxaQmtpK3JIamQ3?=
 =?utf-8?B?REVjM3RPZlFoMjZ4MXlnQjQ5enZON0tRekNWdWlrZWJyeURtYkxEeHdqSVVN?=
 =?utf-8?B?WXRKU3dtYVc5bHhjNHhYUGVGQ3NpcDFxSGFwM09zd1dub2dESktlOTBjVkoy?=
 =?utf-8?B?NnBzNzNMZzZqdHFHT3J5TUxMR1VhaTdBOXJKaWs3RjVWNldJUWdHVnZXazBS?=
 =?utf-8?B?c2VWRUZMZ1FOR2w2NFlLWDI1YTB1NFFwNW5PTU5iNDJUSXVhaExjRlFJQ2NC?=
 =?utf-8?B?UU1oc3d4cEtlckxwaVlVNWhOVFFST0ZiazNBNVpOdFgxNGpCZ0ZVWXRxRWdR?=
 =?utf-8?B?MHBqK1FZQlRRNlFVUDlwcU1SN2VES0J4SEd1a0ladEtBRjA4Sy9BaTBNTmFi?=
 =?utf-8?B?STMvUXV4L0xrTFZVWDhaUUltNUtNMUdHQkJVZGx5eXpCdHF1UWhJYUdJVUJ3?=
 =?utf-8?B?R2ZzMXc0djFTcDM2cVBMMVdNREJtRkhoNTNyUFQxblBWc1Zadmdwd3ZxWi9K?=
 =?utf-8?B?RlBzY2lVajNyVU1lYVJCdndUTXVLQ2F3cGtuQ0FDU21INDc4VGRkaGxkK1hn?=
 =?utf-8?B?WFUyMy84SzFvSFB2RGdTdlRHUjRFVCt0VmN5VjVWZTlOY2pPbUlCOFlrT0ps?=
 =?utf-8?B?V3VSNENXaTY3emRHMFlhWFZNMFpjRVRGRnJSb2dYRDNNRnZ0TFkyQ2x4OFNl?=
 =?utf-8?B?NlpKaE1FYVgzNnlzYy8zcXhkd05SMEczVDZvdVdnb1kzWUQrV041ODN1bDdu?=
 =?utf-8?B?UHFMV3YweGRKRC9peVJKL1M5ZkNUanBUSUcwUTJFY0N0bE8rUVVCUS9pVTFU?=
 =?utf-8?Q?1Bfrv76ZoEtkC8BsjwbJRW9XT?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991c8e53-8ff9-4107-7f9d-08dd97afb07b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:59.4937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpbceVfIEGG8x9fiLYlxtVWSdmfjUMv13fhZ0GS1dCvtV5f5OFqnmW1rf/00VLnqotC5oZ0mbeMpe2Qj6qoXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-GUID: l6Bpcq6HfDbXOCXMx-FQETqz7nKob-o6
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a1f cx=c_pps
 a=qvBKVd3KFl3zkoLf5jvq7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=vXCtUE0a-urccVGwgxAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX/LihosZmbePh
 fjKv0Xn7OUESah+s+l16BO0Pf6eLU03JpCVC1lVkHopnEkDeRTkaMV1KDW7BZ+52+00FKT1Oeia
 1owZ07CiraVcfXp0JmXhkbDzhGxUyLMrCPpVVZVXzkrax5kWImA6JALi6cA39z86zuZPeam74fj
 VV6wlzycEP7Ccb5XswosHmWX7gS+KwP7gZDBOK3WhBMeN+4h15d2Cg6uHrzpv1u4GQ6ovvgFYd+
 xZbsso/SvZ8HIsuz6LjH4M++F/o6Ixk2Lwg0065uvBvcpMzL+A5AATllkagds5qIoE0ZKcnJxsa
 Qa/wBw47f11ce1cF3Me4jlpNUZyLXSRJ8Gxjzh4Lk9lqB8JfsWxucJhMnSxt2SO82C23UP2LzwZ
 b0wA7yM5v8BS58d8p33zUf+IZVbd7uinWQNkrXfmXTOS8uBBvSA61KpgaGKSfyuvFBIoEnz1
X-Proofpoint-ORIG-GUID: l6Bpcq6HfDbXOCXMx-FQETqz7nKob-o6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Add the basic implementation for receiving vfio-user messages from the
control socket.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 meson.build               |   1 +
 hw/vfio-user/protocol.h   |  56 ++++++
 hw/vfio-user/proxy.h      |  11 +
 hw/vfio-user/trace.h      |   1 +
 hw/vfio-user/pci.c        |  11 +
 hw/vfio-user/proxy.c      | 409 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   6 +
 7 files changed, 495 insertions(+)
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/trace-events

diff --git a/meson.build b/meson.build
index 7f91500bb7..1873f92313 100644
--- a/meson.build
+++ b/meson.build
@@ -3642,6 +3642,7 @@ if have_system
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
+    'hw/vfio-user',
     'hw/virtio',
     'hw/vmapple',
     'hw/watchdog',
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
new file mode 100644
index 0000000000..6300c681e7
--- /dev/null
+++ b/hw/vfio-user/protocol.h
@@ -0,0 +1,56 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 60fe3e0b6d..0105479d02 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,6 +15,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/sockets.h"
+#include "hw/vfio-user/protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -31,6 +34,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -70,13 +74,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
new file mode 100644
index 0000000000..574b59aa89
--- /dev/null
+++ b/hw/vfio-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio_user.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index f77d0e497d..894130b575 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,16 @@ struct VFIOUserPCIDevice {
     char *sock_name;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -69,6 +79,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index ac481553ba..4a654d7597 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -14,15 +14,32 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/proxy.h"
+#include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
+static void vfio_user_recv(void *opaque);
+static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
+
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -35,10 +52,340 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (vfio_user_recv_one(proxy) == 0) {
+            ;
+        }
+    }
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+    Error *local_err = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, &local_err);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 &local_err);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(&local_err, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(&local_err, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(&local_err, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(&local_err, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(&local_err, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(&local_err, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, &local_err);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(&local_err, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    error_prepend(&local_err, "vfio_user_recv_one: ");
+    error_report_err(local_err);
+    return -1;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -54,6 +401,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -92,6 +486,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -102,6 +497,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -117,6 +524,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
new file mode 100644
index 0000000000..89d6c11c4c
--- /dev/null
+++ b/hw/vfio-user/trace-events
@@ -0,0 +1,6 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# common.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
-- 
2.43.0


