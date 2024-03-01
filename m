Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768BFC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg2uX-0003Mz-Qp; Fri, 01 Mar 2024 08:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rg2uW-0003Mh-3D
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:26:48 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com
 ([40.107.94.70] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rg2uT-0001d7-GG
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:26:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS5cNuJGaK8eGVboCHxJ7RBiG8sdYJ7l10do7bV1zEkpD47nNsCtQclMoHDUpbC+Z2Ed/vEZ9uBERif66YxyGiGBVkcW7NDDX+wFhV47ihzShY5wvEQ5VL6STa3zy31GErUsV6f1J/xVT3PaHx5KzzLT4scuS+ZZEZ54u5qWRte3yGVO4x7jl/CEUpp5QfcebmvJ/ieUTQcwwHgvEV0aWHepdpDRQCuHtNwPEOR6vyqunu+82ek7gy3pMmYHfoPQkgLlnl5KblM0scwRt19e7KWLfuceHTRD98nzR7OEmMBQ9Ruj37ySdQax9o+K2SPDNroUqDQHMzTYkDqOkaj8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS21dAddUUM3aw9BQN1vnoUYVViEZGdA8c+SzbhKVUE=;
 b=CE+joWm5RpGzpLwil3lnOmtSyorPzTZ3ylI3FUsQjA3OxTNQPWpIoASREVBxIOU4Ufo01nRwP7Zt0QaRVQZ5RsCHmljiSwNoqTK5p8pJRqXYM/3uOFIRCXBWO/bx1sARLJp5PSXMRMUEws2KX+7TGFujm+Sdj8++rhSa/RLwtS7o4yUX3zpl8oP9TBZqJSPlnYU6RunwVCY5ZN2vULl3zPyZPFaH3am7ceZvT2E6VLXUdRlvMYQZOW1HY3m/Xf1b1e1RF1YPancaFDw1Srtb2glKhAI60xaSVMLOZVEY9TSrw6zEWKQgc0AgOxcIWfL87/wj+AYOUAftpZUn7wLxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS21dAddUUM3aw9BQN1vnoUYVViEZGdA8c+SzbhKVUE=;
 b=R4kq0jmqdu4ESQrKLFd+pFnHGLRckC3jiw/P35iuGe0h3xWRcQwl4WZDXh4NAbLg1cjHs40Www1mVKcrx/1DYOZuKasVqEHhDf1ol/mRl2Up5Ee7HgtFukv7oOkG+4+/agfy2/EIS0SlUtxNZu9wEHj6VB/pwN5YtYqAtbOwYIk=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 13:21:34 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::ad) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 13:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 1 Mar 2024 13:21:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 07:21:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 07:21:32 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 07:21:30 -0600
Date: Fri, 1 Mar 2024 14:21:28 +0100
From: Luc Michel <luc.michel@amd.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
CC: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 09/12] contrib/plugins/hotblocks: migrate to new
 per_vcpu API
Message-ID: <ZeHWWIe--GpzOVE3@luc-work-vm>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-10-pierrick.bouvier@linaro.org>
 <Zd2_VHB6-G7srfSo@luc-work-vm>
 <e0688c8b-fac2-4b4f-8cda-a0c4f5ee2bf6@linaro.org>
 <Zd3xGrZetKoAbIn1@luc-work-vm> <87il279w7t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il279w7t.fsf@draig.linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 678b00d7-5b67-4ecb-632c-08dc39f283d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1TBp2IaPl1rLrvzby6F/p7GVRTe1fsWLQJQARk6fq09hbJs4scp6HMvPvNRiDkMMwo4GLlenwxpCYzPvNyiVuI3aJV17ng/zNTY2QZIsxRJCp1lDHnRtnyCWPWalhS2yVQEJvXrtUdic63ewLINReqziTTEfXESyPtmHSFtj7bDBTUvJFSMaE2oTQS7HloCYBR5/sUV/LcankxyHUtDhSRgE/PePN4qjqGkRcE5315Jw7bmooyvhqxdNdfF8uQU6ZhgztMIhsX4WE4YWB6R9hEvKf+JqQQaczq2Jw1XX1XhjgIxemH+SVnRIZ9iJagohHOaPD0VWaCQnbp3DY4dRO1AnDXqXviW23Q681SS6YSF0mNdbJeUUpeytzyJLqHodJaGJZMZRoCWATHT81Q6sDDinueRgEoFI6y5JGpMk3zcuYphAPfjMmjkMsM6gdW2wHJq680wuPJU0EhcEphIEbUlX9cuEtBUyNaZH6OnMiYMEpeXWLGD4ihD0Rmg7pQtn3+Pvpt4VfOF/g8oMMPvnJ7z8A3xBDIe51CJf0n6gKz1g74CmB6kZ63sr8RhE9twKfdDmAly2s86ihZzPJGUOgGh4u4bORRZWbZyS/K4S1v1g3H9mi9Plt/bfcBq4Hty6i3HzzOv/HXnsYddmUOa9DRuemVWE2PCjpLdOPn53wiI2fGLxrGmf1H9fScjlEXHymdT020/upcyiRqu9ZWfyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 13:21:33.4702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678b00d7-5b67-4ecb-632c-08dc39f283d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
