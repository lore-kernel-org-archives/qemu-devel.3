Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7C4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnhi-0007XJ-As; Fri, 31 Oct 2025 07:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhg-0007WU-A4
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:54:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhT-0005xn-JJ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:53:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b64cdbb949cso296177566b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911622; x=1762516422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bhb1mLqXEKSAcqQYNINu1t3UrGPOjAbAdi5xoc8QmP0=;
 b=Ip0LmNMldirDsbhcHpovIR5KWIyXYmHUZjMSYX9V9TqJit7cBGzblzakRva6/9wh5/
 QLTsJ6oKGSez12AZB3fX8EbbvfHHFEHXWSRxPMbswxMBTrSMDQl4AvXBvI2RaAr1O+mF
 ahOgmOI8wJW1ok/hP4nvrfRnj1D0xcRdQ6ohluTMzdqYU5Lnz8fgU3YVK/jl81k5LxEO
 mKMelCzLYQhYeeB5ZgqqIoMwa8GnRfGXTyZLHI3GufGwf6Bd0psGdMHwgp4o6mD31ZE/
 Ije/gZJClcEiGzfzHmyCTSnqkrii1yuQEt3gytahf2vCEZIEPXqJb0mymN52V4TmuqjK
 SzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911622; x=1762516422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bhb1mLqXEKSAcqQYNINu1t3UrGPOjAbAdi5xoc8QmP0=;
 b=reTaUBjt/mbpFAi1BGFLHV5tK45jcrSvt12HH8ujiMiRzeJn3jxKO5yrBkmmu/jz+P
 lLmoSRJkW+rUn1xKeLmBwRvmbdp6dljalP6eVBagWjRbH7/BE59P5+vu9fbP5ozVVjxA
 Fi9HloBqd6nDRu/F33Jxw4c/HZCdxxz2Zvm0UAkyz3Kkl0lxs6J8x+clrOqtnNcVVfpN
 IQRxmUJvVbBvxTV3OZfeiaCZkDHOwqoul4/RvyVeaCUyZv0I8JSqoFjMkjyhmhzBjO9B
 eZo1lcSf19vPw/OsrDMJzABR5xZiLJSpg0ENCRU9D4rxvj/9V3wkFCavNIClui6+f0mR
 pO8A==
X-Gm-Message-State: AOJu0YztZxClzTSMoEg76d1Kjr7hZ+LqI12OnhkuxUbkXV/47r1YFY8y
 KSHkMyBeox/FYQ+v9PL8JgPFBLsGGQSVG0FuEQ81L8S7K7HVn68L9d37cj41jTjZM1NM1BcQHLE
 tUoezdz0=
X-Gm-Gg: ASbGncv4nkORbl1UPR/ADnXjUjBk4euNAhjAAphrxj7g1594SMLNdy8eCkbVsLrcJR9
 DS2ROYkoGjNdiYTQLCS6LyA9+WRS4ftuSfaLD8wI60mFT8smg11RGJkjFJjSFCejzfy9aBypO0j
 mO6lO9bfHk8ti8UcoJXzGWxCeXLcSX56oALJQgTAvXeeMf4r4aEvLKTKtf8GoBbbjKswEqvchVT
 GVD6dwlsrDF3XgJygg6SSD7fFuvK/gwKQ7QaGkLO7Alc7W4SPZZfkMDzLxggH9ZnGi4gL0n+M31
 OlgCV024ulz8TvzN15ylGfzZB/e6t+3kLSvdLfAT+PIjTebHCDsdmN4fYX78rHiTTMsxJeImk4b
 eqxR/wFxDG4gtL95SdoVDabziJYOI2MnqDkcCgLKPXWDPqzQa4VZbikGJZfE1YJdA9uR5XMCpp+
 zaX+k1XKWhWoSI8q0P51E4QZqFll4ui5L/NJORYHJUgHsBCKSnZhk=
X-Google-Smtp-Source: AGHT+IGqOfCuNh0p5dlHRtEFaQ6JHb40EqLUxtD2eBZvU39BAGxep2muu3ZFX0lgC6Saiajh59XFJQ==
X-Received: by 2002:a17:907:7294:b0:b46:cc3b:65f8 with SMTP id
 a640c23a62f3a-b707061e145mr327077066b.45.1761911622357; 
 Fri, 31 Oct 2025 04:53:42 -0700 (PDT)
Received: from stoup.. (C3239BBB.static.ziggozakelijk.nl. [195.35.155.187])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077975dcbsm158078366b.14.2025.10.31.04.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:53:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/5] linux-user: permit sendto() with NULL buf and 0 len
Date: Fri, 31 Oct 2025 12:53:33 +0100
Message-ID: <20251031115334.368165-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031115334.368165-1-richard.henderson@linaro.org>
References: <20251031115334.368165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

If you pass sendto() a NULL buffer, this is usually an error
(causing an EFAULT return); however if you pass a 0 length then
we should not try to validate the buffer provided. Instead we
skip the copying of the user data and possible processing
through fd_trans_target_to_host_data, and call the host syscall
with NULL, 0.

(unlock_user() permits a NULL buffer pointer for "do nothing"
so we don't need to special case the unlock code.)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3102
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251028142001.3011630-1-peter.maydell@linaro.org>
---
 linux-user/syscall.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8546f48a05..2060e561a2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3581,7 +3581,7 @@ static abi_long do_sendto(int fd, abi_ulong msg, size_t len, int flags,
                           abi_ulong target_addr, socklen_t addrlen)
 {
     void *addr;
-    void *host_msg;
+    void *host_msg = NULL;
     void *copy_msg = NULL;
     abi_long ret;
 
@@ -3589,16 +3589,19 @@ static abi_long do_sendto(int fd, abi_ulong msg, size_t len, int flags,
         return -TARGET_EINVAL;
     }
 
-    host_msg = lock_user(VERIFY_READ, msg, len, 1);
-    if (!host_msg)
-        return -TARGET_EFAULT;
-    if (fd_trans_target_to_host_data(fd)) {
-        copy_msg = host_msg;
-        host_msg = g_malloc(len);
-        memcpy(host_msg, copy_msg, len);
-        ret = fd_trans_target_to_host_data(fd)(host_msg, len);
-        if (ret < 0) {
-            goto fail;
+    if (len != 0) {
+        host_msg = lock_user(VERIFY_READ, msg, len, 1);
+        if (!host_msg) {
+            return -TARGET_EFAULT;
+        }
+        if (fd_trans_target_to_host_data(fd)) {
+            copy_msg = host_msg;
+            host_msg = g_malloc(len);
+            memcpy(host_msg, copy_msg, len);
+            ret = fd_trans_target_to_host_data(fd)(host_msg, len);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
     if (target_addr) {
-- 
2.43.0


