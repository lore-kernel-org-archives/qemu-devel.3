Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98435C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojta-0003he-Bi; Tue, 28 Jul 2026 11:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtV-0003Ys-Q6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtU-0002ij-1p
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so11759f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253139; x=1785857939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pAFxtzfR1kXmS5OJ99MnGy/nFG6E2fuCMA2MDYotSI=;
 b=bZtobW6anmEk3bHqnf2q3pujlmoNhZXl2+o05VTmSe615Sm+4+jDbgSXoTXsALabae
 aStSGtjmArcBcljyCyXaY/EWMjz/uxGgUU7fseYVckYqRlzfWqI+xE3qmKbXK3hIGcht
 HnT4eMMz7pjYZL7Iw5SHVvaHvbnhmn30vUXeh64WbEZ+td6a5IHPzz2gjF9iKH6pWTnc
 EbGFZvAQZLCJfXaIWhu1S6T9AFV29ZAE3SgnnG8ZeaC0/NX3v3g+0PlkRr0IR1N5HqTv
 GvYEnY8TgEUJ+59dL+0EYB66uDjsem6p0CaZ2HTNQG9RIalcshhz+enfcHqDV9QWRgTP
 a0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253139; x=1785857939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pAFxtzfR1kXmS5OJ99MnGy/nFG6E2fuCMA2MDYotSI=;
 b=VS5zJ1zT1+r9Uard3pPAWxHA8M2eTO9XTLBPh+OLju3WQW5HBarhoipPKPZCstv9r9
 I+ccX08TLwOMuZA0bZXELeSB+CeL4wTnRsDe9U3lGHXp4/xS4yooBnUkSlT2zEwPwgat
 1/zplKq7wlVPEawfiw+J3rjW4lBsjWLehdzqvmIlAaHggNO9XqQCunTdFwnImlFy92cb
 wopRP9C7Gqtt8rBTxvlP92A2dSy57mJVEFmvKOvtC9Bx7a84DKMblUSi7qQHdRu6sWEx
 7XbUU/kOQJ+TxaZLJnSh1zKWC/fDIayiU6D4ClQA6/hbB/Aanxe8E36jpKHDPahXPEj6
 CIUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/PweZQ1WUX7XXKP8ztDBFrivnyqFW9kMBm96pAJ1nI8ftWvJ8hrzpFC5ap7W2a8ZgcU/SFx784wa2@nongnu.org
X-Gm-Message-State: AOJu0Yx+Vf7DHXYJEWEdDZE0JOLs/f9GpKiYk2GOoEDPoZPBSmbuBuHv
 6JdFUxot6nmjdVmV1/0KqqE7MclG2Q0X6shg9QOt0ALtP6v/EMBZU03WVdXXRM1Ywqg=
X-Gm-Gg: AR+sD100duvjqTw/OC3Gj4B7Bjzxo+nhPd0YKwbgjMYrDsA3pDaxgimLQYjfsEpdYje
 EtzpeT7wDp3cjhI5JAAZnpYH4YDmidS+JY0q0xTKUdkrpadUTrcdceTFaqR4ytFOblNvJyVfhq+
 sIs3de5TpeAa65OmRQo1SzQtOCOiymBiMC0uoQU+6mROHFP4/rq8cHD3MDZaYdiN6IzVkoFn+9b
 sJC2dAXR9hCCxGonFeBL+uVVEOMhqTFmwJD9KX/BdoxOVWfM92gM91IRcDqE6sbmOr3fALjzG6F
 Oa7MKkK9GBFDw2asdWiS6ubSJDTkX7xCnjYz4UmLgFExvBhtAGh96wlLvqbmkxOSpxFp6rf/eE9
 q9dfs9l4RwG8ZGgc4qKtzHpAbvnlsfSl1Lin53BKJ10wJl+1Y9mU5AXN+DFN9XieELjMUg9fumQ
 ==
X-Received: by 2002:a05:6000:430c:b0:47f:9839:a79a with SMTP id
 ffacd0b85a97d-47fb1ec8808mr3674552f8f.10.1785253138574; 
 Tue, 28 Jul 2026 08:38:58 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:58 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 6/9] parallels: skip loading a genuinely empty bitmap L1
 table
Date: Tue, 28 Jul 2026 17:38:46 +0200
Message-ID: <20260728153849.601939-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=den@openvz.org; helo=mail-wr1-x435.google.com
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


