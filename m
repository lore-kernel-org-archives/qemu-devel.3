Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D426C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pU8-0008OD-8K; Thu, 10 Sep 2026 20:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x4nu2-0000WH-U4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:10:13 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x4ntw-0006bE-3t
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxZL9eZKJAw/zWU7e2Ne3umU+OgKWEquyhW1eUsjrEH4M7nAAr3idjjJNRS0TrRgS0WMWK7bbpB8JiFDM/Gfe0T2UQU1fxNMC45cZamD0TJh9zX9sjaXFNv2HraL132cM3J37g2SsRotXDuHjX79n7CxVZbM/GUvsT0gQRsBrgw643DjYKVbYD/smtqUw+t0Ss/sqzmrEYFBqdo/r2gBKdw6OD3LtpJeop7MiDg4v7pgT5MMCMZJBzIej8zg2Ji+0UDIG4uac6WtN3rOu86HcHV3UNTSCNiVixznSCcU8k/BDqOKi14cLOgV5VGhZAz1oWJ1iLExBFlE5yxWlwi4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtDfJ2dSMoOMs+Ev1QAgPWo0SMkEF8Vr694pICmo4hQ=;
 b=ea9WgUc8F/yvpI8qEUkTZm0PWo11eta3uFKu5qpxWyAFC76fOlXYt0oNzO75SENLYEA15Pb+syuwx8fg6xIo+SyO/p1c2dS0GOBtorsYnGtoWGXQ83UubWstfgCRVsXpQCH0D3PNi/Pk+cnrbVkRao3DATqe56ZxQEndHuNDloLyaGJIUmfEQGL6AS1SRCneKbsjIccf+hsoKSpjnMX1vUS9dqV78DANfWxzPf9RCk+6HgK3Cm23iDhwINYSjt/cuVUJQAn2RAp79UB4ld02p5mY7ifc5o6CKXF4VqcyGsSiQehFc64vSo87EH21GRenPdMAxQqwYTNgFLGElrgTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtDfJ2dSMoOMs+Ev1QAgPWo0SMkEF8Vr694pICmo4hQ=;
 b=j6MPh38Zj/u12bTnxWUHW6EqXWUCZwT16IfPJQ5Qpn79c0SJWvYUMXh8MvM/VbnAwjqgVdt2/p+8rqFo+SYUBbcONPqFtkurpCf5j8aMHj05juCO4eblnmNSinwgPK2I8DHeeUuw+PQu99RcmpV76E4AUVicJH8bbP7qG6wUIag=
