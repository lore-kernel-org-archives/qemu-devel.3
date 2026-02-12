Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6E5EE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZYT-0001Z4-5K; Thu, 12 Feb 2026 11:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vqZY9-0001Pb-3t
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:28:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vqZY5-0007jN-Qa
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:28:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-481188b7760so299295e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1770913688; x=1771518488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7WdD2zHkBagt+yCXYN+euTN8kOLoPQP3BR3Isyndvk=;
 b=R8zw03sH7C+rHDXJo22KP+vXFQOZls9Ntkd8iL4V/lSYoJXUJBJdD46snXO+m/mm4b
 lvlpeSEgWQR6PidhVzvtJz49yZHNsh5iSChQOiBxGrXKtC+SJgzx/8xLl9oUVB1eidRC
 +8ciufWIS1QoLBD09XGTc2FOPRvS7ul76sb46fDZNxMwfZalpI7K2HPu5myAd6VpsEqM
 clSdnUPf0ZHNFAn8Merocy+o/MXLo9G67DWsVPy7kUju1G2CItpDsblmgnoMafcZR8ts
 8VmJdIt4mARN8h5/3WyZmi022WxnuC1k95txYSVpoeNwjA217dCluwtdkIGuqEfbZMLS
 cbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913688; x=1771518488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l7WdD2zHkBagt+yCXYN+euTN8kOLoPQP3BR3Isyndvk=;
 b=fJ99Lqxud/NTq6I0YGOe1eLCtfaCr38Qh3eVnSyhNKgUzdk1MiMrHsatOktoWL3lkD
 XWx/3Q1N6yKftCv+AGzEqQQJfbx/WJ5PsmLRMjM43w5bW+xkz4rnz/lR7mMEqeT2NAul
 NeEdBwvNno2RDyPJQbLrd9v8mrWI5fiODDzBzmDT45szOSjsAgFoH1NX7xOElVrp0Zwg
 EcEkegGeRcCGtmnf3+CObo02dt1XeozNeNWut5a2nmIuBNKKaCH+dQt0E8/eBASJfBng
 FbmNFi2AJqTQEQEitxVjQ77Q0z+8Hm5jqKWLVOcph0jspGvTrLU5wW3y9flSMMVv7ZYY
 CODQ==
X-Gm-Message-State: AOJu0YwwuG9+v7ksTmFyN9p+BNKfqacPBtixTst/qP282wNYGSyd8vMm
 p8FU+lLroLFGvrm69vYg22Qtz+DI+45+LQZKKUWDkeVLH7/u2493UMA+Ihfq734iQwm0rffKv3+
 ylfeT
X-Gm-Gg: AZuq6aKW2k/pu8xTqZ5TpuD6h0z3Rkr4a6ZACfjhnpVAPJ5qeS53RFMi2U0VyTk4QuZ
 KKn0sRUrOggwWIWNfrzfF2sO3KeKi6IbTq1IEMefe5hUZ55hXYFIAea1cwTcIiB/BoMqO9oNkXr
 StgyHoOYB0uc2mY1xCFGf9VG+cHOHn0XoD3HuhXqNmsXG7MY36shCmMsZM8zlPY0XGkkceH9Q0B
 qM8qdEzz6FBvIdbiYb70LdeEB5lG1uAM80iRJR1L0hRsIA2XaPjkuV3vTvcJXfCF0y2Ci4PbqVD
 NsX1PDB40ZhyurWNVbeZL8UKkDne5+1Yu0kigMnrD0R5HLwfghfJQkA+4NaWjVAW5aQ6uyP8zZA
 uawVBCI0S0WrtbN/Y1hK2FqZdepaNdoqwj2MBlOHpRv+y63Rdk9Z+X2BRrf5r7zM6mItiQNwOVg
 y3Xp4GrDNnudwK62Rg/yYduZmAldgKa/AqKJ1iDMByTx/NnTG3
X-Received: by 2002:a05:600c:354c:b0:480:3230:6c89 with SMTP id
 5b1f17b1804b1-483656c8246mr51006065e9.12.1770913687845; 
 Thu, 12 Feb 2026 08:28:07 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836131d484sm33198425e9.27.2026.02.12.08.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 08:28:07 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] block/curl: fix concurrent completion handling
Date: Thu, 12 Feb 2026 17:27:24 +0100
Message-ID: <20260212162730.440855-2-adamhet@scaleway.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212162730.440855-1-adamhet@scaleway.com>
References: <20260212162730.440855-1-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x32e.google.com
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


