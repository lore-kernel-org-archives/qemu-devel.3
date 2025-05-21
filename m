Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E159C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 21:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHrQG-0002br-D7; Wed, 21 May 2025 17:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHrQ8-0002bP-VF
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:56:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHrQ6-0006Kq-Nu
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:56:16 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LE121Q021083;
 Wed, 21 May 2025 14:56:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=4bq8xtLRIHI24
 0rN16S397bEXOruu9bGT9xZ6WIjEyY=; b=xKmPF3QwuFdSQ5104yICHyWtk2yyH
 y3yXHV2JSy0aC64U7MDrmeQ8bayyZwJRzjDawf+nzpwiA7i7YQzCn0HTlVQVvD5t
 lHOIpymTW47AgXKB3dN5CwBDByqYyaxwd2pOEYHeQWcUL5JJ7nivs1q77XGm2nfs
 ZyZqe7iYFDylh70x8PXuCT6YLAYi/EaKmWXXZ9ltcpXsp0d3Y9/7eAlWp4EQ4loP
 lpJmYv16VIGXAjoHNvj/bAGKKRitULnMAlLEG10Z1vbG8+6wnY9S4ULXulynk9Li
 9X5HfHzebQwYxqBFW+pBkvqHlEhJodJBvCBpvL5KwbU5win+txjvldbVQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46rwgs3qgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 14:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPeka5eh57xMagqteETqCv+nMZP3a3KuJYd+nm4urU8GAK4RmIQbVuVGt6FxEhHxxFiWdM/2/EYRc/pGnyGIZrtbOW9EP3tncYUjtXqRGz7j426tbVgeuL3wdzen4Y2Gcjs49mBtC1RuM6S2gh6Q/2dRY/ag837jMpvFsJDTZKBtUX+uD3a8Io/AVQYgUJUS3w8oZZEpldA6iRMWhOe6X3CMkhSssPDuFrpQT4Hl8ra6toKLJZyoLYzQicYlSYcoOYn1j39jI7EOKj12jEto5M5wm/ApE70cskpP30NYupqlGYJOSQB9hJPVD+YaUL9J5QuwRkPLNq3L6euqiopCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bq8xtLRIHI240rN16S397bEXOruu9bGT9xZ6WIjEyY=;
 b=b9tfcJnOCp0qAw+uxmQW+UXHHTgGz+SSbpD5ZBhOa3g6F1pJ5rEW1kDI2WaqGNTM2IPwzkGUF2Xhhj0xW7mWwYuGiNSrpaVEUsJhwwgw2CvdtbRaoL/S5sLWVaFIM3+trAQ6yLTvz+g8ey7uCW4fwna8CpSahBajTQ9D3OAmoalj5HRu4nojdydhyOB3xwdl7NEoie6eLSxGH7Ukn6Vs8sZfc+yo4QB5hSIaCr3Xm6wqu5gQ5PduWBCYiRT7pI/Eo9fNbeRwfUfCB5E1q1AOC7QfDUURh/jPe/vfQz35JxIQ7Xx9SCOxEXtgRq/uKWI5QYghLrgxypolefwSJvnuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bq8xtLRIHI240rN16S397bEXOruu9bGT9xZ6WIjEyY=;
 b=DltHpoACrLthoM+oHX47TbgeCeI1PuzOWMXWiDmb9AFPJovYERVSBYYlKX6Tr2SmMvGoFHpJnVJhae77TnrFWrOtuWaXSraHkJgdqjso4r3Myzd8lNgWKJGq+wyx2T8VrDgOibKCJRbOZE6no2BoN6bzFiIKJeTjGRYjnVaggG65dfkvsqIIm2RgXDn7ps9xunkwQayd9UdxOJYi6yaqYKizT1h4IHm4udcQTBrqkXrqzBkvJn7D89/7ywuL23ywc9/Ugsi5OXYUXbAhYSkMZFQeE6Dhd8bAhYpbN8kom2NR+Zyuch0VgkkNhAb/CSbvP5F6KiXQdHWd/th+adgDkw==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by BL0PR02MB6532.namprd02.prod.outlook.com (2603:10b6:208:1c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 21:56:07 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::94a9:746a:7967:ba88]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::94a9:746a:7967:ba88%4]) with mapi id 15.20.8769.016; Wed, 21 May 2025
 21:56:06 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, steven.sistare@oracle.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH] vfio/container: pass MemoryRegion to DMA operations
