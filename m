Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820EAC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IBT-0003iw-Dp; Mon, 28 Apr 2025 02:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAp-00032l-IX; Mon, 28 Apr 2025 02:41:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAn-00078R-RR; Mon, 28 Apr 2025 02:41:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2295d78b433so45730425ad.2; 
 Sun, 27 Apr 2025 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822459; x=1746427259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6Y5fduZ/n7B0lws/L+kMEP40MZKy5lZ1C1ofdKXGng=;
 b=AS+YU+SJgljV7stfKJsqmGpyggq2baF0eZ6VrYc4sQa7O7Qm8koV6p7Jmtbfy5xwDD
 27Q0wFsjiCNkofWQKBa4vXkmwU9QqipvgISMKBLVgim/Y1FpRHz1u6CmT3G0h8W3xX3+
 q/HWSYDY1NuiCtfThAuewRpB/ZQMa2V2oIumOZcFbHRMOTJiMSej9HBkqju04MgtVmuT
 emRpcJGw2Mgpk16wa4ywkJ18nosCIA+7ZeIeSdNU6EKjUY0RYAP8Vd8W8MlSH2iOSm3c
 8id5+GJXiXtzj5LNgl0IaIUAfr8X7JHLCF4bXAxJKtum8sD1xx/+x7GWeVVeRh8O8uhc
 +LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822459; x=1746427259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6Y5fduZ/n7B0lws/L+kMEP40MZKy5lZ1C1ofdKXGng=;
 b=abcAYOwVSLcfFu1I68uKb5zc5GfQjxWY8BNik3e8xsRURzh/iSp4GKJO56LZD5mLPD
 5pGM37cZylQlVtNCWn/xlPXWkFvUWWTWHdN2rXYPVBZLhDp0aIXbz9G18lmiq61FcGWn
 lt4DmDrym7E+4RtEpDp0MbIqQ4OcVPcWF/nDx8f9tqaJnO8Xi95zonAeexWouYi/83Nw
 318qORMF9aVmHcSoIXCZSedFWfzG33+CKEkVZpUSsVytQLwz2rm1vMR1WWK4jqFdF9Xc
 4szBfQOatdMeF92LyWAMQH1IOHf3vPKR6mu6saW+1ijtIZqv2a7sRWS+wakQXfbHI4pA
 jQGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqcX4tgYXXG0gi1vJmehYZXz7a2E/nxAsZ2bQT5v2NzCLccR67lMSkyA0IClo1BlZkZQbZ/FKM6fg=@nongnu.org,
 AJvYcCVIsr7N0Z57WFnK0ed+jVRtj0jCyBuHLszc5NnMBwYG8gSMy00dv3nbUkv2pqKl0js0Rw3oCbS4EwNZog==@nongnu.org,
 AJvYcCXVgof5v85CeWNkmxT7zGjuqmFAiVGI5eXEsJgreRB3q4UjHMMiSPvn3Opbfvu+U1+RPGVmZtVkWKrcEw==@nongnu.org,
 AJvYcCXoA91wojsSOlY5bL0GdPRox4l/w3ytJtVsEmIseW02PtW/V546Ym+CJRz4DfU7tRKy2i8LpJMFDw==@nongnu.org
X-Gm-Message-State: AOJu0Ywnglplfoa0p16xQVsGaJt/Znk4Kh6n+V84/egGHvuG+awqLHIx
 TLqxUmwJuiBPhgAqyMp73oT2Ykxsvg9z7ABrJcUIBt7Ki3hfRH/UPfoQEtOj
X-Gm-Gg: ASbGncv4eiU7wvjwJYL40RHXKMiqdKgVpfcmwPOk8MLsyzrUaOJTcXqO3BHWc5ozSMB
 I9kizjIyxn5U2jdi6ykf5my685Xs13roYn8/mVv9xc6sAldgZ1VgKyg+6KhgXVUQEWD/UlQ6uVX
 oOqb6gFYVo5JbKANDN+i4mc8KgAJZ8IRT9aKHY0T4uZc53Cj/ilVHr4WKkHjm16omQMBBTPaeNk
 pbEVlSyysmGW01Jft2SqWYWZdI7RYTtSd0OdJWNXVRhNQC4hrUPl5R8+Ca3WLtJrAj36XXxvFN0
 jk0j1SoGJxEUp5DgCW1h9V8duRDIXsDJ1RYzB3E9h7c9jXZo
X-Google-Smtp-Source: AGHT+IFg4N8OT8wKmU3nQHn6zk4dFjhpvs/A9pwNKzARPLnM/GCRvPNR7NLeZX5eUAhAVxIGHW/tpw==
X-Received: by 2002:a17:902:d2ce:b0:229:1717:882a with SMTP id
 d9443c01a7336-22dc69efaeemr117641465ad.4.1745822459147; 
 Sun, 27 Apr 2025 23:40:59 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:40:58 -0700 (PDT)
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
Subject: [PATCH v3 10/20] include/glib-compat.h: Poison g_list_sort and
 g_slist_sort
Date: Mon, 28 Apr 2025 15:38:59 +0900
Message-ID: <fa57c8069d6c723f5b947560677f4ca596334330.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62b.google.com
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
 include/glib-compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

V3:
- Fixed the multiline comment to ensure it starts with "/*" on a separate
  line.

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 86be439ba0..2e32b90f05 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -36,6 +36,13 @@
 #include <pwd.h>
 #endif
 
+/*
+ * These functions perform function pointer casts which can cause function call
+ * failure on Emscripten. Use g_slist_sort_with_data and g_list_sort_with_data
+ * instead of these functions.
+ */
+#pragma GCC poison g_slist_sort g_list_sort
+
 /*
  * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, allowing
  * use of functions from newer GLib via this compat header needs a little
-- 
2.43.0


