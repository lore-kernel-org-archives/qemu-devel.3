Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948BCC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56us-0008GA-PP; Fri, 11 Sep 2026 15:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x56ur-0008Fv-1b
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:28:05 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x56uo-0006GT-73
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:28:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts/pg0wa8v5kZH37Axlb0PDi0o0trs58XxLUb17Rq9G/71Lj4nDvoSV2WuUTLh415XBLdhYLceyOvDHAdlTKZUaibWWKubqAlJ9YQrPRK/mYXklqKENJWIvvA1vmxlq7h+uroBdxNSCznOINMYPVVQHkZQOT8lCzLOCCRw1Hxp64wYG1ZnqDn3q5YHw2MRwcBAGUMrUqubDVq6ycMbgVYi65IunIBA6xSP1iENswEQPO2VwNSrYk/Dc+rcM6XN7mdZ/62Rz6j4RszaXL267jCKfA53vL4WQTf3DAxjPY6k/dWkTYjorydc1eLPPT8a8HzGSa9a0+sFxWnK6J9x1f3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ3KR9WFJOtLsoSsf30m9sxczI3JMtUnwjarFqNZfLE=;
 b=eG2Ubp58N1CWwd+sGS3xLZRWjyBXpgszlkTN7Qdux6cPieoMWWzepkdnaL37hCMH+PX+jiOegH9wjA255PkfTOdLJogkHEIo/8d3R5jGPAPbI1RNESQKpaeRJRU1xQsrG98xlLwmBhPssVcb+DdRcTB0vc/GW79BkUq0MgXx1YIMPkl4JuUm4kxjletBXT9niAVNtR21hvGINo0P8klSmDd3g0yAIj/h1+NN2Qr/CXEvjXS8Y02/ZA0PfNdOKoktm3dGqpNIBhm6KTwg83XJF4GsavYiWd5B/ChFBmJLHPBQh7rdiddA4DjGzZzGs4a47PQBt3ku5WixY/IGQg2HUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ3KR9WFJOtLsoSsf30m9sxczI3JMtUnwjarFqNZfLE=;
 b=HT/Qq5pZuFMx7pnAxnWkd/fm82SOoSpZiWnQiM06nRZ5lAlfmjbipD85osg1cGIWs3UY3SaWCcN2yvhpA5aeaciEoDSqa5Hjf+220sSvbd6Bk20Y6KSSaWMYrZWfl1yzg18g25uH7TWkGTrA04oBBkGGuHuXc4qa6rxctpEJnoE=
Received: from BYAPR21CA0019.namprd21.prod.outlook.com (2603:10b6:a03:114::29)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 19:27:55 +0000
Received: from BY1PEPF00026958.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::73) by BYAPR21CA0019.outlook.office365.com
 (2603:10b6:a03:114::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Fri, 11
 Sep 2026 19:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026958.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:27:55 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 14:27:54 -0500
Date: Fri, 11 Sep 2026 14:27:14 -0500
From: Michael Roth <michael.roth@amd.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v5 09/12] machine: Rename machine_require_guest_memfd()
 to *_private()
Message-ID: <4g72solcqijzlvhtlfp7wxkjsg7qr57v73d4gmmsqllq637dji@cicdflxc5pnq>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-10-michael.roth@amd.com>
 <e4a6efac-c241-417c-85d7-16415348378b@kernel.org>
 <742iw72k4pc5bigmbyx6rls3n2nm34x4duvo34ylgamhnwrjpg@vzoi4ozrpied>
 <f4f6f4a2-df26-4905-9900-ff1ef62201db@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4f6f4a2-df26-4905-9900-ff1ef62201db@kernel.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026958:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: a845dda6-7e18-42d2-9986-08df103ac78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 019xUUexkeb7amc5Eh9/CftmhFnW8KFBcuu9UsM5pzS2q1+ZRRt5qxkmDQFaDQSVBt/NqvZaVwMj3/joJDTv4UymK+Ae37bKbxdTOLw8Z360AomQb9tYZXiUg/yqQeNH/8goxrrPZJmLeby6idT3VUH9OkAg6dClwnOwxWe8yl3gu5t0NxKh9BKs0FylAE1Qj64a6jMMQIAycP1NupgWeW75pBdjTrcHN9mzLXky2SZwTeXL7Ge6krqOjRHu5i56rd+nY+VeC6y8MJqnh1N3UTsybiSqUV89wkfMa19WAVnKh8efUchv3TFTT4M3U8WgJTM3pv0vhekxhfhbu4ZY4FZ+rCIV/oN/MKOlk4la8LnCw4xdqnag5FGhd35HWu8Xr3wwkQ04OO4R6lbsy7lVqSiUo3nxiueYqG0rT3wqxZRLyzzPkNMzlr67HfR+CxI+dKQ3SmXDVxI2F095fNVZrg8d6oG2YJDNvoMB1840OLJOUzikqshyvfcqyb6reJGyoDrRtwEXbJDj329rPek0rJDeGdad4/MrG5KoM1uKimi0kcN2RgMDumuaNfrNas7GEC4D5xQnVNoBJbr/DKKxwZOapBkiyrs3Qx8U16XhpYE1bBptRUgnwiVrTEHw/htyQiOC1+m+3deqeClT8pbcgCW9Sy71qg80/bk4ToyNfWG1wCuYfWd3K6rpCEFmJSX/a8Vjm1dKEDITmVJGmHBmmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cFXeO+yxgn2v1FqCp0p1zpPox86bQTQsI+Zi3qUDMk3lkITPza49cEaUHZWcrCP0Sa9yZhJr9dvvIccz++xxkOT4h29e0fiM2iubgeynwUWHGNeEbXoq9Udw5G7tjp8s8+gFzbx5IA6ZYT7hD+CqnJwG93zdoswZ4o/3imNi8f8lWZVuRRUGQIqtKSyxuZwXo6jb8zVsQIVMRk/53iYBj5DkBWMzH9bki9uspAfDeTdK1b+cwZHyUcNqSoPLZ4Eifg+0rjhI/svbQRgr+pCedDlfbVrcVZ06iA4fVbdezT1Dn/nzH9Jx+JWPIwGtHDxBIFZMV6y8h3UTVJCqpXhbzBnPYf1K0tewULxdaW9br/mYKnkLl+iIlFHbASp85rG+DUDQ98IhWUQHfsrSK9ywnThH97WmFcJRu3q+JqC8rOxwsO/rBtOy8HZkDOaPDiyp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:27:55.0805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a845dda6-7e18-42d2-9986-08df103ac78e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026958.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Michael.Roth@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 11, 2026 at 12:48:10PM +0200, David Hildenbrand (Arm) wrote:
> On 9/11/26 01:08, Michael Roth wrote:
> > On Thu, Sep 10, 2026 at 10:55:09AM +0200, David Hildenbrand wrote:
> >> On 9/8/26 15:30, Michael Roth wrote:
> >>> From: Peter Xu <peterx@redhat.com>
> >>>
> >>> Differenciate it from fully shared guest-memfd use cases.
> >>
> >> s/Differenciate/Differentiate/
> > 
> > I prefer the other spelling, but I guess the ship has sailed on that
> > discussion :)
> 
> Heh, my spellcheck flags it (and it looks odd). If it's valid, please keep it :)

No your spellcheck is correct, I just couldn't resist the opportunity to
complain about the inconsistencies of the English language :)

Thanks,

Mike

> 
> -- 
> Cheers,
> 
> David

