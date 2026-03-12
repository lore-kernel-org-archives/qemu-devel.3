Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A261C105A59A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0fow-0005aN-Pk; Thu, 12 Mar 2026 09:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1w0fou-0005Zf-IS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:11:20 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1w0fos-0003SH-MG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:11:20 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40974bf7781so1736613fac.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1773321076; x=1773925876;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6n+flxHqynR75KQOSZZUX+1j5hYBSQEjDVF5W/wAj2A=;
 b=m99ZcDSBlOPXqRX9c5ecc1ANA2Xtf5zJyNEy0B9sojlhJP8rfhd8JGqr4SCcCUK8Eh
 D4hVzFzhv9mKdgKwfoiskLSlGPUMaDRaEbPEoo5xz6FzJBtwxfGuEkN3Mv8rRJ4y2hCw
 GsaF8rRcGcObwowaeVN5iW82o2haRoyfIrqpiP953HqJEgGggbKFFvjoeVOzk4lKv6DF
 +9vH7kBqSYmP/fDj2hwJbYzTSLq1IogKduRXKCVnhpXur7Cb9OHITmQCwUjN8pUrzoYY
 F65XqFtMXQAOkyZn/7estZNdOsDRB85EOmSClJRBzuhZEzgy6WRg/SDZNrllRYtyVddW
 nC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773321076; x=1773925876;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6n+flxHqynR75KQOSZZUX+1j5hYBSQEjDVF5W/wAj2A=;
 b=nEx0NkqmoY1zQsT3E002Kt1AwYPDUiKfS8ipnLS8PROFIlC+dtlhRSPabZ8IxL4ZCQ
 cl7AlgTKAgSMwmrChxT1oD1fobNYatmv/CuPgmg+jHqklW58mF9vh7yulUb5Q0BcYa2d
 flLewm1RtuZJEFOZi3rXz6gSgfNcKtWKd4+i/qk0mXZcap6rCUEg8G3BHnNL1z8Pp2+I
 sap9tSTjDtVyn+gnmuZI8JoC0lExU2S08wC3j+jL1usau4C7nPim9QVVa4ZiNMuu6iSN
 /iggBGHaun1ggm3sXDuv6LNKFGnWcR7xnJD/xkJ4x8I4BgXQugZxSdZeNZDsnRvQwYQO
 9DNw==
X-Gm-Message-State: AOJu0Ywt0WcoqQlXDM/l4JlAcSoVxzt4A1r6NZgjPHrlutiFHsv1R9+P
 ecx/s6LYtWLuV6wNYTrH0vhgxXxXKPPthh6oWylyJjAMG8iaAJMT9JbI+MVusQUJRLI=
X-Gm-Gg: ATEYQzxjHF7X0oIoXxaa3eyUM1hcZvKmGrZa4Tx/a1fJrgOLMNpUKosplKEY8QtvAKp
 VEV3bEif4xwJgJ+1/dXbJbyKRuBAis9OKOAW4QHhG2EpvPFbxjGgpPoKX1pGk6GtnJgAPVeq/lm
 dTG65Azy7vq1Gh4Da3tRCon2J1BIbHmpORNz9ZCZHwWWOj77XEktZMu/jpPlJZa3YN4N42Qfe8P
 ijClXKrSA3+q+My+9UPIxc1zEuAz2IfEEk+YreCW+tibvURfZnZA5plG+PuOC9JpSgDPvbN/dw/
 R9gkzRUydTwkCkdAjdg+jE6E56KiDFjrotSVuqHlNmLxg1G31RV8piT5LjEGJz6z1ItkUKs/65x
 xHQf79ZP7ycFR7J2g6kowrbjtmfVr5Pw4Bb4sVWwsrat9bLUTSvHtS6mlGXKOYCD+5X+FaV6zAZ
 8JtRQUAQT+MDMofPGzdruc
X-Received: by 2002:a05:6870:c10d:b0:417:1560:e2c7 with SMTP id
 586e51a60fabf-41798e0668dmr2018190fac.1.1773321076326; 
 Thu, 12 Mar 2026 06:11:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e9f53sm5342083fac.13.2026.03.12.06.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 06:11:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 12 Mar 2026 07:10:51 -0600
