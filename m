Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18608CEF15A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 11:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy8cl-0001hX-1D; Tue, 08 Oct 2024 07:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sy8ci-0001gY-60; Tue, 08 Oct 2024 07:43:28 -0400
Received: from mail-eastus2azlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c110::] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sy8cf-0000fe-NB; Tue, 08 Oct 2024 07:43:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDoIiGYNEts9epRpDRddVasOLI5ocktSyMGtRFlejr429f3p5OfDOhzXJV5M2Ztmd60D5KhUAmecuW4PliM+/jkwa3idGXLlv/UD+QnNPk9bol8Ezbwl1ir2oqrGwhyCyvqJ80DWPK2IQiicFml+Nf9NbWZja6yiaH1HJ0N4jalmL5fWjs5EPrOl908deG1OOdscgpmmOXizIQNcEFjHFlHCkkMSaiFu9rzOA8Pg60eCXgqGvnpAZMWWAxuVx5LJatMo9Wlvx0g1lP4m6XNEU498V8iNVUEtg/dATmzW8ilflpOwcAL1fmjRy74VcF4eRFdU0mpuc0sBQr2s1p3MBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7VI+VGdcxIaSONjM0nr/NPvWXFaY5mTaVrTwX9X+G8=;
 b=pDb6SXH+eyjRRA5dVXh5mR1F/4/XawrHhx1oGEO+JzwL1FnD7o2/O0rpPtOQXD5zr/+UBcEVVUPtTH0ThSPXYBoA8DKWaRuza/2vNkRqQDLc+P2XLJVxqVBL2fmOBZ1Vsq7xCEB0aUK7qu7nmshf7d9KSl2h0UoZivjAo6Mh54dwDRj83KhNfsKTrNpD55MDUZ+IarayXuI61vY3V8lYyGLKZALZ5FU1EYhk1lpf0I+KHon69b0gJNp5NUD39zgSr4/cxgl6Yll70WNbyPYtSxohXdSgTk1HdwfzOzEPSC/K4Jgt1bE9ish4QjMcXw5EvrOvC3ni2X7Ss7adt6ys2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7VI+VGdcxIaSONjM0nr/NPvWXFaY5mTaVrTwX9X+G8=;
 b=K20IpH9rW9s7RO9YN+AabKA97jN3cNIYcuDht6F58jSYjjs1xueUjJ2z+2SIMtjvJ+/YIfvfmrayO236PyydI+o0hT1FwNhZtL9732KBc1EqThhaH966KFQwtUzd1SQcjdm9AZFn+onLRAU22fpe68g9+RmMSKWxktWvSn09+mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH7PR01MB8954.prod.exchangelabs.com (2603:10b6:610:24b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Tue, 8 Oct 2024 11:43:21 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7982.022; Tue, 8 Oct 2024
 11:43:21 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 gustavo.romero@linaro.org, alex.bennee@linaro.org, cohuck@redhat.com,
 darren@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH v4] arm/kvm: add support for MTE
