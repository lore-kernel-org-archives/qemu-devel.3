Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC2DEA3C22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmNp-00064k-Lh; Thu, 09 Apr 2026 06:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmNn-00064Z-Jt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:13:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmNl-0003sr-BM
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:13:07 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6397nhqX3196929; Thu, 9 Apr 2026 03:13:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=tA4Rp9vRJXMrhiKMILMRQVIItFDJV+ZzD3fidpi6p
 mU=; b=AmHlus7FugnGS4rPW9LX+6JxaTVxXfJlNpu99w0kcL/ifB588oFrC87Oe
 zste37oxYcR4VnpKAnrQhPji85QofKIJdOC7d5NDEbcKvnpL/Vx5ZEiWDgYIkTpW
 rslU5x1p4QgSvDwlKm6SL7HKPNqThtaV0PvhttcuTlnxHKbYyJfC+fKbTw7PHV5I
 tYpI7aIyrMSDDKokNNg1huDJPcYXJ4PtgX22ZGiJ0Xg5lNnDvP6UEL9DVIcRlu6E
 DRHLtRXoOH2VPIjl9nRK3xORiMA9RG/28XQVTd1meg2KVxIW1Flh9VVjv+plWcot
 6GNWqOc5GFVyw3jPwxSUK0REF3Qow==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022079.outbound.protection.outlook.com [52.101.48.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms4714k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 03:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlLj74kYtcCz1s2BAMF/f861XkE+hWKp0ZMqrBcP4BdW+qFQnZyw/sxvUcJpH5w5IVnzkZrZ0WRFB8nLV/6CN7wtb4Uy4+3Fa/5ZYhFjNA9JiiPRkhseMlJNvdVbiwenEQ1XpYfmRobzf+OzQ/lisEyYDItvfV5VYuTGD8n8KO9uMyPrF2sH3RAsprW7KlSPH8XiDYKgq+Nx9CrQpG4Sk4sumCo/oseAh1l8y7sLDGHn81RHVRoVdeGcnYbBVbZ7znwmp8zXtvshGRodl93bQaObY9+u3FPe0rT/zN0Bz5h0Jt8RhvfJYeQoUYBGY0WJWAtLM3tlHwwFKGuxbG95iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2wH8grdoOmwqnhmab37kP/LPW5bL5Ulmoqv6a/loxw=;
 b=UaoNFhd6T69ZpM3Ahnu9kotT4Z8jlawFLzSn+Y3hg8aQNJAow7yNfhTjJJO6aOa7hNPjwJOp9QIACwlUmJfFmvF2XlUBi1s0o2E+AWAboIW4uBF07KVE/Ej+ZL1WvtVN22nauUDI3MnvbFR/LE0emhPRY3uZ7mP3ZQ6QiqchqLwZTj956F8mSNOWvInR3lPwYUJuVd7FZLcyU2YZQ/kFQ5Qp8hgcDGvzNN+xVmBlJLWD4vZoGc17dfs74M2swsL3SjcAoKRqZoWVUPFN9IILn60e3oyKJCirz1gH0JS5T1BMs0GRFMUFYDbmP9lS2F1pvEATPlWIkcx2cDeH5bFYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2wH8grdoOmwqnhmab37kP/LPW5bL5Ulmoqv6a/loxw=;
 b=TeJmQ7P5RGhjnIzu+yO7mu7ChUVtF5rkNc6QxSoxYUie0CN/ex8wEo/ttmcH9iQMkF8iTs6S1M+DLpSNsPTlMD27cq6WvVUUCM0BbnOdZz5RwZbO57rD59LqqG8AqEYKmXmbeJ6Ak1q9QBNS0bQLSOhHkKx0YwA+mQ/NI5qvRL0SHgnRExsO8D1t+/vBpIWg3JEU9dlGRILHQ+og0Hjtc9dLKY8MqU9TiG5WB/vNSURlPYHx+LFPsDnLZ44AXA90XZvVYQFer9HSQaCUWkHcDJeQs1Ay9AWjRV3FbZ8gHHgS5NFdL53Z1yQ/LEIH2DYkZTc19zbvOm8NUIRd4M9etg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7389.namprd02.prod.outlook.com (2603:10b6:a03:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 10:13:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 10:13:01 +0000
Date: Thu, 9 Apr 2026 11:12:57 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH 2/2] vfio: quieten dma-buf warning
Message-ID: <add7qUT5WUA26iOW@lent>
References: <20260317195323.776669-1-john.levon@nutanix.com>
 <20260317195323.776669-3-john.levon@nutanix.com>
 <2bbd13e7-5d14-48c8-90a7-231a38537180@redhat.com>
 <adYYg-OgUUavR31j@lent>
 <ed00dc34-858e-4d5f-9b43-28c39ef561d7@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed00dc34-858e-4d5f-9b43-28c39ef561d7@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0478.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: d59b326b-36b5-4612-c09d-08de962094a2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6o6MYu+2/6f1UnXzLIq3C+MffNvTrhdbxSfGsjmmWjF4NZAY9p666yvA6z2IKsHcl0hAoCdKjS0hRhhWA3SYB1Vu4aDKyfq/IUI+6/R6z+U2A8w+mqNo/WIEsYilneRNWX3svnynVyemxlBJfwPaFCpreykOY5KC6vbx9eGFHtKti8RDvxXo/46D3C7om5P0HCOW7eJaEw6JMU3iKxuXBEft8hMbAgy1/HpdALCm2KrjIQobvh3LXP0LcP0b4qSC68NN4YbWOgPp76qtuNQ64QE04v/C7ZCHYZAvXj7NNapsoV4MpP7M+HFpNmOfzUKmWlwpPEzfgfJmZ/2lsTVvJZcayLSKMUuHabWnjMytjaZDNHSsvby4mY51xz2ofoM269jJzSmQL+rdVRvKlhc3rBHrTb02hNZxgEbRUgTEuwYm2n75L+/VyKvAz7J0R3YxZcWmVfrGGEsDZsfmx6ntNTW4mEw4XxGS02M+aIeydLqczXnX+fBAMYJhPf9OaVF9o9QiO2CP4HWhnq4k0X6FXnyJ6RJ9xFAt+cJ9hLCDeJWl3icTdYSKIL3Z8nnXpojJIEKFNLTwQbq66CbrSxDiIPfHlg0Oo4dK2fSZ2qj335KsZp0ZqFl9uBByx3zlVpEyUyzyEEKSnkpNtR1rKYIX3BmSvf2XFFd3kvt4QLJT6zoxX6xK8JwA2h6H2E01277jKu/2Q5oTNncT393uYL+lMieakNZfdzhOSPkoDSoiRFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MfvOdI9yxo6XsxTjxE9/Vp0WfjW4RW0w9JGydotdgB8fw36lOyJ8pdu+er?=
 =?iso-8859-1?Q?KnnzPnuVTSfF2U77KNkZRD36qealXvjAN0AYv5Piv26mU4eM2awyfJH7Xh?=
 =?iso-8859-1?Q?HhW2e3HITfeMEiOTGS3WFKMgfinmrde0QIN4KO8zdQNqK8fnnAOwoO50gd?=
 =?iso-8859-1?Q?jYkev2QjnjQvY4B3KVLbvARPwMHNkXwxxjbTBlG/J+llkCsALSkf8f3377?=
 =?iso-8859-1?Q?nw3OxO3xebSTlVW3wGZtwZdiFHzpgQ+9tgOXiYzwHpmKXwqHyJ/dcatvkM?=
 =?iso-8859-1?Q?zwZ+NUf5kIQXD3kECtBXdPHMwqDJUzYWpIAIuP0UtRDp/gA7vlJGoy/tjt?=
 =?iso-8859-1?Q?Dnp+hifKHlrqE0+iYO416rlgPAj1dGCpiDDX7rz0P2noab1zLTMeRYSWr8?=
 =?iso-8859-1?Q?WPktTJfcj62zAA6VcMDRGrhHSO/zbkjyYJ70HJ0bCqmMrX63sfKcNZ8DXE?=
 =?iso-8859-1?Q?QugWiLthd8JBNkJtFbvPG5jffaZFAZD5QNPsXopsNQqCESQWMd0Juve29Q?=
 =?iso-8859-1?Q?g8XgpKnzsVMN5fByiDmKeLytGPJlq72abN0uwCwZzykKkkSARyohcapZH0?=
 =?iso-8859-1?Q?vQmPKWDfD1EMiP2REwKE6sSAUszwnmusaHjWHF7n7ZLVzum7IxTpc/2diu?=
 =?iso-8859-1?Q?rWSZgI21EJ+sH/WqLe+LApvq4suRGnnxu5MGAl2ZybFkRLttNiCpzRCzsO?=
 =?iso-8859-1?Q?ynKB4GMGrYvhOmatX8nR8uWaHGzX5aNExELzVJf+G6rEpeXBVtEyuwm18H?=
 =?iso-8859-1?Q?/TpDKUDKTKHecUGxWc/sRuLflZZKIPz9EPxNOdW/i4i+jMWBADgorx8AUu?=
 =?iso-8859-1?Q?7lqxWVk7oSgMJVXeuMdY/b1ES5s3ce6U1h/yFdPjDa25moh+Q1q1vShHsL?=
 =?iso-8859-1?Q?8zw71UREsScoI60Emvxln92bk147b+gRBatDFIxwRlC1vPNef0mgC1NXEB?=
 =?iso-8859-1?Q?fk7h5Nfz/dqHh76v+ZilSbVDIN4a379cg3OwfCKnqXh5BWRMaj/sIgWwk+?=
 =?iso-8859-1?Q?ha1ePQZFrDI6ARUjpwUhic85l/i8bwVWMeErQM8bbKF5Wb4VydmqQL6fSH?=
 =?iso-8859-1?Q?z58otN7aPR0ofSMW7iPTJmvd5pD9UrvM1fPNlW8JAAiMfPOl96mFay9jL6?=
 =?iso-8859-1?Q?yQZYG4iJjOf8e9Ma1bpIKdYAT3GtSrqHa2tTKNnbh7sqUQsIHIyR88Ibbh?=
 =?iso-8859-1?Q?PCaocDJQHrfUOsV7czZzw4cyvw0OGREDdxO1fCK3jNOhiZaOtzBJVs+9Y9?=
 =?iso-8859-1?Q?auXnPhD2TNnAJ6WWb2RKnqG91qqa8g8wH6+ImpRshwTEowxUz8uV61R4no?=
 =?iso-8859-1?Q?FgvH1TTU52ldwp/AfWB3hdPPpjeLzTJ0cDDVOEpNKw0Ibgxy4LkR49XeRJ?=
 =?iso-8859-1?Q?l5/F31MZMVJYdGjYOZ9gFQvRFgJTYjDhpjsipnZgwY6Zu2c6zX9Us2kV0D?=
 =?iso-8859-1?Q?O0o168wlLF0/DFpHCXVi9NTwIi2mrkZxBoJ/Iay4YkKzP/Y8QjxL2eCWGS?=
 =?iso-8859-1?Q?BNxvRpYgMQmPEB9n9HqtN5OpuVAxZye/nn59CF3YBqA4cSNPnDHRI/l7iG?=
 =?iso-8859-1?Q?Arsq5rpS6zoTzHwOG9uosWGpPhk8MP/daAYO63j+32EEA0sSULJP4Wk9fl?=
 =?iso-8859-1?Q?IT3CAPh+3vqfX6wANn6bCXWsE7g6AbFZeBMcJK98lg5DnVM3tXoaAyBJbk?=
 =?iso-8859-1?Q?9UIboXfbtOZpTT6MqEcLYrMNj/VYWkXupgLJulHq/aA8p8IHL/mYpNJZdE?=
 =?iso-8859-1?Q?Z3NDqbgg5HKyHbeePi+7p/sg7P6z2qT8GKMJUHT6m7Ap70X02zAZ+rEEgz?=
 =?iso-8859-1?Q?WL8w7C/KwA=3D=3D?=
X-Exchange-RoutingPolicyChecked: vMmcVWUwCeVhfqDUMd7BPRFy98hRQBIdHcCuA8aTCSh8UHPvI8D8KRec1ecgt4+3F9pJvdhFFe73bWdLZDE6HrkswC3TR/Z7N33DgtDio4cmbPpN779kzeHFPpdHUi/R3lPdvbdkUIfjpuK4eYYrTkve5tdiC7l1kVHvKSlaH4bSfgcFnpGUWdXzSzn5ZpmGT8Ao9PmeCzwhjoJNVBayUDHCiIzp4fxY/kIkZ9eiqWdXbvzGDt1iL3TQdL5Bff3xAou9j8I7TftUt/pbKkHeIVrwp6K0xvaJvq5BmaP8NYXpSgp/saVOHcP6tSDb3rdXsS5lP6XX39DXrYAgi6Ytxw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59b326b-36b5-4612-c09d-08de962094a2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:13:01.1049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSwxzOHKf6PnByZ6ip5mdIzNccP/TsTIgP9U9Jk3o9iXGMtlCebXz9/zzXhVyRGuDotKkXyCce8QZ9Gyn7KbLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7389
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5MSBTYWx0ZWRfX6v5u1r8q68UK
 5D2QyoWNlf4XnWkkFxAw5mCK3EhUfoDGtlttY6ntrHEzAyE12cLN6h5g8nAQ/rtSWMynyGRI9KM
 pV02glPLNog3Wnr0amsdRtOkc0k320w1YUSZLu3vAo678+N6WTFkgR9T6j5xNri64ycTYu8ayrm
 3mEj7nTK0sNDASKSkYLbAKmvoWkXxWNIuA1XQSWdT3mJQCvJyu9qweTMyL58mmlHqrP4n/ddTrS
 fidfLB6jeAuPIqJOLRjZ/1tPRBS4hflDZWnbAombry03OuwvS5hAs6WIlKMT5QGOdUJorRvZb2s
 RUUqE2qjqzNn8T3szvGW4WxI+V+3yr1rQsh37VOp4ETyyONPga1TqZH+urkPjtxOKVYMSCgYDro
 f5o9deZoRxv+UnpbOgg8z7CNK9o6GrANqJRxLTJ/TVYGu282TbT+bdHHIwYXSjb5G7wBBkIn/e1
 toxxFFZihSxEwzSRUAQ==
X-Authority-Analysis: v=2.4 cv=M4197Sws c=1 sm=1 tr=0 ts=69d77baf cx=c_pps
 a=oCGjzYnsqMZj53MIwVW12w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=8qD7CkwyVcilpS8tGWoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: EWSluM76zH6kmnTEHUTbohQftqdPLMxF
X-Proofpoint-GUID: EWSluM76zH6kmnTEHUTbohQftqdPLMxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Apr 09, 2026 at 11:53:58AM +0200, Cédric Le Goater wrote:

> 1. quick one:
> 
>   Return -ENOTSUP and test the value in vfio_region_create_dma_buf().
>   It's cleaner than masking EINVAL IMO.

Scratch that, vfio can return this error too:

220         if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
221                 return -EOPNOTSUPP;

> 2. cleaner one:
> 
>   Add a capability field to VFIODeviceIOOps to advertise supported
>   features:
>     #define VFIO_IO_CAP_DMA_BUF        (1 << 0)
>     #define VFIO_IO_CAP_MIGRATION      (1 << 1)
>     struct VFIODeviceIOOps {
>       uint64_t capabilities;  /* Bitmask of VFIO_IO_CAP_* */
>       ..
> and test vbasedev->io_ops->capabilities where needed.
> 
> How's that ? I can implement option 2.

I'd appreciate it, thanks, please let me know.

regards
john

