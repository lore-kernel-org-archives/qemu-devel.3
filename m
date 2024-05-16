Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE245C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7bgZ-0005Hn-C6; Thu, 16 May 2024 10:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>)
 id 1s7bgW-0005HG-5U; Thu, 16 May 2024 10:02:17 -0400
Received: from mail-os0jpn01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:201a::700]
 helo=JPN01-OS0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>)
 id 1s7bgT-0005jd-Qr; Thu, 16 May 2024 10:02:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5s2O9AR5WJD23Ap780L5hXrNUXih0zRKa1LTEwNexuKMqhqsDr0Fu58vg4vGQ9RQUFmqhE3O7DsEq7njt9EY5xLcQ5Pok8QSAvbCzx3rJGqO9DimpCxLf4IIpr3Igp/uuXFRUPSLl3lrkOCxagB3FPIl+WO1s4cDvxtkWg8URldqNxL5FjhrOL3Do9uawnc7D4Ij0g++gLSZ4CncXqNcuNHIYeQJ2XIs5AikOsTGEhI4tCdGau5aQ4mNoLje6DpDA3P2pWMYg5aFzdBV+MmAkvDoCt/o40jpgTXqJCQUbQKaDhoGZ+0pXKFm5jHpyh197f+2dctG9NV9ehKJ9O7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9fffW14I+TtV6L8lpTrQfHEA0PzqrpIvFS9PWHk7dY=;
 b=DbOW1pMFmvdkaKmq9feQ3D1GEIrS82kDvroL6L5RGfEN5XVxNhh3tlxc6/GLFFJnt2QQGJ9ZuLt3V30o7nY3ZYNnnBkCPQhK96e0gs7sWo+SGrUeRJf7mkLTcUV2/JOo7SjE7z2SRhtfhsF+Dl7qeyosfZHxOPz8ZSmrH2h6S+FR/jko29Y1/CurUPBmDMgHB6wYxdQ7YjxL2O/QXlkHz85cvZrpLkcRl6YnM0S62Kt8zcEppX7307ZD57YJMkSD04vlmnsjYSn1B96BEJeDuafXbYDokVgC1fgVOwA65Qtl8e9xxOlf2kOy0UrgmW9FQVdyCkLpAaQHXYiP8Sn6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9fffW14I+TtV6L8lpTrQfHEA0PzqrpIvFS9PWHk7dY=;
 b=XQ+hdagcg+5Y3dgdkdprpO55fSyrF2pSkMi0kVBHOy/3tKRXBD3HPjeco2r3SpRbtSHsjc9TYQMg04/Zau1kPZs4YFmFhb5cv/zRwS4ICJPgs1KO6+x5PKeyWP+/W4V+kkwBekdt6FZTMXAJnVM2PmdiC0q0uvHE3i6km25YLoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYTP286MB4021.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:181::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Thu, 16 May 2024 14:02:03 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 14:02:03 +0000
Date: Thu, 16 May 2024 22:01:59 +0800
From: Hongren Zheng <i@zenithal.me>
To: Yangyu Chen <cyy@cyyself.name>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Chou <max.chou@sifive.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH RESEND] target/riscv/cpu.c: fix Zvkb extension config
Message-ID: <ZkYR1_ZyjR8f5Yt0@Sun>
Mail-Followup-To: Yangyu Chen <cyy@cyyself.name>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Chou <max.chou@sifive.com>, qemu-stable@nongnu.org
References: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
 <tencent_8C6C872035C2F071090E689F3ADAE1E2C50A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8C6C872035C2F071090E689F3ADAE1E2C50A@qq.com>
