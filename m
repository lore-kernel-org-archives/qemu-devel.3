Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE7DC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjfo-0006SD-4n; Sun, 27 Sep 2026 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xAjfg-0006RR-8B; Sun, 27 Sep 2026 03:51:40 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xAjfc-0001lS-Pz; Sun, 27 Sep 2026 03:51:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwSSPMrtXk4GSgRknjtpWUAANMow0Doald6YxGoWSwU+MCXE0nMsA3JUklnTY8leE2+wdDVhVcDce7RjU+t1oBa8+OVFEKm8Sm6lfV42KZJeKmledEM8SzvpmR15DtMJMudn8N1zJcpHVbR0bqtxRYZZDvn6Si4UtrV2qFty3TYSCaATxGB9bjYgYUt3SFKKwwM6P9R0E/jdn1YXWhp6hTuHohM/RpkSlPK2iQKjM5xZa4o/bvmrSWe2KFT5JMxgE5spVS63S3E6tPaOIFjJB+444LV/ekKmDEtMTmyoh5Ei7YMvAMwq69cSu0FqFk/pBkTdqsSv0A2MQHW3PayOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpiF884gU8s2SQzy6F7YF8DaJoHvFTOXTMyJr3j0n+k=;
 b=gpoG6XzZZCRqveB9uakao3MIGZJPQ6SUioOgWk063QhwV8HJCfKvnFRFybB1eL1J3ejd+X6LCS8cYRcVMKPkH0x2F8re6ae+08aRFM9KLdBE6cRh7q+e/yywQSoUlvpngNri8hX80H2EFKIHw9uAHX+G69Nw0U/UnT81PO2czxz+vo9ELtOFOh5gJHPEHuOtdjesfSLxJSbUic0WZX06uCUORDyUfOauL7Lt60klW+cCB9saIXkAx3veqIONJ01N7UT7qIZuchaXcbzvlNsWWQWkVIQAl5F36+1mdxsA1wVtO/qvs6dUD759xZH79hvPmGPdwCoNT0SbDBeeWL0vLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpiF884gU8s2SQzy6F7YF8DaJoHvFTOXTMyJr3j0n+k=;
 b=PhhBUD7XjpfvLJGa1KidxoyXzPCtqJ9HoRKprSG3yxaAjzlJi6d7KyXNpV/0yL9kAYRTxXJ78felzqw0NAAwzyXIjTQHxT2nSBF7O2kWCbK/ea/nu5aipqsd4sPu4/49tJHT64wpyXxtZGEC+JYTh5kx7VjrRH27wlTrxnYjpQQz21SpIssfi34FbakSF6Sm/DelDhxOiGYC4YbHevqVhYZo5cYja0jXFlpOzFY9fzCJsZ+AQe2REtFo0qV+otRMbiaQYNwCUyOtl0R+4x/Fo1ofBN8EUo+9J/Htm55C8z218osKnvypuhZjeq2JsHRcwWaiPTNnqyEKnKbYVNCFRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6759.apcprd02.prod.outlook.com (2603:1096:820:10b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 07:51:25 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 07:51:24 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2] hw/net: cadence: Honor subword lanes in the GEM registers