Subject: [PATCH RFC] common-user: Share thunk.c between bsd-user and linux-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
X-B4-Tracking: v=1; b=H4sIAFq7smkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mj3eKMxKJU3ZKM0rxs3cQkQ1MLUxNzc0tLSyWgjoKi1LTMCrBp0Up
 Bbs5KsbW1AMTww+ViAAAA
X-Change-ID: 20260312-share-thunk-ab1585477999
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=hzQVSHISTC7zdIW0SvKg5wh0j8sPKBcbw1Au4yV6n+0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpsrtgNKWxp94e9MrOvbbCcbBZ6A5pZ/A8NOGUe
 txE1REAqqKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCabK7YAAKCRBsHNEofbAR
 AMBPEACAv/Ktbw6f/eIH1Ipdz0H5/K2VCjBkZoMyXd5kVRfKB27JTJDyE8EdeVwuRpqQ7Pfexj1
 zXYaVU+rBwzp7AfiT28pr0sY51pTIDruAmiowvwvBeuIjAmUtX9eoMbGC7ZTatRkNnBBTffHKKi
 b2nioL/MkLdsOcJ/2up9I1IVaNFJbb9NdwaBR3gzjEt33A9YjYseUhmDxvtH/P77f8dPLvhyZYd
 leZuUJ/fkm4YmkQElZX2C6ebuTrQophuppBwYlWWVD1RhZybVJm9w/p1epSlQuLujfh8dQktP2k
 btUaYl0OPG4BS95Vppft+v0nN7CcrPZqv1nUbHP++8Ds1H/EYKhpEyoJ8Zl2XY9mMoMpaQ6oIIw
 XSsN0GI4pbhCDNIjObkqY1y4a+MsuZaPg+HKV8TBiCPJoUc441JoNxnFTS+yebv+0dRfVhgryel
 ISQT4eXCpPlzyM5Xs6qIaG+Qbpf4st3VN2skRaIrxHlcsVgmdPBUYsPUVKK1bUfdrKl5ra6O8G2
 +3LodCLMKKeIffxzB8vpXj2sSdySj4rtyNCHSU8yvbJT00ermMSVnej93IzU3GMDTxACfT71Pts
 BkqmUlWs2u94kO5QTW6RsbsUKNoBFWoMQKrbXQ0f+IGvxIrNwlHcQ2o7vqGYCECAve//cV7zfvS
 Dr278BWDmjVpjWg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::32;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x32.google.com
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

thunk.c is the same between linux-user and bsd-user (out of tree),
so share it between the two.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
As part of upstream blitz bsd-user, I've discovered that bsd-user and
linux-user have the same thunk.c file. Rather than copy it, put it into
the common-user directory and share it. It has to be compiled
per-target, unlike the rest of common-user, so modify linux-user and
bsd-user to grab it from there.
---
 bsd-user/meson.build                | 1 +
 {linux-user => common-user}/thunk.c | 0
 linux-user/meson.build              | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 00428fc2f8..c19b1f37a7 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -17,6 +17,7 @@ bsd_user_ss.add(files(
   'plugin-api.c',
   'signal.c',
   'strace.c',
+  '../common-user/thunk.c',
   'uaccess.c',
 ))
 
diff --git a/linux-user/thunk.c b/common-user/thunk.c
similarity index 100%
rename from linux-user/thunk.c
rename to common-user/thunk.c
diff --git a/linux-user/meson.build b/linux-user/meson.build
index 332847a621..f98b4a62cc 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -17,7 +17,7 @@ linux_user_ss.add(files(
   'signal.c',
   'strace.c',
   'syscall.c',
-  'thunk.c',
+  '../common-user/thunk.c',
   'uaccess.c',
   'uname.c',
 ))

---
base-commit: 769a37d8bd0c81c39128fc292352f01bad0769f4
change-id: 20260312-share-thunk-ab1585477999

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


