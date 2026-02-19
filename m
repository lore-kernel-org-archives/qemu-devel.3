Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB71E9A050
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7P9-0007tE-LL; Thu, 19 Feb 2026 12:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vt7OZ-0007hR-V5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:00:57 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vt7OW-0005lQ-Vx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:00:55 -0500
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
 by m0050095.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 61JGnVji3297308; Thu, 19 Feb 2026 17:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=tqC59wsFgBPKe3YFztXsMVbJnMEXcXQdnJSPbdwbhLM=; b=
 aX4msOZKA7Lk+UNBLbKfE9nc9K9MaQzU1L8XesfUxhfxBQEuuGJ5bQ4LV4C1mGQt
 dpLLhTd/b8puKyuuZcu4FX4U4I+mAjB97Maf9imLhMC8MuiZzOaFQNFMM/iIXmKp
 NmwOeCDJB9T+N0+AbuuB8cMth+LlN0Kn13Xja56e1EJ79vzUficAWv8yWmjnCFKK
 YKDwPUBKp2tXfpLQAFo2DU9ef4SyxNd8jmIunAwczt13+koB8OG/OcxR6NBh+OWq
 WaS29UKrIEHaPFxp5Txt7DT35H/TGQBY5RhRj7lfwhTcJjj/4CWk07AdPts+3wjo
 3H0mig2umG4cY/qg6oBBHw==
Received: from prod-mail-ppoint7
 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be
 forged))
 by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 4ce6c9r58k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 17:00:45 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
 by prod-mail-ppoint7.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 61JGmnUe014319; Thu, 19 Feb 2026 12:00:44 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4cdd941g0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 12:00:44 -0500 (EST)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 09:00:43 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 19 Feb 2026 11:00:43 -0600
Received: from CO1PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 19 Feb 2026 09:00:43 -0800
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com (2603:10b6:a03:29a::20)
 by BY5PR17MB3731.namprd17.prod.outlook.com (2603:10b6:a03:236::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 17:00:41 +0000
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f]) by SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f%2]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 17:00:41 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v3 09/12] net/tap: move fds parameters handling to
 separate functions
Thread-Topic: [PATCH v3 09/12] net/tap: move fds parameters handling to
 separate functions
