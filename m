Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3846FFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDOX-0008Vs-5f; Tue, 05 May 2026 06:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wKDOV-0008Vj-N3
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:52:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wKDOT-00009v-3k
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:52:51 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6457YLiu363445; Tue, 5 May 2026 03:52:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=s+Gsi6zwyJgkz5BRJ5BICF0lxUxIpecBLxMM6clVe
 H4=; b=xGdhajgcwnL08GGEUAaiDb9L4Zhvl429AQNQLolhn7B95+okp7EIb92jT
 wEbYrQDmog8XbVUTI1kmHuBNY57nK5omZGyRvCqi2UAoNhS4Paat0kiC30FGr0DS
 1V/E8/YViEI74I6SiTNgzwe2C3i+2HBBDbtXzBvnP8g9OdmdEAJNCBwGDFrljU5U
 a9UprZ6dZZETohQxEJdxDAIZfT7NqwRlvjL/++lxQJeUJCfyEy23oZlUhySmUHP+
 MI1iV13x+IlcTHhqifw0fgBQLGYo6IKqfisoYoCGshB8Rw7HKOsCECFHKN+3bhM6
 F9DsGj0WRYV+ii3pfWZgOQUsfLpCQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022073.outbound.protection.outlook.com
 [40.107.200.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dwgtup2ae-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 03:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS89X+rJkmjlhyvu9yDFYcaqXy2cdjZXmxVKK6b63kv0WDov4VROCFD0y6DvINTPau6qf7ftikd226zZnP3KI6yEuWupf3sDgSg6mZCJO5jOP+p9ivMDTUnUBCoyHzZoZoo+DR5sumeSP+Ts3wOdVUJ+T7pphsHC56EtN98cevn7QblLuU9kTU9cy/kDOmHrACvtBX/eZtCvCZRWg/n513i6ztAMoYOXUEuSBm9Ukij/32ffOIrS7r1Irc/YrKouJ62u91U53Yfb7JvEraEJyabEPFMkbZBG3wao1BFbe8XLWzMjPBDGJsAkB5DeJxuE8D7pWS4HsAhpLJQK7Yl9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+Gsi6zwyJgkz5BRJ5BICF0lxUxIpecBLxMM6clVeH4=;
 b=M/nmIeWEd6A9ialM2NG8Y9zoxtNHDq/d82gDUbQv9nZNsxDxQyhO1Uk1QLKc7b9SGBmPWlyaUF2tQuQHEbaPGeyBspSqcK4anh+5gtQeG585xau2JKoyMpi27oAcgFXcT8LnlGHNeN2uLfijSEZLebRQ41mCfzhuw2Kjo1MgYxqbiYU3q2eUJyXU0mH082LssQ+uRV7+Q4icT2wnxHfHrRzaeCmtb/mHfUbZ30vIf9xQ7HZ40Osgm3kWDreALh3F2vkGIu9MayCEen8I1IX9EP6/+S4QLcrPyyJRvwoLcciRR+xVncH3j1VQw7DB7pDILST+6otV+zgdqqp+xG1a4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+Gsi6zwyJgkz5BRJ5BICF0lxUxIpecBLxMM6clVeH4=;
 b=V7nSaMKFsNAkI1D607Mr9aPgVFgjWR6+Qug256XJ03vNUojOc6ILSbqFNvSHJe7j+ikX6vAuxQKkoYQHntk3q7de7V2MAX+/INUgUXDoL386wX29YGmu6RITM8ZwAlsCSy/xBbzUtiT9KrXwW8NQtLPmQjxG6UOUCz2v6DeKgTTi7zKnvWg5vocq5OGJT7rTDN9Ngu9pP+GkrlP/qfcdvYn+eNKcZM01sSw5r9BAeZnp9+38FWD5OnNnIi1h2qdIsd2whJTr5Oe11xir4WnawbOZUj/ftQQIWHno5Y3hBd+qUZB1rD0G8go3OxHlNQ2k75K7TD/c1CLz6Uhk0+LU9w==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by CH0PR02MB7900.namprd02.prod.outlook.com (2603:10b6:610:101::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:52:42 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:52:41 +0000
Message-ID: <cdd66e42-1367-455f-8deb-03391a1b6b27@nutanix.com>
Date: Tue, 5 May 2026 11:52:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] isa-serial: acpi: declare shared IRQs for COM1/3
 and COM2/4
To: Igor Mammedov <imammedo@redhat.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
 <20260428163356.3a2feb90@imammedo>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260428163356.3a2feb90@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:930:16::10) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|CH0PR02MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d27394-b594-46ba-2a4d-08deaa946e22
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: KjOpAOQ3PhqP6JVr3TYPbpGl98iACrTTTxWSsOmNk1fLhw9GWxvYyPGTXtJPQPiQNqFxzOolwgpe7K5iQBHtXznzkQg2brWIjJ98R0nt9K9QAVYwhKpfa4CQrgV3ks1iMEg8UDWJgX1BQqVuTvfGgzBkk1tEVGdechn3jXy7XUBDGzKAq37WTnnQ82+fiNOLqmQyFeERJ1sHVkBoBsHVcHn21kCMMWlLcAUGIkrrjLqCIcAs462HLz/pX6X9W0G+F6n4urZm1Nyrrkn2OMSuXpqroJ/zrC+q+hCCs9uoAxqVGLgCun8wu2Xwz+ODsVp4wjerXtjg88VOhbIYT/zzdAqKK8bsVIR133f1GJgMoEElHR0YF+XqHhXvps23oAorOx7rjml6ej7NR5rORtvA992MecEGuDHbep+dgFXOS+c3lUVSL9W/JS55ZsDwZESbt+vpGzxpLtB17NIpk3ndQ8p6IS1Vcoh77aFmhDlu+dCWWcEGBUh+44CQh3Z7Cb0UM84mEIfNPXS1yH2KFhFvyMxsbrFKPPiTNRws8Dx3aaOvn3rxmtRVbA/11S4JZAsAqFxKoyOhnE7U5EOBw1+BRyL9ZD/LNLJseChtsb+EWJIMN+6+fuPH9B6/UGjqAzLCRmHWX2ppXCCFwDlBl86n5FUOttc2kaVGDD30O7iKsFI4afvWyPed2EOhJ8U8NQui
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkMwa0hndDk3YU5XTUxWL2NHUkRwazBOUTBhMmFTQnd4V0pjdUJaZkZ5YU5F?=
 =?utf-8?B?azYzV2NPL1F5d1dWM0JlWVoyM25ZUGFxWUFoUHc2NzFZMzZmTnZqRGkvM0Vt?=
 =?utf-8?B?dWVueFRLV0pacVV6VjErOU1zeXYxYkVMcW9FblpUTGc5WVpqVE1yR2dTV3NM?=
 =?utf-8?B?L3ViMGJhbldMK1VWYzdwdVBqQVN4aUxITlFJYi9jcTVhQkNLdjFUZXpMSWxs?=
 =?utf-8?B?anVXQWJmYjg5QU1pTHVTbUZGVE1MbXR1WFRTVVprOTBsaEFDMDdGeGJsUU9L?=
 =?utf-8?B?UTZJeDhjOTJDampZMy84cWNtUXp5VzBVVjhLWDBnQWNuQWNBaWE3UTQ0dVNm?=
 =?utf-8?B?eWNwWm9mK1lXdlkwOGc5YmpOejIwV0J2aEJYQzlNR0pZSndoK3dnSEsvKzF0?=
 =?utf-8?B?ZXZtdC9YTkxIeXEvTkJQMVZPcHo2cDMrcVdldzF6ckFJV0hNVW1hdjhvcFk2?=
 =?utf-8?B?UlRVRWhsWktKUUMwN2JydG9vaytaQkFqSlRBTnBnYVcrdkpDSXR5Q3drVmtt?=
 =?utf-8?B?UWMvKzFhclBJcWU5bUYwR0RnK3E3ZTZsbW1xbG02R3ByMVBqMHZZRHVFZDFB?=
 =?utf-8?B?T0lXaHlzRHhPZEl2azZRbGxlOVZXSTRhbzJ3VjhUcG9JYnZ4YytxblNYWjJx?=
 =?utf-8?B?b2l3YkxtQ1JzZm9iUWs0VjVmNGRSNEkranZTckF5Z3pvY1FRNTVXVm1zQWlP?=
 =?utf-8?B?blI2N1UzN1hUT3ZmSVdOK2VtNWlYOGFMNVJ0MXo0V0NML2JLMlRxVDVLbmZB?=
 =?utf-8?B?SWVkRGN3bDFyMG9JZ0RCL3ZFMGZDOVRrYVhRQ3FJQTRVdXdsYS9CenM0b2VH?=
 =?utf-8?B?YzVhTmhRVUIvNEMwZzloZU41ZkpGa0VEeFdZOEJYVUU1Vmt0cXhCZTJUbk91?=
 =?utf-8?B?bFRyaEhXRCtGdTQzTU53U1hMUkZxb1R3c1BaNTVCREVaVXhUU1JKYnVGM0ZH?=
 =?utf-8?B?Q3J0MTNHcW9aUWNSdWQ4ZjRodFNHNlVoQURZeHQ2bFl6Z2V2Z1FEUkRtSk9J?=
 =?utf-8?B?bHlZRzMvMUFVeWFaZEtBZjYzcjRTbVVQVUJOWXVwWlZLNElrWjB5UjY4eEkr?=
 =?utf-8?B?SEpQQXRhWXJtYjBPd3d3MFZEWm9HSzVaYmJzYnBROEE3TW14NFdWN1BaWHBS?=
 =?utf-8?B?QkpxUk9KTkEyRjJLUDlqSWtwMk0wUzlYZUlSZDBMbXovSGxaODBRTG9DYWlE?=
 =?utf-8?B?TlBnTyttYUJCOFZaekZjaGVzdzhpdTErdHY4ckc0SDNjdW1iODl4Z2VjbWE0?=
 =?utf-8?B?My94b3dlQVpSMjYrZ1BMbXl5ekV3OTBpOTRPdlBTYU4vYzZId2htNklRQnZ5?=
 =?utf-8?B?OCsvSkovZjdUbVpKM2xVV0t2THZUZFpzMXVrQlAydkNIYmJ1azF6cFdYNjZs?=
 =?utf-8?B?bkxpTm1LSUJNNjNkWWtmOXgzTDlodDMwOG1HR1drWWdibmVveGtUZUt5NGpz?=
 =?utf-8?B?U01FcmVNN2FWVWE4cVA5UDN6R29NNkZEVTluVkFMOGdzRURQWU9nNHp5ZG5X?=
 =?utf-8?B?bnhSL0xNM2UvMXRLdjE4V3hrdzN6bmRKckI5N28xcTIrREFuQWd0Z2xBK1Qx?=
 =?utf-8?B?QXRidmlSb0Z2RVJmTXdGWjg2U29RL3NtZ2xDWnc1RURJdzNXM0I3UTRDUGdC?=
 =?utf-8?B?WlkvdGVHUWdoL01aTnpWSTVQOVRUaVBvV200MUtNM1J3L1hpNUYxSzdSV1hH?=
 =?utf-8?B?bVgrTGlacHJsS2d6bXVmZTVYU2ZFbStsODloNUJDQUhPWEZFN3VReHkzQWRU?=
 =?utf-8?B?U2t4VGIwS2w3cXcxSnRjYnBYNFg2Y295QWkwTVQ1bnNMMmZUa3Y0QkhXSms5?=
 =?utf-8?B?TnlMU0tqRjFzM0FsRW1MZTlwc2xiS2xFV2ltZVBnUFRhZnkwZ0ErR1NpRTBa?=
 =?utf-8?B?clhWVlN2b0JRQXErOTRBRXVIYWZxZGxFMllSOVpSenNHYzJpY082S2Q0M1M4?=
 =?utf-8?B?c0xqMUhya3ordHlsTWFPUmFCUS95RHFtc24xSExPenZnWFhGaCtWelZRbWdI?=
 =?utf-8?B?di9kNzRva2N2ZklxRkVjdHRTUDFZQlo5YjRMSGF1eFh1ZU9RN2JmMlBwZGUx?=
 =?utf-8?B?QWE0bzhnRGl4ZHJzSWJKUzh1MWJpK3p4emMwSGJYR0xDQ3h3S0h4UVJCZmZB?=
 =?utf-8?B?UkppdmR0YkpiUDJTbGlrR01KanEzMlFNYWlBNHQ5Q1lPSEd4eDFEN25uWk1K?=
 =?utf-8?B?MGs4dTJtSkxaN3F0NlZTOEd6OUFwMFRFVGV4RTNENGNxVjU4Z21HVndPcGMw?=
 =?utf-8?B?V3FoTUpKdGhDTmFuRlpoVGdCZEoza3ZETXc5MGk2b1R2dEI0NThsMzZBOG54?=
 =?utf-8?B?SnYwaHgvbHhoRy83WFEySG9hL3pBWGJubjBMbUg0dW93cVlndnlsSEVZMGpK?=
 =?utf-8?Q?kxHqKdIXJ03yQarI=3D?=
