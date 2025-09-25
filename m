Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB8DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kF3-0007lu-Tx; Thu, 25 Sep 2025 07:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDt-0006aN-RV; Thu, 25 Sep 2025 07:33:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDg-0008NN-LZ; Thu, 25 Sep 2025 07:33:15 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P2Obnl2033590; Thu, 25 Sep 2025 04:32:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=d1Jwz5isjlbIpCe98CarFbvH0A62Ao1Bdpy8T1KBF
 Zs=; b=aMP4bQvyCuegI3R1Ix4GZdnEoMgr28ClO2uPI0jH9bNCjV2AGmva7tlmD
 vRBtG/D+Z1YoWyrdLoO2atdqjh8yhCR7dUAdNjQIsGnVCkV6wtW3lWRpt0BxvqSI
 2zagDrMCsqWekHaIcv+2RF0bqUh6FqTFKB+5eESxAMFpW3FTzFg0fHsKXYFomv2H
 cFKhqQ9vyYRsFw+hOMjm7GllvyRJTPQ1tOwp3yB4BlUCZgXcsoE5ZMyb1OqoIoio
 1bfF0yeFQHDW/uKIh8tkN7CrTS4YnINEceoTrJqpKOg5VhTgFDLf/IfggMcb/eLG
 w8S56wpUOnaQXv24yfIP3QtrMcttQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021141.outbound.protection.outlook.com [52.101.62.141])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cj95tknk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlLLNisXsdE+Ot+dy3T8GIK5r9O2GR3oH9uPMC0+2NHcFuyshn2MZGVqTz/AwpH0L9VD31RhaUWr1prFGPSvmYmZfr0vfQBHAvoYTEAfXzBjRp9IeNOxTUy4XHCXXBqF84x9A/GUiPN/8jQRKVoaUWUD63gOJTXV4ZJzMLanKkxqJmFiymJlTDdLjdUvF7Y+GWfzuKKMziCzzUqpP46OsbPwGDeMznvk4Eq2nA+beAZyNauP65v3G/847lPK6IaeWM54gGZuCDy2EsWpNkUigtMhMQRrzKBtEFr044ksTXRtJhOGOPS/EBAeUGVXiskLy/6ms83fuAIX1jSUzkbUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1Jwz5isjlbIpCe98CarFbvH0A62Ao1Bdpy8T1KBFZs=;
 b=DsCKQ+eD5zwIKKroNC9LQMf6aF7qfGAUYoOOCfRxVTBOt2yP4F532pWCTq0uYs1co3Vj3aO7cU01ZwWdd2mXLjsmm29oevHGf3XMDooyWIfFVHgPjv6kBnKhsi6n1p/Lg/34f38NKHchpropsO1NoD6i0Qsndcayf1DSpj7NtjhRXqlGN0qPU5EKw9Wu3O3+X+ruor8bySPO/Vt7Gw4jLhYeadHj2w8Du2YGpBHo/otFWYpS35Ix++y4Wzy/ROdTLTInczVxAbl/Z5JFRX7Zj7UIm0DtV681bmb30rX8XCmtnyyuXsvSgyjsHljaHER67vVE8nw1Nwj8Is9K4E0sdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1Jwz5isjlbIpCe98CarFbvH0A62Ao1Bdpy8T1KBFZs=;
 b=Jh7cHqby1ACLd+1NtYWhriOZPmux/aqWM6M3K+vEWHsD2Sqk0F02Tei2dFr+tApb7zyOKFDtzvTdTAFLUGJ87+TvlN0cN5cZIQsrPVmqzXP2Rr9tfF49nYThGI9zJHzpgB+sq+QZfZb0kzjLqHOPJihAs4351QlL46nSPoq4JkfTdX7z6pgbBzeaJC2y3PM6/89ENDAK8duDzzHH2RNDYyOHPj5pNsa5ukNHjPv1C/0eXT9aCGa35CaumLNFLytDN0uhQpnC1w/CwgBZ+yys7+GbU3Pzq53BNCySPNUB5DPYejAKhm+w1+oRXZrzlOrAvRIeY/gv7FcStYQpH5Lw6g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:32:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 13/28] vfio/pci.c: rename vfio_instance_finalize() to
 vfio_pci_finalize()