Thread-Index: AQHcoRVV1VxYfO0y6UK+vTh3XKDqHrWJ7JKA
Date: Thu, 19 Feb 2026 17:00:41 +0000
Message-ID: <881F7D8C-E65F-4629-8AE4-68CA9BFCEFB4@akamai.com>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <20260218202829.1322088-10-vsementsov@yandex-team.ru>
In-Reply-To: <20260218202829.1322088-10-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4301:EE_|BY5PR17MB3731:EE_
x-ms-office365-filtering-correlation-id: 56180720-9589-417c-e606-08de6fd86a27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?N2dqdENINDlBcVdwcitSenJlWWFzd3RIajlwR08wQWZnTG5lZDJMWGZLQUhR?=
 =?utf-8?B?K0JuWFdLT1hmY09rbmN4WldLOFNUSVl2NW5ndUdSVFh1YVNWaWdLUDU4SDZM?=
 =?utf-8?B?RTRJNk4rMEFSZ1dVbGtjR2xFRUdoQU5jYWUxbzZwTFppNXNVdnZNN0s3OXM5?=
 =?utf-8?B?Mkg0a0hFbm9qNFArNDB4THpDRnRUQmltbUs2TjVtU3BieW5EZXJrZGduQ1hq?=
 =?utf-8?B?aWpkVlRJcDFQQUZZWlNXd3BLaHcxYTZGLytZUXhaSGJYbDlvQXVhcWxHQ01Y?=
 =?utf-8?B?T3NLcjRJaGRJazJ3K0xOL1lTRzUvTHJ5OUliNDNBSGxSaS9nUXlzc0luQmxh?=
 =?utf-8?B?TFl5SGtyN0FSSEpWUzRWdDZEaW4veG1RV25jL1V5NzV4QlNvR3NsU3hkZ05X?=
 =?utf-8?B?OHdibDBBMENPazh5NTIzcndSNExGYU8zQkpRYzRpOFlpWlhsWGMxZUFpazU4?=
 =?utf-8?B?VkdIMWFJbERxc09GVjBjNW9OUjUzRVE4UVRnN0xrbWd5bGRqUFNKMmZVQUF1?=
 =?utf-8?B?RXJuMG1GL250SmtXQSs2am8vVVB5a0xCeG5wSTJVRllGVXl1K0FYaSs4MjlM?=
 =?utf-8?B?bFhBK3JTejZabC9rMy9UZjIzdUhHdGwwRk9aWkVGOE1zNVpmaUwzMCthZUI5?=
 =?utf-8?B?SUZ6QzBxZnN6QWp3a0xNNTR0YlhmRVlRTlRCN04xYWdBbFhzVldPZDRFcE1p?=
 =?utf-8?B?QmYzQ3Jpdk03NXE0WVliM1JSei9NYWtCU0RrTGMxMktkZDUwc3hPYjgwL3BS?=
 =?utf-8?B?dWo0SDNOWjZHbGxnTkE2d1UxT0dTS2dLMkFwYmZwbXREUFQ1dDZlN2x3Tjdy?=
 =?utf-8?B?by93ZHdaRHk5anZkRHQ4UHhGRFBBc0FBaXU3REdIWWJXS2pNd3NLd2hDQUZn?=
 =?utf-8?B?VnBlclFvNU1Kd3l2SmdDSTlVeWI0eWIzb2VvRlFYVUZ4UW04Q2VTajFZcGxm?=
 =?utf-8?B?c2JEZmZ4ekQ1SnQ1Z0p0VUhhN1c0Zkk5Zjh1bnMvUHdXaGhqMkRpbXBBNGl6?=
 =?utf-8?B?TWtOWm9Na1NHNmEwZXpWck9zbDlCbWJTRzJYWGZGRFpQUWIwcG9mdmFWZzlm?=
 =?utf-8?B?d2g3QXVRK2JXOWJHclo4THV5bUtUNGRjM25iWVRvZlRJVnpTQWlDMWs2ZFRD?=
 =?utf-8?B?OGJrRVFLWlBReG1IOUZySk52NzVSMVJ0Wko5K2hjZ21ad2FqdHBTbkF1TXp5?=
 =?utf-8?B?NWNsV25obzdWMWtBZmQyV1JJOTV0M2lKSTJqVVp1UmxQNVMyUDdKaUFWM2lo?=
 =?utf-8?B?QStNcnRlVGdGRXc5Zm5lOVdOcGpxQmZQOWJsL1ZMQ01BdnZVT0dxUmNMRVpn?=
 =?utf-8?B?M3hWcEpOTTFSY3JoYUpqWnkzZmppM29YaE9ldlBVUEhWblZ4bnpWQjRSQ3hQ?=
 =?utf-8?B?SnFDL2h0ajFPWis4cFBYL0xvNG9SS1daelZpYzZhWkxvQXF2TTV5TzN3VGpx?=
 =?utf-8?B?UDNmS0RDdmV5VXZMOTZZSzAyc1hwWGJVdzBuV1Z1UFQwT0tyRFJiWnVQU25x?=
 =?utf-8?B?UTJHSmltQXBKbnRWRTdKT0ROdFNLcjBTOWJtU014cVhoWVlwVWJBRjVaTUJS?=
 =?utf-8?B?MSt1aWxYLzltZWpGVi9QSWRJNmRwTmErQWVWT2NrTnRHWW9seWNldk85SHBT?=
 =?utf-8?B?YVdxVjZOaTR1b0lKem9GeXJ1UzV6OXh4QTlKZ2tzZHFad0FOeXpGUnhweE1h?=
 =?utf-8?B?U2IyUTh3RlF6b1VWSWxVcFlodmI5L1A4cmhvazBwb1BseXYra25udndUeXVw?=
 =?utf-8?B?d0c0akxtUEc4RTl5S3dxdTRTWHh2VmdidE53WmI2eTVNZ01UdEZqdTNLem1V?=
 =?utf-8?B?WTlmZXNuYy85WjVvbVp5STdaTk5HaG9VcTZSdUZoR0pCQW1pZEpxc0U1RFp5?=
 =?utf-8?B?WHZZZnVQMHQ3cXVvRDhsWlg2RC9tcm1jL21SWXZiU2JGUWlkblBWcUFjSnp5?=
 =?utf-8?B?T2tpTFF2bkp5bGZGTUxYN29iUC9uNTFPRmdoeWhpZExMODk5NVczNHNHVXl6?=
 =?utf-8?B?dnJmbW5YZys2MDFtOXhGRU0xN3pLN0t6MUwvL3Ewd1U2NVpyaVVqcVVCcTBk?=
 =?utf-8?B?OXZzc2E0V2tUVkpDWThRd21jMmFuQm9vR1VjMWFudVhKQ0x5SS9MRy9FSU5D?=
 =?utf-8?B?STE5YnN5dFFFVkRGenVMY1JaZm1UckhnSXF5Z2wxd3NKcElJSU93dVpIdm9w?=
 =?utf-8?Q?oZoSjFJFBJe6wyL3Mkfky2g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB4301.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTIrd2RFNHNjaHcvNnFSSFZqZ0tpMmx2TkRld0gxMXZDUVpNd3krT05OT2or?=
 =?utf-8?B?N3NRT0t4L1pkc2RnZS9JUlVGK3dPb2hJWmY0R0paTWhpY2pHMjR0b05nM3cy?=
 =?utf-8?B?WUtJd2dZanVmdndyb0xOK3hDdEpmTUdEbHZKbFUxOGx3d2pyc1p4NURKOXdX?=
 =?utf-8?B?QXpGS3dXYWJGeFN0NHRZK0FDeXloclEvajRZcVpyeUhyOFp4MFdjSGtCbkRF?=
 =?utf-8?B?ZFVaSFJnTDVBcllHNGtKN214aElZeHBTYmsrc0oxWW14amZPZHY5TU1reTZv?=
 =?utf-8?B?bG5TOE5xNmoxc0VDM3NYMTJ6blo4RU9Od1RpYzEwTExQckxSdG9Tb2wzT2dJ?=
 =?utf-8?B?ejRWRjFxaGFjUmpBcUNoRU4weVk5b0xCbWZ4NlNwSWk4QWE0RzdWb01Wb0l5?=
 =?utf-8?B?REdBNVJmMHdLb2d2ZkVNK3dLeVliWWpTcUhBOUdTMHNDVUQyVEwydEViS2tU?=
 =?utf-8?B?Y1BKZ3dEcGpNaEI4eWhpazdBdkpSd2dBMU1vZVU2OUYwLy90UUxZSUNQTWtz?=
 =?utf-8?B?eVUzUUhXb2twalp0bnFoR1NTd3JDbHA3YTdzZU83Wk1MOEFYYXJiM2R0Q1B6?=
 =?utf-8?B?MEpYdHIzRGZxd1Q3WEV1cUIza0t0OGl1SEJUcmxWbk53dnpPR1dvTEFsODhy?=
 =?utf-8?B?UWgwSFJwQ0tLL0JTQ1VZRE15Rmcrc3BhcUFGdVljQ3oxWmVRcWc4Uzh3Qk1P?=
 =?utf-8?B?OEloSkhRcjc4VitpQ09TeStLYkhpL1loTXBjTUJuaFpFbVlEQXFMUTV1N01j?=
 =?utf-8?B?OUFDa1BNNE5UZVo1cmt3NmNKcWE2TUszVlY2NHdhQ3Rsbms3NmVwVHhYcWFQ?=
 =?utf-8?B?SUZSYkk3M2tiekdyY1NDMFgxRnZ2WUJkanhYSUhZN2lSY0k5MllUbzFMNTFo?=
 =?utf-8?B?dklsS1hGNG50Uk14dk5LNHJFL0s2NkNxbTdzbThnR2ZNY1lESjZFTzNNWWxF?=
 =?utf-8?B?b2ZSa2NOeUY2Q00ya01kSW9wakVZRDE5R2UyOVYzOG9WT2FvcktHdHgrLzhV?=
 =?utf-8?B?OWJHZVUyTEdhRFJSZ1cvcUFacmFNSEo0blJPeUk3VjQwckw3dG1DcFZJR3Y1?=
 =?utf-8?B?ZFhkcDduWGtVbkpTSEc2SVY5czJJWGNwekxBa1FNRlBMYjJwbXlmOTNiNWxE?=
 =?utf-8?B?UzhMT3ROQkNKTkl0dWFrMmpvWTh0YWhjU1ZlbVp4Zm1nVGh2Q3kzMTlnRTls?=
 =?utf-8?B?ZS9VN1RvaHYxZW5jb2xJWlNZb25rcHROZkRlRUo0eUp1MlJCem9ic1VTdDd2?=
 =?utf-8?B?cFNwMXhiTnJveit5QUhoc21GVGR1T3I3cDBUb2hocnpMZDRKRlpqTE02UW9C?=
 =?utf-8?B?VjN1eEovK3c5VGgzM1VLN3Y2ajVNMUdvWUhNbEF5NUM5NmhFc0FnaThUTzRK?=
 =?utf-8?B?YitHY0doSWp6aWU1WWN5ZDlBK29iKzRIRktVS1Z3aVY5MmthNHJsOFVKRnZp?=
 =?utf-8?B?SDhQbnR1Z1dtTWhpRngyQ3ZhOFgyQUplU3g3NzJGeml4bkRBck5IYllja20y?=
 =?utf-8?B?aEd2eVlLNFhITURsbXljTFVXb3o3bFBQZ2pEQ1I1c0c5dlIyQWRKTnAxUjcr?=
 =?utf-8?B?elIyNWl4VXpPa1dSY2RneUFyMGhkbVZoemhCSGJnUy9URDVGTEJxMnM5YWx4?=
 =?utf-8?B?ZE9VZDAxTjRzS3VtWGF4MnJWemh1N1pla2VneFFkWjNyU3plY0tjWmZkZVVq?=
 =?utf-8?B?OHh5UWNQKzNKQWNQZEtOaHIwYkN5RzA5T1FMRkFvM2hoeXBiTWRSNENSVDJR?=
 =?utf-8?B?RGdvN0REZkcyU3pnL2YzUmtCbFFvUnRlb1JtWUI4c0tRTkZiL0dSTDI2RDlD?=
 =?utf-8?B?M2pLQ0pBd2xPZHlTT1JnTDh1NkF4WnVjR3BPdlp0WmhGc0FqWWhoQy94Y0Jo?=
 =?utf-8?B?QmVSRm9aMDhTT3F1TU9YZnlHMDUyVXBFZjJqNXB1OG44L2JLRUxZUUJZTE1Z?=
 =?utf-8?B?bUNQOTdDNmdwZHVubWE3UzdYeUdyWmJjTVU0SzQzajV0WW9OMjFCTktNUDhi?=
 =?utf-8?B?QkJ4a3RKR2ZNU1JPZmVhbHNHS0h5WUV0c2hRNFRXSlBEVGsxTjFKNlVmRkx5?=
 =?utf-8?B?clowRk9XdzNWM1VtMnQrOVhERnFlL1U3bUU1MUpRRE5tSFRLcVVFTGxyNkwr?=
 =?utf-8?B?ZzJXTEQ3WlhtMy9pbk52K0NqMUNFcUdSdnpnd1VlQUV3T292d0d5dE16Q3No?=
 =?utf-8?B?NFRQZjRDTGxKZ1c5TERFVXRKVHRuQ2tLVnMwNWlOcHpOVXMyVWVXSWVFN2RR?=
 =?utf-8?B?aEwweFFwd0lrYUpwWU1VTjNVelZOWGhnVllZekdSWDRYZllzU0l1TzFITU9T?=
 =?utf-8?B?TXdxNHdESnVqcStuOFp0Z3ZoUExnSHN3Sm1rNDk1QmNQaVNhREdVd0RrQ0ZR?=
 =?utf-8?Q?g0HMmClvXdyxFSWXlSBazKwWjcKk2vKuaQPbEbs4vh7eT?=
