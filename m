Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAA2CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAnx-0007mR-Mm; Thu, 18 Jun 2026 07:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1waAnw-0007lv-OL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:21:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1waAnv-000100-2k
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:21:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921e4dd62dso6645045e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781781661; x=1782386461; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZoNIBLpa4H4HVf3Cf2OZcXdi5J8raXPzj1RjxLRdoA=;
 b=Sk+aXpU7wgCCs2iRAP+Ub9t204SKL8zFqBpJdsEe1W3hHwHMjY7CIrHxzQSC7dzInX
 WwJg7XnNSNTktlFtUxXakLFYY0hFWVyG/+0zZXYNIUhP4oOwxm3T9axO8XRJZ4KTi6QG
 /zWPlazxUZhczAm/lYc5/iLle8W2gLbGuG6t16fiBL8vnO30uSACIix+zTxaM4xB7Lu+
 6Iqq/Dzsf6hTduoD9dDYIPcdXCW2fYlH3klhsRqPJRapWvp29CMcyxfaq/gGvCE9vyXB
 e4g7RQEsGSxBg343Ufzq2I+Ff1KgfAAawogR0eYemJ5v2NJSSlyBTDFYSZEfvaiZGlqx
 F03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781781661; x=1782386461;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZoNIBLpa4H4HVf3Cf2OZcXdi5J8raXPzj1RjxLRdoA=;
 b=O6k0fzOZllzT+rM/sC4YWepG9jgYwfoa7ZyebDJn96aZply4SvAjHm+DPRjC4lPogP
 bcvPMfnc1ERoMbTuYn4PweyjIloKvJ9UOI6rxYXX+qzQmwP5k+2NuF88EHjFsQN9082G
 7Kh+3BfdcDmRSB7hwV2OT81t0GW2yp3qin9fAcs89KCAY77zS01QxvRlWLEXKs3BgI+K
 i6nBOaX43lr2sgZ7Q/Le1mf7yLQAhSlYlNLIqfaGw1bmjiaC8X9TV6rNccm9UKIjWnlI
 K07P4teDT8akx8F1QKKJtI59bzC9ZUAl8d0MzOmLGeyUuhRKdqlYNxvv7nVPNsnRBwF+
 gzNA==
X-Gm-Message-State: AOJu0YzaWDxdDRwetvuvVwfAqTOkiRo4h1bIRsT380pI9OTa1a0kIle6
 8IlXO457nArzW0/xEMYliqAPL8I+OdPE7J3sh0bG9WJ/5KKketifH6+d
X-Gm-Gg: AfdE7clxEwuXZjvVhzKu+DChD2yRLlQj9lr1yQfzQTv/3/Sx2FzL5zgsZIoSUEKCidP
 8FWdW0r90Hv7vxB98YU1jenKzlAx9BPTns9V9WLimou8M8MpbWDgFNlXfqeXZzldZENaHS47JbQ
 96ZqgVYQk5pClAT67eTfQdx08liQGUnYfxPHII+TsM/VngxVJbLU4ggJk1GmWFJ3oFKz2q9rdI4
 GSYzmRJKxLsdbl1tFir6yhfD3gNMFvmpPywSqirvAbQYkxtnMKNDTMWmpktSBY9IC1pdOKZauG/
 C1VpdBwENKDLwtxBCGpDuScebV63aFIIEnLJNlVeVnAaiJuGIPUPsrwo9UJX2ZG1Zv+dI3Mb8oy
 vCOqsqbkkqyh7axtzhpuDSHsklRbouTeTT6RcozsX9J+pTGZpx3Q5sU/nA3N0xZrEOfKRqpjQK+
 9vYuUn1jRnjqoRrd/JKllBRMUoMXk+OySF9Wm/gQ==
X-Received: by 2002:a05:600c:4593:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-4923817fef2mr43674495e9.11.1781781660829; 
 Thu, 18 Jun 2026 04:21:00 -0700 (PDT)
Received: from localhost (89-24-32-97.nat.epc.tmcz.cz. [89.24.32.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d9d87sm30380855e9.2.2026.06.18.04.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:20:59 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Thu, 18 Jun 2026 13:20:18 +0200
Subject: [PATCH TRIVIAL] char-win-stdio: fix typo in spelling of 'stdio'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-char-win-stdio-typo-v1-1-05086b1b326b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0MLXaBokW55Zp5ucUlKZr5uSWVBvq5pYlKSoaV5SqpJqpESUGdBUWp
 aZgXY1GilkCDPME9HH6VYiERxaVJWanIJyEyl2loAcGNHtIAAAAA=
X-Change-ID: 20260618-char-win-stdio-typo-5abb197de4e2
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781781657; l=1445;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=B6InDpCOU3A0aCAEVqyNbL45ugtsncYezEz8HpVlh0M=;
 b=tvLVxWGAEl4Il2ukVnENwvavQWktZ04oDjoiLLHlvnqFx4DgYek71Pp5FGMqfm8upJwLvnohA
 GH1PZTNygTsCCvUU1vimvtwVEre1AO7e+sXf00Y/yjT5M6OKNkYG1qg
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-win-stdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index bb9c195a8b..0deba3bffb 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -128,7 +128,7 @@ static void win_stdio_thread_wait_func(void *opaque)
     SetEvent(stdio->hInputDoneEvent);
 }
 
-static void win_stiod_chr_set_echo(Chardev *chr, bool echo)
+static void win_stdio_chr_set_echo(Chardev *chr, bool echo)
 {
     WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
     DWORD              dwMode = 0;
@@ -205,7 +205,7 @@ static bool win_stdio_chr_open(Chardev *chr,
 
     SetConsoleMode(stdio->hStdIn, dwMode);
 
-    win_stiod_chr_set_echo(chr, false);
+    win_stdio_chr_set_echo(chr, false);
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return true;
@@ -263,7 +263,7 @@ static void char_win_stdio_class_init(ObjectClass *oc, const void *data)
 
     cc->chr_open = win_stdio_chr_open;
     cc->chr_write = win_stdio_chr_write;
-    cc->chr_set_echo = win_stiod_chr_set_echo;
+    cc->chr_set_echo = win_stdio_chr_set_echo;
 }
 
 static const TypeInfo char_win_stdio_type_info = {

---
base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
change-id: 20260618-char-win-stdio-typo-5abb197de4e2

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


