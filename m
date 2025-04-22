Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D48C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76DX-0003iC-AZ; Tue, 22 Apr 2025 01:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76C7-0001rl-H2; Tue, 22 Apr 2025 01:29:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76C4-0007sU-Et; Tue, 22 Apr 2025 01:29:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c33677183so53726225ad.2; 
 Mon, 21 Apr 2025 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299753; x=1745904553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vwsMBWLqSru1XC5tGa2owIx78df+Ne2sGVF0WVxroM=;
 b=C0qlR00wT0McfFt1GyudLiRowyymSbL5c2/I91V7yqL6XAxTWbsH9xDGmnVHqczJ/a
 mX6chp1t2l6RJqOm4yXKRGWy8AZAzgGu7dg/GNzezjDLJMAR2y3cQFKCTP4fNQtQitZ2
 EQhh+ieVMjFZidzWgKt6xsu7nBZFBBcoe+geHrStI5RuvY/ce0GZyubswcnbWRzj+r2v
 sVX/Zas6mJBdjGP/l1EPeXt/Jk5CLewZTlJ0bRFxeH64IsXZ6/cTBuNHlH89UTAdzlGp
 Ry5kJsm+Oe4Z8AeVtP8BY85nF6j9FNoOjnTCiU04pSUzKjUPgyW5tXNk6VDyfbh2PVJF
 78dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299753; x=1745904553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vwsMBWLqSru1XC5tGa2owIx78df+Ne2sGVF0WVxroM=;
 b=LdR7jd7InyezlFiAPma4BS7EIKZr7X10c7Hkovn7gYF6TUfgZksuUqfofD+wmcWkSk
 xI2arOuMdrMap7Uj/7P2Kg7w5BaCo0SlHX4b7/nV/EKmCPvhO4Da4wQE1A50gtDDa/3U
 xJaKmQ4+Qn5uBTLt6oKc9XtTdO3VPzbS8l/iNNih9j2vh73Y679ru9gk205JaCGlPu0w
 YgYW1BHS9nEKmIDuA0iVo/GlyMvKSgQRA8MgsVLZKWPcu8ORs2stq33X1+zp4/PlFLnJ
 fKq4VhLNXvGCW67+60dTwxTqiCoDzmUv0wpWaTgn2VkITB+26SNp+t9GtSIL6ZYhwwEI
 zpGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4P/FhHVsWHOQsOEAtivYn7eStl3hdrAIX/GQ0sSW8xvNVsxsdwDC92UWhfb8a6YqB9hvZvvboDQ==@nongnu.org,
 AJvYcCWXp22JdS42h1Hiuydlaz+jTN6uYcYYNkyXYDLETIc73Zm9iGU3x1qj0lCa9WZKemE2e32rqrdg24k6lg==@nongnu.org,
 AJvYcCWgPMI450FAlydQlfoyfs2X6r/JBmmLevdikhpztJgqiJnUK5SUaYh5A8ce36Ef2LtAUveC8+3kMLzczg==@nongnu.org,
 AJvYcCXCmbxtVEL0Qzkt3qYOyNluXiqKqW6SdeUj1JZHa7zfjyaQgpErPWfijAaaiXtgMYBBEFf4NLtOBR8=@nongnu.org
X-Gm-Message-State: AOJu0Yz4PjGmypT2X0QqejxkNNdiPQ31m4fc5T59VqonW3MfM/xGfU3i
 i9Y7YIGdFdjKAqDZc9YYqOhMqNFVUgWGbNtWh4m19UgJ8MpS1EjA/N4RNgBy
X-Gm-Gg: ASbGncubleX8FST4fuhrhaDkHa/uKlEMWblpMmFSbQub5cGcCnL9NB0ZCUPKk25jlrT
 UJ+AkIBtBb8CV7O9O19o2rZnnLzHWtxw0CcXrYWfotM+xjv8IO3XzZ6Z2hUj5xdEARtQZ7j3f/r
 JCpc9hUD/5K47Tc12cGbI3AEKOMVbCOAG5UjEWy3758r+ZS/pDBZfnzZDogSe3OrLhwHEKqm3PY
 BWRy3CxsrrhLfpuc9mfopBUkqXJlXLoLt7mLUA5yoi6Wd8AP0kuzg6Ig7/23XUnth9GKB2HzVmE
 QhTxDPmgu/0VbDWp9NgkXQ/KwUTtMvGh0CmyF0JHzrcRWiD52eISHllIamI=
X-Google-Smtp-Source: AGHT+IGcgLfvr8Wdb5riVcTXWYTEKyRMiKMNTuqyUTz74/+a7cYyYkhgkYkaogzfi9swQMO3/AnoyQ==
X-Received: by 2002:a17:902:f682:b0:224:912:153 with SMTP id
 d9443c01a7336-22c53573d25mr231402555ad.5.1745299753393; 
 Mon, 21 Apr 2025 22:29:13 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:12 -0700 (PDT)
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
Subject: [PATCH v2 09/20] target/s390x: Fix type conflict of GLib function
 pointers
Date: Tue, 22 Apr 2025 14:27:13 +0900
Message-Id: <1e55b633d50567e8b145c98f626af5ecd93001f9.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 93a05e43d7..48cdef285d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -373,7 +373,7 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
     g_free(name);
 }
 
-static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     const S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *)a);
     const S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *)b);
@@ -415,7 +415,7 @@ void s390_cpu_list(void)
 
     qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_S390_CPU, false);
-    list = g_slist_sort(list, s390_cpu_list_compare);
+    list = g_slist_sort_with_data(list, s390_cpu_list_compare, NULL);
     g_slist_foreach(list, s390_print_cpu_model_list_entry, NULL);
     g_slist_free(list);
 
-- 
2.25.1