Date: Thu, 25 Sep 2025 12:31:21 +0100
Message-ID: <20250925113159.1760317-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0407.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 8231be2d-ca6f-47ac-134f-08ddfc2741ec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b29pdndEclgzNExHd1p5clJoWlVETXd5UHFmT1A2MG4zOUY4MXk5NEFSSkNB?=
 =?utf-8?B?elkvS2g4NjRGYjFSUGJyclBMT3MwVHlqWWNldUI1L0tBTlk3cHY5azdBVExZ?=
 =?utf-8?B?QjhSS1R3a29KRC92QlBwV3dxRW03UWZnS2ZndTlvK1ZDcnlSQkM0VmpTSzNu?=
 =?utf-8?B?RldsL0NvUTBWYW80dzFjWGFUQURsWWh1RERrQjRKL3RyRUtKaTRlNEY4VTRZ?=
 =?utf-8?B?cmd0MlNVejZ6Vkx4alFJK1MweWF4cEhPSlVLTSt3bkZOSCtUM3VSVFk5d3k1?=
 =?utf-8?B?WmdRQnhmMjQvOUtITTBGSVozdUYva1hReE1oVzU0d1lObGxGaFBTZ2NUTnUx?=
 =?utf-8?B?elMxaVozZDNQQVE0YWdneEdCSllNNE9TbWd2OVdURUxLS2hWUnJuTU05VVRq?=
 =?utf-8?B?T1Z4YTlORHk4L2cvcUl2QzRDSFkxczFHRVBnZzlHSG1LMEwxUTdab0pVdG81?=
 =?utf-8?B?azFQYU9lbnhhQTRHdlJLRTdGT1pTQ0VCVGpacGxmUEpIemRkUXBla09TNEJE?=
 =?utf-8?B?d0JtSjlqWmJsZVpZNXVvVjQ4TGVqL3RNTGNlK1VmVyt5aU1zVU9HcVU5TnBz?=
 =?utf-8?B?RFh3cG5pQnlrazhHUEFNQkNDOUhPTzFEbXRhTVlvQVZmUHZRV3h5Q1Yvb3Nq?=
 =?utf-8?B?WTNOYjBtR2h1NU9SMmNYVjkzSjRhcG1nZmJ4RDQrWG5xbktXbE1qNWtOTVYy?=
 =?utf-8?B?N1M4bXpveHZ0bVRiU1gvYjNVN1dNeHM1Slo5MGtJSmtPU0dUZG4zS0ZqWDBm?=
 =?utf-8?B?aGJKeUhQd0daMXVtQnBkMUVKVFZ4K0NzSXM4bmVnSitzMkFwc1pLVW5xR0dF?=
 =?utf-8?B?UGh5VmtBRy8vamFJVHhZRkFzREtlMUhaMUZkRXA1UFYvcDM4NFNSQmlsV3o0?=
 =?utf-8?B?a1AwcXR3MzE1dTVlQ1BIZGZjdUNmNU1nenNobjBaYzJBUy95cHlnSXd1U0FN?=
 =?utf-8?B?bGYrUU1SWWZCT1Q1ZEF5MWEzVkNTVEF0NmJVNWdaVDIrd1REdHN3WXFjQXBp?=
 =?utf-8?B?NlRFdkxtcjlqbmcwZm1kTllleld0aEw5SEI4dWdScDg4UUt0ZTVhK2lINlhM?=
 =?utf-8?B?WG9JNE04NUw4TE5sVVprb2h1ck9VSU5aWGtOUXR1eTRrajRQTjN1S2Vqc3hO?=
 =?utf-8?B?bUsydFdLK3NYTXJoSnpLeldjMGJxS0ZSODBzZko0VzdRT0Z1SGhybnNKaEdO?=
 =?utf-8?B?RU1RRm1la2hlOWJiM0lHbGtjUUwzaFFpTnBzc3NpcUNuMU90Z2g1dEFBT0Ir?=
 =?utf-8?B?MGFlVUNkNnMzZzFRaEZDL2k4RmFVZjdGZ1lPb0Y4NlAyWWovNmNKVGFxejhS?=
 =?utf-8?B?MFhCSkJQMUI5MkZ2SlJPSE9yREM2OEpXV0JINHZmeldFMUhVYkZrV0VvSjBr?=
 =?utf-8?B?andOMStQZ0krb2prQkxLSU50ajg4U1JUQTdHOWJvVHVjMEYrWXN4bWJuYk45?=
 =?utf-8?B?YlRadk1OM2VsNW84TlFySzU5cHZIVU45TllBa24zWldLc3NUNURDU1JPeWhp?=
 =?utf-8?B?eXYxOFQrbTV5dnkyOWdyK1pkMkF5Q3AzRlJac2FOM3V0aWJLcjBsc1RVR3RL?=
 =?utf-8?B?WFZ6UmVnbmtzRWs2SGNlRTNXcnpRVXpnd0l2N0NhYVpvdEhuRXJ2c09SYjdQ?=
 =?utf-8?B?SFYyejVDeUxiTE9XQ1hYUnV4YWhFRWVvNkhlUC95eHJXUmZEUURQRGRYb2ha?=
 =?utf-8?B?OXI2NG9EQU52VVVUWkx1SFd0UEUwZ3FRV3drRDlFcTVVTisyNHFEL3NkSTZl?=
 =?utf-8?B?KzRycUtSQThuRXRwKzFoM1NUOGROcko4L04xSWJab09UTy9Wb2QxVVFzRCth?=
 =?utf-8?B?Z1F4emxidkdLMFVneDlVendUTkdUM3FDU0NwdDF6TmRCMUNKNEZ5SXZ3MktC?=
 =?utf-8?B?SmVpMndJWnpvREJZcnd6NVl4YVRFbVFnVUFUdVpaZExVMVdzbFJBa3hYRTZk?=
 =?utf-8?B?bC93MzNUVmliczJsejlEY0dwTmZJVUYyYW5WdVc0LzAwQmdzNWxtY1RIdUpm?=
 =?utf-8?Q?WMvyvkZV3sIVc5zm3A9hynlflrva+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFObnBieW9KczI1cE1nazV2YUxhck4zY2R0RlBYbjN2Y25HSlVUdkwyMUw1?=
 =?utf-8?B?R0k3MXVxQWxrRHVEV3BIRUp6clNua3RNZzc0WGxpRGkvWEdmYVRuUUJLaTY3?=
 =?utf-8?B?S2FUdDRUTFdNRldmdFk1S3Bac1dHRlpvYmVTOWNyYUhXUWZrMW0vZUlQbEZC?=
 =?utf-8?B?MEZ5cWRUTFlXbVNpYUhZMGR3cFNhcGtIZWZvYjdTWkdEOWtJcFZTTkJqU21k?=
 =?utf-8?B?VWVBRE50TktEbDBnYVhHT3FTV29VbCt0S3ZmS21iOGd0QS9nSkdabVI3cXFH?=
 =?utf-8?B?ci80WHZ0eVc0cStaMmdUOVBJNFdlTkduQ2dTZXZaV3dBZ3JHY0JqRmpjcXQv?=
 =?utf-8?B?WFlIeWduWTNISkNFS2tHa3JrcDZXbEN0aVBSeTNTSXpZNndGSDhrZmprOGVk?=
 =?utf-8?B?N3FrTzBFTXIvWTVXT0x5NFNpMEp4ZVV1NXg2SWYwOUFlOWVzcVdjQWV2cDJW?=
 =?utf-8?B?dXdZR1BkU3N2alVudjFobUxaTUkzQ09hdlkwQTVkdkEvcnlUcENQb1NWdUZZ?=
 =?utf-8?B?T0JGM3o0dFlGT29zRWpseGxrRnNmMHc1VU5URER1Y0t2L1pwbEdYcnNIVzVv?=
 =?utf-8?B?OEpZR25jSWpzdEorY3ZnazBwNUlON1B4Q2JCbWdEZjF3TkpZbmFnVHVONWNN?=
 =?utf-8?B?ZVNPTmU1c2YrdG43WUxMS29NeFRKMWhqVWREcFlOVTA2bWpMRWh6ckR5TXVt?=
 =?utf-8?B?QzB6d05CUEhLWHpYSHpnamVFQ1dqd2tTVUQ5enBHL3ZteFlES29GZDk3MFp0?=
 =?utf-8?B?eWxRQzhGckVtSWU1eU1mQmRRRGs0YzNZNzlSNytRRjJzc2JnREt2MGIxQWxH?=
 =?utf-8?B?dldZTTNtYksxcWhadCs2T3BCVFZkR2pMMTNJeWltMVVVMHRKUkVIVzgxUG54?=
 =?utf-8?B?aWVGUHZLTWY4Y2JkTGpBem9MaFI4MWxGS3BkWmFKZWtRN0VXQXY4bDJYSWtI?=
 =?utf-8?B?ay9BTjJvYTV2Y201Qkh2NnR5N1FpUElKbzBDRzNYVWo4Z1BITXJPUU1vdEx3?=
 =?utf-8?B?YXBvMkFLYW9qci94YitPbmMwdzVUbzg4WXBHRmRvQnR3b0lJUzZRcGRqMDM5?=
 =?utf-8?B?Wkd4TGo2amphbG90akNMOHpadmtReEFMNXBCcnc3WHpsR1gzYnNpdG9NTUsz?=
 =?utf-8?B?NktaTmYxeGsvdjVwZ1NYdGcyZS9aMXlpNjVNU1d5bTBtWnA3Q2JuekFYL1Y0?=
 =?utf-8?B?clZwL2tYM01VOEswWDdSc28vQjJFclNsT3k0RzVuY2dQa2dRVzI5NDVjR3Bh?=
 =?utf-8?B?eDU3S1Z4WmRZTWlQdVU2NDJMa2FlbXU3TUNiVGhQZCtzOW05eWtkTjFNZ29x?=
 =?utf-8?B?eENrelJTUnFNemJIaHpGVm53VEtPNTJ1RGhTMjY2Z05FQk9Vck9aUEJWT2g0?=
 =?utf-8?B?cjhLMXBNVmJCOHdab3dpQlArMEZmZTRqT21uaFVJa1cvajdwcFFyVGdTOHpW?=
 =?utf-8?B?SjFjdmFrVTluVW1mZjFWcGFLYTgyWVBQdm14N0pkekFjYXlPZU82VURsTE5n?=
 =?utf-8?B?cWxXbk9Rd0FKeU90cm1wemw3WHZnK3lpWGJqczBSSWI4N1VwYnVyOGh6Z21S?=
 =?utf-8?B?bDFxeDM4dVh0NDBwZkpIUGdMYS9xOHFqN1JnK003dEszMDMvMlpkV3EvZVlE?=
 =?utf-8?B?L05GSjNXTnJuR08xSWNtY1FudG5vaXlraXJocmtVWUgzMnh2SmliNWViN0kx?=
 =?utf-8?B?QlRUK0VZb29IZ0NqcUhlOGI0cG9lMytydW5qZXZDaG5oRTBpbW5hOGozNERX?=
 =?utf-8?B?d0tSSXhQWmFvN1pVSmtGV2plZS9helNKMExMNVBlSml4QmNOanM4VjBTL05a?=
 =?utf-8?B?VUNmaWxSOVlxVHBBOXg1eGZCSWlNTVEydTFzUklqWDBmaWhzUXpSNnlPWHpn?=
 =?utf-8?B?dldlU2lwWE1PQXJrN21kYUdMM3dCZHhYOW9GZTBOVHFzUlNnRjcvVyttbVor?=
 =?utf-8?B?UTBxT2hKcnBITlA0eXZPamd1bVhoblNBQ2lPTUZsN0paSU1BMVBMSVMyVmRs?=
 =?utf-8?B?djU4QjVHYmdFY25GVzhlVDhqTnF3T1lTUWU0N1RzUlFmNExzT1dIaVpacXg0?=
 =?utf-8?B?eituS21sYUwwcXgrMXozYU82cU9jYy9RbjRNZ01JVEk3c2lJVEcwdmo5TXA0?=
 =?utf-8?B?V05IeTNNSjU1c0ZRWDBOL054TEkyNzErUDdIeUxxVzhhNUdhVGdNaitNZGxQ?=
 =?utf-8?B?MkZRZDZYM1k3bExNQ00yaGxoTEZyYWpXTVoyNVhoNmlhcjR6U21Weko0citw?=
 =?utf-8?B?TCs1RmNDZmJpU1NCblNIRC9CRENnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8231be2d-ca6f-47ac-134f-08ddfc2741ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:49.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzKI9xBGqk2o868kZhtZ1T6632tJlE9ZANz74L6AtP5Z0BTHS9oX+aPvCUACoSpns6NhpX+6XcnAqCTadZmOXqPgxujMWIXISGp5waTjYc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Authority-Analysis: v=2.4 cv=fPk53Yae c=1 sm=1 tr=0 ts=68d52863 cx=c_pps
 a=YwNxXrBOkeX2Yvw65jHa0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-an67RP_g-7o1LT8KO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6rw_id8br2RUE7Yu-X1OKeuLBGzF4gh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX+0noFCk2MtoV
 TeSF5pYn5DlMEAWOyUofNE0I3mLLWGmaGexsotFlANIfohhMYLxY3Q9OktzlnKQK5eAMwJZUhh6
 VsNDrCvU956J63aBdB7KXnAcg/69FL1l9qRXNQHweubxv0eSvIMqVesCgXPK3L2r9GYKmYWOQbQ
 4QhivaV6sXkbZRnrJ2yRWFnbI9QUEZ35DuvfPuWetuDM9gktq/EQFeiy2xg9zdR+fy1fPmNU+Vt
 UnVe+N3gKFcGWJjd9YLDZxU578Mg9IP9mC61mWiionfQEL0dZkOKQLvlOAcHIioe7qvheemcnyR
 XwcQGLQXx0dm4U+9d+VKwFUbwEPnFH40TGaLK65ejuK/APJceuqngZxnF7iXcU=
X-Proofpoint-ORIG-GUID: 6rw_id8br2RUE7Yu-X1OKeuLBGzF4gh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This is the more typical naming convention for QOM finalize() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 493f9da45d..90458bc3cc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3550,7 +3550,7 @@ error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
 }
 
-static void vfio_instance_finalize(Object *obj)
+static void vfio_pci_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
@@ -3917,7 +3917,7 @@ static const TypeInfo vfio_pci_dev_info = {
     .parent = TYPE_VFIO_PCI_BASE,
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_pci_init,
-    .instance_finalize = vfio_instance_finalize,
+    .instance_finalize = vfio_pci_finalize,
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
-- 
2.43.0


