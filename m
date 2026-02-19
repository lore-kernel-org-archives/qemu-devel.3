Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3325E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswV5-0002lS-29; Thu, 19 Feb 2026 00:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUy-0002jq-9r
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:48 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUw-0001bV-Sa
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:48 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-66f747175d8so389233eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478565; x=1772083365;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e2UYyOMHlja6Kl2L8NhlVAAFnx93AP80rNAabxdIAvw=;
 b=GrfBoajNOgaJG5Lcj9ZUpfqaBNjwci96nKPQVj1KVfOqic/6qgc95UTZ4is1dpm2yf
 mHtvUKD+O8LHLZIVl1NvvKaGiGKJI3KZ/F0GTCQUURJwqfsMontJo8wbYxpXKhbAavGx
 F3PzeGwBzXURbiyDlgbKz6qIe7Jy4ZtMxEJct3pFK4Pz1EnCHCJQUU+thueifEKKMCKb
 NNdN/4eNpvjRQ0cd79rmJEVvUb1JAV208eISN/D589ahetHBPCfVD9Dt5J7XNiEbckIA
 fhGD1aYM/7gSudu0NGEpjEcOkpw4ljYFHXRdCIW7oGjZjN3qWP9EybbwIZ/y58aMR71a
 kfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478565; x=1772083365;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e2UYyOMHlja6Kl2L8NhlVAAFnx93AP80rNAabxdIAvw=;
 b=UuenuZT4/zj/hbgFnhsEi6CZomD0EVinCLdkOAw1Pa/bRN8xtL7o1A0Rff996FGU/X
 z5oi4SMiU9SPSAgvKULqtiQooI/E7N5+G0aaDX9xNETSph8uN65RyankKL4jrcDDcMF1
 F5xAF3CP294pZZvmdqrkCvW7+RvGrzhsJdDKbbiy3NU6wDWU0JxYCB/Cko5jhDD6IEqZ
 CYSLoc3QCipNrMOgGlx8T5Ts5Y9FrTgMdACPuCZcLBWkcnU7P1AaAWBwduVMRZAptGn5
 bM0FmSaBDyO/3RQg9lhonQvK6j4VdrxVuOSH1zTXd5FwB0jyycLUsMd+pAY7c8Jfp6At
 zWuw==
X-Gm-Message-State: AOJu0YxcWW72AudN/3DsVJY7oilSJK4MalqjEHSS2mQD786JD3paWU+i
 ZvxHYRP8+ijOxYivLkngn+rJRJy+bQ2qYfpaKP0pEHvDy1AwhexUxmLsUXUfD0ShQgG/zYSS9/4
 h/fRjqNA=
X-Gm-Gg: AZuq6aLit5Ie7b4zJa+9+I0PbGv46XH+KwBKkjcWWu2+tOs7va8TBYJx9u71YYlDx5I
 AJfINiylLMELnqMWCo/sRC/dOXIUlOvq0xBpkmlgHnCqyOeE3wOVs6erHeB7vT2XPc+dONcmjSw
 w3zRVQR99Vl8ZJ0p5LlD4VIPivwlLGLWyXMvVMTnP49AusJFN/cGMaNz44mORf2qHe1oexUM/o5
 abf0afDkls5fZItqDgU8TBM1jc2yxOutzqmSMHFOloRDmknjaSNSxGy+vGdfgcjLDSY5SNVhOfX
 B57V7IO9S1O/b+evnkc5CiUS+2KjI8430R0XKvRl0qU+fFf5+t1M0Tvv5TmeF7RQsVjGv2RVNYT
 1rxD6sY8pmucHPhKq82YKFjESyAMvLuC7dNkNkx30dIJxTl59k1miUpFYqPi0nPRJEzOiFK5/G4
 AKO6/X9X4a3g==
X-Received: by 2002:a05:6820:22a3:b0:676:e8d1:bb49 with SMTP id
 006d021491bc7-679a745c790mr2421530eaf.69.1771478565600; 
 Wed, 18 Feb 2026 21:22:45 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:44 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:31 -0700
Subject: [PATCH v3 08/24] bsd-user: Add host_to_target_semarray for
 semaphore operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-8-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=1LFR2/aewofcqUWaUSfvi7cCnimlAOVVnZsi6mqqDx0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4rFGS0BrCWLhiWrTcCbCFqLKp2ze0WfhBTh
 GBIDyQ7e0iJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 ALiuD/wJir007vdS7RcVQrrQof0S9MZAeJdktIXP5zO/zVgXMC+MnWkzEOSQWBvYTA6JkgtojDs
 T0yJuzaoQagPPytPFjcvcoeg3PyBJz2cE4sNHuutBKXzwsQv6x5+TtcGiPQcBXQD45a+B9hFwRF
 rPM7ErgsLNotj/LaPa1LCo8nBGGDSJc+t22IYM93KbgBOGhjAMXLLjiLTMqj7GKItTSOufQJy8J
 a5XH1+o6rxmhEP29raBh9Dv8UR/mGwh1wU9WLKbZX/tr3Tk2VlwFc9O1DJjzy0w3noCV8OsPK1P
 bO0Ck0SWmIbcKFU2vRLn66PO4x4NL8DSqyTkF8duQEYO7x9Hv8qNItlO7ebd28xurDyowGliATX
 jD938PcJTNN0ISk6UFa1N2JJRnm7kFO6zQ8yQRfkWQIGzV1U19RuLXZIjlRlCr/WZQON5hl9ldc
 EGQFmpBBYLBXS1r5Dn62ZyQv9EHrzyMOXm/vzpBnvs7g/GtOn/Oz49v/rwZDkhPdgMvU18MilpF
 S0+oSSMfGKRt2EAWs2pvjUDifaln5/TV0LRTAkfwsxpyscf20TvvynhvTWNgPDpg2akB4a32xBv
 5tXsM/jT+7WWznwEbEIVetmEN+XMfzrgoz6icm78NLDYkg/4C1L1l6EU0yXFoXq14lEY9j0708f
 JR+QgbHfrmBsqgQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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

Add host_to_target_semarray() to convert host semaphore array to target
format for semctl(2) GETALL operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index d1645db46b..65fd7b72e5 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -68,3 +68,33 @@ abi_long target_to_host_semarray(int semid, unsigned short **host_array,
 
     return 0;
 }
+
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_arrayp)
+{
+    g_autofree unsigned short *host_array = *host_arrayp;
+    abi_long ret;
+    int nsems, i;
+    unsigned short *array;
+    union semun semun;
+    struct semid_ds semid_ds;
+
+    semun.buf = &semid_ds;
+
+    ret = semctl(semid, 0, IPC_STAT, semun);
+    if (ret == -1) {
+        return get_errno(ret);
+    }
+
+    nsems = semid_ds.sem_nsems;
+    array = (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
+        nsems * sizeof(unsigned short), 0);
+    if (array == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        __put_user(array[i], host_array + i);
+    }
+    unlock_user(array, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