x-ms-exchange-antispam-messagedata-1: b8Ov8q3579wa+w==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBOQ1NJQiRJWEF3NlXl0QHQip5Y7wSR2gTZniSBKdjBMCZEsQme43llNwoC3G9SGYQgBcsRgkK+TcXPMkCQtfkSdGmMTvdx1mEQg5mMt/JEeSnYn62FqfVx8c2sHitHOQXiWPcJ9kz/8flVYJqcWYeNN6eCF7PLf/TCf0/d4iXP+waCAvxiAUCpN+64iRARafyCL6EMswsYU+6xdDVZ/9hLZ1fc0Ffl/dBDg1g3leQuSiyqKHobvUlknJrp1zMBKS9ms96ZHfSuP40jspfpA3KIQMkZBTUrTjAyOBECPggAsjbHVTc+4TXztgZVehAayWFNOZXy1U6K4NU+fkoMMfw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmwMv9ZyC/fcqvjXeM7oWx0iB7lUon+syJODTwQQs4c=;
 b=Fh0iZntfJE9e/kL2teq1Dn5pHsQdQQxGpMPwInBbi0WXD9xIkMjAgNncoogvGi0zyhxlJ1yQ5iQGF5JAOVrwJQT7V8bLpilyLuKzuoL00bSNmud7S9IQRp81+sjyBv4MV71HKLIXVPYaGpy3E8HTYnEXeZHu9EJ6C0Pc5fWVQ4fb6jqJGWZ2d6a1Wdk2NabNtwrQlOKoJvaOMNb3dpmEt8UG2O3PCfMyuufTFf/1W2lwtw0u5kkAUCIqhOfJGYC7+TonOojkUj1tHZxwwqp3Z0MkyHNBXTM9htku9oZPKUwUgDNRhDA58SwXRrdaoz27GeU0fOhNwtN3O8FJ6MUbCw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR17MB4301.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 56180720-9589-417c-e606-08de6fd86a27
