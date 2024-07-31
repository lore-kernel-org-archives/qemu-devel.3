Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90FBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ52P-0002vG-Ms; Wed, 31 Jul 2024 04:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1sZ52N-0002l6-Cm
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:50:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1sZ52L-0004ym-18
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:50:23 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UMs7UF026227;
 Wed, 31 Jul 2024 01:49:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=97433eYgz+gbNTe
 B8yVjIw2nay9XIP8r1mvMkZQh0uk=; b=DOiXOSTeNAHc+lAShOAJVIPG7KW+MYy
 vNyiIBJDsNArnO1jPK+MsA3oGqHsNYAxsUfBUi5jpzolaEytVZIXWnytCxHg+1fF
 CVQhONKciTJBsdHvoFFTH2tMu9ouEEwTtLcfwPRRjtQYNm906X3RGu3IVwiOzSpu
 1JF1Dn88juPCLcnBojSi93umfEXD0oDijfdLCVLlU1AavN9Bs5S4CUSZ/HPjQHGj
 i3hkRVgsgN+Bp4wezSQBkl4PwE7JCAJJ3E/0srYAQxGD0OTkLpEFB2ojVCw7cHIA
 yHzKwa/Byxlsrvwi+s2hEywa+DvcNPNpVYwanmL4l5dOXca7lXPQ80Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40q9cg12wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 01:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kM+/0Mr6sP2ITKZ6RuWfbX191mzNQUZxNFeWIInR+HqY+Yvd/AptdVHrO7RUvO9xBuLB1HDzlYUzqXy5g9M/b089gYjwxeUij2VwJ/BFa+8QSSY4NVNzxDc77qLmYNu4mYhRdR7zR/Dxi+H7rBoXO7xxnF2JeFy0qBJhSkXfHgIAgECPNuRMt9mkKrgtFboR27gEnObYkcV1qnRSxobGb5cWaCPOs/xga9fu1ToZBrik0yUxW7i1KkRVDofIiJ08+kD0/3+McWEe8qLXY6ykgxUtnIej8ngt+n/4rXtuoozrvMDjNPjiu8WSeNzm4VZeNGIa6S5LyBLClzU7KdAOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97433eYgz+gbNTeB8yVjIw2nay9XIP8r1mvMkZQh0uk=;
 b=fLeLBVLmvAWrdcytEz5ceLCixhK3FCbJDDhlv40C9MOPuoHnS13Z4dTDVfzHKOS30EP/fuKuQ+vIznYMxsdtfFSUcoaUP12Zwj/6G7ztqMAKEo07QAOswP7OV6/W40n3WREiO0gkpjVWzUSMyrNmquDaA6W9UJfMd+xshxKyZcE8xFjyu5UpYnhtLBC2BhP92VncovtFk+FYg3NIlwKITp/zS+YLgABKXwoIp62vRDUhdj1gKHOX++PnICoeHT7VqbvjUFDAu1Xsr/X8mvJ8eJDngFxluWY1jhdSfW5HmvYitklJTjGo1UF7+0dMCc5plCcECf+nb7tKF4CTF7p5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97433eYgz+gbNTeB8yVjIw2nay9XIP8r1mvMkZQh0uk=;
 b=DdUvmsaCv0hNEP8g9XssxtohPhMoFKKUtIUO4uHJGYQmmIkSgbLx/+gUVLMoxp3uVguYrRbgSs5OVvzqmxPsJKJR5RewxBLwlbWE2g/VwFIOwnR/6O7Pkcj3MifbpRf291zuT5b/BL4NRlMJqZFFWWgxmgPo3XX/0R7ndDKa5JSp5DTV3qinWdAWbcyN54jNY2PW/yA+mNtDiE5//DAVf2J/zlzRrb9jk59MqmDKoSZtLp0jlT49eBRg1OtukjO87MAfbxHHEm3jnO+SapyNjq9FW/5qHU9kXrjYynHGh/K2RlLOihi+a95UexuHD+ZO9zGTftZ1s9z0yY9W1OQ+Bg==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by MW4PR02MB7250.namprd02.prod.outlook.com (2603:10b6:303:71::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 08:49:40 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::94a9:746a:7967:ba88]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::94a9:746a:7967:ba88%7]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:49:40 +0000
