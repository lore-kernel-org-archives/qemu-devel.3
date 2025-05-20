Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA20C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPmt-0006Xi-PT; Tue, 20 May 2025 12:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHPmk-0006Ww-Hl
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:25:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHPmg-0001pX-U7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:25:45 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KEgMOU028047;
 Tue, 20 May 2025 09:25:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=O/zFtQswGhx4y
 a5wMZyoHQ1FjNc+VukPQAmr8UNbEEA=; b=2Z1eKx2IeJEVL/ETNAtXpkX2MdB5S
 Cw8g2lV09oELtoq3G5J4JK0Tqbn8wKJddGgcIVh/9JKv5OxQtGOXe5gHGKanB0An
 GTB5fA6mbai1HmnqPkQ655+G0koi2sRGCOT496wf/W98wBiAC8GwLWNSOCGFjyVJ
 qrpBMHVsK6+1uuSrU+dlzZ1/oviNDTQiY8SM3otw1WzMBIfa5DRQTFZHzx6/A72P
 h+XoJlNF1g3qoAQZGkXHEkq95cJ5WVx3hibSlyxYlamqQCLFM4XGZvd2eK/WLvn7
 pibnLvQ3uLjfWvq7xuV8I5+oR24dr08dcanXMxdw4crkdMAZiBfGmIPOQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46pssbpjpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 09:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQOF0/MWQ6RNwdHnjWJeYsOV8nkUU2huTs+5vc97B+UQ9LS+Xxj5UK1YrPEG8E/ZAVZmdrmqAYlQmx9tkINxx4GgUWNY+BcJ10q092TuSVvg5F1DNpf8yn0e2B59vG8SI1PJozKlTwLhJ1fV/8tP9J86yTLBnE5/edO4MAdho8Rt/LOp9Du07aliaaXUwPz9X5MtrLRKU2AU6IIzzsy0fINiJFKvVZQscVZXZHY2vgDEmA7LMqyoX+DjwW6//wzK14yy52P1ZdJSLTY4GGm6f2A4AIulMW06Gj9Xn6zuW8ZkGx6qleHhTAAxqBZTjJ2yzt8rJMQSlZlIkO3vr5WlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/zFtQswGhx4ya5wMZyoHQ1FjNc+VukPQAmr8UNbEEA=;
 b=x1xxRIHcCO/zPxTCj6Qmh6RzfeRhgiZfKpGngn7jKbW20E+ijH1FOCiVcblJHGnfnLGzPr6jTZnEXNxq6g3fpnr5xUnzQS3nepXxWGILvMOdVkpQ/2/7M6V0oosWBPjgcx60hcF0/AOa9tO5+HeopjrVrnETQtDw0IistmRWNhzRclCkayZN2g21CwoFy7V+1cFCfEKp9BPBEYRLkdfp9UJQPflRlWwLeBAgM0kQ1OBrmWnNc/4IgKBm1FNUMa0KI8a9AFg2+APdhumJue4J415SAMFRJLCAIOSkm34wz+FTCy0H+hYifQnoVzhTWbe51bNSWlmwImAOQHoK6Jt/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/zFtQswGhx4ya5wMZyoHQ1FjNc+VukPQAmr8UNbEEA=;
 b=ljcBzeY8nSZJ+ljPo/NqN6cT3kR0LemEP+tw+VHismbYU4d+F12yUf5pZ2MKJVyQgi3PqmuD/iajM+H0e0NuQqH0to5oRd5EW8RLhunUoF0DLCauy7CO90BIVImtM7QNSeX76QpC5PwA8MdGZBfJt6s7AlhA0qG/922a9BdMQvwOAjE5uSxP5OOm9/ZiWCTQRwh7MSAfmCM7tYUo1Lzcxf/yk1IRKrWDJ7y4K2E1l5qijFrwZOB8YAmTl1apIetZhBjRmNa48VDJ8RFCQKxTxIWTm0jeEZNcQBCVAZKgbm5HmN8/QJ4DXJsWwzbKy7/titVeAxEryO6BfDMR80lu3Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CYYPR02MB9804.namprd02.prod.outlook.com (2603:10b6:930:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Tue, 20 May
 2025 16:25:35 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 16:25:35 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] vfio: add more VFIOIOMMUClass docs
