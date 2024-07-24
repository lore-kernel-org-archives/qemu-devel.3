Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD2BC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWWuj-00085o-Sq; Wed, 24 Jul 2024 03:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWWuh-000850-CV
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:59:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWWuc-0003G7-8i
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:59:54 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O0wrAf021568;
 Wed, 24 Jul 2024 00:59:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=D1clWuqQ4+i1LEW
 HWCrjSbBSySHDiGHnN6Y1T/PbBuI=; b=wo5daheP62thhr+MxPxf64OUOp722H1
 RabVjtJn2NpWZ6DHeSI5FvmAXBiSDNgF5004qQXlMGpoRXuHpCFz2Zw+38rSx6yS
 953YTFh77m+dQt1BBj67axsJHOu7kJ0UzcxBXkbTCUuizQmXx7cNkO7jJ9xnL9BB
 ruYwpKYdpMPa6Dr5bSZEtwFXKNVvhrDv6IjmFrH6fmW6Jt7GhXubHrGW+yRJW/Ze
 nKLhfPHg2ZcpzWMutn2xNe/iM+Q2X9LdsXEnxi5Uj3+CqcZQYBdlKub9o4dDRoDk
 FZkHCzsz411gQ2OjPaG4NITxAk0yhI8i1kQEjhBgSB1hTRSL0GD3IeQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40gcad7q5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 00:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsboazisSCkDB9KTRpNjRHhH5+TU0yTkZETKK3R9V9Irc9Mtte4+450tZWMxldE+n4tuX1HRWPwvQ8+5s02OvphbuwUpjlppExi5GgrqE5diPjdQmJWtFg8yXSF3gSNL71S8r4AUc8nrxUwBKKoAl7BPjPp3P8bYp+JK7aYEZo8uAmlBcEzm3FOWnURdA0rgNtGn5fYeGr5zMpihRwcU7ZUq0J/v/3vOzvHubKd6DNeBgW+W/FSllJDD1IOmR3b3OA2Nh5yCrZV8h/NUy714bRWuq94pvbfq/y8bg82pkKY9PJRwqe2KF39n1yn/rUp1baqKtL48+I1qSOAaNdgWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1clWuqQ4+i1LEWHWCrjSbBSySHDiGHnN6Y1T/PbBuI=;
 b=HfqbPYkfN+Mf2U/tcFSNxTFHvTFko0N4uje7MsK1ehFqsdegnb3KvbZC0GhE4HS5K7fpihZxdfGeLFDMgNJgHRqUlnjRY4xUPR4Nh7l+wD/YmqUc6+9ujIWBI4Jfuqld1rmySj/m33Slxs8WHXhON8FjUa9MveMwsEXNKFa6Haq9QOvigm3Cw/A1gMI4G/pSJow7cZLVzgfQNRSg6K88RGrzKWjXzVCKJi7jeYuulfSGFUKzq1BhZr/ZiTbahqTMgY/WvT/n5+U6l+XhjdOoo+vxlSMWewWhfKmLRFKmzn2uxEk5lsYyLz6LzDB6ARQARhZeu9vWxJaz2hRi3kamqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1clWuqQ4+i1LEWHWCrjSbBSySHDiGHnN6Y1T/PbBuI=;
 b=WpfZC9U4ewrqgii8B2yQnHF/YBy435g4+b4eSxSqt7ob9ih2ECLHyCqXMbWbk8/v5YBNiLD1hCdvc2QK6/Ul90wQ3krg6pcHI2p0tRSXekC0Rb9ENkt94wALl5+fTk0ymDI2y/4dGLwjfR7O/mJAej1lhNmU3dUJhX24cAsuU5o2EdTH8gB6yK5UbB9sn8LwvyIrd47z1kN6TRZ4P4q6BttqTS2Ue/eiMR+YbI27je127d/wtWi5KLJCdsrDQqUp2cCwpxSDLF1c9g0wFTjquk33GwiqxWrNn9PxSQqF1Ex4KwGawU6sVLSAEZHg32KqsX1iLgC2DOABDlO1iLo3rg==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by BL3PR02MB7985.namprd02.prod.outlook.com (2603:10b6:208:354::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 07:59:39 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 07:59:38 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Bob Ball <bob.ball@nutanix.com>, Prerna Saxena <prerna.saxena@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Subject: Re: [PATCH] target/i386: Always set leaf 0x1f
Thread-Topic: [PATCH] target/i386: Always set leaf 0x1f
Thread-Index: AQHa3CCTp0oB/OcNPU6slzARG/b0pLIEaqmAgAF4EAA=
Date: Wed, 24 Jul 2024 07:59:38 +0000
Message-ID: <3d1719e0-b4b6-445a-b18a-791c8176bb64@nutanix.com>
References: <20240722101859.47408-1-manish.mishra@nutanix.com>
 <20240723170321.0ef780c5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240723170321.0ef780c5@imammedo.users.ipa.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: PH0PR02MB7384.namprd02.prod.outlook.com
 (15.20.7784.015)
user-agent: Mozilla Thunderbird
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7384:EE_|BL3PR02MB7985:EE_
x-ms-office365-filtering-correlation-id: 1084d9d9-83b2-4f89-e29d-08dcabb6912b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?y7SO+keMpGLsMs7eoKe2oKSdeg+9y8mFjPkxKo9qcazhGqdvV7Gu9BCVW6cE?=
 =?us-ascii?Q?y9W7aZ9tGDlOZ++MTOalclFCy60hFHKb88PQFS9ubidphO2IplYUUr1DD/Ic?=
 =?us-ascii?Q?d02BfBIW9Sk+3eF14tmL95rkJH+VQkoiZOMaLRXP94e/yncAeiwvro1nNDek?=
 =?us-ascii?Q?4A4U1EX1xV5H+FM0E47XICppjMrO26BkOWhr1fSsX8BplfrLfOw5jeDOI9t1?=
 =?us-ascii?Q?zAzkjhUabrV/QkI8SrpffAFXnSdLzArdfojpKRM9BdcAsO5fWzQmIkzbHYFm?=
 =?us-ascii?Q?WaxkMn2BPvUTMuu+r2ZIkSsx86ilfCJZrWRgVM9gWSWXoXc2y0YeuzL7Ne0j?=
 =?us-ascii?Q?vfeBqz8swVXESTcooXxnvgqQghag/2lzkNvvKibXt389pDSZXptwRudKHGrZ?=
 =?us-ascii?Q?SJrucRyZMnZsMy7qyY1GrMml8t7X+UQFyFOZbTmvDhQJ4zARVtVVLyfSJeHC?=
 =?us-ascii?Q?/CiDg1AEyp+elJnmaVfxmwInhcXb7flcm0yO6LB9jRXtigxejnp9G18Qcle3?=
 =?us-ascii?Q?QXcz9TS5fHkGDBo2zhlKqtGktZW4bf8sDeFw/5ichUH4sDoiDXZKHIs/VUhT?=
 =?us-ascii?Q?vwM9ImPLyY/Ztyd1yapC2yiyuPd7LzX0mKm4apEQQSbyBjh20bcbcgubtIfh?=
 =?us-ascii?Q?EfOxWOCo95GmWXZu6HtYkhDwBYXq4sZ4mDWoANXA6zJzGFN4Z9YL1LVq6xoF?=
 =?us-ascii?Q?7wHJ3r9fmGOv4B7jfEqMF4+EC1nm+BB9sWJt5nlu/fawwaq47WCgRlnGoPpJ?=
 =?us-ascii?Q?bamqbdyXo/Jlgc73X20m8X++lF3lhq8H+rWRRWxStG4UOX0XXXKdlLX4pEeA?=
 =?us-ascii?Q?z9ls9S1axbZbRChCWb+Vq4JKDkEm9uG38Y1j7rrkDS1sycbn2PC82aDo1l7l?=
 =?us-ascii?Q?N41ZEwtug0Yfijl/WB6G1ZW4/cgfoVWTAm4FXQazMIOdvBmCcHszllrabhnQ?=
 =?us-ascii?Q?fHw68x+ZucvNEz/Nv4WfFooiLAcyHet7HWuNEAWw2pMx+FzVweEfxBbyr1KO?=
 =?us-ascii?Q?pTTKKglGqbYVIMH374aX50pFsVMd7sDjFThBlLj8/l6mZVjgNw6FNY5aSars?=
 =?us-ascii?Q?YSselfjhAk1M8fOLdocn1e7bsCsEVTABnfpnzAl+KcKni4tcCy1AO+iKFftY?=
 =?us-ascii?Q?HD3N9xrcwFt0vG0u5nzSKVosotS9tLucSmIMCU/lVRJdS/0Z9UMarigudUhP?=
 =?us-ascii?Q?BV1eAFeURJ0ILc6kpmherE/5nrGUDuANvGiC/XnCCx/Smx6D1D4cBUVP52Ik?=
 =?us-ascii?Q?jNB39Tky4gNGQxfO3fcCqbCQ5qJVPP0tfqWVqWW7F1toBmXuEuJ0BxYet0Qs?=
 =?us-ascii?Q?Cmj/JSpRGFOzy6o1B8nky7kHu1aNQhZNegAbwPaPb5UaB8O/PaB99Zrq/7ru?=
 =?us-ascii?Q?zmW/wEE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f0BPZAyhbtlXe4JYbDCLVCMFgYbMp4oNPY0+irfD15ljsLqK/c0CqYB9sqNk?=
 =?us-ascii?Q?iDvEVcyQJ8xAamAPl60qX605uahIKTT9aUjUpJH3YzrM7INVubCOutiU7+B4?=
 =?us-ascii?Q?nBBZNM4NUwYGJtQ2g/ngaXb1DL/XuWldSIoX9vbu2lUv+Cr5hSS4ytNeNC50?=
 =?us-ascii?Q?2J6OzJOpEUkOC5KE3na55OnVUquYkvKtIJI4XWjaIG/DQBSes8tsPZIkHTq/?=
 =?us-ascii?Q?c6KkCcsHeZ9A3OQvbB0dVLj5SZMFcwOBeVq6uhaiFEb6RB/6QUQBICYBq/gb?=
 =?us-ascii?Q?kfie0B4TmSJC1ObF+1YJ13WjYBqIlp7fgEG0xANwOz1IFjU7WdjQr0lK0njV?=
 =?us-ascii?Q?wt8hiFTtKNZZiZW1j7/q1/JBijq9XBLQoLaBnfvYH/+U2APEPpQVYo6H4lLF?=
 =?us-ascii?Q?T1kdXQSBpfrPSljKZklG/MJKZcQ9jaTIoABRot+CctIL72uGPFnMxEnqZvKD?=
 =?us-ascii?Q?h5pavu0czsGBso/P9gxEM7xE0U3j2aeq9KuBvngnJDSJGA5GORrN9spSUco/?=
 =?us-ascii?Q?QTA+LedMHFlKkZPsUqeo26m7QRqf1NYX65XtVpU00tl5YUaA12oJgdA1xAx5?=
 =?us-ascii?Q?46CKX2Ych4XNJKqXs4xWaAE5nokSPxb0H1AQUG9ORGsYwD80Z4mTU+w66eVI?=
 =?us-ascii?Q?U4pg2Q/AmrfjJRxmvqDsRwVDOhIZ66lDq2Qw7DGKQbG8qZ0zF4kN6Vt2/ifI?=
 =?us-ascii?Q?IvxCZBE3q1RLDO5/UvWiGL6angj5y0HDpTjVeWJLAUyIvBFZ4gygP6athgs0?=
 =?us-ascii?Q?WaRq5Rh5mc0uKwzc+NQEf8sXO4IKCukXxJnWjfIKbmnLnC473L5vnOPDt8As?=
 =?us-ascii?Q?HhcMhQtEMe83daCiUpfDqgn170OUEPpH0PQ0wQ3MadsZf91BUWNf57Z4IJik?=
 =?us-ascii?Q?XwG2mhUXN67YH1mJYpKtXudawj+ftR5jDp6tA6y/j/PRwzUn+AUGpyW5oCp7?=
 =?us-ascii?Q?whtpDs5+wrXuzKvgtdTmdtD330+dIJLHIan+A231zCeQl6mss7EnxBowCSNd?=
 =?us-ascii?Q?2DiRuLG7P73QcLJX+TR9IFkcf4BahDRUVXX3YjRvUvGUQj6xvmzfLCWYpgpU?=
 =?us-ascii?Q?ZmaNbLNU9WRT1qdzoLPBrJR4GmhXV4pSPGukrqiXo9BNo7IMAzl7kplQD40m?=
 =?us-ascii?Q?bGYeCgl88OrjSy7TC4OtmmcYXpq/guICTbsLPydFpT7THsIn0SOUKTOq/dGp?=
 =?us-ascii?Q?z2OWMR6TlPlJt+knmrJDEk4yQEsa7n7a23TOH7KJdq1pKV9gS70ql+Elj/G9?=
 =?us-ascii?Q?iIoQ7Vw/tiL5HBtlYD+6RK6FG+OKhPCCJZaIFkXHSihxZI2NUk8KNcyzKnXI?=
 =?us-ascii?Q?L2lgJiBys2fa+6Y1yZPx5VFtDajvlnl4/vIj2hVGBMKD6o/1wf+9QrlsE7DZ?=
 =?us-ascii?Q?IDIfy8OWn5PGlL1z+shBiUaHpCeL2g51kNqPeF3SW+mNTXG9RzX949y9iih+?=
 =?us-ascii?Q?BUg5wrtP89tpIVmp9ee5EmL+S9DafDeRMNJ24kjvpVbE1rvbi3lD0rl7bQJp?=
 =?us-ascii?Q?u8w7IK3cJ/bXN61QnBdTdFkpxDGmQ3CCqenXCdFNHKGXwfGDk+V3AN5DE1x1?=
 =?us-ascii?Q?rXBF1Ez6+7AeIdHp8BonoMEQLBsGcqCFyMDIfIw5AMfJiXHzWWRIp5N4kuIl?=
 =?us-ascii?Q?UXrk/hJEgDC4IqXBaf3sd7dQLLC6G/h+yCOykMEQkQule59QBlgI1V94RM3n?=
 =?us-ascii?Q?nm3BbQS+FQzCE528+G83GQaievs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_3d1719e0b4b6445ab18a791c8176bb64nutanixcom_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1084d9d9-83b2-4f89-e29d-08dcabb6912b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 07:59:38.7638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9PVOfCDvlFzZn8JbWPNRjbwCaow3qf2pbfxS9konqXgA3611DcdTApuDarV0a4vtXddtLlbKRCxcqgGFHIkvtpMKuZk716xlQfxLg0eYiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7985
X-Proofpoint-GUID: QjZXBBrmBqMzNTJasANPYUxINPDjoVV8
X-Proofpoint-ORIG-GUID: QjZXBBrmBqMzNTJasANPYUxINPDjoVV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_05,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--_000_3d1719e0b4b6445ab18a791c8176bb64nutanixcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Zhao, Igor and Xiaoyao,  I have sent v1 for this https://patchwork.o=
zlabs.org/project/qemu-devel/patch/20240724075226.212882-1-manish.mishra@nu=
tanix.com/.


On 23/07/24 8:33 pm, Igor Mammedov wrote:

!-------------------------------------------------------------------|

  CAUTION: External Email



|-------------------------------------------------------------------!



On Mon, 22 Jul 2024 10:18:59 +0000

"manish.mishra" <manish.mishra@nutanix.com><mailto:manish.mishra@nutanix.co=
m> wrote:



QEMU does not set 0x1f in case VM does not have extended CPU topology

and expects guests to fallback to 0xb. Some versions of windows i.e.

windows 10, 11 does not like this behavior and expects this leaf to be

                 ^^^^^^^^^^^^^

be more clear about

Done now, please let me know if i need to add more details.





populated. This is observed with windows VMs with secure boot, uefi

and HyperV role enabled.



add here exact QME CLI and necessary guest OS details to reproduce the issu=
e.



Done







Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent

to 0xb by default and workaround windows issue. This change adds a

new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in

case extended CPU topology is not present and behave as before otherwise.

---



maybe instead of adding workaround it would be better to enable

1F leaf on CPU models that supposed to have it?

Windows expects it only when we have set max cpuid level greater than or eq=
ual to 0x1f. I mean if it is exposed it should not be all zeros. SapphireRa=
pids CPU definition raised cpuid level to 0x20, so we starting seeing it wi=
th SapphireRapids.





 hw/i386/pc.c          |  1 +

 target/i386/cpu.c     | 71 +++++++++++++++++++++++++++----------------

 target/i386/cpu.h     |  5 +++

 target/i386/kvm/kvm.c |  4 ++-

 4 files changed, 53 insertions(+), 28 deletions(-)



diff --git a/hw/i386/pc.c b/hw/i386/pc.c

index c74931d577..4cab04e443 100644

--- a/hw/i386/pc.c

+++ b/hw/i386/pc.c

@@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] =3D {

     { TYPE_X86_CPU, "guest-phys-bits", "0" },

     { "sev-guest", "legacy-vm-type", "on" },

     { TYPE_X86_CPU, "legacy-multi-node", "on" },

+    { TYPE_X86_CPU, "cpuid-0x1f-enforce", "false" },

 };

 const size_t pc_compat_9_0_len =3D G_N_ELEMENTS(pc_compat_9_0);



