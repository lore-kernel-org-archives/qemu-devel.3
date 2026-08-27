Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0A7C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBz-0008Hj-Ec; Thu, 27 Aug 2026 10:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBx-0008H6-O6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBv-000229-T8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:57 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67REBEpW088827
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=91B4F5KbeG3ldu4vWVVBQtwVHVEy8VE+NWpp0Nl6p
 E4=; b=k9MesA7MuxRt0vVwHWwgbHtwqzwvOzNVZiFkTgH8n4a6V8MfCoAb1VN+d
 FymU283eEhmfBBQZnvfCMJCS3hvhvzsf+dXquF+OoqUt3fwqbO6TCUhET2Twu/jK
 4DO2kIq2oxbIaeWkij12sBcoHgCNyK/ccWI6J0Iri/aA9d/mPXtkpMb1eEFlVEv4
 xoliP+P9gX1z774UloQMDVt9yC7YKwpbd93l2v/jt+rm1I0IVRw4aNpVscINHjbf
 oyAooKQiW1Zl5Sslo3rHVxKWqQh5RA6ujLxtHkEKdvn+HQoFZmF6925lt0ek0zfc
 aTzu/udYpyCbrqzBvIKxbLnatchtw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022137.outbound.protection.outlook.com [52.101.43.137])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g9dk8p16x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5RGZDExf2XC4BlxDMmzEmdEVFeKd/zcDIl59sCc8E8Whnm7fNeNRKzOt6E38W3Y3xqtbb77S5p4H0dR+eZjBrOKzoMqdClVi2rnUP8JBeY44XqxeL0NOKQXiCsdWB7qkEBjWIT4bvFdwNL9pF3z9ZRGgEK3sWBCIHhItDsSDfxWDwe2lIuH9wVTXR/IlADaQO7/BwJ+8qVQenh4F8vbmKaMHiqHEUmvWBXYGlr+8IZ7Z22eq0NmRbb442jTK2m/fSwXjuApYdhiOhK8hXD+a8S2j8QqkJjM7vt3EphcVs+mgzVFXDVJDgjYNVeuHTxiZokKTh3EFSL8ZA/+V029eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91B4F5KbeG3ldu4vWVVBQtwVHVEy8VE+NWpp0Nl6pE4=;
 b=HLTbAsbVOcHVdD4zLVhKcGioABTCTz9f8YpBghx0c/4ZHloBfstiQmEM4wFjD7cTvxMNPZZD5+IMBws5+b1m2KCXNdIWwGgI8uhVUt14vJ9rAvh0oeXJPWxOrD0QBTipONPqPvjTJlJsgr926DHpiQBaX3GmSvILPVKdL33ehN0vbq3dOSZoM0PY8taDXHJmzbmWDn9S47K2zQRFyHyt83EerAF7bD+vQvi73W0ufzRFn1kH3Y3O1GDZAvhX8qW1zgokS8MC4fKKgRO3qQvR0oibVom4SovCUfZGsO/cVqolz6YAabBfjaKlwJr5QYeuQSwTotpytfgW2u2dNdnivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91B4F5KbeG3ldu4vWVVBQtwVHVEy8VE+NWpp0Nl6pE4=;
 b=ECiZoD2LhGVA28nelK+qAQ2g///aBO51gH7bAD1BKqpGzn94eQ8O+ytZLcu/M3351l4+c6C6TI0sIMMNyQGQkpSTax/XbKnMtyitlu2Ypa+M/EmOrb2w/pB4lvxXx+2E1Q3cUp1Pecc7MwXKQNylIeKXBy86aMb28o55H6fl0Ukt5Nk/8eUMgO7K8jCD7t6undV4RVkGYwfwREmKLtJGeDR/8gKd7wM16irMUYIbXIkYyRKIZohka6nEKfWwQ1nuDI6ZdIxV7OE1dXsCUZ+XXlis9Lq4/4+zlPgArdpKcl5IlWe+zgwxGj4hFivEmFOwRDeoHMy6KiDLeCZ7DLG0JQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
 ACPI_PCIHP_IO_BASE_PROP to class props
