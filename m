Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC17CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy1-0003AS-OR; Fri, 15 May 2026 17:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxi-0002tx-PI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:52 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxh-00038u-3y
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:50 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so159590a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880048; x=1779484848;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AHuj+qCYqadp/YGZmDto4OnuQZ9s2XweTIlNAkwUkxQ=;
 b=FrdHX/XLE2bt5Oij06baw+c6o3su5AXb1rO4q5H+mlx/X3T+zKSVzEP6oBIFUaZYwt
 WY9oMh1l26xeubG58k3JClxP2+IDMG2Ib8VvGvFftMaIcxV9sXQ8IPTePV9EvSNZiwUH
 QCvbKa8iDrhJTIWFjaeZ8J9Yp3kjGXrX4yU4979tmBi5LVlnDYkUfw2rqEAN9tSwYc5v
 WDEb705eCssKumPJirJBivvSeNRDh6DZ5KOShJWigQtQhxovziSQwr6PieCfNVtKmg0m
 Z0SJV4lRqY4b2FxqAc3dapLSmqOOhG7Zkbv4FSPI7Vxbm3TP0IG5x7MTUoL/8lS+KAKn
 Zpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880048; x=1779484848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AHuj+qCYqadp/YGZmDto4OnuQZ9s2XweTIlNAkwUkxQ=;
 b=cYywstts5QBpYbrPUJLXXhIzntr7sLVBX3WVHycfUObyL+qWvJtu+Qz2KchWqC9Amh
 F4qybyJfthBH0ipQ/Vn5iXyasNa157rWgyXU5T/gBBw8w/DpGMjatPbZVgxxqK9POQA+
 SO28GQ/e/Jf0rKn3CQSSUGjAnyVW7MI7G73XeU00Cd29JyrSxdAKCKxULPW6IkS1vorG
 xXpOgv7zNk5o+KRWgNee9T+tU/8sL5/xVxrlHlvFbh6P4kV2J/n5dtWkKCgVMQAMaH4e
 IDrJJ8hm8kyzhX/vcALQ8d4UrnxeH8HM7LqrdKfFRRnZBi1GYvGw8XoRqLgintgn2CLC
 bAEA==
X-Gm-Message-State: AOJu0Yy06vbwHzZAh+Be1ptdP7M6wzUiCafgY7uJEn1PqQmbS3k5AMwc
 8wDC8ortHELkF2B3C891cho/M127BazjOam03Ob0i5dCNPu/GAzLqM+PyNSyLU2dnQ8oZyvezcm
 yGEvmeM4=
X-Gm-Gg: Acq92OEfUyPj0cFJmlVL2EunB34bjAgHYldUhkqrDj2UFLaffGyvbBGE1mQxeE9Nqg+
 a66xz52+Ouw4HWoGYYGAZdQvqF29aRIMsI70OjhDeuQagO/Kf7ZxSm/aMY9rOR9gcQQ5p+vk/NK
 kciGKvGStFCOXfmMTUuJl9un9nXZPYwHHdVyvfhdHuuAWzGD98dekRYdS2hCffEAVgMuzmvqxZB
 xH9YVmIwRW06M51dVjZXkweX2nO43j/F/QJz9P4d7ZpLPvnx1HCUsSb26fbPaFowPSkZDASh5ok
 En8kDWqPmhp+UgKjTQ+oI6YFy8tW1OlnZoU9OQ+j+JCi0mB3Xp9wpOuDOx45q3nn53u0fNX/xfV
 qqxlepFeyZTAFq3rFfOB4GPh4j1CYLP3jPTVDSxYPHEir7sMjcyS8KhXAIuwYFj9Ys9hO9Ym92g
 brvXy/b6Y24Q==
X-Received: by 2002:a05:6830:710e:b0:7e1:90a:97c2 with SMTP id
 46e09a7af769-7e4fa0a3502mr3884746a34.23.1778880047754; 
 Fri, 15 May 2026 14:20:47 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:43 -0600
Subject: [PATCH 44/66] bsd-user: do_freebsd__acl_aclcheck_file pass type to
 __acl_aclcheck_file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-44-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=843; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=N75KZU3MHRQqN3yIHwU+t1Zd5+ya99JKhq/+3G3/YJQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43ms9rIuQx3EOyF7JKhPXCkGedMHBtzqLZKk
 4aZIa/ntm2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AJjHD/9W1UpEFoYFTdRD9TXFukPq87ylMoprqa8yIHPtd9fftYo2J+ERDMiPKP/kGw9P+M8HUsi
 3ijclRIGbZrajAXRHJfevnLJpXQ06z3JMiFmTY7f4RvuHeelOz7WZMh6Ut8R0VAjkJiLFdC6T5p
 DVbxHZrHEEL6NgmdOIbQX2qwoT5JlyaJ4AdSEkxsY0ea3UC6UgpAJpGOy31bXJMvkWCBjmfrXv9
 I79Y/SoqdYMp+kbVevMeql2ISsP+ze+u8CrfwLaqAWCT1YlNG2NUKDyQCQ14qNTOmt7DkereVfG
 xMOh7jDcdkJ8o+IPx0+i7W9cQ9bYt32G0rVb4lfK3nqJCPW++Di0mUMqCjZkHtGoAp+4P6FxEU1
 X9QaXDcXKyMLafYCdJATiwPmxczi3Y+qoAA4dbDg7/g3qUu0VUecn103QDxtCil5yd7oWLQlGxI
 s738uQg+70QPXiMMGSVkvVrkh7Zo4zuMRfM4TbIn+bQY9xZSkXwM2zLlX+CtjmgjmIsY1LuT9hl
 QgKsJ5Hkwob/0xC5IpEZEleJPp9wS1yXCjzbVXFj5GoomNSL6plvOMN7MjVJCytEgY/VJjRXd8I
 BrMU3sgktILtZ7rSAyhSBT2NfOcy123qOklsxM7ltPMepZYNsYxQD2y90zU+AR2Z1viNQtQgfJE
 nvChY7bMuL8EkcA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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

We convert arg2 to the right type, but then pass arg2. This a logical
error only, since target and host types are encoded identically.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index 70446f9a54..0414a2e479 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -413,7 +413,7 @@ static inline abi_long do_freebsd__acl_aclcheck_file(abi_ulong arg1,
     }
     ret = t2h_freebsd_acl(&host_acl, arg3);
     if (!is_error(ret)) {
-        ret = get_errno(__acl_aclcheck_file(path(p) , arg2, &host_acl));
+        ret = get_errno(__acl_aclcheck_file(path(p), type, &host_acl));
     }
     unlock_user(p, arg1, 0);
 

-- 
2.52.0


