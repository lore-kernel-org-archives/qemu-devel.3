Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C72FF3C99E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuj7-0003jv-GA; Tue, 24 Feb 2026 10:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj5-0003i9-7v
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj1-00084q-I0
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:30 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso46070765e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1771948406; x=1772553206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBzph0yd8ODlMrDm3zgIFroU1WmXKib1kj+ismUWb8c=;
 b=I7rX6EREfB9R2/9ez2shqC0DXHpKj7qInHcXGgFpNpUG2O0QZEMBqsUY8FZ48IN9c3
 3rJIItiGQX47y5+546wP3bXuCxewKxewLEggURMKY8GOkUzHhSM/PF8mLQFK+4SNofhd
 kpZ/sOayDCJDFX54G63X7IUyTMSgQLFp5TYo8Xy/m398AvDVJK4ImnPk5jIGBml/1JsR
 EAAKEER9OdQrKo2DalWVskTMDiOVKK4aElElOHdjAgVbk6Az0BvPpeZre/vz2EHhfY0p
 GDkr99M1vYjJvvszHMDwtk38T5bM+/nB+XkKchRPnhISJKDSgJV7m9Hn8A+bBpopiWrA
 J3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948406; x=1772553206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HBzph0yd8ODlMrDm3zgIFroU1WmXKib1kj+ismUWb8c=;
 b=i48K4oJjpZW2T4gWMa/rwjwaAC2Tx3JX1LPsfSuCkNpDxa55z+njCuKaZyfKpurddB
 VNBdkNVbDzb3yy4Ithb2V0pndb57IOT2T4EhDdhXYuAQKxMMN/yP/Rkh44SgR2M/Vv09
 ChgBPPgTD99cOhZu1e724dYu1+09pKfn+0rusxfvlZHIQKrDMS+tYhfxkejyoHYR+CvZ
 HYuBJ0ICMleBGPs2GnpWegn14bCH/IL4pCbG0X5ymQZDBXNbcCFy85q0fEnxO5yaJ5OX
 5XCeqFU8BtvmKFdVYzUR41uVlNBr1iQ7y/Yw2uwFARpSpjLmVmfkXG6MlkpHtQpn82md
 X6dQ==
X-Gm-Message-State: AOJu0YzbeUXgyyhv3Ybi0fIKMJl0VP11EUivn+gaIarIIrWRzPUqWage
 Fho2RiCqzo3vi82baPieeESCNhdY6BFimujm/uOcReYZUFuv2tMLx2PkxgbvqpmKsaXUvjJebhe
 58YJA
X-Gm-Gg: AZuq6aKBOvs1u3873tM7hhkE6XtbR1kFXwxSNi1gkkeyY+91PR0TFCwNl90ZMDr/oeo
 vKJiAaQBodcl5uboH/yDHL/cKEzCK0GOwGXmy31Ih1F1h8rSZWTH/MGxzg46BQj5P5aF5LlBC2p
 b/VV7s8cq4d6juRuQLbr2Wx+oVeZwCxRgZRRW8lkMLPA5GCtE1evQWtjSCrmKFse97vMJXG2l0F
 9m8hAccs98rBJ8yMQ0KuSFzj8jYIiP4xu0cNTxnXLPZ8Z8Ye75zAzxUiBYBHSgX+ohgIoVkuAl1
 xgRoWd4EB5P6J/yXyOKCm6BEuLViICUs8SI4gP/5xaq1LFtA5ORUc/01XcP+V2D0TDtun8oYVIb
 /h+YBalGmtRBvwdR27ZJ9Jh7phjJAOC1MJc8uLIfAHzj1AehH1MfuQJ7vM+sZAs7zIIwzcy2o6S
 WEa+9RKN4kU0ys/M28U7KJypE=
X-Received: by 2002:a05:600c:8b71:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-483a95dd932mr192661685e9.17.1771948405899; 
 Tue, 24 Feb 2026 07:53:25 -0800 (PST)
Received: from localhost ([2a01:e0a:e9e:c3d0:7a5b:f76a:6cf6:aac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd765604sm5827415e9.15.2026.02.24.07.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:53:25 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/3] block/curl: fix concurrent completion handling
Date: Tue, 24 Feb 2026 16:51:29 +0100
Message-ID: <20260224155314.1658988-2-adamhet@scaleway.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224155314.1658988-1-adamhet@scaleway.com>
References: <20260224155314.1658988-1-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x32a.google.com
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

curl_multi_check_completion would bail upon the first completed
transfer even if more completion messages were available thus leaving
some in flight IOs stuck.

Rework a bit the loop to make the iterations clearer and drop the breaks.

The original hang can be somewhat reproduced with the following command:

$ qemu-img convert -p -m 16 -O qcow2 -c --image-opts \
  'file.driver=https,file.url=https://scaleway.testdebit.info/10G.iso,file.readahead=1M' \
  /tmp/test.qcow2

Fixes: 1f2cead32443 ("curl: Ensure all informationals are checked for completion")
Cc: qemu-stable@nongnu.org
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/curl.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 4e77c93b46e6..6dccf002564e 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -324,17 +324,11 @@ curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len, CURLAIOCB *acb)
 static void curl_multi_check_completion(BDRVCURLState *s)
 {
     int msgs_in_queue;
+    CURLMsg *msg;
 
     /* Try to find done transfers, so we can free the easy
      * handle again. */
-    for (;;) {
-        CURLMsg *msg;
-        msg = curl_multi_info_read(s->multi, &msgs_in_queue);
-
-        /* Quit when there are no more completions */
-        if (!msg)
-            break;
-
+    while ((msg = curl_multi_info_read(s->multi, &msgs_in_queue))) {
         if (msg->msg == CURLMSG_DONE) {
             int i;
             CURLState *state = NULL;
@@ -397,7 +391,6 @@ static void curl_multi_check_completion(BDRVCURLState *s)
             }
 
             curl_clean_state(state);
-            break;
         }
     }
 }
-- 
2.53.0


