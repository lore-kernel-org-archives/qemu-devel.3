Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69283C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXct-0004C7-0b; Wed, 22 Jul 2026 10:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmXcr-0004By-OH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:08:45 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmXcp-0007wc-3u
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLw5rKIJtiWKb65Usen4KQl4WG8wTPVXVNRzT3vCJm747JhQxQKttfKOmUXiF+CMTvHJ9bfpmZkX/buoXfwPyXEIkA9G06pNQmLq12siRv/lJlfTCXzgB4qM74aUH49oQ03hQhrGHN6srKyB8wVajWvxZEFL/VR9iBLjy4RIPKN2mln6qsDlkaCe4ic5KnACh2h0FQ+02HBd+M9ZJLCcEP+EeZIBubGKufJH0beP5vtOkzseUTjNfyjMmCQ9GhcdVAisYAL3e6ce2P3Sl6LAQQ5vjWAMcqdTWbnUwF+crtm03XnKSwojTvh053kJhpC2LGwr/OQqjpxaNcHnAPv6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dccv141j90E4KeVjOwjEzU3IX2pFpcEKrfdyKXTpGQ=;
 b=ioHBufKRGwzDfZFGwA+417mndIH7ujJt6DZbnL3Sax/zPK2xBEDUXBCUcC8QTgfcaFCZ7/CkuAKlwhYRf5vFbsFogLcyWqaKcVFA8kYPGF0aUGIw5r/yQUPnBkGl2TVfgyzJYyBTZibfNmSXik/wzlJMNNyaQU/k2is4aAvdfuhxaukWMPiTG+jzzXY9XgRRPQcypMFWIaQsj/f6cnYzSKbJuPqhsbjNxFFMxx+RUwt8/6DV9YmlIII1MFi3JQZMp4ywJV4AiiKU8B+yJ84n2vGttfiyX57MBi8NhQzoLM4mBcRsBBCISAASA5Bz6oLhGUBvzqqGYlA+nftYB0NzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dccv141j90E4KeVjOwjEzU3IX2pFpcEKrfdyKXTpGQ=;
 b=cYMlK0IhjlXApFp2lNibk2DHNXJBLvGp0uu43gwApZUWeUdlYOXV1H799dqkHO9wwU+L6AVy34oQCuIo/khgPNm+qAEVOemv/Fx9imxrLxB5q86bolEKePiJZvG8IcCenPnMmB0DHAJ6/UeY6hCICOrJIATcHWkbLlPAx74BcSM=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by LV1PR12MB999281.namprd12.prod.outlook.com (2603:10b6:408:3bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:08:36 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::14) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 14:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 14:08:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 09:08:35 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 09:08:34 -0500
Date: Wed, 22 Jul 2026 16:08:32 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Richard Henderson
 <richard.henderson@linaro.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Frederic Konrad <frederic.konrad@amd.com>
Subject: Re: [PATCH] target/microblaze/translate: fix reversed load/store
 translation
Message-ID: <amDO4OyZk2rcRC9G@XFR-LUMICHEL-L2.amd.com>
References: <20260710072348.3575-1-luc.michel@amd.com>
 <7358d920-d631-43b0-8285-c162bd67df78@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7358d920-d631-43b0-8285-c162bd67df78@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|LV1PR12MB999281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2b0b54-a022-419d-bdf2-08dee7fab896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|13003099007|22082099003|18002099003|6133799003|3023799007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: blkQHTcMRFIUcvusuhmw7zzohizjPF/Ny0idfV4bUYZrzoJGzH7K/KeQLIC3Vkt7DenYfHS+XyrNErSQLjGud2+vmSFAG5aGm2vbhuofkVmSYI3Ksk2tFOhn+wWLoJ/WQXfSvXConqelD5ZEcPqqvN+iXwOgACcv0tlxYSn2SLrr5yne1mMd83hM/opO9Svfnzvczeil2S5XeHRpYK4Q0KsTkKaGnfqzHYbAr5+ngHstG1JFHQTsQnHWYAfF1zn1XwLXZhXJnR0XDW6mQ8i+fNu9FnQglQn3vuMzbMSZSKYtF/2URxQPe5q2V7O+LWHkHPN6S4Amt6QLSHX7PbuHRYTlaEUH0/3quOKe4/nDN0VWLPDYHcSMtlOkwLmUjiudHbxwItOnhJ9ntR6oalov0nopVfsPtKuS8xLZlXbJMQsLohZLoMUnP/vF4UkpnDCDNnO77ju9IGNaTYbhPMDhimVG1l+9wEWDLgnGqD8otB0P5T0EEO4RA0KJA0iVrhr0O+Y8SE/xd1ApJ9jP2t+UfREVZtSXTlCtsdg2BZM/hPQN4eAe6MMm0WkyuGdbLXeVvnbCMpN0619j0YdTokJe1BT3vx/ejouPpUWu0gTpHwFRat+ia+JDRfs6bEEe8NGgMAjGTyHnAhbjcUEtl9fQ/ssh77bkewoW9FL8JgY2f7FqliWbrurjuxz3doieIXKNfVms+97805Ec03rnbb6iWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(13003099007)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4K3nSAPO66dsceJIHD2RSTiZDkP/wbcyohuayxhFi8QnCz77nF+aSshAWQL4bRxx4nDgDaLes0Z/1j4WtOmE7qwCBqBIxW6/WT54xeCbic3v5a67fKvwt0QhefSbg4hWu9ONb2bKQcfIWKKiE+sF/n48ZpK61jNzPDAOIr6pKKCeNkP+6G6VoiAwSxU1++gH6BiwyqafsE1I45qPdjdRrT59JJwUh8Z2XzCZFJCXrHwYE44pDGsyk0WYr2MIHN45ISUiYM0VlwueqJTNPdiKdv1uUJxQLsPLXoPj38nKfI1gLtzT83n7exwDaLcvO2bo5SQySB78NU+cBRBND8TJ+xnVHXMaKk5sNtQ9YrtY4MKgUyXwiJrJyA1eyQIFfks7ufPJquQowf9u0xygOapxvW90iRuSWtMNWetf1tD4BfYhvwbQidtB5BKZEhZl+das
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:08:35.7164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2b0b54-a022-419d-bdf2-08dee7fab896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999281
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

On 14:02 Wed 22 Jul     , Philippe Mathieu-Daudé wrote:
> Hi Luc,
> 
> On 10/7/26 09:23, Luc Michel wrote:
> > Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
> > the address can be a target register or a constant. However
> > do_{load,store} might modify it in the case of a reversed load/store.
> 
> Register are modifiable, aren't they? IIUC compute_ldst_addr_typeb()
> is not used by the reversed opcodes and the only issue is the 0 constant
> in compute_ldst_addr_typea(). Is that analysis correct?

Hi Phil,

The address registers are never modified by a load/store instruction.
(See e.g., https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/lw ) 

36a9529e60e0 introduced an optimization that can return the global TCGv
used for rA or rB storage instead of copying it.

The bug appears in the reversed load/store case, where the
do_load/do_store functions treat the `addr' TCGv_i32 as a temp and
modify it. Since 36a9529e60e0, addr can alias rA, rB, or a 0 TCG
constant. Those 3 cases are buggy.

Thanks

Luc

> 
> > Fix this by factoring out the reversed access logic and copying the
> > address in a new TCGv_i32 if it needs to be modified.
> > 
> > Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > ---
> >   target/microblaze/translate.c | 56 ++++++++++++++++++++---------------
> >   1 file changed, 32 insertions(+), 24 deletions(-)
> 

-- 

