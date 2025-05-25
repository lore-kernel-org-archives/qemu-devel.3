Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD9FC54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH6n-0006O4-Ea; Sun, 25 May 2025 15:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH6k-0006Nh-Ht
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:34:06 -0400
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH6h-0008AV-P1
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiPsrx25SXpSFtb/l0xbeaSkR+xVoVGSpoFql5E951s5/tHWOKGrTjRBRisD7ytxYyVbgvuq0QgREkGpXjVDSIqffX2TyIVBp+hkzDF8vUWbIIxrXWOsb2J04PvBqrgO1po7tLB/k9RBc/SWzUD3uHGUvd8EI11pIt6X2Bcadk0rO7Q/HRTtgFsXWQgoyW1zIARnkyux42h55hajnuOqubfz9DiOU/6um8hkQfLmkPfrJiQqSWuCZqNCeGIQtUZlda/2j+tulyQD48t/lZoJRiRFKz+EwcvT3GS6HNn58YS7rEOeGfQCDPiiQDmuM+ehd7IpxSs0J25alFwomHL/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02faRF3vYmJMrv5gpFXsXtldvVUwI5uW2V6MkOehO38=;
 b=fnzXBPv7qoqA0ijCXjc4baRJAahH2e1J5lHTyMd4hTEtJRkfLuVW1RjLNKmBAEgzXBFgxfusDRW8rkfYHRFgbmChxkXliltwIfUoF8yR8QJMQNn8tcShElWU7FASAxqnf6/k35Wqnp9lTUKNZxSd8GkaMCzoLSdGtklfW6kl8SlVueAK2UWtKBraPG82ndKfxtfQbtGxkM+Hq6ewuUrht2HrnpBjKOJAB2UD2EZ68dAmKYSVAVp3QVB1jQgAFSjD4wsP1CbDAxRIyPTcsMmcrrys1odE+0jWkUHKYGIgir4gYeT+CYWgft6TfgoJzD5ZWwuYXktwmqg50mhEwTpqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02faRF3vYmJMrv5gpFXsXtldvVUwI5uW2V6MkOehO38=;
 b=K0uUuo+jDTvBMMqqZR0HEi3ZH4U0XV3DY0h0zuGt5LW1cfLaowfyOPcWjpouMWPAa3sI5t0uhGmFuSN1sHT3CssPH0IC8Gxfk3tTeWCNAV6aDm7B8z1XZHv756OtFsFk4u1aVLADLff4L8gm5qvhrhrffppnt2TK9u6K24O1vyg=
Received: from BY5PR17CA0006.namprd17.prod.outlook.com (2603:10b6:a03:1b8::19)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Sun, 25 May 2025 19:33:44 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ff) by BY5PR17CA0006.outlook.office365.com
 (2603:10b6:a03:1b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Sun,
 25 May 2025 19:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:33:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:33:42 -0500
Date: Sun, 25 May 2025 21:33:36 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 04/10] target/microblaze: Implement extended address
 load/store out of line
