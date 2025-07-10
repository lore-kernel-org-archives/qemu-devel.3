Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C99CC83F18
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2n-0000av-AN; Thu, 10 Jul 2025 04:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2k-0000Vw-O8
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2h-0003ap-NV
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:14 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A6bTJG025383;
 Thu, 10 Jul 2025 01:54:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bhW2GJXHa+LjH1mbvQvH006rmYB2gZrdpKyHb0ly7
 TY=; b=y+RhqCvetq8hvVEd3ZEiQNRqQoRZycuVM0aguOCdu8d3NgvjrnlwQB9Wu
 ru5a6htQE/RX8zjQ1yVFM+mzEay6M9tfkjreQdOQxJF25/RAz6/NkAq2+NJX+eKn
 EA3aw5igcBK64aOIFOEmlpfh31kH7DdQ/AJkvpdEUZtGATk4quqU3bfDQHxbkW1v
 crpkhd/iMSL2k1kMDO8qx+EEYkowRczs9hSwSvPwJNuL8N41ouZssO9QYrxADKXu
 iDVk41SG/PfXoF0B7ZBUckDNea8oCz4P/Cu9XGOo5UIhagNrOAU5zbpBu+RqvU8M
 6i+UsI+LVG+EgSOhH+sPgpAN12fSw==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020111.outbound.protection.outlook.com
 [40.93.198.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3m150mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO3gWIJv1jMXAjBFi/7E0P8xnKZELFRyyk3wFdIu4cAxnauRojKasuASKteytTL8KSApTyHnbNXTxHDUlA2uxLjleaz8ws2WpsHQ54vcumt8NcXoJxF0khM5StwUWEMh3660iWpa4sisqWvrLoo/z+oT7gBXDvQsnerRgBFMfn5Tg6texHyZRh47M2HgeKqx7BkdZPwOKFOqXPatRqrAN3zoNaNbQdiubk1RNKRvKgU6HEQAPJDdfJJAi2Beu0Tg5HUJGswFtyf5+Li/e5i2wWSFwFsP84GCncsUwOCpMJ5A4KE2tSA9GYoChnBRmhlmQWJ3t/iZYYjX95O9i5R4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhW2GJXHa+LjH1mbvQvH006rmYB2gZrdpKyHb0ly7TY=;
 b=cxCIRXkFJqtZn1C2aKUJe9DS+ihfH5YvEARwIjY4bjaRLw78JoR4KKXFLcCJW+bJ/CpzPYS3DJT8DeABKAVHOdnW/1e/J1bEtrHIPwBBKOFmMxqVnWmmnTjX7se9ZgevYMlX9ispDR23bn5rNgaat4J2zjMsBeHgLPtdPz7SoYotzQF2v1dsLT/QS4nUsnUuxZQZF8fpkPQEcEIuM9Y9kMBcHTf86sBH9OcQyoeDl4OB9DY43daCJ0K8Y9TZ1SDnv8msjN2JJuY5SdpTuPaC4CKxEf+6AuOj4dGxMXUdCy1NouGbR9ycfk9CK7ft6J4YI9fLv2+dcAoY9xtwnc1tAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhW2GJXHa+LjH1mbvQvH006rmYB2gZrdpKyHb0ly7TY=;
 b=yN/6jdP0V/AmYmyq5kB86vXDZwag2IJAuQEEZ4eYSGhnuLi3dXY8KMgiF4WJomRWQfEe1jV8Xi6IzHNUgrb7kZeDwVXa9k/RY+UiejIomKHCd2V4JFVuQ4tAEkeztbbEUSBfQnaVDSNyFImAwr8r2CKx3QTs6NEewrOaN0fYkj7juTdl/JdeEbXk8qpdLdw3Sv85eVb0QnItFN8ZD8ccXE1vnUl62Is55Vx+X3O/adWpTnzRSdlNCajbUjFmI1yaXjXK1gspOWPgxv0wvuZJspECteDX4y4/vyK0Rqhl8JyWYLF3wx2+CZipjf/WXS9id9r/TMNE8tUb6lQshue75g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:54:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:54:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 15/18] hw/i386: move isapc machine to separate isapc.c file
