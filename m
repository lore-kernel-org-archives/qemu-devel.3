Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E08C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IBj-0004Sh-Nl; Mon, 28 Apr 2025 02:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IB2-0003JX-S1; Mon, 28 Apr 2025 02:41:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAv-00079G-SQ; Mon, 28 Apr 2025 02:41:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2295d78b433so45731735ad.2; 
 Sun, 27 Apr 2025 23:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822467; x=1746427267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/nnk2ZOF1tW/MJazOrX1XPPavmSBWDJgIss4LsgUwQ=;
 b=O3hL2UkLyiruFtzP6pCoYyeFxO6sRLffZNU8p8UBwGRb5UhlODSOfSJjvDUetW+yBA
 oZAWFxNdBEczgDB2X89oeuH5JTgWhfH9tgX5u03ZUgawtSRRLBPQyHlubGbko8LUr4Vi
 rkiUJuPwf88dAQFiOBnpSkM/aZt9QK8Kb1rw1Ae1A2qxWlB4KADmgluIQzC2gmmTIoKe
 OzT+FyKG9g+SexOYxxs60Djo1wP2Ua8p4Up0KFlfWKWPdWwPZjVYztmPj4cGq9XHj8j1
 8RYXxOWhY+gdarc2o6LtphaZrlZilWqq0LZqq6Mn2GLCDK4LpuJgwo9P+MAfKvL1aOjF
 Rd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822467; x=1746427267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/nnk2ZOF1tW/MJazOrX1XPPavmSBWDJgIss4LsgUwQ=;
 b=b7BwUao+MvB16qggg61XEp2qGwPWzsJJqVSuc489VypM6Un2La43I5HRIYT/h7rbyx
 xdogEN06FF5GnQQfSUAILX+CVVTPRbF5Yo2E2D0Akp1r47F0Z7gVDNAA7mUfe8r+Mnl8
 YE5KGZGEJq3Mce73ibplcbUTbJCryksqujugaxIodq4ypXQr+mpYhHnFw+sc3XulHnx/
 i95xhgoP9otXtG2eotUJTip727g6qHkEh286Zq92LczHU2ChULaaRJ9D/c4XHoCoweJF
 dGEXkeRJvi83hO4uH/5hwrK031AtRWEoEoXkcvEUzeloxjdGGXq19fZNYqguUh6y5HRS
 wpHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK+EkfyLVOtUG2zqB1DPvujesM9PpbFMJ17oXEhJEMcQhFFuuIr0yhLIMwDhmViUPN0kprdWtZaig=@nongnu.org,
 AJvYcCV779Oc+C0QyiGU+TFhZ/S5bGC2ectwYc5B6cDkgJxOGq5xNA4UG1xZbCWdGesn8cHLqjaLdhqohtnODA==@nongnu.org,
 AJvYcCXxOs2dkvhW4ALSalbRKsX0Ae0m8KfkQygsjerQCkeA65h1/cSUhqHtOq051VSfyLSipaFN56cM7Zj70Q==@nongnu.org,
 AJvYcCXzo7Y6eUw8268BkoJGYPwbgqnKaK6Me8HvCTAIgShVdRO1N1glkwKk/YULrwDmzTLxWfoJdpTeCw==@nongnu.org
X-Gm-Message-State: AOJu0YyYFT5WBtfC+0s9IT+M43McrDH2T0kimJrTekov6pv89Qhd58Ky
 FnQzzCJlvuqUSupnYZb34T5t554hv6Mwjn71dOSmThSIApdjc9rBHd+5HWJb
X-Gm-Gg: ASbGncvoPFqQ0IR9/I38ms/4kLJhV5XAs0ev5ZsKXHbiUIc1lwinT/HE+cxcXG3DqSp
 bZLBYuUUJXUtRBGZSDESFWF8juqc6CDbIUhR+gXHpKzFm/9wGMlGz41Q6KmllRzW/bEGrA/buYx
 HJOWw91rBAJe3E5VJEoHtFzUsdG4pyLSQ9kwuWtcYU8zllg88xyxNi+D3emf2oDXWOMIB3j1c0r
 fMrw6r9CXNCwvUag3uCOx1avVkSWNuaeKDQMDYS4Ro9U6fJSnrmOQH204hWdqowuxBk/NZ+fddt
 8F2ANhomml+cyX1ABhjqMdYwazQGvF+9hE1sO4Ny2e1mvpvT
X-Google-Smtp-Source: AGHT+IHy8JC9peExQmw9o+e1dR7WVS5JuRxtg0fw7P70HK7P9CvHmfmRCy8fXoV4eVZdOOZik8y5Ig==
X-Received: by 2002:a17:902:cf4c:b0:22c:33b2:e410 with SMTP id
 d9443c01a7336-22dc69efab4mr115305535ad.2.1745822467072; 
 Sun, 27 Apr 2025 23:41:07 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:41:06 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 11/20] util/cacheflush.c: Update cache flushing mechanism
 for Emscripten
Date: Mon, 28 Apr 2025 15:39:00 +0900
Message-ID: <2926a798fa52a3a5b11c3df4edd1643d2b7cdcb9.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
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

Although __builtin___clear_cache is used to flush the instruction cache for
a specified memory region, this operation doesn't apply to wasm, as its
memory isn't executable. Moreover, Emscripten does not support this builtin
and fails to compile it with the following error.

> fatal error: error in backend: llvm.clear_cache is not supported on wasm

To resolve this, this commit removes the call to __builtin___clear_cache for
Emscripten build.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/cacheflush.h | 7 +++++++
 util/cacheflush.c         | 4 ++++
 2 files changed, 11 insertions(+)

V3:
- Fixed the commit message to remove a confusing link.

diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index ae20bcda73..76eb55d818 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -26,6 +26,13 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
     /* icache is coherent and does not require flushing. */
 }
 
+#elif defined(EMSCRIPTEN)
+
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
+{
+    /* Wasm doesn't have executable region of memory. */
+}
+
 #else
 
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 1d12899a39..17c58918de 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -229,6 +229,10 @@ static void __attribute__((constructor)) init_cache_info(void)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
+#elif defined(EMSCRIPTEN)
+
+/* Wasm doesn't have executable region of memory. */
+
 #elif defined(__aarch64__) && !defined(CONFIG_WIN32)
 /*
  * For Windows, we use generic implementation of flush_idcache_range, that
-- 
2.43.0


