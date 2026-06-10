Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC0CCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDBr-0004tf-0U; Wed, 10 Jun 2026 03:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXDBS-0004lh-Ul
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:17:10 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXDBQ-0001WR-FU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE4+cjqLkqqg5G6mUl8DjAhKCIe4M/gPOPyVEdIcQxAiOsSXyuts0nOD5DQVcUMRl2hmxx5x0mCtKd4urTL0NztWkk4dFN5KNyVrxxIAwWVhW3T2K6wk0keOihkqN+R0APkSGSqSJCCRDRAeLWIwoj2mlqMYQNcY7yTg3Xj2WCiJ0Jb/ISLqrfETLJwR+7YhSwbV2BqryC58MYqXMU92px0AcuanM4Oh+H9+c/Sn7oRGh/iGipmYHOs6N53Ysy73A9WoF2cr9oYvwQ0VoJXD8JFJ9tJyUhauJS0knjNMu9SweIOfMKbGKt0ZjMy3V/XGkDEDvbO9oRXrkGBf0pSYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kPWM4E6WNAb+ai0Mowd4mvEfYv5++/lrZv74WzIMGg=;
 b=PRcBnHk4xyCQQtns76Tj31dA/ie0+HSALXbfFpr/fv0CyY0j/VSYC0EArkWG9YvJczdd7iXIjkclzIaX3wGLcuB9fTuKmNSwcwA9Ky/I2HhzNYAFKazgCYUzbBBekjb3U6pPhhVZUROG9qT9CXKklV+5+eX165oJckIwujiAuAImY96xLd5qJl72RZz+vYPXZz1CzNhpfP+2dIXtRgYCaRPrAhn3kkvs24lRniF7J4BHAm1zEfm5An2F1kzuyez8sPzWaI9wGE3ACIYnI1Ss4Hl0V7Znc9axhfCVJ2obdxJXoWee9B2V6Kg28fpjmIWJ2onq1RUgQzkcDOD5kOypBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kPWM4E6WNAb+ai0Mowd4mvEfYv5++/lrZv74WzIMGg=;
 b=PG1PIuOhgmsYErQ63EDR3ZLBvITkhplGIpDwfTkiKzjBBUH0gUH1X2Wd//YbdZWoAjlHDQvGOtR+aZMR274eHlsKBI/O614Doye5eMgk2MqNQUML8GRBGaFVnP3Qh11EQeV03MRR6lLR44SmLHgbjOwlmeDmzk951/TE10wXy5I=
