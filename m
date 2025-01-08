Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAB7E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdR-0006SZ-Fd; Wed, 08 Jan 2025 06:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd7-0006PX-A3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd1-0002D8-1J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:43 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885pFF021537;
 Wed, 8 Jan 2025 03:53:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RPCvoz2CV6dyRw6KqFuv3ix/vqrAXPjRvd4Pq1nuO
 lk=; b=GlxRb8rWfPZsFfoPUhBktN0abGnD1R4AiQusGkrx1aAhJZnNLyKOgTxur
 wbXtfaO4zgkpnpfmLLqrd7ZtQQKY34agne5e40GDc/y87VX80qp99rU9VLNnSTtu
 omF7AIXmHrGgcLaEW5YbmQgwF9AG+sd+HtBYeh2QDYcrJXvd8sk1Juv49rpbqTSh
 vwENZkGNEwvgqzs6FWWyhLihIkClolW74a09rcC9/Xjvf0n3O9GPqrCBChTEiPHK
 PcVS398Wz1Epcz1ibycoNkOYXacCWE6wZfUoRGdh6HYNRlci7axvpAQm5s9xDCHU
 9bXxqtkeipZpedIIoWXVBj/tHGf2g==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y5d3rs7x-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNsqeF17Reyp0PXa2oveo260J2drZHlqZIrM9Je5mXFBVVFIn/PYhG7o3dcfnWuC4T7D3TPvTAGMu9NeHQ2khye9YIj4mqJXiHtZwbLAfCjw/y+HtaM1K5zHI4rGwzi1//V49aOMCVDul+ioAkS3w8+xQkSrh+4KK+e9Lgh7RGH2jd8LYW2z0uN069CRPNPtlMbujAuy5iwp+xZjHLXSSdAMs7nwradMgjouq74e4EWo8GtXknErtiabHm1eGuJnG4Nzrc5UjqZiHN6PPlfdj8kkJMCv7Q+d6916p8P8ubAYLf7WANWfsa3gofS0YaFsMd6NQCa5I0qPCErSnGBHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPCvoz2CV6dyRw6KqFuv3ix/vqrAXPjRvd4Pq1nuOlk=;
 b=dd+riDZSSwhbVLKqzmiSvBTQUoVqHCd9l4nr29L9xkLE5pHs2BRW2C5jMURCsBSavNLvQ4S5sQ9DlqSNhKxp/0fsLfkjL904CJ9fHo4GzokTD2VYdp6HoZcM+wEOTaCliQe2n2JReKG0JPiPYZpDEAE5Wug9cP/2ZqQcFJt5c74GjEz988cSh9cUcvI6E2FtxMls9oPMmveNQ5Q6rdUr1ZfjSk07IblrYr6duCeOC3z1f8RwfITfhVRjLE/NyJPcf7MKhtmuL6zI/Yoo2BXKmpUZaerVyiwdkTl54k27G5xQz64lOSMvc2UbSkUibiadY0de4RbaPszhsPFxu4Lmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPCvoz2CV6dyRw6KqFuv3ix/vqrAXPjRvd4Pq1nuOlk=;
 b=cToGa9raXzjAaE6dxL2x/i1rsG51ItdpLj1le4akXR7sk90kq0QK4QQ+JlGMzDjyRIxL3ehetAA+jwuBN/3ehudxcMTrgNtl5RoDwUKgB2yMl3uXopuHTxMmoNCUqP9c0RsoUevff5aPNhmne1IibJKsqu+qSl3Vvbepc2F0xNGc0+7ovtTwh/OJ5R5roDTo9LDW/+os54hAnevAJ8XICVBtK7k4EMV7Z7IL3HUReTdlI77O5K7SHR5F02ZjxYSNqiMnYUv4GhzH16FhIYdeqxcYpQSmnzJ91H7WPIhNH3IGTRbPI+nttIh3A/MY592RkkNebR4nsag3Vny+CrwSxg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:34 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:34 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 04/26] vfio: add vfio_attach_device_by_iommu_type()
