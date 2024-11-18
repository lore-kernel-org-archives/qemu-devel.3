Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13878D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1BX-00065g-ME; Mon, 18 Nov 2024 07:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1Ac-0004Ei-J6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AZ-0005RM-Rg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:57 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso18088605e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934074; x=1732538874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZY2UZXl5ISTHGaCx/dhRxaaExiBOZqSteLaMzypVhw=;
 b=DIFQkBvb/zfEc8LqPrxIsMwrQ9ML3uAgym/lKlLqr9/X+2LUC+48CYera6qe3nUlxv
 CHlnzKnYEol93M3/qmh+83fBKD5pFSDLGWniYwxuGWZVpkZ69leQ2plIUbzlHn0F53kP
 HKoiFpZsqLVbZ1U0YUDvNYFJnZHQYnIFZhcWNWAxhoUifxvmttlCmOTTgdLdoGAatTvA
 eJSvwQ4newl2v/icdnr7KTy1cPxiSyasTUid8snan0Kct6sNA67Xs4FigK4SPDac6Z9D
 kc5X3hJkBUkyCzjfA7of/LIiG/xjw+Gj6ViotMFm1xdHRuBl5LSzt0Ao3LiC6NbaqzOl
 rRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934074; x=1732538874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZY2UZXl5ISTHGaCx/dhRxaaExiBOZqSteLaMzypVhw=;
 b=Kj6O1PVqJs9bmNgYrqYx97ewK/Ov3CS96I0aijQgdPddFEzGL2gK6+sUU03B+br29A
 o6kggVA01M4DpgY/DaROFyIm4rhVDevWX1ixFCXmz3LUlEXs4aBesH4ChrubDGqsJH6b
 jNmk5kcqMqOeOHBSQFHdVwJJfAP/UFyjJ3Xk/d5lrKXBaN9E0Nmy0NUTSQJkkpAkIqhv
 21IaixSIfOgob7WPZuL7y5CJ04cJiMoMItjsW1q1ifbpJaidd1xkxXIIrpB6H2xflE1F
 o6ZJ8NhLs8cpLh10pu9GcJzr/hXubd1wkL8KJWBDOQyDwxQaWSufr+eVa/tgsQxDJlFu
 hD2Q==
X-Gm-Message-State: AOJu0YwiQiOoNp6v1V2dxY3wXN/32WaMMbTkCyEH6tSM6bf64rFJ9zOo
 5ZDlt1ZQERwCvLPMpMv2Ep19bzmWgbWHSFBnBM7hH95BU0QjBg9eViso1gqB5mGO8PVDtr3sqXL
 J
X-Google-Smtp-Source: AGHT+IFWseHO7AxXi8DCnPAmK/DSPyYuGVEk+4RungkkyCu1GUZjKkq1wwr2n3Hq66WurevDi7G4Eg==
X-Received: by 2002:a05:600c:3143:b0:431:9397:9ace with SMTP id
 5b1f17b1804b1-432df7411b0mr120048115e9.10.1731934074124; 
 Mon, 18 Nov 2024 04:47:54 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28cad9sm158081935e9.32.2024.11.18.04.47.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/15] hw/audio/hda: fix memory leak on audio setup
Date: Mon, 18 Nov 2024 13:46:39 +0100
Message-ID: <20241118124643.6958-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

When SET_STREAM_FORMAT is called, the st->buft timer is overwritten, thus
causing a memory leak.  This was originally fixed in commit 816139ae6a5
("hw/audio/hda: fix memory leak on audio setup", 2024-11-14) but that
caused the audio to break in SPICE.

Fortunately, a simpler fix is possible.  The timer only needs to be
reset, because the callback is always the same (st->output is set at
realize time in hda_audio_init); call to timer_new_ns overkill.  Replace
it with timer_del and only initialize the timer once; for simplicity,
do it even if use_timer is false.

An even simpler fix would be to free the old time in hda_audio_setup().
However, it seems better to place the initialization of the timer close
to that of st->ouput.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20241114125318.1707590-3-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/hda-codec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 74c0292284..c340a9481d 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -487,8 +487,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
-            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    hda_audio_output_timer, st);
+            timer_del(st->buft);
         } else {
             cb = hda_audio_compat_output_cb;
         }
@@ -497,8 +496,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     } else {
         if (use_timer) {
             cb = hda_audio_input_cb;
-            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    hda_audio_input_timer, st);
+            timer_del(st->buft);
         } else {
             cb = hda_audio_compat_input_cb;
         }
@@ -726,8 +724,12 @@ static void hda_audio_init(HDACodecDevice *hda,
                 st->gain_right = QEMU_HDA_AMP_STEPS;
                 st->compat_bpos = sizeof(st->compat_buf);
                 st->output = true;
+                st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        hda_audio_output_timer, st);
             } else {
                 st->output = false;
+                st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        hda_audio_input_timer, st);
             }
             st->format = AC_FMT_TYPE_PCM | AC_FMT_BITS_16 |
                 (1 << AC_FMT_CHAN_SHIFT);
@@ -750,9 +752,7 @@ static void hda_audio_exit(HDACodecDevice *hda)
         if (st->node == NULL) {
             continue;
         }
-        if (a->use_timer) {
-            timer_free(st->buft);
-        }
+        timer_free(st->buft);
         if (st->output) {
             AUD_close_out(&a->card, st->voice.out);
         } else {
-- 
2.45.2


