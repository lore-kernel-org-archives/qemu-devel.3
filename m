Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C5C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGe-0008AB-Ix; Tue, 28 Jul 2026 06:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGc-00088B-HU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:34 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGa-0008ID-Q0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:34 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1f5208b38dso285179966b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235351; x=1785840151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pAFxtzfR1kXmS5OJ99MnGy/nFG6E2fuCMA2MDYotSI=;
 b=aufP3M2U1a/N5strIO6MWX7w3ibAe/fppp7DLIl0ioRCXp9Jq4okS4aZxqINKzESzL
 MpS9Op2i9Ky3VIADTtSTRmIRHoad0+dATcpgJu7jIwPlwxuT18o3IZGMUoQ5oJp2A3Ay
 AHW1gHLushSfj745dqMTvv1eHhV2EbuJ4IEjdtZ3DT8sqOyl6LWHPjGOearSEwHm6vDX
 QUBpvykVz5Z+o3KtAItFpFOBiPjtZlO7PEeGQQHWgHB/bwzQpxNT88RkMliAPt4Zqer8
 uOFUMSoFa+MUT6w1e0PSDa+54SmXyin26a+LkMW41L+end/RJm72PV+G06DDoWIVBIWc
 q43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235351; x=1785840151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pAFxtzfR1kXmS5OJ99MnGy/nFG6E2fuCMA2MDYotSI=;
 b=Wdr7CQt1aGYB5MD2MgKw/CH8SfbflzoBOX9AIId6HeNfldCYAj7FBztKZg2vPGMmMf
 8ns0fB5/oyWuTO7hADcePe/utytbT6T+NoLbZqchJAAX2ZXV18E3QTd4ITroV3gYt2P4
 T6kb3DywmjbSpUZb3URUmUWNxFVqe/Hvctm+FBXE40zQwl1GmOn6Z/OId0mcqzc7Uuqo
 TsYefNlLl4+yS2NOJ+W3nEmOJOqICRD3wtCD69wQhmeQJ0Vj8Zi0mTcMH9BTqqysIv/h
 GXbFuD9rufhAFd4wbHxKLSWC5WNhivvD6iZGbJVDGpw+1KBlsCtSA0fHAywfeDPk0YYz
 ET1g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4ebb2OsrlMS8bfo8unO7ES2pKRsgMqSxJVyoTEtwlftK7mWkJO9NHrfaB8XRqz01NTsMD0cf2NgMk@nongnu.org
X-Gm-Message-State: AOJu0Yx6PDrN3IpcpEezwVi4h/Sc5NZdsPFMnVZSVru8JaYDwnrw/B/s
 6IMsZQFmNblRrJZb/DURYPYEsKQlsqGsQF0XwDvH6ZN7KIxW+mc5508o64tncFE70TU=
X-Gm-Gg: AR+sD12pSD33Ndy1+kHQG4xwAW3CunwchbkODqlvLtzddX7lUHfIHykWiRESeZU3jLk
 aY37PYX7kgkF6GVx8Bada/Q2UUOaCm6zBf74MgvTFZtWRbn+gmAHoS+ZSFFc9mvVp+Gp0KC0LCp
 /Xk/8AHAYwutTj4NWIZX4AE7H98STynYyekWMkS6NOXIZPRsxetrp1J2iCJLh51DRZKjyNV3ydr
 orjXWY53TEq3wWnj4ESiuuYqqVMcPhddjp1SKeG1zgrzH1gaqaXGuvwC2JGZHFHfzaXU9wFFHp8
 ucqvFbnhdducNv47ccl97HTJi35aCjgGDzTvuWo2P+I+/7Gshs8AJN6v9R/hm+opNpBnD4BghUK
 qlXT3JWvL48ti/C6qX0mpKIeY5NC2bvt47wXrYTsGHpZ5Wsy/CtYYuMf12tk6g7BBRA==
X-Received: by 2002:a17:907:1787:b0:c15:ff7a:e56d with SMTP id
 a640c23a62f3a-c1f7215114dmr75060166b.51.1785235351335; 
 Tue, 28 Jul 2026 03:42:31 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 6/9] parallels: skip loading a genuinely empty bitmap L1 table
Date: Tue, 28 Jul 2026 12:42:18 +0200
Message-ID: <20260728104221.3981592-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
References: <20260728104221.3981592-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=den@openvz.org; helo=mail-ej1-x62a.google.com
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

parallels_load_bitmap_data() unconditionally calls
bdrv_dirty_bitmap_deserialize_finish() even when there is nothing to
deserialize, which hits an assertion in hbitmap
(hbitmap_iter_init: 'pos < hb->size') when the bitmap itself has
zero size, i.e. the disk is a zero-sector image.

Skip allocating, populating and loading the L1 table entirely when
l1_size == 0. This is safe only because the previous commit already
guarantees l1_size == 0 exclusively means the disk has 0 size.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels-ext.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 97744c9696..704e16e1de 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -168,14 +168,17 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         goto fail;
     }
 
-    l1_table = g_new(uint64_t, bf.l1_size);
-    for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
-        l1_table[i] = ldq_le_p(data);
-    }
+    if (bf.l1_size != 0) {
+        l1_table = g_new(uint64_t, bf.l1_size);
+        for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
+            l1_table[i] = ldq_le_p(data);
+        }
 
-    ret = parallels_load_bitmap_data(bs, l1_table, bf.l1_size, bitmap, errp);
-    if (ret < 0) {
-        goto fail;
+        ret = parallels_load_bitmap_data(bs, l1_table, bf.l1_size, bitmap,
+                                         errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
 
     /* We support format extension only for RO parallels images. */
-- 
2.53.0


