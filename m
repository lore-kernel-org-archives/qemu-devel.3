Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FDB10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYdQ-0002go-0D; Wed, 08 Apr 2026 15:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1wAYJO-00088t-US
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:39 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1wAHeP-00056h-3P
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:24:17 -0400
X-UUID: 9ce9225c32e911f1aa26b74ffac11d73-20260408
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:232959a4-facd-47cb-91cd-aa8f8797d01a, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:1486a81185f24feb4d20892f30c03bf4,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9ce9225c32e911f1aa26b74ffac11d73-20260408
X-User: yujun@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yujun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1573712403; Wed, 08 Apr 2026 09:23:56 +0800
From: Jun Yu <yujun@kylinos.cn>
To: marcandre.lureau@redhat.com,
	odaki@rsg.ci.i.u-tokyo.ac.jp
Cc: mark.caveayland@nutanix.com, philmd@linaro.org, thuth@redhat.com,
 qemu-devel@nongnu.org, Jun Yu <yujun@kylinos.cn>
Subject: [PATCH] audio/pipewire: Fix stack overflow by moving buffer to heap
Date: Wed,  8 Apr 2026 09:23:41 +0800
Message-Id: <20260408012341.16131-1-yujun@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=yujun@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Apr 2026 15:32:16 -0400
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

The PWVoice struct was allocating a large 4MB buffer on the stack using
uint8_t buffer[RINGBUFFER_SIZE], which could cause stack overflow.

This commit:
1. Changes the buffer from stack allocation to heap allocation by replacing
   uint8_t buffer[RINGBUFFER_SIZE] with uint8_t *buffer
2. Adds g_malloc() calls in qpw_init_out() and qpw_init_in() to allocate
   the buffer on the heap
3. Adds g_free() in qpw_voice_fini() to properly clean up the buffer
4. Adds error handling for allocation failures

This fix prevents stack overflow while maintaining the same functionality,
as each audio stream (input/output) still gets its own independent buffer
for the ringbuffer operations.

Signed-off-by: Jun Yu <yujun@kylinos.cn>
---
 audio/pwaudio.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index a59c22e60b..ff75ec2af2 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -56,7 +56,7 @@ typedef struct PWVoice {
     uint32_t highwater_mark;
     uint32_t frame_size, req;
     struct spa_ringbuffer ring;
-    uint8_t buffer[RINGBUFFER_SIZE];
+    uint8_t *buffer;
 
     pwvolume volume;
     bool muted;
@@ -532,6 +532,12 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
     AudiodevPipewirePerDirectionOptions *ppdo = popts->out;
     int r;
 
+    v->buffer = g_malloc(RINGBUFFER_SIZE);
+    if (!v->buffer) {
+        error_report("pipewire: failed to allocate buffer");
+        return -1;
+    }
+
     pw_thread_loop_lock(c->thread_loop);
 
     v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
@@ -551,6 +557,8 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
                        ppdo->name, SPA_DIRECTION_OUTPUT);
     if (r < 0) {
         pw_thread_loop_unlock(c->thread_loop);
+        g_free(v->buffer);
+        v->buffer = NULL;
         return -1;
     }
 
@@ -579,6 +587,12 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
     AudiodevPipewirePerDirectionOptions *ppdo = popts->in;
     int r;
 
+    v->buffer = g_malloc(RINGBUFFER_SIZE);
+    if (!v->buffer) {
+        error_report("pipewire: failed to allocate buffer");
+        return -1;
+    }
+
     pw_thread_loop_lock(c->thread_loop);
 
     v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
@@ -595,6 +609,8 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
                        ppdo->name, SPA_DIRECTION_INPUT);
     if (r < 0) {
         pw_thread_loop_unlock(c->thread_loop);
+        g_free(v->buffer);
+        v->buffer = NULL;
         return -1;
     }
 
@@ -619,6 +635,8 @@ qpw_voice_fini(AudioPw *c, PWVoice *v)
     pw_stream_destroy(v->stream);
     v->stream = NULL;
     pw_thread_loop_unlock(c->thread_loop);
+    g_free(v->buffer);
+    v->buffer = NULL;
 }
 
 static void
-- 
2.25.1


