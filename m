Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C86C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9w-00033F-VR; Fri, 06 Jun 2025 20:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9u-00032p-4E
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:38 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9q-0006QY-QM
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:37 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556NqBwV023142;
 Fri, 6 Jun 2025 17:11:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOy
 n4=; b=e5lGYuSlR7pF5cGUn4QuN0PUDA2TqLYLUwcM5VUm70e2r/x+kW5EU8iKR
 6V4B8nAkVNN/EBDTnbGcqM6eNalSCCfddnce9UP4hs7QT8YZdJptCafqGTp0xwAb
 1CNZcUR10Y15MjkLDaq89DcQvjKLbK9qssgfKFNr9t0b4grnSzrvYjTDcS0GACl1
 8hmNPS55iiZktCskQxtIfXDBhjubqPTJ5EyP9xmqLlRHlnxSjMsbAP3N7XKTVe0P
 W0KKzBlcob8SdGcz/BRKaLhty/WMnUjU283+R16vNshc4iLAtmidgdt4XQB9mghs
 EHmSEANWbK8pVoCepIkDUktDpy5OQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2137.outbound.protection.outlook.com [40.107.237.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahOA68HBisb+Ks4KMnhqI5w+EfEUXXR2CTLUqsGRcieE/zoqZh+ALBPCDSgGkca0v3nl3n4Jpfp3Ay5gnMcP5x1M/JxM0xtclqANz9LJ2d58VFDSo2VMejGbMJ+j7E6nNva1vtlurJ/3fOK+UxN8g7Om8oroqk5Il3FR61+H3Q5RDCU7U0i/kzDaOkCI3x4mHau4DYaiL0wMIf9okRAVIIgho+oOcpFx/wqQEsORzbW+G9F5p+Hw67CkbHBYXxKBwpy2cmKJfhEdUmQFf2JCJheEOtW0HZiTTbWaZM/dmmVQFr0yfQIn+JeGEuuYBF8vU6H3J4srem9f1Z8OYiA6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOyn4=;
 b=JpWQN5R7Amf5dqUp1uQNKJfCkryGKPDMWCqLwT7tCqdlqFww/3HganHXCBRQ51HjWk93enA5cViMlnbT2gZewDGWw03VOoS/emW4RC5YSNQXFk6LqNaUExPGBgz8xRkYtb6onLUwQQCDF+M9uKVzLecwRvMeDNM/F5kJ8LALbRhAfjWjLcxs0sqoXZctphagRmBWJnacgKN62jORl7kU8SjWm9bVyg83Z24xBubmbMfzk6tBMTka/dO6jrxv+KVYh6nos7NABbdeWhzJtaq9hK18WZmbx3CUmLwln645W3vA/A/tsMfXIM03kEME64pobGPKZJnF4iASOnH30MNAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOyn4=;
 b=kZ5myy2PaY4nLPz9NllP2CdKBR30WppkjNyHhyiBrVThnxZM1YTco9IJHxfWZHmVZ+I6ncTztnAQg7QcMVijPtDEgOD9xpJw9xnR6vWBV9XOrUFKq+kevoWpfgB3AoTROaOWbATA3yse4DFOOna7AhJc2J8vPTc40pHSXDjZ4MN2xIo6MDBxEr7JcX1w7e57bf0s6d7vxizrAutNf3/gWMY8vAsZHAVcNhTtmJDTS84ScGCaCnm0vxLZozQ2r2VQP/SkcD85FnnXSbpCJs5lWyrgdm11qR+7bbnFLbSDtZNKjZqDFTntY27c04btwDtLpgLHPbD5QS7f6uIkXwRnLg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:21 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:21 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 16/23] vfio-user: set up container access to the proxy
