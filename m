Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5763BC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc24-0002Ah-Rf; Tue, 15 Jul 2025 05:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc12-0000ep-Vt; Tue, 15 Jul 2025 05:32:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0x-0005lJ-3h; Tue, 15 Jul 2025 05:32:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F959ee014031;
 Tue, 15 Jul 2025 02:31:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=b5ACdPuOv9UtG7dJP2B6s4qqVMaK/ScZhrg2YJ4nN
 Ak=; b=IZTIMS46/+pF7YoYAzMCeT5QamErY9CMZJdvzWVFhR/kgftF8mtMptVpE
 TcLq/MK874yK4/KytLlJV2vPfRpjz9DBu7oDNH0sJW4gHBfOls8YRVKfhDj6NctM
 ox2FxUhAH7IbG+dta+6Rm6Nk1pOJM1ojKbxE1w/w2ypBawJ/o4C0lrman5OUHn0g
 Z5OX/Dia5qOdoXa+UyU1S6dGmPVjpxOCbxYdCLyH9jiUwSNJzg1AKfTGs+1dTJXo
 CCqU4cfcQBp3A5CZrwTyxkdcPJhsGIM/zDsWnTkGLu8Lh6yPbPTi0cuTu8UNcywa
 NpiVhTHpMJNCLDSKdwqTv+fe7qCzw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2113.outbound.protection.outlook.com [40.107.92.113])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s823n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJDXxJdbAZ2APNhUMR7wUophzlUy1p1DdGkeSOcWVkCNoe+gqyN8JBVwxhdYsQ/tJlgoA80d4llm9XC/Z7U4vo6i3TusHhv1hq5eNm5FMJ7dwxTvGRx1ZECokidS0tl9wXA6BKBt+SvBV1X+nKQ5S+qn3fEuAbyUwJ2D/mQW6g0/dHdzmCLSgXd4Ys72TmoGKfOn0Ve7zgIkSCV7Nuqo/fqP16glm3uX+JqYHCC/Vh7goWkE1OEnBWlvYO6w3siAK129maC76B4xzmAWPrGovcL4g/Gfeyqt9tC7PJzjrdJ7JamcGJqEUDLtOyN6x4uf5K7ubTHMbdLmaYoN+7GpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5ACdPuOv9UtG7dJP2B6s4qqVMaK/ScZhrg2YJ4nNAk=;
 b=H+2SUXJSN4wyiTZ2SZPVzprnPYgIItg7flWcSDSwXwJK+gJ74rMKVSUMKPDimyWIxId1sX705bNhbmwMsApFpcO9G9pWApjeK/cSXwRhQUi870firjnhwPwNos20UNtx4tJsDDTu8j/BE5QjXZCcng/B0iNRzt5VbIf/9GCYE6H0JxZXUuvGYtS5utlxuOH3RXpVZqaWXeYRGXeqOzoTJdVio4SvAt5d+lpG4Oz2Akhk1gWJcz7m4CIHqH8MKxE6At/79EadlTT30V8qUSECFbfrX4G53uMbFe0N/DfGU+gF+FkwRLgRFic0RA5Xg5fZDGxxei8JSrzcUvxb3/mIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5ACdPuOv9UtG7dJP2B6s4qqVMaK/ScZhrg2YJ4nNAk=;
 b=HwxkxihJu7VmYCpJ/wrZkYDxmFfIAWQmJP+vDX/D4nRc82fCNYtwiVD5XzLu8uD7KxHvgROafYR08WLPy/aN9lys6yR2PMudaeeTfP40iHrmjLZFq1z5FAMnMdg3wOvC6IK8Sl/ni9l5HxVZ2uQlx4b39y/LBRRdxijMwJUx5ctiu0OhT7LxmK4B8xaY8vdloh4PRRr6Nkq3hef+5hHvTy9EXPX57oBOldqE67nepeAYbnNINzV6HCZ2dHMzyr0dYJo9bJlmhuwAqRxijoM09eXtjpCgEJsKBw8eV+ttNUBfAefs1eeD1X1vAPvsecdu46XkyZG+AsJ74dyM0Bivkg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:47 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 09/22] vfio/container.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:49 +0100
