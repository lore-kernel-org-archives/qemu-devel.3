Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C54C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymkE-0001xt-VI; Tue, 25 Aug 2026 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wymkD-0001xh-Eg; Tue, 25 Aug 2026 04:42:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wymkB-0008TJ-9m; Tue, 25 Aug 2026 04:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abBeWeFc3KCy8HlSFZvOwU34Q/wdfqXLRZh1uEEFEBh7POENpNkb/Xlvt+eSI07kQjk654r4QNfNYS8vOW3GmXl1OS0sHA6tLdz0Vuq5mZOcqiGfxHGRcAQtk8Zy+g81sOq4ilhX7oBeKGBaJg6ujehJufBW1Dq2Bi7cpdfy3UfNyr4IaNMi0r3Fo8BK+9BhsBOHfoDo+qK9+7TYqLd7D1vGO9NiN22rBTFmOy07BO5e9y6TOK+DbGAup2XORJQEzquZKCaTV3J3q22wLCjvtxocx2V8/J2uAKYDKPz19oZiNK7pBgwNkZuqh3Qyap2qicR9hUO1h+Qem0wZ2pW8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw/INqAEpusAJ+6hmxCU458epkGMO9niRBEBC5KKEQQ=;
 b=UCtqm5891F+KxAVk1hN+GgpiVk/LsyALOimLgJ9W7ovjEkvUefsH0Awt025DTYj2ppD/D5u7UphWGWIdk6UKWBeqHg0UcCAq34pawc9QE1+u5KUdCRIVUhJtOAxepps72AyR5XnuhnHrI04rK/C40dLOxoQ3G2t8q542MIYw4gG9sIAZiGNcDCzLDuQtiPJhfSCyPVGxyBfrqb3XvNEPfsTKUt+8rGZ9c141ZXlzn0U+5dvtDVbGP5yh6Whkw5iqHSqcIB2g4+h1Vel2yF6mZkqgCxzEdIyF0sXTw/ihj4g2je14BFyXNZ+mIUhSKNRAf+wGofHVR1Ga1yTafDYHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw/INqAEpusAJ+6hmxCU458epkGMO9niRBEBC5KKEQQ=;
 b=XBGhXazMUR6ILQ1oR/97J5+5Hus1qnpukwtJX4kXjXPp/8PbqrRm0h6Hj5jJ565QhmwSoCg2fbeOjPn0rsr8S7M17K3KaehYaBRFzrWFw0KBl7NUUnKpKwBOpyeFphsx4lmRE2MHBIwg72owaktN5AtC22PX3lEV2dp/0vP6kDsUuY/LH1OyJpj44JF3JdMxZBj92rimuslnuAotwWZ84z31p0PJ0rGVS+mqr2wtouBRpOvCgDSBP8t5HfA3HUe8PqmXpjdhPZjzpAp3su3YkQ4mPqNL5EFXgtem8pKokpdhjhsV82sQcLdUP/HBlIXS3b7lU5hHUoSU6TRvOX7nZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by JH0PR02MB6938.apcprd02.prod.outlook.com (2603:1096:990:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:42:44 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:42:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH] hw/net: cadence: Honor subword lanes in the GEM registers
