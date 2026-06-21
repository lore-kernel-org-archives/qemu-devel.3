Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2F7CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9go-0002t8-C8; Sun, 21 Jun 2026 00:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gl-0002sU-Fu
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:43 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gj-000513-5x
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:43 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69dead44101so2844904eaf.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015698; x=1782620498;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fzpwJqrwWAd3VFFYpaG8wAf+Nc1z6/55fHtqwLYrqxM=;
 b=dY44YDjy0oG55DrLq2IewW1stWYmQR94YrhRb+Vq87W+AHOCbrileeQSouRKeCprCI
 nNXcwbC5+LcVphbGjtRyKezQoI7nHE/F7Y3Ogh0OIfsa2fnFJzmJdUGpN//VmBa43bzl
 URpfQLcIsl87gdjm2n2zQpgaUpRVwADjlby4KK0HG1zWXZCytBZOoSqYlMV3A/p/UH+u
 x0sANPHOAlJZzcusj3HpoRfR9znbPAGEi5IOVOvZcWDkdXr6s6VctxJiIBiDxQf4sQLI
 ER/BonkIHYcmarq8bYhTLAeWFdvwVsEkwxhblasfVrW0fkhKgigqsSnOy4KgdOz7Ldmt
 4MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015698; x=1782620498;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fzpwJqrwWAd3VFFYpaG8wAf+Nc1z6/55fHtqwLYrqxM=;
 b=MbMUt6+hwWsui4+UVWfW/Bd/Eu6JQ+6nBemOBwdME5bPz1Tqz0vNaGSF8hctLOmLyb
 bvvfsLzeVAcyJAUiRSAvyqTSqOer8i24uMPRQTL8/L9cTvALliLXuc5jdD6XoeHh7Aoi
 M0YgEd90HUcr2uQhp+zXUzfPwuhWxb/iuGA6659p782Dzl8SK9sqD5C8PcqLHbrFObzk
 6jIxwlVvmaTjDI7JLPW2IE17rL6YroSR43oYe/LblHOwQrZVS3pcYfKHTqnBNQ3HY8MF
 E5uCfQUcE+AsmLchJM5j5CBTuONY4dL78DeqE31v8o4D+CwWweJs/TcxFxrmw0qD0guT
 H0iQ==
X-Gm-Message-State: AOJu0YwtZl69Uht0zfj1ks9qHFb4dZNcSiKWn8gdDHpa7sNpFSL/qiUa
 p2HZNYETlkkY8FZNJrfjChRgdLX1rJEmkkd+LxevK/aoktb23vkQzqESqITgibw3+qa2hy4ZnND
 9BhYQCESZ7g==
X-Gm-Gg: AfdE7cnz0toSu6uAhsFtOQYigbqNnqO++SBnZ9+920ROL5sCPcRih4MGAlZMsukMImJ
 QadiD0xXMNelTS1oREI+q7jUk1A81eSzTeXnQK+kVwPs7b5Mhy+KWitnXo6JyXtt01s80q2ZaGa
 GzRoymKgfZQUTT0FIMdXaLW8qZ3654ZfaQvEiRf21Ckr2I6XzTfQUhEbMVz6jLkekaFwfGTg7z4
 Bf0v79OuoSE9sNW9NrHQTWeBTZXVRQZgyPKiIJJoXwyhUBpz2H2Xv99ubfyN8O9834JGorGvfl+
 lMrkXCvjbuM0rfBK0ClV2jWLcZoXwTtc0fvyYS+ixKtYNPiTwSiYeeYun7lWHp26n3lI3klnruZ
 6+qSinklu3voFRo0Otp9T5cIB0KtTxnb1izayJL515v8vncv+UR4r6/qNUp5Jz1J0lhS073EPkP
 w=
X-Received: by 2002:a05:6820:4b86:b0:69e:9d90:4b31 with SMTP id
 006d021491bc7-6a0d893f0c0mr8525579eaf.26.1782015698588; 
 Sat, 20 Jun 2026 21:21:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:48 -0600
Subject: [PATCH v3 01/40] bsd-user: catchup to locking / mapping routines
 in bsd-misc.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-1-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=KM05tZy7MozYd/zz06WXSb3RtIm7HHqGMQ0kCX4eSvo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z804w5eHy9TZ750O8jT3A9K0PgdvuL0e7Ym
 BgCXz/HUAuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfAAKCRBsHNEofbAR
 AIG5D/9aWImU7mDMHbqEtefZhZ1ReAU3oUqcr91GyQ6s1lCFWPS5dAg7QZ/G+AjsxPVU9I3E9Ea
 oDOwwyYM/5XWh6sP+Hozdjtocv6Qm9f/3X87tPdQyyYup+gfNY+oGK7iwbO4lfdKd3mpH8idTqR
 KpE7bO3jUZ/DHOOfhcvaZcglRfw6s4yFDocV/CBxuGJX2QmRACMwB9569mKrXajEs9A3a7SS4ms
 72NkxgHcM5rVJGDdDkqwYUshD2nGc7l+ljNIzHTAEb01kpmDjfEY2JDT4ss9UG6SkYk9+yzD/XZ
 OLOvayIq3U2mdT871LEvtz5jdIbbr74G/0JPOR3aD5+Ub/LwWd1kL9lKn1n4DbhdJPIigRXEEtI
 C6FbAwQ40NxGTH9kseLThdd2rbGvnmO5hHG4GJChuT1qAc3UP9BXblZFEeFtZgS0YYXMEA3ttps
 Kwqbdqac1XuX1zIWMxLIi0SfxaDm2bxRUdT+127WPGsMHhn1E9xowxL34zuzBxITvT2jHYoxBlc
 WOHqbjTnvp22IXoXlALdE1EcQH7vjFoxGUJJMQs/dPMrU5pmjn6eJU8liw2thTVk7UYOMpGl6KH
 yx09/1WUqI1wN26WIVnXh5SukrytBCkcfdA04DWxoR1xedeaKKxzs9qXLWjm+4hViOAVG0g8qhX
 /He7aH60jP6c2CQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc33.google.com
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

These were added to bsd-misc.c in a prior series. The declarations
logically belong here, but aren't strictly needed with the current
structure of the code due to include contamination.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 756425d18e..f7c8338213 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -32,6 +32,24 @@ int host_to_target_waitstatus(int status);
 void h2g_rusage(const struct rusage *rusage,
         struct target_freebsd_rusage *target_rusage);
 
+/* bsd-misc.c */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr);
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array);
+
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd);
+
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr);
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md);
+
 /* bsd-mem.c */
 void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
         struct target_ipc_perm *target_ip);

-- 
2.52.0


