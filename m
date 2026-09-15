Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E84C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6bzd-0007TT-Pd; Tue, 15 Sep 2026 18:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x6bzb-0007Sy-7w; Tue, 15 Sep 2026 18:51:11 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x6bzY-0006cm-Ne; Tue, 15 Sep 2026 18:51:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGprbo2ZMZ2D5ZjOGhLZQKfb0WGVv6YddBU04+8vDI4jPvb2jy6QBC0FUP/bx8irnyNqwxYnjzKTrt8PR8FOS8uapH2GWryVgPJgikokAEQP3RCqEri3JV44Dm1Ph/MRaYlFUjXbLXhGOKPf5lh4tUL8M4GgOpOtfz4s1m9nk9tojySxpc2WtbAGG8axOpQwsbpzLyhBUzCE/WGSX6belaNWa4hOfZy4JCD8gDHCx7mIcc5cCqlVJume1Az/xFH3VnyDcabrKhVu21sRIk6nSY56+buBXT45LKIeaimNOwyqSQ6qPUjAEYhtzwEIYeaLLAp6RQrpc+JJUHap9QwYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm11CS2wqJyDmOJ+joz6xwuCkmLmq9nRKkHFUcp2LPg=;
 b=xaYHNeGXonvcPUtuxGywQOiRr8d36x8F1c4Mc7H4OWQE+UC9la5Yf5wwy2GSXPieHu2enAI9Ppp+/dvOYy88hKjLrmTkTUS5ku6dcHF2F0k2SqROw5KblfFZwp6GBEgjJeNV+jCahL+3TQ6DxOjvNgnqVn6gsI759IWNUQ1BM4mXbCWwLCtfAy9cqrfJRTVYGecPqb4NEPLtkFYLhGqz90NaQtJ8n91gA5Y8O4YIGV/WwdE9dUM6jpcSJwsLkwL0Oy8NO+toCVrJrfq26mbQmsb+9gh/Ft20LwDRXthON2sRToDdJpyFf8xHz1v3pHOOFqHAKPL6Gr/wbhKi2PmqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm11CS2wqJyDmOJ+joz6xwuCkmLmq9nRKkHFUcp2LPg=;
 b=272j9w7xmylxvcEopCIgiXlRbYuo7nN2z279J0NWb9gcCVs0lGSW87mz3Tz2NkPUjOiJTzyqiCW/wKegFjo9zbdY3Avu1iNMRWbqOPhOl0nwYKgzJG8ajMG4EyX+ZT5edcHAXBkFz6oBenxrXzq0GUQKv0hQpX/6RNdZiSIbOEU=
