Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329DAFF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 07:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIi7c-0007C4-DM; Fri, 01 May 2026 03:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wIi7Z-0007B6-KB; Fri, 01 May 2026 03:17:09 -0400
Received: from mail-northcentralusazon11013069.outbound.protection.outlook.com
 ([40.107.201.69] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wIi7X-0001hD-Ds; Fri, 01 May 2026 03:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcfcS53B2FeU60UD6HFzNYidxdGk6J2wiMavDPekO2msydBV1c2CqWk/lMyde1x+cWYy7Mh2ferKUzi0ccQMlaDEwtTCmzUk5SfY4NLC5PxtRKKmcSxe5KxkUatu9shzPcoNpynfCKdSMFalWOYtuubwrS43sSsxIb6Mv/b+U5qlTxfVmySDUwhhNavZqGzfcm2LWsCGwNzkMcBHMS77XVx157hj/WjI5MOxJg0hh4wpRg4ch7ptGp+Yagfa7WbnUASXEaupfDa1VqhvpjS6lCnSvVgYl8qpNUStYF0ceYe8+jSj+Vpff8dwWCCXeq333TT+izYJnIbSMp6E0t8Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xC1xgD5105+XOtHwggseqN4CL+uGpq72S9CcHXqQc8=;
 b=mSe0wytGk2JcXam/knI3w6CrRHFHhmOlsNu0CrWCvFhhNZhIl+t6GbSC+fadZj0MuWIMKcl0ga0Eej4LhLJL6x2bP/peFDWp90NR9eKUXmCCywHaW52Udn6TFz7nL8uj2gh04XqYRQ4l1SpJG6Dvb6rCFFVltb5YxsjkMS3ALpb6O0eObHSrYSAmLb/TJNKWBxk8e6D1dNgmuCt+s5XmdZeMvKZp/k+DJus83po4LxwJ1GBAE9jIzMAQa5IFaZVLBEhhK89d/v2iG6iRdwMqhP2ukoF7YCL9bcBt4CHPDLBUSdghxkf5JHIny1RDK0ltSXx651zrmn8+nSq+IjAeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=tls.msk.ru smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xC1xgD5105+XOtHwggseqN4CL+uGpq72S9CcHXqQc8=;
 b=XTKcZI92HOtltQTCKp4Ot2B5GE1WDz7cs6iBoIPC3/zFS33EsCxRhrASv4QtXkMu7xaLzliayBliUm7nfeT/4ySLuwa/QH/M9y54DMrUm+zlFtEoKbzP9lALeS4yrgN2zFkmUZ1/oAsaUk1mA5Y8X4nIQBDpKI8NQ0sGLE+jg/M=
Received: from PH7PR10CA0016.namprd10.prod.outlook.com (2603:10b6:510:23d::8)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Fri, 1 May
 2026 07:11:59 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::64) by PH7PR10CA0016.outlook.office365.com
 (2603:10b6:510:23d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 07:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Fri, 1 May 2026 07:11:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 02:11:56 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 1 May 2026 02:11:54 -0500
Date: Fri, 1 May 2026 09:11:53 +0200
From: Luc Michel <luc.michel@amd.com>
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>,
 <qemu-arm@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] hw/core/register: add register_array_get_owner
