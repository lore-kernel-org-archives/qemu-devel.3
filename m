Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB63C369A6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VnM-0006Qc-BN; Wed, 09 Apr 2025 09:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnJ-0006Il-Rh; Wed, 09 Apr 2025 09:48:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnH-0005e2-88; Wed, 09 Apr 2025 09:48:45 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5393wmNF011859;
 Wed, 9 Apr 2025 06:48:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+vs6j2ljEDp01+LRO6q8hF5ca2p4JL4hYf31I1a6i
 ek=; b=2Gji95F/4wZaUUtaG2f4U1jnpdSy0pduhQm4XdEyfcak3qSpYN5BO/Act
 ptzUvr0soLFofMC9/GtHOMQaCPfW8yTTQKiAb0xL4HHuYuXdOnxLPBmIzdsn3HTY
 WobWZjJAckEljjPVfzOeq/wodOmRKtWdfK9oJ/Dt0rR6JFK6BKFFnQyAwgS6R9Wt
 uGG8T+AoWTVRL0f6tiLJf/SrATgukiiXBC113McSGloKnkPriKOekcqJ7QMUy4Pr
 Pl48IaW4CcmlF9wRNR6xn6Lz0immEjrm+NKAmccLGIrNubzKCAvCklnJvUNiJEFT
 0Fab3XFSsXBxy1J4L3/V9IxiTBZvA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazlp17012051.outbound.protection.outlook.com
 [40.93.20.51])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u0ut9jx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0dylAn7PItTs4IjdpPwia4wyUepwqu7mOrq5L9891J//7JB23w9F2jWf3SC0ZEJ1mTPE80qAP+xI7KOqX9jYrDLw3eMOiKdQ64lCzon0Jyp/UqElmueOXNRllteoLzturpDEU4FrA3z5xoaeZke9alf9p6OFbFLHnE/zmOunPZ3loWJ61qf4t8AqTWzl8GtUVYftxBqSmksV9UfRStGCS1IXqBwwTdo+qvAxz6xMUzvAoJHb5/uMWjaD8AIKUzSxQVcUxmJeFpErztUVVFVCv5cAiCFYR98la2mjKssV0IapTX/86kjMVLL+A7Ce6yKGIvOkknQp3DEcb1M1Wzs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vs6j2ljEDp01+LRO6q8hF5ca2p4JL4hYf31I1a6iek=;
 b=GNJzeIpET7ws8lvJmCJndM81ML+Su1TM4zVq/o0hNXnY6aheP4ieKOk0SwGKCMZpQ7NYbiEmPoJCLjMyNIOFtpO2Sx64qPQ/TbVm8xxodP3JYiL8at/D0GbZ1ePHHuSrCGA6F5WrZrjUuly6LCgkeKX3JQjwkap7wK8Nr1cxLhjZQI6crL8XUom9nEf88vhGMb3F6qzUuELmLlaCvG0FUgzHWUXc5m3v3GtDK0SRDYd8Y9rjil1vDM7h38Lat35ZfGtb2s7Udya+njIE9i/52UqZjLL7Sv4HZ9ZDTaI0wWzxGYgQw9CUc4e88rVY+7IKjxiPiCenZIlq5cuahLnk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vs6j2ljEDp01+LRO6q8hF5ca2p4JL4hYf31I1a6iek=;
 b=SxMuWPAZqQ8CCcuNxvLz6cx8klQRvMaJDOicXWKARDcUhUKrsRaGQ8K8jAJarKxUPp6zn9DJsDeYalF+8IoY1BD4+ibfmmkSYw3S1bXccoUDLf7LdFw6ReKo4NZ5OinsmbIIv+ip/4aS+LEyMgEPAZ7GqOM/YpXIsXLmokdpNOUX8cJqrh4eyuRqn2Z0t8MW7GSaZqfdFDC6IOdanliAXiCp8Ct6OS/o6vCr/Mme/r7yN9INYGO8sSmIQVM5bil4z+b1qSAM7NfG6g2E2N7gTw2VLlqEz1NsS7J1KfYP3CwCNtyRZSv0hDv6HZrIXERgS6dO2c9OFKRX8OrI+dr6Qw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:36 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 06/14] vfio: add flags parameter to DMA unmap callback
