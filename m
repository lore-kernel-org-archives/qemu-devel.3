Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76884C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWb-0003DY-Ay; Tue, 20 May 2025 11:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWZ-0003D1-8m
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWS-0002RE-N3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:58 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7TJcb016599;
 Tue, 20 May 2025 08:04:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h1VvT9mJEdTWrDe+HTk4I3vCUVrW9NWxE22+aAmMo
 IY=; b=119PORhFyA4LipAJZtwS1iMW5jiIAlFfV+i6xgJSULXZY57SwHaAYKSMQ
 p+641zQeIjC3dQ0UG0/9kYwS6RNcgOUkilR2QCFImMrfy2RfbVtsyhXUuV5QgLuS
 IuaREqvR3hP6Bb3ykUAr2acmyKS2qxj6a3oViQj70dQVCQwnmIlqV4vrvmiLuujR
 i7fkd1yKAb+4URxQKxFuzNfIxcNutxLcAC4014lU7FLK3vhrs9nOIt32GRt5MS8m
 jUOEbdfAiny9OkayHBMx7Umn5pWsidFg4GVXTWIiR2AMXjTg7y+hTTfiiZZQa6j+
 D0VHZDCpu3kQcPgftC2loXi4QwluA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheacm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzWYVV4i2GJ4cpXOAjqVaA9iA8xhUpE4EQHzGBCDe0NKcD+dXtRX+4YHqcg/VNIZhR8i7Jsms0OOUzlq1nEUJL5+B7lEkNi+Oy0doPge+x27r1R5t2x2mgqxV2//yUVMokLt7b5PGVkLOeuB1FPZy0NIaieA3swqnKENwTMi6LBA+DWGCGLHMVqVIO9ndovn4T/UPDOqkg5XjLMmzVtlCN1ZJfn9R70UzlpynvplTKZSFtpSnNyfcp7EprkNJBI9yhZ593mgebOPuEtiu+PEsR7aNNWWxwrClsx6q1TfXVoM84hs+pECVPa1ChfTXtolRriD5Wg58+x+lwc7rWs1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1VvT9mJEdTWrDe+HTk4I3vCUVrW9NWxE22+aAmMoIY=;
 b=sQbCGfZSMcW1/13H5yC57U4CXfYG7n3Adarr1RBByUVwG9fxMfX13CmUB3z+rIdH9vWCDlmXlCkPfG/rhLh5l14wcxlsklHuP6c+wLlhKhUxCSDJuBQktKK6H6wg3IoYsHPJq6DP4ztqP9pI+t7g0ZXGqlr8mU/18o6kS4v+YqBh2CwQxzwqtHONl6TjJF2zdpmHeT1Ff2HCI285qnRs3rhhINb0maNs9Lr5MD6x3NOanfjkbKGQrUif4AxlyXYOlap5ah0AunxeshByEbHXR6BCS/M1NzTTnObNjDJWccEWTgPOIWSwZhTzeImnAXkAsiPUy6IPhraNQKQyXy/LIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1VvT9mJEdTWrDe+HTk4I3vCUVrW9NWxE22+aAmMoIY=;
 b=D7IhC4WTgyfSDWYb8kwVHPkn6WFLaJM2aQEseNm5Wxuc89jJfEncWhBlE+ObG/QQMX7R1oI/g/YEzSbXogLAnSdMxEz9jqrN3nRNoCqnpQhtZdIB476MZAikncm49l+C6HxrnaDkJ76twLhaURvAYqtmKjq947BAowlmUtR9FEThz3XysUHVJx8U+nIQrrMXJeqsZDWXBjoEA2AIw3EeOy5FR8SwC0wkmuE6w5KPHavFkK5zieyJEDqq5Q7Y+Hyp03wTTe7uTLVZ7//KVyaTS8C6euyVlBQiCgMq085A2T6F4m8mfVlcMU2blk4gLIlf8mHjvFHyz59FD4VjNcpbSg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:49 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:49 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v2 10/29] vfio/container: pass MemoryRegion to DMA operations
