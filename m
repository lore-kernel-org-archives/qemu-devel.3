Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6741CE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdW-0006UD-HN; Wed, 08 Jan 2025 06:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd5-0006PJ-QY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd1-0002Cu-0U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:41 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885pFD021537;
 Wed, 8 Jan 2025 03:53:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VjJ0dCrJYirjmalQEGQcRMGK6EsRN+AhL+QDUW+TQ
 uM=; b=lf763ODwv0u5Jv7zvp1KKgEkqNWA8+zCzWxLhFTx6benHV9s67U/JuzyU
 ltSAbbugjk8d9jM9Ju7SV22FGEy64OkPMkGP+mAyfsOWsaGjbihdEFnjvpat+5qd
 DHbQoZoL2Ms9rLsBboPYe1IsOUR7uFOv+TQ+YW4V+u788B7ELV6HOfRAEgx6913C
 U24XSeRVztlDsBTCwg4zlg9+7HUwefdRgZbFgpaDRrx3Cd+6Ridq3BMmtkmqSxfb
 oRVjQl9PCp/nJOzw/9Lq0nywuzjM0NDcX9PnWHI0M72Yl1Ug5v0bkgTADne5w/Di
 FAQd1ZxLNaJpQuZA1g7JXvpvfJuQg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y5d3rs7x-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4MuRzLe95FcJKRGiDAEhtvkQMvy9I+oOJpnoOEw1r6TsQ9+WuhAYuIpH8KjYehFMxPzka5Y0R8A5Yymqe7L7eYLtpfE03GpwiLkwtBZEArNJFjcqBU+ZIwXFA0BTjUrhIp8rjZNbp09fR5cibvlCT0s3RxnfuzNXAZ3MfwLYXU7gZE285qR1rl7I20+uyxAsXmoPpj+7/fpg0Nb+a4wOVzSQpi2NXwJQqlLKTq+UkRloG0Uyk1FB3IzXPR/x9frY8CnZw9u+l5oynvOfdIIpr5Um8NQds38OL/RbIuwWPKrSoUeuJZros4+njL4s4qVcedSsnIjOUyZvggHQPsdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjJ0dCrJYirjmalQEGQcRMGK6EsRN+AhL+QDUW+TQuM=;
 b=U5vywAfFAJDqTuWGDWcWGX8qe7I/3UkiY3RdArEBKaqNOAqdUiTb6gcEIMZp1q/1AzMRIs/9Bt57I4rWShDOq7WvhzMpynMlwC0GV679XCMbJ3MxML7POJYCsmBQPcHnnM3/BX3IVCXKCDS3x6/dPY9/cduFuY2U9qmrpkFonesBVo6EqPRUduGFw5aJCixqu9ptw4AbO34LNFXwK6lzxEjUVgMh2JTljXdfTuGGAwwcPcfDWK9N8GS2Zk57gwUNC78aAWXlcKeEvYY5Uw7CSTO6by/yHjaLbChIwRPozoNpP5pyutvmUMpiRGwimeBJGkF/yG1/cvDfeKdPENl+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjJ0dCrJYirjmalQEGQcRMGK6EsRN+AhL+QDUW+TQuM=;
 b=T8Xg4TkrnzYPEYCjpsrRHLo/KjyRFvRfHJfKG8PhOvjLdaYCUsi52iOQpnbuHWTGVWGt8w7EWAn9H80Q+p6/CELUUhigrj9lvewZms8u+2vosJZ5cXR6ftHHApN0VAIBEdbsj3r+/pSdkmriQ2k3rSgzIGSZ1LoZYDJOAPeV4PlszSqfez4LhmOyZxkzWkV1bvupu38mygpkIBD8c0i5DLUPxGAPyPG6k2GqQW1nd6ER106bfyhrOgza4PRLPBwpnrBPVzRZlVb+AM6rFBjDX06WJ5lIprF5AWKv1hckqs6o2M2Mq1dwfAtfMl4SzDE4yActXVDieQpt8shbbIZc2A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:32 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 02/26] vfio/container: pass listener_begin/commit callbacks
