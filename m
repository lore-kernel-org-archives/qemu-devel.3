Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB9CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy8-000482-Tm; Fri, 15 May 2026 17:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxy-0003AT-QH
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:07 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxx-0003CT-Ay
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:06 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dea20cf21aso363765a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880064; x=1779484864;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=402MI+eMAC2JN+aTXLkZ84wCkhgwaRFbSZi0tBBQDsQ=;
 b=ma/45IM1TgM8WMhRUyihsTgVjnCMSDTXYCBQ3FQ/V7hysxCS8GdZr/pczm/8ic0VNz
 5cK0k9GP1CGka7DkKwZuGjcMmp0owkADdxEf6lRQbxjC/jvCrM6vs6TKdUqy2OObWNcv
 mC8jNUkqVb+fnGkt1V5hITvf7G6R44qZrNDp0msdT/8w94UsP7ufBM3XvFuHRaHuQU8Q
 hq33ebbnj5gJ3a8wVl9YzwTQiT+0Htnck3bkMJ1TFa7npWVyJ58qSQ4WC4dOOpvN12BE
 thQxgmZxZqPWDjuJ969ct9LukwgWrWS0YwA0DwiY+QrW418N6lWC9sDQM1GfDrxOjjBc
 vAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880064; x=1779484864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=402MI+eMAC2JN+aTXLkZ84wCkhgwaRFbSZi0tBBQDsQ=;
 b=YpLfAVlf7o+329UVAKcv232haJy2gNd3XUf6OnUR4rvMAeBoTDq0tyBSoioB/IBiio
 xr4t5wEv+KGk8sWQKX8NPqLKYQRo7Etps9ZbYxyqvASLnAkyBODRVyWQITITElawHva/
 RQoGidmelfZEA6oHtnhFILG8oCRsysWsXAuOBPbpWWklaIhBPt1GGjxjXgn7Yzb3yLzk
 Xya5Jchs1hHWaGi/BQsS7tATmuhth7jdeqzeEXwlKpg4laV5tNtnHMMUEtHy5X7Lm5Fz
 onE5GB1cwgY7bLwH6mnMaxxmYWSRLkA98UIfLNHNG56OGfNuPJDyilzD6Do/3djrFPNb
 i+eQ==
X-Gm-Message-State: AOJu0YxCgvQWDBQfyAV/LJHMGIsr4ysui5W3jFgvswSEBxXDbW1OIaCz
 bKCuDP+wdg8ONPleqenb342n3LWM+bjkx2y5ukgzZNy/8/vgR2Q2nta2ksT4LOOS8pSpIgjhkzB
 lE45KblM=
X-Gm-Gg: Acq92OEfO7Kq7a+xyzIlDX3ybHdWMTLZnFOl3pdhNXUJ0s3sAlyo+wQPTPIzjQqxyNQ
 XkBihZJHUHMlxTygAC6v2/wh/jGRooXeERoRmkLuAIJsdF8jdkqzTMYgYcbVdQNd6cl6Dc0L9n2
 neCMs8jxw9wZUZejlCJOygSfL/MgP7A/K/lwX4H0BvnEdPymKJevWvnb7dVFA76+GHOVRVOriFt
 bXC1rawkS3IPWQcin1wfblZmP3IeP3LGZ1E/psRDAdcUlPvHuzeIJdLCEm5QjQMmofLGBL15pyc
 jveWDE/DdVuEQDbSKejyfQzASAx/MdzKy57kiDocYfO2RyO3aqPfEXPYBk9z199bb2JU+/RXGOO
 YZnlvCpvjyzUsxd3jiQlY+wRXEcGrhm7ZGsiD/yjDPJDtD+McBBxdUBdtaqGGLgqRkwd8tkxbom
 1zPg2vsRqVJg==
X-Received: by 2002:a05:6830:4128:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7e4f2b6f1f6mr4036431a34.21.1778880063891; 
 Fri, 15 May 2026 14:21:03 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:03 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:58 -0600
Subject: [PATCH 59/66] bsd-user: unlock the start of the cmsg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-59-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=iHTiAs0eo+GfPoYHIYv7+/2ntDeMJMG9gZW+S3lWJyI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43ozZyN/xMUaYHas5P9yaMfCyh4kUULClrIm
 kRyvYmB9j2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 AIXKD/93FdpOPo1nROZqPraVZ/rpIQDsup2MEYtEYPd/UzK2le5hGSu1iN/YsCifqOtYYXpPyO4
 wCeZ0DOz7rXOxNCPWdH3xflM94D506NbRuF0S2T4MxSo63tKAlvle8nP8vcY4LFZNZI2IqAHNZQ
 2mgnWumAs/IWA6vhDwAHo6nY0Yp78ryzkGuTorltSQ2Xh1ZIFPQItMRbR3iLnTD+pX/x8rFeZNN
 XcfwUdt8g/khc8iqMhhhFE/Rs+NRWfODPO5LvdbzVUNZrLneDgtEfozbKHseS/JqvG1o7pBEi7z
 OdMelYrok8IORm4E57lPpQOujuM1yjznwdztBercD8rpXUw3Q9udGoQ26ijv80bGGLUU2Kkf1X7
 P0av2+qAF1bdq4+JmascbPA2uvKgAHcjJCd9bgjqhmcG5ZzUBy54xORkO0Cu9KEgJDHt34kBmUj
 d1FG46rlKNIBkjsVowPzrOBwWuykfoMQ9EG+RD3QQmhPTxjBjxQC+aBXaCd+MMrlXYPBKSk7b7V
 Qhh8QqW84QmczeC/YQEgIQ0AtaWAHD4hEQBveLR2+D+/WkGUYd1TumpXZBvW29lJAbSqAs7mt1u
 mus910BvEnxQ02zNj6knEYAvE4gX7DEaEBFWmFPP9MCFci7c5qkBvcnIwFmg08pT2W/AiGaT3jt
 GT3O4oDfRPIh3kQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We move target_cmsg, but save target_cmsg_start as the beginning
point. We need to unlock that, not the moved pointer.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket.c
index 968929c2fd..8eb728240d 100644
--- a/bsd-user/freebsd/os-socket.c
+++ b/bsd-user/freebsd/os-socket.c
@@ -91,7 +91,7 @@ abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
         target_cmsg = TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
                                          target_cmsg_start);
     }
-    unlock_user(target_cmsg, target_cmsg_addr, 0);
+    unlock_user(target_cmsg_start, target_cmsg_addr, 0);
 the_end:
     msgh->msg_controllen = space;
     return 0;
@@ -227,9 +227,8 @@ abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
         target_cmsg = TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
                                          target_cmsg_start);
     }
-    unlock_user(target_cmsg, target_cmsg_addr, space);
+    unlock_user(target_cmsg_start, target_cmsg_addr, space);
 the_end:
     target_msgh->msg_controllen = tswap32(space);
     return 0;
 }
-

-- 
2.52.0