X-Exchange-RoutingPolicyChecked: wIOmlgN+X6mfT/z4bNBCgbtc+HwF4s3UISsPRDxsVjXkbPjCIRTVd8i4Xc5t409gfK++IHP7b3FI7zDaiscOTI0S19SsxfFsr/xw8OKPpwm5bO84hkiC6/SgtocmtnqXxvvZkuWvGyeGN9OV2aYJjwMBJYsnpqy15whr8WiNfIwlIr/P0PTI/erzL6Z8C8mDj6qyu/BmG7E76EqxdCtjyu8KFqoOMD0fBCt0HELLCOSsKlMZRbEL0AQqlsn+4Ft1pcqWoV7xCvAeEgESgtyEBY5f239cRtz0wGiQgefNfQCw2VjRRmLxFQ9CkDuPe1hCAClorSdv09eyEJK0zL5PXw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d27394-b594-46ba-2a4d-08deaa946e22
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:52:41.8827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLNuKhGxkUitCApXoVnYhVLnFlCU9o/YW6w70xfoHnzjl5unNeFc1gT/uGBs+FIPd4AyLVoRC5mEn7FEjHba6e+faif/npSMhRbPeCzsufQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7900
X-Proofpoint-GUID: 8VunOquAUObVG1oosw2-4rhjuuC3AOu0
X-Proofpoint-ORIG-GUID: 8VunOquAUObVG1oosw2-4rhjuuC3AOu0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEwMiBTYWx0ZWRfXzxtZKCtCFuzb
 +ccbK3QTegbJam+b002Cn6km/I7698viN5DAWW/duAKXI3mlGWZaipUN7PQanlGMUDlOiqIAZqA
 ugSlbBn/JcsvPO0ipG46HF0E1jsYEvMXZa7lVayIWivs+/9s5a2fPskcO129M5qMNHjJisCsU3i
 ihqe1z1OPqLGwCXprIpeQzrjJMNl02piGCa17Jsplapi82Ptf++D3qstnuEefcbnCS3ihF81x5I
 3IdRNcCKV5G3muEeev488Wbmj186ybP411B+sdC+BtrMfiepZ70UxyMd4OqrX6TlBSvt8FoeMhJ
 Ef6FyDEEhKp2ItmizT5JiQuxHUoNdxcUhpyTjkygRH7QtrIu2Cb4kR5l1S1So/QxuioYH91OUdj
 s17WY8GqMmcMj8+lB0pDdCSuG/qyO5ZiFCvMmssZrPWkTLH8rrjiRLozzLjEbemiFaTR2CN7trp
 3eu6DcQuUGKowFa9qAA==