Message-ID: <aDNwkAvUfFlj7cSp@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-5-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcaad9a-0726-45cf-8f02-08dd9bc30f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qfA0Kx73WbzN8uH14YHfXS7udS6fmzdEIOvo+rjep+U8ceXq1FwBB4au+fyJ?=
 =?us-ascii?Q?FZ6LNjR02AD9JVi2NZ+0MPPTdIpqnpJGzJ9eSabWbY37ixB0XwyFoqWJKjft?=
 =?us-ascii?Q?ymKm+0Z4vqGEwU0LAoeeK5OVMm0RvvobYf7zJ47Oow2JVVFivm/MS9aRFaPs?=
 =?us-ascii?Q?VdYtmLK3p3U3uIs6N3Au2s2L1fmFIBPZWulMg6bb+KQJSIVg8UMfDBIZ7LEF?=
 =?us-ascii?Q?qxHo3zgr8HX03L4r0zWRyrraB0EoNaA/fJzfFe5n2cEwXiZHgQ2esRCaq/3Z?=
 =?us-ascii?Q?iLt+8rVz0+RbpY8Q4bqCrt6oL18gpwuFekMWh1q+sgRxFoe95Cn3hWjT1NPz?=
 =?us-ascii?Q?pczXKt4RBYHE99VnIkrKY9Myu+aXrn/bz1gabjqV9P5wXflbq0YUxnT4raMp?=
 =?us-ascii?Q?cfqU2zO0ZB0UCvbcOVaj8EO9x6jbvF36OQocfsHkIZgLI1XffiJZHv1wymNl?=
 =?us-ascii?Q?vvfeljtRqaDBuVHa8RbsXjGYK6sZBoQ/yP7PnhA6apsY3eM2iEozvxh6c/T7?=
 =?us-ascii?Q?pfDqWM++bKo01bCsCsdpFc7KseC2v2KQ1MooUiqfb2NiEPHkRFJfnk0+kPzV?=
 =?us-ascii?Q?ZpHHJ3pzIfrXykpQK3WFF2rR4sH/7eK0cwRsCOWFa+xLueDPshWc8CRMPrgN?=
 =?us-ascii?Q?omo08GuPfiFEeXT9YBjhy4hvRKKrnpNQdJqjDJFfsOTkPA2sa98fSkO6IqWp?=
 =?us-ascii?Q?RtzO30tqqgGK9J/vIJQDAJ88u2CXNervQABg3z4nfyb7Pcv9qNXGrKZWJYz0?=
 =?us-ascii?Q?XdERWEGFZSUiPtCpVRJKIGZZo/o4tkBcLl5Z5/kDRY7BrkfHEIpcsXGxvCN7?=
 =?us-ascii?Q?b2SeKNHicMtb05RAD0KCBWUi3mAbA8aYuPCW1Uv7dUYYDNPM4/By7RMLpUfi?=
 =?us-ascii?Q?MR5f7joRSlLR8jp6ixzzNMMSzhe/17LuZ0K2XyjwMFcDXhxZkfVxOaLbls1U?=
 =?us-ascii?Q?KaXOx/azVXRDEnPv8gsDu8NSovCdZlhzC8ko0Ud4CeDTnpytXNnEhncGlsFm?=
 =?us-ascii?Q?2xi9jBD4cAzpHZuwfUccBDvPr7iX5YotBI6lTs65iTLyEa/f4lV5A5fPiqM1?=
 =?us-ascii?Q?iFpgRqC4XhrtA3j+pocSZu8urpCMfBFpSC+Chwy3b2CP4BgCMlAJTNEBO3EK?=
 =?us-ascii?Q?2IrPz+2O3X2Lm3dcSIlIKvSOCDEJzdfe354/I8tOcmgDNP2KIBLz95ikDiUq?=
 =?us-ascii?Q?yLGH+Fc4clUhIzJPPVSN6+osu9GLX3P0AdBvQtMdLfLVwJKVVhd7glJwHMxL?=
 =?us-ascii?Q?2KlPAot1IaLK1dmAxaeok/1MFHn0g7KlFd4Lhbgk/nBp9o8FPIaOMjZuxw9A?=
 =?us-ascii?Q?LTSAJ/jcuvG8jufaUUMmpb0zwd3CMCJfXpKoYGLdiHc9b2eioFDSI9z/SJvn?=
 =?us-ascii?Q?i9xjv3yy/fYeg6Xby3ie32T1t72KJsiD5F6/P5XcKjyewDJAE62c4b/qoXVC?=
 =?us-ascii?Q?eg9F7xOzVBhQFpQT3NJfE/VbgDU9c3TdL+UT1n+ErwySqlQ8pciRP9h/AGhA?=
 =?us-ascii?Q?MeQqbSrBUv5H558Li0m8ZybhgvKX3TruqtG8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:33:43.6163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcaad9a-0726-45cf-8f02-08dd9bc30f7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
