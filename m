Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90185E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwD8-0003fg-7Q; Thu, 09 Jan 2025 12:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwD6-0003Rt-4n
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwD4-0000uQ-Bw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43626213fffso14877165e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443240; x=1737048040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEHoOzKyVxEglpmxh6lJRCjvFkinjqf0bKzuyMt1kmA=;
 b=suOkAL8qdGUFwbkWItOVdvYESw6+/SWaDC8myny/fARJ3z9ycBtJ2kj9Ig9mgtIP42
 Hn2ANHVt87uYBRUcGkZfCr4wLvgQXQ2dpocMP3mTAjq+aCFh1je6mfdn00fJnMYwyaAY
 VtNMq+AKK5B7smPQlHFCCU3Pj5KUNhKMqY2uomBm5LnMNB8VFKCphOHmiSA+GFrOvmKw
 v+YeJ5qi+1HMkiB7nY4tC1YVpwHLQoUFRLQjty+wNqzT8TW4K3KYsyQqn7sA2H81qKy9
 Y67cuYGE+IWTLSAaVN+USu1LLoXj7mmiC/NQUKncs0ROWoF8nxnOopUYz07yz3a38alc
 n0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443240; x=1737048040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEHoOzKyVxEglpmxh6lJRCjvFkinjqf0bKzuyMt1kmA=;
 b=k7mcmQ9aonfDCC2nTiou9ExqmPJrESne2yTMDGs9PSAoZFeJBiX8/J2sUrwQuxeSn3
 nvAAyJxQ0QgJ+WGCM49+Ix/0c5l/w4uytEHYwdywMCfNbDZwWVSrVy6mSY+Tg6QOaoAc
 oecD9TfArKa/redUCSnX/IL2EWVmEykLa9cZyA4l6Am6SRmr6S41F4mkCr/I8iXKvCqr
 JMMYHDwJpScb8PI73z5Xvr89ndcP0wpGEYtLVPXAJY82ieH0kwGk7yFkyjXnvltP7Uky
 btMnoUtKG/CPmM9nymKJWFWQjreuZ4lcdzwcklw946HSepqrQKkJItqn9zFj9FqrKWfd
 o8sw==
X-Gm-Message-State: AOJu0YzHzzvfralct4gJyrtBQEKgW5xJHhKoA+/iCaHlhoSE/nlZCo9h
 51pITqhojPf+5Ns2rcZQsdf0AeLDO6ThFXca0/Es2vHQcMefEPAyIq1MjXAJfO/5Z2F0n3hY1LB
 SA7w=
X-Gm-Gg: ASbGncu8vhaQ3YTcrwhpXJDvjvU8z79/SvACeWQoPu+wQJioJnEVp3Z9UvwrOkoBy3k
 2r1xRCwlDIXp8GnBxhM1RpxKZLJR3/61NuTuNmW+hBDNPYiHPbiPBJ71Ta65SY2Kg3zwStNm5fW
 b98xjDNbzMHw2RY3nql2PH0pNEF6Rzv2CqYhyH/JBnoMaSQmBaSfgm8BEyCJD3gSQjUUw3Ui/gD
 BDpGdGyVgWZKXs/BCNHieha0mGb7EjdZfnhxe06xlHgTejXVtB+LmiFN84uw0YNoK+T5B69p2u/
 gntzGiK+cvpm8M1d2S1wszcINuEtVXFAlCQr
X-Google-Smtp-Source: AGHT+IEdDuYK6BPxWIjxcr4VZNIr5nl2I+Uhsa5UgRt7sCnz4aIdIjbtQDZb99ZB2RrqIIARZ8rmMQ==
X-Received: by 2002:a05:6000:1fa5:b0:38a:88ac:ee69 with SMTP id
 ffacd0b85a97d-38a8b0d5bb4mr3396738f8f.13.1736443239590; 
 Thu, 09 Jan 2025 09:20:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1ce5sm2357604f8f.94.2025.01.09.09.20.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/11] qom: Remove container_get()
Date: Thu,  9 Jan 2025 18:19:46 +0100
Message-ID: <20250109171948.31092-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Peter Xu <peterx@redhat.com>

Now there's no user of container_get(), remove it.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-14-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/object.h | 11 -----------
 qom/container.c      | 23 -----------------------
 2 files changed, 34 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index bcf9910b42c..77935572894 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2017,17 +2017,6 @@ int object_child_foreach(Object *obj, int (*fn)(Object *child, void *opaque),
 int object_child_foreach_recursive(Object *obj,
                                    int (*fn)(Object *child, void *opaque),
                                    void *opaque);
-/**
- * container_get:
- * @root: root of the #path, e.g., object_get_root()
- * @path: path to the container
- *
- * Return a container object whose path is @path.  Create more containers
- * along the path if necessary.
- *
- * Returns: the container object.
- */
-Object *container_get(Object *root, const char *path);
 
 /**
  * object_property_add_new_container:
diff --git a/qom/container.c b/qom/container.c
index 20ab74b0e8d..38a27ec1edd 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -34,27 +34,4 @@ Object *object_property_add_new_container(Object *obj, const char *name)
     return child;
 }
 
-Object *container_get(Object *root, const char *path)
-{
-    Object *obj, *child;
-    char **parts;
-    int i;
-
-    parts = g_strsplit(path, "/", 0);
-    assert(parts != NULL && parts[0] != NULL && !parts[0][0]);
-    obj = root;
-
-    for (i = 1; parts[i] != NULL; i++, obj = child) {
-        child = object_resolve_path_component(obj, parts[i]);
-        if (!child) {
-            child = object_property_add_new_container(obj, parts[i]);
-        }
-    }
-
-    g_strfreev(parts);
-
-    return obj;
-}
-
-
 type_init(container_register_types)
-- 
2.47.1


