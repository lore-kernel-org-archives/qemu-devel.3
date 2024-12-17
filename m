Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF90CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbF0-00080i-Ma; Tue, 17 Dec 2024 12:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEw-0007zV-W7
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:11 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEl-0006GI-Li
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:10 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so3640441f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455998; x=1735060798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=673gMgKWT3TLRKI285qFmHPbfGLkvDLWeFaKIf5VVwQ=;
 b=mm+QtEs6kMdUJrkiMRXHHADtrMxmOIBUp0dQp4ZtvGUlBoRlpJAVKjY2DE8rmEu7zx
 2bdmNrU3wmW7Fq+up2PDCsVU/pCuM6yVjdvRdSeT77fsbU+UYf5H7d1X0MV1O+5pBjVE
 xa0fhQRyw9fQYQv1cKMNtRYfaLUMbjPnpf1CSIC9igdnUqMfIdA+8+MMF/h7p4PcjnIs
 UsKri+hy9XC0HkTaZyFdTdaR6iHEQvYaLX7Y7Tdx4AOFOex1NH/S5IP11+bf+w3k5vlJ
 40jqvL+LbmXQJ3M/r/G4pU8rDy3e+RyJQHNORVgun6spl0M/yY7haO0ErxbcDZlZAArw
 jEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455998; x=1735060798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=673gMgKWT3TLRKI285qFmHPbfGLkvDLWeFaKIf5VVwQ=;
 b=cvQV/aK23JckS8rwAEv6PaPCGRm+BmO1VrzzOICsNnnh7SFRnAO/GJwhQCDQ9Vo07E
 B2anP2m7K+gZtru/R4gLNI79dreCSUwruLc5ZXps+dk+oLArkNcNHKNW7c3QwY1MbOo5
 IPs6zz9iE1SG8Lp33RH/NLnc+LOKTPInGA+cFl1T7NuJoRdstyMMhbUX2Dn09kpga6XO
 XWsXvmeoOaZ8wHw1ZkT8IBcQAPkV5c84ds88mMVJURCIRHk49pdvn4YQd9GI1bbjNGeq
 nQCveMuLZZpdO5nqOvIXCYD3bN2Y/5jSc69+2LaS1pegnH1wGcI0xcbH6M+4W3kaq828
 wPNg==
X-Gm-Message-State: AOJu0Yw7dBnR8iB6cXhTKGCM6C7hQyn+TWKu2SA0a1IF7lwLJiubJWCX
 DA0Ux1aAOjXXBcJb/QG+ET+BopTUoMBl24dYJfvi8vFEjsUnvijwVRew8NSmgIbXcgkTbkPcFZR
 4
X-Gm-Gg: ASbGncssSmr20EbsDkRsfiNTtrwY7sUCwLPeZFOlRoTaQm6I4PENhBbmHFwYHF1LgDn
 rwCKzCEvaZ8VAKc9C5l+eKDi+mjwh9LuCP+DAkn9ZfuT6iTHya1wcTFAbf/jULoh2NDhICKlbxx
 DYZ2vlsSaaVa8ZWDuxaZmIPLo6torCrf/WYqOkqnvSe+UukGRdcHiAG0cJkUUVt0WfZMOchS3mb
 E04rgj7olYhHc5116hUBkFaygkchnL9kS8tSEvUqNJazOodw97oMboVxT79we0=
X-Google-Smtp-Source: AGHT+IH0tOPNuWiD53itQaNu2HLTWCiUr77EnqnzWs6MhyYQI2PEMYaRLqVgXIOCqJiJ66rN4xTgOA==
X-Received: by 2002:a05:6000:144d:b0:385:e37a:2a56 with SMTP id
 ffacd0b85a97d-3888e0bb669mr12691509f8f.52.1734455998044; 
 Tue, 17 Dec 2024 09:19:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc
 structs