Message-ID: <afRSOdoqW27KAvRQ@XFR-LUMICHEL-L2.amd.com>
References: <20260424155646.533334-1-luc.michel@amd.com>
 <6d8bded7-a796-4144-b4cc-cb1b2f227528@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d8bded7-a796-4144-b4cc-cb1b2f227528@tls.msk.ru>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e36b2e-71c7-4b04-bffe-08dea750ee21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: hWGiVTqNjX6NGs9FRM/xk03OuNUEsKGpT3bcb8Jeha60ig++IbS9uZxhF1lJn34PmKxygrrW1pqSAdOxQjEw36Kh/dC0J99887ESYm8EuN7Yw1MOc2wqXFDjE/9upe1ieRKKVkdGYYEYEeTnfPPI+CiXRsvWaMtejsQs+f2u+kEDzR3ubHpUoxakeg/2QTk/Sh3g9kD3EqwVarYnBfSLEp1QzW++EgOXX0YSOpz27nMsTPZtryOYr1Xs3/jTnOVqhmjbsY39K+HC4IMOylEUVSLGwYwEFh0sZtJ2qyYJBWNtkgcUkS8AWBBv1X9MydsB4gKnwk6eSh0vA7qSqzXbvqXnFQn7L8cxtMcjGZFIabV7eDh83BXgPTFcMqiIpRTAsqMGkeXYHRCiVd6Wv3JjksXdJ19cemC2sxS1vW9imMJEQhqBRmU4d8qLVZS7LLWdgu5mLlN/tz5hDWIaShK3ftS19D6fNUx3XvWhkDzmZiuBmWrGGo4dITMmL6tT3gX/82Jquv0uTFVeX4wzRGosvrye3jbvCZwX/xWkVEFihlYaROh92tNMu1PVkHcavFNBgz6brM8usVcqGMPxyFpN8Mk344811F89cGqX8IARB6tpTllbrN887faItLjjI8J/NIVtGznJqHpj1fifpI157MNh0ncfpqPYNoF6x/atTdaq2dvl/Rrc0/XQbnOxcl5v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bc78cXNAuAQWY/FBaJ19MOtddFbpLXBCnesrCXVi3cup0qYmxkJDMJ9EyPwr16OOhLAhF37E9eP9+FCjmPlH2bdsrgRk4ryV52vXEkYoyCZ1+e3uXeVHOB/cy44BenBzcamdCM0ri7dyhOOJT1lfxY9o5789aCrByS6naWyv2wsccr6VS+lLOa8YNgN8tZ6mKxww/saJFbaivMclEzVrXt+n3yRvmEXz4+5kUhGJZFthpaHsoj2/QF5ywGMafN0hrvWxWnMJLnXhG7LYPUdFiXf8wWS9TOYZplKg+hBeLVRtDsGNRjCAQ167ZJWsQRPKbZTke8oxewtGX4HBGBK8lmyP06xAIlCkAYbbt1SqMiLweW+yTpP77drH7SiFXYz9cvEHS20OpcrAe2NcwsAuvVjByphwmlyOYVqeqHYD1+pjvUPdj4SwuJ7h2gAAGJLK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 07:11:56.6304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e36b2e-71c7-4b04-bffe-08dea750ee21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
Received-SPF: permerror client-ip=40.107.201.69;
 envelope-from=Luc.Michel@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 19:45 Thu 30 Apr     , Michael Tokarev wrote:
> On 24.04.2026 18:56, Luc Michel wrote:
> > Add the register_array_get_owner function to the register API. This
> > function can be used to retrieve the device owning the given
> > RegisterInfoArray.
> > 
> > This was previously done inline by some devices.
> > 5c6367bc1c8850f74812eeaaf87cff9911be58de modified the way register
> > blocks are created and parented to the device. Since this is an
> > implementation detail of the register API, it makes sense to have a
> > function for this.
> > 
> > Use it in the Versal OSPI and Versal/ZynqMP eFuse models instead of
> > tinkering with the API internals.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3421
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3422
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3423
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > ---
> >   include/hw/core/register.h        | 11 +++++++++++
> >   hw/core/register.c                |  5 +++++
> >   hw/nvram/xlnx-versal-efuse-ctrl.c |  4 ++--
> >   hw/nvram/xlnx-zynqmp-efuse.c      |  4 ++--
> >   hw/ssi/xlnx-versal-ospi.c         | 10 +++-------
> >   5 files changed, 23 insertions(+), 11 deletions(-)
> 
> This looks like a qemu-stable material (for 11.0.x series), I'm picking
> it up.  Please let me know if I shouldn't.

Indeed, thank you!

Luc

> 
> Thanks,
> 
> /mjt

-- 

