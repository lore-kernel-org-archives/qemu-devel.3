Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C862CD4F46
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy4-0003bQ-UC; Fri, 15 May 2026 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxo-0002wU-2V
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:59 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxl-00039f-O6
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:54 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479fc1fc048so332317b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880051; x=1779484851;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tYvRaepDtsbFXwl9GsgUjxQ80JPHa+QR0l1FXg4rYR0=;
 b=AxOQPcscFBu71QXKmbv6YOtE3kvsqMrsUnJx11cKEujCqa9G+OuhD5O1b7C7H/20CW
 +6x49/HfH8EOzZ7c7UHkPeZMGIwtLKPbuTPXJukgqGAdNs/u3mqOHMowfk45kSpoqrc0
 3+KXqGMqaknxI0bM6Hc+4yA89B5AMWXQu5WN6QUnLqk0UwWCujAR3yMaz14P6sTVIFZ8
 YZ/VqQyDO3BTX3PGIylmkYG3Od5rP3QECMiXvjfDGVALXnNXR3dJhxqa8c/ZZlQ6q8FC
 JeyaViBxxQP6WEZ7ZbISu/nCW+fI1Z+O9zItt4HIYUnCkJQozrgjCMc15U6U+x4f6gJ3
 1WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880051; x=1779484851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tYvRaepDtsbFXwl9GsgUjxQ80JPHa+QR0l1FXg4rYR0=;
 b=WziESFkrr27x24eHfL2Nt5WNBAi2xvz+fycCtNBZjSSTOQrBSgmWxGmCrXGqS5JUAr
 aTosgore2C3Ex37gaiZAbhd7QT42TkevVa6Ve7Rg2gf2auZ1J6K4RKjMJibvUAVeiYB+
 yj/CuQtf1oeQlncdzdYK1t4yYfjUPl/hvWSWm8AEcRu7set1ZWzT1t0fzXUzOJQs+3Ci
 PnrxGhJtF2xljdf/q7UN9W8zkSOzkLEcRF71jXoCvVfM4Knui96MzWSdq0HGDJYJF0Lm
 VlgXbzvpESepoe71Z+G5dXZIQM4VfWiJxraznerAXk9FvAkCuY4upMY3ryQZOAOTqMbK
 MVkA==
X-Gm-Message-State: AOJu0YyNY+2HYGK5TDQAKknnvcV3qypsGzijoE+T2De+LEwxvqW2Z8m8
 P0fkhgPF6Ry8UzBj/iw6z1XeR2S9RV8RStDPk0/kZqrl8AkMcO95bw57PLqcxOjxPnZmZmil4Fm
 IGbSIKSU=
X-Gm-Gg: Acq92OFrWsXkeQut3zDRJudPHF3JK9YYBpmkaNBf+sQbrrh1LX4xzyJ8zj9YRwZ77xm
 8xNKHmrzec8OmrvXTxiN2iuT+LL23fAQe019pQxbV0LZ7VFB2uGd7qD2cS9XDIeLwdftj8GGWkZ
 9ZRauDDSo7UZJSpKjAOPj3nWgGJkkvHop//2YMYAKZkrs7PC50mO6/BI16AMVrUMpRrAhTGFlqg
 Xjyx6nr+LMlu3Tmd8mmMMVjkYTp82oT60jv3uWiETqUaLrWQTwXfrHqj2VlPPnwWRGkl/ldsaWv
 uIJdTGfrbA2loHZ6zYHpVm3tk52kkPN0S+2jS7lo7K3iCNzfmYO9wpb+mNInSbd4KI+QCyR8vl8
 v8Rz/6OKnkLrVgbnfvLgWqomwCbiz4VA0s+2LFLVXJUmbNMSRCbsdRBW+/7fxabyDGmrYyoHoXs
 HoB/szrd1yVSfUCMSJWmmw
X-Received: by 2002:a05:6808:c195:b0:47c:be49:cf74 with SMTP id
 5614622812f47-482e572ca95mr3757763b6e.23.1778880051256; 
 Fri, 15 May 2026 14:20:51 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:46 -0600
Subject: [PATCH 47/66] bsd-user: In do_freebsd_thr_new, use unlock_user_struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-47-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9UHRe9EHyra8Hq58p66IxlYqg5jJrk8hXeWirOuHoEk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43mj+NE6Agv5n0YnbGyjL5EeLkTB6+2xRTE8
 XX/MsO7Y7GJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AFU+D/9ZSjSXgGRo4BxMZ1ntPideccaRFrT12zg/0Db6PNtrF1ITD5BePsh6gPZrI8I7dQCiM9E
 7gbWQKopmUEhA22rh7sq4CggHPHFe7dpEmdzr7ruIPrMdqBdnqltm0tTW7eXQFWOXXxBgG4jqrL
 cJY648FIVRXkr8KySDuoUpENR24Ux+nnA0DBUkLVuOGWX6OSdKtj/RcuPzceV9pPHhGOZexCqXN
 hHoLLiCTpQcFK3BAnoJKkJ2pkg6O3mfwAIuM+aEvKmstOmChAuGydeImQZql9UvaO+LLwyf2LBv
 kfxIOVyDsR5qP735a9y8Uil6CpnsbYqby4padFEjcWGs9AjNHuXcS58SjMn/AFF0QUE1iWjX4Ft
 NAr+vQO3gQm9k/sj0VHOfGGe70ZFInjmfqFWNLoHEgJf7D2S5QJTgte1mWChDpbEqHwi4A+SFQV
 DCyl9rWUmXRrUyZKvVuImOxtGOPegLVU+LCB5GkS8kzf+YOywE71SHlALMp8MKKeS07fqa+Zq9y
 JvncpIntDAKs0+EBvgWjcOn7VoycOnyGxEOou6J6EiFlZY2B0zPC7nU2DztX6eBGCzcxXqeWVV7
 DQP4hc4m1GsAt260unl1SNH9++rzvvwMXtWJIaljYZ3GvH2dmiydukbz2h1RiiZb1UWsa1Tyr/Y
 4S++LuDTlOZaD5g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22e.google.com
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

Since these were locked with lock_user_struct, unlock them with
unlock_user_struct.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 7c3256a87e..f90f13076f 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1567,7 +1567,7 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
     info.param.parent_tid = tswapal(target_param->parent_tid);
     info.param.flags = tswap32(target_param->flags);
     target_rtp_addr = info.param.rtp = tswapal(target_param->rtp);
-    unlock_user(target_param, target_param_addr, 0);
+    unlock_user_struct(target_param, target_param_addr, 0);
 
     thr_self(&info.parent_tid);
 
@@ -1577,7 +1577,7 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
         }
         rtp.type = tswap16(target_rtp->type);
         rtp.prio = tswap16(target_rtp->prio);
-        unlock_user(target_rtp, target_rtp_addr, 0);
+        unlock_user_struct(target_rtp, target_rtp_addr, 0);
         rtp_ptr = &rtp;
     } else {
         rtp_ptr = NULL;

-- 
2.52.0