diff --git a/target/i386/cpu.c b/target/i386/cpu.c

index 4688d140c2..f89b2ef335 100644

--- a/target/i386/cpu.c

+++ b/target/i386/cpu.c

@@ -416,6 +416,43 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint=
32_t count,

     assert(!(*eax & ~0x1f));

 }



+static void encode_topo_cpuid_b(CPUX86State *env, uint32_t count,

+                                X86CPUTopoInfo *topo_info,

+                                uint32_t threads_per_pkg,

+                                uint32_t *eax, uint32_t *ebx,

+                                uint32_t *ecx, uint32_t *edx)

+{

+    X86CPU *cpu =3D env_archcpu(env);

+

+    if (!cpu->enable_cpuid_0xb) {

+        *eax =3D *ebx =3D *ecx =3D *edx =3D 0;

+        return;

+    }

+

+    *ecx =3D count & 0xff;

+    *edx =3D cpu->apic_id;

+

+    switch (count) {

+        case 0:

+            *eax =3D apicid_core_offset(topo_info);

+            *ebx =3D topo_info->threads_per_core;

+            *ecx |=3D CPUID_B_ECX_TOPO_LEVEL_SMT << 8;

+            break;

+        case 1:

+            *eax =3D apicid_pkg_offset(topo_info);

+            *ebx =3D threads_per_pkg;

+            *ecx |=3D CPUID_B_ECX_TOPO_LEVEL_CORE << 8;

+            break;

+        default:

+            *eax =3D 0;

+            *ebx =3D 0;

+            *ecx |=3D CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;

+    }

+

+    assert(!(*eax & ~0x1f));

+    *ebx &=3D 0xffff; /* The count doesn't need to be reliable. */

+}