Date: Wed, 21 May 2025 22:55:34 +0100
Message-ID: <20250521215534.2688540-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::12) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|BL0PR02MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 5482028b-5c02-4464-8799-08dd98b23c21
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9JMuabaTX///cdHy/enl0ewre7kUAzQKsLyH5yWH9RTm0nAnkjQ5vyHlo1E?=
 =?us-ascii?Q?1I64q73Ufa5u8jG4Emtev2DDqcgg3r/EoPU8mKu4B39aGbD2ev8iH3aCXRxE?=
 =?us-ascii?Q?J034haq1qOXRLFxQIUuO2t0sdHNNtTzLltFVvUd1ekZBkJOOtfSpXIuetgw/?=
 =?us-ascii?Q?WNSPzI9UkAKONxI+ypNXW+urvzCDQggX06CHFhentISAFJXfOxiCXwr6VX4o?=
 =?us-ascii?Q?EDUYAMLtPVU3ufppmaM68bqGkgBE9ySggYVbaUUH45P6Ayr8gtvy1zJu4w4W?=
 =?us-ascii?Q?uyWBYfrMYhUUf4cm9cH0pJhf7ToIvOzGbuew4nOWmOPBqlNZ7CdhyL2nFsit?=
 =?us-ascii?Q?agq2DKo+1ovCAaM8JfLm4B7h3ci9SDmz2xYybQhis/oXF5mn126qQ9Gwj9eU?=
 =?us-ascii?Q?AvJaf8T5Sp2UG+A5aa0shLICXM12u+C6K7yiuDTyC4VEZ3UXjWa+CTcB3IaG?=
 =?us-ascii?Q?p7Bk3B1r/Ezg4ceSxmV1RVFag9R/2Hahlh/Q4Iia6S4Be5y8yCa+E0aY+LJX?=
 =?us-ascii?Q?zMriwxccpVLMYPrkdc2A3S/hAtLG7mk5kX/YfdlfmugxWPxlXau4KFP4oSEe?=
 =?us-ascii?Q?Vwg/dnehhvRjhQbC8apfskIcJAEuryMfIW3fhXzlngIGdxZ2SXPRTQouRdU/?=
 =?us-ascii?Q?SNweE165jjFpahAZ6xQXCqv5QD9RUNqrqTvMwHdOpwO/70gZpq/BmlF3Z9pR?=
 =?us-ascii?Q?A8DVHoqjxGZ11vT9fpwMK0Mn0C0QLlH7gjfNRs/u6Ia1vBqheDSDGD1+3RL4?=
 =?us-ascii?Q?K/RgsT6/j9nOOX17nxW43uchkJg9yoGUwqLIlba1r/uQtPwhOF187WWQinlm?=
 =?us-ascii?Q?ncRKwV5AHGq1RyK2PnY8W/t2HV/k9ateeHBa5L9j3x2m+a5Onnt7CK6mGrNo?=
 =?us-ascii?Q?IPmTl1HgqcB8/LTuOSqfVbIbeS9Q2L5rMZC14tzxhI2j9/ilOWDyrcy6KS/C?=
 =?us-ascii?Q?tfTxBlrwHNntV70+lv5K5SRdegqqeHIrgnL+l/nZ7T/s8KwuUkmSxQI8xTA5?=
 =?us-ascii?Q?dW45pBXrStS9P4UpzBDkkTApGyzeeUyyp3zUSFmy5vwbP4S8n7KU5l39eW3g?=
 =?us-ascii?Q?OeJnelFLiWVIRt01iVrvkhjXXp1HUnPLsDP7bsmgntDKg54tCKzR9hykg51O?=
 =?us-ascii?Q?nfLHRMnzBmTQeRHhee5x+f7VrNcaLGYzReCcl+OYimjH/IWUxSgUfWtDQPsQ?=
 =?us-ascii?Q?dwakb2tVu9CF6mvr91ji8jajlJoq66PDqrmN9p3qaFyReDRlk4iyRK0tspMb?=
 =?us-ascii?Q?DOZ2kOAppFCWZcO5WxgbStINE45q77l4KkUFMquWV9a+40Y3kmpvVBNiw616?=
 =?us-ascii?Q?3Mn0vvRNcfIeyb+1F5UV+2vQAFZZIgFnadwQT3V+nXuEYejq3CY7lgg2LYIh?=
 =?us-ascii?Q?Yk/TpdZdHqz2SC5Fe6m+ngcMCISrTRVce3kiDmF+aHfNkiljYS6SA0vSoH/w?=
 =?us-ascii?Q?wgbHPCGiTTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZPFtZVJDll3lgdX6tHhiYnNguDgYqVHJUnt3cRXRKq6rnZ5ru/sUQbBGKW4?=
 =?us-ascii?Q?CyeYk2jmAeam9WV4kpzLZ8ymts0Moni2bD3J9fdjlCIr8fd093Y6kOU1Py2N?=
 =?us-ascii?Q?ZuQuFc85A6Q/c2NVSWfPuz7eVWHm/mGdUwjHuB8gAfid6zjNpZObp1uB+KrF?=
 =?us-ascii?Q?k6JKBaYImNDiJ6Qd2RBxRwNghnKKInothn944pcwk22e2voOWwVQT0IzMDlG?=
 =?us-ascii?Q?1Y7zaKDQgiMD7GVGjwBI2c2lXGqNLNtdL2ekEzCnqLTzwO9JSv4aXiPmwqBF?=
 =?us-ascii?Q?CzZr7hI3f0pBxQNr1SZ67BraYHVfx2xZdGib+NtQzJs/ypiioI5T7gBu1zlp?=
 =?us-ascii?Q?XAMcCDcWolNIS9RA88Dhj9THThzjyMxcjCNMkPibQcKCh15dnE3OUjwR5Teb?=
 =?us-ascii?Q?4GnFrcVKHXhD2TN6cFJoBRNOyiyZ2boiaUx7Xw6rz0Him4s1Sgpu+FmjwuO0?=
 =?us-ascii?Q?8e5cB7pwibf/VuV8h8UIex11qyE1wfxs4knD3rxEk6n847Rwlk5slpBjyhGw?=
 =?us-ascii?Q?ZFlHVsN1I+9DKS3yFylaETFddh5ZGbS044aUqYzrQ1d0EcEIhdPpiUfY9IBk?=
 =?us-ascii?Q?XjUa3YJry7ofhfaPUXwa+QPwcX1Dt6cjEa4QnW8PJK2mGeJPtnBkhyMUjClj?=
 =?us-ascii?Q?lu0iafLSUObtvFnQ+Lh7XMc0aHgitvSni4u+4Ro6oLRngDKWTHF9V5wAYsnk?=
 =?us-ascii?Q?YbVmpCzt2aes4ivwhRSHfEx9YWUhk4976Fbt7Go3ygAhLY8eajT7+rP0PqDl?=
 =?us-ascii?Q?ph5Z92qnpAJHexJGlFDQs+POsJAnrHsabb8JdWcH64b6COh+Vtb/w8FQ0sVm?=
 =?us-ascii?Q?8J1A+g3h4E3MZu1yvrbRnIquR8Agq3Ih0WlbkR0Y/sbJDXZPmNZtGkS+5AZM?=
 =?us-ascii?Q?kCaONjsrlz+obJFbZOTvL4krzkjGbTVlVMwbsP/vaYJW34cCVh4Ns7UNr6/g?=
 =?us-ascii?Q?d4QsLt/OLGzR0ZS7FPUcLbiA/l++ndCPdhBKfQjT1DJwQQsXC3KKXopedxhR?=
 =?us-ascii?Q?QqIApxNfrfnwhRVqg3FY82TQhuTY4gG1IpCaJO1yBE/knhHpPAAlApIdm5WF?=
 =?us-ascii?Q?E6Xj6h2gPHy8qUWJ2tffQPUIGGxRVlpztDUUX7HlxAbe+hRzlr/jsNx1Pvza?=
 =?us-ascii?Q?jlPHQAK56hYMwMrYeNsGOf2lKuk3ubtr30G5EJUAcaTwnAF3G8LtbkIdQrtk?=
 =?us-ascii?Q?QoViR7eIaKRLuVQpqFEJ2kqtvLXigjYm4xJufgfS5RO6q0lYbkfQjtQSh6Td?=
 =?us-ascii?Q?64h0t7CSWlcSMlsnSyZxREXfUT5o4Zgyj/Dm5KV8ujzC+ECLhuRvERBDzSkI?=
 =?us-ascii?Q?yvr4HWSnQgLTEZiqUhowkbS+qNuySvZ1sgP9Jc88I8DZV4qg5CfAPALe/Bv3?=
 =?us-ascii?Q?HiEyr9NBY3iEiAfax3DAQWT5MECOxicWcTWbL++FP9sr9bzN9BV/254C2DV8?=
 =?us-ascii?Q?+/aL3AWWzODjxpeQZoTDnYODs+FGpM7gxZhhtumCoF+nT79YGLKv/vMUt9i/?=
 =?us-ascii?Q?/6G0GQw1lVUSpxoyZJkS6vYioCJ5mlj+JoH7fbbgzfRQFOXsg26g7/WbgL3W?=
 =?us-ascii?Q?fFXrBYfpP/xRYv9sYy9/rvrTk6DXwKOFEutvAjyo?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5482028b-5c02-4464-8799-08dd98b23c21
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:56:06.7536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzRwcljtfV6xsBiBj/BYAOXM8UMcr7Qt2lsu47uYHwembvIXkmclhAAB0al9bo9lRD8Gd62hquKflXwnvyEk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIxOCBTYWx0ZWRfX835kDet4wPUf
 0x80a+IQZoruHGVXOSvDzHea95ascsborQjw7frIPHIiOPpWUvonimR7lRi8c4mC1uHpFsVHd3U
 q66kldErnQr+iHuzR5GlPoGPnMORc9A7sV/VE/g4pcpodSQUvGCAfEuxJLdhRj2CXRyW712+ugh
 DRwwQZX0MYJH8Bx/TwcW2Nci2uO1sEKix3Rv/GdYI4iuU/JXthImyimmWoZ9sHiEG0agLaHMKnM
 L0fzSNITizzpsUEA/DWlPTFbpLqp6CmFnsX0Pf3U4Hiw/Vd4Go4xcfrN9nmwLgKMcZrrfy9/u4q
 4hwH8EkjI8TcyvSVP0yGIJii3e9hDpZdD05TBnEUGRi0TjfTSsIy0Zmb0v2otarmkpoA84CI8en
 OvWMzOpvY4SYiSvAJYmpsMztPHnFBxqdJ3R3SxkyjuPaibyjN8pGmoRKadgnIkklbL05P2v8