Date: Tue, 20 May 2025 16:03:59 +0100
Message-ID: <20250520150419.2172078-11-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: d8af3fa4-d2d2-4d88-748f-08dd97afaa75
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?da6RNqSHp899DrR7YqjSupEHhaY211TlvaxNA3jE/PK2qNa+4k81gPkLVK8c?=
 =?us-ascii?Q?3WhFEXhmp6oUQLnr3PMNtzl+hrfx6LeSVb3PkiSwq2yZajMMBYAxC3oyZyEQ?=
 =?us-ascii?Q?dLZ/38lW57HzwQf6Zv+n3W3c8GlN290qe+t/8PaF8MpAaQrxdojHMqg76Pt4?=
 =?us-ascii?Q?EVtCPkaZ1muhY1nbkl7SeOgV2GLa7X6UK7jJc8EQBgqgoPLhczHImsJ0UCxA?=
 =?us-ascii?Q?iYFpTZ4ARo8dhuyGmFRlO0tsfm6xfr31jDC95dlmF/1fXAF1SKdj0BQ+oHq9?=
 =?us-ascii?Q?fwpqGjwWk8s6NiJUGDQOr/ZaygpCdk7ZNPSq7rUMbIOeCkLPoXgBbUZ9I6SU?=
 =?us-ascii?Q?Z3ViiHKfjY10mspqX3VIpd3gQr6YabGm5Z4KlaBvfsXPHvqJcqrPXA/wbyfh?=
 =?us-ascii?Q?v7mgwShRM/lLdcsFqHIPxZg0zD1MJlQFziVgITCGchmbApt9G/0JMkktgOuK?=
 =?us-ascii?Q?bdHnvvxJwKbFVmH1aDoN1NRNTlTro3sLHVwkdc+SueEBCqnDRVltBKQ1Zgwa?=
 =?us-ascii?Q?7eWioBzC6nzZMV6/ne6RGnYRLog35pfnvUhO25xyrwPee8FwBOR7S2y/RfJL?=
 =?us-ascii?Q?WZvhgDJGhP+49jFaUi5tFESH0OtO1aFLZYtX0EHSm3XCGvBaTJ1/Q+irxzt6?=
 =?us-ascii?Q?pY9Btr+owm/OYBda7anTkhLLEOUSQPZN17uY9Zy//h4tH/CxJS5f5X8PfLjl?=
 =?us-ascii?Q?qxqF5MIQC1Oy0l5UhKeEyYeqz/hEv8qJqVtG8avFQy7Zj7lK2NNpfyVhRqXo?=
 =?us-ascii?Q?d0Zsnlo37Dkgcmao3AsQTW0jhdtnlwWkVk00kWPycq8fFNjD1wBXf4jcQWfU?=
 =?us-ascii?Q?2j6ZQHlYcJatE7YVDzda4eFKLHO3fqh/vs6JsKkAmjLpA625L5ucSSBD3ciz?=
 =?us-ascii?Q?E7EbL3BHolJfI7E2n+k7y3Vj/g9Z5Fbbv4ZanbmkvVL9mFtBLeLSLi6fn/Mk?=
 =?us-ascii?Q?3Yk9ZySFkKJyfPlpS5qV85X0GnmkC01Cqn5Vr/MGntHsw6WK8pTy2s7+Vb/k?=
 =?us-ascii?Q?y85a93WB+xp0LIBMi/PNyJWE4gyHQgaa9qCXxgHnLXAzDx69j0eqZp+93NyA?=
 =?us-ascii?Q?pHumPrFzj32xGlxYvE/45L+NRZNJ7WHUG7LUj9vQjplHHvH5yhTMIFyrW2zh?=
 =?us-ascii?Q?fnuscOzzkk1goQ9QqGaoFzcvEvZxJdfCMcEKi0ejAF6QEGEpD0uU7Xu+81D4?=
 =?us-ascii?Q?TW57XE7E1t4nLt76OTlD9hdGgTZxa6NU5UmBFzdPSSayoi9gcs87GEH1wwHz?=
 =?us-ascii?Q?3P50exWoeoZQ1gxnH3nGQeqHXpUY35RjcuRnkmk4Y78EfHBvjMRsWZ8MJyPW?=
 =?us-ascii?Q?GmkyNBN41VjX3OsXOI2p+8ld0ENDnbReGPpOmD3GAAtljJ5og1rKCsUKaQEs?=
 =?us-ascii?Q?H/dozpBSM0Qz/zmRL2AefmCf9EtPAYeEOddXUpMC1FAZfE3wrHS5oB7swJnf?=
 =?us-ascii?Q?+n8Ab1UFtE4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3LxjHLTFJhPAkbcfBTZPl+XLM3LU21T4n1Q6VP9t2FJyb1obtHaQTI9wH5Zh?=
 =?us-ascii?Q?gDEjPCXXmX4hKfKXvR7NwNNcgaaCwBxlW/sVXs+hYnr/QxUN3epTAC1i9d3I?=
 =?us-ascii?Q?ARS03z8/UVsJMGzZJ9Vat15nOH2sCqWG3UDPD57rnUj+G/KSOFaHvOVBknUt?=
 =?us-ascii?Q?laHXZLp+3LaliA2rJJe0GqrTwMu8gJAfkhzCENjt9G/gIQ0yElaNaohlnlmO?=
 =?us-ascii?Q?K7Gaws27zgVpVs3o/YjSDYIT2iF57wkskqOvtiPbz2XTO74pkryv8DUIEUQp?=
 =?us-ascii?Q?KrK1txS8pHy9jkPwcyQHtYcyx7tVplaPREpoyXSrACjC1JJlofh5UixH9Hbq?=
 =?us-ascii?Q?Ul0KWwbxGETKV/ov/CPMFzOd0kqBjlXeszcDUO+8i3blA55AxPjvN800uaLl?=
 =?us-ascii?Q?DaeU0OPO17EfErikS+fe31CovI8SRiiGkmlYTNhrp0qu/tdei29O+R4oJiUC?=
 =?us-ascii?Q?u2OghXWBUknlrHNT9H0hgI7oLhyEMDIsafMI/Vr8RTvz1nETCHypGOCHiZeW?=
 =?us-ascii?Q?dJl3o90uQBkVEGg2A9sScU3qe0e6QyMG/sHINDCtry+oyak1zAaHwmtJuwzj?=
 =?us-ascii?Q?a3zhPNmVlvCWgxnRvMujT4jk+ZY/plY12gPKmLy6z6kVfwTnkfzZF06UoIqN?=
 =?us-ascii?Q?MEc/gySawXSzG2ppdukYqRVTYfAvQIN6gOKshSmm9F0qOMj8+b7wrpd+3DNC?=
 =?us-ascii?Q?Q6EtOmh4sD0bcts8pxN+pnH3F2bSC1cQG41r7l08uOpLyrBEyouphOeiKjqf?=
 =?us-ascii?Q?s+H3TZgLGdJCRFSoVzoey/KjHO2Cc4mBUlMkZ+vZnmz0LnQP4taaOzNGmFxz?=
 =?us-ascii?Q?4D7iJBVJtX0dZheYZN8DQmt1rGUXhQCYy6Hj2CmCATlrNfAZRKn6IvCb5Blp?=
 =?us-ascii?Q?23UlAULZQJTF/W1jhuHIHypSfzd6xunNSgsysMTJASlXgec+yvCZJBXeNNxX?=
 =?us-ascii?Q?HI6X1ukrZYhL/h07HHWSByO3+9XmzR7mjbToHUaR9G6gzSGX6D1xJ1iJJeRe?=
 =?us-ascii?Q?Xnh3rafnU7ewDYLr5wHTCfcMg1sqFEA39RpJ+K/YPbwV2GljuyqmllYy0ena?=
 =?us-ascii?Q?qJSk3q74ACh44gUHq+ZzzmGeGBBjNeaFSz1teCJD3/XwRcP1t7ENwHLMmvK8?=
 =?us-ascii?Q?vt2wkYXDnuKJiTcQygZ16qOIrUVdBXhk97C0XrG61FnAY298lKCmu09EhhF9?=
 =?us-ascii?Q?tM8VHQbflT2/s5MWhhc4vNciioGeakfCa6J8C436Ob+zR2F65h70EW66n5kl?=
 =?us-ascii?Q?1NkCis6rrj9wuHGO8XVztrxd4hv7Rg61eQ3eCra+rszZY5w6HH4+e+DfcZZh?=
 =?us-ascii?Q?7qjmtRcyVqnulXpO8Ii+VJ6lD9YodbKbZWYtwKBOdY9cteQriyD92xQUQos0?=
 =?us-ascii?Q?2Mw/OxaAY4iEveYKYAbC7kShAVhp+RunAkIYbdS3RoAKqQ4kVYLYVbLSDry9?=
 =?us-ascii?Q?7mStmpNsHTpjr+qw4j+8R0cZn4mawh70i6Sp4F7ASBoV4QB4qi6hewoLqh83?=
 =?us-ascii?Q?6VSaTCZvBymsmczqWn6mLEfprq79aXYWf+jZkGRGj6mnmmJluSSftRMF5Laa?=
 =?us-ascii?Q?LfQqPvNbaC1xSQW4MwlUUiqN+Py+dp8l3cV7+q3b?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8af3fa4-d2d2-4d88-748f-08dd97afaa75
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:49.3030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Myamf75/lwTiRAkjqiCs/ePSIWJ6ccgGd3LwVx1CVCTfFp9xAWUK80fEQxA7rwVoXeWUEiLWSoWP/87i3kjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX851Fzl+EceWw
 t0I497hP7suNhyZxAN4Ssr7cAqn9xXGHJ4lKefCTYflzBmzPRZsegmBg4c1ezoeS6/WznDC+ums
 U6z6l9bZGeN9rGit0vjpEDWRxnnLIY4ahXD6mkgv7Cex25FlXYPW0fbgn6Avbw5siLVLHeevVZd
 7wcdGGRkC+XKvgXnGAe9KeG6i3WIRtenAvwYP/CSWk5P0ekOFQCUlHeES91fAtw5sKaCotFvCR8
 jn9YPuhWm5gmd53J6c7aCmx7HXGE3cVUX91hERfjw7OQk1qJ93vLaCVRYl+i/y4JuWNwzcRsYAK
 CcptTOXbGxteYLxXVSP9L0L8HSjVLMuVgGrw/fspelgM7qIP5fzLH81cPQwp0jPVzCzDdSBO14u
 CN9L8iejX4WDmXtnO5pSs5zN39So0e52jERQoDm3U1iAvwmHYAbZi2Wv8I/YvRikXKbc+6Es
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a13 cx=c_pps
 a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=P1UepQaUeP-bpQj9cxEA:9
X-Proofpoint-GUID: 4Vgnio4vbSGX42BGI4iOl2dKcWn3zO_A
X-Proofpoint-ORIG-GUID: 4Vgnio4vbSGX42BGI4iOl2dKcWn3zO_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later, to translate
the vaddr into an offset for the dma map vfio-user message.

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
index 41c49b2aa5..c18986a621 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
@@ -149,18 +149,19 @@ struct VFIOIOMMUClass {
     /**
      * @dma_map
      *
-     * Map an address range into the container.
+     * Map an address range into the container. Note that @mrp will within an
+     * RCU read lock region across this call.
      *
      * @bcontainer: #VFIOContainerBase to use
      * @iova: start address to map
      * @size: size of the range to map
      * @vaddr: process virtual address of mapping
      * @readonly: true if mapping should be readonly
+     * @mrp: the memory region for this mapping
      */
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
-
+                   void *vaddr, bool readonly, MemoryRegion *mrp);
     /**
      * @dma_unmap
      *
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1c6ca94b60..a677bb6694 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mrp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a9f0dbaec4..98d6b9f90c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mrp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index af1c7ab10a..a2518c4a5d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,8 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mrp)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 0afafe3464..a1d2d2561d 100644
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