Date: Tue, 20 May 2025 17:25:30 +0100
Message-ID: <20250520162530.2194548-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::8) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CYYPR02MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9a1fba-abcf-4c95-3e0d-08dd97baf2e7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jLDNoOpzk9xBjspEFCDKfmCWcsNnw4itLBQs+FIbt5lwueMQf/0z6xbvWwMS?=
 =?us-ascii?Q?8u5fFPsaMtQRW4MLpJs45H7/DLamUPHr08RE80q/tlGhiEotG49ZqYPa+qpl?=
 =?us-ascii?Q?vPnRa6q8sf/a78pjvCPGvahYMnWO3T6ph3motU6BDV56EGE1Tg8P0xsNAldd?=
 =?us-ascii?Q?Kak3qonM+rmh5Txo0reQfpqkX1gw7pgmAtAnAcpo2eVXNHRVRMVg8uO9QFIY?=
 =?us-ascii?Q?XattQhdJhuD9HJAcVGIKiFRfHoZOiixZP5RaffSvzIr723gunqMpEucGeDnx?=
 =?us-ascii?Q?5QlpOZGI/ubBHIMsCnMhUQGkVdTO5w+ohVM1e9AEdd8iVNCxzG+dp58Kvxyi?=
 =?us-ascii?Q?pnkMe20CjM4NsgGKiZ5GRkm+Vd0PEphZL/UxbA18gVfSPp6tjiWok/fsd3i1?=
 =?us-ascii?Q?icKUvkLLO9ess3nZCIt8n4FqVfUQa763DozflPw9nWNcgAFr5Fv5sFhjZiQP?=
 =?us-ascii?Q?+J72rUvVCLH4+P1VwTwfu7PdF7mK3lRg1jvZ82NQ0l+NV2vMUF3pYrS+BvL0?=
 =?us-ascii?Q?nyuyvtTW/U8nOq0ZgI34hJFENhJRyNt0KDupm5oNUsxZHcqAIgOZRpjDImjF?=
 =?us-ascii?Q?6ZuSkYmcduZyQUcXG7/KQ88qztn/iiZBXywUc36NMPoT3VXvtBBVvYBzSdNt?=
 =?us-ascii?Q?Ssu9II5tgf/YUpkYxHYXSZaFx/aNM8PwomH9OGlQl+VzOeiNP9qFF2U+vUz0?=
 =?us-ascii?Q?321AjAVWbpZrKGRSohRJYqhr8EJZMtd57/UhYimMvur2CF1qj/62UYSdhCx2?=
 =?us-ascii?Q?7kyrg2AV4IX4UXW+l6TwurnhEDgUCCI3foIX+bxsnOLSGNQHZVnEgkQDfm/i?=
 =?us-ascii?Q?hmvzmHsgoLx7gdibLKGJCzurAJ5sros3+i15GzBgcl4ZkYygdju2qJWN/wGc?=
 =?us-ascii?Q?rBwIMJhkcVZc5q/nzNz+1EafIIeAJ+QVlh9PxkW/UJmcrhPmDNWUtStsQhYU?=
 =?us-ascii?Q?CRCEu9uAi8I+3w03ASWXsKDD94ceunQ0X2aTZikYedVp74B7Ezx2BJuP6JMd?=
 =?us-ascii?Q?3P+8WnlqGNjBerTn3homtPSiRvbPhGL0JOEOUoZWBscMlu+hyahLMOhDf0Ks?=
 =?us-ascii?Q?YbmZXuOkpMHtXvKQSyC01/wvJpCLOA3LDnqS28HpGexb2cTQhwwzxq3kBDEv?=
 =?us-ascii?Q?QGYUAYvKQeCnMtB/egRIiImbbsU//buFyhpN7k8CW5W561mOtT4pybb72VDT?=
 =?us-ascii?Q?OzIdHJh73+katUVe0trEWOluTtFUPSQPddefOcywu62X5uqz/SkdpXQ6A5+5?=
 =?us-ascii?Q?rdwmaa/y8Kd8/C/OEpMs4eDyGNrXrPVkNiNZXAQKusF4jOf6q9BX/8ZJHgyu?=
 =?us-ascii?Q?hE+XE9vcJ1KfusE5pG7FleJm6pV/vgDqQ5t6H1l8n87xeLhv4q6OjpuKA8aw?=
 =?us-ascii?Q?TNVWPrf4GfvkFiaSbfbt3/BFWBrsxoXUu7kfhKUXakxvUy8Ippi6Z7GeAvWg?=
 =?us-ascii?Q?h8dqtFRNmc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82W5wfK9Yc5DrCIG8xujKqNs21pmAVShRwHuGdfH21awJ+QTDTBFc7f1HAfd?=
 =?us-ascii?Q?vcoMx5FL3SLwJs3xwpOlVpOo3F/w2k4liotkr/eWYIK4YlkJu6dUfp2rhwgs?=
 =?us-ascii?Q?/DR9EDmP4vg86jlN0oqwjw5CnUaeIeIhO5tJXXUnjrQh6mxQ1KUmL494syf4?=
 =?us-ascii?Q?9IZj5hp/NVdyaE/ZMd7OjupVSdb54Sg02QHPayhXqgeEp7kOzkSlB4lmpn64?=
 =?us-ascii?Q?vXVFEXj65zpCRRE78OIY7dZ03GZewWLCaGL9oX4JB6rWJ7cw804iv5jfxLBI?=
 =?us-ascii?Q?4WnlGHEhDNEfOdLiZiRa1doF9K/gqohYzdoxTHU/M5suos27NFuR0rjFUhU+?=
 =?us-ascii?Q?KArKUjJ0vvP9liPVVHyI2IIR5WWGDYiQcdXf41Ot0TGYYxRV9WjtU0FaCEjo?=
 =?us-ascii?Q?qfZ/k+jHVvAObSk2rjXvZt59PWwvaUgWmBxGPrK6zDUNA5OPHewq42NUflD3?=
 =?us-ascii?Q?FbAMM7G60nStfPYF5eyG5kf9h6sSWvxtONVRNrqzlIx7ShLHsHYedry+xOQT?=
 =?us-ascii?Q?OfqIgg9dMJSAOZskopobQOdE5IMnv17cFX4RHThxciecp15PNrBoQIqOa1mx?=
 =?us-ascii?Q?fB9gAf/HMtzbESq3u+FunAaC8x5VKQU/RLZV9B0xleJfL3avJSSLJUzEZi8U?=
 =?us-ascii?Q?p9kK/cqyw1xLxgGcu0GRrHXzBJUY/96cap2m5u4T+UI4JNxyYl3IuaIraRL+?=
 =?us-ascii?Q?vdEwNNtzDm5wCRzWNx1N5wfi+qOPUeZ1kjUcPKBxwHQZvzLzlhbPiYexnMze?=
 =?us-ascii?Q?SghnKXlFu1j+o+NvSx+YEDpgvV7KMxCmig0CGJAxFfmP3TFcJeOP6AwELYXx?=
 =?us-ascii?Q?HOftUg5pT4Al8HKhTNj7RKt6vB4OZtBVzVbGfDkzCo5Sr8ZihO9ENcN6mE/b?=
 =?us-ascii?Q?uzcST9rEkz9Ow1TlXDyxoWAWApozPgU9lSIDsQBIp5T/vRJse9urzcH22GKS?=
 =?us-ascii?Q?GCCeQczU12WOv6ZgX85EZt2aLv1ByWHGq/JkjqKKCF/csoI1ay/Ty4ZGmlBw?=
 =?us-ascii?Q?rf0Tvs57k+VVj2s/tENeUG2fDGG5FqNZEyU9CYizg7K7z/8Q0d9J2WFfsUUy?=
 =?us-ascii?Q?jf4ARZpQSd0KQp0O+MIairuvTsSkc3xs5pT9XN4rO1m7TDYJj75UVID995aZ?=
 =?us-ascii?Q?jBE9V7orjAki8iZSSZDlKJhZ7yDvb/0h7VIEfccrDzIHj2yOMoMX1f7LghxM?=
 =?us-ascii?Q?J6g+z63yr1ReCqzzvZAOa2k7zxQvH4ExU+6PptKKlE+1fnF9leApFmGCzPM0?=
 =?us-ascii?Q?hcPfJ9gPhtc8XDMzPSJi59dPPriB7VSZu4C1bljz7piHqPIkTmL9+QvhO491?=
 =?us-ascii?Q?orvchASme0K0ndavskVvw8eBVKdUBYyxjEQvfH9zkBk9i3ncXnQeIQ9zvhy5?=
 =?us-ascii?Q?0D6+VllWskYPxpfSn3aztg3ivEQdlP0EL7fqzUn4ePnWFxhRSbDcHd3VSa8x?=
 =?us-ascii?Q?NDk8DUDNqOJEQ0qzxCgv9KRl0q1oU5QDNnNhcSIaFJefZoJjZaPpx34Y4FT/?=
 =?us-ascii?Q?kMzBZMrxs5qDM3UDOIUiyrysUl2Fh8ar+bDPzsw2CySMWWGoav0d3oCKHaSn?=
 =?us-ascii?Q?nzILHvg3w0QLes4rUDDHFYhOge0ibPhoLM0ABjpl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9a1fba-abcf-4c95-3e0d-08dd97baf2e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 16:25:35.3136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xAGDwKmnm4p2BN+xd6BvYyyF565dRGQQoP2UJb0PeFYrN7uX2F0vJOg2eNj1qjsfGTjVB22y8KMyyQNdOwT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9804
