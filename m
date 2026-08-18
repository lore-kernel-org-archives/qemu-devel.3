Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945D5C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwD72-0006H2-Lf; Tue, 18 Aug 2026 02:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wwD71-0006Ga-N8; Tue, 18 Aug 2026 02:15:51 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wwD6z-0001lu-TR; Tue, 18 Aug 2026 02:15:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/ZzrtOd+a7KLm9X86tPcPblWzfkFmXTnzzDRUPZvVbyniVA19msxeyHtujAxLit6taS2Nwu5/6VqjJkFw06NgUBvMc/c4fPMiX0710Y6Pjfqj3NtpJvgMDCUwBJhjYUd5KkvT9cs+W37RAr/LHzt+G2w5+QonZHBQKFJPnICk4F8dAcDZkH9ZEvW3UnK8kds0o1ZtnhmuCN6HAnAdzb4fTuTvf6F8N1UwHXqDjaIaT53Mfx0F6LUlGSP9VCWip9MKRoKCPQVDjYFbzc7KGZVP4e2ydHboSsW56JKwJ8yX+08sFoM9qBTJeYq3EC5RNHIBG82Tp+ySWtrGHzn784Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr9rp/lMTZ9E+N3wvJ86nYKEHNxlqVfnxecoRM1uTyE=;
 b=pdLTTe++0QiezDSDrJuza7TRkyMWfA4z/SQwDOAjaq7rDc9C4AZZAIXpmyr3HMIFV6iU4BcC1exFshxx+OwH46dObWrXrxX0+AyQJrxAcOpGvN6zuSpxhpkE0ZmIOe9xCHKslpALPpWZ0YSXydV9Kt1BGVaSubLj+Ny5afwsQ4ZatoL9YaS4RMkwhTOnvWRpRJR5uul9F5ICLBeA7cRnQ0sZR0/doHcES9Nu1kLcSaIZy5rtFJW6t5h9k8PY547Zdnyw2lR6K01cWIkia4baNl9y7Se0Owj32TlDNPxjI6xjpd6Rz58SVewGutgaX/Tn8Enp0ihvwG8drMrn4HCozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr9rp/lMTZ9E+N3wvJ86nYKEHNxlqVfnxecoRM1uTyE=;
 b=SZRCAA80mWVYIDebs+vros5Juj8yejFcQXEJsSJmQ6w4WP6T0OMaRjFx4jl/F7kCj9SZgmvYEFofu15sIZNUtkRVyKDpA0fmNq4od5ESuouaZOYxpBhfi6V3thjlL7uUZTaGnG9BTc0aW4EtkG7XBojXh3r0Li9hAoVXvK8/rBXsGOUlLtJlpM9cvGnaH91ECNckZYLpbzkepojBUmWhVgz6VIAhRbMrMzi0XZjC18uoSYUM4RdGer65/aSuvVzkAOLVe+9tWuSE2W34etFrv/Q9tlmZi+HTPxjOY04KTVv8JvvDALKO8UdZoykDM8ClwT/9/p6uuJZbIHuLFQDRNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB6686.apcprd02.prod.outlook.com (2603:1096:405:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Tue, 18 Aug
 2026 06:15:41 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:15:41 +0000
Date: Tue, 18 Aug 2026 14:15:36 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Vladimir Isaev <vvisaev@gmail.com>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, joel@jms.id.au, npiggin@gmail.com
Subject: Re: [PATCH v2 1/2] riscv: csr: do not drop C bit on misa write
Message-ID: <aoP4fP-Dy1nzrE8Z@ChaodeMacBook-Pro.local>
References: <20260817150653.40357-1-vvisaev@gmail.com>
 <20260817150653.40357-2-vvisaev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817150653.40357-2-vvisaev@gmail.com>
X-ClientProxiedBy: PH0PR07CA0113.namprd07.prod.outlook.com
 (2603:10b6:510:4::28) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a453794-3b88-49c4-a230-08defcf02140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|22082099003|18002099003|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: gINaSBP7et6+lP5/C4lTKvTvIgJvZOR+fNyuIKUsUfgIoSDfqZM8c7d5070OSvlSvPauP+3aeJzERjDBGY7gXoPT74gT6sbfgAJAJBvELi5pAxepMBed4CII4Cv8acGuynYeNvbYU+YoJW7u9FhwshcZ2Dp0DY1VayeREKVT46sSFqfMo2EaPVXgXNcVTajdpT+vw7HkddHhDzqnwkzOgqqoZ4CuIWo1t0pvNM0lbEf+2w5BB9A7snNjoNCI34fUfLG1vo21l8p9m2V30FI3zBLG6MPn97Ny6QZ5DNYBDWHqCOgcZQM2vnEZvr8HHeyOt1mOd2BUkfgpOpsUV0MPlxHxGiStJHkLHQ40SIFku/z3n8BlXbrmwOWh5jU9xG80wF6G8p3MxRjLaR9z8c2aWEn84YCWnYwucjvLbji3aO8QCimZEvn+naYgfNuK51tYckY9vc0VE13UpOdpY7ljTbqZI27gN0C4zJYcd4zawxz/NQPmJoDyEYRytOkgOhybhtqLBOR3RzneOi+FposYHigWI4IcKBSOyYI50P8NmUr+FqfGUN9n/TOy9btB32awXCIARaz8p2PEWv5X8+WGDSXnzHRe0XFXemwkGljJnESHI/HsXvI3PQT2ref0j8cp+MjL+RMhp6YQG0DKXLJfHDcCMlkvhWa64AAWJAncnqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXhILzFpM0o3OUI1Vm1oN2xZMWlaWFg0VW1hbm1NQjIzdFdCRFIxZmE0N2Vt?=
 =?utf-8?B?Y3o0aDEzMlUyUFBVQllkUWVTVXYrTVkwdVdHWWR1TmhvbFVTZG43eUJneG5Y?=
 =?utf-8?B?Q1V0aWM2ZU1sY1Bvb3lmTXR4T3J4U2l4Z3dMNlVvK2RtemNXUXRFem1QRHgw?=
 =?utf-8?B?Z1pRaDdnOFY1dFN4cGV3cVFPNmkzUlRmTFZ2T0NkcGpDRXJxSG1LVmZLOGY1?=
 =?utf-8?B?ajdXMXFPei9NMlVWZWtrdks1am5meTB3Q0RoSzVTVWxRKzNqbVZmNExFNGJk?=
 =?utf-8?B?bnlxSlVQUGRZZHRVVm4za0NSTWdVZTA0bXAxZzRzeDdWNUs0QXFFeTgwZlVO?=
 =?utf-8?B?YzAwbW9SLzcrNzZOUTd0OFBNN1dDeHl3VlczV3JOblJZRDZpbGkrWTZkeEJu?=
 =?utf-8?B?dnpUb1JaQ2ZmZGJ0b254Mkd1d0s5bk1wZnFQVE5Td3dkNXI1SGVnOFNpVG9H?=
 =?utf-8?B?ZjBWMXh0ZFlKVTlXdGdPVVo2Zzkvb3pQVEQ4N3ZDWWY3WUdSRFg1TnpxZFZJ?=
 =?utf-8?B?M1o3a1NmT0hJdHhsT2diai9SMkdrSGtuSXJIRE1tMlM0TWJXMndxcFU1ZnV5?=
 =?utf-8?B?cngyNFg5UW5qSWQ3S1UwTS9kWG9xSGpGTEg5K2Z1WDZlbHZwUjhUdnFQOFVi?=
 =?utf-8?B?M0tzQm1ianBncHVnS2dCVEJDMGlXQStCeW90L1ExWms0UkF2ZnRCSUMzak1y?=
 =?utf-8?B?SU5mS3NkZjBPeWJBMSsxbFRRL2V3RzF3cExnUG9nUzQyMkdEdFBiQmZwUVp2?=
 =?utf-8?B?ZXh0KzdCcGNuNkJ6alBkdlR0S0lmYVhCNDZ0MmxSeENud05yVXhmZU41ZmZH?=
 =?utf-8?B?dzZ0d3NVVm5uRWUvdDZIeFNCSy9ScXdjREwxKzNaUUhFNkNRcXBUUU1LOVV6?=
 =?utf-8?B?UGtGcFZLVWFhN2xRSFREdER5cksrREtGQnB4WnVDRnRzSDczUG5vWUhRaHpj?=
 =?utf-8?B?NitwdDMyVmNyc1p0TENSNWhQTUlvZWdpblNaZHB3aHNvaSswclJpdCs5c1ZG?=
 =?utf-8?B?bmRnV3R4YkpCdVFQVzhib0hJdUt1VDJqV1Q3V0xEUENQenl2RUNjTFgyRUZY?=
 =?utf-8?B?SzlWK0Y4SnRtOHZCVWF2anBmVlFaNmZIRFV6QXdzK1NyNHRYalJENTREcVQw?=
 =?utf-8?B?YUVBcWRubUc4bnljRms4cFFwRWtrUm1UbHBzM2o5TkNWemM0R29JYlp2UTV6?=
 =?utf-8?B?bzczcGN6WVhGS2Rqa0dwN2s3enhuNHptRm1uZkR0ZUxTZmhFUXVoNG1BQThX?=
 =?utf-8?B?d0RjSFYzYjdWTlBFeHJuS1hHS00wVHZITVo4RngvcGltTFNMTzZFaUVTTkR3?=
 =?utf-8?B?RUxzd3BFeGsvaXAwcWNiajNHM3lyMFkzNXpRcnFuYkIwRTlFbVp4aGlZSk4y?=
 =?utf-8?B?Y0hyVUZ3VndMSFQ3eFVwSFQvSFU5VDZNdVhwTlZ2SUZGMXp6Tk03cmN4MmR1?=
 =?utf-8?B?SjV1NlF5V0lzMElZY042L3hZTHRoSGFYbzlLYnpuMldmaVBmYklXZTM5Sllq?=
 =?utf-8?B?dVRvbGQ1ZEMxRktERWZiOFhURWhUaWh5YUZoVXRvbHE0aDRkZTJ2VzQzaXJG?=
 =?utf-8?B?SXAxMlJpYVNkMU5INTJFUHpHbVlybEFsekphbnBNN0NBQmVGRzNBcFBxaTZ5?=
 =?utf-8?B?U2lpSFVRQTI4T3NpNFl2eGRSOXJJTkJwdDFJcGxNOEs5eGN3UHdkT05MMUx4?=
 =?utf-8?B?dTh6QXo3UnV3UURhRjNCZmptbTNwcjdQNXMxa0pFeGQ3WHl3bFhIMFFUNkph?=
 =?utf-8?B?QVhIWGhjVzM1YUZmZEFPcTVqYzBmYVIvdFBOeW85S3FBckpGSXkwQmJuRzBG?=
 =?utf-8?B?cGkzVHVoblR4WUlpek9BWWpXd2Y2Wk9LTDhtbUhCcFpUWlRYQ1g1aWJwQTZ6?=
 =?utf-8?B?cVc3bS9reHp4UmM1TTU0SjFxaE1Tcmt2QVFTWjRJaGNrVlBXd1NQQjViajhm?=
 =?utf-8?B?citIY3Z6aW5pWFM1UXpGdTIxRk1Sd3FZUGVKWC9XMmdRMC8yNWFiOVljbUcw?=
 =?utf-8?B?eGRRRE5oSDR6WWF5RVlwM1Y4dW1VYUVKZjZ6S3FFckJ5SjdZY2FBLzVhTlI0?=
 =?utf-8?B?K3pUdmJzakFKK3cvUVArM2JTdnN5Y1BTL09IZ2VwQW9XRkdIZzFnMjhJZ2tq?=
 =?utf-8?B?bW1iakhaZjZRRHg0dFhKNlBLMm54S3RaYloyWjZtbDduWFhoRmk4RU1KNzZw?=
 =?utf-8?B?MHAwZGtkWkJaU0tQSlNiUVJBOVJrSVBuMW9LRm5pZzBaRThlNW40QU9wWjB6?=
 =?utf-8?B?QzBJdUlZOVV0V2h2eERveTlqZ0JrRm8zb0ZKU2QveUVCNmFWWGlueHZjZ2F0?=
 =?utf-8?B?S2FrbFUyQjhiQ3pNMFJMekM2KzJSbmxtVENzaitrT2xqT1ZxUGZkbzBReFZF?=
 =?utf-8?Q?5iJeuM+7NOtH8ecE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a453794-3b88-49c4-a230-08defcf02140
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:15:41.5578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUiwplDzU74n+60e66IiY4oR8Bs7HRZYsYfyYRzrbOfsSLSQMG/vlCnj7dyTi8VIZ++gcKrlvE1SI9viqdWGnNtmXVWYEpOXz4SaKqprMew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6686
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 17, 2026 at 06:06:37PM +0800, Vladimir Isaev wrote:
> According to spec:
> > Writing misa may increase IALIGN, e.g., by disabling the "C" extension.
> > If an instruction that would write misa increases IALIGN, and the
> > subsequent instruction’s address is not IALIGN-bit aligned, the
> > write to misa is suppressed, leaving misa unchanged.
> 
> So attempt to disable C extension if next instruction is not aligned should not
> change the misa.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/csr.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..dbfb3381ef 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2182,9 +2182,13 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>      /* Mask extensions that are not supported by this hart */
>      val &= env->misa_ext_mask;
>  
> -    /* Suppress 'C' if next instruction is not aligned. */
> -    if ((val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
> -        val &= ~RVC;
> +    /* drop write if RVC is cleared and next instruction is not aligned */
> +    if ((env->misa_ext & RVC) && !(val & RVC) &&
> +         (get_next_pc(env, ra) & 3) != 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unable to write MISA ext value "
> +                      "0x%x, MISA.C disable failed\n", env->misa_ext);
> +
> +        return RISCV_EXCP_NONE;
>      }
>  
>      /* Disable RVG if any of its dependencies are disabled */
> -- 
> 2.55.0
> 

