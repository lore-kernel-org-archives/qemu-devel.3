Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2C5C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuI6-0004B4-Lo; Tue, 27 Feb 2024 05:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reuI4-0004Ao-TC
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:02:25 -0500
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reuI2-0006xd-PN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:02:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNbtZNgOL8VCuOFSBXaF0o+31xiSJScXQJsoVG7TB1pp6Dsg4ZxmzeiNAOU7XR0jVtjMz30AN/+2zyJ8E7CND//0PLQxn76qjG7QtVHaylTR7sAHgUzOn4YbzNJsQzryZ0IXQxXRxmrTfeu3/IkXvKswuKvGK6VHsu5JcpaN99H93kT4SE+TrRps/ax811/1MVLOmRV6Srqp8KrzllXnnJvM6JJ5AIk9iMW5TNNHSJ7xiVXe9F+UG/CO2kPpJtUrcUO0GRyAP/6N+L3c4EyrGq6qxygZvHwIcMxnWNMb6DhhfQVYsX6680uAj0cKKSQ22ZHpueMwYpcAybQPgZEAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaZvRZT1hIj9rf/+Sd+EzzjHbOcizQgtTo9QfXSEAYg=;
 b=cCAcJv77FhhEP9njdEykuZoBtQkwaZM6s5XIiG15t1+sqPkil8CookTd5WR01Sb6+PXwdVM7DBeDFf0BwypxvkNgEJhhDfq3pdgSbr9hlBEtleGA77WJ6zEdNoVkeY2+inCMKAIFE8Qtu6uKgNH1Yw7cjPnFhjYF4Ek/UdZHUpWKawl/AQu066Wi4Q+4lCqzoZnnc7j0jRt/T3aCz7I9BUy2fRlsEx468OBDEIMLInThNlMCYeZI++5MV5PbdaIStXck0Vs+/SGkv+vcM2K5Gfod3rcxcgvUxfZrSQc0d9ryYdKZveL+CQsdnhdQ5MVjEbRRrEeBC8S0z5gCDRAXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaZvRZT1hIj9rf/+Sd+EzzjHbOcizQgtTo9QfXSEAYg=;
 b=JyikOoQH5tQ7PwC5VYL0wHuwMDwRFjUPCZRT6p3JKWfV2AFyumV7vMRrdyRo09Sj+Uf4TVF77ivG+qILnHA9HbDMYBUkjKSf+bXjW1zmyoa8m7xt9cPB4SIYhKRb0FPUvSqGG/JKF5ggPNleigiKe/AXdh2TXcPWCX1QR6sUv7A=
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 10:02:17 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::58) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 10:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 10:02:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 04:02:16 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 04:02:15 -0600
Date: Tue, 27 Feb 2024 11:02:08 +0100
From: Luc Michel <luc.michel@amd.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 08/12] tests/plugin/bb: migrate to new per_vcpu API
Message-ID: <Zd2zINRPHXZs_7C_@luc-work-vm>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-9-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226091446.479436-9-pierrick.bouvier@linaro.org>
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a454f1-03f1-4bf0-ee62-08dc377b2e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyE0tYPJgEsyd6ElhsZp9bbNnImAmR8Anc4i0LEoCBcFUHAkGDwRKWd3SHpmjj+4mZAjiapmAL87eqNvqv7H/fUxDwIuxpnWh4Xw2/7Fj5oXWD6PeAyEXsgNEmmgTYHtUfDEOAaHjWgOE34WZRGIVeaBOATIBKTr1fWocZ0aBZtTENcu/TPiE7o6vssAF8EsvKDmq79R3U755yvQvFM1O4qhliikpavWUC0imbZI0NFPy6t0jPow2lOSwGihkJTwpM8AC+TpNauFl4sG5iWUzf1j3WZ9+Q8VP46Sd99FABvBIMJB2/1AKjjurKC4qSlUTKsosax4rYqxORoTmyGJeiO4zamAmEXj8lOQkz9QtmkrVCSi0FlRtylRhboLDlbEEGAcdtZ1dvq4kvZgGwR6g0vvVzxrYexI6HWn8u66LTGwChj4BNGxWmLGFgwSPG1fbIhVTreS46GvA6oJ+uWbxhTAGIGHZjGef5PqXW0S+2gV6h3eYpYzN9RG2wucoeq9iII3tKW2dQFA4u7iJPcXMLYDSDMatd9SoVN3uXlCkbkcanpS8FVIQX1+/cDvIqyksl/tntiRwuP6RPlwjbFziCNCiHsSHfp7P+pc47gyJmWtsHjc7jXEyqwwMOqO1sfQpfPnlsibTSzVYZrWSkqYgQFxsEKFKXP2rzajQs2v+xBMF+XYu8ViIZvOpERHfSFP4fmrs3rzYgZBpvE912xJn17my3/HvYb2BWgmaiegJm6gRqqLoVGuS5KqPLoD+1O5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:02:17.2600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a454f1-03f1-4bf0-ee62-08dc377b2e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
Received-SPF: softfail client-ip=2a01:111:f403:2418::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  tests/plugin/bb.c | 63 +++++++++++++++++++----------------------------
>  1 file changed, 26 insertions(+), 37 deletions(-)
> 
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index df50d1fd3bc..36776dee1e1 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -17,27 +17,25 @@
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
>  typedef struct {
> -    GMutex lock;
> -    int index;
>      uint64_t bb_count;
>      uint64_t insn_count;
>  } CPUCount;
> 
> -/* Used by the inline & linux-user counts */
> +static struct qemu_plugin_scoreboard *counts;
> +static qemu_plugin_u64 bb_count;
> +static qemu_plugin_u64 insn_count;
> +
>  static bool do_inline;
> -static CPUCount inline_count;
> -
>  /* Dump running CPU total on idle? */
>  static bool idle_report;
> -static GPtrArray *counts;
> -static int max_cpus;
> 
> -static void gen_one_cpu_report(CPUCount *count, GString *report)
> +static void gen_one_cpu_report(CPUCount *count, GString *report,
> +                               unsigned int cpu_index)
>  {
>      if (count->bb_count) {
>          g_string_append_printf(report, "CPU%d: "
>                                 "bb's: %" PRIu64", insns: %" PRIu64 "\n",
> -                               count->index,
> +                               cpu_index,
>                                 count->bb_count, count->insn_count);
>      }
>  }
> @@ -46,20 +44,23 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
>      g_autoptr(GString) report = g_string_new("");
> 
> -    if (do_inline || !max_cpus) {
> -        g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
> -                        inline_count.bb_count, inline_count.insn_count);
> -    } else {
> -        g_ptr_array_foreach(counts, (GFunc) gen_one_cpu_report, report);
> +    for (int i = 0; i < qemu_plugin_num_vcpus(); ++i) {
> +        CPUCount *count = qemu_plugin_scoreboard_find(counts, i);
> +        gen_one_cpu_report(count, report, i);
>      }
> +    g_string_append_printf(report, "Total: "
> +                           "bb's: %" PRIu64", insns: %" PRIu64 "\n",
> +                           qemu_plugin_u64_sum(bb_count),
> +                           qemu_plugin_u64_sum(insn_count));
>      qemu_plugin_outs(report->str);
> +    qemu_plugin_scoreboard_free(counts);
>  }
> 
>  static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
>  {
> -    CPUCount *count = g_ptr_array_index(counts, cpu_index);
> +    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
>      g_autoptr(GString) report = g_string_new("");
> -    gen_one_cpu_report(count, report);
> +    gen_one_cpu_report(count, report, cpu_index);
> 
>      if (report->len > 0) {
>          g_string_prepend(report, "Idling ");
> @@ -69,14 +70,11 @@ static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
> 
>  static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>  {
> -    CPUCount *count = max_cpus ?
> -        g_ptr_array_index(counts, cpu_index) : &inline_count;
> +    CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
> 
>      uintptr_t n_insns = (uintptr_t)udata;
> -    g_mutex_lock(&count->lock);
>      count->insn_count += n_insns;
>      count->bb_count++;
> -    g_mutex_unlock(&count->lock);
>  }
> 
>  static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> @@ -84,11 +82,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>      size_t n_insns = qemu_plugin_tb_n_insns(tb);
> 
>      if (do_inline) {
> -        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
> -                                                 &inline_count.bb_count, 1);
> -        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
> -                                                 &inline_count.insn_count,
> -                                                 n_insns);
> +        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +            tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count, 1);
> +        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +            tb, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, n_insns);
>      } else {
>          qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>                                               QEMU_PLUGIN_CB_NO_REGS,
> @@ -121,18 +118,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>          }
>      }
> 
> -    if (info->system_emulation && !do_inline) {
> -        max_cpus = info->system.max_vcpus;
> -        counts = g_ptr_array_new();
> -        for (i = 0; i < max_cpus; i++) {
> -            CPUCount *count = g_new0(CPUCount, 1);
> -            g_mutex_init(&count->lock);
> -            count->index = i;
> -            g_ptr_array_add(counts, count);
> -        }
> -    } else if (!do_inline) {
> -        g_mutex_init(&inline_count.lock);
> -    }
> +    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
> +    bb_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, bb_count);
> +    insn_count = qemu_plugin_scoreboard_u64_in_struct(
> +        counts, CPUCount, insn_count);
> 
>      if (idle_report) {
>          qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
> --
> 2.43.0
> 
> 

-- 

