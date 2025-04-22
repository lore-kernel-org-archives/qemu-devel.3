Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23BAC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76D2-0002rE-6T; Tue, 22 Apr 2025 01:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76CE-0001yv-PJ; Tue, 22 Apr 2025 01:29:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76CB-0007su-Dj; Tue, 22 Apr 2025 01:29:26 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225477548e1so45666335ad.0; 
 Mon, 21 Apr 2025 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299761; x=1745904561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0zvsPX/FfJ/QEBUSdkp3Xuzprg79q1K+fLsRE/b2DA=;
 b=B1UjjVv1zyNHHQj+637wjKDTJ0Z9uRZdHzlZhJX/238Sl1gXEEvBGBKsF73nqrjvk2
 DZkRkRJwL46GyewnsPEGe8Ztgb8D/MBIkT0bgbrjGv6Istm3Aj41xfBHdF/oEoMRo76L
 2lIBM20i9VnRRzRGAkFH8UvG5x3WH7pbF9vMTfCzEymUDXGg+Thm+C1Sp5erU/b6sMXh
 +oK0Z+kiemGf3mOrDxZOYmCdWRDgEFNUt/AAaygkFOtOoXTv7Q4mj/CNEJzSqCvVGD6q
 K5Qym69v/SstEkYF+2eetSzZo0QkJR02R6sZqCH172LtHMuxbLbfJqXOPnNNFRr/SFj+
 LJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299761; x=1745904561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0zvsPX/FfJ/QEBUSdkp3Xuzprg79q1K+fLsRE/b2DA=;
 b=JOJceb4qYKHKIYbvXWxLcC+5FLMFu0AUUvuPFyReK22xbPTKqOop+kBSiUrUNiUwAJ
 vpEovLIkdRbRj3r1YsIM80ALj31C4oNpWa+5QVeEG6rSKaRAV451PKEkDoAykQ+wley5
 fkCgXJf2cTI8RwWjotaCYsq4cTiTqJdfykfZ+7FpSqbxdjOjYARZ08D/BuUyikELYzPn
 Cg1XxS7Vq+s3adIipGhmCHQBDDDLkUjfZBmP9YQDoRY0VYL4ooj2Jgc4dPzHtk+t+VjT
 0f64M+cyJiBFgyCZTVxLA9I3Ka4e6zFjPRPOR+b97Dn61/nNIJ9ZiBLdilT3Sx1jCCsD
 R0dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmV30izAsGWoHq54unuNAuztpinwXty/T1Ez9yQX8ryhhsX9mVud0GvOayIhyQQahiC+tRQeLVoQ==@nongnu.org,
 AJvYcCV6ozmnbjF+ox9pKmgYUrn6YaynOidLQXk7c9v5Rr3HCcT1xfF5AcWzec1/NvHvIwI+iyZOKLLsV9IVVw==@nongnu.org,
 AJvYcCVA5mKJwe8a2S8r84OY7oHKtDJmcicQV+Knds2AgwT/Gt2T4F4+R/fRb2HzDhB/YW+n9p22HxjGA9FHyw==@nongnu.org,
 AJvYcCXDS43EhI6KktGtqV9fKv82kxsneaWgC0F9+yRZdq1i80icW6bcGoITnfNyliGXv5FKlI+j6hwKdvE=@nongnu.org
X-Gm-Message-State: AOJu0Yzsl0LveSh/16HFVJ//Y5S9Rd9huYwSKA6Kbk4lEfrCqsfmKGsj
 HecmOMsX/cB1Gru1DxE3lRUklXDOIpLfjMJSHlGuo90uSEYwk6ptjX5eslHx
X-Gm-Gg: ASbGncvBNOpx0IeEyIS8Gfzjz4RLxts/8Lpe3N7eGOUYCNKQB579dABE7L+Z6vGMDlz
 KNvA4LZwfsJl70n1rvaMF0BVPINZ7kYEn4jl5lULSE4Y31FPnfk33XKue/XAfx4XJBvphGmRHAn
 aVFdKGtevFKypAAVKyWp2z9JEXOYEkmJvtu0G9V7cbctZYtaiMt7wkIm8425rxd3sptu/BbYIex
 UG31hEonM73qsSXV4C3zFQ0ahvO8L89kG0ofn6mOJ6K7RN5HEJzR+PvUID97LO34w1WCWziYcFG
 8JVet9BFPagvRNq6UIAgqZm3ronqKA0Xe9cqx3W1URFqOIa9qEJUBAYZiSY=
X-Google-Smtp-Source: AGHT+IEjmWmpJ6AAAiaqVT3tzNWYxNrjHbhUCkbn37vCmlnEnKPSfcFShn0zTwGUz13Hrf/oiWTlcQ==
X-Received: by 2002:a17:902:f650:b0:224:26f2:97d7 with SMTP id
 d9443c01a7336-22c5337a016mr187606955ad.8.1745299760678; 
 Mon, 21 Apr 2025 22:29:20 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:20 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 10/20] include/glib-compat.h: Poison g_list_sort and
 g_slist_sort
Date: Tue, 22 Apr 2025 14:27:14 +0900
Message-Id: <edc1b2ac9a26dc5bbf9a3897e842fbb36c69ea87.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
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

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 include/glib-compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

V2:
- Fixed typo in the comment: s/insted/instead/
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 86be439ba0..53f8ea38d3 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -36,6 +36,12 @@
 #include <pwd.h>
 #endif
 
+/* These functions perform function pointer casts which can cause function call
+ * failure on Emscripten. Use g_slist_sort_with_data and g_list_sort_with_data
+ * instead of these functions.
+ */
+#pragma GCC poison g_slist_sort g_list_sort
+
 /*
  * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, allowing
  * use of functions from newer GLib via this compat header needs a little
-- 
2.25.1