Date: Tue, 25 Aug 2026 16:42:23 +0800
Message-ID: <20260825084224.1827672-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:405:370::16) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|JH0PR02MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: b803e3bd-2916-4de1-1dc4-08df0284d26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: NyQQPX5iVZ9h2Xj77iv0tSER+NuCaHn4zGtNFp5BPvVJ8dAqvZV/QaBL5kDWp/jaEUsYicVpxd/u+4CEXudab97WtCr3Cz0OFuxJ2c/tkExk9cnflLRivvhpOwAYZy1qY+auGK+j2oyRbBnFpn5C8QZBB7Jfgpf7BylHE90si5cYF1shZ9nPvxxGJ7KZasmsCaEH9AXfIhuYASVRJ7OjB5FSy38oybnOiKgpalWiYOWmkv7LNW54CVcJi6SHIIThXITd/KysBbUTPPlERMnKdytN00j6y1ABwL6WyVg9NDpxwjN593/ApzlXXB1eUbB1ZuRwt8f/3zrOeajNgh02EeV3Cl78sl1qc8IkXxYEfszBu/XaVlVdQ7oAHpMKo37yfmS8kmBFVds7M3beiEwyRRfl8Cu+EZiAAunwmH5tq9us3chM+savBcSQR4HdA1kSlCiyxlBKVW4P71edChNoUsTsmIwIy/FMOLzleCV7CXphIZDHA/MIFL1vhNUq5Ym/T0Ctl4lbwi0DwM94YfBpih5uNpZRqgs+85BC84BAvshCZJ7jeqGjjQCKiJ8geemvv26iRl7XfVre8tQsKTbkkiE+MYcCroSfV1lgVOTsNMWYUFO3AuVFwNs1a0NegOaVKKvWvjxoM7SxkQws397WcMSOL9CtAZXOm78EQrgPIHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2feckJqAPpv8OUX4P1ZOa5Fqx+AV2afreKsh7pMkaQsGfb3pJt3lQMVFrIb?=
 =?us-ascii?Q?rg+gMpEvdkAZ+0j0mxD0vLrtrImyp1e0r+1oYoQa58QrsnnsdNnX9k1P3IYR?=
 =?us-ascii?Q?ogRwJ/nyViWFkFVPSIKv/WQbuwLGhrBnUXINrs8YGX2J7oOHRXbFPHJ6pY0D?=
 =?us-ascii?Q?Hp4sYrp2e4WY2a2BCLenX2wgqV2GzWy7aHZAMLLRRgH0o1Z8MoJ2qGgdSjkY?=
 =?us-ascii?Q?8X3Vfnr9YvmX1G/vIyOKaXP6CjCA6tJSA+NNOpZO5sOoGlPMRcG2W63ktjtL?=
 =?us-ascii?Q?NjXKDVLHBv8IrBjV0WDxlWysm/NIUntlPyYfIl5OINvbzjtIhhmmCW0qAvRI?=
 =?us-ascii?Q?j19r1yzWblmy1uqDZhFiC6rJUKuUvUKsw66IetsbAYD+LZ88zW8pOT1pgpck?=
 =?us-ascii?Q?VRGwVtyJT19U02FDALXEoSVEZ8ASwt6XeKYbDSIs7noiobjh63g8kDatH4a6?=
 =?us-ascii?Q?i81YwWoduj8sApUmJX3GJNa9d3OylzYw+SNTDoLdRC5VP+/X71WjMJzISas0?=
 =?us-ascii?Q?Gqt4fanlFafTIg/bjKBEDCj9q+0AOIe3Cg0GQ9VQsQf6hWzl/ty0wsFqVuCR?=
 =?us-ascii?Q?KdX/xcmjkcULahmWLxhuP+2Rd4ERz4hfpR0WiB5t9BzZazEbK93m6j6oXjXq?=
 =?us-ascii?Q?KXrAOJokx0szm1Arb9/URCHhZs5Jh27eJUyRj/mvA/UWgkBE7szRHLMJ+wg8?=
 =?us-ascii?Q?atqtOV+iWbrvOIFWdQUs21NUYlz0gjtvZrF2XgXYB+qOhMV7L9YXwHDxdYUa?=
 =?us-ascii?Q?CFyW1oLjD3zf9AQuoXZ5tXE+YR7asPOwv9vL6hTUdf/SY5pXg9iQPlKNbjI9?=
 =?us-ascii?Q?LsagBgvl8gf+kRkKMKCsUK9eiWWHvZF60B0ayUdXJ6V7w/+NxuPXrA4ZpZYl?=
 =?us-ascii?Q?pKpgFZ9Qecxv0+67du0hrJrvgnwpKFBWGHcU7JS8wfG5Nnr2DwAvSrfR2OOm?=
 =?us-ascii?Q?FHd9Xm6kyh9U+dAKN1JZJIy0bEF68lRqAQthQ4j8wrUuSnRFoKsqCPtfyRYJ?=
 =?us-ascii?Q?vmsvw4lmCMK7juax9+WF8wt7uYmHGaHku3/6qMznMwfKb+sEYybupJzoCt80?=
 =?us-ascii?Q?GTRhqF1sTXuou3J1G0A9AtYGP1P8hVe4mb0huntqBeZQqCuvycR67+BSTFoz?=
 =?us-ascii?Q?jblI4fvHqr+Jvbk/Pz414bYqpQma3gZCd3Ww+v5h87Gv4K8TLRapfVFJqAq5?=
 =?us-ascii?Q?1TzwVXPcouaYnII5jGkJBDi7R3CQYJIaVYUYta8c2llrYyV0abqqhljT3IhE?=
 =?us-ascii?Q?xmdTvN1TAiS71TWAeV+ZNH4+wPvsPyBLLmARz0YhPGMG3Z5X9AM7+eKqubq1?=
 =?us-ascii?Q?ev/3rLoEYaW5trasgT6cBmfJfdp/xswL6unxmqKL5C8hAnhygO9v+U/5xIMu?=
 =?us-ascii?Q?8N9TgPJx/tgrRuW/o/C12fitRsMuFJW3DJZ6zEh03Hb7Ha5b6acjzXweV1mw?=
 =?us-ascii?Q?FLSX8036S/p+BKnU/Nyti1WbKh1ogADSE6cxWaChvY0KbaqrH1He7QHD752M?=
 =?us-ascii?Q?2F1EA6jgh5OT0ORka073uWKapfbLD0Sx0MzybbPKuoott1ek8JRYNhLXOogM?=
 =?us-ascii?Q?ZdJFQblODF/vT49oHxYa5sKEtlR40wKEGY7F/hZWHBU/8QhijVrqmSbinQ6x?=
 =?us-ascii?Q?OLBjrQ2LFk+aZ8en8/5WoFph++Px+TObZglf2qWMwzMzfXGjnqQgSkHlDEsC?=
 =?us-ascii?Q?dFXbRmvBI8B9cHR2O6FawLFQNncTAy0cCQUydTP2yMj1tHlo+MuTIz8aJ7Qq?=
 =?us-ascii?Q?i3b6b8sOHyi1j68eHvy3ZnaFudOR+7I=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b803e3bd-2916-4de1-1dc4-08df0284d26e
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:42:40.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ipp1vw6kHLQgWzsebjPEMztiuQzXXuUR+DjoW1xY53WOnfBby2R20h2eXUzLa0iv6hcOxvEM+/1vEtJNKo5a7ysSb6xA12pc0iJ9nKBjWx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6938
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

 hw/net/cadence_gem.c | 94 ++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 39e3620ef5..a4c61e3306 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1582,21 +1582,9 @@ static void gem_handle_phy_access(CadenceGEMState *s)
     }
 }
 
