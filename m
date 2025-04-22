Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97EBC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76Bc-0001S8-M1; Tue, 22 Apr 2025 01:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Ba-0001RE-VO; Tue, 22 Apr 2025 01:28:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76BZ-0007pr-8Q; Tue, 22 Apr 2025 01:28:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22409077c06so64333465ad.1; 
 Mon, 21 Apr 2025 22:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299722; x=1745904522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hr9XXQB6Zuvd+iKttpiqSUP78igtxru6uVhXXPY7Q/k=;
 b=dIq7MrwkWCfUkjKd5XEk8Zywlaky8lKU1Bi2Iv4BiAb4A3OrzbovLt+iFq6Himz28l
 6uthAEW6b18y04McXB3TSdraAu+Mo/vE5lPnMvcuePN2EpS6PkwehjyF01zBXM+nFuMG
 9aOuFO45Vt3BY0Ayq7a33WOiLuXHCuk7I4DsqT1TWhTR+jZ0Ud/rpDmXLOFLtKZaYePx
 98kNKSTGUhkiDXeozaqI1NAvFzicUl0ira7i1mjTbFwqUd+ivciMU3BDK3McJKjXCceC
 W5J/aBuFU7HV3DN0bLXMk7FH27XTeXdxrWuETVN7rRgTy7hc91nmlQ6eXLop0uZItSEa
 9Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299722; x=1745904522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr9XXQB6Zuvd+iKttpiqSUP78igtxru6uVhXXPY7Q/k=;
 b=PCfsxM/7aKcISqwM9F1hTVgoHfxZgvNMy60q2y6jAICz6hW9tc7j4MjX3SAWWdZC7r
 LjbiLknXWqj7ZO9NQG07kkc73J5aevd/6CaRmwSEy0bJVa6aTyFrgZo656fDAeC8CHQq
 /CIhZlmaJovdPoQmMpH1IWXT3qRmnpva1Gebc4EVudAhB+AQhtsbmbk1Bd0/VQqCitUJ
 HmpYxRq8hPw+UaWTOSsaWSml8s7bW0xU+MvDyjA0L6iYzO4rluIS+tEdIJ7q4tlKOqwD
 kxN0aybPzrzvoiS7zmSgdoG4RC/DH+4yaAekIq9wXge8dTSfBSjtR4sVdFoIldyIitDa
 EcRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuaPN46O36Ia+mzKYLGcOJc18D/ZYU7rIt4unYN7w/OQ5d1EeDSnhPSowy5gW4BDiqBvfNUfp5kU9j5A==@nongnu.org,
 AJvYcCVHW+6KyiOi8jjqj3X/tz+MmpCJy77EOu6itR/PnuG3O08vWa3CibE6TiAFZdeeHtZ740St+kOwqiCYkA==@nongnu.org,
 AJvYcCXSgpL8DfzfvhmPrA1JbzRCFZU0TuUBVZz/tGHoY2/OQy4mNazk8rCNByewoS7BxzXQ2kh8OdtHYgE=@nongnu.org,
 AJvYcCXTTnGEv7Lygudal/yROBJ08xl5oRejSrvmEKrJA7YpviUZWqEhKFjCRv4ae1WED0vpl/KBgtg3JA==@nongnu.org
X-Gm-Message-State: AOJu0YwERcWinFSo/s9TlOSFXp72Xdshwy/+hMJvOhLSBUpqLbXe/NGK
 0ojAK73yU5DxDYFaCj875EWfmc9kO9gsfUoFP+skXQa5JSwdQ4pqBaIMTIqd
X-Gm-Gg: ASbGncvfH/H+a3bHaR6Cb3CZe3gqm3FHiGkqKlXto3l/4z2hJ8p0U2Yduh0gwCU+k9H
 gQB0tsYsggYuArUHTkHYqtMoipKVf379xkkETXIRVJg9t0ukTUCdUipuMYI4YCB6UliaTz5YQjm
 eyWs/DFH4OfVdpvLaPDMaip07MO+Jydw/b/LOCjFLiOScwcEAhQ4izJ0xn0F5O0IBoUoe5mxB/A
 HV+LoNfUvAPFuy/8GL3VaPL+cvS9CxTf3V1nInwOwIfI6LRU3NjwUki4ZznE4g0lQLSpo8yPLt9
 Ko/vCgXkNT4voTUYAvO5rtZC2h3Z6aqOeCE/jPDV/WLn4caIk55CRI1g11DEWQHxr27KMA==
X-Google-Smtp-Source: AGHT+IFEW2NT+cAzggJEpQL3dt6BcmbrJbdC6ZiC0A9EVoOH3QZflzMIs4u+eWmxfq5VVr0igUgIOg==
X-Received: by 2002:a17:903:1b67:b0:223:377f:9795 with SMTP id
 d9443c01a7336-22c530bbe9emr210573765ad.0.1745299722329; 
 Mon, 21 Apr 2025 22:28:42 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:41 -0700 (PDT)
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
Subject: [PATCH v2 05/20] target/i386/cpu.c: Fix type conflict of GLib
 function pointers
Date: Tue, 22 Apr 2025 14:27:09 +0900
Message-Id: <98cee904084f66762b6ef9fca4248f1c8c995d3b.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62c.google.com
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
 target/i386/cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba..2c494e4b0b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6226,7 +6226,7 @@ static void listflags(GList *features)
 }
 
 /* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
-static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     ObjectClass *class_a = (ObjectClass *)a;
     ObjectClass *class_b = (ObjectClass *)b;
@@ -6247,7 +6247,7 @@ static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
 static GSList *get_sorted_cpu_model_list(void)
 {
     GSList *list = object_class_get_list(TYPE_X86_CPU, false);
-    list = g_slist_sort(list, x86_cpu_list_compare);
+    list = g_slist_sort_with_data(list, x86_cpu_list_compare, NULL);
     return list;
 }
 
@@ -6304,6 +6304,11 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     qemu_printf("  %-20s  %s\n", name, desc);
 }
 
+static gint strcmp_wrap(gconstpointer a, gconstpointer b, gpointer d)
+{
+    return strcmp(a, b);
+}
+
 /* list available CPU models and flags */
 void x86_cpu_list(void)
 {
@@ -6326,7 +6331,7 @@ void x86_cpu_list(void)
         }
     }
 
-    names = g_list_sort(names, (GCompareFunc)strcmp);
+    names = g_list_sort_with_data(names, strcmp_wrap, NULL);
 
     qemu_printf("\nRecognized CPUID flags:\n");
     listflags(names);
-- 
2.25.1


