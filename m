Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BADF9D0C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCc8Y-0003Ml-Bv; Tue, 14 Apr 2026 07:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCc8X-0003MY-IM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:40:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCc8W-0007XS-1j
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:40:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488d2079582so49600795e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776166852; x=1776771652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7L46d3RVA+pndHKf7BmgScwp74EmHepatmTW1GWELZg=;
 b=fBD04iHvjUJ631bvSa+sB86tDxK6yyRH8Mue0O+cL5LrBedb9tt62SYyTHiz2JI2Ou
 j4y5aSWAQoOoWDEduibJPLEFInYHlAFd823iw2v3/HjGexw9WELYCym0HTvld9UuPZ36
 YFuVh4IZtmklnpmXm06/pEQnyGmRox7DGeER/iTsrkjnoSRCDpLuzJorRI7eGt+cOqKb
 fbywqdCakYuTxK0V0R1OEgrzyDv8AUNw78bmxbRYYKCbWceDIzadKnmiaSX6yChcuTyF
 6LSPnXYvZhVs2vfE4NL+nhppB3IKiWoy8lYz6Ii69pnXTr6gIag8QUxygghDnbuc2fvs
 CwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776166852; x=1776771652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7L46d3RVA+pndHKf7BmgScwp74EmHepatmTW1GWELZg=;
 b=rLmafkS3t/pMKwtgPhOAms42Ju0ef4hhEdU2kOnobUQB5k8OfHJB+WjOTYNWO92IDG
 EOdas5j3D8q4WIV7OAYExB6C5LsssYlUnV3n8QYIjTDZLrKljbTWJyBo1m43ylMnDhPe
 8/cOJKDTXgX1FpVwlE/MQ+CWZtTLC1LnujgtPp8RaaKSx7a/0ujJsTBQjqvmhUPKvva8
 Z3lt9/kqf1C6NPNvs7a5alUIJObBdpGNGV1d7B9MYC667Fekm8ZgBB0DDdKBpQGdWB2Y
 Vay5axf0PYvRDvmjPAbUiEGpaKVY6SlsSGoj/l1CWvBg3iHs8bhX6SxJRWPUPf4N9D3l
 gR5A==
X-Gm-Message-State: AOJu0YwBbACd+7mUq4cPhFnjVvKGV6jNTBjc254CYY+Mo0xQoz5XNrZT
 jy8ZKDFaROdzOJwGe8sRYW3FALkLNjbxoae2ajBXXOLKfXlNATTO9YPx7BZKNQ==
X-Gm-Gg: AeBDiesGKGdvfZ2WkGxxAxXAtvXbTi6rQh11BEgyLfSyPEu6quQj39ogBEdC+foFCyW
 228gy6FQBSaas973GExzybGlqgIhnC3MZYidkS2LmOf05kgs6r9tRu6LG3g2UaAy234b5XrC1BN
 DcQXHeas79mLutrJV0DBSq6MaBeWLMKD0YkggMHM4ZFcqYbE7/Xs4eL3YzoQebWSMLledDCVZYw
 0gvCBS/QsWNdKp6R+V8l44JMmSwrWIRJXqSpoMTNgq9jOz8e5btwuUwRLzfJ2HE4AfpNiAgM/Cf
 i+QK+trum2JpYBhxeiqeElccVja2T6id5XwejcvSu+Y7MIJYlHCmamjZ9qbck50eM0YNHWVCqIn
 Jf94rZfPNFsxUykmC+8i+7Fqo5FJ74CEEqIBVKe2zJbrJ2QZ0AhnKNQ8+uhfwr2rdjD4tlpTb6B
 s6ltyZfj66uTDs7dwF6K1VlnzjSd8IwGG2BQnabpfU1JE1LnyyO4HUW21dSuNnyDI=
X-Received: by 2002:a05:600c:3b24:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-488d6872ed0mr237746525e9.25.1776166851663; 
 Tue, 14 Apr 2026 04:40:51 -0700 (PDT)
Received: from archlinux (pd9ed75d7.dip0.t-ipconnect.de. [217.237.117.215])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67b4a46sm267821125e9.4.2026.04.14.04.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 04:40:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Bernhard Beschow <shentey@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH] util/cutils: Fix heap corruption under Windows
Date: Tue, 14 Apr 2026 13:40:33 +0200
Message-ID: <20260414114033.2360-1-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Under Windows, QEMU would only sporadically start successfully. In the
G_OS_WIN32 case, get_relocated_path() first determines a cursor
to the end of the "result" string and then increases its size with
g_string_set_size(). Since g_string_set_size() may reallocate, the
cursor may become dangling. Windows may detect this and crash the QEMU
process with the following message:

  HEAP: Free Heap block 000000000499B640 modified at 000000000499B684 after it was freed

Furthermore, QEMU crashes spontaneously, even long after the guest has
booted. For example, it presumably chrashes due to the guest setting a
new cursor icon which may be a result of the heap corruption.

Fix this by determining the cursor on the resized string.

Fixes: cf60ccc3306c ("cutils: Introduce bundle mechanism")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 util/cutils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index 9803f11a59..76a9442085 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1165,9 +1165,10 @@ char *get_relocated_path(const char *dir)
 
         PCWSTR wdir_skipped_root;
         if (PathCchSkipRoot(wdir, &wdir_skipped_root) == S_OK) {
+            char *cursor;
             size = wcsrtombs(NULL, &wdir_skipped_root, 0, &(mbstate_t){0});
-            char *cursor = result->str + result->len;
             g_string_set_size(result, result->len + size);
+            cursor = result->str + result->len - size;
             wcsrtombs(cursor, &wdir_skipped_root, size + 1, &(mbstate_t){0});
         } else {
             g_string_append(result, dir);
-- 
2.53.0


