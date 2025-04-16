Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0D9C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xwL-0001YC-Cp; Wed, 16 Apr 2025 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xw0-00012k-TZ; Wed, 16 Apr 2025 04:16:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvt-0005fn-Qg; Wed, 16 Apr 2025 04:15:50 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so5947718b3a.1; 
 Wed, 16 Apr 2025 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791341; x=1745396141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpJvxCQGaFnF6HY7NcaQ25KSvKw9uO9sC1x3AjQFOq0=;
 b=WsXJpWl7bfdeyN8nMABcUNYxoiU85xAqlrsyRgZXeY8gctRWBKKqs25skkGq2TAN0Y
 iYvR2EdmjSPKeooHUofLRIu5r2Qb6fLF/VC4Q3u5P+OuevE4QLdONKVqekN5BA3Z2mcw
 rOeIHUdr8+7ITgM8/Qq2Tvp0Yfxcz3w7BSkMOFfTzgGAKqQFqUP+xoWP4VDZSIfcFGwy
 707e6xJzUmtZQJcUvW26sm3Ezv9tNcDfz94lCeSzyv1OWPq2EtpNbJFsmy8u8zIywZEP
 tgONpfwtNJKH83Cmsbl6eTEdBE25axWJW5KS0KiuhWamMGdGlxkvGucFEeKPcI2q+6QO
 k3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791341; x=1745396141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpJvxCQGaFnF6HY7NcaQ25KSvKw9uO9sC1x3AjQFOq0=;
 b=rPJT2mhKWJtMkvXnNX0b9041aB9opR0Gfnsou9bOYQXfBFBSsC8vkLjgk3H69HPbgN
 vNZ9IuT8jYIBVxQacBGThwtJJbHv9bWUAc4vqyjzRwz6DtAEiiommIqtMxP+x9YskuYM
 q0xfAAKbuELeyOuK2oZkwAC1AQHiyfCJ4mn9QS3767pfIyn5bKsINBLGEfqjf7KrwAKo
 0ZGtFMslktEiKOcjOQpOSic0yce8jphjwWBN3OLk2fPEwZikpgENuHyyuewWN9169/uh
 onM4xw87CNdrowMfhM0L+iqV1Vu8cFfGUs0sKP0CmwN5IEQww8hDOwuaUezNBKaNKkEU
 mShQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4i1pJz+EMb5v0TOTm/GXu2QvnuoAu5qwQ5cKHAYK4gBP/q6QiXQOs3sv19tr035p8Yyfa6nR53yTdZg==@nongnu.org,
 AJvYcCUzj7WS73Og2li/1P0EpXNw2i8/8aooNtaJkSGB8F0fwARpl5xznjPcpA7uLihDyu+ZQaQ3TCoGEydo+Q==@nongnu.org,
 AJvYcCWgGnPGd+LUKQNNU+KhjrnOCj5rzgsCuWHYrpeTzhxJWSsZgZ+/rui2H2wuXpTuqn9As7c/JE7hMiM=@nongnu.org,
 AJvYcCXlvMfwH/qjs/GD4EKlozius1KD4nxJHXXjRtj0tNC94DluBSZ/Vq0uSIk6IJAbRvP5Tm19fT4wpQ==@nongnu.org
X-Gm-Message-State: AOJu0YwDmE/DlcnJ5Qc6BMSWesah2IkdugJ11zQaRfHR4sQGTxDKijCF
 w1WAOpbaHxjwqZKn/xNF9OmuASBrsayIZNEMuD7MJZr44qCZ7/FtkC7qITzC
X-Gm-Gg: ASbGnct4SEUZHFnZZSpc3WmB61YwXbK8v7Nudw2fbfGxbXGVEOa467LaIGuyfTKd6Cb
 d5h0wmEkYzFRlXWxlO2VE/yMpPULoWgDESoAcxrfjPuA2D6Kamx158veEgOIQH10/+6Ta0Rxomj
 uqHn18LD/EH8icLerNlb+sv19y4E6fARj51JGFqnYhhmgEkMF87t0yUyGobhA+IrC+jWObgi99h
 jddow5Zhj7cHLKNz8rWjE4KdpG6pUIR60CI2PYgAWZKksZhZzCGezjkrX6rx/J/OWJetvUH4S6t
 ImYzYwwSe/syELxxPk6CQqt9FPCr/TMP/JnjOYkYDyZuzz14ApNKCCcmJg==
X-Google-Smtp-Source: AGHT+IGxLpFGOdeLk9mPFSkfHfbJw8A0iENnrM/+hSulZm4CxoTeH4oVbmxYU8fUDsz6zRCOaAXueA==
X-Received: by 2002:a05:6a21:670d:b0:1f5:60ce:6cc6 with SMTP id
 adf61e73a8af0-203b3eed04emr1324160637.21.1744791341546; 
 Wed, 16 Apr 2025 01:15:41 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:15:40 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 05/19] target/i386/cpu.c: Fix type conflict of GLib function
 pointers
Date: Wed, 16 Apr 2025 17:14:10 +0900
Message-Id: <f73846a5494a1b6f2abb7143ad682c640ef4b9df.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x430.google.com
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call using g_list_sort_with_data and g_slist_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 target/i386/cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

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


