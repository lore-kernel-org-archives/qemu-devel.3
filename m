Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD2ECD994
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38C-0004TI-Ok; Thu, 05 Feb 2026 12:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38B-0004Sd-Mp
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:03 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo387-0001QD-OD
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:03 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1866473b0so611529a34.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312414; x=1770917214;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NSplLdDOuLYCFBg68iBUU7au8Vz3E2AWM5FfBV8sq4s=;
 b=yW0knLw/gI7H4AwCtBcOFHEl30WH0o28NKDDSrAWrojHfBEjIMUmPpRrEr/I6S/FVy
 pmMP2jVeLtqw3vHMNMVUX1GeW+acW6HpCdMkbchc8F/rieO6Cgy9RstwhqfVfyd4egFE
 7z7U6tcrzTabG8N51s3pvmqyf+pnIUKXGIgI5HET29PvG/bxtXj8DSsbB2j1lyEcFn/3
 0VzmBIkeIXH1ZJvoHTWnR+2XLEcLbdBO6ZolzLmdZeqwbMKyCjZBPEttVVV40TF/RpmH
 3pcXM1rstZrqTjx9onJTKWMUYw+yHGYMjxWf15gbEacW5Q9+5cX/gkc+hS6dAUEN4itX
 TexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312414; x=1770917214;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NSplLdDOuLYCFBg68iBUU7au8Vz3E2AWM5FfBV8sq4s=;
 b=s+zL7lRBMwfsOMnnfBGhwHXjI4hARqkGosS6HjjAsFFp8Z69I4ZqZrGxgiGFFFn8ND
 SD2gmoapjEzNj0SOfgLuenl0hkj1aa09t9bpLCtgLaGimuxFHsJUGj6Oo5iIAXz8rRch
 UteR+jaYCqq0W6yOW2A4oJfXrtto87eMDsxJC6pjVWhoY4Ncl6W/UMeYpse9bq7/TvIx
 uyzw5ClsEaJbsVokMZmL+RjZ9wgsq/U9YLnpsZp1gM5TFX4RHC2Mkp6a6+2/S806C9by
 dqNTniY5MH4Tl6SMJ0CSm6qM1UWJi6ZsgsN3YF7W4YBR0y+mwspgmYXhkgUgFtpuKRZi
 OZNw==
X-Gm-Message-State: AOJu0YzrtJE+R/ixE/jpC2oii2Bk0ty8fATXUWucTuAFwxue9WRZFH55
 jVNQ5BjNxHNiU2NsCzXgS7PI7f6U6RqUJlyGOpoVXRXdu5KcbSl9Ffv+jUOFubUw2NU=
X-Gm-Gg: AZuq6aIQj8CO38SHzcUqlrBkEFA7l6RrmNicFlBYCL9RgIt1PvrLytk4WoPWqqnOXoB
 WqSC9D4AjQ1LRaV5co301nCIlOcFF4Nfn496DUMdX7nxWUPRJwnegE0+4dqR5Qdqc7JM7Kr3I1f
 28JRhXIDVzGAtj2snBcn1IePTUyblEa4oau8A0LvXL5TyyQFl7d4DVmrTP+Yrf6OSKXiAxDxhPy
 LKnnpuxVkNGXeLKDPHE/g+8a/z2Lng+D44LKiaLmaZL8btzQelZD96MEi05mvwKWFTfj5Fi0Pa4
 /j/ulOrbXVFUnTsVScLAjMaBRbJ2rXvFlXZl+N3sBpMYzdVyCZvnhLlowUo4Kj9tyjECfGoTqdi
 UERzBGTGB7IYykMz9iStPdMHlGmoBl2/APeJ41arARfqn6FrCAdxVWcmg5T5ox1YbNzE4osLzDg
 ==
X-Received: by 2002:a05:6830:d13:b0:7c9:5bef:ec3 with SMTP id
 46e09a7af769-7d4489a7395mr4512534a34.12.1770312414261; 
 Thu, 05 Feb 2026 09:26:54 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:53 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:45 -0700
Subject: [PATCH 12/24] bsd-user: Add host_to_target_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-12-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=3hpc4zcdTmYdtYeFdjXrSPsRxTUOn6kyxap64nQnBQw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLaP2Jj+UjHaDtX3QOdd/OCHXYZqqjlMTWnh
 S12K/T9D2KJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 AJCVD/sHLPEEFzrkycApVC3nTC8ymjne6vdpPYFHIrMxdRaxChUilbDjqX7WuZ441lF4ngPSaZg
 U/QLkdYrogX9c/1tpSig+AfJ7hDXwoyjh1CrElHoiMfa9Oo20B2BhZ6ONvmykWAFlY+KyzFnS5P
 Q/03fRGm3yPDU4MI09ZqN350ElG9flcHYp+N4fxLpKbuZPNN61Xsvxy9e3Dndz0bv5am72kQ5Uy
 zXJuH43+Hi4pKXOf38LDZ6zcs87GxNdbqLsqT/csbm2vF0+9qI5MStLlD8XJchry8PIELCL2UwU
 8Szj8fTObtUdsN6qlciSzWPTU4LzecYzEx1J7SSAlRc685byWz7jNC4fLArDGdCo+hAGWZ4Ljav
 C3CCJ2v+5jx1P/xdSYnDnELYuWiwMMk08JR2Q2oaetnRZoyPKF8UAP4lAmrNQ4n6chcyI4mj9Ik
 scVqemEWyHLpLRsBQ5PztuuMPL2Gb/onmSSHSKy4ngtfX9dWsfx+Zi6SzRF/aabWvr+HSG+/KhK
 G1dbuQEcswE5NOVNi268nk5WAixHwjJAeEW9YmM0n1TLbhrKJdaTaO98q3o3KWwwc6qzx7e2kue
 cC77Spkast8cs0szrffQ2riu2hMyA3+iKvJtMEtD7C+hwxKral6g0/oqIjR5fjV4skna3EJVCBt
 gAYAVNRbidPWn9Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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

Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
format for msgctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index e7031c5264..03773e2620 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -187,3 +187,36 @@ abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
 
     return 0;
 }
+
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_md, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(target_md, 0, sizeof(struct target_msqid_ds));
+    host_to_target_ipc_perm__locked(&target_md->msg_perm,
+                                    &host_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    target_md->msg_cbytes = tswapal(host_md->msg_cbytes);
+    target_md->msg_qnum = tswapal(host_md->msg_qnum);
+    target_md->msg_qbytes = tswapal(host_md->msg_qbytes);
+    target_md->msg_lspid = tswapal(host_md->msg_lspid);
+    target_md->msg_lrpid = tswapal(host_md->msg_lrpid);
+#if defined(TARGET_I386)
+    target_md->msg_stime = tswap32(host_md->msg_stime);
+    target_md->msg_rtime = tswap32(host_md->msg_rtime);
+    target_md->msg_ctime = tswap32(host_md->msg_ctime);
+#else
+    target_md->msg_stime = tswap64(host_md->msg_stime);
+    target_md->msg_rtime = tswap64(host_md->msg_rtime);
+    target_md->msg_ctime = tswap64(host_md->msg_ctime);
+#endif
+    unlock_user_struct(target_md, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


