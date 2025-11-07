Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A02ACCFA1B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdm-00008J-8D; Fri, 07 Nov 2025 05:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdk-000080-MB; Fri, 07 Nov 2025 05:24:20 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdi-0001Pk-Mo; Fri, 07 Nov 2025 05:24:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbGCklTSPvspkDXWBzpElHWdWRb9vGEuqwB75ajzIYmSJwjIhERyiAeiO78sFQqqPaCdoGQxajOyS4A8XJziOJTMvenOZ7lSBmqEv69YzXDdpDgiF1dVc1mxHvVxETmNjMFOHf/WTi+3op93tKC8znzIlBudQLYuv7G+1TUUzKwi5jwI/VbY7P4pprJI7lMAhus4XNOg9HyhEHPtFsMQKqWLgwBCT+5aUPrwVdsIYAro5Ad6tEpKohONuJ0Md5UbwJHwTTCesLfcWNmvZpJxkzT5AHAGevCzxdNt6XdeQoLrLke6axv9Y5jOKP4ZUq3XUJuNKWVISyFIBir0eF1w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhA/1LdrXNZXDxtM8IQxacz2NgUTtIpjO79bGe6HTn0=;
 b=N7yJbzbaBs5K0j/jU1VdqkUZxDMOyT1NTVSysDOUmwm0TVcqmqg0oMuaRtcB99y6QVTlVBObEA3tSfTt+0vNqNI70JLQ2UmbbL8/2Adj8+CJQF86VWeF2dNDuySiGGE1DgFSZ6D8OEqYo1zxSK3yQm+KsvmcvB1kAoNUPQrf4HRWz22TFJi7T3WvPdG1fgtey4XP2a8X/HMQRr54kuovbEaK5FCvfvWGCa/BA0hP+PNPD5O0+0SAAbwAQ1d5UPZRs57Q1kKhrNoAPD143+YyZ3mg02y1MXyCltDPrC6D5d0Nd0bRE0dEvVPujuWF8ty4DWx/Emj2SZnXhqeT+kxBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhA/1LdrXNZXDxtM8IQxacz2NgUTtIpjO79bGe6HTn0=;
 b=qqsaAxgUhqg1yO90U8roWvjoLPLvcjMrhZR9WuTT6OoMQslIRzTvhZCsbfy6QOkjkmvau9M1AoWVGfdL4A5ADVfiLVtqHmQvIQRJLCPVVunEqz/Ft5ATSWY+qELyzP8aPtyzndFsQZTvSi2iu9Ru6vkEIrpQAkV86BgsHTnFsmk=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by BN7PPF862C85B20.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:24:11 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::c7) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:24:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:08 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:24:08 -0600
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:24:07 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 8/9] target/riscv: RISCVCPUTimeSrcIf: add
 register_time_change_notifier
