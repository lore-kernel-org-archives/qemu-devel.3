Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE933C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IBW-0003sN-VT; Mon, 28 Apr 2025 02:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAj-0002qN-86; Mon, 28 Apr 2025 02:40:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAh-00077J-HM; Mon, 28 Apr 2025 02:40:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224100e9a5cso51812535ad.2; 
 Sun, 27 Apr 2025 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822451; x=1746427251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Q15BGW6LhwhT6zw6SRS78AEAgNrS56qYf9dYAkVJ5Y=;
 b=AjylmvaFPr+KHJRSTh1qYpgiOI4sk+GwXkn6i9Fp9hXvz7oWUseD0JKkR+OPfMeTBP
 1ZHlrz/a1IzRtxg+a+nxcVPL99GPmThA5aFDS9nSvI+KeHeapqqgzafXs0zkYPksXv9e
 JNFcY144PTF4XEmTgf88V42ZEx4FBxuqDIuwITs/RV1KLalkRvg/zD6yaqSluIo1TRyG
 cBhSVhhm05KIg+4BlDf8r2PxTJQp1X8u2Qp3jkLWlYXEPJa1rYK8juKvi5AHDit8C4IK
 LET1QYYJdiDHOGTGuGFGhsBTEoHjJyF6iicm7boa8PnEMK9LAFugf4/dLP5pfiI9bj7q
 T6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822451; x=1746427251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Q15BGW6LhwhT6zw6SRS78AEAgNrS56qYf9dYAkVJ5Y=;
 b=gL5l145cxTpn/Lw9/WI0wmh/9F/xxtqRYHyXKpV3kMO0L7+k/NDjLnQoujh4DNu5xk
 3PuLgiC8xj34URrsm+tk588ZVPFBd61dRlRQPkAo5XlsN0rJ+UEC76AtLlE6Snb0Xe68
 cGwJBgapqn7BTLHulSA8fWf6UD//62w18lsfM08C1TRryPfnELnJhvg5+xa6jbnftvuN
 VXIyD+vELBUGhrNFZMC8n7yHPCmWgeddc2ETZLeKNXubCGbj2ZCoWIX4jDkBuetFM+bB
 Lw19xl5Kdjqg1YJfbT8gz5av4HP1AXz4l0yv7jKOppCmxj4Z46gXpPQtj0V6QL7dsV2K
 wAqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV67vCddRrFSDfqi929phd9Z4cc2OC5/NHVtfxJOI0AiANHNpxfdVWUQ9Mt9ZsyjEBGzPE1FTIzrDo=@nongnu.org,
 AJvYcCWMxxxSoHT0fbiz2zTqKhIFE98ouenKTIyQfdwVud2tVBDvdi6/VWCQXypbYlz+TMnR/rUyyKtW6ZMsDw==@nongnu.org,
 AJvYcCWX7XeUYNMt29e8FAqw0ZWJ69nC//w18wrbdKn7XETt1eoU9fN/JynxpN8wp32kzu+Rd1/jfWOCOQ==@nongnu.org,
 AJvYcCXALKvvQLO+Cyhgn/8PerCsFJnluDXFEH5utYI283qephyzdtLIoGpHHxa4I5kMyXhjeiEivL3Ug67QZg==@nongnu.org
X-Gm-Message-State: AOJu0Yw5bVzryG4WiyU2pmfaolkcRySjjqDg3cpLjsSMVo+dLFXhskfA
 9pj4wvq3BUM6HLProXWjmm81SQC5E2thWOMZAyz/lo1FIEKgCCBndw27XRmi
X-Gm-Gg: ASbGncuDzO1jx4qPmACTY3fSw3tSR8nL+UO1yfeZ6U4cDoqoBykgxLeJPRGtc0uXkb2
 9mOyDKu/IBhAz9AtZ7lMJPPLGzADKHTZPci4AHpm3kSDXQq9eCFfg617/Mfki5584HF+XmrmLoS
 h/ayHcUw5LwavnQ8RH4DlH7GH4aQWp+j7McN4UgTVhIBb040xhHVK3sRhHmdsmFSbWHI3PrWrYU
 vevNNyYgk5tFVizk9A01Wfe18q4PNwtb+BpeCOaGumiGcDTZgZCrorPyGUnkyviq07BZRJqAjr0
 dfPcnj3ohskfB1W1N1EHIs61xOxMsej/+eIq5A==
X-Google-Smtp-Source: AGHT+IHUzvkkUjB8d7ThlNvRcVu0LfUpCbBEl2GyOReJ/zYjSf2e/+O+k3koZv79twbkihrK1nuyzw==
X-Received: by 2002:a17:903:1744:b0:220:d601:a704 with SMTP id
 d9443c01a7336-22dbf5ecbedmr128835925ad.18.1745822451373; 
 Sun, 27 Apr 2025 23:40:51 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:40:50 -0700 (PDT)
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
Subject: [PATCH v3 09/20] target/s390x: Fix type conflict of GLib function
 pointers
Date: Mon, 28 Apr 2025 15:38:58 +0900
Message-ID: <e91c4e266b839f62b5c41173a05896b210ae1180.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62a.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8e0b01dc65..5e7c091681 100644
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
2.43.0


