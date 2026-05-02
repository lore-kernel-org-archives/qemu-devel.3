Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA30CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsP-0007tK-5x; Sat, 02 May 2026 13:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsN-0007ry-4C
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:35 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsL-0007Cp-OE
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:34 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de431da8fbso2612378a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741892; x=1778346692;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vXQpeVT6NjBI0ExB2y6SAL1f7h+wTVfpl0e6umDStqE=;
 b=oM1o2JL8KV1CTI7DUP6GD62Q7TWUGIsy4uvyC4quqxjxQZxmt55Xw1+Wal3uTt2wR1
 TFV8TVorp0QwKN6qynqxBcaZPxm5D2wJY+kO9JPZWhLOiaEuRw6Yq0WJAqgewzwO+h9F
 /hWVGFe6+E5Qtr5wUahU4bHmXoZCZLGCyAjNHdSVTIxClo6D/p2EZDlGfcePOJIwICcx
 lfIsYk76BzyREQS8kC5Oewbt6L//aCUQuXbCrAO5637C4AlFMGPATxYhrDJlR9RBo98a
 qkSeroLLdxNxvuQtOrgqNNgutGWfBKASEXGH6n8/eDW4LaG56XokdYKVMgm3ohveNc5N
 b7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741892; x=1778346692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vXQpeVT6NjBI0ExB2y6SAL1f7h+wTVfpl0e6umDStqE=;
 b=GCaqJlrmpQgPw0gBmH1uff9SNpMj0ih0Qy6cr5qrk3vQQ8dFgqIPK31TOK4FoxWfua
 TvAVytQNCQzZdAx7uqd7/oG+gz+0TurWpCdWyCKaj9GkinXppPx8yHmWfkoqjwCvB/XF
 AY9suLNfJZZRg/92MIoQO3IkWzfeR62PyUpIzEM1xODp65fEhDNghDsLOzBP0tTLZRwi
 EucFleIjVghzoOQPafDY3LXjDn4Bb4z2RdjejZhkIYTMyNiJGVV9m7gpC9fJvwU8Tg1D
 02g6KgSV10UtpzaKwj4rd+sU/yj954Mg6zkeG6U1wf6rv/ynP+YYNOYxMsAaAnddyEWx
 E4dQ==
X-Gm-Message-State: AOJu0YypuqKF8Mh6/Pnq0UXlU3tvUi3ffjCYIsYxlNXOxmDduIfQYjtG
 wZYHNvlPbCFAPF5K+26UI/Sw1Aa2TgHBm+pe4w2YI6+al/zs00cZxaA43dgFuXzkRYwHQ9h9r1f
 Y1LKerxI=
X-Gm-Gg: AeBDiesVsIhlBhAr3tbNc6YEBndC30cq9kExCJ30COWGaM9BI60Z+RlumT+S7FtBUyq
 sCEQEzZBJPOHgC2eAWYnVf9PSbuWxEqacgg9KkAeme8q+kb2RqXC3x2DA3HN9cYgfgmtii2BIe1
 Tus4tlidVhQ8eujEFrNY0nm1Z+qESDS7PDCqWhwJ40hyApdkKPY8LtTq2Rfxd4QDHGrzZNEXIiA
 dGnML8Q9QJvLNLJtOa3DIpCrl1yhyZwqys55TGJwKpEE/BsxpDFY6xC+0okjmVTjRbpRI1eCN1c
 bod3vcJn4/axI706vZo1Cs5+Y0HEb8PULf93vH0HCTlTmzUGW64PBHYhe0QV0X/qao56sdNBmKB
 0NNtiBovod+BA+CciMjUinnWBmPq5pSiJG2OdcUShJI6blU2ExnMiCKU9e+mBp7cBgpHBmFVa7v
 pyjHCzFCZ8BctQ+O7+G3ag
X-Received: by 2002:a05:6830:4182:b0:7d7:d524:bc88 with SMTP id
 46e09a7af769-7dee132b4b4mr2385036a34.10.1777741892346; 
 Sat, 02 May 2026 10:11:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:35 -0600
Subject: [PATCH v3 14/19] bsd-user: Add do_ioctl_unsupported function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-14-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=DJgAUmrf4raw2oc+XFegw2HgSbHU5Wy5dZ5DGqoYjZo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/QfOm9o/hjOw+u7Wu31539Ox1YkY7QtyLc0
 0NywOUfDaSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 AF9LEADahW8NdIIlH40TtfW2v/RFGAS7fKIh9VhzYSdU5P17YINuhVVeYDQZvWpGH6YmMo4E2HM
 sotWXsYHqS5a0nTr4ucBou1zN3u/2RWyHa1xQ4LWwc+yUUL7vl/U27TG7b6i15dyS2ulXk0qBeQ
 nSB47CjqRLtUDMJ5DBtxAQW5vrMgGLCK9CWmnNoImR6ZCtnTVxzyriUj+XEXVp0UIinmbY+fPcS
 YzrdYQfL664E1e1+drH7kR/K3npM8/kpymsq58sAfv+YwVa05pa8lo09gqJt8nvo/4FaFNjgXcE
 hZDvQIxH0PlSv1IAbBe3ML+eplDoFkgzOH5poSK6smY6/uVOKSvd8UaHdHdAc6UWGegFg2Z0ut/
 EEswYg7RETov1EAnmAzboY9VW6LdbRfp/YswtNesGwmesp0hJYxTVeTFGndvC1bANpRxSDu1oYn
 Jqx21+HrHZ/CEX0T28XDvLlWxi32mqPo1fXW/kRpMIGADDmQvsupfiEgATaAR3pXqpPuzJ18GSN
 DYOgWZlhZJMrDAchX1znzeXBweecOd3KFMidN5asEzmKWp3ghSF9NJjF1ZzmrXNiX5EoNj1vof0
 6/zrnCvAyjf1LjE41Ai+ZqgIA7v8nJLYWIs6fcXxmMj226AGK3ibwS1guoa1WS/0srNmdr4xF6X
 6oOD4Y5iiJ+mHYQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 2d84adce71..69d1ea1718 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -241,3 +241,11 @@ static void log_unsupported_ioctl(unsigned long cmd)
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


