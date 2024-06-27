Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B374C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpLw-0003AJ-QG; Thu, 27 Jun 2024 09:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLf-000266-81
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:39 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLd-0006aO-Jr
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:38 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7187e6b3584so3721709a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495576; x=1720100376;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=66SWenAU4qt0HqdzzgzjopUq88LncGGPdZoRZN6MJBw=;
 b=U5OFeVL/gbCE8SrtacwXOVTRXmxTxtukIofmUMDrS+SNrQZZG5xO08Glno18CGwJTo
 AEnH+XgTCDKqHhodC3sfShgdniXD6b+rxJRoBBhAZnH2oxxcXhn4f3TS2clq4l4DMvPb
 ZH87Te4FMbvjdY1ADHstvzqTT8+wgVgBeHX94jiYTitFQOoLQN5f2m+fl/dsbSqt5hZP
 RjnH6w0Gnjf3EfIxkSVU1sq56WuzQs8PEhF2AsOpHjsEbjO6qggA2nPUb4ZdriNw0rx0
 AgzCqneLz9msmAK86WPIn1xUHkDFYipSMdxr/e2RCZNgzHAzqM36f8f2DyxPF0XL/o68
 q4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495576; x=1720100376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66SWenAU4qt0HqdzzgzjopUq88LncGGPdZoRZN6MJBw=;
 b=jSzU+it3/GzPbpWCKZoWY9oi1D2uRVijSTwaAsx+AgsVGI18qu8mjLH4z/iXfcun1o
 Vok6klRjmaSxFbshAaflvPkXZIoUZTrzfH2qUXFi6WatGb0jWVf6KNg+JDcseCu06Jjc
 vgEP9NuZFsUNSISICIXKXEUjCkDDRQdKYHhRdD5NEVUMkVDJmbpWlIyF20k0DA0J76Lq
 2CYNbv06nlvJhGMAnQeU5Dw4UEAL2CJwCDW5QmYTSS8I73dFItkqkAF7Lghexv3MXU0D
 dzouMV8kp8EQYd5+SDMWbdaBqdC0zsT5/wlqTOydQupHflm+HOdjmIPMhMyBRjBJ0jsa
 d8EA==
X-Gm-Message-State: AOJu0YymWoBLL5dn0ntvr54P3x9FkzOB0MMnMOjGJ2BQKuCkN/g1OiCR
 vlnUyMpyN1N9CTiDW1sG/jXOqigsQ3ACCWJerFIc9TzIGxMMJBw8XTNYLEMiIcU=
X-Google-Smtp-Source: AGHT+IGK3IeNA1PsDdEds/reaHYwgDV95tDqPpf6AdGiFC4ZsLRZj1HBdWm8l3UiekhYxiotaysaqg==
X-Received: by 2002:a05:6a20:1e58:b0:1be:c753:dc65 with SMTP id
 adf61e73a8af0-1bec753dd0cmr3363255637.18.1719495576216; 
 Thu, 27 Jun 2024 06:39:36 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8df617sm13243105ad.31.2024.06.27.06.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:39:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:57 +0900
Subject: [PATCH v2 14/15] tests/qtest: Free paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-14-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/qos-test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 5da4091ec32b..114f6bef273a 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -33,7 +33,6 @@
 static char *old_path;
 
 
-
 /**
  * qos_set_machines_devices_available(): sets availability of qgraph
  * machines and devices.
@@ -191,6 +190,12 @@ static void subprocess_run_one_test(const void *arg)
     g_test_trap_assert_passed();
 }
 
+static void destroy_pathv(void *arg)
+{
+    g_free(((char **)arg)[0]);
+    g_free(arg);
+}
+
 /*
  * in this function, 2 path will be built:
  * path_str, a one-string path (ex "pc/i440FX-pcihost/...")
@@ -295,10 +300,13 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     if (path->u.test.subprocess) {
         gchar *subprocess_path = g_strdup_printf("/%s/%s/subprocess",
                                                  qtest_get_arch(), path_str);
-        qtest_add_data_func(path_str, subprocess_path, subprocess_run_one_test);
-        g_test_add_data_func(subprocess_path, path_vec, run_one_test);
+        qtest_add_data_func_full(path_str, subprocess_path,
+                                 subprocess_run_one_test, g_free);
+        g_test_add_data_func_full(subprocess_path, path_vec,
+                                  run_one_test, destroy_pathv);
     } else {
-        qtest_add_data_func(path_str, path_vec, run_one_test);
+        qtest_add_data_func_full(path_str, path_vec,
+                                 run_one_test, destroy_pathv);
     }
 
     g_free(path_str);

-- 
2.45.2


