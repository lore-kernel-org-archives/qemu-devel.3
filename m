Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0212D4921B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1BO-0005KU-UK; Mon, 18 Nov 2024 07:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AW-0004Aj-MM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:02 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AU-0005R3-Fr
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-382456c6597so631276f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934068; x=1732538868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaiZ7J4o0vhrl+WvkyGBPRzIVJzJiK8smMQqcbPQEFk=;
 b=pQ+/tJorJBOJQTGgvlAptHbcfivKLHWdsfa5HOcwJZ+jkrQAe2iZ/tR52yVT0X2yYH
 uSTKREnLtRFLLeQrzsDR68Nb5DQupuHreSdOaJVWsOMkRhAsKiKGxjNu97yUF2SAAfeu
 RHVcd9+CtI+jK/huCZ9vMgc2kUu5ZxAQeSybB22INUvi69XsAqTBvAVvnkq4tVpGC5Yu
 M/keS9WfW16GJg7f/DL4i8yXrq/OZivdx9RGHTIznftrcsY47GUZGmmKgOXP6S/iQwVd
 Jt6fLNd6Ge+x76W/qOUMu1JRKp4IQdoO49jDxMri1M73wsSpY1WRSXAQrT+RsnMRyGZH
 2A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934068; x=1732538868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaiZ7J4o0vhrl+WvkyGBPRzIVJzJiK8smMQqcbPQEFk=;
 b=iFW/o6YBJfJTHd7okRYuW/7NMHWFCwYWsPwMD8TxpkZi+MK6jQeJgq7uLK98v1GZrY
 44UarBUIS4UMI3C58JKuZJU6w5sfmbvcE44dT5Ei00ywL79ON/gBdRLOOeRPEvk5E7iD
 5xVDoY0dys/Js9kP2Ff17zRafFGJ9ygtq+y3ji8rDI8dH9K+1bQWay9Le4hbUpYSIDIu
 gGS6UC8xWpzY4bUa/MvHwkAyPUMjFe8CF7k29vH6D76G1KBNhJ9NrSkHZ0auMivZlPvf
 JTA7BpGV3EWstd5OA6iSDwK3TGZw/YDUSqydXFCg+SXXqPpCR/gbvZt7bthSzUYX1C4/
 TI0A==
X-Gm-Message-State: AOJu0YzimiY4m404pWEgIJa1Qnus2btSzg/nsGMXvC5GQVz6Ot2L7+Qc
 L44nG6AaNVPSGHaSmT+yCdfLlO6WVZ5apggK7leOyrbbFPtVuGHGZHtswQxdvo6vkDc9Y7DqZKV
 6
X-Google-Smtp-Source: AGHT+IHwuhTtJ9EdE+hX3AFGvPR/H9Fi2JWawS4tV29H2dLJ4uE2j9nNXvRWsBtvFBFFTPwE0DskCQ==
X-Received: by 2002:a05:6000:1544:b0:37d:393a:97c5 with SMTP id
 ffacd0b85a97d-38225a059a1mr9511199f8f.28.1731934068350; 
 Mon, 18 Nov 2024 04:47:48 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38248b74ec6sm2579263f8f.38.2024.11.18.04.47.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/15] Revert "hw/audio/hda: fix memory leak on audio setup"
Date: Mon, 18 Nov 2024 13:46:38 +0100
Message-ID: <20241118124643.6958-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

This reverts commit 6d03242a7e47815ed56687ecd13f683d8da3f2fe,
which causes SPICE audio to break.  While arguably this is a SPICE bug,
it is possible to fix the leak in a less heavy-handed way.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2639
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20241114125318.1707590-2-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/hda-codec.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index bc661504cf..74c0292284 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -472,24 +472,6 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     }
 }
 
-static void hda_close_stream(HDAAudioState *a, HDAAudioStream *st)
-{
-    if (st->node == NULL) {
-        return;
-    }
-    if (a->use_timer) {
-        timer_free(st->buft);
-        st->buft = NULL;
-    }
-    if (st->output) {
-        AUD_close_out(&a->card, st->voice.out);
-        st->voice.out = NULL;
-    } else {
-        AUD_close_in(&a->card, st->voice.in);
-        st->voice.in = NULL;
-    }
-}
-
 static void hda_audio_setup(HDAAudioStream *st)
 {
     bool use_timer = st->state->use_timer;
@@ -502,7 +484,6 @@ static void hda_audio_setup(HDAAudioStream *st)
     trace_hda_audio_format(st->node->name, st->as.nchannels,
                            fmt2name[st->as.fmt], st->as.freq);
 
-    hda_close_stream(st->state, st);
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
@@ -760,11 +741,23 @@ static void hda_audio_init(HDACodecDevice *hda,
 static void hda_audio_exit(HDACodecDevice *hda)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
+    HDAAudioStream *st;
     int i;
 
     dprint(a, 1, "%s\n", __func__);
     for (i = 0; i < ARRAY_SIZE(a->st); i++) {
-        hda_close_stream(a, a->st + i);
+        st = a->st + i;
+        if (st->node == NULL) {
+            continue;
+        }
+        if (a->use_timer) {
+            timer_free(st->buft);
+        }
+        if (st->output) {
+            AUD_close_out(&a->card, st->voice.out);
+        } else {
+            AUD_close_in(&a->card, st->voice.in);
+        }
     }
     AUD_remove_card(&a->card);
 }
-- 
2.45.2