Message-ID: <20250715093110.107317-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0220.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: acedea26-3e61-4ff6-2556-08ddc3826b48
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sYrmmKJgfleUL3h8r/MfIOA3pZcZp5e4gCLN3rkWx6kP4LyOEV57ra37nQ6t?=
 =?us-ascii?Q?hcA1Jz2knRq2S9CR2NfzYvRZLlf+7m3wJWU27OXphOyLygyyXJCN411Z3O5d?=
 =?us-ascii?Q?TLQh0lsgEyUgrBLh/KfmOC6mLVZ8/9XU++IRMhpXseqrvBdEJBcJwYC3mis3?=
 =?us-ascii?Q?eY2SqYK6qoLy518OSVdGn1r+l1waQohsIGGubP791gbEztdyYCyMH/IkuCqS?=
 =?us-ascii?Q?g1aaj/uZB6utCTF5kXwTV0aGbt5GFur7aYbWTnJ7BGmbguL+mhtmbon1f9Dn?=
 =?us-ascii?Q?Hm/VyeBC8phwwicfC7MSh7NuYSMPLShWW4TzMSx6nGilzHNTObuJJe6Vp1Aj?=
 =?us-ascii?Q?iP6e0p8m9fJgjGT9qq7BaBzA4qUptNTVret+6f8NcPc3etDr1/8U2Fyn5QPi?=
 =?us-ascii?Q?mUShd+BouQQE1hGpEhD0NllaerNTtwT7Qb9jRxdYxlHM0O1YXn7TgZeR13CY?=
 =?us-ascii?Q?b7GjYtzi62heeTePBIwHvG0X6KAkICv3Py9gw0GBKKzL5+SgkFjq6wNNXtos?=
 =?us-ascii?Q?N2FajZviEyzpU7QnxanEtjyHKQTNQW4ninTpnN2uMAdA5iuLGEhLuxeU9jNE?=
 =?us-ascii?Q?F+/o5mOU7M6TKb1YuiVMhV/yENO/HmHAcY8qlpeOzezo7gHOQAhL23HjCZ1H?=
 =?us-ascii?Q?0X/c0uuELZKlh/amuc4Bm497kDEJGbeibjZIAk49FOV7NOOnEA4mFNfghYUO?=
 =?us-ascii?Q?WqwRZoLzO9Q0/vcFvfieq5ZzVaFx1+dKQDxaiYc1XjJVvId+b/iXM6lHD7d8?=
 =?us-ascii?Q?/JAau568AVsBF9lqdq7iOWNaJCoOgRDYroHqhrBbxLbtXGwbF7qCcQctQ0I4?=
 =?us-ascii?Q?/GnKZqQ291qS5YfwQvfHU/QtI7129+YkBR+v9bBW1LGS8ubtxBSRz1c9iY8p?=
 =?us-ascii?Q?01qcK5cwWfmacsGI0X1EFmDZ0Og27usGnbljzTNzgnv3YT8jiRAm5c7ItNAG?=
 =?us-ascii?Q?eEbLxn5O3p9IYar5Be73mZd8/BB4OJXeQ8wGXyS6VZ0AnSoKOlx/hwa6wE/V?=
 =?us-ascii?Q?AH2d3t3JzN9V0gLyDUJhbz9DnlcnWXpHosn2U5vjXfV1++nb93N0PPaWzu3A?=
 =?us-ascii?Q?2bjHLlwn2UlReWVgjT7Upg6d604kFvEssjKr8HpsgYrbWjhWm26neqSHw2gA?=
 =?us-ascii?Q?9QAXHjXdzjZrNzSsAk3B1elt4h62mThBVMq0G1h+cpAYyQBHTRRGsDtOkiYD?=
 =?us-ascii?Q?fuv4X2KhtjLhK2qRA2JhJbjl30f5oph7m/SFbi3TEwandls7ToWcerKO9zPc?=
 =?us-ascii?Q?F8eSHi7xHHVZuOwaU144+6WG772ahfnjG5AEN3WbW5oJuOnjRMKmGmFs/kPk?=
 =?us-ascii?Q?So9XAlNdiKqdoQpZkL6yO4FjkeF/6JiFXN1CwAaqdzPfRMRxYVtUQUt2dekP?=
 =?us-ascii?Q?fbPVIuzTO0LdkTluSLQ4kuYBoowOKUDYtgH3Oj+VtLd3fWPM/srLXg6BeZU1?=
 =?us-ascii?Q?UW2Zh8IOxn+iSnJcg9v5tZubyGUF8LqYKfFViPZuk9Ok3Kgud67fHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QR7RRbsXREoZwUYWNAoHBasWJhNVaulHrwF9DuywrcV5iXXDfcAFuFPrrPCd?=
 =?us-ascii?Q?XMaTmrLVUkjyfLkznu7G1uFHJdV3Oh+CkGZMXCbfLbabeHYtVsSbvv2waAn/?=
 =?us-ascii?Q?S1/A/OxMQcymuqf9qWBQQK7cb3pBjJ4DLvN6JfTq+5oFAam3LWPY1n18xhtL?=
 =?us-ascii?Q?Ui8u01//wJK6w7GqOhm8AYo+uqbK6N63JfMM3JyAkAGfzh5a8bEQmPhjyE8W?=
 =?us-ascii?Q?ewDkEX+HyjFprJKp/5pMzEJqefSPSyo3CUD18/Bhcddc6sxsnF39GsO95Nmz?=
 =?us-ascii?Q?kJVYPwbc1bwQC2XA/Tt7EiaIPGhYkXQv8XCRX8q4QjbuXujQVc03n4wk3FD5?=
 =?us-ascii?Q?KDp90GYJkun9D15qzJ5nHbj2ujZVoNBTz8qumbGDSuIgsW9JeY4bIaFfziJF?=
 =?us-ascii?Q?xJbX5iMzyechV6QF1RJKpJ96aTSkUT24x7GaazAFP6S7mUsmz9A9oxKOWsWv?=
 =?us-ascii?Q?n10usnPSbB9QQ+HII17oXTv/JWIzwlI8QM2Ol2hK/P0H6DLF+6lUum3M+2K9?=
 =?us-ascii?Q?xPhb+SWaiJSqQWc3Ybvqdamrm1G1DDWsM5BbX/9Z6hUFLMiAGO0sjTxb0Ct8?=
 =?us-ascii?Q?I3+JW2yVaW+Ar15Wu4q9Xgr0ItOLEfmyeNNdVnjPVmjXq595kO+MJGywr5L5?=
 =?us-ascii?Q?Uz+qq+w+2H6dx1JtzQz3NtDDWI+LhHeOtgcm0mtc1LRzue0x3PXD0mnJAps/?=
 =?us-ascii?Q?Dr0+DuCqYGDQdmuZrh94clyYfVUF6CrEy5fraKgNLQhVRbc3DfHC1WQWX4Sp?=
 =?us-ascii?Q?G7kp/nFEAByn43V2AdPh7M6rh9OJtAPOitlgKpbi9RVX8S9NkM0MvKEJiv+M?=
 =?us-ascii?Q?E0v7W+X4hlwlPyKTcJgbuL/1TJXZmWcQOkydhE0iW3Inrgnf96LzpoBXSQ7C?=
 =?us-ascii?Q?2GVwJ/6hZoNOJF+u7Mc+APWUNh/c4OvRrjzOUmHRk/1BhSu7wMivt10iOFlu?=
 =?us-ascii?Q?+PmIoKkcoKaoMbs7L7Favd6oRdkSHxjeTlFdL+csnrC9OCyBWcrPRKw8TToy?=
 =?us-ascii?Q?IFO6skd7xz7ZqHCgmkMNzKmxMY9Ce928HD7RVsSMIOo9JNG53lPBVwQtyINp?=
 =?us-ascii?Q?NUl/j1vkrw4Ncm1oQlYf6aKDQdMax6BTLPaJMgwF/zcgZk2NcnBNT782J2RX?=
 =?us-ascii?Q?cGkrJeB+Wp6rdOcLowoq3va7fvl6l+qqpICEe1QjR96i7Idlb2oZHg1ssdAx?=
 =?us-ascii?Q?zEpb8RMFTb+qQJAxykhlk4A0EVtDhGH7RQMkXrv0OeKzcMO0yhnXKzcDKQDS?=
 =?us-ascii?Q?ElDm3WpxDj3vHJdsE/n9D1NndoAvdrVngDKyvlxHfYsHSOqPNo/LHHa3oLYY?=
 =?us-ascii?Q?IZ9vQNbLkox8TFCU53YuzxmXM7A59+IaAMfauPCjmkFhVlzOejtAKbQie8pj?=
 =?us-ascii?Q?aVgwkARNybaAy0naHLNdO62iDzDvthUXp+s0JsZdRIICe9/kpcgGQ1RvVFys?=
 =?us-ascii?Q?FVulZrtT1biTKPknuEht71rxQJxOGRYaH7H89ZaPuEZlZqy0UwxiwYkMxIce?=
 =?us-ascii?Q?FHHt61xb/yyubpUQRZ3U+mRyqUSeCofiama9ZTs5uGocgRd4chszKmKXz4nA?=
 =?us-ascii?Q?Jewvja60lkl6bjpcACodZL5b8E40lg9cWEI7UJZXCIbeZKtTvLmVYaQjdgrf?=
 =?us-ascii?Q?e/EiK358IjxuKn7KEfL+vblkTq6a6hm0aQn9dybocm1QcfQ9ijt9c8n93zjn?=
 =?us-ascii?Q?BMD2VA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acedea26-3e61-4ff6-2556-08ddc3826b48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:47.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmxXvYwDNYI0Bz/BcH+mQ86r5F3f3P49tqj2fixca51OEdfyA2kBA4i5c6V8rncjpGd+8CH42JUNfk7qKzsYsOt9JHxj7mej94JsP62MDhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX1hL9ZXT5JRKu
 5EEFs//2FpYkA+VWjhg1463KN6LnIBL2V2vTJPrEp+8NZzWS2yrfArihZbvaDNNllU5DZ6Iggon
 PpgBmkO9+EAM1QMgckWFtKqx2TZDCKc9A62vGv5HYrEcZEW6UrGmajttYYDsf6VcO/koNhLl8np
 ZmqIKoVizkZ78kyxRpL3hgcoPclf9cuWHsS/G6Xq3Y150IyVDLUrodrE7pTViMzGnQJ8d7cIoTF
 UyiDqWbEPy9OmzNbqu9Qe0dQwBNMul7GW0XYiEWTZfZUmNjLl+nXGvsfRi5zflvse5urvysih9M
 KgptIKJe51iJKf315bXiin5CQvsZdAUdCMp0H54Xh+lrn16JLPIMpsFcRMYE2vY9N34wmm+r6VR
 QhCaMXLj+8PFXpRvLgCtTQfB6xCXqYdUJtOyDkAdP3WQ5dYqjChYkSNRMMwaoPrFD2+15e8v
