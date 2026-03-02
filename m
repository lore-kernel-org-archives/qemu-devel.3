Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA50D58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwun4-00011A-CF; Sun, 01 Mar 2026 23:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun3-000112-OI
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:53 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun2-0006qc-Bw
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:53 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f194e9a98so1488033b6e.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425311; x=1773030111;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/M2ULDSDe0NcTtXHoyde+GECciBrM3DVoejIHmSstw=;
 b=CLD+/1C6TQjDZ9X/+GpdAmQ5crKHFJ0LrTMGWlQLoxMN2K4ZIZZipSetMSqK10OAl5
 J09ARgXJ5gjtF35U+K2EuvNMTyyolOMuotTopp9TPVrQ10n2AeaWguxdrkjOMyoQngiF
 LT1asN9+jr/2mE7sUembdgm3s367UOisOyT000sjviiy5gLjWdrJ9ThYphKOytXb7Mqh
 JAIOG19RyEBli/hYACsm3/wRxcl/AhrMOpIXpAwo1x/8EtB+O0d+tsKjzKmDmYmDNTCI
 DkBJCXoYabkvklOv7GMkjR8Cy+NdoJ+5XhqsI5Jfdh/XGuClPJodcXAFXkhZc5rF/upS
 pSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425311; x=1773030111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q/M2ULDSDe0NcTtXHoyde+GECciBrM3DVoejIHmSstw=;
 b=IxEvQrNTgo2RKRJvPOYnxbXTv1ugn08oPth4sXgvxtWXOFW/cYCWZUY/hfgD/MD+R/
 idOad6gfl0JEVWLQ1UzFC1rmg1FXmepatmHaESh79BQeV9oB995nzA/nJ7KFjg6cQZEP
 KG6GT/qR+64qxZDQWJ/GsTkw9zVFjBU2llpmzKajNfAF641dXWSkDXqUzdCYgmPclTTC
 4MdygRu76KoK4jgKxEgw+QYrh04vimzuXChEH4C8nEyYpfnJDq5qS0jP0bb6CDAvNnKm
 xh8dxBcyLG2Cxii4fw7nljkFgP8tHgTjp8qkjVA0Jo8zChMdK+f8q7PL5NAhdOKKdU2L
 wASw==
X-Gm-Message-State: AOJu0YxPmXBi4/1CImOwx2uJX1bT87BWrPsaykDki9QntEtD6q1X0zPE
 PPInmbjkbpNaBedL0GSsUt8QJ/FQcKGuVmHnHYpjXenw6H3RYT2UbdQ+T2y57dBXygimbFig7ZM
 3AQd6biM=
X-Gm-Gg: ATEYQzw4jLdCcGi0zn0HVfXqXxE0XH2NshT/DJGpE7Q5gB71wM4X0FmpewSAZ395L51
 aMYl2JdnHTOpueK3Rqz9fdt4KZIfhfShe8VoZ7m46dCeUyRiLb0SW7+u8mzFwqZQvp/OIqUwGzV
 fjuCLk7LUcsw90Uo4+4c1kkD52wX0ozsbGx01dFBkaqZaY9I16gzgvLWVKzHQCqQFQi5OUsgOW7
 It2ekhYCiNZDivIdTELVfhp4BYjQUIO87aVP5s4/B22aJZioN6AhfaXQ/eIN3UXnm8Llh+xn2Cy
 sItb+Vx26eCdxSltLjKCsYVYSFRF5wqRLtN51MluVhKtgA1oKdYai0mDQyprb/bvDvuR82HjSMX
 YWIs9wnXoZeuRSdsoeYx59SeNcnRNWNNaXFfJ/mRReZuHewmmPWXuxqXsUvKwD98E+/ggi2Z6Je
 t7kcaQkh5lZfdJY23IMIXO
X-Received: by 2002:a05:6808:1491:b0:45e:e07c:3fd8 with SMTP id
 5614622812f47-464bec61c64mr5341501b6e.43.1772425310862; 
 Sun, 01 Mar 2026 20:21:50 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:50 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/27] bsd-user: Add host_to_target_semid_ds for semctl(2)
Date: Sun,  1 Mar 2026 21:21:00 -0700
Message-ID: <20260302042115.83410-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x235.google.com
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

Add host_to_target_semid_ds() to convert host struct semid_ds to target
format for semctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 941f30d547..5b02006313 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -116,3 +116,23 @@ abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
     unlock_user_struct(target_sd, target_addr, 0);
     return 0;
 }
+
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_to_target_ipc_perm__locked(&target_sd->sem_perm,
+                                    &host_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* target_sd->sem_base = h2g((void *)host_sd->sem_base); */
+    __put_user(target_sd->sem_nsems, &host_sd->sem_nsems);
+    __put_user(target_sd->sem_otime, &host_sd->sem_otime);
+    __put_user(target_sd->sem_ctime, &host_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 1);
+
+    return 0;
+}
-- 
2.52.0


