Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B2CECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38D-0004Uk-Hp; Thu, 05 Feb 2026 12:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38A-0004Rc-LW
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo386-0001Pa-Nx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40418578e28so451221fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312409; x=1770917209;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cv9VqQBU8EsaN+qArtGcq8e7shvSBXLN57BzyKSj9cM=;
 b=OivuTprhsnGap8Ev5DX+VgBvwgUaNtOJh29TxQ9UxYt/Pic0mxb+9+rC6nlhweaP8x
 La9Ip7jppJV/DTmQm2ENsTqnwsUksTsspTdzk90yplQgFXi99xkKjpmMACSFA4MyDNea
 YvOoQ+7AOziNGoPYznZL6HydV935zHByIE6sCy0x8eaM8yAs09ku4YuZqCsJ2Cn4v1sg
 rRAORKWxlDNg5yX3s57Lv3dW6wZnvr8xcsX2Or77q9ajVZ01YcojPQ64xax0i+0w10J6
 ht/r229U5/fqsz5QY+/1SZbAsFWY+4N4l5ES0P4XnljijiCwXXtXFtPIg6fd4bgKYKii
 SAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312409; x=1770917209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cv9VqQBU8EsaN+qArtGcq8e7shvSBXLN57BzyKSj9cM=;
 b=e91tqez4kGwalK8Pb0PnQmzX97t2ydW6jIDnC60jKqGzsiUF9Jr8NnNjHP0LmJcaSy
 GiEKH2hs2bcw5NYh2c3ShTGEi/3La9KphmshIh7WLhePRnSPWuSR1TkMuDdENQHnY0Ql
 o7cWyiA26R3KbjQGWMiC+yDzbPOvDapo3x7boOZ1BTc4TLl5enVE0udl5g0B1Up/TGZx
 fNOtGZ55KEzRjIjMZJRB76X8CprV+meOqX4Eg54yxaV921AEoNA1w+01io1akwIsQXic
 JhSa5C4XY11X5r8BlA2cmchqkk4YujoC/XFchyeBUzY9/sWILMx43FALjZ1hUA3Td2lw
 K4oA==
X-Gm-Message-State: AOJu0Ywtx4Vt+HnR7XEg0ZWoL4PrI1ecWd7BFzj9xXI0xgy7tuS0lCcI
 o4nJ9FJN2BH7lym5VgfYprNfTviOG6rsHE9W/4pVE34vNTR8a30clB4eD6DLEsndbys=
X-Gm-Gg: AZuq6aKYf2lePI6jSBPGzQ9vUSgopA8A2l0WGZMVbC2BppDh1HyoM1X7gpD7AjI78Z8
 qJIyD+CKZ509GRI8rHYH5isLhszG8FU3HFSg9ljU32TVk54DXptJShkifgy8ZwJG6GD27ecIkrC
 j+S24am3ZL5Eeho37iDYkI0mjBo7OMX9fdcECV5KuF2RA+Xjx+FRuC3KrYqTOcc0nB9Vh8zKgEj
 1k7UjcW3B//3aZK+Ce/kDgZI1QcBef2bSZN/PTfbGpMMBu3h7kMWua8WWSMw8HhvwOE+B9UX8V0
 ZCaIE4DJ7qL/UZRrOQpJV4Z9/Z124G/VnzgP3V8Puxhy7pb2BPyMnbeV16sbQTuYdTGlQPOa4hJ
 7rFFOs1/khOWK40hjStQRyooragdnlWwPknqInA0ZcTEqlamvjHTFLTsIHTIJkVrIb9+ohVf4ag
 ==
X-Received: by 2002:a05:6870:fb8f:b0:3ec:9c0c:283a with SMTP id
 586e51a60fabf-40a96cddaacmr17065fac.24.1770312409451; 
 Thu, 05 Feb 2026 09:26:49 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:49 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:42 -0700
Subject: [PATCH 09/24] bsd-user: Add target_to_host_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-9-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=l3aaSGl75xDQ60m8Tb3gHPxOs7J8k8a3sxeBgES7+7U=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLaLCmlKLQ+Amj072Bg+j8FpwbBVcv2UjnBC
 o7dI40XLNyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 AN4mEACEbMRc1J4WLQiTRt5HZoNmzjcKAeCqmyLshv8Y0vtcDNmWHaXuUHaAkgEFYiIEtFbb/ql
 2P7wT/kEt+ADjO31m38snCDlo7Hiv+rZzpqeOlL7sBy3rMPrpbFHG82ZOero/Cj8csP+8YUS2dY
 mNF1DhzVqiauE5PfAfPPjugr6HPx0vXiPNTFKgYUM6jk5+0pmES1cMYqe223kWvYrSgqJTrIFVu
 CjkwFP9nPtdERCfTTkY0fy3eBHbCnJOLoykKb2uYVKjWra7svnELcIcs3auRoCISs2+IW6ZKRJq
 ETYDwDQCygzLqLAXKydpH89oComo4DXjB83VKsAAvrGVzUyyXsDMRqjm+8bx/xOKJ2Rzaa960WZ
 3itt/LghgfaZU84y/XN7HTzK0EG7YhzOgwP6VC19rEXi07zD0gY6+/iPMkwWsFCeTPFZHCB7oqH
 C47JqE4rrKCidCSZ59Cjjr2Sf+q9Eq97GsErphLAI86cMop9v6nn+v5BmGeKeS6O0fw8uP+1NDk
 c1NWYSaooH+TlTef2Qtcg9iBeFsxrP5lDYYMKDdEYaAannVlT1AFzvxTq/yjGaxxio4w7IUvV0/
 PigoUFnR433jYVDaautyUnqd4bfWmAiezL3sep4Xg5oiw9WeHB+c9XFm4dLsTepT8xKOUnH7Vw/
 sBkEnD4kIjkn4Iw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2e;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2e.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 7bdf65450a..581eb50355 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -111,3 +111,26 @@ abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
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
+    target_to_host_ipc_perm__locked(&(host_sd->sem_perm), &target_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* host_sd->sem_base  = g2h_untagged(target_sd->sem_base); */
+    host_sd->sem_nsems = tswap16(target_sd->sem_nsems);
+#if defined(TARGET_I386)
+    host_sd->sem_otime = tswap32(target_sd->sem_otime);
+    host_sd->sem_ctime = tswap32(target_sd->sem_ctime);
+#else
+    host_sd->sem_otime = tswap64(target_sd->sem_otime);
+    host_sd->sem_ctime = tswap64(target_sd->sem_ctime);
+#endif
+    unlock_user_struct(target_sd, target_addr, 0);
+    return 0;
+}

-- 
2.52.0


