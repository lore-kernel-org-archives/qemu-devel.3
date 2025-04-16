Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EED1C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xya-0003xh-5d; Wed, 16 Apr 2025 04:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwe-0001x5-Ph; Wed, 16 Apr 2025 04:16:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwd-0005sg-3v; Wed, 16 Apr 2025 04:16:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso7314475b3a.1; 
 Wed, 16 Apr 2025 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791388; x=1745396188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYpO1k305Wtiuq/zmuKPfj735nkTtZMPOH5ZuTPK1tU=;
 b=KUhgGu6MEinhgdxkPlV2nrVl7g1wQZTs0/pLcjQ40AVV72KlxTNDt8QnSHcQ6HbxPw
 GgFuggZJRfPVpnWBTlAwHynSDwvuNZHAOTY5vZzLbhZgHG7r3+BRi24Lmfumv94xd++y
 ZNWyqLyOYZlGSBpEuV2OdmWRynp2NemdeAtsAUkCBd35twRxxZQiI7q0iMV3Ys86cedi
 LB7ieDEYYqf8QrlRf1nrC7LNxDRKjcfF3xkinxAR17OJh03xadvoSNHxJxP2fGMj4fZM
 xl9EHhJ/TJ+RCW3XTCsPPhcbvlLMWtFhIonTpivG9BIMQHXEo3TEB8jx8ATNjkChVlMF
 newQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791388; x=1745396188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYpO1k305Wtiuq/zmuKPfj735nkTtZMPOH5ZuTPK1tU=;
 b=Z58TC7Tm/QnrrfdFi/J2KSrxKaE5zf+INE3svyOzc5KGKhOdTrL6yaq0g3ceEFlEc9
 mDwhDX24m2J9jcOC+bJekWqs0fFmFKLOXuD1vezTP3rTuxgOPMSQyyiEnhJf6TAg1ata
 lPU/hGrm1l19Rye7th7NJmudmafj/D4DZLT2uZG8lE9o7zhYBHBHX4WPLMoPaI6GrIbJ
 FtDnu+5CmfMPUEQl9iQBnHKZuD/YxmWvlnC4u8e5PD68tFDJKBOsSGME+tKNcNGVuZKi
 88VueWYLNJeO5lILVItMFigR9TnRx8l6iBsSnCwStJUOxSSlqn0sJFV113pKFd3WxXHL
 FELw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO1e3oaI2C6kIneXC95wq6NtANe91V3E8YvxkdRbbkY+OO38PV7Jy8kHyzredR5nd2XbJU2YFMLAA=@nongnu.org,
 AJvYcCVUqcq9Ip+JUz7J4CJJGJvvn/EBFBGdSrt3YqRqjr1rSqgUaVxsXvUI9RC0tXtb1uxaDF4zLsMmDSs48g==@nongnu.org,
 AJvYcCXe/+NvADZhdJDPzZmW1p5bXb7BNsvl7sb+u+FL3FZIaSqKrpurxn5rLcF9TUi49NthyS4drF7iUpPgEQ==@nongnu.org,
 AJvYcCXm64hitflcZ0vbsp1A/INdfUTrBGxSq+3TfGxPpbsfwnS2UO9eeIP9kkDpOX2E2wNmbeichJN+hg==@nongnu.org
X-Gm-Message-State: AOJu0YyUl+UDFKUYHLfjFzGuAG+e3MEavhPWbaCevq7YYonGodlOao5J
 N3w0yOzwPIBvz5cofAdoO6TEaMHsdQY9hkRyjab0FQwj13AdC1Cm2ND0+80M
X-Gm-Gg: ASbGnctPKZOuaAJEH8g0/hNrHvdEb1lw2fiB3Cf+jWU86WiKGC5T8UwSRc2N//s5sIe
 kf/RYSL3pzljTwHQCWisZu5jdNNCy7z2szvKreG4Bw2u58ld+HMEgHNooxA/36f7dVdkFyBvku0
 R50yUsVluh6Ykm3fxDaMAn3FjRUNex+cMp5UnMpaPL58vHHVKdR/NK4WBHFaXAjg3OQUXcPR/Dl
 f/EfB0LZsRaBw+f7Ypqnrlc4CGM73ib8WCswUxovVJy3pMDq11NAQ3ux7kUf0uaRXEXEOfkUs/R
 2H1asOCmwE2NSawNXbcCzio6XNrH0YciUN3bC16VaSK1UauU7IWuq74xKA==
X-Google-Smtp-Source: AGHT+IF9bDDZbwuPJU2PpdK5gj1XZbWq4WLDXyolVao4ExtH4EJUgh98Q5i9ZONRA1Uraq4j6nEIYg==
X-Received: by 2002:a05:6a00:4c8d:b0:736:562b:9a9c with SMTP id
 d2e1a72fcca58-73c267d2f14mr1548869b3a.18.1744791388065; 
 Wed, 16 Apr 2025 01:16:28 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:27 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 11/19] util/cacheflush.c: Update cache flushing mechanism for
 Emscripten
Date: Wed, 16 Apr 2025 17:14:16 +0900
Message-Id: <97a2164b3f428265136bb1c01615a16b516138c2.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 include/qemu/cacheflush.h | 3 ++-
 util/cacheflush.c         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index ae20bcda73..84969801e3 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -19,7 +19,8 @@
  * mappings of the same physical page(s).
  */
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) \
+    || defined(EMSCRIPTEN)
 
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 1d12899a39..e5aa256cd8 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -225,7 +225,8 @@ static void __attribute__((constructor)) init_cache_info(void)
  * Architecture (+ OS) specific cache flushing mechanisms.
  */
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) || \
+    defined(EMSCRIPTEN)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
-- 
2.25.1