X-Proofpoint-ORIG-GUID: YzbSBmG3pSVEU6v2vDNjbjoaK2kCqVYC
X-Proofpoint-GUID: YzbSBmG3pSVEU6v2vDNjbjoaK2kCqVYC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEzNSBTYWx0ZWRfXxn43wzVwmjVy
 ZXCNg1XjuQh7KOlTRidbLBBA1rxixN/B9Gi2VXt1BD+/eE/NNegLZ8LpTB+Pq28XulNcdOhcORf
 xOXznFuHQglSGkuvS7Uwa2EkqjgCmxOTxr/rY+TBI9LdQnJkgQSzpZx1Vh/dzRdloNLX2+VgZt0
 tGngtROAS9aYddbGwW5MNVqsI3xFMm3DnOICuNuT/tisUA9VmPdsEIRv9tVRHdbhGv8/1+hHh5b
 6r3pzV5mo1z28bUMK93e2vwm7lJkDsF0gUpuqj3OsIMP/eRf2kl3gLj/q2zWkvfo5pI+XyHkETK
 3s8Dlg3qheNkBgfi5fchWxsQjCg1apK8bRplxdEzby17chA2IAZs2oTaSjkI+vdehU1BMiWrA03
 nFzxejq1WIaTlE2CL4frUs/7HW2OMlF/7MSiCsTnRz0uw7mnU5Vez2mcG+BmCtlYr9VEwplj