X-Operating-System: Linux Sun 6.6.28
X-Mailer: Mutt 2.2.13 (2024-03-09)
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TYTP286MB4021:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ab20aa-cdac-451f-3709-08dc75b0c32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|7416005|41320700004|376005|366007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zGdx3j73u5LBhVn8koYsTor8UDeXgHQkDhVYpnIEzuf9iNhOuHkdo9WruXWf?=
 =?us-ascii?Q?sysRFnhPLpBecjWu5wQ4vupYnvBC6gUiPsSjAG41T17W4UKSDdW2QHsdaLHW?=
 =?us-ascii?Q?1lNhkWhViw4k1W3qrvlPjaA/xguicA1/imIguvXY8nXTuT2LLWifL/GDV3/D?=
 =?us-ascii?Q?4jE8V5C/g0CrTo71r5nm+jBduDMIjkWL+MECpZtB4vl5Lt2X83rPeDNb0/7G?=
 =?us-ascii?Q?3KitiY99gU6B7XTrS2OfYzpRrM5Br8bv5DACidqwmTsKSmAqj8dyTzyzxSpp?=
 =?us-ascii?Q?elw3y2VJ5wL81qPmA6Y9H52O1uOtO7DfCROl0jROz4hiYUkR06puSKoehNa3?=
 =?us-ascii?Q?dafE+U9JtiKlJjPVTYX9pqTpLhhii5nijixMusI2+rpsjYx9jx8YkfKYRzG/?=
 =?us-ascii?Q?pCimlwbIPBx6q+GutHLAuX8bDuEG4fsIo3xVU4bACr+x8hs/nk0O6LmLQqqR?=
 =?us-ascii?Q?9M5d2Ri4x41EANdJ7+ONJLAxqmertrKJpALl/SmavexC4xjGB271jh1swtDm?=
 =?us-ascii?Q?8Lgzh4dzJhOpE6wm3l7I7nVu6nFOZM44PcgC8CbZMGBonhY0IPR8tbzlzNZS?=
 =?us-ascii?Q?LrS3clRDmD7AqXZPzK3EMO3MVs7t+F8JwKX1mRIda/95QYmrYfp7PcVJ3VbA?=
 =?us-ascii?Q?6NFis51Sxi6Vb8aR40jTGMosoInYZD1Yb3PC1QEoriybVGmSgEXU9Kzuoons?=
 =?us-ascii?Q?eS8bX3DR0HG8BGeYf07it54KF01RUmNc/KdYTLgbib3vdm2i4EldNqzjDxRW?=
 =?us-ascii?Q?udpQZOrF5iPonkkUdV5tDLs3DEG322CwYZhg8dIBI0D4rawdQKzeUukFrTd2?=
 =?us-ascii?Q?Eh/WFjku2BXHKc6Z+2QaV5ak9LDMPwyQcL1SG/lzc/6Udj0HOW/HHuYKs221?=
 =?us-ascii?Q?iBo1Q74hK7DRe83Nd4a4gcLPyJhS56+2BypIs2f3IIlZwLOiXm+UU246cwLY?=
 =?us-ascii?Q?grhnFTvq8QF1/S3FY+0XxiZH9aGE/+uZCX2qMEqgO7kav5/ohRGQcktWoqgN?=
 =?us-ascii?Q?90WrCTm3w4ZODQLoV5BSnbjemk9wpMUnEq2OkJD72xhTji52zTAGWs3Fhy0n?=
 =?us-ascii?Q?1qn+6xefYk8/w+PXGHQ+CBHEoAdOfPdWfX4xHCdCh8PGKp2lTFW92rYeD+JZ?=
 =?us-ascii?Q?qrl89G4MbOH8XCrRyI8UVedNe6TYxMd9dqd7P/3h+SDioVFwjs1PedsGFef8?=
 =?us-ascii?Q?f6m2iogB9HD9N+eZF3hkAIeP39cU/oHWqVRob+Eden94YKE01f1BM57Ufww?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(41320700004)(376005)(366007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nY2WJ6KkY8KHCtZ8elX4CGMxMAZP9dVTELj6cI3s+VQQ0y47WYvA+dXCUHpm?=
 =?us-ascii?Q?8llYpeRIaAKyZ69/B5NF+KW2IwTnvZ5Fl5gYwfGU4YQiD7YVoJvOqO+xJRzB?=
 =?us-ascii?Q?Y0JiO/1G5uY17GJ/9PkcijZvGGvWKW9t1+BFeniRmfRZFgcwa2cmJC0cb3ev?=
 =?us-ascii?Q?7vZ/pOl7SyzRzQSVFywxHq+l3UKpoDKiizt2BiL50Y7zHXuB+wGKsN76kBY9?=
 =?us-ascii?Q?sqpoRWEU99lOrbF1iSfdWYrrKRewuVh+XL39SeKYw8KXxpHavVqN+U53zWIR?=
 =?us-ascii?Q?0iH/iWJbMOk7yOcLf1VOOXsyOo/Fgh4HZu9U7QRPJ6rkjZtEPW2Fn9i6Bkk7?=
 =?us-ascii?Q?YwoAcjJ3fM7OURRsuNM02McT8rdfQEK+BmAasH4OHsipyGaw4kqq87j1Hq+m?=
 =?us-ascii?Q?5KhOgmtGFuvyrMt7G4REB1undq0gMrfoqoLZVhgZKGlDSxHt2US3jy0ipvFY?=
 =?us-ascii?Q?L+sCPdxdRXPDKhpCn55ILJ/DIGBCjGY421Zgi3WKVbdrCNHaenft8IuYGbeg?=
 =?us-ascii?Q?L5JX1h2tXTezpfAUqq3NCpGxXQ3YIzMec8z7EK+UAwzVIFnPTC3Acnb30dm7?=
 =?us-ascii?Q?ra6cAa7UsnWks33IZ6sfFsXzanXx2tkCRO9xWpAW7GP/NYuoyhI2fnqB9V4J?=
 =?us-ascii?Q?L0T6h+ICQo6VZwWJnevh3RsMRF9v3eF53AT8rTb76FVT1Ty0tO9EAsDh1Lc/?=
 =?us-ascii?Q?ODjklvfiCyW3JcbwHhoJiM1EbDNt3TMND+fR68XQ/ABuN/kZQ4fp++XZ3hDJ?=
 =?us-ascii?Q?B3Rm91TsKer77PReFeGCS5es/uKRuYUaCFswVqyAO/Qv+ZhQl6htYC0wQO1X?=
 =?us-ascii?Q?wwm9ZVRufl0bFuT6bqg2BZLKaf0joyQTFpHygembCs0vK/Uy0SrflU5LCcsz?=
 =?us-ascii?Q?EC/IxWqq7P9daZJCnULo9tuex78NhcUNqD21tVAYjFLWDcRgOTiYO7JrViud?=
 =?us-ascii?Q?gdhcwao3L8mHntsTKo1nR4yKJaH/zD5t7JlE8QnMtXixTWkPYcMqikvcCD2m?=
 =?us-ascii?Q?e1ACuw7mVCCFxIDgQolr8/Xf+Z1ctOWwI8PRpL71aLCWp+BSkS8eOOU7k0zc?=
 =?us-ascii?Q?Eauc2vIXWGF108rYGuyEqzzrpnd806gpsUPRNIE7wu9C5CJBjm/TZnYGNRSu?=
 =?us-ascii?Q?7/eNl/elFrH3i1zraNUiMkERg0apoWDQCdEOFZFMvJ/eOaBcJMgggJRUFwlw?=
 =?us-ascii?Q?+jJ8e/+HdOwfZuGfEJQvvf57ePy0UR3JZzQ8IvH3jpUupf3pNm1vGc4+AV8+?=
 =?us-ascii?Q?4e92XdfZCDjPKC2bFxam5YG5Xf/j1uyNRX7Eb5iRAJiAV/NZvsSuP0VDwJEa?=
 =?us-ascii?Q?RgSRdW+LavFedSw+FSnbATl+PvshXaNrXPmvRIXIbWjl3/OrSNwIU3dGWMFI?=
 =?us-ascii?Q?UvZHNQRAS+XR15PR5ukOH46rtVbeJWIDOYhZwBLbBzWLQdzXdhEhwDkHSqIv?=
 =?us-ascii?Q?i6bi3vz/oXNE4GlWgKT/rDVZ6qJp+/T2JBLYrwdBYwI3QiCRaWdzuwBGYEi/?=
 =?us-ascii?Q?W1sAWSDZktAWY6Aklegkkk9iJGextpAmC8sOm8K/+/gVicB3bIhXZ2NjkJM+?=
 =?us-ascii?Q?4QkiQDXFzlFcuiDFkNVy8288sbT7e+TaJBHZl/rS?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ab20aa-cdac-451f-3709-08dc75b0c32a
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 14:02:03.2345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9UM2YfNUCOOVL2a6KsOv1+UitSVd2cAKEiZNW/AOmSkQo6Ur+Xbt+f+by7N5/2V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4021
Received-SPF: pass client-ip=2a01:111:f403:201a::700;
 envelope-from=i@zenithal.me;
 helo=JPN01-OS0-obe.outbound.protection.outlook.com
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

On Mon, May 13, 2024 at 03:18:53PM +0800, Yangyu Chen wrote:
> I think this patch also needs to back-port to stable-8.2.

Indeed, downstream OpenSSL CI using Ubuntu 24.04, which ships
QEMU 8.2.2, encountered this bug and that is quite confusing

QEMU 9.0.0 is also affected

Links
https://github.com/openssl/openssl/pull/24403/commits/5f7750fa0d366fd87d3280c18f7539f720a8d0be
https://github.com/openssl/openssl/pull/24403#issuecomment-2115320298

> 
> I added qemu-stable@nongnu.org to cc.
> 
> > On May 11, 2024, at 19:26, Yangyu Chen <cyy@cyyself.name> wrote:
> > 
> > This code has a typo that writes zvkb to zvkg, causing users can't
> > enable zvkb through the config. This patch gets this fixed.
> > 
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to riscv_cpu_extensions")
> > Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > ---
> > target/riscv/cpu.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index eb1a2e7d6d..13cd34adbd 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
> >     /* Vector cryptography extensions */
> >     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> >     MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> > -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
> > +    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
> >     MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
> >     MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
> >     MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
> > -- 
> > 2.43.0
> > 
> 
> 
> 

