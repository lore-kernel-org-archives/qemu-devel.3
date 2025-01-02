Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06314E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSab-00049f-5N; Thu, 02 Jan 2025 16:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaZ-00048S-RF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:43 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaY-0001Qe-AA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:43 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so5377158f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852720; x=1736457520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X072cNLxlYU70g0aPAnHdJmyEbpQKTIAoLkN1KVyvsY=;
 b=VdD5b2MTwqOzkcwx3Sf8KbVcivw3vPR8i2H9JzrTz0JwevpNdKlTfPMqk3FAJIAVqD
 lC9IjU4KXtAG8i/cp9QBgPrYcc40LziBsKi2fOV0IJ9kjOzlhBFtyoyv+aXWxj4+BzB6
 YpqMTe2a6HnI/7KWpQZvSVMVx49E5rpNncavJmsBeT1/pG5BRl8gU3hTBqByFAFIAZtk
 VYABK1nU1mgHihHsKivbUsX841Taf7OlkZAM2kCFSbDDO4sA+QRrkip65iGyhrvBZOZA
 CAlzCOQSJiwWxZJRQGxrnNTXu+nsfPvlQCaf3+wMwL0q+LSdUzAvpGF5AP+91zkx4b6P
 acuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852720; x=1736457520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X072cNLxlYU70g0aPAnHdJmyEbpQKTIAoLkN1KVyvsY=;
 b=mAqL3nqQbhVaC8NnT4c1hgjjjGsrgsD/vsgz/D/Yta7TuSSBO9pjgLNSE2TC3jouYJ
 nNYQVMc59Ujjj4Got577XfodtzYGzEEti8CH699AYXCjBm/KNjkLsmJ/8YbGK+zL8L8K
 488b1ahfEoEwWW0nx/CW+C5mkgTMnXQ0HCcZBl2TPG6rKpwGOXOkczGtPlTn4sLpuKGW
 AF5fUo4NBQKkzh/r0UawF5pyFIYbK+mo+4fBRzXmWHlLxCvaxMy8bAM8h1rrnEIW+/69
 mLpCA8GE7lEr9P0A0Oonh/UttQLnqlgmmVOMEbBJRbJzzaNSjtu2By7vjSFeruPFKL1j
 uduQ==
X-Gm-Message-State: AOJu0Yxly4H5sxc3dMuJZ/VS709ZJ6twc7KH43hoCfD5y6NGMZ2pQSFL
 HvlXTedNtgmyDF4pHRIL8woskM0y3jan19U7hNNbFyfUXAcO8Q4QqF4/FtHJDVJXu/GcNjqwWze
 C22F4kQ==
X-Gm-Gg: ASbGncvgaf92OPC26U/Xygsd7OcwEY1wRvz8he8Om9KQPVz/iTukjloegKC1t+Lqmgs
 3bMtItAMKd5GoyvtVyVm9uN9OA9QK4hQV0MYXkbn6gNquObWyzmuguojp1LxRChF6yDf0ye8iLo
 rfHglItdLbOTAimMdce9wsTYzhSUBJqeCVAVpB/s8mXH9oCWkPCDTeiZyx+4WzTne4KLNI0hffj
 MRjFsRwCgfNHUf5gt76zz5ZOaGi6gl8ARk9KF08VKgQZeTNV+Mco35pg0SqC6uICc2arFQQwR2s
 o4qVrvDf44uqgQh4bnLgfM+FwQF3Beo=
X-Google-Smtp-Source: AGHT+IFktdjjUzUBETKV9PyuXkCREZ3c3g+nxlKsHbj9nwq6FsyN1dPaFpF5Gb7QuNkcttZGCo6slg==
X-Received: by 2002:a05:6000:2a7:b0:385:ef2f:9282 with SMTP id
 ffacd0b85a97d-38a221f321dmr44804791f8f.5.1735852720584; 
 Thu, 02 Jan 2025 13:18:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a7csm460601325e9.24.2025.01.02.13.18.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 7/8] qom: Remove container_get()
Date: Thu,  2 Jan 2025 22:17:59 +0100
Message-ID: <20250102211800.79235-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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


