Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D17DC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pgG-0001IB-7T; Thu, 10 Sep 2026 21:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPX-0001g3-5a
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPU-00078R-TB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49e625d5a2fso748305e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083746; x=1789688546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I/WX+4pCAmK4ycsPuxUQEh25NlG6reKGl1ZmaTRTHAg=;
 b=DSxoQdDXW4gyO8esFnO+EKRJPxOazeGIa/hxdva6YeIa095PsmmZ0nurs0QSg4456H
 hh9HBhYjuoB1ZUKpV9XkbnPf7GRrXM/ygeesoLrCHc6wH/7XOvCW58NYbuHjsGAZm6g1
 vWMALtcUtlBOzbi1VezJwJDWoscN8aB1TmjOAyJZUXpgPMGtSwRpj1zCTRu4KhOquFWG
 QxNRgkKlRJJke4XNrLXp7Z5axnQ/PU0l1iJaMoiO7QupfsM1JegpTr4X2RgU7kG4QuY+
 o0wRAugEjB7AB8PRQY06elweqWLzaKSmy7HWfXAGMDOGnrQ9ivYblPWJYvCRSuHCZoVk
 LCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083746; x=1789688546;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I/WX+4pCAmK4ycsPuxUQEh25NlG6reKGl1ZmaTRTHAg=;
 b=ZnqUs9rjOyxm6hs/ChaSCHjBt8QHd4zmMRQdwXwMasj56MrlZFCKnq5dYTJmhjX7Aj
 wI3RWWAkuRAcPgq9oqmz7xIgz3byZcP8MaZ3MiLAaUhZfKQiMXO2zmeDVkfwFn6IYOiT
 dyBgST8+BiKcSW/Hdf6AB+Faeyv6z1erdlelhOfmuWZH3NWMoPCps5ZCn0EThu4rpiM7
 aIcaoWei7W/7SWFhoux+VX3jOCg2842X1rjTxmtRkflaAMegkcs2m4qdOwcFH7q7NVv3
 My0QMsCsBfrXGRMGk76CFy3gWiJWLNRZNxEpvkn0YLH12H1rR56qnPotUwP0BDjh2rW1
 8Utg==
X-Gm-Message-State: AFuF++kFpSAX9M48NuqVftOCcIT9YkhD3spJa04mfi7T0zmiARgJPDJf
 IEIK8MvpZG7fsFCsYyH84zDUuBfa8YbCon+uv7AZJk3U54tQ3qoU2McWTDXQo7Yf8H8=
X-Gm-Gg: AYBFou0x2l+YtLCAb711Evo5xD6v8kiAUtJyHEQaoFqBAtauEsRViZEvc6eFda/uqYV
 kIFyrmJl8Eb80Fmui+vkdOitk0OB6qwB+4XzsAQU/XkkD+Yglc9PAT28D9M50TAXqiL0phIWxgE
 6tT95C+Za7PcFqQzm3p2WUL/7vu7lCMIqYVO4v+D+Uu5mEPRbXncG7nLhv/dtmZR48uGpP3RCHV
 MGbPZszFAbuIn2dW1DE/Gypo5ZggE/h5qct2NAih8GU2FOVH3HR3F71NsxqPSxxOQCD+B0RVfMF
 6VL+22dL/LHZWazdeyKDXkliKOb7Jc67wd7pkKJPVRhu4+j4FO3esKWAfCZW1kl6Qk2E9+OuHw+
 ow5yiDKFZwQsLlp+r2hUgYN9yuJxkZxOC6L02mpSlAuWS84AePz90qU6d7I3CrYuVfN1OuvJwRw
 zxCrlFMl2lQIaDekPzatpVrta4I2IrKib9ory0PdFf4L/0z+RY+1EwtdhuNffo/FGw6s7p
X-Received: by 2002:a05:600c:3494:b0:49c:fa21:1c7c with SMTP id
 5b1f17b1804b1-49e619bb143mr14136555e9.17.1789083746381; 
 Thu, 10 Sep 2026 16:42:26 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:25 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/29] parallels: fix out-of-bounds read in format extension
 parsing
Date: Fri, 11 Sep 2026 01:41:54 +0200
Message-ID: <20260910234222.3039975-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
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

parallels_parse_format_extension() advances the cursor over the feature
payload but subtracts only the feature header size from the remaining
byte count. A feature whose payload reaches the end of the extension
cluster leaves the cursor at the end of the allocation while the count
still allows one more header, which the next iteration then reads out
of bounds, 0 bytes after the 512 byte cluster. The stale count also
breaks the data_size bound of any further feature, so
parallels_load_bitmap() can read past the cluster as well.

Account the aligned payload in both the cursor and the count. Aligning
data_size before the bound check changes nothing, as the count is
always a multiple of 8, but it has to be computed in 64 bits: on a
uint32_t a data_size of 0xfffffff9 or above wraps to zero.

Reported-by: Martin Holeček
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4156
Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 7f6ab6b0d2..baee86a159 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -239,6 +239,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
     while (true) {
         ParallelsFeatureHeader fh;
         BdrvDirtyBitmap *bitmap;
+        uint64_t data_size;
 
         if (remaining < sizeof(fh)) {
             error_setg(errp, "Can not read feature header, as remaining bytes "
@@ -260,7 +261,8 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             goto fail;
         }
 
-        if (fh.data_size > remaining) {
+        data_size = QEMU_ALIGN_UP((uint64_t)fh.data_size, 8);
+        if (data_size > remaining) {
             error_setg(errp, "Feature data_size exceedes Format Extension "
                        "cluster");
             goto fail;
@@ -283,7 +285,8 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             goto fail;
         }
 
-        pos = ext_cluster + QEMU_ALIGN_UP(pos + fh.data_size - ext_cluster, 8);
+        pos += data_size;
+        remaining -= data_size;
     }
 
 fail:
-- 
2.53.0


