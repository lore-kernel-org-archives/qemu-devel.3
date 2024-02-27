Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512E3C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rev6Y-0000DH-HO; Tue, 27 Feb 2024 05:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rev6T-0000Ck-Mu
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:54:29 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rev6R-0003cu-Mc
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:54:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5qMA9WjAZCTAagavF7RBvqipo9W535dJ0zoawrPID4D16tAR85DbrmZ1SS00M4szYSSgIkorVkRtAHw4InTnILCkMkrkDGCzFillwbNzoI23lrKXj1xY8Xu1N6yQcHDhIKUTEZPAKSm4WpKfDrtqQE5Vt7JofkXu3nhMAJG8t5L/F9i3OXJh8dLj27/zH0f7VYGvuq2Il4FzLlN4wuPg+BwDPi3jxQngBI33d1Bw84xfIDjjCNdLN2A8PUier+EscMpKVYQ8jVz3Wjkjx3v2qEfCaakV+xGVrdMPMTpSJowdvAzfPklLWlhOqmgqbV0U8VtBpYHe9LaGtNtfAjP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHgiqamjz1eC2rBJUp7CcJ4zrxd7thjfnOMgM1nOQJw=;
 b=F2CkPj2za8sbGdBx3TxHynYVVVd7u8awZhhjLGluOw7CWgQuUWPkwdZQel2Npz0wJvZT73QB+0QwNbw5VQW848BQR+n/zdMAWx3bQ5ml0GR9enyDtnt7Pf67wJBhF3O5Is4TGay/21QAx+Fq7f9dJ/+8QFIH5j5J/F7P2RUSmtIN0KRAm5rjCvkp3eOXaSsaptpIi6oLET0VH0OCpEMD4QTHEatTpRrEZNul9kD2fRV+fDT2lyz97bNuCggysSMZYYJh5nqmwaIA2ekZc9Cr8/3Defsb9RPNqgwm0zAOxR8iH894L6/Y48NE/Hu8mafeh7HHYSZywZoicgmAapxbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHgiqamjz1eC2rBJUp7CcJ4zrxd7thjfnOMgM1nOQJw=;
 b=WSd//cHPOSOEIjZIsv+rO1Lk7sf2OL1r6Q0q1ZfCAidECZKJNdwkrYRX8OeKjp91L4w+/gfhTgF6eR7RSmFLzNU9WqKBaNqhi0ZyD6btWJJOKNit6q443jYrPBQ8A0SPUvAE2fMj8BGWy7ElIIbrqEEJUpoi9S2GW8JHnYdmHRA=
Received: from CY8PR12CA0069.namprd12.prod.outlook.com (2603:10b6:930:4c::14)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 10:54:18 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::c2) by CY8PR12CA0069.outlook.office365.com
 (2603:10b6:930:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 10:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 10:54:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 04:54:16 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 04:54:14 -0600
Date: Tue, 27 Feb 2024 11:54:12 +0100
From: Luc Michel <luc.michel@amd.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 09/12] contrib/plugins/hotblocks: migrate to new
 per_vcpu API
Message-ID: <Zd2_VHB6-G7srfSo@luc-work-vm>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-10-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226091446.479436-10-pierrick.bouvier@linaro.org>
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: af058809-c7bf-40fa-6c2d-08dc378271b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uC/j0lcliiD2cHj3uXSA9P3ms/c2FCTBEpvhiGfxXc3jq95nVgzbJcCLzZQQVVcXNxOPnmFuRgHlXF9xlKASr/fyrA0GDrhshGS6eUDOmQLd1mDKqy6zrssR6pJ144mHd2Yrq2y6QiQQUxmdZWQ3FVZaLCf1MF/DFTeWP4hMSUvDu6HO7L55YCT223ytm/QXAiJQSJLpeRGph3Il8QGc+qTLGjBWkHVwOL/rEJBvgmTHmvRvPxIhz6zuM9qZEilUPJq6obyX70wsQGpKGpnX95OnTtJJIqYGZikY+RN3ZpJMmShSh7THthBEZV6J9yYMZcWJwR2qF7eBlI/P5ohDZfMWV0UZhubFMhm8lN4T9m9m2guni/LVUBA41VNkWOvAbCHJxoO4UfHLm/KWmZ3Rb24rW9vHJgVgP7SbNa3dcd0I2ADguarZ3890yHuFAX7bMXrZIwkWf4YY71TNwwoZ2YLmY5OlTKyQvEl0KjVCII1u+801kqfcJJo4Unx6sPtW3s3JwSbC+T2eu4ajD9+AeNYFIC+5nohUkMC6RaXyIWwrEc9FaTd4soqLcnKVp0cvy7cZrz/e9QJI8bVMbMrfdE4neTxMHeQ9QyflKSRzkmbom9N/bvKdiQDUmaOFEhnRg2/zRd2qrc+xznLGUIW1K3R7hyj9dZP8d5a/Nw1OzdTvdnk964D8+oQa5Cq63n+4uXY/7tyrquViEFHHn0N/1HyTK3MUvlU/AkOttEwxbTVi8bS9t0Ab5MM+S0VK9Lo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:54:17.1403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af058809-c7bf-40fa-6c2d-08dc378271b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
Received-SPF: softfail client-ip=2a01:111:f403:2414::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi Pierrick,

