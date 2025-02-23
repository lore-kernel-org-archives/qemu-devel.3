Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3614C021B6
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 14:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmDNC-0007p6-6i; Sun, 23 Feb 2025 09:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN8-0007op-4G
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:22 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN5-0007dp-Ub
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:21 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e0505275b7so5765757a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 06:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740322458; x=1740927258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARVfbAZthN6G0J8zifHQamYji2miOgYkQ6/AWMTqiyg=;
 b=br6+1qnOBzCVBaDpx7Y765uyYKQusDdKeM7HcdqUclRHN0tcyUvWNnAkor68TpYhFf
 qz2pev25/wBFVugJBG7Be2CWgrhN+bgtCh/IDjaZkKeIHWcqOiWZkffedM8IakYvaRL7
 dgFxyVsra3UvJ31mtbsd3XUu64fKmgj6BJ1bLaAJDybOXdpD7wJj7TWcFMnNJGAc3rcQ
 74fs6jFLPQ0M3LNwx8aHXT7WUnMdjqSjhvJ5lhphC7lUMB2W6vK2c0fvAVfxJ5+OqLV9
 cTEKAiAFsrSuuN+Aloz5+8xa+w2GSnTF0r3HxD8MGkcPpR591++tvpn2z76lo9T9C7qA
 tDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740322458; x=1740927258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARVfbAZthN6G0J8zifHQamYji2miOgYkQ6/AWMTqiyg=;
 b=NJx5svq/rRQznWi7UOjCeVS8dNT06cJTRRbwSebqIN36i3RXdhG92cRX+W2TY9ubcS
 LEmCbkbNnx8PVQpkgMWuRGkly5vWCI/ox/wFhiRucEM5vZpIQyhPMjwsflshoFBsMrYa
 I9PkHDghPvH3BBbmN24p3u/neqY3DZPJoQq0YrkjlCdIdBnxNzqdmnZXSqqsr7TfmckN
 j9/nf+/iGD2uYorRdi7g8kByLCGW6jhiFWG6Z/c6hlCoa8Ri6Q/N6CR32HkH/o7VTRx1
 iJQBiywg3v7wsvLqBSgKPcSUf4vrelJTimH18wM4ahXLJfgl49U+zOU7fmivifYMplDr
 iwrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcPkvoZlCXuEAKNHG+VUghUhV/l6Q4xelo2/53ycQCrqob2CkEI21fFYDUUeCu/vQVrgpKPnpmsQFk@nongnu.org
X-Gm-Message-State: AOJu0YwHmt9Zk+Mq/KLDEiKBqPMwFT+WDI5EH4ZykDzyjyupKWuyDeKr
 Emw5yIHMg/LyJSZRgV4+uaVfpA0KEEPZznGJxwjJXoi54mgk8Oy1
X-Gm-Gg: ASbGncvvNKS3fJtW5JBhcQOkSUzg8nPI/ricUmBlsaD3X41foy9gmKRWALUphzQ6OLn
 al6Zdk2O/ZcYo8gvmmmFyFUvwgKJwES1sDoUccKSJQFCmcPlBZ4YeDk+Gevat7d6YsofRKTwuWZ
 60pM0wL1C58HvgcoTO/PJ+048nbkLdxRwJk+LPvOAChMxb9DLeEp2w70QW5vOxwoWi9B1FxrVtm
 LleY1jjIRul4nirrkS+2R2XFDzTkkVTfsEUYaakPoffzmsNAdiGBFZNfEmcEUNh4KIYntTlqaCz
 7+wdn9OoJ9b9e9QPFFqWukf46egrHo7E8uA=
X-Google-Smtp-Source: AGHT+IG3/1eo4iZ5JvQuxJiYR09fv9TtWpx2o5hxwcEmV4biPf1OO52DN6N4r8Pe3lS3zrA0CuLkZA==
X-Received: by 2002:a05:6402:430c:b0:5da:d76:7b2e with SMTP id
 4fb4d7f45d1cf-5e0b6fec4b4mr9947178a12.0.1740322457749; 
 Sun, 23 Feb 2025 06:54:17 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:1283:abda:b08f:72e4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a0310f66sm6431580a12.81.2025.02.23.06.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 06:54:17 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/5] ui/console-vc: report cursor position in the screen not
 in the scroll buffer
Date: Sun, 23 Feb 2025 15:54:00 +0100
Message-ID: <20250223145407.259924-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223145407.259924-1-r.peniaev@gmail.com>
References: <20250223145407.259924-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x52f.google.com
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

The format of the CSI cursor position report is `ESC[row;columnR`,
where `row` is a row of a cursor in the screen, not in the scrollback
buffer. What's the difference? Let's say the terminal screen has 24
lines, no matter how long the scrollback buffer may be, the last line
is the 24th.

For example the following command can be executed in xterm on the last
screen line:

   $ echo -en '\e[6n'; IFS='[;' read -sdR _ row col; echo $row:$col
   24:1

It shows the cursor position on the current screen and not relative
to the backscroll buffer.

Before this change the row number was always increasing for the QEMU
VC and represents the cursor position relative to the backscroll
buffer.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/console-vc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index d512f57e10a9..87f57f1c52c6 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -827,8 +827,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                 case 6:
                     /* report cursor position */
                     response = g_strdup_printf("\033[%d;%dR",
-                           (s->y_base + s->y) % s->total_height + 1,
-                            s->x + 1);
+                                               s->y + 1, s->x + 1);
                     vc_respond_str(vc, response);
                     break;
                 }
-- 
2.43.0


