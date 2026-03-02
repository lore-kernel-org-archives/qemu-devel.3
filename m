Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B23D58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwun4-00011G-RE; Sun, 01 Mar 2026 23:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun3-00010o-BJ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:53 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun1-0006qU-UX
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:53 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c7d04890so3771667a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425309; x=1773030109;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NFgmoDUpjo8YrOGeMbSVUHaSJ3jM2QUV4V1yO/sA9k=;
 b=wtTJgygncmylZ8zgaUIECZnZEEIHrBw84kHzFSziMNXjPscasa+MzcFhCU/swxoFt2
 sI3cumj/KtyDfzLr6VD5BpglmaotApwDhbRyr3oWP6fAbtKHLqed1OE1ptFO9bR2q/ZE
 e/CQ3m0uSHlTpMAwQ6MyAS37BZapvviyjYYLE3fKYls6R28IXgLcGjxKvlYuRww80rDC
 b7WN5qIEgGghOBu7riZ1arGbQC4SoONOyD3MNQQo2gx/jLzw0bRv+01ojE53KPBUFWry
 URe0WDe5zIOQCcgVofUYRdj4LXkkdFD9Cxp3Oif4iU/YtUsP9uUsjFfcRTtV1ChIActZ
 c3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425309; x=1773030109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0NFgmoDUpjo8YrOGeMbSVUHaSJ3jM2QUV4V1yO/sA9k=;
 b=T/vWYSAN+1X2Uo527F8KelrPk59AxGBBn/Fze3zSLexqXn3+nQqz4sMKpwY7YbKBzg
 VLb6XPPb0y/UkhzAVlOnggjuka0STAVBTAJ+bAkvvGgPtzB8h8B+wmabs1Ba9mXQ8XAq
 r+AnrhBW3chsDrp1rXTuo3pQZEdLTPmfSTbqfKbkYynbt/Yte3jA3ZJHurNZWCbpqRmw
 CrcJQ8hGUIokb9P4ZfBcJxqzAyljotn2DRspxTGuHfgz7e1QXcGBazXfkAXRiKenBtsS
 wnsie9/jwsKt+RYDDql5N2bTSOo2O7wSweot68xciDSiIekeHYuaZnTRR/XBZv+Enx7v
 GlBA==
X-Gm-Message-State: AOJu0YycqwG1riRN5LbP5WkRC91AqfnI2S8KFHhUFepUx9RK+EKzbwge
 wS8U9bHOLVilEUMr3INyyBsSch1IYRzn8iCKjJKBmYzODFR+OBdsAe2dwNsjrGy+LdkX9ZkdqNP
 FYB/X
X-Gm-Gg: ATEYQzx+M6ywUofmGPcic1Y5o3JN1bHHOR+IR/1tUO1847AChFNEc1fvyPgo7MxukVi
 WZA7wIljNF14joHCleDnh2VbE2kol09KtQfPnPJMZHuLe+biD52fmwSNST/Pm1xDF+pAtMlJ8Og
 Xdyw5igJ9M1BRB3JwXJZNUY186wXkUobONr3NipnocFtt6Qd02jI9iyNY+Q6JeJ0K1fITkw568j
 61vbdCCvxYmQMwWhS6vq7qpTYw7+nnPj81o1Z83EIvOn5ssgaFl2/b0dOIgFMpZQbd6uuviI1AE
 LIgAB1XpYW9Q7IE76iOfQ/sSD4Ts0TyA2ItxM998IlKmV2K7zt5g39s58TKTvZV2uuw/hZiZySX
 iEHaOuuHRtMNmqdvKXFmckBkYBsSH0A42z9+QOHsFIRnLfTqy3ywuAAdfJw62jfhyUoz+BU99We
 qndsaP7usijw==
X-Received: by 2002:a05:6870:9583:b0:404:33f8:c8b8 with SMTP id
 586e51a60fabf-41627088442mr5113334fac.50.1772425309444; 
 Sun, 01 Mar 2026 20:21:49 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:48 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Mikael Urankar <mikael.urankar@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/27] bsd-user: Add target_to_host_semid_ds for semctl(2)
Date: Sun,  1 Mar 2026 21:20:59 -0700
Message-ID: <20260302042115.83410-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Stacey Son <sson@FreeBSD.org>

Add target_to_host_semid_ds() to convert target struct semid_ds to host
format for semctl(2) IPC_SET operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 65fd7b72e5..941f30d547 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -98,3 +98,21 @@ abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
     unlock_user(array, target_addr, 1);
     return 0;
 }
+
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_ipc_perm__locked(&host_sd->sem_perm, &target_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* host_sd->sem_base  = g2h_untagged(target_sd->sem_base); */
+    __get_user(host_sd->sem_nsems, &target_sd->sem_nsems);
+    __get_user(host_sd->sem_otime, &target_sd->sem_otime);
+    __get_user(host_sd->sem_ctime, &target_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 0);
+    return 0;
+}
-- 
2.52.0


