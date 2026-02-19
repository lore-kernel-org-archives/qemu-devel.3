Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A90E9A04D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswV5-0002ld-R5; Thu, 19 Feb 2026 00:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV3-0002l2-AD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:54 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV1-0001k8-NG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:53 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-409de4132b5so336994fac.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478570; x=1772083370;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9HAHp2eGqV/T6gC1AiqdWHhJeslTmnwP/pOM4ajrSM0=;
 b=EsnL51DffpeB3UIRlvGPVytShdSu4G30S4vBwVEm+U+gegTNFcdKHrCh/BnmTf89Bq
 zq4+0x3XJUatJ6slKDyWAtCS/EwlFJ36TLbXxCEGiF9wgVXDy43GU072vz+xturNzxNx
 jSfJeangij4MCYsG3qibamtyZ5m21BRFgcXRGFVtEL17nWqJrIPicrO6KHw79O14UBUo
 bUhFZC7LklrOdI3X12uXancdo0Z0SUvZPQ9krchpXxO0XeXbOk+zvdQn9NXmE8QLfoq6
 R6j5RDrPS2mQODMPPWEY6yv7ogvOOrSlne6rhXJ9uO+1HI4oEUlyIfwUciO1jCm7Iubt
 /fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478570; x=1772083370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9HAHp2eGqV/T6gC1AiqdWHhJeslTmnwP/pOM4ajrSM0=;
 b=N1eB6ksgIk4KCGmSSjgdSKnxO2+3WlLz8noHmSu3scNC3wzGFQsc1feDbe+3orQkoz
 eQ2bcDH3omZglvC20p1ZCgQQKW6OawyTmaFUQHF260HhfxouYG8ykWWskS2p2z0uEcXG
 8CEc2LjAapTRY/EMLSQS4RKuOdX5BJmWe5emvHjlUhLSQa32IX+TNOdwrcek8SQsJMgc
 ndMao4OpzTa/gJii1MKLe/8PGEuC51qMZbESMCT9MaJcJIO7cUIQlARsSineiQmk2Vmo
 n4/Po3GDhFlITxQg99Wi/xDkb7Tv6iEKt/jTrKB4XA3STnvYwjuPL5meBnsEtfop7SST
 ztwQ==
X-Gm-Message-State: AOJu0Yy2DTC+zjgxD/9s9LcXxLkl33wDxZiOuKlPRf62rLuZtjAOYQst
 Hx/FDB/NGev9bECkgyrLq3PeYiyY9gGn7iB8M//8PBC8NJEiSNhSHedoFRmvqDOBODU=
X-Gm-Gg: AZuq6aIKlknRiFvsQezRoRfHcQDtSQfUQykaiiTZJ5ehnZHEF2z1KkXo+17We2Xe8Mo
 v7XN6JqdYzCw53U2l/TEx+JPh8MxEPkHAC95V7UnU5c1IhSWij8vtBU25uj/jkwsiFG9kAf2A9o
 7gxTVFfkUZUgHAVXPA68ByjGDgaAPk/jUA5GRZJCvGnH43uRH4Vcp3v+/6tjneTPrmX8gsiI0ZX
 o+s2dIsYc++d2JRl0QUeL8DBn5k5GWpEvRr+K7YDIW5KjW54qiTcrqucg7+SyRr2CaRDyTltBlE
 Rg6XFIgTVHUgHm7isus38ulhZ5fdFn+FOKuAtsJPTGyCBUaX/E3qZsL+BGxX73p4l33FVAkcJov
 rChFfDbkmsA0bD1lWTn0+103rTAAZDZP2Tz5ZivQlxrGZ+sYZMyhPKh3LIsSmj/JxNbEQWJ/bDL
 dQl5wrOHrKHgTToGQlf6Mt
X-Received: by 2002:a05:6820:824:b0:678:1479:fb05 with SMTP id
 006d021491bc7-6785bb685a8mr8760249eaf.59.1771478570375; 
 Wed, 18 Feb 2026 21:22:50 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:49 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:34 -0700
Subject: [PATCH v3 11/24] bsd-user: Add target_to_host_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-11-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Brooks Davis <brooks@one-eyed-alien.net>, 
 Sean Bruno <sbruno@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=uTQUitK5xISck5snIAEayDZejrsfRER9aFZurjjKZHI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4spxBhuf2brJQvYXJwjUYYwy7QCKVNnhXEt
 iv4YiJr7UaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 APyID/4jJD2KR3Nf1RfzWl9PAlKTjBWjQXCyezaFy3A6s51ioLsTNm9AND+A2X/4XonXkQjmE2H
 9WfWThTCf+l0vmaU1XhiSA+UYnCqpIvSMBa0o2OsgNEtj2VdmsXzOVWMpMJbGepKR1/LpF39GZu
 2PQRhtnM2JgGBiACY0dPTOXrQxK/Y5apK72Hv8kbWzo9yYc9wPIKNZg6QTCjHJKZrkb1If3CxKv
 US160+6UdNXPHSTEF36Zqva9ErfK31lxPTZ3Ofd1uLoOceUZ+pHXI/pNXDzVU2ocFmS2vovDR9d
 +dErZ81CBD0IhEa4F7Wb6sagJGOe9jP0RJdaiWwtPN1oZSJeVTibJqtnXf7KN9qsieWmzBetmuP
 3QFQl+iHuEZqhw7QGaWATokIIpMuBM28B2aqsNfiBRMhA2GVTZo0vv3M0KpaDGA1lPnsiDU4ZJt
 LR8IYQLjUGHaUQXKwvagEPNMC67g8ml9FXkderF5w6feytRVC3ajYZz7sXxh3tsHbGyZBUeG/yU
 Oz8eq0TlCwj1+bcPI0Mmu88+vACwRVC9Z2t7AbLJ4OBFZVbId+UOpnoD6ezIMfblhMZfTnySHPt
 JwTnaMascDKosB3XZ1OI7RF0mEWEQXFM1BUNPnIZZq8fYcnXY9cIJ0nId7xdeRPizNvg1UNy9ex
 kqMxgaEjI+pblNg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 5b02006313..5e5a590227 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -136,3 +136,30 @@ abi_long host_to_target_semid_ds(abi_ulong target_addr,
 
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


