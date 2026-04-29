Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50485FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6CE-00054c-SF; Wed, 29 Apr 2026 10:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C4-0004lG-Dc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:16 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C2-0004er-Em
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:15 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so6230169a34.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474031; x=1778078831;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ydItN197xR3dfX4ljekOGS/5kkStQ6bZhyq8u2u6ke0=;
 b=qEr2Kljt671d6a9qeWdETxq34XXCdhnOYnLhkl/0lEfq3b0gSP4ZpSshjc7T8oGrCd
 mylslD8As4qnqRS9uljXhLJQf7DP02xT9kMwPp06TxS/nSWINZ1xzo+3GVGQ8kIj9rTF
 exjSR82y3DxLAQeUUDcFc1ztzmwmRe3+ZmptwoCvW6hoFVjTfXUy5ZUxDUscfrK8/XKy
 2nhbXOJMiZBfbvf2I+qSRo5w4y2taA0+yShzceCxwsmNw391vN1UpDRNZQMAsLhNgJix
 LVx7hoIOBtOWIzDx3FTaQxxFxWKRn01ULXKCgzfDaZnsNtmLJ9qhgrYLzADowKl6uLE7
 e+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474031; x=1778078831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ydItN197xR3dfX4ljekOGS/5kkStQ6bZhyq8u2u6ke0=;
 b=tUHSpFF8iNIXPW4hBKAw/buSpboLnBIJ8lqA59UtX9Fxwmb53ht8BdHy2Xi3UWgP7+
 Bda6M7PzJZ6dQ9aUBvqmeKhTEK5SQ/4bdDZR1cWC6OLXuCKC1///MZGw979f0ORB9+eI
 HPM8xFowHdb/eoDBoXy0cuRjCM8Uwe5vWKl52N46JlL7HAcBhhoBKIoryKiPCtTyZc+5
 +iahxvDWb6EmaFvHw6jfWgtUgpSswuTR1N6ex26CoOD6snGmKJvx4DDpnsRECGYslQqb
 FVCcwSIyCo6MqqAVRanEM7N98CmxyeRbCjD56xqwzYza0MR1OWoeoUE5sm+pT58MafWk
 Sd7Q==
X-Gm-Message-State: AOJu0YxFDhxDWGld5z5vWkCau1kXGQ9hCtbA8KaG30SVTkALfBSa2FRE
 SziujlluykRG69lKfX8IIAyG9vL//Sj60TNCtDlVxrsqeLE7MuJ8jfEchTDLQWOOu3o=
X-Gm-Gg: AeBDieu2u5ML1XSg22QeRyDALqnsqyZGDwsQW8GlHfUXTLrnKtehiVUhDAj74DLRFZ6
 fPPW8kIJZlADhZQFo/C2Qe3Nsmtaz/GayhXp32CM/QdayWMi/ixZNSFH1B3gCM/7EAIEEdttuTy
 9PZWm/OKfCjueCbtWqOQCHae7afCZLCDqqmifjxVLw/v/VWFvNvsBdOYMPx1xbHurlkR0YgX48Y
 ygJ6YWEikjpYOgfsS9epkRh67OnHeLWy+ZiqhaPuIKTSAhg+wixsDQVJ5tkn2GNKPKsLongmdWC
 0c0rPD3J0y74HP+qR6hRQjUVy/WgBzZhNsHDZKwtwF/Cha2GdoJ+BD7ZcBvDxlwm6dzOyTL2d4D
 q6ak/ZN+pYAoAsPoBTZeVubSsz643/GoAiqMmndzdCQ6oSkwDGFzvRYM7L+4ikybWucl/5a46cG
 EV8uHztf8jwqi9hNsb2403
X-Received: by 2002:a05:6820:2219:b0:694:984c:1a7a with SMTP id
 006d021491bc7-6965ca4d56cmr3726905eaf.10.1777474025613; 
 Wed, 29 Apr 2026 07:47:05 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:19 -0600
Subject: [PATCH v2 13/17] bsd-user: Add do_ioctl_unsupported function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-13-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=z3kSXcpgHWSbT8rO0VakkW+JCopL97J9zLmtTQWWN9s=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl9fWobJVTjCLnEpntYHONeQ+supMyuuPkM4
 yEvMdwW7fKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfQAKCRBsHNEofbAR
 AGQOEADJlUse7gewwgZjHVjE3sdSIA+qOqYGY+gVk2otoINMjAkWs0poAFl49kpmXyyIQ5GZfDK
 Lk2xL2l+44D1a028pKUaep2T+XU3Sic2xGFelvqvuiD7JIlE/vFqRl33Ca6fsCEPxyDkRsO/B3v
 Cu14gg+ngIYXEPbexaucV2cL4LmdXriw0IJETnqwzUP4ZWyJ+zff2j0k3poLA5erXwf22JxdGr4
 MFZ7UwHcoH++JeItZ5IUNdlCHdNvry2b4EqOkmBCZFu24DnD0fC7cBDyK+SxDgi1jF/YStX3kMG
 FUql/S2rKgq1+m3VvitTSYG0HCRKmWhJbtIcoEfsdoVyo/SNAN/PIGngz+J+OwK3HBLmKLv6BJf
 3sz3zEjFy45rtRSGRgaLZ1mew7oijQolzQUXcJLJyZIrW9/UXx+xAHQLAPQ4CxZxV7DTKAeBQAI
 TLfnUylgDVt78FOYvA8Hkt8DGPKrUjSeQmd4AHMcanulwnNK5xIbZEBrSDPJjvzjcaXBZbZFsan
 yTLsBgq6oRJ3fKXDXNMGwdQyTS5a4Xz00eR4b+vcWsV2qhZhv3M4j7gkPyPhuYwJI/3i2cCfmCJ
 1M6Wcf0rt8aMaPsoSzDLPtwhutxgM7jeZgPAhRy3DcHw7daUPjSh4yfbI29n2qtLiCo3qHeg4JK
 FJpDwlbw7jdCu+g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

Add handler function for unsupported ioctl commands that returns
TARGET_ENXIO.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 049188e5e1..41f310c734 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -243,3 +243,11 @@ static void log_unsupported_ioctl(unsigned long cmd)
     gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
              IOCPARM_LEN(cmd));
 }
+
+static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
+                                     __unused uint8_t *buf_temp,
+                                     __unused int fd, __unused abi_long cmd,
+                                     __unused abi_long arg)
+{
+    return -TARGET_ENXIO;
+}

-- 
2.52.0


