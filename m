Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2016E98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSXL-0004Dl-Bx; Mon, 23 Feb 2026 04:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXA-0003zm-TE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSX9-0006pm-Bd
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/8Lhqa9JuzvRQV6JBHOjcSWNe/Ygi7du2NsJ7/nJWM=;
 b=e+SFE7HMUUiK46T6x+gkEvuzl3J20rrLL+DjDfQ8K2SWdjhmTAapVNiip7j9AgndcFf8rm
 G4YxtGLpSM2Ti+SPFrXG8vCtcz6wqk8v5Wg72tSbz9fyKxlGoz1yOiR0eVmG1zgzulXOYc
 DiICuu90//DaNuOjMsBDn4duXH57AB4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-RQeKIWzEOwKkjGiN4tn9UA-1; Mon,
 23 Feb 2026 04:47:14 -0500
X-MC-Unique: RQeKIWzEOwKkjGiN4tn9UA-1
X-Mimecast-MFC-AGG-ID: RQeKIWzEOwKkjGiN4tn9UA_1771840033
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A509E19560A3; Mon, 23 Feb 2026 09:47:13 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 227C01955F22; Mon, 23 Feb 2026 09:47:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 07/85] audio: replace vm_running with runstate_is_running()
Date: Mon, 23 Feb 2026 10:45:25 +0100
Message-ID: <20260223094649.2005118-8-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

AudioBackend had a vm_running field which was set in
audio_vm_change_state_handler().

The state change handler "bool running" argument is true when
vm_prepare_start() calls it, and the VM runstate is either SUSPENDED or
RUNNING.

Audio hw voices shouldn't be running when the VM is suspended, but only
when running. Thus replacing the vm_running field with a call to
runstate_is_running() is both simpler and more correct.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h | 1 -
 audio/audio.c     | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 20b4c87b0b6..25de0e3f9cf 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -252,7 +252,6 @@ typedef struct AudioBackend {
     QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
     int nb_hw_voices_out;
     int nb_hw_voices_in;
-    int vm_running;
     int64_t period_ticks;
 
     bool timer_running;
diff --git a/audio/audio.c b/audio/audio.c
index 9563583cd1e..68698b13e15 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -933,7 +933,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
             hw->pending_disable = 0;
             if (!hw->enabled) {
                 hw->enabled = true;
-                if (s->vm_running) {
+                if (runstate_is_running()) {
                     if (hw->pcm_ops->enable_out) {
                         hw->pcm_ops->enable_out(hw, true);
                     }
@@ -979,7 +979,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
         if (on) {
             if (!hw->enabled) {
                 hw->enabled = true;
-                if (s->vm_running) {
+                if (runstate_is_running()) {
                     if (hw->pcm_ops->enable_in) {
                         hw->pcm_ops->enable_in(hw, true);
                     }
@@ -1598,7 +1598,6 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
 
-    s->vm_running = running;
     while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
         if (hwo->pcm_ops->enable_out) {
             hwo->pcm_ops->enable_out(hwo, running);
-- 
2.53.0


