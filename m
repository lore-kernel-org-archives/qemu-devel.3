Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2387AE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaP-00046I-NP; Thu, 02 Jan 2025 16:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaO-000468-J7
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaN-0001Ps-2f
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso74664755e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852709; x=1736457509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOzPkO5TmCycPZ/aaTUQEr16ldzePeyfEU/CMbdVIug=;
 b=ahwe36KA0yJzj2Dt20snb7WiEbUJ82jontu72fTUmbPdxhT1pRKr16iD/6J0XJsBkC
 juEWs0LXkk0nWdzOXqRGcFZeOVSOVzspeKjwZpNctd50ecSsQjnzWtssCm2h1H3vfYIt
 aQ/zsfJAd/Ehs9Q6SacLc0UMVeZk/FLLHFPpb+sLpQ+Sgu/lIdVWYEBSYP6KJgE7n09m
 BEjXiLqX+aKV8AN947FOCwhwF+uulU3830sSuPyE/5R0vJ+ZRXMXVQWUXhqx9gKske1m
 AqI3nd4NtsMHHRnbH/vVl5543YDkDkntbBmOkypvezjN/L1YzVmdStn1PgpLk4FtOnoC
 buwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852709; x=1736457509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOzPkO5TmCycPZ/aaTUQEr16ldzePeyfEU/CMbdVIug=;
 b=lJt5yPuT0MWTzT0cfUaWBGsBfcOMsJs7C+Iy3sDb+eohdfzyxFrKGLpv8Q4PmgT6DX
 r1q711KGIuznRwuT4WGzjbwR/KhfGvtC0xF6wkA1DlfydtZaZvj3Bg8lT3lzpQ3Sbg+3
 Gi05P0ZnLKuXxiGWQwvBW6Ip1oYjB+2TvxQ+34+Eevk9p9TzKZ0ePFqDltMe5l5KRwUO
 dpq+iEEU/rxRNQHI/rFUYHL9GHtFdtBeVsqndfyj5CONpXJbGGLxZGsVzuaC98DleqHQ
 Ga+k5sNKzMorn/P+ftBVRrr5x9muNk6zATqD6Rdmuv1YTiUOoahjAXUJtSGI0ibKRlRI
 DO5Q==
X-Gm-Message-State: AOJu0YwuuaKiEQAzxKgnTKEhXCpskyXpKO8+LtA1WypeJZ/0354+EMfS
 m/hF1IseqyA5bf+XdvRMNrqQ+sQxLnH9dmNGa8VSiQgI223O/sERJtUVojKQjEZMYPAchCHfym+
 AJZEHVQ==
X-Gm-Gg: ASbGncumR1obrYfLqnga6ZUgas6vcRVdk/nRMEHxM2NJtEN3DTgvWarfcLsm3df7nwN
 i/hlJsRQ/sRP0uCZk334xmhILsTElrY2fwQuTvu5rP7D1ubktTOZMYau1gq1TZwlpn/vKecuZ3r
 nuvd0sxtG8kUTkI2jzs/nLKl+mY0iQCSI4ipfE1x2qmCxiTrZkCKmuCiM2Vm+EYoSJVNoWBB/kM
 i6kC/yn0+dpxj8oh/xd0GwSBJjRwT+gy+jE3LOVOZMz+3kCuYRoYFKDC2L7AHyVr3oJJYuqBrjp
 cpQF73WwFMT/fTG/bZ/baIIfhYzTQ9M=
X-Google-Smtp-Source: AGHT+IFU3Ak1Tex0YDo2PB7ja9Wd9PA1j+50jH6zY14zk2XZnqdul0bDSoDkpr5Jw/reI/O4XHF1Ig==
X-Received: by 2002:a05:6000:381:b0:38a:69aa:31f5 with SMTP id
 ffacd0b85a97d-38a69aa338bmr100361f8f.3.1735852709348; 
 Thu, 02 Jan 2025 13:18:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6ca5sm39940132f8f.86.2025.01.02.13.18.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:28 -0800 (PST)
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
Subject: [PATCH v4 5/8] qom: Add object_get_container()
Date: Thu,  2 Jan 2025 22:17:57 +0100
Message-ID: <20250102211800.79235-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Add a helper to fetch a root container (under object_get_root()).  Sanity
check on the type of the object.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-12-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 95d6e064d9b..bcf9910b42c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1510,6 +1510,16 @@ const char *object_property_get_type(Object *obj, const char *name,
  */
 Object *object_get_root(void);
 
+/**
+ * object_get_container:
+ * @name: the name of container to lookup
+ *
+ * Lookup a root level container.
+ *
+ * Returns: the container with @name.
+ */
+Object *object_get_container(const char *name);
+
 
 /**
  * object_get_objects_root:
diff --git a/qom/object.c b/qom/object.c
index b4c52d055d9..81c06906d30 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1751,6 +1751,16 @@ static Object *object_root_initialize(void)
     return root;
 }
 
+Object *object_get_container(const char *name)
+{
+    Object *container;
+
+    container = object_resolve_path_component(object_get_root(), name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 Object *object_get_root(void)
 {
     static Object *root;
-- 
2.47.1


