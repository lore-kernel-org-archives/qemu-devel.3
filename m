Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEFFCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIQI-0003zx-Cf; Fri, 08 May 2026 06:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLIQG-0003zm-IF
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:27:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLIQE-0008WB-Jv
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:27:08 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6484sv1P3427606; Fri, 8 May 2026 03:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=8JnKtuQajGzCy
 8lns2F3WROUtLKO9sTx820PQ7jv/ck=; b=AM9B0lmlFJhc3IeYAxYxeeFAc2KeJ
 P+Pq6TTtgxreDyBieFDBWBEmjeBpUNxLEpnK5xo3Hs1e1dyfpKxj8nZxEDSMxtxM
 VWjEMT5IwNLne5NPw0lkTRosGWCnEt/2wtmrhEpL759v36XXY9eNoxbUpD02n66V
 Jz/PXm7u4SjU6iihvEGIpks8BvkXjVvfHiuSHqBt7mH/mZrHNvbr5deruZt7W/IT
 H05lcCNybCNWmDdc+speYumQDDS3Iy6pNMMpwcb2vIVrtUP/wM4um59jeRrokw5Y
 wf+LwhFB6b/tVOxWk66OuDs96cW+UNQicZ2e5m6pyolfOzryTCcx9WgRw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020078.outbound.protection.outlook.com [52.101.46.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e00ahev7x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 03:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeKpx1pC2oGZG9wPC9xYZJxXVoRLwTqcKBBEXMWB3DUHHLGYDFh/J/iN9qkR0HGBLoeK8ysyV57Q6H4jdA8sws72rSueU0riyXBMp0YoXqkcllBpjo4XUcMxubSWg0nbHabZ/H+xdWqykfUqQSvMMzgV53l5HOIG3BEVa6Oot9Odcg7EY9dqwB4x45WHr/kK/WQzVHaLkad+AKFv7aL3kAmWAlWC8o7ppdt5XZVUD+i1apX+M/hU9UW7dURuaVdmxgY7zWh/TvVl2pzschF+MIN8WZBz9V1rXBnOCsHMbxcM6d6wXyvjclxPbVhfEg1/E6GkaQu56BecWHqQOzYO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JnKtuQajGzCy8lns2F3WROUtLKO9sTx820PQ7jv/ck=;
 b=JlxNjpjXPLKkDR7jS1SOVEOU/GQ3/emoASJddVjiSNEWUqCjxdrln0Cd/1iMSa5QUF/f1rOn+IebHx2OeUdJxTxxyPEkc2Tqq/pYu3hWjtfh4FMhsiTA/eEab5rhJV3uZzxG8I0nukDXVYxY7BV60iM81qZL0sZ0Ib+Lc8i9JFJVh/v2OWUH3FWG5iEbYQ5Yl2BRyjjvdsRJYgAtZLyvRKYddevce+40HijVJ1a6WIGHhDucOB6x6ZUdhJGouxNvF5JKKEvBsQ9bpsBXXj86svnnlc87bv1Ntz2n+es22eyBW6HPBFRDGQK7AA/rCwZ7UfTi+gKyYHUsPTMdnoYkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JnKtuQajGzCy8lns2F3WROUtLKO9sTx820PQ7jv/ck=;
 b=HI3t9H1Lswb3yBKZnFozLoabxzoh34I46RkuvGJGnYcGFvq98wZXTUvuD1K/jAtU5FFEUYwMOD21k9Qko9zcvxPWqP2PvuNVDN73ebpuUIhZzmonNH88AmWlBcsQujns6TG4r7ZE1fwQEA5edRMwPCtJGjmPYruMgASBPA/7ATjA8Ll5VRXZ02HmJuibLuO4TZArSkxKlzxakS7GoOgoKpRGk4zQer5+oFAlSGecQ2oOmE9VqCNuaNvIGxPex4BnavUvbX2QThiS8TQxZlRD8uWdOzfiqWu6/c2h427y8AzzZ9JOAnyVheC9F9Y6TKwacaoB2OCDzeZpZJxW+dS8fQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA2PR02MB7548.namprd02.prod.outlook.com (2603:10b6:806:14a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 10:27:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:27:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, jag.raman@oracle.com, clg@redhat.com,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] Mark Multi-Process QEMU as Orphaned
Date: Fri,  8 May 2026 11:26:57 +0100
Message-ID: <20260508102657.644247-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA2PR02MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 5baacc3d-a484-41b6-309c-08deacec5701
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: GAn4D5poE/SqUq3hjDFwoKCHOlPR4S101BaxHeBQJctweDllepyoCgEW81pHNm8sSrsXqdgixrbeY9duRt1bFJ7XACOqjXZoXV3x4vK3t5FJ2fhTJ+Yw/3LqJpG2vithHaPoznN7a3p36obZBsSq951WRsysiOBb8lfkYDLYzVUfdHR6PikDbPfQvwps5zUjKOC5jofTEgr4o9PtXQbuuO7TPNRr71zeQktErZMu1boQg1fxFaE+b4ApSUPVj3kA0ZwR012xTHDVXxqhpPw10jWi5m6KYuDoX2qd/F7j9pt7s+6oSOzRSFwP8QKZlcycCVcgNAeR405yi7dXA1+ZGgVjNQCjA5emqJ6tR8Ah13+HxS50e/haPGVBl/+O2I4gJpZOH5RigNeZf3AGn62KcFsoLlllCHFeoB71TO47k0VFfnl+g2Q/HZkgGPhAHbv/PckSQH70+mVF832gOcJcdKQgl0ns1etvwoHG9EGjjK7vUUUole+JF4sK6K5hCbmqXipqPUT1zjtmEwcI8bIjYM3tjxN6yvsHyT752m3RfgwjLSsivCFktfnph3b1K735ZQkXZ/W4S2ywJrFkxz1YxHr7KptkSmwP5ZZdiodJX0YpyKNaFRV4v9usu5YhMd4xjQ7t7YBBFMZ9JCJXWpENioc7ingDA3T8sUBLpJAvsNymanoQXITgnCGOUif5VMI/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVwV1axbeNbaQa4OedPZeKdN/bw+CV6FkbNyPgpz7EshivRosJZQ80ZJj/1U?=
 =?us-ascii?Q?pf7/ZdBW+EKEh0I1iHLBn/+4j7LX8OtxLsbEdkvkgBXRme5V4UUoLceoebrz?=
 =?us-ascii?Q?lVdSPG07a+xuvzKf8a0FRz2esggz1QLRvtWVX8Rhr9+NfHSt52O0uSLpEDWn?=
 =?us-ascii?Q?+JphPG+B8UKBYSPM2O+zQfsAOkWN3LLxLw3k1Q79fzPNirCFyXuRf3hPS1P2?=
 =?us-ascii?Q?VB+VMrlNjKNHGGq/zAQ7W0+9LO544dMduOyTnM9ebynY64P6bb1b6bWFhJsG?=
 =?us-ascii?Q?r+Iy17oLnYZIHxY0sEw82BzQv/oQyxN2duZ3ffZlt4V3nRJs9dDsBCwUlsKj?=
 =?us-ascii?Q?blKPJXP0J19K0YZnpX7hjSjLa8IE1BHXcJWjPomoq5FHpGMxxD0ZWGos+9Bh?=
 =?us-ascii?Q?k/+B1+f/eTwNTGMeNp4aR2D1ovnihACO6Z/JISkPsdp0pGLndDVo1rIyt89J?=
 =?us-ascii?Q?43h7WFN/aWKBMb4JJeJt/kEmw2oZdU3tAOArRxpv6EacnZFULCr5uJXc+NoR?=
 =?us-ascii?Q?LawhHRpMy8hAFODYqRMX5m9AaVqzB43RIx5/Gvh07tHTim/Rwlm0iIqoedvq?=
 =?us-ascii?Q?rYv6BkRfdvMqtXxCJupVXQvhWOURdZ3DQTOMHlA5q5mCTFGcrn71nOjXDHar?=
 =?us-ascii?Q?jiw+fb2ELRyIMOP/D8eNxGUzbrtbn1w+Kl6PoyoMBn90BoDBtCWl1tb0XPF0?=
 =?us-ascii?Q?pdwBg3q8TDWsZOxP1UgHo4n+vWs842G09azP2bQa1MFaJHvpB0FWJXWDDzto?=
 =?us-ascii?Q?4xG5PTGk7KfEI5pAKFKn2+dgxgfxDAnrxIEf0s1rJqTJizyUzrZxT7LvdqPQ?=
 =?us-ascii?Q?CLu8kdz2CMS5vtuRjNaaF8INeoMIhXHMg1EuQph8YtcyYVKLV68Q+7vOhMsx?=
 =?us-ascii?Q?AJTtPfHHzT24U2i8nt8yFlmZmKEuDFPIFBnAJbIPafksge+WFH+pNXoU1X8d?=
 =?us-ascii?Q?opaaLc6PQruyT2hGZyM0fALUC8908/6ZzGKjV4mig2tCdKtuo0GQHDsBk+53?=
 =?us-ascii?Q?10u+B1VqrrbtiZecLIMLiAVhPkF5WNlWg4cfANQSVuoOqJ0pYQmbLCV9rMqz?=
 =?us-ascii?Q?pleUJjBx87vVVLfU9uKhj6som3HsbMbxBVP7wdgk5AeuQlrLGB8L8YfsKU+r?=
 =?us-ascii?Q?JP+raxRYrvGzSBM/Pefu7a8ykZicHRq3JQX4qfIAsSUZVyqrOaJh/4lPNnx5?=
 =?us-ascii?Q?4qpVKyh4kJm5eAw4plZZdGc/QUehZVIjGgEstLHc/TK/QZs5xVU4O4+N9L35?=
 =?us-ascii?Q?pfb6AmNgx93/+d5gHD/s4gcAPOYWBcf0MGFLSFL744qJBEoWLuVqcxMB2S0U?=
 =?us-ascii?Q?rwIyW8XMiyHVR/LPPqDOfjGMgUnZOlWayAD2Al4miIaQm4JCGOMV30BezeQZ?=
 =?us-ascii?Q?/of1ottjGhU9UHmpI96elM/439eszv7OyUX6G4voZ5EojL8qkfhCMJCVzbiV?=
 =?us-ascii?Q?vcnFm+P9jDSyfAmlJCxTX+SGd3942knjFob1p+Om6QjC9xaFNo4pLfOBwPk6?=
 =?us-ascii?Q?nyeK0YuvaPsZidleKW2yhu2FR6R7MXr768JdkVZUrUEXcs340+E4lnaWp5On?=
 =?us-ascii?Q?0A9Hk12TnAzimi2ci8eyEPShLOD8mqnmaiebEfCxaK1RwsvjpvvtR1Piun2V?=
 =?us-ascii?Q?SaSIAOoaZ/JUBpvyl/3o6L6Ep8zDYuvSWdojN+9nVbbnK3usida2+ZW2Vf+d?=
 =?us-ascii?Q?WnOC2yPblI7DHCyjqkc3aWah+ZJKgp+BoPfZCjtOpCXbz0g3VZz+8MM7xH5l?=
 =?us-ascii?Q?JfiauwZPZg=3D=3D?=
X-Exchange-RoutingPolicyChecked: gkAbQmbX9rRP/p/y4/oh3xJbq0/Sg0PI/ZEXaXdNMh05gUZGL18ojd1Yr1lOkGjELF3zp+5QF6/DacrerfaxlDstcPfMGgycdpEoH9ABpvq1BViiK3lg5ycGXItEo9Jx/M670wh45rAHVVE+8vnysqgYOO8LLNL2XEorfSNcquaU96qhH9HglCo/CXpOOkgBzqcAm2vRmDI6dP/ReQ7FHQ2veSrKCl9ebNLmaxCa8NTPx6gBUwEpMsSWXY4LqrcX80Y0nX+fKoXXb84WRX+M/fZ/bGgAnnSDchghgy+JNJr+bIohb0F/SG4hB3JgBKlKWwWnhwx523Jh655DtxQJEQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baacc3d-a484-41b6-309c-08deacec5701
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:27:01.7146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/S54jK8foMpRdzmR24R1TrVhhNYzCBErEoHR/8X61RXsoO7MaGAfo9c0FqtEYf5VSv2KYNsmWSPUb9FcKQXmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7548
X-Authority-Analysis: v=2.4 cv=PcHPQChd c=1 sm=1 tr=0 ts=69fdba78 cx=c_pps
 a=x8fXg9NzY3hbHNzXWQS9+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=yPCof4ZbAAAA:8 a=Bv4DKuEdLmPPoxUc4yoA:9
X-Proofpoint-ORIG-GUID: EHiB-6iG2ERlHxFVpn747lIShuFWgjoP
X-Proofpoint-GUID: EHiB-6iG2ERlHxFVpn747lIShuFWgjoP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwOCBTYWx0ZWRfXyluYsfmk9lD3
 2C1X3RiJHsATHDgjYKAwUr54T7Bo43p3MPP2V27dNM7lNtOJrXIc4cakyNi6xQn3fXEXJwsC8X1
 IkubSix23zNpQV5koC6hoIwnwE+0SmZ/TR1QlPssNkKBkTB/6JnINuIrhUpfqXoJHgNTJqeUGKe
 CPikBgy89mLJO7eIQ8Pqz2eIddpuOfiDihTHrFOm9PzIj86IrQSJ4zfHu4jmp0MsSkfNm8zt3Vc
 cpTemYdcNNEaZy5rKzTycIjzPHC5ejIlD67388hDxtis/F82rlav3f42uHbhKlobYxhM2zgLIRZ
 DxGBpspxWxxskTeS7PAahOuZ/Cy/JtQx4hhljknwkSFrDasdguvMfQ7YCSY31gXEDjtNkFwNQSy
 oNm0APl6E9F35fpOb9meeck1oJePr9T3BlXMuZumt6XVNhnL6X/oIEoC2SmX2s3+MlJO4Otlr9g
 X9Qia6BhY76E3n9gzJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

This subsystem is no longer seeing any development, and the primary
contact listed as maintainer has confirmed they're dropping support of
it altogether.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a90204ae9..ce2b494086 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4429,7 +4429,7 @@ F: tests/tcg/aarch64/system/semiheap.c
 Multi-process QEMU
 M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
 M: Jagannathan Raman <jag.raman@oracle.com>
-S: Maintained
+S: Orphan
 F: docs/devel/multi-process.rst
 F: docs/system/multi-process.rst
 F: hw/pci-host/remote.c
-- 
2.43.0


