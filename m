Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01A1EF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpAS6-0000uP-8i; Sun, 08 Feb 2026 14:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR8-0000dN-Az
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:15 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR1-0008Vg-9U
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:13 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-662fc35291eso2043783eaf.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578794; x=1771183594;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M9xNPNbqhv9/vF8wZcWfITjl5wHDmlbZMJc3LNdJVtE=;
 b=RSXi1rHoydZ3RcULbjELeF88j/LFZpQBHFAZnEq4qGiicWsM1UhtzNq0p5jbh75pqU
 wMV4JdLdTE79PiKqJq3vBoRdR76w7TWR7iQwEPPH9J5erTNWGtXYn4gmZCKUNrFv06Ru
 rc07gFa6g3Hb+opWKitm4VOGfMTz6bBdyl8PhBWVFzXdVAzxRzdd5RZ9uECkgKp7ptid
 CS8JIk3h4JUgpD2fnSrS/cr+9DXObhJ/mXG+HDeMZcMKblObvsEhVs+yatiHjtp4iWhz
 ANA8PE8Sf4/syS1I15HiLaRIKVZQCOpTBSaS5DRdFt9FzAnSGTEvvCvis1OG8BmiEJVr
 kddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578794; x=1771183594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M9xNPNbqhv9/vF8wZcWfITjl5wHDmlbZMJc3LNdJVtE=;
 b=Bv9e0J145aQB93XgNsfu3exdpQE5vGXAU2yN5Zzybay49qZBpPwzSxksozaQ+AQBbE
 MJTg92FOaikWHWFMcNFZv3lq1bil5JVyIcoS77CIdVBPslWEeM5fUMT8SjBhH5zxBkkq
 vW3LZgVehJjvocAyZXHVXx8e4ofB+enLGlkkpuBRpiZitxGjTirOLeMw14ZSXTbAul34
 dmMMSuifCM6FBmatzRmS4ZVOGS8+g8jbzL3YsliqD9iwCB7oHuNTN1W1aIMX2By9Y7Ow
 cHC1bZtFjJvhJk5LNcEfst+kFGybKxDpUSEjRXyfznaxYBXVorqelFmbOjqogtFSdcW0
 dFvw==
X-Gm-Message-State: AOJu0Yx17ihXUnqXtqP5nFU0+pN8nom/WXMMgeEto10W7kraFdRV/B1g
 SHYkixrlltHVeNaOoe/qcBAs0ojfleWBkRIwQH9eThZTLQxQ/U600IF/a9RXFsLD7Zg=
X-Gm-Gg: AZuq6aJeoR1XjORYUB8ITUMcVfFhOWBXp0S408jHxZIQmqG3bxP/2pqfzQD1EnojuCo
 P1pAPKNZzyLmXWuWFXkvfN7vWCF1jQdBtZMoVHgKv3/ruxaiIpdwrakdEEJ86pNl7dLc0ag1+Ld
 4VHJ30wzuW9C7szje2okKhU3Y/fIyrbwNk8LS4XvzzxrXlEsWtABhSwBpoZAvmjqZWOum3TM46i
 uH+nb6rPfFbjPJAVaTzkp8uNZInYI6XnfIWHOhvY5iL1Ie4vIk1UA5BOizgx6lgqYkGlU6pd3/U
 EKLL9ZpTr5b37piR2qiVyFtPU8aZKvtcnpv8EM+JXOMN+M1/kcjTbIVaDg1g9EBWUu7o3oqoPuv
 th/OWWfEXLWBDlrGl3/jgbhNLZaX/APCyWnJhoKNbH15Yd28dYYo51Ri086pxx9uMIE7srWESeA
 ==
X-Received: by 2002:a05:6820:151d:b0:663:42d:6264 with SMTP id
 006d021491bc7-66d0c94e10fmr4301936eaf.62.1770578794618; 
 Sun, 08 Feb 2026 11:26:34 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:34 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:17 -0700
Subject: [PATCH v2 08/24] bsd-user: Add host_to_target_semarray for
 semaphore operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-8-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=KKOm1kO5SVw1eTG/QWkq8m52uXQzMN2XHbqGE7/xmA8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgN1AkxuLeoPJF6UvGWY2wzYQNIXJEzCo5e
 Ox4rq2RugGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 AF6ED/oCcNDMSqqWFYM8GLItpiuF85fbv+Ntf4mc36oE8Ti9Jdvpt6dJxnPBo5cxqhVD4K9shEo
 6zvOLy1v213zDTSDR9ATE48kDU0sIMZmiuU+ghG0Ms3LJu6jc9dhXTumO0Q8gJfSDef8IHl7WK9
 5PP0tEfwAK7ZqDCWkVxqiiwjTtak0KruaFPYtq3z6T7GDffMZECU4NOBXuiLGcSd3GWkeBp5Wns
 Ac2WZIMJjMJO5KnNwpdMnszbxfh9g7VF57ml5nKrUL7sMsnJ2Aa+O+Joic+EUWOV4k5cpwm+Rpb
 PEExGv0ovYoLAremEgrokSq4CaRae7cE8lcv2r6dRN7UXEu4ptG9gPuyMgEKTS8sV5iprYw0963
 tZNizcl3CnIbIOq9sT34A7309qnDuFSQ29YZb6WYMLK96TxtDqPOOFIQA/MQRKiowVYEELhV/Ky
 jyjoZnt0aFoY4z4i3Td+udSoKSmbYmPEJKeRXqUf8NEhx4CSifJr57hy41NNYgB2cat20OAtDe6
 1ox2g+4IjY+pC2/L+048uLRWp/qUc53PEt6dB8Erosetq7cPBKfKSH5zum5ab8EzrLgTVbAcp72
 8oR5wRKe8C2iw8zCPiX1zGjf+codJ1HJg6wQhaDYA+8RusUFXGq/pLpEVq2DBuVy3iHEt3BfWUb
 VuS2eQ4hcOO/UmA==
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

Add host_to_target_semarray() to convert host semaphore array to target
format for semctl(2) GETALL operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index d9eb87db80..677cb49d27 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -79,3 +79,36 @@ abi_long target_to_host_semarray(int semid, unsigned short **host_array,
 
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
+        free(host_array);
+        return get_errno(ret);
+    }
+
+    nsems = semid_ds.sem_nsems;
+    array = (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
+        nsems * sizeof(unsigned short), 0);
+    if (array == NULL) {
+        free(host_array);
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        __put_user(array[i], host_array + i);
+    }
+    free(host_array);
+    unlock_user(array, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