X-Authority-Analysis: v=2.4 cv=LJNWhpW9 c=1 sm=1 tr=0 ts=69f9cbfc cx=c_pps
 a=mhBramkM2YKFwkQI7AGxcA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=hD9MWEz5PaxzhiBJWG4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/04/2026 15:33, Igor Mammedov wrote:

> On Wed, 11 Mar 2026 16:24:25 +0000
> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> 
>>  From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
>> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
> 
> nitpicking but pc/q35 ship rev 3.0 facp, it is worth mentioning CLI used to reproduce/test

Thanks for the confirmation - I think I got 5.0 from searching related 
documentation online, but I will change it to 3.0 and add a suitable 
command line example to the cover letter.
>> Descriptor is used then the interrupt is considered to be high true, edge
>> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
>> an IRQ then if more than 2 serial ports are added, Windows indicates a
>> conflict in Device Manager and these combinations cannot be used together.
>>
>> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
>> ISA serial IRQ is low true, edge sensitive and shareable. This enables all 4
>> legacy serial ports to be used in Windows without conflict.
>>
>> Tested on Windows 8.1 and Windows 11 with 4 instances of -serial on the command
>> line and copying data simultaneously across serial ports COM1/3 and COM2/4.
>> Note that with this series applied, if extra ISA serial ports are added to an
>> existing VM then it is necessary to go to Device Manager, select "Add legacy
>> hardware" from the "Action" menu, and then reboot the VM for the serial ports
>> to be detected correctly without Device Manager indicating a conflict.
> 
> 
> 
> 
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>> v2
>> - Remove _PRS changes (including AML build changes that are no longer required)
>>    and compatibility property as suggested by Igor
>>
>>
>> Mark Cave-Ayland (4):
>>    hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ
>>      descriptor
>>    tests/acpi: allow DSDT acpi table changes
>>    hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
>>    tests: data: update x86 ACPI tables
>>
>>   include/hw/acpi/aml-build.h                   |   2 ++
>>   hw/acpi/aml-build-stub.c                      |   6 +++++
>>   hw/acpi/aml-build.c                           |  25 ++++++++++++++++++
>>   hw/char/serial-isa.c                          |   3 ++-
>>   tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
>>   tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
>>   tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
>>   tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
>>   tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
>>   tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
>>   tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
>>   tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
>>   tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
>>   tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
>>   tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
>>   tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
>>   tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
>>   tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
>>   tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
>>   tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
>>   tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
>>   .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
>>   .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
>>   tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
>>   tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
>>   tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
>>   tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
>>   tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
>>   tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
>>   tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
>>   tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
>>   tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
>>   tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
>>   tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
>>   tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
>>   tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
>>   tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
>>   tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
>>   tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
>>   tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
>>   tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
>>   tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
>>   tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
>>   tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
>>   tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
>>   tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
>>   tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
>>   51 files changed, 35 insertions(+), 1 deletion(-)


ATB,

Mark.


