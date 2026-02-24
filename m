Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564BFF3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbJ-0000rB-PC; Tue, 24 Feb 2026 09:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb8-0000gu-Gm
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:15 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb4-0001KR-Ij
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:13 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so5155294a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944068; x=1772548868;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KyAAySKGEyrx2ixnnRFGbmSqIcx7VodIdDffNZU+p9w=;
 b=PAmlG54gFHg3HI2np7uXEn5N3ubLetEBzPvAmuZl0HctFshrz/e98gL9aaYUVHc4c+
 69HhX1pTi6sESqfqGaAyS2jXanmCFYDejy8ZsnSljh9NbO1s4IDzSWhJJFVgSYW7pxWh
 dYSl71QX9Z7HAuFkKbOBsSO0nDtOAFdEmibNILMFZUfT1cPC+jEsIaLUNQja8dzaldeN
 vgk1nAxZICCQy8wFBThavnjjiQjF4IZeXRWN9i/je8e+GDS50QK+7bXPSHX2ziVWaODe
 0rsJJtZ/CkkOGyMNIR54DpIBIrY3pdsh4amX3zNrVolAreMllKDzzc5ayTxHyk9eZhwg
 zz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944068; x=1772548868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KyAAySKGEyrx2ixnnRFGbmSqIcx7VodIdDffNZU+p9w=;
 b=BXnxKWCHtQ3nw24YV8+beTVLdXgIOnhwN+/EKo20JDWoiWTzJHGlEpB9txjaDGg6UH
 AS2g5pxhwzbHa/Rg0yBKY3rOfNcdN2xFhCUa6WaiLRWVyLSYyjiXXEZZlwxkPWpgxUVu
 eM1sQcQyO9DJ9qQhObsi3Rv3zYp9Rxa6Ho9v5Y/a+MMiv04NJKSlEiXJmetHWCOeun8b
 1O04lpgqzMgkvg0y8RIkgtObqSErF1NzF/ev3EIjQpyl5ZGxd09k3U7IGyEq/HbEK/5s
 J03CjcesNbWbJJxG8giPSZ38/QjxeYb7prK8MACZjX7qUCyRMLlJ3azxpO44P5zvSXAs
 DCSg==
X-Gm-Message-State: AOJu0Yy5QSwn4dD4vvPhmkV8yyDtbuF2/MGW9UYfJr3PH0jlaDC35Uua
 J0RXYAtPjPSGLDRZH3grFqYoA33pNP2uL0vDaNHSZfadE7nauri99FU9vTkozIjdcAV9lkvmOmM
 Jm/eb6g4=
X-Gm-Gg: AZuq6aISgtoic60edkE/85UE3vPOcDg2cs4O7+2MWRG9olXGYs801AmPVnBNeTxcJiv
 UkQUIevG9K+DLqpFxenhabHgMQgT7fYNz+jEGUg5u5Pu4SaUk4v1gdv1AMISVhkRsdfPKwIyU6R
 WhxJWK2Yfq/7/IjuVi//5AjwoIGl6SfZpHqkOWCz/edpH4uWhfwqJ4m6AawhnXa/Mo+byVC/3Sn
 9Xg8IwihPk78jGLzORtGRyBXRNNPkrB4pE7/gWQl6PDrhZvn7D+RkIJ101Mlj+PhVeA3PXRhApn
 8M41GcD4eSK+MD1MyBBg8Bpl7YNR08iy+VXe8Rg18PXb5oMayV5jdmYxEN1zXYPnupITgXapNEm
 bukyYbdDRyMmhF5fuYp1q+S4HjxVwr5Sm8GkEPpZGiPAvRGxR5MUrEEAWcrIJqx6z6RHOCKPO+4
 bz/cioEaKS/A==
X-Received: by 2002:a05:6830:d13:b0:7c6:cedd:8bf8 with SMTP id
 46e09a7af769-7d52bf36eb1mr7353200a34.27.1771944067974; 
 Tue, 24 Feb 2026 06:41:07 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:07 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:46 -0700
Subject: [PATCH v4 22/24] bsd-user: Implement System V semaphore calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-22-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=G/MtAZXxblLExrmekUauAECEshkdpeArgaMJyuYCSAQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhoJyhW5gnlzzleCCAkU6jk04mynRyU2qHun
 PgWTxIlyuWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 AOLuEACCs0rkrfX82A6l+lYQIqazwbXrOzSrWGQWNCbFg7jpOnWFuO/4U7A6Bhn83pV2fdLyOgI
 f/imFDMEhZsCqlWUCZ8+Vz/LiWEvaucdHHKyWLDr6C1ZK3+OFuYwk9JCQCM3zF+FpZ1WD3Ccjzk
 9sPPB9e11XRLkynNM2TxN/gi6Dna2JHQgDKPgspB5wcQDNFhLzwvnwyMGAGlk8riJpyDCa4HGjJ
 jMuriAwlkyObj1h84l1YdOAAY6NFfktbx2RsJNkRYORRHXyDPK5U9j24dCwSKKZpZn+VBrj2aMr
 relaVg2A/0N9Kx14C22eN08bewJ4Dlg8N0QzYAuuRrEMTc1eVipXUbs+hsGhn7+EfjB+lAkHscX
 MLXk2aT6HSjQ0kA492r7pbE7bNVEM/ELN/lfUOT2D+gLUIL+XdCfj+uHj0pYlZeezimHwlajmp9
 668mHCKD6+KK4OdsX/iQ+jXolJOcMKqWYWIbzLNcFF6MGW3qm+3T/ol/B7nYssE+XMGBYaol1Gw
 1uv+lEAsxEgBGAg9NlytTHFlel/eiG1oitVk84ckkcBLoIdkq84sDay1G2l99ZNLakBSPBlYKTV
 mZL2NYb7Z2M6SNKnwTeBDkfPe2YC+uf1Y5BL3SUD2MfgCzCt9sfnkSqRsrY8HqawIh00MtSXVRT
 TJ/j1tL277bdvTQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Wire up semget(2) and semop(2) syscalls to get System V semaphore
implementation, as well the undocumented __semctl used to implement the
bits of the interface in libc.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4c1191b8f4..234bd78fd2 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,6 +36,7 @@
 #include "bsd-file.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
+#include "bsd-misc.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -878,6 +879,21 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+        /*
+         * System V Semaphores
+         */
+    case TARGET_FREEBSD_NR_semget: /* semget(2) */
+        ret = do_bsd_semget(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_semop: /* semop(2) */
+        ret = do_bsd_semop(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
+        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
+        break;
+    }
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;

-- 
2.52.0


