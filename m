Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF455C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vnb-0006UP-Ol; Wed, 09 Apr 2025 09:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnO-0006Su-BY; Wed, 09 Apr 2025 09:48:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnL-0005ew-9B; Wed, 09 Apr 2025 09:48:49 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398ai3I009618;
 Wed, 9 Apr 2025 06:48:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oazRZz3xQrkr7hvFHhVeMA+UmiqblYhdJA62AL6OE
 GA=; b=SlsuM7q1I4iucUX9i+LX7mzi3Ei4L5BYIEG46eC2gjUhK5+hwM49pEahd
 mpwua3i8mlaK129MqB2KgrHeUGQdyBXHRURpEJsUTgBbCP/44eXaXvD8abbqZt7T
 xOWPplCKchVeSBGqMKoTU2+eOCExELDXgbfAWmYwXbOwipZrfF86drqtp4+8UdyQ
 sM5UYsTn7XkM2kRHlrku7AyG7xnzaiQEWdttVtkzR3y3MybRzDnkZ+s8Y94QMrG5
 kEreRjDiS8+eUxyE0DcnBk9kITxQrWK/FjeyiHLHV4GUHYUUsd7SklNj6uCriv48
 AI4ijI24VnOTZjMCLwUUZcUCZQwTg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012039.outbound.protection.outlook.com [40.93.6.39])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u420syj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/2Sav4cw5kkVdKfo13qL57bu8dOTv0xc294lcY0m7qpSTbidMqnpBROy7NjCYjPixN7JIp6IAgcShXfc9xdcxtf1YcfoLI4b0Kz8vBB9YFhuUgl70spc5kCSWqcRbMJNkWU6LCpUSlnQqw9qc5ccj9hOQyrdOp6wsOaFPBSJ5H7EpqNBvOr5vK2n31C4+lxGp+95Y4UuFbBUG6l5avEIs8pnDNjhNDn4ifi5yo6RCxK28L3UFIWvtdbn4YnKH8MRJXBfcuS7nZv3kb7xdWq8NSGzpOiAvmbQEhtzuYJ4T0Z+BcfVAC1YgELimJjTQweRhVXc4OL5XdhFcZF5+qbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oazRZz3xQrkr7hvFHhVeMA+UmiqblYhdJA62AL6OEGA=;
 b=DSzfV+JrzmWWn7duTPUu0AsQAyBW7LqaZWJB9W8GmGVWWK+reubarADPV97IwC8oCUMA16x4Hod4UsqQ1Thk9LBO/LllSSMdra9Aqyglgr9BlUQ9uClDooZDqJVZ0Y15tNxCXKoyBSrJtDq97I7rzwOT33QmTuew2pFmoFS1LGhILU0djHzPoKPyfAuE6Py6VeZi79i29/BO3Lk9U+OctimBK/yL8dn8l29qG6UDaKhkz3FrxvaNBkKBmw41ItTOyIvOP1cTZR4ADJv1NP5Kk4WZyPnyKNs490EvpxaDnq2BGIau1KOvlNp9vCmYm38MUxGZh02nXYe/R1Qwlj/9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oazRZz3xQrkr7hvFHhVeMA+UmiqblYhdJA62AL6OEGA=;
 b=dmcOIFL9pK8d+p4aM7fsAT41TA4ZC8Hb3KhM6lHI5hGpgiP+GVjuYL2cFbfm6/mOqsLPaj5pdUv2y/upNTuD8aiHSRGUV+Sg4cyYepbWY7Ap+P7V9Vjd7Bb3EN8a375fGQFl9QSOLX3WPAh6vWLAEpT3Cda0cH6Ktb92D1XujB33GYXIs6SdrwNSGl4QUcijav7qAjFFPaCHZEjz4HvBfretvvh6x3te0bkPSx9btVwTe7xEneL6rQGenczHG6+/W3yKIXaaVqVux8437SZAD2EfJKOZ/xaudw7f/zU4b+WoMqMKleXZ4ZMcrx+20llSM8BfQe9nfXkIzYB50RIUQg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:42 +0000
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
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 08/14] vfio: add vfio-pci-base class
Date: Wed,  9 Apr 2025 15:48:08 +0200
Message-Id: <20250409134814.478903-9-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 953380a1-5503-4716-3d9a-08dd776d3d1c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3zI3CBzntcor42KuT+yptRXsC2tkUFOoAv/5fLVRfdSwIbof1xW9Q48Dbpab?=
 =?us-ascii?Q?5TQwsONyWi/Z+MuupWkAmlTfm4NFkv7jl3QaOQ7yaUf0Zq2n4enV08L4MQu5?=
 =?us-ascii?Q?KJKKeBKDV4wM79LBF1QeXXGlhcq6Q+c8cO4mqDAp4TMZBBNCQhM52jdTWLC/?=
 =?us-ascii?Q?x98XDyJjrEU/SCEdU9QPFo9KHwSsZHQN1idDCabguhzDNGvXSEHDGgt3Cv94?=
 =?us-ascii?Q?Jv/cvTAz73TfLJhZXbs0i6j7yI3YQGqCdsUUFbbg5C9CYJwtUpwhetcvOPbl?=
 =?us-ascii?Q?fD320f1oU9QLNm0M/eFR81FiqrVXLObf21jwCYKhzbg1I1R+Tq2Aoy5hV9+l?=
 =?us-ascii?Q?RmaNm8w63Vjq//nECMeXAN9cP1GJfdWokLrn/r+xSw8MJ+BKhN5Iz8Ane+kD?=
 =?us-ascii?Q?469Mi7PogEa2mpOVTClWwziXscR+SIKHb/s36Cq4btDQb+Fe3PbuHmpjoHAQ?=
 =?us-ascii?Q?QPrIfMl2poIw8x9A3W1AK8m8g+djMW3OPWr4AZ62zfNEZ9MoWCibDCYF3Qb+?=
 =?us-ascii?Q?QGjZXtmaPXMEaTBBatii82pt6MLwypevy4jeV0XONoO4VIU3X92nJ1CMds7l?=
 =?us-ascii?Q?oIpLJggbjL5PqDmz7DZBGZ2slKTlMyr+X+vd+TZNUtEZMyw/7umFK+bbJIQW?=
 =?us-ascii?Q?ZPqJCap0FYdtbC61+DSCsUF99+yn34sB9mSQ5ceLmfY2rXqg48a0nEYGiYQ8?=
 =?us-ascii?Q?XaBAFCgHegw37o8qOtznLyqkCiE2Nvflui09hZD6yhx8h0FAvBfTIu+YUZsk?=
 =?us-ascii?Q?V0vC6ZuI5cT4YebwzfwQB+boPrlvogTIw5w6/0g6lRL+NNFrsnJ0nlL2C9dl?=
 =?us-ascii?Q?BO71/Q4bCYcCXYaKHTa8kC0IsU1LtKnFrtCWi9BTY7nQxUizHXDSG0xIDsJx?=
 =?us-ascii?Q?qkZN86J2T0XYzOnBtlrd4QrcI6GYr3Yr7JogN21Tg5ORQPH5mbQRUiTVF/QL?=
 =?us-ascii?Q?x4Wb5T+9ElEWf5a5EORmkfXKH5OG7U6wXC8yr2f5Of/o1nChmQwXs2KLBNFN?=
 =?us-ascii?Q?JJkbPrL2SQkAechbe/uwt4cXCjt6RIY+EF1qMVIC0GSwJFY+coEwm2Ik01jx?=
 =?us-ascii?Q?DaxCxLrqiuXv6dbVQZhqgER2mY+6ZFNUU8o1VHKcRMtzTu8Eqs1nBZuH8Gb0?=
 =?us-ascii?Q?y4p5mgdb5cMGxA31wGSlmkg+G78gPId57JHo8PO53mOJhDu4uAeiy/R7sK3h?=
 =?us-ascii?Q?FI0H9CBPY7M3MTzcQoSBK0HaIaGL9If02x9Ip9Yyt5oC9Ti/WeW5gettBloC?=
 =?us-ascii?Q?WGpuVUMBiNkSNPJnIGU0c2HN74y31pgncTFLlDcVtlRbfx5DDeyvy13y8NXK?=
 =?us-ascii?Q?JWrCpIry/yAaEH/19ujAydWRf2RLXHnnvpYu0mB+wIqD2WHPZt2xsqVC1vhF?=
 =?us-ascii?Q?CTWnPQRCr30GTzeQ8ljKUIreN8u2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qO2RJ2eM9QiBH/deCghmJn7cIqRt3QCfNSkeKy+nQhrXcU3b0qB7KDpMs+a?=
 =?us-ascii?Q?TrvpwTO2pr3hb8UzjQu1IIMQVHi2gBVv0Ffo8mPE81R7368K5mAY8t8ck3e3?=
 =?us-ascii?Q?p4f2PRzEPx2O3sWMtHSKE1J1AehHVG6CQkqVxZiuZ35k+5fgnOAbKYbdT5p2?=
 =?us-ascii?Q?LS7WUcWDr1ERssGY13zzLwWK4tYjQ8R2VNnh4MVaJg8P7jadkrGUJ0JcP0Bk?=
 =?us-ascii?Q?f0R2pZ0syuw/LoASIrlOgEfIL9kjVLDzzr/C7WSQgn/wwge3n6ew57ACz5Ml?=
 =?us-ascii?Q?sYf6jeQVyuslY1IBUhaRduqnV8430B26TApl8PFY7KG0YofSI3ne0gSSvbgU?=
 =?us-ascii?Q?mFjPNGmmozLfWrRXtIgRaRVJ5tk8PcWiFGUKmuSugi7VQ+iOGnFl7lG7pD+l?=
 =?us-ascii?Q?L2JeXGYDw/eSyNkm63o7HYqP+9Vh63c1vfv0IBSqubKrs2YJo2HAxhMz+fIl?=
 =?us-ascii?Q?VMMS1YXnUlNoixMNjva+5w7+b+M+eQ5x5xmuHTwVuItn7oxGuSXumxfE+HZ0?=
 =?us-ascii?Q?kQjIsX2myVEyX8HlTyFnnumAJhlCA9sdMmWdIBiAkY4NgT6ljFOdIfEkRqsq?=
 =?us-ascii?Q?dM31gNZVHGDAHqTclYXt2tEBnByzgUkzDsAUYgoUAGFYorNlR5uvOkZcHZLh?=
 =?us-ascii?Q?z5/SsU5KGogJjkyfvC0TG5mD9Jr99YZdyRnKLcBHhRe2Dqx0ryFFHE6RONTA?=
 =?us-ascii?Q?vgSRMsOqdrKAuMG7iaOKaf3CYNnuf8TILf4WlXnvS1oBwrXY5IMSa2z+ul15?=
 =?us-ascii?Q?colULdisIaxIiZGR7HndtVBIRO15PfP46+nwaSrQPhTWsmHeN6YYhTvVfS7F?=
 =?us-ascii?Q?qMpKUk1nnW5Kz+fVHkqVwRFzPnnViOuGeRgSp4xSXn92vNa/ZTXXQcUaoW5g?=
 =?us-ascii?Q?Lq8e7yHRNaILzYkSaA6Xn7vNLXswgjBwgEYPrrbsCENmcmJG4IhjCYFKMczM?=
 =?us-ascii?Q?t0u6dYuZxSflxJGD+3kKGc4XiyI9vdK4juWnA4/djU4yWgL3qkwsYSGq8Hlu?=
 =?us-ascii?Q?bYDHJeRFY40pfsLkSHDI7HoxqxpkpJ3gVjZgS7pdRx3nOK9vTlbKsHTqbFeT?=
 =?us-ascii?Q?jkXz8jHBa2o48kYvLOAqrla0/XOE5h8O6S+AI0pHcXnUStAdA8r7OEsAkDlm?=
 =?us-ascii?Q?14P6d/hFfWGpJ3oIYszA1rN+2RPGHjsX0QzUsvfa57Iho2REoc6YJ+zgDk9H?=
 =?us-ascii?Q?10ul6kqo+a1k967dhewNiKOvyZL9SKi8eAkYveeoarP3Rj1Vj9uiZyTFcldn?=
 =?us-ascii?Q?qCX4BEsMyvQtJlkVb+k9i9uiVdSnay2TG0Kxm6P+H2ANT1d9wtO8UUimPrdO?=
 =?us-ascii?Q?SnnIMRZFeP4RzySfdM8PfhqOeEAlD0Ae45UtgJDGLBGhBZUwm5ce76PkvptV?=
 =?us-ascii?Q?xdRs/Ma6CiE3g+nBsp96Cgg/DLWmhWHzMCWwquEcX+oUh/ndIq0u+lGzkR61?=
 =?us-ascii?Q?cJavZuY3Gfnm7hgESJ2ZNjXAOMl7fP+kTwa13khhuONXZPIXndU2fqDchJjp?=
 =?us-ascii?Q?bqSUe6kqQW9nQFnogTTh9GcPGk/c6yEB6uXBm5DttSnxi+0g4/qgTjab0Ic2?=
 =?us-ascii?Q?NerOn4T7JlE5iFXUlE9zeu6XHS3PHM16wPlDzj42?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953380a1-5503-4716-3d9a-08dd776d3d1c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:41.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOVfPZVa5ZvZtIT2/X95VgXTAxQKC/5R/wS1LXRyJn4RLmlqyks7ErqgBNp1XxM0TjzSP4M6LTuc1jkZ9O4jCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-ORIG-GUID: mywOmPImy4QHVBRGhlA6REI2od4smQ8K