On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  contrib/plugins/hotblocks.c | 50 ++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 4de1b134944..02bc5078bdd 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -34,8 +34,8 @@ static guint64 limit = 20;
>   */
>  typedef struct {
>      uint64_t start_addr;
> -    uint64_t exec_count;
> -    int      trans_count;
> +    struct qemu_plugin_scoreboard *exec_count;
> +    int trans_count;
>      unsigned long insns;
>  } ExecCount;
> 
> @@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
>  {
>      ExecCount *ea = (ExecCount *) a;
>      ExecCount *eb = (ExecCount *) b;
> -    return ea->exec_count > eb->exec_count ? -1 : 1;
> +    uint64_t count_a =
> +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_count));
> +    uint64_t count_b =
> +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_count));
> +    return count_a > count_b ? -1 : 1;
> +}
> +
> +static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
> +{
> +    ExecCount *cnt = value;
> +    qemu_plugin_scoreboard_free(cnt->exec_count);
>  }
> 
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
> @@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>      GList *counts, *it;
>      int i;
> 
> -    g_mutex_lock(&lock);

I encountered cases before where the vCPUs continue executing while
plugin_exit is called. This can happen e.g., when QEMU calls exit(3)
from one CPU thread. Others will continue to run at the same time the
atexit callbacks are called.

This also means that you can't really free the resources as you do at
the end of plugin_exit.

>      g_string_append_printf(report, "%d entries in the hash table\n",
>                             g_hash_table_size(hotblocks));
>      counts = g_hash_table_get_values(hotblocks);
> @@ -63,16 +72,21 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
> 
>          for (i = 0; i < limit && it->next; i++, it = it->next) {
>              ExecCount *rec = (ExecCount *) it->data;
> -            g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
> -                                   rec->start_addr, rec->trans_count,
> -                                   rec->insns, rec->exec_count);
> +            g_string_append_printf(
> +                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
> +                rec->start_addr, rec->trans_count,
> +                rec->insns,
> +                qemu_plugin_u64_sum(
> +                    qemu_plugin_scoreboard_u64(rec->exec_count)));
>          }
> 
>          g_list_free(it);
>      }
> -    g_mutex_unlock(&lock);
> 
>      qemu_plugin_outs(report->str);
> +
> +    g_hash_table_foreach(hotblocks, exec_count_free, NULL);
> +    g_hash_table_destroy(hotblocks);
>  }
> 
>  static void plugin_init(void)
> @@ -82,15 +96,9 @@ static void plugin_init(void)
> 
>  static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>  {
> -    ExecCount *cnt;
> -    uint64_t hash = (uint64_t) udata;
> -
> -    g_mutex_lock(&lock);
> -    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
> -    /* should always succeed */
> -    g_assert(cnt);
> -    cnt->exec_count++;
> -    g_mutex_unlock(&lock);
> +    ExecCount *cnt = (ExecCount *)udata;
> +    qemu_plugin_u64_add(qemu_plugin_scoreboard_u64(cnt->exec_count),
> +                        cpu_index, 1);
>  }
> 
>  /*
> @@ -114,18 +122,20 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>          cnt->start_addr = pc;
>          cnt->trans_count = 1;
>          cnt->insns = insns;
> +        cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
>          g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
>      }
> 
>      g_mutex_unlock(&lock);
> 
>      if (do_inline) {
> -        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
> -                                                 &cnt->exec_count, 1);
> +        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +            tb, QEMU_PLUGIN_INLINE_ADD_U64,
> +            qemu_plugin_scoreboard_u64(cnt->exec_count), 1);
>      } else {
>          qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>                                               QEMU_PLUGIN_CB_NO_REGS,
> -                                             (void *)hash);
> +                                             (void *)cnt);
>      }
>  }
> 
> --
> 2.43.0
> 
> 

-- 