+

 /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */

 static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)

 {

@@ -6601,33 +6638,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
 uint32_t count,

         break;

     case 0xB:

         /* Extended Topology Enumeration Leaf */

-        if (!cpu->enable_cpuid_0xb) {

-                *eax =3D *ebx =3D *ecx =3D *edx =3D 0;

-                break;

-        }

-

-        *ecx =3D count & 0xff;

-        *edx =3D cpu->apic_id;

-

-        switch (count) {

-        case 0:

-            *eax =3D apicid_core_offset(&topo_info);

-            *ebx =3D topo_info.threads_per_core;

-            *ecx |=3D CPUID_B_ECX_TOPO_LEVEL_SMT << 8;

-            break;

-        case 1:

-            *eax =3D apicid_pkg_offset(&topo_info);

-            *ebx =3D threads_per_pkg;

-            *ecx |=3D CPUID_B_ECX_TOPO_LEVEL_CORE << 8;

-            break;

-        default:

-            *eax =3D 0;

-            *ebx =3D 0;

-            *ecx |=3D CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;

-        }

-

-        assert(!(*eax & ~0x1f));

-        *ebx &=3D 0xffff; /* The count doesn't need to be reliable. */

+        encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,

+                            eax, ebx, ecx, edx);

         break;

     case 0x1C:

         if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_ED=
