Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6409C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgQl-0002tV-Tq; Tue, 28 Jan 2025 02:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgQj-0002eC-2T; Tue, 28 Jan 2025 02:54:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgQd-0008BV-JL; Tue, 28 Jan 2025 02:54:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E534DE1ACD;
 Tue, 28 Jan 2025 10:52:59 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FC031A62BC;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 2F4195200F; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 20/31] hw/intc/arm_gicv3_its: Zero initialize local
 DTEntry etc structs
Date: Tue, 28 Jan 2025 00:41:12 +0300
Message-Id: <20250127214124.3730126-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In the GICv3 ITS model, we have a common coding pattern which has a
local C struct like "DTEntry dte", which is a C representation of an
in-guest-memory data structure, and we call a function such as
get_dte() to read guest memory and fill in the C struct.  These
functions to read in the struct sometimes have cases where they will
leave early and not fill in the whole struct (for instance get_dte()
will set "dte->valid = false" and nothing else for the case where it
is passed an entry_addr implying that there is no L2 table entry for
the DTE).  This then causes potential use of uninitialized memory
later, for instance when we call a trace event which prints all the
fields of the struct.  Sufficiently advanced compilers may produce
-Wmaybe-uninitialized warnings about this, especially if LTO is
enabled.

Rather than trying to carefully separate out these trace events into
"only the 'valid' field is initialized" and "all fields can be
printed", zero-init all the structs when we define them. None of
these structs are large (the biggest is 24 bytes) and having
consistent behaviour is less likely to be buggy.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2718
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241213182337.3343068-1-peter.maydell@linaro.org
(cherry picked from commit 9678b9c505725732353baefedb88b53c2eb8a184)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index 2ff21ed6bb..05b63a0848 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -468,7 +468,7 @@ static ItsCmdResult lookup_vte(GICv3ITSState *s, const char *who,
 static ItsCmdResult process_its_cmd_phys(GICv3ITSState *s, const ITEntry *ite,
                                          int irqlevel)
 {
-    CTEntry cte;
+    CTEntry cte = {};
     ItsCmdResult cmdres;
 
     cmdres = lookup_cte(s, __func__, ite->icid, &cte);
@@ -482,7 +482,7 @@ static ItsCmdResult process_its_cmd_phys(GICv3ITSState *s, const ITEntry *ite,
 static ItsCmdResult process_its_cmd_virt(GICv3ITSState *s, const ITEntry *ite,
                                          int irqlevel)
 {
-    VTEntry vte;
+    VTEntry vte = {};
     ItsCmdResult cmdres;
 
     cmdres = lookup_vte(s, __func__, ite->vpeid, &vte);
@@ -517,8 +517,8 @@ static ItsCmdResult process_its_cmd_virt(GICv3ITSState *s, const ITEntry *ite,
 static ItsCmdResult do_process_its_cmd(GICv3ITSState *s, uint32_t devid,
                                        uint32_t eventid, ItsCmdType cmd)
 {
-    DTEntry dte;
-    ITEntry ite;
+    DTEntry dte = {};
+    ITEntry ite = {};
     ItsCmdResult cmdres;
     int irqlevel;
 
@@ -586,8 +586,8 @@ static ItsCmdResult process_mapti(GICv3ITSState *s, const uint64_t *cmdpkt,
     uint32_t pIntid = 0;
     uint64_t num_eventids;
     uint16_t icid = 0;
-    DTEntry dte;
-    ITEntry ite;
+    DTEntry dte = {};
+    ITEntry ite = {};
 
     devid = (cmdpkt[0] & DEVID_MASK) >> DEVID_SHIFT;
     eventid = cmdpkt[1] & EVENTID_MASK;
@@ -654,8 +654,8 @@ static ItsCmdResult process_vmapti(GICv3ITSState *s, const uint64_t *cmdpkt,
 {
     uint32_t devid, eventid, vintid, doorbell, vpeid;
     uint32_t num_eventids;
-    DTEntry dte;
-    ITEntry ite;
+    DTEntry dte = {};
+    ITEntry ite = {};
 
     if (!its_feature_virtual(s)) {
         return CMD_CONTINUE;
@@ -764,7 +764,7 @@ static bool update_cte(GICv3ITSState *s, uint16_t icid, const CTEntry *cte)
 static ItsCmdResult process_mapc(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
     uint16_t icid;
-    CTEntry cte;
+    CTEntry cte = {};
 
     icid = cmdpkt[2] & ICID_MASK;
     cte.valid = cmdpkt[2] & CMD_FIELD_VALID_MASK;
@@ -825,7 +825,7 @@ static bool update_dte(GICv3ITSState *s, uint32_t devid, const DTEntry *dte)
 static ItsCmdResult process_mapd(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
     uint32_t devid;
-    DTEntry dte;
+    DTEntry dte = {};
 
     devid = (cmdpkt[0] & DEVID_MASK) >> DEVID_SHIFT;
     dte.size = cmdpkt[1] & SIZE_MASK;
@@ -889,9 +889,9 @@ static ItsCmdResult process_movi(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
     uint32_t devid, eventid;
     uint16_t new_icid;
-    DTEntry dte;
-    CTEntry old_cte, new_cte;
-    ITEntry old_ite;
+    DTEntry dte = {};
+    CTEntry old_cte = {}, new_cte = {};
+    ITEntry old_ite = {};
     ItsCmdResult cmdres;
 
     devid = FIELD_EX64(cmdpkt[0], MOVI_0, DEVICEID);
@@ -968,7 +968,7 @@ static bool update_vte(GICv3ITSState *s, uint32_t vpeid, const VTEntry *vte)
 
 static ItsCmdResult process_vmapp(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
-    VTEntry vte;
+    VTEntry vte = {};
     uint32_t vpeid;
 
     if (!its_feature_virtual(s)) {
@@ -1033,7 +1033,7 @@ static void vmovp_callback(gpointer data, gpointer opaque)
      */
     GICv3ITSState *s = data;
     VmovpCallbackData *cbdata = opaque;
-    VTEntry vte;
+    VTEntry vte = {};
     ItsCmdResult cmdres;
 
     cmdres = lookup_vte(s, __func__, cbdata->vpeid, &vte);
@@ -1088,9 +1088,9 @@ static ItsCmdResult process_vmovi(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
     uint32_t devid, eventid, vpeid, doorbell;
     bool doorbell_valid;
-    DTEntry dte;
-    ITEntry ite;
-    VTEntry old_vte, new_vte;
+    DTEntry dte = {};
+    ITEntry ite = {};
+    VTEntry old_vte = {}, new_vte = {};
     ItsCmdResult cmdres;
 
     if (!its_feature_virtual(s)) {
@@ -1189,10 +1189,10 @@ static ItsCmdResult process_vinvall(GICv3ITSState *s, const uint64_t *cmdpkt)
 static ItsCmdResult process_inv(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
     uint32_t devid, eventid;
-    ITEntry ite;
-    DTEntry dte;
-    CTEntry cte;
-    VTEntry vte;
+    ITEntry ite = {};
+    DTEntry dte = {};
+    CTEntry cte = {};
+    VTEntry vte = {};
     ItsCmdResult cmdres;
 
     devid = FIELD_EX64(cmdpkt[0], INV_0, DEVICEID);
-- 
2.39.5