x-ms-exchange-crosstenant-originalarrivaltime: 19 Feb 2026 17:00:41.7092 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 4Pft8bpSQhvV8yorcf2B5d7e2a6Td8PYGflfXglVu+k6zVVXfzWCtCKsWDU72fx5z9wpSkNrXVfluS9Wkckdvg==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR17MB3731
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0548967D357BE4B9E0C64521CF15422@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=942 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2602130000 definitions=main-2602190152
X-Proofpoint-GUID: n7mXNcM3hlNeMfxWm768YQhGIQ5UrIb_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE1NCBTYWx0ZWRfX/vzf6S/Zig8K
 vkZ6/clAotLDbhbT2pxBYZWIl8HRZpJoC3L4rAGGx//U6IwFTUfNFICOoJhgyjEB1F9npYK5LlV
 hfBOV3rqrZ+/1xE9re58+pY2DBlmgoq2sfICqhb2oM7e3jdReEWgr5WiNaKAW7tUaKxDOuaivvL
 QL8PbjQ8OWutuALB7ruNvjrhUz1syGFxRGIBfeHqcTtZWbzNW8xWbS6cpa+oGCgvC/S+uiGrjJU
 WWIPExdZCVXCqoqhXs374R2hqx540j2MrW0N2QJdLJ5t/KixzUU23fJCEE2VpRFxhqMO4kKUHB3
 C1pKOv8qxyQfcpNQ78D7SjUXyJFS+WPcvbYKJiX7+pFF1304ZeQF7uzDEwbgLw0N+N2akLqza4k
 ee/bijgFb4irq6WpvV1LWG0SwRlWeqC1j9o9HUvRYxW4aFmQoztOQCiQilFCPuDFpVRYhpUcjWJ
 n7mMP2C3VVnznBQxpLQ==