Date: Thu, 10 Jul 2025 09:52:30 +0100
Message-ID: <20250710085308.420774-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 52976221-19de-4cbb-9187-08ddbf8f53c8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q5NBJOW/9KYdLjLpqvgu1lt6lT3HzVYP/GMXKArvFFb2gsqA2CCHS/Qcl/kq?=
 =?us-ascii?Q?hHTWjtHOLn1z7YgBMFK3Zpc/1efL2mn93lKrnmkIsBmP5HA/m/yglbnvRG2T?=
 =?us-ascii?Q?Xnp9TfnDe4Slf04VB+QZoSv2OVt18vivqy7J74z6PEoGPyDq0gvtMHZudb6d?=
 =?us-ascii?Q?q6aOIGhEHlXJFxqTP5r4ZLSVLxpbqoFDaLDQBBp7+S3YRZO+v/5v6t7IrcK9?=
 =?us-ascii?Q?nbZe6gK74yJtfGg2Kf95Zf2u8d8nMnOTiTWzWc/Bk+G2x1s2H5kHxvkFaAgY?=
 =?us-ascii?Q?U7hoDj32f7YWWOXJOSz/+ftz5o4ji9OOHWglm2QfIQJ/Zfl2IBCGO7iN69q7?=
 =?us-ascii?Q?aGXbSm86PC+5K3z3iWZ/KjixALiKHm7DOAC4SPT38tgr9WeTBNiTMCLrs7Dz?=
 =?us-ascii?Q?cIQXQN0zAR1W5NVZmpM4CXKKI/U3pMn9c8F48+BSe/yHXfIlPmE/VwvAFuCB?=
 =?us-ascii?Q?hxvEWT4LbXJCwrEJIL3eu2dYKzgZjDzljDqlU4UhXUmtOru5EBxP64pKcOut?=
 =?us-ascii?Q?0LGkEMgIWSBKNG2KzPBw+nUkCfCp8/53gX6HjKzKTtDSvKLJVjulc7sQ5ahb?=
 =?us-ascii?Q?pYWbUQ6rSX9rzLbizmjbLUn6vrfhFQgVgT2UNCEom4k7i4ycS5PWLlJCFwXO?=
 =?us-ascii?Q?MsFN5UuUgxKfciwlukoKK/0lRafT0ox6sUZ4SIUZ00yz8nFGGwfnIxCVzwee?=
 =?us-ascii?Q?Txno/+HSgQpJRXWzKXdies+52z3t6pMdSHGfT6FnLy/QltNaBVu/gy1lIs/m?=
 =?us-ascii?Q?MMIImsGHnU4odQbB1jgHF/rvRiB08pkjZXqXJ2Wqq535swWD2it9ylm0p05B?=
 =?us-ascii?Q?cGYbDXemXTCxJhwLcDe+84aB6MmPxohatQwsjJvoZ0zteLkp5OY4yXcjXNA3?=
 =?us-ascii?Q?p5ZNi92VmB/z2mJTV82R9mVInMB70cIEjT0D9nWna2B8IDeCdr4YUF20hdKQ?=
 =?us-ascii?Q?4gN4bD+5Hgr/vR/X80GcumGXibNALQjiwR97XI89dWuVOZUH6ZSlJY2VBO3M?=
 =?us-ascii?Q?vFEGchKHXgnZkyrhfPH3WWwVjNbsJEnGwylR7ANJ300MIJHVm+8LBcEdflRe?=
 =?us-ascii?Q?E7purk787jRkIHMl3R39h30HeSLkajn7YRkFahCOBaHr6ePG9RtQypr3gp9D?=
 =?us-ascii?Q?13T7H8HyzSQmYOxoV2URMTPSlowPy1pckjKgVk20xhmZQ3JmWbZvYcPpdWdq?=
 =?us-ascii?Q?RrWs9hy+WwI9JU6j/OkrVEAMFZ+0dpXqEq+cZ4O+OmYmPL8IX2p2avrYRu0p?=
 =?us-ascii?Q?SG2GWogJvmemQLNgWqM/K/FNHd1dCBNS3ZYnGBtOzaQa2cgSJ+vKIutDwOim?=
 =?us-ascii?Q?HYWAlMUYaDSLhpc5/KowFuw+YZ/JiXYYFhCpDWHPZ8+W0Y2WfcDn2K+gBrD3?=
 =?us-ascii?Q?DnsvxxQDUyMJu2HOqaWVMCOcu7v1qYetOXNxr/MY5ouwwLOFeIcNC2rJX7fj?=
 =?us-ascii?Q?huEdKkPMR+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzBnGr4VuSYyWMYjAY6i4uqRN3VH6sIhbYvWNqp50PqzfZ2VW/gLrhyPEdud?=
 =?us-ascii?Q?YWj5mkBNRiqpsQVr0JHcdVgkgaAPIeoQfxwE2S4XJ6t/n4ukJ9nx2JNn8D0V?=
 =?us-ascii?Q?zi1/kQWYrO9feNhgDV47pAefcrxACFJcS+HBmx4Qk6q+CaKlaE1yUsHUe511?=
 =?us-ascii?Q?g4F9H1mjKkk0qSytTUEPi4REX92PziVy+XeQTJkn9mgwA8cXqFzPJNAem2sg?=
 =?us-ascii?Q?NaRrVNO19cSCkdr+lPK8QJA7AH2ia7bwW4puHVFVezsyrWKd1SzSFa/vA1KM?=
 =?us-ascii?Q?u/a/rvjPraiC4BlpVTTcIsns51Q6PO3yWTLEW++ZUz1ZRo7x9SkNWb3fTA02?=
 =?us-ascii?Q?FJ7zxrZeTXjSyujMatsYavnIrfrZmuII4t2T2IHUA4qWk1wnRg/scIs67EIL?=
 =?us-ascii?Q?iPMwGLSYQt7Yj+G8KmE+acDmOMDyUbV5dJNw9ktKksWPEQWnYs2dmEI6glN2?=
 =?us-ascii?Q?pOUCr+STX2lKwwpySwu4vSnbgMrVFxRCMsc5m44P+zU4iQN8/tey2D7n4kuk?=
 =?us-ascii?Q?Cc5QsQ/lrAvVExkkxgm6D1Yc7cISrc0WADjKNyhAIFB1pCmVM++FwyD42Uuq?=
 =?us-ascii?Q?+oqDQgncGQy/u+S8TtUtQN0gY0qxqJuJe4+4jp4yhDWRHWJqMTw9pkz5+LSa?=
 =?us-ascii?Q?jiGgvPNaB06NjfdkwRj9JJdsUswpTNpuLb/5We0cCHAg96a89RK7MHScBtGX?=
 =?us-ascii?Q?scic53etzhU4g1YEkKUxTKnXtt4zjLTMe/2qbcO7UkKCfEhrd6csZXiz0i5p?=
 =?us-ascii?Q?hnVH3HQeZ5cejb4/umlqFAEg+sWE12zTpQFFoW42ZtXcJCpIkcRCkxg37EuP?=
 =?us-ascii?Q?VcKjP3+87FaADNd8WXdhfeloUj72edSL+vI6vS68vSiF9/pez+Y0DpGV12qm?=
 =?us-ascii?Q?gzQSJcfjq+EgNnHtLwAMTG44ho6g3NgRSqpwblO+VcywfF4T+ESvdrzx12nR?=
 =?us-ascii?Q?YXYSmd9yHdD7I49E2n/APGkImqFTTp6D9tDk2pimMvBepVPzfM7MyTWlSTZ4?=
 =?us-ascii?Q?9iL0Gns5pA9d6xRyFm08RrDjgybjnZ9eEhzG8BwclifkvIpXdtk+ioriHpSd?=
 =?us-ascii?Q?vKVwWrsmvpPlRpzyWritdu1yduWQYeY4Ah+WigUWBc93yVqk9tEEJn0z0INF?=
 =?us-ascii?Q?6+o+slh1JxZjiBxovvVjcxeLc1soX6kyoUfKnpkWP33YiGjPygySXlNfJCxz?=
 =?us-ascii?Q?KAkJX02GACXcSY1QmbQamgIi0cEND1wPekzYZm8yHwkg7UoGrsyuamEr6Lax?=
 =?us-ascii?Q?/9RGIwRjEjmkbfeRJaHL7pz/sp0M1dwKijIXPs7BQ2ZLOOFE1fZBKMccJkhH?=
 =?us-ascii?Q?BCAOw3EAWR0Blx+iS7ib95WnoaDSZ1wBW7WY91MVQRw7X6PJQjVok6m0BA4i?=
 =?us-ascii?Q?XZR83YyusJ3RtU80j4Obg8aQmRUhB9z4saLOi/OSkU4s0BIWv5Noktzu/KC3?=
 =?us-ascii?Q?y5IiXtZKIpExMY4KawMpV9GBqAKvB/S4xV70plC0NqVAbT1B1hnJSRh6l+U/?=
 =?us-ascii?Q?REmYp6GYsH1rZW4WZv2yCLaRiFlsazukdVlJQNPQ+sjGVVIjduFi4fYivS/B?=
 =?us-ascii?Q?DNprn8R/Qw1N6rv86deKqYx+72ADmXknkQtwe1rbTVYx9imJ17o3WW4TXR1h?=
 =?us-ascii?Q?8YXzqJF93+Im6HTbz9dVptgBVLg3xNm3aQ3+JJPxmizXc5UiiYUog5pIIcl+?=
 =?us-ascii?Q?7uWdfQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52976221-19de-4cbb-9187-08ddbf8f53c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:54:06.4414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYRJxdR9bOmtKrbGWGKdKuOA34eeWOaIdMg76rX25KeO4nzlLRm8KUzuUIT5UpVbLX6PhUQ5J4MXAE+Pfche9pWOQFmMZ1s4gohNZPaTcLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Authority-Analysis: v=2.4 cv=Nffm13D4 c=1 sm=1 tr=0 ts=686f7fb0 cx=c_pps
 a=Lghs/6261MT82QrUgbBUQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=pGLkceISAAAA:8 a=Pbl5c31VFoorxvNN0s8A:9
