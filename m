Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1154DC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L19-0002NF-8y; Fri, 25 Apr 2025 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0J-0001Ci-0k
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0G-0003qr-1a
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so2122045f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595010; x=1746199810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qyqAgsMl7PwKWyQcrXSb+jM1udTOnFyOaVgMp4zBvY=;
 b=KV6B8rSfGFSckNH6VrIs3Ind4k75HVPyf2KBvkwhzVZ9Khl7XkFmuy7q7AG8oH5Wh+
 nvpZ+2iO/4TAzH/KcPjh0cUkca2FqB9x2FsXKka1mVkfC2VM7klEYsP5OHNFzzaKPuVr
 +1MTNy2JRiIIEEviEUIVwhNOfjb94X/i9pKlKi6E6cEVG+gFfLZmIUGk3IN7Vd8zIsEU
 1Bm8hUKjAHRn/I7AvdppXbPH5PrNfnzbEn9nBDZYdw2GmtxyHGqHg5Cf9veiNxQhw2DW
 8zYR0OoSntSNGuahusaTzRoyLmStsseMpq7Ii5Te8ym6S4wfVvIeBamEGNgyPDKHQwfu
 ViIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595010; x=1746199810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qyqAgsMl7PwKWyQcrXSb+jM1udTOnFyOaVgMp4zBvY=;
 b=XRb6tH1K2BLqU957b1wK3l18dPRhSTq8ZvpB11LdwIedtGzgq5J88/q07VHulp2LJE
 nnozCw4pAnWNRoqK5RMo8DeH7ZOyBQqq+t8ysQx8/NcZAX+A7/kHyhApkZtuKKuBqEg9
 dbqecYcSPgjtmax14u0SWa0dFtwLJZC2efjXY/VSIJDyOO7MJ7XfCspfqPENDB3Adj1n
 rBD4QLuzuGYROBDQFvKCuRGfdjt62e5DQtjrL7r4lPeG02qRm8XGgC2bn+KxKD8Ed+Gb
 tHkzq32b+NPcCCaSQU4fPS68A8KrgN9Xs+8Ff8QLNASyCPgJh5yxuJfCKcf+UWclB5wo
 TmQQ==
X-Gm-Message-State: AOJu0YydCT83JfrWW45nMw3ikPi8YJATnP1gMVIH14da4nVJKo8RmHeb
 SflMGVP9bakDgKLJuyKDOq/C56bmidfQ6DDHVs0nRaZRF7MyDgdOsP0hMUmHAsBORBSOgQJ5Iyn
 D
X-Gm-Gg: ASbGncs3R8AUxaokj48b04TS5gAIaFtV3mvdpOyzooAxFJOa5GnqCj4U7HdK7JHNzL1
 s/fJs/HHsa3CDfQtBoQVpsNeOR3bvL/xFJFdyHxFoNH5wdQOPwv61mCgTA2Z7oWxFYj89ZRS5L5
 koVUzGTfu67sR9rPVw4ROvBlo4thCjyzA/MCQ5O1fnMvFRpJdYe2j9d4z3XJTZahMQ1yb2MSJN6
 JuDo1GWolrjBRsyfwdMpMXMld4ZjuUveyMPdvlLGEH5UF1bzWYUkcPSrAeojIs0/ptJtFKdY4R6
 eKAqF8AxeOjwRJ/dgx6UtoTgEzY6dLSLeE3EzRYrSLehaaAbGFQupoSEqBZ/U8P08DPjo785m9K
 HDfKnD2HONn7a+dA=
X-Google-Smtp-Source: AGHT+IFGgfjhMIceIRMETrVtVvUK2GXRueWko3puHURh4iS+jphNtzxesL33N7+irgZIIvvc4dsusA==
X-Received: by 2002:a5d:47ad:0:b0:39c:11c0:eba1 with SMTP id
 ffacd0b85a97d-3a074e0e19bmr2178441f8f.12.1745595009892; 
 Fri, 25 Apr 2025 08:30:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8c973sm2682620f8f.5.2025.04.25.08.30.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/58] qom/object: Fix type conflict of GLib function pointers
Date: Fri, 25 Apr 2025 17:28:01 +0200
Message-ID: <20250425152843.69638-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <8ca13f4e2b9eba9d1f6030b0afb442a24330e463.1745295397.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 425ee2f0ee8..664f0f24ae8 100644
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
2.47.1