X-Authority-Analysis: v=2.4 cv=TeGWtQQh c=1 sm=1 tr=0 ts=67f67abc cx=c_pps
 a=VIUGDxI8SzY5XGtng4SOXg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=A9enwp8IFyuUK1rs7oIA:9
X-Proofpoint-GUID: mywOmPImy4QHVBRGhlA6REI2od4smQ8K
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

Split out parts of TYPE_VFIO_PCI into a base TYPE_VFIO_PCI_BASE. The
base type contains properties generic to all vfio-pci implementations
(although we have not yet introduced another subclass).

Note that currently there is no need for additional data for
TYPE_VFIO_PCI, so it shares the same C struct type as
TYPE_VFIO_PCI_BASE, VFIOPCIDevice.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/device.c |   2 +-
 hw/vfio/pci.c    | 266 ++++++++++++++++++++++++++---------------------
 hw/vfio/pci.h    |  12 ++-
 3 files changed, 156 insertions(+), 124 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index f74b9c25ea..b9473878fc 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -361,7 +361,7 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI(obj)->vbasedev;
+        return &VFIO_PCI_BASE(obj)->vbasedev;
     } else {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 81bf0dab28..090b2f2ef0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -241,7 +241,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -516,7 +516,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -621,7 +621,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1169,7 +1169,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1215,7 +1215,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1248,7 +1248,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     uint32_t val_le = cpu_to_le32(val);
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
@@ -3091,7 +3091,7 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i, ret;
     char uuid[UUID_STR_LEN];
@@ -3260,7 +3260,7 @@ error:
 
 static void vfio_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3278,7 +3278,7 @@ static void vfio_instance_finalize(Object *obj)
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3302,7 +3302,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
@@ -3342,7 +3342,7 @@ post_reset:
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3365,32 +3365,15 @@ static void vfio_instance_init(Object *obj)
 
 static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
 
-static const Property vfio_pci_dev_properties[] = {
-    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
-    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
-    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+static const Property vfio_pci_base_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.pre_copy_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.device_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
-                            display, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
-    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
-    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
-    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
-    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
-    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
-    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
-                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
@@ -3405,8 +3388,6 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
-    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
-                     no_geforce_quirks, false),
     DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
                      false),
     DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