Date: Tue,  8 Oct 2024 04:43:02 -0700
Message-Id: <20241008114302.4855-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::6) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH7PR01MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f299d1-094a-4e20-933b-08dce78e68c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GaSOqv4okvfbZhuHrQaaoNYTlo7L0OFHt/78WgCqPBpdXbdbjXxOm2kRe8gX?=
 =?us-ascii?Q?l4xmam4l04+qo2pxBb34i/KdSzj1MXMFOOgL/ofNlgpOc77tj1ze21Ptf1vH?=
 =?us-ascii?Q?U7q+0exoWmYIwblvpLJNgYaNMlrEjPgW7+LVcKBvuoDTH4mBZBtjDQpcc5Pj?=
 =?us-ascii?Q?ijhqXJlsH9OidOLsFZKSrVGo03vZlj3zKPJfsOWjVzmXQI4UXCcKNKoGTQ7b?=
 =?us-ascii?Q?XUOICONJ+uU7Q5ZYIVUK0/dXMvQBoiwgIGBT80dtd4mLtZ9sY6cfYPjoCY4J?=
 =?us-ascii?Q?jvQWUtLSEnLFUP5y64ft3IJDaKmMjSEh2QL6WvrX3MDR4w8uqlsrSaKLlyam?=
 =?us-ascii?Q?V5A2uoJaP/N9XfA0bhLkEk9/UAn/Bhqfqg0B0USSOaiULGFpgLqyoHxjfmpo?=
 =?us-ascii?Q?7y8r56/KJx621fLP6tGcJqHWgY5USHkoggzw5kst9zbTBn0jD7eCoDWZKQsJ?=
 =?us-ascii?Q?W1zTUFHpC8o/b5wwFhQaVFzOxAz6myHnKUH1kSKWaaad+oiquA3zStyykW9t?=
 =?us-ascii?Q?oSPWf/knvtqerEcNcJ4SK/WGt507n2zmESsGMGniPh4EHVcqTbdH3LmhNGFe?=
 =?us-ascii?Q?6AF6ggqM+hJkQEn1AybucFcRUigoG9o5hjA8T67c1hZj/RHCxULbuCQO9D4T?=
 =?us-ascii?Q?M+PlxyJpnCOBlbB2YGUPDHkY/+DWCejXkSMRyu/3vobao3PRMZM02Gl/t3RX?=
 =?us-ascii?Q?uY5X5DogHcmrJYhty6HoAHgGR7GRIZwfaxHrkTzUQXED1SjtIXtbj1Q6wHMc?=
 =?us-ascii?Q?M8gNVdvAkPUt6T60QLJEpN6Qqf6gIYLtxWhghLnkMmI+8NZ/JBRwWEVXD6vP?=
 =?us-ascii?Q?hnlakqEBwFLNFpYv3+Muwly5iyAL0dfbEPE2McS7Nuc3fzyyQGBswTfdzw/a?=
 =?us-ascii?Q?Rmcecm33UiWAlZgWKvC9lI6sSD1ZAB/l6R2412RGjAmuY092IjQ2sGUHlSaP?=
 =?us-ascii?Q?aIDDD3Ez5mxpxIN/9JwSw2yWQf1S15BG5sndC8DrDOfgkHZD8t2sj+k2vhqe?=
 =?us-ascii?Q?+9zCeGEpkFNRdT5vcZ6n67OH0CwpTUTNN2+sx6lhZh1CiVZjNvjarW5wwvI9?=
 =?us-ascii?Q?tG1R81Kc6k430kXA5iK/yNC2Iwp7OuGrGccJBgysxNn3haNyaN+JYVW4cSHb?=
 =?us-ascii?Q?KO/v98hr4Mve5u37XCB08uWOdcxiEo42wN7viHKiJ8zxtBTIbaQVEiRpqRbu?=
 =?us-ascii?Q?HGqSxx6eVGTyfx2g51EC9aKO1+An3TpZwlP9z7KQMd4juVtNU1ofctcL5eH9?=
 =?us-ascii?Q?B1LSRZ2uEz4E6IBmAiBreWbaufv5AfkTSu+CE3roIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+uPrLN4YAYOxUMxvLLD9pc1h9LN+UejuSWlVGZFplHLXvPD1ORxjw4nU9E2?=
 =?us-ascii?Q?chbdTedL1r/TVEDxbaUpBpDpaGf0V5b5C0Wf0b7cWRqdIsYvyvgCYLAmXKn0?=
 =?us-ascii?Q?5delI6yqTYlX7+asRYalOKRGHgPbmenSDVGmRqxXG/1V71Fl9ppr59d3j06/?=
 =?us-ascii?Q?BSkp8XyyOi7iD0Ip1t2FzSAmZPP73eFfLzA+ETOvxT8HRub+t5eNd1qPS97D?=
 =?us-ascii?Q?284W1B5qSWLab/CEYyUg8/zgGnepggnQPwAIu5QOmOHGW9J2QhPBDTl0F8bY?=
 =?us-ascii?Q?M/KPDddjOHlF6TiRxD7TVIGT1NEEkaRCuWNIDM0d/Wvt13WSFzIrONiZwn5S?=
 =?us-ascii?Q?9OkT9NVI6FJaWWBsBlmpwz8S+wCuO9SMxD277qyoK+4Zet1UhyQhua1WOcTl?=
 =?us-ascii?Q?qqxDPGiU1XeiWxjqpSBWMSZEN0/iPD6vw8sbDinwg6WZ/3CF3cZHzd8mIvXb?=
 =?us-ascii?Q?/J0Hn99qAXwAZruTulCHmbpea2qASccYOgPg/90i63EHgkM4eQDGVA5dkG2w?=
 =?us-ascii?Q?ElvN58ZEpzN4Wf27qPO7og8hiyMcJ+fwNmUKP02q1xrkVdKUfOHxsBofQetd?=
 =?us-ascii?Q?iDpb1s3V8ottaX33NCUzEbCJ0tPa08ZXkTUMa9iw0Xochi9YbX99KwUK1m5h?=
 =?us-ascii?Q?GyrPGxX/w/Ze3kNS38p/Cy5hx8Am30GsRzL7lld5pIjEDhKtBLEcEFubch5W?=
 =?us-ascii?Q?VAJ/KmVCZNy43BcveM6j+gk6yqxTq2YMp6i3jEb1ddBhpU5Zq1joQypmX8vv?=
 =?us-ascii?Q?swQHTOSEQTWT+IZZNSphT6iAZsl1QbqTf+BviCfRtiMLi1m+IcS6GdxYmeLm?=
 =?us-ascii?Q?8kfin8f7HBch4dhpL6fdP7eRdaa8uzhLHWQ/MrOaUOe/q3Yjsw0oEfJAgibe?=
 =?us-ascii?Q?n6wepSaDAeTKn+udejNqlSRVnNLPp4voTJvVqTi0o+PYN7Zvrsv1lbz865u1?=
 =?us-ascii?Q?0RHAV6PbQn+Ai2Lq6zO1KuphMp6PLh3VjXPsV9/Z+CyIkQGBjDZOvF7tUC9X?=
 =?us-ascii?Q?/I9Xmw5WVv6d/9+Bh8zP5oZsiZp/crjX/5thv83WCFsZt6Wu4IKH56JDn7Dv?=
 =?us-ascii?Q?otoGd3HHNYe4rAiaBKNRy8eY/chg66hHm8lQu9eInCiBHWz1qsLxlhK6IdSA?=
 =?us-ascii?Q?/rN3vkN1UAwFBXg+1FCkTbPDIE5uyEVILyF81DqWON0KQgKD1sNd2Y0t9PCi?=
 =?us-ascii?Q?d1hPKbo0OqJPb01mKi76zG78WeecmdlCBIUEY9rJSiKNOskphZcQWpujDug2?=
 =?us-ascii?Q?QY1F07UmaifjY8GKuLKcDd+saN4v2evc9k99H/EjOn1vRvVHnDVYkA+uvEwy?=
 =?us-ascii?Q?RevfaW+mhthtwKMVKTl9u6Z5J2tudUdO27sjTJgmCLMNM1qHt/6z/m/4LNkv?=
 =?us-ascii?Q?DgxSq8jlSHVoh6OTIpvLG7axHvqMz6Fw5I4/mNoSGo7SMqZmRJoyslXeL8Sk?=
 =?us-ascii?Q?4qkz+S/rUv2qdOcY4Bc78tE4R05fR77ohIGBK1bUYRro1PR+cEQo8R46NY7T?=
 =?us-ascii?Q?ZYRihYF1LYh/jFiLOHU4srvjwGUweS0RCTK7pRTtiqCOJONLKATndWggDcwW?=
 =?us-ascii?Q?Kkgjv7/Hqyuloopq/l3I5aOW+o+EpB1mT6LL4lO7/p9Q9/JIWvX5fXnuKruH?=
 =?us-ascii?Q?ZiahhV7Z/erhbvBlSB5eYwPP1fEvWa2GS2Ehn7BP/OpE?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f299d1-094a-4e20-933b-08dce78e68c1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 11:43:20.9993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zD6TCIPkPKmJF9Yf0v8DRb5K35i+cz6h4bSbGowavO65VOENZzISz1IoJJkmkWTS8EKqHToIctrl90pWlQNsLN02sUW6ZLPaYs9JGwPnazubxw171PRyh8PcAtXO8suf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8954
