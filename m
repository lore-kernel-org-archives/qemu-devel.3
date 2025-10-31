Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856ADCCF9EE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEiwG-0007Lu-31; Fri, 31 Oct 2025 02:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEivx-00070R-K8
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEivl-0003qF-HK
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtYsjuztbXqZIXvJzOChqeqiNWmlNBPVkm7CJiwD/zs=;
 b=FNXZN7ksxfNmMYWXe1wDDW1t+0lkMy5aoKnEBtl4guPGf8OYhbpHkwgQdiNleeL7pz+98h
 Jl769WzzuN4BObmGhuj8kc5cbSi7pjVDP8MSfI5FAMmlFbOoH7z20DBpuSShpwij3H6MrE
 vhvLA4zqqZ8HzRoJb3+8sw02HybBDB4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-4QOs978XOxKsT4dzKIVxvw-1; Fri,
 31 Oct 2025 02:48:10 -0400
X-MC-Unique: 4QOs978XOxKsT4dzKIVxvw-1
X-Mimecast-MFC-AGG-ID: 4QOs978XOxKsT4dzKIVxvw_1761893289
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52D9A1955DB5; Fri, 31 Oct 2025 06:48:09 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C26161800592; Fri, 31 Oct 2025 06:48:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 14/36] audio/dsound: report init error via **errp
Date: Fri, 31 Oct 2025 10:46:07 +0400
Message-ID: <20251031064631.134651-15-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Whenever NULL is returned, errp should be set.

Inline SetCooperativeLevel call to simplify code.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/dsoundaudio.c | 182 +++++++++++++++++++-------------------------
 1 file changed, 79 insertions(+), 103 deletions(-)

diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index c8745a3df0..d476e9b441 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -33,6 +33,7 @@
 #include "audio_int.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 
 #include <windows.h>
 #include <mmsystem.h>
@@ -64,162 +65,154 @@ typedef struct {
     dsound *s;
 } DSoundVoiceIn;
 
