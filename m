Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DBFCA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC57U-0006JN-MF; Wed, 30 Sep 2026 20:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xC57D-0006HD-FW; Wed, 30 Sep 2026 20:57:40 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xC57B-0003Hq-7C; Wed, 30 Sep 2026 20:57:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S14l6TpOgv83qYnLWHXHnT19ShvBZ6zs5DejA5TKlk9lX5xyFnuhveNvkCOcgpp3tdLeY7arufqBbEWwGCvPRhXqiouUIsbPP1YUa07cDgchJBeeKvG6FWM2tiClECSVld2CON+wSQ62rmr6ohWvX7+9lERO/7NCl+MH/HpyoThTQcGlYDOzqecl/HY6YneCwRyrlvKzCraTMvXZC+k/JrbeGtI+0Q+OaNZMvOPVuv/JDWb9ZwW4T2CxTGgjtl8ryMCFSvUOucINQxljJbptqNKylHNGfuMUKIy3DROrrelXKC6j7r63yWOcz5UR0/XOMQqMReVAfli9zTc8eEK28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2/McMVCEnw8GTk9ncF1NkHxOp1J4BcR2j/opP5kyHc=;
 b=LOvZ9gR35PqpGpCtIhVGNlSBDnCf9DjUjpnDkpgErgxtdoH9DNFLjVIN8T0r0OmwRoTARSdmBdSO/9hhmu0JuYIestmOIM7zwuV610RvkgV5xo/fyu03mNLwRQSv4Z0Vkh2ywSv473Z8tUsdrNnEBdob0zGK4D/d4eM8szu7iBKXIvzd1WcpbhTePrGOc5mb8kNe+ck5OAF+ywJRzuWG+SMlX/un6iAwAA0acvdkYnvHJFKJXD/ej44/SLCX/VUCNeaqQUavOiti1iEYes5RsrvLuuknwymKLxEpbM5LpLEdBa8z7cC+9idxVygGwAnql/KoIi8f3DjR3284abpiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2/McMVCEnw8GTk9ncF1NkHxOp1J4BcR2j/opP5kyHc=;
 b=d8sSoB/Lyzk0gCxc7vgwttlONDFqF4XwJQW7TuzRcbhlXOyOusxMWlmsP+X9GmkYGWYBcBrtt4lPxCbS7f+090aqeBMP3IvKIwfRznLUlwrr+gfzo2CvecDOa6MoibWJVH1S4AlGR2WN+uuKufjjZP27wPWbbThSszRzshA6Drm6+yS0EDAh1Y+uBAF7OpTZ20pvTmiXi4VBAYIaT+7NLuqRsqp6g1Qmn6XEeRbETmX/kQ/tyS03I9YHBFjqKWJwMW/Tdkkp3g2fEGqXnQ3fkLQAILXwL5+c0ZxgpIKNRHY/IOwzhllrNPE4ui46kT7Qf4Z9QotCg05oLjXGVgF9Fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6299.apcprd02.prod.outlook.com (2603:1096:101:b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 00:57:27 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 00:57:26 +0000
Date: Thu, 1 Oct 2026 08:57:21 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 08/10] target/riscv: bypass smstateen check in debugger
 mode
Message-ID: <ar2sNh_PW7XllZF0@MacBook-Pro-4.local>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <20260911-query-reg-v1-8-0c04f0c02cf3@redhat.com>
 <7a320a89-efb4-4520-80bf-d673d514e39a@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a320a89-efb4-4520-80bf-d673d514e39a@oss.qualcomm.com>