Date: Fri, 7 Nov 2025 11:23:34 +0100
Message-ID: <20251107102340.471141-9-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e86384-37f3-4920-a886-08de1de7caf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dPCQd0IRY0AaFFIflDc/t25BPLeXIXodPV5MlqGGvynZEe/mGFUTtrZP+XUb?=
 =?us-ascii?Q?yrZ8j5tJWrFDnZvGVzC5LmipLXmOcd4ek2v5js+df2OgKOfrNXHW9tnrhnwQ?=
 =?us-ascii?Q?4T0QcNOaGH7BP5R94VHeJOx9iO/8T+mlJSyE0WOolds+3d4iQv05J+xqI/MU?=
 =?us-ascii?Q?jXh4jJ3Nq1az753BPYgi4nhQ2cC+uQOn1CxC5YG6cWOK0C9ZFaiPhgQ1poxp?=
 =?us-ascii?Q?V02yeKhnn1WPbu0Y91+lYTJtpkFEd6JqzQlYxUe4Ugiwnennef1FVfutaOLp?=
 =?us-ascii?Q?k5iqieq/k3VUFIXTSSS4/kfb5+sAL9HDXJhal8jDBTSHis6soR2dXjBfrhdU?=
 =?us-ascii?Q?bMkKOqq+iybwx2eIE75eoPVwJp2ovOKvCs1O24e1LkGSSUrniQz8u7u+eNZ3?=
 =?us-ascii?Q?UksrQ+EEWRbyIrlPYGs/o2BrneyDla3ojOvx409J064EaZs4bY77j8Ou7zvQ?=
 =?us-ascii?Q?jJCLDo8s/juim7aHb2ovncxni8nb0zqxb59xmbzs6gJeD+6u0G+iQzCmmr1A?=
 =?us-ascii?Q?dPdd8V6RHOiaGGnOg6H/IlEkdD4pC9wuHMG/ewXnWXcxJNIvf/D67vmQYMNJ?=
 =?us-ascii?Q?Q2xraBjfoc3W0arMZm/LcmyhHfI0Fch171JNKNhgaq5Pda8jHm3rGSh21pYQ?=
 =?us-ascii?Q?wPpd59t0MMaOuJoYn812vn4NBNe6lGxIUGQK2apKPAGpA7q6IeCgoopZCxsp?=
 =?us-ascii?Q?HVpnST1bvE27O9FV5xOirnLgPZx4GMX4okXFMXiwKWz8tJzyS2L1jbGKQTi5?=
 =?us-ascii?Q?DQkdOgReRMIL96fZriM5usV4H6vZb9kusKHpQNbeHmbb49O0azgVt+KWs2DU?=
 =?us-ascii?Q?RdtaX2LWld5f8cyIn1k0704c2qs+CnRDN6jTAF1KGKh5KnXpRaZnbTj9Q+jB?=
 =?us-ascii?Q?cqoWsye+k93OHH1lFub7zzXA9CgXSOc8vZsC5oUv/WSzjsE5e+pXnkA1RwM1?=
 =?us-ascii?Q?4o4HwzjUuZWp1SiHFQyGV8aYlGDi8FCw3yd2obRQtVyiOEHsdexxAlKopnFu?=
 =?us-ascii?Q?iS+kYK8VlHPvyjwYyQjlr3sDAja68MohosCQJKjt6u0jDyJD3muL42ZuPjxL?=
 =?us-ascii?Q?Mqil/zl1UpC/2aAjeEGg83Q2/ys7d/Pluz7KNkT3RtOOHZetzzKhUCvdZu8i?=
 =?us-ascii?Q?eV+OcceLQ1Q8c9LicsXxPx1u7LUa05/GsbxbNgd5bcuB/De7q/zl1tkXvodD?=
 =?us-ascii?Q?sBjbzvndk7odLPBlBocsP1xWpHthy4ZofHwnU/+3ab1WulSz9EO3ZrxGdo3C?=
 =?us-ascii?Q?SnAzSXw9sVDTk7fvMn6ndh/+hDGRgG/OwdHrEa1txhYWnMDN6vD5yxYjRtGp?=
 =?us-ascii?Q?1BCsoAmJA0W5rhwkpGyS2owJs642KHu8/YWSFLQHBlzaUemfvNL2E7ADr1Em?=
 =?us-ascii?Q?KwEqsaxXlh90vco/+hdGpp9Apfsckulpb/eqh3uAoNqPrV9/WASAA863k7jg?=
 =?us-ascii?Q?oJ+M9TKGMITXZp/bnjaKdaSRrjTGrWKNONDvRgrvMfdlGS5QbFNMA7A/dj8h?=
 =?us-ascii?Q?4/BYNvVylgz6xuFKmBe4JrfT7K4f4iBGYAQoleNYhMGxqBoFYgsW12CpzA6A?=
 =?us-ascii?Q?UUEmiT/QxN6u3bTnu4c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:24:11.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e86384-37f3-4920-a886-08de1de7caf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the register_time_change_notifier method to the RISCVCPUTimeSrcIf