-/*
- * gem_read32:
- * Read a GEM register.
- */
-static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
+static uint32_t gem_get_register(CadenceGEMState *s, unsigned offset)
 {
-    CadenceGEMState *s;
     uint32_t retval;
-    s = opaque;
-
-    offset >>= 2;
-    retval = s->regs[offset];
-
-    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset * 4,
-             retval);
 
     switch (offset) {
     case R_RXQBASE:
@@ -1611,6 +1599,34 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
         retval = s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1];
         break;
+    default:
+        retval = s->regs[offset];
+        break;
+    }
+
+    return retval;
+}
+
+/*
+ * gem_read32:
+ * Read a GEM register.
+ */
+static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CadenceGEMState *s;
+    uint32_t retval;
+    unsigned shift;
+
+    s = opaque;
+
+    shift = (offset & 3) * 8;
+    offset >>= 2;
+    retval = gem_get_register(s, offset);
+
+    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset * 4,
+             retval);
+
+    switch (offset) {
     case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
@@ -1625,7 +1641,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 
     DB_PRINT("0x%08x\n", retval);
     gem_update_int_status(s);
-    return retval;
+    return extract32(retval, shift, size * 8);
 }
 
 /*
@@ -1636,35 +1652,43 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
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
+    s->regs[offset] = (gem_get_register(s, offset) & ~writable_mask) |
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
@@ -1679,37 +1703,37 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
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
@@ -1725,7 +1749,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
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
base-commit: fd7ab698c921e2e97aa1b1d5b719d42103a2dd58
branch: cadence

-- 
2.53.0


