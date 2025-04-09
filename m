Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92403C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VnG-0006HS-Me; Wed, 09 Apr 2025 09:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnF-0006Fh-Fb; Wed, 09 Apr 2025 09:48:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnD-0005dV-PO; Wed, 09 Apr 2025 09:48:41 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398qFsb032733;
 Wed, 9 Apr 2025 06:48:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=v5K//WRt+T/iENZNMiiOBN+Y1xrHhw1qE7oHbMMhN
 P8=; b=QUSkcgKoUqPzMQoP21KaZONjHlg6sWrNDJ58QCiK4aHikbO/ZszZc7Ruz
 qRpUN8Ck4nwNtyXIzEkObgG3nuyU6tItBA7cpuq0NTJaULx6569GjT/RmFgF0znE
 2ewpeBQZEj255rBQg0kNFhuzCK+FnAM95MIShMV/KVgB4U2RkaNUI+glXisDF7Lf
 yvtPT439LQuKAfh93ygiEjnX+8bRyZhBsjTEsLkCGzBsxu+ddoWEYPRPhDOrwsF/
 egQ/YRcQx+VHwYX21zlUVxv0XFO5txZgBpn4f5FBREjoUbi0TNFlcUg/T8hRx/VW
 66eUMzWHNIv6sh05cFWbaJRG63lfA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u22aj4ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCBvr+q1Cht+XZXGVjqDkUL5jZPEmU+DMqrOFr4EY8irECVuOFV5Y62GUPdQ5yonZiaocYGGpypEuE0f96azdZkZh2Th5hnEG8jknEIZ+yyAMskIkmYuPa2HIB6fv1+demAlPSNnWisc1EatBrvbRxxzcDpwRBm+R3lPVSivGbN2db9jp7vfVrl6uBAx6ZNQ2tMdz2u13mC47iwPMuyyJ7IvVrtQerc9WDMlDTnPP+jebA0wK3f5DONkm/FJVI2CK4Jfco5OPaauwscwOJ22iJ24vPMcafIluK9xpPn2aHARW3K/SXvgaz52eI99MnjZYaTavEDkPpLYHyUYAhq+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5K//WRt+T/iENZNMiiOBN+Y1xrHhw1qE7oHbMMhNP8=;
 b=SfE0ajlsZ6zeQNxMJ7OiILFWs4WAMnZg7z/0AWvpSpOcjNmH4ecXotVG/EtxpZtMU05H+omxwfPHGtp+22G25HchY8LK7WirJj7nw7pEMvqT3iFzrlrgO0ZsdGg/EXn5B8WQAloj6Iyei4MoBl4t5urCNOhyaUFroBaE3KHY6lt5o0AWj7/LUAdTXNcI48lnt14+/q2L0b+f6h//oBKypIEJ9+FWAS1JVvf6SV+9P6xMcpxAljB+3U9ISeMtl+yeEh3PIzw9Cg9LkmQ15HISOfIXAiXjQJUXtZn6Ywgua6KSn4RA0bnLx22imwa5lZQzqHs6kKnE03ySzBkwn5Y/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5K//WRt+T/iENZNMiiOBN+Y1xrHhw1qE7oHbMMhNP8=;
 b=RLk9Fvp75iERcooWUjGpyOL6Da46ndai3sp8TZDtWwQ8eXN2zRkv34rqcUfXfyWuGPoy6tM6rGzkh4H+RW5zxxijZQKgeeABdDAGjf21ZfVKtFUqfCRXV99cOIEsQ2QNeC3GVeycrm1fK0vZaX54oA4qE9nF4j/yY1KOdlCCoLJv/b18vs7yp6hP38d8J9g1U9IiXrokgp7IKjgBKkwY1ZKpKkuvkYYq3Aj9gbps7LpgU7oXLz/cjeW8cy1IEM/Dt5JydCgkd9F5ts1MSQaOIOv3JBwMrqxWdSD79sU4L9awugiZUWXyiWseSnl7wVFSU8tLV7IgGazYSXAM0Yb5QA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7486.namprd02.prod.outlook.com (2603:10b6:a03:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 13:48:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:33 +0000
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
Subject: [PATCH 05/14] vfio/container: pass listener_begin/commit callbacks
Date: Wed,  9 Apr 2025 15:48:05 +0200
Message-Id: <20250409134814.478903-6-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 768d0c1a-d176-4c2f-0c10-08dd776d37e2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fMRRAMj6aG/+MJfaIO/DDhzUzCvyU7Atiqor9/3/84uX5VwvgB9SCwQL9mqm?=
 =?us-ascii?Q?sVX/hWrHmlWqwKWdMRyZWCFbscv5wtzHmFXDeQHcba1vxwB2N1rkSwxKHA1M?=
 =?us-ascii?Q?uS9njMqD5S3nC8eX6WyiRF26ezsisELcfVi4LwlSfLBi4KenlLdwCJIPKp31?=
 =?us-ascii?Q?7X7uP5eqjTBHV8HCLI4w6gr8M6suvSMXV7Qm1glCF0iTFTH9gknCRP1k7hyB?=
 =?us-ascii?Q?3osLK9QWtuYFPgEZJgyS7HhyCjIiBh5Np0DUXKiehtRmnFWshzEXN6VrSaLN?=
 =?us-ascii?Q?2ldPnVNZdBFjoEjxvGcyoZV0deXHpBCozne7xNWonpAMQuPet9RVGnIZptDs?=
 =?us-ascii?Q?4gTIWumRLbqjrn5oi0527S5RQOsb0YC34vgP6KBnTZ60g13KQJMbE1oBbVcv?=
 =?us-ascii?Q?pf5tTeQNFbtLmmFdMiFnf6vrVI6OBTE1w0iaXm9dNeU0gyklOqJ029YTqveo?=
 =?us-ascii?Q?GTVE9hmTASZ/MTLBAcVZNLWI5yX3uRSE2sORYLxYA7Q5kABaletCCH5Ti4ta?=
 =?us-ascii?Q?BZLFpf0ljxj/yMUTK3CyjuCx5p4fMl358Qy5yABYNemECMZQNoVWkmtHhmk6?=
 =?us-ascii?Q?VMTUZ2WZxxvK+Dh7DVT5y48lT2XnTLGFaWWIQz0enXFB1Nhwkm448TGbFY5A?=
 =?us-ascii?Q?h+SCnBYcgmjUvxA/EvLPgHj3pFwfAKvX13la14E1q4zDs8tZr4QOyRkPS9s4?=
 =?us-ascii?Q?pd+5MpUj7f1XWZGr5tz+9tEgZZrOvk2ll4HnH/R+KKw9iwSJhWRuFmoJirE+?=
 =?us-ascii?Q?/wa0LuoFFqyNiq8vylBULYgx8JM1yyRSI4IYxapM95O2vzWwKZPUwyqbUJRr?=
 =?us-ascii?Q?hlr/Zjt4HS5KWMvcIwIGxXIMYBtDUngg60ter5du3ckF9NkSwwE5zeVLEI6m?=
 =?us-ascii?Q?etXf/OVKTbrlfHNUbTzRCUBo6E8u6+13cKiWizX0y8XEcVxK07zwIZ2G1IDh?=
 =?us-ascii?Q?U2r9FT7ZQe5aatFKE+I2P8c8xLrl3quXb27mMc+dC0YAc3weH45rFc3WniE4?=
 =?us-ascii?Q?w8FLbbjIKxbebmPkebJ5z3rSrg5tyF+ecYDZXEcj7yyFANU5/V+LLpTR+EZ9?=
 =?us-ascii?Q?GxBtxLEObzQ9xH7NOWkhRF20XobA4phecAOw/X4cavzKzv0uGxYYp3DK81fm?=
 =?us-ascii?Q?OkQrdVszG761eDw5TRlf9HhXvGs9ek3RXGOK463Y34LMk/CEdtL2toxy6+oK?=
 =?us-ascii?Q?TzapHPFvWqh5Eb1f7x1a4wWOFDj2Dvn7INofIVQ4n+lMiiUMz4iYHXXR7+hx?=
 =?us-ascii?Q?xkncZT5EMtgddwFkb7wBct0lChonGU9oc2zdAXVaavLXdzgj+g6T77xa0KKQ?=
 =?us-ascii?Q?igWCLr5hRFTgio9PSVuFu48ZyrmyUrJjZnWJgLRtTR1toR1mSLAIgl/f5uFI?=
 =?us-ascii?Q?EjwQ2n4WYuGEQDdJx5K1kA1glWdPIAONU51IVP1aT/koMzTL/43JWbZ3KOQP?=
 =?us-ascii?Q?4fLkJe+O4Gk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?havs8ND1xjx3H76t6Yh0OMKLPSBHasYqH0haKyf5TNuKqWP9LUYd8YWtIJt5?=
 =?us-ascii?Q?IUYQhynN96hWCVtdikH5Jr9zYZ9qPWk+KwmoGbrRICB/fTiz8FPsU+ZlW76m?=
 =?us-ascii?Q?CSZnt2UgSbEbvEAZD0FMdZZp2/MVOZy9MkTWU6arlw8mzntBsQAoongkYLga?=
 =?us-ascii?Q?9C+PsN2ZtrDhuJglKTojWo5XZDBU+/FRON+g+HFGDhSb7EAhTm1vNdzlvQQD?=
 =?us-ascii?Q?3h+JMZkKi4jrZ9wUTF/C0ByvDReaiymUoMjVReXAfK00q+f51mgaqAc0nkIo?=
 =?us-ascii?Q?ulKhVe+Fetzk9bxH4bzv4rbrKTRqEpPeTd/U6ulyhoCb0QvpD/bke5EaiGOI?=
 =?us-ascii?Q?uTlHRsiZEEka97Pw0QuCAVgmXxK64Ba0eggDYXeUQhJuLTTUXSK2EW3I/+yn?=
 =?us-ascii?Q?t17HVHftjwHNu3bkvmp4nI6dhUfsmEXKY0W+5lp+RDRZ2jNhZ4OFMedhgdCX?=
 =?us-ascii?Q?H4Nmmu0syxD2ry/NpeUQfSteuumOldaJhbzI6r4YwKUnBtABGv9zWs7wkPKK?=
 =?us-ascii?Q?l/c63NuqAG7Jpqzdo6NS7qGdZ1dUK5yIfCNK/t5RXX1HVCzWMNzntIht1j7A?=
 =?us-ascii?Q?+Iw3A8wYLao/C7ODllriMjekBGw9YnaJYUDnpv49MyAlq+65BzPBw0bEIXfH?=
 =?us-ascii?Q?OTrTOWeXr2twe8tAUnsY9raMEaBpnNWZW0HuMQ2DctlREmrVoq2YBsSrjgHb?=
 =?us-ascii?Q?SnhhdP6cbOzfW+jHoKZZoHZXep0rUoadZ1nSHxmgJ6W6iMxseoQo/yyBlu4i?=
 =?us-ascii?Q?DgTeDYEGuUrQwHYOOHB3slp35vxmEh1cf3NgBM50hzX/RJyuOXwWMxsTnEzc?=
 =?us-ascii?Q?angdeJDrmc4kXnJYttsoXaHGVW1j370OGCAmIj6H2QLGoeOGgkPyoL6zM5Xa?=
 =?us-ascii?Q?irqrD4PWv4Ga9RWPiowLzL1fIFtX2g3QhWhr5dOJy4VZR2SLfEslXameItbo?=
 =?us-ascii?Q?qIRLFARjvcvA7U+R/GuGvC115n7zK6R56nKoqBFWOe9n0JwKvpSRR/0bF2tP?=
 =?us-ascii?Q?n0mH7zWp7lXqjFSnCCAf3zeRCObF+Ef/6OyiuMqaKrO4oyUfb8XRF2zrRMAY?=
 =?us-ascii?Q?JeudwOlKxF1oqda3hKvT8B+rE6gPPEH2TWMprYRTrpgn6wYd/u4l019xwM/F?=
 =?us-ascii?Q?m6wfQwLgCBuiyjW4kt9C0lAFoGEMawQctJfpIf/27TiDJVUlD4i5/sSQywF4?=
 =?us-ascii?Q?ymLv+Dt6eTF0P9lopIDNfKra4VCR3KAsKhwWQJTz6F1MrrqE610/bbPtNrXr?=
 =?us-ascii?Q?QEO7yGmqzLaMfezOo+W4uxNvZ80+5JmolCGKyajKvIsq9AdQg9K8/+PQsuiY?=
 =?us-ascii?Q?LeSzs786mzE77zdGbIUNFPBbkQvtvAQyNclhXgahuC4cQ6w+mBLFNThkQmxn?=
 =?us-ascii?Q?Z1a1M7C70Yh/9sFcK9JhnpI1uwJMPtq3UBVdaNdPtA8Q3Wu6dj4qmIRy1EHQ?=
 =?us-ascii?Q?/eJNH74hE9dFB+5GKI4IA0n+B8Cjd4j+ZXbYl4cdBGjqEvvEYZidAUbkP/+3?=
 =?us-ascii?Q?V2QXyPKhoMTO1sXthLWmxjtheBGyCDqWF0ttxS0SY/TwNk8hLtgQ7lApjvWj?=
 =?us-ascii?Q?us9N79qflh/nCwPmjY9XCzSF7NxPxl4ff6vsVy/E?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768d0c1a-d176-4c2f-0c10-08dd776d37e2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:33.2972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdYe8u8cUpS0WkkHCLJ1asqyS2R11aWahvo+himCIwbtiJ3XAIGB5SWre4uym4EPWGwZBVd4lbXuTGDDtZGByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7486
X-Proofpoint-ORIG-GUID: QyNV2ncRbkr07joRq1AY7s6wyljOpUmX
X-Proofpoint-GUID: QyNV2ncRbkr07joRq1AY7s6wyljOpUmX
X-Authority-Analysis: v=2.4 cv=Xtf6OUF9 c=1 sm=1 tr=0 ts=67f67ab3 cx=c_pps
 a=+1/HLBYLL4tv2yjlBWnClw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=vU0vC_IIgwTtBsNJuTcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The vfio-user container will later need to hook into these callbacks;
set up vfio to use them, and optionally pass them through to the
container.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/listener.c                    | 28 +++++++++++++++++++++++++++
 include/hw/vfio/vfio-container-base.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 285ca97a8c..9ffc2deb2d 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -412,6 +412,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_listener_begin(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_begin) {
+        listener_begin(bcontainer);
+    }
+}
+
+static void vfio_listener_commit(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_commit) {
+        listener_commit(bcontainer);
+    }
+}
+
 static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 {
     /*
@@ -1166,6 +1192,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
 
 static const MemoryListener vfio_memory_listener = {
     .name = "vfio",
+    .begin = vfio_listener_begin,
+    .commit = vfio_listener_commit,
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
     .log_global_start = vfio_listener_log_global_start,
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index a441932be7..67373e8db0 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -120,6 +120,8 @@ struct VFIOIOMMUClass {
 
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
-- 
2.34.1