Date: Wed,  8 Jan 2025 11:50:10 +0000
Message-Id: <20250108115032.1677686-5-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2dc88127-24e0-4753-2f18-08dd2fdb149f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7kl+ylLcVg1Qto3U/dmtnPJy6YfzFRrcKNdtkc/a3USLw3+bOgzmagg7Ejv?=
 =?us-ascii?Q?8vxWRdlQGJfzXQ3FOEUhldRcd75Un/vB/r0ZoEyeI3wLSjM4cXDL1oqpXGa8?=
 =?us-ascii?Q?9PkudO494t1ly9+VF7F+8mk/g4gcIfDa+EfuZSNDxXXzJ0ysjHuXKzMOMMEB?=
 =?us-ascii?Q?RURNOTHVPRHHo8YHrOoAlGj2NZ8ocNp1esStcN2TuvhrG/cSiSyyr7BGlma9?=
 =?us-ascii?Q?lIqtvhn+ZeclUI1Def5/sgW2n/MBbmCqMqL/8pQMXogR7QKdPyU/WhiZGgVC?=
 =?us-ascii?Q?wmp/XAQeSmFc+O8tVw/8bupvV1/zJW6ThUTndx3dzxt7sRTUBsM8ngXyXB5m?=
 =?us-ascii?Q?esCenAPYJMhXsPFaGdOt27Q0kbuo5gdb25nkh72dQ1rjC5wGzLFG2dulckhu?=
 =?us-ascii?Q?dZ9klfyGpRmXKj2qcLxyHmyrAysYRIvxYAqzrIbVl07SLeT6V3OCk3LwqF2h?=
 =?us-ascii?Q?L8sTqVblkeA3+fOTpIvLAy9RaD48JR9DlYtvnT3qMkXKfeacpyUhGFDIfjs2?=
 =?us-ascii?Q?+1ooJ6INIw5/d2xKgs2vf1uQ/LkVJGc1l/GtMy+5SEFIBcDEH/L5ePT6JNQP?=
 =?us-ascii?Q?O14yRjmp8T6MH19rdQQH8eyEsK4J43IIDjlQuWY0Zc5vI82Vbw26QQynJcYJ?=
 =?us-ascii?Q?cEwetjKP5qlwPMvzY3QSxZY8J2gEDRCA5aug0oYMYIqp1omX0vmNHoeAwRUR?=
 =?us-ascii?Q?ANnUOrjtkQb8O1N+8viT6TwORG47dnLROS7B1xNxzRuVi6krX/i4DH3SYd89?=
 =?us-ascii?Q?dQDYZ0vQf/rcC5D6noBBPRlX66AD3dymovK1HwD8XulWli592JYou4fkH/z4?=
 =?us-ascii?Q?m5LPaRuncIt4qGVBNu+AsfknUFRlLn5QROu92FBCFIBM1AQq/W1J7ah1O12v?=
 =?us-ascii?Q?BpnF85CHRFGEfMHdx7gHnC9ZdteqNAzpOxI7dKYND4TzNrGKB4jiByo4GpGY?=
 =?us-ascii?Q?C/uBao4kkod72o57wNWhMSJHvb/9anW1b2rNLsuJ9+PYTrxnDrFWwVpT6G8t?=
 =?us-ascii?Q?CV2kvJYFf52toJZMYA9sCC2wt34k502TpgaWOAKmfYqTdogda49KjUpRynPK?=
 =?us-ascii?Q?B5KPuKljnbo6nY8CHnpc9BnKe8ShPcqEmKSt2HTcHMX+CAttCX3DyytPKrot?=
 =?us-ascii?Q?NpiAPc0eODfoH+Mmpd4v3NZ5Ssd4y6+fqS+tZ8sD4d7joNlWTnctnf7CBrTS?=
 =?us-ascii?Q?h67ny31dx5/YbbRTg3rjoGMffgbS0rdMh/m1/ZfRwT6DYs5oo8eAQWUcIpNe?=
 =?us-ascii?Q?007MQC13X+AI2s+7iSapJ1UV0fzdD4nW7BkpO7h08UGLt9UB/QO6MLfHrfVj?=
 =?us-ascii?Q?4IWXoorC7k+96GCBIoCmnbTrGyvA5FXZ1HCHs0fngXkZv6S3/NMC4EU+DwHk?=
 =?us-ascii?Q?4vjzUQTR095/ry1fzPKFgcFuxbfc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zi5ALBZst5GoyJImOLKPD3QRMtfJcaXx5O9wDNAZwJQ5DIN6ylKL6f6W1Drj?=
 =?us-ascii?Q?9TiURCuVsS9K4eKFNRnd18EFEVqm4xLEFshuA84vkneFz41zsfV0faEqYuui?=
 =?us-ascii?Q?yUlsxKb9k4jdbFyZXienvN2BK9BdggHiemJ2VRUENQ5rHX1J+P4dV1LTUo1X?=
 =?us-ascii?Q?N/WNgs+72LA58rSDvk4CuuU+TZ2KXdtyjrOSHWtTF5dTlW4fU7RrtwuC/xR8?=
 =?us-ascii?Q?7jxGQ/c2d0hz4xRySO2/4kXJprPc8G8I/tX1fI1RI8EN7Rvct5hmljsAzHYN?=
 =?us-ascii?Q?z9v4tg8XTeDfa2Ls6Ai3SXYMUByT2h5B0eaNb+UFCyOXbhWNyLH4c49Jo3k+?=
 =?us-ascii?Q?QaUvRPlqHKBuk5h5VBCUGRZtYZTNkEC+npvm4eeu7LMuv28UoevBWjs85MPj?=
 =?us-ascii?Q?rxkPrfbsxoqismAyAVCtTP1nvH/PtzFGCnuKJmzQpG5GsU1D6Z624lNALhrT?=
 =?us-ascii?Q?VhQjSryeBOkIw2AHrrVGYJmSNiVen48iPDEF/6HN5z8FBdRAdA72+KUF2P0f?=
 =?us-ascii?Q?5kzjXWBA31fJJa2/W0zj6yLMXFpkgrK+AwSaG2oo9HhFEqc70iPn18XNEykG?=
 =?us-ascii?Q?sJATANL9Be6ChafMCkF/i21SuhoYtfrGFGn2UT59cdHke5VCITewX9beunaH?=
 =?us-ascii?Q?pqZFjpUl+k5wJMSjYSpiXGKeHOak01POhiFoQTAZAwe9Iae9knJ0uKySpV2/?=
 =?us-ascii?Q?Hd4fgasvUIdlnfWLe/l9+Dyc5kJSaasgkuLqAnoV/2AH+geU7i1+s3/mSP0E?=
 =?us-ascii?Q?GlFVQnwpgXP1Wsz2Tqlj4jphFS5Msoq2WasWTwmi0cddmtE5uTO6aRIZGqML?=
 =?us-ascii?Q?pDVjl7kLiKtl4itquPNAJGatGej6zU700qKEIw0yVhlyNnfLQoIL9Go2GIzP?=
 =?us-ascii?Q?0sO9UzJTVYd6LKm1d1kbRREYtdqqPfL23u5yz8KlTYbwLnT2GQLqBtPgZzoj?=
 =?us-ascii?Q?WYazEduZCcQuoLDU2yMq/s1umKHfO2akZCCQiBRIcEKaScvS5m0m3diBcNQu?=
 =?us-ascii?Q?4aXK6sTEGZrYCGX/WHI4JjSjSSAHMm2MNo8VpzQupy4bs/sZGbHDYzpRG4/9?=
 =?us-ascii?Q?MLDixVtvDhDz5aHdmPlWg8W6TPPpNVkQT0MqLVJodJdbqHf5DfU9KfKAM6+e?=
 =?us-ascii?Q?D9idPeGcxW+VFlBW5Edi1TK0Mi082uNmRei9eB4fZiqfqeyq+E/Slw1Q/ph+?=
 =?us-ascii?Q?KALpiei7HZmKEML0JQJh7BJlSxcJYQQeK9qjqQbjfj1wodY4iaZxLItq6CEZ?=
 =?us-ascii?Q?uJICSz/JyN05gaxb3FaUr+yysZwvBBLV7+LxdYxn1SnDQlTZ7mMThiwPFtPv?=
 =?us-ascii?Q?uk06z+xtLnp2SSHluJHZlUfm2wM4ycagH2k6Gsh1eoXQ+RQOpjWLxokAIZ+B?=
 =?us-ascii?Q?Jezdtd7ywPCrqO3tcRKUCfH8CwSoTsHkWzhGBbp2P2kAm1/W2cSuai7IT61s?=
 =?us-ascii?Q?Z3XlofUUgEUKs1LYYPDtm6BgqcjJp2V/QwCE8RixInDI4IdjTD4LQX8Gffjg?=
 =?us-ascii?Q?5rqed9+RaImgbe0qDT7ClKgMM8onHJvJyLtHr2AZTHL7Vd75Tb2sgsHTk+Af?=
 =?us-ascii?Q?gGrfIHi3tJowrD8MyAWr2jY/4jwFTvKDw5NWEoyX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc88127-24e0-4753-2f18-08dd2fdb149f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:34.7836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nO4JcKKaHmEYDk6fYGwatsVkHFFSS49yjC8GNIZghWami2OG9cAe7CABlPTxGpllLaZeCq3Oe0ZRV5bI6luqww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-ORIG-GUID: RijwkoEPdH14qB9o1zfgSuqCaC7Wqp5b