Received-SPF: softfail client-ip=40.107.94.70; envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On 14:33 Thu 29 Feb     , Alex Bennée wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Luc Michel <luc.michel@amd.com> writes:
> 
> > On 15:09 Tue 27 Feb     , Pierrick Bouvier wrote:
> >> On 2/27/24 2:54 PM, Luc Michel wrote:
> >> > Hi Pierrick,
> >> >
> >> > On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
> >> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> > > ---
> >> > >   contrib/plugins/hotblocks.c | 50 ++++++++++++++++++++++---------------
> >> > >   1 file changed, 30 insertions(+), 20 deletions(-)
> >> > >
> >> > > diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> >> > > index 4de1b134944..02bc5078bdd 100644
> >> > > --- a/contrib/plugins/hotblocks.c
> >> > > +++ b/contrib/plugins/hotblocks.c
> >> > > @@ -34,8 +34,8 @@ static guint64 limit = 20;
> >> > >    */
> >> > >   typedef struct {
> >> > >       uint64_t start_addr;
> >> > > -    uint64_t exec_count;
> >> > > -    int      trans_count;
> >> > > +    struct qemu_plugin_scoreboard *exec_count;
> >> > > +    int trans_count;
> >> > >       unsigned long insns;
> >> > >   } ExecCount;
> >> > >
> >> > > @@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
> >> > >   {
> >> > >       ExecCount *ea = (ExecCount *) a;
> >> > >       ExecCount *eb = (ExecCount *) b;
> >> > > -    return ea->exec_count > eb->exec_count ? -1 : 1;
> >> > > +    uint64_t count_a =
> >> > > +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_count));
> >> > > +    uint64_t count_b =
> >> > > +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_count));
> >> > > +    return count_a > count_b ? -1 : 1;
> >> > > +}
> >> > > +
> >> > > +static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
> >> > > +{
> >> > > +    ExecCount *cnt = value;
> >> > > +    qemu_plugin_scoreboard_free(cnt->exec_count);
> >> > >   }
> >> > >
> >> > >   static void plugin_exit(qemu_plugin_id_t id, void *p)
> >> > > @@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
> >> > >       GList *counts, *it;
> >> > >       int i;
> >> > >
> >> > > -    g_mutex_lock(&lock);
> >> >
> >> > I encountered cases before where the vCPUs continue executing while
> >> > plugin_exit is called. This can happen e.g., when QEMU calls exit(3)
> >> > from one CPU thread. Others will continue to run at the same time the
> >> > atexit callbacks are called.
> >> >
> >> > This also means that you can't really free the resources as you do at
> >> > the end of plugin_exit.
> >> >
> >>
> >> Interesting...
> >>
> >> The current documentation [1] mentions it's the right place to free
> >> resources, and from what I saw, existing plugins assume this too (see
> >> contrib/plugins/cache.c for instance).
> >>
> >> There is probably a bug related to the case you mention, and I'll try to
> >> reproduce this, and see if we can have a proper fix.
> >>
> >> I'm not sure that removing cleanup code from existing plugins is the
> >> right thing to do at the moment, even though there is an existing issue
> >> with some programs.
> >
> > Yes absolutely. The problem is on the QEMU side. FWIW I tried to fix one
> > of those exit cases (semihosted exit syscall) some time ago:
> > https://lore.kernel.org/qemu-devel/20220621125916.25257-1-lmichel@kalray.eu/
> 
> The plugin exit handler should flush all instrumented code:
> 
>   /*
>    * Handle exit from linux-user. Unlike the normal atexit() mechanism
>    * we need to handle the clean-up manually as it's possible threads
>    * are still running. We need to remove all callbacks from code
>    * generation, flush the current translations and then we can safely
>    * trigger the exit callbacks.
>    */
> 
>   void qemu_plugin_user_exit(void)
>   {
>       enum qemu_plugin_event ev;
>       CPUState *cpu;
> 
>       /*
>        * Locking order: we must acquire locks in an order that is consistent
>        * with the one in fork_start(). That is:
>        * - start_exclusive(), which acquires qemu_cpu_list_lock,
>        *   must be called before acquiring plugin.lock.
>        * - tb_flush(), which acquires mmap_lock(), must be called
>        *   while plugin.lock is not held.
>        */
>       start_exclusive();
> 
>       qemu_rec_mutex_lock(&plugin.lock);
>       /* un-register all callbacks except the final AT_EXIT one */
>       for (ev = 0; ev < QEMU_PLUGIN_EV_MAX; ev++) {
>           if (ev != QEMU_PLUGIN_EV_ATEXIT) {
>               struct qemu_plugin_cb *cb, *next;
> 
>               QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>                   plugin_unregister_cb__locked(cb->ctx, ev);
>               }
>           }
>       }
>       CPU_FOREACH(cpu) {
>           qemu_plugin_disable_mem_helpers(cpu);
>       }
>       qemu_rec_mutex_unlock(&plugin.lock);
> 
>       tb_flush(current_cpu);
>       end_exclusive();
> 
>       /* now it's safe to handle the exit case */
>       qemu_plugin_atexit_cb();
>   }
> 
> So you shouldn't see any other instrumentation activity after the
> end_exclusive. However you may see another thread hit its exist handler
> before we complete exiting the system.

OK I was not aware of this. Anyway I encountered those issue a long time
ago. It's probably not relevant anymore.

Thanks

-- 
Luc

> 
> --
> Alex Bennée
> Virtualisation Tech Lead @ Linaro

-- 

