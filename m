Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A369DCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVvu-0007UZ-69; Wed, 10 Apr 2024 07:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvs-0007TG-LU
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvp-00019F-8M
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:15:59 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 439Ku0uF015416;
 Wed, 10 Apr 2024 04:15:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=/9FLvqG5pUW
 JAD1s8VedIKA1uWOEQOT36XyHpWnVZKk=; b=D2dlOp5f60Itjd8shI/VqDD5o7a
 P1efP55gZhvoe3nfp15oIGGzg/h3v6NmN38HZhPx4zt3dwfsaC55hP0Iv21+d0nx
 9knP9rB3kcIbD4BY2ryKtu6YcMRZ1TERB5meafp+ZBHhFRYZCeUkOi0P2Q2cgkI2
 DzJC/8xWSXoIFRw3BzglQJIS3aDhPAhNy+TNoA4tFpEAYB7ePNCJ9hwBOaK6hzej
 JsahiBlZ8LobtRtZlmcX1VJdHOn7ReZcEh5clCLcHuRVETUeS8LUqD5IE7MFK8+8
 WhVbGPVVEPlH5kDUDjgvqxyIp0BuT/d0Ns2iAFBZDQr1eVAqIi3KW+yuH2A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcvwy2v5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Apr 2024 04:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7BVriiM8GZd8i++Mh+VEPx7+KqD8ETE10xANuBBK5pptW6KHG7QmSKtF0qBDOL+Asoo8JhhFPCKv4uD2lwC5CKUlL5RSXw4EMQ0D9xjlDWSazC3kpGjLxw0TywFZkyRECptl6t3QtogZF/epHeQ2xF4CjE87J5//t0VOpwklqOCvdPNyJIaW1dkCaOjPuDmxj32yLyi7RGH5zHLWVqz5f/tvdOr5BoCNyr5MxAx1d8TZ08hI/7hd8aDhfAIdwD5FZdPi6/dUBWifW98L0w99FNLWsG2iakz7ESpVU4siOTyEweMFvfNcCxfi6StlA8kBCG+Z69F5K2XAbq/bsrbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9FLvqG5pUWJAD1s8VedIKA1uWOEQOT36XyHpWnVZKk=;
 b=ga+eBXHrffLbSSEADicagdyxWevmiYK6r3FMaNaDTXYidYmYTqVu2iiObLTbhCVtNE0bU01sZj/gD3UI/Ga2NRbhXkjodgsbEjab4B6uw8IUSAUdcjcQcLD0P9V8HE4O0JbERTW+UjXE/NLHtUtGPc6t6Hfj1iOZoFjgnVcmAlXs04Jm9dgL8LOrxER1TrEsHs9dlk8aqgGWXtnIb34LfBknIUnyAVoWVos7ZplbVRd+9v5PnHJD3/U3odoT1nSnYE7x2JtNGujdKpHzISDitNk6KEkY0MhhPDq5GwcJrZuHjDyaRfvkeSx61Y2mggiH6/22R1eZNVCHiEPXEGvEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9FLvqG5pUWJAD1s8VedIKA1uWOEQOT36XyHpWnVZKk=;
 b=n+XLfzopSA+Xd2tb7m6WHtQ92VlWBhsJBFGFwwQAxf8Wae7tlGuLsGhzFIajhLrXmRKv4mb7bAlv7Aaqu+64Vn34fJV7nZjv3hARPlaR8PrWepvQu/Ledwwee7ciU3o57J7c+Kndc8ZY5Fj3Ws6/XVMZCfznTYdIZc0iV+b1FKzPFQ61qoIlEOXxLtNs7HTtxrG7ObuufB1mu/SdZnLxawcZZC08GFOt7SbejU2V0aXrMnSrrw7+nP6wdOGiYxl488+ZMk1O8rSMRVlkwJvWiHOgPxEDiQNJU72BN/0xDNc6hHXXdiYltEuBlqDsuynedVUd9AkKN+Jf3t0z2M+JQA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6791.namprd02.prod.outlook.com (2603:10b6:610:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:15:49 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:15:48 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 0/4] tests/qtest/migration: Add postcopy qtests for
 introducing 'channels' argument with new QAPI syntax
