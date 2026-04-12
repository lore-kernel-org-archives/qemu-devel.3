Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EF4E937EA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxII-0006YX-1y; Sun, 12 Apr 2026 12:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHz-0006Rn-A8
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:03 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHx-0004Wx-IR
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:58 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40429b1d8baso1241681fac.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009828; x=1776614628;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=flxXVM9IUYo3v5A37ldvuHn8wPg9FyAcz4uvyK53nnI=;
 b=rBUQr30VeJY8W2zXs8Tve81ZjKBVnjXGEdPICp0feB8FqqcEa+zV2paGKoYIR38JmV
 B1tW9Fl4YdTEr2+04HzSlhGs9619I3ag8NuO6uKji2EOUqns3EUSpeYpQeopmCHbz+4w
 BQjlR1og0xkKAhvzSnRObJsJVNXnqGlMzSE33JVTIYDNbyX8oE3OCz3WemLUmNmjT23v
 hB2+fxwiPaWDj0cEN2PSwLWJjEcChV0OWGZmtd6cYMcDJYxXdEVZZFK3fRrM2rdgowe5
 lkk1edOjDuS9B7qj2BooJrgwaC0XiMXJekwGterKwtIzzU9xvaWDAQ9sPTnWEcEjJG97
 jx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009828; x=1776614628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=flxXVM9IUYo3v5A37ldvuHn8wPg9FyAcz4uvyK53nnI=;
 b=YbtCrJ9uXC4lzQtxRyVN2hKQE6lLIFpHaNAeSChNs/abRVfWeQLlAWz3WUwwIrWiwI
 HBW4LdEzVJFWvchMYO1/4RaSBUWiEeJyqS8do5YVSZrWqF5X2y+sAzatznoPu294ambl
 3fYdRMIrFZY+RRIZd2kokJGMj2vSdVF8OR2Bpw1x6Jppp/cjoRD1+jIXqXggCDZ5SXfO
 YnDqzxdmRqsbqT1GbbPVIqUZXzuW7Y65CXvZj0jhUDeUi+HxZn4X9yKTDYwSCumfpA7Z
 We/jpbFpd6uAjz1rnMq1RGnN6mm2Q7XvvBsPlBZof87gsw+SA766bbmKuAFeADrIy8MP
 sfBQ==
X-Gm-Message-State: AOJu0Yy+SB2d614vW8aYBfZtC2+UuT1Te1AR9NI+uwaZ/wj6nTBlgl83
 E7iwz7PaLYdG2KipYWB8OwBDk1Xyc+//0QPT3Wk2dRGJNot2sv1uKphUjPRSPgo/3ooHorlah/L
 N0IlgVFw=
X-Gm-Gg: AeBDievNIlu8JsV2jMLw3xFuKFi4nJWrYg3nFwVDhZ9Y39A+m5DvxTg8bJpaJdTR+cE
 sOX7VCc1EbxJRdHt2XC2sGkNqie6GNBsFsRUf0cREmfhFWG2k1u6ThEUq07GbIBcEVuftfVjntP
 z9nkFd8qQhYnRhFp8XSk0QoM5Ke+xW/BT2xRi9weoc1uW/1T9DfOmZKKD7ZFIcXtrCFLNvNJRtg
 5vFGiVXCjvpSPUcCPmpXWFOLqrZV23T/Tyh8EFyNnLKm5/LTSxVgWef8+0j3ZmfGN8VGb8c8ims
 +Zbx3lcdynflFSWW9afUzSD6jExMOhjQbcQWxbUhg6kl7Oy1AghPSkP0MUfP9sbDfkGoPxtMx+M
 SnnSpj6yCYaebdjq6O6iSsgbWNDyIfiS0k02LzHdXyjb3kYhytETtu3+0n4FoAmFrorvmPhKjBE
 /LhqPB+W6n/A==
X-Received: by 2002:a05:6871:e785:b0:417:15c:796a with SMTP id
 586e51a60fabf-423e10c3aebmr6406411fac.26.1776009828482; 
 Sun, 12 Apr 2026 09:03:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:35 -0600
Subject: [PATCH 12/17] bsd-user: Add log_unsupported_ioctl function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-12-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xbGD7IcDXbypQMwK7rI7j0iz7UJrizyHubokpLPYvRQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28Ig/rheeLFhubVKUkvrp1CPXsHgTe8eC8Ges
 Z2sjN0WE3OJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 ANIFEACbz4nSPoCdKFDXr0lwEmnyTZ8DgNEGP/fP+W2a3AF0uvmAvlox+EoxbJWwJ1n9KXcg5dN
 j2Y3pYtUIm6wvMtoxs2cE9NdhsIfFhgYqMeHOvj0GFsWzRNw0ELlH/QxD27IXDCwUvl5xfGPIX7
 w4YnG5oIY6NaUCCAd147L1JkCzDSo/Pru9BH68AA3Z35Bb0Ai5rGWwttn2K/JDrtPCC6EtPUFp+
 1/i9Lhg+ksDCw/B8LI2eW34EpqTtPnMOCXE05JFz9Zi6WLg+n/CqnIO8Sl6G4wf9cTHLVK4PIak
 E85vQDuP7A8/uxBbWKtFUFaDUcjlbYK9NDkE3uyesXH+Succk5LxV0jK3cjxtw/aXwAGuWWmSKI
 0qsSDXnVpXmrhWHNKvI0S8tBe+Idqpbc9G3cqjxpSpGR9CQnk010Prxj33MUIE7x0FDGW7Kz7uB
 v2MQ8J47Mb5YN64SSUrRVFYFxhdkCsaa9QoeKvu/d80LEFENA2eHnXbPhkSdXFt2aUF9G1OHofD
 sMjza4KM2yTM+mcxSuyeAsW25kOCSY2CEHU6VnNAq94ipxwQG/pj1Jo97UXbEHlHS/aXphCL4Cd
 ++UzYee55JSOvOe2e0deWkT2jRGn/ievx50pONaFXqq0YUnDZpChajrZktynXhNYIPlo9uQT3sC
 XKerEBOuvxvi5Uw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::35;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x35.google.com
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

Add helper function to log detailed information about unsupported
ioctl commands, including direction, group, and parameter length.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 32fa9c3d33..049188e5e1 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -219,3 +219,27 @@ static IOCTLEntry ioctl_entries[] = {
 #include "os-ioctl-cmds.h"
     { 0, 0 },
 };
+
+static void log_unsupported_ioctl(unsigned long cmd)
+{
+    gemu_log("cmd=0x%08lx dir=", cmd);
+    switch (cmd & IOC_DIRMASK) {
+    case IOC_VOID:
+        gemu_log("VOID ");
+        break;
+    case IOC_OUT:
+        gemu_log("OUT ");
+        break;
+    case IOC_IN:
+        gemu_log("IN  ");
+        break;
+    case IOC_INOUT:
+        gemu_log("INOUT");
+        break;
+    default:
+        gemu_log("%01lx ???", (cmd & IOC_DIRMASK) >> 29);
+        break;
+    }
+    gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
+             IOCPARM_LEN(cmd));
+}

-- 
2.52.0


