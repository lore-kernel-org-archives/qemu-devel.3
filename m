Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C080C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyRG-0006tM-GX; Tue, 27 Feb 2024 09:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reyRD-0006ps-L5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:28:07 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reyR7-0006us-Ho
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:28:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdN+r4MqXZN/qShnqlIB/pAS+4oQ0YX6kP87dft+ZewrTFxtHvAKg/nuAI+7FSLUplzheMzSzWyRGwhkoGa7SL/hZ9iXmimH6krdLICliFI0UuaiFIy5S+oZEBx0gxI6/RxKLJDrQszXxjmxfuQ4Ajjmri3jQtCLPEKTio7PjMeOD6Hth0ASHwPy4YldcBtIGbQ0rzSghZqqsYZuWsGQuvb8KoAwdzHsB+t5AnGa7wTilH++2S0xpWlL9+/vU+GPZ0qBso+klhT6STWKF7qz+cfSAqIC3YdEUE1y6DkPTCgM62sEezr/4m3i2OLdOqFRL8vhaz392clocAXm8dE8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34DbvKuJRWTvcP5FWe7R9pXSRs0pZjhRW8ik4cd+mmc=;
 b=H319bY3Crlp+qk5Jo5vJuSV9wMwVNXQ0WDUR4DhJBMZatapKpc7a+mmdD02ou1IKilSj/46naRtpLrx2c20RmIBoVthEp7W6IjofIYMa8xIpe0ZIHhqKY1GG/AVLLMKvvPUtcF8OaRUBHTOabCKGQkEtkAsrVJ8jd33VUzOhqq4dCAvhZTKFkuUD1f/Rvok/a5L6YR7P3roZ4XtvBEgFs6iObLfqG02HFnvmP1R7hC6c9GqpMRnbKHweD1Ov7R97DcLn+f1fDysCe8dzl4yLKD5yAd/gzc1ZSAVphBKv3KgIB3r4UhbBF/CC1J8Z8/DTW0VU7sFiQeUdcd+TRxRstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34DbvKuJRWTvcP5FWe7R9pXSRs0pZjhRW8ik4cd+mmc=;
 b=JvfWNokQJcpMQVX6BqID15wMMBKbtHTQCFV5x7B1Ti0CH981WQ0n94JKp93bROkq44FbxPvipP+ZqTnsZEqrPiqllgmLc4tfyO9bBzo0bTa7swjQX1wuYbdcbqGNlSqiZmlLh1TGQg3ZHVPK0DSur99FCplcTrdrxhG7a90rCdc=
