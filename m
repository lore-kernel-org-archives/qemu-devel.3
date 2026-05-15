Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1915CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyD-0004db-AK; Fri, 15 May 2026 17:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy6-0003mg-Ai
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:14 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy4-0003GE-Od
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:14 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d55b97f358so222361a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880072; x=1779484872;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5JKTJrCCQNbgurNMjNugqjzzYIjsw8VYwvORH6EEIMU=;
 b=XUyZE4Z0maUrfxRmeueghzCy+M94C4f60KVXhz3mXEqPpvP9u0WD9/0627ZjdmT0qE
 OE1WnA35fiTKwRCTVduHUqv/o0zOKJpcPmGC8gTVVsdHhun3lpOIVaMR7k/68Zuhx2Mf
 8fb3pBO71mmgdn4yXp4uh1g7CtbsRvKqi5uMPehCjiRLfEjz1/htPeofmxNK9yqspw4N
 KEceWNl/TMPiCczHQH3F1vyGtBzM1hF1LdmoBvgdCg5eskE+1x3xWU34dTO3Kpz3xSWJ
 AYiMhb04eMxaEyv6b7GIxLkUiCEiLsllOeK0C2C4cmZFbEY2deKu6wkySV6Kv7xFZCBw
 xDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880072; x=1779484872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5JKTJrCCQNbgurNMjNugqjzzYIjsw8VYwvORH6EEIMU=;
 b=BBDG1AXGIipdkez3XK9HvDYkr7oWyZx66mEH0u1NYxuyoZSw+OdK2W9cl9f0R3cFsk
 +6gSN7ENK9HGJT/jvHP9WDMbPbgZCk0nhgsNMqBCio2LnLPf8AYcuasjBXo+plKrNs9t
 bxrLv264mUtcO4Vv2Z3takL4CqiSBuC5fwtQcAsCnBsmE2uVFsL19riCG3BDBT99G8jT
 uuUN6+0nEKXzD7/U5Ro+98MV4xvrVQXBQaDcJsTiPyZWEbb+gFyFBcvneWffQAg0Y4WU
 nxgndXO+XN9K/iRDynwOn87No4x1OFHysvhyMJ8yOeg3xLvVoxkktQxdCiVfhTyDBkTi
 4JtA==
X-Gm-Message-State: AOJu0YxE4a/KVYG/gZbR5J6LY/XrvXw7DAzIXGNfaScUJsntC61E4mTA
 nHZAAKF7dOrKi/esxE9UsWNrjHPzwAnb6r9/p0tudnhvStU4BQ+i+FTXEmaK6GorN4pvicUg4h7
 TOLJnP6E=
X-Gm-Gg: Acq92OGbsjhZxVHKtX2dRMjC/zBoxVFV8TnlEsEboXqUZLybC1o487y5H0UGwlfuXKx
 UKR9WyRWzr+RavLrG2oFppvZv0T5z2npl3ZGWo76eoL60AC+XFI2FntmyIsYtaDNgDHrTs1URbB
 MjkZq5NcM+tJ3HzkvoFMdcJ+CPsHoCsrC7HQ6QRyQ94vrdLvpgs2Psi9/C9Wcr5vrPMsspjl88N
 axL2a+KssijQQaKmD63gZnE0pIeKWQmWIzSASaa44wKmJj4qnz2KhnR8rzMEhFkS9Otz4/4gCMN
 /SC9cYgT+AhHPp/rE301hM+QsIv2aCeOcMVLvMXB4yvAYWYYlpPzlYAL+AE7ZCgqHpzBKcri7Pd
 riGnNJMg4LGAkXzlEpITNMqAjYh4igoXRGxSDjKjF3sknuTatcOh7/B0E6qpo2hu0tzriwXR92z
 9pu5csIZpgVw==
X-Received: by 2002:a05:6830:658d:b0:7d8:7d95:fa59 with SMTP id
 46e09a7af769-7e4de6449d1mr3878579a34.0.1778880071683; 
 Fri, 15 May 2026 14:21:11 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:20:05 -0600
Subject: [PATCH 66/66] bsd-user: freebsd_unlock_umutex: make flags 32 bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-66-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=C2mdZ20iYFOeIHPDW/UIb9Tu4284XyAJBzHAKXVXiPo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43pfxaWkYqpt6w2/c1yFbkTuaFfPm/WlprPd
 lLUDloqP3OJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6QAKCRBsHNEofbAR
 AFd7EADdBut/lsnGMrUhfpFRKR55XgfnW2HEBDNGEDYfiGexKuXO5Ex5RuGhMNxOo4oGGP3brTs
 WE9cxT9gMaypIBLuKJ1RbF1Ie76GnqeeHJ51LsxhkOpqsLXacj4UHDiJerivYx/aoaba0HJrVSc
 LM1oAcQ7DyERyKMV6PjiSe22B60Pll7etCb9M8b+1yiC3ykGv3Mly5pXAaAQGoe4OSlMdm3Ewdl
 fhMi6UR9Qbfsne5OCpKBe2AQo4DMVkRCCc2scvBfKNcKUtnj8297ioq+Luwvg5BLkfbdZ0k2wN9
 BSYHIGH9ys+URdk1j29olB/k9l4cmKlwwa6Q8Ncbz7qRs9ab+ui0kUE3fZM/m+R2T0h48WHsbA3
 ldLFAdoOdCj5QJpbH5luEfWafrmeCKeQqxz69GPu17Sff0fv/GzUZdJsgRrbvbrdAZxbQlXh3FJ
 Uw2BX9x0S3lFE5CTeT4cLWR8ZL2wdu40IneTpPl2UjrlcVkeBzexRIAgU1eUzCc8r4UU1hgZVsO
 GwZuatC36nJ7kyHxGKsYNe3LNlPvZ5q3bMlOom3poV892/a4rjjun0xGoIjRx/HACg69I481AVV
 vcx6dGedsSObp0imWbaSDFijA3ZQM+rsH6Mu59Vf/jJDpvWcurat9biV1EearBTm1XSmm2vc8rj
 30xLFH0xmGqs9Hw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
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

Since we're writing flags to m_owner, which is 32 bits, we need to have
it be 32-bits. This also fixes the problem when we were trying to add
the TARGET_UMUTEX_CONTESTED flag, which is bigger than 16 bits.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 86dea0aea2..9ed5fade41 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1033,8 +1033,7 @@ abi_long freebsd_unlock_umutex(abi_ulong target_addr, uint32_t id)
     return optimized_umtx_op(target_addr, UMTX_OP_MUTEX_UNLOCK, 0, NULL, NULL);
 #else
     struct target_umutex *target_umutex;
-    uint32_t count, owner, *addr;
-    uint16_t flags;
+    uint32_t count, owner, *addr, flags;
 
     if (!lock_user_struct(VERIFY_WRITE, target_umutex, target_addr, 0)) {
         return -TARGET_EFAULT;

-- 
2.52.0


