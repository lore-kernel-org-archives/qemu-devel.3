Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F2BC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xyc-00048m-89; Wed, 16 Apr 2025 04:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwX-0001vq-5y; Wed, 16 Apr 2025 04:16:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwV-0005rK-8V; Wed, 16 Apr 2025 04:16:24 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso3176137b3a.0; 
 Wed, 16 Apr 2025 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791380; x=1745396180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SASE3XTeg/hH1Bv2p0ymNoIDo1zAKPv9dOqsCm+H98Y=;
 b=ghWV6wmrFsmZ25MEH74EsWWmIFXkfgJMdftkvrXai/7gE6KH5cHbH7yoKL28nwyWSP
 c/xQn/28wTAJmEjCajTEKg/AKY94+bkAlcYyCUr3K4zYN3wF/dh+WfPSakzx3O7lTp57
 TToMN1F1umlGSlqK1x8CH37dcgOQke7dvEH005rhU2pWIEew6yc64/Y7Eltwbr9chTvX
 JRNlkb62XSuTG0K5wa+6iYdRTC2AiPQ1mfliG91LM6U87F9qFEkgZPCTtFZBYtD1N44F
 zavo/xsy9sBiBrjDrVU/q8rtA+y/Ao3uGw7xviyCGXV7t0Cu3xTTwLcZHXcda6tB+UtG
 xorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791380; x=1745396180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SASE3XTeg/hH1Bv2p0ymNoIDo1zAKPv9dOqsCm+H98Y=;
 b=m+Amvye3kzJ5WV+A1Sis96kCwPmoym6m3IKet029uF3KpjToA6Eff7MfHlm0B5viHG
 /vPdoKO0FyQ4ek3VWCvWf8GXG1lH356MGqGRM9crmg+Gg7P+zgLli3oj6mC26vs6uStf
 HmOx4dpL0o6kzJcOR8LndhpHuD2ERYnvZB7OAzYhdHAO2TNw1nGKSqW1o98kFvou2e2D
 OJj8v/VDoKybxAgIj4YaIZ6/iY4SzRWoI7x1WlLSKDS+znPOHlcA2UXvWIZHX5l0+41n
 0tohy2lzvubZUfhGJJgW5wwQxaS6MkaWx3TcOKbF+BidsBkDNPnitPFcsgylkbw/ocfY
 vu4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH34aKJA3HxOiIMlK/SLlQLNBRxi2LDVBdungfwt36JpYxFm/o3TjnwqXyJ+KJeEb2VHzY4v3kugo=@nongnu.org,
 AJvYcCVSSYjktOWe4Bk4Lnwl9aDgPuwKJnPetX4VT6DzwmerhgnTJRIEDVbkhyGAh9u5Mme/3v+O1cxaBPm0hw==@nongnu.org,
 AJvYcCWDdRLIrmmDMOj9hsOC+t9bEnxD8wLVuXMo/1oynDwdgLtufDZfZ7mwkQn/pApI6uP7iB0KLtzVqXfmSw==@nongnu.org,
 AJvYcCX9B5BxMZcOcuOgwQL8r9L0wJg7CnGZ6r8bgh7D/G6v6q6MMIKbITLDVE9BgqN3BHSXO0h+XgkVHw==@nongnu.org
X-Gm-Message-State: AOJu0YzzuG2piX4Pxoj/OUzN1DV95wdHhw+/Zqdw/f81+KMcMFudAbzP
 rVe1/hxw9Az0j8wGNmHrtxwuc9e6QZEby1lGwX7fjbu7GYP5hW/Tw07lvnAD
X-Gm-Gg: ASbGncv43BaLy6gYSFUuIi719NfupainD989tOk/9ameeXVtdvMP3jqg3Hvl7ThSu8O
 SqySO/1+WPnLz9p52cypfzrtKS7RueiS7MB3YtcpUtQfpQdfsQP7tG6g/PIym5WwHBtvjoJ2C2o
 /+L/bFGwAqNGw/VuiZPMzj5Qf4u9Ob5tTGtl0BmxQW56b3oLk515hWV9qyi2SnAVupoqP1hub8Q
 gMMdoI9F9GJrzwpNj+D6oJYRf4f7L5W9jIxBzOpA1DtxiLz4EOteH60AosE6/E8x6bNz+eMZWKf
 kpgjjHcRAXekZNt8zb9G0jyS2yeFKBifTKirMSQvCSpp56HF5F9/lKb95g==
X-Google-Smtp-Source: AGHT+IGZVnR6iExg3SaeGbXovRMHfu4V9AyLUD1Bp7HiSc7H8Bjv2sq7p9nu4P9mJ0RjhTJsAOhTYQ==
X-Received: by 2002:a05:6a21:150b:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-203b3e4ffe2mr1258840637.5.1744791380301; 
 Wed, 16 Apr 2025 01:16:20 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:19 -0700 (PDT)
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
Subject: [PATCH 10/19] include/glib-compat.h: Poison g_list_sort and
 g_slist_sort
Date: Wed, 16 Apr 2025 17:14:15 +0900
Message-Id: <f6e0e42ae3491564478929e412991c2a16ee3539.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x436.google.com
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

On emscripten, function pointer casts can cause function call
failure. g_list_sort and g_slist_sort performs this internally so can't be
used on Emscripten. Instead, g_list_sort_with_data and
g_slist_sort_with_data should be used.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 include/glib-compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 86be439ba0..e441b396ef 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -36,6 +36,12 @@
 #include <pwd.h>
 #endif
 
+/* These functions perform function pointer casts which can cause function call
+ * failure on Emscripten. Use g_slist_sort_with_data and g_list_sort_with_data
+ * insted of these functions.
+ */
+#pragma GCC poison g_slist_sort g_list_sort
+
 /*
  * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, allowing
  * use of functions from newer GLib via this compat header needs a little
-- 
2.25.1