X-Authority-Analysis: v=2.4 cv=YvAPR5YX c=1 sm=1 tr=0 ts=682cad01 cx=c_pps
 a=e6lK8rWizvdfspXvJDLByw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=UrW5fgWPM3IBa3_2MYQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add some additional doc comments for these class methods.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h | 75 +++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3d392b0fd8..f9e561cb08 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -115,13 +115,56 @@ OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
 
-    /* basic feature */
+    /**
+     * @setup
+     *
+     * Perform basic setup of the container, including configuring IOMMU
+     * capabilities, IOVA ranges, supported page sizes, etc.
+     *
+     * @bcontainer: #VFIOContainerBase
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns true to indicate success and false for error.
+     */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+
+    /**
+     * @listener_begin
+     *
+     * Called at the beginning of an address space update transaction.
+     * See #MemoryListener.
+     *
+     * @bcontainer: #VFIOContainerBase
+     */
     void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    /**
+     * @listener_commit
+     *
+     * Called at the end of an address space update transaction,
+     * See #MemoryListener.
+     *
+     * @bcontainer: #VFIOContainerBase
+     */
     void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    /**
+     * @dma_map
+     *
+     * Map an address range into the container.
+     *
+     * @bcontainer: #VFIOContainerBase to use
+     * @iova: start address to map
+     * @size: size of the range to map
+     * @vaddr: process virtual address of mapping
+     * @readonly: true if mapping should be readonly
+     *
+     * Returns 0 to indicate success and -errno otherwise.
+     */
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
+
     /**
      * @dma_unmap
      *
@@ -132,12 +175,38 @@ struct VFIOIOMMUClass {
      * @size: size of the range to unmap
      * @iotlb: The IOMMU TLB mapping entry (or NULL)
      * @unmap_all: if set, unmap the entire address space
+     *
+     * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
+
+
+    /**
+     * @attach_device
+     *
+     * Associate the given device with a container and do some related
+     * initialization of the device context.
+     *
+     * @name: name of the device
+     * @vbasedev: the device
+     * @as: address space to use
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns true to indicate success and false for error.
+     */
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
+
+    /*
+     * @detach_device
+     *
+     * Detach the given device from its container and clean up any necessary
+     * state.
+     *
+     * @vbasedev: the device to disassociate
+     */
     void (*detach_device)(VFIODevice *vbasedev);
 
     /* migration feature */
@@ -152,7 +221,7 @@ struct VFIOIOMMUClass {
      * @start: indicates whether to start or stop dirty pages tracking
      * @errp: pointer to Error*, to store an error if it happens.
      *
-     * Returns zero to indicate success and negative for error
+     * Returns zero to indicate success and negative for error.
      */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
                                    bool start, Error **errp);
@@ -167,7 +236,7 @@ struct VFIOIOMMUClass {
      * @size: size of iova range
      * @errp: pointer to Error*, to store an error if it happens.
      *
-     * Returns zero to indicate success and negative for error
+     * Returns zero to indicate success and negative for error.
      */
     int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
-- 
2.43.0