-static void dsound_log_hresult (HRESULT hr)
+static const char *dserror(HRESULT hr)
 {
-    const char *str = "BUG";
-
     switch (hr) {
     case DS_OK:
-        str = "The method succeeded";
-        break;
+        return "The method succeeded";
 #ifdef DS_NO_VIRTUALIZATION
     case DS_NO_VIRTUALIZATION:
-        str = "The buffer was created, but another 3D algorithm was substituted";
-        break;
+        return "The buffer was created, but another 3D algorithm was substituted";
 #endif
 #ifdef DS_INCOMPLETE
     case DS_INCOMPLETE:
-        str = "The method succeeded, but not all the optional effects were obtained";
-        break;
+        return "The method succeeded, but not all the optional effects were obtained";
 #endif
 #ifdef DSERR_ACCESSDENIED
     case DSERR_ACCESSDENIED:
-        str = "The request failed because access was denied";
-        break;
+        return "The request failed because access was denied";
 #endif
 #ifdef DSERR_ALLOCATED
     case DSERR_ALLOCATED:
-        str = "The request failed because resources, "
-              "such as a priority level, were already in use "
-              "by another caller";
-        break;
+        return "The request failed because resources, "
+               "such as a priority level, were already in use "
+               "by another caller";
 #endif
 #ifdef DSERR_ALREADYINITIALIZED
     case DSERR_ALREADYINITIALIZED:
-        str = "The object is already initialized";
-        break;
+        return "The object is already initialized";
 #endif
 #ifdef DSERR_BADFORMAT
     case DSERR_BADFORMAT:
-        str = "The specified wave format is not supported";
-        break;
+        return "The specified wave format is not supported";
 #endif
 #ifdef DSERR_BADSENDBUFFERGUID
     case DSERR_BADSENDBUFFERGUID:
-        str = "The GUID specified in an audiopath file "
-              "does not match a valid mix-in buffer";
-        break;
+        return "The GUID specified in an audiopath file "
+               "does not match a valid mix-in buffer";
 #endif
 #ifdef DSERR_BUFFERLOST
     case DSERR_BUFFERLOST:
-        str = "The buffer memory has been lost and must be restored";
-        break;
+        return "The buffer memory has been lost and must be restored";
 #endif
 #ifdef DSERR_BUFFERTOOSMALL
     case DSERR_BUFFERTOOSMALL:
-        str = "The buffer size is not great enough to "
-              "enable effects processing";
-        break;
+        return "The buffer size is not great enough to "
+               "enable effects processing";
 #endif
 #ifdef DSERR_CONTROLUNAVAIL
     case DSERR_CONTROLUNAVAIL:
-        str = "The buffer control (volume, pan, and so on) "
-              "requested by the caller is not available. "
-              "Controls must be specified when the buffer is created, "
-              "using the dwFlags member of DSBUFFERDESC";
-        break;
+        return "The buffer control (volume, pan, and so on) "
+               "requested by the caller is not available. "
+               "Controls must be specified when the buffer is created, "
+               "using the dwFlags member of DSBUFFERDESC";
 #endif
 #ifdef DSERR_DS8_REQUIRED
     case DSERR_DS8_REQUIRED:
-        str = "A DirectSound object of class CLSID_DirectSound8 or later "
-              "is required for the requested functionality. "
-              "For more information, see IDirectSound8 Interface";
-        break;
+        return "A DirectSound object of class CLSID_DirectSound8 or later "
+               "is required for the requested functionality. "
+               "For more information, see IDirectSound8 Interface";
 #endif
 #ifdef DSERR_FXUNAVAILABLE
     case DSERR_FXUNAVAILABLE:
-        str = "The effects requested could not be found on the system, "
-              "or they are in the wrong order or in the wrong location; "
-              "for example, an effect expected in hardware "
-              "was found in software";
-        break;
+        return "The effects requested could not be found on the system, "
+               "or they are in the wrong order or in the wrong location; "
+               "for example, an effect expected in hardware "
+               "was found in software";
 #endif
 #ifdef DSERR_GENERIC
     case DSERR_GENERIC:
-        str = "An undetermined error occurred inside the DirectSound subsystem";
-        break;
+        return "An undetermined error occurred inside the DirectSound subsystem";
 #endif
 #ifdef DSERR_INVALIDCALL
     case DSERR_INVALIDCALL:
-        str = "This function is not valid for the current state of this object";
-        break;
+        return "This function is not valid for the current state of this object";
 #endif
 #ifdef DSERR_INVALIDPARAM
     case DSERR_INVALIDPARAM:
-        str = "An invalid parameter was passed to the returning function";
-        break;
+        return "An invalid parameter was passed to the returning function";
 #endif
 #ifdef DSERR_NOAGGREGATION
     case DSERR_NOAGGREGATION:
-        str = "The object does not support aggregation";
-        break;
+        return "The object does not support aggregation";
 #endif
 #ifdef DSERR_NODRIVER
     case DSERR_NODRIVER:
-        str = "No sound driver is available for use, "
-              "or the given GUID is not a valid DirectSound device ID";
-        break;
+        return "No sound driver is available for use, "
+               "or the given GUID is not a valid DirectSound device ID";
 #endif
 #ifdef DSERR_NOINTERFACE
     case DSERR_NOINTERFACE:
-        str = "The requested COM interface is not available";
-        break;
+        return "The requested COM interface is not available";
 #endif
 #ifdef DSERR_OBJECTNOTFOUND
     case DSERR_OBJECTNOTFOUND:
-        str = "The requested object was not found";
-        break;
+        return "The requested object was not found";
 #endif
 #ifdef DSERR_OTHERAPPHASPRIO
     case DSERR_OTHERAPPHASPRIO:
-        str = "Another application has a higher priority level, "
+        return "Another application has a higher priority level, "
               "preventing this call from succeeding";
-        break;
 #endif
 #ifdef DSERR_OUTOFMEMORY
     case DSERR_OUTOFMEMORY:
-        str = "The DirectSound subsystem could not allocate "
+        return "The DirectSound subsystem could not allocate "
                "sufficient memory to complete the caller's request";
-        break;
 #endif
 #ifdef DSERR_PRIOLEVELNEEDED
     case DSERR_PRIOLEVELNEEDED:
-        str = "A cooperative level of DSSCL_PRIORITY or higher is required";
-        break;
+        return "A cooperative level of DSSCL_PRIORITY or higher is required";
 #endif
 #ifdef DSERR_SENDLOOP
     case DSERR_SENDLOOP:
-        str = "A circular loop of send effects was detected";
-        break;
+        return "A circular loop of send effects was detected";
 #endif
 #ifdef DSERR_UNINITIALIZED
     case DSERR_UNINITIALIZED:
-        str = "The Initialize method has not been called "
-              "or has not been called successfully "
-              "before other methods were called";
-        break;
+        return "The Initialize method has not been called "
+               "or has not been called successfully "
+               "before other methods were called";
 #endif
 #ifdef DSERR_UNSUPPORTED
     case DSERR_UNSUPPORTED:
-        str = "The function called is not supported at this time";
-        break;
+        return "The function called is not supported at this time";
 #endif
     default:
-        AUD_log (AUDIO_CAP, "Reason: Unknown (HRESULT 0x%lx)\n", hr);
-        return;
+        return NULL;
     }
 
-    AUD_log (AUDIO_CAP, "Reason: %s\n", str);
+}
+
+static void dserror_set(Error **errp, HRESULT hr, const char *msg)
+{
+    const char *str = dserror(hr);
+
+    if (str) {
+        error_setg(errp, "%s: %s", msg, str);
+    } else {
+        error_setg(errp, "%s: Unknown (HRESULT: 0x%lx)", msg, hr);
+    }
+}
+
+static void dsound_log_hresult(HRESULT hr)
+{
+    const char *str = dserror(hr);
+
+    if (str) {
+        AUD_log (AUDIO_CAP, "Reason: %s\n", str);
+    } else {
+        AUD_log (AUDIO_CAP, "Reason: Unknown (HRESULT: 0x%lx)\n", hr);
+    }
 }
 
 static void G_GNUC_PRINTF (2, 3) dsound_logerr (
@@ -359,27 +352,6 @@ static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
     dsound_unlock_out (dsb, p1, p2, blen1, blen2);
 }
 
