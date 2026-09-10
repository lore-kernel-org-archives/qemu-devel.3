Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F963C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pa5-0004Y9-IL; Thu, 10 Sep 2026 20:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPa-0001gG-K6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPW-00079K-RW
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso3168825e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083749; x=1789688549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xmIJ/DJJkGNWUN3aFg+eKBZQoYpsUnERuZvgRZchJco=;
 b=gLYyHjiIZ4wZqM4Od8W0Sxt19z1TY9pyw+6Ud5n1VrKZs3NFY71jEZH+j9y9LtZVz2
 YxFbrJMlw8tNJiV0b67Hdq2zm+r0w2CxxW6Ch0EdcSQauMxHujtqAiLwhMMLE9VreMeI
 jWakfQEr4HMwHYsgmhhVlKlgmQhiKQPYCXgV8reG8Ym42ZOXTKrvAsvlbQnilU+yP3DT
 CWd393TtBZptoRWN2cSrWvdzBD2zbdzvrAyD8l6MrS1DScEUVa5VVE6C7K1cJY7aEkUe
 jfWVbgPXpaeBJHaOM3WrDrz74dhCbB120dTgu2ZUQ5z2EEqr4DVKej3bLtLk6H8wgMl4
 IiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083749; x=1789688549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xmIJ/DJJkGNWUN3aFg+eKBZQoYpsUnERuZvgRZchJco=;
 b=sOpGiYLTdkPEbzKGABgCXyLncLubQ0qGN09Osc0/M8mEEOrydIdIgk9o6Lf0dOUdiJ
 edM8+cDFkhE7xLnMSwXdUP44/PreYa/8SKRVt6BknlSb7txvXEBTA/GgK60pEVwUybru
 QyWUu6EwzI6rB/7zpyWC+L8rdw/PzQBaNvIcEx3hdFz6FicvZyfJv07gdYtzaLvf+Jgq
 4BUDe9SJBzD3stvXRddPM/Z4wVD8NLUJ6k+YcDfrglEVV+/jD7dq+FWfj4pYvZlqtQaN
 31HkdL+nRIhBCeDieK3vS/GFGZ83q0+mx+pVrUPR4DUInGDoEmgwHjKxqrFnY9vW7wn3
 rIQg==
X-Gm-Message-State: AFuF++mDM7XiILGz/8qosNoU22DVW3PfYLeE0uRG1V3Cai4ur57ieNX2
 PX4vj1T+IRgKWLmQqQ+7z2I+fSASob2vc/w0QKs93Bk+8y/R12SnOGZWx/ETQq3Ke3k=
X-Gm-Gg: AYBFou3mYLgCnAyDUTPOQTcCvpLGt4YtiD9jMJcKGIG9GCw0Kpw683TY1B+YW7nzOa/
 8lF4NCUWCDuW1evmnZHqcTy9n9yyduv3zHUL0/DyliO6dmxSYBWnKD9DO3/zx4Rvm5EO1uDSxQs
 2lXugSW4r1PVVriNVNVlP7B1cyMy8LejVOEfafoiAS41JG5xCXTWBAu/6rlY6V2uTvbuse5iGLE
 pZ31f0XtiN49BA1dVUM6XRBK3uSPSksA8UyoYzYiQ2ft+kjmGK96kHnPpsWpvzAKNqhdmKF/VDh
 R8SvjowlajCmGrxOkeSDdJc49T1+aiit7qBOE0mk5iF8hZobzGJhcUaR4dZ7leDpIIniZ15BSdt
 htGjZvkC4FU/nHclI9/1uiWqwcnBbxYs/9HzLyPxfW46E3/vCwxkrSn9J89sojisQtvD4tx7hSm
 kg2r2W8/o76puLjRY7fLyM/rcogVPAlSPqULB9MEK1W0B7DE107dynIgsDjr7m4SHDEuu7
X-Received: by 2002:a05:600c:8a1a:10b0:49c:ee22:364c with SMTP id
 5b1f17b1804b1-49e6198d0a6mr10919025e9.9.1789083749047; 
 Thu, 10 Sep 2026 16:42:29 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/29] parallels: reject a Format Extension outside the image
 file
Date: Fri, 11 Sep 2026 01:41:57 +0200
Message-ID: <20260910234222.3039975-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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

The Format Extension offset and the cluster size both come from the
image header and neither is checked against the image file. Reject the
image rather than reading a cluster which is not there.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 93b5fa9dcd..50748d1415 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1375,6 +1375,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (ph.ext_off) {
+        int64_t ext_off = le64_to_cpu(ph.ext_off);
+
         if (flags & BDRV_O_RDWR) {
             /*
              * It's unsafe to open image RW if there is an extension (as we
@@ -1382,9 +1384,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
              * ignores the extension, so print warning and don't care.
              */
             warn_report("Format Extension ignored in RW mode");
+        } else if (ext_off + s->tracks > file_nb_sectors) {
+            error_setg(errp, "Invalid image: Format Extension is outside the "
+                       "image file");
+            ret = -EINVAL;
+            goto fail;
         } else {
             ret = parallels_read_format_extension(
-                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
+                    bs, ext_off << BDRV_SECTOR_BITS, errp);
             if (ret < 0) {
                 goto fail;
             }
-- 
2.53.0


