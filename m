Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D1DCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy7-0003sb-8c; Fri, 15 May 2026 17:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxj-0002uW-RR
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:52 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxi-00039A-8a
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:51 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e55b95ba13so176021a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880049; x=1779484849;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UKtDoegR296hWUFPVeKD3N8X+wZ1+wnI2qTMFP6ZpMM=;
 b=YwEo7LxcGr+DQar7szVN1Xt+o3ncDV7EX/tG7xVgMK7Om55z3sZAnKvsm1S/r+QZln
 gsBVcwnKqXIzUWGxt2NrvvhZh9djxtJnxz+JY73mj8dh3BS3UPezOgTrCyo7Yut7imwZ
 Nd+MvN0NIMjGTksqzheUDSI+3J+oymXJYfpwh7mrqg+nAloJayEFFIPWMBtMo9hOyRCx
 4Kv2UlqU8i6gIytp1Ng5/6YhN+vsvpDO8c+FETfY0kgl1WxeXmJY01R0PW8dc3uBicUN
 YdwehjKrQHl5M7jLA//ZWss5h3kiI8JRMhPvVwGMhV5LwcBa/tPlQMqgwM/tmP6oxSUH
 3QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880049; x=1779484849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UKtDoegR296hWUFPVeKD3N8X+wZ1+wnI2qTMFP6ZpMM=;
 b=FoVKlu2xMM8Ht1HqTK4GCWUPaAq93hRV53O32KDsxPbMxc6wpd6l9d2l5zc4tojgln
 sZdvTi08rDpRwiSSeuWRd+0dcgU2BOKEiMKXN2RAUWdM5Hxo4mdmTUqRQYcfhVdQJTC3
 eFf7wKQeUL4cx96BhBkO1yQ1CRanaayjH0auUecHFn1mDNQryIfPvzbrgHFZXhvtyNu4
 +zKHmOSdcYBVVO7fJeu3vfxBFA7NaNjSXPjtRjkMJknSKFof5LIvn/H5/kSIVePPyka5
 Ky3NoHd+ZC5huE60DEWUH7j9z6YEpQhOTIYiTwFtG0x7FSWBxNVLxwwfXAWJu7fQxhkI
 xPTw==
X-Gm-Message-State: AOJu0YwRiQNSE6MeISiVdtceIesgEyylt2bZ5iSHnyAX5HgNIKfH10FH
 rba/JGElra3KLaPDZtC5B0gUtQrTfdVQfSNxV6XbK9bnYv5Ik4M7bXQUXkzztflhiEVsr1gObNn
 HT64KTCY=
X-Gm-Gg: Acq92OE1BmqhYjIMi5wqiuUVBc5KFPYhuPrK66DlOPTiMkNK+gAwGmbBi/HUkNFSByk
 B3KLC7oCORqvj2yfWPYS8BjcOx3/NFZKwySf8c9UCmsHDjIr8ZsdKEJUu8aZLCVQTJYJoPupM/n
 OxXhROgIL8qu9REtdmcB1PjG/UDHzLx+XBQV5MnhHjGBlH7iTgRYwZKzWXbm6hJuDhUR20aZ0ey
 kigZJO6eiDOEuWapr4YEu89d3Clo0no6QYHz4gIooi1Q3dD/m9PiT07yFRxY7gOjpO+HfXOSBV9
 ONe3VOxjcddXj6EMEOxDX4gt6LaM5rBChcXHhTXxMG67W3/D2Ldj0dMyrapdcRs+4fCWWPy5yyj
 gSN7yTbJwTALDbHjCYbLEcsPqF5VSkjEjJMzhy+7c1MpEmngK+huQSDXoCTDUE4O9Jl5dfKiweh
 KeJiyhTH5ZlG2ETPDpVUqd
X-Received: by 2002:a05:6830:4989:b0:7dc:da06:c0f0 with SMTP id
 46e09a7af769-7e4ea087f57mr3681690a34.4.1778880048797; 
 Fri, 15 May 2026 14:20:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:44 -0600
Subject: [PATCH 45/66] bsd-user: Unlock in h2t_freebsd_ntptimeval
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-45-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ME/cgvxbJzgLPnmEKnWFBKklT0dtyN+EMZjFoeGHenI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43m5JaWTAkr60WsvxuzKBjA/I9kAa0LqqXgC
 F8TTT/X5EmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AGZUD/9pJpUnPH2XbVTMNrlOy0FaDObZ3mih8IOsq199YJ2ibKXEidWO7nE2a1/fNKmbWuS0UqT
 Wy283vPp5hSziZuyo3jT+bjqgOJEEb9l8HZQkE+WErHPqI2r0XMP+3zCjDDJWki7UpX6ZrAWefL
 Sy7r7NhdIu8+HwGLimazZ8PzYRk9WeR91N/x/RQkM1Ef/n3cBt5VG3cGqF1kvNuB7REKRdUL7oT
 Stza0JyxkkswlZKqANCyr8sxh9uV1Z8cN6WoK//10qsywW9ZO2GIScaH0ME1TVMCuPrVMueNzCW
 +mVLkrpkb2tK5UE57A0MMAktU/2ppiDVCpHcA7QsdYBkRWbDZ7V0CavwlhX6iGwbCmxjMbFHW+n
 0ayCiUAQuV6HQHPokNQ9AvyU87IFl3VIWvX50j/PqXZxiG9TL92iBiExngA2wyScm90VOQUB1jU
 90pu0S0czE9WPKF8seLnBgMslO5pFL18WPkfrMxqo/x4wDhP+KUIrNAlCabDyGK1c9QvLKAJZ8v
 0Rn/e/6Na1g6Ap+PX37UN6fdscbVlOjjlUJsxHKl9MLyGn64YhrMJE7RaBlMYIcM1drztWU6ukT
 xKcXU2T/QoC8wrHi6uC2R/ycslW+62aJGw6DqCLoajZswkISibtTAfzNM69Hl+4MwuLyyQ0H54I
 QCmqI8xb+TcWpnQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

We lock the structure, but don't have a matching unlock_struct.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c
index 4333d7d30e..2dba352b2d 100644
--- a/bsd-user/freebsd/os-time.c
+++ b/bsd-user/freebsd/os-time.c
@@ -153,6 +153,7 @@ abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
     __put_user(ntv->esterror, &target_ntv->esterror);
     __put_user(ntv->tai, &target_ntv->tai);
     __put_user(ntv->time_state, &target_ntv->time_state);
+    unlock_user_struct(target_ntv, target_ntv_addr, 1);
 
     return 0;
 }

-- 
2.52.0


