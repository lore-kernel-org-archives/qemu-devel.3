Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD38EECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38C-0004TA-ID; Thu, 05 Feb 2026 12:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38A-0004RM-HL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo386-0001PA-Ng
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:00 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40866608701so638682fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312408; x=1770917208;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ctgNgpTDwLFkGNa74poCMYLdCOOa3i9ahgcsncESpAU=;
 b=PKmMkaMKFWN7yUDIGGUiUj2E0YSouFhYNeHk5VFPSja86VjOlsJo+SMeusd17Tu1zE
 miFKnrF+DMO+BzZQbG3goIY/ejpIx8urRpvmU5X+aGmxz8bMtSB0eo8yFf6rzJMQYmsr
 AjefPJNu/ZFjv1gNWeUYPrqTZeYc2rEgkOkYDkSvmAKsmpmZtsDylYQE587h/sIgwKSf
 42ox4NrHkxoIvVJeFvg0XfVLRlSVDX/c8C0oUSSHzMmH3hy1CNL9APy938zOlY9Ha886
 6KkRaRFk6XO4kDh3gq4ufY9kkx7+kwS+3sFIB751ktnn1yI3ryBTsF13ZHIdm6b7+ecZ
 Zf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312408; x=1770917208;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ctgNgpTDwLFkGNa74poCMYLdCOOa3i9ahgcsncESpAU=;
 b=pyRYUMU/zppcoJEH8XiYqV1ArFkSBTY5NQEkRUKyYxotbJ2JMctfp/CrX43x43gnqE
 fNJgnne7N8EPeVNDLmgvrxrp8sFRhSUIeXCExMqkQuSfxzn+ohuWgKrnsx7eKylOEEa+
 4E8qMqXTAwJ14mOH/cI+mTydfhikNmxSx6KqlwjQLvfmsE3cjYxk1B9wFfSQlgtSwGqQ
 NmfwHyDq1QjKSYgfRMaYG/zamHWKp9dEyP6sSTndf+jTtD4mX6YaMekXp5ew33CyGh5e
 sEYeRHOAwJxZxPG/gLQ3HIsdwxfDjJQkAMYvs8FrnZKsHglzfQRJUloSMimPeb/ZoSmu
 flLQ==
X-Gm-Message-State: AOJu0YwMvASymwa2on7P+eW0oOZfvjPeLckQNeyOq/WK+aufLxCRevWg
 k1ExiXUyJ7u0cta1zGLwwik8nbgJa3rMthDyKHZo3EkO/4F7tIVT+Tq4wE+PwWXrIZQ=
X-Gm-Gg: AZuq6aIYRUPOnH10kAohuiyf9Z1EgnLV9JmTZ0CJf7W18ibHfAmicNnA0vRcPK3nvXM
 AP5x5V0SHy4Q1Vucha0VCJC/zRRoOBu6VspZiSCDydxOh4Xy4sY0gnzq+t+I36BApjrQe+sfTZf
 kcWu3I8Zru2x18yyF4NXf6vKNsmB62os/AuylUgYFmr0SQU1CCe8oCZ8l7vX6d38xMw4wATh5qI
 8BOMObEGriQ9x98LLR1n0KJG/j3dyQ/PLhJLF8kFgEiCfYJ9m/bbKSeWgpdg4TK3e9UtjDxXF+a
 SPa00rgQbjxSHJQ8a7RecJgF+d2lKTu5FZjXq74aksP8eMSlKlm/fFTG4cl1HDcZqbB3c7Ttuu9
 h1VojcT5pQxFGVMSgHs45zC1hDL2yWLlkOU0XpKSKGj8lDQ4WNQkpcA8t7AiDaMBY77jCZmkPFA
 ==
X-Received: by 2002:a05:6870:478d:b0:3e7:e20a:39fb with SMTP id
 586e51a60fabf-40a96d03073mr16444fac.11.1770312408496; 
 Thu, 05 Feb 2026 09:26:48 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:48 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:41 -0700
Subject: [PATCH 08/24] bsd-user: Add host_to_target_semarray for semaphore
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-8-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=GZirQKfoxs6dgQznfTWdQX62ZfU4zzodujvBOpNoWAc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLaxtPTAN5ZqcBSOCFtubokZhfT1i2F2k6PG
 DjAoeQSCGiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 AKPmD/9AcPeQf1nSFOOFv/zL6r0Ba0DbAYrq6QPGX2Zx3hpJRTGcokViqhxi0OI2aYlHi47u0R3
 KuPrZbjDgvF2r0R2YX6OtimlsP+ZXWmHwVRA9wcUKN2g3VdOoNNS5McVoL9NM7uNc86rG/Ma8PM
 we3RCcIoAkk3lolcivZujt92JBvJcJcO5sw6xGI6hmBOsTgOyzSTKJZa5PF+XN/APb9qQ/dcBpM
 uP6XRFMkalo1GfyZgim4VUjnEt0tTOCcmU4o+g7xU2vd4apNN3MVw+iImFLAd8tqgiyGHrbLP7/
 WlFw9eY+ulZAvAEsQrVMKpz2Ti5DOg7vFE1D1YlYfEdPx1z9+pfcKbsplFltRgVSmDPHxR2fAhQ
 t2uyMoaGdYv+PmBowDyCP0EEx5g5mt3OlN58PhumA7sytVwiwtOQWh9n1zLVdextww950+4CV6+
 pdix9hxwM0Jc7uNpM7GbSTFsm+BPAfPOmyTP4bainci+VqLMZd2bCg23ptQQJ3W0qQiVFiR2WV6
 57DFDV34t+W+nKcxdWzfDdptvr9fjtaEsQm9JrETwqNAREffLx1H3kIFJqVVK0CmFOtFhICF9fG
 JyAWgFPqJdMP74k02pcp1lyRKR95TNoKbQ7YZw9MEdOx3kyuS1v0k88gEOtCbfN+TrjEqy/HvRn
 6fNNOTCtfXheiIw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::34;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x34.google.com
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
 bsd-user/bsd-misc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 07d8bf1304..7bdf65450a 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -79,3 +79,35 @@ abi_long target_to_host_semarray(int semid, unsigned short **host_array,
 
     return 0;
 }
+
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array)
+{
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
+        free(*host_array);
+        return get_errno(ret);
+    }
+
+    nsems = semid_ds.sem_nsems;
+    array = (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
+        nsems * sizeof(unsigned short), 0);
+    if (array == NULL) {
+        free(*host_array);
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        array[i] = (*host_array)[i];
+    }
+    free(*host_array);
+    unlock_user(array, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


