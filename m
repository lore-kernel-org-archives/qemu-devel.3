Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A7BE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdTI-0000k9-JU; Wed, 18 Feb 2026 04:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTH-0000jf-4t
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTF-0008Sa-Mu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trO6A6IjlpgNbzVR7kz3ETeP3M3fhTsm0v2ihyysHDg=;
 b=RhWyMf+ZRrQNfnGICInAG3h/xhN7KDdsA4kofNZ2glYlncSMpzwINBE/VZg/F73oeCiKGb
 uInKyDwt6c/chs3LuiXTupRDP4NEizpH562Uca0O+L45O9obDONsJxTc4rDrIlDIYFnGb2
 YKS1klXEJliQYePv13eVaOHxMmHqe28=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-ekLVpFgsM-6o1FDij37u2g-1; Wed,
 18 Feb 2026 04:03:43 -0500
X-MC-Unique: ekLVpFgsM-6o1FDij37u2g-1
X-Mimecast-MFC-AGG-ID: ekLVpFgsM-6o1FDij37u2g_1771405422
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86F86195605C; Wed, 18 Feb 2026 09:03:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04F61180066E; Wed, 18 Feb 2026 09:03:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 03/85] audio/adlib: drop ts_helper HWVoice field
Date: Wed, 18 Feb 2026 10:02:03 +0100
Message-ID: <20260218090330.1476169-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Previous commits made this dead code.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h | 2 --
 audio/audio.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index b2b8002477c..20b4c87b0b6 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -77,7 +77,6 @@ typedef struct HWVoiceOut {
     struct audio_pcm_info info;
 
     f_sample *clip;
-    uint64_t ts_helper;
 
     STSampleBuffer mix_buf;
     void *buf_emul;
@@ -99,7 +98,6 @@ typedef struct HWVoiceIn {
     t_sample *conv;
 
     size_t total_samples_captured;
-    uint64_t ts_helper;
 
     STSampleBuffer conv_buf;
     void *buf_emul;
diff --git a/audio/audio.c b/audio/audio.c
index b7a28f79d4f..a218570a4f4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1240,7 +1240,6 @@ static void audio_run_out(AudioBackend *s)
 #endif
 
         if (played) {
-            hw->ts_helper += played;
             audio_capture_mix_and_clear (hw, prev_rpos, played);
         }
 
@@ -1320,7 +1319,6 @@ static void audio_run_in(AudioBackend *s)
 
         min = audio_pcm_hw_find_min_in (hw);
         hw->total_samples_captured += captured - min;
-        hw->ts_helper += captured;
 
         for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
             sw->total_hw_samples_acquired -= min;
-- 
2.53.0


