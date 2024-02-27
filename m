Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EA0C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reu6k-0007Q5-Da; Tue, 27 Feb 2024 04:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reu6g-0007NN-Vj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:50:40 -0500
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reu6d-0003oZ-O5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:50:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7CmyExLjqeXyoYfmcHhymvbVe5AGdRMgplPR+84VY+iX0iJpK1rNOlHGHx6cf+ExE3Q5DPuKsmQr9N3pq5ogkxsa8t/Kssc/1BtpFDwvW26VJCEWhTVAOwJV/c6KiPeg/HrUrZHrOd5IbePpy8V+ipE7iGpz/hxucHcWo5U8zFUGPtztPKu1ckIrGmnrMkT9O89ejwqGFjRImYi7EGUuWTRMPXEI+Ld+VniQax6+jUICJ0ze8AdqfJ80YtstqE1q01MoBCsd0+pznB02DEyXO0/Q3568Zztwg0mDRbB8+qW5NLqg50fkJMv0vPF4B0P8ldIFFw6cHlht7j5+aJMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIz/hQ8R1S6DOpj5EY9GZL0i3nOCnKBFZOxlF+JnLk4=;
 b=ZxklmlXIkg8IQhYI7uh+oJG/Fb3mK/rY99E+5wCuHyM451+eSnNwyX+aWtftAY9UyF+vqthcyI+RuqEQYuogJzU4WCzyZ7abcb8sdPkESQSa2vT1t0EuGju+m4b2ggi1a34CGp6bEn/U70qY/kTB+cq7g91m+EP24ujgsn3aT8Imzjfd9ozAPYsh8VKfF96vvqFIg0YefXclTc63EkrKIduSmwqWMZ0ifHmpqNxapIy1500Ey8bcKHHEZceQ7/6YyWe4KdBgB38+vTGtJ7ig5VU0vNXAOKd4P9lvWSjzjmjHzxZrurUBPzcKXTk/vKLXx2h0lcS/5WPooTh3ajVmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIz/hQ8R1S6DOpj5EY9GZL0i3nOCnKBFZOxlF+JnLk4=;
 b=OfRmyUWA7JDUw8L0lwS4nO1161nCmzLaINQ07MZioGYElSGQRHDOHY3xfY/6au73tANgD160NywtKdyjEopBnphhSLZqF23pp7dTBMyzw82fbNXmn2vPrcrO2kRulkRc++pAUdQmaz5mBdZTLsnboRgUa9jKpVQCJF6mDKcYHO4=