Received: from SN7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::22)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 14:27:55 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::3c) by SN7P222CA0005.outlook.office365.com
 (2603:10b6:806:124::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 14:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 14:27:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 08:27:52 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 08:27:49 -0600
Date: Tue, 27 Feb 2024 15:27:43 +0100
From: Luc Michel <luc.michel@amd.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
Message-ID: <Zd3xXyGG39czU7AL@luc-work-vm>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm>
 <354a01af-c2e2-4f24-80a5-158547015805@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <354a01af-c2e2-4f24-80a5-158547015805@linaro.org>
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: d226597f-56e7-444f-bbc1-08dc37a04854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsnMyrf1zsuCsF5Nzy9SeXT83BdqKukf5Bn+idtjNbKfh9EWqtIOMySMvLsy2NRQtarQgH4rFckbcm//pxhRzZ0NYWUnmweYxsdhRREkHeeGXWcJqEWdYQLjwPhdUwQj39KScx/uvwaLJGnI1y74usm43H6v1srU0CFL90aJYkD3pAo9uBOUsG40UD6zPbhGRfAW3D3fgMTqipi93O27T259NEBMfuzhriPoeJOREPrTV+0u+hhmPaCIUq+E8GhdLWT51+nN/siIntz8fb3XWbKjW4WM5ID3+vaJVsJrVf7sB56PI3F64u1FIavosZS4izr5uH4GyZi6tR99PFjkecncs8wzFTaKeIcnC+BzN71Ql6XGbPyzsJn+0Viqbafc09hIjw8Sq1MElpHlswJsq3/8FZaTsfIV/NVTkj647waGxXjDHttAmZuG3Yi/lhDlDjRufZnaALt2cnq7LJlYeP4SeytUHVyUaAMEoj3Cc7kpVaeemblYcJDS8VSRt/JzIvQ4BdARjZOFfpVVTDx/a9ei++Rjh0Yj/H1k0S9E86IMsmp6bSi5c38Tj6b1NRyOMg1LRoWobkU1Woqy4o9CgYXDLHg21xytLgTmY9EoYI91X+xEIkadl/53YK520FrDnA2wGac5Ngzo4qs34ULTJy+ogzx9yEsBvq3/nZ2eBb95O95i4X44pEjF1A6b/GmDFXBhnfgM8H2JBbxDdqJg+6z9xUIgn2/CCsaZ2ZWYf3AWbjdV3F2n+4V+JfMsZS2Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 14:27:52.6950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d226597f-56e7-444f-bbc1-08dc37a04854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On 14:56 Tue 27 Feb     , Pierrick Bouvier wrote:
> Hi Luc,
> 
> On 2/27/24 1:35 PM, Luc Michel wrote:
> > Hi Pierrick,
> > 
> > On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > ---
> > >   tests/plugin/mem.c | 40 +++++++++++++++++++++++++---------------
> > >   1 file changed, 25 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
> > > index 44e91065ba7..d4729f5e015 100644
> > > --- a/tests/plugin/mem.c
> > > +++ b/tests/plugin/mem.c
> > > @@ -16,9 +16,14 @@
> > > 
> > >   QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> > > 
> > > -static uint64_t inline_mem_count;
> > > -static uint64_t cb_mem_count;
> > > -static uint64_t io_count;
> > > +typedef struct {
> > > +    uint64_t mem_count;
> > > +    uint64_t io_count;
> > > +} CPUCount;
> > > +
> > > +static struct qemu_plugin_scoreboard *counts;
> > > +static qemu_plugin_u64 mem_count;
> > > +static qemu_plugin_u64 io_count;
> > 
> > I see that you merged inline and callback counts into the same variable.
> > 
> > I wonder... For this test don't you want to keep a plain uint64_t for
> > callback counts? I have the feeling that this test was made so one can
> > make sure inline and callback counts match.
> > 
> 
> Indeed, the new API guarantees thread safety (current inline
> implementation was racy), so this plugin now gives the exact same result
> whether you use inline ops or callbacks. In more, callback based
> approach can be implemented without any lock, as we are counting per
> vcpu. Thus, it's faster and safer.
> 
> Regarding the "testing" side, this series introduce a new plugin
> tests/plugin/inline.c that allows to test all thoses cases in a single
> plugin. Thus, it's not needed that other plugins offer a way to test this.

I see! Then:

Reviewed-by: Luc Michel <luc.michel@amd.com>

> 
> Thanks for your review.
> 
> > Luc
> > 
> > >   static bool do_inline, do_callback;
> > >   static bool do_haddr;
> > >   static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
> > > @@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
> > >   {
> > >       g_autoptr(GString) out = g_string_new("");
> > > 
> > > -    if (do_inline) {
> > > -        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inline_mem_count);
> > > -    }
> > > -    if (do_callback) {
> > > -        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\n", cb_mem_count);
> > > +    if (do_inline || do_callback) {
> > > +        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
> > > +                        qemu_plugin_u64_sum(mem_count));
> > >       }
> > >       if (do_haddr) {
> > > -        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
> > > +        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
> > > +                               qemu_plugin_u64_sum(io_count));
> > >       }
> > >       qemu_plugin_outs(out->str);
> > > +    qemu_plugin_scoreboard_free(counts);
> > >   }
> > > 
> > >   static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
> > > @@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
> > >           struct qemu_plugin_hwaddr *hwaddr;
> > >           hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
> > >           if (qemu_plugin_hwaddr_is_io(hwaddr)) {
> > > -            io_count++;
> > > +            qemu_plugin_u64_add(io_count, cpu_index, 1);
> > >           } else {
> > > -            cb_mem_count++;
> > > +            qemu_plugin_u64_add(mem_count, cpu_index, 1);
> > >           }
> > >       } else {
> > > -        cb_mem_count++;
> > > +        qemu_plugin_u64_add(mem_count, cpu_index, 1);
> > >       }
> > >   }
> > > 
> > > @@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> > >           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> > > 
> > >           if (do_inline) {
> > > -            qemu_plugin_register_vcpu_mem_inline(insn, rw,
> > > -                                                 QEMU_PLUGIN_INLINE_ADD_U64,
> > > -                                                 &inline_mem_count, 1);
> > > +            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
> > > +                insn, rw,
> > > +                QEMU_PLUGIN_INLINE_ADD_U64,
> > > +                mem_count, 1);
> > >           }
> > >           if (do_callback) {
> > >               qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
> > > @@ -117,6 +123,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> > >           }
> > >       }
> > > 
> > > +    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
> > > +    mem_count = qemu_plugin_scoreboard_u64_in_struct(
> > > +        counts, CPUCount, mem_count);
> > > +    io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
> > >       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> > >       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> > >       return 0;
> > > --
> > > 2.43.0
> > > 
> > > 
> > 

-- 

