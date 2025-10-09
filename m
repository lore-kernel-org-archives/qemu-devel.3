Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3927CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rE2-0000o4-Vo; Thu, 09 Oct 2025 10:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v6rE1-0000nc-EC
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:02:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v6rDt-00079k-JR
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:02:33 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 599888FD483807; Thu, 9 Oct 2025 07:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=TST39DjItp1lD
 OfglqwJyq/dQTzeLosDeg/IDtz0ZYs=; b=usMYZNT91chJgIce3cTnpklOqCK0E
 7PcpbDDmsU9IjalvMQjzVlTOHYi0YrNIzObnuku8koo/dJ9FXQN8slL9qGvFe3Ba
 NTGuuLV1LjOU/6KbgybaJTuWhLPPvfRJLa2P6pzChnFVRBw7qkMYgYwIoFNKLseX
 08wnVshC1yraP60EaYRCe8FfpAKCpMSqoOO+LewVArwF/U98qtdXLkxB61VtRnRu
 RHN3cdqmA5xTLfl/vpm0ntjS5/Zfru2PP97vwc8Mk7IXzAm/1uhHIDtVAx/IMv8V
 WH2qjJEWmRKxU9odilGicE5AhoanZDMSaRSxBKH0aDPWN4KDj1qJaGihQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021128.outbound.protection.outlook.com
 [40.93.194.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1uj2vw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 07:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/U0VL+s2ZCu/Vyo9hxRtPV5RrPT1Zvp3MkGBsTPv8bgxKNjBEKoJzd2s5uG5Pw5aT6yFSLovEDV6yvBi5e73hfRYuLQwpkwhr6N6XGLVK9G93VYDJqeuaNl/Y37rZStOn21/xFyr8AGbmZswkUCEwe3QBIQNz4UM+lZvF+Cn8DQ63FhTv7bzvK8ute+7+TXZcgC9OJPCjXLq8aeLgBgreIPcTnJcZrVdf36A65TijMciUyKu0QTOUEqdXb0j5XMAswoByzmBE9VAEAJ10dh0XUAXNEy+kQYElApEfDM2gUnbWnR7zPTc6aPCgJw1LQmp1INIea6+Uuz3n0N3pGHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TST39DjItp1lDOfglqwJyq/dQTzeLosDeg/IDtz0ZYs=;
 b=xYSq6cjdsndQaK5KL2SEXpwKAGTs6x+AEbd9W23C1CdUu6ef2H6EGQsJH7b4SzYaQCMpRr9d7I/wTz20QygkE23RD+359kGUWJSpgG7xkdxy+tVrdeqQmru3iQpByO8nmD6lo+N32wASiTadfXHA0Y9udd4yLb7TmFJO5/aLJJFSkcEvq6Yb3c5VfbqBVgJX8juKYEwDIQq1BBpCL8bt4MdxSxx9AaeQrij2CQJVc7gRG6oWwh92JqOIjOfbQWO12n1LrrgLLk76dlJ9J6MjuqYOZfgLo4JYHC21ihyAqSrUt1fiPrfnJPAyi4cEyLxwq1m0954NJwXAnQOfx5jVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TST39DjItp1lDOfglqwJyq/dQTzeLosDeg/IDtz0ZYs=;
 b=Z6gfEslOSIJeHxKCBzi8ZbPP8fw+7Os5DtVEIjJcHwchvovJ7Hj8XjifHiHRy6DhVmZXrdaE8AdklO6PUek56wLM3ZSUg3y9syjePERlAZL7C0IZByTOx04K+ssdxz1MBfR2UlWw6bMvsw1ENOIF1MMHH4bRaXk6i8d6b5awMcq7x3B54u/S7gTQp1y1LXVTDtlRjJESFY6D+aThAzXLSugqRKHJXKyTd1od+G2yLYHEJ/zyv0nQQpBcsYGoTM/vb05xEMtObOkKt3xt4hHGnxkis+G+BpucPNiadrnnES3aOT2bUoMPwGeBNBKgOXs9+MRPDI/JDiFU6a5KRk8CHA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10473.namprd02.prod.outlook.com (2603:10b6:303:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:02:10 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:02:10 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] docs/system/devices/vfio-user: fix formatting
Date: Thu,  9 Oct 2025 16:02:06 +0200
Message-ID: <20251009140206.386249-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::9) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10473:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b17701d-ae35-4881-7a91-08de073c7044
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uy0BlPRmP3PvQapZtB6bsvQ7lL34/sSLyN9rUOUSlbpndytL0TfYld4ZkjVf?=
 =?us-ascii?Q?m27+KIsBB+JkpHG4drK/SL5Vj/pxJ9VboGuLVJ1AYgpjaBWt6l3mu2NlkiHO?=
 =?us-ascii?Q?5p7ELYhzY5BY9IqlGw9QTjtUYW0+fCApvybP7Ft56qoH+LLP4OOzdyKZh2Qm?=
 =?us-ascii?Q?5Z1VNRRdR3U94q3XUEfzTu0Dkq+baI/9MQB6nyZOK7Cec9wz2rF3PBzaqqIX?=
 =?us-ascii?Q?1jB959kb6+2Wwyi2+Ng4QwAHx9asaasYw0UzOtbe0MQ63ft6d1Tp2a9xmU8Q?=
 =?us-ascii?Q?255SVa8EIW3po3h/syie+EZWcQZFaVOTNcRG3owu20TbyJgZAXc8jpbkQj7z?=
 =?us-ascii?Q?xT6+4phU6O//yXgCbJggGlrpA9Hy/DnmcGw8fFkceTEvN6NBQOn9Oobo/CmM?=
 =?us-ascii?Q?CAEV/KHg9kGl+14bIts/u3YJJF+WRFoda4gBOg+iKlAdVzBq5dPbdohXqOS2?=
 =?us-ascii?Q?RFGsDsZhDuFbc4E3FIATUhPf70oovplQrmqnPxVlm5epwRUx03hEQQSmnMox?=
 =?us-ascii?Q?7sZ2SUxBV2r6EtG7cQgHyF7PZpQDSMAgBFbeKC5wx13Lbuc+YOo6JFd0Kgkl?=
 =?us-ascii?Q?+DfNuccryXvzbME056itGuSLajtVMa1JdD10pY8g64vkZhDWL7tBimoGn+LC?=
 =?us-ascii?Q?0ZVnz1F61obyHCUzxmeMBBM4eH77Q/IF+M4JEh6LgbyUaDb+UtvPCRmJ3Ary?=
 =?us-ascii?Q?UyUEccsxCT4z7b4Z0R8z8uWGo5riWzXrlxKfXyyiThiPS/IsF4+33OST2WNY?=
 =?us-ascii?Q?bwb68STUzTvPyHPzSLm+If13o8xPYaGEuVaV7WsGyWpJZXQHta0DwokSNw9X?=
 =?us-ascii?Q?ZDY2udm8ViZaEu0QnAz+2ZO8qnhlLqQ54XvYXQYnE8SMfv2h+9mCgus0itQJ?=
 =?us-ascii?Q?8PlD5vF61SGtbniAU4aSZLTNbvKYfIKi5ZJ1Om5lSbZ27U2OnJiypb2CzD8Y?=
 =?us-ascii?Q?MUJ7+IRu2xLhgqQ8IqN8Y1yLa3jZksuShtzL6FhhntPu+391tE+RLd8rZtmX?=
 =?us-ascii?Q?MJJ4a8paeU3MYGEWEh6qmfqxbjyF29Bnb52h6INf8ria9h08khThIFxoaqp/?=
 =?us-ascii?Q?wmeuM/cLjwRrA+72O/xLVAYB8AK5ErF/Z+nP5Fseko5p1QDneRr7V/95zx7l?=
 =?us-ascii?Q?R4wq8ZMtw5S9gL/zK9x0Nghf0cmKGfOa3a5bLAb6780MZTCUnziIWjEZL4qP?=
 =?us-ascii?Q?+WzP36E7MwE57rQbrgB8crgk/03DiRDrlv3Gjp9zurfwf2Kah7NgLdUkVTxN?=
 =?us-ascii?Q?V8T3wOki7+prVqi/SAFGwL3ch8H9+ekRMHTBjZt2B/+w+6KmqAksX7Wsf6ko?=
 =?us-ascii?Q?ICpIdjbrfrsyPFtgCq6quo28yarxSwwubwsWXapaUdFa/sBkGrOm+qcxvt1S?=
 =?us-ascii?Q?hWVvqfHpzeQ5qJolCCRZXI86txdSTlIc+QEskyG5IpPgF/yinWpBhkwDRvVK?=
 =?us-ascii?Q?TUNG9hyNLwQ97MSb8Aag3exCZQaWouDF13VI4cmxslwF4qdMvpx5RQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NxO+4qzsM1EdkonvF6HxNZKq3AxMF3XoRdBUCMHkoiLiAfPEyY1oQB3SngM?=
 =?us-ascii?Q?yp/eLQ7wt4MwyY4A5eqM4NAEUFQcIXWQ5BJGy2mT8JopfborurejvmUUizi9?=
 =?us-ascii?Q?gTIjGMwiuOISkcHDKnmEZ4Y2bTAM/bu3YsKhj+2tPm5p8APadC1mUnHRgEwR?=
 =?us-ascii?Q?mUbdwCFkM+nqmyV6cRIgLjWJImWZG+wdk/iCkEBoIiiId+0eAFnNVlHozsEH?=
 =?us-ascii?Q?FD/X1mf4cZuIX80Fy+orTb7e4tqc2Yb83L+NGhsJrl73w9i3TOHIrlyBna9S?=
 =?us-ascii?Q?ECL1oeFTrnDjdkjy1ccYDM3SWZYQqbXlrHMjwBIGCSF8SmYBfckKK1dSOmFk?=
 =?us-ascii?Q?B48IybX84aN/KybEfeczw3uTfdiqgLLhdRqOC+cChv8QimO0Fg3MI24eBnsj?=
 =?us-ascii?Q?EUCAn7OUaDol0pCbkXzHX5FJLnsRKwmIUpAcvwRwBUtK0haQvqU3Etf4DaIK?=
 =?us-ascii?Q?UMQdGwOVS4GQOHCsGGqb44HbRwDl4pfhovys6bOqA9/LlQ5dB9QifgC5i2li?=
 =?us-ascii?Q?u91H9RBOVRufrBgzVwWQ7+dcT0RgT18uDWDaQwTl4ck3pKVTQuitG2UKiDr6?=
 =?us-ascii?Q?Icme1qHosuaelzBUeHckOwaZKtLDIaPA1ypEHcZ4qYCT/cbdT10sSOUDHTtC?=
 =?us-ascii?Q?2rK/qxeNmvasANBRv6ZIP4Icr0URCyl2qUvQ5XWvMgugVc7/Lv/4OJowrKfY?=
 =?us-ascii?Q?PPnm8Qpe9w0TE+VffyM64pwtdNFt0gQN/fr+/Owug5OkXHr2hIV4RTGPJmg0?=
 =?us-ascii?Q?o+U2xIYxSiKL/xPq9tlIQUAgGbJdI78hWrV4gzP4+HGWsWytaXijEtVe+ABo?=
 =?us-ascii?Q?IJfmYfIbmEXUMvZndiWQiXiDHEcmkenJuLeS7ArtkgNMrJGCwUzFKLbgg2up?=
 =?us-ascii?Q?t2MTdxF/cdSWPKdPQ3EgWGzBzrm7kQDP5cUIHNjfnvSidz6egz7CAoe6uaua?=
 =?us-ascii?Q?knc/TMwUUUy7gOpsWKmdNj9CU9aI4kG5A0cGfuppb1VycHAGdVOEr1NxA02F?=
 =?us-ascii?Q?lwb9dBSwQM49GsGPtB2JsYN17/XiNvWObngrVSI06+JJl4rsbii7opqrrshO?=
 =?us-ascii?Q?m0R6MskNZKFhJXGi1uJ4Iq3e5vY+AhqUo39iGqzIMrzz9DZQNZ5JUw5/OQiS?=
 =?us-ascii?Q?WgRDsJMowv17PHQ2V+ujeIzEZRvQY1FOhqOhCtwff2xqyCm9CT0AwlGRWpkm?=
 =?us-ascii?Q?cSb4j/E6PAnWvqQR5tr21uNN80PERiPxqr0yuhspxBAtbLNcRLmNnjwMUg8X?=
 =?us-ascii?Q?frAlh81hZFPfe/B4FokpGI0Wyck63lomF7c9r90LQVcSir+RX0UNRqZFjDHV?=
 =?us-ascii?Q?0F0m7EcA6fYV5S5+nEjSsSc7cVbBKGT9WnDN/pMIu9q5r8ZRTGtFWRzy1ppq?=
 =?us-ascii?Q?0PIJWquI0eUJWt8a697Syed4VPMHh7VV+dpHylZNnY1054cUh0+5/MdIETd4?=
 =?us-ascii?Q?cJMdmqap0a0OAB/tGxAh7iLu4+Q3XnArSSClIeEaaUSEKKf6jYfW6vk8tjFO?=
 =?us-ascii?Q?O2W6xOOKiXJkYEP4N0lU/bY+KLUbR2dePniFzp4tfSNBVJ+idVy/19L39Y3U?=
 =?us-ascii?Q?bp5DBgyZdP2XGA6psYsMwwRNjbR5IxSHACnDMIAA?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b17701d-ae35-4881-7a91-08de073c7044
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:02:09.9637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvRu671Og8470uSDuU7BwzyJUszbvo4v8x0BhYYol07cGlqngw/jK/JbERLH/ZZPLAL8dw4VhYoipkgMUtMIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10473
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA4NCBTYWx0ZWRfX5ZW/NM4BcDsF
 cwbfuPIii1YTBZL9+6+tR7DtUEyFbq5dDoin0hYLVHx2VRZsqd6KJ/khAd99qmmmfMP2P/RW0qe
 RQa96+nDvVLr5+HKfhcBNUkGAjrmCnew6lDJMGM6wAdtdylDuP6bcogG9YluTn0Y46SI9r7sUM3
 DjLnKLE3e+8Zwy3JXVmDWXSba87z3Mw0siwND8IrpdFEraMAkCE0q7R9AkBrc86vbGhZkv+uGwY
 I7qUCuYBq+ORmDk3nyGYFgwM+5P/pN3iNFOKA+aDF5R3uEaYAriYhYSzsNXlH+/OHxBE0cZmP9M
 xRwgAYk3fUbDLgnirJo14c+NIjVuW8a7EHT38QBr7ht76zA+54isJm4Que8LjmSvcxBBOCzfX6/
 /hWpP3tEVkTL7e9yvZMD4n5H2IvuJg==
X-Authority-Analysis: v=2.4 cv=J8enLQnS c=1 sm=1 tr=0 ts=68e7c065 cx=c_pps
 a=iGETFsOoOHXRiUW2e12q2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=Mcs2P1E7AA-yyT6VCyAA:9
X-Proofpoint-GUID: Hixr1CRWtQOI5plssInUg1gP-ne7ZbJr
X-Proofpoint-ORIG-GUID: Hixr1CRWtQOI5plssInUg1gP-ne7ZbJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

The example QEMU argument was not rendering properly, as it was not
indented.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/system/devices/vfio-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
index b6dcaa5615..7c110b1644 100644
--- a/docs/system/devices/vfio-user.rst
+++ b/docs/system/devices/vfio-user.rst
@@ -20,7 +20,7 @@ Presuming a suitable ``vfio-user`` server has opened a socket at
 
 .. code-block:: console
 
--device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
+  --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
 
 See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
 information.
-- 
2.43.0