X-Proofpoint-ORIG-GUID: n7mXNcM3hlNeMfxWm768YQhGIQ5UrIb_
X-Authority-Analysis: v=2.4 cv=Ra+dyltv c=1 sm=1 tr=0 ts=699741bd cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=6R7veym_AAAA:8 a=PJzi30hxmJvySxw2S9oA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190154
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
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

DQrvu79PbiAyLzE4LzI2LCAzOjI5IFBNLCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSIg
PHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRleC10ZWFt
LnJ1Pj4gd3JvdGU6DQoNCj4gKyBxdWV1ZXMgPSB0YXBfcGFyc2VfZmRzX2FuZF9xdWV1ZXModGFw
LCAmZmRzLCBlcnJwKTsNCj4gKyBpZiAocXVldWVzIDwgMCkgew0KPiArIHJldHVybiAtMTsNCj4g
KyB9DQo+ICsNCg0KQXJlIHdlIGFwcHJvcHJpYXRlbHkgdmFsaWRhdGluZyB0aGF0IHF1ZXVlcyAh
PSAwPw0KSSBiZWxpZXZlIHdlIG5lZWQgdG8gdGhyb3cgYW4gZXJyb3IgaW4gdGhhdCBjYXNlLg0K
DQpUaGFua3MsDQogICAgICAgIEJlbg0KDQo=