Date: Fri,  6 Jun 2025 17:10:48 -0700
Message-ID: <20250607001056.335310-17-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af1a3e2-fc01-4c8d-a6f9-08dda557d555
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MkelGuIKg3YqAP2HAS0eTJxsEZ8O+V3E13impj/s1OlkwfjKx+yM3VqLl7GB?=
 =?us-ascii?Q?p8qqBZDKVVqKRi16MY7NGB1lRwSBU+A3Gn0o9UaHBif8HkIygApOrl26HtPr?=
 =?us-ascii?Q?FyPEapx10LcK/MNIQnYe8Is8q9O+2//ZaxMls6ya36saNtdv8LKoBIBeF7D7?=
 =?us-ascii?Q?DrYkbj0aAhVgA3C0dImJacvNC0GuyY+SxtdouyGTFH5sJUE7FpUOelz5+9Rv?=
 =?us-ascii?Q?nKslMvde+WTh2nsXduSiuqtUensz1xTXoO2LxRzPyaJSsBwjt59ylC5iD8rb?=
 =?us-ascii?Q?CbObWdoMFkGOuPcCdKjcsdvlihe7LV/ajWRv4/AkB3KmzsEFd3D0mX3RqHY7?=
 =?us-ascii?Q?DO8wUfPEKnIAC6OZNSwfiHT68sNpstA+PKNruoD0V2YU/qodwCGwhyB5+j+S?=
 =?us-ascii?Q?c4LmXG2ZrKNaoH6k6PlvZjMZRnsSJf1P/Sb3PUOLUo6z6HzS63XTIxQmE+ZI?=
 =?us-ascii?Q?Ioo5PDDkYj5d9+CqNzTgRo0EseZUrk9eXg0trTNAHDBgxgbfMrF8oiUz1Paw?=
 =?us-ascii?Q?z2MKRB3b87W/PRPZ5rjZyWnyp0lnhCuH+dSflNTB6O2mzndrZx+GnAlQofd0?=
 =?us-ascii?Q?8FwNlsQWMq6BRjhDfByQ8KQ3CuKZD6mPHO9rLV816Ea50Uu7uSbb3sdVqm93?=
 =?us-ascii?Q?s+c6sAU0cZVEWFwXjoCUwV9nHwIunxc8lyJA9W7so067dcH6JkvwrTx8S8qY?=
 =?us-ascii?Q?vXrfz4aTLer9F2LVlNX1KO0kswbZslmZnQvOx63MFys0BkLKbeA2oTTcD2uC?=
 =?us-ascii?Q?SHLXapUsTRpm8gSHVL+OyutLr2kli4eYNNn9WKwjKAYbIpOyPf6qtwr1wDgi?=
 =?us-ascii?Q?UjT0uj9PouGmkZgyYd70PEJ3YSHO5uVbdCi5O9CnlAtLIn/XMjxdgRqgew+1?=
 =?us-ascii?Q?LoRDj/1+UQ3D/rSXDmWBVuU4SNsyhMOyAc4d24VqSCHCFLHinCiiX3K9+Qb4?=
 =?us-ascii?Q?xHNtg4zenFra36CyJcuo6Q3iJYi+Ay81ntBzEJiU1rJLByq48UzHWg4sRlZ6?=
 =?us-ascii?Q?inFcZEJnfIvAfqn8SV3IBhCng10E3nRa4kchfnagIs9uEeltx/+TqG0WAg7/?=
 =?us-ascii?Q?pjaHTlrZtopgXE4nskvnj/k4QqcVWls/sgBTew/ssOzuO6qMVP5kK9o75JwI?=
 =?us-ascii?Q?Rw9qQwM+As/9tfRhXi4yY5CM0cUSRwF6K1K3WRTeRFaM3SCbxwdfCb64f2f/?=
 =?us-ascii?Q?WQd283G4HrbKhGoDwIvGnOiyQg6d+Vt/s4DO7qtokZSS+zAh4dfoDEL9FXoY?=
 =?us-ascii?Q?BQHZoDJzel2e0wDMpivtRxHZWCy8IetfELOjy7+RlhDDmTq26FlSykS9i4pY?=
 =?us-ascii?Q?G9Rray7XBhHNjZRhBujr5ySb803u44Xj6kxxu9Q/SHe89Ilx41deMcVjJ2QW?=
 =?us-ascii?Q?LCbIkHEbXHC0JS0aoHhAxRKhbiKb5GbYNm8ylVFVEk/pM3KTornUefQYp/9V?=
 =?us-ascii?Q?oxldU2T/lTA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kB9+C7b1XnaMSw1xE+3WC9EJngYkCAZ2DVQH3kuEF8OV/ypYvnlsmSh/iCAo?=
 =?us-ascii?Q?dbhxjfoHAoOWVxVUkVDeqwolpEh/toqn0Ps1cUxcYONW8lXKvaIpVaMZJc7a?=
 =?us-ascii?Q?SHd7hK4pqFzb4an8AK3oVDUZY26u5gc1OzEWnovNskOji+31aIT2VZ4BaBgM?=
 =?us-ascii?Q?EFJwzdGAGLskqZWIFmNCTTwlSBPhkR8Z7+1hKXc5y2Vtsx6A+J22QoocrwEb?=
 =?us-ascii?Q?H5IH/ZW0gwAcRgiMME1QBLc4ueFkEOCg5PxULsifmhnkYMbQM1xrAWKZ6Y7w?=
 =?us-ascii?Q?BJY1NoPxO5OGAElFfEzLdUyD5iBTDXjHofxcD6FLhDXVeuaHUBJ6qMwEsU1c?=
 =?us-ascii?Q?Yo/qG+pO30R9kTSKPJzjv8lWlDcwLA8PNYnItbw/OjvqyswTKBRf3FJYpP5z?=
 =?us-ascii?Q?Zedw/uvzAKdegC2d9YqTPlpG6WIhcFhrZhtd0n+m5pHGZWZ/Gm4N888hDpe9?=
 =?us-ascii?Q?iunar+pCV7uurYLdOaFm2d03vHcw/OoOFhkAGUFjXvL+n9b7+C+eCoNoXmOe?=
 =?us-ascii?Q?WwIFAyk+wIlegstQabJhe9SqNsdF2oUa/EUKuRejbMhoYuea5PgwlfM/dRoV?=
 =?us-ascii?Q?LLyI4+vgomRV/LeIzytoaYY5/V2luhmHaTndXIgVxlM7p5ILbaLFPAYEWrEO?=
 =?us-ascii?Q?BGatJ6KTRYTbquz4taPlsyU8ZX1B8OwF8pK4ppi+qM8s/VufyFYwO3ujVUuK?=
 =?us-ascii?Q?7G2OsTPgtJ3cNHq4RZxXYuh3Z+A5FPs7JWhTZFDRaJ843Mo4bQSHNpfBxZJy?=
 =?us-ascii?Q?l8JukP+m8D1onamYJlEy/TBv9jncJgm8nYEOQO+oYcUhbiuZIZgyP7tf1Fdx?=
 =?us-ascii?Q?ivgCu6/YLGPh0lNX2nvL07zbRvDEh2X2PDtwqKq5Yl0C5ayPHrAKrqOmqibz?=
 =?us-ascii?Q?gH008vgeNberrFJA8KcZWLxtFiGLAnRklnx9RIrpu3T4tL04BZniLt6cRhhx?=
 =?us-ascii?Q?Bjg02JCkh8N8RyNTE5mHw09Td67dpZ4g/mwXgoMJd73rcNRQw/dP4RvbY4M6?=
 =?us-ascii?Q?phZOyuc0a+u20o9X+r1eNNl5dDghIOXQYboTRvsq/pY/2Jw9GilwU04IcPoI?=
 =?us-ascii?Q?W1qAg3gB6qAsjEU2r5rfma6S5LAJ5bVMqeS48ukduqkng1POT2Ex3w8iW6yz?=
 =?us-ascii?Q?z1oxBYMmiyaVXCxB69uVKkOUJ+Ac5OKW3ScfPxLB99p0PIj/WQ3p2KVOfCYB?=
 =?us-ascii?Q?SCnIPL0vC8g/7p6DrTc+5jfm557pRIou6jKSsa+mF6psXTCFGj95zyLa618o?=
 =?us-ascii?Q?6awHA7ZbQWyEm/bKsQkyw2zMwQfagVmiPdueQBu55YAsKjpTS2WyDKItl8sK?=
 =?us-ascii?Q?Kpjo0F+d34ze8r3EWvkrpI9TjQ7t/EkK3urFUO5KeDJaX7qnIItEO3XowwDV?=
 =?us-ascii?Q?xWHIiFkLy0MXSi6hOXQY18ZCxY2gOGcDuIm8sc7/+Nk1IDIXM8+AajGcqpkJ?=
 =?us-ascii?Q?E5THJwdlCFdt9IY18eAxDiEobsbD+sDdNntBAsC44oK5JXK6cM8tyDfufOeC?=
 =?us-ascii?Q?9BVlELqaxEtwWFeGte2OHbTHm8h1625H+Tl/aqXtZ2g8V6DyKK+3+bZnHVe4?=
 =?us-ascii?Q?gk1i31EcpwZEYinTkU2k62bfccJn4s8g+usSgG8e?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af1a3e2-fc01-4c8d-a6f9-08dda557d555
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:21.7727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDInLkJhDhzvsHljlXq7NZFmluURjNIpJtwdFv1Ts/Wp0N+jLzhdAkYJaPdG9lr9moDHy+zcRjyqI29yT8n+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383ab cx=c_pps
 a=kojefl/8vcI7rOD5WQpBNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=eNiANMbe5KInMaSQXcgA:9