X_ARCH_LBR)) {

@@ -6639,6 +6651,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
 uint32_t count,

         /* V2 Extended Topology Enumeration Leaf */

         if (!x86_has_extended_topo(env->avail_cpu_topo)) {

             *eax =3D *ebx =3D *ecx =3D *edx =3D 0;

+            if (cpu->enable_cpuid_0x1f_enforce) {

+                encode_topo_cpuid_b(env, count, &topo_info, threads_per_pk=
g,

+                                    eax, ebx, ecx, edx);

+            }

             break;

         }



@@ -8316,6 +8332,7 @@ static Property x86_cpu_properties[] =3D {

     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_leve=
l, true),

     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),

     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),

+    DEFINE_PROP_BOOL("cpuid-0x1f-enforce", X86CPU, enable_cpuid_0x1f_enfor=
ce, true),

     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, tru=
e),

     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_fe=
atures_only, true),

     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),

diff --git a/target/i386/cpu.h b/target/i386/cpu.h

index 1e121acef5..718b9f2b0b 100644

--- a/target/i386/cpu.h

+++ b/target/i386/cpu.h

@@ -2102,6 +2102,11 @@ struct ArchCPU {

     /* Compatibility bits for old machine types: */

     bool enable_cpuid_0xb;



+    /* Always return values for 0x1f leaf. In cases where extended CPU top=
ology

+     * is not supported, return values equivalent of leaf 0xb.

+     */

+    bool enable_cpuid_0x1f_enforce;

+

     /* Enable auto level-increase for all CPUID leaves */

     bool full_cpuid_auto_level;



diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c

index becca2efa5..a9c6f02900 100644

--- a/target/i386/kvm/kvm.c

+++ b/target/i386/kvm/kvm.c

@@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,

     uint32_t limit, i, j;

     uint32_t unused;

     struct kvm_cpuid_entry2 *c;

+    X86CPU *cpu =3D env_archcpu(env);



     cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);