@@ -3417,61 +3398,55 @@ static const Property vfio_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
-    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
-    DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
-                                   nv_gpudirect_clique,
-                                   qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTO_PCIBAR_OFF),
-#ifdef CONFIG_IOMMUFD
-    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
-                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
-    DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
 };
 
-#ifdef CONFIG_IOMMUFD
-static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
-{
-    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
-}
-#endif
 
-static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
+static void vfio_pci_base_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
-    device_class_set_legacy_reset(dc, vfio_pci_reset);
-    device_class_set_props(dc, vfio_pci_dev_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
-#endif
-    dc->desc = "VFIO-based PCI device assignment";
+    device_class_set_props(dc, vfio_pci_base_dev_properties);
+    dc->desc = "VFIO PCI base device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    pdc->realize = vfio_realize;
     pdc->exit = vfio_exitfn;
     pdc->config_read = vfio_pci_read_config;
     pdc->config_write = vfio_pci_write_config;
 
-    object_class_property_set_description(klass, /* 1.3 */
-                                          "host",
-                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
+    object_class_property_set_description(klass, /* 5.2 */
+                                          "x-pre-copy-dirty-page-tracking",
+                                          "Disable dirty pages tracking during iterative phase "
+                                          "(DEBUG)");
+    object_class_property_set_description(klass, /* 9.1 */
+                                          "x-device-dirty-page-tracking",
+                                          "Disable device dirty page tracking and use "
+                                          "container-based dirty page tracking");
     object_class_property_set_description(klass, /* 1.3 */
                                           "x-intx-mmap-timeout-ms",
                                           "When EOI is not provided by KVM/QEMU, wait time "
                                           "(milliseconds) to re-enable device direct access "
                                           "after INTx (DEBUG)");
-    object_class_property_set_description(klass, /* 1.5 */
-                                          "x-vga",
-                                          "Expose VGA address spaces for device");
-    object_class_property_set_description(klass, /* 2.3 */
-                                          "x-req",
-                                          "Disable device request notification support (DEBUG)");
+    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
+                                          "enable-migration",
+                                          "Enale device migration. Also requires a host VFIO PCI "
+                                          "variant or mdev driver with migration support enabled");
+    object_class_property_set_description(klass, /* 10.0 */
+                                          "x-migration-multifd-transfer",
+                                          "Transfer this device state via "
+                                          "multifd channels when live migrating it");
+    object_class_property_set_description(klass, /* 9.1 */
+                                          "migration-events",
+                                          "Emit VFIO migration QAPI event when a VFIO device "
+                                          "changes its migration state. For management applications");
     object_class_property_set_description(klass, /* 2.4 and 2.5 */
                                           "x-no-mmap",
                                           "Disable MMAP for device. Allows to trace MMIO "
                                           "accesses (DEBUG)");
+    object_class_property_set_description(klass, /* 3.1 */
+                                          "x-balloon-allowed",
+                                          "Override allowing ballooning with device (DEBUG, DANGER)");
     object_class_property_set_description(klass, /* 2.5 */
                                           "x-no-kvm-intx",
                                           "Disable direct VFIO->KVM INTx injection. Allows to "
@@ -3484,6 +3459,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
                                           "x-no-kvm-msix",
                                           "Disable direct VFIO->KVM MSIx injection. Allows to "
                                           "trace MSIx interrupts (DEBUG)");
+    object_class_property_set_description(klass, /* 3.0 */
+                                          "x-no-kvm-ioeventfd",
+                                          "Disable registration of ioeventfds with KVM (DEBUG)");
+    object_class_property_set_description(klass, /* 3.0 */
+                                          "x-no-vfio-ioeventfd",
+                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds "
+                                          "(DEBUG)");
     object_class_property_set_description(klass, /* 2.5 */
                                           "x-pci-vendor-id",
                                           "Override PCI Vendor ID with provided value (DEBUG)");
@@ -3498,95 +3480,136 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
                                           "x-pci-sub-device-id",
                                           "Override PCI Subsystem Device ID with provided value "
                                           "(DEBUG)");
