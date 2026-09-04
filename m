Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B92C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2OJ7-0002Qo-Gz; Fri, 04 Sep 2026 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x2OJ5-0002Pg-GU; Fri, 04 Sep 2026 03:25:51 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x2OJ3-0007gM-LI; Fri, 04 Sep 2026 03:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA8vbaAwDY5WFxrkYLa0bU7JtrX79X28ZUEIbXh4FVBJlY2cAphKO/olnI4ZMrS8GQdrjdjhrmXCoJQjEzYA30sjQ4CQN2vpz8CLAoP6vP47Kkab3U2r3P7B/mIk7WUiQ4XRS7bfNF9UFeq3BeKYy9IOWlAaxE0coeKGkOfse1puNRBlkzeNfi/e/N3wcXsleeU77UARwoG7wgynnlCXDCBZC+akiaLmDD3S+jDLjyLcZZ38BXuw8CZxW4aANBtKFZGzyyf1x1UEo9/MlYrhW85jZMpHUFETKvTMUuhJakOTbo/qMUkTtZrYAg/8VQTJ+iMuwiUcl1AgMkbEg0aQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su7tTibnRj9AvKzB3b5AXQMkrnA8R7XJS2ocbbcNwcc=;
 b=pFuI1MirXTNlSbqT93ktPEd0QMUjQSQdXxF16zuCZ0PqkMZfVdntH50FbSSDOhtajfsAAeJFrf3063L102H8tNblAxKO8Gcy04I6G7PK2EI/5sAQdEr+6jcy/3Ki1wutLkMa+dCKAI8ZnPSOZ6TGZuZ2shY9WWmhvq/TU9psuD//9ka+d6Mj15kSJlfXRwWzMowFzGuT4qorHxxfbGZoWEdCioNd6A9UlMimKKIG3+ht5+e6tXcJvFQQxf7UHtGF3zx341ZeUDNk9JEJtUz/UNT2adZOIX5Dp5Mf8o5bxVuhcVZ202khTAP5XalBtcG43PIg5kGPsx3RcAb7GC+wRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su7tTibnRj9AvKzB3b5AXQMkrnA8R7XJS2ocbbcNwcc=;
 b=HvIZV4N4wVE1CHT8ZNaB+PGjZ1KPNYcQZKOqJgqBQhU/2bWexaa7Hfjsr+NBKE1rfoRbmXfLFl2oJ0zOm4gUN+oRQ+lofhbtsa9kJnR08jk5GTaDAJ3rC31/z90YFSLXfsze61o0RBXoF+w189Q1UKtMfcv8d9Hb0DLte+JqaIf0v4Wv9bHta08xh39/d+BuR9eAPoc5mejBmURKMBQFyE+MKwB9ZZc3AZgW+0Ruk+PFsL+DmXXeoEfdaFAump8MYlTBoRTN75MVlaJFYUTpVY2mNv78LiCSD9xUclBnCPSgTr3mCxhigj/w+hCmqlQcUpo8NBKaLjgP9KjbeSkmWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB6137.apcprd02.prod.outlook.com (2603:1096:400:286::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:25:40 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:25:38 +0000
Date: Fri, 4 Sep 2026 15:25:33 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v9 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Message-ID: <appyYhaGVRtLrWAS@ChaodeMacBook-Pro.local>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
 <20260903183125.682865-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903183125.682865-2-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH0PR07CA0111.namprd07.prod.outlook.com
 (2603:10b6:510:4::26) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bce1b9-e427-437d-2212-08df0a55b811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|5023799004|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: Zeu+lgZgUm+s/d4gmSMCas0jmLylt+MSaYMOoDCz99SQWm9e0irn5N8OIlnMp0W9zN2E2uLfZrQ161GpMPRAxQ+U1wNLAdPsbRAt4zWUYlYqMgWLa+MXc9t4pVtxCDHkhp7kLN2pfOtdZTB5qRyCvt/NcoQL6DIPdAWFUqptv+neeAnLl/PZARN21Hl8kMNYZ1gThAi8XAs/m27y9yyoBII/43fhhqa1HVZHuxoQPtfa4FcWmKgfIn1of+gGF2Uz/iyQN9W38oyoeKTZTxKq2p32Vyoj4cmr5JwH6sKQAJ4r539xOVhhW7vxzwQaRBqjDsW9NIHH4Jpx1mMQ4V3U+K4BXa3XQ9W+mV6iQ75LPrta8A5jj5Mi7lpEfNEDikCl95cX2VTph8WbIEwyhsWw5mUswymv42CcRJvmfy2rhWJpwjdAQwgMFUkJPAODzQRZEzMhx0WAvSMzr9RhQ6cpraeVyLYoTKwqeUW60SWYNMTQQy4dnF9HoIw1ReoE6VykiIV3E+5a/rwY+CNVEtAexwmKxKzGXMbZEyQb+BPkLpZkv4aCgHDsviGchHw4uOzwH3W0LiOsY7bEa4myUDCzia+sCiRib86XbmJZnotK+huKTYCM0mQNaqEz1Lwi43s7xqapoSGDwTLRf7ml6TYm+DHhOre0wD+aMiSkxZYqXWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(5023799004)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8yvIsju79rYp6UNYefwQz63ggjbuWZXLp6CDHgkAYbZdm2kv3m0/ndEODWC?=
 =?us-ascii?Q?uyKihq7gDSbnZufOeMJJdjSN+Wld727gizU58SDolajKbk3qBAk5FAY4WTMN?=
 =?us-ascii?Q?MJgi0mcgMHPqnPFelqIH0yNHwfiM4LXI6MJoU9opD6O4+tgb9EsKQ92qB2ST?=
 =?us-ascii?Q?bxSNsU4XkBZSRhE/eRcdyfzx4iMpBpsHJ1C1Q1LQMUjk7OfDjFczslLfmE9U?=
 =?us-ascii?Q?L/ohNh6M3cFTRhFWWGk9cZ9d+EN3csDZuniSUDai069JFH7HQnmqn8ZMrwiI?=
 =?us-ascii?Q?S9j3xBzNckfbM6Jqe1unVF45cW9Vzyy7KTDmklmeS2rc5k79ORR4ZnfHc2GV?=
 =?us-ascii?Q?h7apCZ4Rc2BCFkJaZ0e5QmIMp38wO9p624q2SJVoAEa/FEJBlp5kNsgUHACw?=
 =?us-ascii?Q?U8SSzdJcIO+FIntvaVUlb2nxPIYmTjcSwHL9TxVztKA+N4jN0/U6eG9Q2Wcs?=
 =?us-ascii?Q?7twTkaH/P1Qejzl81LLWKR5pwlmdt/FWfCr8TzOsdysT6/UTdUO8bp2JWy8S?=
 =?us-ascii?Q?HLKdeHoCl71Qc6ojSN0LRrALx/AcgQFv+ydDJLPVd1877lICgovPdtFjod/l?=
 =?us-ascii?Q?1NbsbWCSqpSRfjE6CJuH0BcZXOZn/nluQUVx4Uok2CJaAtz16fCLpsZ56WYh?=
 =?us-ascii?Q?ykirnhya6mok64ev32At1h9Q5WVpHsLvPqGrys86cYLuadhjvJ3O7B70txyI?=
 =?us-ascii?Q?PamL3IoVV+f4gi82u/Ev5XvZc3jcrc3NolKlcX7t5pD9BQJz3oP8Yp1YbN3b?=
 =?us-ascii?Q?LYDonRnkqNsRJXqPK5JyDU5FVCLZ71WlnLpo81zEK/Exw4zqvpSPYu9gGC5S?=
 =?us-ascii?Q?kgu9o4RwXJqARvp/oAYj3RIYXVLCKarL6XXxaVch3WrckYi7H5g+2oL1Y0YU?=
 =?us-ascii?Q?4wGbsaECeqS5NGgUnAdUGzYIjsZpPylNyc07iIn8chcI1ut/SFvrfD1S9hEN?=
 =?us-ascii?Q?GBy5TNd2c8I95pNrEw4zLjT+qH3R+EL9QV3tzDRVNu2B27m7NYhjoGLwJ/xF?=
 =?us-ascii?Q?RWnxYhnb/oYSCqVwkJIZFtK8zCqYTrHqrZezJzoqWuusSFnBCTEnN8h+g/Kx?=
 =?us-ascii?Q?ZQv6bJtugoLYsr9cVgPAeYp+Mu4CRkexlYz+SD017LsP6s1z7VVONraUQhpd?=
 =?us-ascii?Q?8m92hs35LcS+OWHyBPQcuMkX93rhcc7yPnKqKHifnGSjbbRSe6KGscSun/T0?=
 =?us-ascii?Q?beqSY8rfdYPoeou+m/50RdiIa6ZGVSJbdV8YBhscrZQMuAb5xiSnsZ/UI+RT?=
 =?us-ascii?Q?LPE1eU4nDcdBnXF521/nEfNPVi+yX03CmF2Pl2kLosNe3tH8MuiHtxERLvSB?=
 =?us-ascii?Q?KFnT/dm4fYyvoR25Ant9Q9LltITLjO37zLXzGeQW4jboVkey4l8up1NrZ6wD?=
 =?us-ascii?Q?Ymfdk+DEjU5nM1QYk+6EU02HkEb5LkS3NX5x13IKrpcNIKvlk03ARJKPHgxc?=
 =?us-ascii?Q?vdjMgUqI6bmri/n1C2ChCt+pgMOUy/L4E1U5Pc4PHx4wEpAt0nBxdoRJhINo?=
 =?us-ascii?Q?UquaMa1RN5Vm03sEuih0xPXpkfNdYjLtiW6a7L9oKOMRXEhw6abuAN0MYxf5?=
 =?us-ascii?Q?hGV6DEKvX5asY+wAGOsTN0FYbvC37f3UcKrlPe2xXTe2aTxucVyNeCK4BI/O?=
 =?us-ascii?Q?n7gqdC3Sxw/l9RBJ5GpbQvz4ig40fI41LUKYmd2nlnOa623XbBX6znc2iUML?=
 =?us-ascii?Q?JSQw37DxJKiHARrZpYcXZlM2xF6A53AtuIG3oK0pI+yipfXo/w9Oliu/kFSx?=
 =?us-ascii?Q?pNOsdYc3CnCjkBdnRzt3OycpsheSUn8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bce1b9-e427-437d-2212-08df0a55b811
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:25:38.8276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrSI8jfHcnxu+Q9nQpcfq4hgBvQhCB6RUi9pnHsoJ+rmqjnXTWw7l1YoJ3CaF8ER6SF4JUFnbRLJYMIslTwF2N+KJXk2bjJFKlRZXJeiZsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6137
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 03, 2026 at 03:31:21PM +0800, Daniel Henrique Barboza wrote:
> We want to configure other CPU types to use profiles as an alternative
> to adding every profile extension explicitly, i.e. a profile is nothing
> more than an extension bundle.
> 
> This means that a vendor CPU can set .profile=rva23s64 while having the
> same handling as any other vendor CPU. Same thing with all other CPU
> types.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 61109672d6..4cc73de793 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3096,7 +3096,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>          mcc->def->bare |= def->bare;
>          if (def->profile) {
>              assert(profile_extends(def->profile, mcc->def->profile));
> -            assert(mcc->def->bare);
>              mcc->def->profile = def->profile;
>          }
>          if (def->misa_mxl_max) {
> -- 
> 2.43.0
> 