Date: Wed, 31 Jul 2024 09:49:28 +0100
From: John Levon <john.levon@nutanix.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Manish <manish.mishra@nutanix.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, bob.ball@nutanix.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <Zqn6mNuCH4/HJoO/@lent>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR02CA0135.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::32) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|MW4PR02MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: abbdc5a4-e290-4513-86db-08dcb13db6a1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zm5arWlUhWaood5b2ADrst4d5VSVnvVNtOWXJ1rmzyWVyz/mOLDfkL1/eZ5M?=
 =?us-ascii?Q?vFojD9DjKPUfJvEsTIq4t+RPEZ9q0atetX3MBwkk4PqcOSW8JTdRQ9VotC5q?=
 =?us-ascii?Q?xE4ZvoQZtT5uXLudfwxh2IEAPHO9GhLJSgsPz8XbOS7gsaSiekmG+SXUQxiw?=
 =?us-ascii?Q?9870YYKZAhk7AoYAs3CLNTCYwRC8ZZ1ofpeSnpFpOJeToMXhqy43bqbOrxkE?=
 =?us-ascii?Q?vJogqHMt1dpG9AM12+nYg/+5Fmy7Q154m6KhmYEfd0DaVW2HimQsfJ/eAmDm?=
 =?us-ascii?Q?pE5U/b9XZvoOr62VX8aqvqmGCMR0boqIJqtp/1FiGH8w4gW3zIImdxkp2a3D?=
 =?us-ascii?Q?wM/vESe0xd/AKouKPr8LAug8Q/0P+zaT60YndsVERmTh22tChcvzGBpZ54Qo?=
 =?us-ascii?Q?ytFjnJkHfqZPVB0KskdI1yBj+mUcwYyKkhlzhXctEffRTdBX34tqw8hJGeNC?=
 =?us-ascii?Q?4yZegYdLzfg52TL1341sErawbFutlPbw632FtwG1lN+aga/7fgauAbHjRML7?=
 =?us-ascii?Q?aC9eGWR9C3Zpl1hbuBa6dYs1hWLdaMplH6InEU3/JvTKtcMWsJqVVMGd9TDy?=
 =?us-ascii?Q?3fQminwIxN4lsORtjAT9Q1lV9faT3K9CZTEpjOAinHzZBegsEf+3Fx+KNegC?=
 =?us-ascii?Q?PjrVjoLWjg9UwL2pz/d7G98sQYrNei7ZhKDMprtpzUhkPTCCgFqA9f/OPa1I?=
 =?us-ascii?Q?lh8tu+StM14RPLZHN9ZxMOXD1U3lJFqS4oEw/qn6OL3EJ+BiV7WKbA1Xk0Mc?=
 =?us-ascii?Q?USFR6HFyjnsHmrScVzQiurDPYTYLbjNq4nZGOwfy3rQ47BviL0CP7zCga2Ci?=
 =?us-ascii?Q?TLAcSz2zMEKw0GCZZpJ+zHeJKAW4vtviGdDusfHzrRNxjkmQ6DmPgR1L3ElM?=
 =?us-ascii?Q?QtP1VMlO8nfXJob6yqN3mvkIL01CejCzCndC/LfOXNXLQcfk+r8OQ2SnqpXa?=
 =?us-ascii?Q?B2g9hgNb1nNSJgG4FFJBdpO6OAg/S+oo53m0NQgWFRXr3twKPGPdJFhlL3Qw?=
 =?us-ascii?Q?yV5wO0QEmuy3Ds2274LNDL9jx2ueMdP4oP/vG2IFgXRbAOuBpEYhqIrld7mg?=
 =?us-ascii?Q?SLPbKoRdAlgq2gNxUFsBvvTnxZ7HcftB2EKuS8w8LNfRFRURzcgicLiAnMOr?=
 =?us-ascii?Q?XyMQvg2Alv0kNSR0YACR+qzWccdxp7Tqnl5m7U4S/CO8UHxBvFw82O9dhjnT?=
 =?us-ascii?Q?2eN7bex2Vsit2TbP1fNQhdCia9SOEXR4/h0raVH/ySCvD23zV3E61euCoeoC?=
 =?us-ascii?Q?fS2GXKX8gCimMqz3usmxnyp104ktyO2kg5x15z/O7QfGNLRKhYAlzwsXVUH+?=
 =?us-ascii?Q?XrBrpiU5T7qLhpRPxD3mF2sXO4GBQR9nkT845y/6UupJ/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTRwQytlCetct/LkOcC9AsyGmHovL3/kS6y183o/lD5esqOQCs+Wev7JeNoA?=
 =?us-ascii?Q?NnptCFMPmrh0cVw8pCbebvhfoDdVplSYJcsFRDN2zQAIIozqZkQiSQ1z1n/g?=
 =?us-ascii?Q?opl9RxXCJh6lAFzuRy0Uzg7Iyc0Q5e8VpgpH/eomyTPlWw7o1GEWW8IgkYR6?=
 =?us-ascii?Q?p1ZlxeZScFna3XwK5Mrmi8XklrFgFLg7uw0xJF2kH6tDzDFKTCUKiE4bPy5w?=
 =?us-ascii?Q?2nOGWWvOWKyabJL7WiHp71/DKrAaP19KEAMdf5WY1oQ7Ik6/zpACTvFNgKwh?=
 =?us-ascii?Q?ncdqiUbexfgkVPzh8GcFhp9OeYIhlpzd85pkQjusLKCWqtrvev2qbJgWNEKM?=
 =?us-ascii?Q?zRJx0oSC+iOVf5SllBFVMtUPLKDYy24ymjOPdh8wJyf3xY+G3Cu7xoR4ZDfl?=
 =?us-ascii?Q?I0dkoKnA0RCgW+9RIDXwgiLnoWpPt2MoHVPWROWkd/9j75EeQBHCf/QPtucQ?=
 =?us-ascii?Q?lQBHxl/KwoXXzp1TkODVGRjBGunEzR+DPF6hWnrvbmiVwCBRztVFTVPlv/kt?=
 =?us-ascii?Q?TLQVUYRKJKcBg1AKmLSX3goQwt9sIbc5kY4HmSonDkFEgSxcwtZKyVkVgTMZ?=
 =?us-ascii?Q?VwPG6xjHY21XC6WyA1imvzitiF5YPJETlhY0eK6HBuaufqXezO6bcMhsK0KN?=
 =?us-ascii?Q?U+hxqlGmjSrK8SYRm/iXbKA22fgsCaKumPvfz2nkn5qQYclq8ofnRU18OCzS?=
 =?us-ascii?Q?yt9DEbkWR2PwtjX2gGkVCuy4fZVHCn4O/dHC9CdlThPWUYW6aPdVwrIbWjFR?=
 =?us-ascii?Q?vZRr1uJXlwMYjWVqXLs4T/jOqDZozy+qiSUxwOnkp1KEneIhtTyTe6S1UlxZ?=
 =?us-ascii?Q?AE1DU8ClOUE4ojn2meL/MWgx7CnJmf2FxmmYRLgUSPJg5kVJl4H/HOaxqZYW?=
 =?us-ascii?Q?beSfzm7d41iYRK50wnj3dDRFMm4APboC2ORP4aXAYqxNima5jkKwrBBX/i2I?=
 =?us-ascii?Q?EMoYFLU7b1g+4xMAB4yY4GUrQWvXDMEoGA6zgVNZh4QKzJkVe7GHUIydd1jL?=
 =?us-ascii?Q?2kn4/2Bo+5eyJQDKOFRV4oValcYXiV/63NmS/IKzJ+dqn3CsgKmYKl7ilIzc?=
 =?us-ascii?Q?njuq7hj2kkLnNoVJptH6sJGHUCBevJnClJEWxsLoRbNrfIDAvv9vR4FWM+8m?=
 =?us-ascii?Q?G2m1smjNXv45ftBGgLNWWDXimm2Zu+nvpjPOxWbt0BRKIDVuylcDXZ/sbtGZ?=
 =?us-ascii?Q?+K1THon0Iu4iSpeWaEvsZAF/ek1i4gyWHs+bXoyxwt9kIZiluIEpo2sldqnn?=
 =?us-ascii?Q?VyJj0YBgeL1ELKFQNR6z0WVusHudGpo3u3L/zzdUiwszX+Jhq4hl280kqvg7?=
 =?us-ascii?Q?7lZrtjNFAL5vjHkZkOBvXgI2RVj/I6m08SVH17mikI3CSiMStzCzvsX+Z5mP?=
 =?us-ascii?Q?wHijfSGNAz+KAJYbMcSlYRtIizjinN3C0PV5lRNam2bgW6kFen9MnBKtbc3C?=
 =?us-ascii?Q?OkLuF7xNQVHuC/aReWy1tlJ9EhbCEvam2C6iS5xqAU2DkzCQXal8pVvTakLs?=
 =?us-ascii?Q?vZBwfruLsDCCnFet6g60I3I6NDBbDy0DJlwKPmSXt+72+BUTMVIfqD/gAgyB?=
 =?us-ascii?Q?osKZitQeB2pMZ9pho+k5RqQ+aKiTJXY5B2epdLTX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbdc5a4-e290-4513-86db-08dcb13db6a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:49:40.1144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYtKO4qi5R5QB2lXOR6DeNP8fdHP8+AwalupZyV6YEkrJbXxbGDFpJi/iyWaSz3yB0uEVGj4z1/LCiLHYA1PKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7250
X-Proofpoint-GUID: uOt6e5XoLTvL9EOOdgnz76rzKahlhHNR
X-Proofpoint-ORIG-GUID: uOt6e5XoLTvL9EOOdgnz76rzKahlhHNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_06,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 31, 2024 at 03:02:15PM +0800, Xiaoyao Li wrote:

> > Windows does not expect 0x1f to be present for any CPU model. But if it
> > is exposed to the guest, it expects non-zero values.
> 
> Please fix Windows!

A ticket has been filed with MSFT, we are aware this is a guest bug.

But that doesn't really help anybody trying to use Windows right now.

regards
john

