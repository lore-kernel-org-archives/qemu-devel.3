Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D7BC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfY-0005CJ-KL; Wed, 26 Aug 2026 07:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfW-00053R-E5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:46 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfT-0005qN-5E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:46 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a41191c9a9so980919a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743181; x=1788347981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TJBKDx/NPPo3M962XW23quyF1pb9lG1A3xeKFPd765A=;
 b=jpE8RjVzifcpaK9OmL5JUTixjOtlkLpEI8RcyyRjOV7TA6MVabC8zloBRXKKoQhfQZ
 R2ze3CcFhYv3IMeD6IW8En6Avq2ijGOnXwmeP5+ppVeChrNGrcC8aYw0XPS6ZFbUmI52
 OKD8ODzikaonesJB1iFZsD4m5jg/4kaJTgWwq+QIaeGmDqjGPwzonvfuWQHcIfi2qNxa
 O/p04vmNawAv675BxUKY9VMskzwvaKmD0Csu5ktG88k2qatFJ/nfu2Und11FaH8PRzDQ
 9wvqc2c0UHiQQ3m2Nc+wcnRHoZ0slVkTm4Z5sJyNkPHXV7c/tSpQsttyO1owy1JUnVWJ
 lBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743181; x=1788347981;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJBKDx/NPPo3M962XW23quyF1pb9lG1A3xeKFPd765A=;
 b=WgevGZroNoW9M4gYO9dhAKBBwknRqOscJfCljcma9X0je9wlmFP23NkfLbjvMytLg7
 EgMqjUzervfzDZX/0XYA/qLFxquxnDB+MzPDdOz6yNouCyM8aDWgsquJG+3WcNGM4d2e
 AT9VWfDIE0rx+o5NNulgR6WhfORCYZm4mv5yfUfjPMCZiMS4rGZystg7BgcIwIwl6z3A
 opSC5U8hxOtW2nm8xWav04Zw2nPDxbA/vAZp4uaYsqEYl63W9cV20j/COkudqwkEmzNK
 wfGhgZIaq/sWrO10CoF5DghFVkQM4fNYR9CsGwBaK4lCBmiZb0A8y511bhmlIMZhV3Ij
 Upcg==
X-Gm-Message-State: AFuF++mBNbFbXRw87+h0Mw7/+jA0f8TNpIt5sSUBZ0T44Z6Z85P/Jo/C
 uwRTBuf/YPXilxmCmKJY447n/KBX3SYRpvxeeqlOSxCaerFwuVaTkIGiv/8e+fu3AvkQh/sDYBd
 GWP0a
X-Gm-Gg: AR+sD10RGGUP+wWIwihgsFiCe+CH6UDtUc/l96WEQtcIYikY/rvn4ZFfOiubAFjBiem
 +bThwkamfsEPcvH3EDkH/nrUcOelJi+Bj4eHQ0Iw/7E0T8FOaptx2/dbkuTgl8iej4dZa8Dgils
 XFIAXiA9FdUkr+f3Hh2z9h8o42vMQUjga1rvB2wn3YFTU6/nABPSHZPDZNpo4HE6T9s/E3Mp8/I
 prLXvVwxL0imipcpeJozlEMT00qpTgsWJZkDUnbhy8Tmqd1x8uQh9ZzHmRjFBs/mbW7Psrlad6U
 rUF5LqdOtVDFj/Yjcl3MPMvgarPyIjq4Amz806Zt0l8D2pnG3F/MGYlHwzhtu7t4UC5BMweWqxp
 fhPQv/XZVSdpGMbvkSaLkH1WoEmUtTm8PwC3KJ6gcv9Tb5CF3MiHn2OyTi+hplYz0Z4rQXA7yVe
 fVFKnQ9+pm1Uko2Hq+qKYGtXtlEMFYm6OzKpac4JxLWR9NZlkC
X-Received: by 2002:a05:6402:3245:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a5df653615mr7496309a12.10.1787743181426; 
 Wed, 26 Aug 2026 04:19:41 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:41 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 27/28] hw/ide: report ATAPI UDMA5 with a matching standard and
 cable
Date: Wed, 26 Aug 2026 13:19:14 +0200
Message-ID: <20260826111915.3387926-18-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=den@openvz.org; helo=mail-ed1-x529.google.com
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

IDENTIFY PACKET DEVICE claims UDMA mode 5 in word 88 while word 80
reports support only up to ATA/ATAPI-4. UDMA5 first appears in
ATA/ATAPI-6; ATA/ATAPI-5 stops at mode 4. Bits 3:1 of word 80 are
obsolete in IDENTIFY PACKET DEVICE data as well, so the old 001eh
claimed three standards that mean nothing for a packet device. Report
0070h, ATA/ATAPI-4 through ATA/ATAPI-6.

Word 93 was left unset, so nothing reported the 80-conductor cable that
UDMA5 needs. Fill it in, but only for a parallel attachment: ACS-3
7.13.6.41 gives word 93 of IDENTIFY PACKET DEVICE data the meaning of
word 93 of IDENTIFY DEVICE data, where "For SATA devices, word 93 shall
be set to the value 0000h". A cleared ncq_queues is how both identify
paths already tell a parallel attachment from an AHCI one.

The device 0 reset result is 0fh rather than the 01h ide_identify()
reports: bit 3 says diagnostics passed, which they did, and bits 2:1
say the device number came from some other method, the only one of the
four encodings that is not a jumper, CSEL or reserved.

Raising word 80 has a second effect. Linux decides a device is SATA in
ata_id_is_sata(), which wants word 93 clear and word 80 at ATA/ATAPI-5
or later. An AHCI CD-ROM satisfied neither condition before and was
taken for a parallel device; now it satisfies both.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4038
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 06c18dbf09..ef573798d9 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -292,7 +292,7 @@ static void ide_atapi_identify(IDEState *s)
         put_le16(p + 76, (1 << 8));
     }
 
-    put_le16(p + 80, 0x1e); /* support up to ATA/ATAPI-4 */
+    put_le16(p + 80, 0x70); /* support up to ATA/ATAPI-6 */
     if (s->wwn) {
         put_le16(p + 84, (1 << 8)); /* supports WWN for words 108-111 */
         put_le16(p + 87, (1 << 8)); /* WWN enabled */
@@ -300,6 +300,10 @@ static void ide_atapi_identify(IDEState *s)
 
 #ifdef USE_DMA_CDROM
     put_le16(p + 88, 0x3f | (1 << 13)); /* udma5 set and supported */
+    if (!s->ncq_queues) {
+        /* word 93 is parallel ATA only, a SATA device reports zero */
+        put_le16(p + 93, 0x600f);
+    }
 #endif
 
     if (s->wwn) {
-- 
2.53.0