-static int dsound_set_cooperative_level(dsound *s)
-{
-    HRESULT hr;
-    HWND hwnd;
-
-    hwnd = GetDesktopWindow();
-    hr = IDirectSound_SetCooperativeLevel (
-        s->dsound,
-        hwnd,
-        DSSCL_PRIORITY
-        );
-
-    if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not set cooperative level for window %p\n",
-                       hwnd);
-        return -1;
-    }
-
-    return 0;
-}
-
 static void dsound_enable_out(HWVoiceOut *hw, bool enable)
 {
     HRESULT hr;
@@ -621,7 +593,6 @@ static void dsound_audio_fini (void *opaque)
 
 static void *dsound_audio_init(Audiodev *dev, Error **errp)
 {
-    int err;
     HRESULT hr;
     dsound *s = g_new0(dsound, 1);
     AudiodevDsoundOptions *dso;
@@ -637,7 +608,7 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
 
     hr = CoInitialize (NULL);
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not initialize COM\n");
+        dserror_set(errp, hr, "Could not initialize COM");
         dsound_audio_fini(s);
         return NULL;
     }
@@ -650,14 +621,14 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
         (void **) &s->dsound
         );
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not create DirectSound instance\n");
+        dserror_set(errp, hr, "Could not create DirectSound instance");
         dsound_audio_fini(s);
         return NULL;
     }
 
     hr = IDirectSound_Initialize (s->dsound, NULL);
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not initialize DirectSound\n");
+        dserror_set(errp, hr, "Could not initialize DirectSound");
         dsound_audio_fini(s);
         return NULL;
     }
@@ -670,21 +641,26 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
         (void **) &s->dsound_capture
         );
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not create DirectSoundCapture instance\n");
+        dserror_set(errp, hr, "Could not create DirectSoundCapture instance");
         dsound_audio_fini(s);
         return NULL;
     }
 
     hr = IDirectSoundCapture_Initialize (s->dsound_capture, NULL);
     if (FAILED(hr)) {
-        dsound_logerr(hr, "Could not initialize DirectSoundCapture\n");
+        dserror_set(errp, hr, "Could not initialize DirectSoundCapture");
         dsound_audio_fini(s);
         return NULL;
     }
 
-    err = dsound_set_cooperative_level(s);
-    if (err) {
-        dsound_audio_fini (s);
+    hr = IDirectSound_SetCooperativeLevel (
+        s->dsound,
+        GetDesktopWindow(),
+        DSSCL_PRIORITY
+    );
+    if (FAILED(hr)) {
+        dserror_set(errp, hr, "Could not set cooperative level");
+        dsound_audio_fini(s);
         return NULL;
     }
 
-- 
2.51.1