Date: Sun, 27 Sep 2026 15:51:07 +0800
Message-ID: <20260927075108.3621107-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: c26894cf-779c-4766-7570-08df1c6c20e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: WATvBzPhY4lxlbWF7Tp0pBsUiu2DNbZGMK8XJ6p3rwQ8yKwXV1m8IcbuAg7sqQCPGV/t+s1ZawHS5D6KuWpm9zr79tz+xj+qJ5fAJzXbuGe7mYZaimO1QiF22zypq2zPhWVImBz4qSa1/VaULet58S7m8nvF+XlQXPawYoWW6a7Adpz9u2+XulyDyo9OQrWQeusLDYLiU/3VyV40VV33Py1NujXP3StVKNlip9J2zcx9Fp5O9qXFFlyMwzIwbEZT16W9bQEz3/SfbGU7ixUtihpEiHrMk7d6nahqDKJXnipk/ffAIU+ni9YCG/EOZLU196kP95ntERQyX+uIdkwAg0qijLf9XXDYR/j2uGncFwxe/4OiZ4XWmiIPIo/+pBs2uA1A4DGZ+JT5JAgtH2u0sHPgMZGDbxFaXAifObFYjsFnp8V99tDSAOYerJg5/L16sQqKvkQL6ut0SkPGRf0C5AnFUvTdjIe+xdCBKaovBFCBOeeAmcorO0nBdGKs3QCOaYor+buT+S+sBuI2N4JPfobYFs0xX2cvafPrC8xmIUIgasn341oqLqI913IC9qvO0F/tDWl8XBBxJvPTY0N8bjtVXsqdCkl1z8lhph3c+/Je+keDtpGfkqAQDNCJN2siPOG85bAZGOt9eQEVRjfLCg0yRHRMt9Q63hmQNfT9DpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9b2rSYKqvj+eMS97ODHYmybP4mH0zPfjTFqjAuJFfyQVK/mTmY2Ju+GiG8fe?=
 =?us-ascii?Q?0ymebQhsn6BmHqfPm+Ya/p+Bj02lAotVXDljaLRzSM0mrATpnfSxlsnj616z?=
 =?us-ascii?Q?D7rHsx84JY8lwH2aE8QnJDqfnKA320gF74c1z5AwYr0hYf83Q+QGYqhiRtgW?=
 =?us-ascii?Q?v8PlQUXOEDlbCnhhE/xoyrLeOTW2tTKxFjKH2oLsPIza8avE9qlSXusk4zGy?=
 =?us-ascii?Q?fVW8DfVixRVtkkDgV14f4MYJaD43cHz5kf/pDtOAeADQACbVDsVENZFYdX/S?=
 =?us-ascii?Q?zl1iaThnwmMnbKfIDc5csoQUSlyB0T7q2QCgzi9UIHeVr1AVVB4H3WwhaWG2?=
 =?us-ascii?Q?yeW5CBVlU8QcKFJ04r5LBVckluQw9hcamVNyHvfuB5u9Ucdnw0g3S+fVVzCi?=
 =?us-ascii?Q?9wtq0NDEcwfd1KgcdpRetzNI/QHvOeuPiiMIMjUbAINjSg33v90DZDjnn4iK?=
 =?us-ascii?Q?GF+Jirroul25Sgs2WwTLeli34poxRCrnEVS+Mwdg8L2MjQj95ZSYKHJQIb9K?=
 =?us-ascii?Q?RxrqALdexvxFQdeUFByJKmKn8KX2SFZdKYlU12MgwqPE4iohFRG33XSLku8X?=
 =?us-ascii?Q?Ry4+9VtgUum/Xq9Rq8JMPwwWcyy6apoKN9MP1xlMtKnHlYwnKjpgmrMPlA/L?=
 =?us-ascii?Q?RWmm9PtENNHStPVBN0GzI8vkSwHj+mmACZenE70bXWQN5WhkZ8oBF2ZXA/2W?=
 =?us-ascii?Q?WVzy0cKGvMjUvFwRBEJMh/XrLfDdVu2w7sLNWhtHBugaYPXXsJKTC5hm48+A?=
 =?us-ascii?Q?/lCx6x0rLlueAR4G3B+n44XdYMLZkt5wjxKic9zAoX7MeCpe1JCKAss5j63f?=
 =?us-ascii?Q?MGYq1za3ULSswhtdaR7lyjLLjZ4Ae3Z+9Q6qylK5cG9atIaObpgyEEqxftOi?=
 =?us-ascii?Q?BrNOi1JxA9XmxvvCUdjvO8lP+Ywi64HyFXMYjYO0mJ7CxfxsrqgmBgxZDeXW?=
 =?us-ascii?Q?a9pK4wY618mNMMvkLcZL/4p2TELXYJwBcThQlZN7oVJHgEFvdzJJ/LjaWKmV?=
 =?us-ascii?Q?0fOlLbj4gvymPDzKddQN+zd6KtoeMXqtK/zcMPx7YbTmRNlPJf+PHVurFhzA?=
 =?us-ascii?Q?weuAgIUk4ZvypJu9CLDnS3hbr0ozyazEXVNWfLVl9G6zJSHpaZnuzeFOhk8g?=
 =?us-ascii?Q?V+g3/eF2INzW7brfOpZxoVVQZ8ZycfuY3iTraW+OODaRx2huZJQGXIgX2soi?=
 =?us-ascii?Q?s79s2Z7F4i5zyxiHABwZybvI5WjEoH+Bfcxl0B0QH4WTHSD2rl53nAusfJlb?=
 =?us-ascii?Q?xdxdkH4naXcJkfy8Nl7kpQ0vYoC7JvS9G2yJOnguUEFyiekEwBSXoIMvBguD?=
 =?us-ascii?Q?AO/Prtm0ZWHFfO1N393wbrBR1qx2wrdCmtUx5Wk69Ia7mcfIvyELh8B2JABx?=
 =?us-ascii?Q?oyq//u+OSmwOmlKEway0jsa57FVDYu20DYQVu3i7lmZzCthGFZdcRc9nXkR9?=
 =?us-ascii?Q?POrDfQSC9tNfJSJjzw//JICVg1Uh8hnHib5iQiCz1FvIXhQMfZyYJA5G6SMh?=
 =?us-ascii?Q?Cp0qcu+sU69iwbBZJM9AakwvfZiytxvI7bcmgrYjThmV6GG0jvW8fEAcOAiI?=
 =?us-ascii?Q?4Xt8lmhX62c89zt69UPGcGPdeEP5DseF/jUZV04FEiBK/fuhapRdYGf7m/1B?=
 =?us-ascii?Q?DL63qY4plkATPmWTbsjXlPm7METbZ7p/sDRRJdcAJ+dbkTLhV2fySPhi55KV?=
 =?us-ascii?Q?xj2xWQl/JY9OZm1ZMlGBC8aETa+CtzJRzrZriJZW2sf0PRymeaMWW5HjVEH/?=
 =?us-ascii?Q?zP6a+e3iG8RbE+EC3WaPr9ZbYYk97Wo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26894cf-779c-4766-7570-08df1c6c20e8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 07:51:24.7849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cFlTg3mSYFpBKehN/DQGwwmxflEIGXjwt0eHl0cJOuh2pM0JGvEBfnPGiYv0JuWL4d9I97v/6eNHvnrp3YGn5O32R+JK74Oo2ri+2oP91w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6759
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The GEM MMIO callbacks ignored the low address bits and access size.
Byte reads therefore always returned lane zero, causing guest driver
that reads the station address byte by byte to turn four unique MAC
addresses into the same value. Partial writes had the corresponding
lane-selection problem.

