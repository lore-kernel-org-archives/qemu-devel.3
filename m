Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682C8D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzc-0007OF-83; Mon, 02 Mar 2026 03:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyx3-0003If-SP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyx1-0002Eh-RN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzxHzHOzm9YjyekujVzBigOBvtSdmMNTQfMMLR0iTvo=;
 b=NttXSYwrXoQnMjkesHFOlH3SNJsHXHfWfFHVq3j/kUVd7yrKageBk+awrs4KHBTb6gJpYv
 uMiErlnUfRDqHCiCggWH0iOWZqsR/Ra/4Unm7htycoJgfe02VpKHzfLI7JqnzNGWx2wEnC
 7Kur0Ac1UeUmb+O/EgGLCFh0+pbWXVE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-a1wll9EcO7aRwngbsN6i0Q-1; Mon, 02 Mar 2026 03:48:26 -0500
X-MC-Unique: a1wll9EcO7aRwngbsN6i0Q-1
X-Mimecast-MFC-AGG-ID: a1wll9EcO7aRwngbsN6i0Q_1772441305
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439bab2d095so234660f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441303; x=1773046103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzxHzHOzm9YjyekujVzBigOBvtSdmMNTQfMMLR0iTvo=;
 b=hmbm6vzgR3YHx6HS9MO+nt1a3erNx7YNAA8JDuiPin051HO3JFlvjm+jqf7zBIWEq7
 XZBRpwlD/BMcJFZ3j/2j5oiu8sxB+tU8xh65PtO+as5mpBAlB4xDhjjJPNGqDNc1nwwT
 jlpS6JhIh4JtV59zvgqYKXkqm0gdRmlXa5oLvr3RtfHjXnIQ2YiQSHqhPIwVZNXOq10+
 B5j087Lq3FxkImCKTJBXuFhmhJhv6Eg+zhiJHF9bFifbHAZVPBJm9ILYCprQFvjovuhf
 LMJO/uMcIFGvs/w6yAS2+LJ3BYzHNHzL0SfyytJtv6KieZJ9/9UP8Q7haIVj7wQXVvs3
 P88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441303; x=1773046103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzxHzHOzm9YjyekujVzBigOBvtSdmMNTQfMMLR0iTvo=;
 b=wrNZ5kJf7eYxAmtNcU3Vs2HlyBezOnpwExYF8gqWwrJWoTfgrK68sGLuZZ2oAIcMm7
 kF/IPDwlfjOZrnZzt97OLgc9Bw7stcaitPQEY3bys/HndgzQuEclw5HsfoRbhRanB0fD
 Z3AMms3FLjKMgAmW1svHz32ydYpjbs75q/o3rEvhaY9XRzkT64ixv7dXQsJO9dm0AgrM
 ieBPdskDaq/A6jDEeUofLY//xHa+ihJLxIFC3jMRyaiiDEVu6RUL/YRhQQ/TRLPVKaEG
 JJYHgbNrwFSlgtikc9SuTzHA+3d+kxTp4GitSKsmx709fPJU0UyFLS5JgzG08Bqp+BlY
 gWcw==
X-Gm-Message-State: AOJu0YxEJBzlD6c2uVcIS11IV9LfY+2m4UcN40KQL+GXDHK6O+izMiRL
 eL1gxaZcZNS4gCgcZcaArrkdyS904k4jNuGU8F9mh8jl1MX2lbtqc/aD9l04K4lrBdLtmtxLc5s
 3Qs+I//9KuJhckI9ab7Vbc4HKXtjhBM7lNg8fhEsIawey30dy7w2UsSBlBf0A/iEsy4Mii+AZce
 Vb8J3XVyW5rQqMkER6a/1Nwj+f7KbqEvvP3S9hWCnI
X-Gm-Gg: ATEYQzwGHrXVtHOAqhJ4QDnt/1ZtNRFuZG/Eq2OSz9RONHfGnDQXkBoq47o06sExAXm
 ClY5cp7fHxogsM99U3Y2hjFz5V6vd5Y2HQcdgcaQuKsM8hHceS51N3dO55IBdyXz8nH/+nPyBxL
 3GpynFx8F/XrGExS62nxeEz5c07LvE8Aw7qJc3hbr601KrKBqRwV+OyooPh3rB8TeizwSsCmFjM
 MtICNORXBMggHyBSxejBhLBX+IvbGVFKF+TnnuSjNmouS1C66rzP9Zc1DE1wZybTjdU/C8PsrtP
 6m9dZ3ipBWRf1UBepP+4byzpzYLSIET0Kp3cSdCrpstpGiqxceEpHUJ2fgy0jRyjRO1mZzweJeN
 D1egGxe4C7E1iioH6MisG6d/vDzj3eWJi9bPAxF57M+o7dcaVQ5aOsNI98wfLhBQE9TMt4d5KzJ
 phGNpf98/nJui4Su4jrYAO5HR51f4=
X-Received: by 2002:a05:6000:2401:b0:439:9566:f6d4 with SMTP id
 ffacd0b85a97d-4399de3a913mr19988352f8f.53.1772441303340; 
 Mon, 02 Mar 2026 00:48:23 -0800 (PST)