Date: Thu, 27 Aug 2026 15:33:34 +0100
Message-ID: <20260827143404.1393166-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0147.namprd11.prod.outlook.com
 (2603:10b6:806:131::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1dc316-bafd-45dc-e07b-08df04485ba6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iNMRN+Z8GCb3IKA1KWd85UGT2TtCoWUm2e/22nQ7S7xY0xvNFEAJvRkYlDhkhuCdsr0Fmq2weRHRTCPkkflmK4MQ6bQFNGF4NUtHPb71h0TXO+8CnUJjKcKOBHM/UQqOftWwClYNHpM9byuBARNsRfzaJlP7gfI7jsFEaZJIOSUJOXPab0Pu6iWIXIc1JEFZugppQAjhCiuG7dR25mbm1jHN20G7zncpmHya0jbZPpkhdE1VZQcPQMoFAaGJyO0/byuLb/mSnKhaKRkgI4ziyDdaHMtwg8+cSU0rXmH5HNs83xtfh1FqkOPqSskum9tH+wbLYHjfVSM7CvmSmZLq25jLekQsph2nPD7mlak4JuPtlosjYNv3WdWHN1ChT2EhNqvGNtRZ3Q+/PHR08y51zsjU1gbt/RfasYJ9nKLDqhEjDJDCRhcGHeuhCp1/g+7++W9RQKkkdkFu0WfBeRbmG9ya+H2hZ9l1X5NQT34vBEzjyiGDhNz4wB6Mv4hSw1N+7aWZZ7Ymbr8DmEarzyVqDcBzhfYdXm5pBrqzZskhZgMChf6AOV0XW8JYWMwv++pMa6ePijPHonKAM+xK3X1NDgigY4bPAfjVbg7ArEfKee/mZhl6fffA0bgxvcZc6hYVkhz+x/NEjg4arzSZiYij3ptnZm+E72cRle8dGQl6yrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE43WVhyR0VVb3VteEdvUmo0WnlGRU1kVXJOMy9rQ3hWQXFLS2lWU2tnYXFh?=
 =?utf-8?B?NHNOZHlKY0VjcFA5U2cva2w3UlpBclVPWmFWQkFrU1hndE5VVk1LN2NZMW1T?=
 =?utf-8?B?UWdIS1huMVFwbnZPQ0dndkJTSDBBS05IZzV6T3dLTWV4c1B2SDhBQkg0eVIx?=
 =?utf-8?B?WC9KZGFNTnRCTXl3WmY2WXk5RXg0QjZaRFV0SFR1V3QrMGRPcmRUdHVYZU9m?=
 =?utf-8?B?ZDlnYmlTRUFOWTBZbUU4MElvS0JLU29oM2pPZmZ5QTh1Y3E1cE9WeUdWS3kr?=
 =?utf-8?B?NVFHS29jdGlhc3ZFUmQ5WmluVWlOeiszQXU2YVVrQjk5M1ZjcW5LbmpRdWVY?=
 =?utf-8?B?S1RDalUweUFGTVlnM0c1RkxUMmo1RlVtUStVT0JqNXYyT21kVmUxYWJqQ2hq?=
 =?utf-8?B?dFM4UDFOV05ESVpySklGRXUzWXQyL1pvNXNZYTBkS3VyQUloTXBRT0tTNVUw?=
 =?utf-8?B?ckdoWU0rNXAvNnUzdFE0eHJRdk5pOVlkb1c5bUVla2dxN0hXYU55cldoOEZr?=
 =?utf-8?B?dlByTmxaQnJuUzdZZHBXU2liZHA5UFFLeDRyaDQ2bllsVHdVbmpXUUh1WEFL?=
 =?utf-8?B?RkZwK1lBYlNzbTJnMnFmcER2MTgyNzlkeEw3MG8wNlRuc0VJNi9LdU85QmhB?=
 =?utf-8?B?MVJpTmxSVUpldjYxVUU3ZVR3KzNxWFhpdHlERkhmZmRlVFNoRmp6SUNFWVh2?=
 =?utf-8?B?aTJnWEJNRjljc013VVZLRUdxdHk3aldDeWdMQ2lPZjF3QmQzREVUN1czbGRa?=
 =?utf-8?B?a0t4T3VrQTlZRlovRXpOem5iY0l3MENuMkFzR2tuYWtDYkxJQ2tBNnNoSUJX?=
 =?utf-8?B?Zkcxa2JpKy9QajVYNk5TSy9vV3VlRW1qK0IzUS9MUkE1T3dTR3l5aURKWWQ1?=
 =?utf-8?B?eGs0Z0M4VkRZZllkNDZrc2lKbzA0OWRYQ2V0LzdCalZWb05ITzNFMk0vZmFK?=
 =?utf-8?B?RkZFcDBmbTJ5bjhvM0t0WG9uQTJVZEtLcVVZcXI2V25aWVFVVnU2S3FRaFRn?=
 =?utf-8?B?LzNlbGdvQ2hENGY2eFhmZjlwbDBNUkc0QzgwUWNVVzJWT1N4M3BUL3M3RXMy?=
 =?utf-8?B?emw5cjV4eHEwM2dvOXhKYkpPZVR2dkxSSHZlYWNleXJzVmZuUWowRkw4aTd1?=
 =?utf-8?B?OENhUzdJYzBKajltcVM1ZlZpd0l6TDg0czFwSFlZVTcwSUFUOHQvVDlPZE45?=
 =?utf-8?B?YXBMVTFodnFnSFk1M2sxRm1tNWtxcTdMUnprTlZ0T0dqWXVtZkVNMHVLbUxi?=
 =?utf-8?B?QS9ka081b0FyQUtIamxhMiticE9BaisxYzlOU0duVDhDcXE3VjFvNE5lK1Br?=
 =?utf-8?B?VGJDTmtsbUY0ak9zckp0bE5UdUNjU1V0MXRTK09Da2ptRjdYSlRTZ1VMVDY2?=
 =?utf-8?B?bGV3ZXJlUDJ5U2h0VGJTblBwUFlCTDljWXVOTlEwU3JEZ3RvRlRIS3pJRkJS?=
 =?utf-8?B?TTJoTy8ySXQxYmhqLy9ZTWtqbUM5YnZUUkt6Q083djc4SmVjdm5hWGJBSUZ6?=
 =?utf-8?B?NFR6S1MyWnAyaTBpYS96bUQwanBkVUppWHFGYkl6Qzc2ODFXOFlOSFBGbGxj?=
 =?utf-8?B?MkJvUm5VRXhkS1ZONFYvcjJ4U0UwclJraEl3WThiOUhUSFJoRUNkN3I0RlM4?=
 =?utf-8?B?MXJSdXU3bnRoMjZhTkVwcUZJMjVXVzFMTWR6aThOcVR1K3JMVkUxRXQxMnVT?=
 =?utf-8?B?WnQwWUxsSEozUFNTNHYxNWpaNDlZZk1FeDdEU1ZpVlVFekhNRkF0bExsWE5D?=
 =?utf-8?B?cmN0c0Y5R2tVbTFNOENIMElBczhQcEkwU0t5a3lvR0s5azh6aUhpRWI0UCt5?=
 =?utf-8?B?USthUmRzbnNBNnI4RVlFMkt0amNtZ3hScFBxaFhHU0oyN1U2MmRkQmpDTDN2?=
 =?utf-8?B?UjcrbEt4TEJYTjNLNjYrVWNEdEp6OHN1L1UxVmxzdlNTcWprc0hTRTB2RkZ1?=
 =?utf-8?B?Y3BsR2ZxLzlGTk5Zbm5yc2dSMTBod2U0bTY0M2xLRHdEWlhFL2pUemJnR1B5?=
 =?utf-8?B?R2ZPOXJCWGJhMjNFN2hWRGJpbWcxejFwdExuWVV3a3dRZ2IvWWhEd0FvVlFS?=
 =?utf-8?B?RStKSmgwVkxXRzNHUy94akRpVitmRXQ3SUF6cWJhOEhOeVloRytYS1VjUmR2?=
 =?utf-8?B?TlNqbkgyVlltQmJmTVlNSHBiVTNCSnVrWTZWVFhmaHpRcTE0dEVBelgxN3NQ?=
 =?utf-8?B?N1hiQlFrUTNlN3ByRUhOVEdSM01VNUJGWjJNbVN1WEFab2N3cmRuVjRka2J2?=
 =?utf-8?B?aGFiay9TS3ZCTGZiRHgrbTJKbG9ZVHh6QUJGUnlyMnZGY3REbzIrYkp1RXpY?=
 =?utf-8?B?RUxmdjFmdlQ1MEdxd2tmcGZoV2l5VGEyVklrd0E3OTk1dFJlL1hBVlJSQUhR?=
 =?utf-8?Q?CYk2jW8j8ZNDVzPc=3D?=
X-Exchange-RoutingPolicyChecked: nHF7uF5guhgvZioR5HDAlS50vy4pg5jVA5fP5v9mTJNIt9vx5lXRP8h5eDJS3KsCIwI8koTlkndeXq3svBqKXlErAY5rZKJFFISAymQqvYMrm2LCY6hghYNKqC9NXjymCtzbQvAPyaCYyU3vNDkUsSl7S0/fyO839Q4Qx/UiHCZyDDWPqWRm7f0YJyDQ4+MUF1wMLcCdkgUpZIFWSDqESg4weoDRgdge9Key0rlUcLYpPWJe/cb7siBHAoZ1avXttXCfHhtHwErL/9D7cemsF3m0x/QvAQqoBzsIQoxC61lQtOesE18b0wjTl/ni214r7+OgO3XsgU11PT+QNSwIHA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1dc316-bafd-45dc-e07b-08df04485ba6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:53.2433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5y9IE0T3y6scVzfOZZjWurw1XUkGYvVLJAsTJpe/jJ7MZzA3C0y+3hlAqd/mkUTtxvsdBDf/CVD+Tdw46kSRJQVR8RVaBO4Jn3lnkgAYaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Proofpoint-GUID: 3aM-kQQ306dwjIc2OKAoFa7aQXUIOMZ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX/Z9vTycLE/7E
 P1zPj3gCuoRnQKSl7D7RPzcXR8mYlbk2mmEIYcgZsLkRlQUxnkD5znNCYgvYRlxDeALaowHU/fK
 oCtGxRODn7IjoBuCFe5XLjbL4z8wAM1oJ6wqXMVZkOqrapvpr9+sPaStH3CqLfLeOk/1gUG8/W7
 lLLKbesjreOzT+zfZV6cRK+vyaDVQyo2fNOdr9KLbyval0ijpdgo50x8lzVT5u6ohpEfBylKa3l
 49H+gNRON86aV7BW79QITDVgs18cEJcKgY52plGdDCBmbsct/uhwWTg4RPrY5Q4l8HM7JWRT2TO
 Gx5wIOHnxCnY0ZYD+3RyslZJ1yq8EZTigMucLRGulyJ1z3V8ZTiHcpd+ot/w+NL61eS2FdoLAqR
 DVdSYZFQFxTeD0wXVhqmJ2Eqg4GoRL2cXkXgW6AY3viXAJE/60V8nleqOqwWk536XALm0Dh1kJP
 vH6NYrp8gkScdNZQKuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXyDNwFjQD96Lm
 3BbSPEthH6OikE6ipr9N7kcAptPT++80lMuK9FNxY2dk0sesMI5R1Np02093018BkILRmKXpYkH
 xo5LLREigR5q+NSNO7xtkjfLuEJflhA=
X-Authority-Analysis: v=2.4 cv=YOyvDxGx c=1 sm=1 tr=0 ts=6a904b0e cx=c_pps
 a=KrBlo5eklov38meissWYIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=pnBmNuUOYQARQnUSyu0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3aM-kQQ306dwjIc2OKAoFa7aQXUIOMZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Since the objects referenced by acpi_pcihp_init() do not inherit from a common
class, add ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP class properties
to each referenced object and remove the object properties manually added in
acpi_pcihp_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-14-mark.caveayland@nutanix.com>
---
 hw/acpi/generic_event_device.c | 10 ++++++++++
 hw/acpi/ich9.c                 |  6 ++++++
 hw/acpi/pcihp.c                |  5 -----
 hw/acpi/piix4.c                |  9 +++++++++
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9e9416d406..67c9e9b3e8 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/cpu.h"
@@ -608,6 +609,15 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
+
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo acpi_ged_info = {
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index d6df8db21f..8082eae428 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -400,6 +400,12 @@ void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
     object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
                                        PM_REG_FIELD(keep_pci_slot_hpc),
                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_BASE_PROP,
+                                   PM_REG_FIELD(acpi_pci_hotplug.io_base),
+                                   OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_LEN_PROP,
+                                   PM_REG_FIELD(acpi_pci_hotplug.io_len),
+                                   OBJ_PROP_FLAG_READ);
 }
 
 #undef PM_REG_FIELD
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 87162ff2c0..a91f523c93 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -502,11 +502,6 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
     memory_region_add_subregion(io, s->io_base, &s->io);
-
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
-                                   OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_len,
-                                   OBJ_PROP_FLAG_READ);
 }
 
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7af..1d209ac96d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -607,6 +607,15 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


