Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B954C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyQ1-0005oZ-5J; Tue, 27 Feb 2024 09:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reyPy-0005mg-8b
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:26:50 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1reyPt-0006lg-Ql
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:26:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3CeFDQ2Dm0CQUQIEDUpoTokM/f99JNWcCt6CI2majIlxmaJTmS8gR2e1ED4vtAc4QOugk9ZBW5kWswzISNFnB13CvTMqofQnd+1wrbIYCllX0HJ7U99/u8aYDP7oesBWLsqnjryoEmXwFUW8V7M0CZ+WppYRew++YI+k9lRRy6xLMMY3jUY4G1oXSc/B8mo3kPF106NG0jEZklkIb6IM3td02fOwcQoKZkdtuHb9Jft53JU+L6ivXjgdku6W/ek6MjR5eaeohXudPLEokvx+edwxuuOi8VEgIOUrD585U/wtnSwa3q8OConpVnBDHnFEjS79oxFSuS+UoAMkaPHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0v9ZWwgICyvN7Eirxa+xvkc6A0w40oUd5VqL60d2tk=;
 b=d8jbR9ZL1iQ7iGfSbaAlvZWwABO/rG78May/RldpUwO7XcUjuI2YH5IGQm8nie4qRj+lWNhBj+phCKhtT5kHrNuaFki5s7xPn+2oKFD844CjOKTzEzgtPUCcCMlSBGYnPf43qUvFEYpzCQcnkvwSScwB26owxx8DVb5NhtwVR2epMKY0BCHAgMeJgCEtXhMcXyoN7fgK1bWgXHeqrwWCgaFXfRXteEs27A5RDveSe27xjQUI9epRxNGM+W5RKIw+Ol2vnDvoX+c0r0ZLK4/MOiYTUU6cNBM8fzf+ABRuNqXxG3ypRVQmSVtShLl8jZW0fNgP76HDS0+wzE8AdTH/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0v9ZWwgICyvN7Eirxa+xvkc6A0w40oUd5VqL60d2tk=;
 b=1GjCW6SMfYfeiTGIf8Ix6qgs6J9ciCs9fiVNPWVW4QLprXKDk1MrR5etpsr8gD/4BiM9nUiPCGVe/zFW67SLnzoJXG/da0Yv1CzBSX6vDhPNQL1zXT1GxuNUU82CR493j5pte/U1iFJeBdnsHHs5OxNB3vYH9UiJ6w+XnAeHYRM=
Received: from SN6PR04CA0106.namprd04.prod.outlook.com (2603:10b6:805:f2::47)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 14:26:39 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::57) by SN6PR04CA0106.outlook.office365.com
 (2603:10b6:805:f2::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 14:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 14:26:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 08:26:38 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 08:26:35 -0600
Date: Tue, 27 Feb 2024 15:26:34 +0100
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
Message-ID: <Zd3xGrZetKoAbIn1@luc-work-vm>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-10-pierrick.bouvier@linaro.org>
 <Zd2_VHB6-G7srfSo@luc-work-vm>
 <e0688c8b-fac2-4b4f-8cda-a0c4f5ee2bf6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0688c8b-fac2-4b4f-8cda-a0c4f5ee2bf6@linaro.org>
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DM8PR12MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a381e1-dc87-473b-458e-08dc37a01c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVVM7Hfg8Hb5Zr0xawpU7HvQ/0GZqEnNGCKGec56YYfmRjp17sCrOkv7CJaeEEWEhrQWto0jp6HlE33EtELysAvFNccPMHVuoEKgnJ0lhW3LMuISQXEUihh9jqjXERrbxlrKE7TOzLsudyFSczagMpn1fojkCSDd54azJ5Ygg+ijoQMAL44zz22uT35ZrKZ2+QEMO1i5yr0dTIruRXGIoIRDn1SKAEXzQHkRSK0bTMLxqtnc0iBSOL05hGQVJ4yXzTppNGuYaWpH8X7OX0rb85Co6dMQMPOGjRe3Py1PdO9ezVCMsW/geOIE5z2Pprip6pMrl8aUtz/e/lZpiDZhbh57TjT2HrcYQgGDjNBJZx3HbHP13F13RYKEFsAEAlkcQmjaWDac4viLicmnTB2gBuF9ypEU9gXGMSRVSG4vsl8vI8zdBxqyJrJg5MwZ7US2tFSJAwyvVWUvfEw4TiuRXWn3Gr9oFgnH6jW0MrCnJgJDcp5JqY7EfN7p/3B/SXLLCziIxnszG4y0Cqy6jxZjtNQoheeuWXY/FHdJYEke2v1Wp2I7f7QLKoguObFF0DOjXCJ/H20p2iigM55eBkNE6wTHeUi++nJJPGuolk2nGZmfARnXOh3e+qjdgNnpBn3Cqm7PqmMFbyP6djpRDky9xwNDnqEG55YZ5ta+k65r3iSEDSmfw/U3DAc2Z8IWchLTBijugd51TaaIaLWE+LQP7B94VB3giVfX5rTTeRytFY699NCQO66yrjtVkVxpD0xd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 14:26:39.0124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a381e1-dc87-473b-458e-08dc37a01c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On 15:09 Tue 27 Feb     , Pierrick Bouvier wrote:
> On 2/27/24 2:54 PM, Luc Michel wrote:
> > Hi Pierrick,
> > 
> > On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > ---
> > >   contrib/plugins/hotblocks.c | 50 ++++++++++++++++++++++---------------
> > >   1 file changed, 30 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> > > index 4de1b134944..02bc5078bdd 100644
> > > --- a/contrib/plugins/hotblocks.c
> > > +++ b/contrib/plugins/hotblocks.c
> > > @@ -34,8 +34,8 @@ static guint64 limit = 20;
> > >    */
> > >   typedef struct {
> > >       uint64_t start_addr;
> > > -    uint64_t exec_count;
> > > -    int      trans_count;
> > > +    struct qemu_plugin_scoreboard *exec_count;
> > > +    int trans_count;
> > >       unsigned long insns;
> > >   } ExecCount;
> > > 
> > > @@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
> > >   {
> > >       ExecCount *ea = (ExecCount *) a;
> > >       ExecCount *eb = (ExecCount *) b;
> > > -    return ea->exec_count > eb->exec_count ? -1 : 1;
> > > +    uint64_t count_a =
> > > +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_count));
> > > +    uint64_t count_b =
> > > +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_count));
> > > +    return count_a > count_b ? -1 : 1;
> > > +}
> > > +
> > > +static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
> > > +{
> > > +    ExecCount *cnt = value;
> > > +    qemu_plugin_scoreboard_free(cnt->exec_count);
> > >   }
> > > 
> > >   static void plugin_exit(qemu_plugin_id_t id, void *p)
> > > @@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
> > >       GList *counts, *it;
> > >       int i;
> > > 
> > > -    g_mutex_lock(&lock);
> > 
> > I encountered cases before where the vCPUs continue executing while
> > plugin_exit is called. This can happen e.g., when QEMU calls exit(3)
> > from one CPU thread. Others will continue to run at the same time the
> > atexit callbacks are called.
> > 
> > This also means that you can't really free the resources as you do at
> > the end of plugin_exit.
> > 
> 
> Interesting...
> 
> The current documentation [1] mentions it's the right place to free
> resources, and from what I saw, existing plugins assume this too (see
> contrib/plugins/cache.c for instance).
> 
> There is probably a bug related to the case you mention, and I'll try to
> reproduce this, and see if we can have a proper fix.
> 
> I'm not sure that removing cleanup code from existing plugins is the
> right thing to do at the moment, even though there is an existing issue
> with some programs.

