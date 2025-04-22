Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7F8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76BF-0001Ii-Et; Tue, 22 Apr 2025 01:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76BD-0001IK-Oj; Tue, 22 Apr 2025 01:28:23 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76BB-0007o3-RU; Tue, 22 Apr 2025 01:28:23 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-aee79a0f192so2950956a12.3; 
 Mon, 21 Apr 2025 22:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299699; x=1745904499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9YjZLFky15fQ25eN+PsZB2kxxrFQ2yvjf7JgWdhp2A=;
 b=IRy/TvwRS3/jMLUElwUY4X8zgo/cBp6iStbIEyaIot5CFfS7Sa4e2qf6k0UwXrpD4h
 AdUxagGCMtDlxKt2MI3ibOhdehSciL3v9GJv3A2sfgzf+SXD1Q0YUsfCY3pjDek3y7Yp
 Mmxg/TTlWtVWpcTUqR+esq5XriewL6ic4YJxISJj/Noj1nqXxDQlJA2LJ1ndeS/Ri40N
 dkrGN6WI/GjdClkoQzh+V51ZB4cTBOfE/a1rRSZtOQYhAOlwI0UvYHqd0eWscmZqfh5H
 y1l9McH0NBxee/6IHQn7M5FeIy85JTLfHxkaNyKx2lyisj4oiqEGdEwLsoj4pnYOhL8U
 kbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299699; x=1745904499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9YjZLFky15fQ25eN+PsZB2kxxrFQ2yvjf7JgWdhp2A=;
 b=MExIBJkQBgRmcLBaXSpE6Yg8dL3afaGeb9zpEXlPS8aBTCCvANJxMXA6tyECDxhYlL
 gijCJangA8NoQs9XURNFyHmQEB4jmanIr/QndwAgvWZXGNgUgaWD2Js/SP9wyQgTGcQp
 au7lNvLO93GzZoa1jOiKSDQSuA/s6h1SCWzZfhM8xmUo/gnydX9W/La3nX+3kNnbzhKw
 mt1p+A+ZQ/1+51ftE1kpMizju9wIzz7xEbFF2MqHggdAjoUnIojQqkOmv4NgEhhT79mf
 vCmxRbKdTowe36kTAz4Ka8F81nHOU3BIEvQiJ4ZFJ4/aYoWz2WjBdPkewIYHepP5/AAu
 uc2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcwbzzQoagV7RDxYlOMI9hI8cHFEIFg3e6haQCpJt08u4//GF+R6XmqTV9a52uDrzFk0f2LoGgwtaU+Q==@nongnu.org,
 AJvYcCVS54wOXYveWgDdX7vTyCroR9mq7l8QfEHJ6JZArH8Cvk4ieV8POOUP8pavlKC89mQqkWhptPTtHCA=@nongnu.org,
 AJvYcCWDxEH3qvD4upRuejp4DJc1JF/xP9vtNIX5Zbjem6vazPGwrXjqdfuc7sbY5fCftiwyvbccxG/4zw==@nongnu.org,
 AJvYcCWv7tP2JJyMEt3IhL2X0G6QQIsEZ2+Rlj73fs378LbsVzefob4/LxUwyfD/EvqeQwEcKXNI/nvcn//V3w==@nongnu.org
X-Gm-Message-State: AOJu0YxjGAipEsN83P8q+LPXDxAOGiq9Mp3XLZ84kJU0WYJ5VoRGnY/M
 g8FfUg4Fba0/aSGKpycLvAg7C1g53mPZWgr0VTEmNonlLyS8hpOXJx4C6qXV
X-Gm-Gg: ASbGncuqtnNfYLua2i1L/keUmoxK7gVkLxB9XeF2EsEmZLsWF5OcMvuMuC7CGqFADJy
 8lE9K2EcgRycmlqilzTdqauCeTSQszx3sA2cTlDMZ6JOXcHd7rlpjFMiohdoEs+nItrdAUWJBm7
 WQJRxQ7SZmbFLzg8/6q2Lj3r6BKBjc+d+cuQQf4IffPoi+IMiMH+zFJ0YJYqTSTub8mot3YeGAP
 lUwd7Oxe3XvAtXI08YstHeoPpaf/bPzU4fRGDRVQSTQttS8UELqEEb3Llfc/ghc9TYAY29zQqT0
 T/cJdoFzUNXwwnK3VF4f6rdSsR5NtjPl9k5KHCtOnCAutaC1YvbfRVh8iSw=
X-Google-Smtp-Source: AGHT+IEclO4OoJigEUfTejjyH3NIpSNJXpyhl1ePgWwzpOp+ffb6EGFjIA5uyx5Tw2/HzCaV2+Jtpw==
X-Received: by 2002:a17:90b:2e48:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-3087bbc9349mr19070468a91.29.1745299698887; 
 Mon, 21 Apr 2025 22:28:18 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:18 -0700 (PDT)
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
Subject: [PATCH v2 02/20] qom/object.c: Fix type conflict of GLib function
 pointers
Date: Tue, 22 Apr 2025 14:27:06 +0900
Message-Id: <8ca13f4e2b9eba9d1f6030b0afb442a24330e463.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
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
 qom/object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

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
2.25.1