+    object_class_property_set_description(klass, /* 2.12 */
+                                          "x-msix-relocation",
+                                          "Specify MSI-X MMIO relocation to the end of specified "
+                                          "existing BAR or new BAR to avoid virtualization overhead "
+                                          "due to adjacent device registers");
+}
+
+static const TypeInfo vfio_pci_base_dev_info = {
+    .name = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = 0,
+    .abstract = true,
+    .class_init = vfio_pci_base_dev_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
+static const Property vfio_pci_dev_properties[] = {
+    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
+    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
+    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
+                            display, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
+    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
+    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
+    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
+    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
+    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
+    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
+                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
+                     no_geforce_quirks, false),
+    DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
+                                   nv_gpudirect_clique,
+                                   qdev_prop_nv_gpudirect_clique, uint8_t),
+#ifdef CONFIG_IOMMUFD
+    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
+                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+#endif
+    DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
+};
+
+#ifdef CONFIG_IOMMUFD
+static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    vfio_device_set_fd(&vdev->vbasedev, str, errp);
+}
+#endif
+
+static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, vfio_pci_reset);
+    device_class_set_props(dc, vfio_pci_dev_properties);
+#ifdef CONFIG_IOMMUFD
+    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
+#endif
+    dc->desc = "VFIO-based PCI device assignment";
+    pdc->realize = vfio_realize;
+
+    object_class_property_set_description(klass, /* 1.3 */
+                                          "host",
+                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
+    object_class_property_set_description(klass, /* 8.1 */
+                                          "vf-token",
+                                          "Specify UUID VF token. Required for VF when PF is owned "
+                                          "by another VFIO driver");
     object_class_property_set_description(klass, /* 2.6 */
                                           "sysfsdev",
                                           "Host sysfs path of assigned device");
+    object_class_property_set_description(klass, /* 2.12 */
+                                          "display",
+                                          "Enable display support for device, ex. vGPU");
+    object_class_property_set_description(klass, /* 3.2 */
+                                          "xres",
+                                          "Set X display resolution the vGPU should use");
+    object_class_property_set_description(klass, /* 3.2 */
+                                          "yres",
+                                          "Set Y display resolution the vGPU should use");
+    object_class_property_set_description(klass, /* 1.5 */
+                                          "x-vga",
+                                          "Expose VGA address spaces for device");
+    object_class_property_set_description(klass, /* 2.3 */
+                                          "x-req",
+                                          "Disable device request notification support (DEBUG)");
     object_class_property_set_description(klass, /* 2.7 */
                                           "x-igd-opregion",
                                           "Expose host IGD OpRegion to guest");
     object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
                                           "x-igd-gms",
                                           "Override IGD data stolen memory size (32MiB units)");