Received-SPF: permerror client-ip=2a01:111:f403:2417::62b;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, May 25, 2025 at 05:02:14PM +0100, Richard Henderson wrote:
> Use helpers and address_space_ld/st instead of inline
> loads and stores.  This allows us to perform operations
> on physical addresses wider than virtual addresses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/helper.h    | 10 +++++++
>  target/microblaze/op_helper.c | 40 +++++++++++++++++++++++++++
>  target/microblaze/translate.c | 52 +++++++++++++++++++++++++++--------
>  3 files changed, 90 insertions(+), 12 deletions(-)
> 
> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
> index 41f56a5601..ef4fad9b91 100644
> --- a/target/microblaze/helper.h
> +++ b/target/microblaze/helper.h
> @@ -28,4 +28,14 @@ DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
>  DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
>  DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
> +DEF_HELPER_FLAGS_2(lbuea, TCG_CALL_NO_WG, i32, env, i64)
> +DEF_HELPER_FLAGS_2(lhuea_be, TCG_CALL_NO_WG, i32, env, i64)
> +DEF_HELPER_FLAGS_2(lhuea_le, TCG_CALL_NO_WG, i32, env, i64)
> +DEF_HELPER_FLAGS_2(lwea_be, TCG_CALL_NO_WG, i32, env, i64)
> +DEF_HELPER_FLAGS_2(lwea_le, TCG_CALL_NO_WG, i32, env, i64)
> +DEF_HELPER_FLAGS_3(sbea, TCG_CALL_NO_WG, void, env, i32, i64)
> +DEF_HELPER_FLAGS_3(shea_be, TCG_CALL_NO_WG, void, env, i32, i64)
> +DEF_HELPER_FLAGS_3(shea_le, TCG_CALL_NO_WG, void, env, i32, i64)
> +DEF_HELPER_FLAGS_3(swea_be, TCG_CALL_NO_WG, void, env, i32, i64)
> +DEF_HELPER_FLAGS_3(swea_le, TCG_CALL_NO_WG, void, env, i32, i64)
>  #endif
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 4c39207a55..b8365b3b1d 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -382,6 +382,8 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> +#include "system/memory.h"
> +
>  /* Writes/reads to the MMU's special regs end up here.  */
>  uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
>  {
> @@ -441,4 +443,42 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>      mb_transaction_failed_internal(cs, physaddr, addr, size,
>                                     access_type, retaddr);
>  }
> +
> +#define LD_EA(NAME, TYPE, FUNC) \
> +uint32_t HELPER(NAME)(CPUMBState *env, uint64_t ea)                     \
> +{                                                                       \
> +    CPUState *cs = env_cpu(env);                                        \
> +    MemTxResult txres;                                                  \
> +    TYPE ret = FUNC(cs->as, ea, MEMTXATTRS_UNSPECIFIED, &txres);        \
> +    if (unlikely(txres != MEMTX_OK)) {                                  \
> +        mb_transaction_failed_internal(cs, ea, ea, sizeof(TYPE),        \
> +                                       MMU_DATA_LOAD, GETPC());         \
> +    }                                                                   \
> +    return ret;                                                         \
> +}
> +
> +LD_EA(lbuea, uint8_t, address_space_ldub)
> +LD_EA(lhuea_be, uint16_t, address_space_lduw_be)
> +LD_EA(lhuea_le, uint16_t, address_space_lduw_le)
> +LD_EA(lwea_be, uint32_t, address_space_ldl_be)
> +LD_EA(lwea_le, uint32_t, address_space_ldl_le)
> +
> +#define ST_EA(NAME, TYPE, FUNC) \
> +void HELPER(NAME)(CPUMBState *env, uint32_t data, uint64_t ea)          \
> +{                                                                       \
> +    CPUState *cs = env_cpu(env);                                        \
> +    MemTxResult txres;                                                  \
> +    FUNC(cs->as, ea, data, MEMTXATTRS_UNSPECIFIED, &txres);             \
> +    if (unlikely(txres != MEMTX_OK)) {                                  \
> +        mb_transaction_failed_internal(cs, ea, ea, sizeof(TYPE),        \
> +                                       MMU_DATA_STORE, GETPC());        \
> +    }                                                                   \
> +}
> +
> +ST_EA(sbea, uint8_t, address_space_stb)
> +ST_EA(shea_be, uint16_t, address_space_stw_be)
> +ST_EA(shea_le, uint16_t, address_space_stw_le)
> +ST_EA(swea_be, uint32_t, address_space_stl_be)
> +ST_EA(swea_le, uint32_t, address_space_stl_le)
> +
>  #endif
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 671b1ae4db..3d9756391e 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -700,6 +700,20 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
>  
>      tcg_set_insn_start_param(dc->base.insn_start, 1, iflags);
>  }
> +
> +static void gen_alignment_check_ea(DisasContext *dc, TCGv_i64 ea, int rb,
> +                                   int rd, MemOp size, bool store)
> +{
> +    if (rb && (dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
> +        TCGLabel *over = gen_new_label();
> +
> +        record_unaligned_ess(dc, rd, size, store);
> +
> +        tcg_gen_brcondi_i64(TCG_COND_TSTEQ, ea, (1 << size) - 1, over);
> +        gen_helper_unaligned_access(tcg_env, ea);
> +        gen_set_label(over);
> +    }
> +}
>  #endif
>  
>  static inline MemOp mo_endian(DisasContext *dc)
> @@ -765,10 +779,11 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
>          return true;
>      }
>  #ifdef CONFIG_USER_ONLY
> -    return true;
> +    g_assert_not_reached();
>  #else
>      TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
> +    gen_helper_lbuea(reg_for_write(dc, arg->rd), tcg_env, addr);
> +    return true;
>  #endif
>  }
>  
> @@ -796,10 +811,13 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
>          return true;
>      }
>  #ifdef CONFIG_USER_ONLY
> -    return true;
> +    g_assert_not_reached();
>  #else
>      TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
> +    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, false);
> +    (mo_endian(dc) == MO_BE ? gen_helper_lhuea_be : gen_helper_lhuea_le)
> +        (reg_for_write(dc, arg->rd), tcg_env, addr);
> +    return true;
>  #endif
>  }
>  
> @@ -827,10 +845,13 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
>          return true;
>      }
>  #ifdef CONFIG_USER_ONLY
> -    return true;
> +    g_assert_not_reached();
>  #else
>      TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
> +    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, false);
> +    (mo_endian(dc) == MO_BE ? gen_helper_lwea_be : gen_helper_lwea_le)
> +        (reg_for_write(dc, arg->rd), tcg_env, addr);
> +    return true;
>  #endif
>  }
>  
> @@ -918,10 +939,11 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
>          return true;
>      }
>  #ifdef CONFIG_USER_ONLY
> -    return true;
> +    g_assert_not_reached();
>  #else
>      TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
> +    gen_helper_sbea(tcg_env, reg_for_read(dc, arg->rd), addr);
> +    return true;
>  #endif
>  }
>  
> @@ -949,10 +971,13 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
>          return true;
>      }
>  #ifdef CONFIG_USER_ONLY
> -    return true;
> +    g_assert_not_reached();
>  #else
>      TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
> +    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, true);
> +    (mo_endian(dc) == MO_BE ? gen_helper_shea_be : gen_helper_shea_le)
> +        (tcg_env, reg_for_read(dc, arg->rd), addr);
> +    return true;
>  #endif
>  }
>  
> @@ -980,10 +1005,13 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
>          return true;
>      }
>  #ifdef CONFIG_USER_ONLY
> -    return true;
> +    g_assert_not_reached();
>  #else
>      TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
> +    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, true);
> +    (mo_endian(dc) == MO_BE ? gen_helper_swea_be : gen_helper_swea_le)
> +        (tcg_env, reg_for_read(dc, arg->rd), addr);
> +    return true;
>  #endif
>  }
>  
> -- 
> 2.43.0
> 