X-Proofpoint-GUID: nM62GD2398d-UGQ9uWgpiGklQGiTWB6W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfXzyTLl85LnfFW
 J7e33uE6lXQhIGo4+HLbUH4zy5bo+65OY15Bhv/I8Fxg0u0FYly8y3f4L3IWEe0PDdQE66nIlcW
 TD0YrTRVp9k3eeQiTkI7SLkHd12fmwd4+JalPt+VKDKGhnQryZpIjo2qzOVLbxBX46975KK00hI
 rVF9axRlOB7sGbuvI7/zVVm+ahLQ76xtUxiKuuyLUDu/pqclc+xK17fXh5QzUZ8i/1zV7u96TUG
 QjY08/HQhzQSzNPB2gLbeOGTLPcliKhuQBVI1bbh4a5IMHVsgOQN0R7IQ1O1eRCErI042dyMsye
 PbHMcjOVDJXkCUKVGMTbCLa75Ibc+XNd8DG9zn0//P/cmamn0vQL8Sqa6naD6LlqJnPE9Md2PHQ
 /3nh4IqRNbFw2TdB/sXyKejCDgdq8+L64PQhAGzgm/zkBwhL2p4+XnO/TyMxbelUhlzfkFmR
X-Proofpoint-ORIG-GUID: nM62GD2398d-UGQ9uWgpiGklQGiTWB6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