Received: from BY3PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:39b::19)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 23:09:43 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6a) by BY3PR05CA0044.outlook.office365.com
 (2603:10b6:a03:39b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Thu, 10
 Sep 2026 23:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:09:43 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 18:09:43 -0500
Date: Thu, 10 Sep 2026 18:00:11 -0500
From: Michael Roth <michael.roth@amd.com>
To: David Hildenbrand <david@kernel.org>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <g3iq3ku62byofbc4c7m5tzmpcpqrlb4ark7pwvg3fm2jvcbvhg@qi5nnpnulsuk>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-9-michael.roth@amd.com>
 <eee90083-3962-4bf4-a7be-2e06e02e4e94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eee90083-3962-4bf4-a7be-2e06e02e4e94@kernel.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: f62116c6-2abc-46b7-79aa-08df0f90997b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|11063799006|4143699003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: mG988/+CZhiJ/ztOj/yQ04c08u4f6c/cINCCqXJHnVD7AjAaBcLghuiPMVrniHWEWtWBYSq8j0EpIhNxY2BAOMzJ6i/oxLoH/orqjg8uFHRsXu8zdqKfsvs/ZdIpDoNTl1Oje3Bh1IhaoTDc6ag2M7bCF81uLlXLJEC+CI54S835XGCkJsKsCdg95N9wH2u9hIlQa/BrgcFoixQb2wsFDjC/pWvQ+w9OUZ5+tDIoudoGiUsd1BKZeUmdgmDbx0VgAiTcouILR4P3jcza70W2ORcpgdkDnKtALu/WF/qP9L9bg0GLtn0UGpXsBYespS/i3xPiU/QmSPYJSPAqXr5ZHpvaELw0ahPl3eSnnQ9pY6t6s7EmjMSm8ZHHf4zOlx1F1wZkkTVZOkFWukeDg081XUhPK371amv4ZWlBh2GPuEpAMULo3Ind1FUy3jkkhlP97JhVD3ENSX1/whJP3IQK7h5de2jgKG8doeZr80J6antVUViL4hf4l4O5+st6GrtP7dMfeOYS2DmpLwlgFgQHHqViacVo0kU9A8cAahaYdbri3Dt0sZ8d+XUCFoXLPjdmn89gVorfxJut2qubg/+N1T0YW2nB6xrmxi+vjIj6QOEModiWiNlejV4q9++i17GBnG989/nOoqQ4QwnxHTTCFJrXfeRpH0NhTtcxWwUZyhZMLHZdOVs5t81iqBMn+pqbFGA/Z7WSqHYW+rsc/tYPig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jyyVfcDphOaF/13NhgSxrCBkJrnGOxzw9YdZ4Cr+hK13y+Zn6cVnujkKOn2jC3Fz3hkmyQ3TUg9qStVo2W1X1dE9Zhfl9Q7jcftttvO23oH+QEv68aUzOlGxBZbVMKkYu4d7iXQJkJwpkd+WAlawv36npxec9DXyZTO0m9A3tsw4h9KdzA8LGRDaL/F885dIAhGLuUbYV2qs67lrqrgSI5Ow/WZAXTEl8z5x3sdaA6lUPjAc4cDEw27u5+66URvFcliXi2UeQTJSF69ef27jf1LwRr76/5ZhCqL1Rf1NtnhKQUsMpmdZ7EwjSi3ffPNBHjycay78HZn2z3FA47jD6+V7QYrHsZxDIUFh/odC5YA97xVOHb+3PPwCuJOV1L7oNi7MD9QJTH0NlzyxyagLeYbZOwufEpPXM5p0k7O7LKvYwLEsBjm2rEIScA5SnxCq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:09:43.3601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62116c6-2abc-46b7-79aa-08df0f90997b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 10, 2026 at 10:54:09AM +0200, David Hildenbrand wrote:
> On 9/8/26 15:30, Michael Roth wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Host backends supports guest-memfd now by detecting whether it's a
> > confidential VM.  There's no way to choose it yet from the memory level to
> > use it fully shared.  If we use guest-memfd, it so far always implies we
> > need two layers of memory backends, while the guest-memfd only provides the
> > private set of pages.
> > 
> > This patch introduces a way so that QEMU can consume guest memfd as the
> > only source of memory to back the object (aka, fully shared).
> > 
> > To use the fully shared guest-memfd, one can add a memfd object with:
> > 
> >   -object memory-backend-memfd,guest-memfd=on,share=on
> > 
> > Note that share=on is required with fully shared guest_memfd.
> > 
> > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > guest-memfd may return negative but not -1.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> 
> [...]
> 
> >  static bool
> > @@ -47,11 +56,31 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >          goto have_fd;
> >      }
> >  
> > -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > -                           m->hugetlb, m->hugetlbsize, m->seal ?
> > -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > -                           errp);
> > -    if (fd == -1) {
> > +    if (m->guest_memfd) {
> > +        /*
> > +         * NOTE: guest-memfd ignores seal=on/off because it always
> > +         * implicitly seals the FD by definition.
> > +         */
> > +        if (!backend->share) {
> > +            error_setg(errp, "guest-memfd=on must be used with share=on");
> > +            return false;
> > +        } else if (m->hugetlb) {
> > +            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on yet");
> 
> There is a lot of uncertainty how guest_memfd would consume huge pages. So best
> to drop the "yet" that implies how it would be consumed (and that it would be
> called "hugetlb").

Makes sense, will change this as suggested for v6

Thanks,

Mike

> 
> 
> Apart from that LGTM
> 
> Reviewed-by: David Hildenbrand <david@kernel.org>
> -- 
> Cheers,
> 
> David
> 

