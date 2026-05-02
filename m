Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1CECD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsO-0007t7-M2; Sat, 02 May 2026 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsM-0007rj-8m
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:34 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsK-0007Cg-OT
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:34 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de4be15125so2511692a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741891; x=1778346691;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HAHKfojUuw/69SixWPv6wm5RcU3cb1v2ogn7XGt8kfk=;
 b=pZWC/kjYNiXBoRUXYleGbQQdVyiZ6mIKVgp6stiIZFb9EF5E8xycZpfWfoE1lzqrA/
 dpOB8ZaG/tI5fgiu0d5HnfTFcOGHTIVipi1XkRwc8zs7LR7RG+iGAoyUN4NZvHYZ5v7n
 xE6fVJBbmW3QEGK+bkBZf8RkB09IVmpBYC9Z6+Si8HPmPlK7ho7xhmIGuBPAQPToAN3h
 yycs8GTfEk0qMj5+BGMNoaWMzXUMo7WmF1GbyDWV7wRFM9Y0ksB3Z4ruFkRCn7m+QX2K
 1m9EQ/VEJ03zhA+GYt8+JGqdSHRvbKIzVcFnZHCy5iv+BO3sBMcg7slwg+znVx7sWAyy
 uMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741891; x=1778346691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HAHKfojUuw/69SixWPv6wm5RcU3cb1v2ogn7XGt8kfk=;
 b=FEeVZ+YKf99x1FX25nif7ENapVFeKYfLHalYgAFjo7dpMkj4QF3r+gVgcI63LB+BSg
 VNqxk+A13xKaibQfhOApa2e8rhZLTAgZRuuwpc/lrvt2p7GJenRlM5vtzRjL4RwZTYAj
 AFXMON4P6znSfujEzzHhGXFKDqlIzJa48/i018DV41Ypa2ZgkmbrQOetP580SFHn57fo
 AT6aus5/FMa3CfGTptER6rfeb0NMRntP15tk6YeThGrwgPoeolDVe2DLeD2mtA4RqpkL
 3KGGaqNa0eSv0lwbuW+JbE455amd5BCin5PBsvdR4N37DddfUubDuLMkkihFReb9fG93
 qrVQ==
X-Gm-Message-State: AOJu0YyEp1K2MF+NI71X0HEIVZ3stM8+9GgJB4CYzEjNLviwrQTnF1ea
 mOfvSfKZxzGwVpOHBapiEvtzYMyNsF54wnmJgGwaWhRT6/Io7bggxnjbK2zhq8SRaWSGgOYuPuA
 6WjwKmVE=
X-Gm-Gg: AeBDietJ1ygkYPtzZSLcQtlo/BkXser8eGkG4bKHQvVJymOm7ao/pKcFERDA1M0alWN
 943IOwOs9eVxK7VadahuVOiihPOIZ64jnAfIYdjQ6KQao9V1Bwcv4VOdi4dJywUeo/okBt8fOms
 tKnlO0sMczI+W1tUoHwN84avvoMDE2lKI3X1EatgcQvInlWOq0KX5JSKdnS16HLCCwpzA4hSueb
 aBq9vDcd73uW9qYVu9LAkcfjsV4oY+Yd+ZdKBka5PrUO5NwlAI/5pRSFObD2y6PQkAleUqguSOL
 G2UdC53klqUg0vWDJmNthsruMxtjRX1gW2fK4MnCsdLJfRbmMWpgPaL/gvY9PBM05RyhagLziaz
 srf9GZx4DNWHshVEHAUJQU6as4Y3T0jNMXJ/T/P51GIA2b+dFG3k4QVUSb0HAV7sYnWK8epyK5o
 g6rz7e1CGPcYBA6epyb1PL
X-Received: by 2002:a05:6830:350a:b0:7d7:ccd6:3cd4 with SMTP id
 46e09a7af769-7dee14cf785mr1845102a34.23.1777741891423; 
 Sat, 02 May 2026 10:11:31 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:34 -0600
Subject: [PATCH v3 13/19] bsd-user: Add log_unsupported_ioctl function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-13-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=tQ0vLwhfAdA97xzGxFaYPIA9yayNPuS/jeE39FxxK4w=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/QJZ9eP9yDcPhVNN4jwShipGxfWEO8VbNNR
 A3ubZ4aJziJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 AOxIEADO4YZqSQ+JB8sy/gOsehZIgN8ki2wSThTnGjIWqfWSjIL6kCop9KJBZgrha3x+SNrnrcj
 POlHxcqEA5DLV+OHqZRwKz7YPvf/mrqM4MDz36/qUKMJ0qumRvwX37HhFdkERJdQ5C5p29fYkg0
 jdg+9LqPlARTwbCczRfLUtAzCCFLjUG82GV+Cc3DI28eZvCxDYPySwYg1GeQ1CgkP0f5kdDLAuf
 2FkX5Rbotpf1e4yKt3nfk6yewwTw8A+4GZv3H415ZTbk0GSrwnbrn0dnWwEaiYhbBtcjfXNlTjn
 mdK5v2nQhV9BuLIL/wNJHbHj72BFay9qJcL7cCQvYQTxJK1bRJ/MJdmWumnirmp1NlpovFyxcfV
 fAnANZFZ+3DDfyiNmNFkjsR9tWZ/FQQ63JX8LPLCu7a80ndwj/JBX02CnkmOx879WT8g07wLYYF
 Y2l43AE5n67TVJq4hMTw/uWLptALvzmh0GYMGkgiJfqIzRhhtIW9Ve/vvktI5ZmFYqF0YaK1uQQ
 1YayYicp+6pTISbOZQsYUv8bIKKUFbcsYUQQGjjsNh/Q9yZGkHN0XOei161rOPwuXG+EVAiwg4N
 ki0Rw6+K3xANkAAA5OkL36DrLvLErA9RN9JXomqpwNPRStFsTeCZYsFHjT62JtqasBI5q2Ml0d/
 COPXSVN8+7E+EUg==
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

Add helper function to log detailed information about unsupported
ioctl commands, including direction, group, and parameter length.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 94110d4ad5..2d84adce71 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -217,3 +217,27 @@ static IOCTLEntry ioctl_entries[] = {
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


