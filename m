Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62503CDE006
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9Q-0001rb-4U; Thu, 25 Jun 2026 04:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9K-0001hZ-JR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9J-0007yD-3s
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46daae24c79so333343f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374964; x=1782979764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Un3eHQApgu4sIeZqrs0kysA5i496iAug3k/3dQTUAwQ=;
 b=g4oV4pc2j6wvhPJZn0Hs/9ojYws0JCtU4JCWmXyTyUPQIIz6OLD9l1mvC7hlGzO8Uh
 Nm6uLlVIUxaaBsrqm1JV/kN7ZOBt/60KLArBYMitmUTn8dDOL7JCT+c77rVaoOTxnqlk
 Xbu1w7zpJ8YFS4byHuUZxTLberzAnja623yk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374964; x=1782979764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Un3eHQApgu4sIeZqrs0kysA5i496iAug3k/3dQTUAwQ=;
 b=F+eyZZw/JRVCtS7V2raeTgCKlMkm/3243Ia4s3BzNUNYnYtfMi4swa0td6KE4cmEf5
 L0DEJfBT00KQaufoBWa/vNhBknoapi6Q7sjWsISKj7QcYT/xQoc30U8RU4k+4DRmWKGI
 eVsrMyMYtDpV3iVXc5G4CzWvqQppc3FI3JSKgSyyo0JX2cXZRb5o0DKfPa+RcnLatkte
 KGmiSi10uvc4dYBeGqLfybiCW70sAsHH2y14+SPZ4tNJOoKKgko+qBTcRroSE6n50les
 YW6duCECb57Vnbo0GbMo8q8xMjd0ujdJq10sa7nMYa5M9PaHHIC2sM2TfXHfyUzZS+Nx
 Z5OQ==
X-Gm-Message-State: AOJu0YwdcYI+Wnts36TjW/yUNTrfi8LEMwX4UJ4AqLOeNSKyTLpbTylk
 CcD95fLlUXsJi7EOr5mTGRTfvPRfC5ulVusFmZdCiOD+stgXEesXpM0yQyKVHICuOS5SzHDhcWy
 /3HaK5DaMIA==
X-Gm-Gg: AfdE7cnyC621lZ+oQwotLI3kprCjQ/dlmsqCF8p1SeogXAKtYhymIfoUZ04NUdKJOlE
 FwHcErXwWVPvypr7b+EQ44gT5CLRvbjkDsCVNdt8CNfzIluWZlyPvjpUOp9U8uNA7uFLX7dJhUI
 p8qD/jqOHs1ZGAtYMwmF/haO35ATijU/5WepS8ogdg2hX4kcaonF5kXJ5hJ4b/XIm3HotEhmMnO
 DCxZ3mRHJWmebpUvTQKstzbAbblTuOj6cGViAetYwYrmdZYIJ+Wapiihh5R0x6/ajFcK91JbPZ/
 GXw8A54DbzYxSCXfTWDI45H7dQBnmgiQE8XPBzIr9usLVJd7z8nU5CUn3C+hbuLr/fZilxO4Pmk
 pZwZWMD1izP0519hPKPBrGLY5I4HHQQflryalcR4a04HAdu28IVTOL4NCXyZGcirH5SPyPrzJji
 +84cj2IO4E90fC87eZNUqoDXiR5Qe/mQrSKvrtYlZZuwapGyl8r+THcBO18T4C6aa1bdynEu4gL
 XQXuSFnMggL
X-Received: by 2002:a05:6000:2884:b0:46c:cffc:7638 with SMTP id
 ffacd0b85a97d-46dc17af258mr2008273f8f.30.1782374963698; 
 Thu, 25 Jun 2026 01:09:23 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:22 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 9/9] hw/audio/virtio-sound: add placeholder for buffer write
 position
Date: Thu, 25 Jun 2026 10:09:10 +0200
Message-ID: <20260625080910.30569-10-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x431.google.com
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

From: Volker Rümelin <vr_qemu@t-online.de>

When a running audio stream is migrated, on average half of a
recording stream buffer is lost or half of a playback stream
buffer is played twice. Add a placeholder for the write position
of the current stream buffer to the migrated data. Additional
program code is required to resolve the above issues. However,
the placeholder makes it possible to add code in a backwards and
forwards compatible way.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c         | 2 ++
 include/hw/audio/virtio-snd.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index b3de8abcb61..cdd384cf4a0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -81,6 +81,7 @@ static const VMStateDescription vmstate_virtio_snd_stream = {
     .name = "virtio-sound-stream",
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(buf_wpos, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
         VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
@@ -1431,6 +1432,7 @@ static int virtio_snd_post_load(VirtIODevice *vdev)
                 virtio_snd_pcm_set_active(stream, true);
             }
         }
+        stream->buf_wpos = 0;
     }
 
     for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 523c456436b..4c688016c25 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -124,6 +124,8 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     uint32_t state;
+    /* placeholder: write position in current VirtIOSoundPCMBuffer */
+    uint32_t buf_wpos;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
-- 
2.47.3