Date: Wed, 10 Apr 2024 11:15:37 +0000
Message-Id: <20240410111541.188504-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6791:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVZ3LceXt2utZTAdbsI2Iwbs6vV20DAlHfch/dJuku5eDwxB0RBVShcxhjxSW7Q2WlMardIBCOX+wNVMBFe7x6LxfLCTl9yBKUYbKqJv2ETvWIi2SP90lee7MLc+87JGk4qdXAgk7c6rIvaY8BYHGCZATy5I+0bcBWgujmmZ1Vu7P2S12opJbt55Kt0bB9VhFgIoxR8+QURmGrLGUVsN0+7VHeOleTS9wLVBapyRZuVOlOqsuIs+AjCgdeogmEV4UWzQCa7tulZfiT9vkL725os3IVctijsVUlGKdcHrlFUKcyjB9A1TpcriZ5m91u0J8WVl5wTFD6u9aguxjr5rL++EV7QuQpJ9nSCY0LBAzc2CU2Ii3XR7SXartbe8IaUdrr6CI/mZcAau3T1y2FXpsNKmM+hWqM8VFmn18i5fsFCMJS4kHDk/48JIuUxZfJC8/gkVX9IDHTDymCBGH/mQAWfVD4uysvO5LVAZhg1e/F/Ri2zv3mAANoFf1MMaQHhcXZ7dKcWNSrhEk2GTbIE1+JrOvW1jCccjm2MUi3j4TfaIh2C1vzTwC7m+emvGVs/zFNXt2xWk/Nd6RWjHvY6tPBVV9+3o0wfoO6Tqbyr40cL69EzGX8Qh6w0IXUBj9LgoTV5olsgvye/am7KS8gUY1SQkCvDRPxK4pHliFiuf4ngV52BnG7ih5E9VKuYNawA4gfAXRU7ZxpUQsPNZyLlXdZKy7h7WA6dGjjsr3QgOVHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ko6UWeaSNpkh9jW/4Jf0tD6HFwJkihGGVBYYvO5zlQT8DWzvlxSFxIoDpyzY?=
 =?us-ascii?Q?aBb9b7HIxuZuIMQPmi7FZLgv1Z4m9BCfBwTo6EXgosVHt3XJGVAabu2jTGVi?=
 =?us-ascii?Q?AfVBXo1wYBAYX+4fCyMe4mAyFYslco2HrkeMf4Lxhfoy+xe0r6UUCUZoPIG6?=
 =?us-ascii?Q?JjBF7tXXd1wXBVux5gL1Q+ontd/SdG3TF1D3FIKVt+fewJdp6xxem0FiuzLu?=
 =?us-ascii?Q?KlzitsrwEHZiZcn27DhQ8UyLPnDRFFMQcSCMR7e8VDnos/cQ/H5WjDqf+DLG?=
 =?us-ascii?Q?QGxF2vmgDuqwBGKB0HO2apkuOwMLXqwwYGZ4ZK7B5cyd/dDPYJxxqpcM9/7h?=
 =?us-ascii?Q?M7r5bmSnINEAh3N2HTz4s572UEGb1HJnCtJY2ua/qzRvJxg37CAKT8jriwVO?=
 =?us-ascii?Q?IAGDnuBjkUM2gEzxdZz4EHFplHLTVL53YIqJ7O+yZF8SkgIjWneJke5v/f2I?=
 =?us-ascii?Q?gXBaUT4irjqGx57eYOURMsEJHCvGBihpcbo61mKxYrvhCIRwoRFVV5SsnAF6?=
 =?us-ascii?Q?PExIqadjcgf3Mx36DTM3vUJlsSDEu0ZUC5lgq4uPfEPs2qeQ7slJcJ6F/la9?=
 =?us-ascii?Q?/qljNabWJgmNjGozqZQ5ZHfIYOE1SqR49j85QU/H2BtbSSn+sLQsX6WJIHF3?=
 =?us-ascii?Q?sYkQVCmnCzjkbXjgt7zfDQDs1FAjyi0qt+6mx6FCoaDWX0CQPjGKvLznecd2?=
 =?us-ascii?Q?+HvmH6BWd4eZwvnSMjffO56Ufl6pXJAmZ9R0uw/dE/vRhLOBbdkGUMZig2OF?=
 =?us-ascii?Q?SxGGlpQqEbKtnQZIrIpeGgZgvigkXhHt4wVvRhe8o/EFeguifoF38Hv7bbMQ?=
 =?us-ascii?Q?dmQ5aStrUmjzXVJzZ+uCq92wQyo2MKhfiPnZ+0Zw5oxkm4x1mil6l2Kowi0Y?=
 =?us-ascii?Q?V4mHilI56azShk/0cqUXZ4TkAH5vhcOGif+WgDxz7USSEz3pEfdMjCt/4Lgm?=
 =?us-ascii?Q?/MZUdR4kRXzXn7tgQgkT9NEXuqPZj3XezOOIb3wp3VBV8c8ndaqX7su6MqCM?=
 =?us-ascii?Q?/eZUUC9+KQy0dORh55+pAsrrSzDA8glJELIQ5Ve1NF+L+KcKY3MLTFKMVcWi?=
 =?us-ascii?Q?G1vW10YYwVCmJl9ASGsmv20k2y+8xly+BjBv9DKzwWCc/QQ0eQgwRqMPSRBy?=
 =?us-ascii?Q?QefIlQqeU/oCaMDiPRZRnkO+JnVY42Xgy38SRC5F2HrdbNDFV1dLki2fc4LK?=
 =?us-ascii?Q?i7xsB/sb8blFXCeEH7RXvbiEflud0wue9uzZdYNve9e2+QtPrYYBo74EtsxX?=
 =?us-ascii?Q?KQ+/jdf2PlyFQYP5qSKvi080XBLNYMK3pFI4QnTJtzBEx8o+q3M0dntTxD3z?=
 =?us-ascii?Q?MsmO77f6PjZ+OCfKlNmY1Gka5W4D44G3l67CWlS11OijpBDRoX01aWaMXDCp?=
 =?us-ascii?Q?djOArtuEcAGOdld+L/c5SFRHISTH9aEcN+VJVtFT+1SorP/HF7TcGKwV9XJk?=
 =?us-ascii?Q?SGutKNrSnY7t+QbCtJs2icKmi+FikVBzipSuRJhfLnA8RNrHPbmO4Buuh/d/?=
 =?us-ascii?Q?LLfZILeDKKYNuqjMf78fy3o7aC2KtfNwabLGBUhodV8e2hFABZxyyS21dgKe?=
 =?us-ascii?Q?+sKayi8dWanIswhBegILMQy8LVeMSgLvbyIxKHb4?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c4bb7c-cb11-4699-be36-08dc594f9325
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:15:48.7499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OB7lqoMmh0mrVK9QScO0u3wX/a1IrOxzzG/F8NwxZ3Po1tMJdv3ig2rIddqimIgFVoTHyRAIZ+Ns7jsBl3/uzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6791
X-Proofpoint-GUID: W3KBRlKYiLj5WVdA_P6QzHXMjzHd3gF4
X-Proofpoint-ORIG-GUID: W3KBRlKYiLj5WVdA_P6QzHXMjzHd3gF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

