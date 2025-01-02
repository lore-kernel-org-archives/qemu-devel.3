Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6700BE77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMtJ-0007oJ-6n; Thu, 02 Jan 2025 10:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMtF-0007lb-Uz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMtD-0006bt-Id
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso75383545e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830813; x=1736435613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X072cNLxlYU70g0aPAnHdJmyEbpQKTIAoLkN1KVyvsY=;
 b=EFO5XO44gR26r4cYHKY0KNr+vrDhzfNlxI9NMB9xhXJgYSCeOzGJ0z+LVHehVUHabw
 eNrhr+SHefysIzTlfWgsXLR+kctg0X4+pc453eTh8LFjd6iRKhd7YLyd4LYSj7c9nKmt
 jJKALFu/0o5Z4l1pFY6JA3LJSMOW3R7s0SWmRZoNt52bexWcfRdPItX2y+F+2jh0bfLH
 6dXzr/knHMaKJURMO2iUT/wpOMaHOUnQSZWRQcRoQUZohKZIYSXa3RDZ0ArlI1YuBx0n
 q52larNPa2CGbLx2h+p4FonbLzTpwq7Dk1lytoWinoYw1DPgLcC8dUq6jsRLLOipPtCa
 1uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830813; x=1736435613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X072cNLxlYU70g0aPAnHdJmyEbpQKTIAoLkN1KVyvsY=;
 b=f91IHZ+t7NWuXZE32x08kObrRyITrXiUHyiWfaJI5FS+lbeZUrfPuNgAtNZY447to+
 Dsc7z8yk4CpzzPZsoE2pOCYxBSkufdwsUYB2hmW1bi+/NQxAMAYchbQm41ZmF/mxhclq
 blm4776GLgK80gk/F5424JDISWMNQ+jsqk2+GZUGg/cz5gR8qoH3tg3qCxPwbaZjqnGz
 geV4Gm7Ha8D3jFu0wWj7ltfj6k9AQYd3ofRAoNixJpAEqy7ovLkp9NrobC1ve49uX0Ck
 hSCSwflHmQf4QgucPWhfTKzyKiDE4kEd81r1NoBVBgHgxM45Kaz/JT8SCEVy+4zvv3Yv
 5v9g==
X-Gm-Message-State: AOJu0YyhWWL321gBx1JckmXD3c8uqLv9Q1dpg7Q27tV7ysxAviiJZWNq
 8u4ujsyhCdTuPRSZxhGOjuL8KYVH6LJraxyLC/FtinsuQg1uGyj9Y4AlHDNF90/8scbV3vSJ4Bw
 ljlU7Mw==
X-Gm-Gg: ASbGncv3zz5TX17FmMasFk619XalIXcIa+OFK6aGSIi6CLPqD+yVXtNy4U0C7XkVO/F
 mogUmezLHHyr9LaMf5DUvSXbPrgjF5fNeJ2dO2qeikNnaj4KwhQAeJukmiKDnjVyd+RlppzH7sX
 bRoYptd7BcDHc4dQuyyShkd7/UFoT/5PkK058YT4+VG1xnFGUOHsv+Gh190r3ORajzILfOcgh3Y
 JIYuKkT/zcEJtaSC3pFv4/N0jgErqDl6q4F51zSxJiQr29rZ1cSUM7PP1eRG8qeUb22/u5GMbOJ
 VcM0oRoyZYRh041O2vdPL396blUZGBw=
X-Google-Smtp-Source: AGHT+IFkm0SnE7LSTyF1AV/dEwGQJt3d27KTmZa1BL4WtzT5t6eQwwkmsMk5qHL//9abfqkwhSDqKA==
X-Received: by 2002:a05:600c:138d:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-436686439e6mr414647125e9.12.1735830813541; 
 Thu, 02 Jan 2025 07:13:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acb17sm37848716f8f.97.2025.01.02.07.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/10] qom: Remove container_get()
Date: Thu,  2 Jan 2025 16:12:43 +0100
Message-ID: <20250102151244.59357-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


