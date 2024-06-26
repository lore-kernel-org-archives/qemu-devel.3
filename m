Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5FFC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQVT-0007vv-Mv; Wed, 26 Jun 2024 07:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQVS-0007uN-BC
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:08:06 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQVQ-0004yM-Q9
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:08:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fa3bdd91c1so25647785ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400082; x=1720004882;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tYtFORlnbJN2+36DGKZvH4uH8NkkbHJaO5uVtPxgJZE=;
 b=svuKajrICBMbpHRDD6Ep+SaZjTwKHLAO0Bqv7CkS6cKVFmsvvuS+46J99fTAAX3PFF
 8wRfrM2s2b/GIqRFctU/19entEQFvR9m77mZGAHNoa8uQCednOkyH62Gtg6lZwjSOCUZ
 4OejJtcLARPbh5cEdD1de5ewH3fMmGlkULrmfo3fNOo0mCtTm5Gb5SaeviyXMR7tXxDF
 uXj9NaxI4nXJZJF4c/4a6lVloh/JUfY+14oHBEkSl57D2MvzSkwvcgs7co1G1/C23q4s
 7o9b9AbZP3bH78OT4c/ifORyxmgbjZDn4HngXPplKaK0RMGuRDuyZSO4nhsVAm/KEptG
 4Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400082; x=1720004882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYtFORlnbJN2+36DGKZvH4uH8NkkbHJaO5uVtPxgJZE=;
 b=eD8wv8TTsTrLVJDvcZpJn8+dAbhr8qR3MH080fy0cj0siuu1MX4jqD5c+BEWt+qNIi
 jtJW79gY/PhDnlLIdxxfhLl1RTwHVeqnAo1SGagyrMK+uanj736o72Y7sY3J+r1yOtqK
 T5+7QRx8v2mv4pZyEMmoFtd+zYNmNdVl5QDT4z1IkijCniO4ISAdQnzodgDqYGdz6CSy
 xsq8CdnYP4INoWrlVamidR4S6TShRKWDR27iB+Ar+kZh7C+0jhMRXHSn0fTaBK4u75hK
 EzIVDl1IPW6IydY8gw0isyrloFf7+F9i21k3J9mR0mtw2X8im4LSqq2+cpbTTMUHU4BW
 M1pg==
X-Gm-Message-State: AOJu0YzqM7mgpNeYRCaQA2tBWtGqKy6Qb5Y+9w1nBLv9B8QxfZrvwkPE
 oisLSbAbXOEe0avJwibh9SODepzzaaFzgBcLzg+MdOWVHYpkAKFY9aF7DUX2kpU=
X-Google-Smtp-Source: AGHT+IHyZ8wV6Rh9xxRMzOoVr9YOmjr6z9m9zTaM5UgBGYRAIuUzpuVy2sbTaigPVbHMmiuBedLaVA==
X-Received: by 2002:a17:902:c94d:b0:1fa:80b3:d64d with SMTP id
 d9443c01a7336-1fa80b3d9edmr33447555ad.31.1719400082459; 
 Wed, 26 Jun 2024 04:08:02 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f9eb3d5b33sm96978315ad.190.2024.06.26.04.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:08:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:37 +0900
Subject: [PATCH 14/14] tests/qtest: Free GThread
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-14-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

These GThreads are never referenced.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/vhost-user-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f66..929af5c183ce 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -928,7 +928,7 @@ static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("reconnect", arg);
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
@@ -965,7 +965,7 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 
     s->test_fail = true;
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
@@ -980,7 +980,7 @@ static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 

-- 
2.45.2


