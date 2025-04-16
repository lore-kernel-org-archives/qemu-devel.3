Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC71CC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xxs-0002rE-Tu; Wed, 16 Apr 2025 04:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwH-0001Pm-SS; Wed, 16 Apr 2025 04:16:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwG-0005od-1q; Wed, 16 Apr 2025 04:16:09 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso360053b3a.1; 
 Wed, 16 Apr 2025 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791365; x=1745396165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eM0jw4nOu+oWx9X+qy9FQBh8QDUlsZEwEq7XZqMA8s=;
 b=VIp/Aw0Fl0vQRU3W7Q5O8xdWa1OpuJkFJDQ5QDJOMzU7PHpeSYq/SQYDwaDRuanq5W
 EJ6onWcpznYUWUQ40HHdGC+dE9k1CbFHLC0bKkxOvKBnLcSAGsZZ2oDTd2hPkN/xUjLw
 avTupz88Jp3t0cEdFiIDUA+SlY0WCxHWRW52/jtyLf0Hi3kK6nuOOT4CQxBRZgEpjow6
 yI5Az610h7i+wtJcFdj9Yq+GLHlOp39Up5/l3lOmdt7ZYT79snzEb1xXAfZexCKWu3rH
 JyEYGyL5PwG8rz7payvlLvsOC2wWeQie6GI2+OqVfNanqX9PeEmsRb9fuiEWkcqhA5JM
 qW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791365; x=1745396165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eM0jw4nOu+oWx9X+qy9FQBh8QDUlsZEwEq7XZqMA8s=;
 b=lQxNg6pvpb8cRhqUMhzOrgoYhBXg6b4j9Ch1g4DtsIYRwKoumjKD6CaJWvGT3wtlmv
 8K89+55l0qZxs5HImkxAscrKGIJS82Gb1BJ2tdulldRHaynQl+Os6IJYqOn5/7ehMYjk
 grS5U8jcKljm+sOrppWvZ3DMGpLoXVnqdM+JS3yKVTnmiQjAJQ69ighcSmm7QKQALxUF
 St1IYh5kvE81bACEpG0rH3VBBsmfMp2/k/pafDpdRJ9DBdsLCFl4YSzmdi7JyjSSk5Bk
 ZZ8anglN4VRJ2t5OMao48toSs0A85o8uGRR0URKgN+j6nqNyBG4CaOS2DVJSxgaeQg/M
 cbow==
X-Forwarded-Encrypted: i=1;
 AJvYcCViI76Z4rjTgKFI9Tgc9Yi/uDSxdTCQCQ12RyXI01AMXkj4L1Jllr0W6jbUZrvqqDAzMCPgO36lGzDRYw==@nongnu.org,
 AJvYcCWK8wvBcz1l1oWHQFL1t5v8fCq/Kh1tMU00jSRWagu3o5POoHGIOD666bXjfz2hpQTdJ3PoEPhuFw==@nongnu.org,
 AJvYcCWwnFtIbSWMZmZz+PQbxaj8d22gprM93v/SwG6CYxgeqCJUep0ShpYAFhTsNtZ0a+L5WUjvuwJtm1UVJQ==@nongnu.org,
 AJvYcCX6WCiQ8z9ViPmcSvb/IQhLPAbkznvBOD8bikVTlof+/oWKriPKuw/dZk9d0Xjk4z4XWbAqjgS9nfM=@nongnu.org
X-Gm-Message-State: AOJu0Yyco5gFO5aMBqXZ/lxsERIKf9Nqlqr4l0KRs3zFAy8HZPznoad7
 9lcinTZFLZezzfX3a3eYbaMHjFJIeR13P+FpfjAPf/lQVlBGxI4KrrTXenkY
X-Gm-Gg: ASbGnctlmGXgNG5cSOS50LMkVn91jDQjtMcWWnMpRju5JLycuoHXbl1kxo2O/M1E1T8
 /H+5pa7sp5EvPbFbP2xJC1TU0+ILblqCUCAPmzAyFmrwHBBbDgnn8HhiiKI/wKLbMAd1E7glD9p
 2BmESaZ7zRbEQXoMdadGs6UwVs3uBQL1F1hqmXX/SUQdwPIV22aAUz55CbyTkXj6pop9RDZZdtZ
 YNn3C42ZGnd80gu9u+kYs89qEfvp1/jOnM1AnQndyvQ1907JeJIhC8BHr2bj64088zC3ej50Yyw
 SjTvWA87mRUS+OK5VL3T0CfoxcN+5+yI10RGbfFxIrp9rJZj8NLlmwC9iA==
X-Google-Smtp-Source: AGHT+IHuXOMzEgeut1wt/ioMVDm9sPvMSsSZ72Ps6KyQRsi/9QtAQ22BiRbOpCSbljETerW1LR+dBA==
X-Received: by 2002:aa7:8890:0:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-73c26d3939bmr1349443b3a.5.1744791364649; 
 Wed, 16 Apr 2025 01:16:04 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:04 -0700 (PDT)
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
Subject: [PATCH 08/19] target/ppc: Fix type conflict of GLib function pointers
Date: Wed, 16 Apr 2025 17:14:13 +0900
Message-Id: <f94cc2339befd094e6180d876e3098880cce2dfb.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x429.google.com
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
function call using g_slist_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f81cb680fc..f03e48ba31 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7115,7 +7115,7 @@ PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 }
 
 /* Sort by PVR, ordering special case "host" last. */
-static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     ObjectClass *oc_a = (ObjectClass *)a;
     ObjectClass *oc_b = (ObjectClass *)b;
@@ -7183,7 +7183,7 @@ void ppc_cpu_list(void)
 
     qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_POWERPC_CPU, false);
-    list = g_slist_sort(list, ppc_cpu_list_compare);
+    list = g_slist_sort_with_data(list, ppc_cpu_list_compare, NULL);
     g_slist_foreach(list, ppc_cpu_list_entry, NULL);
     g_slist_free(list);
 
-- 
2.25.1