Yes absolutely. The problem is on the QEMU side. FWIW I tried to fix one
of those exit cases (semihosted exit syscall) some time ago:
https://lore.kernel.org/qemu-devel/20220621125916.25257-1-lmichel@kalray.eu/

IIRC Peter was not fundamentally against it. But then I was off for
several months due to medical reasons.

I can take some time to rebase it and address Peter's comments if there
is interest to it.

Luc

> 
> [1]
> https://www.qemu.org/docs/master/devel/tcg-plugins.html#c.qemu_plugin_register_atexit_cb
> 
> > >       g_string_append_printf(report, "%d entries in the hash table\n",
> > >                              g_hash_table_size(hotblocks));
> > >       counts = g_hash_table_get_values(hotblocks);
> > > @@ -63,16 +72,21 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
> > > 
> > >           for (i = 0; i < limit && it->next; i++, it = it->next) {
> > >               ExecCount *rec = (ExecCount *) it->data;
> > > -            g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
> > > -                                   rec->start_addr, rec->trans_count,
> > > -                                   rec->insns, rec->exec_count);
> > > +            g_string_append_printf(
> > > +                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
> > > +                rec->start_addr, rec->trans_count,
> > > +                rec->insns,
> > > +                qemu_plugin_u64_sum(
> > > +                    qemu_plugin_scoreboard_u64(rec->exec_count)));
> > >           }
> > > 
> > >           g_list_free(it);
> > >       }
> > > -    g_mutex_unlock(&lock);
> > > 
> > >       qemu_plugin_outs(report->str);
> > > +
> > > +    g_hash_table_foreach(hotblocks, exec_count_free, NULL);
> > > +    g_hash_table_destroy(hotblocks);
> > >   }
> > > 
> > >   static void plugin_init(void)
> > > @@ -82,15 +96,9 @@ static void plugin_init(void)
> > > 
> > >   static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
> > >   {
> > > -    ExecCount *cnt;
> > > -    uint64_t hash = (uint64_t) udata;
> > > -
> > > -    g_mutex_lock(&lock);
> > > -    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
> > > -    /* should always succeed */
> > > -    g_assert(cnt);
> > > -    cnt->exec_count++;
> > > -    g_mutex_unlock(&lock);
> > > +    ExecCount *cnt = (ExecCount *)udata;
> > > +    qemu_plugin_u64_add(qemu_plugin_scoreboard_u64(cnt->exec_count),
> > > +                        cpu_index, 1);
> > >   }
> > > 
> > >   /*
> > > @@ -114,18 +122,20 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> > >           cnt->start_addr = pc;
> > >           cnt->trans_count = 1;
> > >           cnt->insns = insns;
> > > +        cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
> > >           g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
> > >       }
> > > 
> > >       g_mutex_unlock(&lock);
> > > 
> > >       if (do_inline) {
> > > -        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
> > > -                                                 &cnt->exec_count, 1);
> > > +        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> > > +            tb, QEMU_PLUGIN_INLINE_ADD_U64,
> > > +            qemu_plugin_scoreboard_u64(cnt->exec_count), 1);
> > >       } else {
> > >           qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
> > >                                                QEMU_PLUGIN_CB_NO_REGS,
> > > -                                             (void *)hash);
> > > +                                             (void *)cnt);
> > >       }
> > >   }
> > > 
> > > --
> > > 2.43.0
> > > 
> > > 
> > 

-- 