Date: Tue, 17 Dec 2024 17:19:36 +0000
Message-Id: <20241217171937.3899947-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
---
 hw/intc/arm_gicv3_its.c | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index f50b1814eaf..0de76430089 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -465,7 +465,7 @@ static ItsCmdResult lookup_vte(GICv3ITSState *s, const char *who,
 static ItsCmdResult process_its_cmd_phys(GICv3ITSState *s, const ITEntry *ite,
                                          int irqlevel)
 {
-    CTEntry cte;
+    CTEntry cte = {};
     ItsCmdResult cmdres;
 
     cmdres = lookup_cte(s, __func__, ite->icid, &cte);
@@ -479,7 +479,7 @@ static ItsCmdResult process_its_cmd_phys(GICv3ITSState *s, const ITEntry *ite,
 static ItsCmdResult process_its_cmd_virt(GICv3ITSState *s, const ITEntry *ite,
                                          int irqlevel)
 {
-    VTEntry vte;
+    VTEntry vte = {};
     ItsCmdResult cmdres;
 
     cmdres = lookup_vte(s, __func__, ite->vpeid, &vte);
@@ -514,8 +514,8 @@ static ItsCmdResult process_its_cmd_virt(GICv3ITSState *s, const ITEntry *ite,
 static ItsCmdResult do_process_its_cmd(GICv3ITSState *s, uint32_t devid,
                                        uint32_t eventid, ItsCmdType cmd)
 {
-    DTEntry dte;
-    ITEntry ite;
+    DTEntry dte = {};
+    ITEntry ite = {};
     ItsCmdResult cmdres;
     int irqlevel;
 
@@ -583,8 +583,8 @@ static ItsCmdResult process_mapti(GICv3ITSState *s, const uint64_t *cmdpkt,
     uint32_t pIntid = 0;
     uint64_t num_eventids;
     uint16_t icid = 0;
-    DTEntry dte;
-    ITEntry ite;
+    DTEntry dte = {};
+    ITEntry ite = {};
 
     devid = (cmdpkt[0] & DEVID_MASK) >> DEVID_SHIFT;
     eventid = cmdpkt[1] & EVENTID_MASK;
@@ -651,8 +651,8 @@ static ItsCmdResult process_vmapti(GICv3ITSState *s, const uint64_t *cmdpkt,
 {
     uint32_t devid, eventid, vintid, doorbell, vpeid;
     uint32_t num_eventids;
-    DTEntry dte;
-    ITEntry ite;
+    DTEntry dte = {};
+    ITEntry ite = {};
 
     if (!its_feature_virtual(s)) {
         return CMD_CONTINUE;
@@ -761,7 +761,7 @@ static bool update_cte(GICv3ITSState *s, uint16_t icid, const CTEntry *cte)
 static ItsCmdResult process_mapc(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
     uint16_t icid;
-    CTEntry cte;
+    CTEntry cte = {};
 
     icid = cmdpkt[2] & ICID_MASK;
     cte.valid = cmdpkt[2] & CMD_FIELD_VALID_MASK;
@@ -822,7 +822,7 @@ static bool update_dte(GICv3ITSState *s, uint32_t devid, const DTEntry *dte)
 static ItsCmdResult process_mapd(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
     uint32_t devid;
-    DTEntry dte;
+    DTEntry dte = {};
 
     devid = (cmdpkt[0] & DEVID_MASK) >> DEVID_SHIFT;
     dte.size = cmdpkt[1] & SIZE_MASK;
@@ -886,9 +886,9 @@ static ItsCmdResult process_movi(GICv3ITSState *s, const uint64_t *cmdpkt)
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
@@ -965,7 +965,7 @@ static bool update_vte(GICv3ITSState *s, uint32_t vpeid, const VTEntry *vte)
 
 static ItsCmdResult process_vmapp(GICv3ITSState *s, const uint64_t *cmdpkt)
 {
-    VTEntry vte;
+    VTEntry vte = {};
     uint32_t vpeid;
 
     if (!its_feature_virtual(s)) {
@@ -1030,7 +1030,7 @@ static void vmovp_callback(gpointer data, gpointer opaque)
      */
     GICv3ITSState *s = data;
     VmovpCallbackData *cbdata = opaque;
-    VTEntry vte;
+    VTEntry vte = {};
     ItsCmdResult cmdres;
 
     cmdres = lookup_vte(s, __func__, cbdata->vpeid, &vte);
@@ -1085,9 +1085,9 @@ static ItsCmdResult process_vmovi(GICv3ITSState *s, const uint64_t *cmdpkt)
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
@@ -1186,10 +1186,10 @@ static ItsCmdResult process_vinvall(GICv3ITSState *s, const uint64_t *cmdpkt)
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
2.34.1


