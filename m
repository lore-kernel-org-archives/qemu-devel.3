Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33C1C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJIs-0003bp-Qj; Tue, 21 Jan 2025 13:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taJI9-000372-Ex
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:48:14 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taJI2-00055E-UH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:48:01 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so11757882a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737485269; x=1738090069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRxJDDCyC2VtyIxLTC+Qx/NrV0diVYb05sqKwtVOkPg=;
 b=ANXxL3MJFrh8aFK3+pA+FWNNR/dt+XbnwLp0VgcNVI450HM+fJRzNOADIdbyZUzeA7
 2+w6RTeLblFOlbulTrU87Tc50qNfW2EVEBs0jk0qWlrff+VSAYgE7iVvomfLXdRazkXB
 vP1W8tugwM7WK1VWrMUK6O2iRPXSmoFwsm/jtvYx6dRhiTQMFAP6r9yWk0Q7YJrBm88O
 0wyLtJZmQt01wer5oq4BgLbkOZ+6P2avedHfwxtHi69xBhuQqhIlLoUwztGBZSCQIMKr
 dYSRfITyyDzlyz+Y5gejKhdVDH4kr/R+eXNYG4e/dO684gPEdrDpKus9GGDMCO91FZMp
 lsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485269; x=1738090069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRxJDDCyC2VtyIxLTC+Qx/NrV0diVYb05sqKwtVOkPg=;
 b=PTSn/XyQ76NLFAv/nk5akgEiY1GXTMDmD7Q7RrMwvpcYTmJ9xaQiBzZ2m49rNhdi92
 5LWLyb77Qpq78aZd14UaSNsQVmQ9p7oyjm2fvmFVV6MphGifaevj8iqFxSmhAqnA13Lo
 ygkaHbXtJ+m30RGqEGPmA3d8Xr5p8Uglqigj7cKrrlMEIu+sXCURc0uRM/SoGz2eQy5K
 eBOr6HlyKQOJzmAe4A3kWn4MSZWQMAG1Lmaj6t7V7wLGMk3KGwlpPbap2uwMTPmD8UpV
 4uMLQbEAxlFu0wRzP9pzshH9AnmGF7ds+RVciF39hGanwt6LeniiTIDD2m3r9OF7QSPq
 L/hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgfzKOBMiLewszB2gXLCwW5liBU7s/T788iF3MNaIZ3eWSOSLheSIF1rTSg44dzSMZwd4Oy/7wY+7N@nongnu.org
X-Gm-Message-State: AOJu0Yw7v5oTj1JqxHphg+GvgIA5Ke+kh6n7axluNtUSjFZwVfp8Og0b
 57qA4XYxuEhg2qEcCyVpLBN7pHH4+BsC81cUY30FjzwnsE03liD7
X-Gm-Gg: ASbGncu5zoJTdPSlY3GOJeot/xZsaLkQBFRd2eRC/CZanW38m4ruC9LzJd7vKd2rcCk
 cFoJWqRPMomDhsW7POPMqvPfEBSYSI0s0KIRWT0AnN8yk+dJ93Wfz+5CbAsXWAe8DuddF4giX8z
 6B0q2cng2q+EdT8ZshccNfOVGFEZvUW+ubvnRqQJZhvHV5oFXvIp52jVyzCguz/9Hqdx89P/Bym
 2opV4CeVdIvp81SkIyX2bzQqdANEdNTS+dkto/RlYYmkx/4j53eirg7hVhm9pcR2XYBwzr6nOM=
X-Google-Smtp-Source: AGHT+IH/+eRExY4oPB58EeZJeweKu1xT2TY7Z2vS1oBoUUtK1T4L1bZljgXjFGchPSI3ttHfQ73aFQ==
X-Received: by 2002:a17:906:c143:b0:aab:9842:71f9 with SMTP id
 a640c23a62f3a-ab38b10ffbfmr1516619466b.22.1737485268782; 
 Tue, 21 Jan 2025 10:47:48 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:381c:a1:b53:524d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223e7sm785745166b.111.2025.01.21.10.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:47:48 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v8 1/4] chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
Date: Tue, 21 Jan 2025 19:47:41 +0100
Message-ID: <20250121184746.920841-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121184746.920841-1-r.peniaev@gmail.com>
References: <20250121184746.920841-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Change makes code symmetric to the code, which handles
the "connected" state, i.e. send CHR_EVENT_CLOSED when
state changes from "connected" to "disconnected".

This behavior is similar to char-socket, for example.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Alex Bennée" <alex.bennee@linaro.org>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-pty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cbb21b76ae8d..6a2c1dc13a3f 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -181,6 +181,9 @@ static void pty_chr_state(Chardev *chr, int connected)
 
     if (!connected) {
         remove_fd_in_watch(chr);
+        if (s->connected) {
+            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        }
         s->connected = 0;
         /* (re-)connect poll interval for idle guests: once per second.
          * We check more frequently in case the guests sends data to
@@ -215,7 +218,6 @@ static void char_pty_finalize(Object *obj)
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
 #if defined HAVE_PTY_H
-- 
2.43.0