Received-SPF: pass client-ip=2a01:111:f403:c110::;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Extend the 'mte' property for the virt machine to cover KVM as
well. For KVM, we don't allocate tag memory, but instead enable
the capability.

If MTE has been enabled, we need to disable migration, as we do not
yet have a way to migrate the tags as well. Therefore, MTE will stay
off with KVM unless requested explicitly.

[gankulkarni: This patch is rework of commit b320e21c48
which broke TCG since it made the TCG -cpu max
report the presence of MTE to the guest even if the board hadn't
enabled MTE by wiring up the tag RAM. This meant that if the guest
then tried to use MTE QEMU would segfault accessing the
non-existent tag RAM.]

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---

Changes since V3:
	Updated with review comments[1].

Changes since V2:
	Updated with review comments.

Changes since V1:
	Added code to enable MTE before reading register
id_aa64pfr1 (unmasked MTE bits).

This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
and default case(i.e, no mte).

[1] https://lore.kernel.org/all/f3da8f58-615b-42ed-a99d-20bfd9ec6b56@linaro.org/T/

 hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
 target/arm/cpu.c     | 14 +++++++--
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 58 +++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 19 ++++++++++++
 5 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8b2b991d97..1a381e9a2b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2213,7 +2213,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
+    if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
                      current_accel_name());
