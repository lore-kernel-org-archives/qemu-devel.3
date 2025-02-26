Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9931C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCKG-0007Qu-0K; Wed, 26 Feb 2025 02:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKD-0007Ma-DD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:25 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKB-0007gn-63
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:25 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab771575040so106658066b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740556761; x=1741161561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARVfbAZthN6G0J8zifHQamYji2miOgYkQ6/AWMTqiyg=;
 b=g5OJbl6sTwlNMA3UCSgSkZcD6fLBqn2Q654CKc6NrlxaJIOScQn+RdLxY66Qp8f061
 Ca3g4ZpnJzJD6zDwyKkdSC1pr4vQiWo9zC2qd4eQjtHq8LjiKyqszzT2SVy/YOFI6CTP
 ZS6oH0odED+aNvU9dSKV3N9Icex+6Lz81Kf4mqkAqcfH7LCeRiWz4KqqtrgpuWOxCSQQ
 YypQ7y5Yd+05+qvqOxrbY642CmoHdrpmISn54LG1QsjIoNUWmuIvTKbc4DEUszX2PCTP
 7NZNZ8US/l8nqsf6UgRQsWynkER2X7mJ/aUkJfCgzPcdvrZSxFP3zepQ9kiyD6o7JYjQ
 rCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556761; x=1741161561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARVfbAZthN6G0J8zifHQamYji2miOgYkQ6/AWMTqiyg=;
 b=INS19YqqpISL9SmOJ3xubBvZJw0NcWlQhjq5urQhzXXjGWzSgxBRyxXLtN1mB2MEMU
 vx/SCdh5L+a40vBozHLbqZNeJAs3PKKcV8RBLD4yrcrI7IEzucMxPbZvJbm4ufIZDfJN
 mdAOcDS6PsRcTUQYiNzJWFiEvG248l+KwvYOPm/8mwUsShqc2kTozSkeFvOfQVAB49nf
 uIPN4+UEtY1JuobbFPdKiuv25mC5GqI6yzlKdrQRQ+abENuvQNds5O7adUTzsg9CqVBQ
 T5yMpZt64waNsHHCwxPPBJwCQuSIUpCvdjfGiZk72qHZilrCgaRtYYCZkq7n0DJdX6LY
 4kDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBVpPGyk5et1aNola15WJlvy+dlaUcr3TRdRRDeVnai5kxlqPK85DsNNG8B5XZu4J0GfyBswftdNly@nongnu.org
X-Gm-Message-State: AOJu0YylKtxc5XGgtv1r6H7oi728a9ABZ/XwnC6RB7chsY6WP4QO8DBr
 xfua3RMCM7JTMGZ9xDBkFh9s9On+7ByjlF2tKffnTVYmp3gwOYGRLUI2DQ==
X-Gm-Gg: ASbGncsmr4bGlapAcRzi3j6bSSzok7yxxcTaFus31jQY0BF09JmKkMH6x7/a4iah6Mb
 N7TZEGPvGa9GoWL1CXUzZxERlxeigP/mTTwk/xRSZQIGc4AkH8W8GsV43k6qSPpveDq6DQ5Kf4F
 /i8Yw2wGVFqMgd2C3fpFqnDEk82f7biMyDyeMpUetIu2IGW0OsRplOHzhz7DDUIHl89VJujQo7p
 eZRsPFV8+UmdV48C1Mn6HTPyawZzH8PQAVUOjnld9AW1SbnVqY8TYJ7xPQYcgvSPKYL0tIgzKzZ
 85FH34GfittbODjCSFur/HsG/y7Qx0stmNA=
X-Google-Smtp-Source: AGHT+IESuCS42A3aoL1h0RL0yFzUUnaSn2hH5S60F0GoJxuHORZJbS8s+nSzlpaAuDcnjY7pDnLryg==
X-Received: by 2002:a17:906:3151:b0:ab6:504a:4c03 with SMTP id
 a640c23a62f3a-abc0b037859mr1551857866b.24.1740556761223; 
 Tue, 25 Feb 2025 23:59:21 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:c48e:2efa:cdfc:e268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2013355sm280107866b.113.2025.02.25.23.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 23:59:20 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] ui/console-vc: report cursor position in the screen
 not in the scroll buffer
Date: Wed, 26 Feb 2025 08:59:09 +0100
Message-ID: <20250226075913.353676-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226075913.353676-1-r.peniaev@gmail.com>
References: <20250226075913.353676-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62a.google.com
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


