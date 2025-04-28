Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F1EC369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IA0-0002Pj-Ho; Mon, 28 Apr 2025 02:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9q-0002K1-P7; Mon, 28 Apr 2025 02:40:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9n-0006pB-Dl; Mon, 28 Apr 2025 02:40:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso50856395ad.3; 
 Sun, 27 Apr 2025 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822396; x=1746427196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lww8hov75vab4etPov3FqdJvlp/MIqzg17mT2sCNDQ8=;
 b=heC/KZ6jWveVLlSwkoREBe02yT6G6lKYGRFD5YQnQDvIH6kJbPY9b1CDP4/AC5Lyjm
 1wcDQ+Z2XQl9ilyYtgPvQnYpOYdcM81kVlocF0x2XcLJ4Enul280o5sshfsdb+yY3p+W
 l7noP8zrPXvoAyU8KamTyjvsKXDt+54zXZxPVfpcHGkdX3LlGj26AjxcrWfLAUt4wg1W
 AulGv92WuTG/5AXnRUoEpyH3henhG0R1yhHpEpHuPJDOHe8yiIIDyvJq9g0hBq2QJZvA
 F+FZ1sn/zlp7tMtyHo9UIb+aC3eX/TRW3z4bJeIp+yQWX8KtIoIk1EXlW4Pq7+jzyKF2
 HTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822396; x=1746427196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lww8hov75vab4etPov3FqdJvlp/MIqzg17mT2sCNDQ8=;
 b=lQ2DEYwQqJhP+TSFI/SahRDbk42SIJOmIghqZIUAltXKdA9JIdiZbJdSrZVYmL9S1J
 xCx3bRn3DIawcVNRFg57z9pROCRW8/B/umB4KJt2dtozQQbYcGbym0hwX+lWQU9wFXhx
 nhtX31SyXDTXNQHEqNPVWKSaXY7YDb4AANojGfdm1X0dvhuAAXRAaouvQVAVUHmMDRh4
 yfbXHUColo29ArNQmG5bgvlDxiEzGbTVl9eIywKbH4IFlWsk9ZJn2Dde+2nylBIR/L1z
 dZeo+yfa/4EkwAw2JQy+OqC87ih8gYPZ2TlBQxbdlTD+s6gFhx1LmxqSiit1bieTEsU7
 c0cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRbX+XboOy0JilBRfeT+C/OycC2nLDSgl4E7XGg6wbfZOwh/wapLZVMilUbkKrLksu3WdFV3ePQhM=@nongnu.org,
 AJvYcCX1jzBW3OzzVUTC7wsNRUSipIpvII6XzzIfAEMlYox8VpaziPV+Szvxbo8wJL3bgwVOAW4IUVmN/A==@nongnu.org,
 AJvYcCX6VL0plLVTbqEMhsGhvFyPC3Ab7zqsq2tFT3lYupDWJE2l0GSgcSm4ME5Bb34RmoTnNFIuGqNFi6vLrg==@nongnu.org,
 AJvYcCXP+lYgrPcnxwyZLKMWVqRwFiYfDs9sZ7kCHZjgjnvYHNUoShoM/oYIiDGNWzHAAEnc0xEzMgYA961UAg==@nongnu.org
X-Gm-Message-State: AOJu0YxzyxP8Y3aRTeCb76exw49wiDb955wOWvucuWxRsndFCtoG8u2J
 2ci9qGZVM9RkRXaOlcf3p57sNbCmitq6Ngg4NS52vyI1mLdPlGfllQ01hdeE
X-Gm-Gg: ASbGncsf1XuQ+koulolrQP47UQuCHwUNnhSsXw3lhz14dfVVgLFaLwZCekSMQ/oc/I/
 7jE/Uf/lOPy/Q3zaegzvNfPX8FpeDRSSMEVpGielZQEFfa13Yi/g7rjqPP7IufnTu7UAukAduXH
 NaqxYdS8qu9empBS5cK5QsK3+EWsMaI9XI7GNpuMrjk8vIRlI59Kt2KMsv96ETpPMCvQ2Pe94jh
 RjuDiYQoRUuxSvXm0CZUA+G9nKY4cAUDZ+AVB3yYIwcEaeHv0ZgFS+uae+6RrlB6YSMiittU+tp
 IiNIMSraxhrwjLJDpW1nwTelfN+N0rze113CzA==
X-Google-Smtp-Source: AGHT+IFt0ZirYoW1xYqnSpsbjooBfunphjZ0zCT0Gw8GHldDifYI8Hr1ZVtidupvceMD4VAN9K9TRQ==
X-Received: by 2002:a17:903:40c7:b0:21f:8453:7484 with SMTP id
 d9443c01a7336-22dbf5f704fmr147698225ad.30.1745822396574; 
 Sun, 27 Apr 2025 23:39:56 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:39:55 -0700 (PDT)
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
Subject: [PATCH v3 02/20] qom/object.c: Fix type conflict of GLib function
 pointers
Date: Mon, 28 Apr 2025 15:38:51 +0900
Message-ID: <128ace316789fb5af6e6cdab7788ebe9b6bc639c.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

V3:
- This commit is included in this series sololy to ensure successful
  builds. It has already been picked up by a pull request, so please ignore
  it.

diff --git a/qom/object.c b/qom/object.c
index 01618d06bd..87f84bac41 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1191,7 +1191,7 @@ GSList *object_class_get_list(const char *implements_type,
     return list;
 }
 
-static gint object_class_cmp(gconstpointer a, gconstpointer b)
+static gint object_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     return strcasecmp(object_class_get_name((ObjectClass *)a),
                       object_class_get_name((ObjectClass *)b));
@@ -1200,8 +1200,9 @@ static gint object_class_cmp(gconstpointer a, gconstpointer b)
 GSList *object_class_get_list_sorted(const char *implements_type,
                                      bool include_abstract)
 {
-    return g_slist_sort(object_class_get_list(implements_type, include_abstract),
-                        object_class_cmp);
+    return g_slist_sort_with_data(
+        object_class_get_list(implements_type, include_abstract),
+        object_class_cmp, NULL);
 }
 
 Object *object_ref(void *objptr)
-- 
2.43.0