@@ -2283,39 +2283,51 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (vms->mte) {
-            /* Create the memory region only once, but link to all cpus. */
-            if (!tag_sysmem) {
-                /*
-                 * The property exists only if MemTag is supported.
-                 * If it is, we must allocate the ram to back that up.
-                 */
-                if (!object_property_find(cpuobj, "tag-memory")) {
-                    error_report("MTE requested, but not supported "
-                                 "by the guest CPU");
-                    exit(1);
+            if (tcg_enabled()) {
+                /* Create the memory region only once, but link to all cpus. */
+                if (!tag_sysmem) {
+                    /*
+                     * The property exists only if MemTag is supported.
+                     * If it is, we must allocate the ram to back that up.
+                     */
+                    if (!object_property_find(cpuobj, "tag-memory")) {
+                        error_report("MTE requested, but not supported "
+                                     "by the guest CPU");
+                        exit(1);
+                    }
+
+                    tag_sysmem = g_new(MemoryRegion, 1);
+                    memory_region_init(tag_sysmem, OBJECT(machine),
+                                       "tag-memory", UINT64_MAX / 32);
+
+                    if (vms->secure) {
+                        secure_tag_sysmem = g_new(MemoryRegion, 1);
+                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                                           "secure-tag-memory",
+                                           UINT64_MAX / 32);
+
+                        /* As with ram, secure-tag takes precedence over tag. */
+                        memory_region_add_subregion_overlap(secure_tag_sysmem,
+                                                            0, tag_sysmem, -1);
+                    }
                 }
 
-                tag_sysmem = g_new(MemoryRegion, 1);
-                memory_region_init(tag_sysmem, OBJECT(machine),
-                                   "tag-memory", UINT64_MAX / 32);
-
+                object_property_set_link(cpuobj, "tag-memory",
+                                         OBJECT(tag_sysmem), &error_abort);
                 if (vms->secure) {
-                    secure_tag_sysmem = g_new(MemoryRegion, 1);
-                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
-                                       "secure-tag-memory", UINT64_MAX / 32);
-
-                    /* As with ram, secure-tag takes precedence over tag.  */
-                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
-                                                        tag_sysmem, -1);
+                    object_property_set_link(cpuobj, "secure-tag-memory",
+                                             OBJECT(secure_tag_sysmem),
+                                             &error_abort);
                 }
-            }
-
-            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
-                                     &error_abort);
-            if (vms->secure) {
-                object_property_set_link(cpuobj, "secure-tag-memory",
-                                         OBJECT(secure_tag_sysmem),
-                                         &error_abort);
+            } else if (kvm_enabled()) {
+                if (!kvm_arm_mte_supported()) {
+                    error_report("MTE requested, but not supported by KVM");
+                    exit(1);
+                }
+                kvm_arm_enable_mte(cpuobj, &error_abort);
+            } else {
+                    error_report("MTE requested, but not supported ");
+                    exit(1);
             }
         }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c2391..062c4d7d32 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2390,14 +2390,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
         /*
-         * If we do not have tag-memory provided by the machine,
-         * reduce MTE support to instructions enabled at EL0.
+         * If we run with TCG and do not have tag-memory provided by
+         * the machine, then reduce MTE support to instructions enabled at EL0.
          * This matches Cortex-A710 BROADCASTMTE input being LOW.
          */