Date: Wed,  8 Jan 2025 11:50:08 +0000
Message-Id: <20250108115032.1677686-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 846483ed-a004-49c8-ede5-08dd2fdb131b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SJOR9tthzTfP0WEFmYZgNmFMf2RIRpNASo4V4THoxIXqzfptz3QxTluxQol2?=
 =?us-ascii?Q?9cy0tWhgpuuFy3F5JXwT0eo7lgT/U0XnKsiqq1/+xqs64fRBxTmyYco6sNwY?=
 =?us-ascii?Q?or6OHCm5zkWUVxmc3hFCbpinwP51GuNU+PZ72INOR7FnA9OhW72Nn6lFPcWp?=
 =?us-ascii?Q?TqvwvTpFTNVJrlRUS3O0w8/m0WKUXOz2rUi+l+xBN2+vD6xbW4ASxAoRL3EF?=
 =?us-ascii?Q?5Ih6wuwI0Zx7diXHoOWNxwALb6qBYdRAUujzgquKDADo8+fknng6FctvKKEB?=
 =?us-ascii?Q?7Uf17p8F6lYB51DYVRIRP6eosEZb6x2ufcgK5CBuXRQimtyogD6xiFbOFVMQ?=
 =?us-ascii?Q?+gUzGBFQa/55f+sLXS16CeqXWaXklbm/MCelUwx5vQq8KOlLyAwsnTHSXNL7?=
 =?us-ascii?Q?LEV5bCJpM24q+cj/mpOBJU1cJb7jE1Zr2StjtL9/ArXNElGQGO9H7yqjKMCi?=
 =?us-ascii?Q?/UVCjwJii7ln7Jor9jUJllzj6XfQkLuDSdpK0RUCCvEYRCW8pVERp8od0H5o?=
 =?us-ascii?Q?49kRn3M/3wUL/GQRf1Mn0XlTrdShBdllhiQfohcoQ2LtujpkAdXnK+L+zS7w?=
 =?us-ascii?Q?N2kB3u32d5fX+iQJKddBfmrE+xs9NYKQa2sqSUHEdx25M1Ln5jsUogMEQP/M?=
 =?us-ascii?Q?B1zVDp76oyvejpms10sbCqfhYGA9a2h1WMwF0Q5AXT3rgcVaWDr3nA97sQzT?=
 =?us-ascii?Q?/Iys7ssyPAbT0jTYaS9tMSFFpWngqoB10Ywr6gaKVuGjvXQk6MyKvRXVd/RA?=
 =?us-ascii?Q?1ujGw7w6YNNKCu40uen+MtmRGRFFcdL325G3MUQLEYSnb0m0Zm46T05/UP58?=
 =?us-ascii?Q?bCc3SaNN+3x+EdY+dA8h8ajtNm8bP6RJXoTk/tfd+JS5bXTxiCEdzPDgrSPj?=
 =?us-ascii?Q?+eJnSoaEsXQo3VDObvYK9uD73FgoxFyhaOGp5ganCasg9fdGn0tD1t8EdcwC?=
 =?us-ascii?Q?oG1TP5jyORJ3DXdvmbRZmYlajBWBKSl2nSS8HvPwCTJWYetdjPIe8ULKFwcV?=
 =?us-ascii?Q?/SAWiPH1udE0n05XhqB0V+M00uuvx14xXcDUSgFGCZRawCb4V9bqdpTb/jAy?=
 =?us-ascii?Q?5n9kxxqad6+yhTYD1W0K3J/jR7JTuQejQ3WALS8lv7ZwbVNasAvTK6LdoE73?=
 =?us-ascii?Q?/TFrizxBU3EiIVeQWAQVmP9ABMef7UJz3kW3Nt4U/lNr+roA8nSg0ffMKEwN?=
 =?us-ascii?Q?OZ/9m4EQks6YSMqgF7CzkHP5fw8N0EoI3RP/A9Z61N7Ev0FISW8BcEXPPAsx?=
 =?us-ascii?Q?4aLh9jsmsCrlaEKaWt7YZ452BrDNCL/Qgh12V3bnp5c902rHTn/NkyAbtUL7?=
 =?us-ascii?Q?PXDprVtHuclvSDWkTK7cu0Wrk/vF8c5TTmg8MjDacRoBCrN9Pu/+6Bu3RrTY?=
 =?us-ascii?Q?qddVBfYgfNOpm+lhVtaSrNmXXyVA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHa+ObDCzK2WtjNnGnF789fYKaYpfBEhWrbnECx0bS3JZDxTeJG3IrndiqKy?=
 =?us-ascii?Q?/zTUsqy9FpTYj9jQLp/2J+nkxlykQkoV33blaZ/o/IDMJFe/MrqyAzoqjhzL?=
 =?us-ascii?Q?k1E7rEFLfpqlUcwphSO4O5d6S9g78bG+ejjr3uebua6yjg9Rw+22P/EnaAWr?=
 =?us-ascii?Q?zcNj1gx9NPjACGJHqxnmIFGRjAPaeKOrnsDipcS0l/wY2g04s17JA+qgLyWU?=
 =?us-ascii?Q?nsyKtB1ct8cOZ7L9vPm5Che3BH5mQjqvBuyvvOFntJ31KXx7NRBhDP+xn7kY?=
 =?us-ascii?Q?Zp8gTuv9cLugeFxWqJQKSOlFra8wcg+FVZhzt9SxN+Y49yoHQWA+vxUVEjnz?=
 =?us-ascii?Q?murmuolODq2vnLUqG0a1bew3CfEWb0HkptN7uDPXCEYIo9YjGlcwg6OEgScH?=
 =?us-ascii?Q?NMi+8oi6+5mFfdsGdzw9WOH5vDR/G1JyZq/rU9Vi4WGxGq7/jF6htL3LGVYR?=
 =?us-ascii?Q?EsnlPBs3hxiKDFuK67m03bg9mJB3K6yTMUNSHJQwzUhrg6yfFeio3i2v86fc?=
 =?us-ascii?Q?awe5ItQoVC0RpwJR/q6TATv+jllhYCrWfj67ww61r0h2ZoiXxp7+UpRMrN+J?=
 =?us-ascii?Q?PG37Bas2Knae95F9jwBmjB1/ejYxAdWLQ7m2j01iULFLYq8Bi82Uf6uDBQDH?=
 =?us-ascii?Q?d8nlmI6W9fpw10tAN1duaYLSF6j9SS7/4o3OH31eyNVTNpfTXLRl8PZ/AKFi?=
 =?us-ascii?Q?R/Wf4FZ8tk9D8ri5YrQ9hevV4OzCEFQDlfn4mKI4iRl0wgL5PxV5APQ2Jrza?=
 =?us-ascii?Q?JOVBAesjT6KaqYwfoxUZutk4s/KnT6J0hW+ZBW3G4/AyR29Lpoi1J1ju+XO9?=
 =?us-ascii?Q?fzoMuSXgO+zpfhYWkoL4IFZCcCH5jrxFFL2Kmznc3czmrH9hAzQ2cjkKI2t+?=
 =?us-ascii?Q?3PesdF7gwJghAnW0rw3Y3gImhefjGFtPZL2G2GpCNjLeUqT1/QpehOWN9Tqc?=
 =?us-ascii?Q?RqHBBAs/t6VZkmWR225ZApFwoDkFW4thc8E9/fhQV+XYrfQYRXmOdJE44YvM?=
 =?us-ascii?Q?/FqP3ftIxfOwb8plHhNX0iJtnFrkbWxDdBU654VEQL+s9/PdD9NuX5JWos7L?=
 =?us-ascii?Q?MirTfFBGn20JzhwWknXCuc04ULS/SEnDVM1kcZc9vJmEF88+jTjI2rDofRIh?=
 =?us-ascii?Q?iqBtdbzAk7EpO0SNn5jb8j4wL7GFGenFvDLGlwTnIGfk1mrEPx4fLKr0nhTH?=
 =?us-ascii?Q?2kd68BN4BzAFbEyJi1/Qfs0JoQmiZ8gNVgYXICMYhOnG1UQMuJ+ZzIEPT83m?=
 =?us-ascii?Q?nhRASyTSX+JGPgvKBeENW9xsmO2oAjohrut+JAl2/GwX8OaQHZHU/RNQ/hj0?=
 =?us-ascii?Q?jUm98RhfzliJsP8h8u2J/kOn9AIC1AigNPQ2YpOIDtRWpY8rf0HgnKluw7g1?=
 =?us-ascii?Q?lDCQ4QMWfEUmdEG4KRuCx4KyxxYGpw4AZviWjLc44R9aL2lslAmqYxh12ZM9?=
 =?us-ascii?Q?181L0bE/IRdnPpWt1ULsQc7NYg9trJyA988/FI38IATCKcDKymFu/LueUzPg?=
 =?us-ascii?Q?+YIUUZkyRT5RlZsoId6V6UkqBPrcZ9PUgxKgfMCIK5nIP2ZVcR9MU6RV0/dE?=
 =?us-ascii?Q?pRdpM3h6qZ5RGpbre1o4mPooXOBm/CEhGzY05RZd?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846483ed-a004-49c8-ede5-08dd2fdb131b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:32.2548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A8ELSgfoTrQMjzfPLOhyx8UyE3G6Wv1QvKCoDTf7EHSmLhBOcG5xIdLphzAyjB42zhiBaWBXo+o8Ff8hiNalQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-ORIG-GUID: EHQoirHH84x-iLj538zN-LtSAmwkYjBK