X-Proofpoint-ORIG-GUID: xkACSESfsbzZUUlgki10yZKsPkJmBPPD
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=68762005 cx=c_pps
 a=6JPPvL0+Kp/bephKfSor1Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=0iGWSwJUVMALRjFmDhYA:9
X-Proofpoint-GUID: xkACSESfsbzZUUlgki10yZKsPkJmBPPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use QOM casts to convert between VFIOUserContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/container.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index d318e6a339..025db93ff3 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -24,16 +24,14 @@
  */
 static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                                 bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     container->proxy->async_ops = true;
 }
 
 static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                            bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     /* wait here for any async requests sent during the transaction */
     container->proxy->async_ops = false;
@@ -44,8 +42,8 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                            bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
+
     Error *local_err = NULL;
     int ret = 0;
 
@@ -88,8 +86,8 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                                bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
+
     int fd = memory_region_get_fd(mrp);
     Error *local_err = NULL;
     int ret;
@@ -177,8 +175,7 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                                bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     assert(container->proxy->dma_pgsizes != 0);
     bcontainer->pgsizes = container->proxy->dma_pgsizes;
@@ -222,7 +219,7 @@ vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
         goto put_space_exit;
     }
 
-    bcontainer = &container->bcontainer;
+    bcontainer = VFIO_IOMMU(container);
 
     ret = ram_block_uncoordinated_discard_disable(true);
     if (ret) {
@@ -267,7 +264,7 @@ put_space_exit:
 
 static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     VFIOAddressSpace *space = bcontainer->space;
 
@@ -295,7 +292,7 @@ static bool vfio_user_device_get(VFIOUserContainer *container,
 
     vbasedev->fd = -1;
 
-    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+    vfio_device_prepare(vbasedev, VFIO_IOMMU(container), &info);
 
     return true;
 }
@@ -319,8 +316,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
 
 static void vfio_user_device_detach(VFIODevice *vbasedev)
 {
-    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
-                                                VFIOUserContainer, bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(vbasedev->bcontainer);
 
     vfio_device_unprepare(vbasedev);
 
-- 
2.43.0