Add postcopy migration qtests with new QAPI syntax, having 'channels' as
the starting argument.
Also, introduce 'channels' to migrate_incoming_qmp function so as to
call migration with the new QAPI syntax from src as well as dest.

Patch 1:
--------
Revert back commit which temporarily introduced 'migrate-incoming' QAPI
with the new 'channels' syntax.

Patch 2-3:
---------
Introduce channels arg to migrate_incoming_qmp

Patch 4:
-------
Introduce postcopy qtests with new QAPI syntax

Het Gala (4):
  Revert "migration: modify test_multifd_tcp_none() to use new QAPI
    syntax"
  tests/qtest/migration: Replace 'migrate-incoming'
    qtest_qmp_assert_success with migrate_incoming_qmp
  tests/qtest/migration: Add channels parameter in migrate_incoming_qmp
  tests/qtest/migration: Add postcopy migration qtests to use 'channels'
    argument instead of uri

 tests/qtest/migration-helpers.c   | 13 ++++++--
 tests/qtest/migration-helpers.h   |  4 +--
 tests/qtest/migration-test.c      | 54 +++++++++++++++++++++++--------
 tests/qtest/virtio-net-failover.c |  8 ++---
 4 files changed, 58 insertions(+), 21 deletions(-)

-- 
2.22.3