Extract the requested little-endian read lane and merge partial writes
with the current register value. Preserve the existing read-clear,
write-clear, and command side effects, including dynamic queue
pointers.

Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- drop the gem_get_register() helper

 hw/net/cadence_gem.c | 55 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 39e3620ef5..522fdb91e9 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1590,8 +1590,11 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 {
     CadenceGEMState *s;
     uint32_t retval;
+    unsigned shift;
+
     s = opaque;
 
+    shift = (offset & 3) * 8;
     offset >>= 2;
     retval = s->regs[offset];
 
@@ -1625,7 +1628,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 
     DB_PRINT("0x%08x\n", retval);
     gem_update_int_status(s);
-    return retval;
+    return extract32(retval, shift, size * 8);
 }
 
 /*
@@ -1636,35 +1639,43 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         unsigned size)
 {
     CadenceGEMState *s = (CadenceGEMState *)opaque;
-    uint32_t readonly;
+    uint32_t access_mask;
+    uint32_t writable_mask;
+    uint32_t write_val;
+    unsigned shift;
     int i;
 
     DB_PRINT("offset: 0x%04x write: 0x%08x ", (unsigned)offset, (unsigned)val);
+    shift = (offset & 3) * 8;
+    access_mask = MAKE_64BIT_MASK(shift, size * 8);
+    write_val = (uint32_t)val << shift;
     offset >>= 2;
 
     /* Squash bits which are read only in write value */