X-Proofpoint-ORIG-GUID: 3tUAOTNzwrTSKcn1x1JQLTzBFejpnkkF
X-Authority-Analysis: v=2.4 cv=KIJaDEFo c=1 sm=1 tr=0 ts=682e4bfa cx=c_pps
 a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=P1UepQaUeP-bpQj9cxEA:9
X-Proofpoint-GUID: 3tUAOTNzwrTSKcn1x1JQLTzBFejpnkkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later, to translate
the vaddr into an offset for the dma map vfio-user message; CPR will
also will need this.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h | 9 +++++----
 hw/vfio/container-base.c              | 4 ++--
 hw/vfio/container.c                   | 3 ++-
 hw/vfio/iommufd.c                     | 3 ++-
 hw/vfio/listener.c                    | 6 +++---
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f9e561cb08..3feb773e5f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mr);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
@@ -151,20 +151,21 @@ struct VFIOIOMMUClass {
     /**
      * @dma_map
      *
-     * Map an address range into the container.
+     * Map an address range into the container. Note that the memory region is
+     * referenced within an RCU read lock region across this call.
      *
      * @bcontainer: #VFIOContainerBase to use
      * @iova: start address to map
      * @size: size of the range to map
      * @vaddr: process virtual address of mapping
      * @readonly: true if mapping should be readonly
+     * @mr: the memory region for this mapping
      *
      * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
-
+                   void *vaddr, bool readonly, MemoryRegion *mr);
     /**
      * @dma_unmap
      *
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1c6ca94b60..d834bd4822 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a9f0dbaec4..a8c76eb481 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mr)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6b2696793f..46a3b36301 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,8 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mr)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 38e3dc82cf..7495866123 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -170,7 +170,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mr);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -240,7 +240,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -564,7 +564,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
-- 
2.43.0


