Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFAACF8863
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5cp-0007CH-QO; Thu, 20 Nov 2025 09:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vM0OF-000229-VJ
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 03:51:44 -0500
Received: from mail-westus3azon11010035.outbound.protection.outlook.com
 ([52.101.201.35] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vM0OD-0004kz-N5
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 03:51:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds4DiZBFSkIsThJvHGDzkEpl6uVia9FbH8Majoqi2bUtS916YjT5+YH/2aKz8nnPxgOI8gtZgzfDdjVI5Pfh0iaX0On33fLcE3+XKewnH8KCotGZF8SX+GZfW2RKJXp39mmHKHcT52o4YVRCvGQo5MZU0M5yl3bFkiAJNiskraelj6cSMcGc4RcedJguYtNLo62NYPQ/M7eXs5dAnPwjCghpblqBZWgNxAaXI6D13T7jxVhaDslAndn0DIn98yOJGyYHoPZ3g4scjfNMyrHr6bIDOzHL59yzT7UYWrNd9NLWWm+XgFsqCTst+7kS1wKnbsmTBYSACE2U4DO1euxiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7zw32d/pZPUsjol0yBqP3k5ZyIYoVZthfJ8UU9uS80=;
 b=o96zaQm1r996Y0QQC65hY+q5Y1mbzO9a2TbsHKE06i9m9TCiPtbYbtwMb7uEH3jncqKgq9fug7gwPFhSkyk6981+GfzQj/W5KXOkcAkGhxzMYFxH+A6fc9yfK8EiHNEqXeaJaDgEBbAelUDWOodXWEnAvH88KYqASmuQVTnvpesjHNyQLQujNIM+kOfjRIGp+X5rbOjiLZRAWC9YP6S8A0hE5L6izqxmES5qfY0iQdCC8WZpyNFSBCYgT488Mlrf4TaeoGlfXW6XsRGx05L2znqh1cff/4Hzq1/n5vvjnU6efdFU4qQi+ggVAo60ppkvlvvakcMaWXgx3uI8wkMBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7zw32d/pZPUsjol0yBqP3k5ZyIYoVZthfJ8UU9uS80=;
 b=lUN6PW8P34TaitOdj4gCj2axbiPbEarhdwqm2kgjYBf+EojSEtx87IEfdIkabunIdmGDkipukSMSvNI/ufdIumHLRNwrcAObzxrC/fxiOO3vXVmEWu8X6ORu4r93jfGPjlWPrxjJCPKXRY3Yvvq+cXvLe2HCnpcmD33mWUeReU4=
Received: from PH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:5::26)
 by DS2PR12MB9822.namprd12.prod.outlook.com (2603:10b6:8:2ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:46:33 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::c5) by PH0PR07CA0021.outlook.office365.com
 (2603:10b6:510:5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 08:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 08:46:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 20 Nov
 2025 00:46:32 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Nov
 2025 02:46:31 -0600
Received: from z-bu18.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 20 Nov 2025 00:46:29 -0800
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>
CC: <qemu-devel@nongnu.org>, <HaiJun.Chang@amd.com>, <Qing.Ma@amd.com>,
 <PengJu.Zhou@amd.com>
Subject: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after live
 migration
Date: Thu, 20 Nov 2025 16:44:28 +0800
Message-ID: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: PengJu.Zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS2PR12MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf9896d-a484-47c8-beb5-08de28114e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2NDbWhHUGRWalhGVmNvUWc3NkhJRFJxTDZxbVFkWmxKMmdrTHJLU1pWd3gy?=
 =?utf-8?B?R1d1T1h3M0ZsSkU1UWhGU242eXd2bnJyYkM0SDRFdjloUnRHZkZWeXdIUDNp?=
 =?utf-8?B?dU9YOVNaWWRrcXR0ays5dzQyaktJU294UkFHNnJiVndlMm5xU04xWjh3OC96?=
 =?utf-8?B?YnhHaERmeXBTYjVYbHBRTUd1V2VsOW9JWE1zdnNDckhFRjBHSm16a1VhdXVR?=
 =?utf-8?B?ekZXUjJhQ29JZFNnK0R0MTFGdkZPOWFRbERiY2N6bHppRDFSWnZNV1VKaGFU?=
 =?utf-8?B?RVFUQlZWZE9QaFkrb1FNNzFlM3paU2pVZXdqL2N4dUJha1I0a2k4Y0FUTUdO?=
 =?utf-8?B?UHk5amtkZHNJN0Y4ZTVuRGlhdEU4eTRNbmF3ellOSWU3aW9NejF1Wm5RTDNK?=
 =?utf-8?B?QStwbjlzVmRkcnRYbTBmNVZrZ3JPZmNFSkkwTWwyZGE3L1YrSFR3WXl3YnhN?=
 =?utf-8?B?NXZ2Mm1xSURVZUNBRnRaRS9JYXhpMUFGdGNkYSszT0tRRkpDNDllQVIyU28v?=
 =?utf-8?B?SjBUYUI4TzJsbVh5RnBCdk9YOHNBWG5lQ2NDYmZwOEd2bWlNQjY3Tm5rci91?=
 =?utf-8?B?ODBCWVpCVnRMWU04bWZsM2pSL0wzTnA2eGszNzJUekx2TlowMi9sVGVwR1du?=
 =?utf-8?B?N3lwTDl5S21IWDF3dDI2M09hUXZKTmtURW9hOEh3eVYzUmFkcHFaTnFmalZV?=
 =?utf-8?B?M3hWaHJObWFDYWFYakthNnhNcVFlZVQwdTNKbTJ6ZktqNWhRMFljbk5rRWJu?=
 =?utf-8?B?K2VmTlR4cFFDa2tNbk84NzZ2TVJVM3g2YW5XRHliamNmblF6WGwxMm5NQ0Iz?=
 =?utf-8?B?bDh0Qmo0U0lPWmRPVjExRUU3aUV4anpNc2RqSnlIejhIb1B0RDVjUU1LSGYw?=
 =?utf-8?B?dnN1WWdyamdPaC80RC9BRTM1UC8ybmdKUmVHb1dUSTF4OGd0SThRdXBsUTll?=
 =?utf-8?B?Y3FrSmhUbnlxOElMQjVVOHI3cDFnZWQ4VTh3Rjg4NHA5NHNPbGIvR2RuY01X?=
 =?utf-8?B?VzI2Y0RORG1lM3F4Qnd6L0JmOUNIdVJib1M5K2pQbUV0RjIxUCtqTW5Ndk9I?=
 =?utf-8?B?cWdaRjZqR3Q2ZUJSZUdtTHVoT3daL05SM1JDUjROS0Nma0g5TWx4UXpCWFYv?=
 =?utf-8?B?L3lPNlZCK2tCa1V3ZlFNWWp6VWNOenRGdlAvS2FuNzZZTmNlMFAzRll0WHQ0?=
 =?utf-8?B?eHBqOHJqdW1SNjEyd05jOEdaK0Y3OHVlMDV4RnJjM0Z1bi9ETEhPSDQwQWVn?=
 =?utf-8?B?WEMwZXdxalNFeXpST2xjcmNWMktEOFRSdUFabU03aVlaSFF2ZDhNbmtaMzZk?=
 =?utf-8?B?NDFtVTVuSTlDYlVmN050eGNQa3JFOUpjSXpxbmdLeTMzTXlZdnhiSnNLOERz?=
 =?utf-8?B?ZnptWGNxQXk1ZmcvNzJjck9RcTJ6N00rcXo4MEpxY0xSbXRlQ1dWWUpsRklB?=
 =?utf-8?B?bzYycnFabWxnY2JFbzZ6ek1aM2Q4MmpVWVRyRjVZd1RESVRxbTVJMmJwVEF4?=
 =?utf-8?B?ZEdONkRjRWdmN2JGVThnc3R2TXZlNW4wVnpBVytUdmUxVDZ1Q2hQU3o5a2p1?=
 =?utf-8?B?WE9ZZVZobWIxMzBKblZ3a3FZWWx5WW5BZ28wSHRmT2hFcmwxUWMrZjdPY3cy?=
 =?utf-8?B?SHM4RWp5YnhrT25USnFMQjMxVTEwUkc3YS9KanVLKzhVcFVmTlVEeWovc0sr?=
 =?utf-8?B?cFJZNThydUtQd0hPMzJaQ2xIbDNXaWF4YkEzeWN1WWMzd3FqRUwvNTduemp6?=
 =?utf-8?B?Wm13MVNRblNWTzBvSFlvenZGdDlTaWdnU1FnVDg5SWlvdEkxWXlsUWtFbW1t?=
 =?utf-8?B?UElwVTg2blNwOXBUdlIxMUY2ejdVd3ZkVjgvQ0tmVW1kWGVlV0IrR25qakF3?=
 =?utf-8?B?MkNteUlKd2RlbEoyTVpLQ1BoVjQzREtLVitNNmdFcDVCWU1DaXYyWTBYMzAx?=
 =?utf-8?B?WE00Z0lrYmJLTEprSkF4dU9HYldwdnUyTldDZjR4enZKZjY3N3VaWTBnbHR4?=
 =?utf-8?B?ZzVVYytlNUFRY1ZGaUt2VitKRnM1UWV4Z3MxL0FpcEJsa084WkUrZzJkT09B?=
 =?utf-8?B?LytoVnFhQkxDNVE1aktQTXZBanMzTFhwb2RzSThVV2JQWW1jNEZXMjVrMlIz?=
 =?utf-8?Q?TUUE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:46:32.9640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf9896d-a484-47c8-beb5-08de28114e8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9822
Received-SPF: permerror client-ip=52.101.201.35;
 envelope-from=PengJu.Zhou@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:27:05 -0500
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

Problem
After live migration, the guest monotonic clock may jump forward on the target.

Cause
kvmclock (the guest’s time base) is derived from host wall time and keeps
advancing while the VM is paused. During STOP_COPY, QEMU reads kvmclock twice:
1) immediately after the VM is paused, and
2) when final CPU state is collected.
Only the second (later) value is migrated. The gap between the two reads is
roughly the downtime, so the target restores from a later time and the guest
monotonic clock jumps ahead.

Fix
Migrate the kvmclock value captured at pause time (the first read) so the target
restores from the actual pause point.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 hw/i386/kvm/clock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 40aa9a32c3..cd6f7e1315 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -43,6 +43,7 @@ struct KVMClockState {
 
     /* whether the 'clock' value was obtained in the 'paused' state */
     bool runstate_paused;
+    RunState state;
 
     /* whether machine type supports reliable KVM_GET_CLOCK */
     bool mach_use_reliable_get_clock;
@@ -108,7 +109,10 @@ static void kvm_update_clock(KVMClockState *s)
         fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(-ret));
                 abort();
     }
-    s->clock = data.clock;
+
+    if (s->state != RUN_STATE_FINISH_MIGRATE) {
+        s->clock = data.clock;
+    }
 
     /* If kvm_has_adjust_clock_stable() is false, KVM_GET_CLOCK returns
      * essentially CLOCK_MONOTONIC plus a guest-specific adjustment.  This
@@ -217,6 +221,8 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
          */
         s->clock_valid = true;
     }
+
+    s->state = state;
 }
 
 static void kvmclock_realize(DeviceState *dev, Error **errp)
-- 
2.33.1


