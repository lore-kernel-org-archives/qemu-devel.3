Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30734C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbc-0007tF-LV; Wed, 26 Aug 2026 07:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbX-0007q2-Ff
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:39 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbV-0004JC-Ah
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:39 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c252cd2b3c1so47172566b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742936; x=1788347736; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PGxOxbJCTHpjzoR3+U5OxJn0dZ4GKFvitmqy32ujxR0=;
 b=igpbD63MFVZ4ffzoOsjcgL3zvwb5WhfDKu+HAQ9eNDwtutgIon2uq8NzmVYhtdf4ky
 xufP1k04dBxLhajph0QtjAgUXqphV+MFPghLyV2WmprqKUqni1KsLtyWfWx+D9l4m1u4
 w4QdpSPbrCijnLI73E5/31Hu7KxnDhDxQPYb589jytFTB4xAsYn3iRrhyVxblsu5zul5
 ni/G+IoBJluqCcuHKiuSRCp6/4xezfXY0dKXIOdLzjU43z4FExNZ1hCa0qiAIRyvGec6
 J9sxBrsrb5HE0xKUPGgQJwXmtc+joAP1lbJsGr+j0H0K2N9g0hRP6Wb4+n7rqqDnPXQ2
 LKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742936; x=1788347736;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGxOxbJCTHpjzoR3+U5OxJn0dZ4GKFvitmqy32ujxR0=;
 b=W9RfAZCm4qC06SYWk6FwgCUrHP8SfxPt8a/eWDQw1R6C6nlvLImO68S0aBOPMjBHJn
 0w93tSG5dhwBo0vDBE6VcLaOWoCw1+VuJ6FN/dMN1ztxlb++viOlFNnTlCWVz6K1dAa/
 7/ro8mnw2gyb4M6vAYkGkXhZQbOAAnjUNayFAG5PSSQnKc/tIQSWePGGV1hNgBvIBq+a
 vofLibVLuPB6JbEyLxQ8rR2xdQ/nnd/UfpoklobwoSSrOAR6HcmIwq3oWzuyhmyeaTl9
 4I4yUKgFniVzYA18Y13Q1Gve0WX4JpKROmK5kRDH2LgcLm6ENBDeKBKmrpeTdS7xhBCG
 HKMg==
X-Gm-Message-State: AFuF++k6DtkyWNK9twRxz/TD1W+OicwrsjN8DSFaVxFyvVMZwc5K8cDR
 9GUkn1Mf7k1F00xY5gSXXgt4hYFfV3gmlVN1DV0alD1Ny1PgjrEnLGQE3GDthxv/r46BfFFSTc7
 L5wRd
X-Gm-Gg: AR+sD10WombeHMF+40VzOT79ECjvPaWFF1itROyTJftN/N9eOjiGIXVHnzwbtbeI7bg
 CaUAi0+l5b1WVDg5tr8tDRFCikPr1AucH/btiTbAIGpKgDYja8xpUL3hBzE6GYeR512ulpDHByG
 0OhFd6+/l+x+2rVdg8bFpKPBaZvgEfPuaGuZjRuIkEdVhcCCmDv4DRN8qMe2XSzl34mzcQLkjdC
 RrxBB40NMY//eUSWbZ2YCWwMb7e9cbRkJJZOR1QNpD1zEK5zTdrErl+Kypa+i7+W41nYFHOaGy4
 epguQXv77XZoDl66KVB2KwPhZN6c9um4uOBv/oxxx97zFpjz+5XAQFYIFpmC35fe1KhR9i1lJgl
 L0VDbSJKu6UQzDhLD9KgAnAWSN0308ZPn9SflExE2CaQ9XW3/AQbZfQPEWQtfXg6MQkPlCvaKOv
 bmCJgWbMog5I/TNzYbq4nZMASmEbfY6U89Rzxa47OevfpRu/R7
X-Received: by 2002:a17:907:e00b:10b0:c24:6f60:3f7e with SMTP id
 a640c23a62f3a-c250bbbf36dmr593088266b.2.1787742935680; 
 Wed, 26 Aug 2026 04:15:35 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 06/28] hw/ide: name the retired IDENTIFY DEVICE words the
 device fills in
Date: Wed, 26 Aug 2026 13:15:21 +0200
Message-ID: <20260826111524.3383479-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=den@openvz.org; helo=mail-ej1-x62c.google.com
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

Words 4, 5 and 20 have carried an "XXX: retired, remove ?" since the
device was written, and word 21 is labelled a cache size when it is a
buffer size. ATA-4 8.12.13 retired words 4 and 5, 8.12.17 retired words
20 and 21, and ATA-5 keeps all four that way.

Retired is not a reason to drop them. ATA-5 3.2.3.6 says a retired word
that is still used shall have "the meaning or functionality as described
in previous standards", and that is what these carry: ATA-1 9.9.3, 9.9.4
and 9.9.7 define the unformatted bytes per track and per sector and the
buffer type, and the ATA-1 IDENTIFY table gives word 21 as the buffer
size in 512 byte increments. Software old enough to read them gets what
it expects, so answer the question rather than leave it open.

Word 22 is obsolete rather than retired (ATA-4 8.12.18) and already
carries its ATA-1 9.9.8 name, so leave it alone.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index befbab9486..292908fb1c 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -141,12 +141,12 @@ static void ide_identify(IDEState *s)
     /* Words 1, 3 and 6 describe the default translation (ATA-5 8.16.8) */
     put_le16(p + 1, s->cylinders);
     put_le16(p + 3, s->drive_heads);
-    put_le16(p + 4, 512 * s->drive_sectors); /* XXX: retired, remove ? */
-    put_le16(p + 5, 512); /* XXX: retired, remove ? */
+    put_le16(p + 4, 512 * s->drive_sectors); /* ATA-1 unformatted bytes/trk */
+    put_le16(p + 5, 512); /* ATA-1 unformatted bytes per sector */
     put_le16(p + 6, s->drive_sectors);
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
-    put_le16(p + 20, 3); /* XXX: retired, remove ? */
-    put_le16(p + 21, 512); /* cache size in sectors */
+    put_le16(p + 20, 3); /* ATA-1 buffer type: dual ported, read caching */
+    put_le16(p + 21, 512); /* ATA-1 buffer size in 512 byte increments */
     put_le16(p + 22, 4); /* ecc bytes */
     padstr((char *)(p + 23), s->version, 8); /* firmware version */
     padstr((char *)(p + 27), s->drive_model_str, 40); /* model */
-- 
2.53.0