Received: from BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 09:50:31 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::78) by BL1P223CA0010.outlook.office365.com
 (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 09:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 09:50:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 03:50:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 03:50:30 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 03:50:28 -0600
Date: Tue, 27 Feb 2024 10:50:21 +0100
From: Luc Michel <luc.michel@amd.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v5 07/12] tests/plugin/insn: migrate to new per_vcpu API
Message-ID: <Zd2wXT2La-4dKh-0@luc-work-vm>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-8-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226091446.479436-8-pierrick.bouvier@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 79680dc5-42b5-4bc3-00c2-08dc37798922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqvPbjQxGan5BZPmUIg+tSvNHVFa8ejTPV6CO2K+sh5P048LnIalkeVL5w76eiW3BRczVdcR8R3kc4muTY+w3KRpqaXnv7ftQ9lqteyv5C4aHzTgk3xVBwebaG9H4xh0qQnxCFm8PpMSmWpV1Hf/YqCtegu25AMPBgOkLHvSrcrtfho6PZs7D7AQRIi4bxrZT5Y9vFjwIGzkebkHkE5xwLHbg3GfkyleES+bIqnMb6kiE0dqQcvy2YBUeS91B7Z+eBZMD9jxS4m5PNSoRr4L1s8ANPtQnbxo3O40gNUyisw/06yK9iG5tvZx0E988AbZRGyeUnvHqVpDPihP8vBkHDNjapIQiRda8qhMiFL/KOYmE6S1NxO6ZpSiolRFPEBYu5XhgNdj+xT7vta9DHoScnCKoNcZ/7r11bkBQVxQQTZEO6hEaX7NAhpU2EQNgb/pnDrpT/XvXbJH3AFdaSHKpTsIVo8W73cRjmqWl04GDXSOGMPvX/KsSe2+C4uwGaH6D1lr/7yEb0Ca24ax9C47JYHLQGR4Phb5vqkRTO2i83SoJxbxIQvKxHizRpclFD4pDAJTAD2QIfS9lBTbSUSh3xfbWX5qK/vZ8bosa6AXy/AE+wtz2wJ16wwynvdDkc1D+jSyf4eoJa0UAKzZAxHyfFQ3Wn7QhoAKd6HbZwpaD1MvVULLlQoer3TJEfZsspAsCP+G0q1ickoyTT/CrbD7tPU2tr7aPcQSCUm82CpmXyDaijqEapyjb+WqVKULhU+R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 09:50:31.0576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79680dc5-42b5-4bc3-00c2-08dc37798922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
>  tests/plugin/insn.c | 106 +++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 56 deletions(-)
> 
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index 54da06fcf26..5e0aa03223e 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -16,25 +16,21 @@
> 
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
> -#define MAX_CPUS 8 /* lets not go nuts */
> -
> -typedef struct {
> -    uint64_t insn_count;
> -} InstructionCount;
> -
> -static InstructionCount counts[MAX_CPUS];
> -static uint64_t inline_insn_count;
> +static qemu_plugin_u64 insn_count;
> 
>  static bool do_inline;
>  static bool do_size;
>  static GArray *sizes;
> 
> +typedef struct {
> +    uint64_t hits;
> +    uint64_t last_hit;
> +    uint64_t total_delta;
> +} MatchCount;
> +
>  typedef struct {
>      char *match_string;
> -    uint64_t hits[MAX_CPUS];
> -    uint64_t last_hit[MAX_CPUS];
> -    uint64_t total_delta[MAX_CPUS];
> -    GPtrArray *history[MAX_CPUS];
> +    struct qemu_plugin_scoreboard *counts; /* MatchCount */
>  } Match;
> 
>  static GArray *matches;
> @@ -67,41 +63,40 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> 
>  static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
>  {
> -    unsigned int i = cpu_index % MAX_CPUS;
> -    InstructionCount *c = &counts[i];
> -
> -    c->insn_count++;
> +    qemu_plugin_u64_add(insn_count, cpu_index, 1);
>  }
> 
>  static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
>  {
> -    unsigned int i = cpu_index % MAX_CPUS;
>      Instruction *insn = (Instruction *) udata;
> -    Match *match = insn->match;
> +    Match *insn_match = insn->match;
> +    MatchCount *match = qemu_plugin_scoreboard_find(insn_match->counts,
> +                                                    cpu_index);
> +
>      g_autoptr(GString) ts = g_string_new("");
> 
>      insn->hits++;
>      g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
>                             insn->vaddr, insn->disas, insn->hits);
> 
> -    uint64_t icount = counts[i].insn_count;
> -    uint64_t delta = icount - match->last_hit[i];
> +    uint64_t icount = qemu_plugin_u64_get(insn_count, cpu_index);
> +    uint64_t delta = icount - match->last_hit;
> 
> -    match->hits[i]++;
> -    match->total_delta[i] += delta;
> +    match->hits++;
> +    match->total_delta += delta;
> 
>      g_string_append_printf(ts,
> -                           ", %"PRId64" match hits, "
> -                           "Δ+%"PRId64 " since last match,"
> +                           " , cpu %u,"
> +                           " %"PRId64" match hits,"
> +                           " Δ+%"PRId64 " since last match,"
>                             " %"PRId64 " avg insns/match\n",
> -                           match->hits[i], delta,
> -                           match->total_delta[i] / match->hits[i]);
> +                           cpu_index,
> +                           match->hits, delta,
> +                           match->total_delta / match->hits);
> 
> -    match->last_hit[i] = icount;
> +    match->last_hit = icount;
> 
>      qemu_plugin_outs(ts->str);
> -
> -    g_ptr_array_add(match->history[i], insn);
>  }
> 
>  static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> @@ -113,8 +108,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>          struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> 
>          if (do_inline) {
> -            qemu_plugin_register_vcpu_insn_exec_inline(
> -                insn, QEMU_PLUGIN_INLINE_ADD_U64, &inline_insn_count, 1);
> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
>          } else {
>              uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
>              qemu_plugin_register_vcpu_insn_exec_cb(
> @@ -136,10 +131,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           * information about the instruction which we also need to
>           * save if there is a hit.
>           */
> -        if (matches) {
> +        if (matches->len) {
>              char *insn_disas = qemu_plugin_insn_disas(insn);
> -            int j;
> -            for (j = 0; j < matches->len; j++) {
> +            for (int j = 0; j < matches->len; j++) {
>                  Match *m = &g_array_index(matches, Match, j);
>                  if (g_str_has_prefix(insn_disas, m->match_string)) {
>                      Instruction *rec = g_new0(Instruction, 1);
> @@ -169,36 +163,33 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>                                         "len %d bytes: %ld insns\n", i, *cnt);
>              }
>          }
> -    } else if (do_inline) {
> -        g_string_append_printf(out, "insns: %" PRIu64 "\n", inline_insn_count);
>      } else {
> -        uint64_t total_insns = 0;
> -        for (i = 0; i < MAX_CPUS; i++) {
> -            InstructionCount *c = &counts[i];
> -            if (c->insn_count) {
> -                g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
> -                                       i, c->insn_count);
> -                total_insns += c->insn_count;
> -            }
> +        for (i = 0; i < qemu_plugin_num_vcpus(); i++) {
> +            g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
> +                                   i, qemu_plugin_u64_get(insn_count, i));
>          }
>          g_string_append_printf(out, "total insns: %" PRIu64 "\n",
> -                               total_insns);
> +                               qemu_plugin_u64_sum(insn_count));
>      }
>      qemu_plugin_outs(out->str);
> +
> +    qemu_plugin_scoreboard_free(insn_count.score);
> +    for (i = 0; i < matches->len; ++i) {
> +        Match *m = &g_array_index(matches, Match, i);
> +        g_free(m->match_string);
> +        qemu_plugin_scoreboard_free(m->counts);
> +    }
> +    g_array_free(matches, TRUE);
> +    g_array_free(sizes, TRUE);
>  }
> 
> 
>  /* Add a match to the array of matches */
>  static void parse_match(char *match)
>  {
> -    Match new_match = { .match_string = match };
> -    int i;
> -    for (i = 0; i < MAX_CPUS; i++) {
> -        new_match.history[i] = g_ptr_array_new();
> -    }
> -    if (!matches) {
> -        matches = g_array_new(false, true, sizeof(Match));
> -    }
> +    Match new_match = {
> +        .match_string = g_strdup(match),
> +        .counts = qemu_plugin_scoreboard_new(sizeof(MatchCount)) };
>      g_array_append_val(matches, new_match);
>  }
> 
> @@ -206,6 +197,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                             const qemu_info_t *info,
>                                             int argc, char **argv)
>  {
> +    matches = g_array_new(false, true, sizeof(Match));
> +    /* null terminated so 0 is not a special case */
> +    sizes = g_array_new(true, true, sizeof(unsigned long));
> +
>      for (int i = 0; i < argc; i++) {
>          char *opt = argv[i];
>          g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> @@ -227,9 +222,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>          }
>      }
> 
> -    if (do_size) {
> -        sizes = g_array_new(true, true, sizeof(unsigned long));
> -    }
> +    insn_count = qemu_plugin_scoreboard_u64(
> +        qemu_plugin_scoreboard_new(sizeof(uint64_t)));
> 
>      /* Register init, translation block and exit callbacks */
>      qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> --
> 2.43.0
> 
> 

-- 