-    object_class_property_set_description(klass, /* 2.11 */
-                                          "x-nv-gpudirect-clique",
-                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
-                                          "clique for device [0-15]");
     object_class_property_set_description(klass, /* 2.12 */
                                           "x-no-geforce-quirks",
                                           "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). "
                                           "Improves performance");
-    object_class_property_set_description(klass, /* 2.12 */
-                                          "display",
-                                          "Enable display support for device, ex. vGPU");
-    object_class_property_set_description(klass, /* 2.12 */
-                                          "x-msix-relocation",
-                                          "Specify MSI-X MMIO relocation to the end of specified "
-                                          "existing BAR or new BAR to avoid virtualization overhead "
-                                          "due to adjacent device registers");
-    object_class_property_set_description(klass, /* 3.0 */
-                                          "x-no-kvm-ioeventfd",
-                                          "Disable registration of ioeventfds with KVM (DEBUG)");
-    object_class_property_set_description(klass, /* 3.0 */
-                                          "x-no-vfio-ioeventfd",
-                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds "
-                                          "(DEBUG)");
-    object_class_property_set_description(klass, /* 3.1 */
-                                          "x-balloon-allowed",
-                                          "Override allowing ballooning with device (DEBUG, DANGER)");
-    object_class_property_set_description(klass, /* 3.2 */
-                                          "xres",
-                                          "Set X display resolution the vGPU should use");
-    object_class_property_set_description(klass, /* 3.2 */
-                                          "yres",
-                                          "Set Y display resolution the vGPU should use");
-    object_class_property_set_description(klass, /* 5.2 */
-                                          "x-pre-copy-dirty-page-tracking",
-                                          "Disable dirty pages tracking during iterative phase "
-                                          "(DEBUG)");
-    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
-                                          "enable-migration",
-                                          "Enale device migration. Also requires a host VFIO PCI "
-                                          "variant or mdev driver with migration support enabled");
-    object_class_property_set_description(klass, /* 8.1 */
-                                          "vf-token",
-                                          "Specify UUID VF token. Required for VF when PF is owned "
-                                          "by another VFIO driver");
+    object_class_property_set_description(klass, /* 2.11 */
+                                          "x-nv-gpudirect-clique",
+                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
+                                          "clique for device [0-15]");
 #ifdef CONFIG_IOMMUFD
     object_class_property_set_description(klass, /* 9.0 */
                                           "iommufd",
                                           "Set host IOMMUFD backend device");
 #endif