X-Proofpoint-GUID: EHQoirHH84x-iLj538zN-LtSAmwkYjBK
X-Authority-Analysis: v=2.4 cv=YLtlyQGx c=1 sm=1 tr=0 ts=677e673f cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=RQZ_2NmkAAAA:8 a=64Cc0HZtAAAA:8 a=vU0vC_IIgwTtBsNJuTcA:9
 a=46pEW5UW3zrkaSsnLxuo:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: John Levon <levon@movementarian.org>

The vfio-user container will later need to hook into these callbacks;
set up vfio to use them, and optionally pass them through to the
container.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c                      | 28 +++++++++++++++++++++++++++
 include/hw/vfio/vfio-container-base.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0e3ea71aae..0cacc66c85 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -557,6 +557,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_listener_begin(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_begin) {
+        listener_begin(bcontainer);
+    }
+}
+
+static void vfio_listener_commit(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_commit) {
+        listener_commit(bcontainer);
+    }
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -1378,6 +1404,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
 
 const MemoryListener vfio_memory_listener = {
     .name = "vfio",
+    .begin = vfio_listener_begin,
+    .commit = vfio_listener_commit,
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
     .log_global_start = vfio_listener_log_global_start,
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index c9d339383e..0a863df0dc 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -111,6 +111,8 @@ struct VFIOIOMMUClass {
 
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly, MemoryRegion *mrp);
-- 
2.34.1