The user container will shortly need access to the underlying vfio-user
proxy; set this up.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.h |  2 ++
 hw/vfio-user/container.c | 43 +++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 3cd3303e68..59e14cf5b3 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -14,10 +14,12 @@
 #include <stdbool.h>
 
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 6f0eb86a75..38e9cf8d8a 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -53,15 +53,28 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
-static VFIOUserContainer *vfio_user_create_container(Error **errp)
+static VFIOUserContainer *vfio_user_create_container(VFIODevice *vbasedev,
+                                                     Error **errp)
 {
     VFIOUserContainer *container;
 
     container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    container->proxy = vbasedev->proxy;
     return container;
 }
 
@@ -69,16 +82,18 @@ static VFIOUserContainer *vfio_user_create_container(Error **errp)
  * Try to mirror vfio_container_connect() as much as possible.
  */
 static VFIOUserContainer *
-vfio_user_container_connect(AddressSpace *as, Error **errp)
+vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
+    int ret;
 
     space = vfio_address_space_get(as);
 
-    container = vfio_user_create_container(errp);
+    container = vfio_user_create_container(vbasedev, errp);
     if (!container) {
         goto put_space_exit;
     }
@@ -89,11 +104,17 @@ vfio_user_container_connect(AddressSpace *as, Error **errp)
         goto free_container_exit;
     }
 
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     vfio_address_space_insert(space, bcontainer);
@@ -112,6 +133,9 @@ listener_release_exit:
         vioc->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -128,14 +152,15 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     vfio_listener_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
@@ -169,7 +194,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_user_container_connect(as, errp);
+    container = vfio_user_container_connect(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
-- 
2.43.0