Date: Wed,  9 Apr 2025 15:48:06 +0200
Message-Id: <20250409134814.478903-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409134814.478903-1-john.levon@nutanix.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 48198ca5-f840-438a-2a2e-08dd776d39a2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2axyowfBjpSqrWveFFbS0ESedY0wkLbY9HIbWpFvwoFOQwb1xhMMTHwSndsY?=
 =?us-ascii?Q?52NXYbzOh2ysjFyUjGZp2SKPpS+cXuvRia6cbN9RmD/IGl5pt/44IP1mK28d?=
 =?us-ascii?Q?zEbJ3vq46zarEk3DWBtHLY14cldnIBE+pq3d3aNoIddj9Lhyq3Vs97WWe/+E?=
 =?us-ascii?Q?uplU0YWFLvi9s7hf+dtBeesO38/RC4DvWhkKJ802YboVo5bjks6pxdQLnkDE?=
 =?us-ascii?Q?RYZhtm4AmeCLhuzzxDqHeLL+/KdkJmXAkOi7CR7MZ2lXA0ljnRCGfDACZpTZ?=
 =?us-ascii?Q?R+U4eFgF2Hl3X2QmKEtVJEIfmJDinCzxDb1uBJubYCK1Z0WD6HUKtVoqPe/E?=
 =?us-ascii?Q?PanXUIWTqvlOGQ0NGrQsBzqJBJk0f2FBBuWbnYFt0DV1yspstXYXdrxp63v+?=
 =?us-ascii?Q?KmVPFRjiqwHPyxDhbQsXW+dhNosygeOPZT0WzWV8e0o8ZowGy+tKsA78PYQS?=
 =?us-ascii?Q?nkcWmTI6j7UUSsgfSDLSxF4YePBjYiRN44TYAPKV18e/eZTd7zFl8g09m01W?=
 =?us-ascii?Q?QqwHVgeKKEq691fl4RpTrAd22tsmQqsgnMJhoLW3cr8PymGOhmWBGvrZvKpw?=
 =?us-ascii?Q?kieBba6PUcMFecpBpg7csb7PbCo+WVsVaQFGpo6P77CDBFGpouop78SCr5k2?=
 =?us-ascii?Q?GJe4ZpeY7UcxztEp4MV/RJ9dBWrFoSiIxh0Oz10NVFZFrLygMdA22XIFPa1F?=
 =?us-ascii?Q?0rHFwzozh5MblFtLpOMPbeZjplLRuEVPU1eVfqrBUOzMQZxff31kNZvUrtwF?=
 =?us-ascii?Q?lP1Evo24fuERlONnmnIDt/H+tmBGsYZMj234SJXOpRSZB3ZAJnXRURbiP3e6?=
 =?us-ascii?Q?5GavYmt+11mj8zRYU7wfpZwKu5gluYSXKf4l3m4la/95NRu7GQzRNCWKTmOt?=
 =?us-ascii?Q?w5ehnnbQnIO3lMxYzOAU+YNHdrsC9y/ssYfE+a6OcKGdEozSl9q831TWaAu3?=
 =?us-ascii?Q?8IyediC3GBx0xzXjXD3LqIeBuX9/a64veT9EshAm3lTQ8a6wTSQbyvHjIICo?=
 =?us-ascii?Q?1hhEe+ZPRYOfYjK102ry+MWyjHypX/U9YpxCjHzewJbE9yGIiKHr+YEMjX3U?=
 =?us-ascii?Q?twjHudVLZp48V+ul0bKwnWtybjn5Rfh97TAeXMXQqxve7o+/eomUU6rHjsgf?=
 =?us-ascii?Q?ga3PR+1bvBFbB9+h4dlmR6UA71GtY/5mcFBjubEZG8YYVy5Cw90P7WkZHz74?=
 =?us-ascii?Q?P8O+VEkfi9t8Ddk7VAGVXzM8y0R4FMda1E3MTedrQKIqHLdjwqPzLjLG06CM?=
 =?us-ascii?Q?4ki76v7NQyEjNX7Vzyz86Wf8JvW5WaMAoSU0IT5CHKvTyewQ0Quedk0TznqJ?=
 =?us-ascii?Q?mQtIoTyvMZvy/JEzW4DT5MgHCBL25UrHhR1gMpsRautLLcub4wWtedE0MSTS?=
 =?us-ascii?Q?bWpet7YcXBG5xBCZm7tjgVym5SaE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OhzidXDhwy7S6U4EqfYpL+GWmWyKVal5IQwR3jAb7/FJzKaaZRRg1niaPzIN?=
 =?us-ascii?Q?BpC0HXrrFXpzHf4PJizepviXP5pHUEUJtLbUkTxPuQwPkgsvcSkXX81V7udf?=
 =?us-ascii?Q?RpVJbcY2eCRE78GaBbdPRCqDnanunH/NPGoAxYtfFwCuOztp6tS1iAXhEkHC?=
 =?us-ascii?Q?8YgJiDEo58hbORuDyzLQM6t92bPwcPmMtqgWn5jJeU6V7PyyPlpU6kQh+E6F?=
 =?us-ascii?Q?Kp6LCxfDWloGp2bH6K3D+d6lgNpcwQLIgV3QtFVTA43Mfg5NlMYob1VQbFC6?=
 =?us-ascii?Q?nz+LsfTSqZU0Ec2oROMu6YV88JFnV2Cxdoz+oGeZ8z4fpETH/d10QLZJIr48?=
 =?us-ascii?Q?daI/zoTRuYlXAxqR4nXyZHc4vJ8cI+2RW51YPJBp4QFWK7IVnfHFU06UUicz?=
 =?us-ascii?Q?UIBremr0OWSzwDTOYuWPIHgdmhotSL+cFbxiqt6NIpe5kvD4/GTrqV9M/6bi?=
 =?us-ascii?Q?w+VYB9l36qWhwWpO7g/LI9sqNXBWAfig2yONvOGofMs0KnDC/RvX0v5TkIlp?=
 =?us-ascii?Q?hGRy8cUcJHWbdmfDCIhCywC/U698TLYrO5Ktlf5rLQNlxSNIVlhM7RFTa0k5?=
 =?us-ascii?Q?1KWTi19k9PHe5B2bLK2qYoVdDZyKbhvqSifFEkpUObISsPSqJZrIoiCyhTw+?=
 =?us-ascii?Q?F5eTK1nESIvvAnk9ZoRu/USBf93bWiyRByLgdN48cAtPqlJqCQkvHhgRZ7Oi?=
 =?us-ascii?Q?3ZQcHFpOQFtIRcJoJq+GI4ZwDY2RWVx2UT0fOig+gYpTctI7Hsbe5pks0cQs?=
 =?us-ascii?Q?EAYN2jWU7NR2tQEP1IohsiX9RpkA/UZQrjLCj+Fysg4JAxC7irW1tqInFLGO?=
 =?us-ascii?Q?l0hmsmE6TNNy95t7hhU1u2MZW9M6sO+qU7+ga4HBWwKd6ze4kqUpasad2GtU?=
 =?us-ascii?Q?Bay1U3c5q4IXBxSJNSjJ3VWCf2PAkKmJe/guewFNU5p0VdwFXfKdtmLrz+QT?=
 =?us-ascii?Q?jY11kFVea3CP2FpQFh1cBZhz0XSFAcHVzDklq8buJvkoxTHJecrdwHClXLAN?=
 =?us-ascii?Q?f7vhKJpLII3sawTVrHaO4RM8SOYivZ2nmLesvRiXxpvGKo1WBMvB5vwHViMD?=
 =?us-ascii?Q?zvYlGNO8uNcHXn7c6kP3WigvAH0wglTTzQrErKABIDhyInLXEet6ROA3Pxdx?=
 =?us-ascii?Q?cGdrTgUwcYmXnB4l3hSMaWlzF76YDyWpJAdEOwuGtrPIp7SrWXE9H99q0rBA?=
 =?us-ascii?Q?Ag7eop4cN9Ye5yr1D3hOK4wSQ6FI6hjSzg8UGoBR/r0NCL1X+6MKE9SQxF37?=
 =?us-ascii?Q?QNQ3gau15YHAhHS1sBkXqzqEXU6cc/YbOl50ngihClp8R1dfMnoPhR2xFlv/?=
 =?us-ascii?Q?irc5Z6N1pxgQ2zymKHP3upZMrMfxrH19i6qTChZxUaME7SYu3C1U6JnbTKCC?=
 =?us-ascii?Q?ucUl9oSt6xldZsnQCx5oMMtotRqmkZUhIXo9KDQ06SH8glDr3jwNDKV09nRr?=
 =?us-ascii?Q?ZAPYIqgDwg/f9sfNfvoZX/p222lSRA6gLxRRoiDXVJGq1L7QQ+KNPgAcPh/6?=
 =?us-ascii?Q?agyeFRE7E5VqzwC14Zvk06soNMUYwyptZTFLzb8ADaZM1Irc1Sml1wPLtDTp?=
 =?us-ascii?Q?1GiCp83XOWzmUbL7bOyMs0kS5N/tpA0HcHPe7hqe?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48198ca5-f840-438a-2a2e-08dd776d39a2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:36.0140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5GPpVkCdkQpjyVcIzU+HJrvNSr8eX2l/fjIyCHGI7xu+5CjCNSDLP6NXI1r5rlgSxF0g1fcSFw0EqfSMmOqZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-ORIG-GUID: bQx0jMn3lMVYHta9QGoVTrFT-ZAUYGtd
