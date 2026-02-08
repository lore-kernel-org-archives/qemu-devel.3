Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BEDEF06E4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARd-0000ip-Uj; Sun, 08 Feb 2026 14:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARC-0000ds-F1
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-0008WS-Rh
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:17 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-662fca4503cso2010605eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578799; x=1771183599;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A7c5lX/qXRj8bGPE1XvfP1AN3/BPd7UPgvCown6APqM=;
 b=srhsBlzUDunlkbtghSjsfAC96G6RfvTjruSNGpEBTIokE9MUbAgfmrJ1qzIL8baBTq
 5PRolXUQ6Uj+mZiRPpcZxIx/lPYuV79I83k/vPbVSgY2+n5W8zw3Gtxt2kR54nGtMpBk
 iRejVWGiTDLFVIrJjsEaiIBPXb+LzHqduJvF1wUkfvSDDc0c64Z9CvjRpR058QGQMxju
 qwLuY5ej8q1GVJNwazppTCH7Pva6SMWBt243hUAcsiL8UpB02g1uGR4jxoMKWliwCFJ7
 WuwnDeFWb+k/pIf3m56ZpQW78UxeWXOnffA85ZRuFroR/0vbKqbi69q0A/RXwOSO7k50
 6Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578799; x=1771183599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A7c5lX/qXRj8bGPE1XvfP1AN3/BPd7UPgvCown6APqM=;
 b=Gjt42FsBToxC2SMid0nWY36IyoTjWPYsA752I4+5PPk9O/36y0r138Pnmutp8DnOXm
 Elz1hJp0kEHRWgegbKNlCQyPKsLKFvaQtsExCWrxbPi/M2Sz4pEguDlD2y0LHC3G3pIg
 nOgkP/7892WxLKIeXD4sYiFa+iX2BfEkLRTskmwthlWsByIHn/kHKa9M+xzoIMOhpqMR
 q/UTmM9yg16Ohi8NG8IYZhiW4nOcPyimc9ipmFPP1OEdZZ8tb+1XStbfUuBmNvHyySN3
 uXklCTsgTgyWTqfGPWXLrmXH8coUGOY+nA4W2w6NLhn9cL0HidsR/rfk8/zPKAuKUR3u
 Q5YA==
X-Gm-Message-State: AOJu0YyYJYILWlFMpINcE+/GSzSml0BsSv4Bnyof6JWqQfKjj7Thgo0m
 3z+24HaZMFhHMePA4z+beYzwHsDPlfPVlV2Nr3AA21f3G05mY37O50DaET9B05NX8tc=
X-Gm-Gg: AZuq6aLfZNZYSBUL7XmFImOVx0c+iDKG9pb70+JPexRzhGV7QPAHOkLf7NA/DzNSXrX
 pe/CcvWDerl4zHmyPLACIbPzvVd/aDTnBtO19s60biEk0Aja5X/bNupuznO5QX/zOfVuyaqYEyW
 Yq0Z/Za7Ih1BziukrrffFF2qc7bnDg0EnYVECgWBye3/pDhHKceII8H3OBD3m0YaUPfvtIV3vML
 IT42l1EAQ74mY1QJ4K0D7ledaxQa6gO7kw9d8NiKVoStVg31X7SC4vhQTLbPDlChtk/KRE0Ntpz
 /KFViixhIcgkzOdCR1EMHq3zqD2oMpEIbksc9+2l8k/mDKGXrNc2aU2b+9/qVIcA/Gkwjl1072S
 D5KidVcyO4CPgmdB0UlfQu8eyhgphwRuUjUu+8ZZg0fFw3sIPeU1dGr+UozAt6JfPTubFO4rlUg
 ==
X-Received: by 2002:a05:6820:1514:b0:65f:6994:314b with SMTP id
 006d021491bc7-66d0d2fa708mr3525550eaf.76.1770578798780; 
 Sun, 08 Feb 2026 11:26:38 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:38 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:20 -0700
Subject: [PATCH v2 11/24] bsd-user: Add target_to_host_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-11-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Brooks Davis <brooks@one-eyed-alien.net>, 
 Sean Bruno <sbruno@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=kU6sseB3CR4XsmwJi2REvMB2xXZ65X4IAAhmfCrXGps=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgf/cgHRM7e1X6uX5lSEPySrSK4qc6Vkix7
 alfEXSwlqCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 ABOWD/0Vu8vRiP4u97zpa9OW5tEIDva4GgDCgY4kq4JK5ED9SKMKmYdjNScisGenWjgXPTkWqAO
 wRje8jJO3KtULfYqFRWsCWiBiJ4BUnyE7yVZuhncwcODnyP/X8SgF6eORKmZtmcPvapN5czSmgS
 wyya4QvIP7RRarQj91bcntrLT7t54I9ADxGAvEhIbDggG/HCbDZ70G1aiGwTGH7zFNvxuW3V3ip
 1w1sCgxm587dwBQHIw6QU6W1wCsxOpJrAAis3WEFYzuaeLc2/DsoJMfBxp9bny3L6Oi4RuYujPw
 5b7WgfnbhLkvOQMmiiW/FrZA/ygnD02y0nuqVol2kRxa2db9uBWjfNo1YiNU6dll0l7z4VG1/AQ
 DzKABUKml4K/iCARbuRLpulx08KNBQTAKjO9DXZ3jsQLN9deic8fvrpHdxXrfQqtcZm4+QfBMRy
 ixzHefGK/+NgQaWjMNUUk8JZWDpqvJtW4zhI3ul/1hYa8XiB26fNTi8DxsR2hV/l0MimaJf9jhF
 0viHErCT9bG+CmU/tHRTj/wxfTI/8RoRRQpgZxZZn15/to3UBrmbSp8aqD8yvmb5M1bIbEW4I7o
 1Ee/MrEUlBma7C36ePNLWmFP0OmTgJZnPXxOa62YQtHOW/EdHOVUEzUdKggd+7DQqWJbyR9rXBL
 Pkg5UETfWLK2V3g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2c.google.com
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

Add target_to_host_msqid_ds() to convert target struct msqid_ds to host
format for msgctl(2) IPC_SET operations. Uses memset to zero the struct
rather than directly accessing kernel-only members. Handles FreeBSD
64-bit time_t except on i386.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 9c47073c5a..62362e8204 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -150,3 +150,30 @@ abi_long host_to_target_semid_ds(abi_ulong target_addr,
 
     return 0;
 }
+
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_READ, target_md, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(host_md, 0, sizeof(struct msqid_ds));
+    target_to_host_ipc_perm__locked(&host_md->msg_perm,
+                                    &target_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    __get_user(host_md->msg_cbytes, &target_md->msg_cbytes);
+    __get_user(host_md->msg_qnum, &target_md->msg_qnum);
+    __get_user(host_md->msg_qbytes, &target_md->msg_qbytes);
+    __get_user(host_md->msg_lspid, &target_md->msg_lspid);
+    __get_user(host_md->msg_lrpid, &target_md->msg_lrpid);
+    __get_user(host_md->msg_stime, &target_md->msg_stime);
+    __get_user(host_md->msg_rtime, &target_md->msg_rtime);
+    __get_user(host_md->msg_ctime, &target_md->msg_ctime);
+    unlock_user_struct(target_md, target_addr, 0);
+
+    return 0;
+}

-- 
2.52.0


