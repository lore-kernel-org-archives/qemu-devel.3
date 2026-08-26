Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1D7C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbX-0007pS-8T; Wed, 26 Aug 2026 07:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbV-0007o6-SV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:37 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbT-0004IE-RX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:37 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a3819e8be8so1938827a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742934; x=1788347734; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5m9uheqn5F5pEee9Tp/EbVvueEOqVOsxBiATdriU+vo=;
 b=R6TT14avbFYymHP9/eJ710dKXplkcTs++faod9Sx9629VTAjuQSjsZgH+zYm67oCD1
 f7jm3SvDW45tu/qPWycgJ7MgWMe7LgcHyaX2r6EDZYWlw7Mi9YogGlgWhEMXSAio/brf
 kddSaQenX0UWs8I8cWQZa9Oc8bc3/3gwz3eh7dQCi1hsdLhtAfgsBUMfNy4C8U+PJolc
 td901cD7cXl+vlwVDml7GoHm6QdowM0COqwgGtUKdVDbaoJIudee3jKTiFMgXjpaLRqX
 e0AfAe1AVS/Bo/XDWY6Yrdrn1Qv5qe9i/fvKunEJ603YjqnkQB7/+kZZ7FGZJGihnxAd
 T+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742934; x=1788347734;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5m9uheqn5F5pEee9Tp/EbVvueEOqVOsxBiATdriU+vo=;
 b=gA3FwfFAcbXv5TZwC4LREUsjXTjnYE2aH1ZEHBluLtbqjRXoNt0z1n1jWmE5tvWshu
 PhaT6AUUbRi9QhOHbOSxjHEkYjoJUrIi9T4yNQEZCSgltflXg9Dfo4xBGw6z40COHtfm
 yZwYNIseLMLhXKqho5IW0vT5NQ/q6iTc4kiuQFrCbxNyAAh38Rb/12zsaUoePuIpxIX9
 /xZEIZpQrlkpQ0aNFiJgP/9pW6wNc2bz8U2j7Wj67ZsI9vSYl+vmiTygoXWH3iXC8RBB
 MbnRT9X01YN1Rsx3c3sQyz78WO9HZnIzdmVTX+MthcucjQqceB58HqkRvb2H2EfRbtbT
 37XA==
X-Gm-Message-State: AFuF++nsxH1+BM4wtvqgefvFU5KzWaHFquvMtJAPPgKvyDXmvfGn+D8U
 Hh9I/nHOrP13e9u/XpmJms4V0cS+saCdiZdbQeWLd6HP2a0QbWpoQ423pBNnkWMl43aduB3KPL/
 OT6Fv
X-Gm-Gg: AR+sD10wkNgsOXjZJSn5JlamifxNhhGZk6gwkwZWMqqZdr4/vquoGLBA2tqsFenOOaM
 hWOgiBASEp/LTV8JhBg5d71Vkanp2URLENTEfT0s5HLCvZO6npqH+JcbY+HY5OwK/hnB96T2RoI
 EmlgUKi7+hn9oQ8BzZ9wKa2ge86j0NbE0i7yC+vPCzSyO23ZDhvi0EYlCcJWtY3YFlfnm4WjvZu
 OMIcpGrc5iBHic9lIqg+0kunfOx7SGhqix5yPY2KyeLsvvMpsesDB/BPYAWzwF38CmVZv2GVEQ6
 a+UOFX91LkrMQT5evaJtduEFA4vRpfYgOKR1umwO2rhWdDK/Fj08K9rNdI8Eu6ovTVbGin0IOI4
 k/Pq1ZNMhg5kl20hwkpIrsqhb3rQ1Myni5+417n0i89C8tozjYU6J3+63XrhbZz6iPUtQZwZ63r
 vEtUwD1WncrYTI1mLgKYWVkkvXq0Xgz9OmhZXU+t34riPyzUuI
X-Received: by 2002:a05:6402:4586:b0:6a5:d8f0:dc0d with SMTP id
 4fb4d7f45d1cf-6a5df32da55mr8016824a12.8.1787742934146; 
 Wed, 26 Aug 2026 04:15:34 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PULL 05/28] hw/ide: report the default CHS translation in IDENTIFY
 DEVICE
Date: Wed, 26 Aug 2026 13:15:20 +0200
Message-ID: <20260826111524.3383479-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=den@openvz.org; helo=mail-ed1-x52f.google.com
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

From: Denis V. Lunev <den@openvz.org>

IDENTIFY DEVICE words 1, 3 and 6 describe the default CHS translation,
and ATA-5 8.16.8 requires INITIALIZE DEVICE PARAMETERS to leave them
alone; the translation in effect is described by words 54 to 56 instead.
Words 3 and 6 were filled from s->heads and s->sectors, which the command
replaces, so a guest that selected a translation of its own was told that
its choice was what the drive came with, and could no longer find out the
default. Word 1 is already right, as no command changes s->cylinders.

Report s->drive_heads and s->drive_sectors, which ide_init_drive() keeps
for exactly this, along with the retired word 4 derived from them. The
CompactFlash data labels those words as the default geometry too, and
INITIALIZE DEVICE PARAMETERS is accepted for CFA drives, so fix both.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 747fa71677..befbab9486 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -138,11 +138,12 @@ static void ide_identify(IDEState *s)
     memset(p, 0, sizeof(s->identify_data));
 
     put_le16(p + 0, 0x0040);
+    /* Words 1, 3 and 6 describe the default translation (ATA-5 8.16.8) */
     put_le16(p + 1, s->cylinders);
-    put_le16(p + 3, s->heads);
-    put_le16(p + 4, 512 * s->sectors); /* XXX: retired, remove ? */
+    put_le16(p + 3, s->drive_heads);
+    put_le16(p + 4, 512 * s->drive_sectors); /* XXX: retired, remove ? */
     put_le16(p + 5, 512); /* XXX: retired, remove ? */
-    put_le16(p + 6, s->sectors);
+    put_le16(p + 6, s->drive_sectors);
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
     put_le16(p + 20, 3); /* XXX: retired, remove ? */
     put_le16(p + 21, 512); /* cache size in sectors */
@@ -332,8 +333,8 @@ static void ide_cfata_identify(IDEState *s)
 
     put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
     put_le16(p + 1, s->cylinders);              /* Default cylinders */
-    put_le16(p + 3, s->heads);                  /* Default heads */
-    put_le16(p + 6, s->sectors);                /* Default sectors per track */
+    put_le16(p + 3, s->drive_heads);            /* Default heads */
+    put_le16(p + 6, s->drive_sectors);          /* Default sectors per track */
     /* *(p + 7) := nb_sectors >> 16 -- see ide_cfata_identify_size */
     /* *(p + 8) := nb_sectors       -- see ide_cfata_identify_size */
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
-- 
2.53.0