X-Received: by 2002:a05:6000:2401:b0:439:9566:f6d4 with SMTP id
 ffacd0b85a97d-4399de3a913mr19988302f8f.53.1772441302839; 
 Mon, 02 Mar 2026 00:48:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm11276137f8f.35.2026.03.02.00.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 080/102] audio: require spice >= 0.15
Date: Mon,  2 Mar 2026 09:47:26 +0100
Message-ID: <20260302084749.474955-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Spice server 0.15.0 was released on 2021-04-16. It is part of all our
supported distro (except CentOS 9, which doesn't include it).

It has all the new required audio APIs/interfaces.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260211-cleanups-v1-5-e63c96572389@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/spiceaudio.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 70a0b60dd83..5a97eb80a67 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -49,17 +49,8 @@ static bool spice_audio_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
     return audio_spice_parent_class->realize(abe, dev, errp);
 }
 
-#if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
 #define LINE_OUT_SAMPLES (480 * 4)
-#else
-#define LINE_OUT_SAMPLES (256 * 4)
-#endif
-
-#if SPICE_INTERFACE_RECORD_MAJOR > 2 || SPICE_INTERFACE_RECORD_MINOR >= 3
 #define LINE_IN_SAMPLES (480 * 4)
-#else
-#define LINE_IN_SAMPLES (256 * 4)
-#endif
 
 typedef struct SpiceVoiceOut {
     HWVoiceOut            hw;
@@ -99,11 +90,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as)
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
     struct audsettings settings;
 
-#if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
     settings.freq       = spice_server_get_best_playback_rate(NULL);
-#else
-    settings.freq       = SPICE_INTERFACE_PLAYBACK_FREQ;
-#endif
     settings.nchannels  = SPICE_INTERFACE_PLAYBACK_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
     settings.big_endian = HOST_BIG_ENDIAN;
@@ -114,9 +101,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as)
 
     out->sin.base.sif = &playback_sif.base;
     qemu_spice.add_interface(&out->sin.base);
-#if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
     spice_server_set_playback_rate(&out->sin, settings.freq);
-#endif
     return 0;
 }
 
@@ -194,7 +179,6 @@ static void line_out_enable(HWVoiceOut *hw, bool enable)
     }
 }
 
-#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
 static void line_out_volume(HWVoiceOut *hw, Volume *vol)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
@@ -206,7 +190,6 @@ static void line_out_volume(HWVoiceOut *hw, Volume *vol)
     spice_server_playback_set_volume(&out->sin, 2, svol);
     spice_server_playback_set_mute(&out->sin, vol->mute);
 }
-#endif
 
 /* record */
 
@@ -215,11 +198,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as)
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
     struct audsettings settings;
 
-#if SPICE_INTERFACE_RECORD_MAJOR > 2 || SPICE_INTERFACE_RECORD_MINOR >= 3
     settings.freq       = spice_server_get_best_record_rate(NULL);
-#else
-    settings.freq       = SPICE_INTERFACE_RECORD_FREQ;
-#endif
     settings.nchannels  = SPICE_INTERFACE_RECORD_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
     settings.big_endian = HOST_BIG_ENDIAN;
@@ -230,9 +209,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as)
 
     in->sin.base.sif = &record_sif.base;
     qemu_spice.add_interface(&in->sin.base);
-#if SPICE_INTERFACE_RECORD_MAJOR > 2 || SPICE_INTERFACE_RECORD_MINOR >= 3
     spice_server_set_record_rate(&in->sin, settings.freq);
-#endif
     return 0;
 }
 
@@ -281,7 +258,6 @@ static void line_in_enable(HWVoiceIn *hw, bool enable)
     }
 }
 
-#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
 static void line_in_volume(HWVoiceIn *hw, Volume *vol)
 {
     SpiceVoiceIn *in = container_of(hw, SpiceVoiceIn, hw);
@@ -293,7 +269,6 @@ static void line_in_volume(HWVoiceIn *hw, Volume *vol)
     spice_server_record_set_volume(&in->sin, 2, svol);
     spice_server_record_set_mute(&in->sin, vol->mute);
 }
-#endif
 
 static void audio_spice_class_init(ObjectClass *klass, const void *data)
 {
@@ -315,19 +290,14 @@ static void audio_spice_class_init(ObjectClass *klass, const void *data)
     k->get_buffer_out = line_out_get_buffer;
     k->put_buffer_out = line_out_put_buffer;
     k->enable_out = line_out_enable;
-#if (SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && \
-        (SPICE_INTERFACE_PLAYBACK_MINOR >= 2)
     k->volume_out = line_out_volume;
-#endif
 
     k->init_in = line_in_init;
     k->fini_in = line_in_fini;
     k->read = line_in_read;
     k->run_buffer_in = audio_generic_run_buffer_in;
     k->enable_in = line_in_enable;
-#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
     k->volume_in = line_in_volume;
-#endif
 }
 
 static const TypeInfo audio_types[] = {
-- 
2.53.0


