Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1DFE7BD8B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw4s-0002BG-Ir; Mon, 16 Feb 2026 05:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4H-0001s5-UB
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4G-00011g-FZ
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9XkBQ/oXbUz12+FCnU0YeeeK3GbFA4EHm+vljyv3ok=;
 b=enPHstVUB80gToFofp3ddLRM11wArRoePsgfCLLui+0FOyd3GKc2RvhER14Nvli5IVp/qk
 /yN9TbRyu4xGXkcQFTCTvcrzIUu+XNYJK9BBohpArkVz1ApIdMC5z8zk64JFIlz84Aq+YF
 lc2BKT5KQc6q68XDh7o1vzgMjTZEfns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-LiECF5iUNvSo8CPkGrGdMQ-1; Mon,
 16 Feb 2026 05:43:00 -0500
X-MC-Unique: LiECF5iUNvSo8CPkGrGdMQ-1
X-Mimecast-MFC-AGG-ID: LiECF5iUNvSo8CPkGrGdMQ_1771238578
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4B8D1956061; Mon, 16 Feb 2026 10:42:57 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E3E41800465; Mon, 16 Feb 2026 10:42:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 11:42:19 +0100
Subject: [PATCH 07/85] audio: replace vm_running with runstate_is_running()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-7-edcb25699381@redhat.com>
References: <20260216-audio-v1-0-edcb25699381@redhat.com>
In-Reply-To: <20260216-audio-v1-0-edcb25699381@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2337;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=n+3siSegRS3y0Lxy97FkNncK5ldFf6lqIw8dDZCokNw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvSTPmqaLxLA/HnmcaTTCsvqE3vdDiQVPpbzs
 RWr6Rwjk4qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kwAKCRDa6OEJdZac
 5WnBD/0Wpu3HWqfd4pfZYaECQPFMgJuX4qlciR3vERz8tz2i9ViuKGz2MPe3enDc6GPfT5nRsUG
 +o/IR2SIGrF5CKUDBLemoWaT7csiIVoWmgPri5wF1nNmbcQ+lvOHVFE5qfkkahsYyTsRgjmX5Jf
 Jm6m37g/3mdulv98jEMNkDQKvPoDL+7ikHooELlFQaxTs5r0t7r+PWkzlIkOuv3xBdaWKAjnebC
 24s2fgpb3CFmx0He6hurj7sJR8CTWOLlj61P5IRuncr1szCQxAtB9XJGwB6rMzitph28+amAWFq
 o9N+2x2+AyZ7A/yjQggRwDNg+i1PCIhpNL/3ECDAWhQyumYfljyCMmyOcR+UXi6gZvXE//fi9K8
 zE4mu1J7KNZrFajgN+DKVBR/Xd+l24weCfGRTjlTPf2Hm5dCsRDmyQG0QWsJgKLG/GrNFxPnISo
 owjfC6+XH8a5fUmQyICurK2YGakinVR0XyY1vPjiYm+Y1WPtie2BuAbF1h7YSrNn1ADPp9jbBHR
 S11vwda+8DE7AyPZFAyI1+a+5RXWjNozAHPvuSMgG6uwbGYdxPHU/GjBEtDSRf4QdlUYqAqq7Zc
 7e8ylb8ruQrclQRkXkiiDWwcJu/uLje+tkSxW5qJXrdbSg7wGmTIgbiPI9ZL3FSEchlfaeskMAz
 vhLGGEXijI+/M0A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AudioBackend had a vm_running field which was set in
audio_vm_change_state_handler().

The state change handler "bool running" argument is true when
vm_prepare_start() calls it, and the VM runstate is either SUSPENDED or
RUNNING.

Audio hw voices shouldn't be running when the VM is suspended, but only
when running. Thus replacing the vm_running field with a call to
runstate_is_running() is both simpler and more correct.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