interface. This method allows the time source user to register a
notifier on tick counter asynchronous modification (i.e., a modification
that is not due to the monotonic nature of the counter). This can happen
if the time source counter is writable, which is the case of the `time'
register of the ACLINT.

Use this mechanism in time_helper.c to recompute the sstc timers
deadlines.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 target/riscv/cpu-qom.h     |  7 +++++++
 target/riscv/cpu.h         |  1 +
 target/riscv/time_helper.h | 11 +++++++++++
 target/riscv/time_helper.c | 13 +++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index e5bc23b2ef5..29cb30d23a9 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -90,8 +90,15 @@ struct RISCVCPUTimeSrcIfClass {
 
     /**
      * get_tick_freq: get the tick frequency of this time source.
      */
     uint32_t (*get_tick_freq)(RISCVCPUTimeSrcIf *);
+
+    /*
+     * register_time_change_notifier: register a notifier which get notified
+     * when the value of the free running counter observes a discontinuity
+     * (e.g., the counter value gets reset to 0).
+     */
+    void (*register_time_change_notifier)(RISCVCPUTimeSrcIf *, Notifier *);
 };
 
 #endif /* RISCV_CPU_QOM_H */
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 368b9e2532d..40b198d8d4a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -460,10 +460,11 @@ struct CPUArchState {
     int64_t last_icount;
     bool itrigger_enabled;
 
     /* machine specific time source interface */
     RISCVCPUTimeSrcIf *time_src;
+    Notifier time_change_notifier;
 
     /* machine specific AIA ireg read-modify-write callback */
 #define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen) \
     ((((__xlen) & 0xff) << 24) | \
      (((__vgein) & 0x3f) << 20) | \
diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
index b51fdd96570..074b516f4ad 100644
--- a/target/riscv/time_helper.h
+++ b/target/riscv/time_helper.h
@@ -42,6 +42,17 @@ static inline uint32_t riscv_cpu_time_src_get_tick_freq(RISCVCPUTimeSrcIf *src)
 
     g_assert(rctsc->get_tick_freq != NULL);
     return rctsc->get_tick_freq(src);
 }
 
+static inline void
+riscv_cpu_time_src_register_time_change_notifier(RISCVCPUTimeSrcIf *src,
+                                                 Notifier *notifier)
+{
+    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_GET_CLASS(src);
+
+    if (rctsc->register_time_change_notifier) {
+        rctsc->register_time_change_notifier(src, notifier);
+    }
+}
+
 #endif
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 7b493b7a233..b1d7bba1afe 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -181,10 +181,19 @@ void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool enable)
             riscv_timer_disable_timecmp(env, env->stimer, MIP_STIP);
         }
     }
 }
 
+static void time_src_ticks_change_cb(Notifier *notifier, void *opaque)
+{
+    CPURISCVState *env = container_of(notifier, CPURISCVState, time_change_notifier);
+
+    riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
+    riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                              env->htimedelta, MIP_VSTIP);
+}
+
 void riscv_timer_init(RISCVCPU *cpu)
 {
     CPURISCVState *env;
 
     if (!cpu) {
@@ -200,10 +209,14 @@ void riscv_timer_init(RISCVCPU *cpu)
 }
 
 void riscv_cpu_set_time_src(CPURISCVState *env, RISCVCPUTimeSrcIf *src)
 {
     env->time_src = src;
+    env->time_change_notifier.notify = time_src_ticks_change_cb;
+
+    riscv_cpu_time_src_register_time_change_notifier(src,
+                                                     &env->time_change_notifier);
 }
 
 static const TypeInfo riscv_cpu_time_src_if_info = {
     .name = TYPE_RISCV_CPU_TIME_SRC_IF,
     .parent = TYPE_INTERFACE,
-- 
2.51.0


