Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA8FCD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 13:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtSSu-0004vb-5X; Sun, 07 Apr 2024 09:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtSSr-0004vB-NZ
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 09:21:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtSSq-00008i-4W
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 09:21:41 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 437AJGvw022867;
 Sun, 7 Apr 2024 06:21:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=lHp8gHsh5Df
 GcgOWnk19zBfhJp70k0y0EMOL8hUpGoY=; b=1GJA5+WIbqP/yXH1Dag8aHeVuEl
 13JnqtYdTphYOAmWtivq+Aklljr1R2BkTpQ0gjQIKo/At0oQb8pppCTcJrkvMDfU
 qzlcfScvKveZjldoGB34ZaJm4zIP+UNjLvtrFEAGBeoPBhrvqf/NpxSDCPRsJSL1
 BGGO3gi0U7odbJYAd+whrS8u3lffsAaXildj2TkgUGDNRIMliOpJtijRkh5bBtoO
 rK2L+BWf7gf3ddGMZxsW9DUW+PxgKtk9JSd8wP2GLRladeTrvzpQGOtpLCs82IuV
 4S7bJnqnZX23sRvYufvvkQcF0hbVo+w7XDpMeEM/HVthiiz/pvgM/DmST1Q==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xbsm9856c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Apr 2024 06:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llrlDYEARohjn7QINF6/aXG7KWBKuRBc3dKbQM/LFUH4ec0dEZietnYTwLYBGOyR56SjiQCBxA/w4P7BS5O+NUGK9zDgEVN82Abw3b61TofJVPckdBGip3GXsDD3j4tNUDoiEymKlLuAH/bQd9o4kHXQeAkrWke4pLquwI8atjC/TQMbwTmE7nHFg5G9dnnz3tuZ/3Fl5/IV4RBzqDJD4idKnkIJhYRfhL7y6oxehtFAT+/Z+3UCoswjJloX4gvxBrdC+FMj/5q6Jjq8VSHsC6lvdwrrUzMqL5r1fkeEuZLjvm3yRGfL9NubvDDycpm3BP24NKus8Qzenucu09OU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHp8gHsh5DfGcgOWnk19zBfhJp70k0y0EMOL8hUpGoY=;
 b=HEo+z8E3RkzCiroy8yxcIFlMogXRQ4BIvyBW5GlfG0g9+VO6E2nm4M3HrDow8SAylHVpwXYmA0laLdyfz2xjaR3LATue4frnigBwmcBoxsykAsbIode/wD1N/dR33v/ReU0VR5kes6Y/i1MMnY5aZPy+00DpifwXxYVoyTba36JmnDx+mzuvLAbGv8mUiFUMdBPj9PPaJDet3zTuZGnGLPAG4AkY86R5rYYvPKJmCFNYEJbY7/qW5gSYYFUcNds3b5DTXpGLJSRPDsoaVwMW2Nd2mxeUihMf+iJLRx3I5pUwxY87x+22fz6boYeQJ2PILF/DEHjvo995K5eQ4oARAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHp8gHsh5DfGcgOWnk19zBfhJp70k0y0EMOL8hUpGoY=;
 b=TkzcJbuK8QcG90LWgLepKGRpef+8YO7LfhAPDJs/dPzO8XmIPyG+Y0nCGvW4O3ZwtM1yAW4BKhOHZSIi8VQiw2kMeJTUoTj5jMPxEME4j/IIX0X+xXm2gAsiOI1SkVrqDGwNBZ8nMHQjHb2DNolsFA8qs9k6/wc1gjByzMAQ2C+4kDAQBoLGBjU34kvz4VyfhFxYNMsSu1xYJFY7dOqL3T8Hnmi5uDcjd4eNoCV7Y7Fl0MbWjl73udfay/J4osV/Axvy/GvbSPgPy3SBVDAVQMlB/lFMV6DWhHQd0/4lD3GH05g8IhxS92wEqIl9VgmC3Vvd5AkynohOettwDHMsCQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB8625.namprd02.prod.outlook.com (2603:10b6:a03:3f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 13:21:33 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 13:21:32 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 0/2] Fix: qtest/migration: Improve multifd_tcp_channels_none
 test