X-Proofpoint-GUID: RijwkoEPdH14qB9o1zfgSuqCaC7Wqp5b
X-Authority-Analysis: v=2.4 cv=YLtlyQGx c=1 sm=1 tr=0 ts=677e6740 cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=1ktPcj0v_YJIm58XXvYA:9 a=14NRyaPF5x3gF6G45PvQ:22
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

Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
vfio-user will use this later.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c              | 30 +++++++++++++++++++-----------
 include/hw/vfio/vfio-common.h |  3 +++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 49e3543c89..cb299fc3bf 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1551,25 +1551,20 @@ retry:
     return info;
 }
 
-bool vfio_attach_device(char *name, VFIODevice *vbasedev,
-                        AddressSpace *as, Error **errp)
+bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp)
 {
-    const VFIOIOMMUClass *ops =
-        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
     HostIOMMUDevice *hiod = NULL;
-
-    if (vbasedev->iommufd) {
-        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
-    }
-
-    assert(ops);
-
+    const VFIOIOMMUClass *ops =
+        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));
 
     if (!vbasedev->mdev) {
         hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
         vbasedev->hiod = hiod;
     }
 
+
     if (!ops->attach_device(name, vbasedev, as, errp)) {
         object_unref(hiod);
         vbasedev->hiod = NULL;
@@ -1579,6 +1574,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
     return true;
 }
 
+bool vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp)
+{
+    const char *iommu_type = TYPE_VFIO_IOMMU_LEGACY;
+
+    if (vbasedev->iommufd) {
+        iommu_type = TYPE_VFIO_IOMMU_IOMMUFD;
+    }
+
+    return vfio_attach_device_by_iommu_type(iommu_type, name, vbasedev,
+                                            as, errp);
+}
+
 void vfio_detach_device(VFIODevice *vbasedev)
 {
     if (!vbasedev->bcontainer) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 13c67d25cb..387854cb0b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -252,6 +252,9 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
+bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
-- 
2.34.1