@@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,

             break;

         }

         case 0x1f:

-            if (!x86_has_extended_topo(env->avail_cpu_topo)) {

+            if (!x86_has_extended_topo(env->avail_cpu_topo) &&

+                !cpu->enable_cpuid_0x1f_enforce) {

                 cpuid_i--;

                 break;

             }



--_000_3d1719e0b4b6445ab18a791c8176bb64nutanixcom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <56ABBD147BBBBC4F99D3420F96438E63@nutanixinc.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p>Thanks <span style=3D"font-family:&quot;Aptos&quot;,sans-serif;color:#21=
2121">Zhao</span>, Igor and&nbsp;<span style=3D"font-family:&quot;Aptos&quo=
t;,sans-serif;color:#212121">Xiaoyao,&nbsp;</span> I have sent v1 for this
<a href=3D"https://patchwork.ozlabs.org/project/qemu-devel/patch/2024072407=
5226.212882-1-manish.mishra@nutanix.com/">
https://patchwork.ozlabs.org/project/qemu-devel/patch/20240724075226.212882=
-1-manish.mishra@nutanix.com/</a>.</p>
<p><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On 23/07/24 8:33 pm, Igor Mammedov wrote:<o:p></o:p>=
</p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>!-------------------------------------------------------------------|<=
/pre>
<pre>&nbsp; CAUTION: External Email</pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>|-------------------------------------------------------------------!<=
/pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>On Mon, 22 Jul 2024 10:18:59 +0000</pre>
<pre>&quot;manish.mishra&quot; <a href=3D"mailto:manish.mishra@nutanix.com"=
>&lt;manish.mishra@nutanix.com&gt;</a> wrote:</pre>
<pre><o:p>&nbsp;</o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>QEMU does not set 0x1f in case VM does not have extended CPU topology<=
/pre>
<pre>and expects guests to fallback to 0xb. Some versions of windows i.e.</=
pre>
<pre>windows 10, 11 does not like this behavior and expects this leaf to be=
</pre>
</blockquote>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^&nbsp; </pre>
<pre>be more clear about</pre>
</blockquote>
<p>Done now, please let me know if i need to add more details.<o:p></o:p></=
p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>populated. This is observed with windows VMs with secure boot, uefi</p=
re>
<pre>and HyperV role enabled.</pre>
</blockquote>
<pre><o:p>&nbsp;</o:p></pre>
<pre>add here exact QME CLI and necessary guest OS details to reproduce the=
 issue.</pre>
</blockquote>
<p><o:p>&nbsp;</o:p></p>
<p>Done<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre> <o:p></o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent=
</pre>
<pre>to 0xb by default and workaround windows issue. This change adds a</pr=
e>
<pre>new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb i=
n</pre>
<pre>case extended CPU topology is not present and behave as before otherwi=
se.</pre>
<pre>---</pre>
</blockquote>
<pre><o:p>&nbsp;</o:p></pre>
<pre>maybe instead of adding workaround it would be better to enable</pre>
<pre>1F leaf on CPU models that supposed to have it?</pre>
</blockquote>
<p>Windows expects it only when we have set max cpuid level greater than or=
 equal to 0x1f. I mean if it is exposed it should not be all zeros. Sapphir=
eRapids CPU definition raised cpuid level to 0x20, so we starting seeing it=
 with SapphireRapids.<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre> hw/i386/pc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 1 +</pre>
<pre> target/i386/cpu.c&nbsp;&nbsp;&nbsp;&nbsp; | 71 ++++++++++++++++++++++=
+++++----------------</pre>
<pre> target/i386/cpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +++</pre>
<pre> target/i386/kvm/kvm.c |&nbsp; 4 ++-</pre>
<pre> 4 files changed, 53 insertions(+), 28 deletions(-)</pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>diff --git a/hw/i386/pc.c b/hw/i386/pc.c</pre>
<pre>index c74931d577..4cab04e443 100644</pre>
<pre>--- a/hw/i386/pc.c</pre>
<pre>+++ b/hw/i386/pc.c</pre>
<pre>@@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] =3D {</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; { TYPE_X86_CPU, &quot;guest-phys-bits&quot;, =
&quot;0&quot; },</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; { &quot;sev-guest&quot;, &quot;legacy-vm-type=
&quot;, &quot;on&quot; },</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; { TYPE_X86_CPU, &quot;legacy-multi-node&quot;=
, &quot;on&quot; },</pre>
<pre>+&nbsp;&nbsp;&nbsp; { TYPE_X86_CPU, &quot;cpuid-0x1f-enforce&quot;, &q=
uot;false&quot; },</pre>
<pre> };</pre>
<pre> const size_t pc_compat_9_0_len =3D G_N_ELEMENTS(pc_compat_9_0);</pre>
<pre> </pre>
<pre>diff --git a/target/i386/cpu.c b/target/i386/cpu.c</pre>
<pre>index 4688d140c2..f89b2ef335 100644</pre>
<pre>--- a/target/i386/cpu.c</pre>
<pre>+++ b/target/i386/cpu.c</pre>
<pre>@@ -416,6 +416,43 @@ static void encode_topo_cpuid1f(CPUX86State *env,=
 uint32_t count,</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; assert(!(*eax &amp; ~0x1f));</pre>
<pre> }</pre>
<pre> </pre>
<pre>+static void encode_topo_cpuid_b(CPUX86State *env, uint32_t count,</pr=
e>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; X86CPUTopoInfo *topo_info,</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t threads_per_pkg,</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *eax, uint32_t *ebx,</p=
re>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *ecx, uint32_t *edx)</p=
re>
<pre>+{</pre>
<pre>+&nbsp;&nbsp;&nbsp; X86CPU *cpu =3D env_archcpu(env);</pre>
<pre>+</pre>
<pre>+&nbsp;&nbsp;&nbsp; if (!cpu-&gt;enable_cpuid_0xb) {</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *eax =3D *ebx =3D *ecx =3D=
 *edx =3D 0;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;</pre>
<pre>+&nbsp;&nbsp;&nbsp; }</pre>
<pre>+</pre>
<pre>+&nbsp;&nbsp;&nbsp; *ecx =3D count &amp; 0xff;</pre>
<pre>+&nbsp;&nbsp;&nbsp; *edx =3D cpu-&gt;apic_id;</pre>
<pre>+</pre>
<pre>+&nbsp;&nbsp;&nbsp; switch (count) {</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
ax =3D apicid_core_offset(topo_info);</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
bx =3D topo_info-&gt;threads_per_core;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
cx |=3D CPUID_B_ECX_TOPO_LEVEL_SMT &lt;&lt; 8;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
ax =3D apicid_pkg_offset(topo_info);</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
bx =3D threads_per_pkg;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
cx |=3D CPUID_B_ECX_TOPO_LEVEL_CORE &lt;&lt; 8;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
ax =3D 0;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
bx =3D 0;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
cx |=3D CPUID_B_ECX_TOPO_LEVEL_INVALID &lt;&lt; 8;</pre>
<pre>+&nbsp;&nbsp;&nbsp; }</pre>
<pre>+</pre>
<pre>+&nbsp;&nbsp;&nbsp; assert(!(*eax &amp; ~0x1f));</pre>
<pre>+&nbsp;&nbsp;&nbsp; *ebx &amp;=3D 0xffff; /* The count doesn't need to=
 be reliable. */</pre>
<pre>+}</pre>
<pre>+</pre>
<pre> /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].E=
DX */</pre>
<pre> static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)</pre>
<pre> {</pre>
<pre>@@ -6601,33 +6638,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t i=
ndex, uint32_t count,</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; case 0xB:</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Extended Topology =
Enumeration Leaf */</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cpu-&gt;enable_cpuid_=
0xb) {</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *eax =3D *ebx =3D *ecx =3D *edx =3D 0;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</pre>
<pre>-</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ecx =3D count &amp; 0xff;=
</pre>
<pre>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*edx =3D cpu-&gt;apic_id;<=
/pre>
<pre>-</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (count) {</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
ax =3D apicid_core_offset(&amp;topo_info);</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
bx =3D topo_info.threads_per_core;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
cx |=3D CPUID_B_ECX_TOPO_LEVEL_SMT &lt;&lt; 8;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
ax =3D apicid_pkg_offset(&amp;topo_info);</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
bx =3D threads_per_pkg;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
cx |=3D CPUID_B_ECX_TOPO_LEVEL_CORE &lt;&lt; 8;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
ax =3D 0;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
bx =3D 0;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
cx |=3D CPUID_B_ECX_TOPO_LEVEL_INVALID &lt;&lt; 8;</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</pre>
<pre>-</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; assert(!(*eax &amp; ~0x1f)=
);</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ebx &amp;=3D 0xffff; /* T=
he count doesn't need to be reliable. */</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encode_topo_cpuid_b(env, c=
ount, &amp;topo_info, threads_per_pkg,</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; eax, ebx, ecx, edx);</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; case 0x1C:</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu-&gt;enable_pm=
u &amp;&amp; (env-&gt;features[FEAT_7_0_EDX] &amp; CPUID_7_0_EDX_ARCH_LBR))=
 {</pre>
<pre>@@ -6639,6 +6651,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t i=
ndex, uint32_t count,</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* V2 Extended Topolo=
gy Enumeration Leaf */</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!x86_has_extended=
_topo(env-&gt;avail_cpu_topo)) {</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; *eax =3D *ebx =3D *ecx =3D *edx =3D 0;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (cpu-&gt;enable_cpuid_0x1f_enforce) {</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; encode_topo_cpuid_b(env, count, &amp;topo_info, threa=
ds_per_pkg,</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eax, ebx=
, ecx, edx);</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; break;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</pre>
<pre> </pre>
<pre>@@ -8316,6 +8332,7 @@ static Property x86_cpu_properties[] =3D {</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;full-cpuid-auto-level&=
quot;, X86CPU, full_cpuid_auto_level, true),</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_STRING(&quot;hv-vendor-id&quot;, =
X86CPU, hyperv_vendor),</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;cpuid-0xb&quot;, X86CP=
U, enable_cpuid_0xb, true),</pre>
<pre>+&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;cpuid-0x1f-enforce&quot;, X=
86CPU, enable_cpuid_0x1f_enforce, true),</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-vendor-cpuid-only&qu=
ot;, X86CPU, vendor_cpuid_only, true),</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-amd-topoext-features=
-only&quot;, X86CPU, amd_topoext_features_only, true),</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;lmce&quot;, X86CPU, en=
able_lmce, false),</pre>
<pre>diff --git a/target/i386/cpu.h b/target/i386/cpu.h</pre>
<pre>index 1e121acef5..718b9f2b0b 100644</pre>
<pre>--- a/target/i386/cpu.h</pre>
<pre>+++ b/target/i386/cpu.h</pre>
<pre>@@ -2102,6 +2102,11 @@ struct ArchCPU {</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; /* Compatibility bits for old machine types: =
*/</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; bool enable_cpuid_0xb;</pre>
<pre> </pre>
<pre>+&nbsp;&nbsp;&nbsp; /* Always return values for 0x1f leaf. In cases wh=
ere extended CPU topology</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp; * is not supported, return values equivalent=
 of leaf 0xb.</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp; */</pre>
<pre>+&nbsp;&nbsp;&nbsp; bool enable_cpuid_0x1f_enforce;</pre>
<pre>+</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; /* Enable auto level-increase for all CPUID l=
eaves */</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; bool full_cpuid_auto_level;</pre>
<pre> </pre>
<pre>diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c</pre>
<pre>index becca2efa5..a9c6f02900 100644</pre>
<pre>--- a/target/i386/kvm/kvm.c</pre>
<pre>+++ b/target/i386/kvm/kvm.c</pre>
<pre>@@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State =
*env,</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit, i, j;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; uint32_t unused;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; struct kvm_cpuid_entry2 *c;</pre>
<pre>+&nbsp;&nbsp;&nbsp; X86CPU *cpu =3D env_archcpu(env);</pre>
<pre> </pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_x86_cpuid(env, 0, 0, &amp;limit, &am=
p;unused, &amp;unused, &amp;unused);</pre>
<pre> </pre>
<pre>@@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State =
*env,</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; break;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x1f:</pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (!x86_has_extended_topo(env-&gt;avail_cpu_topo)) {</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (!x86_has_extended_topo(env-&gt;avail_cpu_topo) &amp;&amp;</pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; !cpu-&gt;enable_cpuid_0x1f_enforce) {</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; cpuid_i--;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; break;</pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; }</pre>
</blockquote>
<pre><o:p>&nbsp;</o:p></pre>
</blockquote>
</div>
</body>
</html>

--_000_3d1719e0b4b6445ab18a791c8176bb64nutanixcom_--