Received: from MW3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:303:2b::34)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 07:16:58 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::4d) by MW3PR05CA0029.outlook.office365.com
 (2603:10b6:303:2b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 07:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 07:16:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:16:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:16:57 -0500
Received: from [10.65.98.222] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 02:16:56 -0500
Message-ID: <b404fc17-8b2c-469e-8d8a-ee0c53e29b4a@amd.com>
Date: Wed, 10 Jun 2026 15:16:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] hw/i386: hook sp-mem into the pc machine plug path
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-4-FangSheng.Huang@amd.com>
 <20260609135227.6dd6eb99@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260609135227.6dd6eb99@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: b285258d-5314-4890-540f-08dec6c04285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ueJL8vZRF8ljGdY3fMzuJft8RZdHBf+ShSPoJsmxBBRIf8r1RyA3SyL8oyNgRudJEenTmICDqx5lgBUqJzak/h45w+3jsvuaihziQK3lZDXH0YnsII0UT78YMPPF8jMWfjk3J4/ZunfTvwjiCAL4vDlVbvWKj/TkCms/b6qrKaaDdMOpJEN69HiZkleyOsfs9MNdSSK2xRSt63ZjsMkwBpPvp59k6nAaLWBr+a9dXSdfmIhI2CqW382b7JqucLy4E8wAe/hQtNha5Gt2/d66UxdEzWo5sSEFmRXNnufKrqp5zHbs6POa2eSnP8+4JEQHACYCNe+KA7uvUY2y+Nv6gbHQJ9VwrOxcJd/9OBbtj11T4QPQT9HsfOO3ZCgKyErmZstVTDB3kwwZFOlhpQSE+FMOpfs18FvDqsS6rdVZ75u7fe/cDvSkFAvIG0ueVvfJ/jTLneJq/C4E2nOBjFRc+Xg1Hg1dZkqB9A3ByNXRVyFORXCpHrp39RZ4huA3+/JxDmvzZsiC7hgovt1U2aLWic+zmdqq6p6hVBSkTZ8kSCmVSvcCes64/jzL0Hp23mrR+vxpsC2x8Q9YGX9Acb7YMWdjLQZ9y+GKjWNsVHsbL+4FLDaEb6Mw3OrcRNVVCq6ihFHWigKznkyvP1j6rmn6BfVkx8RPgYTE6nKRqRaAv3RFez83Sx65jf1yLRaDiagh5jVE8ZYtvYBRMU1OafDsoU5lGzbBhHC+I8BIHOJrBow=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bvUI4S3HfN5DkOVh8cvP4hsnzkbdl7hZQcYcTm4VQfK3SnIDA99gaIGoo7b4QTF4Bfj1GXXinWq7Xm9JtCGOWztQBS6uG6RZA1bTdcZhIl46XAnZf57eJXItLDhxV7xRP2L8e1rzQIwsPW/k09pQ5i8ZD5oGRdV3ZNnKlmShEvUzhOVNCPSnDim2nDh60OeCbck2QNNEhfG/KgrkPWDIWAyAq+2TCw1oZCYUCTspkkzROdIQPgE5LNLYOz1qosdFnJqnpy002tMZELuTHww4piFB/MQUPrxgj8S8IeoCl/anpFxIG7VaZiaqedbg5ccNIZ3DUBHcVeixAq0Nb2wcA4otLeWoOFNbGzuPRtBoJus7J9Zu7cRtxbDwkDpGsOISfMogR0F2e/1xb6Guz8wVutlY9bWwAhzaqeKBEC6i3dWRo511G11NHlvSOko33+uz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:16:58.4406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b285258d-5314-4890-540f-08dec6c04285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 6/9/2026 7:52 PM, Igor Mammedov wrote:
> On Fri, 5 Jun 2026 18:46:08 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> +    if (host_memory_backend_is_mapped(spm->hostmem)) {
>> +        error_setg(errp, "memory backend '%s' is already in use",
>> +                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
>> +        return;
>> +    }
> this belongs to sp_mem realize
>

Right — it only needs spm->hostmem, no MachineState. Will move the
is_mapped check (and the set_mapped(true)) into sp_mem_realize(), with
a matching set_mapped(false) in unrealize, mirroring pc-dimm.

>> +    if (ms->numa_state && spm->node >= ms->numa_state->num_nodes) {
>> +        error_setg(errp,
>> +                   "'node' property value %" PRIu32
>> +                   " exceeds the number of NUMA nodes (%d)",
>> +                   spm->node, ms->numa_state->num_nodes);
>> +        return;
>> +    }
> 
> I think this the right place for this, despite what other mems do.
> Perhaps it is worth to consolidate/cleanup 1st.
> 
> I'd put it in memory_device_pre_plug():
>         if has_node_prop:
>            .....
>

Agreed on keeping the check in pre_plug.

I looked into the consolidation: pc-dimm and virtio-mem each carry
their own node validation in realize() today, with slightly different
wording (and pc-dimm has an extra "machine doesn't support NUMA"
branch that virtio-mem folds into its main check). A generic version
in memory_device_pre_plug() (gated on the device exposing a "node"
property) would have to subsume both and settle on one error path --
a framework change spanning pc-dimm and virtio-mem, separate in scope
from adding sp-mem.

So for the next respin the node check stays local to
pc_sp_mem_pre_plug(); I'll follow up with the consolidation as a
dedicated cleanup once sp-mem lands.

>> +    memory_device_pre_plug(MEMORY_DEVICE(dev), ms, errp);
>> +}
>> +
>> +static void pc_sp_mem_plug(HotplugHandler *hotplug_dev,
>> +                               DeviceState *dev, Error **errp)
>> +{
>> +    SpMemDevice *spm = SP_MEM(dev);
>> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(dev));
>> +    uint64_t addr, size;
>> +
>> +    host_memory_backend_set_mapped(spm->hostmem, true);
> dup? see above.
>

Yes — removed from plug once the check/set move to realize.

Best regards,
FangSheng Huang (Jerry)

>>   
> 