-        if (cpu->tag_memory == NULL) {
+        if (tcg_enabled() && cpu->tag_memory == NULL) {
             cpu->isar.id_aa64pfr1 =
                 FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
         }
+
+        /*
+         * If MTE is supported by the host, however it should not be
+         * enabled on the guest (i.e mte=off), clear guest's MTE bits."
+         */
+        if (kvm_enabled() && !cpu->kvm_mte) {
+                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+        }
 #endif
     }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f065756c5c..8fc8b6398f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -922,6 +922,8 @@ struct ArchCPU {
 
     /* CPU has memory protection unit */
     bool has_mpu;
+    /* CPU has MTE enabled in KVM mode */
+    bool kvm_mte;
     /* PMSAv7 MPU number of supported regions */
     uint32_t pmsav7_dregion;
     /* PMSAv8 MPU number of supported hyp regions */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f1f1b5b375..000afa0363 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
+#include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
     if (vmfd < 0) {
         goto err;
     }
+
+    /*
+     * The MTE capability must be enabled by the VMM before creating
+     * any VCPUs in order to allow the MTE bits of the ID_AA64PFR1
+     * register to be probed correctly, as they are masked if MTE
+     * is not enabled.
+     */
+    if (kvm_arm_mte_supported()) {
+        KVMState kvm_state;
+
+        kvm_state.fd = kvmfd;
+        kvm_state.vmfd = vmfd;
+        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
+    }
+
     cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
     if (cpufd < 0) {
         goto err;
@@ -1793,6 +1809,11 @@ bool kvm_arm_sve_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
+bool kvm_arm_mte_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
@@ -2417,3 +2438,40 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     }
     return 0;
 }
+
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    static bool tried_to_enable;
+    static bool succeeded_to_enable;
+    Error *mte_migration_blocker = NULL;
+    ARMCPU *cpu = ARM_CPU(cpuobj);
+    int ret;
+
+    if (!tried_to_enable) {
+        /*
+         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
+         * sense), and we only want a single migration blocker as well.
+         */
+        tried_to_enable = true;
+
+        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
+            return;
+        }
+
+        /* TODO: Add migration support with MTE enabled */
+        error_setg(&mte_migration_blocker,
+                   "Live migration disabled due to MTE enabled");
+        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
+            error_free(mte_migration_blocker);
+            return;
+        }
+
+        succeeded_to_enable = true;
+    }
+
+    if (succeeded_to_enable) {
+        cpu->kvm_mte = true;
+    }
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfaa0d9bc7..4d293618a7 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -188,6 +188,13 @@ bool kvm_arm_pmu_supported(void);
  */
 bool kvm_arm_sve_supported(void);
 
+/**
+ * kvm_arm_mte_supported:
+ *
+ * Returns: true if KVM can enable MTE, and false otherwise.
+ */
+bool kvm_arm_mte_supported(void);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
@@ -214,6 +221,8 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
+
 #else
 
 /*
@@ -235,6 +244,11 @@ static inline bool kvm_arm_sve_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
@@ -283,6 +297,11 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 #endif
-- 
2.46.2