Date: Sun,  7 Apr 2024 13:21:23 +0000
Message-Id: <20240407132125.159528-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB8625:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnrg9TTYAMRV3O4n8ajnZr1K/iLmDgsj0+RAZieT5EbcUVf4GJcI1iwyR0j9eG+DnE+MEuvXyobJaAydzMxl16QsqS/qWMtRGO2koiU2o+a0P6fwQr6JXjRvuzszTyXHaPOAns9gs2C0Sin1fHgpZXCKApRLFjwFwIQdDg02PcOJuGFoVBQBBW3DZgiY2ziP9X0z7FO3bifyI+hzg7Qzp0GFEJynsZRS4GjgPZknaC1AChGwmKuKvSJdP057d6Opcbdk3BUynSgsQyU0B/pFHjth3GuUUamlulYkvIMn+VUeIsMAC1JOKRQZWvMZcJJnHlLh4hoR85Jwfq97zQWM+PJs34ukpe0gBw52K7uZ/VkicjVLTXKxRsvwznsG0q2DGcXKQGlcxq4QgwvwVl6+a+sAIyNnWKs/Z4oxBzpWsa9KnLQJFa1x9mMif2tW674GpHY9VEteOK6YgPR18wgilnGSgLxOavjvqRsKXr71+lAFXPjzmPDM00icHM95/Q7eW3n7bfw354DVGKYDa4jqS1yuOt5jEI6Hu7hPAMlURjdjy67iYIO57walPkECJ0y+gfmOHcT/6LkcmpxiN+GZ2/qOFvA66JUC76dg+TJJjtIL4JqA87kwBv1N1uLC5YhEE/nAeeoH/PhE60erj/vPEnmjMGus7QUovIErW1AR12wD3J52paw8diI7J1bzVP+ZsRvGLAzvxETGd9fztBlbcNu8S5csM2rJQMQ4c02c794=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7wBJA9Y18rzIJt3pkobZgz+X75EqlyMmBhxd1Nd98eAwxKdU2Y9UVrE6idz?=
 =?us-ascii?Q?M+bBVLxe74rxEbttcLkm2xtRO1S7C6vWbiEMomo92g8yqfuMuQnS2p+9fqaE?=
 =?us-ascii?Q?srRa9LhWcyH0PRFFIdc8fKRH+6elk7/r1coczEPEQu6MMVMfqh9f3JuQg6mz?=
 =?us-ascii?Q?Yhyd/Wpd/IReuUY+OWgI3VAF7Pt+cgAPDStVvyz8Zbq3oVUTzeznfNKMueQL?=
 =?us-ascii?Q?Eqfbv7e809wU6gn9Oo8DIu4m1ZgqlC0ZlGIc2X+1gXPm1T6bZaHqMqhwfm8v?=
 =?us-ascii?Q?2rNJQ/+83pF/tWfsK3NuGy7bPnfuZKYiDqIltei5ytADI3Az3+QIHntfp2Yw?=
 =?us-ascii?Q?vTSPzUVu8KHSh9BdmM9p9sIMy+bzp7C/VNL6dsf0K9pBg11YOtdk1ECKcuUs?=
 =?us-ascii?Q?RiVr3CXLhPESHtjULSrUl8BXjQUalLqZImdMbaQ4IjPXvg84MxxyOucgpzKB?=
 =?us-ascii?Q?lgMpyd2w963UuaQ1mlbCbVIcScGXUJVrDltXcR4zAkoE+BkSH3x8kVX6ysXt?=
 =?us-ascii?Q?epVhO0725XfVsNG2wL4yjaZGTxWG/87OLYbGWuvXc0WBo1SIs+FpPVOeGqp5?=
 =?us-ascii?Q?seF0wcnWvt+j8du0J/Gb8PKOznbY4g1gYGFnhUuQ5BGE7i+OY/FNw09cXNXF?=
 =?us-ascii?Q?bHcpoEqb5BIhhKv3P6ZZED8dH92Z0SwyG6zQd9ozdti2aNklfQQ+dbdCJIh1?=
 =?us-ascii?Q?TuWz7m5Mp1HbHVluquCU4zOlgLtSmLBBbLtlBETYVIYRHWjFCU3pHDTF0q1R?=
 =?us-ascii?Q?sGJTZMG8s2lGeqH+abcAR/o8goNcCCa1i6zU4A4zRL2bgUzZihw8kZTtJwWQ?=
 =?us-ascii?Q?FnPLaiIxAXoVzDFPNnFZvxCgXmW+fiTLSR0qlmhO37mBCkrnCFjRzfryXqnh?=
 =?us-ascii?Q?olRcMShUGTAE+91JcRyMSEInNtLmA1IvcsQXTxxvYXmHHwf4ada1rAmv7kUt?=
 =?us-ascii?Q?AZqYkhlcxWFth7jGdCkmYKE684PBSJWRBfIOY2H+MAqV1ZZBY/ZBtX4jfTXD?=
 =?us-ascii?Q?7ihVhyrKwUglb0AO0KNCzvtwtuKjuhXsPBH+UmL4Gh7gQxxiOrAiOtEQfYY3?=
 =?us-ascii?Q?QDwZtaa5HqgvcSzKjvg1tf/bMkzvV8n8sdejxGRFxmNI4W5lTgePD+z+gk61?=
 =?us-ascii?Q?2T8aPa2Ylaaiy38zwVTcy5OHE19iBUpMJm3pX7fwlfkFSjf7J4IdD7rLB3AP?=
 =?us-ascii?Q?XmGsj8SaCx1ayoKZ6VoXjr1I85d2S+jbRhWlMTLsOipIrKWv6iudrDVqxGIM?=
 =?us-ascii?Q?0QvSef+nsAUXFHgmc3fo+cTOTSrCEnq/psMGBMDmTU3JCz/gnuzXqRUxlM89?=
 =?us-ascii?Q?B5hJ3fMx4JBvMYpLcB/pU27Bf4p/Zyj9QCzYEEoBKjYZGSi1cr/69eu5W/nH?=
 =?us-ascii?Q?kS5rBE+w+dv0M5wHi2B6b8bfqjyFMKJB2xXZXKi29ggNxCYKdw54rKseTJy6?=
 =?us-ascii?Q?UMyUT6bd4JJBbOGjY+rM+PTAwhNmKBxpt77+E5hsZsR+wm6n7Ex5fMGNxP2/?=
 =?us-ascii?Q?A/JOy8G2PuFh3b80OcpANmtm9j8r9Ebiokx57D0McQi9eVHOCiHvT/ExZ+8s?=
 =?us-ascii?Q?X9XjHwGZ+hiuX4Hzs9BFEGQS5Mn29Y5GI/UJDps5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a0e91b-89dc-4823-29d0-08dc5705a45d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 13:21:32.6134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4cA3UdQhDuGpg/w3ZEC2PxU5qGGF9yU3lzq1i/NEJrbJ8mxKgB/NE3+0Mtvy8lK+l64tkgG8bLuRnXAkiBbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8625
X-Proofpoint-GUID: vCgw5wzQ-BWr1a9Olt8jbNTRh-Sh3cgO
X-Proofpoint-ORIG-GUID: vCgw5wzQ-BWr1a9Olt8jbNTRh-Sh3cgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

With the introduction of new patchset to have 'channels' as the start
argument of migrate QAPIs instead of 'uri' (tests/qtest/migration: Add
tests for introducing 'channels' argument in migrate QAPIs), a few minor
typos got went unnoticed, which were caught while trying to introduce
similar qtests in migration.
Fix multifd_tcp_channels_none qtest to actually utilise 'channels' arg
in migrate QAPIs

This patchset is built on top of (tests/qtest/migration: Add tests for
introducing 'channels' argument in migrate QAPIs)

Het Gala (2):
  Fix typo to allow migrate_qmp_fail command with 'channels' argument
  Call args->connect_channels to actually test multifd_tcp_channels_none
    qtest

 tests/qtest/migration-helpers.c | 2 --
 tests/qtest/migration-test.c    | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.22.3