-    val &= ~(s->regs_ro[offset]);
-    /* Preserve (only) bits which are read only and wtc in register */
-    readonly = s->regs[offset] & (s->regs_ro[offset] | s->regs_w1c[offset]);
+    write_val &= ~(s->regs_ro[offset]);
 
-    /* Copy register write to backing store */
-    s->regs[offset] = (val & ~s->regs_w1c[offset]) | readonly;
+    /* Copy writable bits in the accessed lanes to the backing store */
+    writable_mask = access_mask &
+                    ~(s->regs_ro[offset] | s->regs_w1c[offset]);
+    s->regs[offset] = (s->regs[offset] & ~writable_mask) |
+                      (write_val & writable_mask);
 
     /* do w1c */
-    s->regs[offset] &= ~(s->regs_w1c[offset] & val);
+    s->regs[offset] &= ~(s->regs_w1c[offset] & write_val);
 
     /* Handle register write side effects */
     switch (offset) {
     case R_NWCTRL:
-        if (FIELD_EX32(val, NWCTRL, ENABLE_RECEIVE)) {
+        if (FIELD_EX32(write_val, NWCTRL, ENABLE_RECEIVE)) {
             for (i = 0; i < s->num_priority_queues; ++i) {
                 gem_get_rx_desc(s, i);
             }
         }
-        if (FIELD_EX32(val, NWCTRL, TRANSMIT_START)) {
+        if (FIELD_EX32(write_val, NWCTRL, TRANSMIT_START)) {
             gem_transmit(s);
         }
-        if (!(FIELD_EX32(val, NWCTRL, ENABLE_TRANSMIT))) {
+        if ((access_mask & R_NWCTRL_ENABLE_TRANSMIT_MASK) &&
+            !(FIELD_EX32(s->regs[offset], NWCTRL, ENABLE_TRANSMIT))) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
                 s->tx_desc_addr[i] = gem_get_tx_queue_base_addr(s, i);
@@ -1679,37 +1690,37 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         gem_update_int_status(s);
         break;
     case R_RXQBASE:
-        s->rx_desc_addr[0] = val;
+        s->rx_desc_addr[0] = s->regs[offset];
         break;
     case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
-        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = val;
+        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = s->regs[offset];
         break;
     case R_TXQBASE:
-        s->tx_desc_addr[0] = val;
+        s->tx_desc_addr[0] = s->regs[offset];
         break;
     case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
-        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = val;
+        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = s->regs[offset];
         break;
     case R_RXSTATUS:
         gem_update_int_status(s);
         break;
     case R_IER:
-        s->regs[R_IMR] &= ~val;
+        s->regs[R_IMR] &= ~write_val;
         gem_update_int_status(s);
         break;
     case R_JUMBO_MAX_LEN:
-        s->regs[R_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
+        s->regs[R_JUMBO_MAX_LEN] &= MAX_JUMBO_FRAME_SIZE_MASK;
         break;
     case R_INT_Q1_ENABLE ... R_INT_Q7_ENABLE:
-        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~val;
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~write_val;
         gem_update_int_status(s);
         break;
     case R_IDR:
-        s->regs[R_IMR] |= val;
+        s->regs[R_IMR] |= write_val;
         gem_update_int_status(s);
         break;
     case R_INT_Q1_DISABLE ... R_INT_Q7_DISABLE:
-        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= val;
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= write_val;
         gem_update_int_status(s);
         break;
     case R_SPADDR1LO:
@@ -1725,7 +1736,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
     case R_PHYMNTNC:
-        gem_handle_phy_access(s);
+        if (access_mask & (R_PHYMNTNC_OP_MASK | R_PHYMNTNC_ST_MASK)) {
+            gem_handle_phy_access(s);
+        }
         break;
     }
 
---
base-commit: efa3b9d5ac8024078225e1ab434411fdfe53b457
branch: cadence

-- 
2.53.0