-    object_class_property_set_description(klass, /* 9.1 */
-                                          "x-device-dirty-page-tracking",
-                                          "Disable device dirty page tracking and use "
-                                          "container-based dirty page tracking");
-    object_class_property_set_description(klass, /* 9.1 */
-                                          "migration-events",
-                                          "Emit VFIO migration QAPI event when a VFIO device "
-                                          "changes its migration state. For management applications");
     object_class_property_set_description(klass, /* 9.1 */
                                           "skip-vsc-check",
                                           "Skip config space check for Vendor Specific Capability. "
                                           "Setting to false will enforce strict checking of VSC content "
                                           "(DEBUG)");
-    object_class_property_set_description(klass, /* 10.0 */
-                                          "x-migration-multifd-transfer",
-                                          "Transfer this device state via "
-                                          "multifd channels when live migrating it");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_PCI_DEVICE,
+    .parent = TYPE_VFIO_PCI_BASE,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { }
-    },
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
@@ -3632,6 +3655,7 @@ static void register_vfio_pci_dev_type(void)
     vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
     vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
 
+    type_register_static(&vfio_pci_base_dev_info);
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index cbea3be029..4000ba804c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -118,8 +118,13 @@ typedef struct VFIOMSIXInfo {
     bool noresize;
 } VFIOMSIXInfo;
 
-#define TYPE_VFIO_PCI "vfio-pci"
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
+/*
+ * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * between VFIO implementations that use a kernel driver
+ * with those that use user sockets.
+ */
+#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
 struct VFIOPCIDevice {
     PCIDevice pdev;
@@ -187,6 +192,9 @@ struct VFIOPCIDevice {
     Notifier irqchip_change_notifier;
 };
 
+#define TYPE_VFIO_PCI "vfio-pci"
+/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
+
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
 {
-- 
2.34.1