X-Proofpoint-GUID: XXmvY853oCywicY9HEQ3SfZcKDKjFqox
X-Proofpoint-ORIG-GUID: XXmvY853oCywicY9HEQ3SfZcKDKjFqox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX5X2QExFnNXBu
 /Lyufr0KrWrz84kNpNIgSt0j+7seRINLWEfvFGBgm3E0ZFG92GhftXj4HLXhfHtaFWG5XsVyHHX
 eWslq3rf442tHgdmlX5aR/zaWKjR3BXhVMU2dmOYpSzgmls2dyNqsymZXgMs2mnr7picnBL5Svg
 jxcy7MUQOCcZ1ZEgfk/ih78iBQfIcg1nI0KpYLV4hQk0j/nqUVTBHHrcCuAYwYfVvDnNvBfRYbx
 P+vS0EJK+sPa3TLbvGCfvODq0AmD2/OYkSTKRFUV6XIP1aCVtMmqdXIZIKDyWzwZje6StNPIcyO
 YqU/OJfxgbfpYItwKlBosVzm9oy3oWMljjh3rGVfdZsGp8aqX4PHvzMPQ/RdkBlWVoKCEFHZKpU
 CJOwQ0y2GvhSWmlBJ+fWS4fnvKh2FJXoGBgxgGsfD6e/DmjPzWp8h8O3GZoaj14kuNM2B9xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Now that pc_init_isa() is independent of any PCI initialisation, move it into a
separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
I440FX in hw/i386/Kconfig.

Note that as part of the move to a separate file we can see that the licence text
is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
("VL license of the day is MIT/BSD") so we can be sure that this was the original
intent. As a consequence we can update the file header to use a SPDX tag as per
the current project contribution guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 168 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 148 --------------------------------------
 4 files changed, 169 insertions(+), 151 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 14d23e27b5..8ffcc9f7aa 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -96,9 +96,6 @@ config ISAPC
     select ISA_BUS
     select PC
     select IDE_ISA
-    # FIXME: it is in the same file as i440fx, and does not compile
-    # if separated
-    depends on I440FX
 
 config Q35
     bool
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
new file mode 100644
index 0000000000..bb22083821
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,168 @@
+/*
+ * QEMU PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/i386/pc.h"
+#include "hw/ide/isa.h"
+#include "hw/ide/ide-bus.h"
+#include "system/kvm.h"
+#include "hw/i386/kvm/clock.h"
+#include "hw/xen/xen-x86.h"
+#include "system/xen.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/cpu.h"
+
+static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
+static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
+static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+
+
+static void pc_init_isa(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    ISABus *isa_bus;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    uint32_t irq;
+    int i;
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
+    }
+
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+    }
+
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                   &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, NULL);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                           ide_irq[i],
+                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+    }
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    pcmc->pci_enabled = false;
+    pcmc->has_acpi_build = false;
+    pcmc->smbios_defaults = false;
+    pcmc->gigabyte_align = false;
+    pcmc->smbios_legacy_mode = true;
+    pcmc->has_reserved_memory = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options);
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 7896f348cf..436b3ce52d 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cac016df22..b04c683e4e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -70,12 +70,6 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_ISAPC
-static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
-static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
-static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
-#endif
-
 /*
  * Return the global irq number corresponding to a given device irq
  * pin. We could also use the bus number to have a more precise mapping.
@@ -372,111 +366,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    ISABus *isa_bus;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
-
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-    }
-
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
-
-    if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
-    }
-
-    /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
-
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
-
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                            &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-
-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
-    pcms->hpet_enabled = false;
-
-    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-    }
-
-    if (tcg_enabled()) {
-        x86_register_ferr_irq(x86ms->gsi[13]);
-    }
-
-    pc_vga_init(isa_bus, NULL);
-
-    /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
-
-    pc_nic_init(pcmc, isa_bus, NULL);
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++) {
-        ISADevice *dev;
-        char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                            ide_irq[i],
-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-        /*
-         * The ide bus name is ide.0 for the first bus and ide.1 for the
-         * second one.
-         */
-        busname[4] = '0' + i;
-        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-    }
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init_pci(MachineState *machine)
 {
@@ -838,43 +727,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        NULL
-    };
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
-    pcmc->has_acpi_build = false;
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
-    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
-- 
2.43.0


