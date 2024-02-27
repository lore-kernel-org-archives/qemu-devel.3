Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA116C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retwu-0003MZ-9z; Tue, 27 Feb 2024 04:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1retwk-0003Lx-J4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:40:23 -0500
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com
 ([40.107.223.55] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1retwg-0000Zl-AC
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:40:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmIP9znpa+NYEDslcjM95QPw9YQIvwSY4YCEvCS7b3Akimc7T8YFdyGtrPwyMhyeEVQM/01SUeQGFRzgm4iCiSSaxVSmeyuUPVDHwaxDUhKkW6eIYa74toDo9neFJ9SLWRz982I7IYaob76ne1fuFPvaz84Nlwoxn26WjeTObzSvYwb1Bi4FQcWtjgbMUg7F7zq3xUjE5/WkjM3C7Y2A5YN5CE7+Jb6lXp4N2hBtpdbAvc1sVnD+Q9CSWVGdcv3UfSLfaO3/nv3Gb6Jnt9EWr+GAvTQy+W0DJcsgxT1usi+FdghyHcX/KLyoyJGTuPzbSR9v3HlegiojaOJaheWRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XG0TvmfUag7tZ4d7RkMcXy/A/GTqyl50PQlpGke98Y=;
 b=DJ9PcCrHB3kiuuFPaAY1ryraqbfamEnvJQpB5UG0fc74PWtj/0Y9C2x8g4fTtXHRyZ4WqQprg2Tr3ATKK0+dw1btM8q1qNiR4NZ7WczMBNHm4VZ3eAzeK48E5/dYdnKq4rf9x5SNamKbZSiIXwZlPski/MHWtH+lS/ivPa4EWi3T8eNyKlnlzqoQMXNlHBNFz3oe9UedaryirAT9Kp1aBT3xRmWHqsgZCixufDr5b8p41XyG6kxEqtu3nIYGrGWtbtYafv/u8ykSEDyWNzALhY/g8fqCmw19Io9yT9AKDlDQhFUyvAvG5vaY+tiPMkH+k+y4LuDFdXopndwSFC71/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XG0TvmfUag7tZ4d7RkMcXy/A/GTqyl50PQlpGke98Y=;
 b=MQIbzk1+WfG5Pw1bg20mcL6nZguIxBPm9B4Xdo5bSswWJc0QSRkNfB6jkfRNp8pXk1wST6Z6Q9PfUvnW4pg2qTgBlGYCleuAoNZCvUHsdIF3bQOef/SjndcX+qdyvlMMurl9T0WfwZszBZOk16WZnqvI+qawiF8P5HR+IDqvx3E=
Received: from SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) by PH8PR12MB7160.namprd12.prod.outlook.com
 (2603:10b6:510:228::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 09:35:07 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::c9) by SN6PR2101CA0003.outlook.office365.com
 (2603:10b6:805:106::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.11 via Frontend
 Transport; Tue, 27 Feb 2024 09:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 09:35:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 03:35:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 03:35:06 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 03:35:05 -0600
Date: Tue, 27 Feb 2024 10:35:02 +0100
From: Luc Michel <luc.michel@amd.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
Message-ID: <Zd2sxjxegajy7ZbF@luc-work-vm>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226091446.479436-7-pierrick.bouvier@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: a991fd8e-5b02-42cc-5805-08dc377762a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIuIPvFmySBAdBOtWPLnAzkDUiFYR6ubohn/CsRFPNiTWgN6Pr52p9zgOlDfThYm5iKKLr7pSv8Yjxu/ZZSJUpAralMncTgezyWw+LbhRsBxvdbraZj25fyZ8BpHGPKmr3RCGsvZoGgD74SHnDVZI6DKnPEF79h03e716tKZG0qXRGyBqUUqxmBR/Mzu5QORt7mp2E+pdnP/PYy0AQH0GuxU6WdiMGjeBPKLAL0oMK9bkICojnkqbs8mQ/vV7kKr6wmuOgkKsRXAMpy7ehBaztp4FkcYAcRD6v9Sqg5GghhkdWa0u0c91GBQNep/NPy1vUX9usMuw2X34KcRDvAMaUJSp6Ps5lNARX3ImT3h91ew8f4eB0z7KwE524XCAmisDnsswZCUYSa4d0tmabKGog6X2zqGtxjkqbfXt72S92tQpu4RHRdy7TYqXBTd92RnBql2xKrM7kJWBuBJHWUQ5HcBf+KDNTyya0A4gdgif0WFo4wRYmL6tRyXbKZN2j/Tg99biSU5zYPlCoPSZr+NP2EQTk90JnmeXxcfxtW3qj7KgSQGmgLdWDSSKv09qdr3Jk+4RH/l1obDN7y9lxgD6O6yLHgxQy0VLVm4lCQNueYN9uvg/h3zS9fFT6+aB9d/nYmQd4A03awt+LRSQGywaFNZx4WwFKBXy9AOswbmzIl1chhajHnVYobQ+IEJKQIyEiNaqT37HAv1lwihjhPKLgDB523x2u8O+kFj8PZRT2+OCq2axlYz0NLfXvIFgR2j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 09:35:07.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a991fd8e-5b02-42cc-5805-08dc377762a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
Received-SPF: softfail client-ip=40.107.223.55;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>  tests/plugin/mem.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
> index 44e91065ba7..d4729f5e015 100644
> --- a/tests/plugin/mem.c
> +++ b/tests/plugin/mem.c
> @@ -16,9 +16,14 @@
> 
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
> -static uint64_t inline_mem_count;
> -static uint64_t cb_mem_count;
> -static uint64_t io_count;
> +typedef struct {
> +    uint64_t mem_count;
> +    uint64_t io_count;
> +} CPUCount;
> +
> +static struct qemu_plugin_scoreboard *counts;
> +static qemu_plugin_u64 mem_count;
> +static qemu_plugin_u64 io_count;

I see that you merged inline and callback counts into the same variable.

I wonder... For this test don't you want to keep a plain uint64_t for
callback counts? I have the feeling that this test was made so one can
make sure inline and callback counts match.

Luc

>  static bool do_inline, do_callback;
>  static bool do_haddr;
>  static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
> @@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
>      g_autoptr(GString) out = g_string_new("");
> 
> -    if (do_inline) {
> -        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inline_mem_count);
> -    }
> -    if (do_callback) {
> -        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\n", cb_mem_count);
> +    if (do_inline || do_callback) {
> +        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
> +                        qemu_plugin_u64_sum(mem_count));
>      }
>      if (do_haddr) {
> -        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
> +        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
> +                               qemu_plugin_u64_sum(io_count));
>      }
>      qemu_plugin_outs(out->str);
> +    qemu_plugin_scoreboard_free(counts);
>  }
> 
>  static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
> @@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>          struct qemu_plugin_hwaddr *hwaddr;
>          hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
>          if (qemu_plugin_hwaddr_is_io(hwaddr)) {
> -            io_count++;
> +            qemu_plugin_u64_add(io_count, cpu_index, 1);
>          } else {
> -            cb_mem_count++;
> +            qemu_plugin_u64_add(mem_count, cpu_index, 1);
>          }
>      } else {
> -        cb_mem_count++;
> +        qemu_plugin_u64_add(mem_count, cpu_index, 1);
>      }
>  }
> 
> @@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>          struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> 
>          if (do_inline) {
> -            qemu_plugin_register_vcpu_mem_inline(insn, rw,
> -                                                 QEMU_PLUGIN_INLINE_ADD_U64,
> -                                                 &inline_mem_count, 1);
> +            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
> +                insn, rw,
> +                QEMU_PLUGIN_INLINE_ADD_U64,
> +                mem_count, 1);
>          }
>          if (do_callback) {
>              qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
> @@ -117,6 +123,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>          }
>      }
> 
> +    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
> +    mem_count = qemu_plugin_scoreboard_u64_in_struct(
> +        counts, CPUCount, mem_count);
> +    io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>      return 0;
> --
> 2.43.0
> 
> 

-- 

