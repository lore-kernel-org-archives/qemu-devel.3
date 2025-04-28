Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302A0C369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IAF-0002Vp-DO; Mon, 28 Apr 2025 02:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9y-0002OW-KW; Mon, 28 Apr 2025 02:40:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9w-00071w-OT; Mon, 28 Apr 2025 02:40:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227c7e57da2so36445605ad.0; 
 Sun, 27 Apr 2025 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822404; x=1746427204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rhl7SgHNqhrCHuC+4o7PMjllPHDODH7BlNYtz7qPS2E=;
 b=OJ4jyQuf6jxIQ1ya2d+hL2VzEnB18c+ZCG5BN/32XqNbxkquLkuY8NBpVqAw008Ek/
 8gujXs74wUSx5DTLDcNPOsFfcpXj7JC+2NPuaRg3idX4CarINd/isrTmMgqP+BxFbaJd
 cF+zLBRtRmaxUi3ABqUsg1Nve80zkylkBwTlSqyYxO2cxpRrSrOdq3B47HZK4CxnvFfC
 RPx++8lOfUm4qcoC99WvJlCQ9TWycaF2j6qk9zA1sB9qH5OGx97i6EtuaeisjknKfrqN
 Mf7YwsGuCRSsK6GYCqgGsdbNP/uiDucjmKdp9SbJ5bsY7xStgg1ZywmLKMKqESj/+bhG
 iGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822404; x=1746427204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rhl7SgHNqhrCHuC+4o7PMjllPHDODH7BlNYtz7qPS2E=;
 b=E5ZoG97Zf4y5fxGo5GLYsFfuRyysG6JNIKZWRPHrZX1mC5oPECkuHiFikzXS2xyR3I
 naysNkh4nMBfhoR0TT8jSVV1i7IhMx0ZgyzxG0XixoT8yOoW++NHXrK190MgRzk+F1XT
 dHAr/ECzr9YtqoXPvdI9JtTWZk1NMBklcIAOQorF995Puc60V0wQTyu4kX4VDIcQtnxQ
 6pq0NYL4OnD6K+c9f+K5J7AlQD/P9w6tdUI5t6md4uZJoeENK9IP3amFfRifoVvWWelS
 cp0v0eCxUML45LyozCWbImlrefaUR1Upn8IuQYvVGfM2anWpot4nEyUvNve3oIH7lt+h
 lqHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJAQgYSYbDfYsQ56K11VI1bjPx/+Qot3Fh6xGMsKGWYnlV43wGOO4CianitdiqN99zY4e6wdLLPRZsFA==@nongnu.org,
 AJvYcCVEnjgCC0nMagjNcT9Q8yn8RCyD1rRoiQxROkAeryO5yPsa8X3D+46gZigXRir9QTJ/VhhM05FBmPM=@nongnu.org,
 AJvYcCVKi7J+5VG3ycxeIpPNWGaOm+kTDeDpv1HtLVgYm6Vjg5Zey6jagYn6SKcHZk9rNyC6u/k8l8rMPg==@nongnu.org,
 AJvYcCXM6IupU0wgnuv5uKDvXIII9YI9ytzXFo7GhYOEzAVrZmJC2HTK09Q/0C0UnJJqXN0uVGhsoprM2FBobQ==@nongnu.org
X-Gm-Message-State: AOJu0YyeQ7VuN95zTDni43idP+lb1C/RYzuxrdL653hFccxRXyO8GA73
 r2FE8Qp+H2qsOs1pApRAnP72Ma3M5ZrgUI0wkbDWZ8pQ9+AR6sGqxbNQjdSq
X-Gm-Gg: ASbGnctc+HPH8MHyvyqHPJfergLOvXKH0/v/gS3+mwh4Ts/L9TJOQ3YnhMF7z4T9TXI
 n7v50vaXznWdrfDyBiwnYJdzpjWfB/GNXi/YpNrKiBN39JipDNsZw1JKXt1e0Xfl6DVGR6I0dCS
 iBYkgRWwKf0euN1H9LCFmm0wNaTINdDTfYUJNbIFc3OgWE89cbO9EZSBqiKl8sNdDP6U0VMWoLG
 UyGl615GQDVrLmIMYPc6bHKVmw42rgQEKNVynfpIeVgYgL3ljpKHtq41iMUXo2yWQsNjyCCNoO0
 YzWlywHLbAJwxP6J1gNVJpJoHMyvzHf8g2aLBg==
X-Google-Smtp-Source: AGHT+IH/pQr1HaXwwQxOTF+dfkdY/KSrS7j//yGwNz7f9oTgv4VQET1V0+fOtfXBRUasDaFSRlC3hw==
X-Received: by 2002:a17:902:d492:b0:224:26f2:97d6 with SMTP id
 d9443c01a7336-22dc6a09a5cmr123343665ad.28.1745822404369; 
 Sun, 27 Apr 2025 23:40:04 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:40:03 -0700 (PDT)
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
Subject: [PATCH v3 03/20] system/vl.c: Fix type conflict of GLib function
 pointers
Date: Mon, 28 Apr 2025 15:38:52 +0900
Message-ID: <1349103c97e4cdccfe58ecf8fef4408f9b9a9900.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V3:
- This commit is included in this series sololy to ensure successful
  builds. It has already been picked up by a pull request, so please ignore
  it.

diff --git a/system/vl.c b/system/vl.c
index c17945c493..4ab2001df7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1524,7 +1524,7 @@ static bool debugcon_parse(const char *devname, Error **errp)
     return true;
 }
 
-static gint machine_class_cmp(gconstpointer a, gconstpointer b)
+static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     const MachineClass *mc1 = a, *mc2 = b;
     int res;
@@ -1574,7 +1574,7 @@ static void machine_help_func(const QDict *qdict)
     }
 
     printf("Supported machines are:\n");
-    machines = g_slist_sort(machines, machine_class_cmp);
+    machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         if (mc->alias) {
-- 
2.43.0