X-ClientProxiedBy: PH7P220CA0116.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::19) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c81317-f6aa-4816-f796-08df1f56f60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|10067099003|56012099006|18002099003|22082099003|10086099003|18092099006;
X-Microsoft-Antispam-Message-Info: auQ9Dhn8ZHpqnScyoWPOYaiUKl5+S9Y3Jn0Qe+5ac+64IaVhrELlT8Yi/uJbiTBUf0RljFMYtklLOV4peEU3KzrSnzsrpbHW+nuGtfvKLrPeuj1CfN/MFN/t16uyxOP/miihf2VLsd3cqq4Lhzjk2rE1GY/pi0WgCX6Mx9BvM38MSH4WIL68z+oEytRRt0PGpH6sdNW0n70ceVhcS0fSPJSIvjrt9EoxQyKtpOihBExuMBbMU0ijOA69Jq+Uk62RE+5sHJbrG46KinQKaTrLwJwCop1IZT37LskYN2YSco3C4kpmMQDDyLzrtzOG9UoaHIEy/XNTSdNGJITllqLWSs04Ryi/e+oJ2GZJF05C31HuiCnykzBMm11pv52onD7DYVKsAu0ybPavjtt8jaUAAzlSbzIxjV/ifSB8E+MlVCDqli7Gw5mU1zMTujuCDIzQ4jsDt1vbgUvbJLaviinvtC91zJgSuHXWAzCbECcbESaZX5ZWnw0AHLIEKhw5GlOr6EmuhISrrk3jYalzXwZm2KIVVyQW0PKOtBo5VlKC682lG7ODH2xNrEZK4F0U+/HUKX3bYAnJf6UuZuKZhl2WlVimWD3PAZaAwoJp0VjyNYyGkiAgn9+U+4emUqiIK0fcc51vygxlYQxy/iffH4B/rK8f1eFZ27hpNmJ9/7R/9gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(10086099003)(18092099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AgGqFzv4eO3RbeZN9yOycJ7hWBJxKEBj7JbXJLWoJyJ0tbotqr4S2iVVDr?=
 =?iso-8859-1?Q?voXOLXv1rnaIRn2f2W22LMTaQ/5m+ZEy1GdzjsOiBCgyGYXMexaTnI/PCO?=
 =?iso-8859-1?Q?tFnHF1QRfagSsXEUOkq9Bp3ul6Kgt9Renp8zMaMT+uknbYoWT+dwgkI0QZ?=
 =?iso-8859-1?Q?o/zVgW4+V+Ph8vPuZXLjjWY9ETWvLV/0pANyAzYeC9DVE/NEC4ucA/JsK1?=
 =?iso-8859-1?Q?TKLD8FrNIAywMXUHK2fzLd73SfuaVamxx+5XF7k+61dAN4PLG4nR6VUH51?=
 =?iso-8859-1?Q?TP0vET2A+GNMuUiourKODpn4K8n9ODMr2vmWs6qG+a6vy+Icx2FbmX/+CG?=
 =?iso-8859-1?Q?aoquzZ1sBaSOcQu55LSjvl6GcH1mDCBJ7glSqvpH+tBghOnwqdcJ0fFAaU?=
 =?iso-8859-1?Q?UBGH27PHDUu23ZDi+qtMWa2jVGBuzbBhJPXmjCLG5h+tsDERrmIwjtz4G3?=
 =?iso-8859-1?Q?l4/bKPhBmd67F+YTw3lKn9IHev5g3s8uvAJRNaj7YBqV+8KQOgLZg1QoU5?=
 =?iso-8859-1?Q?esmW6ULtHuQZYbP5HHbiSK6puj8jJKJ2pV6qqFXFVmt43QiAT+KE+vHB8y?=
 =?iso-8859-1?Q?xEIWgTJ6y4+wxHrDl+nc5C7MIRj4HH255IG0VX4nXPzc8fImo20yA0YGh/?=
 =?iso-8859-1?Q?JyuRUcuvoF8QT43ogEmc4Q2MLactcJZqL0ebLK6iG7LZJK9z+4Ed+Gm1Kl?=
 =?iso-8859-1?Q?gMa2nV5T8tS7P9KeKj1KiApCRhdK0nhTaptT2LOHjPC4DsmkW06bHOe0Rc?=
 =?iso-8859-1?Q?bv2MCGfcb2DH+IMuJyUFUn4wh4jRECqN55C+xf/HsNiajGLls16PNDNgn4?=
 =?iso-8859-1?Q?vKe7kIsVitwfHf12jT+oJUN+qa7YsOKlNtIcCmABvCHNxcy33GT7gd45Dg?=
 =?iso-8859-1?Q?rdveX7jRUAtCt6oj9XLl22YBtcqsG09SyFIyz2q5rxY+Hl0ttRBisr664A?=
 =?iso-8859-1?Q?T7BTsO9vUUgXQp9aa/gTX2gadzGEgBmJYV33YEFaGN0nwFoi/lUMvCj4Nj?=
 =?iso-8859-1?Q?eGTa4B5s3gY7arrooHj87UnCdD4AOCMaV3/9IJgNSLn7OqbOgW7Y2mC2ay?=
 =?iso-8859-1?Q?zQwCHU8ZBgTft0eQPmuHI62e/JfKYAF1plvDCKFqVoH2SSL8UcEizFcLJG?=
 =?iso-8859-1?Q?48wVtii+1QNuiJ3ZfvK0mQNSLwUKtsmxlj4Di3EfucUK/DS2LnT+Lv++Nj?=
 =?iso-8859-1?Q?2jGgD6LefKiWj9FawUk8tEgWF3oS2DdqoPnot26AcHtQojaNnBmNwwgJXa?=
 =?iso-8859-1?Q?+Ac5BfCANgrT+VfPZ0cL8AXRcj1OcXoA/BVperWyx3/qPWX3rQvP66B9Xp?=
 =?iso-8859-1?Q?M2Mo3ueMuGDX6X9bYnr+CP2BhNtTCNzekLH2xzerlw0KTCxrjQwi8F9To/?=
 =?iso-8859-1?Q?VnMeGQ49o9nmPNBVVlqSIk0wOC1Rw2jV+VrFHWQXZCtEtWESpXdBVETDCw?=
 =?iso-8859-1?Q?vP3ygXXzOsnHTG7cgUxA15jwOB+jqNYfZdibjiOyZET3qv1sxVXDqsQJOP?=
 =?iso-8859-1?Q?v0Tu0b1sqhBkrh241pYa4qRVc+8fWxK1NzGmCfaYERllbZVFgRYlLJgy6t?=
 =?iso-8859-1?Q?f9ub5myaQQuVKLvsmef6nys7Sl/ni1a7K+KzVpQc0PqbOtL7W616uPjKOx?=
 =?iso-8859-1?Q?HgzKPmoeHFxh3UO6gSsOOOco1+nvWZczD8nVnWEfcPq2R1zczw/bNYz36m?=
 =?iso-8859-1?Q?5lXvzwYhCs8fQsiqyNKCiPLMEphAYKdpZEYVH22wwCnwd6K4+8/hgn6Qt9?=
 =?iso-8859-1?Q?gkJF2mbZbvqx9IcgO2/mJhZxSC6956ag8Bsk/+sCc9h+gCkIaFn05LM/Mz?=
 =?iso-8859-1?Q?olzoXzihePZ6irFq1OYRHcF8mQ8ktlA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c81317-f6aa-4816-f796-08df1f56f60e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 00:57:26.6628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo5nrpbuDEa2AOUrV5mr8JCor/yQNzQsM2iuUfx2ImkYUM+kYLRm95BcotA7Se8o8CJA3A4AiZgG71UDWKULZKl68+U69qVjcZ5U2bu5KfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Chao Liu <chao.liu@processmission.com>
From:  Chao Liu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 30, 2026 at 03:24:34PM +0800, Daniel Henrique Barboza wrote:
> 
> 
> On 9/11/2026 9:27 AM, Marc-André Lureau wrote:
> > Allow to read CSRs gated by Smstateen extension when env->debugger.
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >   target/riscv/tcg/csr.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> > index bd4b6dc114bc..93a7f419f29f 100644
> > --- a/target/riscv/tcg/csr.c
> > +++ b/target/riscv/tcg/csr.c
> > @@ -53,7 +53,8 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
> >   {
> >       bool virt = env->virt_enabled;
> > -    if (env->priv == PRV_M || !riscv_cpu_cfg(env)->ext_smstateen) {
> > +    if (env->debugger || env->priv == PRV_M ||
> > +        !riscv_cpu_cfg(env)->ext_smstateen) {
> 
> We have an going work in qemu-riscv (sdext, currently on v10) that adds
> a new 'debug' mode that is higher than the machine mode (PRV_M).  It
> already uses env->debugger in its logic.
> 
Looks good to me. Debug Mode uses M-mode privileges as a baseline, with
additional access to debug-only CSRs.

One thought came to mind here that I'd like to share: for CSR access,
`env->debugger` and 'debug' mode both indicate a debugging context,
entered through QEMU's GDB stub or the CPU's architectural debug
mechanism. CSR access rules differ in that context.

I think a shared helper could check these two flags together,
and include `PRV_M` where the same access rules apply. This is outside
the scope of this patch, but we can look into it once Sdext is merged.
I'll work on it if I have time.


Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> I believe this change is already in line with what we want there, i.e. debug
> mode having at least the same accesses as PRV_M.
> 
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> 
> 
> >           return RISCV_EXCP_NONE;
> >       }
> > 
> 

