Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ED4FEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxFV-00072t-Ua; Fri, 27 Feb 2026 07:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxF9-0006t3-4r
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:55 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxF4-0001eZ-NT
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:54 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso16306205e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 04:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1772196407; x=1772801207; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=snnOG+Kv8JUJbX9gCRA+PikPotaKeAEz7HPG/ojeglk=;
 b=TxmnQIqMErdub7CKfVVqyB+5Njj8VkrqldpwOEmzN2OiyD4OBJLx4LalGtx1fiyvqI
 ADdAulUvk7As0wZr4YIKZE+j7tf776SblFJ5sQkiVMRlW2FNZ44G3qGNsCjDVQO746vK
 pL3xJO+IWtLRAnDNyMv1QNtKytbbA9GXzPhmH0q61yGVs2mtSahbeyW0AhxQ53tGM/f/
 yhvzQtPdqvSnCfkonJ4ovQmlrTPXViy+9rmYpqaQACWDg+Ahg0cq+bF7Ro7ZIh0bjKsu
 qv46C7ROT5ydYHCIuGohbdwhGtJd6QWObBfT+2LCYzDxxSiUlnNkgmdR+uq+1Sh0oHM7
 Wtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772196407; x=1772801207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=snnOG+Kv8JUJbX9gCRA+PikPotaKeAEz7HPG/ojeglk=;
 b=GCyQ7ocCXoA57YbE1q7Np4L2JRDoLk7i0T111PXP/bgEQt6TVKXCZuRa5QQwh7JppT
 okIjz7hUC6SMAqPg59vHDdPId0dn4tgbzc7Juh13iwb08ShHJYGKhItAIwWpUkxJP+YX
 CjI3RneIMPexz4GtQ8MHJOdhxMuXIDOD9U0Q+KkwgIROW1sv14DNHgLoFDsrp05aeWGa
 6hFJGdBBvx5tApoehhpPWlIUeFhTpBBc9B9xLQF/gNgtExH84pAfIt7wqvHsk+Bq+Bok
 t1eq5DN+e0CWsXb/405G5T3ahLqMZEgYGGi4OLxB80x6P00nQnyMe0lE6SzB1Jh0AlLu
 xrQg==
X-Gm-Message-State: AOJu0YyhmwZc7xfvU6p4uuuGxaIzNUKfzalM+QfINSwQqzyHus28Y6nF
 jSs65c4J3TfPHqBPMeSDOYfkIJwMQnEHazHMtPKTEcQyH/tAhF/aNkiHljg61CsVrQx/MJvUZ7w
 tIl5g
X-Gm-Gg: ATEYQzwuNsb9PxK06v9D0gX3Hw2CIAL+lI5zr5DNOkQWRq2nwPus2u8cmWTZNZn4iAs
 XCMEDORFti3L/m87/euMDwXHvU0ngkP+cwxPDKFCqI2+D8JwsgsJNjDMjOylG1SlDOcpxcH/oBJ
 /vhFSfGSlzKzSG2Dimr5slfwGq6uvVCxOW+elQkPbxFHA3NYF43s40yK4cYVt4dsbMQrD5CLZcX
 BVIdAcSDiPnr/c/8ZFBcWyzq0naGCPTsHNrbxyoujbmFnzXGn89YRsbr7hHe52xeiaaxKAeYRPD
 xm8t5a72mprJmsdJSlc/coqte2ybAHaFSsW3iF1/yOZQ7DyxqYS84P1S6bwmMENRRPGa5t/FErq
 kzU4l59zAzKwXfqh+n3Vl/WLw9mCJdKxtNDWCfFN5ADcV2wCFxjpiqw2/HI4mr4zlG4fY+SNSHl
 o3BX/ivCRrzaWOsU7vWVs9Jglgh2idFMNKtFl7HmABw7EWiuYe
X-Received: by 2002:a05:600c:4fc8:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-483c9beaca0mr47095325e9.19.1772196406609; 
 Fri, 27 Feb 2026 04:46:46 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccff00sm61962215e9.25.2026.02.27.04.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 04:46:46 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
Date: Fri, 27 Feb 2026 13:45:51 +0100
Subject: [PATCH v3 1/3] block/curl: fix concurrent completion handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-fix-curl-v3-v3-1-eb8a4d88feef@scaleway.com>
References: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
In-Reply-To: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-stable@nongnu.org, 
 Antoine Damhet <adamhet@scaleway.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=adamhet@scaleway.com; 
 h=from:subject:message-id;
 bh=0BKn07VDgAZvORo+jFUCQ3gue1nBEaPUdvRcvK5Z3tc=; 
 b=owEBbQGS/pANAwAKAdwJoy885Y8+AcsmYgBpoZIsJAkOPtugoIRekjN8OBEbuPw38hluIhNwv
 nagoKS2GtqJATMEAAEKAB0WIQQCubVZtDHYaY6x8XzcCaMvPOWPPgUCaaGSLAAKCRDcCaMvPOWP
 PtvRCACgCRpHHKsDt/E5lznSfG5YnQtX9nSX/W9LZSIEbDx8whODkeCPSshj3kqlwwuJC+KtYZZ
 UPYDzgP3Y8njsgxYYEQdWYlfnvduD93/qR7mjkWX4Qd0ARleVsEmHotfGP+sbuRVGIJImA2m5fw
 rRa2owwoQdZsb8PVZ7kqVCjOqMXaO6STMi981mNGBDwRopgqYWb00su4nhIwOQHGa0obv/Aa/yu
 1n92jHectRkynRv8ECUUIcuGBw/9z36PLjzE8XQkeB8ye4d002NJVrVUZpky2WOXimucugrLAWz
 6J9vxDBKqPUjMcyxRNy69rbvV1HGmj5hJ8zdtdSjnUUtppfv
X-Developer-Key: i=adamhet@scaleway.com; a=openpgp;
 fpr=4C3AEF45D70C65052D3F37E02A5F5236CFB70DEC
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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