X-Proofpoint-GUID: bQx0jMn3lMVYHta9QGoVTrFT-ZAUYGtd
X-Authority-Analysis: v=2.4 cv=SpaQ6OO0 c=1 sm=1 tr=0 ts=67f67ab6 cx=c_pps
 a=s+CWjU1cAxIdjlq2nM3SAw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=wam52ssa2_Y8bD6HYSEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We'll use this parameter shortly; this just adds the plumbing.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container-base.c              | 4 ++--
 hw/vfio/container.c                   | 8 ++++++--
 hw/vfio/iommufd.c                     | 6 +++++-
 hw/vfio/listener.c                    | 8 ++++----
 include/hw/vfio/vfio-container-base.h | 4 ++--
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 726aac9827..613fe1a00d 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -85,12 +85,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb)
+                             IOMMUTLBEntry *iotlb, int flags)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_unmap);
-    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
+    return vioc->dma_unmap(bcontainer, iova, size, iotlb, flags);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4fc181d33b..625bbe82a7 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -124,7 +124,7 @@ unmap_exit:
  */
 static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
+                                 IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,6 +138,10 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    if (flags != 0) {
+        return -ENOTSUP;
+    }
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -205,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
         (errno == EBUSY &&
-         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, 0) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 1874185fcf..07334e65b5 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -46,11 +46,15 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb)
+                              IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    if (flags != 0) {
+        return -ENOTSUP;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 9ffc2deb2d..c52d4a52ef 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -173,7 +173,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       iotlb->addr_mask + 1, iotlb);
+                                       iotlb->addr_mask + 1, iotlb, 0);
         if (ret) {
             error_setg(&local_err,
                        "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
@@ -202,7 +202,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL, 0);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -665,7 +665,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
             ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL);
+                                           int128_get64(llsize), NULL, 0);
             if (ret) {
                 error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                              "0x%"HWADDR_PRIx") = %d (%s)",
@@ -675,7 +675,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             iova += int128_get64(llsize);
         }
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL);
+                                       int128_get64(llsize), NULL, 0);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 67373e8db0..6eaf2b2430 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -81,7 +81,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb);
+                             IOMMUTLBEntry *iotlb, int flags);
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
@@ -127,7 +127,7 @@ struct VFIOIOMMUClass {
                    void *vaddr, bool readonly);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
-                     IOMMUTLBEntry *iotlb);
+                     IOMMUTLBEntry *iotlb, int flags);
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
-- 
2.34.1