Received: from BN8PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:d4::35)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:51:01 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::75) by BN8PR04CA0061.outlook.office365.com
 (2603:10b6:408:d4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 22:51:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Tue, 15 Sep 2026 22:51:01 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 17:51:00 -0500
Date: Tue, 15 Sep 2026 17:36:35 -0500
From: Michael Roth <michael.roth@amd.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <berrange@redhat.com>, <kchamart@redhat.com>,
 <pierrick.bouvier@oss.qualcomm.com>, <peter.maydell@linaro.org>,
 <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <lorenzo.pieralisi@linaro.org>,
 <gshan@redhat.com>, <enju.kohei@fujitsu.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [RFC v4 09/24] hw/core/loader: Add a ROM loader notifier
Message-ID: <irbspcb3uts535szacwb5kxa2dsbw4i5453rgivkpfuhgjzpsj@skstiacjnlll>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-10-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903193611.1058589-10-mathieu.poirier@linaro.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ede0a4-f25f-4adf-525b-08df137bd09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|11063799006|4143699003|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003|27256017;
X-Microsoft-Antispam-Message-Info: ad4SdTSaj7IZRFT8nisXHqiIyujoyqd3iWcDl3pfY2od18hM8kj5hEHAlKpGa8/yGySBo/RvvhHmvQNeF0QirFNsBSH2/VUltzC63V0/S/RoZ0diASn2wZ0vD0Mg415+XGJwAVeqSCv7QPnthIQ5Hup11cdC23vkJ24wEeW1bpIdNILE3AxDCH2NE9o6KzqYvngzKFAoQIQydExizzdECIb73YHSAHQnlQA3aLlWazPnkBX8IWKor0trCrVqM8pRldNEOi2IekwV6DdoBxf34J3uOqWH8JffZEplNNlwCgJeqj0l+xezoHhMvUkthXWXNfV4Cv73+wRcZhC7lLW7nSJVeb/z3uJbKhV3EKgTdr+eb5q88nB/G4B1KhkIJwlVCw0+F/6aPVBszLhH7eYahj6aGboaefanSeI4TZ908LcbIFbGuo4oM9xu9zJ2nJ7AsVR4a+tOMD3hhfu6B8/YYbGdvHWVy/chNuvLB62SOI0n5QxxuyBX0N7owDSOfCdCS141fnacnQOXY/qIcw8Hw4NTSgWqUpjxRRnkBg0/vJ7T971eSlYwtsXM2ZWauRSHI3OWzG+zHsyBraBa6rfJ9bY6mFlxwzzNaxa9W4bD1XQu+Hatr+/H8dbvWWOu3WyYkFfKa91D/nKT0ezS+qX0Eny81wQoheCnG1PbvaaWSJGkYM65A2coXhpuG/0SoJ8u4jGBB1aWy6gDrp8AOfktNBOaEG1jBoYK/2Aj6avEpqjB1GX9viBXTLQugSYFIrU+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OWG0bENfyKgAaksClIAyjCUtHE+OK+KDSv5PyIgIm8EPwA/tv1Vz9qRi2LTFROzJ8+Zvd3FfW59kr/dGlCQ5kKctC9dVGq+Ek6Arw2RjPXzFJGHdfNRNPkSscMNosp0tMYSub+IqS1fLBXeU9kBBWjhCsFI0By9qaLEDCB4u3ezj+2jmL51gs7P0IdvUdAEeSV6kpKooTxPGqOrPc6isbWYhZadIxlvnRilV5Bxh9TymG/h/Y3Q0RGXODrUZ9n8uBAPd4hxCVUzOYvXp1PBV/6uzxTW7n2smiYAlCPlRCIF/OyAHyspNpsYcBlPds+zsCffVgrAg9zwKqaZ8hVDCS7sECZ1z5/3SF/uy/42sA5ojrI/IpH2Ef7aJrep228tB12GfVHkF43mEGUf0CJWlkp7qGZ4bo8tVY6bqU68GcMrTkoWZO7oep+C2gEEI+3gj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:51:01.1222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ede0a4-f25f-4adf-525b-08df137bd09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 03, 2026 at 01:35:56PM -0600, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a function to register a notifier that is invoked when ROMs get
> loaded into guest memory.
> 
> It will be used by Arm confidential guest support, in order to register
> all blobs loaded into memory with KVM, so that their content is moved
> into Realm state and measured into the initial VM state.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  hw/core/loader.c         | 15 +++++++++++++++
>  include/hw/core/loader.h | 17 +++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5cbfba0a86d2..388f10e828db 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -74,6 +74,8 @@
>  #endif
>  
>  static int roms_loaded;
> +static NotifierList rom_loader_notifier =
> +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
>  
>  /* return the size or -1 if error */
>  int64_t get_image_size(const char *filename, Error **errp)
> @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>      return mr;
>  }
>  
> +void rom_add_load_notifier(Notifier *notifier)
> +{
> +    notifier_list_add(&rom_loader_notifier, notifier);
> +}
> +
>  /* This function is specific for elf program because we don't need to allocate
>   * all the rom. We just allocate the first part and the rest is just zeros. This
>   * is why romsize and datasize are different. Also, this function takes its own
> @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
>  static void rom_reset(void *unused)
>  {
>      Rom *rom;
> +    RomLoaderNotifyData notify;
>  
>      QTAILQ_FOREACH(rom, &roms, next) {
>          if (rom->fw_file) {
> @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
>          address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
>  
>          trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> +
> +        notify = (RomLoaderNotifyData) {
> +            .addr = rom->addr,
> +            .len = rom->datasize,
> +            .data = rom->data,
> +        };
> +        notifier_list_notify(&rom_loader_notifier, &notify);

I think it will easier to review this if it's squashed into the next patch
where the fields are utilized.

-Mike

